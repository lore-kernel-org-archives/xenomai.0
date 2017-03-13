References: <1051219559.580434.1487468293843.ref@mail.yahoo.com>
 <1051219559.580434.1487468293843@mail.yahoo.com>
 <913208909.4906404.1489152866278@mail.yahoo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <68a66f07-c704-13c1-61b7-3157a4fe79ca@xenomai.org>
Date: Mon, 13 Mar 2017 12:52:35 +0100
MIME-Version: 1.0
In-Reply-To: <913208909.4906404.1489152866278@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] pthread_rt and C++ on Xenomai 2.6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <giuliomoro@yahoo.it>, Xenomai <xenomai@xenomai.org>

On 03/10/2017 02:34 PM, Giulio Moro wrote:
> I think I now have the answer to this question which was - admittedly - not formulated very clearly.
> The answer I came up with is: it depends on how your c++ standard library is implemented. The one we use (libstdc++.so which comes with gcc 4.9) does not make all the calls to the pthread API that I would expect. For instance, it does not call "pthread_mutex_init" but it calls "gthread_mutex_init". Therefore, wrapping does not work properly for the mutex API.
> Perhaps other implementations of the C++ standard library would be more wrapping-friendly in this sense.Has there been any effort in writing a Xenomai-wrappable (or Xenomai-friendly) C++ standard library?
> Thanks,Giulio
> 
> 
>       From: Giulio Moro <giuliomoro@yahoo.it>
>  To: Xenomai <xenomai@xenomai.org> 
>  Sent: Sunday, 19 February 2017, 1:38
>  Subject: pthread_rt and C++ on Xenomai 2.6
>    
> What's the deal with using the posix skin to wrap C++ mutex, locks and threads?
> I am on ARMv7 (Beaglebone Black), with gcc 4.9, xeno-config on this system returns the following:$ /usr/xenomai/bin/xeno-config --skin=posix --ldflags --cflags-Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lrt-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -I/usr/xenomai/include/posix
> The example code here http://www.cplusplus.com/reference/mutex/mutex/try_lock/
> compiles and runs fine (i.e.: I get a reasonable number of increases of the counter) with (1) g++ -pthread test.cpp -std=c++14 -lpthread
> 
> but if I wrap the posix calls with(2) gcc test.cpp -std=c++14  -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -I/usr/xenomai/include/posix -L/usr/xenomai/lib -lstdc++ -lpthread_rt -lxenomai -lpthread -lrt -Wl,@/usr/xenomai/lib/posix.wrappers -pthread
> then the mutex can never be acquired by any thread. Actually, I cannot lock it even if I place mtx.try_lock() on the first line of main().Also, if I try to sleep at sleep just before the end of attempt_10k_increases() with "std::this_thread::sleep_for", it does not sleep. Even if I increase the number of attempts, in order for the threads to stay alive for longer, I cannot see the threads show up in /proc/xenomai/stat .
> What I observe is that when using -Wl,@/usr/xenomai/lib/posix.wrapper:- mutex::try_lock fails- std::this_thread::sleep_for() does not sleep- threads do not show up in /proc/xenomai/stat
> So I have two questions:a) is there any way to get -Wl,@/usr/xenomai/lib/posix.wrappers to correctly wrap underlying calls to pthread_* functions which are hidden in libstdc++ ?b)

Only if the static version of libstdc++ is used, otherwise it's too late
for the linker to do any wrapping, since it obviously won't update a
shared library on the fly while building an application which depends on it.

 is there any way to safely link into the same executable some code that
calls pthread_* which you want to wrap in the Xenomai posix skin and C++
code which uses std::thread?

You bring the safety by not passing POSIX resources initialized by
libcobalt (e.g. pthread_mutex_init(), pthread_create(), sem_init() and
so on) to methods dealing with POSIX resources created by the regular
libc, and conversely.

-- 
Philippe.

