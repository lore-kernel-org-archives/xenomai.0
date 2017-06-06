References: <CAF06wtgV=DewshLh48CMNFy3J7SzBk06ToJjaQsXpF2+TkBqoA@mail.gmail.com>
 <6f55db98-0988-3b9f-f1dc-6f393211af4d@xenomai.org>
 <CAF06wtgMdvZ-K2yNMY6wZMSUa+ELdwBV=rbm7F1vAiLX57OyeQ@mail.gmail.com>
 <a977c731-91ce-e308-8676-1a1a82f7cf22@xenomai.org>
 <CAF06wtjLv+nTAyYv-BZCg51JbJEi+e-MWD7ZjZ-TG=K=kWDNcA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <1062b417-12fd-9eda-83bf-ab7c1eda4548@xenomai.org>
Date: Tue, 6 Jun 2017 09:41:52 +0200
MIME-Version: 1.0
In-Reply-To: <CAF06wtjLv+nTAyYv-BZCg51JbJEi+e-MWD7ZjZ-TG=K=kWDNcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Issues with Xenomai 3.0.5...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jlangston@panurgyinc.com
Cc: xenomai@xenomai.org

On 06/06/2017 04:12 AM, Jim Langston wrote:
> Philippe,
> 
> That worked well, thank you!
> 
> Now that my test applications are running, I wanted to be sure that
> everything was kosher.  If I run 'latency' or 'switchtest' and press
> CTRL+C to stop them, I get a seg fault.

Receiving SIGSEGV/SIGBUS/SIGILL is 100% abnormal. Can you send the stack
backtrace of such fault over gdb?

  Otherwise they seem to run
> normally, basically the same as my old 2.X Xenomai systems.
> 
> *gdb latency*
> 
> Thread 4 "sampling-1035" received signal SIGXCPU, CPU time limit exceeded.

This is a watchdog trigger (CONFIG_XENO_OPT_WATCHDOG) after 4s spent
running purely real-time stuff without leaving any cycles to the regular
kernel, which denotes a problem. On x86, the default real-time sampling
period for latency testing is 100 us, which may be a bit too fast for a
Geode LX. You may want to try latency -p 200 or higher.

Also, you should make sure to turn off any time consuming debug option
in kernel space, e.g. DEBUG_VM, DEBUG_LIST, XENO_OPT_DEBUG_LOCKING,
IPIPE_TRACE etc.

For actual latency testing, disabling debug in the user-space support
(--disable-debug) is better too, since this option has some overhead,
except --enable-debug=symbols, which only adds -g to the compilation
flags but keeps the optimizer enabled (-O2).

> 
> #0  0xb770c25d in __cobalt_read (fd=3, buf=0xb74373a8, nbyte=8) at
> rtdm.c:180
> #1  0x08049e60 in latency (cookie=0x0) at latency.c:165
> #2  0xb770d760 in cobalt_thread_trampoline (p=0xbfff47bc) at thread.c:166
> #3  0xb76bc5bc in start_thread () from /lib/libc.so.0
> #4  0xb7678ded in clone () from /lib/libc.so.0*
> 
> *
> *gdb switchtest
> *
> Thread 18 "rtuo_ufps-20" received signal SIG32, Real-time event 32.
> 
> #0  0xb7729f42 in do_ioctl (fd=fd@entry=3,
> request=request@entry=2148009525,
>     arg=arg@entry=0xb718d358) at rtdm.c:132
> #1  0xb772a204 in __cobalt_ioctl (fd=3, request=2148009525) at rtdm.c:167
> #2  0x0804b1a5 in rtuo (cookie=0x97bec30) at switchtest.c:654
> #3  0xb772b760 in cobalt_thread_trampoline (p=0xbfb88afc) at thread.c:166
> #4  0xb76da5bc in start_thread () from /lib/libc.so.0
> #5  0xb7696ded in clone () from /lib/libc.so.0*
> 
> *
> Is this normal, or do I need to do some more digging through my build
> environment?
> 

I can make sense of a Cobalt-based application receiving SIGXCPU and
SIGWINCH from the real-time core for internal purposes, but I don't have
any explanation for SIGRTMIN at the moment.

-- 
Philippe.

