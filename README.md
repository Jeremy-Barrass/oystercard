This is an outline of the current test plan for this project.
To begin, we will feature test for our Oystercard class, prepare a unit test and check for failure.
Following this we will write our production code to pass the unit test, then test the feature in IRB.

We will repeat this process for each new method or feature we wish to add.

Features tested and added so far are a starting balance and an add money feature.  This will now be renamed to top-up.

We have added methods to control the status of the journey. 

We will create a new class journey and move the station saving and journey history from our Oystercard to our Journey class.
We will feature test by running the `touch_in` and `touch_out` methods in IRB and check they create a new journey object.
We will unit test by mocking a card and stubbing the appropriate methods in the `journey_spec` file. 

We have completed all challenges.  Journey class was tested and created.  Station Zoning tested and added.
