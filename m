Message-ID: <43C6B23B.6030503@domain.hid>
Date: Thu, 12 Jan 2006 16:47:07 -0300
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] PCI Framegrabber real-time driver
References: <200601111655.57020.lbocseg@domain.hid>	<43C56124.4040407@domain.hid>	<200601111921.05544.lbocseg@domain.hid>
	<17349.34151.559777.835174@domain.hid>
In-Reply-To: <17349.34151.559777.835174@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
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

Gilles Chanteperdrix escreveu:

>Rodrigo Rosenfeld Rosas wrote:
> > The memory is obtained passing the kernel the parameter "mem=3D510M". S=
o, the=20
> > kernel won't use the last 2 Mb. I know it is not an elegant solution bu=
t it's=20
> > pretty simple and I can't imagine another one...
>
>Another one, suggested in "Linux devices drivers", chapter 8, is to
>allocate your memory at boot time with one of the alloc_bootmem
>functions. Of course, in order to call these functions, a small part of
>your driver need to run in the kernel itself.
>
>For more details, see:
>http://lwn.net/Kernel/LDD3/
> =20
>
Yes, I knew about that, but the it was not an option at the time. I can=20
not show the source code of the driver due to a contract or else I=20
wouldn't have the specifications. So, if I need to use the driver in=20
other places I will have to build a module and distribute only the=20
module. I'm still thinking in other solutions but it is easier to ask=20
the user to pass the kernel the mem parameter...

But thank you anyway!

Rodrigo.


=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



