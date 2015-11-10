Date: Tue, 10 Nov 2015 18:27:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151110172722.GB4629@hermes.click-hack.org>
References: <20151108180426.GU1798@hermes.click-hack.org>
 <1769796423.4391042.1447175775237.JavaMail.yahoo@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1769796423.4391042.1447175775237.JavaMail.yahoo@mail.yahoo.com>
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

On Tue, Nov 10, 2015 at 05:16:15PM +0000, Frederik Bayart wrote:
> >On Sunday, 8 November 2015, 19:04, Gilles Chanteperdrix <gilles.chantepe=
rdrix@xenomai.org> wrote:
> >
> >On Fri, Nov 06, 2015 at 04:58:40PM +0000, Frederik Bayart wrote:
> >
> >> Hallo,
> >>
> >> I'm using xenomai 2.6.4 on kernel 3.8.13 (patch ipipe-core-3.8.13-x86-=
4.patch)
> >>
> >> In attachment you find the kernel config.
> >>
> >> When I boot the kernel on a recent pc's (Intel(R) Core(TM) i5), I don'=
t get problems, but if I install the same image on an older pc, (Intel(R) C=
ore(TM) Duo CPU=A0=A0=A0=A0=A0 T2500=A0 @ 2.00GHz), I get periodic kernel t=
races after booting without running any real-time process (see below). In t=
he dmesg in attachment, I see a stack trace.
> >> (If I build a normal linux kernel without ipipe patch, I get no kernel=
 traces.)
> >>
> >> Has anyone has a suggestion what could go wrong ?
> >
> >
> >The NULL EIP suggest an NULL handler. Any chance to test something
> >more recent? Like xenomai 2.6 git head, with the latest I-pipe patch
> >for 3.18?
> >
> >Gilles.
>=20
> First impression is that building and installing xenomai 2.6 git head wit=
h ipipe-core-3.18.20-x86-3.patch seems to solve the problem.
> The problem was still existing in xenomai 2.6.4 and kernel 3.14.17, so I =
guess the problem might been fixed after the release of 2.6.4
> I will test further.

As a rule of thumb, when using an old version of Xenomai, you should
update the I-pipe to the latest version corresponding to the branch
you cant to use. So, for 3.14, you should use this Ipipe patch:
http://xenomai.org/downloads/ipipe/v3.x/x86/ipipe-core-3.14.44-x86-10.patch

Regards.

--=20
					    Gilles.
https://click-hack.org

