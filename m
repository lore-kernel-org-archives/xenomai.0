From: Roberto Bucher <roberto.bucher@domain.hid>
Date: Mon, 15 Dec 2008 19:19:10 +0100
References: <200812090832.43063.roberto.bucher@domain.hid>
	<200812140905.08103.roberto.bucher@domain.hid>
	<49468ED1.3030504@domain.hid>
In-Reply-To: <49468ED1.3030504@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812151919.10849.roberto.bucher@domain.hid>
Subject: Re: [Adeos-main] Problems with last adeos patches
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

I've unchecked the CONFIG_MTRR flag in kernel, but the behaviour is exactly the 
same (scilab->freeze)

Roberto

On Monday 15 December 2008 18:07:29 Jan Kiszka wrote:
> Roberto Bucher wrote:
> > I installed a new machine with Dual Core processor, but with the same
> > chipset as the working centrino mono processor machine (which has been
> > working fine for a week with kernel 2.6.27.8+patch), and this PC freezes
> > exactly like the other dual core laptop.
> >
> > It seems that the problem happens only on system with CPU>1.
>
> I'm currently reviewing the x86 2.6.27 patch /wrt to potential SMP
> issues. One thing I came across is our old friend, the MTRR subsystem.
> There are a few local_irq_disable_hw spots, some are even
> local_irq_disable_full, but others are still plain vanilla, and I'm not
> 100% sure that this is correct. I will check this carefully, probably
> coming up with some correction patch.
>
> In the meantime, could you check if disabling CONFIG_MTRR changes the
> picture you (or anyone else with a similar problem)?
>
> TiA,
> Jan

-- 
University of Applied Sciences of Southern Switzerland
Dept. Innovative Technologies
CH-6928 Lugano-Manno
http://web.dti.supsi.ch/~bucher

