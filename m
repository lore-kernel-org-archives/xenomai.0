From: Dirk Roloff <roloff@domain.hid>
Subject: Re: [Adeos-main] interrupt latency
Date: Mon, 23 Feb 2004 03:22:13 +0100
References: <200402230035.16494.roloff@domain.hid>
	<1077493972.18998.2.camel@domain.hid>
In-Reply-To: <1077493972.18998.2.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402230322.13218.roloff@domain.hid>
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Am Montag, 23. Februar 2004 00:52 schrieb Philippe Gerum:
> On Mon, 2004-02-23 at 00:35, Dirk Roloff wrote:
> > Hi List,
> >
> > I ve got the following problem:
> >
> > I have to write a driver for linux for a receiver-board.
--- schnipp ---- 
>
> It would be interesting to know the flags passed to
> adeos_virtualize_irq(). In any case, either the 4th arg should pass
> IPIPE_PASS_MASK, or you realtime_handler() routine should call
> adeos_propagate_irq(irq).
Philippe:

the exactly code is:
      if( 0 != adeos_virtualize_irq( irq[i], &rt_amcc_irq_handler, NULL, 
IPIPE_PASS_MASK | IPIPE_HANDLE_MASK) )

i want to handle and pass it down the pipe.

But i give propagate a try ... not realy better ... 
Now a second IRQ 4 will be delivert to the linux handler.
Only one IRQ 1 to the realtime (its masked out in PIC  when entering the 
realtime)
Could it be that this will block all other IRQ at PIC level ?

Dirk.




