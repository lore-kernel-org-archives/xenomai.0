Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Nov 2007 15:07:33 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2AE097CD@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <4742E82B.1040000@domain.hid>
From: <Roderik.Wildenburg@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_write error: "Cannot allocate memory ";
	bug or feature ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

> >=20
> > Could you please try to run my example on your machine, or are you
> > shure, that this
> > problem is specific to our platform ? Thank you for your help !

>=20
> This is likely not a platform specific issue. You may want to run your
> small test on v2.4-rc6 on your side.
>=20

If you think so, have you been able do reproduce the problem ?

Xenomai 2.4.-rc6 did not make any differenece as you can see from the
following output :
(/proc/xenomai/version says 2.4-rc6)

WriteQueue 716 1512231002
WriteQueue 1007 2129556885
WriteQueue 227 476645315
WriteQueue 615 1299758337
WriteQueue 582 1228925036
WriteQueue 449 947777523
WriteQueue 270 567867246
WriteQueue 752 1589385927
WriteQueue 958 2026690827
WriteQueue 64 131957776
qtest2t: rt_queue_write error: Cannot allocate memory
Message size :64 return : -12
---- qtest1q NMsg:0 Size:12288 used:0
WriteQueue 849 1795696479
WriteQueue 939 1985770412
WriteQueue 234 491648752
WriteQueue 307 646407494
WriteQueue 1012 2140941003
qtest2t: rt_queue_write error: Cannot allocate memory
Message size :1012 return : -12
---- qtest1q NMsg:0 Size:12288 used:0
WriteQueue 610 1289683840
WriteQueue 313 660303794
WriteQueue 472 996746841

So, what can we do now ?

Best regards=20
Roderik=20

MAN Roland Druckmaschinen AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle   =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592   =20
USt-Ident-Nr. DE 250200933

