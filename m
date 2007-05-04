Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 4 May 2007 13:34:41 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01E44028@domain.hid>
In-Reply-To: <463B33BC.5020408@domain.hid>
References: <7289437c0705040615n2272cf83oeec8db0a7dda910c@domain.hid>
	<463B33BC.5020408@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: Re: [Xenomai-help] Problem to compile for ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai@xenomai.org

Or you place somewhere before the linker option

-Wl,--start-group

to tell the linker to iterate several times over the library =
interdependencies.

Even if gcc doc says different, you actually do not need a =
-Wl,--end-group option.



Best regards,

Daniel Schnell.
=20


-----Original Message-----
From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] =
On Behalf Of Gilles Chanteperdrix
Sent: 4. ma=ED 2007 13:23
To: Perrine Martignoni
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Problem to compile for ARM

Perrine Martignoni wrote:
> Hello,
> =20
> I have some problems to compile my code Posix for ARM. I have=20
> installed xenomai in /usr/xenomai_arm-2.3.1 for ARM.
> =20
> Here is my compilation :
> (...)
> -L/usr/xenomai_arm-2.3.1/lib -lpthread_rt -lpthread -lrt =20
> essai_mutex_rt.o   -o essai_mutex_rt

The order of arguments on the linker command line is important, this =
should be:

essai_mutex_rt.o -lpthread_rt -lpthread -lrt

--=20
                                                 Gilles Chanteperdrix

_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help

