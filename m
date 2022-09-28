Received: from mx0a-001f5801.pphosted.com (mx0a-001f5801.pphosted.com [148.163.157.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6114C62
	for <xenomai@lists.linux.dev>; Wed, 28 Sep 2022 18:35:54 +0000 (UTC)
Received: from pps.filterd (m0090334.ppops.net [127.0.0.1])
	by mx0a-001f5801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SH71F3023758;
	Wed, 28 Sep 2022 11:35:53 -0700
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02lp0179.outbound.protection.office365.us [23.103.199.179])
	by mx0a-001f5801.pphosted.com (PPS) with ESMTPS id 3jvqpu8u7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Sep 2022 11:35:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=bKBztAMXuqFC+g42lJBmHGNgLuNVHCXrp7ibcwcpZ9VzTGFEp9XKovLrZ+XqxUzy0Vi2DsGEI/NdKYHBsBO7p5wpBDS3nYI7ZxjXt5lCoCQKjJKPTMh5FkteOUtmD4/nfqX4jTz3UeE9wtvqS/lXFwLmOj56LOCBZlr3FNmScpmd+jgOcJqiMq9fot9PX755FiXYhpnKHTtzYERlKi+ThjoUiqxtKYCX7H07db+nxFynW5x0JYembVLWmKlrH+6+/qBROegNMx/j97w/ts6dxlwF1fXZBho2vZf/Z0vM2uqQo1nfUel/BQIrYuzBlSgFNo37mzllWy+v3kzlFtmOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhHgSyh7bBYzHxpYjGv/A3S7LWa2S2v6CGugsBzYrNc=;
 b=y0Awq09PgUBlayPdgmUkwMGi6/uo+lDmVKFWMRjexirlDK2sMmUZ9ESeMZ49H3PY1lVUXiQ7vPE9c545PzHYSs4WWCJn/inb5y15HIepSfGLebYFqpFS6zTwwdlBwafV9yuKxGluzu+ypnVomRi8fz0jib6czaVSx4YHXPeucWVgU2KXngBLwVx4o8WP5RzqTn2vONBTnmSqiPSmbzQus5KBL3W1SjfSVueSZKbWiWz56CYOgoNcuzQz/eN0mZLBF10nx4QdbpfqT8Crto1zuXzbjInID5TX7VFRNF1NogDnBBz37gHTy6tVdhrsrv12krZ1MefhhEQMohCm4JoUVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhHgSyh7bBYzHxpYjGv/A3S7LWa2S2v6CGugsBzYrNc=;
 b=KT8aEPcpeKSiAEfrHYwZWFS0+HEQDJUuTEpGY2THqBd2uYMk63s0Zoe+KXlIvTDXMVgNBib9pFtBh8pRxL/MwJvaIExzN/ukjQWQucypCO7ewxx7TaXebrrpSvPGa/GUWANs/qrNhHHPrwsSi1Vjoc9CzS1LSbnSHZe0rRU97CIF1Det8PBVr+BAgqDWDo1rlxisc3cPsLElOznphRZA8Gc1PGOcoKY14KqBFQJcK4vcPfc+g90HoEuIqdN927f61A5BXNi0rqnHTs8Gicii1jizw1AXWLfIQRkiwWT4yui4ixyCReM/LIpYpAm59nxmf8m8aaupU5H5pckyu++mag==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1507.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Wed, 28 Sep
 2022 18:35:05 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::dd17:900:976c:937c]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::dd17:900:976c:937c%5]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 18:35:05 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: Bryan Butler <Bryan.Butler@kratosdefense.com>,
        "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: [External] - Re: System hanging when using condition variables
Thread-Topic: [External] - Re: System hanging when using condition variables
Thread-Index: 
 AdjMb2kqEi/6rzVHQeiyZvhBQUhKewCH+EqAAD3N5wAAGglKAABAL88AAANEjQAALawygABDfHNwABf1R4AAEfuKoA==
Date: Wed, 28 Sep 2022 18:35:05 +0000
Message-ID: 
 <PH1P110MB1050C74BE6BB64AD707616BAE2549@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87pmfncw9u.fsf@xenomai.org>
 <BN2P110MB128891FFD2A6A7F6AAF6C5EE8F519@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <87o7v59o02.fsf@xenomai.org> <87illb8pfs.fsf@xenomai.org>
 <87edvz8l5i.fsf@xenomai.org>
 <BN2P110MB1288812BD18DBAA0E2714B618F529@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050E6764B49A09B1699F3D1E2559@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87h70r7r0m.fsf@xenomai.org>
