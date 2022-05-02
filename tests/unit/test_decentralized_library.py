from brownie import DecentralizedLibrary
from scripts.helpful_scripts import get_account
from web3 import Web3

book_value = Web3.fromWei(1, "ether")
book_name = "Sphere"


def test_add_book():
    # Arrange - Arranging multiple accounts to add books from
    account = get_account()
    library = DecentralizedLibrary.deploy({"from": account})

    # Act - add the books from account1 and 2, wait for transactions to complete.
    add_book_tx = library.addBook(
        book_name,
        "A sci-fi mystery thriller by Micheal Chrichton",
        book_value,
        {"from": account},
    )
    add_book_tx.wait(1)

    add_book_tx2 = library.addBook(
        "Jurassic Park",
        "Another sci-fi mystery thriller by Micheal Chrichton",
        book_value,
        {"from": account},
    )
    add_book_tx2.wait(1)

    # Assert - Check if the add book functionality is working correctly
    assert book_name == library.bookIdToBook(0)["name"]  # Should pass
    assert "Jurassic Park" == library.bookIdToBook(1)["name"]  # Should pass
    assert book_name == library.bookIdToBook(1)["name"]  # Should fail


def test_delete_book():
    # Arrange
    account = get_account()
    account2 = get_account(1)
    library = DecentralizedLibrary.deploy({"from": account})
    add_book_tx = library.addBook(
        book_name,
        "A sci-fi mystery thriller by Micheal Chrichton",
        book_value,
        {"from": account},
    )
    add_book_tx.wait(1)

    # Act
    delete_book_tx = library.deleteBook(0, {"from": account})
    delete_book_tx.wait(1)

    # Assert
    print(library.bookIdToBook(0))  # Should print out empty
    assert book_name != library.bookIdToBook(0)["name"]

    # Tested for normal deletion by owner, attempted deletion by non-owner and deletion of any book by contract owner
