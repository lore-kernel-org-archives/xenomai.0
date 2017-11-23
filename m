From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Thu, 23 Nov 2017 14:22:04 +0000
Message-ID: <DB6PR0701MB2456F934D8EFEA530CE8BD86B5210@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
 <1b035acc-5784-f0b0-f16f-09279d5a8845@siemens.com>,
 <20171123132105.313c2fdc@md1em3qc>
In-Reply-To: <20171123132105.313c2fdc@md1em3qc>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] [RFC] RTnet, Analogy and the elephant in the room
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Daniel Wagner <daniel.wagner@siemens.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

At Bela (bela.io) we use Xenomai on the BeagleBone Black for audio. Current=
ly our resources are pretty scarce, but hopefully from March things should =
get better For instance, now that RobertCNelson has discontinued support fo=
r Xenomai on the BeagleBone, we may be able to help with that (incidentally=
 - as someone was asking - we provide a pre-built image for BeagleBone with=
 Debian Stretch and  Xenomai 3.0.5 on Linux 4.4 (and some of our stuff too)=
: https://github.com//BelaPlatform/bela-image-builder/releases).

> We are currently planning a so far internal workshop with Philippe in
> order to discuss how to bring more of our people but also others on
> board regarding kernel maintenance topics. Topics to discussed are
> likely

Either way, it would be great to be able to take part in this workshop with=
 Philippe. I think it is unlikely that we would be able to travel to Munich=
 in January, but we should be able to attend remotely, so please keep us in=
 the loop. I reckon it would be important (if all the involved parties agre=
e, that is) to make a video recording of the workshop available online for =
posterity (e.g.: a youtube live streaming and subsequently available perman=
ently), so to make it easier for others in the future to get started with X=
enomai's development.

Thanks,
Giulio

________________________________________
From: Xenomai <xenomai-bounces@xenomai.org> on behalf of Henning Schild <he=
nning.schild@siemens.com>
Sent: 23 November 2017 12:21
To: Jan Kiszka
Cc: Daniel Wagner; Xenomai@xenomai.org
Subject: Re: [Xenomai] [RFC] RTnet, Analogy and the elephant in the room

Am Wed, 22 Nov 2017 21:26:23 +0100
schrieb Jan Kiszka <jan.kiszka@siemens.com>:

> On 2017-11-21 18:11, Philippe Gerum wrote:
> > So, let's talk about the elephant in the room: the current
> > situation of the Xenomai project is not viable in the long run. I
> > can only encourage people who feel concerned about it to discuss
> > openly the practical steps to best address this challenge.
>
> Thanks for bringing this frankly on the table! For those who follow
> the project, it's likely no news. So we were working on this issue
> also internally, with users of Xenomai inside Siemens. And we have the
> backing to enhance our involvement in upstream work. Right now we are
> working on making this concrete.

I could not agree more, thanks for bringing that up!

I will also be frank and put my thoughts on the table. The most
important point on our tasks to work on is culture. Technical details
and who does what can be addressed later or along the way.

IMHO Xenomai is not an open-source project. There is no open agenda, no
TODO list, issue tracking, discussions etc. All this critical
information, along with the hardcore technical details, used to be in
the heads of two people + plus a few others guessing and helping out a
bit. Now we are down to 1 + for quite a while. Still very much top-down
instead of open.

Looking at the project today nobody could tell where to start
contributing. Nobody knows when the next branch will pop up in git or
the next release will fall from the sky. Such things are not discussed,
they just happen.

Ok, now that was me expressing personal opinions and impressions, not
addressing blame.

I am convinced that a lot of this information can be opened up, maybe
with the use of tools (issue trackers etc.). Now for the experience and
the skills we desperately need Philippe to change his role to being
more of a mentor. And i will be happy to work on tasks that are
assigned to me, my solutions will lack speed and quality at first but
that will hopefully change over time.

> There are many areas where contributions can be beneficial for the
> project and its community, and many do not require deepest
> understanding of the core, like around CI, test automation, distro
> packaging, documentation, or user support. But some essential
> elements in my eyes are
>
>  - building up a core team of kernel maintainers for Cobalt
>
>  - offloading work from the shoulders of our extremely valuable
>    maintainer

We (Siemens) can help with 1 and therefore 2. ...for now. But adding a
few people to the inner circle will not do the trick. Especially not if
these people are coming from industry and only one player. The
dedication/funding of industry players by enlarge depends on business
decisions that are valid for one fiscal year.
But industry is the largest user of xenomai, so to mitigate that
problem more players are needed!

> The second part will be achieved to a certain degree by the first one
> as Philippe can probably confirm. So I would like to focus this and
> try to make some first step:
>
> We are currently planning a so far internal workshop with Philippe in
> order to discuss how to bring more of our people but also others on
> board regarding kernel maintenance topics. Topics to discussed are
> likely
>
>  - current design and how to introduce people to it (tough, yeah...)
>  - possible workflows and integration paths
>  - update strategy and frequency
>  - testing needs and strategies
>  - supportable architectures
>  - state and details of the new pipeline design
>  - planning of and migration path to the new design
>
> If there is interest in joining such a discussion, physically (will
> likely take place in our office in Munich, Germany) or virtually
> (provided time zones work out), please let us know. Time frame is more
> likely early next year than mid of this December. And this shall be
> only the kickoff for further discussions in the community!

Yes, anyone that wants to join such a meeting please let us know.
Depending on the feedback we could also arrange something different.
(i.e. collocated with FOSDEM18? )

Henning

> Jan
>


_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai

