Received: from mx0a-001f5801.pphosted.com (mx0a-001f5801.pphosted.com [148.163.157.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9271F27737
	for <xenomai@lists.linux.dev>; Fri, 11 Nov 2022 21:56:46 +0000 (UTC)
Received: from pps.filterd (m0090334.ppops.net [127.0.0.1])
	by mx0a-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AB5sC9j001775;
	Fri, 11 Nov 2022 13:34:19 -0800
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02lp0177.outbound.protection.office365.us [23.103.199.177])
	by mx0a-001f5801.pphosted.com (PPS) with ESMTPS id 3ks6053qkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Nov 2022 13:34:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=FnK/bteq3Ze5jly+xE4hdnIVe/V2K5NDARe4ixVH4zkOIet5RrLDilR/nQa5L7wtbjz/GdrzA9HqIOLqiKx07s8IC1w8sBvWXxs/xUM3UzqjmsPbJeFeu7KVdigZ2Oe7JMcNgJA563BzCwMG9e9+TgcBv6Vdexe/nk13Irh3m4GW5s3ixYaeQ9w6vje+mXkwwWcdZSq4A0dDpzkU3VWtjgQB80ykgsso64Wzvl5happheTd/vpPUUawT0qj1Sh00Gu/pml/e7HCL+Pmcgg+r8hUJoKLvSSKPz/4ug83za0w5pMiLfBdKUOrWCKxrHoIuhIRZd3ejU77FFPYLAdsIkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cs9UFW1z6gPZHhMvjDvZG5MMlOK5ABgj15OWvrduPjA=;
 b=uEGV3gKMqbCuf4nV9ipScUHVjNBBwb6IGP0w3YNxo076EhmmlcdemJquudSXeSLzsezsEcVZjNPiZ8BGzfJZ/HepDKLL3GFqui2ALn9aqA6JGpsXyfZDqYgf+YPSTFM2QGwLAS/iGEqA6cM0V3FToCniSp4bpURlnM5U1NtBPvkNjfGwPwUXN3xpUfNmkPbFGy9UEnkV+HFaK6K0RAADTL3ZtZzk+uRg1YEIwGFJ6SJxx2faMVsyhKVLXadMm0OdQARfhCxLXCxdN4GqiF46/t1gwL3MHzMtu4Fe4Gl/xX8rHau79gZ3LCeksI1Q1fq79ghywOaUS5W5hIFQYIsnqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cs9UFW1z6gPZHhMvjDvZG5MMlOK5ABgj15OWvrduPjA=;
 b=MWMvu9QYhW5UwlX1YlSGucGYjnWdnUiZfCMHuxySf8F8G1LzMUZeDFjKs5tA/BXSKZAm6aL9DT3eI5Fwnv3iF812Q+J6VoB+mZwRYVJOyxcWN8oe5FT6R17guw41T+rQeDy9gVjIR4TXhvaf8zUbj/CKHJVIRXa0kjNpwFq5U8Vqf0qA4n5MwbEzWNGog7FiEkq8ZFgOqFusO2gm/4m/LPIJ/y4O/PEuazK4CAXU0ecY9mh1Nr1zHUzIs1DuU+nslkHz5cl3tMX94CrjlS8cE1nTH8sMxPLZDE49utgyDB1Rp3VNUVfN7zL001gdfcBhlcMfRCP88YraiX30LMED6Q==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1758.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Fri, 11 Nov
 2022 21:34:16 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::243c:a72b:71b4:9f78]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::243c:a72b:71b4:9f78%4]) with mapi id 15.20.5791.025; Fri, 11 Nov 2022
 21:34:16 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
        Bryan Butler
	<Bryan.Butler@kratosdefense.com>,
        Shawn McManus
	<shawn.mcmanus@kratosdefense.com>
Subject: RE: [External] - Re: EVL Memory
Thread-Topic: [External] - Re: EVL Memory
Thread-Index: Adjz0yff24VAOdNORJO8c3TjB/9lSwAgymPQAAE3ZMAAARoBAABtP6rQ
Date: Fri, 11 Nov 2022 21:34:15 +0000
Message-ID: 
 <PH1P110MB1050221E0BC34BD641127901E2009@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10508DD9688B7D0E82AB30CDE23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050307D7FC58A2B99A40094E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <877d04dm52.fsf@xenomai.org>
