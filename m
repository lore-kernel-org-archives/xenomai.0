Message-ID: <5382E8B1.8070402@xenomai.org>
Date: Mon, 26 May 2014 09:09:37 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAO0fa7ZiofUS3wsbx89uYsnt6icuv+DVcDbiEfVyG5DUeprj2w@mail.gmail.com>
In-Reply-To: <CAO0fa7ZiofUS3wsbx89uYsnt6icuv+DVcDbiEfVyG5DUeprj2w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] gdb / threads on beaglebone black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Drew <pythondrew@gmail.com>, xenomai@xenomai.org

On 05/26/2014 03:49 AM, Drew wrote:
> I'm seeing unexpected behavior running under gdb on a beaglebone black
> using a machinekit debian SD image:
>
> http://www.machinekit.net/deb/rootfs/wheezy/debian-7.4-machinekit-armhf-2014-05-09-4gb.img.xz
>
> I'm curious if the behavior repeats on other platforms, and what I might be
> doing wrong. My understanding is that xenomai should work OK under GDB as
> long as you don't mind the mode switching.
>
> The code is at
>
> http://pastebin.com/MUgLAbGX
>
> It is a modified version of
> xenomai-2.6/examples/native/trivial-periodic.c
>
> I build and run in gdb:
>
> cd xenomai-2.6/examples/native
> export MY_CFLAGS="-g"
> make trivial-periodic
> gdb ./trivial-periodic
> run
>
> At this point, I get two "New Thread" messages, two "Thread Exited"
> messages, a 3 second pause, then "hello world" and nothing else.
>
> Outside of gdb, the program works as expected.
>
> I'm confused why the threads have exited before I have even called
> rt_task_start on either of them. This has been reproduced by another
> machinekit user; he suggested I try the Xenomai list.
>

Any change with this?

- pause();
+ for (;;)
+    pause();

-- 
Philippe.

