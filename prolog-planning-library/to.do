(start timing the planning stuff)

(swipl -s backward-a-star-h_diff.pl  -g "command_line." -a test/blocks/domain-blocks.pddl test/blocks/blocks-03-0.pddl)

(ERROR: /var/lib/myfrdcsa/sandbox/prolog-planning-library-20140313/prolog-planning-library-20140313/common.pl:1:
	source_sink `library(timeout)' does not exist
Warning: /var/lib/myfrdcsa/sandbox/prolog-planning-library-20140313/prolog-planning-library-20140313/common.pl:1:
	Goal (directive) failed: user:use_module(library(timeout))
ERROR: /var/lib/myfrdcsa/sandbox/prolog-planning-library-20140313/prolog-planning-library-20140313/backward.pl:12:
	source_sink `library(sets)' does not exist
Warning: /var/lib/myfrdcsa/sandbox/prolog-planning-library-20140313/prolog-planning-library-20140313/backward.pl:12:
	Goal (directive) failed: user:use_module(library(sets))
ERROR: Prolog initialisation failed:
ERROR: reset_statistic/0: Undefined procedure: bb_put/2)
