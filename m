From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17289.65337.283547.623504@domain.hid>
Date: Sun, 27 Nov 2005 19:47:21 +0100
Subject: Re: [Xenomai-help] Interrupt processing crashes in semTake
In-Reply-To: <001f01c5f1a6$cffd8250$1000000a@domain.hid>
References: <001f01c5f1a6$cffd8250$1000000a@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Hans-J. Ude" <ude@domain.hid>
Cc: Xenomai-help@domain.hid

Hans-J. Ude wrote:
 > I'm porting an vxWorks application to Xenomai at the moment. When it comes
 > to interrupt handling, there is nothing in the vx skin to handle that (did i
 > overlook something?). 

Would an implementation of intConnect be enough ? With vectors and
interrupts being the same thing (IVEC_TO_INUM and INUM_TO_IVEC would not
change anything).

 > First I've tried to handle that down in the xenomai
 > layer but problems occured and someone advised me to use a native interrupt
 > task using rt_intr_wait. I did so but the program segfaults after a minute
 > or so. I've put a sigsegv handler with a stack backtrace function into the
 > code. That shows the crash happens in the internals of semTake. Is it
 > problematic to make skin calls (semGive in my case) from inside the native
 > irq handler? Is there a bug somewhere in UVM or the test program or settings
 > or in other words: how are interrups handled properly from the vxWorks skin?
 > 
 > I've tracked the problem down to a test program which is appended to this
 > mail. I set up the irq number by #define to the irq of my network card. Then
 > made traffic by copying a large amount of files to the target system. After
 > about 30000 interrupts the crash happens most times but this value ranges
 > from about 1000 to 50000.

I have just tried your test program and it appears to work. But I had to
fix the various function prototypes (vxWorks thread functions take 10
int arguments, and irq_server is void). Add -W -Wstrict-prototypes to
your compilation flags, and you will get the warnings.

Appart from that, the "wrong context" issue does not seem to be a
real issue, since irq_server is a valid thread context. But fixing
wind_errnoset was needed anyway.

I did not get any crash, but used the disk IRQ (only 150 interrupts by
second or so, worse than the timer...), running a recursive ls about 10
minutes.

So, I am afraid you will have to dig a bit deeper 
 > 
 > No clue what could be wrong. I'm using kernel 2.6.13 and xenomai 2.0.1 with
 > the included ipipe patch on a PIImmx running at 266 Mhz.
 > 
 > The backtrace function is the only debugging function i have since remote
 > debugging with gdb/gdbserver is still not working properly, but i'm gonna
 > describe that in detail in anorter post. Here comes the program:

note that at the end of sigsegv_handler, after having restored the
default signal handler, you should raise SIGSEGV again so that the
normal processing may be done (otherwise, the program retries the
same operation and SEGV again, but who knows ?). And if you do not want
to have to bother about doing all that stuff, the program "catchsegv" is
your friend.

-- 


					    Gilles Chanteperdrix.

