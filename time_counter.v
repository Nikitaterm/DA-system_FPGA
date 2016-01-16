module time_counter(input A, input B, input clock, output[10:0] _time, output to_fifo);
	
	reg erase = 0;
	reg prev_A = 0;
	reg[9:0] count = 0;
	reg[10:0] _time_data = 0;
	assign _time = _time_data;
	reg _to_fifo = 0;
	assign to_fifo = _to_fifo;

	always @(posedge clock) begin
		if (A != prev_A) begin
			if (A) begin
			   _time_data <= count;
				_to_fifo <= 1;
				erase <= 1;
			end
			prev_A <= A;
		end
		if (erase == 1) begin
			count <= 0;
		end
		if (count == 0) begin
	      _to_fifo <= 0;
		end
		if (count == 10'b1111111111) begin
         _time_data <= count | (1<<10);
			_to_fifo <= 1;
		end
		count <= count + 1;
	end

endmodule