In-Reply-To: <877d04dm52.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB1758:EE_
x-ms-office365-filtering-correlation-id: 860dab8e-b1d3-42fe-47eb-08dac42c7bcc
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 eQ6/zEr8X3quYP01Mne2dce5q7iy/Tlsa/oiXv2L49Wn0SeirY+G1jL66BcqjomC+M9v1fppArOuPdPHa/wo2r0trEC+LIIQ6l9FOBRP4W+m3rED3qEIIOP4iWW2cpr9KoAHMOwSq1vDBLszIUAKsm6F9WfW3MbElYuoCJo7iDXYFgQ2l1TMNQmmAjhSmVU7vCQiHfFTFOdpgMV4Nkc/3zjBEw5q+cnGOhpH9M0tXStRoaVcVFNs/SQYlP9GJoQt6MQByG4U1wJckOuVapXUnRGsWsby4HqUlP04gcnE4EbiTDFzcddHPPksbJU2T0MmU37zaw3F52XWZZJ3D/ZZjW3ze8BJ6WLxq1k95arf52JtNGGgyaU6k5pPkoSABGkBNmXttSBfskXmsaqFnOaFrVRjUKGcwTy6VQ49ODj6tCgiQ/c3i9o21I6pUiFgZpImezcQycpnjifYIHJQuwRSrpxLydnYk1byui5k8YJtOiWxWSBnsDjHA3yfWVUZkNmVPZovnzkjbk+SiHtIyBw/MU6FO9w7kgtYAJqTqn8ktwMZkrRrMuY+TZ/fuOAK8/kaCNqMI8iRgRXCz4fV3rn70LeCK6qqRgThDSgqRmgBVMLMdO4VvwzIjYzmk6sk1a8m+csZnv1FMPALEpPWUtUf5nSDCOK39W5ufvtcP4pS6HFhgPpuXquehd43JZyDcgL1
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(8676002)(4326008)(4744005)(5660300002)(52536014)(8936002)(44832011)(107886003)(498600001)(7696005)(6916009)(54906003)(26005)(38100700002)(71200400001)(186003)(2906002)(9686003)(55016003)(6506007)(33656002)(66946007)(64756008)(86362001)(66446008)(66476007)(38070700005)(122000001)(66556008)(99936003)(83380400001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 vh4puPsx8RkjEBa9TkGLRWEJG8vZQPOApmhA5OR6oEpsu3sgEJjWh26L6sOrzxcoPqfS3lywacpALI6F0XG4rQXkYXD6qxjf0qXaL0oLIePEIP+QfZxOZHdB4/8WeZb1MJrVXE16R6pP+GtqYknSbi0UU/Q6QuLFKfqrE7iJ9lTL8rbr/tg6TF1sNmYeFifg1BQz9vT75OEW4B/owauuqfFLNmhr+kT7+ioxoZbcEbklbXuTRsbeBXb23NFet30d3y5vimTwy9zQBqKFPJub+LgUNsD8hI+nEkZSR9EOf8ywBh37cF17miiymsxhCdwoTC/rZdhTvV94Ldpc0QiEGVVfrxRhiK8I6JUEzFXX1boIRZ3tNzdaRZLkNE+Oxp0qK0LXMuG9auddfRBhfzVngveFUd1kk8NtEfgKsNYnleU=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_0000_01D8F5DA.AB733740"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9G1JI11+Nkkvx3u5zfxF8k51PxT6HNynnr1BBp+syT//vZQ8vPXA2H6HbAOT9BhxJCmbTTmvDFJtVT0dxt0ipATYNZ+sN0oWh1nsblD4RUMd67qxUFGUTFc0NoBQZZ+XES0T7+GuxNIpUAnYqcsEypfg/haRLN3uvIbm+hqdqP5bvlFmpL9ja93S1cu9KiDFSZuAcMJK6Kd3U2xSS90Y2fSVneQSP6YOPa/fEig/+y3lNK55czxexcd+i1+9Rz8N870gZbpxm3HDN4sAJYn8eBanHBKURruAedQdMsFwdFJ/hJdQ/76avR+ItAKu0tBIlCjttHYcJx7sNhRd2L9bqBk676mhC5EwVcOKPTcVjRxRPucK1yvVW+P0BxYtoja00PG3gVPKWO8d05YH0ttMA5m4YM3OQRfyH61UY2vxbhazhYdf0X5y0QU8aLRrWaGM4BBZxwcHFgwluSfCRUr1gBmTjs1plgcc5PSUx74bVe4uCZn9+fLNYY2louWl/4qEJ35lMsMaOJAp6KEjUcROn/FqMAeNsqWN5JB80VcawJXAx/Wnrsq2FIZsTIYNmbiqCySGtzAvK+9YdjJ0iiPoYpk33W9A3WNYdIK6S//QebBZ0XE0UpsA07/QcFWj1DHkDeERpptD8GbcvH9p+BICOlQQDPk/YyRQ0LZ+lyDE1zy2SDyZmUqs8fzfd2Decskj8122vi8gKMDk4lSB2GxOyVdGLHaCo9YbILNr2HwR+9T1LbxuU6Sn21+hdGiB2KHZT/dPToDubD+N4PwjJGNSFB4zTGlWsrTPx7N7KYSjhSnW0XZ5F5GGMKApo58boIbm
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 860dab8e-b1d3-42fe-47eb-08dac42c7bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 21:34:16.0312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1758
X-Proofpoint-GUID: iuoqp6xnH3l2GX2HxUrxYpLm-ZG4uTuU
X-Proofpoint-ORIG-GUID: iuoqp6xnH3l2GX2HxUrxYpLm-ZG4uTuU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_11,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110146

------=_NextPart_000_0000_01D8F5DA.AB733740
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_0001_01D8F5DA.AB733740"


------=_NextPart_001_0001_01D8F5DA.AB733740
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

Thanks for the quick responses to our questions, that is very helpful! After 
more debugging we were able to find an issue on our end that got us farther 
with the issues I mentioned at the beginning of my previous email. Now, it has 
evolved into a something else it appears. I ran with the debug kernel and I am 
getting a ton of kernel splat that seems concerning. The callstacks go all 
throughout EVL, so I was wondering if you could make anything out of the 
output.. I also see two "switched inband while holding mutex" notifications 
from EVL along with a fault notification (grouped together) at regular 
intervals while running. So I am sure the two are related.. Trying to get a 
better understanding of which direction to start looking in. Any input helps - 
thanks!

Russell

------=_NextPart_001_0001_01D8F5DA.AB733740
Content-Type: text/plain;
	name="corruption_stack.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="corruption_stack.txt"

Nov 11 21:25:07 10.243.1.49 [ 3877.744174] ------------[ cut here =
]------------
Nov 11 21:25:07 10.243.1.49 [ 3877.744180] list_del corruption, =
ffff888151798240->next is LIST_POISON1 (dead000000000100)
Nov 11 21:25:07 10.243.1.49 [ 3877.744186] EVL: RxWorker0 switching =
in-band [pid=3D16134, excpt=3D6, __list_del_entry_valid+0xc5/0x120]
Nov 11 21:25:07 10.243.1.49 [ 3877.846773] WARNING: CPU: 8 PID: 16134 at =
lib/list_debug.c:55 __list_del_entry_valid+0xc5/0x120
Nov 11 21:25:07 10.243.1.49 [ 3877.846791] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich intel_cstate pcspkr =
intel_pch_thermal input_leds sg joydev ftdi_sio i2c_smbus mfd_core mei =
acpi_ipmi ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c ast drm_vram_helper sd_mod drm_kms_helper sr_mod cdrom t10_pi =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm
Nov 11 21:25:07 10.243.1.49
Nov 11 21:25:07 10.243.1.49 [ 3877.846956]  ixgbe igb ahci libahci =
crc32c_intel libata mdio ptp i2c_algo_bit pps_core dca
Nov 11 21:25:07 10.243.1.49 [ 3877.846978] CPU: 8 PID: 16134 Comm: =
RxWorker0 Tainted: G        W         5.15.77evl-gae6080e09d9a #1
Nov 11 21:25:07 10.243.1.49 [ 3877.846986] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 11 21:25:07 10.243.1.49 [ 3877.846989] IRQ stage: Linux
Nov 11 21:25:07 10.243.1.49 [ 3877.846991] RIP: =
0010:__list_del_entry_valid+0xc5/0x120
Nov 11 21:25:07 10.243.1.49 [ 3877.847000] Code: c0 eb e0 48 89 de 48 c7 =
c7 00 0c 82 a5 e8 7c fa 8b 00 0f 0b 31 c0 eb cb 4c 89 e2 48 89 de 48 c7 =
c7 60 0c 82 a5 e8 64 fa 8b 00 <0f> 0b 31 c0 eb b3 4c 89 ea 48 89 de 48 =
c7 c7 c0 0c 82 a5 e8 4c fa
Nov 11 21:25:07 10.243.1.49 [ 3877.847005] RSP: 0018:ffff88816588fac8 =
EFLAGS: 00010082
Nov 11 21:25:07 10.243.1.49 [ 3877.847010] RAX: 0000000000000000 RBX: =
ffff888151798240 RCX: 0000000000000027
Nov 11 21:25:08 10.243.1.49 [ 3877.847014] RDX: 0000000000000027 RSI: =
dffffc0000000000 RDI: ffff88841c227b18
Nov 11 21:25:08 10.243.1.49 [ 3877.847018] RBP: ffff88816588fae0 R08: =
ffffed1083844f64 R09: ffffed1083844f64
Nov 11 21:25:08 10.243.1.49 [ 3877.847022] R10: ffff88841c227b1b R11: =
ffffed1083844f63 R12: dead000000000100
Nov 11 21:25:08 10.243.1.49 [ 3877.847026] R13: dead000000000122 R14: =
ffff888151798000 R15: ffff888148b3a000
Nov 11 21:25:08 10.243.1.49 [ 3877.847030] FS:  00007f7313fff700(0000) =
GS:ffff88841c200000(0000) knlGS:0000000000000000
Nov 11 21:25:08 10.243.1.49 [ 3877.847035] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 11 21:25:08 10.243.1.49 [ 3877.847039] CR2: 00007f4d49b09160 CR3: =
000000016e080005 CR4: 00000000003706e0
Nov 11 21:25:08 10.243.1.49 [ 3877.847043] Call Trace:
Nov 11 21:25:08 10.243.1.49 [ 3877.847045]  <TASK>
Nov 11 21:25:08 10.243.1.49 [ 3877.847059]  =
__untrack_event.part.9+0x26/0xe0
Nov 11 21:25:08 10.243.1.49 [ 3877.847096]  =
monitor_oob_ioctl+0x1356/0x1490
Nov 11 21:25:08 10.243.1.49 [ 3877.847154]  ? enter_monitor+0x160/0x160
Nov 11 21:25:08 10.243.1.49 [ 3877.847170]  ? =
__kasan_check_read+0x11/0x20
Nov 11 21:25:08 10.243.1.49 [ 3877.847187]  ? =
do_raw_spin_unlock+0x97/0x140
Nov 11 21:25:08 10.243.1.49 [ 3877.847213]  ? do_clock_tick+0x40a/0x630
Nov 11 21:25:08 10.243.1.49 [ 3877.847224]  ? =
rcu_read_lock_held_common+0x25/0x70
Nov 11 21:25:08 10.243.1.49 [ 3877.847265]  ? =
do_raw_spin_lock+0x119/0x1e0
Nov 11 21:25:08 10.243.1.49 [ 3877.847281]  ? spin_dump+0x90/0x90
Nov 11 21:25:08 10.243.1.49 [ 3877.847316]  ? =
__kasan_check_read+0x11/0x20
Nov 11 21:25:08 10.243.1.49 [ 3877.847367]  EVL_ioctl+0x81/0xf0
Nov 11 21:25:08 10.243.1.49 [ 3877.847386]  do_oob_syscall+0x699/0x6b0
Nov 11 21:25:08 10.243.1.49 [ 3877.847400]  ? =
prepare_for_signal+0x180/0x180
Nov 11 21:25:08 10.243.1.49 [ 3877.847414]  ? do_oob_irq+0x283/0x7e0
Nov 11 21:25:08 10.243.1.49 [ 3877.847420]  ? =
rcu_dynticks_eqs_enter+0xe/0x20
Nov 11 21:25:08 10.243.1.49 [ 3877.847440]  =
handle_oob_syscall+0x189/0x230
Nov 11 21:25:08 10.243.1.49 [ 3877.847455]  ? =
handle_pipelined_syscall+0x820/0x820
Nov 11 21:25:08 10.243.1.49 [ 3877.847473]  ? =
rcu_read_lock_sched_held+0x5b/0xd0
Nov 11 21:25:08 10.243.1.49 [ 3877.847494]  ? =
rcu_read_lock_any_held.part.15+0x20/0x20
Nov 11 21:25:08 10.243.1.49 [ 3877.847536]  pipeline_syscall+0xa7/0x1c0
Nov 11 21:25:08 10.243.1.49 [ 3877.847575]  =
syscall_enter_from_user_mode+0x47/0x110
Nov 11 21:25:08 10.243.1.49 [ 3877.847601]  do_syscall_64+0x15/0xb0
Nov 11 21:25:08 10.243.1.49 [ 3877.847622]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 11 21:25:08 10.243.1.49 [ 3877.847636] RIP: 0033:0x7f735de5a940
Nov 11 21:25:08 10.243.1.49 [ 3877.847648] Code: 77 ff ff bf 02 00 00 10 =
8b 44 24 0c 48 98 48 89 c6 48 8b 04 24 48 89 c2 4c 8b 54 24 38 41 b8 00 =
00 00 00 b8 9d 00 00 00 0f 05 <48> 89 44 24 30 48 8b 44 24 30 89 44 24 =
2c 8b 44 24 28 be 00 00 00
Nov 11 21:25:08 10.243.1.49 [ 3877.847658] RSP: 002b:00007f7313fef340 =
EFLAGS: 00000202 ORIG_RAX: 000000000000009d
Nov 11 21:25:08 10.243.1.49 [ 3877.847669] RAX: ffffffffffffffda RBX: =
0000000000000f26 RCX: 00007f735de5a940
Nov 11 21:25:08 10.243.1.49 [ 3877.847677] RDX: 00000000c0186d03 RSI: =
000000000000000d RDI: 0000000010000002
Nov 11 21:25:08 10.243.1.49 [ 3877.847683] RBP: 00007f7313fef520 R08: =
0000000000000000 R09: 00007ffc09389080
Nov 11 21:25:08 10.243.1.49 [ 3877.847691] R10: 00007f7313fef4f0 R11: =
0000000000000202 R12: 00007f7313fef600
Nov 11 21:25:08 10.243.1.49 [ 3877.847697] R13: 0000000000000000 R14: =
00000000022cb5bd R15: 00007f7313fef580
Nov 11 21:25:08 10.243.1.49 [ 3877.847777]  </TASK>
Nov 11 21:25:08 10.243.1.49 [ 3877.847779] irq event stamp: 889
Nov 11 21:25:08 10.243.1.49 [ 3877.847782] hardirqs last  enabled at =
(889): [<ffffffffa51330bc>] _raw_spin_unlock_irqrestore+0x4c/0x50
Nov 11 21:25:08 10.243.1.49 [ 3877.847791] hardirqs last disabled at =
(888): [<ffffffffa5132e2b>] _raw_spin_lock_irqsave+0x1b/0x60
Nov 11 21:25:08 10.243.1.49 [ 3877.847798] softirqs last  enabled at =
(286): [<ffffffffa5400403>] __do_softirq+0x403/0x57b
Nov 11 21:25:09 10.243.1.49 [ 3877.847805] softirqs last disabled at =
(275): [<ffffffffa40d261d>] irq_exit_rcu+0x7d/0x150
Nov 11 21:25:09 10.243.1.49 [ 3877.847815] ---[ end trace =
87ffbd6a737b5b80 ]---
Nov 11 21:25:09 10.243.1.49 [ 3879.476338] EVL: RxWorker0 resuming =
out-of-band [pid=3D16134, excpt=3D6, __list_del_entry_valid+0xc7/0x120]
Nov 11 21:25:09 10.243.1.49 [ 3879.509373] ------------[ cut here =
]------------
Nov 11 21:25:09 10.243.1.49 [ 3879.509377] WARNING: CPU: 8 PID: 16134 at =
kernel/evl/thread.c:580 evl_sleep_on+0x9d/0xb0
Nov 11 21:25:09 10.243.1.49 [ 3879.509391] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich intel_cstate pcspkr =
intel_pch_thermal input_leds sg joydev ftdi_sio i2c_smbus mfd_core mei =
acpi_ipmi ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c ast drm_vram_helper sd_mod drm_kms_helper sr_mod cdrom t10_pi =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm
Nov 11 21:25:09 10.243.1.49
Nov 11 21:25:09 10.243.1.49 [ 3879.509575]  ixgbe igb ahci libahci =
crc32c_intel libata mdio ptp i2c_algo_bit pps_core dca
Nov 11 21:25:09 10.243.1.49 [ 3879.509597] CPU: 8 PID: 16134 Comm: =
RxWorker0 Tainted: G        W         5.15.77evl-gae6080e09d9a #1
Nov 11 21:25:09 10.243.1.49 [ 3879.509605] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 11 21:25:09 10.243.1.49 [ 3879.509608] IRQ stage: Linux
Nov 11 21:25:09 10.243.1.49 [ 3879.509610] RIP: =
0010:evl_sleep_on+0x9d/0xb0
Nov 11 21:25:09 10.243.1.49 [ 3879.509618] Code: f8 ff ff 4c 89 e7 e8 42 =
97 e9 ff 48 89 df e8 3a 97 e9 ff ff 75 c8 9d 48 83 c4 10 5b 41 5c 41 5d =
41 5e 41 5f 5d c3 cc cc cc cc <0f> 0b eb a1 0f 1f 44 00 00 66 2e 0f 1f =
84 00 00 00 00 00 55 48 89
Nov 11 21:25:09 10.243.1.49 [ 3879.509623] RSP: 0018:ffff88816588f9a0 =
EFLAGS: 00010046
Nov 11 21:25:09 10.243.1.49 [ 3879.509628] RAX: 0000000000000000 RBX: =
ffff888148b3a000 RCX: ffffffffa43034a0
Nov 11 21:25:09 10.243.1.49 [ 3879.509633] RDX: dffffc0000000000 RSI: =
0000000000000000 RDI: ffff88816d77c798
Nov 11 21:25:09 10.243.1.49 [ 3879.509637] RBP: ffff88816588f9d8 R08: =
ffffed1029167401 R09: ffffed1029167401
Nov 11 21:25:09 10.243.1.49 [ 3879.509641] R10: ffff888148b3a003 R11: =
ffffed1029167400 R12: ffff888148b3a090
Nov 11 21:25:09 10.243.1.49 [ 3879.509644] R13: 0000000000000000 R14: =
ffffffffa6209b40 R15: ffff88815179a170
Nov 11 21:25:09 10.243.1.49 [ 3879.509648] FS:  00007f7313fff700(0000) =
GS:ffff88841c200000(0000) knlGS:0000000000000000
Nov 11 21:25:09 10.243.1.49 [ 3879.509653] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 11 21:25:09 10.243.1.49 [ 3879.509657] CR2: 00007f4d49b09160 CR3: =
000000016e080005 CR4: 00000000003706e0
Nov 11 21:25:09 10.243.1.49 [ 3879.509661] Call Trace:
Nov 11 21:25:09 10.243.1.49 [ 3879.509663]  <TASK>
Nov 11 21:25:09 10.243.1.49 [ 3879.509679]  =
evl_lock_mutex_timeout+0x7f2/0x1100
Nov 11 21:25:09 10.243.1.49 [ 3879.509709]  ? =
evl_trylock_mutex+0x1c0/0x1c0
Nov 11 21:25:09 10.243.1.49 [ 3879.509724]  ? =
__list_del_entry_valid+0xc7/0x120
Nov 11 21:25:09 10.243.1.49 [ 3879.509739]  ? =
__list_del_entry_valid+0xc5/0x120
Nov 11 21:25:09 10.243.1.49 [ 3879.509762]  =
monitor_oob_ioctl+0xf95/0x1490
Nov 11 21:25:09 10.243.1.49 [ 3879.509792]  ? enter_monitor+0x160/0x160
Nov 11 21:25:10 10.243.1.49 [ 3879.509800]  ? =
__kasan_check_read+0x11/0x20
Nov 11 21:25:10 10.243.1.49 [ 3879.509810]  ? =
do_raw_spin_unlock+0x97/0x140
Nov 11 21:25:10 10.243.1.49 [ 3879.509823]  ? do_clock_tick+0x40a/0x630
Nov 11 21:25:10 10.243.1.49 [ 3879.509830]  ? =
rcu_read_lock_held_common+0x25/0x70
Nov 11 21:25:10 10.243.1.49 [ 3879.509853]  ? =
do_raw_spin_lock+0x119/0x1e0
Nov 11 21:25:10 10.243.1.49 [ 3879.509862]  ? spin_dump+0x90/0x90
Nov 11 21:25:10 10.243.1.49 [ 3879.509879]  ? =
__kasan_check_read+0x11/0x20
Nov 11 21:25:10 10.243.1.49 [ 3879.509907]  EVL_ioctl+0x81/0xf0
Nov 11 21:25:10 10.243.1.49 [ 3879.509924]  do_oob_syscall+0x699/0x6b0
Nov 11 21:25:10 10.243.1.49 [ 3879.509937]  ? =
prepare_for_signal+0x180/0x180
Nov 11 21:25:10 10.243.1.49 [ 3879.509951]  ? do_oob_irq+0x283/0x7e0
Nov 11 21:25:10 10.243.1.49 [ 3879.509956]  ? =
rcu_dynticks_eqs_enter+0xe/0x20
Nov 11 21:25:10 10.243.1.49 [ 3879.509976]  =
handle_oob_syscall+0x189/0x230
Nov 11 21:25:10 10.243.1.49 [ 3879.509990]  ? =
handle_pipelined_syscall+0x820/0x820
Nov 11 21:25:10 10.243.1.49 [ 3879.510007]  ? =
rcu_read_lock_sched_held+0x5b/0xd0
Nov 11 21:25:10 10.243.1.49 [ 3879.510017]  ? =
rcu_read_lock_any_held.part.15+0x20/0x20
Nov 11 21:25:10 10.243.1.49 [ 3879.510038]  pipeline_syscall+0xa7/0x1c0
Nov 11 21:25:10 10.243.1.49 [ 3879.510057]  =
syscall_enter_from_user_mode+0x47/0x110
Nov 11 21:25:10 10.243.1.49 [ 3879.510070]  do_syscall_64+0x15/0xb0
Nov 11 21:25:10 10.243.1.49 [ 3879.510080]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 11 21:25:10 10.243.1.49 [ 3879.510087] RIP: 0033:0x7f735de5a940
Nov 11 21:25:10 10.243.1.49 [ 3879.510094] Code: 77 ff ff bf 02 00 00 10 =
8b 44 24 0c 48 98 48 89 c6 48 8b 04 24 48 89 c2 4c 8b 54 24 38 41 b8 00 =
00 00 00 b8 9d 00 00 00 0f 05 <48> 89 44 24 30 48 8b 44 24 30 89 44 24 =
2c 8b 44 24 28 be 00 00 00
Nov 11 21:25:10 10.243.1.49 [ 3879.510099] RSP: 002b:00007f7313fef340 =
EFLAGS: 00000202 ORIG_RAX: 000000000000009d
Nov 11 21:25:10 10.243.1.49 [ 3879.510105] RAX: ffffffffffffffda RBX: =
0000000000000f26 RCX: 00007f735de5a940
Nov 11 21:25:10 10.243.1.49 [ 3879.510108] RDX: 00000000c0186d03 RSI: =
000000000000000d RDI: 0000000010000002
Nov 11 21:25:10 10.243.1.49 [ 3879.510112] RBP: 00007f7313fef520 R08: =
0000000000000000 R09: 00007ffc09389080
Nov 11 21:25:10 10.243.1.49 [ 3879.510115] R10: 00007f7313fef4f0 R11: =
0000000000000202 R12: 00007f7313fef600
Nov 11 21:25:10 10.243.1.49 [ 3879.510119] R13: 0000000000000000 R14: =
00000000022cb5bd R15: 00007f7313fef580
Nov 11 21:25:10 10.243.1.49 [ 3879.510155]  </TASK>
Nov 11 21:25:10 10.243.1.49 [ 3879.510157] irq event stamp: 904
Nov 11 21:25:10 10.243.1.49 [ 3879.510159] hardirqs last  enabled at =
(903): [<ffffffffa41aaac2>] __up_console_sem+0x62/0x70
Nov 11 21:25:10 10.243.1.49 [ 3879.510169] hardirqs last disabled at =
(904): [<ffffffffa5115791>] handle_bug+0x81/0xa0
Nov 11 21:25:10 10.243.1.49 [ 3879.510177] softirqs last  enabled at =
(286): [<ffffffffa5400403>] __do_softirq+0x403/0x57b
Nov 11 21:25:10 10.243.1.49 [ 3879.510185] softirqs last disabled at =
(275): [<ffffffffa40d261d>] irq_exit_rcu+0x7d/0x150
Nov 11 21:25:10 10.243.1.49 [ 3879.510195] ---[ end trace =
87ffbd6a737b5b81 ]---
Nov 11 21:25:10 10.243.1.49 [ 3881.205548] ------------[ cut here =
]------------
Nov 11 21:25:10 10.243.1.49 [ 3881.224515] syscall 157 left IRQs =
disabled
Nov 11 21:25:10 10.243.1.49 [ 3881.224599] WARNING: CPU: 8 PID: 16134 at =
kernel/entry/common.c:353 syscall_exit_to_user_mode_prepare+0x37/0x270
Nov 11 21:25:11 10.243.1.49 [ 3881.277186] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich intel_cstate pcspkr =
intel_pch_thermal input_leds sg joydev ftdi_sio i2c_smbus mfd_core mei =
acpi_ipmi ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c ast drm_vram_helper sd_mod drm_kms_helper sr_mod cdrom t10_pi =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm
Nov 11 21:25:11 10.243.1.49
Nov 11 21:25:11 10.243.1.49 [ 3881.277744]  ixgbe igb ahci libahci =
crc32c_intel libata mdio ptp i2c_algo_bit pps_core dca
Nov 11 21:25:11 10.243.1.49 [ 3881.608230] CPU: 8 PID: 16134 Comm: =
RxWorker0 Tainted: G        W         5.15.77evl-gae6080e09d9a #1
Nov 11 21:25:11 10.243.1.49 [ 3881.641467] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 11 21:25:11 10.243.1.49 [ 3881.671175] IRQ stage: Linux
Nov 11 21:25:11 10.243.1.49 [ 3881.685407] RIP: =
0010:syscall_exit_to_user_mode_prepare+0x37/0x270
Nov 11 21:25:11 10.243.1.49 [ 3881.709677] Code: 41 55 41 54 49 89 fc 53 =
4c 8b 68 08 48 8b 5f 78 eb 36 e8 0c fe f2 00 85 c0 74 1c 48 63 f3 48 c7 =
c7 70 66 ca a5 e8 42 f0 ec 00 <0f> 0b fb e8 e1 a1 0d 00 e8 bc af fd ff =
41 f6 c5 76 75 3a 5b 41 5c
Nov 11 21:25:11 10.243.1.49 [ 3881.778001] RSP: 0018:ffff88816588ff00 =
EFLAGS: 00010282
Nov 11 21:25:11 10.243.1.49 [ 3881.800036] RAX: 0000000000000000 RBX: =
000000000000009d RCX: 0000000000000027
Nov 11 21:25:11 10.243.1.49 [ 3881.827850] RDX: 0000000000000027 RSI: =
dffffc0000000000 RDI: ffff88841c227b18
Nov 11 21:25:11 10.243.1.49 [ 3881.856667] RBP: ffff88816588ff18 R08: =
ffffed1083844f64 R09: ffffed1083844f64
Nov 11 21:25:11 10.243.1.49 [ 3881.884352] R10: ffff88841c227b1b R11: =
ffffed1083844f63 R12: ffff88816588ff58
Nov 11 21:25:11 10.243.1.49 [ 3881.912059] R13: 0000000000000010 R14: =
0000000000000000 R15: 0000000000000000
Nov 11 21:25:11 10.243.1.49 [ 3881.939817] FS:  00007f7313fff700(0000) =
GS:ffff88841c200000(0000) knlGS:0000000000000000
Nov 11 21:25:11 10.243.1.49 [ 3881.970540] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 11 21:25:11 10.243.1.49 [ 3881.994183] CR2: 00007f4d49b09160 CR3: =
000000016e080005 CR4: 00000000003706e0
Nov 11 21:25:11 10.243.1.49 [ 3882.022110] Call Trace:
Nov 11 21:25:11 10.243.1.49 [ 3882.035924]  <TASK>
Nov 11 21:25:11 10.243.1.49 [ 3882.048991]  =
syscall_exit_to_user_mode+0xd/0x90
Nov 11 21:25:11 10.243.1.49 [ 3882.069055]  do_syscall_64+0x50/0xb0
Nov 11 21:25:11 10.243.1.49 [ 3882.086281]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 11 21:25:11 10.243.1.49 [ 3882.108130] RIP: 0033:0x7f735de5a940
Nov 11 21:25:11 10.243.1.49 [ 3882.125201] Code: 77 ff ff bf 02 00 00 10 =
8b 44 24 0c 48 98 48 89 c6 48 8b 04 24 48 89 c2 4c 8b 54 24 38 41 b8 00 =
00 00 00 b8 9d 00 00 00 0f 05 <48> 89 44 24 30 48 8b 44 24 30 89 44 24 =
2c 8b 44 24 28 be 00 00 00
Nov 11 21:25:11 10.243.1.49 [ 3882.194404] RSP: 002b:00007f7313fef340 =
EFLAGS: 00000202 ORIG_RAX: 000000000000009d
Nov 11 21:25:11 10.243.1.49 [ 3882.223637] RAX: 0000000000000000 RBX: =
0000000000000f26 RCX: 00007f735de5a940
Nov 11 21:25:11 10.243.1.49 [ 3882.252758] RDX: 00000000c0186d03 RSI: =
000000000000000d RDI: 0000000010000002
Nov 11 21:25:11 10.243.1.49 [ 3882.280720] RBP: 00007f7313fef520 R08: =
0000000000000000 R09: 00007ffc09389080
Nov 11 21:25:11 10.243.1.49 [ 3882.308846] R10: 00007f7313fef4f0 R11: =
0000000000000202 R12: 00007f7313fef600
Nov 11 21:25:11 10.243.1.49 [ 3882.336822] R13: 0000000000000000 R14: =
00000000022cb5bd R15: 00007f7313fef580
Nov 11 21:25:11 10.243.1.49 [ 3882.364830]  </TASK>
Nov 11 21:25:11 10.243.1.49 [ 3882.377882] irq event stamp: 1573
Nov 11 21:25:11 10.243.1.49 [ 3882.394225] hardirqs last  enabled at =
(1581): [<ffffffffa41aaac2>] __up_console_sem+0x62/0x70
Nov 11 21:25:12 10.243.1.49 [ 3882.426450] hardirqs last disabled at =
(1588): [<ffffffffa41aaaa7>] __up_console_sem+0x47/0x70
Nov 11 21:25:12 10.243.1.49 [ 3882.458614] softirqs last  enabled at =
(286): [<ffffffffa5400403>] __do_softirq+0x403/0x57b
Nov 11 21:25:12 10.243.1.49 [ 3882.490022] softirqs last disabled at =
(275): [<ffffffffa40d261d>] irq_exit_rcu+0x7d/0x150
Nov 11 21:25:12 10.243.1.49 [ 3882.521175] ---[ end trace =
87ffbd6a737b5b82 ]---
Nov 11 21:25:31 10.243.1.49 [ 3902.026568] ------------[ cut here =
]------------
Nov 11 21:25:31 10.243.1.49 [ 3902.026575] list_del corruption, =
ffff888151798240->next is LIST_POISON1 (dead000000000100)
Nov 11 21:25:31 10.243.1.49 [ 3902.026585] EVL: RxWorker1 switching =
in-band [pid=3D16135, excpt=3D6, __list_del_entry_valid+0xc5/0x120]
Nov 11 21:25:31 10.243.1.49 [ 3902.131088] WARNING: CPU: 9 PID: 16135 at =
lib/list_debug.c:55 __list_del_entry_valid+0xc5/0x120
Nov 11 21:25:31 10.243.1.49 [ 3902.131111] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich intel_cstate pcspkr =
intel_pch_thermal input_leds sg joydev ftdi_sio i2c_smbus mfd_core mei =
acpi_ipmi ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c ast drm_vram_helper sd_mod drm_kms_helper sr_mod cdrom t10_pi =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm
Nov 11 21:25:31 10.243.1.49
Nov 11 21:25:32 10.243.1.49 [ 3902.131434]  ixgbe igb ahci libahci =
crc32c_intel libata mdio ptp i2c_algo_bit pps_core dca
Nov 11 21:25:32 10.243.1.49 [ 3902.131478] CPU: 9 PID: 16135 Comm: =
RxWorker1 Tainted: G        W         5.15.77evl-gae6080e09d9a #1
Nov 11 21:25:32 10.243.1.49 [ 3902.131491] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 11 21:25:32 10.243.1.49 [ 3902.131496] IRQ stage: Linux
Nov 11 21:25:32 10.243.1.49 [ 3902.131501] RIP: =
0010:__list_del_entry_valid+0xc5/0x120
Nov 11 21:25:32 10.243.1.49 [ 3902.131516] Code: c0 eb e0 48 89 de 48 c7 =
c7 00 0c 82 a5 e8 7c fa 8b 00 0f 0b 31 c0 eb cb 4c 89 e2 48 89 de 48 c7 =
c7 60 0c 82 a5 e8 64 fa 8b 00 <0f> 0b 31 c0 eb b3 4c 89 ea 48 89 de 48 =
c7 c7 c0 0c 82 a5 e8 4c fa
Nov 11 21:25:32 10.243.1.49 [ 3902.131526] RSP: 0018:ffff88815ef47ac8 =
EFLAGS: 00010082
Nov 11 21:25:32 10.243.1.49 [ 3902.131535] RAX: 0000000000000000 RBX: =
ffff888151798240 RCX: 0000000000000027
Nov 11 21:25:32 10.243.1.49 [ 3902.131543] RDX: 0000000000000027 RSI: =
dffffc0000000000 RDI: ffff88841c2a7b18
Nov 11 21:25:32 10.243.1.49 [ 3902.131551] RBP: ffff88815ef47ae0 R08: =
ffffed1083854f64 R09: ffffed1083854f64
Nov 11 21:25:32 10.243.1.49 [ 3902.131559] R10: ffff88841c2a7b1b R11: =
ffffed1083854f63 R12: dead000000000100
Nov 11 21:25:32 10.243.1.49 [ 3902.131567] R13: dead000000000122 R14: =
ffff888151798000 R15: ffff888145380000
Nov 11 21:25:32 10.243.1.49 [ 3902.131576] FS:  00007f7312ffe700(0000) =
GS:ffff88841c280000(0000) knlGS:0000000000000000
Nov 11 21:25:32 10.243.1.49 [ 3902.131586] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 11 21:25:32 10.243.1.49 [ 3902.131594] CR2: 0000000000000000 CR3: =
000000016e080005 CR4: 00000000003706e0
Nov 11 21:25:32 10.243.1.49 [ 3902.131601] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 11 21:25:32 10.243.1.49 [ 3902.131608] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 11 21:25:32 10.243.1.49 [ 3902.131615] Call Trace:
Nov 11 21:25:32 10.243.1.49 [ 3902.131618]  <TASK>
Nov 11 21:25:32 10.243.1.49 [ 3902.131637]  =
__untrack_event.part.9+0x26/0xe0
Nov 11 21:25:32 10.243.1.49 [ 3902.131675]  =
monitor_oob_ioctl+0x1356/0x1490
Nov 11 21:25:32 10.243.1.49 [ 3902.131736]  ? enter_monitor+0x160/0x160
Nov 11 21:25:32 10.243.1.49 [ 3902.131774]  ? =
__kasan_check_read+0x11/0x20
Nov 11 21:25:32 10.243.1.49 [ 3902.131795]  ? =
rcu_read_lock_held_common+0x25/0x70
Nov 11 21:25:32 10.243.1.49 [ 3902.131843]  ? =
do_raw_spin_lock+0x119/0x1e0
Nov 11 21:25:32 10.243.1.49 [ 3902.131861]  ? spin_dump+0x90/0x90
Nov 11 21:25:32 10.243.1.49 [ 3902.131899]  ? =
__kasan_check_read+0x11/0x20
Nov 11 21:25:32 10.243.1.49 [ 3902.131960]  EVL_ioctl+0x81/0xf0
Nov 11 21:25:32 10.243.1.49 [ 3902.131996]  do_oob_syscall+0x699/0x6b0
Nov 11 21:25:32 10.243.1.49 [ 3902.132025]  ? =
prepare_for_signal+0x180/0x180
Nov 11 21:25:33 10.243.1.49 [ 3902.132054]  ? do_oob_irq+0x283/0x7e0
Nov 11 21:25:33 10.243.1.49 [ 3902.132097]  =
handle_oob_syscall+0x189/0x230
Nov 11 21:25:33 10.243.1.49 [ 3902.132126]  ? =
handle_pipelined_syscall+0x820/0x820
Nov 11 21:25:33 10.243.1.49 [ 3902.132206]  pipeline_syscall+0xa7/0x1c0
Nov 11 21:25:33 10.243.1.49 [ 3902.132245]  =
syscall_enter_from_user_mode+0x47/0x110
Nov 11 21:25:33 10.243.1.49 [ 3902.132272]  do_syscall_64+0x15/0xb0
Nov 11 21:25:33 10.243.1.49 [ 3902.132292]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 11 21:25:33 10.243.1.49 [ 3902.132305] RIP: 0033:0x7f735de5a940
Nov 11 21:25:33 10.243.1.49 [ 3902.132316] Code: 77 ff ff bf 02 00 00 10 =
8b 44 24 0c 48 98 48 89 c6 48 8b 04 24 48 89 c2 4c 8b 54 24 38 41 b8 00 =
00 00 00 b8 9d 00 00 00 0f 05 <48> 89 44 24 30 48 8b 44 24 30 89 44 24 =
2c 8b 44 24 28 be 00 00 00
Nov 11 21:25:33 10.243.1.49 [ 3902.132326] RSP: 002b:00007f7312fee340 =
EFLAGS: 00000202 ORIG_RAX: 000000000000009d
Nov 11 21:25:33 10.243.1.49 [ 3902.132337] RAX: ffffffffffffffda RBX: =
0000000000000f3e RCX: 00007f735de5a940
Nov 11 21:25:33 10.243.1.49 [ 3902.132345] RDX: 00000000c0186d03 RSI: =
000000000000000d RDI: 0000000010000002
Nov 11 21:25:33 10.243.1.49 [ 3902.132352] RBP: 00007f7312fee520 R08: =
0000000000000000 R09: 00007ffc09389080
Nov 11 21:25:33 10.243.1.49 [ 3902.132359] R10: 00007f7312fee4f0 R11: =
0000000000000202 R12: 00007f7312fee600
Nov 11 21:25:33 10.243.1.49 [ 3902.132367] R13: 0000000000000000 R14: =
000000001302529e R15: 00007f7312fee580
Nov 11 21:25:33 10.243.1.49 [ 3902.132448]  </TASK>
Nov 11 21:25:33 10.243.1.49 [ 3902.132452] irq event stamp: 673
Nov 11 21:25:33 10.243.1.49 [ 3902.132455] hardirqs last  enabled at =
(673): [<ffffffffa51330bc>] _raw_spin_unlock_irqrestore+0x4c/0x50
Nov 11 21:25:33 10.243.1.49 [ 3902.132470] hardirqs last disabled at =
(672): [<ffffffffa5132e2b>] _raw_spin_lock_irqsave+0x1b/0x60
Nov 11 21:25:33 10.243.1.49 [ 3902.132484] softirqs last  enabled at =
(32): [<ffffffffa5400403>] __do_softirq+0x403/0x57b
Nov 11 21:25:33 10.243.1.49 [ 3902.132499] softirqs last disabled at =
(25): [<ffffffffa40d261d>] irq_exit_rcu+0x7d/0x150
Nov 11 21:25:33 10.243.1.49 [ 3902.132515] ---[ end trace =
87ffbd6a737b5b83 ]---
Nov 11 21:25:33 10.243.1.49 [ 3904.104311] EVL: RxWorker1 resuming =
out-of-band [pid=3D16135, excpt=3D6, __list_del_entry_valid+0xc7/0x120]
Nov 11 21:25:33 10.243.1.49 [ 3904.141268] ------------[ cut here =
]------------
Nov 11 21:25:33 10.243.1.49 [ 3904.159499] syscall 157 left IRQs =
disabled
Nov 11 21:25:33 10.243.1.49 [ 3904.159561] WARNING: CPU: 9 PID: 16135 at =
kernel/entry/common.c:353 syscall_exit_to_user_mode_prepare+0x37/0x270
Nov 11 21:25:34 10.243.1.49 [ 3904.211325] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich intel_cstate pcspkr =
intel_pch_thermal input_leds sg joydev ftdi_sio i2c_smbus mfd_core mei =
acpi_ipmi ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c ast drm_vram_helper sd_mod drm_kms_helper sr_mod cdrom t10_pi =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm
Nov 11 21:25:34 10.243.1.49
Nov 11 21:25:34 10.243.1.49 [ 3904.211877]  ixgbe igb ahci libahci =
crc32c_intel libata mdio ptp i2c_algo_bit pps_core dca
Nov 11 21:25:34 10.243.1.49 [ 3904.545198] CPU: 9 PID: 16135 Comm: =
RxWorker1 Tainted: G        W         5.15.77evl-gae6080e09d9a #1
Nov 11 21:25:34 10.243.1.49 [ 3904.578704] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 11 21:25:34 10.243.1.49 [ 3904.608607] IRQ stage: Linux
Nov 11 21:25:34 10.243.1.49 [ 3904.623117] RIP: =
0010:syscall_exit_to_user_mode_prepare+0x37/0x270
Nov 11 21:25:34 10.243.1.49 [ 3904.648593] Code: 41 55 41 54 49 89 fc 53 =
4c 8b 68 08 48 8b 5f 78 eb 36 e8 0c fe f2 00 85 c0 74 1c 48 63 f3 48 c7 =
c7 70 66 ca a5 e8 42 f0 ec 00 <0f> 0b fb e8 e1 a1 0d 00 e8 bc af fd ff =
41 f6 c5 76 75 3a 5b 41 5c
Nov 11 21:25:34 10.243.1.49 [ 3904.717388] RSP: 0018:ffff88815ef47f00 =
EFLAGS: 00010282
Nov 11 21:25:34 10.243.1.49 [ 3904.739421] RAX: 0000000000000000 RBX: =
000000000000009d RCX: 0000000000000027
Nov 11 21:25:34 10.243.1.49 [ 3904.767285] RDX: 0000000000000027 RSI: =
dffffc0000000000 RDI: ffff88841c2a7b18
Nov 11 21:25:34 10.243.1.49 [ 3904.795170] RBP: ffff88815ef47f18 R08: =
ffffed1083854f64 R09: ffffed1083854f64
Nov 11 21:25:34 10.243.1.49 [ 3904.823094] R10: ffff88841c2a7b1b R11: =
ffffed1083854f63 R12: ffff88815ef47f58
Nov 11 21:25:34 10.243.1.49 [ 3904.851037] R13: 0000000000000010 R14: =
0000000000000000 R15: 0000000000000000
Nov 11 21:25:34 10.243.1.49 [ 3904.879042] FS:  00007f7312ffe700(0000) =
GS:ffff88841c280000(0000) knlGS:0000000000000000
Nov 11 21:25:34 10.243.1.49 [ 3904.909991] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 11 21:25:34 10.243.1.49 [ 3904.933894] CR2: 0000000000000000 CR3: =
000000016e080005 CR4: 00000000003706e0
Nov 11 21:25:34 10.243.1.49 [ 3904.962065] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 11 21:25:34 10.243.1.49 [ 3904.990210] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 11 21:25:34 10.243.1.49 [ 3905.018329] Call Trace:
Nov 11 21:25:34 10.243.1.49 [ 3905.032333]  <TASK>
Nov 11 21:25:34 10.243.1.49 [ 3905.046205]  =
syscall_exit_to_user_mode+0xd/0x90
Nov 11 21:25:34 10.243.1.49 [ 3905.066327]  do_syscall_64+0x50/0xb0
Nov 11 21:25:34 10.243.1.49 [ 3905.083393]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 11 21:25:34 10.243.1.49 [ 3905.104867] RIP: 0033:0x7f735de5a940
Nov 11 21:25:34 10.243.1.49 [ 3905.121847] Code: 77 ff ff bf 02 00 00 10 =
8b 44 24 0c 48 98 48 89 c6 48 8b 04 24 48 89 c2 4c 8b 54 24 38 41 b8 00 =
00 00 00 b8 9d 00 00 00 0f 05 <48> 89 44 24 30 48 8b 44 24 30 89 44 24 =
2c 8b 44 24 28 be 00 00 00
Nov 11 21:25:34 10.243.1.49 [ 3905.191272] RSP: 002b:00007f7312fee340 =
EFLAGS: 00000202 ORIG_RAX: 000000000000009d
Nov 11 21:25:34 10.243.1.49 [ 3905.220715] RAX: 0000000000000000 RBX: =
0000000000000f3e RCX: 00007f735de5a940
Nov 11 21:25:34 10.243.1.49 [ 3905.249800] RDX: 00000000c0186d03 RSI: =
000000000000000d RDI: 0000000010000002
Nov 11 21:25:34 10.243.1.49 [ 3905.277936] RBP: 00007f7312fee520 R08: =
0000000000000000 R09: 00007ffc09389080
Nov 11 21:25:34 10.243.1.49 [ 3905.306096] R10: 00007f7312fee4f0 R11: =
0000000000000202 R12: 00007f7312fee600
Nov 11 21:25:34 10.243.1.49 [ 3905.334148] R13: 0000000000000000 R14: =
000000001302529e R15: 00007f7312fee580
Nov 11 21:25:34 10.243.1.49 [ 3905.362279]  </TASK>
Nov 11 21:25:34 10.243.1.49 [ 3905.375352] irq event stamp: 1379
Nov 11 21:25:34 10.243.1.49 [ 3905.391835] hardirqs last  enabled at =
(1387): [<ffffffffa41aaac2>] __up_console_sem+0x62/0x70
Nov 11 21:25:35 10.243.1.49 [ 3905.424075] hardirqs last disabled at =
(1394): [<ffffffffa41aaaa7>] __up_console_sem+0x47/0x70
Nov 11 21:25:35 10.243.1.49 [ 3905.456192] softirqs last  enabled at =
(684): [<ffffffffa5400403>] __do_softirq+0x403/0x57b
Nov 11 21:25:35 10.243.1.49 [ 3905.487432] softirqs last disabled at =
(677): [<ffffffffa40d261d>] irq_exit_rcu+0x7d/0x150
Nov 11 21:25:35 10.243.1.49 [ 3905.518421] ---[ end trace =
87ffbd6a737b5b84 ]---
Nov 11 21:25:38 10.243.1.49 [ 3908.717920] ------------[ cut here =
]------------
Nov 11 21:25:38 10.243.1.49 [ 3908.717927] list_del corruption, =
ffff888151798240->next is LIST_POISON1 (dead000000000100)
Nov 11 21:25:38 10.243.1.49 [ 3908.717938] EVL: RxWorker1 switching =
in-band [pid=3D16135, excpt=3D6, __list_del_entry_valid+0xc5/0x120]
Nov 11 21:25:38 10.243.1.49 [ 3908.820609] WARNING: CPU: 9 PID: 16135 at =
lib/list_debug.c:55 __list_del_entry_valid+0xc5/0x120
Nov 11 21:25:38 10.243.1.49 [ 3908.820633] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich intel_cstate pcspkr =
intel_pch_thermal input_leds sg joydev ftdi_sio i2c_smbus mfd_core mei =
acpi_ipmi ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c ast drm_vram_helper sd_mod drm_kms_helper sr_mod cdrom t10_pi =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm
Nov 11 21:25:38 10.243.1.49
Nov 11 21:25:38 10.243.1.49 [ 3908.820955]  ixgbe igb ahci libahci =
crc32c_intel libata mdio ptp i2c_algo_bit pps_core dca
Nov 11 21:25:38 10.243.1.49 [ 3908.820998] CPU: 9 PID: 16135 Comm: =
RxWorker1 Tainted: G        W         5.15.77evl-gae6080e09d9a #1
Nov 11 21:25:38 10.243.1.49 [ 3908.821011] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 11 21:25:38 10.243.1.49 [ 3908.821016] IRQ stage: Linux
Nov 11 21:25:38 10.243.1.49 [ 3908.821021] RIP: =
0010:__list_del_entry_valid+0xc5/0x120
Nov 11 21:25:38 10.243.1.49 [ 3908.821036] Code: c0 eb e0 48 89 de 48 c7 =
c7 00 0c 82 a5 e8 7c fa 8b 00 0f 0b 31 c0 eb cb 4c 89 e2 48 89 de 48 c7 =
c7 60 0c 82 a5 e8 64 fa 8b 00 <0f> 0b 31 c0 eb b3 4c 89 ea 48 89 de 48 =
c7 c7 c0 0c 82 a5 e8 4c fa
Nov 11 21:25:39 10.243.1.49 [ 3908.821046] RSP: 0018:ffff88815ef47ac8 =
EFLAGS: 00010082
Nov 11 21:25:39 10.243.1.49 [ 3908.821056] RAX: 0000000000000000 RBX: =
ffff888151798240 RCX: 0000000000000027
Nov 11 21:25:39 10.243.1.49 [ 3908.821063] RDX: 0000000000000027 RSI: =
dffffc0000000000 RDI: ffff88841c2a7b18
Nov 11 21:25:39 10.243.1.49 [ 3908.821071] RBP: ffff88815ef47ae0 R08: =
ffffed1083854f64 R09: ffffed1083854f64
Nov 11 21:25:39 10.243.1.49 [ 3908.821080] R10: ffff88841c2a7b1b R11: =
ffffed1083854f63 R12: dead000000000100
Nov 11 21:25:39 10.243.1.49 [ 3908.821088] R13: dead000000000122 R14: =
ffff888151798000 R15: ffff888145380000
Nov 11 21:25:39 10.243.1.49 [ 3908.821096] FS:  00007f7312ffe700(0000) =
GS:ffff88841c280000(0000) knlGS:0000000000000000
Nov 11 21:25:39 10.243.1.49 [ 3908.821106] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 11 21:25:39 10.243.1.49 [ 3908.821115] CR2: 0000000000000000 CR3: =
000000016e080005 CR4: 00000000003706e0
Nov 11 21:25:39 10.243.1.49 [ 3908.821122] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 11 21:25:39 10.243.1.49 [ 3908.821128] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 11 21:25:39 10.243.1.49 [ 3908.821135] Call Trace:
Nov 11 21:25:39 10.243.1.49 [ 3908.821139]  <TASK>
Nov 11 21:25:39 10.243.1.49 [ 3908.821158]  =
__untrack_event.part.9+0x26/0xe0
Nov 11 21:25:39 10.243.1.49 [ 3908.821196]  =
monitor_oob_ioctl+0x1356/0x1490
Nov 11 21:25:39 10.243.1.49 [ 3908.821256]  ? enter_monitor+0x160/0x160
Nov 11 21:25:39 10.243.1.49 [ 3908.821277]  ? =
handle_irq_pipelined_finish+0xbe/0x240
Nov 11 21:25:39 10.243.1.49 [ 3908.821351]  ? =
do_raw_spin_lock+0x119/0x1e0
Nov 11 21:25:39 10.243.1.49 [ 3908.821369]  ? spin_dump+0x90/0x90
Nov 11 21:25:39 10.243.1.49 [ 3908.821407]  ? =
__kasan_check_read+0x11/0x20
Nov 11 21:25:39 10.243.1.49 [ 3908.821471]  EVL_ioctl+0x81/0xf0
Nov 11 21:25:39 10.243.1.49 [ 3908.821506]  do_oob_syscall+0x699/0x6b0
Nov 11 21:25:39 10.243.1.49 [ 3908.821536]  ? =
prepare_for_signal+0x180/0x180
Nov 11 21:25:39 10.243.1.49 [ 3908.821565]  ? do_oob_irq+0x283/0x7e0
Nov 11 21:25:39 10.243.1.49 [ 3908.821607]  =
handle_oob_syscall+0x189/0x230
Nov 11 21:25:39 10.243.1.49 [ 3908.821637]  ? =
handle_pipelined_syscall+0x820/0x820
Nov 11 21:25:39 10.243.1.49 [ 3908.821673]  ? =
rcu_read_lock_sched_held+0x5b/0xd0
Nov 11 21:25:39 10.243.1.49 [ 3908.821695]  ? =
rcu_read_lock_any_held.part.15+0x20/0x20
Nov 11 21:25:39 10.243.1.49 [ 3908.821738]  pipeline_syscall+0xa7/0x1c0
Nov 11 21:25:39 10.243.1.49 [ 3908.821777]  =
syscall_enter_from_user_mode+0x47/0x110
Nov 11 21:25:39 10.243.1.49 [ 3908.821804]  do_syscall_64+0x15/0xb0
Nov 11 21:25:39 10.243.1.49 [ 3908.821824]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 11 21:25:39 10.243.1.49 [ 3908.821838] RIP: 0033:0x7f735de5a940
Nov 11 21:25:39 10.243.1.49 [ 3908.821849] Code: 77 ff ff bf 02 00 00 10 =
8b 44 24 0c 48 98 48 89 c6 48 8b 04 24 48 89 c2 4c 8b 54 24 38 41 b8 00 =
00 00 00 b8 9d 00 00 00 0f 05 <48> 89 44 24 30 48 8b 44 24 30 89 44 24 =
2c 8b 44 24 28 be 00 00 00
Nov 11 21:25:40 10.243.1.49 [ 3908.821858] RSP: 002b:00007f7312fee340 =
EFLAGS: 00000202 ORIG_RAX: 000000000000009d
Nov 11 21:25:40 10.243.1.49 [ 3908.821869] RAX: ffffffffffffffda RBX: =
0000000000000f45 RCX: 00007f735de5a940
Nov 11 21:25:40 10.243.1.49 [ 3908.821877] RDX: 00000000c0186d03 RSI: =
000000000000000d RDI: 0000000010000002
Nov 11 21:25:40 10.243.1.49 [ 3908.821884] RBP: 00007f7312fee520 R08: =
0000000000000000 R09: 00007ffc09389080
Nov 11 21:25:40 10.243.1.49 [ 3908.821891] R10: 00007f7312fee4f0 R11: =
0000000000000202 R12: 00007f7312fee600
Nov 11 21:25:40 10.243.1.49 [ 3908.821899] R13: 0000000000000000 R14: =
00000000009cca93 R15: 00007f7312fee580
Nov 11 21:25:40 10.243.1.49 [ 3908.821980]  </TASK>
Nov 11 21:25:40 10.243.1.49 [ 3908.821983] irq event stamp: 1475
Nov 11 21:25:40 10.243.1.49 [ 3908.821987] hardirqs last  enabled at =
(1475): [<ffffffffa51330bc>] _raw_spin_unlock_irqrestore+0x4c/0x50
Nov 11 21:25:40 10.243.1.49 [ 3908.822002] hardirqs last disabled at =
(1474): [<ffffffffa5132e2b>] _raw_spin_lock_irqsave+0x1b/0x60
Nov 11 21:25:40 10.243.1.49 [ 3908.822016] softirqs last  enabled at =
(684): [<ffffffffa5400403>] __do_softirq+0x403/0x57b
Nov 11 21:25:40 10.243.1.49 [ 3908.822031] softirqs last disabled at =
(677): [<ffffffffa40d261d>] irq_exit_rcu+0x7d/0x150
Nov 11 21:25:40 10.243.1.49 [ 3908.822047] ---[ end trace =
87ffbd6a737b5b85 ]---
Nov 11 21:25:40 10.243.1.49 [ 3910.811569] EVL: RxWorker1 resuming =
out-of-band [pid=3D16135, excpt=3D6, __list_del_entry_valid+0xc7/0x120]
Nov 11 21:25:40 10.243.1.49 [ 3910.848547] ------------[ cut here =
]------------
Nov 11 21:25:40 10.243.1.49 [ 3910.866790] syscall 157 left IRQs =
disabled
Nov 11 21:25:40 10.243.1.49 [ 3910.866843] WARNING: CPU: 9 PID: 16135 at =
kernel/entry/common.c:353 syscall_exit_to_user_mode_prepare+0x37/0x270
Nov 11 21:25:40 10.243.1.49 [ 3910.918617] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich intel_cstate pcspkr =
intel_pch_thermal input_leds sg joydev ftdi_sio i2c_smbus mfd_core mei =
acpi_ipmi ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c ast drm_vram_helper sd_mod drm_kms_helper sr_mod cdrom t10_pi =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm
Nov 11 21:25:40 10.243.1.49
Nov 11 21:25:40 10.243.1.49 [ 3910.919123]  ixgbe igb ahci libahci =
crc32c_intel libata mdio ptp i2c_algo_bit pps_core dca
Nov 11 21:25:40 10.243.1.49 [ 3911.252660] CPU: 9 PID: 16135 Comm: =
RxWorker1 Tainted: G        W         5.15.77evl-gae6080e09d9a #1
Nov 11 21:25:40 10.243.1.49 [ 3911.286188] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 11 21:25:40 10.243.1.49 [ 3911.316122] IRQ stage: Linux
Nov 11 21:25:40 10.243.1.49 [ 3911.330643] RIP: =
0010:syscall_exit_to_user_mode_prepare+0x37/0x270
Nov 11 21:25:40 10.243.1.49 [ 3911.356120] Code: 41 55 41 54 49 89 fc 53 =
4c 8b 68 08 48 8b 5f 78 eb 36 e8 0c fe f2 00 85 c0 74 1c 48 63 f3 48 c7 =
c7 70 66 ca a5 e8 42 f0 ec 00 <0f> 0b fb e8 e1 a1 0d 00 e8 bc af fd ff =
41 f6 c5 76 75 3a 5b 41 5c
Nov 11 21:25:40 10.243.1.49 [ 3911.424947] RSP: 0018:ffff88815ef47f00 =
EFLAGS: 00010282
Nov 11 21:25:41 10.243.1.49 [ 3911.446986] RAX: 0000000000000000 RBX: =
000000000000009d RCX: 0000000000000027
Nov 11 21:25:41 10.243.1.49 [ 3911.474887] RDX: 0000000000000027 RSI: =
dffffc0000000000 RDI: ffff88841c2a7b18
Nov 11 21:25:41 10.243.1.49 [ 3911.502796] RBP: ffff88815ef47f18 R08: =
ffffed1083854f64 R09: ffffed1083854f64
Nov 11 21:25:41 10.243.1.49 [ 3911.530745] R10: ffff88841c2a7b1b R11: =
ffffed1083854f63 R12: ffff88815ef47f58
Nov 11 21:25:41 10.243.1.49 [ 3911.558728] R13: 0000000000000010 R14: =
0000000000000000 R15: 0000000000000000
Nov 11 21:25:41 10.243.1.49 [ 3911.586747] FS:  00007f7312ffe700(0000) =
GS:ffff88841c280000(0000) knlGS:0000000000000000
Nov 11 21:25:41 10.243.1.49 [ 3911.617694] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 11 21:25:41 10.243.1.49 [ 3911.641647] CR2: 0000000000000000 CR3: =
000000016e080005 CR4: 00000000003706e0
Nov 11 21:25:41 10.243.1.49 [ 3911.669831] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 11 21:25:41 10.243.1.49 [ 3911.698009] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 11 21:25:41 10.243.1.49 [ 3911.726180] Call Trace:
Nov 11 21:25:41 10.243.1.49 [ 3911.740157]  <TASK>
Nov 11 21:25:41 10.243.1.49 [ 3911.754393]  =
syscall_exit_to_user_mode+0xd/0x90
Nov 11 21:25:41 10.243.1.49 [ 3911.774522]  do_syscall_64+0x50/0xb0
Nov 11 21:25:41 10.243.1.49 [ 3911.791628]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 11 21:25:41 10.243.1.49 [ 3911.813111] RIP: 0033:0x7f735de5a940
Nov 11 21:25:41 10.243.1.49 [ 3911.830102] Code: 77 ff ff bf 02 00 00 10 =
8b 44 24 0c 48 98 48 89 c6 48 8b 04 24 48 89 c2 4c 8b 54 24 38 41 b8 00 =
00 00 00 b8 9d 00 00 00 0f 05 <48> 89 44 24 30 48 8b 44 24 30 89 44 24 =
2c 8b 44 24 28 be 00 00 00
Nov 11 21:25:41 10.243.1.49 [ 3911.899551] RSP: 002b:00007f7312fee340 =
EFLAGS: 00000202 ORIG_RAX: 000000000000009d
Nov 11 21:25:41 10.243.1.49 [ 3911.929006] RAX: 0000000000000000 RBX: =
0000000000000f45 RCX: 00007f735de5a940
Nov 11 21:25:41 10.243.1.49 [ 3911.958507] RDX: 00000000c0186d03 RSI: =
000000000000000d RDI: 0000000010000002
Nov 11 21:25:41 10.243.1.49 [ 3911.986639] RBP: 00007f7312fee520 R08: =
0000000000000000 R09: 00007ffc09389080
Nov 11 21:25:41 10.243.1.49 [ 3912.014819] R10: 00007f7312fee4f0 R11: =
0000000000000202 R12: 00007f7312fee600
Nov 11 21:25:41 10.243.1.49 [ 3912.042905] R13: 0000000000000000 R14: =
00000000009cca93 R15: 00007f7312fee580
Nov 11 21:25:41 10.243.1.49 [ 3912.071017]  </TASK>
Nov 11 21:25:41 10.243.1.49 [ 3912.084096] irq event stamp: 2193
Nov 11 21:25:41 10.243.1.49 [ 3912.100606] hardirqs last  enabled at =
(2201): [<ffffffffa41aaac2>] __up_console_sem+0x62/0x70
Nov 11 21:25:41 10.243.1.49 [ 3912.132860] hardirqs last disabled at =
(2208): [<ffffffffa41aaaa7>] __up_console_sem+0x47/0x70
Nov 11 21:25:41 10.243.1.49 [ 3912.164996] softirqs last  enabled at =
(1488): [<ffffffffa5400403>] __do_softirq+0x403/0x57b
Nov 11 21:25:41 10.243.1.49 [ 3912.196532] softirqs last disabled at =
(1479): [<ffffffffa40d261d>] irq_exit_rcu+0x7d/0x150
Nov 11 21:25:41 10.243.1.49 [ 3912.227804] ---[ end trace =
87ffbd6a737b5b86 ]---
Nov 11 21:25:47 10.243.1.49 [ 3917.682604] ------------[ cut here =
]------------
Nov 11 21:25:47 10.243.1.49 [ 3917.682611] list_del corruption, =
ffff888151798240->next is LIST_POISON1 (dead000000000100)
Nov 11 21:25:47 10.243.1.49 [ 3917.682622] EVL: RxWorker0 switching =
in-band [pid=3D16134, excpt=3D6, __list_del_entry_valid+0xc5/0x120]
Nov 11 21:25:47 10.243.1.49 [ 3917.768071] WARNING: CPU: 8 PID: 16134 at =
lib/list_debug.c:55 __list_del_entry_valid+0xc5/0x120
Nov 11 21:25:47 10.243.1.49 [ 3917.768086] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich intel_cstate pcspkr =
intel_pch_thermal input_leds sg joydev ftdi_sio i2c_smbus mfd_core mei =
acpi_ipmi ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c ast drm_vram_helper sd_mod drm_kms_helper sr_mod cdrom t10_pi =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm
Nov 11 21:25:47 10.243.1.49
Nov 11 21:25:47 10.243.1.49 [ 3917.768251]  ixgbe igb ahci libahci =
crc32c_intel libata mdio ptp i2c_algo_bit pps_core dca
Nov 11 21:25:47 10.243.1.49 [ 3917.768274] CPU: 8 PID: 16134 Comm: =
RxWorker0 Tainted: G        W         5.15.77evl-gae6080e09d9a #1
Nov 11 21:25:47 10.243.1.49 [ 3917.768282] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 11 21:25:47 10.243.1.49 [ 3917.768285] IRQ stage: Linux
Nov 11 21:25:47 10.243.1.49 [ 3917.768287] RIP: =
0010:__list_del_entry_valid+0xc5/0x120
Nov 11 21:25:47 10.243.1.49 [ 3917.768296] Code: c0 eb e0 48 89 de 48 c7 =
c7 00 0c 82 a5 e8 7c fa 8b 00 0f 0b 31 c0 eb cb 4c 89 e2 48 89 de 48 c7 =
c7 60 0c 82 a5 e8 64 fa 8b 00 <0f> 0b 31 c0 eb b3 4c 89 ea 48 89 de 48 =
c7 c7 c0 0c 82 a5 e8 4c fa
Nov 11 21:25:47 10.243.1.49 [ 3917.768301] RSP: 0018:ffff88816588fac8 =
EFLAGS: 00010082
Nov 11 21:25:47 10.243.1.49 [ 3917.768306] RAX: 0000000000000000 RBX: =
ffff888151798240 RCX: 0000000000000027
Nov 11 21:25:47 10.243.1.49 [ 3917.768310] RDX: 0000000000000027 RSI: =
dffffc0000000000 RDI: ffff88841c227b18
Nov 11 21:25:47 10.243.1.49 [ 3917.768314] RBP: ffff88816588fae0 R08: =
ffffed1083844f64 R09: ffffed1083844f64
Nov 11 21:25:48 10.243.1.49 [ 3917.768318] R10: ffff88841c227b1b R11: =
ffffed1083844f63 R12: dead000000000100
Nov 11 21:25:48 10.243.1.49 [ 3917.768322] R13: dead000000000122 R14: =
ffff888151798000 R15: ffff888148b3a000
Nov 11 21:25:48 10.243.1.49 [ 3917.768326] FS:  00007f7313fff700(0000) =
GS:ffff88841c200000(0000) knlGS:0000000000000000
Nov 11 21:25:48 10.243.1.49 [ 3917.768331] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 11 21:25:48 10.243.1.49 [ 3917.768334] CR2: 000024a61fc9e000 CR3: =
000000016e080001 CR4: 00000000003706e0
Nov 11 21:25:48 10.243.1.49 [ 3917.768338] Call Trace:
Nov 11 21:25:48 10.243.1.49 [ 3917.768340]  <TASK>
Nov 11 21:25:48 10.243.1.49 [ 3917.768350]  =
__untrack_event.part.9+0x26/0xe0
Nov 11 21:25:48 10.243.1.49 [ 3917.768371]  =
monitor_oob_ioctl+0x1356/0x1490
Nov 11 21:25:48 10.243.1.49 [ 3917.768400]  ? enter_monitor+0x160/0x160
Nov 11 21:25:48 10.243.1.49 [ 3917.768410]  ? =
handle_irq_pipelined_finish+0xbe/0x240
Nov 11 21:25:48 10.243.1.49 [ 3917.768446]  ? =
do_raw_spin_lock+0x119/0x1e0
Nov 11 21:25:48 10.243.1.49 [ 3917.768456]  ? spin_dump+0x90/0x90
Nov 11 21:25:48 10.243.1.49 [ 3917.768484]  ? =
__kasan_check_read+0x11/0x20
Nov 11 21:25:48 10.243.1.49 [ 3917.768540]  EVL_ioctl+0x81/0xf0
Nov 11 21:25:48 10.243.1.49 [ 3917.768558]  do_oob_syscall+0x699/0x6b0
Nov 11 21:25:48 10.243.1.49 [ 3917.768572]  ? =
prepare_for_signal+0x180/0x180
Nov 11 21:25:48 10.243.1.49 [ 3917.768587]  ? do_oob_irq+0x283/0x7e0
Nov 11 21:25:48 10.243.1.49 [ 3917.768594]  ? =
arch_pipeline_entry+0xce/0x110
Nov 11 21:25:48 10.243.1.49 [ 3917.768612]  =
handle_oob_syscall+0x189/0x230
Nov 11 21:25:48 10.243.1.49 [ 3917.768626]  ? =
handle_pipelined_syscall+0x820/0x820
Nov 11 21:25:48 10.243.1.49 [ 3917.768644]  ? =
rcu_read_lock_sched_held+0x5b/0xd0
Nov 11 21:25:48 10.243.1.49 [ 3917.768655]  ? =
rcu_read_lock_any_held.part.15+0x20/0x20
Nov 11 21:25:48 10.243.1.49 [ 3917.768676]  pipeline_syscall+0xa7/0x1c0
Nov 11 21:25:48 10.243.1.49 [ 3917.768696]  =
syscall_enter_from_user_mode+0x47/0x110
Nov 11 21:25:48 10.243.1.49 [ 3917.768710]  do_syscall_64+0x15/0xb0
Nov 11 21:25:48 10.243.1.49 [ 3917.768721]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 11 21:25:48 10.243.1.49 [ 3917.768729] RIP: 0033:0x7f735de5a940
Nov 11 21:25:48 10.243.1.49 [ 3917.768735] Code: 77 ff ff bf 02 00 00 10 =
8b 44 24 0c 48 98 48 89 c6 48 8b 04 24 48 89 c2 4c 8b 54 24 38 41 b8 00 =
00 00 00 b8 9d 00 00 00 0f 05 <48> 89 44 24 30 48 8b 44 24 30 89 44 24 =
2c 8b 44 24 28 be 00 00 00
Nov 11 21:25:48 10.243.1.49 [ 3917.768740] RSP: 002b:00007f7313fef340 =
EFLAGS: 00000202 ORIG_RAX: 000000000000009d
Nov 11 21:25:48 10.243.1.49 [ 3917.768746] RAX: ffffffffffffffda RBX: =
0000000000000f4d RCX: 00007f735de5a940
Nov 11 21:25:48 10.243.1.49 [ 3917.768750] RDX: 00000000c0186d03 RSI: =
000000000000000d RDI: 0000000010000002
Nov 11 21:25:48 10.243.1.49 [ 3917.768754] RBP: 00007f7313fef520 R08: =
0000000000000000 R09: 00007ffc09389080
Nov 11 21:25:48 10.243.1.49 [ 3917.768757] R10: 00007f7313fef4f0 R11: =
0000000000000202 R12: 00007f7313fef600
Nov 11 21:25:48 10.243.1.49 [ 3917.768760] R13: 0000000000000000 R14: =
000000003a1b30e9 R15: 00007f7313fef580
Nov 11 21:25:48 10.243.1.49 [ 3917.768798]  </TASK>
Nov 11 21:25:48 10.243.1.49 [ 3917.768800] irq event stamp: 1763
Nov 11 21:25:48 10.243.1.49 [ 3917.768802] hardirqs last  enabled at =
(1763): [<ffffffffa51330bc>] _raw_spin_unlock_irqrestore+0x4c/0x50
Nov 11 21:25:48 10.243.1.49 [ 3917.768811] hardirqs last disabled at =
(1762): [<ffffffffa5132e2b>] _raw_spin_lock_irqsave+0x1b/0x60
Nov 11 21:25:48 10.243.1.49 [ 3917.768818] softirqs last  enabled at =
(286): [<ffffffffa5400403>] __do_softirq+0x403/0x57b
Nov 11 21:25:48 10.243.1.49 [ 3917.768826] softirqs last disabled at =
(275): [<ffffffffa40d261d>] irq_exit_rcu+0x7d/0x150
Nov 11 21:25:48 10.243.1.49 [ 3917.768835] ---[ end trace =
87ffbd6a737b5b87 ]---
Nov 11 21:25:48 10.243.1.49 [ 3919.382324] EVL: RxWorker0 resuming =
out-of-band [pid=3D16134, excpt=3D6, __list_del_entry_valid+0xc7/0x120]
Nov 11 21:25:48 10.243.1.49 [ 3919.415123] ------------[ cut here =
]------------
Nov 11 21:25:49 10.243.1.49 [ 3919.433389] syscall 157 left IRQs =
disabled
Nov 11 21:25:49 10.243.1.49 [ 3919.433444] WARNING: CPU: 8 PID: 16134 at =
kernel/entry/common.c:353 syscall_exit_to_user_mode_prepare+0x37/0x270
Nov 11 21:25:49 10.243.1.49 [ 3919.485450] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich intel_cstate pcspkr =
intel_pch_thermal input_leds sg joydev ftdi_sio i2c_smbus mfd_core mei =
acpi_ipmi ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c ast drm_vram_helper sd_mod drm_kms_helper sr_mod cdrom t10_pi =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm
Nov 11 21:25:49 10.243.1.49
Nov 11 21:25:49 10.243.1.49 [ 3919.486010]  ixgbe igb ahci libahci =
crc32c_intel libata mdio ptp i2c_algo_bit pps_core dca
Nov 11 21:25:49 10.243.1.49 [ 3919.819623] CPU: 8 PID: 16134 Comm: =
RxWorker0 Tainted: G        W         5.15.77evl-gae6080e09d9a #1
Nov 11 21:25:49 10.243.1.49 [ 3919.853138] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 11 21:25:49 10.243.1.49 [ 3919.883092] IRQ stage: Linux
Nov 11 21:25:49 10.243.1.49 [ 3919.897600] RIP: =
0010:syscall_exit_to_user_mode_prepare+0x37/0x270
Nov 11 21:25:49 10.243.1.49 [ 3919.922159] Code: 41 55 41 54 49 89 fc 53 =
4c 8b 68 08 48 8b 5f 78 eb 36 e8 0c fe f2 00 85 c0 74 1c 48 63 f3 48 c7 =
c7 70 66 ca a5 e8 42 f0 ec 00 <0f> 0b fb e8 e1 a1 0d 00 e8 bc af fd ff =
41 f6 c5 76 75 3a 5b 41 5c
Nov 11 21:25:49 10.243.1.49 [ 3919.991108] RSP: 0018:ffff88816588ff00 =
EFLAGS: 00010282
Nov 11 21:25:49 10.243.1.49 [ 3920.013245] RAX: 0000000000000000 RBX: =
000000000000009d RCX: 0000000000000027
Nov 11 21:25:49 10.243.1.49 [ 3920.041449] RDX: 0000000000000027 RSI: =
dffffc0000000000 RDI: ffff88841c227b18
Nov 11 21:25:49 10.243.1.49 [ 3920.069436] RBP: ffff88816588ff18 R08: =
ffffed1083844f64 R09: ffffed1083844f64
Nov 11 21:25:49 10.243.1.49 [ 3920.097424] R10: ffff88841c227b1b R11: =
ffffed1083844f63 R12: ffff88816588ff58
Nov 11 21:25:49 10.243.1.49 [ 3920.125444] R13: 0000000000000010 R14: =
0000000000000000 R15: 0000000000000000
Nov 11 21:25:49 10.243.1.49 [ 3920.153567] FS:  00007f7313fff700(0000) =
GS:ffff88841c200000(0000) knlGS:0000000000000000
Nov 11 21:25:49 10.243.1.49 [ 3920.184562] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 11 21:25:49 10.243.1.49 [ 3920.208601] CR2: 000024a61fc9e000 CR3: =
000000016e080001 CR4: 00000000003706e0
Nov 11 21:25:49 10.243.1.49 [ 3920.236828] Call Trace:
Nov 11 21:25:49 10.243.1.49 [ 3920.250925]  <TASK>
Nov 11 21:25:49 10.243.1.49 [ 3920.264093]  =
syscall_exit_to_user_mode+0xd/0x90
Nov 11 21:25:49 10.243.1.49 [ 3920.284430]  do_syscall_64+0x50/0xb0
Nov 11 21:25:49 10.243.1.49 [ 3920.301962]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 11 21:25:49 10.243.1.49 [ 3920.323780] RIP: 0033:0x7f735de5a940
Nov 11 21:25:49 10.243.1.49 [ 3920.340972] Code: 77 ff ff bf 02 00 00 10 =
8b 44 24 0c 48 98 48 89 c6 48 8b 04 24 48 89 c2 4c 8b 54 24 38 41 b8 00 =
00 00 00 b8 9d 00 00 00 0f 05 <48> 89 44 24 30 48 8b 44 24 30 89 44 24 =
2c 8b 44 24 28 be 00 00 00
Nov 11 21:25:50 10.243.1.49 [ 3920.415607] RSP: 002b:00007f7313fef340 =
EFLAGS: 00000202 ORIG_RAX: 000000000000009d
Nov 11 21:25:50 10.243.1.49 [ 3920.445137] RAX: 0000000000000000 RBX: =
0000000000000f4d RCX: 00007f735de5a940
Nov 11 21:25:50 10.243.1.49 [ 3920.473367] RDX: 00000000c0186d03 RSI: =
000000000000000d RDI: 0000000010000002
Nov 11 21:25:50 10.243.1.49 [ 3920.501668] RBP: 00007f7313fef520 R08: =
0000000000000000 R09: 00007ffc09389080
Nov 11 21:25:50 10.243.1.49 [ 3920.529978] R10: 00007f7313fef4f0 R11: =
0000000000000202 R12: 00007f7313fef600
Nov 11 21:25:50 10.243.1.49 [ 3920.559152] R13: 0000000000000000 R14: =
000000003a1b30e9 R15: 00007f7313fef580
Nov 11 21:25:50 10.243.1.49 [ 3920.587647]  </TASK>
Nov 11 21:25:50 10.243.1.49 [ 3920.600846] irq event stamp: 2457
Nov 11 21:25:50 10.243.1.49 [ 3920.617396] hardirqs last  enabled at =
(2465): [<ffffffffa41aaac2>] __up_console_sem+0x62/0x70
Nov 11 21:25:50 10.243.1.49 [ 3920.649771] hardirqs last disabled at =
(2472): [<ffffffffa41aaaa7>] __up_console_sem+0x47/0x70
Nov 11 21:25:50 10.243.1.49 [ 3920.682095] softirqs last  enabled at =
(286): [<ffffffffa5400403>] __do_softirq+0x403/0x57b
Nov 11 21:25:50 10.243.1.49 [ 3920.713632] softirqs last disabled at =
(275): [<ffffffffa40d261d>] irq_exit_rcu+0x7d/0x150
Nov 11 21:25:50 10.243.1.49 [ 3920.744811] ---[ end trace =
87ffbd6a737b5b88 ]---
Nov 11 21:26:01 10.243.1.49 [ 3932.344700] ------------[ cut here =
]------------
Nov 11 21:26:01 10.243.1.49 [ 3932.344708] list_del corruption, =
ffff888151798240->next is LIST_POISON1 (dead000000000100)
Nov 11 21:26:02 10.243.1.49 [ 3932.344718] EVL: RxWorker1 switching =
in-band [pid=3D16135, excpt=3D6, __list_del_entry_valid+0xc5/0x120]
Nov 11 21:26:02 10.243.1.49 [ 3932.449176] WARNING: CPU: 9 PID: 16135 at =
lib/list_debug.c:55 __list_del_entry_valid+0xc5/0x120
Nov 11 21:26:02 10.243.1.49 [ 3932.449200] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich intel_cstate pcspkr =
intel_pch_thermal input_leds sg joydev ftdi_sio i2c_smbus mfd_core mei =
acpi_ipmi ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c ast drm_vram_helper sd_mod drm_kms_helper sr_mod cdrom t10_pi =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm
Nov 11 21:26:02 10.243.1.49
Nov 11 21:26:02 10.243.1.49 [ 3932.449522]  ixgbe igb ahci libahci =
crc32c_intel libata mdio ptp i2c_algo_bit pps_core dca
Nov 11 21:26:02 10.243.1.49 [ 3932.449565] CPU: 9 PID: 16135 Comm: =
RxWorker1 Tainted: G        W         5.15.77evl-gae6080e09d9a #1
Nov 11 21:26:02 10.243.1.49 [ 3932.449578] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 11 21:26:02 10.243.1.49 [ 3932.449583] IRQ stage: Linux
Nov 11 21:26:02 10.243.1.49 [ 3932.449588] RIP: =
0010:__list_del_entry_valid+0xc5/0x120
Nov 11 21:26:02 10.243.1.49 [ 3932.449604] Code: c0 eb e0 48 89 de 48 c7 =
c7 00 0c 82 a5 e8 7c fa 8b 00 0f 0b 31 c0 eb cb 4c 89 e2 48 89 de 48 c7 =
c7 60 0c 82 a5 e8 64 fa 8b 00 <0f> 0b 31 c0 eb b3 4c 89 ea 48 89 de 48 =
c7 c7 c0 0c 82 a5 e8 4c fa
Nov 11 21:26:02 10.243.1.49 [ 3932.449614] RSP: 0018:ffff88815ef47ac8 =
EFLAGS: 00010082
Nov 11 21:26:02 10.243.1.49 [ 3932.449623] RAX: 0000000000000000 RBX: =
ffff888151798240 RCX: 0000000000000027
Nov 11 21:26:02 10.243.1.49 [ 3932.449631] RDX: 0000000000000027 RSI: =
dffffc0000000000 RDI: ffff88841c2a7b18
Nov 11 21:26:02 10.243.1.49 [ 3932.449639] RBP: ffff88815ef47ae0 R08: =
ffffed1083854f64 R09: ffffed1083854f64
Nov 11 21:26:02 10.243.1.49 [ 3932.449648] R10: ffff88841c2a7b1b R11: =
ffffed1083854f63 R12: dead000000000100
Nov 11 21:26:02 10.243.1.49 [ 3932.449656] R13: dead000000000122 R14: =
ffff888151798000 R15: ffff888145380000
Nov 11 21:26:02 10.243.1.49 [ 3932.449664] FS:  00007f7312ffe700(0000) =
GS:ffff88841c280000(0000) knlGS:0000000000000000
Nov 11 21:26:02 10.243.1.49 [ 3932.449674] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 11 21:26:02 10.243.1.49 [ 3932.449681] CR2: 0000000000000000 CR3: =
000000016e080005 CR4: 00000000003706e0
Nov 11 21:26:02 10.243.1.49 [ 3932.449689] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 11 21:26:03 10.243.1.49 [ 3932.449695] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 11 21:26:03 10.243.1.49 [ 3932.449702] Call Trace:
Nov 11 21:26:03 10.243.1.49 [ 3932.449706]  <TASK>
Nov 11 21:26:03 10.243.1.49 [ 3932.449725]  =
__untrack_event.part.9+0x26/0xe0
Nov 11 21:26:03 10.243.1.49 [ 3932.449762]  =
monitor_oob_ioctl+0x1356/0x1490
Nov 11 21:26:03 10.243.1.49 [ 3932.449823]  ? enter_monitor+0x160/0x160
Nov 11 21:26:03 10.243.1.49 [ 3932.449872]  ? =
rcu_read_lock_held_common+0x25/0x70
Nov 11 21:26:03 10.243.1.49 [ 3932.449920]  ? =
do_raw_spin_lock+0x119/0x1e0
Nov 11 21:26:03 10.243.1.49 [ 3932.449938]  ? spin_dump+0x90/0x90
Nov 11 21:26:03 10.243.1.49 [ 3932.449976]  ? =
__kasan_check_read+0x11/0x20
Nov 11 21:26:03 10.243.1.49 [ 3932.450040]  EVL_ioctl+0x81/0xf0
Nov 11 21:26:03 10.243.1.49 [ 3932.450075]  do_oob_syscall+0x699/0x6b0
Nov 11 21:26:03 10.243.1.49 [ 3932.450105]  ? =
prepare_for_signal+0x180/0x180
Nov 11 21:26:03 10.243.1.49 [ 3932.450134]  ? do_oob_irq+0x283/0x7e0
Nov 11 21:26:03 10.243.1.49 [ 3932.450148]  ? =
arch_pipeline_entry+0xce/0x110
Nov 11 21:26:03 10.243.1.49 [ 3932.450185]  =
handle_oob_syscall+0x189/0x230
Nov 11 21:26:03 10.243.1.49 [ 3932.450215]  ? =
handle_pipelined_syscall+0x820/0x820
Nov 11 21:26:03 10.243.1.49 [ 3932.450252]  ? =
rcu_read_lock_sched_held+0x5b/0xd0
Nov 11 21:26:03 10.243.1.49 [ 3932.450272]  ? =
rcu_read_lock_any_held.part.15+0x20/0x20
Nov 11 21:26:03 10.243.1.49 [ 3932.450315]  pipeline_syscall+0xa7/0x1c0
Nov 11 21:26:03 10.243.1.49 [ 3932.450354]  =
syscall_enter_from_user_mode+0x47/0x110
Nov 11 21:26:03 10.243.1.49 [ 3932.450380]  do_syscall_64+0x15/0xb0
Nov 11 21:26:03 10.243.1.49 [ 3932.450400]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 11 21:26:03 10.243.1.49 [ 3932.450413] RIP: 0033:0x7f735de5a940
Nov 11 21:26:03 10.243.1.49 [ 3932.450425] Code: 77 ff ff bf 02 00 00 10 =
8b 44 24 0c 48 98 48 89 c6 48 8b 04 24 48 89 c2 4c 8b 54 24 38 41 b8 00 =
00 00 00 b8 9d 00 00 00 0f 05 <48> 89 44 24 30 48 8b 44 24 30 89 44 24 =
2c 8b 44 24 28 be 00 00 00
Nov 11 21:26:03 10.243.1.49 [ 3932.450434] RSP: 002b:00007f7312fee340 =
EFLAGS: 00000202 ORIG_RAX: 000000000000009d
Nov 11 21:26:03 10.243.1.49 [ 3932.450445] RAX: ffffffffffffffda RBX: =
0000000000000f5c RCX: 00007f735de5a940
Nov 11 21:26:03 10.243.1.49 [ 3932.450453] RDX: 00000000c0186d03 RSI: =
000000000000000d RDI: 0000000010000002
Nov 11 21:26:03 10.243.1.49 [ 3932.450460] RBP: 00007f7312fee520 R08: =
0000000000000000 R09: 00007ffc09389080
Nov 11 21:26:03 10.243.1.49 [ 3932.450467] R10: 00007f7312fee4f0 R11: =
0000000000000202 R12: 00007f7312fee600
Nov 11 21:26:03 10.243.1.49 [ 3932.450475] R13: 0000000000000000 R14: =
0000000025f8f620 R15: 00007f7312fee580
Nov 11 21:26:03 10.243.1.49 [ 3932.450556]  </TASK>
Nov 11 21:26:03 10.243.1.49 [ 3932.450560] irq event stamp: 2335
Nov 11 21:26:03 10.243.1.49 [ 3932.450563] hardirqs last  enabled at =
(2335): [<ffffffffa51330bc>] _raw_spin_unlock_irqrestore+0x4c/0x50
Nov 11 21:26:03 10.243.1.49 [ 3932.450578] hardirqs last disabled at =
(2334): [<ffffffffa5132e2b>] _raw_spin_lock_irqsave+0x1b/0x60
Nov 11 21:26:03 10.243.1.49 [ 3932.450591] softirqs last  enabled at =
(1488): [<ffffffffa5400403>] __do_softirq+0x403/0x57b
Nov 11 21:26:03 10.243.1.49 [ 3932.450606] softirqs last disabled at =
(1479): [<ffffffffa40d261d>] irq_exit_rcu+0x7d/0x150
Nov 11 21:26:04 10.243.1.49 [ 3932.450623] ---[ end trace =
87ffbd6a737b5b89 ]---
Nov 11 21:26:04 10.243.1.49 [ 3934.468351] EVL: RxWorker1 resuming =
out-of-band [pid=3D16135, excpt=3D6, __list_del_entry_valid+0xc7/0x120]
Nov 11 21:26:04 10.243.1.49 [ 3934.505195] ------------[ cut here =
]------------
Nov 11 21:26:04 10.243.1.49 [ 3934.523357] syscall 157 left IRQs =
disabled
Nov 11 21:26:04 10.243.1.49 [ 3934.523412] WARNING: CPU: 9 PID: 16135 at =
kernel/entry/common.c:353 syscall_exit_to_user_mode_prepare+0x37/0x270
Nov 11 21:26:04 10.243.1.49 [ 3934.575073] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich intel_cstate pcspkr =
intel_pch_thermal input_leds sg joydev ftdi_sio i2c_smbus mfd_core mei =
acpi_ipmi ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c ast drm_vram_helper sd_mod drm_kms_helper sr_mod cdrom t10_pi =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm
Nov 11 21:26:04 10.243.1.49
Nov 11 21:26:04 10.243.1.49 [ 3934.575624]  ixgbe igb ahci libahci =
crc32c_intel libata mdio ptp i2c_algo_bit pps_core dca
Nov 11 21:26:04 10.243.1.49 [ 3934.908567] CPU: 9 PID: 16135 Comm: =
RxWorker1 Tainted: G        W         5.15.77evl-gae6080e09d9a #1
Nov 11 21:26:04 10.243.1.49 [ 3934.942053] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 11 21:26:04 10.243.1.49 [ 3934.971930] IRQ stage: Linux
Nov 11 21:26:04 10.243.1.49 [ 3934.986372] RIP: =
0010:syscall_exit_to_user_mode_prepare+0x37/0x270
Nov 11 21:26:04 10.243.1.49 [ 3935.011814] Code: 41 55 41 54 49 89 fc 53 =
4c 8b 68 08 48 8b 5f 78 eb 36 e8 0c fe f2 00 85 c0 74 1c 48 63 f3 48 c7 =
c7 70 66 ca a5 e8 42 f0 ec 00 <0f> 0b fb e8 e1 a1 0d 00 e8 bc af fd ff =
41 f6 c5 76 75 3a 5b 41 5c
Nov 11 21:26:04 10.243.1.49 [ 3935.080613] RSP: 0018:ffff88815ef47f00 =
EFLAGS: 00010282
Nov 11 21:26:04 10.243.1.49 [ 3935.102656] RAX: 0000000000000000 RBX: =
000000000000009d RCX: 0000000000000027
Nov 11 21:26:04 10.243.1.49 [ 3935.130510] RDX: 0000000000000027 RSI: =
dffffc0000000000 RDI: ffff88841c2a7b18
Nov 11 21:26:04 10.243.1.49 [ 3935.158377] RBP: ffff88815ef47f18 R08: =
ffffed1083854f64 R09: ffffed1083854f64
Nov 11 21:26:04 10.243.1.49 [ 3935.186296] R10: ffff88841c2a7b1b R11: =
ffffed1083854f63 R12: ffff88815ef47f58
Nov 11 21:26:04 10.243.1.49 [ 3935.214788] R13: 0000000000000010 R14: =
0000000000000000 R15: 0000000000000000
Nov 11 21:26:04 10.243.1.49 [ 3935.242756] FS:  00007f7312ffe700(0000) =
GS:ffff88841c280000(0000) knlGS:0000000000000000
Nov 11 21:26:04 10.243.1.49 [ 3935.273674] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 11 21:26:04 10.243.1.49 [ 3935.297585] CR2: 0000000000000000 CR3: =
000000016e080005 CR4: 00000000003706e0
Nov 11 21:26:04 10.243.1.49 [ 3935.325742] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 11 21:26:04 10.243.1.49 [ 3935.353906] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 11 21:26:04 10.243.1.49 [ 3935.382008] Call Trace:
Nov 11 21:26:04 10.243.1.49 [ 3935.395984]  <TASK>
Nov 11 21:26:04 10.243.1.49 [ 3935.409811]  =
syscall_exit_to_user_mode+0xd/0x90
Nov 11 21:26:04 10.243.1.49 [ 3935.429912]  do_syscall_64+0x50/0xb0
Nov 11 21:26:05 10.243.1.49 [ 3935.446955]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 11 21:26:05 10.243.1.49 [ 3935.468406] RIP: 0033:0x7f735de5a940
Nov 11 21:26:05 10.243.1.49 [ 3935.485360] Code: 77 ff ff bf 02 00 00 10 =
8b 44 24 0c 48 98 48 89 c6 48 8b 04 24 48 89 c2 4c 8b 54 24 38 41 b8 00 =
00 00 00 b8 9d 00 00 00 0f 05 <48> 89 44 24 30 48 8b 44 24 30 89 44 24 =
2c 8b 44 24 28 be 00 00 00
Nov 11 21:26:05 10.243.1.49 [ 3935.554757] RSP: 002b:00007f7312fee340 =
EFLAGS: 00000202 ORIG_RAX: 000000000000009d
Nov 11 21:26:05 10.243.1.49 [ 3935.584179] RAX: 0000000000000000 RBX: =
0000000000000f5c RCX: 00007f735de5a940
Nov 11 21:26:05 10.243.1.49 [ 3935.613249] RDX: 00000000c0186d03 RSI: =
000000000000000d RDI: 0000000010000002
Nov 11 21:26:05 10.243.1.49 [ 3935.641352] RBP: 00007f7312fee520 R08: =
0000000000000000 R09: 00007ffc09389080
Nov 11 21:26:05 10.243.1.49 [ 3935.669502] R10: 00007f7312fee4f0 R11: =
0000000000000202 R12: 00007f7312fee600
Nov 11 21:26:05 10.243.1.49 [ 3935.697540] R13: 0000000000000000 R14: =
0000000025f8f620 R15: 00007f7312fee580
Nov 11 21:26:05 10.243.1.49 [ 3935.725630]  </TASK>
Nov 11 21:26:05 10.243.1.49 [ 3935.738718] irq event stamp: 3045
Nov 11 21:26:05 10.243.1.49 [ 3935.755162] hardirqs last  enabled at =
(3053): [<ffffffffa41aaac2>] __up_console_sem+0x62/0x70
Nov 11 21:26:05 10.243.1.49 [ 3935.787382] hardirqs last disabled at =
(3060): [<ffffffffa41aaaa7>] __up_console_sem+0x47/0x70
Nov 11 21:26:05 10.243.1.49 [ 3935.819592] softirqs last  enabled at =
(2346): [<ffffffffa5400403>] __do_softirq+0x403/0x57b
Nov 11 21:26:05 10.243.1.49 [ 3935.851088] softirqs last disabled at =
(2339): [<ffffffffa40d261d>] irq_exit_rcu+0x7d/0x150
Nov 11 21:26:05 10.243.1.49 [ 3935.882340] ---[ end trace =
87ffbd6a737b5b8a ]---
Nov 11 21:26:10 10.243.1.49 [ 3940.614587] ------------[ cut here =
]------------
Nov 11 21:26:10 10.243.1.49 [ 3940.614594] list_del corruption, =
ffff888151798240->next is LIST_POISON1 (dead000000000100)
Nov 11 21:26:10 10.243.1.49 [ 3940.614604] EVL: RxWorker1 switching =
in-band [pid=3D16135, excpt=3D6, __list_del_entry_valid+0xc5/0x120]
Nov 11 21:26:10 10.243.1.49 [ 3940.717204] WARNING: CPU: 9 PID: 16135 at =
lib/list_debug.c:55 __list_del_entry_valid+0xc5/0x120
Nov 11 21:26:10 10.243.1.49 [ 3940.717228] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich intel_cstate pcspkr =
intel_pch_thermal input_leds sg joydev ftdi_sio i2c_smbus mfd_core mei =
acpi_ipmi ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c ast drm_vram_helper sd_mod drm_kms_helper sr_mod cdrom t10_pi =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm
Nov 11 21:26:10 10.243.1.49
Nov 11 21:26:10 10.243.1.49 [ 3940.717553]  ixgbe igb ahci libahci =
crc32c_intel libata mdio ptp i2c_algo_bit pps_core dca
Nov 11 21:26:10 10.243.1.49 [ 3940.717596] CPU: 9 PID: 16135 Comm: =
RxWorker1 Tainted: G        W         5.15.77evl-gae6080e09d9a #1
Nov 11 21:26:10 10.243.1.49 [ 3940.717609] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 11 21:26:10 10.243.1.49 [ 3940.717615] IRQ stage: Linux
Nov 11 21:26:10 10.243.1.49 [ 3940.717619] RIP: =
0010:__list_del_entry_valid+0xc5/0x120
Nov 11 21:26:10 10.243.1.49 [ 3940.717634] Code: c0 eb e0 48 89 de 48 c7 =
c7 00 0c 82 a5 e8 7c fa 8b 00 0f 0b 31 c0 eb cb 4c 89 e2 48 89 de 48 c7 =
c7 60 0c 82 a5 e8 64 fa 8b 00 <0f> 0b 31 c0 eb b3 4c 89 ea 48 89 de 48 =
c7 c7 c0 0c 82 a5 e8 4c fa
Nov 11 21:26:10 10.243.1.49 [ 3940.717644] RSP: 0018:ffff88815ef47ac8 =
EFLAGS: 00010082
Nov 11 21:26:10 10.243.1.49 [ 3940.717654] RAX: 0000000000000000 RBX: =
ffff888151798240 RCX: 0000000000000027
Nov 11 21:26:10 10.243.1.49 [ 3940.717662] RDX: 0000000000000027 RSI: =
dffffc0000000000 RDI: ffff88841c2a7b18
Nov 11 21:26:11 10.243.1.49 [ 3940.717669] RBP: ffff88815ef47ae0 R08: =
ffffed1083854f64 R09: ffffed1083854f64
Nov 11 21:26:11 10.243.1.49 [ 3940.717678] R10: ffff88841c2a7b1b R11: =
ffffed1083854f63 R12: dead000000000100
Nov 11 21:26:11 10.243.1.49 [ 3940.717686] R13: dead000000000122 R14: =
ffff888151798000 R15: ffff888145380000
Nov 11 21:26:11 10.243.1.49 [ 3940.717694] FS:  00007f7312ffe700(0000) =
GS:ffff88841c280000(0000) knlGS:0000000000000000
Nov 11 21:26:11 10.243.1.49 [ 3940.717704] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 11 21:26:11 10.243.1.49 [ 3940.717712] CR2: 0000000000000000 CR3: =
000000016e080005 CR4: 00000000003706e0
Nov 11 21:26:11 10.243.1.49 [ 3940.717719] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 11 21:26:11 10.243.1.49 [ 3940.717726] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 11 21:26:11 10.243.1.49 [ 3940.717733] Call Trace:
Nov 11 21:26:11 10.243.1.49 [ 3940.717736]  <TASK>
Nov 11 21:26:11 10.243.1.49 [ 3940.717755]  =
__untrack_event.part.9+0x26/0xe0
Nov 11 21:26:11 10.243.1.49 [ 3940.717793]  =
monitor_oob_ioctl+0x1356/0x1490
Nov 11 21:26:11 10.243.1.49 [ 3940.717854]  ? enter_monitor+0x160/0x160
Nov 11 21:26:11 10.243.1.49 [ 3940.717871]  ? =
__kasan_check_read+0x11/0x20
Nov 11 21:26:11 10.243.1.49 [ 3940.717888]  ? =
do_raw_spin_unlock+0x97/0x140
Nov 11 21:26:11 10.243.1.49 [ 3940.717914]  ? do_clock_tick+0x40a/0x630
Nov 11 21:26:11 10.243.1.49 [ 3940.717928]  ? =
rcu_read_lock_held_common+0x25/0x70
Nov 11 21:26:11 10.243.1.49 [ 3940.717975]  ? =
do_raw_spin_lock+0x119/0x1e0
Nov 11 21:26:11 10.243.1.49 [ 3940.717992]  ? spin_dump+0x90/0x90
Nov 11 21:26:11 10.243.1.49 [ 3940.718030]  ? =
__kasan_check_read+0x11/0x20
Nov 11 21:26:11 10.243.1.49 [ 3940.718091]  EVL_ioctl+0x81/0xf0
Nov 11 21:26:11 10.243.1.49 [ 3940.718127]  do_oob_syscall+0x699/0x6b0
Nov 11 21:26:11 10.243.1.49 [ 3940.718156]  ? =
prepare_for_signal+0x180/0x180
Nov 11 21:26:11 10.243.1.49 [ 3940.718186]  ? do_oob_irq+0x283/0x7e0
Nov 11 21:26:11 10.243.1.49 [ 3940.718196]  ? =
rcu_dynticks_eqs_enter+0xe/0x20
Nov 11 21:26:11 10.243.1.49 [ 3940.718237]  =
handle_oob_syscall+0x189/0x230
Nov 11 21:26:11 10.243.1.49 [ 3940.718267]  ? =
handle_pipelined_syscall+0x820/0x820
Nov 11 21:26:11 10.243.1.49 [ 3940.718304]  ? =
rcu_read_lock_sched_held+0x5b/0xd0
Nov 11 21:26:11 10.243.1.49 [ 3940.718325]  ? =
rcu_read_lock_any_held.part.15+0x20/0x20
Nov 11 21:26:11 10.243.1.49 [ 3940.718367]  pipeline_syscall+0xa7/0x1c0
Nov 11 21:26:11 10.243.1.49 [ 3940.718406]  =
syscall_enter_from_user_mode+0x47/0x110
Nov 11 21:26:11 10.243.1.49 [ 3940.718433]  do_syscall_64+0x15/0xb0
Nov 11 21:26:11 10.243.1.49 [ 3940.718453]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 11 21:26:11 10.243.1.49 [ 3940.718466] RIP: 0033:0x7f735de5a940
Nov 11 21:26:11 10.243.1.49 [ 3940.718477] Code: 77 ff ff bf 02 00 00 10 =
8b 44 24 0c 48 98 48 89 c6 48 8b 04 24 48 89 c2 4c 8b 54 24 38 41 b8 00 =
00 00 00 b8 9d 00 00 00 0f 05 <48> 89 44 24 30 48 8b 44 24 30 89 44 24 =
2c 8b 44 24 28 be 00 00 00
Nov 11 21:26:11 10.243.1.49 [ 3940.718487] RSP: 002b:00007f7312fee340 =
EFLAGS: 00000202 ORIG_RAX: 000000000000009d
Nov 11 21:26:12 10.243.1.49 [ 3940.718498] RAX: ffffffffffffffda RBX: =
0000000000000f64 RCX: 00007f735de5a940
Nov 11 21:26:12 10.243.1.49 [ 3940.718506] RDX: 00000000c0186d03 RSI: =
000000000000000d RDI: 0000000010000002
Nov 11 21:26:12 10.243.1.49 [ 3940.718513] RBP: 00007f7312fee520 R08: =
0000000000000000 R09: 00007ffc09389080
Nov 11 21:26:12 10.243.1.49 [ 3940.718520] R10: 00007f7312fee4f0 R11: =
0000000000000202 R12: 00007f7312fee600
Nov 11 21:26:12 10.243.1.49 [ 3940.718527] R13: 0000000000000000 R14: =
00000000360f356d R15: 00007f7312fee580
Nov 11 21:26:12 10.243.1.49 [ 3940.718609]  </TASK>
Nov 11 21:26:12 10.243.1.49 [ 3940.718613] irq event stamp: 3141
Nov 11 21:26:12 10.243.1.49 [ 3940.718616] hardirqs last  enabled at =
(3141): [<ffffffffa51330bc>] _raw_spin_unlock_irqrestore+0x4c/0x50
Nov 11 21:26:12 10.243.1.49 [ 3940.718631] hardirqs last disabled at =
(3140): [<ffffffffa5132e2b>] _raw_spin_lock_irqsave+0x1b/0x60
Nov 11 21:26:12 10.243.1.49 [ 3940.718645] softirqs last  enabled at =
(2346): [<ffffffffa5400403>] __do_softirq+0x403/0x57b
Nov 11 21:26:12 10.243.1.49 [ 3940.718660] softirqs last disabled at =
(2339): [<ffffffffa40d261d>] irq_exit_rcu+0x7d/0x150
Nov 11 21:26:12 10.243.1.49 [ 3940.718676] ---[ end trace =
87ffbd6a737b5b8b ]---
Nov 11 21:26:12 10.243.1.49 [ 3942.781537] EVL: RxWorker1 resuming =
out-of-band [pid=3D16135, excpt=3D6, __list_del_entry_valid+0xc7/0x120]
Nov 11 21:26:12 10.243.1.49 [ 3942.818240] ------------[ cut here =
]------------
Nov 11 21:26:12 10.243.1.49 [ 3942.836295] syscall 157 left IRQs =
disabled
Nov 11 21:26:12 10.243.1.49 [ 3942.836351] WARNING: CPU: 9 PID: 16135 at =
kernel/entry/common.c:353 syscall_exit_to_user_mode_prepare+0x37/0x270
Nov 11 21:26:12 10.243.1.49 [ 3942.887649] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich intel_cstate pcspkr =
intel_pch_thermal input_leds sg joydev ftdi_sio i2c_smbus mfd_core mei =
acpi_ipmi ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c ast drm_vram_helper sd_mod drm_kms_helper sr_mod cdrom t10_pi =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm
Nov 11 21:26:12 10.243.1.49
Nov 11 21:26:12 10.243.1.49 [ 3942.888154]  ixgbe igb ahci libahci =
crc32c_intel libata mdio ptp i2c_algo_bit pps_core dca
Nov 11 21:26:12 10.243.1.49 [ 3943.219885] CPU: 9 PID: 16135 Comm: =
RxWorker1 Tainted: G        W         5.15.77evl-gae6080e09d9a #1
Nov 11 21:26:12 10.243.1.49 [ 3943.253383] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 11 21:26:12 10.243.1.49 [ 3943.283317] IRQ stage: Linux
Nov 11 21:26:12 10.243.1.49 [ 3943.297827] RIP: =
0010:syscall_exit_to_user_mode_prepare+0x37/0x270
Nov 11 21:26:12 10.243.1.49 [ 3943.323263] Code: 41 55 41 54 49 89 fc 53 =
4c 8b 68 08 48 8b 5f 78 eb 36 e8 0c fe f2 00 85 c0 74 1c 48 63 f3 48 c7 =
c7 70 66 ca a5 e8 42 f0 ec 00 <0f> 0b fb e8 e1 a1 0d 00 e8 bc af fd ff =
41 f6 c5 76 75 3a 5b 41 5c
Nov 11 21:26:12 10.243.1.49 [ 3943.392085] RSP: 0018:ffff88815ef47f00 =
EFLAGS: 00010282
Nov 11 21:26:12 10.243.1.49 [ 3943.414133] RAX: 0000000000000000 RBX: =
000000000000009d RCX: 0000000000000027
Nov 11 21:26:13 10.243.1.49 [ 3943.441990] RDX: 0000000000000027 RSI: =
dffffc0000000000 RDI: ffff88841c2a7b18
Nov 11 21:26:13 10.243.1.49 [ 3943.469893] RBP: ffff88815ef47f18 R08: =
ffffed1083854f64 R09: ffffed1083854f64
Nov 11 21:26:13 10.243.1.49 [ 3943.497833] R10: ffff88841c2a7b1b R11: =
ffffed1083854f63 R12: ffff88815ef47f58
Nov 11 21:26:13 10.243.1.49 [ 3943.526730] R13: 0000000000000010 R14: =
0000000000000000 R15: 0000000000000000
Nov 11 21:26:13 10.243.1.49 [ 3943.554742] FS:  00007f7312ffe700(0000) =
GS:ffff88841c280000(0000) knlGS:0000000000000000
Nov 11 21:26:13 10.243.1.49 [ 3943.585690] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 11 21:26:13 10.243.1.49 [ 3943.609617] CR2: 0000000000000000 CR3: =
000000016e080005 CR4: 00000000003706e0
Nov 11 21:26:13 10.243.1.49 [ 3943.637821] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 11 21:26:13 10.243.1.49 [ 3943.665965] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 11 21:26:13 10.243.1.49 [ 3943.694083] Call Trace:
Nov 11 21:26:13 10.243.1.49 [ 3943.708081]  <TASK>
Nov 11 21:26:13 10.243.1.49 [ 3943.722275]  =
syscall_exit_to_user_mode+0xd/0x90
Nov 11 21:26:13 10.243.1.49 [ 3943.742387]  do_syscall_64+0x50/0xb0
Nov 11 21:26:13 10.243.1.49 [ 3943.759505]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 11 21:26:13 10.243.1.49 [ 3943.780956] RIP: 0033:0x7f735de5a940
Nov 11 21:26:13 10.243.1.49 [ 3943.797910] Code: 77 ff ff bf 02 00 00 10 =
8b 44 24 0c 48 98 48 89 c6 48 8b 04 24 48 89 c2 4c 8b 54 24 38 41 b8 00 =
00 00 00 b8 9d 00 00 00 0f 05 <48> 89 44 24 30 48 8b 44 24 30 89 44 24 =
2c 8b 44 24 28 be 00 00 00
Nov 11 21:26:13 10.243.1.49 [ 3943.867297] RSP: 002b:00007f7312fee340 =
EFLAGS: 00000202 ORIG_RAX: 000000000000009d
Nov 11 21:26:13 10.243.1.49 [ 3943.896714] RAX: 0000000000000000 RBX: =
0000000000000f64 RCX: 00007f735de5a940
Nov 11 21:26:13 10.243.1.49 [ 3943.925810] RDX: 00000000c0186d03 RSI: =
000000000000000d RDI: 0000000010000002
Nov 11 21:26:13 10.243.1.49 [ 3943.953912] RBP: 00007f7312fee520 R08: =
0000000000000000 R09: 00007ffc09389080
Nov 11 21:26:13 10.243.1.49 [ 3943.982042] R10: 00007f7312fee4f0 R11: =
0000000000000202 R12: 00007f7312fee600
Nov 11 21:26:13 10.243.1.49 [ 3944.010078] R13: 0000000000000000 R14: =
00000000360f356d R15: 00007f7312fee580
Nov 11 21:26:13 10.243.1.49 [ 3944.038147]  </TASK>
Nov 11 21:26:13 10.243.1.49 [ 3944.051224] irq event stamp: 3849
Nov 11 21:26:13 10.243.1.49 [ 3944.067708] hardirqs last  enabled at =
(3857): [<ffffffffa41aaac2>] __up_console_sem+0x62/0x70
Nov 11 21:26:13 10.243.1.49 [ 3944.099955] hardirqs last disabled at =
(3864): [<ffffffffa41aaaa7>] __up_console_sem+0x47/0x70
Nov 11 21:26:13 10.243.1.49 [ 3944.132084] softirqs last  enabled at =
(3156): [<ffffffffa5400403>] __do_softirq+0x403/0x57b
Nov 11 21:26:13 10.243.1.49 [ 3944.163602] softirqs last disabled at =
(3145): [<ffffffffa40d261d>] irq_exit_rcu+0x7d/0x150
Nov 11 21:26:13 10.243.1.49 [ 3944.194885] ---[ end trace =
87ffbd6a737b5b8c ]---
Nov 11 21:26:42 10.243.1.49 [ 3973.340652] ------------[ cut here =
]------------
Nov 11 21:26:42 10.243.1.49 [ 3973.340659] list_del corruption, =
ffff888151798240->next is LIST_POISON1 (dead000000000100)
Nov 11 21:26:42 10.243.1.49 [ 3973.340669] EVL: RxWorker1 switching =
in-band [pid=3D16135, excpt=3D6, __list_del_entry_valid+0xc5/0x120]
Nov 11 21:26:43 10.243.1.49 [ 3973.443226] WARNING: CPU: 9 PID: 16135 at =
lib/list_debug.c:55 __list_del_entry_valid+0xc5/0x120
Nov 11 21:26:43 10.243.1.49 [ 3973.443250] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich intel_cstate pcspkr =
intel_pch_thermal input_leds sg joydev ftdi_sio i2c_smbus mfd_core mei =
acpi_ipmi ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c ast drm_vram_helper sd_mod drm_kms_helper sr_mod cdrom t10_pi =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm
Nov 11 21:26:43 10.243.1.49
Nov 11 21:26:43 10.243.1.49 [ 3973.443573]  ixgbe igb ahci libahci =
crc32c_intel libata mdio ptp i2c_algo_bit pps_core dca
Nov 11 21:26:43 10.243.1.49 [ 3973.443616] CPU: 9 PID: 16135 Comm: =
RxWorker1 Tainted: G        W         5.15.77evl-gae6080e09d9a #1
Nov 11 21:26:43 10.243.1.49 [ 3973.443629] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 11 21:26:43 10.243.1.49 [ 3973.443634] IRQ stage: Linux
Nov 11 21:26:43 10.243.1.49 [ 3973.443639] RIP: =
0010:__list_del_entry_valid+0xc5/0x120
Nov 11 21:26:43 10.243.1.49 [ 3973.443654] Code: c0 eb e0 48 89 de 48 c7 =
c7 00 0c 82 a5 e8 7c fa 8b 00 0f 0b 31 c0 eb cb 4c 89 e2 48 89 de 48 c7 =
c7 60 0c 82 a5 e8 64 fa 8b 00 <0f> 0b 31 c0 eb b3 4c 89 ea 48 89 de 48 =
c7 c7 c0 0c 82 a5 e8 4c fa
Nov 11 21:26:43 10.243.1.49 [ 3973.443664] RSP: 0018:ffff88815ef47ac8 =
EFLAGS: 00010082
Nov 11 21:26:43 10.243.1.49 [ 3973.443674] RAX: 0000000000000000 RBX: =
ffff888151798240 RCX: 0000000000000027
Nov 11 21:26:43 10.243.1.49 [ 3973.443682] RDX: 0000000000000027 RSI: =
dffffc0000000000 RDI: ffff88841c2a7b18
Nov 11 21:26:43 10.243.1.49 [ 3973.443690] RBP: ffff88815ef47ae0 R08: =
ffffed1083854f64 R09: ffffed1083854f64
Nov 11 21:26:43 10.243.1.49 [ 3973.443698] R10: ffff88841c2a7b1b R11: =
ffffed1083854f63 R12: dead000000000100
Nov 11 21:26:43 10.243.1.49 [ 3973.443706] R13: dead000000000122 R14: =
ffff888151798000 R15: ffff888145380000
Nov 11 21:26:43 10.243.1.49 [ 3973.443714] FS:  00007f7312ffe700(0000) =
GS:ffff88841c280000(0000) knlGS:0000000000000000
Nov 11 21:26:43 10.243.1.49 [ 3973.443724] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 11 21:26:43 10.243.1.49 [ 3973.443732] CR2: 0000000000000000 CR3: =
000000016e080005 CR4: 00000000003706e0
Nov 11 21:26:43 10.243.1.49 [ 3973.443739] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 11 21:26:43 10.243.1.49 [ 3973.443746] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 11 21:26:44 10.243.1.49 [ 3973.443753] Call Trace:
Nov 11 21:26:44 10.243.1.49 [ 3973.443756]  <TASK>
Nov 11 21:26:44 10.243.1.49 [ 3973.443775]  =
__untrack_event.part.9+0x26/0xe0
Nov 11 21:26:44 10.243.1.49 [ 3973.443812]  =
monitor_oob_ioctl+0x1356/0x1490
Nov 11 21:26:44 10.243.1.49 [ 3973.443873]  ? enter_monitor+0x160/0x160
Nov 11 21:26:44 10.243.1.49 [ 3973.443894]  ? =
handle_irq_pipelined_finish+0xbe/0x240
Nov 11 21:26:44 10.243.1.49 [ 3973.443968]  ? =
do_raw_spin_lock+0x119/0x1e0
Nov 11 21:26:44 10.243.1.49 [ 3973.443987]  ? spin_dump+0x90/0x90
Nov 11 21:26:44 10.243.1.49 [ 3973.444024]  ? =
__kasan_check_read+0x11/0x20
Nov 11 21:26:44 10.243.1.49 [ 3973.444087]  EVL_ioctl+0x81/0xf0
Nov 11 21:26:44 10.243.1.49 [ 3973.444123]  do_oob_syscall+0x699/0x6b0
Nov 11 21:26:44 10.243.1.49 [ 3973.444152]  ? =
prepare_for_signal+0x180/0x180
Nov 11 21:26:44 10.243.1.49 [ 3973.444217]  =
handle_oob_syscall+0x189/0x230
Nov 11 21:26:44 10.243.1.49 [ 3973.444246]  ? =
handle_pipelined_syscall+0x820/0x820
Nov 11 21:26:44 10.243.1.49 [ 3973.444283]  ? =
rcu_read_lock_sched_held+0x5b/0xd0
Nov 11 21:26:44 10.243.1.49 [ 3973.444305]  ? =
rcu_read_lock_any_held.part.15+0x20/0x20
Nov 11 21:26:44 10.243.1.49 [ 3973.444347]  pipeline_syscall+0xa7/0x1c0
Nov 11 21:26:44 10.243.1.49 [ 3973.444387]  =
syscall_enter_from_user_mode+0x47/0x110
Nov 11 21:26:44 10.243.1.49 [ 3973.444414]  do_syscall_64+0x15/0xb0
Nov 11 21:26:44 10.243.1.49 [ 3973.444434]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 11 21:26:44 10.243.1.49 [ 3973.444448] RIP: 0033:0x7f735de5a940
Nov 11 21:26:44 10.243.1.49 [ 3973.444460] Code: 77 ff ff bf 02 00 00 10 =
8b 44 24 0c 48 98 48 89 c6 48 8b 04 24 48 89 c2 4c 8b 54 24 38 41 b8 00 =
00 00 00 b8 9d 00 00 00 0f 05 <48> 89 44 24 30 48 8b 44 24 30 89 44 24 =
2c 8b 44 24 28 be 00 00 00
Nov 11 21:26:44 10.243.1.49 [ 3973.444469] RSP: 002b:00007f7312fee340 =
EFLAGS: 00000202 ORIG_RAX: 000000000000009d
Nov 11 21:26:44 10.243.1.49 [ 3973.444480] RAX: ffffffffffffffda RBX: =
0000000000000f85 RCX: 00007f735de5a940
Nov 11 21:26:44 10.243.1.49 [ 3973.444488] RDX: 00000000c0186d03 RSI: =
000000000000000d RDI: 0000000010000002
Nov 11 21:26:44 10.243.1.49 [ 3973.444495] RBP: 00007f7312fee520 R08: =
0000000000000000 R09: 00007ffc09389080
Nov 11 21:26:44 10.243.1.49 [ 3973.444502] R10: 00007f7312fee4f0 R11: =
0000000000000202 R12: 00007f7312fee600
Nov 11 21:26:44 10.243.1.49 [ 3973.444510] R13: 0000000000000000 R14: =
0000000025bbabb3 R15: 00007f7312fee580
Nov 11 21:26:44 10.243.1.49 [ 3973.444591]  </TASK>
Nov 11 21:26:44 10.243.1.49 [ 3973.444595] irq event stamp: 3945
Nov 11 21:26:44 10.243.1.49 [ 3973.444598] hardirqs last  enabled at =
(3945): [<ffffffffa51330bc>] _raw_spin_unlock_irqrestore+0x4c/0x50
Nov 11 21:26:44 10.243.1.49 [ 3973.444613] hardirqs last disabled at =
(3944): [<ffffffffa5132e2b>] _raw_spin_lock_irqsave+0x1b/0x60
Nov 11 21:26:44 10.243.1.49 [ 3973.444627] softirqs last  enabled at =
(3156): [<ffffffffa5400403>] __do_softirq+0x403/0x57b
Nov 11 21:26:44 10.243.1.49 [ 3973.444641] softirqs last disabled at =
(3145): [<ffffffffa40d261d>] irq_exit_rcu+0x7d/0x150
Nov 11 21:26:44 10.243.1.49 [ 3973.444658] ---[ end trace =
87ffbd6a737b5b8d ]---
Nov 11 21:26:45 10.243.1.49 [ 3975.416141] EVL: RxWorker1 resuming =
out-of-band [pid=3D16135, excpt=3D6, __list_del_entry_valid+0xc7/0x120]
Nov 11 21:26:45 10.243.1.49 [ 3975.453142] ------------[ cut here =
]------------
Nov 11 21:26:45 10.243.1.49 [ 3975.471367] syscall 157 left IRQs =
disabled
Nov 11 21:26:45 10.243.1.49 [ 3975.471418] WARNING: CPU: 9 PID: 16135 at =
kernel/entry/common.c:353 syscall_exit_to_user_mode_prepare+0x37/0x270
Nov 11 21:26:45 10.243.1.49 [ 3975.523213] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich intel_cstate pcspkr =
intel_pch_thermal input_leds sg joydev ftdi_sio i2c_smbus mfd_core mei =
acpi_ipmi ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c ast drm_vram_helper sd_mod drm_kms_helper sr_mod cdrom t10_pi =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm
Nov 11 21:26:45 10.243.1.49
Nov 11 21:26:45 10.243.1.49 [ 3975.523761]  ixgbe igb ahci libahci =
crc32c_intel libata mdio ptp i2c_algo_bit pps_core dca
Nov 11 21:26:45 10.243.1.49 [ 3975.857517] CPU: 9 PID: 16135 Comm: =
RxWorker1 Tainted: G        W         5.15.77evl-gae6080e09d9a #1
Nov 11 21:26:45 10.243.1.49 [ 3975.891006] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 11 21:26:45 10.243.1.49 [ 3975.920914] IRQ stage: Linux
Nov 11 21:26:45 10.243.1.49 [ 3975.935389] RIP: =
0010:syscall_exit_to_user_mode_prepare+0x37/0x270
Nov 11 21:26:45 10.243.1.49 [ 3975.961180] Code: 41 55 41 54 49 89 fc 53 =
4c 8b 68 08 48 8b 5f 78 eb 36 e8 0c fe f2 00 85 c0 74 1c 48 63 f3 48 c7 =
c7 70 66 ca a5 e8 42 f0 ec 00 <0f> 0b fb e8 e1 a1 0d 00 e8 bc af fd ff =
41 f6 c5 76 75 3a 5b 41 5c
Nov 11 21:26:45 10.243.1.49 [ 3976.029965] RSP: 0018:ffff88815ef47f00 =
EFLAGS: 00010282
Nov 11 21:26:45 10.243.1.49 [ 3976.051995] RAX: 0000000000000000 RBX: =
000000000000009d RCX: 0000000000000027
Nov 11 21:26:45 10.243.1.49 [ 3976.079868] RDX: 0000000000000027 RSI: =
dffffc0000000000 RDI: ffff88841c2a7b18
Nov 11 21:26:45 10.243.1.49 [ 3976.107756] RBP: ffff88815ef47f18 R08: =
ffffed1083854f64 R09: ffffed1083854f64
Nov 11 21:26:45 10.243.1.49 [ 3976.135689] R10: ffff88841c2a7b1b R11: =
ffffed1083854f63 R12: ffff88815ef47f58
Nov 11 21:26:45 10.243.1.49 [ 3976.163639] R13: 0000000000000010 R14: =
0000000000000000 R15: 0000000000000000
Nov 11 21:26:45 10.243.1.49 [ 3976.191612] FS:  00007f7312ffe700(0000) =
GS:ffff88841c280000(0000) knlGS:0000000000000000
Nov 11 21:26:45 10.243.1.49 [ 3976.222528] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 11 21:26:45 10.243.1.49 [ 3976.246420] CR2: 0000000000000000 CR3: =
000000016e080005 CR4: 00000000003706e0
Nov 11 21:26:45 10.243.1.49 [ 3976.274590] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 11 21:26:45 10.243.1.49 [ 3976.302728] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 11 21:26:45 10.243.1.49 [ 3976.330855] Call Trace:
Nov 11 21:26:45 10.243.1.49 [ 3976.344849]  <TASK>
Nov 11 21:26:45 10.243.1.49 [ 3976.358680]  =
syscall_exit_to_user_mode+0xd/0x90
Nov 11 21:26:45 10.243.1.49 [ 3976.378802]  do_syscall_64+0x50/0xb0
Nov 11 21:26:45 10.243.1.49 [ 3976.395857]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 11 21:26:45 10.243.1.49 [ 3976.417301] RIP: 0033:0x7f735de5a940
Nov 11 21:26:46 10.243.1.49 [ 3976.434233] Code: 77 ff ff bf 02 00 00 10 =
8b 44 24 0c 48 98 48 89 c6 48 8b 04 24 48 89 c2 4c 8b 54 24 38 41 b8 00 =
00 00 00 b8 9d 00 00 00 0f 05 <48> 89 44 24 30 48 8b 44 24 30 89 44 24 =
2c 8b 44 24 28 be 00 00 00
Nov 11 21:26:46 10.243.1.49 [ 3976.503605] RSP: 002b:00007f7312fee340 =
EFLAGS: 00000202 ORIG_RAX: 000000000000009d
Nov 11 21:26:46 10.243.1.49 [ 3976.533012] RAX: 0000000000000000 RBX: =
0000000000000f85 RCX: 00007f735de5a940
Nov 11 21:26:46 10.243.1.49 [ 3976.562080] RDX: 00000000c0186d03 RSI: =
000000000000000d RDI: 0000000010000002
Nov 11 21:26:46 10.243.1.49 [ 3976.590164] RBP: 00007f7312fee520 R08: =
0000000000000000 R09: 00007ffc09389080
Nov 11 21:26:46 10.243.1.49 [ 3976.618274] R10: 00007f7312fee4f0 R11: =
0000000000000202 R12: 00007f7312fee600
Nov 11 21:26:46 10.243.1.49 [ 3976.646281] R13: 0000000000000000 R14: =
0000000025bbabb3 R15: 00007f7312fee580
Nov 11 21:26:46 10.243.1.49 [ 3976.674323]  </TASK>
Nov 11 21:26:46 10.243.1.49 [ 3976.687394] irq event stamp: 4671
Nov 11 21:26:46 10.243.1.49 [ 3976.703858] hardirqs last  enabled at =
(4679): [<ffffffffa41aaac2>] __up_console_sem+0x62/0x70
Nov 11 21:26:46 10.243.1.49 [ 3976.736098] hardirqs last disabled at =
(4686): [<ffffffffa41aaaa7>] __up_console_sem+0x47/0x70
Nov 11 21:26:46 10.243.1.49 [ 3976.768189] softirqs last  enabled at =
(3960): [<ffffffffa5400403>] __do_softirq+0x403/0x57b
Nov 11 21:26:46 10.243.1.49 [ 3976.799696] softirqs last disabled at =
(3949): [<ffffffffa40d261d>] irq_exit_rcu+0x7d/0x150
Nov 11 21:26:46 10.243.1.49 [ 3976.830927] ---[ end trace =
87ffbd6a737b5b8e ]---
Nov 11 21:26:47 10.243.1.49 [ 3978.390616] ------------[ cut here =
]------------
Nov 11 21:26:48 10.243.1.49 [ 3978.390624] list_del corruption, =
ffff888151798240->next is LIST_POISON1 (dead000000000100)
Nov 11 21:26:48 10.243.1.49 [ 3978.390634] EVL: RxWorker1 switching =
in-band [pid=3D16135, excpt=3D6, __list_del_entry_valid+0xc5/0x120]
Nov 11 21:26:48 10.243.1.49 [ 3978.493295] WARNING: CPU: 9 PID: 16135 at =
lib/list_debug.c:55 __list_del_entry_valid+0xc5/0x120
Nov 11 21:26:48 10.243.1.49 [ 3978.493321] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich intel_cstate pcspkr =
intel_pch_thermal input_leds sg joydev ftdi_sio i2c_smbus mfd_core mei =
acpi_ipmi ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c ast drm_vram_helper sd_mod drm_kms_helper sr_mod cdrom t10_pi =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm
Nov 11 21:26:48 10.243.1.49
Nov 11 21:26:48 10.243.1.49 [ 3978.493644]  ixgbe igb ahci libahci =
crc32c_intel libata mdio ptp i2c_algo_bit pps_core dca
Nov 11 21:26:48 10.243.1.49 [ 3978.493688] CPU: 9 PID: 16135 Comm: =
RxWorker1 Tainted: G        W         5.15.77evl-gae6080e09d9a #1
Nov 11 21:26:48 10.243.1.49 [ 3978.493701] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 11 21:26:48 10.243.1.49 [ 3978.493707] IRQ stage: Linux
Nov 11 21:26:48 10.243.1.49 [ 3978.493711] RIP: =
0010:__list_del_entry_valid+0xc5/0x120
Nov 11 21:26:48 10.243.1.49 [ 3978.493726] Code: c0 eb e0 48 89 de 48 c7 =
c7 00 0c 82 a5 e8 7c fa 8b 00 0f 0b 31 c0 eb cb 4c 89 e2 48 89 de 48 c7 =
c7 60 0c 82 a5 e8 64 fa 8b 00 <0f> 0b 31 c0 eb b3 4c 89 ea 48 89 de 48 =
c7 c7 c0 0c 82 a5 e8 4c fa
Nov 11 21:26:48 10.243.1.49 [ 3978.493736] RSP: 0018:ffff88815ef47ac8 =
EFLAGS: 00010082
Nov 11 21:26:48 10.243.1.49 [ 3978.493745] RAX: 0000000000000000 RBX: =
ffff888151798240 RCX: 0000000000000027
Nov 11 21:26:48 10.243.1.49 [ 3978.493753] RDX: 0000000000000027 RSI: =
dffffc0000000000 RDI: ffff88841c2a7b18
Nov 11 21:26:48 10.243.1.49 [ 3978.493761] RBP: ffff88815ef47ae0 R08: =
ffffed1083854f64 R09: ffffed1083854f64
Nov 11 21:26:48 10.243.1.49 [ 3978.493770] R10: ffff88841c2a7b1b R11: =
ffffed1083854f63 R12: dead000000000100
Nov 11 21:26:48 10.243.1.49 [ 3978.493778] R13: dead000000000122 R14: =
ffff888151798000 R15: ffff888145380000
Nov 11 21:26:48 10.243.1.49 [ 3978.493786] FS:  00007f7312ffe700(0000) =
GS:ffff88841c280000(0000) knlGS:0000000000000000
Nov 11 21:26:48 10.243.1.49 [ 3978.493796] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 11 21:26:48 10.243.1.49 [ 3978.493804] CR2: 0000000000000000 CR3: =
000000016e080005 CR4: 00000000003706e0
Nov 11 21:26:49 10.243.1.49 [ 3978.493811] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 11 21:26:49 10.243.1.49 [ 3978.493818] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 11 21:26:49 10.243.1.49 [ 3978.493825] Call Trace:
Nov 11 21:26:49 10.243.1.49 [ 3978.493828]  <TASK>
Nov 11 21:26:49 10.243.1.49 [ 3978.493847]  =
__untrack_event.part.9+0x26/0xe0
Nov 11 21:26:49 10.243.1.49 [ 3978.493884]  =
monitor_oob_ioctl+0x1356/0x1490
Nov 11 21:26:49 10.243.1.49 [ 3978.493945]  ? enter_monitor+0x160/0x160
Nov 11 21:26:49 10.243.1.49 [ 3978.493987]  ? rcu_nmi_exit+0x9e/0xc0
Nov 11 21:26:49 10.243.1.49 [ 3978.494010]  ? =
handle_irq_pipelined_finish+0xbe/0x240
Nov 11 21:26:49 10.243.1.49 [ 3978.494048]  ? =
do_raw_spin_lock+0x119/0x1e0
Nov 11 21:26:49 10.243.1.49 [ 3978.494066]  ? spin_dump+0x90/0x90
Nov 11 21:26:49 10.243.1.49 [ 3978.494086]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Nov 11 21:26:49 10.243.1.49 [ 3978.494115]  ? =
__kasan_check_read+0x11/0x20
Nov 11 21:26:49 10.243.1.49 [ 3978.494178]  EVL_ioctl+0x81/0xf0
Nov 11 21:26:49 10.243.1.49 [ 3978.494214]  do_oob_syscall+0x699/0x6b0
Nov 11 21:26:49 10.243.1.49 [ 3978.494243]  ? =
prepare_for_signal+0x180/0x180
Nov 11 21:26:49 10.243.1.49 [ 3978.494273]  ? do_oob_irq+0x283/0x7e0
Nov 11 21:26:49 10.243.1.49 [ 3978.494315]  =
handle_oob_syscall+0x189/0x230
Nov 11 21:26:49 10.243.1.49 [ 3978.494344]  ? =
handle_pipelined_syscall+0x820/0x820
Nov 11 21:26:49 10.243.1.49 [ 3978.494381]  ? =
rcu_read_lock_sched_held+0x5b/0xd0
Nov 11 21:26:49 10.243.1.49 [ 3978.494403]  ? =
rcu_read_lock_any_held.part.15+0x20/0x20
Nov 11 21:26:49 10.243.1.49 [ 3978.494446]  pipeline_syscall+0xa7/0x1c0
Nov 11 21:26:49 10.243.1.49 [ 3978.494486]  =
syscall_enter_from_user_mode+0x47/0x110
Nov 11 21:26:49 10.243.1.49 [ 3978.494512]  do_syscall_64+0x15/0xb0
Nov 11 21:26:49 10.243.1.49 [ 3978.494533]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 11 21:26:49 10.243.1.49 [ 3978.494546] RIP: 0033:0x7f735de5a940
Nov 11 21:26:49 10.243.1.49 [ 3978.494558] Code: 77 ff ff bf 02 00 00 10 =
8b 44 24 0c 48 98 48 89 c6 48 8b 04 24 48 89 c2 4c 8b 54 24 38 41 b8 00 =
00 00 00 b8 9d 00 00 00 0f 05 <48> 89 44 24 30 48 8b 44 24 30 89 44 24 =
2c 8b 44 24 28 be 00 00 00
Nov 11 21:26:49 10.243.1.49 [ 3978.494567] RSP: 002b:00007f7312fee340 =
EFLAGS: 00000202 ORIG_RAX: 000000000000009d
Nov 11 21:26:49 10.243.1.49 [ 3978.494578] RAX: ffffffffffffffda RBX: =
0000000000000f8a RCX: 00007f735de5a940
Nov 11 21:26:49 10.243.1.49 [ 3978.494586] RDX: 00000000c0186d03 RSI: =
000000000000000d RDI: 0000000010000002
Nov 11 21:26:49 10.243.1.49 [ 3978.494593] RBP: 00007f7312fee520 R08: =
0000000000000000 R09: 00007ffc09389080
Nov 11 21:26:49 10.243.1.49 [ 3978.494601] R10: 00007f7312fee4f0 R11: =
0000000000000202 R12: 00007f7312fee600
Nov 11 21:26:49 10.243.1.49 [ 3978.494608] R13: 0000000000000000 R14: =
0000000028b61d36 R15: 00007f7312fee580
Nov 11 21:26:49 10.243.1.49 [ 3978.494689]  </TASK>
Nov 11 21:26:49 10.243.1.49 [ 3978.494693] irq event stamp: 4767
Nov 11 21:26:49 10.243.1.49 [ 3978.494696] hardirqs last  enabled at =
(4767): [<ffffffffa51330bc>] _raw_spin_unlock_irqrestore+0x4c/0x50
Nov 11 21:26:49 10.243.1.49 [ 3978.494711] hardirqs last disabled at =
(4766): [<ffffffffa5132e2b>] _raw_spin_lock_irqsave+0x1b/0x60
Nov 11 21:26:50 10.243.1.49 [ 3978.494725] softirqs last  enabled at =
(3960): [<ffffffffa5400403>] __do_softirq+0x403/0x57b
Nov 11 21:26:50 10.243.1.49 [ 3978.494740] softirqs last disabled at =
(3949): [<ffffffffa40d261d>] irq_exit_rcu+0x7d/0x150
Nov 11 21:26:50 10.243.1.49 [ 3978.494756] ---[ end trace =
87ffbd6a737b5b8f ]---
Nov 11 21:26:50 10.243.1.49 [ 3980.524993] EVL: RxWorker1 resuming =
out-of-band [pid=3D16135, excpt=3D6, __list_del_entry_valid+0xc7/0x120]
Nov 11 21:26:50 10.243.1.49 [ 3980.561838] ------------[ cut here =
]------------
Nov 11 21:26:50 10.243.1.49 [ 3980.580024] syscall 157 left IRQs =
disabled
Nov 11 21:26:50 10.243.1.49 [ 3980.580075] WARNING: CPU: 9 PID: 16135 at =
kernel/entry/common.c:353 syscall_exit_to_user_mode_prepare+0x37/0x270
Nov 11 21:26:50 10.243.1.49 [ 3980.631745] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
mxm_wmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich intel_cstate pcspkr =
intel_pch_thermal input_leds sg joydev ftdi_sio i2c_smbus mfd_core mei =
acpi_ipmi ioatdma ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c ast drm_vram_helper sd_mod drm_kms_helper sr_mod cdrom t10_pi =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm
Nov 11 21:26:50 10.243.1.49
Nov 11 21:26:50 10.243.1.49 [ 3980.632245]  ixgbe igb ahci libahci =
crc32c_intel libata mdio ptp i2c_algo_bit pps_core dca
Nov 11 21:26:50 10.243.1.49 [ 3980.965791] CPU: 9 PID: 16135 Comm: =
RxWorker1 Tainted: G        W         5.15.77evl-gae6080e09d9a #1
Nov 11 21:26:50 10.243.1.49 [ 3980.999328] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 11 21:26:50 10.243.1.49 [ 3981.029249] IRQ stage: Linux
Nov 11 21:26:50 10.243.1.49 [ 3981.043760] RIP: =
0010:syscall_exit_to_user_mode_prepare+0x37/0x270
Nov 11 21:26:50 10.243.1.49 [ 3981.069293] Code: 41 55 41 54 49 89 fc 53 =
4c 8b 68 08 48 8b 5f 78 eb 36 e8 0c fe f2 00 85 c0 74 1c 48 63 f3 48 c7 =
c7 70 66 ca a5 e8 42 f0 ec 00 <0f> 0b fb e8 e1 a1 0d 00 e8 bc af fd ff =
41 f6 c5 76 75 3a 5b 41 5c
Nov 11 21:26:50 10.243.1.49 [ 3981.138077] RSP: 0018:ffff88815ef47f00 =
EFLAGS: 00010282
Nov 11 21:26:50 10.243.1.49 [ 3981.160087] RAX: 0000000000000000 RBX: =
000000000000009d RCX: 0000000000000027
Nov 11 21:26:50 10.243.1.49 [ 3981.187931] RDX: 0000000000000027 RSI: =
dffffc0000000000 RDI: ffff88841c2a7b18
Nov 11 21:26:50 10.243.1.49 [ 3981.215800] RBP: ffff88815ef47f18 R08: =
ffffed1083854f64 R09: ffffed1083854f64
Nov 11 21:26:50 10.243.1.49 [ 3981.243717] R10: ffff88841c2a7b1b R11: =
ffffed1083854f63 R12: ffff88815ef47f58
Nov 11 21:26:50 10.243.1.49 [ 3981.271663] R13: 0000000000000010 R14: =
0000000000000000 R15: 0000000000000000
Nov 11 21:26:50 10.243.1.49 [ 3981.299646] FS:  00007f7312ffe700(0000) =
GS:ffff88841c280000(0000) knlGS:0000000000000000
Nov 11 21:26:50 10.243.1.49 [ 3981.330571] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 11 21:26:50 10.243.1.49 [ 3981.354488] CR2: 0000000000000000 CR3: =
000000016e080005 CR4: 00000000003706e0
Nov 11 21:26:50 10.243.1.49 [ 3981.382620] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 11 21:26:50 10.243.1.49 [ 3981.410763] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 11 21:26:51 10.243.1.49 [ 3981.438857] Call Trace:
Nov 11 21:26:51 10.243.1.49 [ 3981.452814]  <TASK>
Nov 11 21:26:51 10.243.1.49 [ 3981.466641]  =
syscall_exit_to_user_mode+0xd/0x90
Nov 11 21:26:51 10.243.1.49 [ 3981.486739]  do_syscall_64+0x50/0xb0
Nov 11 21:26:51 10.243.1.49 [ 3981.503788]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 11 21:26:51 10.243.1.49 [ 3981.525232] RIP: 0033:0x7f735de5a940
Nov 11 21:26:51 10.243.1.49 [ 3981.542188] Code: 77 ff ff bf 02 00 00 10 =
8b 44 24 0c 48 98 48 89 c6 48 8b 04 24 48 89 c2 4c 8b 54 24 38 41 b8 00 =
00 00 00 b8 9d 00 00 00 0f 05 <48> 89 44 24 30 48 8b 44 24 30 89 44 24 =
2c 8b 44 24 28 be 00 00 00
Nov 11 21:26:51 10.243.1.49 [ 3981.611725] RSP: 002b:00007f7312fee340 =
EFLAGS: 00000202 ORIG_RAX: 000000000000009d
Nov 11 21:26:51 10.243.1.49 [ 3981.641121] RAX: 0000000000000000 RBX: =
0000000000000f8a RCX: 00007f735de5a940
Nov 11 21:26:51 10.243.1.49 [ 3981.670236] RDX: 00000000c0186d03 RSI: =
000000000000000d RDI: 0000000010000002
Nov 11 21:26:51 10.243.1.49 [ 3981.698325] RBP: 00007f7312fee520 R08: =
0000000000000000 R09: 00007ffc09389080
Nov 11 21:26:51 10.243.1.49 [ 3981.726468] R10: 00007f7312fee4f0 R11: =
0000000000000202 R12: 00007f7312fee600
Nov 11 21:26:51 10.243.1.49 [ 3981.754484] R13: 0000000000000000 R14: =
0000000028b61d36 R15: 00007f7312fee580
Nov 11 21:26:51 10.243.1.49 [ 3981.782554]  </TASK>
Nov 11 21:26:51 10.243.1.49 [ 3981.795620] irq event stamp: 5475
Nov 11 21:26:51 10.243.1.49 [ 3981.812071] hardirqs last  enabled at =
(5483): [<ffffffffa41aaac2>] __up_console_sem+0x62/0x70
Nov 11 21:26:51 10.243.1.49 [ 3981.844286] hardirqs last disabled at =
(5490): [<ffffffffa41aaaa7>] __up_console_sem+0x47/0x70
Nov 11 21:26:51 10.243.1.49 [ 3981.876372] softirqs last  enabled at =
(4782): [<ffffffffa5400403>] __do_softirq+0x403/0x57b
Nov 11 21:26:51 10.243.1.49 [ 3981.907874] softirqs last disabled at =
(4771): [<ffffffffa40d261d>] irq_exit_rcu+0x7d/0x150
Nov 11 21:26:51 10.243.1.49 [ 3981.939107] ---[ end trace =
87ffbd6a737b5b90 ]---
------=_NextPart_001_0001_01D8F5DA.AB733740--

------=_NextPart_000_0000_01D8F5DA.AB733740
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
9w0BCQUxDxcNMjIxMTExMjEzNDEzWjAvBgkqhkiG9w0BCQQxIgQgdXgsUjpOjmEtIgO+ENoLGkjz
cm8ar9M5xcS7rj0J1ekwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQAr
CyNY9901dvrqbVrhrhyNxYDhYnZ16LcC+XKZAsaKpyPSdjrmQlMWKFYanxuKPgEkIj4+lxB4zPT2
0iBeEzoBqXRJ5qHIXf6YEuyjut7XeUS65ZVAzNpenbaSlmqZTnqzADH8haQNLqS7zgHowh141Dgj
CEWFTgYqR/jWu9boFNMsbvCTmoi6VYXssOr4TOQB6uhPnqIxJqs84TnwipgFzbhQKkrsKPxpNiBB
+qFcXejZ6hwv0F9Pga2u/uQoGMcLfdiamTjdgO2L685wphrrdkX8dUOCJMtmARYmv7kpmu20ZtG4
Cnx9vzV3oawAzxwotZnXGruMjKjjVrykcEumAAAAAAAA

------=_NextPart_000_0000_01D8F5DA.AB733740--
