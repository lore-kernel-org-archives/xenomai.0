Message-ID: <d6c8ef150803280435s2fb6a459kcfe68a0dde86b34c@domain.hid>
Date: Fri, 28 Mar 2008 12:35:34 +0100
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] Using shared memory, Xenomai 2.4.2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hi!

I'm using Xenomai 2.4.2 with Linux 2.6.20.21 (Adeos-ipipe 1.8-03) on
ARM9 (AT91SAM9260 based). I have a problem with using shared memory
between kernel and user space. I've tried on user space side both
native and posix skins.

Here are snippets:

--- rt_shm.c - kernel module ---
RT_TASK rt_shm_task;
RT_HEAP heap_desc;
void *shared_mem;
[..]
  if (!rt_heap_create (&heap_desc, "MainSHM", 1024, H_SHARED)) {
    printk ("Error rt_heap_create");
  }

  if (!rt_heap_alloc (&heap_desc, 0, TM_NONBLOCK, &shared_mem)) {
    printk ("Error rt_heap_alloc");
  }
[..]
============================
--- user.c - userspace app ---
RT_HEAP heap_desc;
void *shared_mem;
[..]
  err = rt_heap_bind (&heap_desc, "MainSHM", TM_NONBLOCK);
  if (err) {
    printf ("rt_heap_bind error: %d!\n", err);
    return 0;
  }

  rt_heap_alloc (&heap_desc, 0, TM_NONBLOCK, &shared_mem);
[..]
============================
I load rt_shm.ko, I can see it running, no errors returned during
rt_heap_* calls (I'm incrementing counter inside shared heap memory,
and displaying every 10000th time). When I start user space
application I get:

rt_heap_bind error: -11!

So, rt_heap_bind is returning -EWOULDBLOCK. Why?

Also, I've enable during kernel compilation in posix skin option
'shared memory'. Also, I tried with posix skin in user space:
[..]
fd = shm_open ("MainSHM", O_RDWR, 0);
[..]

When I start it, on the console I can see:
shm_open: No such file or directory
Xenomai: POSIX: destroyed thread c4802400

Any ideas?

Thanks!