In-Reply-To: <87h70r7r0m.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB1507:EE_
x-ms-office365-filtering-correlation-id: 31a6d68c-754c-46de-45ec-08daa1802990
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 z1401LhABy6y/WrDBZ9OcWpvNRGYGEsRQm8G4x2ijWuQW2RyP2LOhCPb09bKm7UNSQFvQmG6gYMTsM6biirh78VKWQOcQMtp8yxTaT0RjO0095n+5NgAa17raeLTsjFnR51ckHneTTwWvZGix5cNaz5oPdbsIkmwXzFtvnCaMc42bKbOs0dB6mnweUZoQS7ONZiaBNtECSXivDGraTQyKrwaQJ2/HqvcQ6MiumYY4KSxytvvQzM3MKyTsR2+Uhk785D8FAV/hOgwmIze+GBvawHQCQm2fzT+RR4HSxmYUeOQgAh/8MRDV0VfjFiOcTyZTdE6L/OJspDR3KPof4XlqjEOA4+99Sc9ncbrkka+76pzrEXW+VKWaJq/2t38jEdq1Q5b3TCm8UGlJCXT4ts89OlhvAkgsM/dNtCImeWy/fGU9/OYGOsLY34CoJL4g/b8QDYK7jDaqLWUBY8D9FAbtO6Dv6hH0jyKjOiuwv5UtPz28QaKYA0P1+ygH8OwW2R41PGhOr7crx2oEnaY2TYv6rERXEtAGtMzNsS8YhXZr7bA1rFZMmuFKTnmUHImlvkICJb90SG/92vyGWMiZtZGhUKXTlsjm7uEDGGassfN+DcV5EXBO/hXwAfDJBJovOyXZgm0cC9ookSppbIzQxtdVAV5U1gbFYf2jsxPoa1VvR7DgUjjMhWAQ7Mgt1la42IX
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(8936002)(5660300002)(44832011)(52536014)(4744005)(76116006)(66946007)(86362001)(66556008)(6916009)(54906003)(6506007)(7696005)(64756008)(2906002)(4326008)(8676002)(33656002)(498600001)(55016003)(66476007)(66446008)(71200400001)(83380400001)(38070700005)(38100700002)(122000001)(99936003)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 qPRbkQh6bLR00bQJc9kI14kMWNAfsi1QlVnSkYh9PlcRmLcMUpl+V2tVtCDGjM/yKZbsXcuolSyL1VggK2BW+lPLAf4UfRhSxkQPKP0lhjNWgCH2U40w0c0vuJEM69RXqMK+noHDY14lErEcLfUynjvJSZidN0b78ISsxjSfAqicyQ/43miJ1Knqfs+6ujB+HPJ2sf0liE3JCFzWRVNe4TXjkmHCcOgVREyy5yF7bliIijze2GaDb4AfUhJl8A7uhL+1Fe+3y5cvJLueu33Ca+6rolDyymX2gtHeQaqWg81A4hR+w7RBkrhYkS+5EX4fysalQDtiVc0q1eVBfigVFBCeglzvCTgTSczNrrhYIneWvocHXV9X4ykW45/4dnsF6RaWa1Dy6huOt6tKEV8vxt/o1YkbQYfEurLguqy46ko37lVTq2g1W+1YTK5Q24xTs5FB9odavODdMNgRfvt8sunasdGrfFak+VsAyh3tCpI=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_0349_01D8D336.BB863860"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a6d68c-754c-46de-45ec-08daa1802990
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 18:35:05.1397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1507
X-Proofpoint-GUID: -qZzf96TQ2sOKRbcVAQJVhhELfX4ZxDJ
X-Proofpoint-ORIG-GUID: -qZzf96TQ2sOKRbcVAQJVhhELfX4ZxDJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_08,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280110

------=_NextPart_000_0349_01D8D336.BB863860
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_034A_01D8D336.BB863860"


------=_NextPart_001_034A_01D8D336.BB863860
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

>Could you enable CONFIG_PROVE_LOCKING, CONFIG_EXPERT then 
>CONFIG_DEBUG_HARD_LOCKS for testing? Maybe lockdep is going 
>to help us (this will wreck the timings with a significant slowdown, 
>hopefully the app can still run in a degraded mode in that case).

I have done as you asked and have attached all the dump I get from the
kernel leading up to and after the hang.

Russell

------=_NextPart_001_034A_01D8D336.BB863860
Content-Type: text/plain;
	name="stacktrace_3.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="stacktrace_3.txt"

[  705.469776] DEBUG_LOCKS_WARN_ON(!irqs_disabled())
[  705.469779] WARNING: CPU: 9 PID: 4107 at kernel/locking/lockdep.c:167 =
__lock_acquire+0x1379/0x1580
mEVL: Ma[  705.469788] Modules linked in: dma_buf_mgr(OE) =
rtlstddriver(OE) xt_CHECKSUM xt_MASQUERADE tun ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt iTCO_vendor_support gpio_ich =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl intel_cstate pcspkr i2c_i801 intel_pch_thermal =
i2c_smbus sg lpc_ich mfd_core mei_me joydev input_leds mei ftdi_sio =
ioatdma acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler wmi acpi_pad =
ip_tables xfs libcrc32c sd_mod ast sr_mod cdrom t10_pi drm_vram_helper =
drm_kms_helper syscopyarea sysfillrect sysimgblt
in[4096] could not receive HM ev[  705.469844]  fb_sys_fops =
drm_ttm_helper ttm igb drm ixgbe ahci libahci crc32c_intel libata mdio =
ptp pps_core i2c_algo_bit dca
ent #2
  705.469854] CPU: 9 PID: 4107 Comm: IRQ_0xded_3_1 Tainted: G        W  =
OE     5.15.64evl-g18085c66e3ca #8
m[  +0.001547]  Hardware name: Supermicro Super Server/X10SDV-6C-TLN4F, =
BIOS 1.3 02/13/2018
[0mEVL IRQ stage: EVL
[1m: Main[4096] [  705.469860] RIP: 0010:__lock_acquire+0x1379/0x1580
could not receiv[  705.469864] Code: 3f 00 85 c0 0f 84 07 fe ff ff 83 3d =
28 23 99 01 00 0f 85 fa fd ff ff 48 c7 c6 97 b7 32 a1 48 c7 c7 db 14 31 =
a1 e8 2d c1 99 00 <0f> 0b e9 e0 fd ff ff 84 d2 0f 84 87 01 00 00 83 05 =
dd 20 ea 01 01
e HM event #2  705.469866] RSP: 0018:ffffabff0172f960 EFLAGS: 00010086
m
[  +0.00[  705.469869] RAX: 0000000000000000 RBX: ffff89cfc01b5398 RCX: =
0000000000000027
1970] E[  705.469870] RDX: 0000000000000027 RSI: ffff89d2ed89bb10 RDI: =
ffff89d2ed89bb18
VL: Main[  705.469872] RBP: ffffabff0172f9d0 R08: ffffffffa280baa0 R09: =
0000000000000000
[4096] could not[  705.469873] R10: ffffffffa280baa0 R11: =
0000000000000034 R12: 0000000000000001
 receive HM even[  705.469874] R13: ffff89cfc01b4580 R14: =
ffff89cfc01b5370 R15: e2a93f30ac2a174c
t #2
[[  705.469876] FS:  00007f706fae8700(0000) GS:ffff89d2ed880000(0000) =
knlGS:0000000000000000
  +0.004512]   705.469878] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
mEVL  705.469879] CR2: 0000000000000000 CR3: 000000016869a002 CR4: =
00000000003706e0
m: Main[4096] co[  705.469881] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
uld not receive [  705.469882] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
[  705.469883] Call Trace:

