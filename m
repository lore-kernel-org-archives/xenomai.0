References: <CAD5jUk8z4BibX8cQa4rnit2ihRjO0G0tg8TeyRHrHtRSHKKc5g@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <3eccc488-88c7-ce6f-50b2-0d85b9adefd7@xenomai.org>
Date: Wed, 27 Jun 2018 16:55:40 +0200
MIME-Version: 1.0
In-Reply-To: <CAD5jUk8z4BibX8cQa4rnit2ihRjO0G0tg8TeyRHrHtRSHKKc5g@mail.gmail.com>
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
To: Radu Rendec <radu.rendec@gmail.com>, xenomai@xenomai.org

On 06/27/2018 03:52 PM, Radu Rendec wrote:
> Hi all,
> 
> I need to port some kernel and application code from Xenomai 2.6 to
> Xenomai 3.0.
> 
> The existing code creates a semaphore with sem_open() from the *kernel*
> module init function and posts it with sem_post() from a rtdm interrupt
> handler (which is also part of the kernel module). The application opens
> the same semaphore and synchronizes on it using sem_wait().
> 
> I can see that the xenomai/posix/posix.h header is gone from the kernel
> tree. What is the correct way of accessing the semaphore from the kernel
> code? What headers need to be included?
> 

The only API available from kernel space is RTDM. Since you already have
a RTDM driver in place, all you need to do is to expose a read() or
ioctl() service to userland, which would wait on rtdm_sem_down to be
posted by your IRQ handler via rtdm_sem_up.

The naming part would be solved by opening that particular (named)
device your RTDM driver would create.

e.g. depending on your choice on the kernel side, you would have
something like this in userland:

fd = open("/dev/rtdm/your-device", O_RDWR);
...
ret = read(fd, ...);
OR,
ret = ioctl(fd, ...);

select() could be made available in both cases too.

> The migration guide focuses more on the application side, but doesn't
> provide much info for the kernel side. By the way, the old link to the
> guide at https://xenomai.org/migrating-from-xenomai-2-x-to-3-x/ seems
> to be broken after the gitlab migration.
> 

Fixed, thanks.

-- 
Philippe.

