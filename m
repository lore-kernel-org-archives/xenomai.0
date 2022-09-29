Received: from mx0a-001f5801.pphosted.com (mx0b-001f5801.pphosted.com [148.163.159.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6514429A1
	for <xenomai@lists.linux.dev>; Thu, 29 Sep 2022 18:32:43 +0000 (UTC)
Received: from pps.filterd (m0090335.ppops.net [127.0.0.1])
	by mx0b-001f5801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28THrCgS007117;
	Thu, 29 Sep 2022 11:32:36 -0700
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02lp0177.outbound.protection.office365.us [23.103.199.177])
	by mx0b-001f5801.pphosted.com (PPS) with ESMTPS id 3jt12b6dfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Sep 2022 11:32:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=LMulT+s0TP8OBltbnn+pqCJdW6OqNZbyCAZeZPk8qHCGtRDJZDqPmX+CjgAZzUb5ROWr2WJkaRaGQfew7eRW/u1wE+s0NTyaell9kbHpS5EYTthh60g5N9AAGb1AuVhd/M/CUuqGEOnd3GIL8YIwY5Cub8hOPyZDfzvveHpuGGpetAKOQPC9u8CyPe5JfM7tYzkR+e5MyQY0F5t//V9UtEv4HdMd34vfroE62q6NsFHrQDoMuGA8S1WbjFhz5uUW2GH5iXf/HkaTX7deVbD4+RNTyDCr7cYn1rA7AE8tOFLlFMf07xuqxTASOG0FukJ4zy1Zq+9V+vBRVgurauxQjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ww/qeXFzYy1kt6mE3AtS7CQh2WZoiCmSM299zdXkSVI=;
 b=li56VbLn+yVeEOzo7RtULkxlV1e4lygHdiqhKUS1es/OK1I2APGnkw2p3Yi88G8fm6svaEsFUh0tY8yIUujquL+xILwZhAqro4WZUTXGySKoQ1uVjkMR43OxUHJx+FN5ljp6Am6s8cb0SPaJXZSSUn79+sGEPIGU9hWbHft0ky2ET+NKJ00enhjrRTQVC1w8vW/eTbqF1+75Nn1jQqSrm1U61DkG1QJN+YQrj5frlNJ8YW5s0Mt792FBOwN1s5TeQq/10g0v2eevOGVp4R8Qy7OYY8Bx+24G0xuU91n4VnUzodrg8h8lKO8Dw152464t3QcLC0zoJctDit3C1PloVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ww/qeXFzYy1kt6mE3AtS7CQh2WZoiCmSM299zdXkSVI=;
 b=wPdr4xy5ZX8nk1JK0gRZ7XIA5m1ZkGYiuCGTl/5oEhPjDkkNB8Diz5+E1xcHXWikqXXvEVqb+Ck/iO4HGhRAb7sMddQrNSqcPUcMWU5uf6FvJJTaGgA+5Y14v0gnZ2H/yfk8xKokXyO2RySbcwuSWiM1C78GaZVjQpkcSjggupb0a0nQHQTJUlE5+hu8C8bYUliqO2tBn4foq3wcK6ZQS2MQMUGaafwGq5fpbq0IigPjqv/x1SnRKbvc1k+ZYe7/84hVBZh38boe2pTz67LmWIpYe9qrAyYtQxNLhFjOebNDl3g/0kFQXKlz39c8NACBgynn+rxzNLdWFZqcb4R9BA==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1743.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:177::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.14; Thu, 29 Sep
 2022 18:32:34 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::dd17:900:976c:937c]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::dd17:900:976c:937c%5]) with mapi id 15.20.5654.025; Thu, 29 Sep 2022
 18:32:34 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: Bryan Butler <Bryan.Butler@kratosdefense.com>,
        "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: [External] - Re: System hanging when using condition variables
Thread-Topic: [External] - Re: System hanging when using condition variables
Thread-Index: 
 AdjMb2kqEi/6rzVHQeiyZvhBQUhKewCH+EqAAD3N5wAAGglKAABAL88AAANEjQAALawygABDfHNwABf1R4AAEfuKoAAaNBUAABgCPVA=
Date: Thu, 29 Sep 2022 18:32:33 +0000
Message-ID: 
 <PH1P110MB1050D4CDF44BA86ECDD4550FE2579@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87pmfncw9u.fsf@xenomai.org>
 <BN2P110MB128891FFD2A6A7F6AAF6C5EE8F519@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <87o7v59o02.fsf@xenomai.org> <87illb8pfs.fsf@xenomai.org>
 <87edvz8l5i.fsf@xenomai.org>
 <BN2P110MB1288812BD18DBAA0E2714B618F529@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050E6764B49A09B1699F3D1E2559@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87h70r7r0m.fsf@xenomai.org>
 <PH1P110MB1050C74BE6BB64AD707616BAE2549@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87r0zu7j6i.fsf@xenomai.org>
In-Reply-To: <87r0zu7j6i.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB1743:EE_
x-ms-office365-filtering-correlation-id: 8aa6dc1c-c516-4463-e4ae-08daa248f9e2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5WoRA/kf7M25rcO1NJ70+jyULIOYaXvZRe1ybEd5GiAFiJsr5tm65CgtPRNz6wwYIBmjGA8i6hJMb4s2qzt1YkpeCz4Ui9EMlskqJm4KoHxCbaygy11Z6eFDnsbSxJcZgWUUl9baFmrXRselH+QYCNjaxPdUFCQBzec/pqw80UN3WDGskG0Q9W+0HbDEIowvYfXVHc4pDXHZpgwE5pvYyYO7W+sQ/Qd6Yh2UY9r8s/oM9JFHl5yznsI/J+FxtRNq2JYE2zXjDFWQmmCa/j2BZJNM2BBig6395roATZDVfKkYR0k/8jAOtpXGvIfTTZlniuhSI8y8OHTniqtOSVWADhGy9nxue64DUSAV60VYN0IkXUxXZ/SHcqgCSDIJscNX134GJK2gXI5Rjt5wxsxob+ctTgpL/9FbsH7W9nPtGrAwvivFVeOQcojsZpUYdUOKRbPwR+EnN4l1POxiIqzJ93pKdei3AS18uqnnukVP7fVaEzEW910kVqExkyGCEi2Hy+0dFdEGRivZHSaDL+uK6SLhVocqztX8itID7svK3N4NMAJXt2tpVPn0Tq7J67Hu/NvqHAOvkV4l/VmB2+7yu/hk8mFvTyGTYEa8MwqG6LlycbrWFfn89czGWC0ieuqjgkJv1wyG8e56V2BGWgduHU81Ys1n1clSUM2hM4cZiFYI2c9rojRq14IJBnqpm4jT
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(44832011)(4326008)(38070700005)(9686003)(8676002)(5660300002)(6506007)(7696005)(558084003)(38100700002)(122000001)(99936003)(33656002)(86362001)(55016003)(83380400001)(186003)(54906003)(71200400001)(6916009)(52536014)(66476007)(64756008)(8936002)(76116006)(66446008)(2906002)(498600001)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 TlSmKf5C9MTdIjXZLfLhfVNhBG12dniaZHZ8XzoG6ee1UrxSuqJA2rmhiQj8WeCPSwZxX146Eyf9k+HIusRkj5QTVm0uBuc85IwBYlNPGfITbIgBABdSpzFROOPHu7uUq4B+l9ehKyudIBOjDCJn35y9K1uBldYvSvwAGbBvjm/pnnPSQZIk2ldGn+I0TN3aPs/Va4K15cff/9vCEWuITDaFZBlcDmfVdLF2ZwojWxw4hNpY+wxqu5Y2nx5G9Ven80PLjdZWNPV/tsF7CiDidP0fJSjb4R3V3Anjd9aXuDM8Xtxid/ml07HkhGtPxHhNhanixV4ObvM5UKVFZKi5DKj11d6dmTnCi1JjpMmU4tQadSlKAWSDTQJBZtwEyiuhzwih9+p2hIE3day7h4+6AN9SCTM+H9OVfzDbrooSYInVelygjpocScF7ETB1XSu5ULJLO3kOHk5C76AAcUiiVOMuxviK494jVEi8knGzpSE=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_0364_01D8D3FF.8BB0A340"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa6dc1c-c516-4463-e4ae-08daa248f9e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 18:32:33.9619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1743
X-Proofpoint-ORIG-GUID: pFsOZkHHN-DjGQ8GYwCEv2yKACv-neum
X-Proofpoint-GUID: pFsOZkHHN-DjGQ8GYwCEv2yKACv-neum
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_10,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209290116

