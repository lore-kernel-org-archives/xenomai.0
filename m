Date: Sat, 3 Oct 2015 14:29:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151003122900.GZ31137@hermes.click-hack.org>
References: <299A38B133279A4EBA47BCB60993FEAF858030C89D@xs203433.MELINDA.LOCAL>
 <20150414073454.GA1589@hermes.click-hack.org>
 <299A38B133279A4EBA47BCB60993FEAF858030C89E@xs203433.MELINDA.LOCAL>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <299A38B133279A4EBA47BCB60993FEAF858030C89E@xs203433.MELINDA.LOCAL>
Subject: Re: [Xenomai] RTNET
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: romain.perier@scle.fr
Cc: xenomai@xenomai.org

On Tue, Apr 14, 2015 at 10:15:56AM +0200, romain.perier@scle.fr wrote:
> Le 14/04/2015 09:35, Gilles Chanteperdrix a =E9crit :
> >> I have two questions :
> >>
> >> 1. Have you any ideas about the problem described above ?
> > No, the macb driver has been tested on AT91, and was working. Have
> > you tried loading rtipv4 and passing an IP address to rtifconfig (in
> > that order)?
>=20
> I have just tried, same behaviour, it freezes.
> $ modprobe rtipv4 (rtnet and macb are already loaded)
> $ /usr/xenomai/sbin/rtifconfig rteth0 up 192.168.0.1
>    # freeze

I finally tried the macb driver with the at91 sama5d3 GEM, and could
not reproduce any issue.

--=20
					    Gilles.
https://click-hack.org

