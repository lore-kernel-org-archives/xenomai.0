From: Wolfgang Denk <wd@denx.de>
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <1353481805-28850-1-git-send-email-stefan.roese@gmail.com>
References: <1353481805-28850-1-git-send-email-stefan.roese@gmail.com>
Date: Wed, 21 Nov 2012 10:09:13 +0100
Message-Id: <20121121090913.B53842003CF@gemini.denx.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [PATCH v2] mpc5200: Add RTDM LPBFIFO driver and demo
	RTDM FPGA device driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: stefan.roese@gmail.com
Cc: Stefan Roese <sr@denx.de>, xenomai@xenomai.org

Dear Stefan,

In message <1353481805-28850-1-git-send-email-stefan.roese@gmail.com> you=
 wrote:
>=20
> This patch adds support for the RTDM LPB (LocalPlusBus) FIFO driver
> for the MPC5200. It will be used for DMA support in an RTDM FPGA
> device driver. This rt-fpga.c driver is a custom device driver,
> but might be useful for other developers as well. Thats why I
> included it here too.
...
> --- /dev/null
> +++ b/ksrc/drivers/mpc5200_dma/Config.in
> @@ -0,0 +1,10 @@
> +#
> +# Xenomai configuration for Linux v2.4

Linux v2.4 ???=20

I am pretty sure this driver will not run with a 2.4 Linux kenrel...

> +#define dbg(format, arg...)						\
> +	printk("%s (%d): " format, __func__, __LINE__, ##arg)
> +#else
> +#define dbg(format, arg...)						\
> +do {									\
> +	if (0)								\
> +		printk("%s (%d): " format, __func__, __LINE__, ##arg);	\
> +} while (0)
> +#endif

Why do you define your own (incomaptible to everything else) debug
facilities?  Can you not rather use the existing kernel debug
macros?

> +#ifdef PRINT_READ_TIME

I see no translation happening anywhere between PRINT_READ_TIME and
CONFIG_XENO_DRIVERS_MPC5200_DMA_PRINT_READ_TIME - am I missing
something?

> +#ifdef NO_DMA

Ditto for NO_DMA versus CONFIG_XENO_DRIVERS_MPC5200_DMA_NO_DMA ?

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Evil does seek to maintain power by suppressing the truth."
"Or by misleading the innocent."
	-- Spock and McCoy, "And The Children Shall Lead",
	   stardate 5029.5.

