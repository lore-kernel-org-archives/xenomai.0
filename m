Message-ID: <4368A088.9070906@domain.hid>
Date: Wed, 02 Nov 2005 12:18:32 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Dev branch 2.1
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


A dev branch toward v2.1 has been created. It features a new build system so 
that Xenomai now follows a split source model, decoupling the kernel space 
support from the user-space libraries used in accessing the former.

It's work in progress, and there is still a lot of things to be done in order to 
finish the transition from a tightly coupled source-based system to the 
decoupled ABI-based model, but a lot has been done already. What remains is 
basically a slew of details to be fixed, since I had to somehow "disconnect" a 
number of things before attempting to connect them back gradually.

All in all, my perception of this beast is that it's way simpler than the older 
fully autoconf-based system which tended to become overly complex over time.

How does this work?

Simple and easy. The Xenomai distro now comes with a pure kernel source part 
(ksrc/) and a pure user-space source part (src/). A few symlinks are made from 
the target kernel to the ksrc/ tree, so that Linux's Kconfig/Kbuild just sees 
Xenomai as a regular set of mainline drivers/extensions. A shell script 
(scripts/prepare-kernel.sh) automates the kernel preparation so that it 
eventually includes the Xenomai support. The user-space side is autoconfiscated, 
and only builds the interface libraries used to issue Xenomai syscalls, and the 
UVM libraries; period.

The HAL has been made a static part of the kernel, since it has an 
architecture-dependent section, is totally silent when the nucleus does not use 
it, and weigths less than 10 Kb on any platform. Additionally, if something goes 
wrong into the HAL, well, there is little chance one is going to be able to 
unload it, fix it and try it again. Under such circumstances, the box almost 
certainly went out of the window anyway, so providing for the modular form is 
just, mhhh, braindamage.

The simulator will be shipped as a separate tarball starting from 2.1. It is 
still part of the dev trunk though.

Advantages:

- The user-space support does not have to know about the target kernel. A set of 
features required by the former is just checked for availability when an 
application binds to a skin built in the latter. This ABI separation is going to 
be enforced; the idea is plain simple: I see absolutely no reason why user-space 
Xenomai interfaces should have for the RT applications a different role than the 
glibc has interfacing them to the regular kernel services.

- Normally, no kernel headers are included anymore from user-space programs. 
This should solve the C++ issues in the same move. If some mistakenly remain, we 
will have to fix them.

- The nucleus and all skins can be either compiled as modules, or statically 
built into the kernel (a glitch remains with POSIX due to a redefinition of 
sem_init(), but this is going to be fixed).

- Binary packaging should be made simpler.

- Xenomai actually looks like a more seamlessly integrated extension of the 
Linux kernel, since the kernel space is fully under the control of the vanilla 
Kbuild/Kconfig stuff because it is fully part of the kernel tree now. One just 
has to open the "Real-time sub-system" menu from the Kconfig toplevel to access 
the complete Xenomai setup, no more error-prone multiple configuration sources. 
I've also killed the Expert mode, all options are visible at once, so that Xeno 
conforms better to the Linux configuration rules. Help strings should be 
revisited in order to explain which defaults are sane though.

Pitfalls/Caveats:

- Compilation of modules is now out of Xenomai's build system scope, it's a pure 
Linux thing anew, so no support is provided for doing this anymore. For 
instance, xeno-config has twice less options than before, because all kernel 
compilation related stuff has disappeared. Kernel modules should be compiled the 
Linux way (i.e. cd your_module && make -C <your-kernel-tree> M=$PWD).

- Don't search for klatency; it's not available yet. The plan is to integrate 
the kernel portion as a built-in test module, and extend the user-space latency 
tool so that it can also be used to get the sampling results from the in-kernel 
module too.

- The cruncher has been removed, because the test case was not sensible anymore.

- Make install currently installs half of the available headers, and basically 
none that would be useful to build kernel modules. It is still possible to find 
those from the kernel tree, but this also requires to leave the full Xenomai 
sources accessible. This likely has to be fixed, but we need a round of 
discussion about what should be available from the installdir first. Btw, I've 
moved the default installation dir to /usr/xenomai, so that we couldn't 
spuriously mix pre-2.1 and 2.1 setups.

- Make dist will not work properly.

I've updated quickly the README.INSTALL file so that the new build procedure is 
explained. This document will need to be fleshen out though, since it's rather 
terse for now.

Again, all this is very new, so review and comments are welcome. The window for 
tree reorganization is still open.

http://svn.gna.org/viewcvs/xenomai/branches/v2.1/

-- 

Philippe.

