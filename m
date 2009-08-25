Message-ID: <4A939CE2.3080006@domain.hid>
Date: Tue, 25 Aug 2009 10:12:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <EB48F2CADC239E44A8598CC0B0571102E4A9BE@XVS-DCFR-21.europe.corp.altran.com>
	<4A8C23BE.8050904@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C2@domain.hid>
	<4A8E628C.8010001@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C4@domain.hid>
	<4A8F1E70.6090608@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C6@domain.hid>
	<4A925F27.4070104@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9C7@domain.hid>
In-Reply-To: <EB48F2CADC239E44A8598CC0B0571102E4A9C7@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] RE :  Native message queue and synchronisation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Berruer_S=E9bastien?= <sebastien.berruer@domain.hid>
Cc: xenomai@xenomai.org

Berruer S=E9bastien wrote:
> Hello,
>=20
> It works for me.
>=20
> It also solve some problem for me using the latency program in the test
> suite. I suppose it was the same kind of lock.

An issue with the latency test is the first thing you should mention. We
know the latency program is supposed to work without any problem, not
the programs you write.

Could you try something: with the patch still applied, could you try to
compile Xenomai user-space without the -msoft-float option?

>=20
> There is still the registration problem, that cause an error at the
> deletion of the task. If it persists and I can find any information from
> the mail archive, I'll opened a new thread.

Please post a short example exhibiting the bug you think you found.

--=20
                                          Gilles


