From: Jeffrey Melville <jmelville@mitre.org>
Message-ID: <574EFA37.5030607@mitre.org>
Date: Wed, 1 Jun 2016 11:07:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] SIGDEBUG_RESCNT_IMBALANCE with recursive mutex
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Setup: Xenomai 2.6.4 (actually 2.6 git rev 4f349cf0553, with a99426
cherry-picked) with kernel 3.14.17 on a Zynq and the POSIX skin using
the ipipe patches included with the specified git rev)

We've noticed that SIGDEBUG_RESCNT_IMBALANCE is generated when a
(Xenomai) mutex is taken recursively by an NRT thread. The snippet at
the bottom of this message will reproduce the issue. I omitted most of
the error-checking for brevity.

A couple previous threads have discussed slightly similar problems, but
I never saw final resolutions:
http://www.xenomai.org/pipermail/xenomai/2012-January/025278.html
http://www.xenomai.org/pipermail/xenomai/2014-October/031919.html

As far as "why are we doing this?", the problem area occurs in a test
suite where some tests have to run as NRT threads because they don't
have to run real-time and will get killed by the watchdog if they run as
RT threads. Removing the Xenomai wrappers would also be complicated for
reasons that are outside of the scope of this email.

Thanks,
Jeff

---
#include <stdio.h>
#include <pthread.h>

int main(int argc, char **argv)
{
    pthread_mutex_t mutex;
    pthread_mutexattr_t mutex_attr;
    pthread_mutexattr_init(&mutex_attr);
    pthread_mutexattr_settype(&mutex_attr, PTHREAD_MUTEX_RECURSIVE);
    if (pthread_mutex_init(&mutex, &mutex_attr) != 0)
    {
        printf("Failed to initialize mutex.\n");
        return 1;
    }
    pthread_mutexattr_destroy(&mutex_attr);
    pthread_mutex_lock(&mutex);
    pthread_mutex_lock(&mutex);
    pthread_mutex_unlock(&mutex);
    pthread_mutex_unlock(&mutex);
    pthread_mutex_destroy(&mutex);
    return 0;
}

