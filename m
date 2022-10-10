Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50052.outbound.protection.outlook.com [40.107.5.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1E02903
	for <xenomai@lists.linux.dev>; Mon, 10 Oct 2022 13:41:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJiJ59Yf4JVt7s4P1RyZRIIoc1MmHI5N+kAIhZw/ycmk6bgPi695X6L2g0+pCHwAufzbYQy56Hk4v5HDfyX1M4nujzmsGz7P+n6AAK2lBN6SiV1qliH0gghkRtOSBOf+Vlft1CTQVrW+ZsDdeZYzQ6sNNycziZ6gr/fLJByxwPbglsERSAP/IALahCdC3EmcVKJaSBVpgGFIaJRSuKw1LFcmi2LBlSEqTttLS7ikPz8JBvElE8s2DvylnV/CQdA674v/fuGZPB9LxFI9wpJgo7C2FJ1I++EAB/VNHBFiBb4SiVH9wEfzO4a/TFkTbN7TxDTRPgtvVNSnGF04lp5Waw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLJCdpUQyXk18ampHhRq1ZXavPy6T7k1eNqmK63g4M0=;
 b=Y8BLa1ISFBae2Ab/yWuH8znVM+gGYXfN030x5AK4Gor7o3nM7gvaQGtGd4BXdzo9QvKZFQVm8wxs6UhAFw3eFEtFXr0GqBOZyllI7rWnjDFCOe3aRRrkkMfbkHmmKcK+Oyxsbm5M39My6i9b0as7ExKdsmjeDninsZEKGVtHtquENKMrOr4ygQ36ihSP3srT8m1350qIlpndq5zVLEn/xaj1j1pe1BcJ4YyACzA7awvgZmakGmaf+c3HrUu3Vrdh0p/A3fABydErGfUZoN73owIxHvmk1yOMHzsTAYEyP+ynJVaQwO+UtnI9gyad8v81ShqZ0OTF8Tnw35pIgEOtRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=126.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLJCdpUQyXk18ampHhRq1ZXavPy6T7k1eNqmK63g4M0=;
 b=bIqVcnjj4/U810kpMlRGWpzAbJBS1evfUJVw7xWUlLj9arxc75DhoB0QgAlPmqkqsXp/u9s47Q1qup8q3GhKVQ/T8NwUrGwj6ITecZ/nDLIzh3xqphAqWT6xZkrqyfXjM8/co8RMeBPt9q6H7xSjNw3+W32Xz5d9dJBENa9UYZFuXnvl6xK9HAt8RT3vnM42J6MW8YGWqZckmgyBMPMgCoCkj193tYjrRjgcOkU4Rdh9jIRetqmawyTsT6RwCO6Xkh8qiSvVDFJdOp+frQ7Bw1mEYW46vpqu8p4BjZzi8iwCOQY6f8Pem/gGPSuz4kRhhMWYEXl6QHovbuGSo65HQg==
Received: from AS8PR05CA0025.eurprd05.prod.outlook.com (2603:10a6:20b:311::30)
 by DB8PR10MB3705.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:132::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 10 Oct
 2022 13:41:41 +0000
Received: from VE1EUR01FT036.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:311:cafe::e3) by AS8PR05CA0025.outlook.office365.com
 (2603:10a6:20b:311::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19 via Frontend
 Transport; Mon, 10 Oct 2022 13:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT036.mail.protection.outlook.com (10.152.3.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 13:41:41 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 10 Oct 2022 15:41:39 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Mon, 10 Oct
 2022 15:41:39 +0200
Message-ID: <1ff093a6-a231-898c-aee6-3bfb19178ae1@siemens.com>
Date: Mon, 10 Oct 2022 15:41:26 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: some kernel exceptions
Content-Language: en-US
To: Yxian.Yao <yxianyao@126.com>, <xenomai@lists.linux.dev>
References: <54a0470d.7082.183c217d486.Coremail.yxianyao@126.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <54a0470d.7082.183c217d486.Coremail.yxianyao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--23.970700-8.000000
X-TMASE-MatchedRID: 5kZRuoL5N6g5QaOxwNGfvvy6J2sQ40CSPg9yfk4YC0b27WtDgGBc8gD4
	keG7QhHmbDD7i2QfyEePGutTIsMtmq4YUaH/Q8F2uAN3LEqlbKOmWOD8X0TFhJr5ykm9NtIcG2P
	mwUTL+u+buvvgpZZI+TsFIVOYY1fQLoD4tn9vWJKulkHlSZ5QMdPxsjeTKRpT0HlMpWf5i5dVog
	WRsEaR/kkrZ4mFjTbDY7btfej9JsI+Op6QH6cKGNwvoAJ3YEa7n48ibeRvdVyEv01fZOqaQJtcY
	V58cc5iR8gZj3ANEgS8AJs9IkFC9ZNAHEbyceNqDrDi7yDegcTVT9opCASd7fwcuqXdCr5KTACU
	LrJNhc6xW4YXFsTUDhZjuFZ2Rc972jtn8HbXDd94W1pIycz0orVV9elkcNTqOdY+ociA+RViMNd
	0z/HZU5QBR+Vr4iFospdaYS9obcQLG8CBpMcXL1+24nCsUSFNt7DW3B48kkGtIWznhjjBtfoLR4
	+zsDTtAqYBE3k9Mpw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.970700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: D51982052CB2EEEF7B9B5AB930FC15036DF13AD6BCC0C37613D209E274CE9BAB2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT036:EE_|DB8PR10MB3705:EE_
X-MS-Office365-Filtering-Correlation-Id: 625b001b-c2e1-4d8c-b3a0-08daaac529f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BIksxv8tHJZKr/BGx25OujzYy7s0OJTZ/VoABxBYW+Dl4ubQU0U9Vbwa1wdBEdaeNmE5xCFmDPFoyXXKvMfX0FNRRCNKq+P1cYHGpTXNeyepRY2irJoV+r0L3FhSTTlANULmclau9FqbSpGkFpENfdqiWxgDf9mb01rZtDWlNqTr34CSXgZzXu9R5zGvsmVuEZ0RN7Zc6zZR27GLuvA3VAzR67t8bDQyr72iJ3v+HedRGDm8LtuJeS7q6GpjWDLFnB3q3/yC6sjIs6X1NBXI5BqDeN1eopYxtR3ywWlKdza+F5CPRiN6kwRGX8b4u43F4sliHmj+ehpcopRuEytN44W8wHdP3+sZk53Sf1ngrF5RQnjkKwBY0BJj7qzcTFV05O5kD4tF+HLz8BpWiP/eZ3p6vgvytQg6tKHCq1AoBAcYBanoslRg+rmuTkWLlDNDxTAw3HNyUz1pA38sHLsbsW4T5VeoIyJ0XMo2iZBB7Nptw0JrEy1uAALHfuG8XtL5q4UPZ4bmErh511V9omtyuqAugdTtnAii8wvrbaT1fekEeOzvfubhLCNT6dpSAIMclPsIOj58mODXeeoICYX18O3VjGCxd8j6O8qZWswEUqp4CL5VhbV0Ra8ksFm1sAsQWEtslgaWbyGKVfYSOdfPeuCpaUAWnJaSjf1GT/PmHZ+U5ektI+XChOkZvAlCsFewzeti9RiahbDTqm3NMF7JBAzftlbHI63lShAscEjTNHmTBpx9trfHW+KKziM+mq98UI4+8hnFj1yFPb8CnVykss4Ud1BMzDKK1omLihZzC5si8yHBFaFheqfDQwbZktT51D2xfa7z5cswsuvBvAvzh3MTvfRs9AmkXai0YOPvLg7Zvt6IsItQ+CgPal9ppsJAFGa8MJxCFkyl5N+ALuWIPw==
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(47076005)(2616005)(82960400001)(81166007)(336012)(3480700007)(956004)(186003)(83380400001)(356005)(5660300002)(44832011)(45080400002)(82740400003)(7116003)(2906002)(40480700001)(16526019)(316002)(40460700003)(8936002)(53546011)(8676002)(36860700001)(6666004)(16576012)(478600001)(70586007)(70206006)(26005)(82310400005)(41300700001)(6706004)(36756003)(31686004)(86362001)(31696002)(110136005)(3940600001)(36900700001)(43740500002)(505234007);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 13:41:41.5331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 625b001b-c2e1-4d8c-b3a0-08daaac529f9
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT036.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3705

On 10.10.22 15:31, Yxian.Yao wrote:
> 
> 
> During the recent testing on the linux-4.19.89-ipipe-9-xenomai-3.1 (linux-4.19.89, ipipe-core-4.19.89-x86-9.patch, xenomai 3.1), 
> the kernel outputs some exception messages, as follows.
> Please give me some hints!

Are you using the perf tool here?

Also, can you check if the issue persists with a recent dovetail kernel
(5.15 or 5.10)? Or are you locked into these versions technically?

Jan

> 
> Thanks a lot.
> 
> 
> [ 5228.358085] perf: interrupt took too long (2504 > 2500), lowering kernel.perf_event_max_sample_rate to 79750
> [13323.899759] perf: interrupt took too long (3137 > 3130), lowering kernel.perf_event_max_sample_rate to 63750
> [62540.659725] hrtimer: interrupt took 12379 ns
> [63405.661958] perf: interrupt took too long (3927 > 3921), lowering kernel.perf_event_max_sample_rate to 50750
> [131204.150039] perf: interrupt took too long (5012 > 4908), lowering kernel.perf_event_max_sample_rate to 39750
> [166021.881707] BUG: unable to handle kernel paging request at 00000000000a22e8
> [166021.889579] PGD 0 P4D 0 
> [166021.892503] Oops: 0000 [#1] PREEMPT SMP PTI
> [166021.897268] CPU: 2 PID: 1604 Comm: RunCommandActor Kdump: loaded Tainted: P           O      4.19.89-ipipe-9-xenomai-3.1-20201027 #1
> [166021.910661] Hardware name: Intel Corporation S2600CWR/S2600CWR, BIOS SE5C610.86B.01.01.0022.C2.062820171903 06/28/2017
> [166021.922696] I-pipe domain: Linux
> [166021.926394] RIP: a2260:0xffff88866761c560
> [166021.930965] Code: 00 00 00 00 00 00 00 00 00 00 c0 8f 6a 67 86 88 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <01> 00 00 00 00 00 00 00 01 01 00 00 00 00 00 00 02 00 00 00 00 00
> [166021.952016] RSP: 81037f07:00000000000a2260 EFLAGS: ffff88866761c560 ORIG_RAX: ffffffff8111953e
> [166021.961726] RAX: 00000000000a2260 RBX: 0000000000000002 RCX: ffffffff828021c0
> [166021.969786] RDX: ffff88866761c560 RSI: 0000000000000000 RDI: 0000000000000000
> [166021.977847] RBP: ffff8886676a4540 R08: 000000000005f3e0 R09: ffffffff811838cb
> [166021.985909] R10: ffffffff8117cddc R11: 0000000000000002 R12: ffff8886676a5d08
> [166021.993969] R13: ffffe8f9ff8077d8 R14: ffff8886676a4540 R15: ffffffff811838cb
> [166022.002030] FS:  00007f73c6ffd700(0000) GS:ffff888667600000(0000) knlGS:0000000000000000
> [166022.011157] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [166022.017666] CR2: 00000000000a22e8 CR3: 0000000c29cf8004 CR4: 00000000001606e0
> [166022.025720] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [166022.033781] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [166022.041843] Call Trace:
> [166022.044667] Modules linked in: fuse mod_samo(PO) mod_drxu(PO) mod_stcu(PO) arc4 ecb md4 sha512_ssse3 sha512_generic cmac nls_utf8 cifs ccm dns_resolver fscache intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes_x86_64 crypto_simd cryptd joydev glue_helper intel_cstate mgag200 ttm drm_kms_helper drm fb_sys_fops iTCO_wdt iTCO_vendor_support lpc_ich intel_uncore syscopyarea evdev ipmi_si ipmi_devintf mfd_core mei_me sysfillrect i2c_i801 ipmi_msghandler mxm_wmi intel_rapl_perf snd_pcsp snd_pcm snd_timer snd soundcore sysimgblt ioatdma mei acpi_power_meter wmi button ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto dm_mod i40evf atlantic i40e ixgb e1000e e1000 e100 mii vmw_pvscsi vmxnet3 sg sd_mod
> [166022.124033]  hid_generic usbhid hid ahci libahci xhci_pci ehci_pci libata xhci_hcd ehci_hcd crc32c_intel igb ixgbe i2c_algo_bit usbcore scsi_mod mdio dca
> 
> [166022.139480] CR2: 00000000000a22e8
> 
> 
> 
> 
> [184723.509341] BUG: unable to handle kernel paging request at 00000000000a22e8
> [184723.516418] BUG: unable to handle kernel paging request at 0000000000048044
> [184723.523453] PGD 0 P4D 0 
> [184723.526072] Oops: 0010 [#1] PREEMPT SMP PTI
> [184723.530336] CPU: 2 PID: 4763 Comm: RunCommandActor Kdump: loaded Tainted: P           O      4.19.89-ipipe-9-xenomai-3.1-20201027 #1
> [184723.542312] Hardware name: Supermicro Kontron C612XS1/Kontron C612XS1, BIOS 2.0a.V2 07/04/2021
> [184723.550996] I-pipe domain: Linux
> [184723.554308] RIP: 0010:0x48044
> [184723.557360] Code: Bad RIP value.
> [184723.560669] RSP: 0018:ffff88885fa03ed0 EFLAGS: 00051046
> [184723.565972] RAX: ffff88885fa5f3e0 RBX: ffffffffa07ed4a8 RCX: ffff88885f8a4540
> [184723.573184] RDX: 0000000000000000 RSI: ffffffff81e0f0a7 RDI: 000000000000000b
> [184723.580394] RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000a7e
> [184723.587604] R10: 000000000000000f R11: ffffffff825b1eee R12: dead000000000200
> [184723.594815] R13: dead000000000100 R14: ffffffffa07ed480 R15: ffffc90003b5fa40
> [184723.602028] FS:  00007f4ad57fa700(0000) GS:ffff88885fa00000(0000) knlGS:0000000000000000
> [184723.610190] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [184723.616014] CR2: 000000000004801a CR3: 0000000813a66001 CR4: 00000000001606e0
> [184723.623225] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [184723.630435] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [184723.637645] Call Trace:
> [184723.640178]  <IRQ>
> [184723.642277]  ? xnthread_switch_fpu+0x21/0x30
> [184723.646636]  ? ___xnsched_run.part.68+0x1fb/0x460
> [184723.651426]  ? xnintr_core_clock_handler+0x20d/0x310
> [184723.656471]  ? ___xnsched_run.part.68+0x120/0x460
> [184723.661257]  ? __ipipe_dispatch_irq+0x120/0x1b0
> [184723.665876]  ? __ipipe_handle_irq+0x67/0x1e0
> [184723.670226]  ? common_interrupt+0xf/0x2c
> [184723.674229]  </IRQ>
> [184723.676412] WARNING: stack recursion on stack type 2
> [184723.676413] Modules linked in: mod_daconrt(PO) mod_daco(PO) mod_pgcu(PO) mod_tsmu(PO) mod_scc(PO) fuse arc4 ecb md4 sha512_ssse3 sha512_generic cmac nls_utf8 cifs ccm dns_resolver fscache intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes_x86_64 crypto_simd cryptd glue_helper intel_cstate intel_uncore intel_rapl_perf snd_hda_codec_realtek snd_hda_codec_generic iTCO_wdt iTCO_vendor_support joydev snd_hda_intel ast evdev snd_hda_codec ttm snd_pcsp drm_kms_helper i2c_i801 snd_hda_core drm snd_hwdep fb_sys_fops syscopyarea sysfillrect snd_pcm sysimgblt snd_timer snd lpc_ich soundcore mfd_core wmi ipmi_si ipmi_devintf ipmi_msghandler button ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto dm_mod
> [184723.752393]  hid_generic usbhid hid i40evf atlantic ixgbe mdio ixgb e1000e e1000 e100 mii vmw_pvscsi vmxnet3 sg sd_mod ahci xhci_pci libahci ehci_pci libata igb ehci_hcd i2c_algo_bit xhci_hcd scsi_mod dca crc32c_intel usbcore i40e [last unloaded: mod_scc]
> [184723.775041] CR2: 0000000000048044

-- 
Siemens AG, Technology
Competence Center Embedded Linux

