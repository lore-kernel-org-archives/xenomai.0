References: <CAD5jUk8z4BibX8cQa4rnit2ihRjO0G0tg8TeyRHrHtRSHKKc5g@mail.gmail.com>
 <3eccc488-88c7-ce6f-50b2-0d85b9adefd7@xenomai.org>
 <CAD5jUk8_t05o5H+GfCfE_vU4ALgE6B==P-ukEZ3U-gOtBCafyA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <3e6203e0-27cb-829f-5be1-3623dcca401a@xenomai.org>
Date: Wed, 27 Jun 2018 17:54:00 +0200
MIME-Version: 1.0
In-Reply-To: <CAD5jUk8_t05o5H+GfCfE_vU4ALgE6B==P-ukEZ3U-gOtBCafyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Migrating some kernel code from Xenomai 2.6 to 3.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Radu Rendec <radu.rendec@gmail.com>
Cc: xenomai@xenomai.org

On 06/27/2018 05:30 PM, Radu Rendec wrote:
> On Wed, Jun 27, 2018 at 10:55 AM Philippe Gerum <rpm@xenomai.org> wrote:
>> The only API available from kernel space is RTDM. Since you already have
>> a RTDM driver in place, all you need to do is to expose a read() or
>> ioctl() service to userland, which would wait on rtdm_sem_down to be
>> posted by your IRQ handler via rtdm_sem_up.
> 
> Thanks for the detailed answer, Philippe! This should be enough to get
> me going.
> 
> On the other hand, the same semaphore is sometimes posted from user
> space and that complicates things (I guess I would have to create
> another ioctl() that posts the semaphore from kernel space).
> 

That should not amount for a lot of additional kernel code. API-wise,
you could also use read/write pairs to pend/post the sema4 instead of
ioctls.

> Since the project is on a tight schedule, I'm also considering leaving
> the code on Xenomai 2.6 for now. So here's another question: is there
> any chance Xenomai 2.6 could work on kernel 4.4? How about ipipe-core?
> 

That support won't happen in mainline, 2.6 is EOL. The changes involved
in supporting this on your end should amount to update Xenomai 2.6 for
building over newer kernels. This may or may not be easy depending on
the arch (x86 is unlikely to be that simple). The legacy I-pipe API is
still there in 4.4 and 4.9 patch series, dropped by 4.14 though.

-- 
Philippe.

