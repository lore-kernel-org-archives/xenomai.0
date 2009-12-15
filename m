From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <784.75506.qm@domain.hid>
References: <784.75506.qm@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 15 Dec 2009 16:12:38 +0100
Message-ID: <1260889958.2216.152.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Porting Adeos-Ipipe on AVR32 (NGW 100),
 enable_pipeline.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: A C <adrien_chiron@domain.hid>
Cc: adeos <adeos-main@gna.org>

On Tue, 2009-12-15 at 14:42 +0000, A C wrote:
> Hello,
> We are trying to implement the function enable_pipeline. 
> 
> For the NIOS2 architecture in this fonction there are calls to the
> functions __ipipe_init_hrclock(), __ipipe_init_hrtimer(). So we
> checked those functions and we understand what they do. But there are
> still two questions :
> - Where can we find the physical adresses of the clock (timer 64 bits)
> (named "na_hrclock") and of the timer (timer 32 bits) (named
> "na_hrtimer) ? We don't find the declaration.

You don't care about those declarations. Those are NIOS2 specific bits,
by definition. Besides, the NIOS2 is a  softcore, so those definitions
depend on the particular design that has been synthesized.

> 
> - Where is setting up the input clock frequency of the two timers
> (timer 64 bits and timer 32 bits)?
> 

In the NIOS2 case? Again, you don't care about this. What you do care
for is how you could get:

- a clock event source for the real-time domain
- a high precision monotonic clock to get precise timestamps

And you probably want to use what your board provides to this end, e.g.
using a freerunning timer to emulate the monotonic clock. It's possible
to use 16bit timers for that (some ARM platforms do), but that is
uselessly painful if you have better hw at hand.

How to set this up depends on your platform eventually, but you can't
copy/paste this from NIOS2 in any case.

> For the AVR32, we have at least  two 16-bit timers, we are thinking
> about to do the same functions (__ipipe_init_hrclock(),
> __ipipe_init_hrtimer()). We think we can also use the
> "ioremap_nocache" fonction. 

ioremap_nocache is just a helper to map a piece of memory having
side-effects in the kernel address space. You will have to resort to it
in case your platform provides MMIO to reach the (timer) devices. But
that is only a gory detail.

> 
> Regards
> 
> Adrien Chiron and Vincent Vanbesien
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 
Philippe.



