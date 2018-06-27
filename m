MIME-Version: 1.0
References: <CAD5jUk8z4BibX8cQa4rnit2ihRjO0G0tg8TeyRHrHtRSHKKc5g@mail.gmail.com>
 <3eccc488-88c7-ce6f-50b2-0d85b9adefd7@xenomai.org>
In-Reply-To: <3eccc488-88c7-ce6f-50b2-0d85b9adefd7@xenomai.org>
From: Radu Rendec <radu.rendec@gmail.com>
Date: Wed, 27 Jun 2018 11:30:02 -0400
Message-ID: <CAD5jUk8_t05o5H+GfCfE_vU4ALgE6B==P-ukEZ3U-gOtBCafyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Migrating some kernel code from Xenomai 2.6 to 3.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

On Wed, Jun 27, 2018 at 10:55 AM Philippe Gerum <rpm@xenomai.org> wrote:
> The only API available from kernel space is RTDM. Since you already have
> a RTDM driver in place, all you need to do is to expose a read() or
> ioctl() service to userland, which would wait on rtdm_sem_down to be
> posted by your IRQ handler via rtdm_sem_up.

Thanks for the detailed answer, Philippe! This should be enough to get
me going.

On the other hand, the same semaphore is sometimes posted from user
space and that complicates things (I guess I would have to create
another ioctl() that posts the semaphore from kernel space).

Since the project is on a tight schedule, I'm also considering leaving
the code on Xenomai 2.6 for now. So here's another question: is there
any chance Xenomai 2.6 could work on kernel 4.4? How about ipipe-core?

It looks like Xenomai 2.6 requires the "legacy" API of ipipe-core and
that doesn't seem to compile on kernel 4.4.

Thanks,
Radu

