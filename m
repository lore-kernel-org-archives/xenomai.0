Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F4B28F7
	for <xenomai@lists.linux.dev>; Fri,  2 Dec 2022 20:45:32 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id mn15so4175014qvb.13
        for <xenomai@lists.linux.dev>; Fri, 02 Dec 2022 12:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4j7+f7S8RTMrGyIGcwl0tm3MDO4burkQ7yrTlSBoFQE=;
        b=gjoh578KM0my+tjmI/PB20nansMefikKBCbz4lxkMVbLEtaZNjYHy5FtalMMihISo6
         8Zl6AexSuVDLdfIGnUY/6+Sznt8fGJUPqjXlr7/zNT4ikOAd6tWOOtzqgQ6cLPaSVhkn
         A2Ltk1/7Uey5Ef8NlT1JIishCQccbet8QqxRa+YjYITWxYXK0b8AzpNaoAbiSXpc/7fu
         uy2RZ49SizFDRch4Erls+j/wvfxg03dW6Bkb6lYO2MRs2s2iTYyJ7HZsmwBCPzHOoubq
         UxGza+GNiDHe5HY1vTSlCJ6ikV3o4MKLGApxK8eD+wiaCAK0t83TlXWu2IrQPhL+h0Hj
         F8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4j7+f7S8RTMrGyIGcwl0tm3MDO4burkQ7yrTlSBoFQE=;
        b=aYclwVyBoDX2fetUwzp6FsWyV10epIGHKS2yLDt+M7zRo42kLrY3038TMYnAyi/cOq
         s9FFS+CVHIi9NWSoN64T3rw1flIBmprVkV+VwWrCG+fs7khR+ffVtPyKMcIJMJf9fkM1
         Jt+6rTgXFwwGM93kOeIWbcniv9NNQLYU7vGX64RLuQeWhDzePgtXulz9FLVCV8XKBIqS
         iTopdRuPGxUb4RDzwk6AdI8TmoOj9DHtqeZyvxKRw5h8q/I+GLPbE2KtwVaZZ/qv/Qgs
         IqJcIhZiR0a+bEvGeZCOBQPBdObd4cjtSOeQWFq+OspqViYNGgW0Agfwlh4ULc/ua1ju
         wmRA==
X-Gm-Message-State: ANoB5pm1BM/WdxczpRKk/nuuvra85gL5nHliJmVO/C71rFOrZtCxnwY3
	fG9SuqKHh1Ynu5jQMQoQv2w07dCZX8lrjsIs01mWzZg/EY0=
X-Google-Smtp-Source: AA0mqf6/7KetDGq9yudC8PBcDb4CatgArTWdT4yNxvntmx99fmmqVSzfgcIJaaJo78lMXgei4/QNX3jgdrjyhvsIWPs=
X-Received: by 2002:a05:6214:4508:b0:4c7:2b:ee13 with SMTP id
 oo8-20020a056214450800b004c7002bee13mr23781233qvb.99.1670013930707; Fri, 02
 Dec 2022 12:45:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Sri Subramanian <sridhar.subramanian@gmail.com>
Date: Fri, 2 Dec 2022 12:45:20 -0800
Message-ID: <CAAm9oxrZ+g7RgBV0SC5GkvEeKKGXOZb2R_BRjf0qRObQM1wCgg@mail.gmail.com>
Subject: Xenomai crash in timer IRQ
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

I have an application waking up every 500us (waiting with an
oob_read() on an EVL monotonic clock) and taking action.

The application also has an interface to enable/disable NTP and set
the clock manually. The system will run over days without any issues.
But if NTP is disabled, and the clock is set manually, then NTP is
re-enabled, a short time after (order of minutes), the OS crashes and
the system reboots. It is reproducible every time.

Should the monotonic clock be affected by an RTC clock setting? I was
assuming not, but I am not so sure now.

Hardware environment: Raspberry PI CM4 with a standard CM4-IO board.
Xenomai tag: 5.15.77-evl-rebase
Stack and config as below:

