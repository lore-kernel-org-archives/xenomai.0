Received: from mx0a-001f5801.pphosted.com (mx0a-001f5801.pphosted.com [148.163.157.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75247362
	for <xenomai@lists.linux.dev>; Tue, 27 Sep 2022 23:04:13 +0000 (UTC)
Received: from pps.filterd (m0090334.ppops.net [127.0.0.1])
	by mx0a-001f5801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RMwuR1007770;
	Tue, 27 Sep 2022 16:04:06 -0700
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02lp0152.outbound.protection.office365.us [23.103.199.152])
	by mx0a-001f5801.pphosted.com (PPS) with ESMTPS id 3jv34nhafw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Sep 2022 16:04:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=YmSRt3wUWlmZKI0LwZ+ZT1drbkYN7m2rSxFyJ5PPaXUyv3WaB0A+NUuG+ndGSFe5JnD/6GW3ALWJ0N73wHg2aRphueZfGjZ0RTCTGZg1EO14kEMqQLj0mBldg1av/Wyc30G8gWMEJNIKGjL0tTfQG/tWFXeiFIZwjoplZb9ZJPyiK3QJfQShhkesqNk164J1D/G0gTGQhimaI5HmkmXJLyTaFvez0DTeU3xn1+DmwLtzhmlKP2wMp+QceXYT+7Uf1AorIflX0Jrd1N+7L3QxefIUWWtnHxXzD0TBjHJpkp1x59uD38uAgfPk5NR8O3V5oN576NqzdxoYkKI9cwTfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfItfQn7nGkKo9g6wXmNa+x8Re7NdNGng/c0t8Uh+5M=;
 b=MVQb+pzeNThDZA3atRKAnRYwnGnvUSNJkFAxxTh3zeiTtFpU6zISlKn0khibzVu+bujGKWFBx3B8keYfgiCtNNuDNVAcu5w17geOi16PXEAX00if+Ihd0nc9lAGQ2zJyWvo5OY9lW/60BiLPKs90hJya83tHWI2K4nD3xg4d4Yr/0h3bGUTz8i7fxs6yst2Gmf32u+bqa4m9iRraFlWBTVuaxLakJ8aMEJ5jPmHW4rFDikWdkh+2VAvGSCfyhVAo1/KHrT9DILN/sCu87RfG+gvDiy2ied2WP2S0Du9RJqP4EnO+7gpnQTS/lbOumc2eA4p46w+cCsDtOz0gRgAeuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfItfQn7nGkKo9g6wXmNa+x8Re7NdNGng/c0t8Uh+5M=;
 b=rLCyH/LBo1eIfxjE1kvxWRiymkHkg32i4JwSsAFUmQ/W9wK3bwJRDBBOVJk6H2VAsnWeCB2hhAGughmq9FQGwPV9UzG0CigT/i8SKBVadO/jmysIujQo22H36OBjGdy693Y0nRaAZVg+DBVddY2c7ZRarjHGwCEuT/6u2RfFEs1DNJ29mKA1nqHHOa2ZVyCzF8eIXi6I8VgXp3SPBqkhH8NpA9duaW6a+X2ZWvukgMJXUv6eqKIg8SCY7/1g+sItBUzLP7Yl1aaKoVuYxLHE2YJ4Mq+QLrY9bmyhiD7oetmCVD8K2wApkfyit23hJ8hzGrCpB2oj33R70hHtv/SJ2w==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1379.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Tue, 27 Sep
 2022 23:04:04 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::dd17:900:976c:937c]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::dd17:900:976c:937c%5]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 23:04:04 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: Bryan Butler <Bryan.Butler@kratosdefense.com>,
        Philippe Gerum
	<rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: [External] - Re: System hanging when using condition variables
Thread-Topic: [External] - Re: System hanging when using condition variables
Thread-Index: 
 AdjMb2kqEi/6rzVHQeiyZvhBQUhKewCH+EqAAD3N5wAAGglKAABAL88AAANEjQAALawygABDfHNw
Date: Tue, 27 Sep 2022 23:04:04 +0000
Message-ID: 
 <PH1P110MB1050E6764B49A09B1699F3D1E2559@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87pmfncw9u.fsf@xenomai.org>
 <BN2P110MB128891FFD2A6A7F6AAF6C5EE8F519@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <87o7v59o02.fsf@xenomai.org> <87illb8pfs.fsf@xenomai.org>
 <87edvz8l5i.fsf@xenomai.org>
 <BN2P110MB1288812BD18DBAA0E2714B618F529@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
In-Reply-To: 
 <BN2P110MB1288812BD18DBAA0E2714B618F529@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB1379:EE_
