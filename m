MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 15 Jul 2019 23:30:56 +0200
Message-ID: <CAFLxGvw7QBucCM47XXq2RJe1YtQ_wuGVrNg8ZPkUSmXYB04HHg@mail.gmail.com>
Subject: rt_mutex_acquire() does not return EINTR upon rt_task_unblock()
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

Sorry for asking so many questions on RT_MUTEX.

Docs on rt_mutex_acquire variants state:
-EINTR is returned if rt_task_unblock() was called for the current task.

This does not seems to be the case, pthread_mutex_lock() in lib/cobalt/mutex.c
does:
        do
                ret = XENOMAI_SYSCALL1(sc_cobalt_mutex_lock, _mutex);
        while (ret == -EINTR);

So, upon rt_task_unblock() the while loop does one more iteration but
blocks again
and the function will never return with -EINTR.

I guess the recommenced approach is posting a signal to a task before calling
rt_task_unblock()? Then the task can exit in a more or less controlled way.

-- 
Thanks,
//richard