------=_NextPart_000_0364_01D8D3FF.8BB0A340
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_0365_01D8D3FF.8BB0A340"


------=_NextPart_001_0365_01D8D3FF.8BB0A340
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

>Thanks. These reports show that an assertion spuriously trips 
>in the lock validator due to a missing fix up in the Dovetail support 
>for that code. Please apply [1].

I applied those patches and now I have the following output from the kernel.

Thanks,

Russell

------=_NextPart_001_0365_01D8D3FF.8BB0A340
Content-Type: text/plain;
	name="stacktrace_4.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="stacktrace_4.txt"

[Sep29 12:29] ------------[ cut here ]------------
[  +0.000003] WARNING: CPU: 0 PID: 0 at kernel/rcu/tree.c:1129 =
rcu_is_watching+0x2b/0x60
[  +0.000011] Modules linked in: dma_buf_mgr(OE) rtlstddriver(OE) =
xt_CHECKSUM xt_MASQUERADE tun ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 =
ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ip6table_nat =
ip6table_mangle ip6table_security ip6table_raw iptable_nat nf_nat =
iptable_mangle iptable_security iptable_raw nf_conntrack nf_defrag_ipv6 =
nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables rfkill =
ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod x86_pkg_temp_thermal intel_powerclamp =
coretemp kvm_intel gpio_ich iTCO_wdt iTCO_vendor_support mxm_wmi kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl intel_cstate pcspkr i2c_i801 intel_pch_thermal =
i2c_smbus mei_me sg lpc_ich mfd_core joydev input_leds mei ftdi_sio =
ioatdma acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler wmi acpi_pad =
ip_tables xfs libcrc32c sr_mod sd_mod cdrom t10_pi ast drm_vram_helper =
drm_kms_helper syscopyarea sysfillrect sysimgblt
[  +0.000051]  fb_sys_fops drm_ttm_helper ttm drm ixgbe igb ahci libahci =
libata crc32c_intel mdio ptp i2c_algo_bit pps_core dca
[  +0.000010] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           OE     =
5.15.64evl-g4a69fe361195 #8
[  +0.000003] Hardware name: Supermicro Super Server/X10SDV-6C-TLN4F, =
BIOS 1.3 02/13/2018
[  +0.000001] IRQ stage: EVL
[  +0.000001] RIP: 0010:rcu_is_watching+0x2b/0x60
[  +0.000005] Code: b8 01 00 00 00 65 8b 15 33 94 ee 51 48 89 e5 f7 c2 =
00 00 00 01 75 15 0f b6 05 72 ae 76 02 84 c0 75 10 81 e2 00 00 00 02 74 =
08 <0f> 0b 5d c3 cc cc cc cc 65 ff 05 06 94 ee 51 48 c7 c0 48 f0 05 00
[  +0.000003] RSP: 0018:ffffffffaf603940 EFLAGS: 00010006
[  +0.000002] RAX: 0000000000000000 RBX: ffffffffafb1bbc9 RCX: =
ffffffffaf603998
[  +0.000002] RDX: 0000000002000000 RSI: ffffffffaf603e01 RDI: =
ffffffffafb1bbc9
[  +0.000001] RBP: ffffffffaf603940 R08: ffffffffaf603f48 R09: =
ffffffffaf61c818
[  +0.000001] R10: ffffffffaf603ad0 R11: ffffffffaf61c840 R12: =
ffffffffaf603a40
[  +0.000002] R13: 0000000000000000 R14: ffffffffaf61ba00 R15: =
ffffffffaffc2180
[  +0.000001] FS:  0000000000000000(0000) GS:ffff9e2b6d400000(0000) =
knlGS:0000000000000000
[  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000001] CR2: 00007f8e413d5070 CR3: 0000000148b34005 CR4: =
00000000003706f0
[  +0.000002] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[  +0.000001] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[  +0.000002] Call Trace:
[  +0.000000]  <TASK>

[  +0.000006] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[  +0.000001] WARNING: suspicious RCU usage
[  +0.000000] 5.15.64evl-g4a69fe361195 #8 Tainted: G           OE
[  +0.000002] -----------------------------
[  +0.000000] include/linux/rcupdate.h:689 rcu_read_lock() used =
illegally while idle!
[  +0.000002]
other info that might help us debug this:

[  +0.000001]
rcu_scheduler_active =3D 2, debug_locks =3D 1
[  +0.000003] RCU used illegally from extended quiescent state!
[  +0.000000] 2 locks held by swapper/0/0:
[  +0.000002]  #0: ffff9e2b6d458730 =
(__RAWLOCK(&thread->lock)){....}-{2:2}, at: __evl_schedule+0x99/0x9f0
[  +0.000009]  #1: ffff9e2b6d4586b8 (__RAWLOCK(&rq->lock)){....}-{2:2}, =
at: __evl_schedule+0x99/0x9f0
[  +0.000006]
stack backtrace:
[  +0.000001] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           OE     =
5.15.64evl-g4a69fe361195 #8
[  +0.000002] Hardware name: Supermicro Super Server/X10SDV-6C-TLN4F, =
BIOS 1.3 02/13/2018
[  +0.000001] IRQ stage: EVL
[  +0.000001] Call Trace:
[  +0.000000]  <TASK>

[  +0.000007] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[  +0.000000] WARNING: suspicious RCU usage
[  +0.000001] 5.15.64evl-g4a69fe361195 #8 Tainted: G           OE
[  +0.000001] -----------------------------
[  +0.000000] include/linux/rcupdate.h:717 rcu_read_unlock() used =
illegally while idle!
[  +0.000001]
other info that might help us debug this:

[  +0.000001]
rcu_scheduler_active =3D 2, debug_locks =3D 1
[  +0.000003] RCU used illegally from extended quiescent state!
[  +0.000000] 2 locks held by swapper/0/0:
[  +0.000001]  #0: ffff9e2b6d458730 (__RA[ 1357.745304] EVL: Main[4625] =
could not receive HM event #2
WLOCK(&thread->l[ 1359.106986]
[ 1359.106989] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 1359.106990] WARNING: possible recursive locking detected
ock)){....}-{2:2[ 1359.106991] 5.15.64evl-g4a69fe361195 #8 Tainted: G    =
    W  OE
}, at: __evl_sch[ 1359.106993] =
--------------------------------------------
edule+0x99/0x9f0[ 1359.106993] IRQ_0xe4f_1_0/4641 is trying to acquire =
lock:

[  +0[ 1359.106995] ffff9e2843d6a018 =
(__RAWLOCK(&thread->lock)){-.-.}-{2:2}, at: =
evl_lock_mutex_timeout+0x299/0xe40
.000006]  1359.107007]
[ 1359.107007] but task is already holding lock:
[ 1359.107007] ffff9e28412f0018 (__RAWLOCK(&thread->lock)){-.-.}-{2:2}, =
at: evl_lock_mutex_timeout+0x1b5/0xe40
3m #1: f[ 1359.107013]
[ 1359.107013] other info that might help us debug this:
[ 1359.107014]  Possible unsafe locking scenario:
[ 1359.107014]
fff9e2b6d4586b8 [ 1359.107015]        CPU0
[ 1359.107015]        ----
[ 1359.107016]   lock(__RAWLOCK(&thread->lock));
[ 1359.107017]   lock(__RAWLOCK(&thread->lock));
[ 1359.107018]
[ 1359.107018]  *** DEADLOCK ***
[ 1359.107018]
[ 1359.107019]  May be due to missing lock nesting notation
[ 1359.107019]
(__RAWLOCK(&rq->[ 1359.107019] 2 locks held by IRQ_0xe4f_1_0/4641:
[ 1359.107021]  #0: ffff9e28454ba9d8 (&mon->mutex){....}-{0:0}, at: =
evl_lock_mutex_timeout+0x1b5/0xe40
lock)){....}-{2:[ 1359.107027]  #1: ffff9e28412f0018 =
(__RAWLOCK(&thread->lock)){-.-.}-{2:2}, at: =
evl_lock_mutex_timeout+0x1b5/0xe40
2}, at: __evl_sc[ 1359.107032]
[ 1359.107032] stack backtrace:
[ 1359.107033] CPU: 10 PID: 4641 Comm: IRQ_0xe4f_1_0 Tainted: G        W =
 OE     5.15.64evl-g4a69fe361195 #8
