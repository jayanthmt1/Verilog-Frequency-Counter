// sequence_counter_1001_built_in.v
module sequence_counter_1001_built_in (
input clk, // Clock signal
input rst, // Asynchronous reset signal
output reg [2:0] count, // 3-bit counter output
output reg done // Done signal when all 16 bits are processed
);

reg [15:0] input_sequence; // 16-bit built-in input sequence
reg [4:0] bit_index; // To index 16 bits (needs 5 bits to count 0-16)
reg [3:0] shift_reg; // 4-bit shift register

always @(posedge clk or posedge rst) begin
if (rst) begin
input_sequence <= 16'b1001100110010010; // Hardcoded sequence
bit_index <= 5'd0;
shift_reg <= 4'b0000;
count <= 3'b000;
done <= 1'b0;
end
else begin
if (bit_index < 16) begin
// Shift input_sequence into shift_reg
shift_reg[3] <= shift_reg[2];
shift_reg[2] <= shift_reg[1];
shift_reg[1] <= shift_reg[0];
shift_reg[0] <= input_sequence[15];

input_sequence <= {input_sequence[14:0], 1'b0}; // Shift input sequence left
bit_index <= bit_index + 1'b1;

// Directly check shift_reg for "1001"
if (shift_reg == 4'b1001 && count != 3'b111) begin
count <= count + 1'b1;
end
end
else begin
done <= 1'b1; // All 16 bits processed
end
end
end

endmodule