x-ms-office365-filtering-correlation-id: a827cd47-5fc3-490a-795b-08daa0dc92f1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 s2HYISWyriUtrVlfAdxwrYKm0oVViZaew/DJla6FSTARidLAYSNwSZTSlUepIYJfDcH880HzXc9eCIxR3yhwHWdGh2EVX+r6CxbDIFNCI6HRoOU4b3cukCD6aGapH6hxqo1W0NYMdu3txJVLIHBvJNFTFKDXqiQBM/Tdg6mXMVc4We84meBOJ5m6DTpD4nwk6LQxm/xjMBzzsKph2XGVKuqZru/CkuM3vu4LHzK1Uk+6MUwJUVgjVWh/JgBRu+bS/ulNzeznFf9idES4PHMok5ELf8OizFQrFLGLBVmdQUMDHuwaeUml7Pz9lf3VnqclLUJjuFiY/u3y9PaiM4G2sGs6uLnmw4hbYCqSh/bJJy90DtN4KqIm+zFGJc3PA9dBiPbCE+xwKr6B7OtLwyq+hDmLuPHAecz4Sh5Vb9m5ZjFUGWwzWGkgpdi2nKC1rmgQ3fjZNfB0o0PX/y0rZ+177zficlpHsqvFfU57wJBiwIrXn4ICWwx+ON7yWV9f0llc6WI/DZJrw9QSCAiReg7jhI+X0c1QySOw6lSXFbi71c9yK7kXM5+Zn8LjhRlTrKb/Az8mQoY22b6w/thyGkqrQV/431sH+u/xY0xYKTU+WqonQ4MTBIDBa4IBZSlWXoecJ8WftJK3afOchxAGnuiDB2rQUV5lbrYlHQuDnV16wTgheU5DyJ+FC5fQsOyCsRmc
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(110136005)(38070700005)(8936002)(66556008)(86362001)(8676002)(4326008)(52536014)(66946007)(66446008)(64756008)(76116006)(66476007)(44832011)(33656002)(5660300002)(71200400001)(498600001)(122000001)(99936003)(38100700002)(558084003)(2906002)(7696005)(9686003)(6506007)(186003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 L6KildwhwydnNyT9QYAThNc0S3aALG35GxGElK81EmcHY9T9CQ1bI6SXSmx0smnsl1Pj0fquA4wrGF0EVolYAIUfPHnXAVrzlCG5xzq8e06sH0b2OenNYEQ4gfsOTJbrJMf9I8m+Xjk5UC5yjnyQEngtQ4LlxctXOkI5k3zuxK9fF0PR4QQENJXSWHH2XYKXCm1AEUtfoGsE4i74+KlEU1gGBVa8jQONEKb4q3c8nul8aObFnllU3SFnrYwA5tZBbPg1jBX1LcWHCscG0i4T7UXE8RQavxgTkcZ7huvJX9gBn/WEwTZ/ctYLm7gth/CLWfOWzRu+b569xYTjIJFtTwcGr7hFv1k3qJEoNNzwMqVrjIB7brWW+d9Hj8avR8HM4qIOQawPzFNp5fIdwFgjc/hRRlMvrBNk2Da70ATyaRHXkZYzEXydxsx/J58G+8dMEvlPql2dyYWXzBNwbbRDQP3C72ajChVIzxClL7Gnzlg=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_030C_01D8D293.24712550"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a827cd47-5fc3-490a-795b-08daa0dc92f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 23:04:04.4582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1379
X-Proofpoint-GUID: jXVjJteUnUXzBmBvNqwZdJzkDBIKp_oT
X-Proofpoint-ORIG-GUID: jXVjJteUnUXzBmBvNqwZdJzkDBIKp_oT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_11,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270141

------=_NextPart_000_030C_01D8D293.24712550
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_030D_01D8D293.24712550"


------=_NextPart_001_030D_01D8D293.24712550
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I am not sure if this is useful in the meantime but I have attached the
kernel stack traces that we see whenever a  CPU gets stuck.

Thanks,

Russell

------=_NextPart_001_030D_01D8D293.24712550
Content-Type: text/plain;
	name="stacktrace_1.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="stacktrace_1.txt"

[  +0.000198] EVL: Main[14098] could not receive HM event #2
[Sep27 22:09] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  +0.000034] rcu:      4-...0: (32 ticks this GP) =
idle=3D3c7/1/0x4000000000000002 softirq=3D1088249/1088252 fqs=3D14376
[  +0.000038]   (detected by 7, t=3D60002 jiffies, g=3D1104541, =
q=3D1155)
[  +0.000004] Sending NMI from CPU 7 to CPUs 4:
[  +0.000004] NMI backtrace for cpu 4
[  +0.000003] CPU: 4 PID: 14121 Comm: TxMain Not tainted =
5.15.64evl-g18085c66e3ca #8
[  +0.000003] Hardware name: Supermicro Super Server/X10SDV-6C+-TLN4F, =
BIOS 2.1 11/22/2019
[  +0.000001] IRQ stage: EVL
[  +0.000001] RIP: 0010:native_queued_spin_lock_slowpath+0x5d/0x1c0
[  +0.000006] Code: 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 =
30 e4 09 d0 a9 00 01 ff ff 75 4b 85 c0 74 0e 8b 07 84 c0 74 08 f3 90 8b =
07 <84> c0 75 f8 b8 01 00 00 00 5d 66 89 07 c3 cc cc cc cc 8b 37 b8 00
[  +0.000002] RSP: 0018:ffffb21bc164fd20 EFLAGS: 00000002
[  +0.000002] RAX: 0000000000000101 RBX: ffffa0215d624330 RCX: =
0000000000000000
[  +0.000002] RDX: 0000000000000000 RSI: 0000000000000000 RDI: =
ffffa0215d624358
[  +0.000001] RBP: ffffb21bc164fd20 R08: 0000000010000002 R09: =
ffffa02141380000
[  +0.000001] R10: 0000000000000000 R11: 0000000000000000 R12: =
00007fd1040013e0
[  +0.000001] R13: ffffa02140f40800 R14: 0000000000000000 R15: =
0000000000000000
[  +0.000002] FS:  00007fd111d2a700(0000) GS:ffffa024afa00000(0000) =
knlGS:0000000000000000
[  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000002] CR2: 0000000000000000 CR3: 000000011bcf4001 CR4: =
00000000003706e0
[  +0.000001] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[  +0.000001] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[  +0.000001] Call Trace:
[  +0.000002]  <TASK>
[  +0.000004] ------------[ cut here ]------------
[  +0.000000] WARNING: CPU: 4 PID: 14121 at kernel/rcu/tree.c:1129 =
rcu_is_watching+0x2b/0x50
[  +0.000008] Modules linked in: xt_CHECKSUM xt_MASQUERADE tun =
ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 =
xt_conntrack ebtable_nat ebtable_broute ip6table_nat ip6table_mangle =
ip6table_security ip6table_raw iptable_nat nf_nat iptable_mangle =
iptable_security iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
libcrc32c ip_set rfkill nfnetlink ebtable_filter ebtables =
ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod x86_pkg_temp_thermal intel_powerclamp =
coretemp kvm_intel iTCO_wdt gpio_ich iTCO_vendor_support mxm_wmi kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me intel_cstate pcspkr i2c_i801 lpc_ich mei =
sg intel_pch_thermal i2c_smbus mfd_core joydev input_leds ftdi_sio =
ioatdma wmi acpi_pad ip_tables ext4 mbcache jbd2 ast drm_vram_helper =
drm_kms_helper syscopyarea sr_mod sysfillrect sd_mod cdrom sysimgblt =
t10_pi fb_sys_fops drm_ttm_helper ttm ahci drm ixgbe libahci igb
[  +0.000051]  crc32c_intel libata mdio ptp i2c_algo_bit pps_core dca =
fuse
[  +0.000005] CPU: 4 PID: 14121 Comm: TxMain Not tainted =
5.15.64evl-g18085c66e3ca #8
[  +0.000002] Hardware name: Supermicro Super Server/X10SDV-6C+-TLN4F, =
BIOS 2.1 11/22/2019
[  +0.000001] IRQ stage: EVL
[  +0.000001] RIP: 0010:rcu_is_watching+0x2b/0x50
[  +0.000003] Code: b8 01 00 00 00 65 8b 15 73 38 f2 42 48 89 e5 f7 c2 =
00 00 00 01 75 15 0f b6 05 d2 e6 9f 01 84 c0 75 10 81 e2 00 00 00 02 74 =
08 <0f> 0b 5d c3 cc cc cc cc 48 c7 c0 60 4f 05 00 65 48 03 05 ee e0 f1
[  +0.000002] RSP: 0018:fffffe00000f9cd8 EFLAGS: 00010006
[  +0.000001] RAX: 0000000000000000 RBX: ffffb21bc164fd70 RCX: =
0000000000000027
[  +0.000002] RDX: 0000000002000000 RSI: ffffa024afa1b780 RDI: =
ffffb21bc164fd70
[  +0.000001] RBP: fffffe00000f9cd8 R08: ffffffffbe456300 R09: =
0000000000000000
[  +0.000001] R10: ffffffffbea7c621 R11: ffffffffbea7c5f1 R12: =
0000000000000000
[  +0.000001] R13: ffffa02141380000 R14: ffffffffbe0fb73d R15: =
ffffffffbe0b6d4f
[  +0.000001] FS:  00007fd111d2a700(0000) GS:ffffa024afa00000(0000) =
knlGS:0000000000000000
[  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000001] CR2: 0000000000000000 CR3: 000000011bcf4001 CR4: =
00000000003706e0
[  +0.000001] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[  +0.000001] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[  +0.000001] Call Trace:
[  +0.000001]  <NMI>
[  +0.000003]  kernel_text_address+0x2c/0x120
[  +0.000009]  __kernel_text_address+0xd/0x40
[  +0.000005]  show_trace_log_lvl+0x1d0/0x296
[  +0.000024]  ? __evl_unlock_mutex+0x20a/0x240
[  +0.000016]  show_regs.cold.19+0x1a/0x1f
[  +0.000005]  nmi_cpu_backtrace.cold.9+0x1b/0x8e
[  +0.000027]  nmi_cpu_backtrace_handler+0xc/0x20
[  +0.000007]  nmi_handle+0x4f/0xb0
[  +0.000010]  default_do_nmi+0x4e/0x120
[  +0.000008]  exc_nmi+0x105/0x130
[  +0.000008]  end_repeat_nmi+0x16/0x67
[  +0.000004] RIP: 0010:native_queued_spin_lock_slowpath+0x5d/0x1c0
[  +0.000002] Code: 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 =
30 e4 09 d0 a9 00 01 ff ff 75 4b 85 c0 74 0e 8b 07 84 c0 74 08 f3 90 8b =
07 <84> c0 75 f8 b8 01 00 00 00 5d 66 89 07 c3 cc cc cc cc 8b 37 b8 00
[  +0.000002] RSP: 0018:ffffb21bc164fd20 EFLAGS: 00000002
[  +0.000001] RAX: 0000000000000101 RBX: ffffa0215d624330 RCX: =
0000000000000000
[  +0.000001] RDX: 0000000000000000 RSI: 0000000000000000 RDI: =
ffffa0215d624358
[  +0.000001] RBP: ffffb21bc164fd20 R08: 0000000010000002 R09: =
ffffa02141380000
[  +0.000001] R10: 0000000000000000 R11: 0000000000000000 R12: =
00007fd1040013e0
[  +0.000000] R13: ffffa02140f40800 R14: 0000000000000000 R15: =
0000000000000000
[  +0.000025]  ? native_queued_spin_lock_slowpath+0x5d/0x1c0
[  +0.000009]  ? native_queued_spin_lock_slowpath+0x5d/0x1c0
[  +0.000006]  </NMI>
[  +0.000000]  <TASK>
[  +0.000002]  __evl_unlock_mutex+0x20a/0x240
[  +0.000013]  monitor_oob_ioctl+0x50f/0xd80
[  +0.000028]  EVL_ioctl+0x46/0xa0
[  +0.000008]  do_oob_syscall+0xb5/0x260
[  +0.000003]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  +0.000011]  handle_oob_syscall+0xa8/0x100
[  +0.000012]  pipeline_syscall+0x65/0x130
[  +0.000009]  syscall_enter_from_user_mode+0x39/0x100
[  +0.000007]  do_syscall_64+0x15/0xb0
[  +0.000004]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[  +0.000004] RIP: 0033:0x7fd123db5b4b
[  +0.000001] Code: Unable to access opcode bytes at RIP 0x7fd123db5b21.
[  +0.000001] RSP: 002b:00007fd111d1a3c0 EFLAGS: 00000246 ORIG_RAX: =
000000000000009d
[  +0.000002] RAX: ffffffffffffffda RBX: 00007fd1040013e0 RCX: =
00007fd123db5b4b
[  +0.000001] RDX: 0000000000006d02 RSI: 0000000000000009 RDI: =
0000000010000002
[  +0.000001] RBP: 0000000000006d02 R08: 0000000000000000 R09: =
00000000003ffecd
[  +0.000001] R10: 00007fd1040013e0 R11: 0000000000000246 R12: =
0000000000000009
[  +0.000000] R13: 00007fd12d2ade04 R14: 0000000000000400 R15: =
0000000084b906f0
[  +0.000026]  </TASK>
[  +0.000001] ---[ end trace f603dab9aa058209 ]---
[  +0.000001]  __evl_unlock_mutex+0x20a/0x240
[  +0.000013]  monitor_oob_ioctl+0x50f/0xd80
[  +0.000028]  EVL_ioctl+0x46/0xa0
[  +0.000007]  do_oob_syscall+0xb5/0x260
[  +0.000003]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  +0.000011]  handle_oob_syscall+0xa8/0x100
[  +0.000012]  pipeline_syscall+0x65/0x130
[  +0.000008]  syscall_enter_from_user_mode+0x39/0x100
[  +0.000008]  do_syscall_64+0x15/0xb0
[  +0.000004]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[  +0.000002] RIP: 0033:0x7fd123db5b4b
[  +0.000001] Code: Unable to access opcode bytes at RIP 0x7fd123db5b21.
[  +0.000001] RSP: 002b:00007fd111d1a3c0 EFLAGS: 00000246 ORIG_RAX: =
000000000000009d
[  +0.000001] RAX: ffffffffffffffda RBX: 00007fd1040013e0 RCX: =
00007fd123db5b4b
[  +0.000001] RDX: 0000000000006d02 RSI: 0000000000000009 RDI: =
0000000010000002
[  +0.000001] RBP: 0000000000006d02 R08: 0000000000000000 R09: =
00000000003ffecd
[  +0.000001] R10: 00007fd1040013e0 R11: 0000000000000246 R12: =
0000000000000009
[  +0.000001] R13: 00007fd12d2ade04 R14: 0000000000000400 R15: =
0000000084b906f0
[  +0.000025]  </TASK>
------=_NextPart_001_030D_01D8D293.24712550
Content-Type: text/plain;
	name="stacktrace_2.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="stacktrace_2.txt"

