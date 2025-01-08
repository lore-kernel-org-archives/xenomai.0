Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B6219DF81
	for <xenomai@lists.linux.dev>; Wed,  8 Jan 2025 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364432; cv=none; b=nQpxf/tS3AK++K2yinRxMiUigSfclsM/w9YAr1QWfhflfSMx4EjoFi7Qgzz92YSzgzM4H9gFSfUyPwvR1uXWvVMBmBtL6jvTPRMvrzEl9mSh06+2KDcgdAVcmJdhQCIG4O2BuuHZmwE1vhVNMSXdUWCnR3KgEmJEw3BRGZJ4IRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364432; c=relaxed/simple;
	bh=0j/YN/8MPFSTWgpGeGgRODlJlVKEFpg4DuT9j7igFN4=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=rAU8V3nj36tNTjUehGPJ1qIE6f45W4w8MXbfwLFTafVYCduVnqJmF7Yp9MX6c6GaFxbySG3fkEGRyK7qpL8WJ9GNjPyFRueI4iugx1PU4aUiVz1XMIybhB5PW0kwyCU5C8+Y9ip5lst2E2in6ghzVOI9PgKWCGbz6w+ZEH6iRIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=QIPrBAGQ; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="QIPrBAGQ"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250108134634b9b2f3c65eccdaad05
        for <xenomai@lists.linux.dev>;
        Wed, 08 Jan 2025 14:46:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=+cHqJQ82klUK8dwX7o3Cgns1ultl91mjG2/ymzt9aDE=;
 b=QIPrBAGQ4fOwTjjkniy7o1eV5sLSpsl7Z0pLHYS+7xm5Y17WPtaZsFVrio+DUo9nlthj5i
 52rwDVvVVzv0jwEdr/3tnyqLBaq2YstZ0KR/XEkxcz9B2Kx0vAj20CXujFSm/94qv/nD+dSP
 APni8Av7CRx5wvCg1g6w4ZvBdV+rjvw3WE63Gon/1GOoz+SauPTC4px6saAN7uKIKRJc8JQE
 qVwv2WedziBxBC89S41uM4vdEmidcn+/Zn78cY+NZ4IrPjiWqpfFwwFStdNSdzpjypEg/3/z
 IYBpcsCbidUzPoBsqe7Qg3t43jY7Zn5o/d1UNLvzcoZtnw3vf928ktvw==;
Message-ID: <9b141179a28d93ce9dfd3d1c560054efc5170a29.camel@siemens.com>
Subject: Register corruption in syscalls on Dovetail > 6.10
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Date: Wed, 08 Jan 2025 14:46:33 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

while doing the dovetail forward porting to 6.13 we detected an issue
within the cobalt core.

CI jobs fail/crash while trying to execute the smokey testsuite.
Philippe and I were able to reproduce locally. Here is a summary what
we found out so far. The issue is not completely understood yet.

The smokey test suite - especially the y2038 tests - are triggering
several (page) faults. One of them triggers the following kernel splat.
The complete test log can be found at [1].

