MIME-Version: 1.0
Date: Tue, 25 Mar 2014 07:33:00 +0000
Message-ID: <CAKJ14NcMmp5ikYEmot_sOmLChz7Amgi=5ZR4BX+NM23BB8yk8g@mail.gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Raspberry Pi SD Card Issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

> Message: 4
> Date: Mon, 24 Mar 2014 11:01:58 -0400
> From: Adam Vaughan <vaughana@umich.edu>
> To: "xenomai@xenomai.org" <xenomai@xenomai.org>
> Subject: Re: [Xenomai] Raspberry Pi SD Card Issue
> Message-ID:
>         <
> CAK4EZFRdaFwbsZ0FOPZmQiddc2jzWNN-9sCbX9k8L8wtb-R11Q@mail.gmail.com>
> Content-Type: text/plain; charset=ISO-8859-1
>
> > However, the cited commit (
> > http://crosstool-ng.org/hg/crosstool-ng/rev/86a8d1d467c8 ) looks
> > unsuspicious to me. Could you elaborate how this might influence the
> > generated kernel binaries?
>
> I don't think that particular commit caused it.  I just mentioned the
> commit so people would know around when the issue was happening if
> they're looking to reproduce the problem.
>
> Also, I'm not completely sure I was using 86a8d1d467c8 or something
> more recent.  I deleted the toolchain after I identified it as the
> cause, but my notes say it was 86a8d1d467c8.  My notes are fairly
> thorough, but I don't always update them and I vaguely remember
> rebuilding the toolchain at a later date.  It could just be a figment
> of my imagination.
>
> Anyway, I mentioned the toolchain issue because I would have never
> guessed a toolchain could produce a kernel that booted and seemed fine
> except for what appeared to be some kind of race condition within the
> SD card driver when it was under heavy load.  As you may know, the
> Raspberry Pi 3.8.13 kernel branch isn't being maintained and the
> kernel drivers (especially USB) have been patched up quite a bit since
> the device's introduction, so I think it's entirely reasonable to
> suspect the code is broken, not the toolchain.
>

Don't get me wrong. I definitely know that different toolchains produce
different binaries and I certainly can believe that issues like this can
arise due to some toolchain "optimizations" or toolchain bugs. Those are
usually the most tricky bugs to find as I still can remember and every
little clue can be help in tracking them down that's why I was asking.


>
> As for the actual cause within the toolchain, I really have no idea.
> I have to finish my thesis research, so I have almost no free time to
> investigate the cause beyond just noting a different toolchain made
> all my problems go away.
>

Thanks again for looking into this. Good luck w your thesis.
