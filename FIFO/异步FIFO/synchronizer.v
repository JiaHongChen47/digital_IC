module synchronizer #(parameter WIDTH=3) (
    input clk, rst_n,
    input [WIDTH:0] d_in,
    output reg [WIDTH:0] d_out
);
    reg [WIDTH:0] q1;
    // 为什么采用同步复位
    always@(posedge clk) begin 
        if(!rst_n) begin
            q1 <= 0;
            d_out <= 0;
        end
        else begin 
            q1 <= d_in;
            d_out <= q1;
        end
    end
    
endmodule