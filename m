Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CAD6AA5
	for <xenomai@lists.linux.dev>; Tue,  4 Jul 2023 16:52:51 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 28CB7100002
	for <xenomai@lists.linux.dev>; Tue,  4 Jul 2023 16:52:47 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 24ADB7803DE
	for <xenomai@xenomai.org>; Tue,  4 Jul 2023 16:52:46 +0000 (UTC)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb87828386so1861633e87.1
        for <xenomai@xenomai.org>; Tue, 04 Jul 2023 09:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688489565; x=1691081565;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IFs/m6gAe06NPhDA2pChf//baW/c2RasXp0O9gIAX1w=;
        b=B2JBa1pXjWnxKueHrp73WI64DeW5U240pKiNcRtngTI06IsXtkZ6LO2BxsezgRsSyv
         5n5pPybCltVD0Eb/qQW9adAiWDkhtOxLBrvkEd+An7IPnuSmUw0kyPFwAn4S//Ohp342
         4TZHrgRL8s6TmYIxCoDcOmaG782X6tU8BgB/KrHNjd1ir+X2ar5ulyEZUVjswSFb7D5L
         3FrsWsqhOLpYf/1Q8e2CasF5HUtJrjEnWB4gjmKGSGVagTpA3fClfPUP1EgsEuT2tlWU
         E6/jGWYGMgtU11jaMEaZ2Q25GcMnzhwBUt/wAuLEeLYxbKeUtkpsLDPOS1/MvBY+gF+p
         5SDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688489565; x=1691081565;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IFs/m6gAe06NPhDA2pChf//baW/c2RasXp0O9gIAX1w=;
        b=U5e6ZCWWCpouXgbYMS/gRJGQ349fDU3XASLWj282WX0YSWIvNHQO6q9tigOWV/f/oj
         gImiZYBLvFdoXNMilc9kvODlgjEPOzJYpKKJMq/h1SjXd/6eUY08yz7ssUJNPiuN4rq+
         kTNUiMVvuNfTMvoEZLhWFiD2KD5q4pGUpzBIvZ3vUVLWqWTvnNCg4uk9/TOey9W5jCRf
         1FrEjF8QkYeRB7lFhJb3niRKei5etHqG0nx7j2hXyj/rYXjcgXewy0vQdQ85yK3hSsCu
         /qgCuGc1Bpv2LvzGq9p1Rdu7mwMpRHoJqHoN1lYecah9zHeLuVqvbKXZ0928glzAz9cM
         2gHw==
X-Gm-Message-State: ABy/qLbrDxnT6ojb3Q4pjya51MFFTCUlRabLXgmP2VzwGZDUe2aruLaf
	oIvuiJS3xDDo88gT+vUcxSwk+wY++vr//ZR+3dQvjgBkcx4cGI4=
X-Google-Smtp-Source: APBJJlEJowyeSKKwrAURVJIYtfQrFaxZlIszehXkGMeHQh4ECRB3UZcofppEHHPl7yxAYdQL5eg+aCG5VG4f5F2qkgg=
X-Received: by 2002:ac2:4841:0:b0:4fb:963f:d6e3 with SMTP id
 1-20020ac24841000000b004fb963fd6e3mr8035375lfy.1.1688489564983; Tue, 04 Jul
 2023 09:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: John Ho <johnho26@gmail.com>
Date: Tue, 4 Jul 2023 18:52:34 +0200
Message-ID: <CAMjL99Lk-QT=vev=3QeeUAjHzfP7X-fCRwJM18OkvTR1V5SRYQ@mail.gmail.com>
Subject: Invalid Opcode
To: xenomai@xenomai.org
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=gmail.com header.s=20221208 header.b=B2JBa1pX;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (spool.mail.gandi.net: domain of johnho26@gmail.com designates 2a00:1450:4864:20::12c as permitted sender) smtp.mailfrom=johnho26@gmail.com

Hi all,
I have encountered an invalid Opcode while running some of my stuff,
and I have no idea where this is coming from, and I would like to ask
for some help.

I have assumed that adding Nopti would help eliminate this invalid
opcode, but it has not helped.

