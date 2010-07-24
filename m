Message-ID: <4C4B379F.9040107@domain.hid>
Date: Sat, 24 Jul 2010 20:57:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C43C83F.5030401@domain.hid>
	<4C43D265.9080609@domain.hid>	<4C43FC4F.3010006@domain.hid>
	<4C440D6F.1060204@domain.hid>	<4C44E9C9.3020600@domain.hid>
	<4C454C0C.6000100@domain.hid>	<4C4550C8.3070504@domain.hid>
	<4C45541C.5090507@domain.hid> <4C45CEE6.5000903@domain.hid>
	<4C460506.3010103@domain.hid> <4C46141F.50103@domain.hid>
	<4C468040.3030509@domain.hid> <4C468485.5060408@domain.hid>
	<4C47597F.1010406@domain.hid>
	<4C478313.2030606@domain.hid>
	<4C48C1BB.8080606@domain.hid> <4C48C2CE.1030706@domain.hid>
	<4C4A292F.5040900@domain.hid>
	<4C4ADFC6.1010900@domain.hid> <4C4B35F1.60103@domain.hid>
In-Reply-To: <4C4B35F1.60103@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Adeos patch prevents IRQ 384 (MMC Chip Detect)
 on omap-2.6.33
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Bob Feretich wrote:
>   Let me make sure I understand.
> The most recent report from me contained console logs of two boots.
> The first was 2.6.33 with no Adeos patch applied.
> The second was 2.6.33 with the Adeos patch and Xenomai enabled 
> (CONFIG_IPIPE=y) and CONFIG_XENOMAI=y).
> 
> You want me to perform to tests:
> 
>    1. 2.6.33 with the Adeos patch applied, but .config edited to turn
>       off CONFIG_IPIPE and CONFIG_XENOMAI.

That is, if when you tested the kernel patched with Adeos you never
turned CONFIG_IPIPE off.

>    2. Assuming test #1 passes the interrupts successfully, 2.6.33 with
>       the Adeos patch applied, CONFIG_IPIPE=y, CONFIG_XENOMAI off, and
>       revert the change to drivers/i2c/busses/i2c-omap.c.
> 
> Is that correct?

Yep.


-- 
					    Gilles.

