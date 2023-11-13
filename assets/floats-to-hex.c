#include <stdio.h>
#include <stdlib.h>

// Function to convert a float to a 4-byte blob
void float_to_4byte_blob(float number) {
    char *blob = (char*)&number;

    // Print the 4-byte blob as a hex string
    for (size_t i = 0; i < sizeof(float); ++i) {
      printf("\\x%02x", (unsigned char)blob[i]);
    }
    // write directly the binary blob to stdout
    // fwrite(blob, sizeof(float), 1, stdout);
}

int main(int argc, char *argv[]) {
    if (argc > 1) {
        // If command line arguments are provided
        for (int i = 1; i < argc; ++i) {
            float number = strtof(argv[i], NULL);
            float_to_4byte_blob(number);
        }
    } else {
        // If no command line arguments are provided, read from stdin
        float number;
        while (scanf("%f", &number) == 1) {
            float_to_4byte_blob(number);
        }
    }

    return 0;
}
