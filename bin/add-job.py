import requests
import json
import argparse
from random_unicode_emoji import random_emoji
from dotenv import load_dotenv

# Load env vars
load_dotenv()

# Keys, URLs, Endpoints
NOTION_API_KEY = os.getenv('NOTION_API_KEY')
NOTION_DB_ID = os.getenv('NOTION_DB_ID')
POST_URL = f'https://api.notion.com/v1/databases/{NOTION_DB_ID}/query'
GET_URL = f'https://api.notion.com/v1/databases/{NOTION_DB_ID}'
ADD_PAGE_ENDPOINT = f'https://api.notion.com/v1/pages'

# Request headers
headers = {
   'Authorization': f'Bearer {NOTION_API_KEY}',
   'Notion-Version': '2022-06-28',
   'Content-Type': 'application/json'
}

def set_index_payload(): 
    return {"sorts": [
            {
            "property": "Index",
            "direction":"descending"
            }
        ]
    }

def get_index():
    payload = json.dumps(set_index_payload())
    response = requests.post(POST_URL, headers=headers, data=payload)
    
    if response.ok:
        data = response.json()
        for page in data['results']:
            index = page['properties']['Index']['number']
            return index # get current index and return
    else:
        print('Failed to fetch index', response.status_code, response.text)

def set_add_job_payload(company, position, index, url, notes):
    p = {
        "parent": {
            "database_id": f'{NOTION_DB_ID}'
            },
            "properties": {
                "Company": {
                "rich_text": [
                    {
                    "text": {
                        "content": company
                    }
                    }
                ]
                },
                "Position": {
                "title": [
                    {
                    "text": {
                        "content": position
                    }
                    }
                ]
                },
                "Index": {
                "number": index # dynamically insert this?
                },
                "Status": {
                "status": {
                    "name": "Applied 🫡"
                }
                },
                "Link": {
                "url": url
                },
                "Notes": {
                "rich_text": [
                    {
                    "text": {
                        "content": notes
                    }
                    }
                ]
                },
            },
             "icon": {
                    "type": "emoji",
                    "emoji": random_emoji()[0][0]
                }
        }
    return p

'''
TODO
- [x] Add terminal functionality (accept kwargs)
- [x] Add dynamic indexing -> call other function to return current index (async)
- [x] Random emoji selector for the page icon ? 
'''
def add_job(company='Dimitri INC', position='FILL POSITON HERE', url='https://example.com', notes=''):

    # Retrieve index dynamically
    index =  int(get_index())

    print('Adding job...')
    payload = json.dumps(set_add_job_payload(company=company, position=position, index=index+1, url=url, notes=notes))
    response = requests.post(ADD_PAGE_ENDPOINT, headers=headers, data=payload)

    if response.ok:
        print('Successfully added job!')
    else:
        print('Failed to add page', response.status_code, response.text)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Add Job Application')
    parser.add_argument('--c', type=str, default='Dimitri INC', help='Add company name.')
    parser.add_argument('--p', type=str, default='FILL POSITION HERE', help='Job Title.')
    parser.add_argument('--u', type=str, default='https://example.com', help='Job posting link.')
    parser.add_argument('--n', type=str, default='', help='notes?')
    
    # Parse incoming arguments
    args = parser.parse_args()

    # Call function to add job with arguments
    add_job(args.c, args.p, args.u, args.n)
