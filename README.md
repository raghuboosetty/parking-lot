## Use the following commands to run and test the program
### RVM is expected to be present in the system
```
## install Ruby 2.5.1 using rvm
$ rvm install 2.5.1
$ rvm use 2.5.1

## unzip parking-lot-1.3.2-solved.zip 
$ cd parking-lot-1.3.2-solved/parking_lot
$ bin/setup 

## run full test suite
$ bin/run_functional_tests

## run the application with default file input
## following is default input you can given any input 'txt' file or modify the existing ones
$ bin/parking_lot functional_spec/fixtures/file_input.txt

## run the application with commandline input
## write 'exit' and hit enter to quit the program
$ bin/parking_lot

## following are the inputs next after entering above(bin/parking_lot) command. 
## commands are taken from the given PDF(ParkingLot-1.3.2.pdf)
$ create_parking_lot 6
$ park KA-01-HH-1234 White
$ park KA-01-HH-9999 White
$ park KA-01-BB-0001 Black
$ park KA-01-HH-7777 Red
$ park KA-01-HH-2701 Blue
$ park KA-01-HH-3141 Black
$ leave 4
$ status
$ park KA-01-P-333 White
$ park DL-12-AA-9999 White
$ registration_numbers_for_cars_with_colour White
$ slot_numbers_for_cars_with_colour White
$ slot_number_for_registration_number KA-01-HH-3141
$ slot_number_for_registration_number MH-04-AY-1111
$ exit

## NOTE: Most of these details are taken from "parking_lot/functional_spec/README.md" file
```

## Few Developer Notes
1. Lot, Slot and Car are 3 classes used to solve the problem. The classes are added to *parking_lot/lib*
2. Git's *.git* directory is present inside the *parking_lot* directory. So you can check the commits using following command from 'parking_lot' directory: 
```$ git log ```
3. No new gems were added to the default Gemfile and even no new add on setup is added to 'bin/setup'
4. Unit tests are written under *parking_lot/functional_spec/spec* directory. These run as a part of test suite with the command given in above section
5. *bin/parking_lot* executable file takes the input and runs the program
6. Rest of the things are self explanatory, but for any issues you can reach out via email 'raghuboosetty@gmail.com' or on call '9177167375'