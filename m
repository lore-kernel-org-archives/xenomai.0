MIME-Version: 1.0
References: <CAAvDm6au1h8Mqwk5Dqevduk9iMJ8crvzb4pOhhZhO85EgRVCQg@mail.gmail.com>
 <20210106000413.GA28404@linux.intel.com>
In-Reply-To: <20210106000413.GA28404@linux.intel.com>
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Thu, 7 Jan 2021 10:03:06 +0800
Message-ID: <CAAvDm6bxvLaeRYvTpQM9CgewnK5qRrpV8ExQSuJ72d3axfcYRA@mail.gmail.com>
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
To: Fino Meng <fino.meng@linux.intel.com>, xenomai <xenomai@xenomai.org>

>depends on your use case, maybe possible to add a raw disk, only used by
>the time critical code?
It seems a good solution.
It's possible to add a raw disk.
One more question, does it could guarantee the read operation achieve a
real-time performance by this method(i.e occupying another disk)?
Is there still some problem that I should be aware of?

On Wed, Jan 6, 2021 at 8:05 AM Fino Meng <fino.meng@linux.intel.com> wrote:
>
> On Mon, Jan 04, 2021 at 07:58:53PM +0800, =E5=AD=99=E4=B8=96=E9=BE=99 sun=
shilong via Xenomai wrote:
> > Is it possible to implement a real-time API to read the files on the di=
sk?
> >
> > As far as I know, there is no such an interface now, but is it
> > possible to achieve this goal?
> >
> > I would be grateful to have some help with this question.
> >
> > Best Regards
> > Sunshilong
> >
>
> my first thinking, disks are heavily shared resources in a general OS, if
> realtime API occupy it for a long time, non-realtime thread all have to
> wait.
>
> read a file is too much slow compare a realtime thread's latency/jitter
> scope (< 20us)
>
> depends on your use case, maybe possible to add a raw disk, only used by
> the time critical code?
>
> BR/fino

