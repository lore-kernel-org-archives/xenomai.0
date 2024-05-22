Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB722146004
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716407492; cv=none; b=VrQ2qMldWUkAvsLoyl/j5vGr2X2rIlJKLXTDbwUly7GxxBo4PMT4FgydTgeOiCrXh/wBG4+hgkTiaYBZrnpb4jbjH2oL9b2ahntU8qTWqqBiKxgkKLzSZALKCrs2KE1VoRg7hLW0YoN6NO8Z+W+vXGFsuvJyYukBLJTGfLH4g3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716407492; c=relaxed/simple;
	bh=sCOxpwJV0AD8mWOTolXc3NsJdcsxnMHuAUv4/gOkx3U=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=aN1EQWTLbkyiApRtCC0wUOkM6cScraAPFPqWDtd8I54Le2yTMXyx8OLbjHoMSSaJoqq1+tMN9GLg8UvJcNqJdfNen3gR9Zez2XrtV/VqsbDMZEoRIsaQiQTdIojQ9i17dwQL3iwznJEyAXXbHDUPvzlIEuzr8s9ndw0aUxxLpR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-354f6ab168aso80609f8f.1
        for <xenomai@lists.linux.dev>; Wed, 22 May 2024 12:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716407488; x=1717012288;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6w4GBOBBiQBGigqMWTyNlVdvIApp74Z9V/Wf5P0D34=;
        b=R/lQoNsaqxMwH4fNcR9hUWh6PJ167tgriH35Wnj+ocN+BzGmvsysHOF/CZtZu02lnj
         EU+wIj+Qj/z/5PhtaAkYbKv9fBsduenOi39ds0pgIZbU/rHV3YpaYwskRBzg3Jxeb8/y
         Ud/Am5WepX/I0IOxyLbEyDT81LSZhkxCpEYBhBl5JyOctGnEw7xPN+Jw3hYWubcRBbwG
         oalJimE1xej+P2FAlQmajXE7P1b/NyHcCqmc0m76zppe/xlg7VSIDZjhOXkKHZ75UGU2
         hFReDExadOYGdpDVAKO9L7Do5pIK+5BJtjxuFnFeFKjl5eg/kbnzRvSESD+MzuA/QqlO
         HKbQ==
X-Gm-Message-State: AOJu0YwcRSx/ypy8H8Vju2zNKbhmO3zeJjNRP31VIRMquomOxWeD7/GL
	PmrJQArg5l9iSu09yq1yLf8+ASOiPHuNtYJijI9+2kjK0tbO2ntEfG42q1aG
X-Google-Smtp-Source: AGHT+IEQl6KTeQGVrQ7a1touRngrJ+PDhLfpwcFpSVP/z0PKz/ae8f0GgOWuax7b8Zgla8ntIpN3ew==
X-Received: by 2002:a5d:456f:0:b0:348:7e75:4d75 with SMTP id ffacd0b85a97d-354f753b77emr204042f8f.22.1716407487708;
        Wed, 22 May 2024 12:51:27 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a789asm34933067f8f.51.2024.05.22.12.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 12:51:26 -0700 (PDT)
References: <PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87wmnmq8v9.fsf@xenomai.org>
 <PH0PR11MB59491C18ADB51F5FEAEF4B3FF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <PH0PR11MB59490B50D2D2717B8155EFCDF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87h6eprhbg.fsf@xenomai.org>
 <PH0PR11MB5949B24CB222FBB2D387BF24F4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: "Nechita, Ionut" <ionut.nechita@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
Date: Wed, 22 May 2024 21:50:46 +0200
In-reply-to: <PH0PR11MB5949B24CB222FBB2D387BF24F4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
Message-ID: <87cypdr5fm.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


"Nechita, Ionut" <ionut.nechita@intel.com> writes:

