`default_nettype none
`timescale 1ns/1ps

module led_array_driver(ena, x, cells, rows, cols);
// Module I/O and parameters
parameter N=5; // Size of Conway Cell Grid.
parameter ROWS=N;
parameter COLS=N;

// I/O declarations
input wire ena;
input wire [$clog2(N):0] x;
input wire [N*N-1:0] cells;
output logic [N-1:0] rows;
output logic [N-1:0] cols;

wire [N-1:0] x_decoded;
decoder_3_to_8 decoder_3_to_8_inst(.ena(ena), .in(x), .out(x_decoded));


// You can check parameters with the $error macro within initial blocks.
initial begin
  if ((N <= 0) || (N > 8)) begin
    $error("N must be within 0 and 8.");
  end
  if (ROWS != COLS) begin
    $error("Non square led arrays are not supported. (%dx%d)", ROWS, COLS);
  end
  if (ROWS < N) begin
    $error("ROWS/COLS must be >= than the size of the Conway Grid.");
  end
end


// logic row0;
// logic row1;
// logic row2;
// logic row3;
// logic row4;

/*
always_comb begin
//always_ff @(posedge) begin
rows = {row4, row3, row2, row1, row0};
end
*/


always_comb begin

  
  // row0 = ~(|(x_decoded[N-1:0] & cells[1*N-1:0*N]));
  // row1 = ~(|(x_decoded[N-1:0] & cells[2*N-1:1*N]));
  // row2 = ~(|(x_decoded[N-1:0] & cells[3*N-1:2*N]));
  // row3 = ~(|(x_decoded[N-1:0] & cells[4*N-1:3*N]));
  // row4 = ~(|(x_decoded[N-1:0] & cells[5*N-1:4*N]));
  

  genvar i;
  generate
    for (i = 0; i < N; i = i + 1) begin
      rows[i] = ~(|(x_decoded[N-1:0] & cells[i*N-1:i*N]));
    end
  endgenerate 

  //$display ("cells value = %8b", cells);
  //$display ("x value = %3b", x);
  //$display ("x_decoded value = %8b", x_decoded);
  //$display ("%8b", row0);
  //$display ("%8b", row1);
  //$display ("%8b", row2);
  //$display ("%8b", row3);
  //$display ("%8b", row4);
  //$display ("rows value = %8b", rows);
  //$display ("");
end

endmodule
