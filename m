Received: from mx0a-001f5801.pphosted.com (mx0b-001f5801.pphosted.com [148.163.159.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ADC8498
	for <xenomai@lists.linux.dev>; Mon, 14 Nov 2022 23:33:10 +0000 (UTC)
Received: from pps.filterd (m0090335.ppops.net [127.0.0.1])
	by mx0b-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEN05Eq009786;
	Mon, 14 Nov 2022 15:33:09 -0800
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02lp0181.outbound.protection.office365.us [23.103.199.181])
	by mx0b-001f5801.pphosted.com (PPS) with ESMTPS id 3ktbhftk4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Nov 2022 15:33:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=OsFymFQPTKKHYpgWmFF6BXgRbiAXT8kBuKholhjwA3UhPzOtc5VpVXY4k6to4YkWyJsGcWJx+tJbK+I59brC5BhW5sWFpnngb9nCx8Mi3M9F0hCpwGuRc4uYuL2TEoPSIbdqB+PXLT1BmQFKBKlh5JxzhO55ZVO/nv03Vh3ZjUg3o37IlcM/TQix9c7Helg5VqAKcbAt7eSTsX8I4stCATHwYjy6XblDKKphTq/3tra2t/Veaf6G0owUT8+WlVXvWfnTu6ia2L2stoUqkOURV6hdHN2VoT6DiAb0aqztoQ4nCQkrkdhwG4PBmE+kCIpxTKxq+dFrBV0vheLatoHW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w32ffzcfINYbxeLbjHYoGLaWJx/EZRjGvFnQzat639A=;
 b=mrIM0DVm0EW8fUWM0owmjIptF9pwED0udZ8qtZRcPIC3UI8KKXiCTlWFKJUzY8di9PimsZhkT79xpCPH8ebGiHf1U/P4of+/b8LwJfrsNfN8hGJn2g4jcKqa2ZevB05wfJ8E1aX0B9ECxaziSO907d2hFXbxMbV0mu2p7TdcmWoIh9+PTyDmk350R9fghCixJNEYhX7/rsg4WNYdVCug/cjcf8Ylp9JcipMZzRw+phA64uYC2iHelOQl4fpdob9kQaykVB/EU9CQTZv3CmnIEHl3RgT7nOBDB0XGpH+NIOlJpVO9wnk0bsfpYMji0Zmo6GfEMvK7ha6eIb18hhXzQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w32ffzcfINYbxeLbjHYoGLaWJx/EZRjGvFnQzat639A=;
 b=PK8I1+IWaxD7muEw7o94+yU3lbeevk1NsOXE7XopWfeWUJLyApImxU5eTEjHE6VG9ETFLg4u8cq/RkemIALAd42TRtqO9vkqWG/r3bk1DVSfwDvT4jVGOLFUH3kxRAIoiwg6FVTU99JBe88enm5vNVq7wjJrFtW3vzHHNQPSy5V8ZxpRC8dXjlhx76Yaz5bUiM3zZJ9PHVo3xJ11+dyZNXo1t9m7AyBI3q08U8MJhCmASsr4fBxN+J/fttx3QDQyJH43lB6mTUM9kpT+R7kVCaZQjVdVmDcafWfZ4z43H8IE4LJPu6TLsSk6X9/ybFTY7EOOhJjs0XTNcJn6nYTmjw==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1116.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:174::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Mon, 14 Nov
 2022 23:33:08 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 23:33:08 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
        Bryan Butler
	<Bryan.Butler@kratosdefense.com>,
        Shawn McManus
	<shawn.mcmanus@kratosdefense.com>
Subject: RE: [External] - Re: EVL Memory
Thread-Topic: [External] - Re: EVL Memory
Thread-Index: 
 Adjz0yff24VAOdNORJO8c3TjB/9lSwAgymPQAAE3ZMAAARoBAABtP6rQAH6X0oAAHJg6kA==
Date: Mon, 14 Nov 2022 23:33:07 +0000
Message-ID: 
 <PH1P110MB105017ACDF56A1BBA36B9177E2059@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10508DD9688B7D0E82AB30CDE23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050307D7FC58A2B99A40094E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <877d04dm52.fsf@xenomai.org>
 <PH1P110MB1050221E0BC34BD641127901E2009@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87leodn9kv.fsf@xenomai.org>
In-Reply-To: <87leodn9kv.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB1116:EE_
x-ms-office365-filtering-correlation-id: 6647dc57-71e2-4548-3413-08dac69895fc
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2j86YBNMcFGkD6w5WUz4aCg2JDGdLk2/lPrMdGsCxB5JxHdb8cVmu7tisnLAwUpOVF4mQAHLQc+sv1h8rpgocxtpDxpZGZBL4HuQV1AIPpdY8H033/PoOLzeU/V5rcYezKkiRuutIY/GIt56dZCjKJpFHwSMcf8AKAkMJI3eJQNHyUJ428k6aX9vPI5dNXhsaO7BCnkOIfWZnBbYT0KmRcg7QmYE0OEw+xQYIVF7GYZDf50n95NuqMSKiyytfE1/HKn1FjxtMBZ/rTded8sNTuIBGKWmOJohdxKZLnPXc5KMAON3ll0/FQslgUNy9HoUzpJSMNeFzqaOztkuUtgq7yML65gwDJFsU5kHCDpzcPhKhO72bpCcMKwQOcAdieaVfmg1qtShN5vqChkvJ4RqVGXL1rrXcbRbjariN2m3rfgqctUGYTgjKYwSUotPkvyebilvCgcSvcNxbOZiL9TRNpIyn6qg8iVI+s28Wtwrpe5aWfqvezCEeWYOBb2Eq1FEgVjmnWZaiDdR9bcYL3nheFJtytSBdcG8X7vCjIupj+PvpWPX/zqRhhqlWIeLFP4z0/VvQlvW7IGSB+WHa/INfL1rgOCw2LsBw3sed4OFcNSAumhlqWL1HYRquUk3FfMVPe6iCPPXiVJ+/YdOineDbM7dCg2JB4qwrazltC5afHeJSLCsVyjof1hdMVzvPyiS
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(76116006)(64756008)(6506007)(107886003)(26005)(9686003)(7696005)(6916009)(54906003)(66946007)(66556008)(66476007)(66446008)(498600001)(71200400001)(52536014)(8676002)(44832011)(4326008)(186003)(2906002)(8936002)(38100700002)(38070700005)(99936003)(86362001)(5660300002)(55016003)(122000001)(558084003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 hq3roDX3iPKWNiWgvsBUXGN2T/F4GBTy6pN18/7A7JmRZ/g1XG4oUi8S/xRBKg7BSE2d6jb9PYAc4AE72IYR3868GEKbW7jrm+G06gS9gXz4z0n7TFjnw8z8sS8a9yLaScNq98CYAdWEZpkRox2cQEyltYsup65mviho/ymUwQOOp8+6uBwRjZdqlPz+Y+bAIDVlsO1qn6KkMkjYv9Uz3qp5xhH4kTh6wOSxTnqktnNqoCntAwScS+f7hHlEThWQZ76EmVNxCSSMcpSrdHp/xwFA3vMter6SJOXmlIp/Se8nH1ww7MtoNtzI/hAKjg8K/vlYLQa64BpRhFI50RXx1sP32Zlw2nIgPDrJU1xQS/D32cEcFquxUKdAsQ1E/FmcQAUGCt7Lb+C8MWugx6gs4OlqR/0wdREZXURXxf6D9NE=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_0115_01D8F846.C64FFE40"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rXDU6R5qxLIhMPrE9zvL+G6FSLaWnnSa8tyJDKwopSz7TV3n9H8m3nid8ONz1yq2mWVB5h7btjIfEVgqmpPV+ygBiWuNhBlc6LN9hewFz5KFNZdU0CYgWMrVzJ3yJiEu0TV59brdFSNnloUQJjJVJsTzTtrX9qDEJgmD0wx/geHwGeP53fz1OmJ5y5j49tnQKLDgOlAns5UgSyQ2CbO01EdSC+//PCaRHH9UTkS7ZEbHQi0xQi1geRxhuDzR+JVWEUZ/JHwFJqsysWSM+synuIVS/ZuLhYnxZ9UI6ikFwUToz11b8lii6XrGiSfmecXSXMwEzVOqH6TADIHrmGImDGaLhjj1x1++VXOCgkjCQOM6wo2JiDlldVxaDq4SNTZ+dYPw/pLnglZpMBnEq2aO1xaoBnBmkjMZp0wJL26Ot3kNqK3G6JWQafqT2K9rt0zRcrObworVnbR0lb9BTlGcTS4i7hFxX4Azru/PogQkLY4fErYM9n/BSteFQ7SBDox8Pbkma45hdzlt/G7BLvOSfbArBsUT6eeu5a/w+4K5Vlbbbvq8fV+zJz/qUnpTXQta9yC9dAkh7OHYqlN5Siad72EvB1CDu+414+KHZFdgHBw6jDjOnjEkuyIRvAE3W4YQNgXn2yEzvtBSKJbrTZTFD2wAi7JiWPLDwtiR2LlA/cFwlgkVZs21CPJugpY1kXdBUpbzo2Ft1jsJkOeGgfRiBTZtaU/E47HnzbY2Ek0OiFMUWh9qu66OJtVVTr9M18ddD/rX2//HVJ/esotrrBkkcyZqOWkXb0DQrRHFcLYmU3nqHo+/06HjbOtFVqldbU3L
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6647dc57-71e2-4548-3413-08dac69895fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 23:33:07.9696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1116
X-Proofpoint-ORIG-GUID: onBeoNTH5gSiOCDkQCFg825alLwQjyx4
X-Proofpoint-GUID: onBeoNTH5gSiOCDkQCFg825alLwQjyx4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_15,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140165

------=_NextPart_000_0115_01D8F846.C64FFE40
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_0116_01D8F846.C64FFE40"


------=_NextPart_001_0116_01D8F846.C64FFE40
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I have attached another stack trace from another un on a different system as
well.

Thanks,

Russell

------=_NextPart_001_0116_01D8F846.C64FFE40
Content-Type: text/plain;
	name="stack_trace_3.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="stack_trace_3.txt"

Nov 14 23:30:57 10.243.1.49 [ 2957.529589] watchdog: BUG: soft lockup - =
CPU#0 stuck for 26s! [Main:30755]
Nov 14 23:30:57 10.243.1.49 [ 2957.550451] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt iTCO_vendor_support gpio_ich =
x86_pkg_temp_thermal mxm_wmi intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich intel_cstate pcspkr =
intel_pch_thermal i2c_smbus input_leds sg joydev ftdi_sio mfd_core mei =
ioatdma acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c ast drm_vram_helper drm_kms_helper sr_mod sd_mod cdrom t10_pi =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper igb ttm
Nov 14 23:30:57 10.243.1.49  drm
Nov 14 23:30:57 10.243.1.49 [ 2957.550952]  ixgbe ahci libahci libata =
crc32c_intel mdio ptp pps_core i2c_algo_bit dca
Nov 14 23:30:57 10.243.1.49 [ 2957.839229] irq event stamp: 39024920
Nov 14 23:30:57 10.243.1.49 [ 2957.850329] hardirqs last  enabled at =
(39024919): [<ffffffffaf117f9e>] arch_pipeline_entry+0x5e/0x110
Nov 14 23:30:57 10.243.1.49 [ 2957.878257] hardirqs last disabled at =
(39024920): [<ffffffffae1c346b>] sync_current_irq_stage+0x4db/0x500
Nov 14 23:30:57 10.243.1.49 [ 2957.907229] softirqs last  enabled at =
(616958): [<ffffffffaf400403>] __do_softirq+0x403/0x57b
Nov 14 23:30:57 10.243.1.49 [ 2957.933046] softirqs last disabled at =
(616951): [<ffffffffae0d261d>] irq_exit_rcu+0x7d/0x150
Nov 14 23:30:57 10.243.1.49 [ 2957.958618] CPU: 0 PID: 30755 Comm: Main =
Not tainted 5.15.77evl-g6437d24c6dbc #1
Nov 14 23:30:57 10.243.1.49 [ 2957.981007] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 14 23:30:57 10.243.1.49 [ 2958.005248] IRQ stage: Linux
Nov 14 23:30:57 10.243.1.49 [ 2958.014002] RIP: =
0010:check_inband_stage+0x78/0xe0
Nov 14 23:30:58 10.243.1.49 [ 2958.028544] Code: 4c 8d ab d8 0d 00 00 be =
08 00 00 00 4c 89 ef e8 7e a2 30 00 4c 89 ef e8 26 97 30 00 48 8b 83 d8 =
0d 00 00 a8 02 75 10 41 54 9d <5b> 41 5c 41 5d 41 5e 5d c3 cc cc cc cc =
65 8b 05 64 56 e6 51 a9 00
Nov 14 23:30:58 10.243.1.49 [ 2958.085339] RSP: 0018:ffff8881683a7ad0 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000000
Nov 14 23:30:58 10.243.1.49 [ 2958.108259] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Nov 14 23:30:58 10.243.1.49 [ 2958.129875] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Nov 14 23:30:58 10.243.1.49 [ 2958.151483] RBP: ffff8881683a7af0 R08: =
0000000000000000 R09: 0000000000000000
Nov 14 23:30:58 10.243.1.49 [ 2958.173084] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Nov 14 23:30:58 10.243.1.49 [ 2958.194711] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Nov 14 23:30:58 10.243.1.49 [ 2958.216325] FS:  00007fc7d3fff700(0000) =
GS:ffff88841be00000(0000) knlGS:0000000000000000
Nov 14 23:30:58 10.243.1.49 [ 2958.240836] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 14 23:30:58 10.243.1.49 [ 2958.258250] CR2: 00005620615ca810 CR3: =
0000000145d6e003 CR4: 00000000003706f0
Nov 14 23:30:58 10.243.1.49 [ 2958.279868] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 14 23:30:58 10.243.1.49 [ 2958.301477] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 14 23:30:58 10.243.1.49 [ 2958.323084] Call Trace:
Nov 14 23:30:58 10.243.1.49 [ 2958.335942]  <TASK>
Nov 14 23:30:58 10.243.1.49 [ 2958.347883]  inband_irq_disable+0x13/0x40
Nov 14 23:30:58 10.243.1.49 [ 2958.365423]  _raw_spin_lock_irq+0x50/0x60
Nov 14 23:30:58 10.243.1.49 [ 2958.382965]  =
rwsem_down_write_slowpath+0x90c/0xb70
Nov 14 23:30:58 10.243.1.49 [ 2958.402827]  ? =
downgrade_write+0x280/0x280
Nov 14 23:30:58 10.243.1.49 [ 2958.420469]  ? unlock_stage+0x6d/0x80
Nov 14 23:30:58 10.243.1.49 [ 2958.436874]  ? lock_acquire+0x1a4/0x3f0
Nov 14 23:30:58 10.243.1.49 [ 2958.453877]  ? =
enable_oob_stage+0x51/0x110
Nov 14 23:30:58 10.243.1.49 [ 2958.471683]  ? =
__kasan_check_read+0x11/0x20
Nov 14 23:30:58 10.243.1.49 [ 2958.489815]  =
down_write_killable+0x11e/0x140
Nov 14 23:30:58 10.243.1.49 [ 2958.508220]  ? =
down_write_killable+0xa1/0x140
Nov 14 23:30:58 10.243.1.49 [ 2958.526959]  ? =
down_write_killable+0x11e/0x140
Nov 14 23:30:58 10.243.1.49 [ 2958.545995]  ? =
__down_killable+0x230/0x230
Nov 14 23:30:58 10.243.1.49 [ 2958.564032]  ? =
security_mmap_file+0xa7/0xd0
Nov 14 23:30:58 10.243.1.49 [ 2958.582308]  vm_mmap_pgoff+0x133/0x240
Nov 14 23:30:58 10.243.1.49 [ 2958.599193]  ? =
__audit_syscall_entry+0x1b5/0x200
Nov 14 23:30:58 10.243.1.49 [ 2958.618559]  ? randomize_page+0x60/0x60
Nov 14 23:30:58 10.243.1.49 [ 2958.635418]  ? =
ktime_get_coarse_real_ts64+0x109/0x120
Nov 14 23:30:58 10.243.1.49 [ 2958.655814]  ? =
__kasan_check_read+0x11/0x20
Nov 14 23:30:58 10.243.1.49 [ 2958.673450]  ? =
__kasan_check_read+0x11/0x20
Nov 14 23:30:58 10.243.1.49 [ 2958.690881]  ? =
__kasan_check_write+0x14/0x20
Nov 14 23:30:58 10.243.1.49 [ 2958.708376]  ksys_mmap_pgoff+0xa4/0x350
Nov 14 23:30:58 10.243.1.49 [ 2958.724412]  ? =
mlock_future_check+0x90/0x90
Nov 14 23:30:58 10.243.1.49 [ 2958.741338]  ? =
__audit_syscall_entry+0x1b5/0x200
Nov 14 23:30:58 10.243.1.49 [ 2958.759492]  __x64_sys_mmap+0x88/0xb0
Nov 14 23:30:58 10.243.1.49 [ 2958.774686]  do_syscall_64+0x44/0xb0
Nov 14 23:30:58 10.243.1.49 [ 2958.789502]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 14 23:30:58 10.243.1.49 [ 2958.808760] RIP: 0033:0x7fc7e42afd9a
Nov 14 23:30:58 10.243.1.49 [ 2958.823504] Code: cc 55 48 89 f5 53 48 89 =
fb 74 35 4d 63 f0 4c 63 fa 4d 89 e9 4d 89 f0 4d 63 d4 4c 89 fa 48 89 ee =
48 89 df b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 52 5b 5d 41 5c 41 =
5d 41 5e 41 5f c3 0f 1f 00
Nov 14 23:30:58 10.243.1.49 [ 2958.888422] RSP: 002b:00007fc7d3fef4d8 =
EFLAGS: 00000206 ORIG_RAX: 0000000000000009
Nov 14 23:30:58 10.243.1.49 [ 2958.915462] RAX: ffffffffffffffda RBX: =
00007fc7b8000000 RCX: 00007fc7e42afd9a
Nov 14 23:30:58 10.243.1.49 [ 2958.941169] RDX: 0000000000000000 RSI: =
0000000004000000 RDI: 00007fc7b8000000
Nov 14 23:30:58 10.243.1.49 [ 2958.966914] RBP: 0000000004000000 R08: =
ffffffffffffffff R09: 0000000000000000
Nov 14 23:30:58 10.243.1.49 [ 2958.992494] R10: 0000000000004022 R11: =
0000000000000206 R12: 0000000000004022
Nov 14 23:30:58 10.243.1.49 [ 2959.017924] R13: 0000000000000000 R14: =
ffffffffffffffff R15: 0000000000000000
Nov 14 23:30:58 10.243.1.49 [ 2959.043331]  </TASK>
Nov 14 23:31:25 10.243.1.49 [ 2985.529490] watchdog: BUG: soft lockup - =
CPU#0 stuck for 52s! [Main:30755]
Nov 14 23:31:25 10.243.1.49 [ 2985.554225] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt iTCO_vendor_support gpio_ich =
x86_pkg_temp_thermal mxm_wmi intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich intel_cstate pcspkr =
intel_pch_thermal i2c_smbus input_leds sg joydev ftdi_sio mfd_core mei =
ioatdma acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c ast drm_vram_helper drm_kms_helper sr_mod sd_mod cdrom t10_pi =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper igb ttm
Nov 14 23:31:25 10.243.1.49  drm
Nov 14 23:31:25 10.243.1.49 [ 2985.554777]  ixgbe ahci libahci libata =
crc32c_intel mdio ptp pps_core i2c_algo_bit dca
Nov 14 23:31:25 10.243.1.49 [ 2985.884044] irq event stamp: 76245688
Nov 14 23:31:25 10.243.1.49 [ 2985.900283] hardirqs last  enabled at =
(76245687): [<ffffffffaf133052>] _raw_spin_unlock_irq+0x22/0x40
Nov 14 23:31:25 10.243.1.49 [ 2985.933431] hardirqs last disabled at =
(76245688): [<ffffffffae1c346b>] sync_current_irq_stage+0x4db/0x500
Nov 14 23:31:25 10.243.1.49 [ 2985.967696] softirqs last  enabled at =
(616958): [<ffffffffaf400403>] __do_softirq+0x403/0x57b
Nov 14 23:31:25 10.243.1.49 [ 2985.998848] softirqs last disabled at =
(616951): [<ffffffffae0d261d>] irq_exit_rcu+0x7d/0x150
Nov 14 23:31:25 10.243.1.49 [ 2986.029763] CPU: 0 PID: 30755 Comm: Main =
Tainted: G             L    5.15.77evl-g6437d24c6dbc #1
Nov 14 23:31:26 10.243.1.49 [ 2986.061829] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 14 23:31:26 10.243.1.49 [ 2986.091634] IRQ stage: Linux
Nov 14 23:31:26 10.243.1.49 [ 2986.106121] RIP: =
0010:stage_disabled+0x9/0x50
Nov 14 23:31:26 10.243.1.49 [ 2986.124991] Code: d8 0d 00 00 48 89 e5 e8 =
15 91 0a ff 5d 0f b6 c0 c3 cc cc cc cc 66 90 66 2e 0f 1f 84 00 00 00 00 =
00 55 48 89 e5 e8 f7 8f 0a ff <ba> 01 00 00 00 f6 c4 02 74 10 65 8b 05 =
16 e8 f0 50 31 d2 a9 00 00
Nov 14 23:31:26 10.243.1.49 [ 2986.193530] RSP: 0018:ffff8881683a7ab8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000000
Nov 14 23:31:26 10.243.1.49 [ 2986.222546] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Nov 14 23:31:26 10.243.1.49 [ 2986.250251] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Nov 14 23:31:26 10.243.1.49 [ 2986.277945] RBP: ffff8881683a7ab8 R08: =
0000000000000000 R09: 0000000000000000
Nov 14 23:31:26 10.243.1.49 [ 2986.305661] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Nov 14 23:31:26 10.243.1.49 [ 2986.333311] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Nov 14 23:31:26 10.243.1.49 [ 2986.360912] FS:  00007fc7d3fff700(0000) =
GS:ffff88841be00000(0000) knlGS:0000000000000000
Nov 14 23:31:26 10.243.1.49 [ 2986.391456] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 14 23:31:26 10.243.1.49 [ 2986.414993] CR2: 00005620615ca810 CR3: =
0000000145d6e003 CR4: 00000000003706f0
Nov 14 23:31:26 10.243.1.49 [ 2986.442836] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 14 23:31:26 10.243.1.49 [ 2986.470728] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 14 23:31:26 10.243.1.49 [ 2986.498600] Call Trace:
Nov 14 23:31:26 10.243.1.49 [ 2986.512327]  <TASK>
Nov 14 23:31:26 10.243.1.49 [ 2986.524956]  ? =
__inband_irq_enable+0x6f/0x80
Nov 14 23:31:26 10.243.1.49 [ 2986.544164]  ? =
inband_irq_enable+0x1b/0x30
Nov 14 23:31:26 10.243.1.49 [ 2986.562850]  ? =
_raw_spin_unlock_irq+0x27/0x40
Nov 14 23:31:26 10.243.1.49 [ 2986.582295]  ? =
rwsem_down_write_slowpath+0x4df/0xb70
Nov 14 23:31:26 10.243.1.49 [ 2986.603606]  ? =
downgrade_write+0x280/0x280
Nov 14 23:31:26 10.243.1.49 [ 2986.622099]  ? unlock_stage+0x6d/0x80
Nov 14 23:31:26 10.243.1.49 [ 2986.639128]  ? lock_acquire+0x1a4/0x3f0
Nov 14 23:31:26 10.243.1.49 [ 2986.656627]  ? =
enable_oob_stage+0x51/0x110
Nov 14 23:31:26 10.243.1.49 [ 2986.674811]  ? =
__kasan_check_read+0x11/0x20
Nov 14 23:31:26 10.243.1.49 [ 2986.693230]  ? =
down_write_killable+0x11e/0x140
Nov 14 23:31:26 10.243.1.49 [ 2986.712419]  ? =
down_write_killable+0xa1/0x140
Nov 14 23:31:26 10.243.1.49 [ 2986.731314]  ? =
down_write_killable+0x11e/0x140
Nov 14 23:31:26 10.243.1.49 [ 2986.750393]  ? =
__down_killable+0x230/0x230
Nov 14 23:31:26 10.243.1.49 [ 2986.768375]  ? =
security_mmap_file+0xa7/0xd0
Nov 14 23:31:26 10.243.1.49 [ 2986.786583]  ? vm_mmap_pgoff+0x133/0x240
Nov 14 23:31:26 10.243.1.49 [ 2986.803839]  ? =
__audit_syscall_entry+0x1b5/0x200
Nov 14 23:31:26 10.243.1.49 [ 2986.823056]  ? randomize_page+0x60/0x60
Nov 14 23:31:26 10.243.1.49 [ 2986.839753]  ? =
ktime_get_coarse_real_ts64+0x109/0x120
Nov 14 23:31:26 10.243.1.49 [ 2986.859991]  ? =
__kasan_check_read+0x11/0x20
Nov 14 23:31:26 10.243.1.49 [ 2986.877444]  ? =
__kasan_check_read+0x11/0x20
Nov 14 23:31:26 10.243.1.49 [ 2986.894726]  ? =
__kasan_check_write+0x14/0x20
Nov 14 23:31:26 10.243.1.49 [ 2986.912072]  ? ksys_mmap_pgoff+0xa4/0x350
Nov 14 23:31:26 10.243.1.49 [ 2986.928512]  ? =
mlock_future_check+0x90/0x90
Nov 14 23:31:26 10.243.1.49 [ 2986.945320]  ? =
__audit_syscall_entry+0x1b5/0x200
Nov 14 23:31:26 10.243.1.49 [ 2986.963379]  ? __x64_sys_mmap+0x88/0xb0
Nov 14 23:31:26 10.243.1.49 [ 2986.979437]  ? do_syscall_64+0x44/0xb0
Nov 14 23:31:26 10.243.1.49 [ 2986.994732]  ? =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 14 23:31:26 10.243.1.49 [ 2987.014465]  </TASK>
Nov 14 23:31:34 10.243.1.49 [ 2994.750477] rcu: INFO: rcu_sched =
self-detected stall on CPU
Nov 14 23:31:34 10.243.1.49 [ 2994.771198] rcu: #0110-....: (61952 ticks =
this GP) idle=3D637/1/0x4000000000000000 softirq=3D479020/479020 =
fqs=3D15011
Nov 14 23:31:34 10.243.1.49 [ 2994.806625] #011(t=3D65000 jiffies =
g=3D779101 q=3D11085)
Nov 14 23:31:34 10.243.1.49 [ 2994.824337] NMI backtrace for cpu 0
Nov 14 23:31:34 10.243.1.49 [ 2994.838800] CPU: 0 PID: 30755 Comm: Main =
Tainted: G             L    5.15.77evl-g6437d24c6dbc #1
Nov 14 23:31:34 10.243.1.49 [ 2994.869184] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 14 23:31:34 10.243.1.49 [ 2994.897430] IRQ stage: Linux
Nov 14 23:31:34 10.243.1.49 [ 2994.909888] Call Trace:
Nov 14 23:31:34 10.243.1.49 [ 2994.920975]  <IRQ>
Nov 14 23:31:34 10.243.1.49 [ 2994.930771]  dump_stack_lvl+0x82/0xbc
Nov 14 23:31:34 10.243.1.49 [ 2994.945563]  dump_stack+0x10/0x16
Nov 14 23:31:34 10.243.1.49 [ 2994.959239]  =
nmi_cpu_backtrace.cold.10+0x68/0xa9
Nov 14 23:31:34 10.243.1.49 [ 2994.976927]  ? =
lapic_can_unplug_cpu+0xa0/0xa0
Nov 14 23:31:34 10.243.1.49 [ 2994.993781]  =
nmi_trigger_cpumask_backtrace+0x170/0x180
Nov 14 23:31:34 10.243.1.49 [ 2995.012954]  =
arch_trigger_cpumask_backtrace+0x14/0x20
Nov 14 23:31:34 10.243.1.49 [ 2995.031810]  =
rcu_dump_cpu_stacks+0x138/0x1c8
Nov 14 23:31:34 10.243.1.49 [ 2995.048328]  =
rcu_sched_clock_irq.cold.99+0x45/0x317
Nov 14 23:31:35 10.243.1.49 [ 2995.067017]  ? =
__kasan_check_write+0x14/0x20
Nov 14 23:31:35 10.243.1.49 [ 2995.083517]  ? =
tick_sched_do_timer+0x90/0x90
Nov 14 23:31:35 10.243.1.49 [ 2995.100006]  =
update_process_times+0xc2/0xf0
Nov 14 23:31:35 10.243.1.49 [ 2995.116252]  =
tick_sched_handle.isra.21+0x36/0x90
Nov 14 23:31:35 10.243.1.49 [ 2995.133802]  tick_sched_timer+0x7c/0xa0
Nov 14 23:31:35 10.243.1.49 [ 2995.148978]  =
__hrtimer_run_queues+0x38d/0x730
Nov 14 23:31:35 10.243.1.49 [ 2995.165758]  ? =
enqueue_hrtimer+0x180/0x180
Nov 14 23:31:35 10.243.1.49 [ 2995.181730]  ? =
inband_irq_restore+0xe/0x20
Nov 14 23:31:35 10.243.1.49 [ 2995.197681]  ? =
ktime_get_update_offsets_now+0xee/0x200
Nov 14 23:31:35 10.243.1.49 [ 2995.216815]  =
hrtimer_interrupt+0x1a5/0x350
Nov 14 23:31:35 10.243.1.49 [ 2995.232848]  proxy_irq_handler+0x32/0x40
Nov 14 23:31:35 10.243.1.49 [ 2995.248314]  =
handle_synthetic_irq+0xd2/0x300
Nov 14 23:31:35 10.243.1.49 [ 2995.264855]  do_irq_inband+0x2a/0x40
Nov 14 23:31:35 10.243.1.49 [ 2995.279359]  =
arch_do_IRQ_pipelined+0xb7/0x5a0
Nov 14 23:31:35 10.243.1.49 [ 2995.296235]  </IRQ>
Nov 14 23:31:35 10.243.1.49 [ 2995.306254]  <TASK>
Nov 14 23:31:35 10.243.1.49 [ 2995.316240]  =
sync_current_irq_stage+0x2de/0x500
Nov 14 23:31:35 10.243.1.49 [ 2995.333723]  =
__inband_irq_enable+0x6f/0x80
Nov 14 23:31:35 10.243.1.49 [ 2995.349775]  inband_irq_enable+0x1b/0x30
Nov 14 23:31:35 10.243.1.49 [ 2995.365263]  =
_raw_spin_unlock_irq+0x27/0x40
Nov 14 23:31:35 10.243.1.49 [ 2995.381554]  =
rwsem_down_write_slowpath+0x4df/0xb70
Nov 14 23:31:35 10.243.1.49 [ 2995.399696]  ? =
downgrade_write+0x280/0x280
Nov 14 23:31:35 10.243.1.49 [ 2995.415775]  ? unlock_stage+0x6d/0x80
Nov 14 23:31:35 10.243.1.49 [ 2995.430739]  ? lock_acquire+0x1a4/0x3f0
Nov 14 23:31:35 10.243.1.49 [ 2995.446074]  ? =
enable_oob_stage+0x51/0x110
Nov 14 23:31:35 10.243.1.49 [ 2995.462166]  ? =
__kasan_check_read+0x11/0x20
Nov 14 23:31:35 10.243.1.49 [ 2995.478523]  =
down_write_killable+0x11e/0x140
Nov 14 23:31:35 10.243.1.49 [ 2995.495116]  ? =
down_write_killable+0xa1/0x140
Nov 14 23:31:35 10.243.1.49 [ 2995.511987]  ? =
down_write_killable+0x11e/0x140
Nov 14 23:31:35 10.243.1.49 [ 2995.529078]  ? =
__down_killable+0x230/0x230
Nov 14 23:31:35 10.243.1.49 [ 2995.545097]  ? =
security_mmap_file+0xa7/0xd0
Nov 14 23:31:35 10.243.1.49 [ 2995.561348]  vm_mmap_pgoff+0x133/0x240
Nov 14 23:31:35 10.243.1.49 [ 2995.576380]  ? =
__audit_syscall_entry+0x1b5/0x200
Nov 14 23:31:35 10.243.1.49 [ 2995.593742]  ? randomize_page+0x60/0x60
Nov 14 23:31:35 10.243.1.49 [ 2995.608709]  ? =
ktime_get_coarse_real_ts64+0x109/0x120
Nov 14 23:31:35 10.243.1.49 [ 2995.627285]  ? =
__kasan_check_read+0x11/0x20
Nov 14 23:31:35 10.243.1.49 [ 2995.643179]  ? =
__kasan_check_read+0x11/0x20
Nov 14 23:31:35 10.243.1.49 [ 2995.658946]  ? =
__kasan_check_write+0x14/0x20
Nov 14 23:31:35 10.243.1.49 [ 2995.674966]  ksys_mmap_pgoff+0xa4/0x350
Nov 14 23:31:35 10.243.1.49 [ 2995.689710]  ? =
mlock_future_check+0x90/0x90
Nov 14 23:31:35 10.243.1.49 [ 2995.705527]  ? =
__audit_syscall_entry+0x1b5/0x200
Nov 14 23:31:35 10.243.1.49 [ 2995.722708]  __x64_sys_mmap+0x88/0xb0
Nov 14 23:31:35 10.243.1.49 [ 2995.736987]  do_syscall_64+0x44/0xb0
Nov 14 23:31:35 10.243.1.49 [ 2995.750955]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 14 23:31:35 10.243.1.49 [ 2995.769381] RIP: 0033:0x7fc7e42afd9a
Nov 14 23:31:35 10.243.1.49 [ 2995.783350] Code: cc 55 48 89 f5 53 48 89 =
fb 74 35 4d 63 f0 4c 63 fa 4d 89 e9 4d 89 f0 4d 63 d4 4c 89 fa 48 89 ee =
48 89 df b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 52 5b 5d 41 5c 41 =
5d 41 5e 41 5f c3 0f 1f 00
Nov 14 23:31:35 10.243.1.49 [ 2995.846809] RSP: 002b:00007fc7d3fef4d8 =
EFLAGS: 00000206 ORIG_RAX: 0000000000000009
Nov 14 23:31:35 10.243.1.49 [ 2995.873220] RAX: ffffffffffffffda RBX: =
00007fc7b8000000 RCX: 00007fc7e42afd9a
Nov 14 23:31:35 10.243.1.49 [ 2995.898402] RDX: 0000000000000000 RSI: =
0000000004000000 RDI: 00007fc7b8000000
Nov 14 23:31:35 10.243.1.49 [ 2995.923598] RBP: 0000000004000000 R08: =
ffffffffffffffff R09: 0000000000000000
Nov 14 23:31:35 10.243.1.49 [ 2995.948794] R10: 0000000000004022 R11: =
0000000000000206 R12: 0000000000004022
Nov 14 23:31:35 10.243.1.49 [ 2995.974025] R13: 0000000000000000 R14: =
ffffffffffffffff R15: 0000000000000000
Nov 14 23:31:35 10.243.1.49 [ 2995.999318]  </TASK>

