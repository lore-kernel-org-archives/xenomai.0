Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Nov 2007 09:51:45 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2AE092AC@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <4741D0AC.40308@domain.hid>
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

>=20
> No more than one block is allocated at any given time in your example.
> This is expected due to the priority scheme your test=20
> undergoes. In any
> case, 282 bytes (+ a few bytes message header) should grab=20
> one 512-byte
> buffer here. For anything below the size of a logical page (4k in
> 2.3.x), the allocator picks the next power of 2 greater or=20
> equal to the
> requested size.

Is it possible that a allocated block remembers the size he is allocated
for=20
and that the block is just usable for this size even after the block is
freed ?

>=20
> What if you don't set any limit to the queue elements, i.e. passing
> Q_UNLIMITED instead of 10. Does this change the behaviour?
>=20

This does not help. What helps is increasing the queue size to e.g.=20
MAXLEN*100 =3D 200000
(rt_queue_create(&qtest1q, "qtest1q", MAXLEN*100, Q_UNLIMITED, Q_FIFO))

Could you please try to run my example on your machine, or are you
shure, that this
problem is specific to our platform ? Thank you for your help !

Best regards
Roderik=20

MAN Roland Druckmaschinen AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle   =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592   =20
USt-Ident-Nr. DE 250200933

