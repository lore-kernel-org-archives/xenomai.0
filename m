Message-ID: <4CA6F124.3090006@domain.hid>
Date: Sat, 02 Oct 2010 10:45:24 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4CA6D3C0.4010900@domain.hid>
In-Reply-To: <4CA6D3C0.4010900@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [git pull] Patch queue for 2.5.x
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

On 02/10/10 08:40, Jan Kiszka wrote:
> The following changes since commit 5e7cfa5c25672e4478a721eadbd6f6c5b4f88a2f:
> 
>   nucleus/sched: fix rescheduling bit test macros (2010-09-30 02:34:27 +0200)
> 
> are available in the git repository at:
>   git://git.xenomai.org/xenomai-jki.git for-2.5.x
> 
> Jan Kiszka (8):
>       RTDM: Protect xnshadow_ppd_get via nklock
>       Fix symbolic status ouput of root threads
>       Create watchdog as non-blockable timer
>       native: Improve documentation of rt_task_join and rt_task_delete
>       x86: Add PCI ID of Series 5/3400 Intel chipset to SMI workaround
>       x86: Add PCI ID of 631xESB/632xESB/3100 Intel chipset to SMI workaround
>       x86: Add PCI ID of Intel ICH9M-E chipset to SMI workaround

This patch reads:

+#ifdef PCI_DEVICE_ID_INTEL_ICH9_1
+#define PCI_DEVICE_ID_INTEL_ICH9_1 0x2917
+#endif

shouldn't it be #ifndef ... #define ... #endif instead?

>       x86: Add PCI ID of Intel ICH9M chipset to SMI workaround

Same for this one.

Cheers,
-- 
Daniele

