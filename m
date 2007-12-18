Message-ID: <2ff1a98a0712180155s44971de9p61e8487e47a7f54@domain.hid>
Date: Tue, 18 Dec 2007 10:55:15 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <5a4b7020712172253j164dae33wbe0ee9a85eb89d7e@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a4b7020712172253j164dae33wbe0ee9a85eb89d7e@domain.hid>
Subject: Re: [Xenomai-help] Could somebody tell me what does I_AUTOENA mean
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jie zhang <xenomai.rtai@domain.hid>
Cc: xenomai@xenomai.org

On Dec 18, 2007 7:53 AM, jie zhang <xenomai.rtai@domain.hid> wrote:
> Hi,
> Could somebody tell me what does I_AUTOENA mean in rt_intr_create() API, I
> only want to create an interrupt object with this API, but it seems the
>
> I_AUTOENA confused me a lot.
>
> Thans for your attention

rt_intr_create flag is I_NOAUTOENA and is documented here:
http://www.xenomai.org/documentation/trunk/html/api/group__interrupt.html#g92fa8e83f6f3db05dd1d2d075dd310ee
to mean: "asks Xenomai not to re-enable the IRQ line before awakening
the interrupt server task. This flag is functionally equivalent as
always returning RT_INTR_NOENABLE from a kernel space interrupt
handler."

This option is probably useful if you want to implement something like
what the NAPI proposes for Linux network drivers, that is polling
hardware from a task instead of polling it in an interrupt handler.

-- 
                                               Gilles Chanteperdrix

