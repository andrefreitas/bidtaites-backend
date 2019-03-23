#!/usr/bin/env python

import os
import requests
import json
import time
import random

API_URL = os.getenv("API_URL", "http://localhost:4000")


def random_expiration_timestamp(delta_hours):
    return int(time.time() + random.random() * delta_hours * (60 ** 2))


def create_auction(auction):
    auction['end_at'] = random_expiration_timestamp(delta_hours=0.5)
    response = requests.post(f"{API_URL}/api/auctions", json=auction)
    print(f"Created {auction['title']}")
    print(response)


def auctions():
    with open("auctions.json") as f:
        return json.load(f)


def main():
    for auction in auctions():
        create_auction(auction)


if __name__ == '__main__':
    main()
