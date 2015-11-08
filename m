Date: Sun, 8 Nov 2015 19:04:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151108180426.GU1798@hermes.click-hack.org>
References: <1058571681.1464498.1446829121028.JavaMail.yahoo.ref@mail.yahoo.com>
 <1058571681.1464498.1446829121028.JavaMail.yahoo@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1058571681.1464498.1446829121028.JavaMail.yahoo@mail.yahoo.com>
Subject: Re: [Xenomai] kernel problem xenomai 2.6.4 - linux 3.8.13
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik_bayart@yahoo.co.uk>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Nov 06, 2015 at 04:58:40PM +0000, Frederik Bayart wrote:
> Hallo,
>=20
> I'm using xenomai 2.6.4 on kernel 3.8.13 (patch ipipe-core-3.8.13-x86-4.p=
atch)
>=20
> In attachment you find the kernel config.
>=20
> When I boot the kernel on a recent pc's (Intel(R) Core(TM) i5), I don't g=
et problems, but if I install the same image on an older pc, (Intel(R) Core=
(TM) Duo CPU=A0=A0=A0=A0=A0 T2500=A0 @ 2.00GHz), I get periodic kernel trac=
es after booting without running any real-time process (see below). In the =
dmesg in attachment, I see a stack trace.
> (If I build a normal linux kernel without ipipe patch, I get no kernel tr=
aces.)
>=20
> Has anyone has a suggestion what could go wrong ?

The NULL EIP suggest an NULL handler. Any chance to test something
more recent? Like xenomai 2.6 git head, with the latest I-pipe patch
for 3.18?

--=20
					    Gilles.
https://click-hack.org

