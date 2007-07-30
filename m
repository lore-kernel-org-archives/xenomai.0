Message-ID: <46ADE8DC.8030307@domain.hid>
Date: Mon, 30 Jul 2007 15:34:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <e39c9190707291316l237d572btd75f570d39ab75e@domain.hid>	
	<46ADC051.7020608@domain.hid>
	<e39c9190707300602i43d94665v33adf44a9870e757@domain.hid>
In-Reply-To: <e39c9190707300602i43d94665v33adf44a9870e757@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9552700C85A35EDA8C757050"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] RTDM driver hints
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: juanba romance <juanba.romance@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9552700C85A35EDA8C757050
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

juanba romance wrote:
> Thanks Jan..
> On 7/30/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Before going into details on how to pass references between driver tas=
ks
>> etc.:
>>
>> Why do you want to establish a dedicated task for transmission? Is the=

>> job you have to perform there too heavy for IRQ context?
>=20
>=20
> The application has two issues related on:
> 1.- The transmission setup would be really time extensive, so the ISR w=
ill
> be really too busy sucking the data from the FIFO and pushing it into t=
he
> chipset
> 2.- Due to system specifications, we have focused the ISR performance i=
n the
> data reception flow, so the transmission irq context management must/ne=
ed be
> really fast.
> We would like to hold as much as possible both features and this is the=

> reason to evaluate the rt_task approach..

Ok, got it.

>=20
> Keep in mind that such a task requires additional management (assign
>> reasonable
>> priorities e.g.) and adds further latencies. It's no magic bullet, but=

>> it may be appropriate if there is actually a lot of work to do that
>> shall not block other, more important jobs.
>=20
>=20
> I mean the application specifications allow us to block a little bit th=
e
> internal driver write capabilities but the isr read management should b=
e
> inherently the most priority program flow.
>=20
> Jan
>=20
>=20
> As I have mentioned in the previous mail the driver is also a formal de=
sign
> review, so lot of  variables and data addresses have been re-arranged a=
nd
> re-structured, one of their was the killer one cause was pointed to the=

> hyperspace into the thread symbol..
> I have checked the context pass argument with the decoded one at the th=
read
> and all is ok now, no troubles related on.
> The writer thread is always coupled to the "context" area reference thr=
ough
> the "open" call softly. Anyway, I think that a more generic question co=
uld
> be stated right now.
>=20
> Could i assume that the memory references coupled with the context argu=
ment
> at the "open" call are stables along the context cycle life?
> I think that this is not any data trusting if i always link the thread
> creation/destroy to the "open"/"close" call entries, but i assume also =
that
> i could have a fully wrong picture about all this stuff.

If you create the task on "open", stuff its reference into the context,
maybe additionally pass the context as argument to the task function,
and then clean things up on "close", I see no problems of
stalled/inconsistent references. Problems may only arise from races
between the open/close and the task function. So make sure not to rely
on specific, only-valid-on-UP execution orders.

>=20
> If you are so kind to give me any extra hints i would be really gratefu=
l
> Thanks a lot..

If things are not fully clear yet, I would suggest to post some code
now. That is far more efficient than just describing the design.

Jan


--------------enig9552700C85A35EDA8C757050
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGrejcniDOoMHTA+kRAmT9AJ91MHa9MGNBkth3agDXUf6XUmb54wCdEjXB
pj1VWPJ8JQG/lqcX7LIwREs=
=7N+O
-----END PGP SIGNATURE-----

--------------enig9552700C85A35EDA8C757050--

