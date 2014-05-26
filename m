MIME-Version: 1.0
Date: Sun, 25 May 2014 21:49:39 -0400
Message-ID: <CAO0fa7ZiofUS3wsbx89uYsnt6icuv+DVcDbiEfVyG5DUeprj2w@mail.gmail.com>
From: Drew <pythondrew@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] gdb / threads on beaglebone black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I'm seeing unexpected behavior running under gdb on a beaglebone black
using a machinekit debian SD image:

http://www.machinekit.net/deb/rootfs/wheezy/debian-7.4-machinekit-armhf-2014-05-09-4gb.img.xz

I'm curious if the behavior repeats on other platforms, and what I might be
doing wrong. My understanding is that xenomai should work OK under GDB as
long as you don't mind the mode switching.

The code is at

http://pastebin.com/MUgLAbGX

It is a modified version of
xenomai-2.6/examples/native/trivial-periodic.c

I build and run in gdb:

cd xenomai-2.6/examples/native
export MY_CFLAGS="-g"
make trivial-periodic
gdb ./trivial-periodic
run

At this point, I get two "New Thread" messages, two "Thread Exited"
messages, a 3 second pause, then "hello world" and nothing else.

Outside of gdb, the program works as expected.

I'm confused why the threads have exited before I have even called
rt_task_start on either of them. This has been reproduced by another
machinekit user; he suggested I try the Xenomai list.

Thanks in advance

Drew

PS I posted this to the list on May 22, but I hadn't joined the list at the
time. I don't see it in the archives so I'm re-posting. Hope it isn't a
duplicate.
