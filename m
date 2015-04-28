Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
From: Michael Haberler <haberlerm@gmail.com>
In-Reply-To: <20150428160255.GD1993@hermes.click-hack.org>
Date: Tue, 28 Apr 2015 22:19:26 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <6EE509AA-B0D3-40DC-9DEA-63E1DCDB39A6@gmail.com>
References: <CADvZd9azLVdxYd8gy4BwT8Fh1LixV_=vbZoAAZegJ+rAut8mng@mail.gmail.com>
 <20150428160255.GD1993@hermes.click-hack.org>
Subject: Re: [Xenomai] RT-CAN driver for C_CAN,D_CAN cores ready
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

Gille -

> Am 28.04.2015 um 18:02 schrieb Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org>:
>=20
> On Tue, Apr 28, 2015 at 05:47:40PM +0200, Michael Haberler wrote:
>> as requested:
>=20
> This is a mess, really, you add files to remove them later.

Steve started with the vanilla c_can driver, copied and renamed the =
files. But the code still shares a lot with the original.

I do think history is important - when searching for a bug this driver =
introduced, or backporting a fix to the vanilla driver.

This is why you see what you see. I think it is more relevant than =
aesthetics.

If you prefer to have a history-free squash, that is fine too - I pity =
the fellow trying to nail a bug though. Please advise.

>=20
> A patch should be against Xenomai sources, and for adding a driver
> it should only add file or modify existing files.
>=20
> Second point, the indentation, Xenomai follows the linux kernel
> rules where the indentation "unit" is a tab characters which should
> be displayed as 8 spaces by diff. Here your indentation seems to be
> one space (maybe your mailer did that ?).

To exclude that option is why I attached the file. For reference, =
umutilated originals are here: =
https://github.com/mhaberler/xenomai-2.6/commits/bbcan

I didnt write this - I am just moderating the process, but I can =
reformat as requested.

- Michael

>=20
> A smaller patch means an easier review.
>=20
> --=20
> 					    Gilles.


