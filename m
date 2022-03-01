MIME-Version: 1.0
References: <CAPEvDeBTsSZRW3jBZZnwmyV4fUMNDvohGHsPxX=kj_9kRHLoHQ@mail.gmail.com>
 <48156ea9-7f01-b172-a21d-a518687bd824@siemens.com>
 <CAPEvDeALuyu-WSZEDiquDprwhpB8iXBEoKg7em2jAua+XCyx8Q@mail.gmail.com>
 <63e1d80d-2f45-7989-c8ed-736feb339261@siemens.com>
In-Reply-To: <63e1d80d-2f45-7989-c8ed-736feb339261@siemens.com>
From: FJKONG <bh1scw@gmail.com>
Date: Tue, 1 Mar 2022 22:03:56 +0800
Message-ID: <CAPEvDeC4bvskoUwYsUqyimetA1hyNVFPTeBuHPFpbofoEn7bEQ@mail.gmail.com>
Subject: Re: Question about apply xenomai patch to RT kernel
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Tue, Mar 1, 2022 at 7:17 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 01.03.22 10:02, FJKONG wrote:
> >
> >
> > On Tue, Mar 1, 2022 at 3:24 PM Jan Kiszka <jan.kiszka@siemens.com
> > <mailto:jan.kiszka@siemens.com>> wrote:
> >
> >     On 01.03.22 02:23, FJKONG via Xenomai wrote:
> >     > Hi all,
> >     >
> >     > I am trying to apply xenomai patch to RT kernel, but there are some
> >     > conflicts.
> >     > I am not sure if xenomai can works with RT kernel, or should I
> >     remove RT
> >     > from kernel and then apply xenomai patch.
> >     > what is the right way to fix this?
> >
> >     The easiest path forward right now is likely using 5.15 (with
> dovetail
> >     patch), maybe even 5.16. There, the conflicts should be much smaller
> >     than with older kernels where the remaining RT patch was much larger.
> >     But I don't have information about recent attempts to make this
> working,
> >     so there might be additional issues.
> >
> > Thanks for replying.
> >
> > Here is our story: we got bsp from other company, so the kernel version
>
> Then your bigger problem is likely not RT but those BSP bits not coming
> from upstream, thus having questionable quality AND possible integration
> problems with Dovetail.
>
> Yes yes,  because I remove RT patch and then apply the dovetail patch,
but some driver require function from RT patch.
I will triy to get this done and test building later.

> Can't you run your SoC from mainline? What is the actual delta to
> mainline, 5.10 or latest master?
>
> not try yet, but I guess that's hard because the driver and dtb.

Jan
>
> > is fixed already and the RT patch is already there.
> > I can reverse apply RT patch now,  but some driver error shows up :
> >  "write_atomic" is not found any more.
> > so I am stuck on this error now.
> >
> >     Which version did you try?
> >
> >
> > I am using 5.10.41
> >
> > Thanks
> > Kong
> >
> >
> >     Jan
> >
> >     --
> >     Siemens AG, Technology
> >     Competence Center Embedded Linux
> >
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>
