# How to use
Docker Engine needs to be installed to execute the container.

# Download latest image
Once Docker is installed, execute the following command to download the latest image available
```
docker pull jlmarcos1/codingchallenge:latest
```

# Files needed
The following files need to be present:
- images.csv
- All the images contained in the previous file.
Failure to provide any of them, will result in an execution fail.

## Execution on Linux / Mac
To execute the program, open Console and locate yourself in the folder where the images and CSV populated with data is located.
```
cd /folder/
```
Once in the folder, execute the following command
```
docker run --rm -v $(pwd):/home/imagecompare jlmarcos1/codingchallenge:latest
```
- If everything is correct, a file "output.csv" will be created at the same folder.
- Should an error occurs, you will get details on the same screen.


## Execution on Windows
To execute the program, open Windows terminal and locate yourself in the folder where the images and CSV with data is located.
Ensure that images.csv is present in the folder, along with the images that will be checked.
```
cd /folder/
```
Once in the folder, execute the following command
```
docker run --rm -v %cd%:/home/imagecompare jlmarcos1/codingchallenge:latest
```
- If everything is correct, a file "output.csv" will be created at the same folder.
- Should an error occurs, you will get details on the same screen.

## Upgrading
To ensure you are using the last version available, execute the following command:
```
docker pull jlmarcos1/codingchallenge:latest
```
# How did I approach this.
- The first challenge was defining the way CSV files would be read and generated with some extra columns. That was sorted out by the use of a WHILE loop.
- The second challenge was to define the way the images could be compared. ImageMagick offers a range of comparison methods, and I had to look for a visual comparison, despite the size and format of the images. After a few tests, I decided to move on with an RMSE comparison after the images are resized to the same size. Comparison of the same image on different formats is challenging, as they can be visually the same, but some pixels may differ, but as far as I could test, on that scenario, ImageMagick returns a 0.00 value, and some more decimals that we can deprecate on the CSV generated.
- The third challenge was to define the time of execution. I simply stored in a variable the START time before the comparison is performed, and the FINISH time after getting the results, then it is a matter of finding the difference between those values. I had to use nanoseconds on the calculation, and as BASH do not deal with decimals, I had to make use of the "bc" command.