MIME-Version: 1.0
Date: Wed, 16 Nov 2011 00:52:08 +0800
Message-ID: <CAMmQBoWXA2SgKvmNjJ7htiq_yoMabA-ADNtKNWi_TT4dfiddJw@domain.hid>
From: arethe rtai <arethe.rtai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-core] A real-time memory manager for multicore system is
	being developed
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rtai-request@domain.hid
Cc: Xenomai-core@domain.hid

HI:
     Multicore CPU will be used more and more widely. But the share
cache is a bottleneck of real-time performance. The concurrent
real-time tasks would disturb each other through shared cache (such as
L2 cache or L3 cache)and front side bus (while access memory or IO
device), so, we should resolve these problems while we want to use the
Linux on multicore real-time systems.
    I want to develop a real-time memory manager based on the page
color technology. It can divide the shared cache into several separate
partitions, some critical tasks will have an exclusive parition.
    Page color is not a new idea, but it have not been used in popular
RTOSes, such as RTAI, XENOMAI.
Chenggang Qin

