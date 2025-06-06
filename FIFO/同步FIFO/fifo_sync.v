module fifo_sync
    // parameter section
    #( parameter FIFO_DEPTH = 8,
       parameter DATA_WIDTH = 32 )
    // ports section
    (   input clk,
        input rst_n,
        input cs, // chip select
        input wr_en,
        input rd_en,
        input [DATA_WIDTH - 1 : 0] data_in,
        output reg [DATA_WIDTH - 1 : 0] data_out,
        output empty,
        output full );

    localparam FIFO_DEPTH_LOG = $clog2(FIFO_DEPTH); // number of bits to represent FIFO_DEPTH

    // array to store the data
    reg [DATA_WIDTH - 1 : 0] fifo [0 : FIFO_DEPTH - 1];

    // Wr/Rd pointer have 1 extra bits at MSB
    reg [FIFO_DEPTH_LOG : 0] write_pointer;
    reg [FIFO_DEPTH_LOG : 0] read_pointer;

    // write
    always@(posedge clk, negedge rst_n) 
    begin
        if(!rst_n)
            write_pointer <= 0;
        else if(cs && wr_en && !full) begin
            fifo[write_pointer[FIFO_DEPTH_LOG - 1 : 0]] <= data_in;
            write_pointer <= write_pointer + 1'b1;
        end 
    end

    // read
    always@(posedge clk, negedge rst_n)
    begin
        if(!rst_n)
            read_pointer <= 0;
        else if(cs && rd_en && !empty) begin
            data_out <= fifo[read_pointer[FIFO_DEPTH_LOG - 1 : 0]];
            read_pointer <= read_pointer + 1'b1;
        end
    end

    // declare the empty/full logic
    assign empty = (read_pointer == write_pointer);
    assign full  = (read_pointer == {~write_pointer[FIFO_DEPTH_LOG], write_pointer[FIFO_DEPTH_LOG - 1 : 0]});


endmodule