[  100.456173] kernel BUG at kernel/xenomai/synch.c:968!
[  100.456183] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  100.456191] CPU: 0 PID: 2255 Comm: OrbRunner Tainted: G     U
5.4.198-neuron-1.6 #1
[  100.456194] Hardware name: _ _/, BIOS N3FCPDU1 03/22/2023
[  100.456197] I-pipe domain: Linux
[  100.456206] RIP: 0010:xnsynch_requeue_sleeper+0x16/0x1d0
[  100.456210] Code: f6 4c 89 cf 48 89 e5 e8 98 fe ff ff 5d c3 c3 0f
1f 44 00 00 e8 9b c9 a1 00 55 48 8b 97 40 12 00 00 48 89 e5 f6 42 20
01 75 02 <0f> 0b 48 8b 87 18 12 00 00 48 8d 72 28 48 8b 8f 10 12 00 00
4c 8d
[  100.456214] RSP: 0018:ffffb1d8414ebd28 EFLAGS: 00010246
[  100.456218] RAX: 0000000000000000 RBX: ffffb1d840e96240 RCX: 0000000000000002
[  100.456221] RDX: ffffffff84f48ce0 RSI: ffffb1d8414ebd0c RDI: ffffb1d840e96240
[  100.456223] RBP: ffffb1d8414ebd28 R08: ffffb1d840e91a10 R09: ffffb1d840e91a30
[  100.456226] R10: 0000000080000092 R11: 0000000080000092 R12: ffffb1d840e91a08
[  100.456229] R13: ffffb1d840e8fa40 R14: ffffb1d843880c80 R15: 00000000000000c5
[  100.456232] FS:  00007f1b57e4ab00(0000) GS:ffff95360c000000(0000)
knlGS:0000000000000000
[  100.456235] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  100.456238] CR2: 00007f94fc6b6d68 CR3: 00000003de2be006 CR4: 00000000003606b0
[  100.456241] Call Trace:
[  100.456248]  inherit_thread_priority+0x2d/0x40
[  100.456254]  xnsynch_acquire+0x5b7/0x810
[  100.456260]  ? __switch_to_asm+0x40/0x70
[  100.456267]  __cobalt_mutex_acquire_unchecked+0x55/0x80
[  100.456271]  __cobalt_mutex_timedlock_break+0x2cb/0x390
[  100.456277]  ? CoBaLt_mutex_trylock+0x200/0x200
[  100.456281]  CoBaLt_mutex_lock+0x12/0x20
[  100.456286]  handle_root_syscall+0x15b/0x2e0
[  100.456291]  ipipe_syscall_hook+0x38/0x50
[  100.456296]  __ipipe_notify_syscall+0xb4/0x190
[  100.456301]  ipipe_handle_syscall+0x7f/0xb0
[  100.456306]  do_syscall_64+0x2c/0xe0
[  100.456312]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  100.456315] RIP: 0033:0x7f1b651cc7c7
[  100.456319] Code: 43 08 75 77 48 8b 15 98 67 21 00 48 03 02 8b 00
25 ff ff ff 5f 39 e8 74 9a be 1d 00 00 10 0f 1f 44 00 00 48 89 df 89
f0 0f 05 <83> f8 fc 89 c2 74 f2 85 c0 75 07 c7 43 04 01 00 00 00 48 83
c4 18
[  100.456322] RSP: 002b:00007f1b57e49f60 EFLAGS: 00000293 ORIG_RAX:
000000001000001d
[  100.456326] RAX: ffffffffffffffda RBX: 00007f1b67690bd8 RCX: 00007f1b651cc7c7
[  100.456329] RDX: 00007f1b653e41b0 RSI: 000000001000001d RDI: 00007f1b67690bd8
[  100.456331] RBP: 00000000000000c5 R08: 0000000000000009 R09: 0000556930a82a90
[  100.456334] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
[  100.456337] R13: 00007f1b653e420c R14: 00007f1b67690bd8 R15: 00007f1b57e4a240
[  100.456343] Modules linked in: nls_iso8859_1 snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio joydev
input_leds snd_hda_intel snd_intel_nhlt snd_hda_codec snd_hda_core
snd_hwdep snd_pcm hid_generic mei_hdcp snd_seq_midi snd_seq_midi_event
crct10dif_pclmul i915 snd_rawmidi binfmt_misc crc32_pclmul
ghash_clmulni_intel snd_seq aesni_intel crypto_simd cdc_ether cryptd
usbnet drm_kms_helper glue_helper snd_seq_device r8152 snd_timer mii
drm usbhid i2c_algo_bit wmi_bmof serio_raw snd hid fb_sys_fops
syscopyarea soundcore mei_me sysfillrect mei sysimgblt acpi_tad
sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables autofs4
ahci psmouse e1000e igc libahci wmi pinctrl_cannonlake pinctrl_intel
video
[  100.456390] ---[ end trace 7997569d11a0d891 ]---
[  100.456396] RIP: 0010:xnsynch_requeue_sleeper+0x16/0x1d0
[  100.456399] Code: f6 4c 89 cf 48 89 e5 e8 98 fe ff ff 5d c3 c3 0f
1f 44 00 00 e8 9b c9 a1 00 55 48 8b 97 40 12 00 00 48 89 e5 f6 42 20
01 75 02 <0f> 0b 48 8b 87 18 12 00 00 48 8d 72 28 48 8b 8f 10 12 00 00
4c 8d
[  100.456402] RSP: 0018:ffffb1d8414ebd28 EFLAGS: 00010246
[  100.456406] RAX: 0000000000000000 RBX: ffffb1d840e96240 RCX: 0000000000000002
[  100.456408] RDX: ffffffff84f48ce0 RSI: ffffb1d8414ebd0c RDI: ffffb1d840e96240
[  100.456411] RBP: ffffb1d8414ebd28 R08: ffffb1d840e91a10 R09: ffffb1d840e91a30
[  100.456414] R10: 0000000080000092 R11: 0000000080000092 R12: ffffb1d840e91a08
[  100.456417] R13: ffffb1d840e8fa40 R14: ffffb1d843880c80 R15: 00000000000000c5
[  100.456420] FS:  00007f1b57e4ab00(0000) GS:ffff95360c000000(0000)
knlGS:0000000000000000
[  100.456423] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  100.456426] CR2: 00007f94fc6b6d68 CR3: 00000003de2be006 CR4: 00000000003606b0

May I know if there is anything I can do to help resolve this, or can
I get a suggestion on this issue, I have been trying to resolve this
for the past few days. This has been an issue after switching from
xenomai 3.1 to 3.2.1 #eedf4ffe3

yours sincerely,
John
