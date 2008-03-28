Message-ID: <2ff1a98a0803280901t703072fapa0ad8508db79b0c5@domain.hid>
Date: Fri, 28 Mar 2008 17:01:48 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d6c8ef150803280435s2fb6a459kcfe68a0dde86b34c@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150803280435s2fb6a459kcfe68a0dde86b34c@domain.hid>
Subject: Re: [Xenomai-help] Using shared memory, Xenomai 2.4.2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

>  --- rt_shm.c - kernel module ---
>  RT_TASK rt_shm_task;
>  RT_HEAP heap_desc;
>  void *shared_mem;
>  [..]
>   if (!rt_heap_create (&heap_desc, "MainSHM", 1024, H_SHARED)) {
>     printk ("Error rt_heap_create");
>   }

This is wrong. rt_heap_create returns 0 when it works and non zero
when it fails. So, if you do not see the "Error rt_heap_create"
message in the console, rt_heap_create actually fails.  rt_heap_create
error codes are documented here:

http://www.xenomai.org/documentation/trunk/html/api/group__native__heap.html#g1d19ad24dc9f94b969aa0f574170bdc4

-- 
 Gilles

