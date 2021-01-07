MIME-Version: 1.0
References: <CAAvDm6au1h8Mqwk5Dqevduk9iMJ8crvzb4pOhhZhO85EgRVCQg@mail.gmail.com>
 <20210106000413.GA28404@linux.intel.com>
 <CAAvDm6bxvLaeRYvTpQM9CgewnK5qRrpV8ExQSuJ72d3axfcYRA@mail.gmail.com>
 <119111.1610018046@gemini.denx.de>
In-Reply-To: <119111.1610018046@gemini.denx.de>
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Thu, 7 Jan 2021 20:12:18 +0800
Message-ID: <CAAvDm6ZsQwrFoLfjnespyx65cmzWgYXGk=dyUE_UD5-dAUKaNQ@mail.gmail.com>
Subject: Re: Is it possible to implement a real-time API to read the files on
 the disk?
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
To: Wolfgang Denk <wd@denx.de>
Cc: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmcgdmlhIFhlbm9tYWk=?= <xenomai@xenomai.org>, Fino Meng <fino.meng@linux.intel.com>

I see. Thank you for your detailed explanation.

My understanding of this question is at a different level with your
generous help.

>You can guarantee _average_ data for I/O to storage devices, like a
>guaranteed sustained throughput (*), but you will not be able to
>guarantee any hard real-time behaviour (like latencies or such).
It seems that real-time OS could not guarantee a hard real-time
behaviour for reading files.

Two more questions arise:
1. A lot of real-time applications based on Xenomai have to meet this
 problem (i.e reading files), how do you solve it?
Reading files by non-rt thread and sending the data(or the pointer to
the data) to the rt thread by XDDP?

2.Can I draw the conclusion that there is no real-time OS that could
guarantee a hard real-time behaviour for reading?

Best regards.
Sunshilong

On Thu, Jan 7, 2021 at 7:14 PM Wolfgang Denk <wd@denx.de> wrote:
>
> Dear =E5=AD=99=E4=B8=96=E9=BE=99 sunshilong,
>
> In message <CAAvDm6bxvLaeRYvTpQM9CgewnK5qRrpV8ExQSuJ72d3axfcYRA@mail.gmai=
l.com> you wrote:
> > >depends on your use case, maybe possible to add a raw disk, only used =
by
> > >the time critical code?
> > It seems a good solution.
> > It's possible to add a raw disk.
>
> This will not help you at all.  The key problem here is that common
> storage devices (conventional rotating hard disk drives, SSD,
> SDCards, eMMC, USB sticks, CF Cards, ....) are all not real-time
> capable itself.
>
> They all contain controllers to manage the storage device, and
> strict real-time behaviour has never been a design criteria for the
> firmware running on these controllers.
>
> Rotating harddisks can do all kind of maintainance tasks, including
> retries when they detect positioning and/or I/O errors,
> re-allocation of defective sectores, recalibration, etc. Not to
> mention that - depending on your configuration - they may even spin
> down to save power and will need many seconds to spin up when waking
> up.
>
> All other storage devices are flash based, so the controller will
> have to take care of wear levelling, trimming, garbage collection
> etc.
>
> Try to get any guaranteed data for response times from any of the
> vendors of your prefereed sotage data (i. e. ask: what is the
> _guaranteed_ maximum time between sending a read request for a
> specific block of data and receiving this data on the interface?)
> I would not expect any precise technical answers.
>
>
> You can guarantee _average_ data for I/O to storage devices, like a
> guaranteed sustained throughput (*), but you will not be able to
> guarantee any hard real-time behaviour (like latencies or such).
>
> (*) And this guarantee will hold only as long as you do not
> encounter any errors on the storage device, which can _always_
> happen, so your real-time processes should better not depend on it
> if they control any critical equipment.
>
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> As long as we're going to reinvent the wheel again, we might as  well
> try making it round this time.                        - Mike Dennison

