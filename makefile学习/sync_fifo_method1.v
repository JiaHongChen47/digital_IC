/* The full condition means every slot in the FIFO is occupied, 
but then w_ptr and r_ptr will again have the same value. 
Thus, it is not possible to determine whether it is a full or empty condition. 
Thus, the last slot of FIFO is intentionally kept empty, 
and the full condition can be written as (w_ptr+1’b1) == r_ptr)
*/
module sycn_fifo #(parameter DEPTH=8, DATA_WIDTH=8)(
    input clk, rst_n,
    input w_en, r_en,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    output full, empty
);

    reg [$clog2(DEPTH)-1:0] w_ptr, r_ptr;
    reg [DATA_WIDTH-1:0] fifo[DEPTH];

    // Set Default values on reset.
    always@(posedge clk) begin 
        if(!rst_n) begin 
            w_ptr <= 0; r_ptr <= 0;
            data_out <= 0;
        end
    end

    // To write data to FIFO
    always@(posedge clk) begin 
        if(w_en & !full) begin 
            fifo[w_ptr] <= data_in;
            w_ptr <= w_ptr + 1;
        end
    end

    // To read data from FIFO
    always@(posedge clk) begin 
        if(r_en & !empty) begin 
            data_out <= fifo[r_ptr];
            r_ptr <= r_ptr + 1;
        end
    end

    assign full = ((w_ptr + 1'b1) == r_ptr);
    assign empty = (w_ptr == r_ptr);

endmodule