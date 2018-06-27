MIME-Version: 1.0
From: Radu Rendec <radu.rendec@gmail.com>
Date: Wed, 27 Jun 2018 09:52:14 -0400
Message-ID: <CAD5jUk8z4BibX8cQa4rnit2ihRjO0G0tg8TeyRHrHtRSHKKc5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Migrating some kernel code from Xenomai 2.6 to 3.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

I need to port some kernel and application code from Xenomai 2.6 to
Xenomai 3.0.

The existing code creates a semaphore with sem_open() from the *kernel*
module init function and posts it with sem_post() from a rtdm interrupt
handler (which is also part of the kernel module). The application opens
the same semaphore and synchronizes on it using sem_wait().

I can see that the xenomai/posix/posix.h header is gone from the kernel
tree. What is the correct way of accessing the semaphore from the kernel
code? What headers need to be included?

The migration guide focuses more on the application side, but doesn't
provide much info for the kernel side. By the way, the old link to the
guide at https://xenomai.org/migrating-from-xenomai-2-x-to-3-x/ seems
to be broken after the gitlab migration.

Thanks,
Radu Rendec

