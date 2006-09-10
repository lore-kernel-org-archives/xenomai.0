Sender: dv@domain.hid
Message-ID: <4503D322.1E88D034@domain.hid>
Date: Sun, 10 Sep 2006 10:56:02 +0200
From: Detlef Vollmann <dv@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai on PXA
References: <200607071703.10700.vagninu@domain.hid>
	<17582.50372.830923.414981@domain.hid>
	<44B34343.9F56F13@domain.hid>
	<17595.47131.142881.132531@domain.hid>
	<1153153788.11603.2.camel@domain.hid>
	<17595.49478.157044.654500@domain.hid>
	<1154334859.9569.12.camel@domain.hid>
	<44CDCB61.2DEDCBFF@vollmann.ch>
	<1154342029.9569.27.camel@domain.hid>
	<44CDE4C2.77465253@domain.hid>
	<17616.42011.663899.554796@domain.hid>
	<1154525585.9559.22.camel@domain.hid>
	<17616.59841.283196.201008@domain.hid>
	<1154596354.9835.28.camel@domain.hid>
	<17617.63387.138316.343123@domain.hid>
	<1154617014.5010.29.camel@domain.hid>
	<17618.12042.631648.702921@domain.hid>
	<1154703176.9602.26.camel@domain.hid>
	<17631.9753.589322.882530@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hello,

Gilles Chanteperdrix wrote:
> Attached a new version of the patch (including the patch for the __xchg
> operation, so that this patch can be applied incrementally after the
> official I-pipe patch) which should be more greedy when demultiplexing
> the GPIO interrupt.
Thanks, great.
Finally I came around to test it.

There is one small typo in it:

> diff -Naurdp -x '*~' -x '*.orig' -x '*.rej' linux-2.6.16.5-tcl1-ipipe-ref/arch/arm/mach-pxa/irq.c linux-2.6.16.5-tcl1-ipipe/arch/arm/mach-pxa/irq.c
> --- linux-2.6.16.5-tcl1-ipipe-ref/arch/arm/mach-pxa/irq.c       2005-10-28 02:02:08.000000000 +0200
> +++ linux-2.6.16.5-tcl1-ipipe/arch/arm/mach-pxa/irq.c   2006-08-13 14:31:28.000000000 +0200
> @@ -214,6 +215,42 @@ static void pxa_gpio_demux_handler(unsig
[...]
> +               for (; i; i--) {
> +                       loop ||= mask[i - 1];
This should be:
                       loop |= mask[i - 1];

With that change, first tests look fine.
BTW, on the SA, what results do you get from xeno-test?

 Detlef

-- 
Detlef Vollmann   vollmann engineering gmbh
Linux and C++ for Embedded Systems    http://www.vollmann.ch/
Linux for PXA270 Colibri module: http://www.vollmann.ch/en/colibri/

