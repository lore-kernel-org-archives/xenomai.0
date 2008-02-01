Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 1 Feb 2008 08:51:06 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D376871@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB02AAE515@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D37686A@slcmail.slc.mew.int>
	<DD39B5C3F4963040ADC9768BE7E430CB02AAE515@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] 125 us periodic timer high interrupt cpu usage
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>, xenomai@xenomai.org

As I stated before, I never noticed this CPU usage when I used RTAI.
Perhaps it simply wasn't being reported. However, I do notice that if I
start the timer but don't load any tasks, the IRQ is reporting CPU usage
of about 1.2%. When I load two tasks that do nothing but block (state is
00000082) the IRQ handler usage jumps to almost 8%.

Steven

> -----Original Message-----
> From: Daniel Schnell [mailto:daniel.schnell@domain.hid]
> Sent: Friday, February 01, 2008 8:47 AM
> To: Steven Seeger; xenomai@xenomai.org
> Subject: RE: [Xenomai-help] 125 us periodic timer high interrupt cpu
usage
>=20
> Well,
>=20
> 8000 interrupts/second costs you something.
>=20
> Daniel Schnell
>=20

