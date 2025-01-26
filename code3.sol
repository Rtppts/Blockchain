// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

contract VaccineBooking {
    struct Booking {
        string vaccineName;
        address user;
        uint256 timestamp;
    }

    Booking[] public bookings;

    event BookingSuccess(address indexed user, string vaccineName, uint256 timestamp);

    // Function to book a vaccine
    function bookVaccine(string memory vaccineName) public payable {
        require(msg.value > 0, "Payment required");

        Booking memory newBooking = Booking({
            vaccineName: vaccineName,
            user: msg.sender,
            timestamp: block.timestamp
        });

        bookings.push(newBooking);
        emit BookingSuccess(msg.sender, vaccineName, block.timestamp);
    }

    // Function to get total bookings
    function getTotalBookings() public view returns (uint256) {
        return bookings.length;
    }

    // Function to get booking details
    function getBooking(uint256 index) public view returns (string memory, address, uint256) {
        require(index < bookings.length, "Invalid index");
        Booking memory booking = bookings[index];
        return (booking.vaccineName, booking.user, booking.timestamp);
    }
}
