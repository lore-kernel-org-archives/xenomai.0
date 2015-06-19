From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Date: Fri, 19 Jun 2015 12:41:13 +0200
Message-ID: <1972650.TnPARfU7Gx@soho>
In-Reply-To: <1281528104.2749631.1434707703235.JavaMail.yahoo@mail.yahoo.com>
References: <7ad4e107e9fd70e40e7a622724d8e211.squirrel@sourcetrek.com>
 <1281528104.2749631.1434707703235.JavaMail.yahoo@mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Xenomai] Rtnet driver of RTL8111/8168/8411
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gabriele Moabiti <gabmoa@yahoo.it>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

El Divendres, 19 de juny de 2015, a les 09:55:03, Gabriele Moabiti va=20=

escriure:
> In RTNET mailing list an update driver was sent:
>=20
> http://sourceforge.net/p/rtnet/mailman/message/31389885/
>=20
> I've changed this driver and used successfully with some 8168/8111 ne=
twork
> card.Hope this helps. Gabriele

Thanks Gabriele,

It doesn't compile, so I don't know how updated is that driver.
>=20
>=20
>=20
>      Il Gioved=C3=AC 18 Giugno 2015 17:27, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> ha scritto:
> Leopold Palomo-Avellaneda wrote:
> > Hi,
> >=20
> > just to confirm. I assume that if my box has this ethernet chipset:=

> >=20
> > Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigab=
it
> > Ethernet
> >=20
> > the rt_r8169 doesn't work, although the linux module is r8169.
> >=20
> > Is it correct?
> >=20
> > And I'm saying this because although I'm using xenomai 2.6.4 (lates=
t
> > stable)
> > and rtnet (git updated) when I load the module no rtethX interface =
is
> > generated.
>=20
> I think rt_8169 supports 8169 only. I added support for the chipset o=
n my
> Atom-based board to xenomai 3 rtnet. Do not remember which it was 811=
11 or
> 8168.

I think that 8168 .... do you think that you will make a 8111 driver?

Leopold



--=20
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