Thanks for any help,
Sri
==========
[  363.094612] CPU: 3 PID: 706 Comm: EcatCyclic-tid_ Tainted: G
 C        5.15.35-xeno-v5.15.77-evl1-rebase #1
[  363.094617] Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
[  363.094619] IRQ stage: Linux
[  363.094621] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  363.094626] pc : evl_get_timer_overruns+0x1b8/0x1c4
[  363.094630] lr : evl_get_timer_overruns+0x54/0x1c4
[  363.094634] sp : ffffffc00a283c40
[  363.094635] x29: ffffffc00a283c40 x28: 0000000000000000 x27: ffffff810103acc0
[  363.094642] x26: ffffff810103ac00 x25: ffffffc008deb320 x24: ffffffc008c6aae8
[  363.094647] x23: 0000000000000000 x22: ffffff81fefde3e0 x21: 0000000000000001
[  363.094652] x20: 000000548931dc32 x19: ffffff810103ac00 x18: 0000000000000000
[  363.094658] x17: 0000000000000000 x16: 0000000000000001 x15: 0000000000000000
[  363.094662] x14: 0000000000000000 x13: ffffffc00898a790 x12: 00000000fa83b2da
[  363.094667] x11: 0000000000000029 x10: 0000000000000930 x9 : ffffffc00a283c30
[  363.094673] x8 : ffffff811c496810 x7 : 000000000000b7df x6 : 00000004a520e245
[  363.094678] x5 : 00ffffffffffffff x4 : 0011bdb637657ad8 x3 : 000000000007a120
[  363.094683] x2 : 0000000000000001 x1 : 0000000000000005 x0 : 0000000000000005
[  363.094688] Call trace:
[  363.094691]  evl_get_timer_overruns+0x1b8/0x1c4
[  363.094695]  timerfd_oob_read+0x200/0x290
[  363.094701]  EVL_read+0x50/0xd0
[  363.094703]  handle_pipelined_syscall+0x218/0x260
[  363.094707]  __pipeline_syscall+0xe8/0x2a0
[  363.094710]  pipeline_syscall+0x64/0x110
[  363.094713]  el0_svc_common.constprop.0+0x48/0x12c
[  363.094719]  do_el0_svc+0x28/0x90
[  363.094722]  el0_svc+0x4c/0xd0
[  363.094728]  el0t_64_sync_handler+0xa4/0x130
[  363.094733]  el0t_64_sync+0x1a0/0x1a4
[  363.094736] ---[ end trace ac73e88b51a9ac19 ]---
[  363.094750] EVL: EcatCyclic-tid_706 resuming out-of-band [pid=706,
excpt=3, evl_get_timer_overruns+0x1bc/0x1c4]
[  363.094764] Unable to handle kernel paging request at virtual
address dead000000000108
[  363.094767] Mem abort info:
[  363.094768]   ESR = 0x96000044
[  363.094769]   EC = 0x25: DABT (current EL), IL = 32 bits
[  363.094772]   SET = 0, FnV = 0
[  363.094774]   EA = 0, S1PTW = 0
[  363.094775]   FSC = 0x04: level 0 translation fault
[  363.094778] Data abort info:
[  363.094779]   ISV = 0, ISS = 0x00000044
[  363.094780]   CM = 0, WnR = 1
[  363.094782] [dead000000000108] address between user and kernel address ranges
[  363.094786] Internal error: Oops: 96000044 [#1] PREEMPT SMP
[  363.094789] Modules linked in: cdc_mbim cdc_wdm cdc_ncm cdc_ether
bcm2835_v4l2(C) bcm2835_mmal_vchiq(C) videobuf2_vmalloc
videobuf2_memops videobuf2_v4l2 videobuf2_common raspberrypi_hwmon
videodev mc vc4 cec drm_kms_helper snd_soc_core snd_pcm_dmaengine
snd_pcm snd_timer snd syscopyarea sysfillrect sysimgblt fb_sys_fops
i2c_gpio i2c_algo_bit ax88179_178a uio_pdrv_genirq uio nvmem_rmem
cfg80211 rfkill sch_fq_codel fuse drm drm_panel_orientation_quirks
backlight configfs ipv6
[  363.094828] CPU: 3 PID: 706 Comm: EcatCyclic-tid_ Tainted: G
WC        5.15.35-xeno-v5.15.77-evl1-rebase #1
[  363.094832] Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
[  363.094834] IRQ stage: EVL
[  363.094835] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  363.094839] pc : evl_get_timer_overruns+0xfc/0x1c4
[  363.094843] lr : evl_get_timer_overruns+0x54/0x1c4
[  363.094846] sp : ffffffc00a283c40
[  363.094847] x29: ffffffc00a283c40 x28: 0000000000000000 x27: ffffff810103acc0
[  363.094853] x26: ffffff810103ac00 x25: ffffffc008deb320 x24: ffffffc008c6aae8
[  363.094858] x23: 0000000000000000 x22: ffffff81fefde3e0 x21: 0000000000000001
[  363.094863] x20: 000000548931dc32 x19: ffffff810103ac00 x18: 0000000000000000
[  363.094868] x17: 0000000000000000 x16: 0000000000000001 x15: 0000000000000000
[  363.094873] x14: 0000000000000000 x13: ffffffc00898a790 x12: 00000000fa83b2da
[  363.094878] x11: 0000000000000029 x10: 0000000000000930 x9 : ffffffc00a283c30
[  363.094883] x8 : ffffff811c496810 x7 : 000000000000b7df x6 : 00000004a520e245
[  363.094887] x5 : 00ffffffffffffff x4 : 0011bdb637657ad8 x3 : 000000000007a120
[  363.094892] x2 : dead000000000100 x1 : 0000000000000005 x0 : dead000000000122
[  363.094897] Call trace:
[  363.094899]  evl_get_timer_overruns+0xfc/0x1c4
[  363.094903]  timerfd_oob_read+0x200/0x290
[  363.094907]  EVL_read+0x50/0xd0
[  363.094910]  handle_pipelined_syscall+0x218/0x260
[  363.094913]  __pipeline_syscall+0xe8/0x2a0
[  363.094916]  pipeline_syscall+0x64/0x110
[  363.094919]  el0_svc_common.constprop.0+0x48/0x12c
[  363.094923]  do_el0_svc+0x28/0x90
[  363.094926]  el0_svc+0x4c/0xd0
[  363.094931]  el0t_64_sync_handler+0xa4/0x130
[  363.094935]  el0t_64_sync+0x1a0/0x1a4
[  363.094940] Code: 0a010000 7100101f 54000621 a9410262 (f9000440)

