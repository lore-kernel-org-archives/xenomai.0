Message-ID: <d6c8ef150804030300p3a4c719tca9903aa7663a5d9@domain.hid>
Date: Thu, 3 Apr 2008 12:00:17 +0200
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <7289437c0804030246v7992ec23kedcc2c8b71dc14f8@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7289437c0804030246v7992ec23kedcc2c8b71dc14f8@domain.hid>
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

Why don't you try rt_heap_* functions? Quick example:

Kernel space:

RT_HEAP heap_desc;
void *shared;

rt_heap_create (&heap_desc, "MySHM", 2048, H_SHARED);
rt_heap_alloc (&heap_desc, 0, TM_NONBLOCK, &shared);
[.. cleanup ..]
rt_heap_delete (&heap_desc);
User space:

RT_HEAP heap_desc;
void *shared;

rt_heap_bind (&heap_desc, "MySHM", TM_NONBLOCK);
rt_heap_alloc (&heap_desc, 0, TM_NONBLOCK, &shared);
[..cleanup..]
rt_heap_unbind (&heap_desc);

============================================

Hope this helps :)

