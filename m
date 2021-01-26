MIME-Version: 1.0
Message-ID: <trinity-9fa294bb-7134-47d5-bdf8-79a42908c354-1611693422979@msvc-mesg-gmx120>
From: Sebastian.Smolorz@gmx.de
Subject: Re: Look up all IDDP/XDDP labels in the registry from userspace
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Jan 2021 21:37:03 +0100
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <10c180a0-4589-556e-1b1b-5b96f2fa382b@siemens.com>
References: <CAPMj8MtS-vAssX+P8rywMUoFfs-DeCh_2f4sZts5Jk2Dk_rOEw@mail.gmail.com>
 <CAPMj8Mv8194p8qCPRgke=w+A14d9f9mf0P6OhR2k67Tqr=JUJw@mail.gmail.com>
 <8ebae193-88ec-e4b1-d86b-642a594ac7da@siemens.com>
 <CAPMj8Mtgv3FzX9H8ZRc9jCZsp8u6RhuyjXGJkbpfK6UoneNQVA@mail.gmail.com>
 <10c180a0-4589-556e-1b1b-5b96f2fa382b@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org, Sam Daniel <daniel.jacob.samuel@gmail.com>

Hi Jan,

Jan Kiszka wrote:
> On 26=2E01=2E21 20:44, Sam Daniel wrote:
> > On Tue, Jan 26, 2021 at 10:07 AM Jan Kiszka <jan=2Ekiszka@siemens=2Eco=
m
> > <mailto:jan=2Ekiszka@siemens=2Ecom>> wrote:
> >=20
> >     On 25=2E01=2E21 22:07, Sam Daniel via Xenomai wrote:
> >     > On Mon, Jan 25, 2021 at 12:20 PM Sam Daniel
> >     <daniel=2Ejacob=2Esamuel@gmail=2Ecom <mailto:daniel=2Ejacob=2Esamu=
el@gmail=2Ecom>>
> >     > wrote:
> >     >
> >     >> Is it possible to look up from userspace code all of the
> >     IDDP/XDDP labels
> >     >> that exist in the registry without leaving the primary domain?
> >     >>
> >     >> I have tried a few different ways of reading the contents of
> >     >> /proc/xenomai/registry/rtipc/iddp=2E The inotify API causes mod=
e
> >     switches (it
> >     >> relies on select or poll), not to mention that inotify does not
> >     work well
> >     >> with virtual filesystems=2E And using the C++ filesystem librar=
y to
> >     read the
> >     >> contents of the directory also causes mode switches (filesystem
> >     >> interactions)=2E
> >     >>
> >     >> Is there a real-time API function that I can use to query these
> >     labels?
> >     >>
> >     >
> >     > C++ filesystem library is causing mode switches because of an mm=
ap
> >     deep in
> >     > its call stack, not because of "filesystem interactions" like I
> >     initially
> >     > thought=2E
> >     >
> >=20
> >     What is the use case you need label listing from RT context for?
> >=20
> >     Jan
> >=20
> >     --=20
> >     Siemens AG, T RDA IOT
> >     Corporate Competence Center Embedded Linux
> >=20
> >=20
> > My use case is an IDDP-based pub/sub messaging system for real-time th=
reads=2E
> >=20
> > Threads publish and subscribe to a channel ("xyz")=2E Any number of
> > threads can publish to any channel=2E And any number of threads can
> > subscribe to any channel (and each one should receive every message
> > published to that channel)=2E
> >=20
> > Subscribers bind labeled IDDP sockets for each channel using labels li=
ke
> > so: <channel name>-<thread name>=2E If three threads subscribe to chan=
nel
> > "xyz" then I would expect /proc/xenomai/registry/rtipc/iddp to show:
> > xyz-threadA -> 0
> > xyz-threadB -> 1
> > xyz-threadC -> 2
> >=20
> > For the pub/sub implementation to work, when thread X calls
> > publish("xyz", &message) the publish method would need to multicast th=
e
> > message to all three of the IDDP sockets above=2E
> >=20
> > I would like to look up all labels in the registry from within the
> > publish method to check if any subscribers have gone away or if any ne=
w
> > subscribers have appeared and then adjust the multicast of the message
> > accordingly=2E
>=20
> RTIPC is not designed for such use cases - no multicast support as you
> may have noticed already=2E Polling for labels to appear or disappear
> would be a poor man's workaround=2E Still, you could make it "work": pol=
l
> with a non-RT thread for registry changes, update a lock-protected list
> of subscribers, and use that list from the publish method in RT context=
=2E
>=20
> That reminds of that simple (but rather domain specific) IPC driver we
> once had, Sebastian=2E ;)

Yeah, but that driver communicates over mailboxes rather than over
topics=2E

FWIW, it also is used in a really cool product=2E ;-)

=E2=80=94=20
Sebastian=20


