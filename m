Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435904A07
	for <xenomai@lists.linux.dev>; Sat, 25 Apr 2026 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777134259; cv=none; b=HKZ9H1wOZV3LKfRiUsE/lW0GaqVnJ2Dd/9iKnh0J9s8qTLF7/kfKOIzFcFQPn5CyN29eh58kis1zMUpAipGBG6heLZUzphA3euAwGum5sQ6WIBxBznRDFVZSo1OGKpo4F4ouBYpY0H7HmZGeOt+dTlk/qTyoD9+ScmRWNatFfqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777134259; c=relaxed/simple;
	bh=gBGhpsXw4EWQpY7vCToiBR7cCv7w5SZ/H4MnnD3zwqg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=PunnkOAi5t4I8QzqO8PdpHT/TcMlN0NPtD50au1jMiQ/YVMdLvcydsTfbooA6ofBX9bW56c9dvgC6BiAmEl25TfoPVAWaJxy5cOT09qpagK7rLKg4Nx1+OLn2eHQtQXeSYc9oK2Jbg8UVj0iPx4Ffm/IOcEIvsJ5Bix5Nd32VxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiTppGBm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiTppGBm"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso91550745e9.1
        for <xenomai@lists.linux.dev>; Sat, 25 Apr 2026 09:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777134257; x=1777739057; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+kttQXms9uNQDMiCDUGKJLeUVHA/M8vgmi6BiNEcvc=;
        b=XiTppGBmpxNXxVVbhcMd+NGk0dVCLbx5waYfvsf7MgXMyUHDUZun94Nkw/vjPnQZgP
         meboZPeP/v94FpOAiD9hPKq73N6nNaOiFnBTj9Vx+t871GaDQNIyxe+J6SeeC0uWcJg/
         583MQ0JbgVBhXphjmWB1/FrG4xmScjeJSwBAZ+QQuC4oFvD+IcDlmJs9sdHpXjsdDBc3
         Zba5gPWj2bWWd6sHcNtXp3xGEiIOLW3fLV7msjphqZP4kjcTM5HD/R8Cb1HcCg76Mlf5
         MhtoZhhTDqy9JZPzLxrnzY3DViecOBVhro5D/L4GGyCDQE/aQpdpGZrxO7ol0CsQP9tB
         3EjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777134257; x=1777739057;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+kttQXms9uNQDMiCDUGKJLeUVHA/M8vgmi6BiNEcvc=;
        b=aee/F54SyyB46kgjMmPlyjVop1PLIfCNySPZsgN96vNYkwmlLOPt0vXAleM+i+HNrD
         vYDyXi3+SI21/kjT9nYaRDVLcZOIGAFnK6jUAuf/7amDcXyb6KjmjGTtVcWdipUunKM8
         K/WuQGO8lfORPWicvgcVHHDnd0q2G3tjv79EjpMugkdyl3pBCfQcqEFkBoBj71xNw/v6
         NyLuX221XJ6jSzG/RDI5kS0PVgPc+giOaOhw75+eMT0R+7MMTDb2m6z8EAnaAYn0Xw6W
         N9MfzPSSiaOsQwjAvB13yMnVUPVO2c8nzRNA6z/jLNazHNVCApf0R9IAqkTrdi3G+P3R
         sZDQ==
X-Gm-Message-State: AOJu0YyPzDM5hJgvcYCXBQXnThv6Z80rdBIRwUwonceOgv0qTh4SXujP
	oLZ+7zMmcennSyZdC2ZbQ9sahzj7eubyVQ8wTllxg8kPUl30b3oRvvnQcELT1w==
X-Gm-Gg: AeBDietcONUTcpKafva5O14p0LllhJbXsJ/AR+m4fL7TfX+M2ilNTfNrcQJYWKAECuF
	xbB48QDbuti1SXrJD5CNu0gaF+liXv/RrSfIL0ZRsql0Np12/6f6GxuB/e7Xkecvc9phD8JOuMp
	ZQD+yQJNmtGcKjNC4BlzAi9lRjRV6+Je6jxFB9/xi6GpPZyvg+HmRI5SyiRDUEl8YRFYMj4thMZ
	XljGQCWzC2phAC/gSoVPU8Fi+8lx6oo9fLRglQAafF/O6d1lziNwSG7ErLonNRzztFaQOc1Kpun
	zoEkaagm+ZT44O5QCCeJv85NImBhvc3EUM/9/2lV6Ws/vqv9Duiiqq8NzRj97PwCAsnGPdXJxj6
	Oq02OakykqFyuN0S+Pt12NjgPWy9QyUuret+Mjowm3pGkmydNFn3TYzZKqqLvv5Fzwozki458HU
	PMXJSr9cg4jw0G4qT0Biv64ARZD41x6Ik3L8jDV+kH/w==
X-Received: by 2002:a05:600c:3e1a:b0:489:1ca2:eafd with SMTP id 5b1f17b1804b1-4891ca2ee65mr377712675e9.11.1777134256366;
        Sat, 25 Apr 2026 09:24:16 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891df9e50asm378108675e9.0.2026.04.25.09.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 09:24:15 -0700 (PDT)
Message-ID: <8e08bda6-1fed-4a5a-9bb3-74f019b05855@gmail.com>
Date: Sat, 25 Apr 2026 18:24:14 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-CH, en-US
From: Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: [EVL] Kernel WARNING: notifier callback netevent_handler already
 registered
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello

There is a Kernel WARNING: "notifier callback netevent_handler already registered right after boot". It is repeated 5 times.

Config:
Debian Trixie with xfce4 Desktop
libevl: r56
linux-evl: v6.12.67-evl2-rebase

I traced the issue already trough the following code:
net/core/net_namespace.c:355
kernel/evl/net/net.c:35
kernel/evl/net/ipv4/ipv4.c:41
kernel/evl/net/ipv4/arp.c:323

However, I lack the knowledge to do a proper fix. One way would be to just check in evl_net_init_arp() if it is already
registered and don't do it more than once but that doesn't feel right.

Some background: I am working on integrating Xenomai3/4 into LinuxCNC. Due to this, I have a full desktop running with a
Xenomai kernel. Probably one of the installed applications triggers this issue.

It is just a hobby and I am not an official maintainer of LinuxCNC but if it works well, it might get merged.

Regards
Hannes

Full warning, one of 5 but they are all equal:

[    4.158674] ------------[ cut here ]------------
[    4.158680] notifier callback netevent_handler already registered
[    4.158716] WARNING: CPU: 15 PID: 1095 at kernel/notifier.c:31 notifier_chain_register+0x3e/0xb0
[    4.158736] Modules linked in: binfmt_misc intel_rapl_msr intel_rapl_common ccp kvm irqbypass crct10dif_pclmul ghash_clmulni_intel snd_hda_codec_generic sha512_ssse3 sha256_ssse3 sha1_ssse3 snd_hda_intel aesni_intel snd_intel_dspcfg snd_intel_sdw_acpi gf128mul snd_hda_codec crypto_simd cryptd pcspkr snd_hda_core snd_hwdep snd_pcm snd_timer snd soundcore evdev sg parport_pc ppdev lp parport efi_pstore configfs nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock vmw_vmci qemu_fw_cfg virtio_rng ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 virtio_gpu virtio_dma_buf drm_shmem_helper sr_mod drm_kms_helper cdrom iTCO_wdt intel_pmc_bxt xhci_pci iTCO_vendor_support watchdog xhci_hcd ahci libahci drm crc32_pclmul usbcore crc32c_intel virtio_blk libata psmouse virtio_net net_failover serio_raw failover usb_common scsi_mod i2c_i801 lpc_ich i2c_smbus scsi_common button
[    4.158773] CPU: 15 UID: 0 PID: 1095 Comm: (crub_all) Not tainted 6.12.67-xenomai4-53a3aa #3
[    4.158777] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    4.158778] IRQ stage: Linux
[    4.158781] RIP: 0010:notifier_chain_register+0x3e/0xb0
[    4.158784] Code: 10 7f 33 75 04 84 d2 75 7d 48 8d 78 08 48 8b 40 08 48 85 c0 74 20 48 39 c6 75 e0 48 8b 36 48 c7 c7 98 e1 54 9f e8 b2 28 fc ff <0f> 0b b8 ef ff ff ff c3 cc cc cc cc 48 89 46 08 48 89 37 66 90 31
[    4.158785] RSP: 0018:ffffc91b414e7d00 EFLAGS: 00010282
[    4.158789] RAX: 0000000000000000 RBX: ffffffffa090b240 RCX: 0000000000000027
[    4.158793] RDX: ffff8901efda0948 RSI: 0000000000000001 RDI: ffff8901efda0940
[    4.158794] RBP: ffffffff9fe809c0 R08: 0000000000000a74 R09: 0000000000000000
[    4.158794] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff9fc5a3e0
[    4.158795] R13: 0000000000000000 R14: ffffffff9fc528ec R15: ffffc91b414e7d58
[    4.158797] FS:  00007f16c63765c0(0000) GS:ffff8901efd80000(0000) knlGS:0000000000000000
[    4.158801] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.158802] CR2: 00007f16c719f160 CR3: 000000010491c000 CR4: 0000000000750ef0
[    4.158803] PKRU: 55555554
[    4.158803] Call Trace:
[    4.158815]  <TASK>
[    4.158816]  atomic_notifier_chain_register+0x24/0x40
[    4.158820]  evl_net_init_arp+0x3f/0x50
[    4.158830]  evl_net_init_ipv4+0x2a/0x100
[    4.158833]  setup_net+0x9e/0x2b0
[    4.158858]  copy_net_ns+0x111/0x270
[    4.158861]  create_new_namespaces+0x113/0x2e0
[    4.158865]  unshare_nsproxy_namespaces+0x58/0xa0
[    4.158868]  ksys_unshare+0x17d/0x400
[    4.158887]  __x64_sys_unshare+0x12/0x20
[    4.158890]  do_syscall_64+0xc0/0x230
[    4.158913]  ? syscall_exit_to_user_mode+0x1da/0x1f0
[    4.158916]  ? do_syscall_64+0xcc/0x230
[    4.158917]  ? do_user_addr_fault+0x4c1/0x750
[    4.158926]  ? __ct_user_enter+0x29/0xd0
[    4.158927]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    4.158949] RIP: 0033:0x7f16c6ebe967
[    4.158960] Code: 73 01 c3 48 8b 0d a9 34 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 10 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 79 34 0d 00 f7 d8 64 89 01 48
[    4.158961] RSP: 002b:00007ffe188cc308 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
[    4.158962] RAX: ffffffffffffffda RBX: 00007ffe188cc8c8 RCX: 00007f16c6ebe967
[    4.158962] RDX: 0000000000000000 RSI: 00007ffe188cc270 RDI: 0000000040000000
[    4.158963] RBP: 00007ffe188cc350 R08: 0000000000000000 R09: 0000000000000000
[    4.158963] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000040000000
[    4.158967] R13: 00000000fffffff5 R14: 00007f16c7374380 R15: 00000000fffffff5
[    4.158969]  </TASK>
[    4.158969] ---[ end trace 0000000000000000 ]---
