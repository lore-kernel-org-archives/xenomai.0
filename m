Date: Sat, 26 Aug 2006 23:38:22 +0200
From: Bernhard Walle <Bernhard.Walle@domain.hid>
Subject: Re: [Xenomai-help] Re: Timer problems?
Message-ID: <20060826213822.GH22004@domain.hid>
References: <1903864415@domain.hid> <1154964748.4322.31.camel@domain.hid>
	<44EF17E8.5040606@domain.hid>
	<slrneeuefr.v1d.Bernhard.Walle@domain.hid>
	<44F0BBB7.7030703@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <44F0BBB7.7030703@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


--vGgW1X5XWziG23Ko
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Steve,

* Steve Kreyer <steve.kreyer@domain.hid> [2006-08-26 23:23]:
> Bernhard Walle wrote:
> >
> >first of all: you replied to a previous mail which results in a broken
> >thread three in the mail client ... Pleaes create new mail for new
> >requests.
> >The example you've provided exits immediately here because you don't
> >wait in the main() function.
>
> Yes, Iam aware of this, but in fact the waiting via pause or sleep
> in the Linux process (main function) failed and results in a system
> lock up.

Ah, now I understand. :)

> >I modified your example to work:
> >http://pastie.caboo.se/10259
> [...]
> >No problem here, for example I call sleep(2) in the RT thread and it
> >work.=20
> [...]
> >Calling Linux functions in RT code should work in Xenomai,
> >although it's not hard realtime safe any more because the thread gets
> >switched to the Linux scheduler.
>
> *The reason of my request was to figure out why any of the standard
> linux functions (e.g. pause, sleep,..., whether called from the
> linux or RT task) results in a system lock up and why the  functions
> rt_task_wait and rt_task_sleep, for example, produce the error
> behaviour described in the first mail.
>=20
> So I think of an timer issue, or a wrong xenomai configuration or
> something like this, but can't really figure out the problem...

Well, this is something I also don't know. But I'm sure that Jan or
Philippe can help -- they're the experts here. :)

The only thing I could offer is my kernel .config which is attached.

> >Just for comparison:
> >I'm running Xenomai 2.1 with Kernel 2.6.15.7 on Debian 3.1.
>
> Iam running Xenomai version 2.2 and Kernel 2.6.15 on a kanotix system.

Maybe try 2.1 with my kernel configuration to figure out if it's a
strange hardware "bug" or something in the configuration or a bad
combination of kernel/patch/Xenomai.

I had some similar problem with RTAI, but less problematic, the system
was only frozen when issuing a rt_printk() from LXRT (userspace). The
solution was to update the kernel.

I use a 500 MHz P III, don't know how old, it's from my employer. :)


Regards,
  Bernhard
--=20
Die Freiheit des Menschen liegt nicht darin, dass er tun kann, was er will,=
=20
sondern dass er nicht tun muss, was er nicht will.
	-- Jean-Jacques Rousseau

--5mCyUwZo2JvN/JJP
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="config-2.6.15.7-xenomainodebug.gz"
Content-Transfer-Encoding: base64

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
VhJdAAA=

--5mCyUwZo2JvN/JJP--

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBRPC/SOiVHo+2lFT9AQKwsQP/bUr5WtWBBg8G9nnP4Vz0IOBobtE/UUhU
GrzqZBt6Oue34iYTlxFL8bePA8nlcmdo5h7jYB3tLWd+yMte5q4Y63fjBMh/2E/d
JXPVXo+Ylhn1+x6lB6VchGAWFo7DKzWnaPcfv3ois0K1PUNk+1f7nyyr3hpVJBcp
//rUw2aDAOM=
=GTB9
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--