[  174.482855] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! =
[kworker/0:3:1348]
[Sep27 16:59] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! =
[kworker/0:3:1348]
[  +0.022178] Modules linked in: dma_buf_mgr(OE) rtlstddriver(OE) =
xt_CHECKSUM xt_MASQUERADE tun ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 =
ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ip6table_nat =
ip6table_mangle ip6table_security ip6table_raw iptable_nat nf_nat =
iptable_mangle iptable_security iptable_raw nf_conntrack nf_defrag_ipv6 =
nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables rfkill =
ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl i2c_i801 intel_cstate pcspkr intel_pch_thermal =
i2c_smbus sg lpc_ich mei_me mfd_core input_leds joydev mei ftdi_sio =
acpi_ipmi ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi acpi_pad =
ip_tables xfs libcrc32c ast drm_vram_helper drm_kms_helper sr_mod sd_mod =
cdrom syscopyarea t10_pi sysfillrect sysimgblt
[  +0.000089]  fb_sys_fops drm_ttm_helper ttm drm ixgbe igb ahci libahci =
libata crc32c_intel mdio ptp pps_core i2c_algo_bit dca
[  +0.000016] CPU: 0 PID: 1348 Comm: kworker/0:3 Tainted: G           OE =
    5.15.64evl-g18085c66e3ca #8
