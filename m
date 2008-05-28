Message-ID: <2ff1a98a0805280101q4e1cc3d9oe73b3de64316f07b@domain.hid>
Date: Wed, 28 May 2008 10:01:13 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <483D0AB7.4010303@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <483D0AB7.4010303@domain.hid>
Subject: Re: [Xenomai-help] valgrind
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Wed, May 28, 2008 at 9:33 AM, St=E9phane ANCELOT <sancelot@domain.hid> wrot=
e:
> Hi,
> I tried xenomai integration in valgrind .
>
> I have got some problems with __native_muxid  .
>
> Is there an easy way to retrieve this value (is it a const?) or is it a
> variable I have to store and reuse ?

The muxid is returned by the "xn_sys_bind" system skin syscall. So,
you have to get it at run-time.

--=20
 Gilles

