References: <CAESnvfOv9xfzqPrTxXjT7z-U+7MYMt+YQESoiQa07icMutd5aw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: First application
Date: Sun, 24 Apr 2022 17:49:33 +0200
In-reply-to: <CAESnvfOv9xfzqPrTxXjT7z-U+7MYMt+YQESoiQa07icMutd5aw@mail.gmail.com>
Message-ID: <875ymy1nx3.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ashwik John <johnashwik994@gmail.com>
Cc: xenomai@xenomai.org


Ashwik John via Xenomai <xenomai@xenomai.org> writes:

> Hi,
>
> What is the procedure to build and run the application with EVL? For
> example a fifo thread.
>
> #include <sys/types.h>
> #include <unistd.h>
> #include <sched.h>
> #include <pthread.h>
> #include <evl/sched.h>
> #include <evl/thread.h>
>
> int main(int argc, char *argv[])
> {
> struct sched_param param;
> int ret, tfd;
>
> param.sched_priority = 8;
> ret = pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
>
> tfd = evl_attach_self("app-main-thread:%d", getpid());
> }
>
> Thank you,

See https://evlproject.org/core/user-api/#build-evl-app

-- 
Philippe.

