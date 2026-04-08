Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBC4319857
	for <xenomai@lists.linux.dev>; Wed,  8 Apr 2026 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775681601; cv=none; b=JzUdS5P9bwLcXnYMrJmhmWfLqSIsXWik5mL6ijZjT2O4Geq011T7TSvfsBfOcbOm3H+Pxwk5JXU+6bHaJvl18CIoYT/UDdxv52qbsYct/s566as98OnTrmIKV1QKC1gAKADaHQJLuq8bbTb5WPQD4tn9dsn2xtIf0MaYXkZsT6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775681601; c=relaxed/simple;
	bh=hEgQsaUMebZ1zuuvARVZeTC9GXXPjJIIUPcAABpTpBQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Iauhkx29oVNe9B2tolEy9A9kytWdI+PwfGfQ98XULF5GiNnhLyTSEUiasXFC8/rR6VMKNGnhcm5RUGmF1pR5dhGR9aFznsWkSK9r6S0UOFHYOd2Ywwn2zDy5iT8XFDSj0XPYABZvO8Uksas3Sh/vhoItb3pKYDLQoLHqK4t1Ps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZt8EWZ+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZt8EWZ+"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso1191895e9.3
        for <xenomai@lists.linux.dev>; Wed, 08 Apr 2026 13:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775681598; x=1776286398; darn=lists.linux.dev;
        h=content-transfer-encoding:content-language:subject:from:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yeA4VjSSQ78R7M48nImnzZ4j2jkPOlo/iSQGXCleE8=;
        b=gZt8EWZ+gLNbvRKn+W34pGcnra3YJCNLFWLAaSRe9rrfSdYgp92pvyiclOXXtqdhli
         mq96Gp9FBovXEXQ3oCdt0c2TiA7y1ovfeap/KPMmERsMIxvhG1DcV9T7+9po7VJf6kVE
         msw/mAbK3Xgjz86Wc879Q5D1B+OTi9Tri0Hwwdy5VVkac9Mv/l+2B2CjPQIg0f+GskJw
         YXuzZ1l1EcSHTyK6AeL3WngFUIWiE81toZp1vLkPin8TD/1ZsXxlEfk8Y9zIoUITMJ75
         JcZOCi0b1F+oyXrfzRXCSGTrbiEBraSkYgZnH4MHBS9OcUl7glWcyL3u7CaYnGmWD1Gf
         DFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775681598; x=1776286398;
        h=content-transfer-encoding:content-language:subject:from:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2yeA4VjSSQ78R7M48nImnzZ4j2jkPOlo/iSQGXCleE8=;
        b=FqzGg69N1MIuSgeqvWrYbquzLu4NBVZUaEPdYA+fsXNxLVcF8vnPq6trMGRCRAV6/N
         7mTUBQgYvM6DycKu0mideMcFeU8+dAJo5MW8nkQ9F1GnxJx51Od5QYdbdzRdPIf1De4m
         KDOt1oi+73QiyiolhAXbm5njFqiRnhJjYFDwJusFtnNUTp3CG1C+MQmeuCG2Q8XP46tU
         picoTTLAo1GbwsItlX09vl6jclGeUB7ILljVQbdV3OtcLZ7M6cT5BZfG4Go3wRySUyDi
         ghzUb031hxSHLgmKsua+TzDTOeDo5naiNSmBoLIUYtS2D7uSjuQPvzaWHtYyGlSD5IeN
         oJfA==
X-Gm-Message-State: AOJu0YzcDT6ww7082CfZOOWoOnHEle7hWNgdHAY1NTHpqMmGtvKYRBJa
	b+zJWuUZ+zS9VLidy82HHOfOeldHZ14z9SNXtcvyRu4Y0oZwTbrozCD6sETW/g==
X-Gm-Gg: AeBDietwM8U2oFF4zSslwMXbKMkl6gPlPQXfhT97xYr2RccsclqzHfoob3bcH9Ra5nJ
	+C49q52jiuSyVfkI/+Bk+YRyuoOC+KFcWKtTiFfKrXTY2uVc0CeYmB7lCYt1D4TKowQGPGn1xJz
	ewGCAVYifYaD/NZCetYHUuNgV1xA/gXtWYdSchLOkOfCRWyhn/PG5XFO8oChvSV5l8L6TliQQF3
	zBPEkOqHn3lXu4lF3IxdVUau3SUCvkHMb0A5Kb71tza0XAYSyhEg7cVpd+Xdsmw10ENg3txXPAt
	6Jr4Pi9x9qUhytG+/7w1Mj9RGHaEzQ+hD2KSOfFd5UXuP0hQ9tnAo0T4nX7ZvB3zXM+Mv285ruD
	S7y9HSkEL4S6ZLNgn4QgxkMFOnoPg3t4g0S/esV3gZQ5z+5qDzvlHxeJLSl1x2ivdKPivEO/fb7
	GP9F6PKF2+1FzxxJY0o7wwZNHekPhDYSw=
X-Received: by 2002:a05:600c:444c:b0:488:a977:8de with SMTP id 5b1f17b1804b1-488a9770d4amr218321955e9.16.1775681597816;
        Wed, 08 Apr 2026 13:53:17 -0700 (PDT)
