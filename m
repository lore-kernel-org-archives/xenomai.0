MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 6 Mar 2019 10:59:23 +0100
Message-ID: <CAFLxGvxXBx+7UWD0aySskKxbrZHjvTBmJNvCEdfoBgLQOACHcw@mail.gmail.com>
Subject: Mixing cobalt and alchemy?
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi!

I have a Xenomai 2.6 application which makes heavy usage of
rt_dev_ioctl() and shadow threads
with rt_task_shadow().

If I understand the new Xenomai 3 API correctly, rt_dev_ioctl() for
userspace is gone and the cobalt wrappers should be used such that
plain ioctl() calls will be routed through libcobalt.
What I don't fully understand is how to mix these with the alchemy
skin such that the application can use rt_task_shadow() and friends
because the cobalt wrapper also wraps pthread_create().
The application simply does not fully fit in either cobalt nor alchemy skins.

Is it legal to modify lib/cobalt/cobalt.wrappers to wrap only read/close/ioctl?
Or can I directly issue cobalt syscalls from the application?

-- 
Thanks,
//richard

