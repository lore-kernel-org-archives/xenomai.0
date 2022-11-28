Received: from mx0a-001f5801.pphosted.com (mx0a-001f5801.pphosted.com [148.163.157.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85299A492
	for <xenomai@lists.linux.dev>; Mon, 28 Nov 2022 20:59:52 +0000 (UTC)
Received: from pps.filterd (m0090334.ppops.net [127.0.0.1])
	by mx0a-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASJVAXm001192;
	Mon, 28 Nov 2022 12:59:48 -0800
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02lp0181.outbound.protection.office365.us [23.103.199.181])
	by mx0a-001f5801.pphosted.com (PPS) with ESMTPS id 3m3fwa49ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Nov 2022 12:59:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=GdwhfmLE+KEJRHXpTDQDgi2VSiXARRnAGh5BlJLw458YZAiWRGVPNBJp4+isjwGmAN7lW8MdsTbAg5D3z0KnMvgvTbiz9Ey4rxC/wSl8DtUtwkgNfZkLMBTCpPRMe2lBcOTo0hjZ4GWnC4ivAtuhP0UJHNeNK7OIsAOU03zRtmi7EWzeKMmz0uoYSdwb6e8E8AqKFoijaopooa0krVVrgkfB5t4YYF98QzEca/eRziitwRgC+Rqk4g4lq7AM/4YTqYi9Uy18fvwShU/9Euio1vX/yYzrdDfCtj96MffKM6qZZnMnQ5EdzXYWHh30S+buBTMa3xqbtwH4I4xcQU0A+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+iOX8ezRwaD4Fqjl9pALw0RK+PO5oj68gd7cWMSoWc=;
 b=vgmnnT8IC5ZgVJeC7E1InznsSTf0+dyU6bFWJeBvDL855+4E3Nu7urMYBO1ful8GvjKqhw9REpcfKu4EU3OwygeMNVcmwNR3F0cT8LNYVZfn/f6kaTST68DprZGwbbzp5acbv0UM8T1+6BpkpY7Ce64Sy8Qv3Niyan7EZL8oAH2WB9eyc8WuuEu1MZPcY+eycTZeI40HWiCPzS22RzBUmDPI3y8iDzk36e/yxvONGNHId635Ralkc7ggBXc6KG9pekzDeCIAtOYZC5jDBQiLbjTSxE95uWftgUOulrdXtrg1Hnc6to5ErMIdCIOYZ0AYo48OoH+HPEa2AKaBbtVRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+iOX8ezRwaD4Fqjl9pALw0RK+PO5oj68gd7cWMSoWc=;
 b=Oc+SW+QRovXGJ6pJXeR51t9FXUaoZOWw5z8w1YYqcLnuUIMsgtfSUvJtRUMouEPqoxC1nwbL/zjLfo6H7/15wF7r48hvJz2BYWM/oU0o8UpN9dopoRSUyMVU12Cu2y/5Cg8xKaMXbOjXoGsYICV/Za9wwXT617/k3wXonkFz/2oAjAWb1/4Ykj+awhKtYTgt8LVrUr4/zZCt84JQYtTJ8F4We0zW5L3IGwTpgYuHzpWGXGWwm4Avo92Ss3ewSJbofFIr/Xq3dCDyvw9DWwUxkQHxMLvVZ8Opr9GkEfc+PN80wAFWPlRA6kKZNMsdYSkz0ssVN8AXnJJv47NEC/A+YA==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1116.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:174::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 28 Nov
 2022 20:59:46 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725%7]) with mapi id 15.20.5834.020; Mon, 28 Nov 2022
 20:59:46 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: Bryan Butler <Bryan.Butler@kratosdefense.com>,
        "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>,
        Shawn McManus <shawn.mcmanus@kratosdefense.com>
Subject: RE: [External] - Re: EVL Memory
Thread-Topic: [External] - Re: EVL Memory
Thread-Index: 
 Adjz0yff24VAOdNORJO8c3TjB/9lSwAgymPQAAE3ZMAAARoBAABtP6rQAH6X0oAAFuqKwAAYlRuAAA/9EKAABRGVgAAsa2CAAAwq7lAAKDcSAAAgIxWAAEP6SSAAYzsWgAAFcSNAAVlSalAAAyZ+gAAIpzog
