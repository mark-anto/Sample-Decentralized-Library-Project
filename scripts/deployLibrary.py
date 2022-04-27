from brownie import DecentralizedLibrary
from scripts.helpful_scripts import get_account
from web3 import Web3

book_value = Web3.fromWei(1, "ether")


def deploy_library():
    account = get_account()
    library = DecentralizedLibrary.deploy({"from": account})
    print("Library Contract deployed!!")
    return library


def add_book(name, description, price):
    account = get_account()
    library = DecentralizedLibrary[-1]
    adding_first_book_tx = library.addBook(
        name,
        description,
        price,
        {"from": account},
    )
    adding_first_book_tx.wait(1)
    return adding_first_book_tx


def main():
    deploy_library()
    add_book(
        "Captain Sparrow",
        "This is the first book we are adding about a sparrow vs a amber herd",
        book_value,
    )
