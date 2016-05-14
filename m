Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: =?utf-8?Q?Rolf_W=C3=B6hrmann?= <info@temporubato.com>
In-Reply-To: <20160514123051.GB27354@hermes.click-hack.org>
Date: Sat, 14 May 2016 15:01:14 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <3CC67847-B96B-4A25-A4C0-D92F267E4E3F@temporubato.com>
References: <f5af5dc73c2046f789592c7f15246c24@AM3PR48MB0177.041d.mgd.msft.net>
 <20160514123051.GB27354@hermes.click-hack.org>
Subject: Re: [Xenomai] system freeze on IMX6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, TALBI Ahmed -EXT <ahmed.talbi-ext@alstom.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi

not sure if this helps:=20

I=E2=80=99m running fine Xenomai 3.0.1 with mainline 4.1 on a i.MX6Q =
phyCORE board.

Phytec has a new PD15.3.0 released which contains a mainline 4.1.18 only =
with some DTS additions and minor driver changes. Applying the =
ipipe-4.1.18arm 4 was without problems.
So, may it=E2=80=99s worth a try to upgrade.

Cheers
Rolf
=20
=20
> On 14 May 2016, at 14:30, Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org> wrote:
>=20
> On Fri, May 13, 2016 at 01:25:31PM +0000, TALBI Ahmed -EXT wrote:
>> Hi all,
>>=20
>>=20
>> I'm new to this mailing list so please feel free to correct me if i'm =
not using it as it should.
>>=20
>> We are facing a freeze on our platform based on a IMX6 soc (see =
backtrace dump bellow). Please, can anybody take a look to it and give =
us a feedback  or an idea on the root cause of this issue ?
>>=20
>>=20
>> thanks in advance
>>=20
>>=20
>> we use kernel 3.0.35 and xenomai 2.6.4.
>=20
> Do you have the same problem with the 4.1 mainline kernel on Xenomai
> 3.0.2 ?
>=20
> --=20
> 					    Gilles.
> https://click-hack.org
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


