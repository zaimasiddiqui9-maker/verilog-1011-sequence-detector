
`timescale 1ns/1ps

// Mealy FSM: 1011 Sequence Detector
module sequence_detector (
    input wire clk,
    input wire rst_n,
    input wire din,
    output reg detected
);

    parameter S0   = 2'b00;  // No match
    parameter S1   = 2'b01;  // Detected 1
    parameter S10  = 2'b10;  // Detected 10
    parameter S101 = 2'b11;  // Detected 101

    reg [1:0] state, next_state;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            S0: begin
                if (din == 1'b1)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                if (din == 1'b0)
                    next_state = S10;
                else
                    next_state = S1;
            end

            S10: begin
                if (din == 1'b1)
                    next_state = S101;
                else
                    next_state = S0;
            end

            S101: begin
                if (din == 1'b1)
                    next_state = S1;  
                else
                    next_state = S10;
            end

            default: next_state = S0;
        endcase
    end

    // Mealy output logic
    always @(*) begin
        detected = 1'b0;

        if ((state == S101) && (din == 1'b1))
            detected = 1'b1;
    end

endmodule


// TESTBENCH
module sequence_detector_tb;

    reg clk;
    reg rst_n;
    reg din;
    wire detected;

    sequence_detector dut (
        .clk(clk),
        .rst_n(rst_n),
        .din(din),
        .detected(detected)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, sequence_detector_tb);
    end

    initial begin
        $monitor(
            "Time=%0t | din=%b | detected=%b",
            $time, din, detected
        );

        rst_n = 1'b1;
        din = 1'b0;

        #2 rst_n = 1'b0;
        #10 rst_n = 1'b1;

        // Input sequence: 1 0 1 1 0 1 1
        @(negedge clk) din = 1'b1;
        @(negedge clk) din = 1'b0;
        @(negedge clk) din = 1'b1;
        @(negedge clk) din = 1'b1;

        @(negedge clk) din = 1'b0;
        @(negedge clk) din = 1'b1;
        @(negedge clk) din = 1'b1;

        @(negedge clk) din = 1'b0;

        #10;
        $finish;
    end

endmodule
