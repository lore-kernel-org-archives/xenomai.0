MIME-Version: 1.0
References: <20b3f016-e519-35fc-9a9e-750ecfc509a3@xenomai.org>
 <c5fe2712-107e-eabe-9a4d-da182696a414@xenomai.org>
 <cc7b4731-357e-6d25-6a94-3a5865ab9a92@xenomai.org>
In-Reply-To: <cc7b4731-357e-6d25-6a94-3a5865ab9a92@xenomai.org>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 30 Apr 2019 10:03:44 -0400
Message-ID: <CALLqZ8SFWngVtVyFQ57X-3Vp2Qyot3HCW747vWifZv03rf3XMA@mail.gmail.com>
Subject: Re: Dual kernel made easy
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jorge Ramirez <jro@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>

On Tue, Apr 30, 2019 at 5:19 AM Philippe Gerum via Xenomai
<xenomai@xenomai.org> wrote:
>
> On 4/29/19 10:24 PM, Jorge Ramirez wrote:
> > On 4/1/19 22:11, Philippe Gerum wrote:
> >> Motivated by the pain we continue to inflict upon ourselves everytime
> >> we need to rebase the I-pipe over a recent kernel release, I started
> >> working to define its future replacement. Now that we have an
> >> implementation of its successor running reliably, my next step is to
> >> rebase the Cobalt ARM port on this new interface called Dovetail [1].
> >>
> >> This work is part of a larger effort to rethink the way independent
> >> software cores like Xenomai's integrate into the main kernel [2].
> >>
> >> This led to not only implement Dovetail, but also to showcase it with
> >> a new real-time co-kernel originally derived from Cobalt [3], which is
> >> simple and compact enough to be used as a learning tool for everyone
> >> interested in the dual kernel technology based on Linux.
> >>
> >> The purpose of this work is about making dual kernel easy, at least as
> >> simple as possible for people to develop and maintain their own
> >> software core of choice over the current mainline kernel.
> >>
> >> [1] https://evenless.org/dovetail/
> >> [2] https://evenless.org/
> >> [3] https://evenless.org/core/
> >>
> > Hi Philippe,
> >
> > For a number of reasons - some personal and some professional - I am
> > interested in porting an IP stack to EVL.
> >
> > I have asked around and it seems one of the most popular IP stacks
> > these days is LwIP [1]. In fact this stack seems to align well with
> > one of the goals you set for EVL, targeting simplicity.
> >
> > Is this activity something you (or others) would be interested in
> > supporting?
> >
>
> Yes, definitely, count me in. A lightweight IP stack running from
> userland is something I had in mind for EVL too.
>
> --
> Philippe.
>

I'll make some time to help.

-Greg

