From: "Auel, Kendall" <Kendall.Auel@3DSystems.Com>
Date: Fri, 26 Jan 2018 20:11:53 +0000
Message-ID: <61a0ffec6dcb4a03b70fe5504f76eb8e@P10-EX01.3DSystems.Internal>
References: <c9443b76-da71-9885-82a4-9e524b460998@xenomai.org>
 <11bce118-b19b-fc07-8a2d-03f4d618d5d4@siemens.com>
 <CALLqZ8R0HT5yOXd9TVrBETbSSPgem=Jsd4LQU_=oBx_FFcU+Ng@mail.gmail.com>
 <1c606242-30d6-6bfe-5288-cf312b28a857@siemens.com>
 <CALLqZ8TdVF7JHUvhMnUf0BEnyoW4r-jcsXjZ6uXkgPWu3g0bDA@mail.gmail.com>
In-Reply-To: <CALLqZ8TdVF7JHUvhMnUf0BEnyoW4r-jcsXjZ6uXkgPWu3g0bDA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] [RFC] FOSDEM meeting agenda
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

I've been lurking on this list for a while, and looking forward to seeing s=
ome of you face-to-face. I'm a Portland native, so feel free to use me as a=
 resource when planning your visit.

> -----Original Message-----
> From: Xenomai [mailto:xenomai-bounces@xenomai.org] On Behalf Of Greg
> Gallagher
> Sent: Friday, January 26, 2018 11:02 AM
> To: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Steven Seeger <steven.seeger@nasa.gov>; Xenomai@xenomai.org
> Subject: Re: [Xenomai] [RFC] FOSDEM meeting agenda
>=20
> That would be great,  I booked my flights and hotel this morning.
> Definitely attending the Xenomai talk and there was another talk on a 3D
> printer that is using Xenomai
> (https://elciotna18.sched.com/event/DXmw/3d-printing-with-linux-and-xenom=
ai-kendall-auel-3d-systems-corp)
> that sounds like it will be interesting.  I'm up for anything Xenomai, I'=
ll be
> getting there late Sunday and leaving around 6pm Wednesday.
>=20
> -Greg
>=20
> On Fri, Jan 26, 2018 at 1:57 PM, Jan Kiszka <jan.kiszka@siemens.com> wrot=
e:
> > On 2018-01-26 19:51, Greg Gallagher wrote:
> >> We can add an ELC meeting ;)
> >>
> >
> > Sure! Will you attend?
> >
> > Our Xenomai talk was accepted [1], and I'll hang around in Portland
> > for the whole ELC. We can do some hallway tracks or more if there is
> interest.
> >
> > Jan
> >
> > [1]
> > https://elciotna18.sched.com/event/DXnN/steering-xenomai-into-the-
> real
> > -time-linux-future-jan-kiszka-siemens-ag
> >
> >> On Fri, Jan 26, 2018 at 1:49 PM, Jan Kiszka <jan.kiszka@siemens.com>
> wrote:
> >>> On 2018-01-25 18:40, Philippe Gerum wrote:
> >>>>
> >>>> Here are some points I would like to discuss during this meeting.
> >>>> Please feel free to comment:
> >>>>
> >>>> 1. Release management
> >>>>
> >>>>       * Currently, the person who contributes most of the code is
> >>>> also the release manager, which is clearly not optimal. Both
> >>>> activities should be decoupled for efficiency (esp. hindsight) and
> >>>> practical reasons. At some point, I will stop acting as the release
> >>>> manager, so the project will need a different organization in this
> respect. Which one?
> >>>>
> >>>>       * As a corollary, the current release process is broken: no
> >>>> explicit release plan or schedule, limited testing, barely any user
> >>>> feedback about the development version in general. Practical steps
> >>>> to improve this should be discussed.
> >>>>
> >>>>       * My understanding is that v3.1 is almost there feature-wise,
> >>>> with a working arm64 port Dmitriy is polishing, a bunch of rtnet
> >>>> fixes actually enabling RTnet with SMAP/x86 (which still need some
> >>>> feedback btw), and support for recent kernels up to 4.14 (arm,
> >>>> arm64, powerpc). x86 is still lagging behind with kernel 4.9
> >>>> though. I'm about to queue a couple of ABI changes more, with the
> >>>> implementation of sendmmsg() and
> >>>> recvmmsg() for RTDM sockets.
> >>>>
> >>>> This raises the following questions: 1) may we freeze the v3.1 ABI,
> >>>> 2) should we wait for supporting 4.14/x86 before releasing v3.1, 3)
> >>>> how much use/testing do we currently have of the -next branch, on
> >>>> which CPU architecture(s)?
> >>>>
> >>>> 2. Documentation
> >>>>
> >>>>       * The existing documentation has several weaknesses; from the
> >>>> traffic on the mailing list, the main one may be that it leaves
> >>>> newcomers with a steep learning curve, in some occasions, even when
> >>>> the information is published on the website and/or present in the
> >>>> inline documentation. How to improve the situation, how to better
> >>>> organize the existing doc so that people do find what they are looki=
ng
> for?
> >>>>
> >>>>       * Doxygen may not be the best option anymore for inline
> >>>> documentation; Chasing glitches with using the markup has been a
> >>>> real pain over the years, getting properly structured output has
> >>>> never been obvious. Could we do better with Doxygen in a reasonably
> >>>> simple fashion, or should reStructuredText and Sphinx be considered
> >>>> as a replacement, so that we can converge toward the kernel
> documentation system?
> >>>>
> >>>> 3. Pipeline maintenance
> >>>>
> >>>>       * We now have a dedicated I-pipe maintainer per CPU
> >>>> architecture, which is a great relief to me. Now I'd like we
> >>>> discuss the maintenance process, 1) how to organize the
> >>>> upstream/downstream flow of the generic pipeline bits I still
> >>>> maintain currently, between other maintainers and me? 2) how to best
> disseminate knowledge about the I-pipe implementation?
> >>>>
> >>>>       * mainline vs CIP kernel, LTS maintenance policy
> >>>>
> >>>> 4. Misc
> >>>>
> >>>>       * formalizing the decision about dropping the blackfin and
> >>>> powerpc64 port, since we had zero feedback from users so far, so
> >>>> everyone must be fine with this.
> >>>>
> >>>> Thanks,
> >>>>
> >>>
> >>> Thanks for preparing this. Sounds good to me.
> >>>
> >>> Adding from Greg's points as well, we probably need to bring up bug
> >>> tracking together with the bigger topic workflow and related tooling.
> >>> This may easily make us run out of time, but a survey of opinions
> >>> and ideas in that round would be good to follow up on the list
> afterwards.
> >>>
> >>> Then testing. I would also not go into too much details, but it
> >>> would be good to understand what exist(ed) and what could be done
> >>> easily to improve it. Overlaps also with release management and with
> >>> the good proposal to define reference boards.
> >>>
> >>> How many days will our meeting have? ;)
> >>>
> >>> Jan
> >>>
> >>> --
> >>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate
> >>> Competence Center Embedded Linux
> >
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

