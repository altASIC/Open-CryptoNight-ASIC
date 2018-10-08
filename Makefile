# Comment out to run full test
SPEEDUP_MODE := -DSPEEDUP_MODE
# Uncomment for dumpfile
# DUMP := -DDUMP

iverilog:
	iverilog \
		$(SPEEDUP_MODE) \
		$(DUMP) \
		-I src -I tb \
		tb/cn_core_tb.v tb/cn_core.v \
		src/cn_top.v src/cn_il_fl.v src/cn_ml.v \
		src/dpram.v src/spram.v src/spram128k.v src/cipherRound.v src/multiplier.v src/keyExpansion.v src/key_ram.v
	cd tb; ../a.out

clean:
	rm -rf simv simv.daidir csrc tb/ucli.key /obj_dir a.out *.bak *.vcd
	cd tb; rm -rf simv simv.daidir csrc tb/ucli.key /obj_dir a.out *.bak *.vcd AN.DB .vlogansetup.args

wave:
	gtkwave tb/dumpfile.vcd tb/dumpfile.gtkw &
