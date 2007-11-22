Message-ID: <2ff1a98a0711220800u67dd21d4l811c721ff8e377b8@domain.hid>
Date: Thu, 22 Nov 2007 17:00:37 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2ff1a98a0711220647p48f9627avc2b260873a0c6711@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <1806495015@domain.hid>
	<2ff1a98a0711220647p48f9627avc2b260873a0c6711@domain.hid>
Subject: Re: [Xenomai-help] boot hang up with lapic
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Vogt <A_C_V@web.de>
Cc: xenomai@xenomai.org

On Nov 22, 2007 3:47 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Nov 22, 2007 3:32 PM, Andreas Vogt <A_C_V@web.de> wrote:
> > > -----Urspr=FCngliche Nachricht-----
> > > Von: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> > > Gesendet: 22.11.07 15:27:42
> > > An: "Andreas Vogt" <A_C_V@web.de>
> > >
> > > Please post your .config so that we can try and reproduce this hang u=
p.
>
> Please disable CONFIG_APM, CONFIG_ACPI_PROCESSOR and CONFIG_CPU_FREQ

You should disable CONFIG_X86_GENERIC as well, it was reported, at
least once in the past, as problematic.


--=20
                                               Gilles Chanteperdrix

