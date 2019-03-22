#!/usr/bin/env python

import os
import requests
import json

API_URL = os.getenv("API_URL", "http://localhost:4000")


def create_auction(auction):
    requests.post(f"{API_URL}/api/auctions", json=auction)
    print(f"Created {auction['title']}")


def auctions():
    with open("auctions.json") as f:
        return json.load(f)


def main():
    for auction in auctions():
        create_auction(auction)


if __name__ == '__main__':
    main()
