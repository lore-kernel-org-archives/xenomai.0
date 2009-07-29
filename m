Date: Wed, 29 Jul 2009 12:12:57 +0200 (CEST)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <1248855797.3247.16.camel@domain.hid>
Message-ID: <Pine.LNX.4.62.0907291210470.20869@domain.hid>
References: <Pine.LNX.4.62.0907241731170.11473@domain.hid>
	<1248453047.3998.168.camel@domain.hid>
	<alpine.DEB.2.00.0907241917480.4343@domain.hid>
	<1248461458.3998.183.camel@domain.hid>
	<alpine.DEB.2.00.0907242259430.4343@domain.hid>
	<1248517986.4438.1.camel@domain.hid>
	<alpine.DEB.2.00.0907281859210.4673@domain.hid>
	<1248855797.3247.16.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: [Xenomai-help] Stack sizes etc. (Re: POSIX skin/Blackfin: SIGSEGV
 when stracing or gdb'ing)
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

Ok, it now seems to run on 2.4.7 (matched kernel + userland) just as
well. I'll try to keep it that way because that's as it comes in the
2009R1 release branch.

>> The application runs with POSIX calls and critical threads controlled
>> using the native API (using rt_task_shadow), or all threads
>> controlled via POSIX skin, and it is well debuggable. Only when I
>> tried to use the native skin for everything, I ran into problems this
>> time.
>
> Any details about this? What did not work with GDB precisely (btw, did
> you check the stack sizes used to create your native tasks)?

Yes, the problems are very probably caused by wrong configuration of various
memory areas, including the task stack(s). I'm not sure how the stacks
and heaps of main, NRT and RT tasks are related and where the memory is
allocated from.

The main thread stack can be set with linker options (-Wl,--defsym,__stacksize=x). 
Is the same memory used if I create a rt task using rt_task_shadow in main?

Where is the memory for rt task stacks taken from?  Does it differ depending on the skin?

Does the Xenomai memory configuration in the kernel limit the rt task stack size?

One of the problems appears when the following code is run via
gdbserver, a breakpoint is hit at main() and I "step" over
rt_task_shadow:

> int main (int argc, char *argv[])
> {
>     RT_TASK maintask;
>     rt_task_shadow(&maintask, "maintask", 50, 0);
>     return 0;
> }

The kernel, with Xenomai debugging enabled, then emits the following:

> Xenomai: fatal: xnshadow_relax() failed for thread maintask[222]
>  CPU  PID    PRI      TIMEOUT  STAT      NAME
>    0  0       50      0        00400088  ROOT
> >  0  222     50      0        00300380  maintask
> Master time base: clock=264885399009

When started without gdb or "cont" without breakpoints set, this doesn't
happen, main returns successfully.

Kolja



