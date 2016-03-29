From: Jeffrey Melville <jmelville@mitre.org>
Message-ID: <56FAF42C.2040902@mitre.org>
Date: Tue, 29 Mar 2016 17:31:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai and AddressSanitizer/ASan
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I'm running Zynq ZC706 board with Xenomai 2.6.4 on a pre/post patched
3.14.17 kernel from the Xilinx fork. Everything was built using gcc 4.9.1

I'm hitting a segfault and the core dumps are corrupted with no useful
information. As a last resort, I'm trying to use the gcc version of
AddressSanitizer
(https://github.com/google/sanitizers/wiki/AddressSanitizer). We've used
ASan successfully on the same codebase but on x86_64 using a hardware
simulation library that doesn't have real-time requirements.
Unfortunately, this bug doesn't show up in the simulation.

I tried a simple "hello world" program with a memory bug that generates
the desired report with ASan alone. When I include Xenomai, the app
crashes before getting to main():
Program received signal SIGSEGV, Segmentation fault.
0x00000000 in ?? ()
(gdb) bt
#0  0x00000000 in ?? ()
#1  0xb6b482cc in __interceptor_pthread_cond_signal (Cannot access
memory at address 0x0
c=0x4e9dd2f8) at
../../../../../../../../../work-shared/gcc-4.9.1-r0/gcc-4.9.1/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:2268
#2  0x4e9d2cf8 in ?? () from /usr/lib/libxenomai.so.0
Cannot access memory at address 0x0
Backtrace stopped: previous frame identical to this frame (corrupt stack?)

I think the pthread_cond_signal call occurs in the rt_print init. This
sanitizer issue may be related:
https://github.com/google/sanitizers/issues/297. I'm not sure why the
problem occurs when Xenomai is linked but not when it isn't.

My LDFLAGS are:
-lasan -lpthread -lrt
-Wl,@/mnt/data/poky/1.7.1/sysroots/armv7a-vfp-neon-poky-linux-gnueabi/usr/lib/posix.wrappers
-L/mnt/data/poky/1.7.1/sysroots/armv7a-vfp-neon-poky-linux-gnueabi/usr/lib
-lpthread_rt -lxenomai -lpthread -lrt

Has anyone used Xenomai and ASan together successfully? What steps did
you have to take? Or is it a terrible idea?

I know this might be more of an ASan issue but figured it's more likely
Xenomai people are familiar with ASan than vice versa. I'll try them as
well.

Thanks,
Jeff

