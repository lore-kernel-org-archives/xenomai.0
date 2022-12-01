Received: from mx0a-001f5801.pphosted.com (mx0b-001f5801.pphosted.com [148.163.159.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB0CA20
	for <xenomai@lists.linux.dev>; Thu,  1 Dec 2022 20:26:02 +0000 (UTC)
Received: from pps.filterd (m0090335.ppops.net [127.0.0.1])
	by mx0b-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1JSX55011039;
	Thu, 1 Dec 2022 12:01:05 -0800
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02lp0180.outbound.protection.office365.us [23.103.199.180])
	by mx0b-001f5801.pphosted.com (PPS) with ESMTPS id 3m6kcn9g0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Dec 2022 12:01:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=ufFwQh5yyoi/uV+HiNRTKVPG25LHv22UPPcy+/2apUSjaI8RLYKzPdukjLyMNu1WJN5egBPiKrMOQUnuwhiIgyVubXWdFG/tv8Lnqd/8Pe0TdSVMHYzbiOE1ykvUuWBzMpE1JbRIBwMBoYMwhCCR8FhbfbQSR1BVweauSre0rXoPW/a+mvimTr5B8PwDnNR5z3yjXftsjGAzkZGImzvcbhDeKd7nXIoTgDuB17JRZkFopZNjN2UuI7sYJy+99D7ke3Siv6o6roKDnWL9v161BFaj0FV85soBMXvrRGL7MP2U7OLG9VcQGh4ObyPTw+p+4dGvD6TbpY1/R3uz7TnQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDCg0+7utBWQUBxFQxnx3ibZU5nEK/CfO2DAfs5fbwY=;
 b=WWk6IXV0QUWiInRP5FEtZD+9ybIrsjXLt9L0Ta5SNZhaLHwe3Tj9l/mnBfIF8ZExHmcukSZxSN2qyghKoO2XxNar1PaZzJEp21X8T+WpniB6uO3Q8wea2e45oJPl8rXXnDW9buPrifxQImiFso558ZONB7hUkR+tSYGFAaZ+4uV35fFWT85sb+2i/9koED93g/+Ueay31Swp5mg3uqd+RxvhS+3Kkq5tNBMuzKrjaasEZYGN3tauDjN07tdhffmHd69gZTbcmPbPE4JYg5pFn8jet0wH/zIer0LyC0TYgntxGP/UnDXnXNrcHnViJ5VPjCi4r3kP+m+AP/wn3Kprhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDCg0+7utBWQUBxFQxnx3ibZU5nEK/CfO2DAfs5fbwY=;
 b=dSRFJiGxdJ9i6MvLaiL/PFaALehRJT7A1KKbWB52KNHtEBzY+JYIkY6I5VdSsL5jhPtPT8ne1j5/UvHXAd9EpYarI8X0bi3iRIkewnQOZ7sZyHefO8zw7nwF7xJc58Ewki+FwwBfw3I+UyYAQOOBYT28r3hcbnrfQ3VTXDtNFKqgcjJEtBh/8EuTPZBLjKFNwoX0HJWNvVlaRX1zG/poY4zbjbbkPjoj3dhf7+tnrxMA0k9K4A12GBastvowPnefneYTpM+n0rQc5FqRQGWr08OB52XdVsqd+7B13hRT88AkEoAGaETVom7dlKVJGC/i9iL1DLRiGtBqFon/CEW7EA==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1001.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:175::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 1 Dec
 2022 20:01:02 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725%7]) with mapi id 15.20.5834.022; Thu, 1 Dec 2022
 20:01:02 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: Bryan Butler <Bryan.Butler@kratosdefense.com>,
        "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>,
        Shawn McManus <shawn.mcmanus@kratosdefense.com>
Subject: RE: [External] - Re: EVL Memory
Thread-Topic: [External] - Re: EVL Memory
Thread-Index: 
 Adjz0yff24VAOdNORJO8c3TjB/9lSwAgymPQAAE3ZMAAARoBAABtP6rQAH6X0oAAFuqKwAAYlRuAAA/9EKAABRGVgAAsa2CAAAwq7lAAKDcSAAAgIxWAAEP6SSAAYzsWgAAFcSNAAVlSalAAAyZ+gAAIpzogAFofRaAAL3JDAAALO44g
