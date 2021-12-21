MIME-Version: 1.0
References: <CAPMj8MvTHmgqABPTdvsiN8F5m6j4Sa0EA7iBUjT2hYikyQaY_w@mail.gmail.com>
 <8f9d3ba7-e8b0-c302-b6cc-b8795efe1de0@siemens.com>
 <CAPMj8Mt+6gHSCpfAXHqBkjD4zbfCZV4sKo=u+-jJb3TLN4q4xw@mail.gmail.com>
 <1f4be821-5f99-339e-4599-532c1a9ed35b@siemens.com>
In-Reply-To: <1f4be821-5f99-339e-4599-532c1a9ed35b@siemens.com>
From: Sam Daniel <daniel.jacob.samuel@gmail.com>
Date: Mon, 20 Dec 2021 21:38:18 -0800
Message-ID: <CAPMj8MvKEuKBycqiy79i44RGn7o8-mSz0xdyzNx3Cfy9eekGFg@mail.gmail.com>
Subject: Re: Debugging kernel paging request oops
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Thu, Dec 16, 2021 at 1:06 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 16.12.21 09:49, Sam Daniel wrote:
> > On Thu, Dec 16, 2021 at 12:42 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 16.12.21 06:35, Sam Daniel via Xenomai wrote:
> >>> Hello. I am running on a Xilinx ZCU102 (ARM64, Cortex A53) development
> >>> board and I've written a lot of userspace software against the POSIX skin
> >>> of Cobalt 3.1.
> >>>
> >>> For context, I have set isolcpus=1,2,3 as kernel boot args. I only run my
> >>> Xenomai tasks on CPUs 1,2,3. I know that despite isolcpus, the Linux kernel
> >>> will still run a few kthreads on those cores. I am worried that the cause
> >>> of my issues might be my Xenomai tasks completely starving those Linux
> >>> kthreads.
> >>
> >> That is likely if your task actually dominates those isolated cores
> >> (100% CPU usage). The Xenomai watchdog can catch such bugs and resolve
> >> the lockup by kicking the CPU hog out of RT mode. Then you can analyze
> >> why the task was not sleeping from time to time.
> >>
> >> Jan
> >>
> >> --
> >> Siemens AG, T RDA IOT
> >> Corporate Competence Center Embedded Linux
> >
> > I have CONFIG_XENO_OPT_WATCHDOG=y and CONFIG_XENO_OPT_DEBUG=y set but
> > don't get any Xenomai/watchdog related output when this kernel oops
> > occurs.
> >
>
> OK, then your task should release the core from time to time, and we
> have a different kind of crash.
>
> What is your kernel version? Where did the patch come from?
>
> Also, your trace of the crash is unfortunately filled with printing the
> oops, likely not with the actual problem. Do you have a backtrace as
> well? Can you make the trace longer [1]?
>
> Jan
>
> [1] https://source.denx.de/Xenomai/xenomai/-/wikis/Using_The_I_Pipe_Tracer
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux

# xeno-config --info
Xenomai version: Xenomai/cobalt v3.1
Linux tonka 4.19.55 #1 SMP PREEMPT Mon Dec 20 22:10:45 UTC 2021
aarch64 GNU/Linux
Kernel parameters: root=/dev/mmcblk0p2 rw rootwait rootfstype=ext4
isolcpus=1,2,3
I-pipe release #4 detected
Cobalt core 3.1 detected
Compiler: gcc version 8.2.0 (GCC)
Build args: CFLAGS=-mtune=cortex-a53 LDFLAGS=-mtune=cortex-a53
--with-core=cobalt --build=i686-pc-linux-gnu --host=aarch64-linux-gnu
--enable-pshared --enable-smp CC=aarch64-linux-gnu-gcc
LD=aarch64-linux-gnu-ld build_alias=i686-pc-linux-gnu
host_alias=aarch64-linux-gnu

I used ipipe-core-4.19.55-arm64-4.patch.

The overall heritage of my Linux kernel is a bit ugly: I started with
Xilinx's fork of the 4.19.0 kernel (because I am using a ZCU102 dev
kit); then patched it from mainline Linux up to 4.19.55; and finally
applied Cobalt/I-Pipe to the kernel.

My application workload is heavy: 40 different periodic tasks, tick
rates between 10 and 100ms. I have never seen these crashes happen
spontaneously during runtime. But I can somewhat reliably reproduce
them by starting, stopping, and restarting my application software.

I have noticed a few commonalities in the crashes:
* "Unable to handle kernel paging request at virtual address: <address>"
* "address between user and kernel address ranges"
* "I-pipe domain: Linux"
* "Call trace" of 1-2 lines that points to ___xnsched_run

This is one that I have not seen before:
[ 8373.909772] [Xenomai] lock 00000000916ccdbc already unlocked on CPU #2
[ 8373.909772]           last owner =
kernel/xenomai/posix/process.c:1242 (handle_schedule_event(), CPU #-2)
[ 8373.926249] Call trace:
[ 8373.928800]  dump_backtrace+0x0/0x170
[ 8373.932592]  show_stack+0x24/0x30
[ 8373.936028]  xnlock_dbg_release+0x13c/0x1c0
[ 8373.940352]  ___xnlock_put+0x3c/0x60
[ 8373.944053]  xnregistry_bind+0x1a4/0x260
[ 8373.948109]  iddp_ioctl+0xa9c/0xd50
[ 8373.951727]  rtipc_ioctl+0x3c/0x50
[ 8373.955253]  rtdm_fd_ioctl+0x100/0x2c0
[ 8373.959129]  CoBaLt_ioctl+0x34/0x50
[ 8373.962747]  handle_head_syscall+0xf4/0x440
[ 8373.967069]  ipipe_fastcall_hook+0x28/0x40
[ 8373.971305]  ipipe_handle_syscall+0x7c/0x110
[ 8373.975712]  el0_svc_common+0x68/0x1b0
[ 8373.979593]  el0_svc_handler+0x74/0x90
[ 8373.983469]  el0_svc+0x8/0x18
[ 8373.990486] ------------[ cut here ]------------

