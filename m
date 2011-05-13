MIME-Version: 1.0
Date: Fri, 13 May 2011 09:25:25 +0800
Message-ID: <BANLkTim1tWxvzUx2gUwLbQVbob4tRqbCFw@domain.hid>
From: arethe rtai <arethe.rtai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-core] I suspect the shared memory of Xenomai has bug.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

HI all:
       I always got null while I request a shared memory through RTAI
skins in the user space.
       Some bugs maybe exist in the sub-system. I traced the execution
stream of rt_shm_alloc, and found the mmap() operation always return
-22. I suspect the problem should be same while we use other skins,
because the mmap operation is implemented in /ksrc/nucleus/heap.c.
       Is there anyone encountered this problem?
Regards Arethe.