[  705.469884]  <TASK>
[  705.470073]  reacquire_held_locks+0xda/0x1f0
[  705.470090]  ? __evl_schedule+0x99/0x9f0
[  705.470121]  ? evl_start_timer+0xa9/0x210
[  705.470211]  ? __evl_schedule+0x339/0x9f0
[  705.470252]  lock_release+0x114/0x270
[  705.470368]  __evl_schedule+0x383/0x9f0
[  705.470483]  handle_irq_pipelined_finish+0xfd/0x1c0
[  705.470524]  arch_pipeline_entry+0xcd/0x120
[  705.470592]  sysvec_apic_timer_interrupt+0xe/0x20
[  705.470608]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  705.470611] RIP: 0010:kernfs_link_sibling+0x2a/0xe0
[  705.470617] Code: 55 31 d2 48 89 e5 41 54 49 89 fc 53 48 8b 47 30 48 =
83 c0 70 eb 09 74 40 48 8d 43 08 48 89 da 48 8b 18 48 85 db 74 3f 8b 43 =
20 <41> 39 44 24 60 72 21 77 e5 48 8b 43 18 49 39 44 24 58 72 14 77 d8
[  705.470620] RSP: 0018:ffffabff0172fc10 EFLAGS: 00000282
[  705.470621] RAX: 000000005b25ab7b RBX: ffff89cfc1545c10 RCX: =
ffff89cfc153c0fd
[  705.470623] RDX: 0000000000000000 RSI: 000000009501fbf3 RDI: =
ffff89cfc929bdc8
[  705.470624] RBP: ffffabff0172fc20 R08: 0000000000000001 R09: =
0000000000000000
[  705.470625] R10: ffffabff0172fc30 R11: 0000000000000000 R12: =
ffff89cfc929bdc8
[  705.470626] R13: ffff89cfc3c439d8 R14: ffff89cfc12b92e0 R15: =
ffff89cfc12b5800
[  705.470919]  kernfs_add_one+0x9c/0x150
[  705.470971]  kernfs_create_dir_ns+0x4e/0x80
[  705.471023]  sysfs_create_dir_ns+0x71/0xe0
[  705.471126]  kobject_add_internal+0xaf/0x280
[  705.471218]  kobject_add+0x7d/0xb0
[  705.471295]  ? mutex_unlock+0xd/0x20
[  705.471386]  device_add+0x115/0x8f0
[  705.471441]  ? __raw_spin_lock_init+0x3b/0x70
[  705.471558]  device_register+0x15/0x20
[  705.471586]  create_sys_device+0xb3/0xd0
[  705.471666]  create_element_device+0x21c/0x3e0
[  705.471773]  ioctl_clone_device+0xf2/0x210
[  705.471952]  __x64_sys_ioctl+0x91/0xd0
[  705.472031]  do_syscall_64+0x44/0xb0
[  705.472058]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[  705.472063] RIP: 0033:0x7f70791c5307
[  705.472072] Code: Unable to access opcode bytes at RIP =
0x7f70791c52dd.
[  705.472073] RSP: 002b:00007f706fad8618 EFLAGS: 00000246 ORIG_RAX: =
0000000000000010
[  705.472075] RAX: ffffffffffffffda RBX: 00007f7064000930 RCX: =
00007f70791c5307
[  705.472077] RDX: 00007f706fad8640 RSI: 00000000c0286600 RDI: =
0000000000000059
[  705.472078] RBP: 0000000000000059 R08: 0000000000000000 R09: =
00007f70640008c0
[  705.472079] R10: 0000000000000002 R11: 0000000000000246 R12: =
0000000000060000
[  705.472081] R13: 00007f708126bd6c R14: 00007f706fad86c4 R15: =
0000000000000000
[  705.472344]  </TASK>
[  705.472345] irq event stamp: 407
[  705.472346] hardirqs last  enabled at (407): [<ffffffffa0aeb18f>] =
arch_pipeline_entry+0xaf/0x120
[  705.472350] hardirqs last disabled at (406): [<ffffffffa0aeb164>] =
arch_pipeline_entry+0x84/0x120
[  705.472354] softirqs last  enabled at (0): [<ffffffffa007f6eb>] =
copy_process+0xcab/0x1ff0
[  705.472359] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  705.472368] ---[ end trace a9ec12d9ddac5535 ]---
[  707.133493] sched: RT throttling activated
[  +0.001876] EVL: Main[4096] could not receive HM event #2
[  +0.098500] ------------[ cut here ]------------
[  +0.000002] DEBUG_LOCKS_WARN_ON(!irqs_disabled())
[  +0.000003] WARNING: CPU: 9 PID: 4107 at kernel/locking/lockdep.c:167 =
__lock_acquire+0x1379/0x1580
[  +0.000009] Modules linked in: dma_buf_mgr(OE) rtlstddriver(OE) =
xt_CHECKSUM xt_MASQUERADE tun ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 =
ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ip6table_nat =
ip6table_mangle ip6table_security ip6table_raw iptable_nat nf_nat =
iptable_mangle iptable_security iptable_raw nf_conntrack nf_defrag_ipv6 =
nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables rfkill =
ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt iTCO_vendor_support gpio_ich =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl intel_cstate pcspkr i2c_i801 intel_pch_thermal =
i2c_smbus sg lpc_ich mfd_core mei_me joydev input_leds mei ftdi_sio =
ioatdma acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler wmi acpi_pad =
ip_tables xfs libcrc32c sd_mod ast sr_mod cdrom t10_pi drm_vram_helper =
drm_kms_helper syscopyarea sysfillrect sysimgblt
[  +0.000056]  fb_sys_fops drm_ttm_helper ttm igb drm ixgbe ahci libahci =
crc32c_intel libata mdio ptp pps_core i2c_algo_bit dca
[  +0.000010] CPU: 9 PID: 4107 Comm: IRQ_0xded_3_1 Tainted: G        W  =
OE     5.15.64evl-g18085c66e3ca #8
[  +0.000004] Hardware name: Supermicro Super Server/X10SDV-6C-TLN4F, =
BIOS 1.3 02/13/2018
[  +0.000001] IRQ stage: EVL
[  +0.000001] RIP: 0010:__lock_acquire+0x1379/0x1580
[  +0.000004] Code: 3f 00 85 c0 0f 84 07 fe ff ff 83 3d 28 23 99 01 00 =
0f 85 fa fd ff ff 48 c7 c6 97 b7 32 a1 48 c7 c7 db 14 31 a1 e8 2d c1 99 =
00 <0f> 0b e9 e0 fd ff ff 84 d2 0f 84 87 01 00 00 83 05 dd 20 ea 01 01
[  +0.000002] RSP: 0018:ffffabff0172f960 EFLAGS: 00010086
[  +0.000003] RAX: 0000000000000000 RBX: ffff89cfc01b5398 RCX: =
0000000000000027
[  +0.000001] RDX: 0000000000000027 RSI: ffff89d2ed89bb10 RDI: =
ffff89d2ed89bb18
[  +0.000002] RBP: ffffabff0172f9d0 R08: ffffffffa280baa0 R09: =
0000000000000000
[  +0.000001] R10: ffffffffa280baa0 R11: 0000000000000034 R12: =
0000000000000001
[  +0.000001] R13: ffff89cfc01b4580 R14: ffff89cfc01b5370 R15: =
e2a93f30ac2a174c
[  +0.000002] FS:  00007f706fae8700(0000) GS:ffff89d2ed880000(0000) =
knlGS:0000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000001] CR2: 0000000000000000 CR3: 000000016869a002 CR4: =
00000000003706e0
[  +0.000002] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[  +0.000001] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[  +0.000001] Call Trace:
[  +0.000001]  <TASK>
[  +0.000189]  reacquire_held_locks+0xda/0x1f0
[  +0.000017]  ? __evl_schedule+0x99/0x9f0
[  +0.000031]  ? evl_start_timer+0xa9/0x210
[  +0.000090]  ? __evl_schedule+0x339/0x9f0
[  +0.000041]  lock_release+0x114/0x270
[  +0.000116]  __evl_schedule+0x383/0x9f0
[  +0.000115]  handle_irq_pipelined_finish+0xfd/0x1c0
[  +0.000041]  arch_pipeline_entry+0xcd/0x120
[  +0.000068]  sysvec_apic_timer_interrupt+0xe/0x20
[  +0.000016]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  +0.000003] RIP: 0010:kernfs_link_sibling+0x2a/0xe0
[  +0.000006] Code: 55 31 d2 48 89 e5 41 54 49 89 fc 53 48 8b 47 30 48 =
83 c0 70 eb 09 74 40 48 8d 43 08 48 89 da 48 8b 18 48 85 db 74 3f 8b 43 =
20 <41> 39 44 24 60 72 21 77 e5 48 8b 43 18 49 39 44 24 58 72 14 77 d8
[  +0.000003] RSP: 0018:ffffabff0172fc10 EFLAGS: 00000282
[  +0.000001] RAX: 000000005b25ab7b RBX: ffff89cfc1545c10 RCX: =
ffff89cfc153c0fd
[  +0.000002] RDX: 0000000000000000 RSI: 000000009501fbf3 RDI: =
ffff89cfc929bdc8
[  +0.000001] RBP: ffffabff0172fc20 R08: 0000000000000001 R09: =
0000000000000000
[  +0.000001] R10: ffffabff0172fc30 R11: 0000000000000000 R12: =
ffff89cfc929bdc8
[  +0.000001] R13: ffff89cfc3c439d8 R14: ffff89cfc12b92e0 R15: =
ffff89cfc12b5800
[  +0.000293]  kernfs_add_one+0x9c/0x150
[  +0.000052]  kernfs_create_dir_ns+0x4e/0x80
[  +0.000052]  sysfs_create_dir_ns+0x71/0xe0
[  +0.000103]  kobject_add_internal+0xaf/0x280
[  +0.000092]  kobject_add+0x7d/0xb0
[  +0.000077]  ? mutex_unlock+0xd/0x20
[  +0.000091]  device_add+0x115/0x8f0
[  +0.000055]  ? __raw_spin_lock_init+0x3b/0x70
[  +0.000117]  device_register+0x15/0x20
[  +0.000028]  create_sys_device+0xb3/0xd0
[  +0.000080]  create_element_device+0x21c/0x3e0
[  +0.000107]  ioctl_clone_device+0xf2/0x210
[  +0.000179]  __x64_sys_ioctl+0x91/0xd0
[  +0.000079]  do_syscall_64+0x44/0xb0
[  +0.000027]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[  +0.000005] RIP: 0033:0x7f70791c5307
[  +0.000009] Code: Unable to access opcode bytes at RIP 0x7f70791c52dd.
[  +0.000001] RSP: 002b:00007f706fad8618 EFLAGS: 00000246 ORIG_RAX: =
0000000000000010
[  +0.000002] RAX: ffffffffffffffda RBX: 00007f7064000930 RCX: =
00007f70791c5307
[  +0.000002] RDX: 00007f706fad8640 RSI: 00000000c0286600 RDI: =
0000000000000059
[  +0.000001] RBP: 0000000000000059 R08: 0000000000000000 R09: =
00007f70640008c0
[  +0.000001] R10: 0000000000000002 R11: 0000000000000246 R12: =
0000000000060000
[  +0.000002] R13: 00007f708126bd6c R14: 00007f706fad86c4 R15: =
0000000000000000
[  +0.000263]  </TASK>
[  +0.000001] irq event stamp: 407
[  +0.000001] hardirqs last  enabled at (407): [<ffffffffa0aeb18f>] =
arch_pipeline_entry+0xaf/0x120
[  +0.000004] hardirqs last disabled at (406): [<ffffffffa0aeb164>] =
arch_pipeline_entry+0x84/0x120
[  +0.000004] softirqs last  enabled at (0): [<ffffffffa007f6eb>] =
copy_process+0xcab/0x1ff0
[  +0.000005] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  +0.000009] ---[ end trace a9ec12d9ddac5535 ]---
[  +1.661125] sched: RT throttling activated
[  734.815783] watchdog: BUG: soft lockup - CPU#6 stuck for 23s! =
[kworker/6:1:150]
[  734.838473] Modules linked in: dma_buf_mgr(OE) rtlstddriver(OE) =
xt_CHECKSUM xt_MASQUERADE tun ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 =
ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ip6table_nat =
ip6table_mangle ip6table_security ip6table_raw iptable_nat nf_nat =
iptable_mangle iptable_security iptable_raw nf_conntrack nf_defrag_ipv6 =
nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables rfkill =
ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt iTCO_vendor_support gpio_ich =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl intel_cstate pcspkr i2c_i801 intel_pch_thermal =
i2c_smbus sg lpc_ich mfd_core mei_me joydev input_leds mei ftdi_sio =
ioatdma acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler wmi acpi_pad =
ip_tables xfs libcrc32c sd_mod ast sr_mod cdrom t10_pi drm_vram_helper =
drm_kms_helper syscopyarea sysfillrect sysimgblt
[  734.838574]  fb_sys_fops drm_ttm_helper ttm igb drm ixgbe ahci =
libahci crc32c_intel libata mdio ptp pps_core i2c_algo_bit dca
[  735.140374] irq event stamp: 97074
[  735.151534] hardirqs last  enabled at (97073): [<ffffffffa0afe622>] =
_raw_spin_unlock_irq+0x22/0x40
[  735.179360] hardirqs last disabled at (97074): [<ffffffffa0af48e2>] =
__schedule+0x282/0xa70
[  735.205101] softirqs last  enabled at (97040): [<ffffffffa0e002e9>] =
__do_softirq+0x2e9/0x421
[  735.231354] softirqs last disabled at (97035): [<ffffffffa008aa3d>] =
irq_exit_rcu+0xcd/0xf0
[  735.257104] CPU: 6 PID: 150 Comm: kworker/6:1 Tainted: G        W  OE =
    5.15.64evl-g18085c66e3ca #8
