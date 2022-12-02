Received: from mx0a-001f5801.pphosted.com (mx0a-001f5801.pphosted.com [148.163.157.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793917486
	for <xenomai@lists.linux.dev>; Fri,  2 Dec 2022 22:26:24 +0000 (UTC)
Received: from pps.filterd (m0090334.ppops.net [127.0.0.1])
	by mx0a-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2M1OYf006049;
	Fri, 2 Dec 2022 14:26:23 -0800
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02lp0181.outbound.protection.office365.us [23.103.199.181])
	by mx0a-001f5801.pphosted.com (PPS) with ESMTPS id 3m7na20wxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Dec 2022 14:26:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=r/qQuK3JEf+BqgRsBzB0qiKJcisqzbJlABlPFm9O5kOUELi4HJgClWqqB025to+ryjcutE3xyX8Sc0tIwKMLrggPEwvExlFD3IB5ygD+Z2lPVKKD9oNpz8PKwLc/TG7Rnbu4VQntsDkf/NFUKBDRb9rf2IbSo2ajeLO0aMQlAq1egbSKbl99X7/1rTHZMjzBbLrsKXMiJSq19pHGL9dqfoX7IodOLmDnGSWeGFSS3HYPKb8l07+JqeCI+WYgBS3ODQZ448W26Sv8VpKrSrp51D130qFSG3tl7fNg/FRpyvbLeceUbQezQS7yBWcUeuxfOYY6DaEORAncC+qe50qIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DUtom07XRoX+bkQLuzOt021n7udrecjr5j7ecmOp08=;
 b=oaf9164cWMRm3oRkpYOOgMD0DDAZBQCBVgH4rDiv4puN+ez9mlCndx+EONRUBBrShX1Xdmh/O3Bmz0JfUNf48t1ptyyzLZNlQbtfh0mxHTfIQzn7tommGHhM5fat9tM/KvlYGbqo4b7J+k5Au2ak2vuYiSVyjhT9PPd2wBSd6HBrqtstLIKoS9DZJZGBrZt5PIRjPjqbaazo1O/y8kErKWtASGw3cY54mHpMRq1GZ0afJujMu4EchJ8YEMxFZYhxPahVsVFT7wEl7QQILCz0ShW50RA64Xg7XjlJfEpI5VY5ixNB/9prFtv02OcSjrcRe7z48WRTUiAmxUr+hItcIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DUtom07XRoX+bkQLuzOt021n7udrecjr5j7ecmOp08=;
 b=PI3RU+sTU54sc5a4CI9fLW0QLgFEnzcssjIX9zVQU9rlj3OY/FG84s7tJjBtm4uJZojEgovLfyXq20EXzynmoIjSKvjVIS4hr1PGOvM7SpBAw4XMayNs4hpPq6/JbCp3WLYqdoYH1LELyjIQhsgshGNHZSYyqAikWxA5+0MLiATbxiCU3zpDMSml6R0EqWDR2jQuJt864mW6LCjokLD+vtY2St6OR0cgVi+5Qo+IwMe7jfEBb973s6JiqQ0q2Z7C+nqjQDvc7oVjwjKVG8UjeiOpKI2K880RagKphqt15ei8JQhq4abVEuV0Mqtt3hqkrmqp1pswDUuPR5GfkxgqHw==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB0954.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Fri, 2 Dec
 2022 22:26:20 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725%7]) with mapi id 15.20.5834.022; Fri, 2 Dec 2022
 22:26:20 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: Bryan Butler <Bryan.Butler@kratosdefense.com>,
        "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>,
        Shawn McManus <shawn.mcmanus@kratosdefense.com>
Subject: RE: [External] - Re: EVL Memory
Thread-Topic: [External] - Re: EVL Memory
Thread-Index: 
 Adjz0yff24VAOdNORJO8c3TjB/9lSwAgymPQAAE3ZMAAARoBAABtP6rQAH6X0oAAFuqKwAAYlRuAAA/9EKAABRGVgAAsa2CAAAwq7lAAKDcSAAAgIxWAAEP6SSAAYzsWgAAFcSNAAVlSalAAAyZ+gAAIpzogAFofRaAAL3JDAAALO44gABv0W4AADFRKsAAAioEAAACcvjAAA2mHAAAKjrLw
