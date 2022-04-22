MIME-Version: 1.0
From: Ashwik John <johnashwik994@gmail.com>
Date: Fri, 22 Apr 2022 17:11:16 +0200
Message-ID: <CAESnvfOv9xfzqPrTxXjT7z-U+7MYMt+YQESoiQa07icMutd5aw@mail.gmail.com>
Subject: Re: First application
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

Hi,

What is the procedure to build and run the application with EVL? For
example a fifo thread.

#include <sys/types.h>
#include <unistd.h>
#include <sched.h>
#include <pthread.h>
#include <evl/sched.h>
#include <evl/thread.h>

int main(int argc, char *argv[])
{
struct sched_param param;
int ret, tfd;

param.sched_priority = 8;
ret = pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);

tfd = evl_attach_self("app-main-thread:%d", getpid());
}

Thank you,