[  735.285716] Hardware name: Supermicro Super Server/X10SDV-6C-TLN4F, =
BIOS 1.3 02/13/2018
[  735.310703] IRQ stage: Linux
[  735.320347] Workqueue: events netstamp_clear
[  735.334158] RIP: 0010:smp_call_function_many_cond+0x154/0x370
[  735.352396] Code: 89 c7 e8 2f 32 3e 00 3b 05 6d ea 92 01 73 96 48 63 =
d0 48 8b 0b 48 03 0c d5 80 b8 3f a1 8b 51 08 83 e2 01 74 0a f3 90 8b 51 =
08 <83> e2 01 75 f6 eb cb 80 3d 16 91 92 01 00 0f 85 f8 fe ff ff 8b 05
[  735.410801] RSP: 0018:ffffabff00cb3cc0 EFLAGS: 00000202 ORIG_RAX: =
0000000000000000
[  735.434593] RAX: 0000000000000000 RBX: 0000000000000000 RCX: =
0000000000000000
[  735.457094] RDX: 0000000000000000 RSI: 0000000000000000 RDI: =
0000000000000000
[  735.479571] RBP: ffffabff00cb3d20 R08: 0000000000000000 R09: =
0000000000000000
[  735.502061] R10: 0000000000000000 R11: 0000000000000000 R12: =
0000000000000000
[  735.524551] R13: 0000000000000000 R14: 0000000000000000 R15: =
0000000000000000
[  735.547034] FS:  0000000000000000(0000) GS:ffff89d2ed700000(0000) =
knlGS:0000000000000000
[  735.572371] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  735.590855] CR2: 00007f32f76c5504 CR3: 0000000240612004 CR4: =
00000000003706e0
[  735.613379] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[  735.635883] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[  735.658387] Call Trace:
[  735.666817]  <TASK>
[  735.674183]  ? __text_poke+0x4a0/0x4a0
[  735.686507]  ? netif_receive_skb_list_internal+0x3d/0x370
[  735.703780]  on_each_cpu_cond_mask+0x24/0x40
[  735.717675]  text_poke_bp_batch+0xbc/0x2c0
[  735.731054]  ? netif_receive_skb_list_internal+0x3d/0x370
[  735.748316]  text_poke_finish+0x1a/0x30
[  735.760906]  arch_jump_label_transform_apply+0x17/0x30
[  735.777384]  __jump_label_update+0xdd/0x120
[  735.791007]  jump_label_update+0xc9/0xf0
[  735.803842]  static_key_enable_cpuslocked+0x5f/0x90
[  735.819547]  static_key_enable+0x15/0x30
[  735.832378]  netstamp_clear+0x28/0x40
[  735.844413]  process_one_work+0x29a/0x590
[  735.857483]  worker_thread+0x2f/0x3e0
[  735.869494]  ? process_one_work+0x590/0x590
[  735.883033]  kthread+0x13b/0x160
[  735.893687]  ? set_kthread_struct+0x50/0x50
[  735.907157]  ret_from_fork+0x22/0x30
[  735.918779]  </TASK>
[ +27.682290] watchdog: BUG: soft lockup - CPU#6 stuck for 23s! =
[kworker/6:1:150]
[  +0.022690] Modules linked in: dma_buf_mgr(OE) rtlstddriver(OE) =
xt_CHECKSUM xt_MASQUERADE tun ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 =
ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ip6table_nat =
ip6table_mangle ip6table_security ip6table_raw iptable_nat nf_nat =
iptable_mangle iptable_security iptable_raw nf_conntrack nf_defrag_ipv6 =
nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables rfkill =
ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt iTCO_vendor_support gpio_ich =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl intel_cstate pcspkr i2c_i801 intel_pch_thermal =
i2c_smbus sg lpc_ich mfd_core mei_me joydev input_leds mei ftdi_sio =
ioatdma acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler wmi acpi_pad =
ip_tables xfs libcrc32c sd_mod ast sr_mod cdrom t10_pi drm_vram_helper =
drm_kms_helper syscopyarea sysfillrect sysimgblt
[  +0.000101]  fb_sys_fops drm_ttm_helper ttm igb drm ixgbe ahci libahci =
crc32c_intel libata mdio ptp pps_core i2c_algo_bit dca
[  +0.301800] irq event stamp: 97074
[  +0.011160] hardirqs last  enabled at (97073): [<ffffffffa0afe622>] =
_raw_spin_unlock_irq+0x22/0x40
[  +0.027826] hardirqs last disabled at (97074): [<ffffffffa0af48e2>] =
__schedule+0x282/0xa70
[  +0.025741] softirqs last  enabled at (97040): [<ffffffffa0e002e9>] =
__do_softirq+0x2e9/0x421
[  +0.026253] softirqs last disabled at (97035): [<ffffffffa008aa3d>] =
irq_exit_rcu+0xcd/0xf0
[  +0.025750] CPU: 6 PID: 150 Comm: kworker/6:1 Tainted: G        W  OE  =
   5.15.64evl-g18085c66e3ca #8
