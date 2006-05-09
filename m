Message-ID: <4460A02E.2080007@domain.hid>
Date: Tue, 09 May 2006 15:59:10 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.2-rc1
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


Here is the first candidate release [1] of the 2.2 series. Updates,
fixes and hopefully improvements have taken place all over the
map. Added features mainly concern the VxWorks skin and the Adeos
support (2.4/2.6, all architectures).

Direct invocation of the VxWorks emulation services running in kernel
space is now possible from user-space applications, the same way it is
already done with the native, POSIX and RTDM skins. The new interface
can be mixed with any of the existing ones, e.g. one may call RTDM
services in a user-space application also relying on the VxWorks
skin. The former VxWorks-over-UVM support which provides a different
approach for running a (sandboxed) VxWorks emulation in user-space is
continued and will be maintained though. This said, the trend is
clearly to provide to user-space applications a direct call interface
to all kernel-based skins (e.g. VRTX, pSOS+ and uITRON), and this work
will be pursued during the next releases.

Adeos-wise, patches have been upgraded for all architectures. A new
kind of interrupt handling called "wired mode" has been introduced in
order to shorten the IRQ delivery path, when Adeos may safely assume
that some invariant domain always leads the interrupt pipeline
(e.g. Xenomai). The wired delivery mode is mainly intended at reducing
the worst-case latency figures on low-end hardware, and the average
latency in general, without otherwise affecting the pipeline
properties. Various tests on different architectures showed that such
optimization might or might not be significant (i.e. above the noise
level), depending on how much the target platform is sensitive to
I-cache and code locality issues, so your mileage may vary. In any
case, I would be interested in any feedback regarding the observed
performance of such delivery mode on your particular hardware.

Here is a short log of other major changes:

* [ppc] Adeos/2.4.25 upgraded to Denx's CVS head of
   linuxppc_2_4_devel [2], as of 2006-04-30.

* [i386] FPU support fixes.

* [blackfin] Major kernel upgrade to uClinux 2.6.16, with support for
   the BF537 board [3] sponsored by Analog Devices.

* [nucleus] Optimize fast path for handling aperiodic timer
   ticks. Core interrupt API sanitization.

* [doc] Manpages update.

* [scripts] Test and preparation scripts updates.

* [posix] Various fixes and updates.

* [RTDM] Various fixes and updates.

* [native] Updates.

* [sim] Fix for GCC 4.x.

* [uvm] Reorganization of the directory layout.

* [testsuite] New "cyclic" test.

Please see the ChangeLog for details. Thanks to all contributors.

[1] http://download.gna.org/xenomai/testing/xenomai-2.2-rc1.tar.bz2
[2] http://www.denx.de/en/Software/CVS
[3] http://www.analog.com/en/prod/0,,ADSP%252DBF537,00.html

-- 

Philippe.

