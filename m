Message-ID: <4B263BB7.2060103@domain.hid>
Date: Mon, 14 Dec 2009 14:20:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <634c78ce0912140322r6e28b8ffl98818cd83a1a3c27@domain.hid>
In-Reply-To: <634c78ce0912140322r6e28b8ffl98818cd83a1a3c27@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Vague bug report(s) on 2.5-head
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Peter Soetens <peter@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Peter Soetens wrote:
> Hi guys,
> 
> I'm using the master branch, 4f42de74 with Linux 2.6.31.1 and the
> adeos patch from that tree. My app links with both -lnative and
> -lposix with the wrappers (using xeno-config).
> 
> I'm experiencing a segfault within pthread_cancel() when calling
> rt_task_delete(&task) of the main() thread (so it deletes its own
> task), which was init'ed with rt_task_shadow(). When I omit the delete
> call, the application terminates cleanly. When the app doesn't link
> with posix wrappers, no segfault either.
> 
> I didn't have this behaviour 'before' (2.4.10). I don't have crashes
> when deleting normal RT-threads created with rt_task_create.
> 
> Program received signal SIGSEGV, Segmentation fault.
> pthread_cancel (th=1719432289) at pthread_cancel.c:35
> 35      pthread_cancel.c: No such file or directory.
>         in pthread_cancel.c
> Current language:  auto
> The current source language is "auto; currently c".
> (gdb) bt
> #0  pthread_cancel (th=1719432289) at pthread_cancel.c:35
> #1  0x00007ffff4579a94 in rt_task_delete () from /usr/lib/libnative.so.3
> #2  0x00007ffff766e270 in RTT::os::rtos_task_delete_main
> (main_task=0x82ab90) at
> /home/kaltan/src/git/orocos-rtt/src/os/xenomai/fosi_internal.cpp:165
> #3  0x00007ffff7669d1d in ~MainThread (this=0x82ab80, __in_chrg=<value
> optimized out>) at
> /home/kaltan/src/git/orocos-rtt/src/os/MainThread.cpp:55
> 
> 
> Maybe related, I also get 'bogus' segfaults in relaxed native task
> threads when using the CORBA TAO library. Sometimes a 'throw'
> statement causes a segv, sometimes something else causes it.
> Identically same code running in plain gnulinux is not a problem, the
> code is clearly correct. Also not a problem in 2.4.10, but I can't
> currently (when writing this email) reproduce it. I keep you posted
> for this.
> 
> I had these problems first in virtual machines (Sun VBox), but I could
> reproduce them on the host too. Please tell me so if I should refrain
> from testing in a VM guest.

As usual: could you produce a simple test case which exhibits this
behaviour? Please also be careful with stacks sizes (though the head
branch should contain fixes for too small PTHREAD_STACK_MIN).

Please try and enable all Xenomai debug options.

Also, arm has an option which allows to show the kernel stack trace at
the point where the SIGSEGV signal is sent, this may help, maybe your
architecture has this too?

-- 
                                          Gilles


