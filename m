Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7682B9A4
	for <xenomai@lists.linux.dev>; Sat, 31 May 2025 05:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748668582; cv=none; b=HcEleF3n6PNli9zgUpOAxZQg9Y8Te2h5XCM48AlbJ2lk3pr6Rex3a+Bp8fJYueokToT8mNPpPfyow8RHSYHZt3ev7mVmBL4WlAomw/tt4/2GZ0eY1KOkwtcT3iGVO0Q6slcIbvl4MmKJ10b4+lPQ0XUhQTmdzD9/VstYG77Zbh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748668582; c=relaxed/simple;
	bh=ZhTStVEkCqWNPsDfCN5Ax0x3/ZP3SGM+EB9IX0YqEus=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XqjASQJ6+QYXW7WifqQSP9lZY9dERRFi62E91Nfu6LvNrbO6IPUOwBo4tKEvD3UafA1f3AbQcV5JQpzq/siyUqx5Ro+ITZtvL0og6ONHcPaACHdHeaA3FSWDGTjRySVlWeNSsYXIY2xdT3Fx1ArPOgQqACG2TdYB59ckdjLImE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frszHw0g; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frszHw0g"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b0db0b6a677so2179933a12.2
        for <xenomai@lists.linux.dev>; Fri, 30 May 2025 22:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748668580; x=1749273380; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jqLRZQh/SKqz8TO5F2XlmUFglE5AMsnOUfMeiiYmVlU=;
        b=frszHw0gE4jdab1QrsJ6Vs7qzW9IQZvYY6ZZunlgsKSTOFR/+4tpVR7biaS2ezf6xC
         ThYvtQ+UFxu/1HBDFNMuTXVhgWCj9liQM523Jfc+mwImw0Zuzk8baHEJi2Y7Dd6nsy6Q
         eL5taxODRwd0rqnrtetxODiEgZufkvKrpOy9p0c47FMwJqtfHBUqa/x2w4zO3+St5Wvp
         KbkY+BObwF6GB5YJfww6i6hZH13KIO2Qn2cyP7JN9jp3JN3X1c3qVOBqauRaRVpqbmNc
         I5Qvf9/g5LfrfdO2q8CAyZDM83NtbKvUOfCmYymg6O6VBrmKIonp6OBJoRRjQ34Ovowp
         ujRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748668580; x=1749273380;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqLRZQh/SKqz8TO5F2XlmUFglE5AMsnOUfMeiiYmVlU=;
        b=uv19lgAjTaK4x4bAOd5Safk5uQPsKY3+QpRE4JVg0ZQrlKR8cnxAzfeqsf5/rhimSX
         WfGnYqdQgzxPYuLY6TqvRB64ZAPR065Ba3MO8gNWmXw9m59ublHIZFrVJYyv4DRGqHwE
         mIlRHjxxC1bySqjanMbly5wtC1AiDbEL1WgwPap6ir6g5WN4pC2TwYQlGmJw2j7mxNO+
         UmTAwd7FtmEKxcpgfZ1x12iFPVgInanv8Nvaourq25zP62tgjPyBjVsAOCFKPwSUD6lE
         n6QBx4hLIU7HZsD36tCQ/QpSPmjJDA9MMZDc+pWyjfRsiipFYI0+Mb/O3t4pTXEHb6v3
         m5aA==
X-Gm-Message-State: AOJu0YxW8NZnDwnlaWEqrLyZ0xcKWn9MPHDi722KrjnrlyvjuMCri4aK
	sZB/L4bwqfXcmmYOMrALSz0NsLbxFKbAdbgSW/sNtg0BzeQVeAUMS3x4pm/qdvrEuKgoLDXlkfe
	IOOtN5/3wS7+DhlZfvnZ0HDR4Rufwys3Y1RFW
X-Gm-Gg: ASbGncuQA5LSFzo9ZH7f/6EP/7QsiNvAyCK1WbI0i9c2k+F/+BqmvB0bfoSDIQt48rJ
	E+MoTPF5UQlHGoFwm27PEjJXl2yJ8YP9Yg5mE5mpKg/f4pfOm6NGHC5FT1uf1B2XAWVoli06Z8p
	wXtCztKGM6W7vaOcZthZEANdTV3DyIzqzKzw==
X-Google-Smtp-Source: AGHT+IG1XhhlT2/AzgXxzrCDHZT4FgC0Gz1YWkZdDqNzfE8ECe0gEkmoIvcyWqAqwcgnTgzkRrAZhI7XlduHIGjeQhA=
X-Received: by 2002:a17:903:1d1:b0:234:8e54:2d53 with SMTP id
 d9443c01a7336-23529a114f9mr87567175ad.45.1748668579713; Fri, 30 May 2025
 22:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Eigen Zhu <yinpo.zhu@gmail.com>
