compile:
	mkdir -p sim && cd sim && vcs -full64 -sverilog -debug_access+all -f ../flist.f

run:
	cd sim && ./simv -gui=dve

clean:
	@rm -rf sim/* 