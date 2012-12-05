MIME-Version: 1.0
In-Reply-To: <CANKLDmvhj_sbQnLgmWSo6QsOnrB1CnJcpvg0DRbnW+X93bozbQ@mail.gmail.com>
References: <CANKLDmvSr6j-=6T-YGCG8byGsZ6oy_7sTmcknL7YC8uk9ymTrQ@mail.gmail.com>
	<CANKLDmvhj_sbQnLgmWSo6QsOnrB1CnJcpvg0DRbnW+X93bozbQ@mail.gmail.com>
Date: Wed, 5 Dec 2012 18:08:19 +0100
Message-ID: <CANKLDms4gtzdTngtENm4aJrh_aXN5283yNLi-NuY9SCuNPgoLQ@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Strange behavior calling certain libraries from
 non-realtime shadow task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Wed, Dec 5, 2012 at 12:42 PM, Henri Roosen <henriroosen@gmail.com> wrote:

>
>
>
> On Tue, Dec 4, 2012 at 5:53 PM, Henri Roosen <henriroosen@gmail.com>wrote:
>
>> Hi,
>>
>> I have a task that is using the libvlc (v2.0.4) library to play some
>> media streams. This all works when it is a normal posix task. When the task
>> is a non-realtime shadow task (prio 0, autorelax), then the shared
>> libraries that libvlc loads (its plugins, codecs etc) get corrupted on
>> disk. A second run of the program is not working.
>>
>
> The files get corrupted when they are loaded with a dlopen() call.
> Is a dlopen() call allowed from a shadowed non-realtime task? Or what can
> cause the loaded library to get corrupted at this point?
>
> Traced this problem a little further. We found out the problem was easy to
reproduce running the testcode below. An md5sum on the
file /usr/lib/libavutil.so.50 before and after calling the application
shows the md5 of this file changed.

Debugging into dlopen() was not easy, but it looked like the file changed
somewhere around were the file was mapped to memory.

In parallel we found out the problem was not reproducable on our "next"
development status which uses xenomai-2.6.1+ and kernel 3.4.6. A step by
step upgrade of the platform showed that the problem disappeared after
upgrading the kernel form 2.6.38.8 (ipipe-2.6.38.8-x86-2.11-02) to 3.4.6
(git 0bd76072135271ad58e7bea559acb524ab8c7dfe).

Now I would like to find out if this behavior is fix with a newer kernel or
whether it is hidden.
Does anyone on the list have any input on this?

#include <stdio.h>
#include <sys/mman.h>
#include <native/task.h>
#include <dlfcn.h>

#define CONFIG_RT_SHADOW

int main(int argc, char *argv[])
{
mlockall(MCL_CURRENT | MCL_FUTURE);
#ifdef CONFIG_RT_SHADOW
rt_task_shadow(NULL, "main", 0, 0);
#endif
dlopen("/usr/lib/libavutil.so.50", 1);
return 0;
}


>> Does anyone know what can be causing this? I was under the impression an
>> autorelaxed shadow task was allowed to make all Linux calls. Are there
>> known limitations or is this a bug?
>>
>>  Platform: x86
>> Xenomai 2.5.6
>> Linux 2.6.38.8
>>
>> Thanks,
>> Henri
>>
>
>
