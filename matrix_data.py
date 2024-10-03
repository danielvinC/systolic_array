def matrix_data(matrix_name, filename):
    mem = []

    print(f"{matrix_name}:")
    print("Enter the elements of the 4x4 matrix row by row:")

    # Prompt the user to input values for each element in the mem array
    for row in range(4):
        row_values = input().split()
        for col in range(4):
            value = int(row_values[col])
            mem.append(value)

    # Write the values to the specified file in hexadecimal format
    with open(filename, "w") as file:
        for value in mem:
            file.write(f"{value:08X}\n")

if __name__ == "__main__":
    matrix_data("Matrix A", "dmatrixA.txt")
    matrix_data("Matrix B", "dmatrixB.txt")
