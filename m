References: <56FAF42C.2040902@mitre.org>
From: Jeffrey Melville <jmelville@mitre.org>
Message-ID: <56FBD441.3030905@mitre.org>
Date: Wed, 30 Mar 2016 09:27:29 -0400
MIME-Version: 1.0
In-Reply-To: <56FAF42C.2040902@mitre.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai and AddressSanitizer/ASan
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 3/29/2016 5:31 PM, Jeffrey Melville wrote:
> Hi,
> 
> I'm running Zynq ZC706 board with Xenomai 2.6.4 on a pre/post patched
> 3.14.17 kernel from the Xilinx fork. Everything was built using gcc 4.9.1
> 
> I'm hitting a segfault and the core dumps are corrupted with no useful
> information. As a last resort, I'm trying to use the gcc version of
> AddressSanitizer
> (https://github.com/google/sanitizers/wiki/AddressSanitizer). We've used
> ASan successfully on the same codebase but on x86_64 using a hardware
> simulation library that doesn't have real-time requirements.
> Unfortunately, this bug doesn't show up in the simulation.
> 
> I tried a simple "hello world" program with a memory bug that generates
> the desired report with ASan alone. When I include Xenomai, the app
> crashes before getting to main():
> Program received signal SIGSEGV, Segmentation fault.
> 0x00000000 in ?? ()
> (gdb) bt
> #0  0x00000000 in ?? ()
> #1  0xb6b482cc in __interceptor_pthread_cond_signal (Cannot access
> memory at address 0x0
> c=0x4e9dd2f8) at
> ../../../../../../../../../work-shared/gcc-4.9.1-r0/gcc-4.9.1/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:2268
> #2  0x4e9d2cf8 in ?? () from /usr/lib/libxenomai.so.0
> Cannot access memory at address 0x0
> Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> 
> I think the pthread_cond_signal call occurs in the rt_print init. This
> sanitizer issue may be related:
> https://github.com/google/sanitizers/issues/297. I'm not sure why the
> problem occurs when Xenomai is linked but not when it isn't.
> 
> My LDFLAGS are:
> -lasan -lpthread -lrt
> -Wl,@/mnt/data/poky/1.7.1/sysroots/armv7a-vfp-neon-poky-linux-gnueabi/usr/lib/posix.wrappers
> -L/mnt/data/poky/1.7.1/sysroots/armv7a-vfp-neon-poky-linux-gnueabi/usr/lib
> -lpthread_rt -lxenomai -lpthread -lrt
> 
> Has anyone used Xenomai and ASan together successfully? What steps did
> you have to take? Or is it a terrible idea?
> 
> I know this might be more of an ASan issue but figured it's more likely
> Xenomai people are familiar with ASan than vice versa. I'll try them as
> well.
> 
> Thanks,
> Jeff
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
> 
Nevermind.

My non-Xenomai test case was oversimplified. If I included a call to
pthread_cond_signal in the non-Xenomai test case, I get the same
segfault due to the upstream issue. I will need to update my compiler to
get the upstream fix.

More fundamentally, I realized the ASan is not practical on a Xenomai
system because it relies on mapping a huge amount of virtual memory that
isn't possible with Xenomai's use of mlockall(). I'll have to figure out
something else.

Cheers,
Jeff