[  265.656410] Unable to handle kernel paging request at virtual address ff=
ff0000404666c8
[  265.656463] Mem abort info:
[  265.656475]   ESR =3D 0x0000000096000005
[  265.656529]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  265.656554]   SET =3D 0, FnV =3D 0
[  265.656571]   EA =3D 0, S1PTW =3D 0
[  265.656591]   FSC =3D 0x05: level 1 translation fault
[  265.656619] Data abort info:
[  265.656635]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
[  265.656652]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[  265.656669]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[  265.656735] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D000000004196d0=
00
[  265.656764] [ffff0000404666c8] pgd=3D180000007ffff003, p4d=3D180000007ff=
ff003, pud=3D0000000000000000
[  265.657948] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
[  265.658304] Modules linked in: crct10dif_ce cfg80211 rfkill fuse drm drm=
_panel_orientation_quirks ip_tables x_tables ipv6 [last unloaded: xeno_rtdm=
test]
[  265.658970] CPU: 0 UID: 0 PID: 1610 Comm: smokey Not tainted 6.12.0 #1
[  265.659072] Hardware name: linux,dummy-virt (DT)
[  265.659213] IRQ stage: Linux
[  265.659437] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  265.659529] pc : __pipeline_syscall+0xf0/0x23c
[  265.659574] lr : __pipeline_syscall+0xc8/0x23c
[  265.659608] sp : ffff800082e93d90
[  265.659629] x29: ffff800082e93d90 x28: 0000000000000000 x27: ffff800081f=
edf08
[  265.659715] x26: ffff800081574598 x25: ffff8000820066b8 x24: 00000000000=
00001
[  265.659741] x23: ffff800081fedf08 x22: 0000000000000018 x21: ffff800082e=
93eb0
[  265.659767] x20: ffff8000819364d0 x19: ffff00003fd964d0 x18: 00000000000=
00000
[  265.659791] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000000=
00000
[  265.659823] x14: ffff000004942e00 x13: 0000000000000000 x12: 00000000000=
00001
[  265.659846] x11: ffff800082d13c08 x10: 0000000000000a70 x9 : ffff800082e=
93be0
[  265.659870] x8 : ffff00000766f0d0 x7 : ffff800082006000 x6 : 00000000000=
00000
[  265.659912] x5 : 0000000000000000 x4 : ffff800082e93d90 x3 : 00000000000=
00000
[  265.659944] x2 : ffff0000404666b8 x1 : ffff00000766e600 x0 : ffff7fffbe4=
60000
[  265.660114] Call trace:
[  265.660289]  __pipeline_syscall+0xf0/0x23c
[  265.660485]  pipeline_syscall+0x60/0xcc
[  265.660566]  el0_svc_common.constprop.0+0x44/0x118
[  265.660598]  do_el0_svc+0x1c/0x28
[  265.660615]  el0_svc+0x34/0xfc
[  265.660632]  el0t_64_sync_handler+0x100/0x12c
[  265.660646]  el0t_64_sync+0x190/0x194
[  265.660879] Code: d3596442 8b020442 8b020f22 8b000042 (f9400841)=20
[  265.688100] ---[ end trace 0000000000000000 ]---
[  265.688359] note: smokey[1610] exited with irqs disabled

Findings:

[ @Philippe, please correct/add if I missed something ]

- The first version with that problem is Dovetail 6.11, 6.10 is fine
- There seems to be a register corruption in syscalls
- Disabling CONFIG_XENO_OPT_DEBUG_LOCKING seems to help
- Philippe figured out that disabling XENO_ARCH_OUTOFLINE_XNLOCK
  allows us to enable CONFIG_XENO_OPT_DEBUG_LOCKING again,=C2=A0
  at least when his toolchain was updated from 13.2.rel1 to 14.2.rel1
  at the same time.

  I can confirm the same for the Debian toolchain (on Debian bookworm).
  Setting XENO_ARCH_OUTOFLINE_XNLOCK to n makes a difference.

- The following fixes the CI pipeline, but we're sure this is just
  papering over the real bug

diff --git a/kernel/cobalt/posix/monitor.c
b/kernel/cobalt/posix/monitor.c
index fb7fb27e9..874acd910 100644
--- a/kernel/cobalt/posix/monitor.c
+++ b/kernel/cobalt/posix/monitor.c
@@ -289,7 +289,8 @@ int __cobalt_monitor_wait(struct
cobalt_monitor_shadow __user *u_mon,
 out:
        xnlock_put_irqrestore(&nklock, s);

-       __xn_put_user(opret, u_ret);
+       if (u_ret)
+               __xn_put_user(opret, u_ret);

        return ret;
 }

Best regards,
Florian

[1] https://lava.xenomai.org/scheduler/job/17450
