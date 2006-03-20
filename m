From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
Date: Mon, 20 Mar 2006 16:27:54 -0300
References: <44172B67.2000609@domain.hid> <200603201142.27591.lbocseg@domain.hid>
	<441EDD9B.20708@domain.hid>
In-Reply-To: <441EDD9B.20708@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200603201627.54738.lbocseg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Em Segunda 20 Mar=3DE7o 2006 13:51, Philippe Gerum escreveu:

>...
>I think that you should try convincing Jan that rtdm_clock_tsc() might
>be a good idea to provide, instead of tweaking rtdm_clock_read() in a
>way which changes its underlying logic. ;o)

Yes, that is exactly what I want! :)
I don't see any reason for changing rtdm_timer_read() neither. I think that=
=3D
=3D20
the most common usage of high-precision timestamps is for relative time=3D20
cases. It doesn't need to be in sync with Xenomai's timer... It is best to=
=3D
=3D20
keep things simple.

What do you think Jan?

P.S: Sorry for the last message, Philippe. I didn't see that one at the tim=
=3D
e.

	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