Received: from [192.168.1.3] ([213.55.168.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e52a0sm58445669f8f.30.2026.04.08.13.53.17
        for <xenomai@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 13:53:17 -0700 (PDT)
Message-ID: <4742f315-9fae-4165-b5c0-066e6500baed@gmail.com>
Date: Wed, 8 Apr 2026 22:53:16 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: xenomai@lists.linux.dev
From: Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: Kernel WARNING in Xenomai3 with RTnet
Content-Language: de-CH, en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Configuration:

Debian Trixie
xenomai3:master
linux-dovetail:v6.12.67-dovetail1

I have the following warning as soon as I enable the network interface:
Apr 08 01:52:12 trixie-box kernel: ------------[ cut here ]------------
Apr 08 01:52:12 trixie-box kernel: memcpy: detected field-spanning write 
(size 80) of single field "call->priv_data" at 
drivers/xenomai/net/stack/rtnet_rtpc.c:93 (size 0)
Apr 08 01:52:12 trixie-box kernel: WARNING: CPU: 13 PID: 2480 at 
drivers/xenomai/net/stack/rtnet_rtpc.c:93 
rtnet_rtpc_dispatch_call+0x2df/0x3d0 [rtnet]
Apr 08 01:52:12 trixie-box kernel: Modules linked in: rtudp rtipv4 
rt_loopback joydev uinput qrtr rfkill binfmt_misc intel_rapl_msr 
intel_rapl_common ccp kvm snd_hda_codec_generic snd_hda_intel ir>
Apr 08 01:52:12 trixie-box kernel: CPU: 13 UID: 0 PID: 2480 Comm: rtping 
Not tainted 6.12.67-xenomai3-73ad3b #3
Apr 08 01:52:12 trixie-box kernel: Hardware name: QEMU Standard PC (Q35 
+ ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Apr 08 01:52:12 trixie-box kernel: IRQ stage: Linux
Apr 08 01:52:12 trixie-box kernel: RIP: 
0010:rtnet_rtpc_dispatch_call+0x2df/0x3d0 [rtnet]
Apr 08 01:52:12 trixie-box kernel: Code: 26 50 00 00 00 0f 85 d1 fd ff 
ff 31 c9 48 c7 c2 00 13 94 c0 4c 89 ee 48 c7 c7 48 13 94 c0 c6 05 06 50 
00 00 01 e8 51 d6 97 eb <0f> 0b e9 ab fd ff ff 84 d2 >
Apr 08 01:52:12 trixie-box kernel: RSP: 0018:ffffcdff82ebbd68 EFLAGS: 
00010286
Apr 08 01:52:12 trixie-box kernel: RAX: 0000000000000000 RBX: 
ffff8988585012c0 RCX: 0000000000000027
Apr 08 01:52:12 trixie-box kernel: RDX: ffff898b6fca0948 RSI: 
0000000000000001 RDI: ffff898b6fca0940
Apr 08 01:52:12 trixie-box kernel: RBP: 00000000000001f4 R08: 
0000000000000000 R09: ffffcdff82ebbb28
Apr 08 01:52:12 trixie-box kernel: R10: ffffffffadeb9ee8 R11: 
0000000000000003 R12: 0000000000000000
Apr 08 01:52:12 trixie-box kernel: R13: 0000000000000050 R14: 
ffffffffc0cff5b0 R15: ffffffffc0cff6e0
Apr 08 01:52:12 trixie-box kernel: FS:  00007f1499d11740(0000) 
GS:ffff898b6fc80000(0000) knlGS:0000000000000000
Apr 08 01:52:12 trixie-box kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Apr 08 01:52:12 trixie-box kernel: CR2: 00007ffe3de7dff8 CR3: 
000000014d74e000 CR4: 0000000000750ef0
Apr 08 01:52:12 trixie-box kernel: PKRU: 55555554
Apr 08 01:52:12 trixie-box kernel: Call Trace:
Apr 08 01:52:12 trixie-box kernel:  <TASK>
Apr 08 01:52:12 trixie-box kernel:  ipv4_ioctl+0x16b/0x230 [rtipv4]
Apr 08 01:52:12 trixie-box kernel:  rtnet_ioctl+0x164/0x190 [rtnet]
Apr 08 01:52:12 trixie-box kernel:  ? __count_memcg_events+0x67/0x100
Apr 08 01:52:12 trixie-box kernel:  __x64_sys_ioctl+0x91/0xd0
Apr 08 01:52:12 trixie-box kernel:  do_syscall_64+0xc0/0x230
Apr 08 01:52:12 trixie-box kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e
Apr 08 01:52:12 trixie-box kernel: RIP: 0033:0x7f1499e2091b
Apr 08 01:52:12 trixie-box kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 
44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 
10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c >
Apr 08 01:52:12 trixie-box kernel: RSP: 002b:00007ffe3de7e9f0 EFLAGS: 
00000246 ORIG_RAX: 0000000000000010
Apr 08 01:52:12 trixie-box kernel: RAX: ffffffffffffffda RBX: 
00007f1499d11740 RCX: 00007f1499e2091b
Apr 08 01:52:12 trixie-box kernel: RDX: 000055c8e00d60e0 RSI: 
00000000c0500285 RDI: 0000000000000003
Apr 08 01:52:12 trixie-box kernel: RBP: 0000000000000002 R08: 
0000000000000000 R09: 0000000000000000
Apr 08 01:52:12 trixie-box kernel: R10: 0000000000000003 R11: 
0000000000000246 R12: 00007ffe3de7f818
Apr 08 01:52:12 trixie-box kernel: R13: 0000000000000002 R14: 
00007f1499f60000 R15: 000055c8e00d5dd8
Apr 08 01:52:12 trixie-box kernel:  </TASK>
Apr 08 01:52:12 trixie-box kernel: ---[ end trace 0000000000000000 ]---

This can be fixed with the following patch. However, I am not sure if 
it's the right way to do it.
diff --git a/kernel/drivers/net/stack/rtnet_rtpc.c 
b/kernel/drivers/net/stack/rtnet_rtpc.c
index cd5f0546d..caed27269 100644
--- a/kernel/drivers/net/stack/rtnet_rtpc.c
+++ b/kernel/drivers/net/stack/rtnet_rtpc.c
@@ -90,7 +90,7 @@ int rtnet_rtpc_dispatch_call(rtpc_proc proc, unsigned 
int timeout,
      if (call == NULL)
          return -ENOMEM;

-    memcpy(call->priv_data, priv_data, priv_data_size);
+    unsafe_memcpy(call->priv_data, priv_data, priv_data_size, 
/*embedded variable length data*/);

      call->processed = 0;
      call->proc = proc;

