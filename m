MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Thu, 4 Jun 2020 22:14:01 +0800
Message-ID: <CAAvDm6bG5sKj_4qpEJX5eP3M32b2YqMymTok3w9xFZwrBAFO+g@mail.gmail.com>
Subject: Questions about XDDP.
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

As per the documentation
(
*https://xenomai.org/documentation/xenomai-3/html/xeno3prm/
<https://xenomai.org/documentation/xenomai-3/html/xeno3prm/>group__trank.html#details*),i
can draw the conclusion that
the non real-time side could block upon attempt to open the
special device file until the corresponding one is opened
from a Xenomai thread,unless *O_NONBLOCK *was given to the
open(2) system call.Could you tell the reasons lie behind?
Why does the non real-time side need to be blocked while the
corresponding one has not been opened from a Xenomai thread?





*In addition, I found that it could returned immediately indeed if the non
real-time side is opened(2) with O_NONBLOCK as described in the
documentation, but it also returned the errorwhich says:"open rtp0 returned
error: Resource temporarily unavailable".*
I do this experiment on Ubuntu16.04(kernel 4.19.84 + xenomai3.1).
The related code is listed below.I thought over and over, but i
can not understand it.
I would be grateful to have some help with this question.

One more unimportant question,through some tests, I found that *XDD*
could not be used to communicate between two linux threads .
Am i right?

Thank you for your attention.
Look forward to hearing from you.


#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define XDDP_PORT 0

static void fail(const char *reason)
{
    perror(reason);
    exit(EXIT_FAILURE);
}

int main()
{

    char buf[128];
    memset(buf,0,sizeof(buf));
    int fd, ret,outwrite;

    fd = open("/dev/rtp0", O_WRONLY|O_NONBLOCK);

    if(fd<0)
{
fail("open rtp0 returned error:");
}

    for(;;)
    {
         outwrite=write(fd,buf,sizeof(buf));
    }
}