hedule+0x99/0x9f[ 1359.107037] Hardware name: Supermicro Super =
Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
0
[  +[ 1359.107038] IRQ stage: EVL
[ 1359.107039] Call Trace:
0.000005]  1359.107040]  <TASK>
[ 1359.107054]  dump_stack_lvl+0x82/0xbc
[ 1359.107110]  dump_stack+0x10/0x16
[ 1359.107125]  __lock_acquire.cold.80+0xc3/0x2ab
[ 1359.107317]  lock_acquire+0xb3/0x2a0
[ 1359.107335]  ? evl_lock_mutex_timeout+0x299/0xe40
[ 1359.107541]  evl_lock_mutex_timeout+0x2c1/0xe40
1m
stack backtr[ 1359.107545]  ? evl_lock_mutex_timeout+0x299/0xe40
ace:
[[ 1359.107779]  enter_monitor+0x88/0xc0
  +0.000001]  1359.107820]  monitor_oob_ioctl+0x30c/0xf60
[ 1359.107836]  ? find_held_lock+0x35/0xb0
mCPU 1359.107878]  ? evl_get_file+0x6d/0xd0
m: 0 PID: 0 Comm[ 1359.107920]  ? lock_release+0x13e/0x270
: swapper/0 Tain[ 1359.108100]  EVL_ioctl+0x46/0xa0
ted: G          [ 1359.108152]  do_oob_syscall+0x3bb/0x3d0
 OE     5.15.64e[ 1359.108167]  ? handle_oob_irq+0xa2/0x190
vl-g4a69fe361195[ 1359.108257]  handle_oob_syscall+0xa8/0x100
 #8
[ [ 1359.108360]  pipeline_syscall+0x65/0x130
 +0.000001] [ 1359.108414]  syscall_enter_from_user_mode+0x47/0x110
Hardware na[ 1359.108469]  do_syscall_64+0x15/0xb0
me: Supe[ 1359.108497]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
rmicro Super Ser[ 1359.108501] RIP: 0033:0x7f8e411d2a6b
ver/X10SDV-6C-TL[ 1359.108511] Code: Unable to access opcode bytes at =
RIP 0x7f8e411d2a41.
N4F, BIOS 1.3 02[ 1359.108512] RSP: 002b:00007f8e2f439320 EFLAGS: =
00000246 ORIG_RAX: 000000000000009d
/13/2018
 1359.108515] RAX: ffffffffffffffda RBX: 00007f8e2f4393b0 RCX: =
00007f8e411d2a6b
32m[  +0.000001][ 1359.108516] RDX: 0000000040106d00 RSI: =
000000000000000d RDI: 0000000010000002
 IRQ st[ 1359.108518] RBP: 0000000040106d00 R08: 0000000000000000 R09: =
00007f8e39eae680
age: EVL[ 1359.108519] R10: 00007f8e2f4393b0 R11: 0000000000000246 R12: =
000000000000000d

[  +0[ 1359.108520] R13: 00007f8e2f4395b0 R14: 00007f8e39eb3968 R15: =
00007f8e2f439578
.000001]  1359.108790]  </TASK>
mCall Trace:
[  +0.000000]  <TASK>

[  +0.000013] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[  +0.000000] WARNING: suspicious RCU usage
[  +0.000000] 5.15.64evl-g4a69fe361195 #8 Tainted: G           OE
[  +0.000001] -----------------------------
[  +0.000001] include/linux/rcupdate.h:689 rcu_read_lock() used =
illegally while idle!
[  +0.000001]
other info that might help us debug this:

