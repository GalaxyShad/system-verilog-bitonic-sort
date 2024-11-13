`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.11.2024 16:16:36
// Module Name: bitonic
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// build-udm-params
// CSR_INPUT_LIST_ADDR  = 32'h00000010;
// CSR_OUTPUT_LIST_ADDR = 32'h00000210;

module bitonic(
        input [7:0][31:0] original_list_i
        , output [7:0][31:0] sorted_list_o
    );

logic [7:0][31:0] buffer_list;

assign sorted_list_o = buffer_list;

function automatic void compare_and_swap(
    inout logic [31:0] a,
    inout logic [31:0] b
);
    logic [31:0] temp;
    if (a > b) begin
        temp = a;
        a = b;
        b = temp;
    end
endfunction

always_comb begin
    // copy to buffer
    buffer_list = original_list_i;
    
    // # =========================
    // # stage 1
    // # =========================
    
    compare_and_swap(buffer_list[0], buffer_list[1]); // # -> 
    compare_and_swap(buffer_list[3], buffer_list[2]); // # <-
    compare_and_swap(buffer_list[4], buffer_list[5]); // # ->
    compare_and_swap(buffer_list[7], buffer_list[6]); // # <- 
        
    // # =========================
    // # stage 2
    // # =========================
    compare_and_swap(buffer_list[0], buffer_list[2]); // # ->
    compare_and_swap(buffer_list[1], buffer_list[3]); // # ->
    compare_and_swap(buffer_list[6], buffer_list[4]); // # <-
    compare_and_swap(buffer_list[7], buffer_list[5]); // # <-
    
    compare_and_swap(buffer_list[0], buffer_list[1]); // # ->
    compare_and_swap(buffer_list[2], buffer_list[3]); // # ->
    compare_and_swap(buffer_list[5], buffer_list[4]); // # <-
    compare_and_swap(buffer_list[7], buffer_list[6]); // # <-
        
    // # =========================
    // # stage 3
    // # =========================
    compare_and_swap(buffer_list[0], buffer_list[4]); // # ->
    compare_and_swap(buffer_list[1], buffer_list[5]); // # ->
    compare_and_swap(buffer_list[2], buffer_list[6]); // # ->
    compare_and_swap(buffer_list[3], buffer_list[7]); // # ->
    
    compare_and_swap(buffer_list[0], buffer_list[2]); // # ->
    compare_and_swap(buffer_list[1], buffer_list[3]); // # ->
    compare_and_swap(buffer_list[4], buffer_list[6]); // # ->
    compare_and_swap(buffer_list[5], buffer_list[7]); // # ->
    
    compare_and_swap(buffer_list[0], buffer_list[1]); // # ->
    compare_and_swap(buffer_list[2], buffer_list[3]); // # ->
    compare_and_swap(buffer_list[4], buffer_list[5]); // # ->
    compare_and_swap(buffer_list[6], buffer_list[7]); // # ->
end

endmodule