[  +0.028612] Hardware name: Supermicro Super Server/X10SDV-6C-TLN4F, =
BIOS 1.3 02/13/2018
[  +0.024987] IRQ stage: Linux
[  +0.009644] Workqueue: events netstamp_clear
[  +0.013811] RIP: 0010:smp_call_function_many_cond+0x154/0x370
[  +0.018238] Code: 89 c7 e8 2f 32 3e 00 3b 05 6d ea 92 01 73 96 48 63 =
d0 48 8b 0b 48 03 0c d5 80 b8 3f a1 8b 51 08 83 e2 01 74 0a f3 90 8b 51 =
08 <83> e2 01 75 f6 eb cb 80 3d 16 91 92 01 00 0f 85 f8 fe ff ff 8b 05
[  +0.058405] RSP: 0018:ffffabff00cb3cc0 EFLAGS: 00000202 ORIG_RAX: =
0000000000000000

Message from syslogd@boromir at Sep 28 12:32:50 ...
 kernel:watchdog: BUG: soft lockup - CPU#6 stuck for 23s! =
[kworker/6:1:150]
[  +0.023792] RAX: 0000000000000000 RBX: 0000000000000000 RCX: =
0000000000000000
[  +0.022501] RDX: 0000000000000000 RSI: 0000000000000000 RDI: =
0000000000000000
[  +0.022477] RBP: ffffabff00cb3d20 R08: 0000000000000000 R09: =
0000000000000000
[  +0.022490] R10: 0000000000000000 R11: 0000000000000000 R12: =
0000000000000000
[  +0.022490] R13: 0000000000000000 R14: 0000000000000000 R15: =
0000000000000000
[  +0.022483] FS:  0000000000000000(0000) GS:ffff89d2ed700000(0000) =
knlGS:0000000000000000
[  +0.025337] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.018484] CR2: 00007f32f76c5504 CR3: 0000000240612004 CR4: =
00000000003706e0
[  +0.022524] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[  +0.022504] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[  +0.022504] Call Trace:
[  +0.008430]  <TASK>
[  +0.007366]  ? __text_poke+0x4a0/0x4a0
[  +0.012324]  ? netif_receive_skb_list_internal+0x3d/0x370
[  +0.017273]  on_each_cpu_cond_mask+0x24/0x40
[  +0.013895]  text_poke_bp_batch+0xbc/0x2c0
[  +0.013379]  ? netif_receive_skb_list_internal+0x3d/0x370
[  +0.017262]  text_poke_finish+0x1a/0x30
[  +0.012590]  arch_jump_label_transform_apply+0x17/0x30
[  +0.016478]  __jump_label_update+0xdd/0x120
[  +0.013623]  jump_label_update+0xc9/0xf0
[  +0.012835]  static_key_enable_cpuslocked+0x5f/0x90
[  +0.015705]  static_key_enable+0x15/0x30
[  +0.012831]  netstamp_clear+0x28/0x40
[  +0.012035]  process_one_work+0x29a/0x590
[  +0.013070]  worker_thread+0x2f/0x3e0
[  +0.012011]  ? process_one_work+0x590/0x590
[  +0.013539]  kthread+0x13b/0x160
[  +0.010654]  ? set_kthread_struct+0x50/0x50
[  +0.013470]  ret_from_fork+0x22/0x30
[  +0.011622]  </TASK>