[  +0.000000]
rcu_scheduler_active =3D 2, debug_locks =3D 1
[  +0.000003] RCU used illegally from extended quiescent state!
[  +0.000000] 2 locks held by swapper/0/0:
[  +0.000001]  #0: ffff9e2b6d458730 =
(__RAWLOCK(&thread->lock)){....}-{2:2}, at: __evl_schedule+0x99/0x9f0
[  +0.000006]  #1: ffff9e2b6d4586b8 (__RAWLOCK(&rq->lock)){....}-{2:2}, =
at: __evl_schedule+0x99/0x9f0
[  +0.000005]
stack backtrace:
[  +0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           OE     =
5.15.64evl-g4a69fe361195 #8
[  +0.000002] Hardware name: Supermicro Super Server/X10SDV-6C-TLN4F, =
BIOS 1.3 02/13/2018
[  +0.000001] IRQ stage: EVL
[  +0.000000] Call Trace:
[  +0.000001]  <TASK>

[  +0.000013] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[  +0.000001] WARNING: suspicious RCU usage
[  +0.000000] 5.15.64evl-g4a69fe361195 #8 Tainted: G           OE
[  +0.000001] -----------------------------
[  +0.000000] include/linux/rcupdate.h:717 rcu_read_unlock() used =
illegally while idle!
[  +0.000001]
other info that might help us debug this:

[  +0.000001]
rcu_scheduler_active =3D 2, debug_locks =3D 1
[  +0.000002] RCU used illegally from extended quiescent state!
[  +0.000001] 2 locks held by swapper/0/0:
[  +0.000000]  #0: ffff9e2b6d458730 =
(__RAWLOCK(&thread->lock)){....}-{2:2}, at: __evl_schedule+0x99/0x9f0
[  +0.000006]  #1: ffff9e2b6d4586b8 (__RAWLOCK(&rq->lock)){....}-{2:2}, =
at: __evl_schedule+0x99/0x9f0
[  +0.000005]
stack backtrace:
[  +0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           OE     =
5.15.64evl-g4a69fe361195 #8
[  +0.000002] Hardware name: Supermicro Super Server/X10SDV-6C-TLN4F, =
BIOS 1.3 02/13/2018
[  +0.000001] IRQ stage: EVL
[  +0.000000] Call Trace:
[  +0.000000]  <TASK>
[  +0.000014]  dump_stack_lvl+0x82/0xbc
[  +0.000055]  dump_stack+0x10/0x16
[  +0.000015]  lockdep_rcu_suspicious+0xed/0xfc
[  +0.000088]  is_bpf_text_address+0xdf/0xf0
[  +0.000027]  kernel_text_address+0x108/0x120
[  +0.000054]  __kernel_text_address+0xd/0x40
[  +0.000028]  show_trace_log_lvl+0x1d0/0x296
[  +0.000204]  ? dump_stack_lvl+0x82/0xbc
[  +0.000115]  show_stack+0x34/0x3a
[  +0.000016]  dump_stack_lvl+0x82/0xbc
[  +0.000053]  dump_stack+0x10/0x16
[  +0.000015]  lockdep_rcu_suspicious+0xed/0xfc
[  +0.000079]  is_bpf_text_address+0xac/0xf0
[  +0.000027]  kernel_text_address+0x108/0x120
[  +0.000052]  __kernel_text_address+0xd/0x40
[  +0.000028]  show_trace_log_lvl+0x1d0/0x296
[  +0.000203]  ? dump_stack_lvl+0x82/0xbc
[  +0.000121]  show_stack+0x34/0x3a
[  +0.000016]  dump_stack_lvl+0x82/0xbc
[  +0.000052]  dump_stack+0x10/0x16
[  +0.000016]  lockdep_rcu_suspicious+0xed/0xfc
[  +0.000079]  __is_insn_slot_addr+0x118/0x130
[  +0.000041]  kernel_text_address+0xc4/0x120
[  +0.000053]  __kernel_text_address+0xd/0x40
[  +0.000027]  show_trace_log_lvl+0x1d0/0x296
[  +0.000203]  ? dump_stack_lvl+0x82/0xbc
[  +0.000115]  show_stack+0x34/0x3a
[  +0.000016]  dump_stack_lvl+0x82/0xbc
[  +0.000053]  dump_stack+0x10/0x16
[  +0.000015]  lockdep_rcu_suspicious+0xed/0xfc
[  +0.000079]  __is_insn_slot_addr+0xe2/0x130
[  +0.000040]  kernel_text_address+0xc4/0x120
[  +0.000052]  __kernel_text_address+0xd/0x40
[  +0.000028]  show_trace_log_lvl+0x1d0/0x296
[  +0.000208]  ? kernel_text_address+0x2c/0x120
[  +0.000078]  ? rcu_is_watching+0x2b/0x60
[  +0.000029]  show_regs.cold.19+0x1a/0x1f
[  +0.000029]  __warn+0x80/0x100
[  +0.000040]  ? rcu_is_watching+0x2b/0x60
[  +0.000041]  report_bug+0xc5/0x100
[  +0.000093]  handle_bug+0x41/0xa0
[  +0.000041]  exc_invalid_op+0x18/0x70
[  +0.000040]  asm_exc_invalid_op+0x1b/0x20
[  +0.000002] RIP: 0010:rcu_is_watching+0x2b/0x60
[  +0.000004] Code: b8 01 00 00 00 65 8b 15 33 94 ee 51 48 89 e5 f7 c2 =
00 00 00 01 75 15 0f b6 05 72 ae 76 02 84 c0 75 10 81 e2 00 00 00 02 74 =
08 <0f> 0b 5d c3 cc cc cc cc 65 ff 05 06 94 ee 51 48 c7 c0 48 f0 05 00
[  +0.000003] RSP: 0018:ffffffffaf603940 EFLAGS: 00010006
[  +0.000002] RAX: 0000000000000000 RBX: ffffffffafb1bbc9 RCX: =
ffffffffaf603998
[  +0.000001] RDX: 0000000002000000 RSI: ffffffffaf603e01 RDI: =
ffffffffafb1bbc9
[  +0.000001] RBP: ffffffffaf603940 R08: ffffffffaf603f48 R09: =
ffffffffaf61c818
[  +0.000001] R10: ffffffffaf603ad0 R11: ffffffffaf61c840 R12: =
ffffffffaf603a40
[  +0.000001] R13: 0000000000000000 R14: ffffffffaf61ba00 R15: =
ffffffffaffc2180
[  +0.000077]  ? arch_call_rest_init+0x9/0x14
[  +0.000116]  ? arch_call_rest_init+0x9/0x14
[  +0.000078]  kernel_text_address+0x2c/0x120
[  +0.000015]  ? arch_call_rest_init+0x9/0x14
[  +0.000041]  __kernel_text_address+0xd/0x40
[  +0.000027]  unwind_get_return_address+0x1e/0x40
[  +0.000003]  ? create_prof_cpu_mask+0x30/0x30
[  +0.000017]  arch_stack_walk+0x9c/0xf0
[  +0.000136]  ? arch_call_rest_init+0x9/0x14
[  +0.000103]  stack_trace_save+0x47/0x70
[  +0.000064]  save_trace+0x45/0x390
[  +0.000141]  check_prevs_add+0xa9e/0x1060
[  +0.000178]  __lock_acquire+0x1105/0x1580
[  +0.000004]  ? lock_is_held_type+0x50/0x110
[  +0.000003]  ? subsystem_release+0x19/0x40
[  +0.000166]  lock_acquire+0xb3/0x2a0
[  +0.000016]  ? lock_timer_base.isra.21+0x2f/0x80
[  +0.000202]  lock_timer_base.isra.21+0x57/0x80
[  +0.000003]  ? lock_timer_base.isra.21+0x2f/0x80
[  +0.000083]  evl_start_timer+0x50/0x210
[  +0.000090]  __evl_schedule+0x622/0x9f0
[  +0.000116]  run_oob_call+0x99/0x170
[  +0.000102]  resume_oob_task+0x110/0x1c0
[  +0.000091]  finalize_oob_transition+0x42/0x80
[  +0.000028]  inband_switch_tail+0x3b/0x90
[  +0.000028]  __schedule+0x4bb/0xa70
[  +0.000115]  schedule_idle+0x1b/0x40
[  +0.000016]  do_idle+0x1b3/0x280
[  +0.000114]  cpu_startup_entry+0x18/0x20
[  +0.000028]  rest_init+0x177/0x280
[  +0.000041]  arch_call_rest_init+0x9/0x14
[  +0.000028]  start_kernel+0x6bc/0x6e6
[  +0.000145]  x86_64_start_reservations+0x24/0x2a
[  +0.000029]  x86_64_start_kernel+0x89/0x90
[  +0.000028]  secondary_startup_64_no_verify+0xb0/0xbb
[  +0.000265]  </TASK>
[  +0.000001]  dump_stack_lvl+0x82/0xbc
[  +0.000053]  dump_stack+0x10/0x16
[  +0.000016]  lockdep_rcu_suspicious+0xed/0xfc
[  +0.000079]  is_bpf_text_address+0xac/0xf0
[  +0.000027]  kernel_text_address+0x108/0x120
[  +0.000052]  __kernel_text_address+0xd/0x40
[  +0.000028]  show_trace_log_lvl+0x1d0/0x296
[  +0.000202]  ? dump_stack_lvl+0x82/0xbc
[  +0.000116]  show_stack+0x34/0x3a
[  +0.000015]  dump_stack_lvl+0x82/0xbc
[  +0.000053]  dump_stack+0x10/0x16
[  +0.000015]  lockdep_rcu_suspicious+0xed/0xfc
[  +0.000085]  __is_insn_slot_addr+0x118/0x130
[  +0.000040]  kernel_text_address+0xc4/0x120
[  +0.000052]  __kernel_text_address+0xd/0x40
[  +0.000028]  show_trace_log_lvl+0x1d0/0x296
[  +0.000203]  ? dump_stack_lvl+0x82/0xbc
[  +0.000115]  show_stack+0x34/0x3a
[  +0.000016]  dump_stack_lvl+0x82/0xbc
[  +0.000052]  dump_stack+0x10/0x16
[  +0.000015]  lockdep_rcu_suspicious+0xed/0xfc
[  +0.000079]  __is_insn_slot_addr+0xe2/0x130
[  +0.000041]  kernel_text_address+0xc4/0x120
[  +0.000052]  __kernel_text_address+0xd/0x40
[  +0.000027]  show_trace_log_lvl+0x1d0/0x296
[  +0.000203]  ? kernel_text_address+0x2c/0x120
[  +0.000083]  ? rcu_is_watching+0x2b/0x60
[  +0.000029]  show_regs.cold.19+0x1a/0x1f
[  +0.000029]  __warn+0x80/0x100
[  +0.000039]  ? rcu_is_watching+0x2b/0x60
[  +0.000041]  report_bug+0xc5/0x100
[  +0.000092]  handle_bug+0x41/0xa0
[  +0.000040]  exc_invalid_op+0x18/0x70
[  +0.000040]  asm_exc_invalid_op+0x1b/0x20
[  +0.000002] RIP: 0010:rcu_is_watching+0x2b/0x60
[  +0.000004] Code: b8 01 00 00 00 65 8b 15 33 94 ee 51 48 89 e5 f7 c2 =
00 00 00 01 75 15 0f b6 05 72 ae 76 02 84 c0 75 10 81 e2 00 00 00 02 74 =
08 <0f> 0b 5d c3 cc cc cc cc 65 ff 05 06 94 ee 51 48 c7 c0 48 f0 05 00
[  +0.000002] RSP: 0018:ffffffffaf603940 EFLAGS: 00010006
[  +0.000001] RAX: 0000000000000000 RBX: ffffffffafb1bbc9 RCX: =
ffffffffaf603998
[  +0.000001] RDX: 0000000002000000 RSI: ffffffffaf603e01 RDI: =
ffffffffafb1bbc9
[  +0.000002] RBP: ffffffffaf603940 R08: ffffffffaf603f48 R09: =
ffffffffaf61c818
[  +0.000001] R10: ffffffffaf603ad0 R11: ffffffffaf61c840 R12: =
ffffffffaf603a40
[  +0.000001] R13: 0000000000000000 R14: ffffffffaf61ba00 R15: =
ffffffffaffc2180
[  +0.000076]  ? arch_call_rest_init+0x9/0x14
[  +0.000115]  ? arch_call_rest_init+0x9/0x14
[  +0.000078]  kernel_text_address+0x2c/0x120
[  +0.000015]  ? arch_call_rest_init+0x9/0x14
[  +0.000041]  __kernel_text_address+0xd/0x40
[  +0.000027]  unwind_get_return_address+0x1e/0x40
[  +0.000002]  ? create_prof_cpu_mask+0x30/0x30
[  +0.000017]  arch_stack_walk+0x9c/0xf0
[  +0.000128]  ? arch_call_rest_init+0x9/0x14
[  +0.000109]  stack_trace_save+0x47/0x70
[  +0.000064]  save_trace+0x45/0x390
[  +0.000140]  check_prevs_add+0xa9e/0x1060
[  +0.000179]  __lock_acquire+0x1105/0x1580
[  +0.000003]  ? lock_is_held_type+0x50/0x110
[  +0.000003]  ? subsystem_release+0x19/0x40
[  +0.000166]  lock_acquire+0xb3/0x2a0
[  +0.000015]  ? lock_timer_base.isra.21+0x2f/0x80
[  +0.000203]  lock_timer_base.isra.21+0x57/0x80
[  +0.000002]  ? lock_timer_base.isra.21+0x2f/0x80
[  +0.000077]  evl_start_timer+0x50/0x210
[  +0.000091]  __evl_schedule+0x622/0x9f0
[  +0.000120]  run_oob_call+0x99/0x170
[  +0.000102]  resume_oob_task+0x110/0x1c0
[  +0.000091]  finalize_oob_transition+0x42/0x80
[  +0.000028]  inband_switch_tail+0x3b/0x90
[  +0.000029]  __schedule+0x4bb/0xa70
[  +0.000115]  schedule_idle+0x1b/0x40
[  +0.000015]  do_idle+0x1b3/0x280
[  +0.000114]  cpu_startup_entry+0x18/0x20
[  +0.000027]  rest_init+0x177/0x280
[  +0.000041]  arch_call_rest_init+0x9/0x14
[  +0.000028]  start_kernel+0x6bc/0x6e6
[  +0.000141]  x86_64_start_reservations+0x24/0x2a
[  +0.000028]  x86_64_start_kernel+0x89/0x90
[  +0.000028]  secondary_startup_64_no_verify+0xb0/0xbb
[  +0.000270]  </TASK>
[  +0.000002]  dump_stack_lvl+0x82/0xbc
[  +0.000053]  dump_stack+0x10/0x16
[  +0.000015]  lockdep_rcu_suspicious+0xed/0xfc
[  +0.000080]  __is_insn_slot_addr+0x118/0x130
[  +0.000040]  kernel_text_address+0xc4/0x120
[  +0.000052]  __kernel_text_address+0xd/0x40
[  +0.000028]  show_trace_log_lvl+0x1d0/0x296
[  +0.000203]  ? dump_stack_lvl+0x82/0xbc
[  +0.000115]  show_stack+0x34/0x3a
[  +0.000016]  dump_stack_lvl+0x82/0xbc
[  +0.000052]  dump_stack+0x10/0x16
[  +0.000015]  lockdep_rcu_suspicious+0xed/0xfc
[  +0.000079]  __is_insn_slot_addr+0xe2/0x130
[  +0.000041]  kernel_text_address+0xc4/0x120
[  +0.000052]  __kernel_text_address+0xd/0x40
[  +0.000029]  show_trace_log_lvl+0x1d0/0x296
[  +0.000206]  ? kernel_text_address+0x2c/0x120
[  +0.000077]  ? rcu_is_watching+0x2b/0x60
[  +0.000029]  show_regs.cold.19+0x1a/0x1f
[  +0.000029]  __warn+0x80/0x100
[  +0.000039]  ? rcu_is_watching+0x2b/0x60
[  +0.000042]  report_bug+0xc5/0x100
[  +0.000091]  handle_bug+0x41/0xa0
[  +0.000040]  exc_invalid_op+0x18/0x70
[  +0.000040]  asm_exc_invalid_op+0x1b/0x20
[  +0.000002] RIP: 0010:rcu_is_watching+0x2b/0x60
[  +0.000004] Code: b8 01 00 00 00 65 8b 15 33 94 ee 51 48 89 e5 f7 c2 =
00 00 00 01 75 15 0f b6 05 72 ae 76 02 84 c0 75 10 81 e2 00 00 00 02 74 =
08 <0f> 0b 5d c3 cc cc cc cc 65 ff 05 06 94 ee 51 48 c7 c0 48 f0 05 00
[  +0.000001] RSP: 0018:ffffffffaf603940 EFLAGS: 00010006
[  +0.000002] RAX: 0000000000000000 RBX: ffffffffafb1bbc9 RCX: =
ffffffffaf603998
[  +0.000001] RDX: 0000000002000000 RSI: ffffffffaf603e01 RDI: =
ffffffffafb1bbc9
[  +0.000001] RBP: ffffffffaf603940 R08: ffffffffaf603f48 R09: =
ffffffffaf61c818
[  +0.000001] R10: ffffffffaf603ad0 R11: ffffffffaf61c840 R12: =
ffffffffaf603a40
[  +0.000001] R13: 0000000000000000 R14: ffffffffaf61ba00 R15: =
ffffffffaffc2180
[  +0.000076]  ? arch_call_rest_init+0x9/0x14
[  +0.000116]  ? arch_call_rest_init+0x9/0x14
[  +0.000077]  kernel_text_address+0x2c/0x120
[  +0.000015]  ? arch_call_rest_init+0x9/0x14
[  +0.000041]  __kernel_text_address+0xd/0x40
[  +0.000027]  unwind_get_return_address+0x1e/0x40
[  +0.000002]  ? create_prof_cpu_mask+0x30/0x30
[  +0.000017]  arch_stack_walk+0x9c/0xf0
[  +0.000133]  ? arch_call_rest_init+0x9/0x14
[  +0.000103]  stack_trace_save+0x47/0x70
[  +0.000064]  save_trace+0x45/0x390
[  +0.000141]  check_prevs_add+0xa9e/0x1060
[  +0.000178]  __lock_acquire+0x1105/0x1580
[  +0.000003]  ? lock_is_held_type+0x50/0x110
[  +0.000003]  ? subsystem_release+0x19/0x40
[  +0.000165]  lock_acquire+0xb3/0x2a0
[  +0.000016]  ? lock_timer_base.isra.21+0x2f/0x80
[  +0.000202]  lock_timer_base.isra.21+0x57/0x80
[  +0.000003]  ? lock_timer_base.isra.21+0x2f/0x80
[  +0.000082]  evl_start_timer+0x50/0x210
[  +0.000090]  __evl_schedule+0x622/0x9f0
[  +0.000116]  run_oob_call+0x99/0x170
[  +0.000102]  resume_oob_task+0x110/0x1c0
[  +0.000090]  finalize_oob_transition+0x42/0x80
[  +0.000029]  inband_switch_tail+0x3b/0x90
[  +0.000028]  __schedule+0x4bb/0xa70
[  +0.000115]  schedule_idle+0x1b/0x40
[  +0.000015]  do_idle+0x1b3/0x280
[  +0.000114]  cpu_startup_entry+0x18/0x20
[  +0.000027]  rest_init+0x177/0x280
[  +0.000042]  arch_call_rest_init+0x9/0x14
[  +0.000028]  start_kernel+0x6bc/0x6e6
[  +0.000145]  x86_64_start_reservations+0x24/0x2a
[  +0.000028]  x86_64_start_kernel+0x89/0x90
[  +0.000028]  secondary_startup_64_no_verify+0xb0/0xbb
[  +0.000264]  </TASK>
[  +0.000009]  dump_stack_lvl+0x82/0xbc
[  +0.000053]  dump_stack+0x10/0x16
[  +0.000015]  lockdep_rcu_suspicious+0xed/0xfc
[  +0.000079]  __is_insn_slot_addr+0xe2/0x130
[  +0.000040]  kernel_text_address+0xc4/0x120
[  +0.000053]  __kernel_text_address+0xd/0x40
[  +0.000027]  show_trace_log_lvl+0x1d0/0x296
[  +0.000203]  ? kernel_text_address+0x2c/0x120
[  +0.000077]  ? rcu_is_watching+0x2b/0x60
[  +0.000029]  show_regs.cold.19+0x1a/0x1f
[  +0.000029]  __warn+0x80/0x100
[  +0.000039]  ? rcu_is_watching+0x2b/0x60
[  +0.000047]  report_bug+0xc5/0x100
[  +0.000091]  handle_bug+0x41/0xa0
[  +0.000040]  exc_invalid_op+0x18/0x70
[  +0.000040]  asm_exc_invalid_op+0x1b/0x20
[  +0.000002] RIP: 0010:rcu_is_watching+0x2b/0x60
[  +0.000004] Code: b8 01 00 00 00 65 8b 15 33 94 ee 51 48 89 e5 f7 c2 =
00 00 00 01 75 15 0f b6 05 72 ae 76 02 84 c0 75 10 81 e2 00 00 00 02 74 =
08 <0f> 0b 5d c3 cc cc cc cc 65 ff 05 06 94 ee 51 48 c7 c0 48 f0 05 00
[  +0.000001] RSP: 0018:ffffffffaf603940 EFLAGS: 00010006
[  +0.000002] RAX: 0000000000000000 RBX: ffffffffafb1bbc9 RCX: =
ffffffffaf603998
[  +0.000001] RDX: 0000000002000000 RSI: ffffffffaf603e01 RDI: =
ffffffffafb1bbc9
[  +0.000001] RBP: ffffffffaf603940 R08: ffffffffaf603f48 R09: =
ffffffffaf61c818
[  +0.000001] R10: ffffffffaf603ad0 R11: ffffffffaf61c840 R12: =
ffffffffaf603a40
[  +0.000001] R13: 0000000000000000 R14: ffffffffaf61ba00 R15: =
ffffffffaffc2180
[  +0.000076]  ? arch_call_rest_init+0x9/0x14
[  +0.000116]  ? arch_call_rest_init+0x9/0x14
[  +0.000077]  kernel_text_address+0x2c/0x120
[  +0.000015]  ? arch_call_rest_init+0x9/0x14
[  +0.000041]  __kernel_text_address+0xd/0x40
[  +0.000027]  unwind_get_return_address+0x1e/0x40
[  +0.000002]  ? create_prof_cpu_mask+0x30/0x30
[  +0.000017]  arch_stack_walk+0x9c/0xf0
[  +0.000128]  ? arch_call_rest_init+0x9/0x14
[  +0.000103]  stack_trace_save+0x47/0x70
[  +0.000064]  save_trace+0x45/0x390
[  +0.000146]  check_prevs_add+0xa9e/0x1060
[  +0.000178]  __lock_acquire+0x1105/0x1580
[  +0.000003]  ? lock_is_held_type+0x50/0x110
[  +0.000003]  ? subsystem_release+0x19/0x40
[  +0.000166]  lock_acquire+0xb3/0x2a0
[  +0.000015]  ? lock_timer_base.isra.21+0x2f/0x80
[  +0.000203]  lock_timer_base.isra.21+0x57/0x80
[  +0.000002]  ? lock_timer_base.isra.21+0x2f/0x80
[  +0.000077]  evl_start_timer+0x50/0x210
[  +0.000090]  __evl_schedule+0x622/0x9f0
[  +0.000116]  run_oob_call+0x99/0x170
[  +0.000102]  resume_oob_task+0x110/0x1c0
[  +0.000095]  finalize_oob_transition+0x42/0x80
[  +0.000029]  inband_switch_tail+0x3b/0x90
[  +0.000028]  __schedule+0x4bb/0xa70
[  +0.000115]  schedule_idle+0x1b/0x40
[  +0.000015]  do_idle+0x1b3/0x280
[  +0.000114]  cpu_startup_entry+0x18/0x20
[  +0.000027]  rest_init+0x177/0x280
[  +0.000041]  arch_call_rest_init+0x9/0x14
[  +0.000029]  start_kernel+0x6bc/0x6e6
[  +0.000140]  x86_64_start_reservations+0x24/0x2a
[  +0.000028]  x86_64_start_kernel+0x89/0x90
[  +0.000027]  secondary_startup_64_no_verify+0xb0/0xbb
[  +0.000265]  </TASK>
[  +0.000010]  kernel_text_address+0x2c/0x120
[  +0.000015]  ? arch_call_rest_init+0x9/0x14
[  +0.000044]  __kernel_text_address+0xd/0x40
[  +0.000029]  unwind_get_return_address+0x1e/0x40
[  +0.000002]  ? create_prof_cpu_mask+0x30/0x30
[  +0.000016]  arch_stack_walk+0x9c/0xf0
[  +0.000129]  ? arch_call_rest_init+0x9/0x14
[  +0.000102]  stack_trace_save+0x47/0x70
[  +0.000065]  save_trace+0x45/0x390
[  +0.000140]  check_prevs_add+0xa9e/0x1060
[  +0.000178]  __lock_acquire+0x1105/0x1580
[  +0.000003]  ? lock_is_held_type+0x50/0x110
[  +0.000003]  ? subsystem_release+0x19/0x40
[  +0.000166]  lock_acquire+0xb3/0x2a0
[  +0.000015]  ? lock_timer_base.isra.21+0x2f/0x80
[  +0.000208]  lock_timer_base.isra.21+0x57/0x80
[  +0.000002]  ? lock_timer_base.isra.21+0x2f/0x80
[  +0.000078]  evl_start_timer+0x50/0x210
[  +0.000090]  __evl_schedule+0x622/0x9f0
[  +0.000115]  run_oob_call+0x99/0x170
[  +0.000102]  resume_oob_task+0x110/0x1c0
[  +0.000090]  finalize_oob_transition+0x42/0x80
[  +0.000029]  inband_switch_tail+0x3b/0x90
[  +0.000028]  __schedule+0x4bb/0xa70
[  +0.000115]  schedule_idle+0x1b/0x40
[  +0.000015]  do_idle+0x1b3/0x280
[  +0.000114]  cpu_startup_entry+0x18/0x20
[  +0.000027]  rest_init+0x177/0x280
[  +0.000041]  arch_call_rest_init+0x9/0x14
[  +0.000028]  start_kernel+0x6bc/0x6e6
[  +0.000146]  x86_64_start_reservations+0x24/0x2a
[  +0.000028]  x86_64_start_kernel+0x89/0x90
[  +0.000027]  secondary_startup_64_no_verify+0xb0/0xbb
[  +0.000265]  </TASK>
[  +0.000001] irq event stamp: 8487512
[  +0.000000] hardirqs last  enabled at (8487511): [<ffffffffae126994>] =
sync_current_irq_stage+0x2a4/0x2d0
[  +0.000003] hardirqs last disabled at (8487512): [<ffffffffaeaf48e2>] =
__schedule+0x282/0xa70
[  +0.000003] softirqs last  enabled at (8487488): [<ffffffffaee002e9>] =
__do_softirq+0x2e9/0x421
[  +0.000003] softirqs last disabled at (8487481): [<ffffffffae08aa3d>] =
irq_exit_rcu+0xcd/0xf0
[  +0.000004] ---[ end trace da74aa0feaab0470 ]---
[  +0.015764] EVL: Main[4625] could not receive HM event #2
[  +0.000968] EVL: Main[4625] could not receive HM event #2
[  +0.000343] EVL: Main[4625] could not receive HM event #2
[  +0.000406] EVL: Main[4625] could not receive HM event #2
[  +0.000403] EVL: Main[4625] could not receive HM event #2
[  +0.000312] EVL: Main[4625] could not receive HM event #2
[  +0.000974] EVL: Main[4625] could not receive HM event #2
[  +0.003818] EVL: Main[4625] could not receive HM event #2
[  +0.018835] EVL: Main[4625] could not receive HM event #2
[  +0.000475] EVL: Main[4625] could not receive HM event #2

[  +1.361685] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  +0.000001] WARNING: possible recursive locking detected
[  +0.000001] 5.15.64evl-g4a69fe361195 #8 Tainted: G        W  OE
[  +0.000002] --------------------------------------------
[  +0.000000] IRQ_0xe4f_1_0/4641 is trying to acquire lock:
[  +0.000002] ffff9e2843d6a018 (__RAWLOCK(&thread->lock)){-.-.}-{2:2}, =
at: evl_lock_mutex_timeout+0x299/0xe40
[  +0.000012]
but task is already holding lock:
[  +0.000000] ffff9e28412f0018 (__RAWLOCK(&thread->lock)){-.-.}-{2:2}, =
at: evl_lock_mutex_timeout+0x1b5/0xe40
[  +0.000006]
other info that might help us debug this:
[  +0.000001]  Possible unsafe locking scenario:

[  +0.000001]        CPU0
[  +0.000000]        ----
[  +0.000001]   lock(__RAWLOCK(&thread->lock));
[  +0.000001]   lock(__RAWLOCK(&thread->lock));
[  +0.000001]
 *** DEADLOCK ***

[  +0.000001]  May be due to missing lock nesting notation

[  +0.000000] 2 locks held by IRQ_0xe4f_1_0/4641:
[  +0.000002]  #0: ffff9e28454ba9d8 (&mon->mutex){....}-{0:0}, at: =
evl_lock_mutex_timeout+0x1b5/0xe40
[  +0.000006]  #1: ffff9e28412f0018 =
(__RAWLOCK(&thread->lock)){-.-.}-{2:2}, at: =
evl_lock_mutex_timeout+0x1b5/0xe40
[  +0.000005]
stack backtrace:
[  +0.000001] CPU: 10 PID: 4641 Comm: IRQ_0xe4f_1_0 Tainted: G        W  =
OE     5.15.64evl-g4a69fe361195 #8
[  +0.000004] Hardware name: Supermicro Super Server/X10SDV-6C-TLN4F, =
BIOS 1.3 02/13/2018
[  +0.000001] IRQ stage: EVL
[  +0.000001] Call Trace:
[  +0.000001]  <TASK>
[  +0.000014]  dump_stack_lvl+0x82/0xbc
[  +0.000056]  dump_stack+0x10/0x16
[  +0.000015]  __lock_acquire.cold.80+0xc3/0x2ab
[  +0.000192]  lock_acquire+0xb3/0x2a0
[  +0.000018]  ? evl_lock_mutex_timeout+0x299/0xe40
[  +0.000206]  evl_lock_mutex_timeout+0x2c1/0xe40
[  +0.000004]  ? evl_lock_mutex_timeout+0x299/0xe40
[  +0.000234]  enter_monitor+0x88/0xc0
[  +0.000041]  monitor_oob_ioctl+0x30c/0xf60
[  +0.000016]  ? find_held_lock+0x35/0xb0
[  +0.000042]  ? evl_get_file+0x6d/0xd0
[  +0.000042]  ? lock_release+0x13e/0x270
[  +0.000180]  EVL_ioctl+0x46/0xa0
[  +0.000052]  do_oob_syscall+0x3bb/0x3d0
[  +0.000015]  ? handle_oob_irq+0xa2/0x190
[  +0.000090]  handle_oob_syscall+0xa8/0x100
[  +0.000103]  pipeline_syscall+0x65/0x130
[  +0.000054]  syscall_enter_from_user_mode+0x47/0x110
[  +0.000055]  do_syscall_64+0x15/0xb0
[  +0.000028]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[  +0.000004] RIP: 0033:0x7f8e411d2a6b
[  +0.000010] Code: Unable to access opcode bytes at RIP 0x7f8e411d2a41.
[  +0.000001] RSP: 002b:00007f8e2f439320 EFLAGS: 00000246 ORIG_RAX: =
000000000000009d
[  +0.000003] RAX: ffffffffffffffda RBX: 00007f8e2f4393b0 RCX: =
00007f8e411d2a6b
[  +0.000001] RDX: 0000000040106d00 RSI: 000000000000000d RDI: =
0000000010000002
[  +0.000002] RBP: 0000000040106d00 R08: 0000000000000000 R09: =
00007f8e39eae680
[  +0.000001] R10: 00007f8e2f4393b0 R11: 0000000000000246 R12: =
000000000000000d
[  +0.000001] R13: 00007f8e2f4395b0 R14: 00007f8e39eb3968 R15: =
00007f8e2f439578
[  +0.000270]  </TASK>
[ 1407.967142] watchdog: BUG: soft lockup - CPU#7 stuck for 23s! =
[kworker/7:0:3780]
[ 1407.990020] Modules linked in: dma_buf_mgr(OE) rtlstddriver(OE) =
xt_CHECKSUM xt_MASQUERADE tun ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 =
ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ip6table_nat =
ip6table_mangle ip6table_security ip6table_raw iptable_nat nf_nat =
iptable_mangle iptable_security iptable_raw nf_conntrack nf_defrag_ipv6 =
nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables rfkill =
ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod x86_pkg_temp_thermal intel_powerclamp =
coretemp kvm_intel gpio_ich iTCO_wdt iTCO_vendor_support mxm_wmi kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl intel_cstate pcspkr i2c_i801 intel_pch_thermal =
i2c_smbus mei_me sg lpc_ich mfd_core joydev input_leds mei ftdi_sio =
ioatdma acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler wmi acpi_pad =
ip_tables xfs libcrc32c sr_mod sd_mod cdrom t10_pi ast drm_vram_helper =
drm_kms_helper syscopyarea sysfillrect sysimgblt
[ 1407.990121]  fb_sys_fops drm_ttm_helper ttm drm ixgbe igb ahci =
libahci libata crc32c_intel mdio ptp i2c_algo_bit pps_core dca
[ 1408.291430] irq event stamp: 12888
[ 1408.302564] hardirqs last  enabled at (12887): [<ffffffffaeafe622>] =
_raw_spin_unlock_irq+0x22/0x40
[ 1408.330379] hardirqs last disabled at (12888): [<ffffffffaeaf48e2>] =
__schedule+0x282/0xa70
[ 1408.356099] softirqs last  enabled at (12848): [<ffffffffaee002e9>] =
__do_softirq+0x2e9/0x421
[ 1408.382322] softirqs last disabled at (12843): [<ffffffffae08aa3d>] =
irq_exit_rcu+0xcd/0xf0
[ 1408.408019] CPU: 7 PID: 3780 Comm: kworker/7:0 Tainted: G        W  =
OE     5.15.64evl-g4a69fe361195 #8
[ 1408.436844] Hardware name: Supermicro Super Server/X10SDV-6C-TLN4F, =
BIOS 1.3 02/13/2018
[ 1408.461788] IRQ stage: Linux
[ 1408.471385] Workqueue: events netstamp_clear
[ 1408.485177] RIP: 0010:smp_call_function_many_cond+0x154/0x370
[ 1408.503389] Code: 89 c7 e8 1f 32 3e 00 3b 05 4d ea 92 01 73 96 48 63 =
d0 48 8b 0b 48 03 0c d5 80 b8 3f af 8b 51 08 83 e2 01 74 0a f3 90 8b 51 =
08 <83> e2 01 75 f6 eb cb 80 3d f6 90 92 01 00 0f 85 f8 fe ff ff 8b 05
[ 1408.561725] RSP: 0018:ffffbab0c2dcfcc0 EFLAGS: 00000202 ORIG_RAX: =
0000000000000000
[ 1408.585477] RAX: 0000000000000000 RBX: 0000000000000000 RCX: =
0000000000000000
[ 1408.607938] RDX: 0000000000000000 RSI: 0000000000000000 RDI: =
0000000000000000
[ 1408.630370] RBP: ffffbab0c2dcfd20 R08: 0000000000000000 R09: =
0000000000000000
[ 1408.652811] R10: 0000000000000000 R11: 0000000000000000 R12: =
0000000000000000
[ 1408.675242] R13: 0000000000000000 R14: 0000000000000000 R15: =
0000000000000000
[ 1408.697674] FS:  0000000000000000(0000) GS:ffff9e2b6d780000(0000) =
knlGS:0000000000000000
[ 1408.722984] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1408.741273] CR2: 0000000001c6cc68 CR3: 00000003a5612004 CR4: =
00000000003706e0
[ 1408.763752] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[ 1408.786220] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[ 1408.808688] Call Trace:
[ 1408.817132]  <TASK>
[ 1408.824513]  ? __text_poke+0x4a0/0x4a0
[ 1408.836834]  ? netif_receive_skb_list_internal+0x3d/0x370
[ 1408.854107]  on_each_cpu_cond_mask+0x24/0x40
[ 1408.868013]  text_poke_bp_batch+0xbc/0x2c0
[ 1408.881371]  ? netif_receive_skb_list_internal+0x3d/0x370
[ 1408.898639]  text_poke_finish+0x1a/0x30
[ 1408.911209]  arch_jump_label_transform_apply+0x17/0x30
[ 1408.927690]  __jump_label_update+0xdd/0x120
[ 1408.941307]  jump_label_update+0xc9/0xf0
[ 1408.954132]  static_key_enable_cpuslocked+0x5f/0x90
[ 1408.969842]  static_key_enable+0x15/0x30
[ 1408.982671]  netstamp_clear+0x28/0x40
[ 1408.994699]  process_one_work+0x29a/0x590
[ 1409.007765]  worker_thread+0x2f/0x3e0
[ 1409.019774]  ? process_one_work+0x590/0x590
[ 1409.033297]  kthread+0x13b/0x160
[ 1409.043923]  ? set_kthread_struct+0x50/0x50
[ 1409.057394]  ret_from_fork+0x22/0x30
[ 1409.069014]  </TASK>
[Sep29 12:30] watchdog: BUG: soft lockup - CPU#7 stuck for 23s! =
[kworker/7:0:3780]
[  +0.022878] Modules linked in: dma_buf_mgr(OE) rtlstddriver(OE) =
xt_CHECKSUM xt_MASQUERADE tun ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 =
ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ip6table_nat =
ip6table_mangle ip6table_security ip6table_raw iptable_nat nf_nat =
iptable_mangle iptable_security iptable_raw nf_conntrack nf_defrag_ipv6 =
nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables rfkill =
ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod x86_pkg_temp_thermal intel_powerclamp =
coretemp kvm_intel gpio_ich iTCO_wdt iTCO_vendor_support mxm_wmi kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl intel_cstate pcspkr i2c_i801 intel_pch_thermal =
i2c_smbus mei_me sg lpc_ich mfd_core joydev input_leds mei ftdi_sio =
ioatdma acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler wmi acpi_pad =
ip_tables xfs libcrc32c sr_mod sd_mod cdrom t10_pi ast drm_vram_helper =
drm_kms_helper syscopyarea sysfillrect sysimgblt
[  +0.000101]  fb_sys_fops drm_ttm_helper ttm drm ixgbe igb ahci libahci =
libata crc32c_intel mdio ptp i2c_algo_bit pps_core dca
[  +0.301309] irq event stamp: 12888
[  +0.011134] hardirqs last  enabled at (12887): [<ffffffffaeafe622>] =
_raw_spin_unlock_irq+0x22/0x40
[  +0.027815] hardirqs last disabled at (12888): [<ffffffffaeaf48e2>] =
__schedule+0x282/0xa70
[  +0.025720] softirqs last  enabled at (12848): [<ffffffffaee002e9>] =
__do_softirq+0x2e9/0x421
[  +0.026223] softirqs last disabled at (12843): [<ffffffffae08aa3d>] =
irq_exit_rcu+0xcd/0xf0
[  +0.025697] CPU: 7 PID: 3780 Comm: kworker/7:0 Tainted: G        W  OE =
    5.15.64evl-g4a69fe361195 #8