> I delete workspace and I recompiled again.
>
> And I have this now:
>
> ...
> [  163.204266] ------------[ cut here ]------------
> [  163.204270] WARNING: CPU: 0 PID: 4270 at kernel/evl/syscall.c:272 do_oob_syscall+0x191/0x360
> [ 163.204279] Modules linked in: input_leds hid_generic usbhid hid
> rfcomm xt_nat xt_tcpudp veth xt_conntrack nft_chain_nat xt_MASQUERADE
> nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables libcrc32c
> nfnetlink snd_hda_codec_hdmi snd_hda_codec_realtek
> snd_hda_codec_generic snd_hda_scodec_component cmac algif_hash
> algif_skcipher af_alg bnep overlay snd_sof_pci_intel_skl
> snd_sof_intel_hda_common soundwire_intel snd_sof_intel_hda_mlink
> soundwire_cadence snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp
> snd_sof snd_sof_utils soundwire_generic_allocation soundwire_bus
> snd_soc_avs snd_soc_hda_codec snd_soc_skl snd_soc_hdac_hda
> intel_rapl_msr snd_hda_ext_core intel_rapl_common snd_soc_sst_ipc
> snd_soc_sst_dsp snd_soc_acpi_intel_match snd_soc_acpi
> intel_uncore_frequency intel_uncore_frequency_common snd_soc_core
> intel_tcc_cooling x86_pkg_temp_thermal intel_powerclamp snd_compress
> ac97_bus coretemp snd_pcm_dmaengine snd_hda_intel snd_intel_dspcfg
> [ 163.204331] snd_intel_sdw_acpi kvm_intel snd_hda_codec kvm
> snd_hda_core snd_hwdep binfmt_misc btusb iwlmvm mei_hdcp mei_pxp
> crct10dif_pclmul snd_pcm i915 mac80211 snd_seq_midi polyval_clmulni
> snd_seq_midi_event polyval_generic ghash_clmulni_intel btrtl libarc4
> sha256_ssse3 btintel snd_rawmidi sha1_ssse3 aesni_intel btbcm
> crypto_simd drm_buddy btmtk ttm cryptd iwlwifi snd_seq bluetooth
> drm_display_helper rapl snd_seq_device ecdh_generic intel_cstate
> intel_wmi_thunderbolt ecc wmi_bmof cfg80211 snd_timer ee1004 cec snd
> soundcore mei_me i2c_algo_bit mei intel_pmc_core
> intel_xhci_usb_role_switch intel_pch_thermal intel_vsec pmt_telemetry
> mac_hid pmt_class acpi_pad sch_fq_codel msr parport_pc ppdev lp
> parport efi_pstore ip_tables x_tables autofs4 rtsx_pci_sdmmc xhci_pci
> crc32_pclmul xhci_pci_renesas ahci e1000e i2c_i801 i2c_smbus rtsx_pci
> xhci_hcd libahci video wmi
> [  163.204394] CPU: 0 PID: 4270 Comm: firefox Not tainted 6.9.0-x64v1-1-lowlatency #3
> [  163.204397] Hardware name: Intel(R) Client Systems NUC7i7BNH/NUC7i7BNB, BIOS BNKBL357.86A.0083.2020.0714.1344 07/14/2020
> [  163.204399] IRQ stage: EVL
> [  163.204400] RIP: 0010:do_oob_syscall+0x191/0x360
> [  163.204404] Code: 1a 41 8b 95 70 01 00 00 89 10 49 8b 85 40 02 00 00 41 8b 95 74 01 00 00 89 50 04 49 8b 74 24 50 0f 1f 44 00 00 e9 0c ff ff ff <0f> 0b 48 c7 c7 b8 fe 43 9a 89 d6 e8 ef 53 e9 ff e9 59 ff ff ff 48
> [  163.204407] RSP: 0018:ffffad2bc3ddfdb8 EFLAGS: 00010216
> [  163.204409] RAX: 0000000000000000 RBX: ffff934d7b378000 RCX: ffffad2bc3ddfe08
> [  163.204411] RDX: 0000000043564d41 RSI: ffffad2bc3ddff58 RDI: ffffffff9a759fb0
> [  163.204412] RBP: ffffad2bc3ddfdf8 R08: ffffffff9a759fb0 R09: 0000000000000000
> [  163.204414] R10: 0000000000000000 R11: 0000000000000000 R12: ffffad2bc3ddff58
> [  163.204415] R13: 0000000053564d41 R14: ffff93545ea52040 R15: ffffffff9af682b0
> [  163.204417] FS:  00007fcdd4d9d780(0000) GS:ffff93545ea00000(0000) knlGS:0000000000000000
> [  163.204419] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  163.204421] CR2: 0000582e42dcb5a8 CR3: 00000001147fa003 CR4: 00000000003706f0
> [  163.204423] Call Trace:
> [  163.204424]  <TASK>
> [  163.204428]  ? show_regs+0x6c/0x80
> [  163.204433]  ? __warn+0x88/0x140
> [  163.204438]  ? do_oob_syscall+0x191/0x360
> [  163.204441]  ? report_bug+0x182/0x1b0
> [  163.204447]  ? handle_bug+0x5e/0xc0
> [  163.204452]  ? exc_invalid_op+0xe6/0x110
> [  163.204455]  ? asm_exc_invalid_op+0x1b/0x20
> [  163.204462]  ? do_oob_syscall+0x191/0x360
> [  163.204467]  handle_pipelined_syscall+0xb1/0x390
> [  163.204472]  __pipeline_syscall+0xaf/0x260
> [  163.204477]  pipeline_syscall+0xbb/0x190
> [  163.204481]  do_syscall_64+0x74/0x210
> [  163.204485]  ? irqentry_exit+0x40/0xe0
> [  163.204489]  ? exc_page_fault+0x99/0x1b0
> [  163.204493]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  163.204497] RIP: 0033:0x7fcdd4ec6381
> [  163.204500] Code: Unable to access opcode bytes at 0x7fcdd4ec6357.
> [  163.204501] RSP: 002b:00007ffff1a5a260 EFLAGS: 00000246 ORIG_RAX: 000000000000009d
> [  163.204503] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcdd4ec6381
> [  163.204505] RDX: 00007fcdd4c9d000 RSI: 0000000000000000 RDI: 0000000053564d41
> [  163.204506] RBP: 0000000000000000 R08: 0000582e42cb7148 R09: 0000000000000000
> [  163.204508] R10: 0000000000100000 R11: 0000000000000246 R12: 00007fcdd4c9d000
> [  163.204509] R13: 0000000000100000 R14: 0000000000000980 R15: 0000000000100000
> [  163.204515]  </TASK>
> [  163.204516] ---[ end trace 0000000000000000 ]---
> [  163.204517] EVL: invalid out-of-band syscall <0x43564d41>
> [  163.204550] EVL: invalid out-of-band syscall <0x43564d41>
> [  163.204589] EVL: invalid out-of-band syscall <0x43564d41>
> [  163.204626] EVL: invalid out-of-band syscall <0x43564d41>
> [  163.204647] EVL: invalid out-of-band syscall <0x43564d41>
>
> ...
>

Ok, thanks. This is the piece of information I need. I'll work on this issue.

-- 
Philippe.
