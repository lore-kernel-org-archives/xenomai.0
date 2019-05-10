MIME-Version: 1.0
References: <VpFdLbJqKpBKdxuwpEr9vxR2VBu2j4uXIps1EM68ktxueh7Q9bRQeHRA56sFDKeY1xbPcvb6TuGG01MVtxNt03OdF6N1b3YIEPjJnzbRjqk=@codecraftsmen.org>
 <CALLqZ8TJt66aooCz+wCFhg_k3+xwoQ6BFqc+7TvFtA+Au71zzw@mail.gmail.com>
 <Wc_l4MYuhmN-h0Z9zuurZ_MxUaMovQA6xNvZE6EMmf7-zD8ZywQlT_X6AovXAczK01iesjy5RdARBztqwtsVxOhOBSgF3CNpXy2z8lpjU-g=@codecraftsmen.org>
In-Reply-To: <Wc_l4MYuhmN-h0Z9zuurZ_MxUaMovQA6xNvZE6EMmf7-zD8ZywQlT_X6AovXAczK01iesjy5RdARBztqwtsVxOhOBSgF3CNpXy2z8lpjU-g=@codecraftsmen.org>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 9 May 2019 21:37:41 -0400
Message-ID: <CALLqZ8RdpTNzdTSnn7yGosKAEYyLGh6-eoi6PzPrzRPs3jAdNA@mail.gmail.com>
Subject: Re: select() unblocks when no data to read()
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <w1@codecraftsmen.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, May 9, 2019 at 9:26 PM Jeff Webb <w1@codecraftsmen.org> wrote:
>
>
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> On Thursday, May 9, 2019 9:19 AM, Greg Gallagher <greg@embeddedgreg.com> =
wrote:
>
> > On Tue, May 7, 2019 at 9:54 PM Jeff Webb via Xenomai
> > xenomai@xenomai.org wrote:
> >
> > > I am having trouble using select() to perform a timed wait on a UDD f=
ile descriptor to detect interrupts from a custom PCI card. After some sear=
ching, I came across this thread from 2017 that describes my exact issue:
> > > https://xenomai.org/pipermail/xenomai/2017-July/037494.html
> > > I am using x86-64 instead of ARM, but I am having the same trouble. T=
he original poster did a great job of describing the problem, so I won't re=
peat it. If I use only read() without select(), things work as expected, bu=
t I need to implement a timeout.
> > > It sounds like Philippe was going to look into the issue further. Has=
 any progress on this issue been made since the last post in this thread?
> > > Thanks,
> > > -Jeff Webb
> >
> > There was a fix posted to the list a while ago but it wasn't a patch
> > it was the whole c file. I don't think a patch was ever made, I'll
> > see if I can dig it up.
>
> Thanks for looking into it, Greg.  I must have missed that post.  The ori=
ginal poster's solution of adding this line:
>
>   rtdm_event_clear(&ur->pulse);
>
> just before the return statement in udd_read_rt() is working for me.  Phi=
lippe mentioned that this might be racy, but maybe it's okay (or maybe not?=
) if there are no shared interrupts and interrupts are unmasked by the user=
space application after the read completes.
>
> -Jeff
>

Here's the thread:
https://www.xenomai.org/pipermail/xenomai/2018-May/038934.html

I'm not sure if that will solve your issue, I can make a patch
tomorrow if that's easier and you can test it out.  I haven't dug to
far into this but I don't mind taking a look if that will help.

-Greg