------=_NextPart_001_0116_01D8F846.C64FFE40--

------=_NextPart_000_0115_01D8F846.C64FFE40
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
9w0BCQUxDxcNMjIxMTE0MjMzMzA2WjAvBgkqhkiG9w0BCQQxIgQgrIYzwDFkZ2VQPFXwFRK0tGV4
dTArNeGaruBZCs2A8h8wgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQAW
I9OqJLs32ChQ4dfQXEj1tqWcMVTZO0yzT2I6fZw63n9DuCGjfv7um1uAwJESp9OvPk73lmShc/8E
s/fqDh+KwGE2JzokkdqLr88e5uDyzXLG9toJm6WU6eylH3ByqlFnrpm/OAXUdq4LjTkWgLZNLoxd
PdSEw6NJT0bdCfx3UE74nyMIX8xenFzf9kMqGlKRrzOYJg908wlIXariP+03Q+eVp8dWu+Uc9kkh
0EAkcvY2Rw6nKLvI1y7aGYHwbk4GaS2N9ZXJdwOqcP9HuRKBmC78PTNtntTrLPlGUyCYk3ni6Agh
GXcxDlkzFQRHn5YNsZ+4cjZAKPDK7nisGV0QAAAAAAAA

------=_NextPart_000_0115_01D8F846.C64FFE40--