[  +0.000004] Hardware name: Supermicro Super Server/X10SDV-6C-TLN4F, =
BIOS 1.3 02/13/2018
[  +0.000001] IRQ stage: Linux
[  +0.000002] Workqueue: events netstamp_clear
[  +0.000008] RIP: 0010:io_serial_in+0x13/0x20
[  +0.000006] Code: e6 48 89 e5 48 63 f6 48 03 77 10 8b 06 5d c3 cc cc =
cc cc 0f 1f 40 00 0f b6 8f b9 00 00 00 8b 57 08 55 d3 e6 48 89 e5 01 f2 =
ec <0f> b6 c0 5d c3 cc cc cc cc 0f 1f 40 00 55 0f b6 8f b9 00 00 00 89
[  +0.000003] RSP: 0018:ffffbb0b00003c08 EFLAGS: 00000202 ORIG_RAX: =
0000000000000000
[  +0.000004] RAX: 0000000000000000 RBX: 0000000000000000 RCX: =
0000000000000000
[  +0.000001] RDX: 0000000000000000 RSI: 0000000000000000 RDI: =
0000000000000000
[  +0.000002] RBP: ffffbb0b00003c08 R08: 0000000000000000 R09: =
0000000000000000
[  +0.000001] R10: 0000000000000000 R11: 0000000000000000 R12: =
0000000000000000
[  +0.000002] R13: 0000000000000000 R14: 0000000000000000 R15: =
0000000000000000
[  +0.000001] FS:  0000000000000000(0000) GS:ffff9d34ed400000(0000) =
knlGS:0000000000000000
[  +0.000003] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000002] CR2: 0000000002a0fae0 CR3: 0000000105b58005 CR4: =
00000000003706f0
[  +0.000002] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[  +0.000001] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[  +0.000002] Call Trace:
[  +0.000002]  <IRQ>
[  +0.000002]  prb_read_valid+0x17/0x20
[  +0.000004]  console_unlock+0x2e0/0x420
[  +0.000008]  ? irq_work_queue+0x10/0x30
[  +0.000007]  ? __wake_up_klogd.part.39+0x34/0x50
[  +0.000004]  vprintk_emit+0xca/0x290
[  +0.000005]  vprintk_default+0x18/0x20
[  +0.000004]  vprintk+0x69/0xa0
[  +0.000004]  ? is_bpf_text_address+0x12/0x20
[  +0.000006]  ? kernel_text_address+0x108/0x120
[  +0.000004]  ? kernel_text_address+0x108/0x120
[  +0.000003]  ? __kernel_text_address+0xd/0x40
[  +0.000003]  ? show_trace_log_lvl+0x1d0/0x296
[  +0.000006]  ? show_trace_log_lvl+0x1d0/0x296
[  +0.000004]  ? show_regs.cold.19+0x1a/0x1f
[  +0.000004]  ? watchdog_timer_fn+0x1b3/0x210
[  +0.000004]  ? softlockup_fn+0x30/0x30
[  +0.000003]  ? __hrtimer_run_queues+0xfb/0x1b0
[  +0.000004]  ? hrtimer_interrupt+0xfc/0x230
[  +0.000004]  ? proxy_irq_handler+0x1e/0x30
[  +0.000003]  ? handle_synthetic_irq+0x53/0x70
[  +0.000004]  ? do_irq_inband+0x1a/0x20
[  +0.000005]  ? arch_do_IRQ_pipelined+0x92/0x570
[  +0.000003]  </IRQ>
[  +0.000001]  <TASK>
[  +0.000002]  ? sync_current_irq_stage+0x1f8/0x2d0
[  +0.000003]  ? sync_irq_stage+0x131/0x160
[  +0.000002]  ? synchronize_pipeline+0x56/0x80
[  +0.000003]  ? handle_irq_pipelined_finish+0x82/0x1c0
[  +0.000003]  ? arch_pipeline_entry+0xc4/0x110
[  +0.000005]  ? sysvec_apic_timer_interrupt+0xe/0x20
[  +0.000003]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  +0.000006]  ? smp_call_function_many_cond+0x126/0x290
[  +0.000004]  ? text_poke_bp_batch+0x290/0x290
[  +0.000005]  ? on_each_cpu_cond_mask+0x1d/0x30
[  +0.000003]  ? text_poke_bp_batch+0xac/0x290
[  +0.000004]  ? netif_receive_skb_list_internal+0x3d/0x2a0
[  +0.000004]  ? text_poke_finish+0x1a/0x30
[  +0.000003]  ? arch_jump_label_transform_apply+0x15/0x30
[  +0.000003]  ? __jump_label_update+0xdd/0x120
[  +0.000004]  ? jump_label_update+0xbb/0xe0
[  +0.000002]  ? static_key_enable_cpuslocked+0x5d/0x90
[  +0.000003]  ? static_key_enable+0x15/0x30
[  +0.000002]  ? netstamp_clear+0x28/0x40
[  +0.000003]  ? process_one_work+0x1e9/0x360
[  +0.000006]  ? worker_thread+0x2f/0x3f0
[  +0.000005]  ? process_one_work+0x360/0x360
[  +0.000004]  ? kthread+0x12a/0x150
[  +0.000004]  ? set_kthread_struct+0x40/0x40
[  +0.000004]  ? ret_from_fork+0x22/0x30
[  +0.000005]  </TASK>
[  202.482486] watchdog: BUG: soft lockup - CPU#0 stuck for 48s! =
[kworker/0:3:1348]
[Sep27 17:00] watchdog: BUG: soft lockup - CPU#0 stuck for 48s! =
[kworker/0:3:1348]
[  +0.022166] Modules linked in: dma_buf_mgr(OE) rtlstddriver(OE) =
xt_CHECKSUM xt_MASQUERADE tun ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 =
ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ip6table_nat =
ip6table_mangle ip6table_security ip6table_raw iptable_nat nf_nat =
iptable_mangle iptable_security iptable_raw nf_conntrack nf_defrag_ipv6 =
nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables rfkill =
ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl i2c_i801 intel_cstate pcspkr intel_pch_thermal =
i2c_smbus sg lpc_ich mei_me mfd_core input_leds joydev mei ftdi_sio =
acpi_ipmi ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi acpi_pad =
ip_tables xfs libcrc32c ast drm_vram_helper drm_kms_helper sr_mod sd_mod =
cdrom syscopyarea t10_pi sysfillrect sysimgblt
[  +0.000089]  fb_sys_fops drm_ttm_helper ttm drm ixgbe igb ahci libahci =
libata crc32c_intel mdio ptp pps_core i2c_algo_bit dca
[  +0.000016] CPU: 0 PID: 1348 Comm: kworker/0:3 Tainted: G           =
OEL    5.15.64evl-g18085c66e3ca #8
[  +0.000004] Hardware name: Supermicro Super Server/X10SDV-6C-TLN4F, =
BIOS 1.3 02/13/2018
[  +0.000001] IRQ stage: Linux
[  +0.000002] Workqueue: events netstamp_clear
[  +0.000008] RIP: 0010:delay_tsc+0x26/0x70
[  +0.000006] Code: cc cc 66 90 55 48 89 e5 65 44 8b 0d 3c fc ba 68 0f =
01 f9 66 90 48 c1 e2 20 48 09 c2 49 89 d0 eb 11 f3 90 65 8b 35 22 fc ba =
68 <41> 39 f1 75 20 41 89 f1 0f 01 f9 66 90 48 c1 e2 20 48 09 d0 48 89
[  +0.000003] RSP: 0018:ffffbb0b00003bf8 EFLAGS: 00000297 ORIG_RAX: =
0000000000000000
[  +0.000004] RAX: 0000000000000000 RBX: 0000000000000000 RCX: =
0000000000000000
[  +0.000001] RDX: 0000000000000000 RSI: 0000000000000000 RDI: =
0000000000000000
[  +0.000002] RBP: ffffbb0b00003bf8 R08: 0000000000000000 R09: =
0000000000000000
[  +0.000001] R10: 0000000000000000 R11: 0000000000000000 R12: =
0000000000000000
[  +0.000002] R13: 0000000000000000 R14: 0000000000000000 R15: =
0000000000000000
[  +0.000002] FS:  0000000000000000(0000) GS:ffff9d34ed400000(0000) =
knlGS:0000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000002] CR2: 0000000002a0fae0 CR3: 0000000105b58005 CR4: =
00000000003706f0
[  +0.000002] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[  +0.000001] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[  +0.000002] Call Trace:
[  +0.000002]  <IRQ>
[  +0.000002]  ? prb_read_valid+0x17/0x20
[  +0.000004]  ? console_unlock+0x2e0/0x420
[  +0.000007]  ? irq_work_queue+0x10/0x30
[  +0.000006]  ? __wake_up_klogd.part.39+0x34/0x50
[  +0.000005]  ? vprintk_emit+0xca/0x290