Date: Thu, 1 Dec 2022 20:01:02 +0000
Message-ID: 
 <PH1P110MB1050DA6B7C1C21B2866038CCE2149@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050307D7FC58A2B99A40094E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <877d04dm52.fsf@xenomai.org>
 <PH1P110MB1050221E0BC34BD641127901E2009@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87leodn9kv.fsf@xenomai.org>
 <PH1P110MB105002FA12DD4C10060A7B59E2059@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87zgcs4ma1.fsf@xenomai.org>
 <PH1P110MB10500F942C9666D27F48E154E2049@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87v8ng3vv7.fsf@xenomai.org> <87edu2dh2j.fsf@xenomai.org>
 <PH1P110MB10505104BB0814A3F46A86BCE2079@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87tu2xbk5k.fsf@xenomai.org> <87cz9kbrkr.fsf@xenomai.org>
 <PH1P110MB105079B5A344B300F33874E3E2089@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <877czothz0.fsf@xenomai.org>
 <BN2P110MB1288677543F1950D08808B3B8F0A9@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10502B0F1F62BFBA1CE3D3EBE2139@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87h6yj6mvg.fsf@xenomai.org>
 <PH1P110MB1050D4E123EE6368D98E071AE2139@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <0082bff2d91b0125ac60050159d3003e64b45bffa35e0c4f0ed9799e38b97b8c@mu>
 <87h6ygwi2l.fsf@xenomai.org> <875yevw5ln.fsf@xenomai.org>
In-Reply-To: <875yevw5ln.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB1001:EE_
x-ms-office365-filtering-correlation-id: 389df8ad-8b2e-4ce8-82ff-08dad3d6c604
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ekUUc0vAPFUDlaRU0Xnhwo7QAKb8NVszXXvaCIl8NEODyV2g39SJ7my9McWOiRnHXpRVVgpyVdX1t5zZnkbJl/o89FvqSHcDH7jjBBdn9fGMlYYZ79UZbjfH/IR6B1WAt3d8L8wlijnflSj8KTPA2OI0rg5ng6+7xLDeMjgDM26M2owoJ04BurYtPKAAq7ypOEHH6StUWt7MaBBcHgG8daZuApT7ISWzTiLMGRd53M+2C2+nFHevpUI1bPLAUlhahqR2uKCDgCMPm1D/bv0T+ZLERIsIWcvNqVOD/O4ITeUuZnmtacfABzJLkrhSSZyDq3X1QLFZotRymzlrJqb0FQb5LJ3u3iTaFmp+fqQh0HB0Tu0p3PGPWivaBIN37Sw0wTGZqnt65yauIEO0A/hyFed62vGZcbtKhQrbwU/Wa5xer9UAV1l+MZ9+LVKzT9TMeTpsQqCtQ/npE0ZWkRUahXSnQm/NEe4UEHZXsBo1RHr1UdGbBTTCPJHH9Vb0xVVY44dWXakGXAe0SyoM1SEjXP0zc9WuJ4XIYt8GDkzzMWwyDVV1O4FuNxQ2jl/UBuFECc83z0z/ItkVOFjpizULBlh3UIJvOyeUgny1LmoieyRwqNLq1P3umlIT08xGusTs
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39830400003)(451199015)(86362001)(41320700001)(55016003)(38070700005)(99936003)(107886003)(508600001)(33656002)(76116006)(71200400001)(8936002)(66946007)(9686003)(6506007)(6916009)(2906002)(66556008)(26005)(66446008)(4744005)(52536014)(66476007)(7696005)(64756008)(8676002)(5660300002)(54906003)(38100700002)(186003)(41300700001)(122000001)(4326008)(44832011)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 tI/EIYs5FKNB8PXdoQZoOeFpycilby4pll0E9/tgfh8bgS6SJ9wFBuuUAXD82tFe6M2T+AozoIa1h9unh5JLt0CKHTOjZPn8irkmMLvRK3xpfuxKzDDPeROo3bPqualFNH6dsg3cwn5lUisIMY/eJDcH54GXYclLIDEcxlfMIR2LqS7wFhgsGhwPmnQ4XuHdG++tAL72PwS6ZUuPQaTYQM4Y/0LXt53CM1oAEsjv8zTtG7gdoVSy62RicO3ux34hY4ukGdA4JyycOi5/eZAs4pEXi6AckjQqWcPwOE/86SMeOMfK0wrQPypr0G7i/xLdKQ6MJp2iIKtvr+rFkL8tIp6YHMLr3jPKotd8UcEQX/W9TBgPahR3k0X0bHFOHcm6QTZxxIGqv7+u+pcEkzParJEFcMpmciReCEKAEU9DzHg=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_01F2_01D90584.F5FE0E70"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AtICFBMBlF95rn6Ar3/rDzNwxfc2qRVPu4uZfg1JcvPuejaTAfROE8cmLKyG839MYlg0PWwlWvMj6Q9WZJsGFEbcejUDunIboGmoASmf6o2hqwdj+mKMM/fLukIAp4FTfjWusrzB5dbO4TwnK6xHJyM+eqx4EzX+T6gBi52VhKa2TAkqJqwpbpsjjjY4EGUbSQ9AxoRknNNLVH1CPevLiunW3aUk0SBj086+6INPjty6J+zeULwk0BGe4g7nmF7hG5UiUM9KAvJKy9WEkK1dFpE0bouBwBfUVoPbaY+NkQvehkcX5iiCV1IsMbRvKKojz7QS74++CcPfpQvON1BYbMnJFtid92Jj/kZ5b6os+16ANsbzdjd48hA5Mto0sLOdmSaOAPf9kvUl9Vp0J2RJO7Ibm971VpuJ26fLeLtj01or9csITo3MGIx5Lo7Y2ehv+zSZA4ya803b+OOShj3akXFFWyOmBhbAlNNbYgAfpIvLYzI8yr/PcilrKr5YUtuONDK4kcz996fyRWDmeHuA0dtjKIvVA6QgTzTx58yVwu7knKkzY2XE106cvZne4qZztmz2CNOlsaL3IdgRr0mDoDMp8AOcHKqpMNEDSZ7KiZUTTWAOJbcAFoVh0fX7HbR76KG/yE5cMKXiNyKcoc5jJqQnYL+4oQM4UqNP+M7ZFokndj1uP3ClK0KRH+BdVaPiIp2TLGl6hsiEkdJx+M3H/phcIQ9lxboQZaj9hKOqjAKDW4kLCRTGD7yeT9YaiqAwE0kPV4A75MCX0Tng8OsGNRV8aLq7jGOk76eOUANgQpDXlO5QC5zENPNHQHhJDeZ0
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 389df8ad-8b2e-4ce8-82ff-08dad3d6c604
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 20:01:02.4836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1001
X-Proofpoint-GUID: uTPwdmFMsEPsKutswR-RFUtawo5m25OL
X-Proofpoint-ORIG-GUID: uTPwdmFMsEPsKutswR-RFUtawo5m25OL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_14,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212010154

