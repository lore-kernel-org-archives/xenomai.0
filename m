Message-ID: <47D1447A.6060001@domain.hid>
Date: Fri, 07 Mar 2008 14:34:50 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <d3f72a390803070526r3867c800u9bfb40ac1eba705e@domain.hid>
In-Reply-To: <d3f72a390803070526r3867c800u9bfb40ac1eba705e@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] WIRED INTERRUPT
Reply-To: rpm@xenomai.org
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

axel axel wrote:
> 
> Hi,
> 
> i used the xenomai kernel side interrupt handler in this mode:
> 
> err = rt_intr_create( &rtFujInt, INTFUJITSUNAME, IRQFUJITSU,
> isrIntFujitsu , NULL, 0 );
> if ( err != 0 )
> {
>    printk( "Impossible to create interrupt handler: %d\n", err );
>    return 1;
> }
> 
> STARTIRQ();
> 
> 
> I saw with the oscilloscope that there is a significant latency ( max
> ~110us on ARM ep9315 ) before executing the first instruction of the
> handler "isrIntFujitsu".
> I listen that eventually i can use WIRED interrupt that is more fast.
> 
> How can i use it ?
>

All real-time interrupts are already dispatched in wired I-pipe mode.

> 
> Thanks for all
> 
> Roberto Bielli
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.