[  +0.028825] Hardware name: Supermicro Super Server/X10SDV-6C-TLN4F, =
BIOS 1.3 02/13/2018
[  +0.024944] IRQ stage: Linux
[  +0.009597] Workqueue: events netstamp_clear
[  +0.013792] RIP: 0010:smp_call_function_many_cond+0x154/0x370
[  +0.018212] Code: 89 c7 e8 1f 32 3e 00 3b 05 4d ea 92 01 73 96 48 63 =
d0 48 8b 0b 48 03 0c d5 80 b8 3f af 8b 51 08 83 e2 01 74 0a f3 90 8b 51 =
08 <83> e2 01 75 f6 eb cb 80 3d f6 90 92 01 00 0f 85 f8 fe ff ff 8b 05
[  +0.058336] RSP: 0018:ffffbab0c2dcfcc0 EFLAGS: 00000202 ORIG_RAX: =
0000000000000000
[  +0.023752] RAX: 0000000000000000 RBX: 0000000000000000 RCX: =
0000000000000000
[  +0.022461] RDX: 0000000000000000 RSI: 0000000000000000 RDI: =
0000000000000000
[  +0.022432] RBP: ffffbab0c2dcfd20 R08: 0000000000000000 R09: =
0000000000000000
[  +0.022441] R10: 0000000000000000 R11: 0000000000000000 R12: =
0000000000000000
[  +0.022431] R13: 0000000000000000 R14: 0000000000000000 R15: =
0000000000000000
[  +0.022432] FS:  0000000000000000(0000) GS:ffff9e2b6d780000(0000) =
knlGS:0000000000000000
[  +0.025310] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.018289] CR2: 0000000001c6cc68 CR3: 00000003a5612004 CR4: =
00000000003706e0
[  +0.022479] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[  +0.022468] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[  +0.022468] Call Trace:
[  +0.008444]  <TASK>
[  +0.007381]  ? __text_poke+0x4a0/0x4a0
[  +0.012321]  ? netif_receive_skb_list_internal+0x3d/0x370
[  +0.017273]  on_each_cpu_cond_mask+0x24/0x40
[  +0.013906]  text_poke_bp_batch+0xbc/0x2c0
[  +0.013358]  ? netif_receive_skb_list_internal+0x3d/0x370
[  +0.017268]  text_poke_finish+0x1a/0x30
[  +0.012570]  arch_jump_label_transform_apply+0x17/0x30
[  +0.016481]  __jump_label_update+0xdd/0x120
[  +0.013617]  jump_label_update+0xc9/0xf0
[  +0.012825]  static_key_enable_cpuslocked+0x5f/0x90
[  +0.015710]  static_key_enable+0x15/0x30
[  +0.012829]  netstamp_clear+0x28/0x40
[  +0.012028]  process_one_work+0x29a/0x590
[  +0.013066]  worker_thread+0x2f/0x3e0
[  +0.012009]  ? process_one_work+0x590/0x590
[  +0.013523]  kthread+0x13b/0x160
[  +0.010626]  ? set_kthread_struct+0x50/0x50
[  +0.013471]  ret_from_fork+0x22/0x30
[  +0.011620]  </TASK>

