Message-ID: <50F19CE1.5080106@zultron.com>
Date: Sat, 12 Jan 2013 11:26:57 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Kernel OOPS during regression tests
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi list,

The el6 packages are coming along nicely:

https://github.com/zultron/kernel-ml/tree/branch3.5.3-xeno

Still a few problems when running xeno-regression-test.

1)  Most worrisome is "kernel BUG at mm/mmap.c:2313!   invalid opcode:
0000 [#2] SMP".  Is this related to HEAPSZ or STACKPOOLSZ?  My mind is
getting foggy about all the things I've seen, but it seems like it was
happening earlier in the tests until these config values were quadrupled.

2)  posix/mprotect is failing:  "FAILURE: sigdebug_handler triggered,
reason 2    memory write after exec enable".

3)  FPU warning:  "fptest.h:24: Warning: Linux is compiled to use FPU in
kernel-space.    For this reason, switchtest can not test using FPU in
Linux kernel-space."

Regression test run log:
http://www.zultron.com/static/2013/01/xenomai/foo-xeno-regression-test.log

Log of dmesg with oops at end:
http://www.zultron.com/static/2013/01/xenomai/foo-oops.log

Kernel .config:
www.zultron.com/static/2013/01/xenomai/foo-kernel.config

The kernel is built from the elrepo.org kernel, and this config file
overrides the upstream config; makes it easy to see the Xenomai-specific
changes:
https://github.com/zultron/kernel-ml/blob/branch3.5.3-xeno/config-3.5.3-xenomai-x86_64

Any help is greatly appreciated!  These RPMs are part of my effort to
enable RH-like distros to run LinuxCNC and expand the pool of potential
users, so if I'm successful, many folks will benefit.

	John