Date: Mon, 28 Nov 2022 20:59:46 +0000
Message-ID: 
 <PH1P110MB1050D4E123EE6368D98E071AE2139@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10508DD9688B7D0E82AB30CDE23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
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
In-Reply-To: <87h6yj6mvg.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB1116:EE_
x-ms-office365-filtering-correlation-id: 41ac8fe8-d2aa-44f3-5ea4-08dad1837b02
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vMMa5863ZKMb1bhnyaMXQAGgIAYMke8OOzKbr2VBtLbjct5ZE6VogXUMOIc6TtvyZnfJKLwG/eCAI8TSC3Cd9aAV6pcYmSnHNCYoBONySiJlWG6vriCurLLrMl7oF819dAebY6HGuZ5jKqamzluyViDq6/W5vD9wFzz69RCKTHeDh8/jPA9K/pbdFq6zZD0Su2DRDkUwfQRGZ+RIPCpTLgRfODY0fwkqZUaufKeKsFR9BW5+79K8j038ixEYSwE8HJlIoAWY+ZqyHdIV8nW6zlEKrGjgJjwR2y91n6EznA2MaXBbS8F1sixODvl3i+7s8/n3JjymEzsqLjKaafsSK41X8ogZi6oMGL7jbKMd9d5yn/lvnf5MwNGEouAtUcfTzF7mp9lSnbIuy/QjqoD2y+V1ueRTKIpleZuI96qW6BoYesjobgF5RLON3mIZkMUqeZJGnuxlUjHGw0Kl4M19PbNVq6bX15K+orAn2YI67bBNYrAtntvuzVx5eNHnSOWNskkWt3U2CFwlra/D3WB4/Gf84eAzWj4asWQR449HCLZULS/pfh1GQUU4VHSnd9FbrnXMUtHsxT9TCXtaVWBGsQQd4YmdCBexmiyLq9HGNhkb3ViRc/YgIScevtXD7rOP
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(2906002)(71200400001)(38100700002)(6506007)(8936002)(54906003)(6916009)(5660300002)(86362001)(66476007)(64756008)(76116006)(66446008)(66556008)(33656002)(107886003)(66946007)(4744005)(52536014)(4326008)(8676002)(44832011)(9686003)(38070700005)(498600001)(26005)(55016003)(7696005)(186003)(99936003)(122000001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 Q5gfcU83K/6w1IQCTUlweYkzLoTh8cDKBdaai5Rs1jYL7rMkBDqlcAp6e//jhWkzFEEaLcVXX9UYvnvMEjl9Rmm8iFLzYo6c++s3ubG/egF/5QB9FwkjdVLapNOtyXN+ZQ4KUl4K14zCEudaBgPq/oXKeHOJBWHHrWfav/PMAyc6RQ5Oxc+ZX3jxjaBtwBQwf1XoRtX0Q8tRD4kQ/VT1q9tt+5tO3r0xQTnPTeLov6F0wKGv6kZvDMTGumVQEB8rmrHsuLHz2v4l2V/V/royEx8d/MrUL3GIr3k1txdKfCbjwt/Ww2aPi/7ZhB2tmcTQRaGTfV6Hn95U/V13zNJjZznyVQb3zr6m/ewURdRI0aLJfx+BX34uWaFwv4kpr9Wpmw2FLhVXApWbEmDcOxSLz96IlRLTOUR3TfdgoXWPRVk=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_00CE_01D90331.AB145EA0"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yTn4Pxkk9Yx3y05DD7rZGimoTarLUAHxa6C+5pPZnIw01H0nFHXLf2G2b1BnE3gJIYWHcnGCdJEJXjrZH3+sOGPYI0XBkYXEBL+UlAeoFJeABMNulqaTKgmp2ZRcZcmScU5lx3hneppKIXfnfPLv1+BCDkxerjhH5wHXjV+jrA1WMx91bD2YJUM7n/4FzlHW/hqK+5nsI8x4X+ZhyNe86tV9kdPU59oXsb7B4J/5cTAQxiBqd8rXhPgrlcdtuTPnDBG1i29ZPP+evUmKKbwOMUXaUcu0q4L/yAg/ig0IVNxaJEFpI0XRCwpZIWpEAQvPtvrvubGEAdjs61u+u612z8efNloY1cLp5xY8C9eKA6C4/DuclHkLVfHbyjCJcDNbC/aG6RU1YsEBVQwob/1rokzMy91rygqXFsBF+kQyI/uj23XiCq8rI2JphxL9BkRNFGqRe3BHlB7J1yKXeGPqI1Z8Po5OtMpJtV+TmvaazXpiVFfqB3yZ/nzieqNrm13RcYizgTBi22reXqd+SeWJK5AuAbWB3L8BUrvkqmsehjZJab9lqqKt20lqLM4Tc/4+ktYXhFmJdwAMIIMCkJmKgT0j6rqpoPNJ2YFECZw25/3IV8Q3V7gVF4Jvp87V9Q72I74KjUp8PdvEFFNMnh/3CAQ9LLTZbs89vra7j9JrLsZ4fLQkdamldR7wDot3KNlXqwI+NZyNg4rT3e28gW1pprUz8yy6W26BqlrDLLzuVXcqEy/5VhvlHRw9xV81jzrdKfrNVTBfTpYNUtpRH3EodehyIf9iyaoUdV7mDiGiGWzzXObcPo8vkH8oTMbmzP7t
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ac8fe8-d2aa-44f3-5ea4-08dad1837b02
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 20:59:46.0708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1116
X-Proofpoint-GUID: Kg1rHyFCei5VhlQPJ1bAAp4Z4bT2wqdo
X-Proofpoint-ORIG-GUID: Kg1rHyFCei5VhlQPJ1bAAp4Z4bT2wqdo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_17,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211280151

------=_NextPart_000_00CE_01D90331.AB145EA0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_00CF_01D90331.AB145EA0"


------=_NextPart_001_00CF_01D90331.AB145EA0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sounds good. I built the latest kernel (with lock debugging re-enabled). I
am running our test case as we speak. I have not encountered a crash yet,
but there was a little bit of debug output from the kernel that I have
attached in this email. Also, I am definitely still seeing a lot of the
threads be priority boosted forever. Let me know if you can think of other
ways to help debug that priority issue.


Thanks,

Russell 

------=_NextPart_001_00CF_01D90331.AB145EA0
Content-Type: text/plain;
	name="stack_trace.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="stack_trace.txt"

Nov 28 12:46:20 10.243.0.116 [  605.511149] ------------[ cut here =
]------------
Nov 28 12:46:20 10.243.0.116 [  605.511154] =
DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled())
Nov 28 12:46:20 10.243.0.116 [  605.511168] WARNING: CPU: 5 PID: 1858 at =
kernel/locking/lockdep.c:5550 check_flags+0x1a4/0x1d0
Nov 28 12:46:20 10.243.0.116 [  605.511183] Modules linked in: =
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
intel_cstate pcspkr joydev input_leds intel_pch_thermal i2c_i801 =
i2c_smbus sg ftdi_sio mei_me lpc_ich mfd_core mei ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper sd_mod sr_mod =
syscopyarea sysfillrect sysimgblt cdrom fb_sys_fops t10_pi =
drm_ttm_helper ttm drm ixgbe ahci libahc
Nov 28 12:46:20 10.243.0.116 [  605.511353]  igb crc32c_intel libata =
mdio ptp i2c_algo_bit pps_core dca fuse
Nov 28 12:46:20 10.243.0.116 [  605.511372] CPU: 5 PID: 1858 Comm: =
TxStartup Not tainted 5.15.77evl-gaf7e24df1f51 #3
Nov 28 12:46:20 10.243.0.116 [  605.511380] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Nov 28 12:46:20 10.243.0.116 [  605.511383] IRQ stage: Linux
Nov 28 12:46:20 10.243.0.116 [  605.511386] RIP: =
0010:check_flags+0x1a4/0x1d0
Nov 28 12:46:20 10.243.0.116 [  605.511393] Code: ff ff e8 9f b4 6a ff =
85 c0 74 21 44 8b 05 0c 45 60 01 45 85 c0 75 15 48 c7 c6 40 05 69 ab 48 =
c7 c7 00 d4 68 ab e8 f0 e2 f9 ff <0f> 0b 48 c7 c7 80 05 69 ab e8 69 7a =
fa ff e9 5c ff ff ff 65 48 8b
Nov 28 12:46:20 10.243.0.116 [  605.511398] RSP: 0018:ffff888120cb7d90 =
EFLAGS: 00010082
Nov 28 12:46:20 10.243.0.116 [  605.511404] RAX: 0000000000000000 RBX: =
1ffff11024196fb8 RCX: 0000000000000027
Nov 28 12:46:20 10.243.0.116 [  605.511408] RDX: 0000000000000027 RSI: =
dffffc0000000000 RDI: ffff8883de137b78
Nov 28 12:46:20 10.243.0.116 [  605.511412] RBP: ffff888120cb7d90 R08: =
ffffed107bc26f70 R09: ffffed107bc26f70
Nov 28 12:46:20 10.243.0.116 [  605.511416] R10: ffff8883de137b7b R11: =
ffffed107bc26f6f R12: ffff888120cb7e80
Nov 28 12:46:20 10.243.0.116 [  605.511420] R13: 0000000000000005 R14: =
0000000000000000 R15: 0000000000000000
Nov 28 12:46:20 10.243.0.116 [  605.511423] FS:  00007f1ddeffe700(0000) =
GS:ffff8883de100000(0000) knlGS:0000000000000000
Nov 28 12:46:20 10.243.0.116 [  605.511429] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 28 12:46:20 10.243.0.116 [  605.511433] CR2: 0000000000000000 CR3: =
000000010af38002 CR4: 00000000003706e0
Nov 28 12:46:20 10.243.0.116 [  605.511436] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 28 12:46:20 10.243.0.116 [  605.511439] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 28 12:46:21 10.243.0.116 [  605.511443] Call Trace:
Nov 28 12:46:21 10.243.0.116 [  605.511445]  <TASK>
Nov 28 12:46:21 10.243.0.116 [  605.511449]  lock_acquire+0x150/0x3f0
Nov 28 12:46:21 10.243.0.116 [  605.511462]  ? =
lockdep_hardirqs_on_prepare+0x250/0x250
Nov 28 12:46:21 10.243.0.116 [  605.511471]  ? lock_release+0x2ac/0x440
Nov 28 12:46:21 10.243.0.116 [  605.511479]  ? =
__context_tracking_enter+0x6f/0x80
Nov 28 12:46:21 10.243.0.116 [  605.511487]  ? =
lock_downgrade+0x3e0/0x3e0
Nov 28 12:46:21 10.243.0.116 [  605.511496]  ? =
rcu_read_lock_sched_held+0x5b/0xd0
Nov 28 12:46:21 10.243.0.116 [  605.511507]  ? sched_clock+0x9/0x10
Nov 28 12:46:21 10.243.0.116 [  605.511516]  vtime_user_exit+0x73/0x130
Nov 28 12:46:21 10.243.0.116 [  605.511523]  ? =
__context_tracking_exit+0x60/0x70
Nov 28 12:46:21 10.243.0.116 [  605.511532]  =
__context_tracking_exit+0x60/0x70
Nov 28 12:46:21 10.243.0.116 [  605.511539]  =
syscall_enter_from_user_mode+0xd8/0x130
Nov 28 12:46:21 10.243.0.116 [  605.511547]  do_syscall_64+0x1d/0xa0
Nov 28 12:46:21 10.243.0.116 [  605.511557]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 28 12:46:21 10.243.0.116 [  605.511565] RIP: 0033:0x7f1df05bce44
Nov 28 12:46:21 10.243.0.116 [  605.511571] Code: ff 31 c0 87 83 1c 06 =
00 00 83 f8 fe 0f 84 42 02 00 00 48 8b 54 24 08 be 18 00 00 00 b8 11 01 =
00 00 48 8d ba e0 02 00 00 0f 05 <f6> 82 14 06 00 00 04 0f 85 e9 01 00 =
00 48 8d 7c 24 10 48 c7 44 24
Nov 28 12:46:21 10.243.0.116 [  605.511576] RSP: 002b:00007f1ddefee960 =
EFLAGS: 00000202 ORIG_RAX: 0000000000000111
Nov 28 12:46:21 10.243.0.116 [  605.511581] RAX: ffffffffffffffda RBX: =
00007f1ddeffe700 RCX: 00007f1df05bce44
Nov 28 12:46:21 10.243.0.116 [  605.511585] RDX: 00007f1ddeffe700 RSI: =
0000000000000018 RDI: 00007f1ddeffe9e0
Nov 28 12:46:21 10.243.0.116 [  605.511589] RBP: 0000000000000000 R08: =
00007f1ddeffe700 R09: 00007f1ddeffe700
Nov 28 12:46:21 10.243.0.116 [  605.511592] R10: 00007f1ddeffe9d0 R11: =
0000000000000202 R12: 0000000000000001
Nov 28 12:46:21 10.243.0.116 [  605.511596] R13: 0000000001001000 R14: =
0000000000000000 R15: 00007f1ddeffe700
Nov 28 12:46:21 10.243.0.116 [  605.511607]  </TASK>
Nov 28 12:46:21 10.243.0.116 [  605.511610] irq event stamp: 6
Nov 28 12:46:21 10.243.0.116 [  605.511612] hardirqs last  enabled at =
(5): [<ffffffffaa002725>] ret_from_fork+0x15/0x30
Nov 28 12:46:21 10.243.0.116 [  605.511621] hardirqs last disabled at =
(6): [<ffffffffab13d46d>] do_syscall_64+0x1d/0xa0
Nov 28 12:46:21 10.243.0.116 [  605.511630] softirqs last  enabled at =
(0): [<ffffffffaa0c4f7a>] copy_process+0x12fa/0x3750
Nov 28 12:46:21 10.243.0.116 [  605.511638] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Nov 28 12:46:21 10.243.0.116 [  605.511645] ---[ end trace =
19749a8d325a12e0 ]---
Nov 28 12:46:21 10.243.0.116 [  605.511650] possible reason: unannotated =
irqs-on.
Nov 28 12:46:21 10.243.0.116 [  605.511653] irq event stamp: 6
Nov 28 12:46:21 10.243.0.116 [  605.511656] hardirqs last  enabled at =
(5): [<ffffffffaa002725>] ret_from_fork+0x15/0x30
Nov 28 12:46:21 10.243.0.116 [  605.511669] hardirqs last disabled at =
(6): [<ffffffffab13d46d>] do_syscall_64+0x1d/0xa0
Nov 28 12:46:21 10.243.0.116 [  605.511678] softirqs last  enabled at =
(0): [<ffffffffaa0c4f7a>] copy_process+0x12fa/0x3750
Nov 28 12:46:21 10.243.0.116 [  605.511684] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Nov 28 12:46:21 10.243.0.116 [  606.064136] ------------[ cut here =
]------------
Nov 28 12:46:21 10.243.0.116 [  606.064142] WARNING: CPU: 5 PID: 1858 at =
kernel/evl/mutex.c:846 __evl_unlock_mutex+0x2b4/0x430
Nov 28 12:46:21 10.243.0.116 [  606.064163] Modules linked in: =
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
intel_cstate pcspkr joydev input_leds intel_pch_thermal i2c_i801 =
i2c_smbus sg ftdi_sio mei_me lpc_ich mfd_core mei ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper sd_mod sr_mod =
syscopyarea sysfillrect sysimgblt cdrom fb_sys_fops t10_pi =
drm_ttm_helper ttm drm ixgbe ahci libahc
Nov 28 12:46:21 10.243.0.116 [  606.064495]  igb crc32c_intel libata =
mdio ptp i2c_algo_bit pps_core dca fuse
Nov 28 12:46:21 10.243.0.116 [  606.064532] CPU: 5 PID: 1858 Comm: =
DummyTxSample Tainted: G        W         5.15.77evl-gaf7e24df1f51 #3
Nov 28 12:46:21 10.243.0.116 [  606.064545] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Nov 28 12:46:21 10.243.0.116 [  606.064550] IRQ stage: EVL
Nov 28 12:46:21 10.243.0.116 [  606.064555] RIP: =
0010:__evl_unlock_mutex+0x2b4/0x430
Nov 28 12:46:21 10.243.0.116 [  606.064568] Code: f7 e8 10 fb 1d 00 48 =
c7 c6 13 11 30 aa 48 89 df 4d 8b 7c 24 78 e8 fc f4 e9 ff 4c 89 e7 e8 b4 =
3f ea ff 41 55 9d 4d 39 fe 75 bc <0f> 0b eb b8 85 c0 75 3c 48 89 df e8 =
ec d7 ff ff e9 52 fe ff ff 65
Nov 28 12:46:21 10.243.0.116 [  606.064578] RSP: 0018:ffff888120cb7ac8 =
EFLAGS: 00010046
Nov 28 12:46:21 10.243.0.116 [  606.064588] RAX: 0000000000000000 RBX: =
ffff888101576018 RCX: ffffffffaa1a5187
Nov 28 12:46:21 10.243.0.116 [  606.064596] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: ffff888101576000
Nov 28 12:46:21 10.243.0.116 [  606.064604] RBP: ffff888120cb7b10 R08: =
ffffed10202aec01 R09: ffffed10202aec01
Nov 28 12:46:21 10.243.0.116 [  606.064612] R10: ffff888101576003 R11: =
ffffed10202aec00 R12: ffff888101576000
Nov 28 12:46:21 10.243.0.116 [  606.064620] R13: 0000000000000082 R14: =
ffff888101576078 R15: ffff888101576078
Nov 28 12:46:21 10.243.0.116 [  606.064629] FS:  00007f1ddeffe700(0000) =
GS:ffff8883de100000(0000) knlGS:0000000000000000
Nov 28 12:46:21 10.243.0.116 [  606.064638] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 28 12:46:21 10.243.0.116 [  606.064646] CR2: 0000000000000000 CR3: =
000000010af38002 CR4: 00000000003706e0
Nov 28 12:46:21 10.243.0.116 [  606.064654] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 28 12:46:21 10.243.0.116 [  606.064660] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 28 12:46:21 10.243.0.116 [  606.064667] Call Trace:
Nov 28 12:46:21 10.243.0.116 [  606.064671]  <TASK>
Nov 28 12:46:21 10.243.0.116 [  606.064690]  =
monitor_oob_ioctl+0x1044/0x16d0
Nov 28 12:46:21 10.243.0.116 [  606.064701]  ? =
rcu_read_lock_held_common+0x25/0x70
Nov 28 12:46:21 10.243.0.116 [  606.064735]  ? enter_monitor+0x160/0x160
Nov 28 12:46:21 10.243.0.116 [  606.064756]  ? lock_release+0xd5/0x440
Nov 28 12:46:21 10.243.0.116 [  606.064771]  ? evl_get_file+0xa3/0x130
Nov 28 12:46:21 10.243.0.116 [  606.064788]  ? =
lock_downgrade+0x3e0/0x3e0
Nov 28 12:46:21 10.243.0.116 [  606.064805]  ? =
do_raw_spin_lock+0x119/0x1e0
Nov 28 12:46:21 10.243.0.116 [  606.064818]  ? spin_dump+0x90/0x90
Nov 28 12:46:21 10.243.0.116 [  606.064828]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Nov 28 12:46:21 10.243.0.116 [  606.064853]  ? =
__kasan_check_read+0x11/0x20
Nov 28 12:46:21 10.243.0.116 [  606.064885]  EVL_ioctl+0x81/0xf0
Nov 28 12:46:21 10.243.0.116 [  606.064906]  do_oob_syscall+0x5ac/0x6c0
Nov 28 12:46:21 10.243.0.116 [  606.064924]  ? =
prepare_for_signal+0x1b0/0x1b0
Nov 28 12:46:21 10.243.0.116 [  606.064956]  =
handle_oob_syscall+0x189/0x230
Nov 28 12:46:21 10.243.0.116 [  606.064974]  ? =
handle_pipelined_syscall+0x840/0x840
Nov 28 12:46:21 10.243.0.116 [  606.064996]  ? =
rcu_read_lock_sched_held+0x5b/0xd0
Nov 28 12:46:21 10.243.0.116 [  606.065013]  ? =
rcu_read_lock_any_held.part.15+0x20/0x20
Nov 28 12:46:21 10.243.0.116 [  606.065038]  pipeline_syscall+0xa7/0x1c0
Nov 28 12:46:21 10.243.0.116 [  606.065062]  =
syscall_enter_from_user_mode+0x5f/0x130
Nov 28 12:46:21 10.243.0.116 [  606.065080]  do_syscall_64+0x1d/0xa0
Nov 28 12:46:21 10.243.0.116 [  606.065097]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 28 12:46:21 10.243.0.116 [  606.065110] RIP: 0033:0x7f1df8382b4b
Nov 28 12:46:21 10.243.0.116 [  606.065119] Code: Unable to access =
opcode bytes at RIP 0x7f1df8382b21.
Nov 28 12:46:21 10.243.0.116 [  606.065124] RSP: 002b:00007f1ddefee3f0 =
EFLAGS: 00000246 ORIG_RAX: 000000000000009d
Nov 28 12:46:21 10.243.0.116 [  606.065135] RAX: ffffffffffffffda RBX: =
00007f1ddefee490 RCX: 00007f1df8382b4b
Nov 28 12:46:21 10.243.0.116 [  606.065143] RDX: 00000000c0186d03 RSI: =
0000000000000049 RDI: 0000000010000002
Nov 28 12:46:21 10.243.0.116 [  606.065150] RBP: 00000000c0186d03 R08: =
0000000000000000 R09: 00007fff8256b080
Nov 28 12:46:21 10.243.0.116 [  606.065158] R10: 00007f1ddefee490 R11: =
0000000000000246 R12: 0000000000000049
Nov 28 12:46:21 10.243.0.116 [  606.065165] R13: 0000000000000001 R14: =
0000000036a20b78 R15: 00007f1ddefee590
Nov 28 12:46:21 10.243.0.116 [  606.065200]  </TASK>
Nov 28 12:46:21 10.243.0.116 [  606.065204] irq event stamp: 6
Nov 28 12:46:21 10.243.0.116 [  606.065208] hardirqs last  enabled at =
(5): [<ffffffffaa002725>] ret_from_fork+0x15/0x30
Nov 28 12:46:21 10.243.0.116 [  606.065222] hardirqs last disabled at =
(6): [<ffffffffab13d46d>] do_syscall_64+0x1d/0xa0
Nov 28 12:46:21 10.243.0.116 [  606.065237] softirqs last  enabled at =
(0): [<ffffffffaa0c4f7a>] copy_process+0x12fa/0x3750
Nov 28 12:46:21 10.243.0.116 [  606.065250] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Nov 28 12:46:21 10.243.0.116 [  606.065258] ---[ end trace =
19749a8d325a12e1 ]---
Nov 28 12:46:21 10.243.0.116 [  606.065296] ------------[ cut here =
]------------
Nov 28 12:46:21 10.243.0.116 [  606.065300] WARNING: CPU: 5 PID: 1858 at =
kernel/evl/sched/core.c:1015 __evl_schedule+0x73a/0x1180
Nov 28 12:46:21 10.243.0.116 [  606.065314] Modules linked in: =
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
intel_cstate pcspkr joydev input_leds intel_pch_thermal i2c_i801 =
i2c_smbus sg ftdi_sio mei_me lpc_ich mfd_core mei ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper sd_mod sr_mod =
syscopyarea sysfillrect sysimgblt cdrom fb_sys_fops t10_pi =
drm_ttm_helper ttm drm ixgbe ahci libahc
Nov 28 12:46:21 10.243.0.116 [  606.065619]  igb crc32c_intel libata =
mdio ptp i2c_algo_bit pps_core dca fuse
Nov 28 12:46:21 10.243.0.116 [  606.065651] CPU: 5 PID: 1858 Comm: =
DummyTxSample Tainted: G        W         5.15.77evl-gaf7e24df1f51 #3
Nov 28 12:46:21 10.243.0.116 [  606.065663] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Nov 28 12:46:21 10.243.0.116 [  606.065668] IRQ stage: EVL
Nov 28 12:46:21 10.243.0.116 [  606.065672] RIP: =
0010:__evl_schedule+0x73a/0x1180
Nov 28 12:46:21 10.243.0.116 [  606.065682] Code: 46 78 48 39 d8 0f 85 =
45 fa ff ff 4c 8b 75 b0 48 c7 c6 1b f7 31 aa 4c 89 f7 e8 02 0f e8 ff 48 =
8b 5d d0 48 89 df e8 b6 59 e8 ff <0f> 0b 68 1b f7 31 aa 31 f6 45 31 c9 =
41 b8 01 00 00 00 31 c9 31 d2
Nov 28 12:46:21 10.243.0.116 [  606.065691] RSP: 0018:ffff888120cb7960 =
EFLAGS: 00010046
Nov 28 12:46:21 10.243.0.116 [  606.065700] RAX: 0000000000000000 RBX: =
ffff888101576000 RCX: ffffffffaa1a5187
Nov 28 12:46:21 10.243.0.116 [  606.065707] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: ffff888101576000
Nov 28 12:46:21 10.243.0.116 [  606.065713] RBP: ffff888120cb79f0 R08: =
ffffed10202aec01 R09: ffffed10202aec01
Nov 28 12:46:21 10.243.0.116 [  606.065721] R10: ffff888101576003 R11: =
ffffed10202aec00 R12: 0000000010008000
Nov 28 12:46:21 10.243.0.116 [  606.065728] R13: ffff888120cb7a78 R14: =
ffff888101576018 R15: ffff8883de174720
Nov 28 12:46:21 10.243.0.116 [  606.065736] FS:  00007f1ddeffe700(0000) =
GS:ffff8883de100000(0000) knlGS:0000000000000000
Nov 28 12:46:21 10.243.0.116 [  606.065745] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 28 12:46:21 10.243.0.116 [  606.065752] CR2: 0000000000000000 CR3: =
000000010af38002 CR4: 00000000003706e0
Nov 28 12:46:21 10.243.0.116 [  606.065759] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 28 12:46:21 10.243.0.116 [  606.065765] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 28 12:46:21 10.243.0.116 [  606.065771] Call Trace:
Nov 28 12:46:21 10.243.0.116 [  606.065775]  <TASK>
Nov 28 12:46:21 10.243.0.116 [  606.065802]  =
handle_irq_pipelined_finish+0x141/0x240
Nov 28 12:46:21 10.243.0.116 [  606.065822]  =
arch_pipeline_entry+0xce/0x110
Nov 28 12:46:21 10.243.0.116 [  606.065839]  =
sysvec_apic_timer_interrupt+0xe/0x20
Nov 28 12:46:21 10.243.0.116 [  606.065851]  =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Nov 28 12:46:21 10.243.0.116 [  606.065864] RIP: =
0010:monitor_oob_ioctl+0x1066/0x16d0
Nov 28 12:46:22 10.243.0.116 [  606.065876] Code: fe ff ff e8 bc 38 00 =
00 48 8b bd 48 fe ff ff 48 c7 c6 be d5 2f aa e8 49 30 ea ff 48 8b bd 58 =
fe ff ff e8 fd 7a ea ff 41 55 9d <48> 8b bd 38 fe ff ff e8 4e d2 01 00 =
41 89 c5 85 c0 0f 84 c9 00 00
Nov 28 12:46:22 10.243.0.116 [  606.065885] RSP: 0018:ffff888120cb7b20 =
EFLAGS: 00000246
Nov 28 12:46:22 10.243.0.116 [  606.065893] RAX: 0000000000000000 RBX: =
ffff8881078c2a50 RCX: ffffffffaa1a5187
Nov 28 12:46:22 10.243.0.116 [  606.065900] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: ffff88811a51e220
Nov 28 12:46:22 10.243.0.116 [  606.065904] RBP: ffff888120cb7d08 R08: =
ffffed10234a3c45 R09: ffffed10234a3c45
Nov 28 12:46:22 10.243.0.116 [  606.065907] R10: ffff88811a51e223 R11: =
ffffed10234a3c44 R12: 00007f1ddefee490
Nov 28 12:46:22 10.243.0.116 [  606.065911] R13: 0000000000000246 R14: =
ffff888101576000 R15: ffff88811a51e000
Nov 28 12:46:22 10.243.0.116 [  606.065921]  ? =
do_raw_spin_unlock+0x97/0x140
Nov 28 12:46:22 10.243.0.116 [  606.065932]  ? =
rcu_read_lock_held_common+0x25/0x70
Nov 28 12:46:22 10.243.0.116 [  606.065947]  ? enter_monitor+0x160/0x160
Nov 28 12:46:22 10.243.0.116 [  606.065957]  ? lock_release+0xd5/0x440
Nov 28 12:46:22 10.243.0.116 [  606.065964]  ? evl_get_file+0xa3/0x130
Nov 28 12:46:22 10.243.0.116 [  606.065972]  ? =
lock_downgrade+0x3e0/0x3e0
Nov 28 12:46:22 10.243.0.116 [  606.065981]  ? =
do_raw_spin_lock+0x119/0x1e0
Nov 28 12:46:22 10.243.0.116 [  606.065987]  ? spin_dump+0x90/0x90
Nov 28 12:46:22 10.243.0.116 [  606.065992]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Nov 28 12:46:22 10.243.0.116 [  606.066004]  ? =
__kasan_check_read+0x11/0x20
Nov 28 12:46:22 10.243.0.116 [  606.066018]  EVL_ioctl+0x81/0xf0
Nov 28 12:46:22 10.243.0.116 [  606.066028]  do_oob_syscall+0x5ac/0x6c0
Nov 28 12:46:22 10.243.0.116 [  606.066037]  ? =
prepare_for_signal+0x1b0/0x1b0
Nov 28 12:46:22 10.243.0.116 [  606.066051]  =
handle_oob_syscall+0x189/0x230
Nov 28 12:46:22 10.243.0.116 [  606.066060]  ? =
handle_pipelined_syscall+0x840/0x840
Nov 28 12:46:22 10.243.0.116 [  606.066070]  ? =
rcu_read_lock_sched_held+0x5b/0xd0
Nov 28 12:46:22 10.243.0.116 [  606.066079]  ? =
rcu_read_lock_any_held.part.15+0x20/0x20
Nov 28 12:46:22 10.243.0.116 [  606.066091]  pipeline_syscall+0xa7/0x1c0
Nov 28 12:46:22 10.243.0.116 [  606.066103]  =
syscall_enter_from_user_mode+0x5f/0x130
Nov 28 12:46:22 10.243.0.116 [  606.066112]  do_syscall_64+0x1d/0xa0
Nov 28 12:46:22 10.243.0.116 [  606.066120]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 28 12:46:22 10.243.0.116 [  606.066127] RIP: 0033:0x7f1df8382b4b
Nov 28 12:46:22 10.243.0.116 [  606.066131] Code: Unable to access =
opcode bytes at RIP 0x7f1df8382b21.
Nov 28 12:46:22 10.243.0.116 [  606.066134] RSP: 002b:00007f1ddefee3f0 =
EFLAGS: 00000246 ORIG_RAX: 000000000000009d
Nov 28 12:46:22 10.243.0.116 [  606.066139] RAX: ffffffffffffffda RBX: =
00007f1ddefee490 RCX: 00007f1df8382b4b
Nov 28 12:46:22 10.243.0.116 [  606.066143] RDX: 00000000c0186d03 RSI: =
0000000000000049 RDI: 0000000010000002
Nov 28 12:46:22 10.243.0.116 [  606.066147] RBP: 00000000c0186d03 R08: =
0000000000000000 R09: 00007fff8256b080
Nov 28 12:46:22 10.243.0.116 [  606.066150] R10: 00007f1ddefee490 R11: =
0000000000000246 R12: 0000000000000049
Nov 28 12:46:22 10.243.0.116 [  606.066153] R13: 0000000000000001 R14: =
0000000036a20b78 R15: 00007f1ddefee590
Nov 28 12:46:22 10.243.0.116 [  606.066169]  </TASK>
Nov 28 12:46:22 10.243.0.116 [  606.066171] irq event stamp: 6
Nov 28 12:46:22 10.243.0.116 [  606.066173] hardirqs last  enabled at =
(5): [<ffffffffaa002725>] ret_from_fork+0x15/0x30
Nov 28 12:46:22 10.243.0.116 [  606.066180] hardirqs last disabled at =
(6): [<ffffffffab13d46d>] do_syscall_64+0x1d/0xa0
Nov 28 12:46:22 10.243.0.116 [  606.066188] softirqs last  enabled at =
(0): [<ffffffffaa0c4f7a>] copy_process+0x12fa/0x3750
Nov 28 12:46:22 10.243.0.116 [  606.066194] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Nov 28 12:46:22 10.243.0.116 [  606.066198] ---[ end trace =
19749a8d325a12e2 ]---