------=_NextPart_001_034A_01D8D336.BB863860--

------=_NextPart_000_0349_01D8D336.BB863860
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCFcgw
ggQyMIIDGqADAgECAgEBMA0GCSqGSIb3DQEBBQUAMHsxCzAJBgNVBAYTAkdCMRswGQYDVQQIDBJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcMB1NhbGZvcmQxGjAYBgNVBAoMEUNvbW9kbyBDQSBM
aW1pdGVkMSEwHwYDVQQDDBhBQUEgQ2VydGlmaWNhdGUgU2VydmljZXMwHhcNMDQwMTAxMDAwMDAw
WhcNMjgxMjMxMjM1OTU5WjB7MQswCQYDVQQGEwJHQjEbMBkGA1UECAwSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHDAdTYWxmb3JkMRowGAYDVQQKDBFDb21vZG8gQ0EgTGltaXRlZDEhMB8GA1UE
AwwYQUFBIENlcnRpZmljYXRlIFNlcnZpY2VzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAvkCd9G7h6naHHE1FRI6+RsiDBp3BKv4YH47kAvrzq11QihYxC5oG0MVwIs1JLVRjzLZuaEYL
U+rLTCTAvHJO6vEVrvRUmhIKw3qyM2Di2olV8yJY897cz++DhqKMlE+faPKYkEaEJ8d2v+PMNSyL
XgdkZYLASLCokflhn3YgUKiRx2a163hiA1bwihoT6jGjHqCZ/Tj29icyWG8H9Wu4+xQrr7eqzNZj
X3OM2gWZqDioyxd4NlGs6Z70eDqNzw/ZQuKYDKsvnw4B3u+fmUnxLd+sdE0bmLVHxeUp0fmQGMdi
nL6DxyZ7Poolx8DdneY1aBAgnY/Y3tLDhJwNXugvyQIDAQABo4HAMIG9MB0GA1UdDgQWBBSgEQoj
PpbxB+zirynvgqV/0DCktDAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zB7BgNVHR8E
dDByMDigNqA0hjJodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9BQUFDZXJ0aWZpY2F0ZVNlcnZpY2Vz
LmNybDA2oDSgMoYwaHR0cDovL2NybC5jb21vZG8ubmV0L0FBQUNlcnRpZmljYXRlU2VydmljZXMu
Y3JsMA0GCSqGSIb3DQEBBQUAA4IBAQAIVvwC8Jvo/6T61nvGRIDOT8TF9gBYzKa2vBRJaAR26Obu
XewCD2DWjVAYTyZOAePmsKXuv7x0VEG//fwSuMdPWvSJYAV/YLcFSvP28cK/xLl0hrYtfWvM0vNG
3S/G4GrDwzQDLH2W3VrCDqcKmcEFi6sML/NcOs9sN1UJh95TQGxY7/y2q2VuBPYb3DzgWhXGntnx
WUgwIWUDbOzpIXPsmwOh4DetoBUYj/q6As6nLKkQEyzU5QgmqyKXYPiQXnTUoppTvfKpaOCibsLX
bLGjD56/62jnVvKu8uMrODoJgbVrhde+Le0/GreyY+L1YiyC1GoAQVDxOYOflek2lphuMIIFgTCC
BGmgAwIBAgIQOXJEOvkit1HX02wQ3TE1lTANBgkqhkiG9w0BAQwFADB7MQswCQYDVQQGEwJHQjEb
MBkGA1UECAwSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHDAdTYWxmb3JkMRowGAYDVQQKDBFD
b21vZG8gQ0EgTGltaXRlZDEhMB8GA1UEAwwYQUFBIENlcnRpZmljYXRlIFNlcnZpY2VzMB4XDTE5
MDMxMjAwMDAwMFoXDTI4MTIzMTIzNTk1OVowgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcg
SmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3
b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MIICIjAN
BgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAgBJlFzYOw9sIs9CsVw127c0n00ytUINh4qogTQkt
ZAnczomfzD2p7PbPwdzx07HWezcoEStH2jnGvDoZtF+mvX2do2NCtnbyqTsrkfjib9DsFiCQCT7i
6HTJGLSR1GJk23+jBvGIGGqQIjy8/hPwhxR79uQfjtTkUcYRZ0YIUcuGFFQ/vDP+fmyc/xadGL1R
jjWmp2bIcmfbIWax1Jt4A8BQOujM8Ny8nkz+rwWWNR9XWrf/zvk9tyy29lTdyOcSOk2uTIq3XJq0
tyA9yn8iNK5+O2hmAUTnAU5GU5szYPeUvlM3kHND8zLDU+/bqv50TmnHa4xgk97Exwzf4TKuzJM7
UXiVZ4vuPVb+DNBpDxsP8yUmazNt925H+nND5X4OpWaxKXwyhGNVicQNwZNUMBkTrNN9N6frXTps
NVzbQdcS2qlJC9/YgIoJk2KOtWbPJYjNhLixP6Q5D9kCnusSTJV882sFqV4Wg8y4Z+LoE53MW4LT
TLPtW//e5XOsIzstAL81VXQJSdhJWBp/kjbmUZIO8yZ9HE0XvMnsQybQv0FfQKlERPSZ51eHnlAf
V1SoPv10Yy+xUGUJ5lhCLkMaTLTwJUdZ+gQek9QmRkpQgbLevni3/GcV4clXhB4PY9bpYrrWX1Uu
6lzGKAgEJTm4Diup8kyXHAc/DVL17e8vgg8CAwEAAaOB8jCB7zAfBgNVHSMEGDAWgBSgEQojPpbx
B+zirynvgqV/0DCktDAdBgNVHQ4EFgQUU3m/WqorSs9UgOHYm8Cd8rIDZsswDgYDVR0PAQH/BAQD
AgGGMA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0gBAowCDAGBgRVHSAAMEMGA1UdHwQ8MDowOKA2oDSG
Mmh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0FBQUNlcnRpZmljYXRlU2VydmljZXMuY3JsMDQGCCsG
AQUFBwEBBCgwJjAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMA0GCSqGSIb3
DQEBDAUAA4IBAQAYh1HcdCE9nIrgJ7cz0C7M7PDmy14R3iJvm3WOnnL+5Nb+qh+cli3vA0p+rvSN
b3I8QzvAP+u431yqqcau8vzY7qN7Q/aGNnwU4M309z/+3ri0ivCRlv79Q2R+/czSAaF9ffgZGclC
KxO/WIu6pKJmBHaIkU4MiRTOok3JMrO66BQavHHxW/BBC5gACiIDEOUMsfnNkjcZ7Tvx5Dq2+UUT
JnWvu6rvP3t3O9LEApE9GQDTF1w52z97GA1FzZOFli9d31kWTz9RvdVFGD/tSo7oBmF0Ixa1DVBz
J0RHfxBdiSprhTEUxOipakyAvGp4z7h/jnZymQyd/teRCBaho1+VMIIF9TCCBN2gAwIBAgIRAJIF
dv7a2pEWVMfTkiUaPlcwDQYJKoZIhvcNAQELBQAwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGlt
aXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1
cmUgRW1haWwgQ0EwHhcNMjIwMzEwMDAwMDAwWhcNMjMwMzEwMjM1OTU5WjCB9jEaMBgGA1UEFBMR
KzEgKDcxOSkgODg0LTYzOTIxDjAMBgNVBBETBTkyMTMxMTIwMAYDVQQKDClLcmF0b3MgRGVmZW5z
ZSAmIFNlY3VyaXR5IFNvbHV0aW9ucywgSW5jLjESMBAGA1UECRMJU3VpdGUgNjAwMRMwEQYDVQQI
EwpDYWxpZm9ybmlhMRIwEAYDVQQHEwlTYW4gRGllZ28xCzAJBgNVBAYTAlVTMRgwFgYDVQQDEw9S
dXNzZWxsIEpvaG5zb24xMDAuBgkqhkiG9w0BCQEWIXJ1c3NlbGwuam9obnNvbkBrcmF0b3NkZWZl
bnNlLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALnh/To9+nijBjtTASsMRaO4
eMR3Oh755HRtJdmmnh8R22FPh0g7SqJ0LqsdxB+F2MZuiATU0yGTqCiipYr7rvJe84G+g7buxK89
qShsTVKg7ho0hYqf5st4OofS70TU6tDSok5DonFeoP13o8WSDj6VaTCgdN4R2EpylpCbkwA0Ztab
OVLXq2c3T/2lYz9E3FktVbyW/g98PMreSQw/YHHVJDHIjRVuHWPDXNxWgL8JhvmBgW/sM0+RbOEB
d8BbpUDKKENyfyh7pyWDuaGdwXgZewYN/rsed9sY3CQbjXdPlkNs2hRr3OBF2x7/r2dxC1WcjAqX
nFpkj5GgZAj9ylkCAwEAAaOCAdowggHWMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0A
MB0GA1UdDgQWBBQozNUBGAya4A+1PrjoDHHIppZKmDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/
BAIwADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1BgwrBgEEAbIx
AQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9DUFMwWgYDVR0fBFMwUTBP
oE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRp
b25hbmRTZWN1cmVFbWFpbENBLmNybDCBigYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRw
Oi8vY3J0LnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3Vy
ZUVtYWlsQ0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAsBgNVHREE
JTAjgSFydXNzZWxsLmpvaG5zb25Aa3JhdG9zZGVmZW5zZS5jb20wDQYJKoZIhvcNAQELBQADggEB
AFr/GaEORVDnaQlG1aZnzFZxeaplFNh2DXG9CRzdu3U6HWBvAYgQqwVxvRD8O8omtchUCTyApdif
jla9M2OlWeyyAqIvCLqgZu7R2YkDuKzrNkyug95yKSUuG6WnFyr62tmlm7/Z/BOwYKdDracwiiJf
1nhhK9tCUhSLEWmNBv6z6rYmszNdajEGuJ4Om2ul76u21GZzvV9xAeCZtzbpQiVK+ib5T8fe/USd
/GIJkUmeyLNip1x1UA6TWJQNM6Y6vBNj2juHeydhVYUwOwrNiBWfYvbzZgbcTkoPjC5zbNf1/ffM
j37+cmagv+vKIk2eZNfvxAw2iHBK/+oQe8fqbZ0wggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06
KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEU
MBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwG
A1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAw
MDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5j
aGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNV
BAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8
gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUfItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9N
xOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeWQcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6
kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YBrf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlV
x/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewDch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+Q
U5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0O
BBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYD
VR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRp
ZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUFBwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDov
L2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzAB
hhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXe
jpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1G
wmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Y
s7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJ
JIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz
9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG0
3i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8
q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQOZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15us
wgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qodx/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucX
qm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i5ZgtwCLXgAIe5W8mybM2JzGCBF0wggRZAgEB
MIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQH
EwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNB
IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OS
JRo+VzANBglghkgBZQMEAgEFAKCCAoEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMjIwOTI4MTgzNTAzWjAvBgkqhkiG9w0BCQQxIgQgxnWcE/Vjc+TnhsCV7zjtCwEG
BWvLKjp8Gud4ijfVSxwwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQA8
NHS8QIo9lKkAPrl2rPVpsBnMbXoxKqa1QeNS5A4pzUtFMFRCGgy+wSzBaBVRlM01tfzMUpj04MJp
T0umiZC9dT68NDSmF27F6c4u0PBr12GGPltv36RnIDyu15wOzx4FFiUK5Wdi715CauifX+3cvVl8
UAhGXpMyFK++sYSpJTw+spnEKLp1TMHQWElQyn+9IYQsunPh7XQAz4OYrMik3jORe3WwdUN/TUqm
nxA64lRpVIcWypD9XfyRa7RFqnVdfnM2IV/ezwTrAvDN+gRzC/K9+yAsf+79ddiyg6DS43Ax7Yqc
WoLEKQtZkXWM8p8ZxfLC4eKVAbFwGndBy4aFAAAAAAAA

------=_NextPart_000_0349_01D8D336.BB863860--
