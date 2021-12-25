#include <iostream>
#include <opencv2/opencv.hpp>

int main() {
    std::cout << 123 << std::endl;
    cv::VideoCapture cap = cv::VideoCapture(0);
    if (!cap.isOpened()) {
        std::cerr << "ERROR! Unable to open camera\n";
        return -1;
    };
    return 0;
}