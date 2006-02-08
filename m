From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] RTDM mmap alternative
Date: Wed, 8 Feb 2006 10:43:47 -0200
References: <20060203192739.87567.qmail@domain.hid>
	<200602061900.35411.lbocseg@domain.hid>
	<43E8DB10.5000901@domain.hid>
In-Reply-To: <43E8DB10.5000901@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200602081043.47859.lbocseg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

>...
>I tested it (after figuring out what to do at all, and how to get it
>working then...) with a simple demo that returns a shared kernel memory
>block, mapped into user-space via an RTDM-IOCTL. I think you should
>easily (now really!) adapt it to your needs. Please check if this
>functions meets your requirements and works for more than one scenario.
>If so, I will add it to official RTDM.
>
>
>@all: I would be curious to hear any comment on my /dev/zero-trick to
>invoke mmap in kernel-space. Is this an ugly hack or may it be worth
>considering to apply on /dev/rtheap as well - to overcome the need for
>this device (and related user errors...)?

Jan, actually I didn't like the /dev/zero hack. If someone else is=20
using /dev/zero it will result in a problem... I think it would be better t=
o=20
reserve a separate file descriptor for mmaping. Maybe in a separate module =

like xeno_mmap that only register a, say, /dev/xenommap or /dev/xenomai/mma=
p.=20
I think it would be a better approach. Or maybe something like=20

void *rtdm_mmap_to_user(void *buffer, size_t length, char *dev_to_use)

Just some ideas...

Rodrigo.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


