From: Paul <paul_c@tuxcnc.org>
Date: Wed, 2 Apr 2014 19:10:06 +0100
References: <CAEbDrgmdy_u5O-1VW+sE6bF4xbM9QaQTtGZh7Ljf8TnDiCpT6w@mail.gmail.com>
 <201404021840.39308.paul_c@tuxcnc.org>
 <CAEbDrgnr9yqa=SoZBjQqR-xRJYDxg1hP4WrKmAgphqv5hW9jfQ@mail.gmail.com>
In-Reply-To: <CAEbDrgnr9yqa=SoZBjQqR-xRJYDxg1hP4WrKmAgphqv5hW9jfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201404021910.06245.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] [patch] Raspberry Pi - 3.10.34
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gregory Dymarek <gregd72002@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wednesday 02 April 2014, Gregory Dymarek wrote:
> Well, have you looked inside it?

Yes, which is why I said "don't patch a patch".

> it consists of 3 items:
> 1) local_fiq_enable/disable fix
>     - from previous discussions it was obvious this should be in the
> ipipe-core patch
>     - it is not raspberry pi specific

Not RPi specific, but would be in post-patch.

>
> 2) clockchips.h fix
>     - a systemic change to linux-kernel breaks this
>     - it is not raspberry pi specific

You have a couple of nugatory lines - White space changes perhaps ?
The main thrust appears to be the addition of struct module to 
clock_event_device. IF that is the only change, then post-patch or 
pre-patch if it prevents ipipe-core from applying cleanly.

>
> 3) PAGE_SIZE vs FIRST_USER_ADDRESS
>    - this looks like a conflict between vanilla kernel and raspberry
> pi kernel that rejects the original ipipe patch

pre-patch to revert the conflict and then post-patch to update as long 
as it doesn't introduce any bugs in the affected routine.

>    - what do you suggest to do?
>
> On 2 April 2014 18:40, Paul <paul_c@tuxcnc.org> wrote:
> > On Wednesday 02 April 2014, Gregory Dymarek wrote:
> >> Hi,
> >>
> >> Enclosed patches needed to get Xenomai compiled on Raspbery Pi
> >> kernel 3.10.34 (github sha:
> >> 7cf0cf0d3e53b4c62f4931bb2d7cb60a1a07b132)
> >>
> >> This is based on ipipe-core-3.10.18-arm-1.patch.
> >>
> >> Steps:
> >> 1) get ipipe-core-3.10.18-arm-1.patch
> >> 2) patch it using rpi-ipipe-core-3.10.34-arm-1.patch
> >
> > No.
> >
> > The pre-patch is applied to the kernel sources so that the
> > corresponding ipipe-core patch applies cleanly. Do not patch a
> > patch to fix a problem.
> >
> >> 3) do prepare_kernel.sh or patch the kernel using the above patch
> >> 4) patch kernel using
> >> ipipe-core-3.10.34-arm-raspberry-post-1.patch 5) done