------=_NextPart_001_0365_01D8D3FF.8BB0A340--

------=_NextPart_000_0364_01D8D3FF.8BB0A340
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
9w0BCQUxDxcNMjIwOTI5MTgzMjMyWjAvBgkqhkiG9w0BCQQxIgQge6CWtCpIhxgdQlUpsof58odS
3u/K0wo3XfjtRY5a12cwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQAx
pBivzvvmAuCVc8hJRKw1DGjb7MXgGcmsL5CBx0qe/tkdRNKDiMWAkoVSmUyCgVVZjquBV4czPjTZ
EpBy9WTWKol79DfX5XT6I24EWJd2XjmckFRsjt6MHT1ZLGFdEts13z9/525ldOy+j8iek90updli
su/JGy17hqrmkLF1/rQPdnFdLpLOGjJGrGH+uRO+ZGTuxvVOMnkihPkvqoX0CsC6vGxaZAS9fo1q
ifa8pn7xSbJ2+DKMpQaaMkbvw0QAMhgnkrRFzrv6F8r0plLNj2yD2/T7QutqbHEdEOcXS/PkUoAw
eKyFWWLBB4vZNXI5PFhod2bfdmDwE2n8S3MtAAAAAAAA

------=_NextPart_000_0364_01D8D3FF.8BB0A340--
