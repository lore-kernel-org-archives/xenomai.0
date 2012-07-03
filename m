MIME-Version: 1.0
In-Reply-To: <4FEC13B1.3040609@xenomai.org>
References: <CANKLDmuw2sM5PD0G1YvObij1dZvdm743hEMMP=6Ljg+k2ZSOQQ@mail.gmail.com>
	<4FEC13B1.3040609@xenomai.org>
Date: Tue, 3 Jul 2012 20:08:48 +0200
Message-ID: <CANKLDmttLXBxdtXss9cWyYtXayBvZeZ74sO6r6KEshMxmLM+kQ@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] How setup receive-timeout for rt_dev_recvfrom?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Jun 28, 2012 at 10:20 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 06/28/2012 10:05 AM, Henri Roosen wrote:
>> Hi Xenomai-list,
>>
>> I am using the native API and RTDM to read from a RTNet realtime interface.
>> This all works, however, I need a timeout on the rt_dev_recvfrom.
>>
>> As there is no rt_dev_select function, I tried to setup a receive
>> timeout, similar to how the XDDP examples do:
>
> The posix skin has select, which can be used by native skin threads. You
> have to use the result of socket, and not rt_dev_socket as the fd to put
> in the fd_set, but apart from that, it should work.

Thanks Gilles for your reply! However, I didn't try your suggestion,
because we cannot easily bind the posix skin to our application.

But I found out that RTNet supports setting a timeout on a socket that
is used by rt_dev_recvfrom(). So for the case that anyone is looking
for how to setup a receive timeout, here is what worked for me:

		#include <rtnet.h>
		nanosecs_rel_t timeout = 1000000000LL;
		...
		ret = rt_dev_ioctl(s, RTNET_RTIOC_TIMEOUT, &timeout);

Thanks,
Henri.

>
> --
>                                             Gilles.

