From: Wolfgang Denk <wd@denx.de>
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <1353678609-9730-4-git-send-email-stefan.roese@gmail.com>
References: <1353678609-9730-1-git-send-email-stefan.roese@gmail.com>
	<1353678609-9730-4-git-send-email-stefan.roese@gmail.com>
Date: Fri, 23 Nov 2012 21:19:15 +0100
Message-Id: <20121123201915.358C620027E@gemini.denx.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [PATCH v3 3/3] mpc5200: Add demo RTDM FPGA DMA based
	device driver
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

In message <1353678609-9730-4-git-send-email-stefan.roese@gmail.com> you =
wrote:
>=20
...
> +/*
> + * CONFIG_XENO_DRIVERS_MPC5200_DMA_DEBUG:
> + *
> + * Define to print debug informations. Should be disabled in the
> + * final driver of course.
> + */
> +
> +#ifdef CONFIG_XENO_DRIVERS_MPC5200_DMA_DEBUG
> +#define dbg(format, arg...)						\
> +	printk("%s (%d): " format, __func__, __LINE__, ##arg)
> +#else
> +#define dbg(format, arg...)						\
> +do {									\
> +	if (0)								\
> +		printk("%s (%d): " format, __func__, __LINE__, ##arg);	\
> +} while (0)
> +#endif

Your change log said: "Removed dbg macro and used existing kernel
debug function".

What about this, then?

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Conceptual integrity in turn dictates that the  design  must  proceed
from  one  mind,  or  from  a  very small number of agreeing resonant
minds.               - Frederick Brooks Jr., "The Mythical Man Month"