========
CONFIG_HAVE_ARCH_EVL=y
CONFIG_EVL=y
CONFIG_EVL_SCHED_QUOTA=y
# CONFIG_EVL_SCHED_TP is not set
# CONFIG_EVL_HIGH_PERCPU_CONCURRENCY is not set
CONFIG_EVL_RUNSTATS=y
# CONFIG_EVL_NET is not set
CONFIG_EVL_COREMEM_SIZE=2048
CONFIG_EVL_NR_THREADS=256
CONFIG_EVL_NR_MONITORS=512
CONFIG_EVL_NR_CLOCKS=8
CONFIG_EVL_NR_XBUFS=16
CONFIG_EVL_NR_PROXIES=64
CONFIG_EVL_NR_OBSERVABLES=64
CONFIG_EVL_LATENCY_USER=1500
CONFIG_EVL_LATENCY_KERNEL=1500
CONFIG_EVL_LATENCY_IRQ=500
CONFIG_EVL_DEBUG=y
CONFIG_EVL_DEBUG_CORE=y
CONFIG_EVL_DEBUG_MEMORY=y
CONFIG_EVL_DEBUG_WOLI=y
# CONFIG_EVL_DEBUG_NET is not set
CONFIG_EVL_WATCHDOG=y
CONFIG_EVL_WATCHDOG_TIMEOUT=4
CONFIG_EVL_LATMUS=y
CONFIG_EVL_HECTIC=y
==========
