Message-ID: <b054e88e0711130323t6e68d1fbs113fdff7e2359cd@domain.hid>
Date: Tue, 13 Nov 2007 12:23:18 +0100
From: "Giammarco Zacheo" <g.zacheo@domain.hid>
In-Reply-To: <4739628F.8000100@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b054e88e0711090616r6376a8a6t81e9bc94b4290dea@domain.hid>
	<473471FB.9010305@domain.hid> <4734736D.7060100@domain.hid>
	<b054e88e0711090652h176ef99dx740a5c0deb333829@domain.hid>
	<4734755F.2010301@domain.hid> <47347593.3040605@domain.hid>
	<b054e88e0711090747m315c1ecdsa998c41653737046@domain.hid>
	<47348393.5030202@domain.hid>
	<b054e88e0711091028v76750ff0jcf3b20aa12317d69@domain.hid>
	<4739628F.8000100@domain.hid>
Subject: Re: [Xenomai-help] Kernel oops while trying first boot w/ Xenomai
	2.4rc5
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main@gna.org

Hi Jan,
the patch works fine, the kernel boots with no problem. Thank you very much.

I am going to make some tests in the afternoon, but right now I tried
to start xeno-test - it hanged halfway.

I will report later the problem with more details.

Keep up with the excellent work! :-)

Giammarco


On Nov 13, 2007 9:38 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Hi Giammarco,
>
> Giammarco Zacheo wrote:
> > Ok, I hope this is what you asked for...
> >
> > I added printk in mask_ack_irq. Look at mask_ack_irq--> in the text
> > below, those are the addresses of the function pointers.
> > the printk related to mask_ack is printed once at the first pass in
> > the function, otherwise the kernel would be choked by the output.
>
> Yep, this pointed to the right spot. I still don't get why we didn't
> stumble over this earlier (obviously, most x86_64 boxes take a different
> code path here), but it is at least clear now what went wrong:
>
> I-pipe ran into one of the remaining non-genirq code paths on x86_64.
> More precisely, the IRQ chip of timer interrupt was changed from 8259 to
> APIC without going through the generic API so that I-pipe was still
> using the old ack handler, stepping later on the missing mask and
> mack_ack handler.
>
> This patch now updates irq_chip.ipipe_ack when it changes for IRQ0. This
> is a temporary fix, I guess kernel people will refactor io_apic_*.c into
> a shared variant soon, overcoming this "minor" variation between i386
> and x86_64...
>
> Please let us know if this helps!
>
> Jan
>