Message from syslogd@boromir at Sep 27 17:00:23 ...
 kernel:watchdog: BUG: soft lockup - CPU#0 stuck for 48s! =
[kworker/0:3:1348]
[  +0.000005]  ? vprintk_default+0x18/0x20
[  +0.000005]  ? vprintk+0x69/0xa0
[  +0.000004]  ? is_bpf_text_address+0x12/0x20
[  +0.000005]  ? kernel_text_address+0x108/0x120
[  +0.000004]  ? kernel_text_address+0x108/0x120
[  +0.000003]  ? __kernel_text_address+0xd/0x40
[  +0.000003]  ? show_trace_log_lvl+0x1d0/0x296
[  +0.000006]  ? show_trace_log_lvl+0x1d0/0x296
[  +0.000004]  ? show_regs.cold.19+0x1a/0x1f
[  +0.000004]  ? watchdog_timer_fn+0x1b3/0x210
[  +0.000004]  ? softlockup_fn+0x30/0x30
[  +0.000003]  ? __hrtimer_run_queues+0xfb/0x1b0
[  +0.000005]  ? hrtimer_interrupt+0xfc/0x230
[  +0.000004]  ? proxy_irq_handler+0x1e/0x30
[  +0.000003]  ? handle_synthetic_irq+0x53/0x70
[  +0.000004]  ? do_irq_inband+0x1a/0x20
[  +0.000005]  ? arch_do_IRQ_pipelined+0x92/0x570
[  +0.000003]  </IRQ>
[  +0.000001]  <TASK>
[  +0.000002]  ? sync_current_irq_stage+0x1f8/0x2d0
[  +0.000003]  ? sync_irq_stage+0x131/0x160
[  +0.000002]  ? synchronize_pipeline+0x56/0x80
[  +0.000003]  ? handle_irq_pipelined_finish+0x82/0x1c0
[  +0.000003]  ? arch_pipeline_entry+0xc4/0x110
[  +0.000004]  ? sysvec_apic_timer_interrupt+0xe/0x20
[  +0.000004]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  +0.000006]  ? smp_call_function_many_cond+0x126/0x290
[  +0.000004]  ? text_poke_bp_batch+0x290/0x290
[  +0.000005]  ? on_each_cpu_cond_mask+0x1d/0x30
[  +0.000003]  ? text_poke_bp_batch+0xac/0x290
[  +0.000003]  ? netif_receive_skb_list_internal+0x3d/0x2a0
[  +0.000004]  ? text_poke_finish+0x1a/0x30
[  +0.000003]  ? arch_jump_label_transform_apply+0x15/0x30
[  +0.000004]  ? __jump_label_update+0xdd/0x120
[  +0.000003]  ? jump_label_update+0xbb/0xe0
[  +0.000003]  ? static_key_enable_cpuslocked+0x5d/0x90
[  +0.000002]  ? static_key_enable+0x15/0x30
[  +0.000003]  ? netstamp_clear+0x28/0x40
[  +0.000003]  ? process_one_work+0x1e9/0x360
[  +0.000006]  ? worker_thread+0x2f/0x3f0
[  +0.000004]  ? process_one_work+0x360/0x360
[  +0.000004]  ? kthread+0x12a/0x150
[  +0.000004]  ? set_kthread_struct+0x40/0x40
[  +0.000004]  ? ret_from_fork+0x22/0x30
[  +0.000005]  </TASK>
[  212.746693] rcu: INFO: rcu_sched self-detected stall on CPU
[  212.763391] rcu:     0-....: (59955 ticks this GP) =
idle=3D951/1/0x4000000000000000 softirq=3D16155/16155 fqs=3D14988
[ +10.241696] rcu: INFO: rcu_sched self-detected stall on CPU
[  +0.016698] rcu:      0-....: (59955 ticks this GP) =
idle=3D951/1/0x4000000000000000 softirq=3D16155/16155 fqs=3D14988
[  +0.029441]   (t=3D60000 jiffies g=3D23317 q=3D10901)
[  +0.000004] NMI backtrace for cpu 0
[  +0.000002] CPU: 0 PID: 1348 Comm: kworker/0:3 Tainted: G           =
OEL    5.15.64evl-g18085c66e3ca #8
[  +0.000004] Hardware name: Supermicro Super Server/X10SDV-6C-TLN4F, =
BIOS 1.3 02/13/2018
[  +0.000001] IRQ stage: Linux
[  +0.000002] Workqueue: events netstamp_clear
[  +0.000008] Call Trace:
[  +0.000003]  <IRQ>
[  +0.000002]  dump_stack_lvl+0x73/0xa2
[  +0.000006]  dump_stack+0x10/0x16
[  +0.000002]  nmi_cpu_backtrace.cold.9+0x30/0x8e
[  +0.000004]  ? lapic_can_unplug_cpu+0xa0/0xa0
[  +0.000007]  nmi_trigger_cpumask_backtrace+0xee/0x100
[  +0.000005]  arch_trigger_cpumask_backtrace+0x14/0x20
[  +0.000005]  rcu_dump_cpu_stacks+0xcf/0x107
[  +0.000004]  rcu_sched_clock_irq.cold.102+0x157/0x458
[  +0.000004]  ? account_system_index_time+0x92/0xa0
[  +0.000006]  update_process_times+0x8e/0xd0
[  +0.000004]  tick_sched_handle.isra.23+0x20/0x60
[  +0.000006]  tick_sched_timer+0x6a/0x80
[  +0.000004]  ? tick_sched_do_timer+0x50/0x50
[  +0.000004]  __hrtimer_run_queues+0xfb/0x1b0
[  +0.000004]  hrtimer_interrupt+0xfc/0x230
[  +0.000003]  proxy_irq_handler+0x1e/0x30
[  +0.000003]  handle_synthetic_irq+0x53/0x70
[  +0.000004]  do_irq_inband+0x1a/0x20
[  +0.000005]  arch_do_IRQ_pipelined+0x92/0x570
[  +0.000003]  </IRQ>
[  +0.000001]  <TASK>
[  +0.000002]  sync_current_irq_stage+0x1f8/0x2d0
[  +0.000003]  sync_irq_stage+0x131/0x160
[  +0.000002]  synchronize_pipeline+0x56/0x80
[  +0.000003]  handle_irq_pipelined_finish+0x82/0x1c0
[  +0.000003]  arch_pipeline_entry+0xc4/0x110
[  +0.000005]  sysvec_apic_timer_interrupt+0xe/0x20
[  +0.000003]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  +0.000005] RIP: 0010:smp_call_function_many_cond+0x129/0x290
[  +0.000005] Code: 89 c7 e8 7a 15 33 00 3b 05 78 f5 62 01 73 97 48 63 =
d0 48 8b 0b 48 03 0c d5 80 48 18 98 8b 51 08 83 e2 01 74 0a f3 90 8b 51 =
08 <83> e2 01 75 f6 eb cb 49 c7 c7 c0 51 05 00 65 4c 03 3d c1 4b ef 68
[  +0.000003] RSP: 0018:ffffbb0b00b27cf0 EFLAGS: 00000202
[  +0.000003] RAX: 0000000000000004 RBX: ffff9d34ed4551c0 RCX: =
ffff9d34ed658920
[  +0.000002] RDX: 0000000000000011 RSI: 0000000000000000 RDI: =
ffff9d3180053928
[  +0.000002] RBP: ffffbb0b00b27d50 R08: 0000000000000000 R09: =
0000000000000000
[  +0.000002] R10: 0000000000000004 R11: 0000000000000000 R12: =
0000000000000000
[  +0.000001] R13: 0000000000000000 R14: 0000000000000001 R15: =
ffff9d34ed4551c0
[  +0.000003]  ? text_poke_bp_batch+0x290/0x290
[  +0.000005]  on_each_cpu_cond_mask+0x1d/0x30
[  +0.000003]  text_poke_bp_batch+0xac/0x290
[  +0.000003]  ? netif_receive_skb_list_internal+0x3d/0x2a0
[  +0.000004]  text_poke_finish+0x1a/0x30
[  +0.000004]  arch_jump_label_transform_apply+0x15/0x30
[  +0.000003]  __jump_label_update+0xdd/0x120
[  +0.000004]  jump_label_update+0xbb/0xe0
[  +0.000002]  static_key_enable_cpuslocked+0x5d/0x90
[  +0.000003]  static_key_enable+0x15/0x30
[  +0.000002]  netstamp_clear+0x28/0x40
[  +0.000004]  process_one_work+0x1e9/0x360
[  +0.000006]  worker_thread+0x2f/0x3f0
[  +0.000004]  ? process_one_work+0x360/0x360
[  +0.000005]  kthread+0x12a/0x150
[  +0.000004]  ? set_kthread_struct+0x40/0x40
[  +0.000004]  ret_from_fork+0x22/0x30
[  +0.000005]  </TASK>
------=_NextPart_001_030D_01D8D293.24712550--

------=_NextPart_000_030C_01D8D293.24712550
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
9w0BCQUxDxcNMjIwOTI3MjMwNDAyWjAvBgkqhkiG9w0BCQQxIgQgFYGXCESL0k+lNkuf57APEeMM
X9wb4sGfftPMFWMw2s0wgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQB2
nXebBYxC5V4Jw3DfIlv9pH+CHgejaHzrtaDIg7MguF9FIrotqJamgaCXsX501XP0MY+Rlj5CmG9a
q5PZ7bj/Gb2WHZdLcaaHRTuux86Encv1qhRoV/NYnTot7mJfjPp9rHEOp1emwNTb3ajxJQfNvewI
uAGr0zXZEog9xLicb6lVEiqnJWgVz70Qr+sBw3jWJrOdaT+x38kTrPoqfHPBWGqD8tJX0o7/mRos
VCX+kPju/BZGAPDXu9SG3OHrmyYxgEgT25HSDg8wPcoynGUBdbBkKnKTXUW9f+8JrxgFnENcSBus
6DFmhFfZTlNOdAMbLrGJE3KRtp/N3thq7vleAAAAAAAA

------=_NextPart_000_030C_01D8D293.24712550--
