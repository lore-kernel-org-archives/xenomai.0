MIME-Version: 1.0
Date: Wed, 5 Aug 2015 09:09:41 -0400
Message-ID: <CAHoW4hFHAmGqFOdDp3QHXK-6w0NQEw8XBxOc8kJkVUQAvEfT_w@mail.gmail.com>
From: Charles Kiorpes <ckiorpes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Segfaults and ENOMEM during rt_event_create()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I am trying to port a fairly large application from Xenomai 2.6.4 to
Xenomai 3.0-rc6

Most of the port has been decently painless, but there is one issue I
can't seem to get past.

I am consistently getting ENOMEM errors and segfaults in
libcopperplate.so during rt_event_create(), and always at the same
spot in my application.

If a segfault occurrs, the dmesg output from the segfault looks like this:
[   235.422300] PortProcess[1502]: segfault at f1b3ebeb ip b76c14b7 sp
bfeae498 error 5 in libcopperplate.so.0.0.0[b76b7000+14000]

The application uses a large number of named event flag groups.  At
the time that the error occurs, it is looping to create 32 new named
event groups.

I have increased these values in my kernel config:
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=4096
CONFIG_XENO_OPT_SYS_HEAPSZ=512
CONFIG_XENO_OPT_PRIVATE_HEAPSZ=128
CONFIG_XENO_OPT_SHARED_HEAPSZ=128

When I dig through the /proc/xenomai filesystem, I see that:
- I am only using 383/4096 registry slots
- My system heap is about half full (284160KB free of 524288KB)
- My shared and private heaps are basically empty

My application is launched with --mem-pool-size=400000.  The main heap
(in /registry/user/session/system) has about 220KB used at the point
that the error occurs.
Increasing the mem-pool-size does not change the behavior.  I have
also tried further increasing the values of my system (1024), private
(256), and shared (256) heapsizes, with no effect.

Obviously I've missed something, but I can't figure out where the
error is occurring.

System details:
OS: Debian Jessie 32-bit
Kernel: 3.18.12 - patched using Xenomai 3.0-rc6
System: Intel Xeon W3503 (x86 architecture)
I-Pipe version 1

Thanks for your help!

- Charles Kiorpes

