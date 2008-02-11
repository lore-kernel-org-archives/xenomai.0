Message-ID: <47B0AC03.9050403@domain.hid>
Date: Mon, 11 Feb 2008 21:11:47 +0100
From: Philippe Gerum <philippe.gerum@domain.hid>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D376AD7@domain.hid>	<47B053A2.9010503@domain.hid>	<51CAD0CE1504444DBE77CBBE51A0135D376ADB@slcmail.slc.mew.int>	<2ff1a98a0802110810r297a639ej5a061b823a4d551d@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376AED@slcmail.slc.mew.int>
	<47B09B10.5090200@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376AF6@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D376AF6@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] overhead
Reply-To: philippe.gerum@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
>> Send those backtraces, please, and a disassembly of your running
> kernel
>> privately to me.
> 
> I don't have the backtraces because they'd occur and the system would
> freeze. I wasn't using serial console because my application uses both
> serial ports. I even noticed ipipe_ calls and 16554_ serial calls in the
> same backtrace.
> 
> Next time one occurs, I will be sure to post it.
> 

At least the topmost four/five lines would help. You will find
__ipipe_handle_irq within the call frame each time an interrupt is
taken, so you need to focus on which handler gets actually called. In
the case above, it seems a serial interrupt is involved, and what its
handler does might be the root of the issue.

>> Sorry, I just don't understand where the problem is, or maybe I did
> not
>> understand what you are exactly doing/expecting here.
> 
> I wanted to be warned if my main state thread ever went to secondary
> domain, so I used T_WARNSW. However, I posted this condition wrong. The
> SIGXCPU is caused by my calling assert() because my state thread had an
> overrun, which it should not have. The system is doing nothing at this
> point, but calling pthread_create() in a shadowed thread causes an
> overrun. The shadowed thread is priority 1, and the state thread is
> priority 50. The state thread runs at 100Hz so this should not be too
> bad on the system.
>

Creating threads should be kept out of real-time duties, it's just
unsafe in terms of latency (Btw, I hope you do reduce the default glibc
stacksize from 8Mb to something more sensible in a real-time application
context, given that mlockall is in effect).

>> If you actually take faults on behalf of the tick timer handler, then
> no
>> wonder why the CPU figures explode.
> 
> I don't understand what you mean here?
> 

ipipe_handle_irq will be present in every call frame on behalf of an
external or virtual interrupt context, therefore if you get a fault in
the interrupt handler like you reported lately, the time spent in the
fault recovery code will be charged to the interrupt context.

>> Older versions, or older kernels?
> 
> Xenomai 2.2 era. I think I used 2.6.18 or something. It was a long time
> ago.
> Steven
> 
> 


-- 
Philippe.

