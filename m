Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <53564F83.4070401@control.lth.se>
Date: Tue, 22 Apr 2014 13:53:31 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <A973FC64-9FD8-4892-BF4B-2BBE74942BA3@mah.priv.at>
References: <CAC66z97Q39YpEQ8aug7DqnCM-+cQ8NRAVgFHLgJamgbqjV4PfA@mail.gmail.com>
 <53564F83.4070401@control.lth.se>
Subject: Re: [Xenomai] RTDM: Ethernet driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Am 22.04.2014 um 13:16 schrieb Anders Blomdell =
<anders.blomdell@control.lth.se>:

> On 04/22/2014 11:45 AM, yogesh garg wrote:
>>  I want to write Ethernet (NIC) driver on Xenomai using RTDM. I don't =
want
>> to use RTnet.
> Why not?
>=20
> RTnet does not imply that you have to use the RTnet protocol, it's
> perfectly fine to use just the Ethernet drivers as you see fit
> (that's what I do all the time).
>=20
> By going your own way, realtime ethernet for Xenomai will be =
fragmented,
> which will benefit nobody (except possibly WindRiver/Microsoft/...)

well there are valid reasons

One we have is: since the application runs across RTAI, Xenomai and =
RT_PREEMPT a single method would be beneficial, even at the cost of =
lower performance. Not everyone is fond of networking silos.

- Michael


>> Can someone suggest me any example code or useful links/docs
>> which can help me to do so.
>>=20
>=20
> /Anders
>=20
> --
> Anders Blomdell                  Email: anders.blomdell@control.lth.se
> Department of Automatic Control
> Lund University                  Phone:    +46 46 222 4625
> P.O. Box 118
> SE-221 00 Lund, Sweden
>=20
>=20
>=20
>=20
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai


