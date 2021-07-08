MIME-Version: 1.0
References: <CAFLxGvy9BSEiRwzJximQLEqn_n=OfgaQcvKpxWSSRYPeeGn-yA@mail.gmail.com>
 <2c2f612c-5a56-0bb7-735c-4d3c4fe13aaa@siemens.com>
 <CAFLxGvzDE0NpXGjxEyGhnjC__3oEq4iSkcDJzFPWB68S6wF2dA@mail.gmail.com>
 <aa766270-994e-2cc4-1e37-52b3dc55e132@siemens.com>
In-Reply-To: <aa766270-994e-2cc4-1e37-52b3dc55e132@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 8 Jul 2021 12:04:30 +0200
Message-ID: <CAFLxGvyn5SdGr8v8tNGCh8w7ciJLwY2wgLVsqiyxkBNXJvmVHg@mail.gmail.com>
Subject: Re: rt_task_shadow() secondary mode
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
Cc: Xenomai <xenomai@xenomai.org>

On Thu, Jul 8, 2021 at 11:54 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 08.07.21 11:51, Richard Weinberger wrote:
> > On Thu, Jul 8, 2021 at 11:25 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >> The general philosophy of Xenomai is that applications should not rely
> >> on the exact switching behavior. So the question would be why your
> >> application needs one or the other behavior?
> >
> > In this particular case the application uses the ioctl() system call
> > to call into a
> > xenomai kernel module. The module implements the rt and nrt variant of
> > ioctl() and
> > the application assumes which version of the ioctl() implementation
> > will get reached.
>
> ...that might be the actual design bug. If a driver implements the a
> service for both calling modes, the service should effectively do the
> same, ie. should be mode-agnostic. Seems, this was violated here.

Can be, the driver was designed a long time ago. :-)
In the nrt ioctl() the driver uses e.g. ioremap(), this cannot work in primary
mode. Is the desired approach switching to secondary mode when in primary
mode such a code path is to be executed?

-- 
Thanks,
//richard

