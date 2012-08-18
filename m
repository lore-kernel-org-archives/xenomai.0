MIME-Version: 1.0
Date: Sat, 18 Aug 2012 19:29:32 +0800
Message-ID: <CAGVaUoFSCeUWb2b9WXiSi1kNo6MhE8VGgSNdqo8N5Vco_=MNdA@mail.gmail.com>
From: Bao Rui <rbaocug@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] The kernel stops after the message "Uncompressing
 Linux... done, booting the kernel."
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

These days I try to adapt IPIPE&XENOMAI 2.6.1 to Beaglebone, as the
"linux-3.2.0-psp04.06.00.08.sdk" is provided by TI, and its Linux version
is 3.2.0, so I merge the ipipe-core-3.2.21-arm-1.patch and xenomai kernel
sources to "linux-3.2.0-psp04.06.00.08.sdk". After finish that, I try to
boot the kernel on the beaglebone, but the kernel stoped after "
Uncompressing Linux... done, booting the kernel."

I disable the CONFIG_IPIPE, CONFIG_XENOMAI, but it is the same problem,
even I enabled CONFIG_DEBUG_LL and CONFIG_EARLY_PRINTK, it does not work.

Could anyone to give the suggestions for this issue?

For the OEM provided linux source code, we may choose to integrated XENOMAI
with two different solutions:
1. Integrated IPIPE and Xenomai KSRC to the OEM provided linux source code.
2. Use standard Linux kernel and patch the ipipe and Xenomai first, then
inegrated OEM board drivers into this Linux source code.

>From my point of view, the first solution we may not care about the
drivers(Or not to care about it too much, just modify some code following
IPIPE rules), but the dangerous thing is the IPIPE patch, it will need to
modify near 150 files for the "linux-3.2.0-psp04.06.00.08.sdk", it is not
easy to control.

For the second choice, we may faced some problem to adapt OEM linux drivers
to the standard LInux kernel with IPIPE and Xenomai KSRC.

>From your experience, which one is better?

Thanks for your help!

Henry
