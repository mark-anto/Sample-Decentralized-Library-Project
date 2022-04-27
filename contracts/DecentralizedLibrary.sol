// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Owner.sol";

contract DecentralizedLibrary is Owner {
    struct Book {
        string name;
        string description;
        bool available;
        uint256 price;
        address owner;
    }

    uint256 public bookId;

    mapping(uint256 => Book) public bookIdToBook;

    struct BooksTracking {
        uint256 bookId;
        uint256 startTime;
        uint256 endTime;
        address borrower;
    }

    uint256 public trackingId;

    mapping(uint256 => BooksTracking) public trackingIdToBooksTracking;
    event NewBookAdded(uint256 indexed bookId);
    event NewTrackingCreated(
        uint256 indexed bookId,
        uint256 indexed trackingId
    );
    event DeleteBook(uint256 indexed bookId);

    function addBook(
        string memory name,
        string memory description,
        uint256 price
    ) public returns (bool) {
        Book memory book = Book(name, description, true, price, _msgSender());
        bookIdToBook[bookId] = book;
        emit NewBookAdded(bookId++);
        return true;
    }

    function _sendTransaction(address receiver, uint256 value) internal {
        payable(address(uint160(receiver))).transfer(value);
    }

    function _numberOfDays(uint256 startTime, uint256 endTime)
        internal
        pure
        returns (uint256)
    {
        require(
            endTime - startTime > 0,
            "The start time is larger than the end time for borrowing. Please enter proper dates."
        );
        if ((endTime - startTime) % uint256(86400) == 0) {
            return (endTime - startTime) / uint256(86400);
        } else {
            return ((endTime - startTime) / uint256(86400)) + uint256(1);
        }
    }

    function borrowBook(
        uint256 _bookId,
        uint256 startTime,
        uint256 endTime
    ) public payable returns (bool) {
        Book storage book = bookIdToBook[_bookId];

        require(
            book.available == true,
            "This book is currently unavailable for borrowing."
        );

        require(
            _msgValue() == book.price * _numberOfDays(startTime, endTime),
            "The wrong amount of funds were sent, please retry with correcct amount."
        );

        _sendTransaction(book.owner, _msgValue());
        emit NewTrackingCreated(bookId, trackingId++);
        return true;
    }

    function _createTracking(
        uint256 _bookId,
        uint256 startTime,
        uint256 endTime
    ) internal {
        trackingIdToBooksTracking[trackingId] = BooksTracking(
            _bookId,
            startTime,
            endTime,
            _msgSender()
        );

        Book storage book = bookIdToBook[bookId];
        book.available = false;
    }

    function deleteBook(uint256 _bookId) public returns (bool) {
        require(
            _msgSender() == bookIdToBook[_bookId].owner || isOwner(),
            "You do not have permission to delete this book."
        );

        delete bookIdToBook[_bookId];

        emit DeleteBook(_bookId);

        return true;
    }
}