Nov 28 12:47:46 10.243.0.116 [  691.063089] EVL: DummyRxService =
switching in-band [pid=3D1994, excpt=3D14, user_pc=3D0x7f1df837d580]


------=_NextPart_001_00CF_01D90331.AB145EA0--

------=_NextPart_000_00CE_01D90331.AB145EA0
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
9w0BCQUxDxcNMjIxMTI4MjA1OTQ0WjAvBgkqhkiG9w0BCQQxIgQgJuauUkJfrdsGWGHN6f/0hiXn
mqS579MYj9cN36/Jj3EwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQA3
Mmd5SMkA7FSKgzslccPOwOLdKvcj34EaA+rEq8ZyPI5g3L6BY/CwQ6VvdBMwa8kf5Fe5jDgZMtBM
1Rj0Ws+4DR0AhAjQ6D3gq8dUvSU8AbeSRdTZ5HMJ7+E1OKuzeVxIUsVv+qBHeSMyi0T2tLTdn6su
eeTh9Q1Gl5lPksep2Bfxuwwfa749UBRLrPECOz0o6xJ1qEE4wJ5jL32/z2vtzOoo+Wyg5auWvW2g
bMSwzXXdV4Y6NJaU42fXOJZvqPhFoy5RoNZCocDNo3JwuDApNLRZOJ/yrUtd3vzUjXuT9Vs3Xl6h
Di63g+dJhLzeoHJMfmbPFofy5WI3fi9wl6snAAAAAAAA

------=_NextPart_000_00CE_01D90331.AB145EA0--
