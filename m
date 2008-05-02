Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 2 May 2008 07:17:36 -0700
Message-ID: <6B8F1229FFBDCA47BA5C9712C46F18DF493016@domain.hid>
In-Reply-To: <481AC93E.3030107@domain.hid>
References: <481AA6B5.9070508@domain.hid> <481AC93E.3030107@domain.hid>
From: "Thomas Schaefer" <thomass@domain.hid>
Subject: Re: [Xenomai-help] MSI Interrupt Crash
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org, Jeff Koftinoff <jeffk@domain.hid>
Cc: xenomai@xenomai.org



>=20
> Does this help?
>=20
> --- include/asm-x86/wrappers_64.h	(revision 3719)
> +++ include/asm-x86/wrappers_64.h	(revision 3720)
> @@ -31,8 +31,8 @@
>  #define rthal_irq_descp(irq)		(irq_desc + irq)
>  #define rthal_irq_desc_status(irq)	(rthal_irq_descp(irq)->status)
>=20
> -#define rthal_irq_chip_enable(irq)   ({ rthal_irq_descp(irq)->chip-
> >enable(irq); 0; })
> -#define rthal_irq_chip_disable(irq)  ({ rthal_irq_descp(irq)->chip-
> >disable(irq); 0; })
> +#define rthal_irq_chip_enable(irq)   ({ rthal_irq_descp(irq)->chip-
> >unmask(irq); 0; })
> +#define rthal_irq_chip_disable(irq)  ({ rthal_irq_descp(irq)->chip-
> >mask(irq); 0; })
>  #define rthal_irq_chip_end(irq)      ({ rthal_irq_descp(irq)-
> >ipipe_end(irq, rthal_irq_descp(irq));
> 0; })
>=20
>  typedef irq_handler_t rthal_irq_host_handler_t;

We are using the current version from the SVN repository and those
changes are already in there.

Thomas

>=20
> --
> Philippe.
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

CONFIDENTIALITY NOTICE:  This electronic mail message and any attachment he=
reto may contain confidential information of Meyer Sound Laboratories, Inco=
rporated and is intended for the personal and confidential use of the desig=
nated recipient(s) only.  If you are not the intended recipient (or respons=
ible for delivering the message to the intended recipient), you have receiv=
ed this message in error and any review, distribution, or copying of this m=
essage or any attachment hereto is prohibited.  If you have received this m=
essage in error, please promptly notify the sender and permanently delete i=
t from your computer.

