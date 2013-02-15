MIME-Version: 1.0
In-Reply-To: <CAJjOJyaVV0QwCidpVmX7py9NT=u+4zsbhjCtddrp3EyPnxeDwA@mail.gmail.com>
References: <CAJjOJyZ3H=ffAT1JbqPr4DEpZsHmAdNXt+eZuWKhg0xhVd+T1w@mail.gmail.com>
	<511CD1F2.50307@xenomai.org>
	<CAJjOJyYYddyTeQ18EHiFaRoYRQnV3v5=rJgJHRLW9cWNJDZ_=Q@mail.gmail.com>
	<511E2756.2010301@xenomai.org>
	<CAJjOJyaVV0QwCidpVmX7py9NT=u+4zsbhjCtddrp3EyPnxeDwA@mail.gmail.com>
Date: Fri, 15 Feb 2013 04:32:36 -0800
Message-ID: <CAJjOJyZQ4G2UftJhQy0V7pPsFzUe4CjNuGkYzmLWQf8aXrqGqw@mail.gmail.com>
From: Jonathan Wallace <jonmon6691@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai]  Kernel choice for Xenomai on the Beagle Bone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Fri, Feb 15, 2013 at 4:17 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 02/15/2013 12:12 PM, Jonathan Wallace wrote:
>
> > Thanks for the info Gilles, I went with 3.2.21. There's a lot
> > more information on getting that version patched for the Beagle Bone
> > floating around. So I've gotten as far as a successful compile, but the
> > board hangs during boot without any useful information. Here's the
> > console log:
> >
>
> > (...)
> >
>
> > Uncompressing Linux... done, booting the kernel.
> > [    0.230661] tps65910 1-002d: could not be detected
>
>
> See:
>
> http://xenomai.org/index.php/I-pipe-core:ArmPorting#The_kernel_stops_after_the_message_.22Uncompressing_Linux..._done.2C_booting_the_kernel..22
>
> --
>                                                                 Gilles.
>
You rock Gilles, that's exactly what I needed. But I ended up side-stepping
the problem by using a known-working .config (part of git://
github.com/RobertCNelson/linux-dev.git for the record) and merging in the
xenomai options. The true problem was trying to configure the kernel for my
board from scratch. I'm booted up now and I think that's enough for now
(its 4:30am, I'll save getting the latency test to run for tomorrow.)
Thanks again for the help, I'm doing my best to figure this out as I go.

-Jon RW