------=_NextPart_000_01F2_01D90584.F5FE0E70
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_01F3_01D90584.F5FE0E70"


------=_NextPart_001_01F3_01D90584.F5FE0E70
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Philippe,

I pulled your latest commit on the "next" branch (5e681f841fc3), I built it
with the normal debug configuration parameters enabled, and ran my test case
against it. I appear to be seeing the same behavior as before. No crashing,
but many threads that are boosted infinitely. I did get a kernel splat
again; it looks oddly similar to the one I sent previously with the old
kernel.... Doesn't make much sense to me. I verified I have the latest
commit checked out and built.

Thanks,

Russell

------=_NextPart_001_01F3_01D90584.F5FE0E70
Content-Type: text/plain;
	name="stack_trace_12_1.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="stack_trace_12_1.txt"

Dec  1 12:51:14 10.243.0.116 [  334.869230] ------------[ cut here =
]------------
Dec  1 12:51:14 10.243.0.116 [  334.869235] =
DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled())
Dec  1 12:51:14 10.243.0.116 [  334.869247] WARNING: CPU: 5 PID: 1999 at =
kernel/locking/lockdep.c:5550 check_flags+0x1a4/0x1d0
Dec  1 12:51:14 10.243.0.116 [  334.869262] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel iTCO_wdt =
gpio_ich iTCO_vendor_support mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
joydev intel_cstate input_leds ftdi_sio pcspkr i2c_i801 sg mei_me =
i2c_smbus intel_pch_thermal lpc_ich mei mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper ixgbe sr_mod sd_mod =
syscopyarea cdrom sysfillrect t10_pi sysimgblt fb_sys_fops =
drm_ttm_helper ttm mdio drm ahci i
Dec  1 12:51:14 10.243.0.116 [  334.869438]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  1 12:51:14 10.243.0.116 [  334.869456] CPU: 5 PID: 1999 Comm: =
TxStartup Not tainted 5.15.77evl-g5e681f841fc3 #3
Dec  1 12:51:14 10.243.0.116 [  334.869463] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  1 12:51:14 10.243.0.116 [  334.869466] IRQ stage: Linux
Dec  1 12:51:14 10.243.0.116 [  334.869469] RIP: =
0010:check_flags+0x1a4/0x1d0
Dec  1 12:51:14 10.243.0.116 [  334.869476] Code: ff ff e8 8f b2 6a ff =
85 c0 74 21 44 8b 05 cc 54 60 01 45 85 c0 75 15 48 c7 c6 40 05 69 82 48 =
c7 c7 00 d4 68 82 e8 f0 e2 f9 ff <0f> 0b 48 c7 c7 80 05 69 82 e8 69 7a =
fa ff e9 5c ff ff ff 65 48 8b
Dec  1 12:51:14 10.243.0.116 [  334.869482] RSP: 0018:ffff8881161ffd90 =
EFLAGS: 00010082
Dec  1 12:51:14 10.243.0.116 [  334.869487] RAX: 0000000000000000 RBX: =
1ffff11022c3ffb8 RCX: 0000000000000027
Dec  1 12:51:14 10.243.0.116 [  334.869491] RDX: 0000000000000027 RSI: =
dffffc0000000000 RDI: ffff8883de137b78
Dec  1 12:51:14 10.243.0.116 [  334.869495] RBP: ffff8881161ffd90 R08: =
ffffed107bc26f70 R09: ffffed107bc26f70
Dec  1 12:51:14 10.243.0.116 [  334.869500] R10: ffff8883de137b7b R11: =
ffffed107bc26f6f R12: ffff8881161ffe80
Dec  1 12:51:14 10.243.0.116 [  334.869503] R13: 0000000000000005 R14: =
0000000000000000 R15: 0000000000000000
Dec  1 12:51:14 10.243.0.116 [  334.869507] FS:  00007f8f72ffe700(0000) =
GS:ffff8883de100000(0000) knlGS:0000000000000000
Dec  1 12:51:14 10.243.0.116 [  334.869512] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  1 12:51:14 10.243.0.116 [  334.869516] CR2: 0000000000000000 CR3: =
0000000110ece002 CR4: 00000000003706e0
Dec  1 12:51:14 10.243.0.116 [  334.869520] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  1 12:51:14 10.243.0.116 [  334.869523] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  1 12:51:14 10.243.0.116 [  334.869526] Call Trace:
Dec  1 12:51:14 10.243.0.116 [  334.869528]  <TASK>
Dec  1 12:51:14 10.243.0.116 [  334.869532]  lock_acquire+0x150/0x3f0
Dec  1 12:51:14 10.243.0.116 [  334.869545]  ? =
lockdep_hardirqs_on_prepare+0x250/0x250
Dec  1 12:51:14 10.243.0.116 [  334.869555]  ? lock_release+0x2ac/0x440
Dec  1 12:51:14 10.243.0.116 [  334.869562]  ? =
__context_tracking_enter+0x6f/0x80
Dec  1 12:51:14 10.243.0.116 [  334.869570]  ? =
lock_downgrade+0x3e0/0x3e0
Dec  1 12:51:14 10.243.0.116 [  334.869579]  ? =
rcu_read_lock_sched_held+0x5b/0xd0
Dec  1 12:51:14 10.243.0.116 [  334.869590]  ? sched_clock+0x9/0x10
Dec  1 12:51:14 10.243.0.116 [  334.869599]  vtime_user_exit+0x73/0x130
Dec  1 12:51:14 10.243.0.116 [  334.869607]  ? =
__context_tracking_exit+0x60/0x70
Dec  1 12:51:14 10.243.0.116 [  334.869615]  =
__context_tracking_exit+0x60/0x70
Dec  1 12:51:14 10.243.0.116 [  334.869622]  =
syscall_enter_from_user_mode+0xd8/0x130
Dec  1 12:51:14 10.243.0.116 [  334.869631]  do_syscall_64+0x1d/0xa0
Dec  1 12:51:14 10.243.0.116 [  334.869640]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  1 12:51:14 10.243.0.116 [  334.869650] RIP: 0033:0x7f8f83d43e44
Dec  1 12:51:14 10.243.0.116 [  334.869655] Code: ff 31 c0 87 83 1c 06 =
00 00 83 f8 fe 0f 84 42 02 00 00 48 8b 54 24 08 be 18 00 00 00 b8 11 01 =
00 00 48 8d ba e0 02 00 00 0f 05 <f6> 82 14 06 00 00 04 0f 85 e9 01 00 =
00 48 8d 7c 24 10 48 c7 44 24
Dec  1 12:51:14 10.243.0.116 [  334.869660] RSP: 002b:00007f8f72fee960 =
EFLAGS: 00000202 ORIG_RAX: 0000000000000111
Dec  1 12:51:14 10.243.0.116 [  334.869666] RAX: ffffffffffffffda RBX: =
00007f8f72ffe700 RCX: 00007f8f83d43e44
Dec  1 12:51:14 10.243.0.116 [  334.869670] RDX: 00007f8f72ffe700 RSI: =
0000000000000018 RDI: 00007f8f72ffe9e0
Dec  1 12:51:14 10.243.0.116 [  334.869674] RBP: 0000000000000000 R08: =
00007f8f72ffe700 R09: 00007f8f72ffe700
Dec  1 12:51:14 10.243.0.116 [  334.869677] R10: 00007f8f72ffe9d0 R11: =
0000000000000202 R12: 0000000000000001
Dec  1 12:51:14 10.243.0.116 [  334.869681] R13: 0000000001001000 R14: =
0000000000000000 R15: 00007f8f72ffe700
Dec  1 12:51:14 10.243.0.116 [  334.869692]  </TASK>
Dec  1 12:51:14 10.243.0.116 [  334.869694] irq event stamp: 6
Dec  1 12:51:14 10.243.0.116 [  334.869696] hardirqs last  enabled at =
(5): [<ffffffff81002725>] ret_from_fork+0x15/0x30
Dec  1 12:51:14 10.243.0.116 [  334.869705] hardirqs last disabled at =
(6): [<ffffffff8213c46d>] do_syscall_64+0x1d/0xa0
Dec  1 12:51:14 10.243.0.116 [  334.869713] softirqs last  enabled at =
(0): [<ffffffff810c4f7a>] copy_process+0x12fa/0x3750
Dec  1 12:51:14 10.243.0.116 [  334.869720] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  1 12:51:14 10.243.0.116 [  334.869724] ---[ end trace =
fa2b3c78041cd9c9 ]---
Dec  1 12:51:14 10.243.0.116 [  334.869727] possible reason: unannotated =
irqs-on.
Dec  1 12:51:14 10.243.0.116 [  334.869729] irq event stamp: 6
Dec  1 12:51:14 10.243.0.116 [  334.869730] hardirqs last  enabled at =
(5): [<ffffffff81002725>] ret_from_fork+0x15/0x30
Dec  1 12:51:14 10.243.0.116 [  334.869737] hardirqs last disabled at =
(6): [<ffffffff8213c46d>] do_syscall_64+0x1d/0xa0
Dec  1 12:51:14 10.243.0.116 [  334.869745] softirqs last  enabled at =
(0): [<ffffffff810c4f7a>] copy_process+0x12fa/0x3750
Dec  1 12:51:14 10.243.0.116 [  334.869750] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  1 12:51:14 10.243.0.116 [  335.305095] ------------[ cut here =
]------------
Dec  1 12:51:14 10.243.0.116 [  335.305100] WARNING: CPU: 5 PID: 1999 at =
kernel/evl/mutex.c:659 __evl_unlock_mutex+0x2a9/0x430
Dec  1 12:51:14 10.243.0.116 [  335.305114] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel iTCO_wdt =
gpio_ich iTCO_vendor_support mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
joydev intel_cstate input_leds ftdi_sio pcspkr i2c_i801 sg mei_me =
i2c_smbus intel_pch_thermal lpc_ich mei mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper ixgbe sr_mod sd_mod =
syscopyarea cdrom sysfillrect t10_pi sysimgblt fb_sys_fops =
drm_ttm_helper ttm mdio drm ahci i
Dec  1 12:51:14 10.243.0.116 [  335.305283]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  1 12:51:14 10.243.0.116 [  335.305300] CPU: 5 PID: 1999 Comm: =
DummyTxSample Tainted: G        W         5.15.77evl-g5e681f841fc3 #3
Dec  1 12:51:14 10.243.0.116 [  335.305308] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  1 12:51:14 10.243.0.116 [  335.305311] IRQ stage: EVL
Dec  1 12:51:14 10.243.0.116 [  335.305314] RIP: =
0010:__evl_unlock_mutex+0x2a9/0x430
Dec  1 12:51:14 10.243.0.116 [  335.305320] Code: f7 e8 db ec 1d 00 48 =
c7 c6 38 0d 30 81 48 89 df 4d 8b 7c 24 78 e8 d7 f8 e9 ff 4c 89 e7 e8 8f =
43 ea ff 41 55 9d 4d 39 fe 75 bc <0f> 0b eb b8 85 c0 75 3c 48 89 df e8 =
67 d8 ff ff e9 5d fe ff ff 65
Dec  1 12:51:14 10.243.0.116 [  335.305326] RSP: 0018:ffff8881161ffac0 =
EFLAGS: 00010046
Dec  1 12:51:14 10.243.0.116 [  335.305331] RAX: 0000000000000000 RBX: =
ffff8881015b6018 RCX: ffffffff811a5187
Dec  1 12:51:14 10.243.0.116 [  335.305335] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: ffff8881015b6000
Dec  1 12:51:14 10.243.0.116 [  335.305339] RBP: ffff8881161ffb08 R08: =
ffffed10202b6c01 R09: ffffed10202b6c01
Dec  1 12:51:14 10.243.0.116 [  335.305343] R10: ffff8881015b6003 R11: =
ffffed10202b6c00 R12: ffff8881015b6000
Dec  1 12:51:14 10.243.0.116 [  335.305347] R13: 0000000000000082 R14: =
ffff8881015b6078 R15: ffff8881015b6078
Dec  1 12:51:14 10.243.0.116 [  335.305351] FS:  00007f8f72ffe700(0000) =
GS:ffff8883de100000(0000) knlGS:0000000000000000
Dec  1 12:51:14 10.243.0.116 [  335.305356] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  1 12:51:14 10.243.0.116 [  335.305360] CR2: 0000000000000000 CR3: =
0000000110ece002 CR4: 00000000003706e0
Dec  1 12:51:14 10.243.0.116 [  335.305363] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  1 12:51:14 10.243.0.116 [  335.305366] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  1 12:51:14 10.243.0.116 [  335.305370] Call Trace:
Dec  1 12:51:14 10.243.0.116 [  335.305372]  <TASK>
Dec  1 12:51:14 10.243.0.116 [  335.305381]  =
monitor_oob_ioctl+0x1019/0x1670
Dec  1 12:51:14 10.243.0.116 [  335.305388]  ? =
rcu_read_lock_held_common+0x25/0x70
Dec  1 12:51:14 10.243.0.116 [  335.305405]  ? enter_monitor+0x160/0x160
Dec  1 12:51:14 10.243.0.116 [  335.305415]  ? lock_release+0xd5/0x440
Dec  1 12:51:14 10.243.0.116 [  335.305423]  ? evl_get_file+0xa3/0x130
Dec  1 12:51:14 10.243.0.116 [  335.305432]  ? =
lock_downgrade+0x3e0/0x3e0
Dec  1 12:51:14 10.243.0.116 [  335.305440]  ? =
do_raw_spin_lock+0x119/0x1e0
Dec  1 12:51:14 10.243.0.116 [  335.305447]  ? spin_dump+0x90/0x90
Dec  1 12:51:14 10.243.0.116 [  335.305457]  ? =
__kasan_check_read+0x11/0x20
Dec  1 12:51:14 10.243.0.116 [  335.305473]  EVL_ioctl+0x81/0xf0
Dec  1 12:51:14 10.243.0.116 [  335.305483]  do_oob_syscall+0x5ac/0x6c0
Dec  1 12:51:14 10.243.0.116 [  335.305491]  ? =
prepare_for_signal+0x1b0/0x1b0
Dec  1 12:51:14 10.243.0.116 [  335.305501]  ? =
rcu_dynticks_eqs_enter+0xe/0x20
Dec  1 12:51:14 10.243.0.116 [  335.305513]  =
handle_oob_syscall+0x189/0x230
Dec  1 12:51:14 10.243.0.116 [  335.305522]  ? =
handle_pipelined_syscall+0x840/0x840
Dec  1 12:51:14 10.243.0.116 [  335.305539]  pipeline_syscall+0xa7/0x1c0
Dec  1 12:51:14 10.243.0.116 [  335.305551]  =
syscall_enter_from_user_mode+0x5f/0x130
Dec  1 12:51:14 10.243.0.116 [  335.305559]  do_syscall_64+0x1d/0xa0
Dec  1 12:51:14 10.243.0.116 [  335.305568]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  1 12:51:14 10.243.0.116 [  335.305577] RIP: 0033:0x7f8f8bb09b4b
Dec  1 12:51:14 10.243.0.116 [  335.305582] Code: Unable to access =
opcode bytes at RIP 0x7f8f8bb09b21.
Dec  1 12:51:14 10.243.0.116 [  335.305584] RSP: 002b:00007f8f72fee3f0 =
EFLAGS: 00000246 ORIG_RAX: 000000000000009d
Dec  1 12:51:14 10.243.0.116 [  335.305590] RAX: ffffffffffffffda RBX: =
00007f8f72fee490 RCX: 00007f8f8bb09b4b
Dec  1 12:51:14 10.243.0.116 [  335.305594] RDX: 00000000c0186d03 RSI: =
0000000000000049 RDI: 0000000010000002
Dec  1 12:51:14 10.243.0.116 [  335.305598] RBP: 00000000c0186d03 R08: =
0000000000000000 R09: 00007ffc749bd080
Dec  1 12:51:14 10.243.0.116 [  335.305601] R10: 00007f8f72fee490 R11: =
0000000000000246 R12: 0000000000000049
Dec  1 12:51:14 10.243.0.116 [  335.305605] R13: 0000000000000001 R14: =
0000000006150743 R15: 00007f8f72fee590
Dec  1 12:51:14 10.243.0.116 [  335.305620]  </TASK>
Dec  1 12:51:14 10.243.0.116 [  335.305622] irq event stamp: 6
Dec  1 12:51:14 10.243.0.116 [  335.305624] hardirqs last  enabled at =
(5): [<ffffffff81002725>] ret_from_fork+0x15/0x30
Dec  1 12:51:14 10.243.0.116 [  335.305633] hardirqs last disabled at =
(6): [<ffffffff8213c46d>] do_syscall_64+0x1d/0xa0
Dec  1 12:51:14 10.243.0.116 [  335.305641] softirqs last  enabled at =
(0): [<ffffffff810c4f7a>] copy_process+0x12fa/0x3750
Dec  1 12:51:14 10.243.0.116 [  335.305647] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  1 12:51:14 10.243.0.116 [  335.305652] ---[ end trace =
fa2b3c78041cd9ca ]---
Dec  1 12:51:14 10.243.0.116 [  335.305669] ------------[ cut here =
]------------
Dec  1 12:51:14 10.243.0.116 [  335.305671] WARNING: CPU: 5 PID: 1999 at =
kernel/evl/sched/core.c:989 __evl_schedule+0x73a/0x1180
Dec  1 12:51:14 10.243.0.116 [  335.305679] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel iTCO_wdt =
gpio_ich iTCO_vendor_support mxm_wmi kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
joydev intel_cstate input_leds ftdi_sio pcspkr i2c_i801 sg mei_me =
i2c_smbus intel_pch_thermal lpc_ich mei mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper ixgbe sr_mod sd_mod =
syscopyarea cdrom sysfillrect t10_pi sysimgblt fb_sys_fops =
drm_ttm_helper ttm mdio drm ahci i
Dec  1 12:51:14 10.243.0.116 [  335.305834]  libahci libata crc32c_intel =
ptp pps_core i2c_algo_bit dca fuse
Dec  1 12:51:14 10.243.0.116 [  335.305849] CPU: 5 PID: 1999 Comm: =
DummyTxSample Tainted: G        W         5.15.77evl-g5e681f841fc3 #3
Dec  1 12:51:14 10.243.0.116 [  335.305856] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  1 12:51:14 10.243.0.116 [  335.305858] IRQ stage: EVL
Dec  1 12:51:14 10.243.0.116 [  335.305860] RIP: =
0010:__evl_schedule+0x73a/0x1180
Dec  1 12:51:14 10.243.0.116 [  335.305870] Code: 46 78 48 39 d8 0f 85 =
45 fa ff ff 4c 8b 75 b0 48 c7 c6 eb ed 31 81 4c 89 f7 e8 32 18 e8 ff 48 =
8b 5d d0 48 89 df e8 e6 62 e8 ff <0f> 0b 68 eb ed 31 81 31 f6 45 31 c9 =
41 b8 01 00 00 00 31 c9 31 d2
Dec  1 12:51:14 10.243.0.116 [  335.305879] RSP: 0018:ffff8881161ffa28 =
EFLAGS: 00010046
Dec  1 12:51:14 10.243.0.116 [  335.305888] RAX: 0000000000000000 RBX: =
ffff8881015b6000 RCX: ffffffff811a5187
Dec  1 12:51:14 10.243.0.116 [  335.305895] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: ffff8881015b6000
Dec  1 12:51:14 10.243.0.116 [  335.305903] RBP: ffff8881161ffab8 R08: =
ffffed10202b6c01 R09: ffffed10202b6c01
Dec  1 12:51:14 10.243.0.116 [  335.305910] R10: ffff8881015b6003 R11: =
ffffed10202b6c00 R12: ffff8881015b6000
Dec  1 12:51:15 10.243.0.116 [  335.305917] R13: ffff8883de174720 R14: =
ffff8881015b6018 R15: ffff8883de174720
Dec  1 12:51:15 10.243.0.116 [  335.305925] FS:  00007f8f72ffe700(0000) =
GS:ffff8883de100000(0000) knlGS:0000000000000000
Dec  1 12:51:15 10.243.0.116 [  335.305934] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  1 12:51:15 10.243.0.116 [  335.305941] CR2: 0000000000000000 CR3: =
0000000110ece002 CR4: 00000000003706e0
Dec  1 12:51:15 10.243.0.116 [  335.305948] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  1 12:51:15 10.243.0.116 [  335.305954] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  1 12:51:15 10.243.0.116 [  335.305960] Call Trace:
Dec  1 12:51:15 10.243.0.116 [  335.305964]  <TASK>
Dec  1 12:51:15 10.243.0.116 [  335.305967]  ? =
monitor_oob_ioctl+0x100d/0x1670
Dec  1 12:51:15 10.243.0.116 [  335.305983]  ? =
lock_downgrade+0x3e0/0x3e0
Dec  1 12:51:15 10.243.0.116 [  335.305999]  ? =
do_raw_spin_unlock+0x97/0x140
Dec  1 12:51:15 10.243.0.116 [  335.306020]  =
__evl_wait_schedule+0x82/0x3c0
Dec  1 12:51:15 10.243.0.116 [  335.306036]  ? =
__kasan_check_read+0x11/0x20
Dec  1 12:51:15 10.243.0.116 [  335.306054]  =
monitor_oob_ioctl+0x1047/0x1670
Dec  1 12:51:15 10.243.0.116 [  335.306066]  ? =
rcu_read_lock_held_common+0x25/0x70
Dec  1 12:51:15 10.243.0.116 [  335.306095]  ? enter_monitor+0x160/0x160
Dec  1 12:51:15 10.243.0.116 [  335.306114]  ? lock_release+0xd5/0x440
Dec  1 12:51:15 10.243.0.116 [  335.306127]  ? evl_get_file+0xa3/0x130
Dec  1 12:51:15 10.243.0.116 [  335.306142]  ? =
lock_downgrade+0x3e0/0x3e0
Dec  1 12:51:15 10.243.0.116 [  335.306158]  ? =
do_raw_spin_lock+0x119/0x1e0
Dec  1 12:51:15 10.243.0.116 [  335.306170]  ? spin_dump+0x90/0x90
Dec  1 12:51:15 10.243.0.116 [  335.306190]  ? =
__kasan_check_read+0x11/0x20
Dec  1 12:51:15 10.243.0.116 [  335.306219]  EVL_ioctl+0x81/0xf0
Dec  1 12:51:15 10.243.0.116 [  335.306238]  do_oob_syscall+0x5ac/0x6c0
Dec  1 12:51:15 10.243.0.116 [  335.306255]  ? =
prepare_for_signal+0x1b0/0x1b0
Dec  1 12:51:15 10.243.0.116 [  335.306273]  ? =
rcu_dynticks_eqs_enter+0xe/0x20
Dec  1 12:51:15 10.243.0.116 [  335.306295]  =
handle_oob_syscall+0x189/0x230
Dec  1 12:51:15 10.243.0.116 [  335.306312]  ? =
handle_pipelined_syscall+0x840/0x840
Dec  1 12:51:15 10.243.0.116 [  335.306344]  pipeline_syscall+0xa7/0x1c0
Dec  1 12:51:15 10.243.0.116 [  335.306356]  =
syscall_enter_from_user_mode+0x5f/0x130
Dec  1 12:51:15 10.243.0.116 [  335.306364]  do_syscall_64+0x1d/0xa0
Dec  1 12:51:15 10.243.0.116 [  335.306373]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  1 12:51:15 10.243.0.116 [  335.306380] RIP: 0033:0x7f8f8bb09b4b
Dec  1 12:51:15 10.243.0.116 [  335.306384] Code: Unable to access =
opcode bytes at RIP 0x7f8f8bb09b21.
Dec  1 12:51:15 10.243.0.116 [  335.306387] RSP: 002b:00007f8f72fee3f0 =
EFLAGS: 00000246 ORIG_RAX: 000000000000009d
Dec  1 12:51:15 10.243.0.116 [  335.306393] RAX: ffffffffffffffda RBX: =
00007f8f72fee490 RCX: 00007f8f8bb09b4b
Dec  1 12:51:15 10.243.0.116 [  335.306396] RDX: 00000000c0186d03 RSI: =
0000000000000049 RDI: 0000000010000002
Dec  1 12:51:15 10.243.0.116 [  335.306400] RBP: 00000000c0186d03 R08: =
0000000000000000 R09: 00007ffc749bd080
Dec  1 12:51:15 10.243.0.116 [  335.306403] R10: 00007f8f72fee490 R11: =
0000000000000246 R12: 0000000000000049
Dec  1 12:51:15 10.243.0.116 [  335.306407] R13: 0000000000000001 R14: =
0000000006150743 R15: 00007f8f72fee590
Dec  1 12:51:15 10.243.0.116 [  335.306422]  </TASK>
Dec  1 12:51:15 10.243.0.116 [  335.306424] irq event stamp: 6
Dec  1 12:51:15 10.243.0.116 [  335.306426] hardirqs last  enabled at =
(5): [<ffffffff81002725>] ret_from_fork+0x15/0x30
Dec  1 12:51:15 10.243.0.116 [  335.306433] hardirqs last disabled at =
(6): [<ffffffff8213c46d>] do_syscall_64+0x1d/0xa0
Dec  1 12:51:15 10.243.0.116 [  335.306441] softirqs last  enabled at =
(0): [<ffffffff810c4f7a>] copy_process+0x12fa/0x3750
Dec  1 12:51:15 10.243.0.116 [  335.306447] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  1 12:51:15 10.243.0.116 [  335.306451] ---[ end trace =
fa2b3c78041cd9cb ]---
------=_NextPart_001_01F3_01D90584.F5FE0E70--

------=_NextPart_000_01F2_01D90584.F5FE0E70
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
9w0BCQUxDxcNMjIxMjAxMjAwMTAwWjAvBgkqhkiG9w0BCQQxIgQgzoQa+sBqRGfGMRIRbs88Hluc
K2IdKWe/yG5elnrkuFEwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQBg
ceMcO6UOPMwKdbubyi59MAg8hcljgYHxNz5hJCPv4aWYwTEQCnuvnZUBWlD1X1SXF635flObh0zx
/qXPOTC8qIYCyXZkTQ/4L+L1OLGuT6CGIGaW0sr/DxNc03HgcJV/erkFGDuChR5lDe3PQrMj9omB
ymTA1zDLx3MA6NYoBZI128WA37mfnjM2r5bVvMFCLuOHwj48IA6ol/j8g/PwuDkH0gsv3VTv3Sfn
GZ269OKUOO1Cky58Xs2WO2AiVrxMEJkrESgXlzAaKIMSgbACaq91asjj0ZAMN+z8CmCjQ7vQtyMp
ww3AvS4kxr6nV7S7JRFDERUa1bElzMQDlLVnAAAAAAAA

------=_NextPart_000_01F2_01D90584.F5FE0E70--
