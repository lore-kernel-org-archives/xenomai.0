From: Romain Lenglet <rlenglet@domain.hid>
Date: Thu, 20 Oct 2005 16:24:49 +0900
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510201624.49798.rlenglet@domain.hid>
Subject: [Xenomai-core] [Debian packaging] Split: kernel code / user-space
	code / includes
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

Hi,


I am thinking about how to separate kernel modules source 
packages, libraries packages and development packages.
Below are more precise proposals and questions.
Tell me what you think about it.


The one big problem is that we must completly separate 
user-space-related packages and kernel modules source packages.
I have identified the following user-space packages for Xenomai:

- libxenomai: the user-space libraries, for *all* the skins, i.e. 
basically only the content of PREFIX/lib (only *.so and *.la 
files)

- libxenomai-dev: the include files, for *all* the skins (i.e. 
the content of PREFIX/include EXCEPT xeno_config.h) + 
PREFIX/lib/*.a + the manpage for xeno-config (BUT NOT the 
xeno-config script, since it depends on kernel-modules-specific 
configuration, see below)

- libxenomai-tools: two scripts (xeno-info, xeno-load), and 
manpages (xeno-info, xeno-load and runinfo)

- libxenomai-test: the xeno-test script and its manpage + the 
binaries and .runinfo for latency, klatency, cruncher and switch 
(BUT NOT the klatency_rt.ko module for klatency, since it is not 
a user-space thing)

- libxenomai-doc: the content of share/doc/xenomai*


The key problem is that those binary user-space packages must be 
independent from the configuration of the kernel modules 
(basically, what is in xeno_config.h).
Can someone confirm this?!
If this is not true, we are in BIG troubles for packaging, and 
this must be fixed.

I am not taking into account the problem that could arise if a 
user explicitly chooses not to compile the kernel module for a 
skin: we can tolerate this, in this case user-space apps that 
use the skin will crash, but this is the responsability of the 
user.



Here are the kernel module source packages I propose:

- xenomai-source: the source of the kernel modules for all skins 
+ a kernel-modules-only configuration mechanism + the 
xeno-config script skeleton

- xenomai-test-source: the source of the klatency_rt module used 
by the klatency test program. i.e. this package should mainly 
contain latency-module.c and latency.h

Those module source packages will be used to generate module 
binary packages (using make-kpkg or module-assistant), e.g. if 
compiled for a 2.6.13 kernel :

- xenomai-modules-2.6.13-1-686: the binary module files installed 
into /lib/modules/2.6.13-1-686/... + the 
xeno_config-2.6.13-1-686.h include file (where to install it???) 
+ the corresponding xeno-config-2.6.13-1-686 script (which 
option --config would return the path to the 
xeno_config-2.6.13-1-686.h config file)

- xenomai-test-modules-2.6.13-1-686: the binary klatency_rt 
module installed into /lib/modules/2.6.13-1-686/...


This split packaging allows to have multiple kernel packages 
installed, with corresponding multiple xenomai-modules-* modules 
packages installed. The user-space packages (libxenomai*) must 
be usable with any of those module packages, without rebuilding.

For compiling application modules for one or the other 
xenomai-modules-* module package, users will have to choose the 
right xeno-config-* script to execute, that would each return 
the path to a different xeno-config-*.h file.
This would be very much like Debian's packaging of kernels: each 
kernel package installs a /boot/config-* file that corresponds 
to the kernel compilation configuration.
It will be able to configure one xeno-config script to be the 
"default" on the system, using Debian's alternatives mechanism.



But to be able to make such a split packaging, I have a number of 
questions and requests:

- Could someone separate the configuration mechanism for 
kernel-space and user-space? currently when one executes
make *config, we have both user-space and kernel-space 
configuration options. This configuration mechanism cannot be 
reused as-is as the configuration mechanism for the 
xenomai-source package.

- I really don't know what to do with the simulator. Could it be 
packaged separately, as additional packages to all the the other 
ones above? Is it purely user-space? Does it build libraries 
which names clash with those of Xenomai? For instance, could a 
libxenomai-sim be a drop-in replacement for a libxenomai 
package?
I have not been able to build it, so I don't know (I am too lazy 
to download a GCC 2.95 tarball for I don't know why).

- What could be a reasonable (i.e. safe, but not necessarily with 
the lowest latency) default kernel module configuration with all 
skins enabled? I mean, what about the SMI workaround, FPU 
support, etc. by default?

- I really don't like the idea of having ALL the include files 
include the xeno_config.h file, which is kernel-space specific, 
even when compiling only for user-space. This implicitly makes 
the compilation of user-space programs look like it depends on 
specific kernel configuration options.
The problem is: since we must be able to install multiple binary 
module packages in the same system, how to choose the right 
xeno_config.h file that comes with each package?!
And NO, installing all the include files multiple times in 
different directories is not a good solution, nor would be a 
limitation to install at most one module package (hence only one 
xeno_config.h) a good solution.


As a conclusion, I believe that the current code organization of 
Xenomai ("split the skins") is not appropriate for packaging 
("split between kernel- and user-space").

-- 
Romain Lenglet