Date: Fri, 2 Dec 2022 22:26:20 +0000
Message-ID: 
 <PH1P110MB1050E66FF8CC978CF642CDF8E2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
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
 <PH1P110MB1050DA6B7C1C21B2866038CCE2149@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <871qpiw3zd.fsf@xenomai.org>
 <PH1P110MB105039710BB301C7126FF2D9E2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87wn797rj3.fsf@xenomai.org>
 <PH1P110MB1050356B939910A6A0406B96E2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87cz917m8z.fsf@xenomai.org>
In-Reply-To: <87cz917m8z.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB0954:EE_
x-ms-office365-filtering-correlation-id: 09be0619-e316-4378-cf98-08dad4b43c83
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 BwJYLGMYHSYhEp1Z50PLxb+XloKwG2EOLzuOpk/w+AVuqUxo9wbDDSv+87LVjWQGw2gskl7xgsg2nioCJMiSmoN2TqI2n1pRPmMHnMBPX4VDvJ3V/pZRBBQEnWkaAyTx7pPzKvKe5/cY2w5eXeT9zYGiRH1wSjI3Zy30z/3ebqmrX4JoO8nSTj1TW4pCvERxaAa+DRi1ZQWEpRzOYqONbJvUFRru9P/yQn5Fu+qYBEPVdERAbMeclQJ2Fv4wAboDGLatrwA1WX2GhsW0MvAB83WzChMZ21cG2gckgk5gCW9ff/6x2vPNZ11AXrTaYrfWDlemY+pwPH8Myh8upfwdPE/5ONiVd4Nfib0lhUdNUFiJS56fbg18nx1NcdnjVWdo/XBn5ulanqAyEgEBBDTiwAAz0nbz6ADAyjFMiNmWjtAN82zBv/1fBJ80o4XNZWP5bKyM0yXnIQvn/Z0cuAj6MCe7FdFKMY9P2/ZSVCzMkrQXoISjJFh8vTqZsiHVLpAsfzzuewC9rz2AaFusm7734OxM0nJF9D717hnmejzpVjUInb8EoZgFVsBMp5pEDpF4S5FgqDNgGaeiYepQp7jrWi9Od8OGUdw6a3Sz28FoU9E=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(396003)(366004)(136003)(451199015)(44832011)(52536014)(508600001)(33656002)(107886003)(558084003)(71200400001)(76116006)(38070700005)(55016003)(86362001)(41320700001)(122000001)(186003)(99936003)(64756008)(41300700001)(6506007)(83380400001)(4326008)(38100700002)(8676002)(66446008)(9686003)(7696005)(66476007)(66946007)(2906002)(6916009)(66556008)(8936002)(54906003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 SOeSgqRgypG/BwwNQVDPU5bKieeVUz/VQjIPWB0m6JH3FTDAKCvAzdxssfqwYg1U9Scs78IoZuYG47BAHWo8EitfyugkRSXXYb/MvOS2A/sGeTqLwiYXmP6H3m3ok0e4EuBSQrhJLxqVKu1Xz3UNNoi74Ww/N4AOFkvr5h6mPqnPR0NxpBxVgw3Vrd88Xb6JUONAsC22mNoGcSghzznemhcADqegzUqZehPiJLNhV2XGkyjXYq3A1H7u9AROQDeHlIB2POuRxRdd6hMNgH5raBTd5YJqswttcHxYif5UFVAFJe/Zz7U6x4DDncCn9484AT7eyFgC1Ct0cQXXmvdweSyJfqRV0JV9+1nAl73EVUMZ15LblGPkwYFSruQtMhWBp9Z62UA2rUb8XPC5JIRrZZpF1qUskMMg4+VTC6N/iMpQBII/Q6aAjNvW6+78ivxP6E7IoLeK9F8rSZU0Jz7VNRHhiPiBohF/YHtn8ihlB+k=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_0242_01D90662.6CCE4780"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	q9sMaLxSLVtXD48Z00NrL1UPKQ4VxXbEUli6XT08o7lUZhzDi8GAf/MsL+DTAoymcUM4ANN3R580ModRet/6PuKkV2XaGN0LVxZuZ8yP2nwYuZqzZ6UZP93VFlOdoNZLKHf1zPdrSLVFxNsHfQZ4HEEIePLOxZgL310olvuxBGQtMxvhyp9zm3Zy6t+RgIwGI8fQeqvnoolCWAPBzK4C962vK8lDd4DYWakDH/CpTBHNu76/0rTYZdtG+RB8IEbpKMbbKgS6mdLkIeQ87Ent2PLAnxYGwkinrQJwgxA0QAzW9V99D54Lo/irVjtiBS48REM+uURi1EgaEZQ2+UWAI44vVYRPYFrC3/oZsHVwL1xOKkyClavh+PcIaH5E5Ae+Otsl6vQwnHccHROp3WWMDsU8uXSALT7f3okEqQdhskS1CK6v5Wg+Fd+RJwtfLcWC2rTNfRhtLHU52yctQUGXL5XtuiCm6JsX0TIZ7LETD87J42ZjXSVUVST7wlGQ5zfKp0xfsLdHAuwXjJ0b8yqOSH+YgNqr6nKgtR+F3MRg26PYtgwT78//S1Va0emo8W0oSLqzUXh3rYvUwrWrBbPQ2mmmZpVnJGaf+5gXT0IT6zfva6nykuIIhYFQp70YKXHshBSS9JqQWzkhudq9NatAzfhGkfOdQQTvCbSo/8BvnEAD3JpexPbrdyWrNojteG1etQjrFXNKM8Bmzs0T2+szCdnyY+sI8/E1qyDOKeThmSOE8DJwLScHOrLV2SLi6J/WqfQTN9d3n/Q0Xm+pY4ifZpvJDcmFNXnKunXRjEtT4Hmy5mqWmZs4sN1dN54TEqD/
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 09be0619-e316-4378-cf98-08dad4b43c83
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 22:26:20.0663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB0954
X-Proofpoint-GUID: OtuGa2jTBvUFa3z-NQhBZDTBroj8Xnjc
X-Proofpoint-ORIG-GUID: OtuGa2jTBvUFa3z-NQhBZDTBroj8Xnjc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_12,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212020180

------=_NextPart_000_0242_01D90662.6CCE4780
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_0243_01D90662.6CCE4780"


------=_NextPart_001_0243_01D90662.6CCE4780
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I added in your patches and rebuilt with lockdep disabled and with ftrace
disabled (since the ftrace seems to be killing the system). I did see a
couple brief kernel splats that I figured I would at least ship your way to
see if they are important.

Thanks,

Russell

------=_NextPart_001_0243_01D90662.6CCE4780
Content-Type: text/plain;
	name="stack_trace.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="stack_trace.txt"

Dec  2 15:23:09 10.243.0.116 [  190.726063] ------------[ cut here =
]------------
Dec  2 15:23:09 10.243.0.116 [  190.726069] WARNING: CPU: 5 PID: 1884 at =
kernel/evl/mutex.c:660 __evl_unlock_mutex+0x310/0x510
Dec  2 15:23:09 10.243.0.116 [  190.726090] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass =
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel gpio_ich iTCO_wdt =
aesni_intel iTCO_vendor_support crypto_simd mxm_wmi cryptd rapl =
intel_cstate pcspkr input_leds joydev i2c_i801 i2c_smbus sg ftdi_sio =
intel_pch_thermal mei_me mei lpc_ich mfd_core ioatdma wmi ip_tables ext4 =
mbcache jbd2 ast drm_vram_helper drm_kms_helper sd_mod sr_mod =
syscopyarea sysfillrect cdrom t10_pi sysimgblt fb_sys_fops =
drm_ttm_helper ttm igb drm ixgbe ahci
Dec  2 15:23:09 10.243.0.116 [  190.726260]  libahci libata crc32c_intel =
mdio ptp i2c_algo_bit pps_core dca fuse
Dec  2 15:23:09 10.243.0.116 [  190.726278] CPU: 5 PID: 1884 Comm: =
DummyTxSample Not tainted 5.15.77evl-g5e681f841fc3-dirty #3
Dec  2 15:23:09 10.243.0.116 [  190.726285] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 15:23:09 10.243.0.116 [  190.726288] IRQ stage: EVL
Dec  2 15:23:09 10.243.0.116 [  190.726291] RIP: =
0010:__evl_unlock_mutex+0x310/0x510
Dec  2 15:23:09 10.243.0.116 [  190.726298] Code: 71 af e8 63 bf 1d 00 =
48 8b 05 84 e6 41 02 e8 07 83 ed ff 85 c0 74 45 65 ff 0d 7c b0 d2 52 e9 =
6f fd ff ff e8 62 72 ea ff 53 9d <0f> 0b 48 83 c4 18 5b 41 5c 41 5d 41 =
5e 41 5f 5d c3 cc cc cc cc 4c
Dec  2 15:23:09 10.243.0.116 [  190.726303] RSP: 0018:ffff88812fb37ad8 =
EFLAGS: 00010082
Dec  2 15:23:09 10.243.0.116 [  190.726308] RAX: 0000000000000000 RBX: =
0000000000000082 RCX: ffffffffad1a31c7
Dec  2 15:23:09 10.243.0.116 [  190.726313] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: ffff888101576000
Dec  2 15:23:09 10.243.0.116 [  190.726316] RBP: ffff88812fb37b18 R08: =
ffffed10202aec01 R09: ffffed10202aec01
Dec  2 15:23:09 10.243.0.116 [  190.726321] R10: ffff888101576003 R11: =
ffffed10202aec00 R12: ffff888101576000
Dec  2 15:23:09 10.243.0.116 [  190.726324] R13: ffff888101576078 R14: =
ffff88811fdac1c8 R15: ffff88811fdac158
Dec  2 15:23:09 10.243.0.116 [  190.726328] FS:  00007f1a29659700(0000) =
GS:ffff8883de480000(0000) knlGS:0000000000000000
Dec  2 15:23:09 10.243.0.116 [  190.726333] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 15:23:09 10.243.0.116 [  190.726337] CR2: 0000000000000000 CR3: =
000000010aeec002 CR4: 00000000003706e0
Dec  2 15:23:09 10.243.0.116 [  190.726341] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 15:23:09 10.243.0.116 [  190.726344] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 15:23:09 10.243.0.116 [  190.726347] Call Trace:
Dec  2 15:23:09 10.243.0.116 [  190.726350]  <TASK>
Dec  2 15:23:09 10.243.0.116 [  190.726369]  =
monitor_oob_ioctl+0xe43/0x13e0
Dec  2 15:23:09 10.243.0.116 [  190.726400]  ? enter_monitor+0x160/0x160
Dec  2 15:23:09 10.243.0.116 [  190.726441]  ? =
do_raw_spin_lock+0x119/0x1e0
Dec  2 15:23:09 10.243.0.116 [  190.726451]  ? spin_dump+0x90/0x90
Dec  2 15:23:09 10.243.0.116 [  190.726469]  ? =
__kasan_check_read+0x11/0x20
Dec  2 15:23:09 10.243.0.116 [  190.726499]  EVL_ioctl+0x81/0xf0
Dec  2 15:23:09 10.243.0.116 [  190.726517]  do_oob_syscall+0x5ac/0x6c0
Dec  2 15:23:09 10.243.0.116 [  190.726531]  ? =
prepare_for_signal+0x180/0x180
Dec  2 15:23:09 10.243.0.116 [  190.726545]  ? =
do_oob_syscall+0x6c0/0x6c0
Dec  2 15:23:09 10.243.0.116 [  190.726566]  =
handle_oob_syscall+0x189/0x230
Dec  2 15:23:09 10.243.0.116 [  190.726580]  ? =
handle_pipelined_syscall+0x840/0x840
Dec  2 15:23:09 10.243.0.116 [  190.726618]  pipeline_syscall+0xa7/0x1c0
Dec  2 15:23:09 10.243.0.116 [  190.726637]  =
syscall_enter_from_user_mode+0x5f/0x130
Dec  2 15:23:09 10.243.0.116 [  190.726650]  do_syscall_64+0x1d/0xa0
Dec  2 15:23:09 10.243.0.116 [  190.726661]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 15:23:09 10.243.0.116 [  190.726668] RIP: 0033:0x7f1a3dcdeb9b
Dec  2 15:23:09 10.243.0.116 [  190.726674] Code: Unable to access =
opcode bytes at RIP 0x7f1a3dcdeb71.
Dec  2 15:23:09 10.243.0.116 [  190.726677] RSP: 002b:00007f1a296493f0 =
EFLAGS: 00000246 ORIG_RAX: 000000000000009d
Dec  2 15:23:09 10.243.0.116 [  190.726682] RAX: ffffffffffffffda RBX: =
00007f1a29649490 RCX: 00007f1a3dcdeb9b
Dec  2 15:23:09 10.243.0.116 [  190.726686] RDX: 00000000c0186d03 RSI: =
0000000000000049 RDI: 0000000010000002
Dec  2 15:23:09 10.243.0.116 [  190.726690] RBP: 00000000c0186d03 R08: =
0000000000000000 R09: 00007ffddbb2f080
Dec  2 15:23:09 10.243.0.116 [  190.726693] R10: 00007f1a29649490 R11: =
0000000000000246 R12: 0000000000000049
Dec  2 15:23:09 10.243.0.116 [  190.726697] R13: 0000000000000001 R14: =
000000001a2e47cc R15: 00007f1a29649590
Dec  2 15:23:09 10.243.0.116 [  190.726735]  </TASK>
Dec  2 15:23:09 10.243.0.116 [  190.726737] irq event stamp: 556
Dec  2 15:23:09 10.243.0.116 [  190.726739] hardirqs last  enabled at =
(555): [<ffffffffae14ee3a>] _raw_spin_unlock_irqrestore+0x5a/0x60
Dec  2 15:23:09 10.243.0.116 [  190.726747] hardirqs last disabled at =
(556): [<ffffffffae141d7d>] __schedule+0x90d/0x1160
Dec  2 15:23:09 10.243.0.116 [  190.726755] softirqs last  enabled at =
(0): [<ffffffffad0c4f3a>] copy_process+0x12fa/0x3750
Dec  2 15:23:09 10.243.0.116 [  190.726762] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 15:23:09 10.243.0.116 [  190.726767] ---[ end trace =
eb204101d74e7ec4 ]---
Dec  2 15:23:09 10.243.0.116 [  190.726785] ------------[ cut here =
]------------
Dec  2 15:23:09 10.243.0.116 [  190.726787] WARNING: CPU: 5 PID: 1884 at =
kernel/evl/sched/core.c:990 __evl_schedule+0x6d7/0x1160
Dec  2 15:23:09 10.243.0.116 [  190.726801] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass =
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel gpio_ich iTCO_wdt =
aesni_intel iTCO_vendor_support crypto_simd mxm_wmi cryptd rapl =
intel_cstate pcspkr input_leds joydev i2c_i801 i2c_smbus sg ftdi_sio =
intel_pch_thermal mei_me mei lpc_ich mfd_core ioatdma wmi ip_tables ext4 =
mbcache jbd2 ast drm_vram_helper drm_kms_helper sd_mod sr_mod =
syscopyarea sysfillrect cdrom t10_pi sysimgblt fb_sys_fops =
drm_ttm_helper ttm igb drm ixgbe ahci
Dec  2 15:23:09 10.243.0.116 [  190.727081]  libahci libata crc32c_intel =
mdio ptp i2c_algo_bit pps_core dca fuse
Dec  2 15:23:09 10.243.0.116 [  190.727114] CPU: 5 PID: 1884 Comm: =
DummyTxSample Tainted: G        W         5.15.77evl-g5e681f841fc3-dirty =
#3
Dec  2 15:23:09 10.243.0.116 [  190.727126] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  2 15:23:09 10.243.0.116 [  190.727131] IRQ stage: EVL
Dec  2 15:23:09 10.243.0.116 [  190.727134] RIP: =
0010:__evl_schedule+0x6d7/0x1160
Dec  2 15:23:09 10.243.0.116 [  190.727145] Code: c1 f8 06 48 8d 3c c5 =
e0 c7 73 af e8 d3 0b 1c 00 48 0f a3 1d 4b 4a 42 02 0f 82 54 09 00 00 48 =
8b 5d d0 48 89 df e8 89 b3 e8 ff <0f> 0b 48 89 df e8 9f b1 e8 ff e9 53 =
fa ff ff 48 8b 7d c8 e8 21 ff
Dec  2 15:23:09 10.243.0.116 [  190.727154] RSP: 0018:ffff88812fb37a50 =
EFLAGS: 00010046
Dec  2 15:23:09 10.243.0.116 [  190.727163] RAX: 0000000000000000 RBX: =
ffff888101576000 RCX: ffffffffad1a31c7
Dec  2 15:23:09 10.243.0.116 [  190.727170] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: ffff888101576000
Dec  2 15:23:09 10.243.0.116 [  190.727177] RBP: ffff88812fb37ad0 R08: =
ffffed10202aec01 R09: ffffed10202aec01
Dec  2 15:23:09 10.243.0.116 [  190.727185] R10: ffff888101576003 R11: =
ffffed10202aec00 R12: ffff88811fda9960
Dec  2 15:23:09 10.243.0.116 [  190.727192] R13: ffff8883de4e46a0 R14: =
ffff888101576000 R15: ffff8883de4e46a0
Dec  2 15:23:09 10.243.0.116 [  190.727200] FS:  00007f1a29659700(0000) =
GS:ffff8883de480000(0000) knlGS:0000000000000000
Dec  2 15:23:09 10.243.0.116 [  190.727209] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  2 15:23:09 10.243.0.116 [  190.727217] CR2: 0000000000000000 CR3: =
000000010aeec002 CR4: 00000000003706e0
Dec  2 15:23:09 10.243.0.116 [  190.727224] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  2 15:23:09 10.243.0.116 [  190.727229] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  2 15:23:09 10.243.0.116 [  190.727236] Call Trace:
Dec  2 15:23:10 10.243.0.116 [  190.727239]  <TASK>
Dec  2 15:23:10 10.243.0.116 [  190.727301]  =
__evl_wait_schedule+0x80/0x350
Dec  2 15:23:10 10.243.0.116 [  190.727318]  ? =
__kasan_check_read+0x11/0x20
Dec  2 15:23:10 10.243.0.116 [  190.727350]  =
monitor_oob_ioctl+0xe62/0x13e0
Dec  2 15:23:10 10.243.0.116 [  190.727406]  ? enter_monitor+0x160/0x160
Dec  2 15:23:10 10.243.0.116 [  190.727486]  ? =
do_raw_spin_lock+0x119/0x1e0
Dec  2 15:23:10 10.243.0.116 [  190.727502]  ? spin_dump+0x90/0x90
Dec  2 15:23:10 10.243.0.116 [  190.727538]  ? =
__kasan_check_read+0x11/0x20
Dec  2 15:23:10 10.243.0.116 [  190.727596]  EVL_ioctl+0x81/0xf0
Dec  2 15:23:10 10.243.0.116 [  190.727630]  do_oob_syscall+0x5ac/0x6c0
Dec  2 15:23:10 10.243.0.116 [  190.727650]  ? =
prepare_for_signal+0x180/0x180
Dec  2 15:23:10 10.243.0.116 [  190.727664]  ? =
do_oob_syscall+0x6c0/0x6c0
Dec  2 15:23:10 10.243.0.116 [  190.727684]  =
handle_oob_syscall+0x189/0x230
Dec  2 15:23:10 10.243.0.116 [  190.727699]  ? =
handle_pipelined_syscall+0x840/0x840
Dec  2 15:23:10 10.243.0.116 [  190.727736]  pipeline_syscall+0xa7/0x1c0
Dec  2 15:23:10 10.243.0.116 [  190.727755]  =
syscall_enter_from_user_mode+0x5f/0x130
Dec  2 15:23:10 10.243.0.116 [  190.727768]  do_syscall_64+0x1d/0xa0
Dec  2 15:23:10 10.243.0.116 [  190.727778]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  2 15:23:10 10.243.0.116 [  190.727785] RIP: 0033:0x7f1a3dcdeb9b
Dec  2 15:23:10 10.243.0.116 [  190.727793] Code: Unable to access =
opcode bytes at RIP 0x7f1a3dcdeb71.
Dec  2 15:23:10 10.243.0.116 [  190.727797] RSP: 002b:00007f1a296493f0 =
EFLAGS: 00000246 ORIG_RAX: 000000000000009d
Dec  2 15:23:10 10.243.0.116 [  190.727808] RAX: ffffffffffffffda RBX: =
00007f1a29649490 RCX: 00007f1a3dcdeb9b
Dec  2 15:23:10 10.243.0.116 [  190.727816] RDX: 00000000c0186d03 RSI: =
0000000000000049 RDI: 0000000010000002
Dec  2 15:23:10 10.243.0.116 [  190.727823] RBP: 00000000c0186d03 R08: =
0000000000000000 R09: 00007ffddbb2f080
Dec  2 15:23:10 10.243.0.116 [  190.727830] R10: 00007f1a29649490 R11: =
0000000000000246 R12: 0000000000000049
Dec  2 15:23:10 10.243.0.116 [  190.727833] R13: 0000000000000001 R14: =
000000001a2e47cc R15: 00007f1a29649590
Dec  2 15:23:10 10.243.0.116 [  190.727872]  </TASK>
Dec  2 15:23:10 10.243.0.116 [  190.727874] irq event stamp: 556
Dec  2 15:23:10 10.243.0.116 [  190.727876] hardirqs last  enabled at =
(555): [<ffffffffae14ee3a>] _raw_spin_unlock_irqrestore+0x5a/0x60
Dec  2 15:23:10 10.243.0.116 [  190.727884] hardirqs last disabled at =
(556): [<ffffffffae141d7d>] __schedule+0x90d/0x1160
Dec  2 15:23:10 10.243.0.116 [  190.727891] softirqs last  enabled at =
(0): [<ffffffffad0c4f3a>] copy_process+0x12fa/0x3750
Dec  2 15:23:10 10.243.0.116 [  190.727897] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  2 15:23:10 10.243.0.116 [  190.727902] ---[ end trace =
eb204101d74e7ec5 ]---
------=_NextPart_001_0243_01D90662.6CCE4780--

------=_NextPart_000_0242_01D90662.6CCE4780
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
9w0BCQUxDxcNMjIxMjAyMjIyNjE4WjAvBgkqhkiG9w0BCQQxIgQgfPP4i6o1shdtpngu0xI7YWyB
CIHnpT1f6n684v8kxiowgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQCh
s66nLuhUYzGNwlt3/d4HAn4w+aEMGhzsFY4tO38JmtbKb40KG6dghmt24dICOORvyuNnxghkWSHD
k045FZHKQz5PtKtTbvHZI5+E0vaw/aW7gLABN3NkWFNOqBcGjyKr+hsSqSXKo3QItvwqwqAX1TWd
yVHOLzzEMtZaDRvHD3bXa20P4p+eL6MK/gxCvy8XlrYEtMER7GIpLxRfEuB8Qb3sUISXML6qAuPM
Z/GPS6HiSFJu3CT8abyrqHvtlKDRFMOqkDDzxjJv+/I+QEV/o+s7J/Rd71fTItMHYU1DdQ/n+zmK
C71OvivibfWbX+d6S2n+pls34AHWiXJsNlRlAAAAAAAA

------=_NextPart_000_0242_01D90662.6CCE4780--
