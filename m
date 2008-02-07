Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 7 Feb 2008 08:21:45 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D3769E7@domain.hid>
In-Reply-To: <2ff1a98a0802070720m35614f33p352bab27380fb93e@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D3769D5@domain.hid>
	<2ff1a98a0802070043n7c78e397i9345f3de1229f6bf@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D3769DF@slcmail.slc.mew.int>
	<DD39B5C3F4963040ADC9768BE7E430CB02AF4D89@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D3769E1@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB02AF4DB5@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D3769E5@domain.hid>
	<2ff1a98a0802070720m35614f33p352bab27380fb93e@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] SIGTRAP
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

I thought search-prefix did this, and that's what I have in that
command.

Steven


> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Thursday, February 07, 2008 8:21 AM
> To: Steven Seeger
> Cc: Daniel Schnell; xenomai@xenomai.org
> Subject: Re: [Xenomai-help] SIGTRAP
>=20
> On Feb 7, 2008 4:18 PM, Steven Seeger
> <sseeger@domain.hid> wrote:
> > Thanks for the advice. I think I have this stuff set up correctly,
but I
> > am not really sure what solib-absolute-prefix does so mine is set to
> > /dev/null. :)
>=20
> solib-absolute-prefix should point to where the unstripped libraries,
> matching those running on the target, are available. This allows gdb
> to debug the libraries.
>=20
> --
>                                                Gilles Chanteperdrix

