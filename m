Date: Wed, 22 May 2019 13:06:50 +0000
From: Jeff Webb <w1@codecraftsmen.org>
Reply-To: Jeff Webb <w1@codecraftsmen.org>
Subject: Re: select() unblocks when no data to read()
Message-ID: <xIC8TGzlKzGfZWIOYx8ds3uHlTBVT0QrrBv-TpAN-T5tu5Jeu3qsGFUVkWzaoEahY7GDiXfhZRd_Jy2K6NIooGf9HuwfHYBsFwsIkMqxXEM=@codecraftsmen.org>
In-Reply-To: <5dbf6ceb-950a-ac49-2331-b6fe54fa0808@xenomai.org>
References: <VpFdLbJqKpBKdxuwpEr9vxR2VBu2j4uXIps1EM68ktxueh7Q9bRQeHRA56sFDKeY1xbPcvb6TuGG01MVtxNt03OdF6N1b3YIEPjJnzbRjqk=@codecraftsmen.org>
 <CALLqZ8TJt66aooCz+wCFhg_k3+xwoQ6BFqc+7TvFtA+Au71zzw@mail.gmail.com>
 <Wc_l4MYuhmN-h0Z9zuurZ_MxUaMovQA6xNvZE6EMmf7-zD8ZywQlT_X6AovXAczK01iesjy5RdARBztqwtsVxOhOBSgF3CNpXy2z8lpjU-g=@codecraftsmen.org>
 <5dbf6ceb-950a-ac49-2331-b6fe54fa0808@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Greg Gallagher <greg@embeddedgreg.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Friday, May 10, 2019 3:24 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 5/10/19 3:26 AM, Jeff Webb via Xenomai wrote:
>
> > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origina=
l Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=
=90
> > On Thursday, May 9, 2019 9:19 AM, Greg Gallagher greg@embeddedgreg.com =
wrote:
> >
> > > On Tue, May 7, 2019 at 9:54 PM Jeff Webb via Xenomai
> > > xenomai@xenomai.org wrote:
> > >
> > > > I am having trouble using select() to perform a timed wait on a UDD=
 file descriptor to detect interrupts from a custom PCI card. After some se=
arching, I came across this thread from 2017 that describes my exact issue:
> > > > https://xenomai.org/pipermail/xenomai/2017-July/037494.html
> > > > I am using x86-64 instead of ARM, but I am having the same trouble.=
 The original poster did a great job of describing the problem, so I won't =
repeat it. If I use only read() without select(), things work as expected, =
but I need to implement a timeout.
> > > > It sounds like Philippe was going to look into the issue further. H=
as any progress on this issue been made since the last post in this thread?
> > > > Thanks,
> > > > -Jeff Webb
> > >
> > > There was a fix posted to the list a while ago but it wasn't a patch
> > > it was the whole c file. I don't think a patch was ever made, I'll
> > > see if I can dig it up.
> >
> > Thanks for looking into it, Greg. I must have missed that post. The ori=
ginal poster's solution of adding this line:
> > rtdm_event_clear(&ur->pulse);
> > just before the return statement in udd_read_rt() is working for me. Ph=
ilippe mentioned that this might be racy, but maybe it's okay (or maybe not=
?) if there are no shared interrupts and interrupts are unmasked by the use=
rspace application after the read completes.
>
> There is a logic flaw on entry to read_rt, when an interrupt already occu=
rred before we consider waiting for the next one; in that case, the selecto=
r block is not reset as it should, which would explain why you get those sp=
urious select() events. Could you try the following change?

Thank you for putting together this patch, Philippe.  Sorry for the delay i=
n testing it, but it seems to work.  I tested it on Xenomai 3.0.5, but it a=
ppears there are no other significant changes to UDD since then.  I will ke=
ep using your patch and see if any more subtle issues arise.  I will also t=
est with the latest Xenomai when I get a chance.  Thank you again for takin=
g the time to look into this.

-Jeff



