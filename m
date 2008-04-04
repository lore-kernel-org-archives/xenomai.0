Message-ID: <d6c8ef150804040018u1b4ed61eg6eccbf5257b88abf@domain.hid>
Date: Fri, 4 Apr 2008 09:18:57 +0200
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <7289437c0804030552q79d1bb84jf5f40d1a57a443b5@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7289437c0804030246v7992ec23kedcc2c8b71dc14f8@domain.hid>
	<d6c8ef150804030300p3a4c719tca9903aa7663a5d9@domain.hid>
	<7289437c0804030552q79d1bb84jf5f40d1a57a443b5@domain.hid>
Subject: Re: [Xenomai-help] Question about rtdm_mmap_to_user()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Thu, Apr 3, 2008 at 2:52 PM, Perrine Martignoni <perrmart@domain.hid> wrote:

> >rt_heap_create (&heap_desc, "MySHM", 2048, H_SHARED);
>  >rt_heap_alloc (&heap_desc, 0, TM_NONBLOCK, &shared);
[..]
> I tried exactly what you wrote. And it doesn't work. I have error -11. It
> doesn't find the Heap I created in kernel space.
> I don't understand why. I put exactly the same name.

rt_heap_create() must be called from kernel module init function. Here
is copy&paste from my code (with checking return values):

kernel_module:
===========

RT_HEAP heap_desc;
void *shared_mem;

int init_module (void)
{
int ret;

  ret = rt_heap_create (&heap_desc, "MainSHM", 4*1024, H_SHARED);
  if (ret) {
    printk ("Error rt_heap_create: %d\n", ret);
  }
  ret = rt_heap_alloc (&heap_desc, 0, TM_NONBLOCK, &shared_mem);
  if (ret) {
    printk ("Error rt_heap_alloc: %d\n", ret);
  }
  printk ("4kB heap memory created, name: MainSHM\n");
  return 1;
}

void cleanup_module(void)
{
  rt_heap_delete (&heap_desc);
}

