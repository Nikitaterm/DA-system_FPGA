module INPUT_controller(input A,B, output dir);
	reg DIR, DIR1;
	assign dir = (A)?DIR:DIR1;

	always @(posedge A) begin
		if (B == 1'b0)
			DIR <= 1;
		else
			DIR <= 0;
	end

	always @(negedge A) begin
		if (B == 1'b0)
			DIR1 <= 0;
		else
			DIR1 <= 1;
	end
endmodule
