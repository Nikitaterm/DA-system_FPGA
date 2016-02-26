module OUTPUT_controller(input clock, input [10:0] data_in, input[3:0] avaliable_data, 
								 output fifo_read_clock, output fifo_read_irq, output[10:0] data_out, output IRQ);
	reg[10:0] data_ = 0;
	assign data_out = data_;
	reg[7:0] state = 0;
	reg irq = 0;
	assign IRQ = irq;
	reg fifo_read_clk = 0;
	assign fifo_read_clock = fifo_read_clk;
	reg fifo_read_request = 0;
	assign fifo_read_irq = fifo_read_request;

	always @(posedge clock) begin
		if (state == 0) begin
			fifo_read_clk <= 1;
			state <= state + 1;
		end
		if (state == 1) begin	// Is the condition being checked by the next clock?
			fifo_read_clk <= 0;
			state <= state + 1;
		end
		if (state == 2) begin
			if (avaliable_data > 0) begin
				fifo_read_request <= 1;
				state <= state + 1;
			end
			else begin
				state <= 0;
			end
		end
		if (state == 3) begin
			fifo_read_clk <= 1;
			state <= state + 1;
		end
		if (state >= 4 && state < 40) begin
		   data_ <= data_in;
			irq <= 1;
		   fifo_read_clk <= 0;
		   fifo_read_request <= 0;
			state <= state + 1;
		end
		if (state == 40) begin
			irq <= 0;
			state <= 0;
		end
	end

endmodule
