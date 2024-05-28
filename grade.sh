CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

# check if file is right 
if [ -f "student-submission/ListExamples.java" ]; then
    echo 'This is the correct file' 
else
    echo 'This is not the right type of file! Please submit again'
    exit 1
fi

# copy the files over to grading-area
cp TestListExamples.java student-submission/ListExamples.java grading-area
cp -r lib grading-area

# switch over and compile 
cd grading-area
javac -cp $CPATH *.java 
echo "The exit code for the compile step is $?."

# check for failures 
if [ $? -eq 0 ]; then 
    echo 'All tests passed'
else 
    echo 'Some tests failed!'
    echo 'Check above to find out why'
fi
java -cp $CPATH org.junit.runner.JUnitCore grading-area/TestListExamples | grep "Tests run: " > junit-output.txt

FAILS=$(cat junit-output.txt | cut -d':' -f 3 | cut -d' ' -f 2)
TOTAL=$(cat junit-output.txt | cut -d':' -f 2 | cut -d',' -f 1| cut -d' ' -f 2)

echo "Fails: $FAILS"
echo "Total: $TOTAL"
echo "Numbers failed: $FAILS/$TOTAL" 
