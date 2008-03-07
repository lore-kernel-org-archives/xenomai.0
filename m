Message-ID: <2ff1a98a0803070539i6cfa19a4t63e56e266fbfba71@domain.hid>
Date: Fri, 7 Mar 2008 14:39:40 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d3f72a390803070526r3867c800u9bfb40ac1eba705e@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d3f72a390803070526r3867c800u9bfb40ac1eba705e@domain.hid>
Subject: Re: [Xenomai-core] WIRED INTERRUPT
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: axel axel <softaxel@domain.hid>
Cc: xenomai@xenomai.org

On Fri, Mar 7, 2008 at 2:26 PM, axel axel <softaxel@domain.hid> wrote:
>
> Hi,
>
> i used the xenomai kernel side interrupt handler in this mode:
>
> err = rt_intr_create( &rtFujInt, INTFUJITSUNAME, IRQFUJITSU, isrIntFujitsu ,
> NULL, 0 );
> if ( err != 0 )
> {
>    printk( "Impossible to create interrupt handler: %d\n", err );
>     return 1;
> }
>
> STARTIRQ();
>
>
> I saw with the oscilloscope that there is a significant latency ( max ~110us
> on ARM ep9315 ) before executing the first instruction of the handler
> "isrIntFujitsu".
>  I listen that eventually i can use WIRED interrupt that is more fast.

Latency on ARM is pretty high, if you want lower interrupt latencies,
you should use Xenomai trunk, which has unlocked context switch. Not
also that if you use the old I-pipe patch for ep9315, user-space
context switches take place with hardware interrupts disabled as well.
So, if you want good latency figures, you should extract the ep93xx
specific part from your patch and run with a more recent patch.

-- 
 Gilles Chanteperdrix

