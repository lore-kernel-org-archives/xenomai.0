Date: Wed, 7 Nov 2018 14:00:07 +0100
From: Henning Schild <henning.schild@siemens.com>
Subject: Fw: Segmentation error 6 in rt_heap_create() without --enable-pshared
Message-ID: <20181107140007.2730e228@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Readding list ...

Beginn der weitergeleiteten Nachricht:

Datum: Wed, 7 Nov 2018 13:55:53 +0100
Von: Henning Schild <henning.schild@siemens.com>
An: Xenomai <xenomai-bounces@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum
<rpm@xenomai.org>, Petr =C4=8Cervenka <grugh@centrum.cz> Betreff: Re:
Segmentation error 6 in rt_heap_create() without --enable-pshared


Am Wed, 7 Nov 2018 13:10:34 +0100
schrieb Henning Schild <henning.schild@siemens.com>:

> Am Tue, 6 Nov 2018 19:04:51 +0100
> schrieb Jan Kiszka via Xenomai <xenomai@xenomai.org>:
>  =20
> > On 05.11.18 16:48, Petr =C4=8Cervenka wrote:   =20
> > >> Only? Sorry for insisting, but it may help to reduce the search
> > >> space, and it's also important as I'd like to release a new
> > >> stable version - without known issues.
> > >  >=20
> > >> Thanks,
> > >> Jan
> > >  >     =20
> > > =C2=A0
> > > I can confirm now, that the problem happens only with the master
> > > branch. Petr
> > >      =20
> >=20
> > Thanks. Philippe, any idea?   =20
>=20
> I was just looking into an issue in the dlopen-test. Turns out it is a
> segfault from rt_queue_create that only shows in "--enable-dlopen-libs
> --disable-pshared".
>=20
> Will at least try and bisect my way to where that was introduced. =20

Got it:
# first new commit: [fa39f253518101d0d31dc946ecdde55afb1b88b2]
copperplate/heapobj: enable heapmem for private memory

Henning

> Henning
>  =20
> > Jan
> >    =20
>  =20