Date: Sat, 31 May 2025 13:16:10 +0800
X-Gm-Features: AX0GCFsLRBnTAnogp8j04Ud59yY-nKpjyjv3hgOHMDNnGrbndEe4E5qy1BByrIc
Message-ID: <CAHVFwiXNua2WnMZ4qCxmG2cPfMBiv2ptTjO6tPpfSPNSjX+5Ag@mail.gmail.com>
Subject: Inquiry about float-point calculation in RTDM task
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi support team,

We encountered a problem relating to the handling of kernel FPU. The
system is built on Linux-dovetail-v5.15.9 with Xenomai.v3.2.1, and the
cpu is X86-64 dual core with specifications below:
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 140
model name : Intel(R) Celeron(R) 6305E @ 1.80GHz
stepping : 1
microcode : 0xac
cpu MHz : 1800.000
cache size : 4096 KB
physical id : 0
siblings : 2
core id : 0
cpu cores : 2
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 27
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq
dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid
sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb cat_l2
invpcid_single cdp_l2 ssbd ibrs ibpb stibp ibrs_enhanced tpr_shadow
vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep
bmi2 erms invpcid rdt_a avx512f avx512dq rdseed adx smap avx512ifma
clflushopt clwb intel_pt avx512cd sha_ni avx512bw avx512vl xsaveopt
xsavec xgetbv1 xsaves split_lock_detect dtherm ida arat pln pts hwp
hwp_notify hwp_act_window hwp_epp hwp_pkg_req avx512vbmi umip pku
ospke avx512_vbmi2 gfni vaes vpclmulqdq avx512_vnni avx512_bitalg
avx512_vpopcntdq rdpid movdiri movdir64b fsrm avx512_vp2intersect
md_clear flush_l1d arch_capabilities
vmx flags : vnmi preemption_timer posted_intr invvpid ept_x_only
ept_ad ept_1gb flexpriority apicv tsc_offset vtpr mtf vapic ept vpid
unrestricted_guest vapic_reg vid ple pml ept_mode_based_exec
tsc_scaling
bugs : spectre_v1 spectre_v2 spec_store_bypass swapgs
bogomips : 3609.60
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

We also did CPU isolation to improve the real-time performance of
Xenomai threads, and the grub configuration is below:
GRUB_DEFAULT=0
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
#GRUB_CMDLINE_LINUX_DEFAULT="quiet"
GRUB_CMDLINE_LINUX_DEFAULT="console=tty0 console=ttyS3,9600n8  splash quiet"
GRUB_CMDLINE_LINUX="idle=poll isolcpus=0 xenomai.supported_cpus=0x01
nohz_full=0 rcu_nocbs=0 rcu_nocb_poll=1024
rcupdate.rcu_cpu_stall_suppress=1 irqaffinity=1 cpufreq.off=1
i915.enable_rc6=0 i915.enable_dc=0 i915.disable_power_well=0
i915.enable_execlists=0 i915.powersave=0"

Over the configuration above, we have 7 threads with different
priorities running over the cobalt kernel, and they are created by
using rtdm_task_init. These threads are synchronised by Semaphore.
Note that all the threads are performing high-intensity floating-point
calculations, and the GCC compile flag has declared -mhard-fpu.

Now the problem is when a low-priority thread was preempted by threads
with higher priority, and then after restored from preemption, the
float-point calculation was going wrong. The code below is a simple
case that could reproduce the error:
#include "rtdm/drvlib.h"

void kthread0()
{
    rtdm_sem_down(x); // this signal was sent by other hardware interrupts;
    double a = 1.0;
    double b = 1.0;
    double c = a + b;
}

void kthread1()
{
    rtdm_sem_down(y); // this signal was sent by other hardware interrupts;
    double e = 1.0;
    double f = 1.0;
    double g = e + f;
    assert(g  >= 0);
}

rtdm_task_t threads[2];

int main()
{
    rtdm_task_init(&threads[0], "thread 0", kthread0, NULL, 90, 0);
    rtdm_task_init(&threads[1], "thread 1", kthread1, NULL, 80, 0);
}



As shown by the code, when kthread1 was activated and then preempted
by kthread0, the assert in line 17 would fail. But if we disabled the
preemption, like using atomic lock to protect kthread1, the problem no
longer appeared. Thus, we doubt the issue might be related to the FPU
registers that, when kernel threads were context-switched by Xenomai,
the FPU registers were not properly saved/restored to memory. But we
are unsure about this reason and did not know how to address this
issue.

We have done a lot of research on the internet, and tried multiple
methods, like using kernel_fpu_begin/end to explicitly save the fpu
registers, but the real code project is very complex, and it's hard to
add kernel_fpu_begin/end to protect every float-points calculation. We
also tried to add CPU affinities to each thread as the CPU is
dual-core, but this could not solve the root cause relating to the
float-points calculation. We also tried to use soft-fpu to compile the
project, but this does not work.

My inquiry is:
Is this a legal move to put heavy float-point calculations in multiple
RDTM real-time tasks, while higher priority tasks would preempt lower
priority ones? If not, how could we configure the kernel or modify the
code to support this action?

Regards.
Yinpo.
