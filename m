MIME-Version: 1.0
In-Reply-To: <54D0A0C2.3050905@xenomai.org>
References: <CAEMXjGyps7NpBUYgC4j4TrVKbiAZsceiuQ71TymDtXz-a3fqbA@mail.gmail.com>
 <54CCAA6D.4030007@xenomai.org>
 <CAEMXjGyNHrnCRXjVQq8FaWAVdzN1x3079QT0J_bCx_8VfNoQxA@mail.gmail.com>
 <54D0A0C2.3050905@xenomai.org>
Date: Fri, 6 Feb 2015 16:31:27 -0800
Message-ID: <CAEMXjGzdbv4F5eNAiLs51xJj+3qRtpRaCgm40SDF-n3nZ=stzQ@mail.gmail.com>
From: Steve B <sbattazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] POSIX skin, task crashes Linux when run as RT task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

> >> I actually found XDDP to be very handy for another part of my
> application,
> > but I hadn't thought of using it for the part where the main thread puts
> > its messages out to hardware. I may look into it for this as well, but I
> > have been thinking that porting the driver to RTDM is the actual best
> > solution if it turns out the mode switches are part of the critical path.
> >
>
> A dedicated RTDM driver is definitely the way to go for driving a device
> in pure rt mode.
>
>
>
Phillippe, thanks for the help on trying to track this issue down!
I built a simple Xenomai application to over consume CPU sporadically, and
found that if I set it to 100% CPU it would trigger the watchdog as it was
supposed to, so my main work thread taking up a lot of CPU could not alone
be the root cause for this. In the minimum configuration of my real
software where I was getting the issue, the only other things running were
threads to listen to a UART and to listen to the CAN bus, which I was doing
with the regular old Linux device drivers because RTDM ones did not seem to
be available.
I was able to reproduce the crash with my simple CPU-burner application by
adding the UART and CAN bus routines to it, and I was able to make it not
crash by taking away the sporadic deadline misses. So I came to the
conclusion that the combination of the deadline miss and the UART/CAN
receiver loops was somehow causing my issue. Unfortunately I'm not exactly
sure how to pinpoint it any deeper than that.

I bit the bullet and spent a couple days to port the Beaglebone Black CAN
bus driver to work with RTDM, and after switching to that my problem seems
to have been solved.
I would like to offer to contribute my device driver to Xenomai if anybody
is interested in having it. Will check with my employer/customer and make
sure there isn't any red tape I have to go through and then I will start a
new thread on that later.

Steve
