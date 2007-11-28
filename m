Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Nov 2007 10:21:23 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2AE3BF3A@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <47470916.6050308@domain.hid>
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

Thank you. Good work !=20

I applied your patch to 2.3.2 and, as far as I can see,=20
the allocation problem does not accur anymore.

(please se my insertions below)

> Now, the human readable form of the explanation:
> - you ask for a 10kb heap, which is silently rounded to 12k=20
> in order to
> cope with the 4k alignment constraint we have on shareable heaps
> (userland heaps are always shareable).
> - 12kb heap means 3 * 4k pages available in the global free list.
> - your application allocates randomly-sized blocks, each new size
> rounded to the next power of 2 grabs one page from the global pool to
> hold blocks of the same size, but unfortunately, the heap manager does
> _not_ release it back to the free list when the last block laid on the
> page is freed.

Thank you for your explanation,
I thought it must be something like this=20
(block remembers what size ist as been allocated for)

> - after more than 3 different allocation sizes (e.g. 2^3, 2^5 and 2^8)
> have been requested to the heap manager, it fails honoring a=20
> fourth one.
> I would rather consider this as a bug, since putting a lot of pressure
> on a single block size would beget the same problem (i.e. no=20
> need for a
> funky randomized allocation pattern here), with a global free=20

I think the test case isn=B4t very funky. Of course we did not write=20
random buffer sizes (this was just implemted to get a simple test case),
but we simple wrote some messages of different size to a queue and faced
the allocation problem.
Therefore, form our point of view, this is a bug.

> page list
> being emptied over time, and all pages lingering inside some private
> (per-block size) bucket queue.
>=20
> The attached patch fixed the issue (against v2.4-rc6). I'm still
> pondering whether v2.3.x should get this update too, due to the
> variations this patch introduces wrt memory consumption for the heap

I would appreciate it, if 2.3.x could be updated too,=20
as we could carry on using 2.3.x (vendor libraries don=B4t need to be =
updated)

Many thanks and best regards
Roderik=20

MAN Roland Druckmaschinen AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle   =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592   =20
USt-Ident-Nr. DE 250200933

