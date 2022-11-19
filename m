Received: from mx0a-001f5801.pphosted.com (mx0a-001f5801.pphosted.com [148.163.157.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6A83C36
	for <xenomai@lists.linux.dev>; Sat, 19 Nov 2022 18:11:26 +0000 (UTC)
Received: from pps.filterd (m0090334.ppops.net [127.0.0.1])
	by mx0a-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AJFx0d4031429;
	Sat, 19 Nov 2022 10:11:25 -0800
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02lp0144.outbound.protection.office365.us [23.103.199.144])
	by mx0a-001f5801.pphosted.com (PPS) with ESMTPS id 3kxv88rtsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Nov 2022 10:11:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=PtAeAzFm/NZEt9Cc2ITWarl0qzO3FgPgGF9qZu3SMp848M0bU9EeBq/c/1FgNSqWmkyK5KD71kX6nA+GkBiQH0LyMOflMKjZoKxn5lua8NkwNUV0kvIZUt+m36bI6/4S/hjQ3JK49y2OFb08cK0RWD/lx8NasLYs1oQ3OZ8Ax33aePcnZRVAZUa5cx84Vgbb7Qiu+xIxU+ha83AV631pukYGc2losxo63SOUln+RNJf2RKghgW1xNSXo3/LhnVeJsANd66+osWKaOM72LAYsNuMmVCJoFpyKFwjxod2RGav+XHlXvtcIf8XMQixj/JAW5wsIUU/8hILcMp1OdEwxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XS8D+gonHbwqwuJ29IrFQFERMbTgHgtOQco/ZWpYjeQ=;
 b=zpvpUmpwqrH6EE8T+1trpVtWPWipCQtVci4WYKIBNe9wd8pOVZ8LVLoWC1gAu+D1VJw7SEqoV6B1MScoCn2ioyyu2gJi0BY7yUtDlTZqeUkSBjcKTKeVG/2tFLa38/Gsgzj18UcwPCEUVtIfaAx/XKShfKDH/uZwKc0kTpOwAyOoOpvFiSkGloC+JD3UXhfNIlTLRlEEbWq3dDlYUYJJUWNwKV8kCSdNmDYQV2V3jRSc3tKzZpFDCW4H1BWD3NMroWUPamMWxxzBMH4KGvpW3JrL5emT6tXCfExywTgyHD84UhQVU1b9fqV1Db7AQgYA79vTVmkJhr12p+ySIUvz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS8D+gonHbwqwuJ29IrFQFERMbTgHgtOQco/ZWpYjeQ=;
 b=C/5CSNdtgbFwVXV2UiSHdMC73M1EZLrRf/6EjKNRFSwfifj0RtbAOoRS1YzpAlPIr5Lv4xzQ4PVJZcb++P+62SXQPbrREdb7f5kvaw2Xo+iw5smj1A7L2Uztti+9WSOUYB/WdAG1zp8y9sPImAgSsMKkulrO+k7qGQoUbkDQn8YA7CdwMdEid6K4Ilq3sd04ne23xSVhEIVRHVcjcT50lPahdFCo8GWTTsIVaWCING1NwHVePkQntrCwT17T61vjhaMRMRQGgSMAvJ+LCqaIZICmenLMJ3veM2Vs4YwRc6aSQXyCs136/7tPq2+WBXo1ZFdD5R/jRUa6ievgtIBHUA==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB0955.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:177::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Sat, 19 Nov
 2022 18:11:19 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725%6]) with mapi id 15.20.5813.020; Sat, 19 Nov 2022
 18:11:19 +0000
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
 Adjz0yff24VAOdNORJO8c3TjB/9lSwAgymPQAAE3ZMAAARoBAABtP6rQAH6X0oAAFuqKwAAYlRuAAA/9EKAABRGVgAAsa2CAAAwq7lAAKDcSAAAgIxWAAEP6SSAAAD/QAAADE3cw
Date: Sat, 19 Nov 2022 18:11:19 +0000
Message-ID: 
 <PH1P110MB105043E3D11444BACF142AB6E2089@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
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
 <878rk6dhca.fsf@xenomai.org>
In-Reply-To: <878rk6dhca.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB0955:EE_
x-ms-office365-filtering-correlation-id: 7c31c580-ab54-4c8b-f98b-08daca597542
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 FB+DWHb2TspcjEuMbEKPY9SKXay6kyYhoS1aBoWvsoRImigtBLwp2ce2FGaW58O1wt2P1kS3FITXVKQP5xyET3YeoHVNNhGYeZ0OwE7Uf5eT1j8v6B1hgmOCrlQGWMXkPRxW7wKV0WUHnC8PJDMBkIVhz4Wo+UvyG7DKYZeZh0fM9lb7ljDr+zbusluWb+bSOAtEgjjIrSK0RKmaD+8f8iXCRNwC/lExw2rfhdp0DhyA8IYo2szpemo5yaJo8rVS9b+qGvaF/yEsqu/WvQJvGPr5NxwB6fYSWydNC/t9u1hoiu5eggDYtkgtttpntFa0IpS8KeUS9dNjeOkCUfFXm1it8BodrPYoxUvJZ4seadkPe7mTzuPpEqUTH4V2F7utaP4Hh99tPiQG63oQHeTAr59680+G26TILAuc9R0TsvYzTucKXZZrjE26Xx11V35MgiOIwcMFFeEH9ub5E+GrxH9SGlfAdogEhh6dp/5GtpSrtK4WQAnwFDVyG15+Q0tE9hN/cFIvJvvu/74Gld95WaQuqgXoYCeJp9q/AdbLX/JaR6z/PoKga916nBzpycXZb/SakEe/R/7QaSUF+PPpC715eybOyZkd0CVqmmqMnOnI1s8qr5exc659N5eh9Tb5sRB6kYSp2+FM2ztFt7pUM1LupjHQBUt8o68FNQ00+HLGVDF8GU1hYyjwns1fNL+m
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(122000001)(99936003)(83380400001)(38100700002)(86362001)(38070700005)(8936002)(44832011)(2906002)(52536014)(4326008)(8676002)(76116006)(66946007)(66476007)(66556008)(66446008)(5660300002)(55016003)(107886003)(71200400001)(9686003)(7696005)(6506007)(186003)(6916009)(54906003)(498600001)(64756008)(558084003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?BFOhu/akDmA/2mVIF05ktF9u4WR6WALPoSABy27avdYn+E6ZvtNqvn9Uepge?=
 =?us-ascii?Q?dJw8MvLxkWar8rTRDtl5oRF/FSRNH6EQ4kPdpV7VcIuxfdDC3PDtl5gm7yj1?=
 =?us-ascii?Q?O5DCD2yklP5CtiWcPktx49QP2XoLTPlUudLwC3o3yBknsQyftZCIpcbuYcQ2?=
 =?us-ascii?Q?eTkVyIaLDIEQioMtUnclGim4gqlEHwCrlRFyAPyoAjvOLo8Q45lQWz8MdFGH?=
 =?us-ascii?Q?qQajGTE07Vgt9/i6dWj3qkKCl3D2z1xHW97PfgGH/0fMuryctlQU5OPmCb1h?=
 =?us-ascii?Q?T32MCJqcRxvn48Mm+F0ICQR+fDWcXMP7HAx412PHg9Ss5+vbQp1IPp5QuyPK?=
 =?us-ascii?Q?haUtbvVbH+ScNk0JN8yJmf8DUFw5yi9SA2fnfTxVfmicZnDOdQaek+vomdVE?=
 =?us-ascii?Q?Zh4Kg1ZQty5tBq5Afa/wi9p4DEegc65nGR6N7f8BRL2dnD8x0J2ISd66LCeJ?=
 =?us-ascii?Q?5Zs22NEFIAiJEoStZNVKJrCEM4qyeZ3ZUeCuWH872Z+LM+tZXgzOC5MAFYKR?=
 =?us-ascii?Q?k70jnMvLRwRWcUGl1EmN8Tc2bXBRtiswfEzkp/9YbJKTpuFfsjsIjiWfc68v?=
 =?us-ascii?Q?ewNXpkmm90U77yplTcIeLy956ZGOqrGIiLB/GKTLiWJuT1a4dbdJ44yOrDvQ?=
 =?us-ascii?Q?K0fhLiPCxxFPcL4bx4FS6ZqDEmo6yQmMvJc5qlRgQsxuuZQMKuBbGyxQqxCw?=
 =?us-ascii?Q?6fipWN9wMKv+5LwqTPx71p7aMRLOxLr17Xfktw85LpKWHRsFS7pMtkE66mzd?=
 =?us-ascii?Q?pL4JBBUZRtdB85qJZvbLd/twb5mED9t2Iu6rjVewboAD9MDdISJKW0WzBZBG?=
 =?us-ascii?Q?VG9CNXClEkz3HJNl2rQM4z6+hCsFjyLyvZ3y8P+l6fxy+iuAUM3cNsGubPtJ?=
 =?us-ascii?Q?LR8DmrCQsCBhA64QGkIPaAG/jZk2DNRgCF67cJXoClaOsRUJN4C7gtDQ0eRv?=
 =?us-ascii?Q?r7RlNoLqTCr+jeF86XxNy96zR6V7vCLWfVOQIv5c8CC5Ht2rumviOAdSM/4h?=
 =?us-ascii?Q?P8fh02wgRMX4eikgeEnB7DjbqNhXqk+LJewR+wdmAVyOH2A0ksMWq/HkkRx9?=
 =?us-ascii?Q?nTHUDpTz4/Cqyx1DoSuUwlPGI8r9dtUPREUehzj9mrrRoICWCGzVlXBhHpCc?=
 =?us-ascii?Q?O9ZwusEU03BZPqzgIgtwszpBXIAApGigZkuFAWaLTuskmJefpxJ6HalfYdcy?=
 =?us-ascii?Q?Vo2Kqf6jBkVx/JdAo/ZGbRWLr7AzrxsH0a+bY5+y6VMADQJWkzBQsoe7gWRR?=
 =?us-ascii?Q?X/ThKx68+X8lXzv+KPxW3pgB2YJ3LJkvkXEXnmpp0z3iTRpQPINOFn9hPCZP?=
 =?us-ascii?Q?ML7w55CEj5CH/mw+hu+sHXWaLZF2VTk0tRMQiLZgJ6m7ETa8I/e4ai2EkHIm?=
 =?us-ascii?Q?D5URJQjstYjwwuWLfGSY8r1KWUioMUJ0aQwdk/UQd0tS7PWnU5D3u0dqi5hP?=
 =?us-ascii?Q?vC4GLd8bW7xSccWu83W1YYmgdH7QUoqUGxt7uD+1+UDH+9PLbdKhpek/7aAf?=
 =?us-ascii?Q?DKRMotftgEqKY+EJKIhloD6zUQkhAir3kv3ofrwMicYA3S0Fr37rX2hCYsWC?=
 =?us-ascii?Q?lwchamsWW8TmEhzb7f6eTYLSOaEUaAC98xrk24wiOpV0wI6MXqFs0Js7jnmr?=
 =?us-ascii?Q?Zg=3D=3D?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_007A_01D8FC07.A542AAD0"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yzufQq24112YtOorhiKYncuA7YW5czESa6c6aOjYkF7UM5OVZAjsGqN9ajf5V+oszmf9tFfByTRfoSRxklJqx4U6w1iob87HXpHaeXPC0eVnXDdzlNE9FIQ5M5g5whNTKtw4jemNQGqjKlvGSiATb2qMcfzJAloh4rwFk9FaZU+/3vHzk4Tp3rX3EGiset5EgoSfTIbw5Xwre6J4P4YQzj6ePascIQzqGvG2HYyThKTVOtUMHZc+D7cTYv8pkyBYhI/Kle5R/3naqKSli/jDiwcPkoZ2oKM8K38I5E8dL7kDrv24j8/t3lQ5idIgFCw1qOgXZ/cFsbBUu+dQPMRDeCs1QSZMcR/ba8DKIFo5axFVV3xhcDnnz7o74lpFHqQJBzm5N1B4pQEqK6P8hc3CWUn4q8chb4/ZRCoZmLQ2sxcyHY1+9HIOP+AU2cBnMXyZcgi1L3omV3vlhhd8YibGD9AywjzV2E8dXTbc5ifdIThEtEcuwPNC4KAOtq63pvVjPdmhHfESxoA+x+mbBoQPDFkqNfleH9xBXw6743Y3PHDMm5DcJRdVrltDIp5SG/G65LOSSXadfHMjiWG5i5lZoWuF9Mafy3yFQhRG/Il3Nsy5ITSLJyGataKDgrZxERhH6oI9tFM4D0oWJEcy/7MPPpO1bvHRe1vLogNmzLGNRaAou+wWzzyONfGhy+3Vn8ox7oswdO0oO3jlFbdgXgHzPLRL24Ach9gEnvpTrKkpTxQQ9im0MoGK0LQVnBdQfxNIlcJjYHT1unkU4ry0hVNQOm7NUmUXedjWmIJT2CGT1jcDn9DAlAcALav051upMDNf
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c31c580-ab54-4c8b-f98b-08daca597542
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2022 18:11:19.4101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB0955
X-Proofpoint-ORIG-GUID: mjSL3w8vvEOWvqrgZ5YOMWgI1rMJXP71
X-Proofpoint-GUID: mjSL3w8vvEOWvqrgZ5YOMWgI1rMJXP71
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_08,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211190141

------=_NextPart_000_007A_01D8FC07.A542AAD0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_007B_01D8FC07.A542AAD0"


------=_NextPart_001_007B_01D8FC07.A542AAD0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I just tried to run the app with the latest "next" branch, and it didn't
make it long at all before I got a ton of dump in netconsole. But the
messages look very strange to me. A lot of "printk messages dropped"...
Thoughts?

------=_NextPart_001_007B_01D8FC07.A542AAD0
Content-Type: text/plain;
	name="kdump.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="kdump.txt"

Nov 19 11:05:02 10.243.0.116 [  111.107091] EVL: DummyTxSample switching =
in-band [pid=3D1563, excpt=3D6, __evl_unlock_mutex+0x2a6/0x410]
Nov 19 11:05:02 10.243.0.116 [  111.107128] ------------[ cut here =
]------------
Nov 19 11:05:02 10.243.0.116 [  111.107130] WARNING: CPU: 5 PID: 1563 at =
kernel/evl/sched/core.c:1010 __evl_schedule+0x73a/0x1180
Nov 19 11:05:02 10.243.0.116 [  111.107143] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm iTCO_wdt =
gpio_ich iTCO_vendor_support mxm_wmi irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
pcspkr intel_cstate mei_me sg joydev lpc_ich input_leds i2c_i801 =
ftdi_sio intel_pch_thermal i2c_smbus mei mfd_core ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper syscopyarea =
sysfillrect sysimgblt fb_sys_fops drm_ttm_helper sd_mod sr_mod ttm cdrom =
t10_pi igb drm ixgbe ahci
Nov 19 11:05:02 10.243.0.116 [  111.107359]  libahci libata crc32c_intel =
mdio ptp pps_core i2c_algo_bit dca fuse
Nov 19 11:05:02 10.243.0.116 [  111.107377] CPU: 5 PID: 1563 Comm: =
DummyTxSample Not tainted 5.15.77evl-g8390add2f766 #3
Nov 19 11:05:02 10.243.0.116 [  111.107385] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Nov 19 11:05:02 10.243.0.116 [  111.107388] IRQ stage: EVL
Nov 19 11:05:02 10.243.0.116 [  111.107390] RIP: =
0010:__evl_schedule+0x73a/0x1180
Nov 19 11:05:02 10.243.0.116 [  111.107397] Code: 46 78 48 39 d8 0f 85 =
45 fa ff ff 4c 8b 75 b0 48 c7 c6 fb d1 31 88 4c 89 f7 e8 12 15 e8 ff 48 =
8b 5d d0 48 89 df e8 16 63 e8 ff <0f> 0b 68 fb d1 31 88 31 f6 45 31 c9 =
41 b8 01 00 00 00 31 c9 31 d2
Nov 19 11:05:02 10.243.0.116 ** 302 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.110085]  ? =
evl_switch_inband+0x273/0x820
Nov 19 11:05:02 10.243.0.116 ** 1639 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.129875] EVL: DummyTxSample switching =
in-band [pid=3D1563, excpt=3D6, evl_switch_oob+0x509/0x610]
Nov 19 11:05:02 10.243.0.116 ** 914 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.151205] EVL: DummyTxSample switching =
in-band [pid=3D1563, excpt=3D6, evl_switch_oob+0x509/0x610]
Nov 19 11:05:02 10.243.0.116 ** 1019 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.174977] EVL: DummyTxSample switching =
in-band [pid=3D1563, excpt=3D6, evl_switch_oob+0x509/0x610]
Nov 19 11:05:02 10.243.0.116 ** 1232 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.191438]  ? =
search_exception_tables+0x58/0x60
Nov 19 11:05:02 10.243.0.116 ** 1718 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.202869]  ? =
search_exception_tables+0x58/0x60
Nov 19 11:05:02 10.243.0.116 ** 1643 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.214246] RSP: 0018:fffffe000016bfa8 =
EFLAGS: 00010082
Nov 19 11:05:02 10.243.0.116 ** 1682 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.225557] RBP: fffffe000016c040 R08: =
000000000000000d R09: fffffe000016c360
Nov 19 11:05:02 10.243.0.116 ** 1672 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.237299] RSP: 0018:fffffe000016ddd8 =
EFLAGS: 00010046
Nov 19 11:05:02 10.243.0.116 ** 1600 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.248325]  ? =
do_kern_addr_fault+0x7c/0xb0
Nov 19 11:05:02 10.243.0.116 ** 1757 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.260561] #PF: supervisor read access =
in kernel mode
Nov 19 11:05:02 10.243.0.116 ** 1629 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.272536] RDX: 1ffffffff12d6bd4 RSI: =
0000000000000008 RDI: ffffffff896b5ea0
Nov 19 11:05:02 10.243.0.116 ** 1762 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.284783] RAX: fffffbc00002d7f7 RBX: =
fffffe000016c36d RCX: ffffffff88877714
Nov 19 11:05:02 10.243.0.116 ** 1771 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.297699] Code: b1 ff ff 65 ff 05 94 =
13 f4 76 48 8b 1d 8d a7 0c 01 48 83 eb 08 4c 8d 6b 08 49 81 fd 40 03 1b =
8a 74 3e 48 89 df e8 04 7d 3f ff <83> 3b 03 74 1f 48 8d 75 a8 48 89 df =
e8 93 a3 14 ff 48 8d 73 18 48
Nov 19 11:05:02 10.243.0.116 ** 2861 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.318270] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002ddc3
Nov 19 11:05:02 10.243.0.116 ** 3879 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.345877] RBP: fffffe000016fac0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:02 10.243.0.116 ** 3924 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.373834]  ? =
page_fault_oops+0x3c0/0x3c0
Nov 19 11:05:02 10.243.0.116 ** 3737 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.400598]  ? =
printk_parse_prefix+0x10/0x10
Nov 19 11:05:02 10.243.0.116 ** 3716 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.427673] RAX: 0000000000000000 RBX: =
fffffffffffffff8 RCX: ffffffff890e5bcc
Nov 19 11:05:02 10.243.0.116 ** 3743 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.454397] RSP: 0018:fffffe000016e1e8 =
EFLAGS: 00010046
Nov 19 11:05:02 10.243.0.116 ** 3629 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.480345] PGD 30ae1a067 P4D 30ae1a067 =
PUD 30ae1c067 PMD 0
Nov 19 11:05:02 10.243.0.116 ** 3578 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.505897] RSP: 0018:fffffe000016ea08 =
EFLAGS: 00010046
Nov 19 11:05:02 10.243.0.116 ** 3301 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.529405] RSP: 0018:fffffe000016ec68 =
EFLAGS: 00010046
Nov 19 11:05:02 10.243.0.116 ** 3295 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.553339]  ? =
fixup_exception+0x32/0x420
Nov 19 11:05:02 10.243.0.116 ** 3213 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.577218]  ? cmp_ex_search+0x1e/0x40
Nov 19 11:05:02 10.243.0.116 ** 3216 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.601117]  ? format_decode+0x38/0x5c0
Nov 19 11:05:02 10.243.0.116 ** 3182 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.624834]  ? =
string_nocheck+0x135/0x190
Nov 19 11:05:02 10.243.0.116 ** 2980 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.646616]  ? __die+0x25/0x30
Nov 19 11:05:02 10.243.0.116 ** 2958 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.668190]  ? print_modules+0x88/0x121
Nov 19 11:05:02 10.243.0.116 ** 2970 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.690089]  ? lock_release+0xd5/0x420
Nov 19 11:05:02 10.243.0.116 ** 2967 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.711844]  __die_body+0x1f/0x60
Nov 19 11:05:02 10.243.0.116 ** 2865 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.732997] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002dcbf
Nov 19 11:05:02 10.243.0.116 ** 2871 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.754181] RIP: =
0010:format_decode+0x38/0x5c0
Nov 19 11:05:02 10.243.0.116 ** 2850 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.775220]  =
__bad_area_nosemaphore+0x247/0x2b0
Nov 19 11:05:02 10.243.0.116 ** 2826 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.796007]  ? print_modules+0x88/0x121
Nov 19 11:05:02 10.243.0.116 ** 3032 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.818461]  ? print_modules+0x88/0x121
Nov 19 11:05:02 10.243.0.116 ** 2951 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.840208] RBP: fffffe000016e260 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:02 10.243.0.116 ** 2930 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.861910] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002df49
Nov 19 11:05:02 10.243.0.116 ** 2750 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.881442] RBP: fffffe000016f0f0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:02 10.243.0.116 ** 2702 printk messages dropped **
Nov 19 11:05:02 10.243.0.116 [  111.900716]  ? print_modules+0x88/0x121
Nov 19 11:05:03 10.243.0.116 ** 2632 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  111.919390] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 19 11:05:03 10.243.0.116 ** 2711 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  111.938557]  __die_body+0x1f/0x60
Nov 19 11:05:03 10.243.0.116 ** 2712 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  111.957855]  ? bsearch+0x5e/0x90
Nov 19 11:05:03 10.243.0.116 ** 2667 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  111.976807]  __die_body+0x1f/0x60
Nov 19 11:05:03 10.243.0.116 ** 2654 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  111.995754] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Nov 19 11:05:03 10.243.0.116 ** 2613 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.014442] R10: fffffe000016c447 R11: =
fffffbc00002d888 R12: fffffe000016c1b0
Nov 19 11:05:03 10.243.0.116 ** 2583 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.032807] RIP: =
0010:print_modules+0x88/0x121
Nov 19 11:05:03 10.243.0.116 ** 2679 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.051785] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002df13
Nov 19 11:05:03 10.243.0.116 ** 2658 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.070766] Code: b1 ff ff 65 ff 05 94 =
13 f4 76 48 8b 1d 8d a7 0c 01 48 83 eb 08 4c 8d 6b 08 49 81 fd 40 03 1b =
8a 74 3e 48 89 df e8 04 7d 3f ff <83> 3b 03 74 1f 48 8d 75 a8 48 89 df =
e8 93 a3 14 ff 48 8d 73 18 48
Nov 19 11:05:03 10.243.0.116 ** 4278 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.101133] Oops: 0000 [#595] SMP KASAN =
PTI IRQ_PIPELINE
Nov 19 11:05:03 10.243.0.116 ** 2938 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.121944] RSP: 0018:fffffe000016ec68 =
EFLAGS: 00010046
Nov 19 11:05:03 10.243.0.116 ** 2941 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.142870]  ? =
spurious_kernel_fault+0x200/0x200
Nov 19 11:05:03 10.243.0.116 ** 2999 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.164148] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:03 10.243.0.116 ** 3044 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.185763]  ? cmp_ex_search+0x1e/0x40
Nov 19 11:05:03 10.243.0.116 ** 3032 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.207408] RBP: fffffe000016e0b0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:03 10.243.0.116 ** 3114 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.229353]  ? print_modules+0x88/0x121
Nov 19 11:05:03 10.243.0.116 ** 3062 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.250999] RSP: 0018:fffffe000016e858 =
EFLAGS: 00010046
Nov 19 11:05:03 10.243.0.116 ** 3051 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.272551]  =
kernelmode_fixup_or_oops+0x135/0x160
Nov 19 11:05:03 10.243.0.116 ** 3056 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.294273] Code: b1 ff ff 65 ff 05 94 =
13 f4 76 48 8b 1d 8d a7 0c 01 48 83 eb 08 4c 8d 6b 08 49 81 fd 40 03 1b =
8a 74 3e 48 89 df e8 04 7d 3f ff <83> 3b 03 74 1f 48 8d 75 a8 48 89 df =
e8 93 a3 14 ff 48 8d 73 18 48
Nov 19 11:05:03 10.243.0.116 ** 4808 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.328274] R10: fffffe000016c447 R11: =
fffffbc00002d888 R12: fffffe000016c1b0
Nov 19 11:05:03 10.243.0.116 ** 3251 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.351288]  ? cmp_ex_search+0x1e/0x40
Nov 19 11:05:03 10.243.0.116 ** 3238 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.374322]  ? print_modules+0x88/0x121
Nov 19 11:05:03 10.243.0.116 ** 3110 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.396569] RAX: 0000000000000000 RBX: =
fffffffffffffff8 RCX: ffffffff890e5bcc
Nov 19 11:05:03 10.243.0.116 ** 3165 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.419064]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:03 10.243.0.116 ** 3180 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.441614]  ? print_modules+0x88/0x121
Nov 19 11:05:03 10.243.0.116 ** 3119 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.463774]  __die+0x25/0x30
Nov 19 11:05:03 10.243.0.116 ** 3220 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.486671] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:03 10.243.0.116 ** 3152 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.508794]  ? =
page_fault_oops+0x3c0/0x3c0
Nov 19 11:05:03 10.243.0.116 ** 3152 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.531235] RSP: 0018:fffffe000016f078 =
EFLAGS: 00010046
Nov 19 11:05:03 10.243.0.116 ** 3091 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.553257]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:03 10.243.0.116 ** 3072 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.575168] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002dc89
Nov 19 11:05:03 10.243.0.116 ** 3095 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.597221] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:03 10.243.0.116 ** 3020 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.618727]  ? print_modules+0x88/0x121
Nov 19 11:05:03 10.243.0.116 ** 2968 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.639688]  ? =
spurious_kernel_fault+0x200/0x200
Nov 19 11:05:03 10.243.0.116 ** 2957 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.660824]  __die+0x25/0x30
Nov 19 11:05:03 10.243.0.116 ** 2897 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.681234]  ? =
spurious_kernel_fault+0x200/0x200
Nov 19 11:05:03 10.243.0.116 ** 2886 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.701769]  ? print_modules+0x88/0x121
Nov 19 11:05:03 10.243.0.116 ** 2872 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.722133]  ? cmp_ex_sort+0x50/0x50
Nov 19 11:05:03 10.243.0.116 ** 2860 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.742609]  ? bsearch+0x5e/0x90
Nov 19 11:05:03 10.243.0.116 ** 2776 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.762421]  =
asm_exc_page_fault+0x27/0x30
Nov 19 11:05:03 10.243.0.116 ** 2801 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.782342]  =
__bad_area_nosemaphore+0x247/0x2b0
Nov 19 11:05:03 10.243.0.116 ** 2765 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.801992]  exc_page_fault+0xcf/0xe0
Nov 19 11:05:03 10.243.0.116 ** 2703 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.821245]  =
__bad_area_nosemaphore+0x247/0x2b0
Nov 19 11:05:03 10.243.0.116 ** 2598 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.839693] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:03 10.243.0.116 ** 2597 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.858178] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:03 10.243.0.116 ** 2521 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.876132] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:03 10.243.0.116 ** 2658 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.895034] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:03 10.243.0.116 ** 2611 printk messages dropped **
Nov 19 11:05:03 10.243.0.116 [  112.913512] RAX: 0000000000000000 RBX: =
fffffffffffffff8 RCX: ffffffff890e5bcc
Nov 19 11:05:04 10.243.0.116 ** 2687 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  112.932577]  ? cmp_ex_search+0x1e/0x40
Nov 19 11:05:04 10.243.0.116 ** 2665 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  112.951541] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:04 10.243.0.116 ** 2742 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  112.971047]  ? print_modules+0x88/0x121
Nov 19 11:05:04 10.243.0.116 ** 2706 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  112.990240] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:04 10.243.0.116 ** 2717 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.009578]  ? =
load_module.cold.80+0x38d/0x38d
Nov 19 11:05:04 10.243.0.116 ** 2723 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.029003]  =
kernelmode_fixup_or_oops+0x135/0x160
Nov 19 11:05:04 10.243.0.116 ** 2702 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.048235] RAX: 0000000000f00000 RBX: =
fffffe000016ff00 RCX: fffffe000016c000
Nov 19 11:05:04 10.243.0.116 ** 2693 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.067387] #PF: supervisor read access =
in kernel mode
Nov 19 11:05:04 10.243.0.116 ** 2679 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.086291]  handle_invalid_op+0x3c/0x50
Nov 19 11:05:04 10.243.0.116 ** 2676 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.105305]  ? cmp_ex_sort+0x50/0x50
Nov 19 11:05:04 10.243.0.116 ** 2671 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.124466] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:04 10.243.0.116 ** 2626 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.143121] RBP: fffffe000016e0b0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:04 10.243.0.116 ** 2769 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.162675]  __die_body+0x1f/0x60
Nov 19 11:05:04 10.243.0.116 ** 2799 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.182597] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002df13
Nov 19 11:05:04 10.243.0.116 ** 2811 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.202635]  ? print_modules+0x88/0x121
Nov 19 11:05:04 10.243.0.116 ** 2846 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.222710] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:04 10.243.0.116 ** 2960 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.243832] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:04 10.243.0.116 ** 2962 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.264943]  ? print_modules+0x88/0x121
Nov 19 11:05:04 10.243.0.116 ** 3009 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.286491] RSP: 0018:fffffe000016d408 =
EFLAGS: 00010046
Nov 19 11:05:04 10.243.0.116 ** 2966 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.307454]  ? print_modules+0x88/0x121
Nov 19 11:05:04 10.243.0.116 ** 2959 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.328493] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:04 10.243.0.116 ** 2988 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.349712] RSP: 0018:fffffe000016f078 =
EFLAGS: 00010046
Nov 19 11:05:04 10.243.0.116 ** 2993 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.371071] RSP: 0018:fffffe000016fca0 =
EFLAGS: 00010046
Nov 19 11:05:04 10.243.0.116 ** 2934 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.392004] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:04 10.243.0.116 ** 2949 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.412866] RSP: 0018:fffffe000016fca0 =
EFLAGS: 00010046
Nov 19 11:05:04 10.243.0.116 ** 2947 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.433748] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Nov 19 11:05:04 10.243.0.116 ** 2976 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.454933] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:04 10.243.0.116 ** 3038 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.476370] Call Trace:
Nov 19 11:05:04 10.243.0.116 ** 3047 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.497930] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 19 11:05:04 10.243.0.116 ** 3040 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.519492] RIP: =
0010:irqentry_nmi_enter+0x83/0x90
Nov 19 11:05:04 10.243.0.116 ** 3088 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.541452]  ? =
fixup_exception+0x32/0x420
Nov 19 11:05:04 10.243.0.116 ** 3041 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.562986]  ? bsearch+0x5e/0x90
Nov 19 11:05:04 10.243.0.116 ** 2983 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.584192]  ? print_modules+0x88/0x121
Nov 19 11:05:04 10.243.0.116 ** 2960 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.605183] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables =
=E2=96=92=E2=96=92#023=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=
=92t=E2=96=92#034=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92t=E2=96=92#=
034=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92b#023=E2=96=92=E2=96=92=E2=
=96=92=E2=96=92=E2=96=92(FOKX)
Nov 19 11:05:04 10.243.0.116 ** 7880 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.661029] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:04 10.243.0.116 ** 3219 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.683830] R13: fffffe000016c66a R14: =
ffffffff890e5bcc R15: fffffe000016c0c0
Nov 19 11:05:04 10.243.0.116 ** 3307 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.707368]  ? print_modules+0x88/0x121
Nov 19 11:05:04 10.243.0.116 ** 3259 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.730724] RSP: 0018:fffffe000016dc28 =
EFLAGS: 00010046
Nov 19 11:05:04 10.243.0.116 ** 3257 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.753810] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:04 10.243.0.116 ** 3275 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.777306] RSP: 0018:fffffe000016dc28 =
EFLAGS: 00010046
Nov 19 11:05:04 10.243.0.116 ** 3252 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.800323] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:04 10.243.0.116 ** 3360 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.824208] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:04 10.243.0.116 ** 3334 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.847831]  =
kernelmode_fixup_or_oops+0x135/0x160
Nov 19 11:05:04 10.243.0.116 ** 3356 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.871590]  page_fault_oops+0x124/0x3c0
Nov 19 11:05:04 10.243.0.116 ** 3288 printk messages dropped **
Nov 19 11:05:04 10.243.0.116 [  113.895042] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:05 10.243.0.116 ** 3260 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  113.918243]  __die_body+0x1f/0x60
Nov 19 11:05:05 10.243.0.116 ** 3272 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  113.941486] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:05 10.243.0.116 ** 3229 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  113.964559] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:05 10.243.0.116 ** 3313 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  113.988073] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:05 10.243.0.116 ** 3212 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.010762] CPU: 5 PID: 1563 Comm: =
DummyTxSample Tainted: G        W         5.15.77evl-g8390add2f766 #3
Nov 19 11:05:05 10.243.0.116 ** 3297 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.034199]  ? cmp_ex_sort+0x50/0x50
Nov 19 11:05:05 10.243.0.116 ** 3313 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.057815] Code: b1 ff ff 65 ff 05 94 =
13 f4 76 48 8b 1d 8d a7 0c 01 48 83 eb 08 4c 8d 6b 08 49 81 fd 40 03 1b =
8a 74 3e 48 89 df e8 04 7d 3f ff <83> 3b 03 74 1f 48 8d 75 a8 48 89 df =
e8 93 a3 14 ff 48 8d 73 18 48
Nov 19 11:05:05 10.243.0.116 ** 5069 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.093725]  =
__bad_area_nosemaphore+0x247/0x2b0
Nov 19 11:05:05 10.243.0.116 ** 3438 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.117993]  ? print_modules+0x88/0x121
Nov 19 11:05:05 10.243.0.116 ** 3429 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.142381] RSP: 0018:fffffe000016e448 =
EFLAGS: 00010046
Nov 19 11:05:05 10.243.0.116 ** 3482 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.167381]  ? print_modules+0x88/0x121
Nov 19 11:05:05 10.243.0.116 ** 3332 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.191087] RSP: 0018:fffffe000016d408 =
EFLAGS: 00010046
Nov 19 11:05:05 10.243.0.116 ** 3261 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.214266]  ? print_modules+0x88/0x121
Nov 19 11:05:05 10.243.0.116 ** 3109 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.236211] Call Trace:
Nov 19 11:05:05 10.243.0.116 ** 3056 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.257889]  ? lock_release+0xd5/0x420
Nov 19 11:05:05 10.243.0.116 ** 3024 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.279406]  ? =
search_bpf_extables+0x136/0x190
Nov 19 11:05:05 10.243.0.116 ** 3018 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.300860]  ? =
irqentry_nmi_enter+0x83/0x90
Nov 19 11:05:05 10.243.0.116 ** 2973 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.321983] RBP: fffffe000016ece0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:05 10.243.0.116 ** 3401 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.346007] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:05 10.243.0.116 ** 2996 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.367282] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:05 10.243.0.116 ** 2986 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.388519] RAX: 0000000000000000 RBX: =
1fffffc00002d804 RCX: fffffe000016c040
Nov 19 11:05:05 10.243.0.116 ** 2957 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.409618] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:05 10.243.0.116 ** 3092 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.431683] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:05 10.243.0.116 ** 3110 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.453777] RSP: 0018:fffffe000016e858 =
EFLAGS: 00010046
Nov 19 11:05:05 10.243.0.116 ** 3147 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.476124] Code: b1 ff ff 65 ff 05 94 =
13 f4 76 48 8b 1d 8d a7 0c 01 48 83 eb 08 4c 8d 6b 08 49 81 fd 40 03 1b =
8a 74 3e 48 89 df e8 04 7d 3f ff <83> 3b 03 74 1f 48 8d 75 a8 48 89 df =
e8 93 a3 14 ff 48 8d 73 18 48
Nov 19 11:05:05 10.243.0.116 ** 4918 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.510869]  ? print_modules+0x88/0x121
Nov 19 11:05:05 10.243.0.116 ** 3267 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.534169]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:05 10.243.0.116 ** 3190 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.556829]  ? =
is_prefetch.isra.28+0x8c/0x2b0
Nov 19 11:05:05 10.243.0.116 ** 3103 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.579027]  ? print_modules+0x88/0x121
Nov 19 11:05:05 10.243.0.116 ** 3123 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.601269] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002de91
Nov 19 11:05:05 10.243.0.116 ** 2994 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.622582]  </#DF>
Nov 19 11:05:05 10.243.0.116 ** 2950 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.643616] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:05 10.243.0.116 ** 2965 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.664743]  __die_body+0x1f/0x60
Nov 19 11:05:05 10.243.0.116 ** 3049 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.686558] RSP: 0018:fffffe000016f078 =
EFLAGS: 00010046
Nov 19 11:05:05 10.243.0.116 ** 3013 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.707894] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:05 10.243.0.116 ** 2977 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.728992] CR2: fffffffffffffff8 CR3: =
0000000102568002 CR4: 00000000003706e0
Nov 19 11:05:05 10.243.0.116 ** 3032 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.750679] RSP: 0018:fffffe000016f488 =
EFLAGS: 00010046
Nov 19 11:05:05 10.243.0.116 ** 3111 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.772935]  ? =
fixup_exception+0x32/0x420
Nov 19 11:05:05 10.243.0.116 ** 3126 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.795159] R13: fffffe000016c66a R14: =
ffffffff890e5bcc R15: fffffe000016c0c0
Nov 19 11:05:05 10.243.0.116 ** 3151 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.817580]  ? cmp_ex_search+0x1e/0x40
Nov 19 11:05:05 10.243.0.116 ** 3199 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.840231] RSP: 0018:fffffe000016e858 =
EFLAGS: 00010046
Nov 19 11:05:05 10.243.0.116 ** 3151 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.862704] RBP: fffffe000016e0b0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:05 10.243.0.116 ** 3155 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.885217] RBP: fffffe000016c008 R08: =
fffffe000016c080 R09: fffffe000016c1b0
Nov 19 11:05:05 10.243.0.116 ** 3186 printk messages dropped **
Nov 19 11:05:05 10.243.0.116 [  114.907999] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:06 10.243.0.116 ** 3148 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  114.930370] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:06 10.243.0.116 ** 3148 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  114.952871] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:06 10.243.0.116 ** 3242 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  114.975993] RBP: fffffe000016ff20 R08: =
0000000000000000 R09: 0000000000000000
Nov 19 11:05:06 10.243.0.116 ** 3123 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  114.998016] Call Trace:
Nov 19 11:05:06 10.243.0.116 ** 3119 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.020081]  die+0x38/0x60
Nov 19 11:05:06 10.243.0.116 ** 2980 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.041175]  ? print_modules+0x88/0x121
Nov 19 11:05:06 10.243.0.116 ** 2969 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.062322]  ? bsearch+0x5e/0x90
Nov 19 11:05:06 10.243.0.116 ** 2928 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.083075]  =
asm_exc_invalid_op+0x1b/0x20
Nov 19 11:05:06 10.243.0.116 ** 2934 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.103944] FS:  00007fdce1ffd700(0000) =
GS:ffff8883de480000(0000) knlGS:0000000000000000
Nov 19 11:05:06 10.243.0.116 ** 2986 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.125168]  =
bad_area_nosemaphore+0x11/0x20
Nov 19 11:05:06 10.243.0.116 ** 2927 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.145895]  =
bad_area_nosemaphore+0x11/0x20
Nov 19 11:05:06 10.243.0.116 ** 2955 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.166794] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: fffffe000016ff58
Nov 19 11:05:06 10.243.0.116 ** 2943 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.187730]  ? cmp_ex_search+0x1e/0x40
Nov 19 11:05:06 10.243.0.116 ** 3000 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.209175]  ? print_modules+0x88/0x121
Nov 19 11:05:06 10.243.0.116 ** 2965 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.230204]  =
bad_area_nosemaphore+0x11/0x20
Nov 19 11:05:06 10.243.0.116 ** 2921 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.250899] RAX: 0000000000f00000 RBX: =
fffffe000016ff00 RCX: fffffe000016c000
Nov 19 11:05:06 10.243.0.116 ** 2913 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.271475] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:06 10.243.0.116 ** 2915 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.291998] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 19 11:05:06 10.243.0.116 ** 3037 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.313646]  ? bsearch+0x5e/0x90
Nov 19 11:05:06 10.243.0.116 ** 2956 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.334619]  page_fault_oops+0x124/0x3c0
Nov 19 11:05:06 10.243.0.116 ** 2947 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.355550] RDX: fffffe000016c0c0 RSI: =
fffffe000016c100 RDI: ffffffff890e5bcc
Nov 19 11:05:06 10.243.0.116 ** 2958 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.376506]  ? print_modules+0x88/0x121
Nov 19 11:05:06 10.243.0.116 ** 2957 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.397599] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002dd0b
Nov 19 11:05:06 10.243.0.116 ** 2929 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.418345]  ? print_modules+0x88/0x121
Nov 19 11:05:06 10.243.0.116 ** 2837 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.438354]  ? cmp_ex_search+0x1e/0x40
Nov 19 11:05:06 10.243.0.116 ** 2797 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.458255] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:06 10.243.0.116 ** 2744 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.477688]  ? print_modules+0x88/0x121
Nov 19 11:05:06 10.243.0.116 ** 2733 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.497254]  exc_invalid_op+0x4f/0xa0
Nov 19 11:05:06 10.243.0.116 ** 2678 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.516293] RBP: fffffe000016e4c0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:06 10.243.0.116 ** 2764 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.536044]  ? =
search_exception_tables+0x58/0x60
Nov 19 11:05:06 10.243.0.116 ** 2797 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.555905] IRQ stage: Linux
Nov 19 11:05:06 10.243.0.116 ** 2818 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.575854] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:06 10.243.0.116 ** 2829 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.596067]  ? print_modules+0x88/0x121
Nov 19 11:05:06 10.243.0.116 ** 2810 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.615992]  do_trap+0x126/0x150
Nov 19 11:05:06 10.243.0.116 ** 2790 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.635923] Call Trace:
Nov 19 11:05:06 10.243.0.116 ** 2757 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.655611] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Nov 19 11:05:06 10.243.0.116 ** 2754 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.675289] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:06 10.243.0.116 ** 2827 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.695412] RSP: 0018:fffffe000016c000 =
EFLAGS: 00010046
Nov 19 11:05:06 10.243.0.116 ** 3268 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.718586] RBP: fffffe000016f500 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:06 10.243.0.116 ** 2920 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.739374]  exc_page_fault+0xcf/0xe0
Nov 19 11:05:06 10.243.0.116 ** 2908 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.760026]  __die_body+0x1f/0x60
Nov 19 11:05:06 10.243.0.116 ** 2802 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.779910] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:06 10.243.0.116 ** 2762 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.799458] RSP: 0018:fffffe000016c000 =
EFLAGS: 00010046
Nov 19 11:05:06 10.243.0.116 ** 2804 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.819285] Code: 4e 2a 00 8b 45 c4 c6 =
03 00 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 0f 1f 44 =
00 00 55 48 89 e5 41 57 49 89 d7 <41> 56 49 89 f6 41 55 49 89 cd 41 54 =
49 89 fc 49 8d 79 7f 53 4c 89
Nov 19 11:05:06 10.243.0.116 ** 4331 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.849952]  =
do_kern_addr_fault+0x7c/0xb0
Nov 19 11:05:06 10.243.0.116 ** 2951 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.870933]  ? =
page_fault_oops+0x3c0/0x3c0
Nov 19 11:05:06 10.243.0.116 ** 2947 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.891917]  ? print_modules+0x88/0x121
Nov 19 11:05:06 10.243.0.116 ** 2866 printk messages dropped **
Nov 19 11:05:06 10.243.0.116 [  115.912342]  __die+0x25/0x30
Nov 19 11:05:07 10.243.0.116 ** 2887 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  115.932731] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002de0f
Nov 19 11:05:07 10.243.0.116 ** 2894 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  115.953192] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002de0f
Nov 19 11:05:07 10.243.0.116 ** 2913 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  115.973850]  ? =
search_exception_tables+0x58/0x60
Nov 19 11:05:07 10.243.0.116 ** 2946 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  115.994934]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:07 10.243.0.116 ** 2926 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.015684]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:07 10.243.0.116 ** 2906 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.036280] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:07 10.243.0.116 ** 2925 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.057062] RSP: 0018:fffffe000016d818 =
EFLAGS: 00010046
Nov 19 11:05:07 10.243.0.116 ** 2938 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.077920]  ? print_modules+0x88/0x121
Nov 19 11:05:07 10.243.0.116 ** 2925 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.098752] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002dc07
Nov 19 11:05:07 10.243.0.116 ** 2950 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.119722]  =
bad_area_nosemaphore+0x11/0x20
Nov 19 11:05:07 10.243.0.116 ** 3026 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.141384]  =
bad_area_nosemaphore+0x11/0x20
Nov 19 11:05:07 10.243.0.116 ** 2984 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.162672] RSP: 0018:fffffe000016d408 =
EFLAGS: 00010046
Nov 19 11:05:07 10.243.0.116 ** 2927 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.183611]  =
do_kern_addr_fault+0x7c/0xb0
Nov 19 11:05:07 10.243.0.116 ** 2893 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.204159]  =
bad_area_nosemaphore+0x11/0x20
Nov 19 11:05:07 10.243.0.116 ** 2847 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.224287]  ? print_modules+0x88/0x121
Nov 19 11:05:07 10.243.0.116 ** 2816 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.244401]  ? =
fixup_exception+0x32/0x420
Nov 19 11:05:07 10.243.0.116 ** 2799 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.264242]  =
do_kern_addr_fault+0x7c/0xb0
Nov 19 11:05:07 10.243.0.116 ** 2776 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.283931]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:07 10.243.0.116 ** 2768 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.303637] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:07 10.243.0.116 ** 2695 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.322662] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002dc07
Nov 19 11:05:07 10.243.0.116 ** 2728 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.342050]  =
__bad_area_nosemaphore+0x247/0x2b0
Nov 19 11:05:07 10.243.0.116 ** 2689 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.361279]  __die_body+0x1f/0x60
Nov 19 11:05:07 10.243.0.116 ** 2671 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.380296] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:07 10.243.0.116 ** 2738 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.399728]  ? bsearch+0x5e/0x90
Nov 19 11:05:07 10.243.0.116 ** 2756 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.419419] RSP: 0018:fffffe000016f898 =
EFLAGS: 00010046
Nov 19 11:05:07 10.243.0.116 ** 2683 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.438509]  __die_body+0x1f/0x60
Nov 19 11:05:07 10.243.0.116 ** 2688 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.457615]  ? =
irqentry_nmi_enter+0x83/0x90
Nov 19 11:05:07 10.243.0.116 ** 2546 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.475678]  ? print_modules+0x88/0x121
Nov 19 11:05:07 10.243.0.116 ** 2631 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.494370]  ? =
irqentry_nmi_enter+0x83/0x90
Nov 19 11:05:07 10.243.0.116 ** 2557 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.512592] Call Trace:
Nov 19 11:05:07 10.243.0.116 ** 2541 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.530691] Call Trace:
Nov 19 11:05:07 10.243.0.116 ** 2537 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.548781] R13: ffff888118d24780 R14: =
0000000102568002 R15: 0000000000000000
Nov 19 11:05:07 10.243.0.116 ** 2540 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.566751]  ? =
fixup_exception+0x32/0x420
Nov 19 11:05:07 10.243.0.116 ** 2505 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.584704] Thread overran stack, or =
stack corrupted
Nov 19 11:05:07 10.243.0.116 ** 2526 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.602653] Code: e0 ee 76 85 c0 75 0c =
41 c7 84 24 b8 0d 00 00 00 00 00 00 e8 6f fe ff ff e8 3a 38 19 ff 31 c0 =
88 d8 5b 41 5c 5d c3 cc cc cc cc <0f> 0b 90 66 2e 0f 1f 84 00 00 00 00 =
00 55 48 89 e5 40 84 f6 75 3e
Nov 19 11:05:07 10.243.0.116 ** 3951 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.630726] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002df13
Nov 19 11:05:07 10.243.0.116 ** 2702 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.649819]  __die_body+0x1f/0x60
Nov 19 11:05:07 10.243.0.116 ** 2779 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.669717]  ? cmp_ex_sort+0x50/0x50
Nov 19 11:05:07 10.243.0.116 ** 2729 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.688983] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:07 10.243.0.116 ** 2760 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.708555] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:07 10.243.0.116 ** 2826 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.728458] CR2: fffffffffffffff8 CR3: =
0000000102568002 CR4: 00000000003706e0
Nov 19 11:05:07 10.243.0.116 ** 2905 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.748990]  ? =
spurious_kernel_fault+0x200/0x200
Nov 19 11:05:07 10.243.0.116 ** 2921 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.769761]  ? =
load_module.cold.80+0x38d/0x38d
Nov 19 11:05:07 10.243.0.116 ** 2833 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.789895]  ? print_modules+0x88/0x121
Nov 19 11:05:07 10.243.0.116 ** 2794 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.809787] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:07 10.243.0.116 ** 2821 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.829735] RSP: 0018:fffffe000016ec68 =
EFLAGS: 00010046
Nov 19 11:05:07 10.243.0.116 ** 2867 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.850124] R10: 0000000000000000 R11: =
0000000000000000 R12: ffff888118d24780
Nov 19 11:05:07 10.243.0.116 ** 2861 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.870398]  ? =
fixup_exception+0x32/0x420
Nov 19 11:05:07 10.243.0.116 ** 2907 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.891124] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002df94
Nov 19 11:05:07 10.243.0.116 ** 2926 printk messages dropped **
Nov 19 11:05:07 10.243.0.116 [  116.911916]  ? print_modules+0x88/0x121
Nov 19 11:05:08 10.243.0.116 ** 2984 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  116.933105] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002de91
Nov 19 11:05:08 10.243.0.116 ** 3004 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  116.954490] IRQ stage: Linux
Nov 19 11:05:08 10.243.0.116 ** 3057 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  116.976183]  ? =
search_exception_tables+0x58/0x60
Nov 19 11:05:08 10.243.0.116 ** 3026 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  116.997661] RSP: 0018:fffffe000016ec68 =
EFLAGS: 00010046
Nov 19 11:05:08 10.243.0.116 ** 3538 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.022750] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002de0f
Nov 19 11:05:08 10.243.0.116 ** 3079 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.044692] RAX: 0000000000000000 RBX: =
fffffffffffffff8 RCX: ffffffff890e5bcc
Nov 19 11:05:08 10.243.0.116 ** 3166 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.067261]  __die_body+0x1f/0x60
Nov 19 11:05:08 10.243.0.116 ** 3148 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.089709]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:08 10.243.0.116 ** 3057 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.111510] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:08 10.243.0.116 ** 2983 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.132653]  ? print_modules+0x88/0x121
Nov 19 11:05:08 10.243.0.116 ** 2940 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.153514]  ? print_modules+0x88/0x121
Nov 19 11:05:08 10.243.0.116 ** 2973 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.174717] RSP: 0018:fffffe000016e858 =
EFLAGS: 00010046
Nov 19 11:05:08 10.243.0.116 ** 3024 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.196172] RIP: =
0010:print_modules+0x88/0x121
Nov 19 11:05:08 10.243.0.116 ** 2969 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.217393] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:08 10.243.0.116 ** 2894 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.237877] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:08 10.243.0.116 ** 2894 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.258399] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:08 10.243.0.116 ** 2957 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.279220] CR2: fffffffffffffff8 CR3: =
0000000102568002 CR4: 00000000003706e0
Nov 19 11:05:08 10.243.0.116 ** 3000 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.300647] Code: e0 ee 76 85 c0 75 0c =
41 c7 84 24 b8 0d 00 00 00 00 00 00 e8 6f fe ff ff e8 3a 38 19 ff 31 c0 =
88 d8 5b 41 5c 5d c3 cc cc cc cc <0f> 0b 90 66 2e 0f 1f 84 00 00 00 00 =
00 55 48 89 e5 40 84 f6 75 3e
Nov 19 11:05:08 10.243.0.116 ** 4668 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.333899]  =
kernelmode_fixup_or_oops+0x135/0x160
Nov 19 11:05:08 10.243.0.116 ** 3123 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.356100] RSP: 0018:fffffe000016dc28 =
EFLAGS: 00010046
Nov 19 11:05:08 10.243.0.116 ** 3177 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.378724] Code: e0 ee 76 85 c0 75 0c =
41 c7 84 24 b8 0d 00 00 00 00 00 00 e8 6f fe ff ff e8 3a 38 19 ff 31 c0 =
88 d8 5b 41 5c 5d c3 cc cc cc cc <0f> 0b 90 66 2e 0f 1f 84 00 00 00 00 =
00 55 48 89 e5 40 84 f6 75 3e
Nov 19 11:05:08 10.243.0.116 ** 4805 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.412798] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:08 10.243.0.116 ** 3278 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.435982] RBP: fffffe000016e4c0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:08 10.243.0.116 ** 3352 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.459823]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:08 10.243.0.116 ** 3337 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.483497] RSP: 0018:fffffe000016f078 =
EFLAGS: 00010046
Nov 19 11:05:08 10.243.0.116 ** 3356 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.507257] RSP: 0018:fffffe000016f078 =
EFLAGS: 00010046
Nov 19 11:05:08 10.243.0.116 ** 3363 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.531120]  ? print_modules+0x88/0x121
Nov 19 11:05:08 10.243.0.116 ** 3349 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.554832] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:08 10.243.0.116 ** 3313 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.578463] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:08 10.243.0.116 ** 3314 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.601900]  ? print_modules+0x88/0x121
Nov 19 11:05:08 10.243.0.116 ** 3339 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.625689]  ? print_modules+0x88/0x121
Nov 19 11:05:08 10.243.0.116 ** 3428 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.650011] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:08 10.243.0.116 ** 3288 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.673124]  ? cmp_ex_search+0x1e/0x40
Nov 19 11:05:08 10.243.0.116 ** 3299 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.696451]  __die+0x25/0x30
Nov 19 11:05:08 10.243.0.116 ** 3269 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.719669] RSP: 0018:fffffe000016f898 =
EFLAGS: 00010046
Nov 19 11:05:08 10.243.0.116 ** 3252 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.742707] R13: 0000000000000000 R14: =
0000000000000046 R15: 0000000000000004
Nov 19 11:05:08 10.243.0.116 ** 3293 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.766273] RSP: 0018:fffffe000016d408 =
EFLAGS: 00010046
Nov 19 11:05:08 10.243.0.116 ** 3284 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.789625] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002d9ff
Nov 19 11:05:08 10.243.0.116 ** 3361 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.813545] CR2: fffffffffffffff8 CR3: =
0000000102568002 CR4: 00000000003706e0
Nov 19 11:05:08 10.243.0.116 ** 3290 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.836733] RDX: fffffe000016c0c0 RSI: =
fffffe000016c100 RDI: ffffffff890e5bcc
Nov 19 11:05:08 10.243.0.116 ** 3276 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.860058] R13: 0000000000000000 R14: =
0000000000000046 R15: 0000000000000004
Nov 19 11:05:08 10.243.0.116 ** 3246 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.883163]  ? =
spurious_kernel_fault+0x200/0x200
Nov 19 11:05:08 10.243.0.116 ** 3198 printk messages dropped **
Nov 19 11:05:08 10.243.0.116 [  117.905949] RIP: =
0010:print_modules+0x88/0x121
Nov 19 11:05:09 10.243.0.116 ** 3186 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  117.928575] RBP: fffffe000016dca0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:09 10.243.0.116 ** 3186 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  117.951238] RAX: 0000000000000000 RBX: =
1fffffc00002d804 RCX: fffffe000016c040
Nov 19 11:05:09 10.243.0.116 ** 3125 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  117.973359]  ? =
load_module.cold.80+0x38d/0x38d
Nov 19 11:05:09 10.243.0.116 ** 3055 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  117.995000]  ? print_modules+0x88/0x121
Nov 19 11:05:09 10.243.0.116 ** 3012 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.016566] RSP: 0018:fffffe000016dc28 =
EFLAGS: 00010046
Nov 19 11:05:09 10.243.0.116 ** 3039 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.038146]  ? lock_release+0xd5/0x420
Nov 19 11:05:09 10.243.0.116 ** 3036 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.059839] RBP: fffffe000016ff20 R08: =
0000000000000000 R09: 0000000000000000
Nov 19 11:05:09 10.243.0.116 ** 2990 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.080959] RIP: =
0010:irqentry_nmi_enter+0x83/0x90
Nov 19 11:05:09 10.243.0.116 ** 3016 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.102317] RSP: 0018:fffffe000016f488 =
EFLAGS: 00010046
Nov 19 11:05:09 10.243.0.116 ** 3012 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.123722] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Nov 19 11:05:09 10.243.0.116 ** 2994 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.144945]  =
kernelmode_fixup_or_oops+0x135/0x160
Nov 19 11:05:09 10.243.0.116 ** 3029 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.166381] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:09 10.243.0.116 ** 3067 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.188200]  ? =
search_exception_tables+0x58/0x60
Nov 19 11:05:09 10.243.0.116 ** 3066 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.209925]  <#DF>
Nov 19 11:05:09 10.243.0.116 ** 3097 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.232086]  do_error_trap+0xce/0x1b0
Nov 19 11:05:09 10.243.0.116 ** 3106 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.254177] RBP: fffffe000016f500 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:09 10.243.0.116 ** 3051 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.275866] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:09 10.243.0.116 ** 3140 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.298411] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:09 10.243.0.116 ** 3134 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.320670]  ? print_modules+0x88/0x121
Nov 19 11:05:09 10.243.0.116 ** 3043 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.342407] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:09 10.243.0.116 ** 3027 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.363831] RAX: 0000000000000000 RBX: =
fffffffffffffff8 RCX: ffffffff890e5bcc
Nov 19 11:05:09 10.243.0.116 ** 3065 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.385567]  ? print_modules+0x88/0x121
Nov 19 11:05:09 10.243.0.116 ** 2977 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.406717] FS:  00007fdce1ffd700(0000) =
GS:ffff8883de480000(0000) knlGS:0000000000000000
Nov 19 11:05:09 10.243.0.116 ** 3022 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.428266]  =
asm_exc_page_fault+0x27/0x30
Nov 19 11:05:09 10.243.0.116 ** 3148 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.450750] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:09 10.243.0.116 ** 3455 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.475210]  =
kernelmode_fixup_or_oops+0x135/0x160
Nov 19 11:05:09 10.243.0.116 ** 2955 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.496152]  ? print_modules+0x88/0x121
Nov 19 11:05:09 10.243.0.116 ** 2953 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.517162] CPU: 5 PID: 1563 Comm: =
DummyTxSample Tainted: G        W         5.15.77evl-g8390add2f766 #3
Nov 19 11:05:09 10.243.0.116 ** 3029 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.538698]  =
__bad_area_nosemaphore+0x247/0x2b0
Nov 19 11:05:09 10.243.0.116 ** 3027 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.560206] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002dd0b
Nov 19 11:05:09 10.243.0.116 ** 3076 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.582026] RAX: 0000000000f00000 RBX: =
fffffe000016ff00 RCX: fffffe000016c000
Nov 19 11:05:09 10.243.0.116 ** 3107 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.604112]  ? lock_release+0xd5/0x420
Nov 19 11:05:09 10.243.0.116 ** 3046 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.625698]  __die_body+0x1f/0x60
Nov 19 11:05:09 10.243.0.116 ** 3071 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.647540]  ? print_modules+0x88/0x121
Nov 19 11:05:09 10.243.0.116 ** 2958 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.668660] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:09 10.243.0.116 ** 2932 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.689492] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 19 11:05:09 10.243.0.116 ** 2929 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.710382] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002db85
Nov 19 11:05:09 10.243.0.116 ** 2945 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.731274]  ? print_modules+0x88/0x121
Nov 19 11:05:09 10.243.0.116 ** 3027 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.752744]  ? =
search_exception_tables+0x58/0x60
Nov 19 11:05:09 10.243.0.116 ** 3001 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.774022] RAX: 0000000000000000 RBX: =
1fffffc00002d804 RCX: fffffe000016c040
Nov 19 11:05:09 10.243.0.116 ** 2962 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.795066]  __die_body+0x1f/0x60
Nov 19 11:05:09 10.243.0.116 ** 2958 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.815988]  ? =
load_module.cold.80+0x38d/0x38d
Nov 19 11:05:09 10.243.0.116 ** 2917 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.836615] RIP: =
0010:print_modules+0x88/0x121
Nov 19 11:05:09 10.243.0.116 ** 2906 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.857283]  __die_body+0x1f/0x60
Nov 19 11:05:09 10.243.0.116 ** 2853 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.877497] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:09 10.243.0.116 ** 2792 printk messages dropped **
Nov 19 11:05:09 10.243.0.116 [  118.897412] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002da81
Nov 19 11:05:10 10.243.0.116 ** 2893 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  118.917986] RBP: fffffe000016d480 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:10 10.243.0.116 ** 2891 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  118.938541] RSP: 0018:fffffe000016d408 =
EFLAGS: 00010046
Nov 19 11:05:10 10.243.0.116 ** 2898 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  118.959229] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002da81
Nov 19 11:05:10 10.243.0.116 ** 2927 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  118.980033] Code: b1 ff ff 65 ff 05 94 =
13 f4 76 48 8b 1d 8d a7 0c 01 48 83 eb 08 4c 8d 6b 08 49 81 fd 40 03 1b =
8a 74 3e 48 89 df e8 04 7d 3f ff <83> 3b 03 74 1f 48 8d 75 a8 48 89 df =
e8 93 a3 14 ff 48 8d 73 18 48
Nov 19 11:05:10 10.243.0.116 ** 4631 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.012949]  ? print_modules+0x88/0x121
Nov 19 11:05:10 10.243.0.116 ** 3062 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.034749] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 19 11:05:10 10.243.0.116 ** 3073 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.056565]  ? bsearch+0x5e/0x90
Nov 19 11:05:10 10.243.0.116 ** 3031 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.078172] RIP: =
0010:print_modules+0x88/0x121
Nov 19 11:05:10 10.243.0.116 ** 2967 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.099367] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:10 10.243.0.116 ** 2963 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.120576]  ? =
load_module.cold.80+0x38d/0x38d
Nov 19 11:05:10 10.243.0.116 ** 3017 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.142051] RDX: fffffe000016c0c0 RSI: =
fffffe000016c100 RDI: ffffffff890e5bcc
Nov 19 11:05:10 10.243.0.116 ** 3097 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.164191]  ? =
spurious_kernel_fault+0x200/0x200
Nov 19 11:05:10 10.243.0.116 ** 3101 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.186318] RSP: 0018:fffffe000016d818 =
EFLAGS: 00010046
Nov 19 11:05:10 10.243.0.116 ** 3113 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.208391]  ? =
search_bpf_extables+0x136/0x190
Nov 19 11:05:10 10.243.0.116 ** 3030 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.229736] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 19 11:05:10 10.243.0.116 ** 3021 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.251244]  =
asm_exc_page_fault+0x27/0x30
Nov 19 11:05:10 10.243.0.116 ** 3132 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.273490] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002df94
Nov 19 11:05:10 10.243.0.116 ** 3062 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.295121]  ? cmp_ex_search+0x1e/0x40
Nov 19 11:05:10 10.243.0.116 ** 3054 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.316878] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:10 10.243.0.116 ** 3053 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.338584] R10: 0000000000000000 R11: =
0000000000000000 R12: ffff888118d24780
Nov 19 11:05:10 10.243.0.116 ** 3080 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.360494] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: fffffe000016ff58
Nov 19 11:05:10 10.243.0.116 ** 3163 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.382932]  ? =
spurious_kernel_fault+0x200/0x200
Nov 19 11:05:10 10.243.0.116 ** 3196 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.405745]  exc_page_fault+0xcf/0xe0
Nov 19 11:05:10 10.243.0.116 ** 3118 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.427906] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002db85
Nov 19 11:05:10 10.243.0.116 ** 3139 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.450297]  ? lock_release+0xd5/0x420
Nov 19 11:05:10 10.243.0.116 ** 3041 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.471988] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:10 10.243.0.116 ** 3094 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.493987]  ? print_modules+0x88/0x121
Nov 19 11:05:10 10.243.0.116 ** 2971 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.515050] RSP: 0018:fffffe000016d408 =
EFLAGS: 00010046
Nov 19 11:05:10 10.243.0.116 ** 2900 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.535544] FS:  00007fdce1ffd700(0000) =
GS:ffff8883de480000(0000) knlGS:0000000000000000
Nov 19 11:05:10 10.243.0.116 ** 2930 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.556276] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002db03
Nov 19 11:05:10 10.243.0.116 ** 2989 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.577443] RSP: 0018:fffffe000016e448 =
EFLAGS: 00010046
Nov 19 11:05:10 10.243.0.116 ** 3052 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.599025]  =
__bad_area_nosemaphore+0x247/0x2b0
Nov 19 11:05:10 10.243.0.116 ** 3018 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.620456]  =
do_kern_addr_fault+0x7c/0xb0
Nov 19 11:05:10 10.243.0.116 ** 2986 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.641770]  ? =
search_bpf_extables+0x136/0x190
Nov 19 11:05:10 10.243.0.116 ** 2992 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.663068]  ? print_modules+0x88/0x121
Nov 19 11:05:10 10.243.0.116 ** 2921 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.683888]  ? =
spurious_kernel_fault+0x200/0x200
Nov 19 11:05:10 10.243.0.116 ** 2913 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.704591] RSP: 0018:fffffe000016f078 =
EFLAGS: 00010046
Nov 19 11:05:10 10.243.0.116 ** 2897 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.725246] RBP: fffffe000016f0f0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:10 10.243.0.116 ** 2971 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.746588]  ? =
spurious_kernel_fault+0x200/0x200
Nov 19 11:05:10 10.243.0.116 ** 2954 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.767698] #PF: supervisor read access =
in kernel mode
Nov 19 11:05:10 10.243.0.116 ** 2962 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.788706]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:10 10.243.0.116 ** 2916 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.809388] RSP: 0018:fffffe000016c000 =
EFLAGS: 00010046
Nov 19 11:05:10 10.243.0.116 ** 2916 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.829956] RAX: 0000000000000000 RBX: =
fffffffffffffff8 RCX: ffffffff890e5bcc
Nov 19 11:05:10 10.243.0.116 ** 3426 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.854131] RSP: 0018:fffffe000016c000 =
EFLAGS: 00010046
Nov 19 11:05:10 10.243.0.116 ** 2953 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.875124] RSP: 0018:fffffe000016ec68 =
EFLAGS: 00010046
Nov 19 11:05:10 10.243.0.116 ** 2932 printk messages dropped **
Nov 19 11:05:10 10.243.0.116 [  119.895959] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:11 10.243.0.116 ** 2936 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  119.916762]  ? =
spurious_kernel_fault+0x200/0x200
Nov 19 11:05:11 10.243.0.116 ** 2966 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  119.937959] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:11 10.243.0.116 ** 2928 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  119.958785] RBP: fffffe000016e4c0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:11 10.243.0.116 ** 2999 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  119.980033] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002de0f
Nov 19 11:05:11 10.243.0.116 ** 3000 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.001411]  do_trap+0x126/0x150
Nov 19 11:05:11 10.243.0.116 ** 3005 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.022691] RSP: 0018:fffffe000016e858 =
EFLAGS: 00010046
Nov 19 11:05:11 10.243.0.116 ** 3012 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.044086]  ? =
page_fault_oops+0x3c0/0x3c0
Nov 19 11:05:11 10.243.0.116 ** 2922 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.064714]  ? =
spurious_kernel_fault+0x200/0x200
Nov 19 11:05:11 10.243.0.116 ** 2866 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.084910]  ? =
page_fault_oops+0x3c0/0x3c0
Nov 19 11:05:11 10.243.0.116 ** 2828 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.104949]  ? =
page_fault_oops+0x3c0/0x3c0
Nov 19 11:05:11 10.243.0.116 ** 2804 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.124899]  =
do_kern_addr_fault+0x7c/0xb0
Nov 19 11:05:11 10.243.0.116 ** 2843 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.145264] RBP: fffffe000016c008 R08: =
fffffe000016c080 R09: fffffe000016c1b0
Nov 19 11:05:11 10.243.0.116 ** 2832 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.165329] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002df13
Nov 19 11:05:11 10.243.0.116 ** 2923 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.185987] RSP: 0018:fffffe000016fca0 =
EFLAGS: 00010046
Nov 19 11:05:11 10.243.0.116 ** 2930 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.206828]  ? print_modules+0x88/0x121
Nov 19 11:05:11 10.243.0.116 ** 2916 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.227746] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 19 11:05:11 10.243.0.116 ** 2887 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.248265] RSP: 0018:fffffe000016e038 =
EFLAGS: 00010046
Nov 19 11:05:11 10.243.0.116 ** 2894 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.268736] RSP: 0018:fffffe000016e038 =
EFLAGS: 00010046
Nov 19 11:05:11 10.243.0.116 ** 2894 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.289270] RSP: 0018:fffffe000016e038 =
EFLAGS: 00010046
Nov 19 11:05:11 10.243.0.116 ** 2900 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.309882] FS:  00007fdce1ffd700(0000) =
GS:ffff8883de480000(0000) knlGS:0000000000000000
Nov 19 11:05:11 10.243.0.116 ** 2964 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.330884] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:11 10.243.0.116 ** 2994 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.352227]  ? print_modules+0x88/0x121
Nov 19 11:05:11 10.243.0.116 ** 2984 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.373417] RSP: 0018:fffffe000016c000 =
EFLAGS: 00010046
Nov 19 11:05:11 10.243.0.116 ** 2950 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.394348]  =
asm_exc_page_fault+0x27/0x30
Nov 19 11:05:11 10.243.0.116 ** 2930 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.415006] RSP: 0018:fffffe000016e448 =
EFLAGS: 00010046
Nov 19 11:05:11 10.243.0.116 ** 2894 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.435551] RSP: 0018:fffffe000016e448 =
EFLAGS: 00010046
Nov 19 11:05:11 10.243.0.116 ** 2892 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.455999] RIP: =
0010:print_modules+0x88/0x121
Nov 19 11:05:11 10.243.0.116 ** 2854 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.476102]  ? =
fixup_exception+0x32/0x420
Nov 19 11:05:11 10.243.0.116 ** 2814 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.496116] RSP: 0018:fffffe000016fca0 =
EFLAGS: 00010046
Nov 19 11:05:11 10.243.0.116 ** 2812 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.516037]  ? cmp_ex_sort+0x50/0x50
Nov 19 11:05:11 10.243.0.116 ** 2773 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.535751]  =
do_kern_addr_fault+0x7c/0xb0
Nov 19 11:05:11 10.243.0.116 ** 2800 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.555659]  ? =
search_exception_tables+0x58/0x60
Nov 19 11:05:11 10.243.0.116 ** 2786 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.575297]  ? =
spurious_kernel_fault+0x200/0x200
Nov 19 11:05:11 10.243.0.116 ** 2774 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.594910]  exc_invalid_op+0x4f/0xa0
Nov 19 11:05:11 10.243.0.116 ** 2792 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.614724]  ? lock_release+0xd5/0x420
Nov 19 11:05:11 10.243.0.116 ** 2799 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.634567] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:11 10.243.0.116 ** 2774 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.654337]  ? =
page_fault_oops+0x3c0/0x3c0
Nov 19 11:05:11 10.243.0.116 ** 2728 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.673753]  ? =
load_module.cold.80+0x38d/0x38d
Nov 19 11:05:11 10.243.0.116 ** 2706 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.692986] RAX: 0000000000000000 RBX: =
1fffffc00002d804 RCX: fffffe000016c040
Nov 19 11:05:11 10.243.0.116 ** 2741 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.712540] Call Trace:
Nov 19 11:05:11 10.243.0.116 ** 2680 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.731548]  ? =
page_fault_oops+0x3c0/0x3c0
Nov 19 11:05:11 10.243.0.116 ** 2678 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.750619] FS:  00007fdce1ffd700(0000) =
GS:ffff8883de480000(0000) knlGS:0000000000000000
Nov 19 11:05:11 10.243.0.116 ** 2743 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.770171] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:11 10.243.0.116 ** 2725 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.789539] RAX: 0000000000000000 RBX: =
fffffffffffffff8 RCX: ffffffff890e5bcc
Nov 19 11:05:11 10.243.0.116 ** 2789 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.809264] RIP: =
0010:irqentry_nmi_enter+0x83/0x90
Nov 19 11:05:11 10.243.0.116 ** 2711 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.828663] RSP: 0018:fffffe000016e858 =
EFLAGS: 00010046
Nov 19 11:05:11 10.243.0.116 ** 2740 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.848112] R10: fffffe000016c447 R11: =
fffffbc00002d888 R12: fffffe000016c1b0
Nov 19 11:05:11 10.243.0.116 ** 2787 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.867854]  =
__bad_area_nosemaphore+0x247/0x2b0
Nov 19 11:05:11 10.243.0.116 ** 2784 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.887655]  ? cmp_ex_search+0x1e/0x40
Nov 19 11:05:11 10.243.0.116 ** 2778 printk messages dropped **
Nov 19 11:05:11 10.243.0.116 [  120.907399] RAX: 0000000000f00000 RBX: =
fffffe000016ff00 RCX: fffffe000016c000
Nov 19 11:05:12 10.243.0.116 ** 2797 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  120.927203]  ? =
search_exception_tables+0x58/0x60
Nov 19 11:05:12 10.243.0.116 ** 2805 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  120.947088] RSP: 0018:fffffe000016e858 =
EFLAGS: 00010046
Nov 19 11:05:12 10.243.0.116 ** 2826 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  120.967127] RBP: fffffe000016e0b0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:12 10.243.0.116 ** 2876 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  120.987552]  ? print_modules+0x88/0x121
Nov 19 11:05:12 10.243.0.116 ** 2890 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.008095] RDX: fffffe000016c0c0 RSI: =
fffffe000016c100 RDI: ffffffff890e5bcc
Nov 19 11:05:12 10.243.0.116 ** 2902 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.028720] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:12 10.243.0.116 ** 2970 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.049842]  =
bad_area_nosemaphore+0x11/0x20
Nov 19 11:05:12 10.243.0.116 ** 3019 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.071376]  ? print_modules+0x88/0x121
Nov 19 11:05:12 10.243.0.116 ** 2980 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.092699] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:12 10.243.0.116 ** 3065 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.114431]  ? =
search_exception_tables+0x58/0x60
Nov 19 11:05:12 10.243.0.116 ** 3033 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.135974] RSP: 0018:fffffe000016c000 =
EFLAGS: 00010046
Nov 19 11:05:12 10.243.0.116 ** 3497 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.160859]  =
__bad_area_nosemaphore+0x247/0x2b0
Nov 19 11:05:12 10.243.0.116 ** 3040 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.182482] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:12 10.243.0.116 ** 3026 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.203845]  ? cmp_ex_sort+0x50/0x50
Nov 19 11:05:12 10.243.0.116 ** 3128 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.226146]  ? print_modules+0x88/0x121
Nov 19 11:05:12 10.243.0.116 ** 3048 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.247705] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:12 10.243.0.116 ** 3008 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.268919]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:12 10.243.0.116 ** 2996 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.290390] Oops: 0000 [#6851] SMP KASAN =
PTI IRQ_PIPELINE
Nov 19 11:05:12 10.243.0.116 ** 2929 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.311200]  ? =
fixup_exception+0x32/0x420
Nov 19 11:05:12 10.243.0.116 ** 2921 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.331888]  ? =
is_prefetch.isra.28+0x8c/0x2b0
Nov 19 11:05:12 10.243.0.116 ** 2920 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.352631]  __die+0x25/0x30
Nov 19 11:05:12 10.243.0.116 ** 2838 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.372740]  ? =
search_bpf_extables+0x136/0x190
Nov 19 11:05:12 10.243.0.116 ** 2791 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.392597]  ? print_modules+0x88/0x121
Nov 19 11:05:12 10.243.0.116 ** 2823 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.412569] R13: ffff888118d24780 R14: =
0000000102568002 R15: 0000000000000000
Nov 19 11:05:12 10.243.0.116 ** 2776 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.432282] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:12 10.243.0.116 ** 2827 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.452444] RSP: 0018:fffffe000016c000 =
EFLAGS: 00010046
Nov 19 11:05:12 10.243.0.116 ** 2804 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.472443]  ? print_modules+0x88/0x121
Nov 19 11:05:12 10.243.0.116 ** 2756 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.492111] RSP: 0018:fffffe000016e448 =
EFLAGS: 00010046
Nov 19 11:05:12 10.243.0.116 ** 2795 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.511901] RSP: 0018:fffffe000016d818 =
EFLAGS: 00010046
Nov 19 11:05:12 10.243.0.116 ** 2795 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.531919] RBP: fffffe000016ff20 R08: =
0000000000000000 R09: 0000000000000000
Nov 19 11:05:12 10.243.0.116 ** 2772 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.551658] RSP: 0018:fffffe000016f078 =
EFLAGS: 00010046
Nov 19 11:05:12 10.243.0.116 ** 2767 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.571238] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:12 10.243.0.116 ** 2838 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.591487]  ? cmp_ex_search+0x1e/0x40
Nov 19 11:05:12 10.243.0.116 ** 2830 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.611642] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:12 10.243.0.116 ** 2865 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.631887]  do_trap+0x126/0x150
Nov 19 11:05:12 10.243.0.116 ** 2822 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.651927] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:12 10.243.0.116 ** 2841 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.672196]  ? =
is_prefetch.isra.28+0x8c/0x2b0
Nov 19 11:05:12 10.243.0.116 ** 2796 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.692041]  ? =
page_fault_oops+0x3c0/0x3c0
Nov 19 11:05:12 10.243.0.116 ** 2813 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.712070] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 19 11:05:12 10.243.0.116 ** 2874 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.732563] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:12 10.243.0.116 ** 2894 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.753209] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:12 10.243.0.116 ** 2915 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.773845] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 19 11:05:12 10.243.0.116 ** 2957 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.794886] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:12 10.243.0.116 ** 3060 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.816779] RBP: fffffe000016f500 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:12 10.243.0.116 ** 3052 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.838390]  ? print_modules+0x88/0x121
Nov 19 11:05:12 10.243.0.116 ** 3156 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.860988] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002df13
Nov 19 11:05:12 10.243.0.116 ** 3128 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.883235]  ? cmp_ex_sort+0x50/0x50
Nov 19 11:05:12 10.243.0.116 ** 3249 printk messages dropped **
Nov 19 11:05:12 10.243.0.116 [  121.906265] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:13 10.243.0.116 ** 3167 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  121.928613]  ? lock_release+0xd5/0x420
Nov 19 11:05:13 10.243.0.116 ** 3124 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  121.950865]  ? print_modules+0x88/0x121
Nov 19 11:05:13 10.243.0.116 ** 3081 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  121.972804]  ? =
search_bpf_extables+0x136/0x190
Nov 19 11:05:13 10.243.0.116 ** 3081 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  121.994623]  ? print_modules+0x88/0x121
Nov 19 11:05:13 10.243.0.116 ** 3047 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.016210] #PF: supervisor read access =
in kernel mode
Nov 19 11:05:13 10.243.0.116 ** 3079 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.038047] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:13 10.243.0.116 ** 3010 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.059355] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002db85
Nov 19 11:05:13 10.243.0.116 ** 3101 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.081420]  ? =
load_module.cold.80+0x38d/0x38d
Nov 19 11:05:13 10.243.0.116 ** 3019 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.102802]  __die+0x25/0x30
Nov 19 11:05:13 10.243.0.116 ** 3066 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.124486]  ? =
is_prefetch.isra.28+0x8c/0x2b0
Nov 19 11:05:13 10.243.0.116 ** 2958 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.145473]  ? bsearch+0x5e/0x90
Nov 19 11:05:13 10.243.0.116 ** 2960 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.166469]  exc_invalid_op+0x4f/0xa0
Nov 19 11:05:13 10.243.0.116 ** 2896 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.187139] RIP: =
0010:irqentry_nmi_enter+0x83/0x90
Nov 19 11:05:13 10.243.0.116 ** 2876 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.207531] RSP: 0018:fffffe000016fca0 =
EFLAGS: 00010046
Nov 19 11:05:13 10.243.0.116 ** 2902 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.228173]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:13 10.243.0.116 ** 2869 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.248551]  ? bsearch+0x5e/0x90
Nov 19 11:05:13 10.243.0.116 ** 2823 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.268617]  __die+0x25/0x30
Nov 19 11:05:13 10.243.0.116 ** 2717 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.287816] Code: b1 ff ff 65 ff 05 94 =
13 f4 76 48 8b 1d 8d a7 0c 01 48 83 eb 08 4c 8d 6b 08 49 81 fd 40 03 1b =
8a 74 3e 48 89 df e8 04 7d 3f ff <83> 3b 03 74 1f 48 8d 75 a8 48 89 df =
e8 93 a3 14 ff 48 8d 73 18 48
Nov 19 11:05:13 10.243.0.116 ** 4177 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.317589] RBP: fffffe000016ff20 R08: =
0000000000000000 R09: 0000000000000000
Nov 19 11:05:13 10.243.0.116 ** 2783 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.337297] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 19 11:05:13 10.243.0.116 ** 2812 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.357328] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:13 10.243.0.116 ** 2709 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.376513] RSP: 0018:fffffe000016e858 =
EFLAGS: 00010046
Nov 19 11:05:13 10.243.0.116 ** 2764 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.396121] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:13 10.243.0.116 ** 2821 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.416231] RSP: 0018:fffffe000016cff8 =
EFLAGS: 00010046
Nov 19 11:05:13 10.243.0.116 ** 2828 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.436349]  ? =
is_prefetch.isra.28+0x8c/0x2b0
Nov 19 11:05:13 10.243.0.116 ** 2853 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.456537]  __die_body+0x1f/0x60
Nov 19 11:05:13 10.243.0.116 ** 2846 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.476751]  =
do_kern_addr_fault+0x7c/0xb0
Nov 19 11:05:13 10.243.0.116 ** 3258 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.499901]  ? print_modules+0x88/0x121
Nov 19 11:05:13 10.243.0.116 ** 2799 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.519806]  __die_body+0x1f/0x60
Nov 19 11:05:13 10.243.0.116 ** 2774 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.539476] Oops: 0000 [#7699] SMP KASAN =
PTI IRQ_PIPELINE
Nov 19 11:05:13 10.243.0.116 ** 2727 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.558733]  __die_body+0x1f/0x60
Nov 19 11:05:13 10.243.0.116 ** 2650 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.577701] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:13 10.243.0.116 ** 2642 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.596462] Code: b1 ff ff 65 ff 05 94 =
13 f4 76 48 8b 1d 8d a7 0c 01 48 83 eb 08 4c 8d 6b 08 49 81 fd 40 03 1b =
8a 74 3e 48 89 df e8 04 7d 3f ff <83> 3b 03 74 1f 48 8d 75 a8 48 89 df =
e8 93 a3 14 ff 48 8d 73 18 48
Nov 19 11:05:13 10.243.0.116 ** 4218 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.626371]  ? =
load_module.cold.80+0x38d/0x38d
Nov 19 11:05:13 10.243.0.116 ** 2914 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.647087]  =
do_kern_addr_fault+0x7c/0xb0
Nov 19 11:05:13 10.243.0.116 ** 2907 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.667646]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:13 10.243.0.116 ** 2884 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.688113] RIP: =
0010:print_modules+0x88/0x121
Nov 19 11:05:13 10.243.0.116 ** 2884 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.708617]  ? =
search_bpf_extables+0x136/0x190
Nov 19 11:05:13 10.243.0.116 ** 2914 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.729363]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:13 10.243.0.116 ** 2926 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.750275] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:13 10.243.0.116 ** 2955 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.771250]  page_fault_oops+0x124/0x3c0
Nov 19 11:05:13 10.243.0.116 ** 2888 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.791683]  ? print_modules+0x88/0x121
Nov 19 11:05:13 10.243.0.116 ** 2801 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.811524] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:13 10.243.0.116 ** 2791 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.831307] RAX: 0000000000f00000 RBX: =
fffffe000016ff00 RCX: fffffe000016c000
Nov 19 11:05:13 10.243.0.116 ** 2802 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.851167] RIP: =
0010:irqentry_nmi_enter+0x83/0x90
Nov 19 11:05:13 10.243.0.116 ** 2805 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.871100] RSP: 0018:fffffe000016c000 =
EFLAGS: 00010046
Nov 19 11:05:13 10.243.0.116 ** 2757 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.890715]  =
kernelmode_fixup_or_oops+0x135/0x160
Nov 19 11:05:13 10.243.0.116 ** 2721 printk messages dropped **
Nov 19 11:05:13 10.243.0.116 [  122.909976]  ? cmp_ex_sort+0x50/0x50
Nov 19 11:05:14 10.243.0.116 ** 2764 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  122.929651]  __die_body+0x1f/0x60
Nov 19 11:05:14 10.243.0.116 ** 2726 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  122.948994]  ? print_modules+0x88/0x121
Nov 19 11:05:14 10.243.0.116 ** 2724 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  122.968266] FS:  00007fdce1ffd700(0000) =
GS:ffff8883de480000(0000) knlGS:0000000000000000
Nov 19 11:05:14 10.243.0.116 ** 2806 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  122.988286] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:14 10.243.0.116 ** 2847 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.008467]  ? =
search_bpf_extables+0x136/0x190
Nov 19 11:05:14 10.243.0.116 ** 2911 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.029034] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:14 10.243.0.116 ** 2945 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.049993]  ? =
search_exception_tables+0x58/0x60
Nov 19 11:05:14 10.243.0.116 ** 2955 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.071112] RSP: 0018:fffffe000016d408 =
EFLAGS: 00010046
Nov 19 11:05:14 10.243.0.116 ** 2896 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.091640] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:14 10.243.0.116 ** 2877 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.111928]  ? print_modules+0x88/0x121
Nov 19 11:05:14 10.243.0.116 ** 2877 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.132370] Code: e0 ee 76 85 c0 75 0c =
41 c7 84 24 b8 0d 00 00 00 00 00 00 e8 6f fe ff ff e8 3a 38 19 ff 31 c0 =
88 d8 5b 41 5c 5d c3 cc cc cc cc <0f> 0b 90 66 2e 0f 1f 84 00 00 00 00 =
00 55 48 89 e5 40 84 f6 75 3e
Nov 19 11:05:14 10.243.0.116 ** 4470 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.164375]  ? lock_release+0xd5/0x420
Nov 19 11:05:14 10.243.0.116 ** 3020 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.185655] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:14 10.243.0.116 ** 3051 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.207302]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:14 10.243.0.116 ** 3040 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.228903] RSP: 0018:fffffe000016e448 =
EFLAGS: 00010046
Nov 19 11:05:14 10.243.0.116 ** 3092 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.250890] RSP: 0018:fffffe000016fca0 =
EFLAGS: 00010046
Nov 19 11:05:14 10.243.0.116 ** 3017 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.272313] RAX: 0000000000000000 RBX: =
fffffffffffffff8 RCX: ffffffff890e5bcc
Nov 19 11:05:14 10.243.0.116 ** 3110 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.294462] Code: e0 ee 76 85 c0 75 0c =
41 c7 84 24 b8 0d 00 00 00 00 00 00 e8 6f fe ff ff e8 3a 38 19 ff 31 c0 =
88 d8 5b 41 5c 5d c3 cc cc cc cc <0f> 0b 90 66 2e 0f 1f 84 00 00 00 00 =
00 55 48 89 e5 40 84 f6 75 3e
Nov 19 11:05:14 10.243.0.116 ** 4803 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.328403]  =
__bad_area_nosemaphore+0x247/0x2b0
Nov 19 11:05:14 10.243.0.116 ** 3215 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.351303]  =
bad_area_nosemaphore+0x11/0x20
Nov 19 11:05:14 10.243.0.116 ** 3166 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.373845]  page_fault_oops+0x124/0x3c0
Nov 19 11:05:14 10.243.0.116 ** 3150 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.396316]  ? =
spurious_kernel_fault+0x200/0x200
Nov 19 11:05:14 10.243.0.116 ** 3130 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.418521]  exc_page_fault+0xcf/0xe0
Nov 19 11:05:14 10.243.0.116 ** 3149 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.440918] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:14 10.243.0.116 ** 3185 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.463632]  ? =
fixup_exception+0x32/0x420
Nov 19 11:05:14 10.243.0.116 ** 3163 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.486100]  ? print_modules+0x88/0x121
Nov 19 11:05:14 10.243.0.116 ** 3206 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.508923] PGD 30ae1a067 P4D 30ae1a067 =
PUD 30ae1c067 PMD 0
Nov 19 11:05:14 10.243.0.116 ** 3044 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.530505] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Nov 19 11:05:14 10.243.0.116 ** 3117 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.552614]  =
__bad_area_nosemaphore+0x247/0x2b0
Nov 19 11:05:14 10.243.0.116 ** 3110 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.574696] RAX: 0000000000f00000 RBX: =
fffffe000016ff00 RCX: fffffe000016c000
Nov 19 11:05:14 10.243.0.116 ** 3127 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.596867] RBP: fffffe000016c008 R08: =
fffffe000016c080 R09: fffffe000016c1b0
Nov 19 11:05:14 10.243.0.116 ** 3155 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.619379] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:14 10.243.0.116 ** 3164 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.641816] RBP: fffffe000016ff20 R08: =
0000000000000000 R09: 0000000000000000
Nov 19 11:05:14 10.243.0.116 ** 3231 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.664757] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:14 10.243.0.116 ** 3198 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.687415]  ? =
fixup_exception+0x32/0x420
Nov 19 11:05:14 10.243.0.116 ** 3105 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.709501]  ? =
spurious_kernel_fault+0x200/0x200
Nov 19 11:05:14 10.243.0.116 ** 3116 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.731534]  </#DF>
Nov 19 11:05:14 10.243.0.116 ** 3048 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.753081] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002dc07
Nov 19 11:05:14 10.243.0.116 ** 3163 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.775756] #PF: error_code(0x0000) - =
not-present page
Nov 19 11:05:14 10.243.0.116 ** 3093 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.797603] RSP: 0018:fffffe000016f488 =
EFLAGS: 00010046
Nov 19 11:05:14 10.243.0.116 ** 3076 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.819356]  ? print_modules+0x88/0x121
Nov 19 11:05:14 10.243.0.116 ** 2999 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.840564] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 19 11:05:14 10.243.0.116 ** 2926 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.861409] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002de0f
Nov 19 11:05:14 10.243.0.116 ** 3418 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.885738]  ? print_modules+0x88/0x121
Nov 19 11:05:14 10.243.0.116 ** 2956 printk messages dropped **
Nov 19 11:05:14 10.243.0.116 [  123.906623]  exc_invalid_op+0x4f/0xa0
Nov 19 11:05:15 10.243.0.116 ** 2937 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  123.927399] CR2: fffffffffffffff8 CR3: =
0000000102568002 CR4: 00000000003706e0
Nov 19 11:05:15 10.243.0.116 ** 3029 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  123.948948]  ? print_modules+0x88/0x121
Nov 19 11:05:15 10.243.0.116 ** 3008 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  123.970365] RAX: 0000000000f00000 RBX: =
fffffe000016ff00 RCX: fffffe000016c000
Nov 19 11:05:15 10.243.0.116 ** 3057 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  123.992214]  exc_page_fault+0xcf/0xe0
Nov 19 11:05:15 10.243.0.116 ** 3051 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.013964] RAX: 0000000000f00000 RBX: =
fffffe000016ff00 RCX: fffffe000016c000
Nov 19 11:05:15 10.243.0.116 ** 3094 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.036029] RSP: 0018:fffffe000016ec68 =
EFLAGS: 00010046
Nov 19 11:05:15 10.243.0.116 ** 3089 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.057817]  <#DF>
Nov 19 11:05:15 10.243.0.116 ** 3066 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.079718]  ? =
spurious_kernel_fault+0x200/0x200
Nov 19 11:05:15 10.243.0.116 ** 3017 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.101175] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:15 10.243.0.116 ** 2980 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.122308] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 19 11:05:15 10.243.0.116 ** 2984 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.143569]  =
__bad_area_nosemaphore+0x247/0x2b0
Nov 19 11:05:15 10.243.0.116 ** 2942 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.164529]  ? =
load_module.cold.80+0x38d/0x38d
Nov 19 11:05:15 10.243.0.116 ** 2892 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.184991]  ? print_modules+0x88/0x121
Nov 19 11:05:15 10.243.0.116 ** 2828 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.204921]  ? print_modules+0x88/0x121
Nov 19 11:05:15 10.243.0.116 ** 2814 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.224938] IRQ stage: Linux
Nov 19 11:05:15 10.243.0.116 ** 2793 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.244711]  ? lock_release+0xd5/0x420
Nov 19 11:05:15 10.243.0.116 ** 2748 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.264249] Code: b1 ff ff 65 ff 05 94 =
13 f4 76 48 8b 1d 8d a7 0c 01 48 83 eb 08 4c 8d 6b 08 49 81 fd 40 03 1b =
8a 74 3e 48 89 df e8 04 7d 3f ff <83> 3b 03 74 1f 48 8d 75 a8 48 89 df =
e8 93 a3 14 ff 48 8d 73 18 48
Nov 19 11:05:15 10.243.0.116 ** 4276 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.294556]  ? print_modules+0x88/0x121
Nov 19 11:05:15 10.243.0.116 ** 2861 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.314971]  ? print_modules+0x88/0x121
Nov 19 11:05:15 10.243.0.116 ** 2852 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.335229] R10: fffffe000016c447 R11: =
fffffbc00002d888 R12: fffffe000016c1b0
Nov 19 11:05:15 10.243.0.116 ** 2886 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.355683]  exc_double_fault+0x9f/0x110
Nov 19 11:05:15 10.243.0.116 ** 2834 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.375804] Code: b1 ff ff 65 ff 05 94 =
13 f4 76 48 8b 1d 8d a7 0c 01 48 83 eb 08 4c 8d 6b 08 49 81 fd 40 03 1b =
8a 74 3e 48 89 df e8 04 7d 3f ff <83> 3b 03 74 1f 48 8d 75 a8 48 89 df =
e8 93 a3 14 ff 48 8d 73 18 48
Nov 19 11:05:15 10.243.0.116 ** 4322 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.406518]  =
kernelmode_fixup_or_oops+0x135/0x160
Nov 19 11:05:15 10.243.0.116 ** 2949 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.427481]  handle_invalid_op+0x3c/0x50
Nov 19 11:05:15 10.243.0.116 ** 2916 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.448176]  ? print_modules+0x88/0x121
Nov 19 11:05:15 10.243.0.116 ** 2908 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.468868] Code: b1 ff ff 65 ff 05 94 =
13 f4 76 48 8b 1d 8d a7 0c 01 48 83 eb 08 4c 8d 6b 08 49 81 fd 40 03 1b =
8a 74 3e 48 89 df e8 04 7d 3f ff <83> 3b 03 74 1f 48 8d 75 a8 48 89 df =
e8 93 a3 14 ff 48 8d 73 18 48
Nov 19 11:05:15 10.243.0.116 ** 4474 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.500768]  ? cmp_ex_search+0x1e/0x40
Nov 19 11:05:15 10.243.0.116 ** 2996 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.522172] RSP: 0018:fffffe000016e448 =
EFLAGS: 00010046
Nov 19 11:05:15 10.243.0.116 ** 3021 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.543650]  ? =
search_exception_tables+0x58/0x60
Nov 19 11:05:15 10.243.0.116 ** 2975 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.564814] R13: 0000000000000000 R14: =
0000000000000046 R15: 0000000000000004
Nov 19 11:05:15 10.243.0.116 ** 3060 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.586641]  ? bsearch+0x5e/0x90
Nov 19 11:05:15 10.243.0.116 ** 3045 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.608216] R13: fffffe000016c66a R14: =
ffffffff890e5bcc R15: fffffe000016c0c0
Nov 19 11:05:15 10.243.0.116 ** 2995 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.629413]  ? =
spurious_kernel_fault+0x200/0x200
Nov 19 11:05:15 10.243.0.116 ** 3040 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.651061]  =
do_kern_addr_fault+0x7c/0xb0
Nov 19 11:05:15 10.243.0.116 ** 3001 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.672281]  ? lock_release+0xd5/0x420
Nov 19 11:05:15 10.243.0.116 ** 3005 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.693771]  =
kernelmode_fixup_or_oops+0x135/0x160
Nov 19 11:05:15 10.243.0.116 ** 3017 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.715262]  ? bsearch+0x5e/0x90
Nov 19 11:05:15 10.243.0.116 ** 2995 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.736502] RSP: 0018:fffffe000016d408 =
EFLAGS: 00010046
Nov 19 11:05:15 10.243.0.116 ** 3016 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.757841]  ? =
is_prefetch.isra.28+0x8c/0x2b0
Nov 19 11:05:15 10.243.0.116 ** 3045 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.779382] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002de91
Nov 19 11:05:15 10.243.0.116 ** 2928 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.800172] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:15 10.243.0.116 ** 2962 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.821435] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:15 10.243.0.116 ** 3073 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.843338] RIP: =
0010:print_modules+0x88/0x121
Nov 19 11:05:15 10.243.0.116 ** 3114 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.865446] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:15 10.243.0.116 ** 2999 printk messages dropped **
Nov 19 11:05:15 10.243.0.116 [  124.886619] R10: 0000000000000000 R11: =
0000000000000000 R12: ffff888118d24780
Nov 19 11:05:16 10.243.0.116 ** 2988 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  124.907803] Code: 4e 2a 00 8b 45 c4 c6 =
03 00 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 0f 1f 44 =
00 00 55 48 89 e5 41 57 49 89 d7 <41> 56 49 89 f6 41 55 49 89 cd 41 54 =
49 89 fc 49 8d 79 7f 53 4c 89
Nov 19 11:05:16 10.243.0.116 ** 4504 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  124.939699] RBP: fffffe000016dca0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:16 10.243.0.116 ** 3148 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  124.962083]  =
__bad_area_nosemaphore+0x247/0x2b0
Nov 19 11:05:16 10.243.0.116 ** 3194 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  124.984676]  ? print_modules+0x88/0x121
Nov 19 11:05:16 10.243.0.116 ** 3041 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.006342] RBP: fffffe000016d070 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:16 10.243.0.116 ** 3005 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.027853]  __die_body+0x1f/0x60
Nov 19 11:05:16 10.243.0.116 ** 3173 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.050368] R13: ffff888118d24780 R14: =
0000000102568002 R15: 0000000000000000
Nov 19 11:05:16 10.243.0.116 ** 3075 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.072164]  exc_invalid_op+0x4f/0xa0
Nov 19 11:05:16 10.243.0.116 ** 3044 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.093860] Thread overran stack, or =
stack corrupted
Nov 19 11:05:16 10.243.0.116 ** 3029 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.115284] R10: 0000000000000000 R11: =
0000000000000000 R12: ffff888118d24780
Nov 19 11:05:16 10.243.0.116 ** 3063 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.137078] R13: 0000000000000000 R14: =
0000000000000046 R15: 0000000000000004
Nov 19 11:05:16 10.243.0.116 ** 3083 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.158977]  ? print_modules+0x88/0x121
Nov 19 11:05:16 10.243.0.116 ** 3104 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.181019]  =
do_kern_addr_fault+0x7c/0xb0
Nov 19 11:05:16 10.243.0.116 ** 3087 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.202958] RSP: 0018:fffffe000016e858 =
EFLAGS: 00010046
Nov 19 11:05:16 10.243.0.116 ** 3100 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.225029] #PF: supervisor read access =
in kernel mode
Nov 19 11:05:16 10.243.0.116 ** 3177 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.247594] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002df94
Nov 19 11:05:16 10.243.0.116 ** 3190 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.270255]  ? lock_release+0xd5/0x420
Nov 19 11:05:16 10.243.0.116 ** 3636 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.296198]  ? bsearch+0x5e/0x90
Nov 19 11:05:16 10.243.0.116 ** 3198 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.318717] RIP: =
0010:print_modules+0x88/0x121
Nov 19 11:05:16 10.243.0.116 ** 3066 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.340480] IRQ stage: Linux
Nov 19 11:05:16 10.243.0.116 ** 3012 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.362028]  do_trap+0x126/0x150
Nov 19 11:05:16 10.243.0.116 ** 2966 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.383075]  =
bad_area_nosemaphore+0x11/0x20
Nov 19 11:05:16 10.243.0.116 ** 2918 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.403844]  ? =
is_prefetch.isra.28+0x8c/0x2b0
Nov 19 11:05:16 10.243.0.116 ** 2896 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.424296]  ? print_modules+0x88/0x121
Nov 19 11:05:16 10.243.0.116 ** 2814 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.444234] Code: 4e 2a 00 8b 45 c4 c6 =
03 00 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 0f 1f 44 =
00 00 55 48 89 e5 41 57 49 89 d7 <41> 56 49 89 f6 41 55 49 89 cd 41 54 =
49 89 fc 49 8d 79 7f 53 4c 89
Nov 19 11:05:16 10.243.0.116 ** 4146 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.473743]  do_trap+0x126/0x150
Nov 19 11:05:16 10.243.0.116 ** 2769 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.493413]  ? =
is_prefetch.isra.28+0x8c/0x2b0
Nov 19 11:05:16 10.243.0.116 ** 2739 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.512891] RSP: 0018:fffffe000016dc28 =
EFLAGS: 00010046
Nov 19 11:05:16 10.243.0.116 ** 2768 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.532399]  ? =
fixup_exception+0x32/0x420
Nov 19 11:05:16 10.243.0.116 ** 2716 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.551749] R10: fffffe000016c447 R11: =
fffffbc00002d888 R12: fffffe000016c1b0
Nov 19 11:05:16 10.243.0.116 ** 2752 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.571326]  ? =
fixup_exception+0x32/0x420
Nov 19 11:05:16 10.243.0.116 ** 2735 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.590705]  ? print_modules+0x88/0x121
Nov 19 11:05:16 10.243.0.116 ** 2706 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.609948] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:16 10.243.0.116 ** 2722 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.629292]  ? print_modules+0x88/0x121
Nov 19 11:05:16 10.243.0.116 ** 2664 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.648353]  =
bad_area_nosemaphore+0x11/0x20
Nov 19 11:05:16 10.243.0.116 ** 2641 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.667272] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:16 10.243.0.116 ** 2542 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.685246] RIP: =
0010:print_modules+0x88/0x121
Nov 19 11:05:16 10.243.0.116 ** 2646 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.703968] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002dd0b
Nov 19 11:05:16 10.243.0.116 ** 2660 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.722879]  ? =
fixup_exception+0x32/0x420
Nov 19 11:05:16 10.243.0.116 ** 2640 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.741667] RAX: 0000000000000000 RBX: =
fffffffffffffff8 RCX: ffffffff890e5bcc
Nov 19 11:05:16 10.243.0.116 ** 2679 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.760683]  ? print_modules+0x88/0x121
Nov 19 11:05:16 10.243.0.116 ** 2684 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.779793]  ? =
is_prefetch.isra.28+0x8c/0x2b0
Nov 19 11:05:16 10.243.0.116 ** 2682 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.798825] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 19 11:05:16 10.243.0.116 ** 2777 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.818394]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:16 10.243.0.116 ** 2752 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.837979] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002dc89
Nov 19 11:05:16 10.243.0.116 ** 2859 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.858230] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:16 10.243.0.116 ** 2889 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.878629]  ? =
irqentry_nmi_enter+0x83/0x90
Nov 19 11:05:16 10.243.0.116 ** 2882 printk messages dropped **
Nov 19 11:05:16 10.243.0.116 [  125.899203] RBP: fffffe000016fd18 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:17 10.243.0.116 ** 2881 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  125.919638]  ? =
search_exception_tables+0x58/0x60
Nov 19 11:05:17 10.243.0.116 ** 2792 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  125.939449]  ? print_modules+0x88/0x121
Nov 19 11:05:17 10.243.0.116 ** 2792 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  125.959367]  ? =
load_module.cold.80+0x38d/0x38d
Nov 19 11:05:17 10.243.0.116 ** 2794 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  125.979180]  ? print_modules+0x88/0x121
Nov 19 11:05:17 10.243.0.116 ** 2782 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  125.998934]  ? bsearch+0x5e/0x90
Nov 19 11:05:17 10.243.0.116 ** 2779 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.018750] RBP: fffffe000016ff20 R08: =
0000000000000000 R09: 0000000000000000
Nov 19 11:05:17 10.243.0.116 ** 2741 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.038297]  =
kernelmode_fixup_or_oops+0x135/0x160
Nov 19 11:05:17 10.243.0.116 ** 2772 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.058093] RBP: fffffe000016ff20 R08: =
0000000000000000 R09: 0000000000000000
Nov 19 11:05:17 10.243.0.116 ** 2817 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.078032]  ? bsearch+0x5e/0x90
Nov 19 11:05:17 10.243.0.116 ** 2747 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.097492] RAX: 0000000000000000 RBX: =
fffffffffffffff8 RCX: ffffffff890e5bcc
Nov 19 11:05:17 10.243.0.116 ** 2827 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.117567] RSP: 0018:fffffe000016e038 =
EFLAGS: 00010046
Nov 19 11:05:17 10.243.0.116 ** 2890 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.138057]  exc_page_fault+0xcf/0xe0
Nov 19 11:05:17 10.243.0.116 ** 2860 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.158350]  =
do_kern_addr_fault+0x7c/0xb0
Nov 19 11:05:17 10.243.0.116 ** 2862 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.178688]  exc_page_fault+0xcf/0xe0
Nov 19 11:05:17 10.243.0.116 ** 2797 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.198516] RAX: 0000000000f00000 RBX: =
fffffe000016ff00 RCX: fffffe000016c000
Nov 19 11:05:17 10.243.0.116 ** 2811 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.218508] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002de91
Nov 19 11:05:17 10.243.0.116 ** 2825 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.238677] RAX: 0000000000000000 RBX: =
fffffffffffffff8 RCX: ffffffff890e5bcc
Nov 19 11:05:17 10.243.0.116 ** 2856 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.259047]  exc_page_fault+0xcf/0xe0
Nov 19 11:05:17 10.243.0.116 ** 2911 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.279790]  ? lock_release+0xd5/0x420
Nov 19 11:05:17 10.243.0.116 ** 2824 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.299784]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:17 10.243.0.116 ** 2828 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.319835]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:17 10.243.0.116 ** 2816 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.339828] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:17 10.243.0.116 ** 2783 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.359528]  ? =
load_module.cold.80+0x38d/0x38d
Nov 19 11:05:17 10.243.0.116 ** 2727 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.378911]  ? print_modules+0x88/0x121
Nov 19 11:05:17 10.243.0.116 ** 2770 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.398454] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002df13
Nov 19 11:05:17 10.243.0.116 ** 2688 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.417430]  exc_page_fault+0xcf/0xe0
Nov 19 11:05:17 10.243.0.116 ** 2754 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.437032]  __die+0x25/0x30
Nov 19 11:05:17 10.243.0.116 ** 2716 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.456202] RBP: fffffe000016e0b0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:17 10.243.0.116 ** 2774 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.475884] RSP: 0018:fffffe000016f488 =
EFLAGS: 00010046
Nov 19 11:05:17 10.243.0.116 ** 2828 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.496083] RSP: 0018:fffffe000016ec68 =
EFLAGS: 00010046
Nov 19 11:05:17 10.243.0.116 ** 2791 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.515906] Code: e0 ee 76 85 c0 75 0c =
41 c7 84 24 b8 0d 00 00 00 00 00 00 e8 6f fe ff ff e8 3a 38 19 ff 31 c0 =
88 d8 5b 41 5c 5d c3 cc cc cc cc <0f> 0b 90 66 2e 0f 1f 84 00 00 00 00 =
00 55 48 89 e5 40 84 f6 75 3e
Nov 19 11:05:17 10.243.0.116 ** 4304 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.546513]  =
bad_area_nosemaphore+0x11/0x20
Nov 19 11:05:17 10.243.0.116 ** 2911 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.567270]  __die+0x25/0x30
Nov 19 11:05:17 10.243.0.116 ** 3335 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.591050] RSP: 0018:fffffe000016ec68 =
EFLAGS: 00010046
Nov 19 11:05:17 10.243.0.116 ** 2828 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.611157] RSP: 0018:fffffe000016e448 =
EFLAGS: 00010046
Nov 19 11:05:17 10.243.0.116 ** 2836 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.631271]  ? =
load_module.cold.80+0x38d/0x38d
Nov 19 11:05:17 10.243.0.116 ** 2889 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.651843] RBP: fffffe000016dca0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:17 10.243.0.116 ** 2891 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.672417] RSP: 0018:fffffe000016dc28 =
EFLAGS: 00010046
Nov 19 11:05:17 10.243.0.116 ** 2959 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.693470] Code: b1 ff ff 65 ff 05 94 =
13 f4 76 48 8b 1d 8d a7 0c 01 48 83 eb 08 4c 8d 6b 08 49 81 fd 40 03 1b =
8a 74 3e 48 89 df e8 04 7d 3f ff <83> 3b 03 74 1f 48 8d 75 a8 48 89 df =
e8 93 a3 14 ff 48 8d 73 18 48
Nov 19 11:05:17 10.243.0.116 ** 4526 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.725592]  exc_invalid_op+0x4f/0xa0
Nov 19 11:05:17 10.243.0.116 ** 2965 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.746758] RIP: =
0010:print_modules+0x88/0x121
Nov 19 11:05:17 10.243.0.116 ** 3005 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.768094]  __die_body+0x1f/0x60
Nov 19 11:05:17 10.243.0.116 ** 2994 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.789459]  __die+0x25/0x30
Nov 19 11:05:17 10.243.0.116 ** 2949 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.810472] RBP: fffffe000016c008 R08: =
fffffe000016c080 R09: fffffe000016c1b0
Nov 19 11:05:17 10.243.0.116 ** 2951 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.831386] RAX: 0000000000000000 RBX: =
fffffffffffffff8 RCX: ffffffff890e5bcc
Nov 19 11:05:17 10.243.0.116 ** 3027 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.852887] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:17 10.243.0.116 ** 3058 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.874551] R10: fffffe000016c447 R11: =
fffffbc00002d888 R12: fffffe000016c1b0
Nov 19 11:05:17 10.243.0.116 ** 3140 printk messages dropped **
Nov 19 11:05:17 10.243.0.116 [  126.896980]  =
__bad_area_nosemaphore+0x247/0x2b0
Nov 19 11:05:18 10.243.0.116 ** 3065 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  126.918795]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:18 10.243.0.116 ** 3190 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  126.941472]  ? =
load_module.cold.80+0x38d/0x38d
Nov 19 11:05:18 10.243.0.116 ** 3167 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  126.963916] R13: ffff888118d24780 R14: =
0000000102568002 R15: 0000000000000000
Nov 19 11:05:18 10.243.0.116 ** 3138 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  126.986295]  =
kernelmode_fixup_or_oops+0x135/0x160
Nov 19 11:05:18 10.243.0.116 ** 3127 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.008320]  ? print_modules+0x88/0x121
Nov 19 11:05:18 10.243.0.116 ** 3118 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.030498] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:18 10.243.0.116 ** 3049 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.052085]  ? print_modules+0x88/0x121
Nov 19 11:05:18 10.243.0.116 ** 2985 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.073315] RDX: fffffe000016c0c0 RSI: =
fffffe000016c100 RDI: ffffffff890e5bcc
Nov 19 11:05:18 10.243.0.116 ** 3027 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.094727]  __die_body+0x1f/0x60
Nov 19 11:05:18 10.243.0.116 ** 3051 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.116510] R13: fffffe000016c66a R14: =
ffffffff890e5bcc R15: fffffe000016c0c0
Nov 19 11:05:18 10.243.0.116 ** 3022 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.137909]  ? =
load_module.cold.80+0x38d/0x38d
Nov 19 11:05:18 10.243.0.116 ** 3065 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.159818]  handle_invalid_op+0x3c/0x50
Nov 19 11:05:18 10.243.0.116 ** 3002 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.181148] RSP: 0018:fffffe000016e038 =
EFLAGS: 00010046
Nov 19 11:05:18 10.243.0.116 ** 3026 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.202760] RSP: 0018:fffffe000016f078 =
EFLAGS: 00010046
Nov 19 11:05:18 10.243.0.116 ** 2954 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.223704]  =
bad_area_nosemaphore+0x11/0x20
Nov 19 11:05:18 10.243.0.116 ** 2853 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.244082]  ? =
page_fault_oops+0x3c0/0x3c0
Nov 19 11:05:18 10.243.0.116 ** 2849 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.264375]  ? print_modules+0x88/0x121
Nov 19 11:05:18 10.243.0.116 ** 2788 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.284164] RSP: 0018:fffffe000016e038 =
EFLAGS: 00010046
Nov 19 11:05:18 10.243.0.116 ** 2830 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.304281] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 19 11:05:18 10.243.0.116 ** 2892 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.324934] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:18 10.243.0.116 ** 2929 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.345859] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:18 10.243.0.116 ** 2919 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.366734]  =
bad_area_nosemaphore+0x11/0x20
Nov 19 11:05:18 10.243.0.116 ** 2870 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.387188] RBP: fffffe000016dca0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:18 10.243.0.116 ** 2853 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.407431] RSP: 0018:fffffe000016d818 =
EFLAGS: 00010046
Nov 19 11:05:18 10.243.0.116 ** 2874 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.427901] RAX: 0000000000000000 RBX: =
1fffffc00002d804 RCX: fffffe000016c040
Nov 19 11:05:18 10.243.0.116 ** 2899 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.448511]  ? print_modules+0x88/0x121
Nov 19 11:05:18 10.243.0.116 ** 2898 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.469268] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:18 10.243.0.116 ** 2899 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.489964] Oops: 0000 [#11071] SMP =
KASAN PTI IRQ_PIPELINE
Nov 19 11:05:18 10.243.0.116 ** 2910 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.510510] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 19 11:05:18 10.243.0.116 ** 2962 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.531595]  ? print_modules+0x88/0x121
Nov 19 11:05:18 10.243.0.116 ** 2991 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.553017] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:18 10.243.0.116 ** 2955 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.573985] RSP: 0018:fffffe000016f488 =
EFLAGS: 00010046
Nov 19 11:05:18 10.243.0.116 ** 2980 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.595113] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:18 10.243.0.116 ** 2961 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.616138] RIP: =
0010:print_modules+0x88/0x121
Nov 19 11:05:18 10.243.0.116 ** 2935 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.637146]  ? print_modules+0x88/0x121
Nov 19 11:05:18 10.243.0.116 ** 2953 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.658075] Code: b1 ff ff 65 ff 05 94 =
13 f4 76 48 8b 1d 8d a7 0c 01 48 83 eb 08 4c 8d 6b 08 49 81 fd 40 03 1b =
8a 74 3e 48 89 df e8 04 7d 3f ff <83> 3b 03 74 1f 48 8d 75 a8 48 89 df =
e8 93 a3 14 ff 48 8d 73 18 48
Nov 19 11:05:18 10.243.0.116 ** 4616 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.690799]  ? print_modules+0x88/0x121
Nov 19 11:05:18 10.243.0.116 ** 3084 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.712761]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:18 10.243.0.116 ** 3057 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.734475] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:18 10.243.0.116 ** 3115 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.756476]  ? print_modules+0x88/0x121
Nov 19 11:05:18 10.243.0.116 ** 3108 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.778513] RSP: 0018:fffffe000016e448 =
EFLAGS: 00010046
Nov 19 11:05:18 10.243.0.116 ** 3172 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.801076]  ? =
fixup_exception+0x32/0x420
Nov 19 11:05:18 10.243.0.116 ** 3155 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.823703]  ? =
search_bpf_extables+0x136/0x190
Nov 19 11:05:18 10.243.0.116 ** 3059 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.845560] RIP: =
0010:print_modules+0x88/0x121
Nov 19 11:05:18 10.243.0.116 ** 3083 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.867500]  ? print_modules+0x88/0x121
Nov 19 11:05:18 10.243.0.116 ** 3032 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.889061] RIP: =
0010:kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:18 10.243.0.116 ** 2965 printk messages dropped **
Nov 19 11:05:18 10.243.0.116 [  127.909957] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002df94
Nov 19 11:05:19 10.243.0.116 ** 2936 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  127.930751] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:19 10.243.0.116 ** 2984 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  127.951852] #PF: supervisor read access =
in kernel mode
Nov 19 11:05:19 10.243.0.116 ** 3448 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  127.976276]  ? =
load_module.cold.80+0x38d/0x38d
Nov 19 11:05:19 10.243.0.116 ** 2975 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  127.997559]  ? =
search_exception_tables+0x58/0x60
Nov 19 11:05:19 10.243.0.116 ** 2934 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.018474] RSP: 0018:fffffe000016c000 =
EFLAGS: 00010046
Nov 19 11:05:19 10.243.0.116 ** 2919 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.039321] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002dc89
Nov 19 11:05:19 10.243.0.116 ** 2967 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.060491]  ? print_modules+0x88/0x121
Nov 19 11:05:19 10.243.0.116 ** 2962 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.081548]  ? =
load_module.cold.80+0x38d/0x38d
Nov 19 11:05:19 10.243.0.116 ** 2886 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.101963] RSP: 0018:fffffe000016f488 =
EFLAGS: 00010046
Nov 19 11:05:19 10.243.0.116 ** 2861 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.122243] RSP: 0018:fffffe000016f078 =
EFLAGS: 00010046
Nov 19 11:05:19 10.243.0.116 ** 2879 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.142539]  ? =
is_prefetch.isra.28+0x8c/0x2b0
Nov 19 11:05:19 10.243.0.116 ** 2898 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.163135]  ? print_modules+0x88/0x121
Nov 19 11:05:19 10.243.0.116 ** 2874 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.183617] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:19 10.243.0.116 ** 2760 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.203339]  ? =
search_exception_tables+0x58/0x60
Nov 19 11:05:19 10.243.0.116 ** 2783 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.223112]  __die+0x25/0x30
Nov 19 11:05:19 10.243.0.116 ** 2780 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.242914]  ? =
page_fault_oops+0x3c0/0x3c0
Nov 19 11:05:19 10.243.0.116 ** 2700 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.262082]  ? lock_release+0xd5/0x420
Nov 19 11:05:19 10.243.0.116 ** 2705 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.281289]  page_fault_oops+0x124/0x3c0
Nov 19 11:05:19 10.243.0.116 ** 2710 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.300649] RSP: 0018:fffffe000016c000 =
EFLAGS: 00010046
Nov 19 11:05:19 10.243.0.116 ** 2595 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.319097]  ? print_modules+0x88/0x121
Nov 19 11:05:19 10.243.0.116 ** 2720 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.338439] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:19 10.243.0.116 ** 2675 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.357436] Code: b1 ff ff 65 ff 05 94 =
13 f4 76 48 8b 1d 8d a7 0c 01 48 83 eb 08 4c 8d 6b 08 49 81 fd 40 03 1b =
8a 74 3e 48 89 df e8 04 7d 3f ff <83> 3b 03 74 1f 48 8d 75 a8 48 89 df =
e8 93 a3 14 ff 48 8d 73 18 48
Nov 19 11:05:19 10.243.0.116 ** 4242 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.387520]  ? =
page_fault_oops+0x3c0/0x3c0
Nov 19 11:05:19 10.243.0.116 ** 2874 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.407870] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002dd0b
Nov 19 11:05:19 10.243.0.116 ** 2812 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.427755]  ? print_modules+0x88/0x121
Nov 19 11:05:19 10.243.0.116 ** 2795 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.447542] Call Trace:
Nov 19 11:05:19 10.243.0.116 ** 2735 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.466915] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 19 11:05:19 10.243.0.116 ** 2761 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.486534] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Nov 19 11:05:19 10.243.0.116 ** 2794 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.506347]  ? print_modules+0x88/0x121
Nov 19 11:05:19 10.243.0.116 ** 2804 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.526462] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Nov 19 11:05:19 10.243.0.116 ** 2823 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.546427]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:19 10.243.0.116 ** 2829 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.566508]  __die_body+0x1f/0x60
Nov 19 11:05:19 10.243.0.116 ** 2818 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.586499] RSP: 0018:fffffe000016e858 =
EFLAGS: 00010046
Nov 19 11:05:19 10.243.0.116 ** 2805 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.606247]  __die_body+0x1f/0x60
Nov 19 11:05:19 10.243.0.116 ** 2796 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.626076]  __die+0x25/0x30
Nov 19 11:05:19 10.243.0.116 ** 2809 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.646127]  ? cmp_ex_search+0x1e/0x40
Nov 19 11:05:19 10.243.0.116 ** 2752 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.665510] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:19 10.243.0.116 ** 2708 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.684724] BUG: unable to handle page =
fault for address: fffffffffffffff8
Nov 19 11:05:19 10.243.0.116 ** 2800 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.704711]  page_fault_oops+0x124/0x3c0
Nov 19 11:05:19 10.243.0.116 ** 2821 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.724626] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:19 10.243.0.116 ** 2823 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.744746] RSP: 0018:fffffe000016e448 =
EFLAGS: 00010046
Nov 19 11:05:19 10.243.0.116 ** 2960 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.765709] RSP: 0018:fffffe000016ec68 =
EFLAGS: 00010046
Nov 19 11:05:19 10.243.0.116 ** 2942 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.786707]  ? cmp_ex_search+0x1e/0x40
Nov 19 11:05:19 10.243.0.116 ** 2918 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.807576]  ? print_modules+0x88/0x121
Nov 19 11:05:19 10.243.0.116 ** 2921 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.828298] RSP: 0018:fffffe000016f898 =
EFLAGS: 00010046
Nov 19 11:05:19 10.243.0.116 ** 2872 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.848637]  __die+0x25/0x30
Nov 19 11:05:19 10.243.0.116 ** 2719 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.867959] RAX: 0000000000000000 RBX: =
fffffffffffffff8 RCX: ffffffff890e5bcc
Nov 19 11:05:19 10.243.0.116 ** 2780 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.887778]  __die_body+0x1f/0x60
Nov 19 11:05:19 10.243.0.116 ** 2720 printk messages dropped **
Nov 19 11:05:19 10.243.0.116 [  128.907153] RSP: 0018:fffffe000016e858 =
EFLAGS: 00010046
Nov 19 11:05:20 10.243.0.116 ** 2731 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  128.926522]  =
kernelmode_fixup_or_oops+0x135/0x160
Nov 19 11:05:20 10.243.0.116 ** 2737 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  128.945909] RSP: 0018:fffffe000016e858 =
EFLAGS: 00010046
Nov 19 11:05:20 10.243.0.116 ** 2759 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  128.965519]  ? print_modules+0x88/0x121
Nov 19 11:05:20 10.243.0.116 ** 2692 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  128.984785] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables =
=E2=96=92=E2=96=92#023=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=
=92t=E2=96=92#034=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92t=E2=96=92#=
034=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92b#023=E2=96=92=E2=96=92=E2=
=96=92=E2=96=92=E2=96=92(FOKX)
Nov 19 11:05:20 10.243.0.116 ** 7077 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.035399]  ? =
fixup_exception+0x32/0x420
Nov 19 11:05:20 10.243.0.116 ** 2909 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.056057]  ? print_modules+0x88/0x121
Nov 19 11:05:20 10.243.0.116 ** 2922 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.076627] RAX: 0000000000000000 RBX: =
fffffffffffffff8 RCX: ffffffff890e5bcc
Nov 19 11:05:20 10.243.0.116 ** 2928 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.097533] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:20 10.243.0.116 ** 3077 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.119375]  ? print_modules+0x88/0x121
Nov 19 11:05:20 10.243.0.116 ** 3034 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.140873] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:20 10.243.0.116 ** 3142 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.163097]  ? print_modules+0x88/0x121
Nov 19 11:05:20 10.243.0.116 ** 3064 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.184841] R13: ffff888118d24780 R14: =
0000000102568002 R15: 0000000000000000
Nov 19 11:05:20 10.243.0.116 ** 3024 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.206278]  __die_body+0x1f/0x60
Nov 19 11:05:20 10.243.0.116 ** 3049 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.227852]  __die_body+0x1f/0x60
Nov 19 11:05:20 10.243.0.116 ** 2981 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.249051] RAX: 0000000000000000 RBX: =
1fffffc00002d804 RCX: fffffe000016c040
Nov 19 11:05:20 10.243.0.116 ** 2968 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.270221]  ? bsearch+0x5e/0x90
Nov 19 11:05:20 10.243.0.116 ** 2993 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.291567]  exc_invalid_op+0x4f/0xa0
Nov 19 11:05:20 10.243.0.116 ** 3404 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.315761] RSP: 0018:fffffe000016e038 =
EFLAGS: 00010046
Nov 19 11:05:20 10.243.0.116 ** 2970 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.336821] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:20 10.243.0.116 ** 3035 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.358377]  ? =
spurious_kernel_fault+0x200/0x200
Nov 19 11:05:20 10.243.0.116 ** 3005 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.379824] RBP: fffffe000016e0b0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:20 10.243.0.116 ** 3091 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.401867] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:20 10.243.0.116 ** 3081 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.423789] RAX: 0000000000000000 RBX: =
fffffffffffffff8 RCX: ffffffff890e5bcc
Nov 19 11:05:20 10.243.0.116 ** 3180 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.446513] RSP: 0018:fffffe000016d818 =
EFLAGS: 00010046
Nov 19 11:05:20 10.243.0.116 ** 3184 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.469085]  =
__bad_area_nosemaphore+0x247/0x2b0
Nov 19 11:05:20 10.243.0.116 ** 3191 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.491800] RBP: fffffe000016ece0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:20 10.243.0.116 ** 3213 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.514569] RSP: 0018:fffffe000016fca0 =
EFLAGS: 00010046
Nov 19 11:05:20 10.243.0.116 ** 3076 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.536405] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 19 11:05:20 10.243.0.116 ** 3009 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.557776] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:20 10.243.0.116 ** 3023 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.579352]  =
bad_area_nosemaphore+0x11/0x20
Nov 19 11:05:20 10.243.0.116 ** 3048 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.600951]  =
__bad_area_nosemaphore+0x247/0x2b0
Nov 19 11:05:20 10.243.0.116 ** 3018 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.622384] RIP: =
0010:irqentry_nmi_enter+0x83/0x90
Nov 19 11:05:20 10.243.0.116 ** 2937 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.643380] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 19 11:05:20 10.243.0.116 ** 3000 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.664755]  page_fault_oops+0x124/0x3c0
Nov 19 11:05:20 10.243.0.116 ** 2971 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.685808]  ? =
search_exception_tables+0x58/0x60
Nov 19 11:05:20 10.243.0.116 ** 2946 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.706748] #PF: error_code(0x0000) - =
not-present page
Nov 19 11:05:20 10.243.0.116 ** 2914 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.727528] Call Trace:
Nov 19 11:05:20 10.243.0.116 ** 2957 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.748426] RBP: fffffe000016e8d0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:20 10.243.0.116 ** 2972 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.769497]  ? cmp_ex_search+0x1e/0x40
Nov 19 11:05:20 10.243.0.116 ** 2951 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.790557]  ? print_modules+0x88/0x121
Nov 19 11:05:20 10.243.0.116 ** 2927 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.811359]  ? print_modules+0x88/0x121
Nov 19 11:05:20 10.243.0.116 ** 2941 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.832298] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:20 10.243.0.116 ** 2963 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.853251] RSP: 0018:fffffe000016e448 =
EFLAGS: 00010046
Nov 19 11:05:20 10.243.0.116 ** 2979 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.874498]  ? =
page_fault_oops+0x3c0/0x3c0
Nov 19 11:05:20 10.243.0.116 ** 2947 printk messages dropped **
Nov 19 11:05:20 10.243.0.116 [  129.895326]  ? print_modules+0x88/0x121
Nov 19 11:05:21 10.243.0.116 ** 2895 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  129.915992]  ? print_modules+0x88/0x121
Nov 19 11:05:21 10.243.0.116 ** 2792 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  129.935773] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002dd0b
Nov 19 11:05:21 10.243.0.116 ** 2784 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  129.955520] RIP: =
0010:print_modules+0x88/0x121
Nov 19 11:05:21 10.243.0.116 ** 2797 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  129.975338]  ? =
is_prefetch.isra.28+0x8c/0x2b0
Nov 19 11:05:21 10.243.0.116 ** 2765 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  129.994969]  ? =
search_bpf_extables+0x136/0x190
Nov 19 11:05:21 10.243.0.116 ** 2764 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.014477]  ? lock_release+0xd5/0x420
Nov 19 11:05:21 10.243.0.116 ** 2682 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.033469] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: fffffe000016ff58
Nov 19 11:05:21 10.243.0.116 ** 2666 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.052353]  ? =
irqentry_nmi_enter+0x83/0x90
Nov 19 11:05:21 10.243.0.116 ** 2657 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.071212] Code: b1 ff ff 65 ff 05 94 =
13 f4 76 48 8b 1d 8d a7 0c 01 48 83 eb 08 4c 8d 6b 08 49 81 fd 40 03 1b =
8a 74 3e 48 89 df e8 04 7d 3f ff <83> 3b 03 74 1f 48 8d 75 a8 48 89 df =
e8 93 a3 14 ff 48 8d 73 18 48
Nov 19 11:05:21 10.243.0.116 ** 4143 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.100664]  __die+0x25/0x30
Nov 19 11:05:21 10.243.0.116 ** 2786 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.120460] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:21 10.243.0.116 ** 2791 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.140241] RBP: fffffe000016dca0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:21 10.243.0.116 ** 2853 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.160434]  ? =
irqentry_nmi_enter+0x83/0x90
Nov 19 11:05:21 10.243.0.116 ** 2853 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.180869] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:21 10.243.0.116 ** 2889 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.201496] RSP: 0018:fffffe000016f898 =
EFLAGS: 00010046
Nov 19 11:05:21 10.243.0.116 ** 2918 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.222195]  ? =
fixup_exception+0x32/0x420
Nov 19 11:05:21 10.243.0.116 ** 2924 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.243027] RAX: 0000000000f00000 RBX: =
fffffe000016ff00 RCX: fffffe000016c000
Nov 19 11:05:21 10.243.0.116 ** 2908 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.263579] R13: fffffe000016c66a R14: =
ffffffff890e5bcc R15: fffffe000016c0c0
Nov 19 11:05:21 10.243.0.116 ** 3019 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.285103] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:21 10.243.0.116 ** 3042 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.306617]  ? =
search_bpf_extables+0x136/0x190
Nov 19 11:05:21 10.243.0.116 ** 3073 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.328446]  page_fault_oops+0x124/0x3c0
Nov 19 11:05:21 10.243.0.116 ** 3050 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.350006] RBP: fffffe000016f910 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:21 10.243.0.116 ** 2984 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.371360] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 19 11:05:21 10.243.0.116 ** 3147 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.393584]  =
__bad_area_nosemaphore+0x247/0x2b0
Nov 19 11:05:21 10.243.0.116 ** 3127 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.415886] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:21 10.243.0.116 ** 3274 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.439177] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:21 10.243.0.116 ** 3154 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.461515]  ? lock_release+0xd5/0x420
Nov 19 11:05:21 10.243.0.116 ** 3174 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.484105]  ? print_modules+0x88/0x121
Nov 19 11:05:21 10.243.0.116 ** 3143 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.506386] R10: fffffe000016c447 R11: =
fffffbc00002d888 R12: fffffe000016c1b0
Nov 19 11:05:21 10.243.0.116 ** 3198 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.529139]  =
do_kern_addr_fault+0x7c/0xb0
Nov 19 11:05:21 10.243.0.116 ** 3218 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.552075] Code: b1 ff ff 65 ff 05 94 =
13 f4 76 48 8b 1d 8d a7 0c 01 48 83 eb 08 4c 8d 6b 08 49 81 fd 40 03 1b =
8a 74 3e 48 89 df e8 04 7d 3f ff <83> 3b 03 74 1f 48 8d 75 a8 48 89 df =
e8 93 a3 14 ff 48 8d 73 18 48
Nov 19 11:05:21 10.243.0.116 ** 4926 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.586869] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:21 10.243.0.116 ** 3268 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.610173]  ? =
is_prefetch.isra.28+0x8c/0x2b0
Nov 19 11:05:21 10.243.0.116 ** 3191 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.632847]  =
do_kern_addr_fault+0x7c/0xb0
Nov 19 11:05:21 10.243.0.116 ** 3207 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.655706]  ? =
search_bpf_extables+0x136/0x190
Nov 19 11:05:21 10.243.0.116 ** 3097 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.677602] RBP: fffffe000016e0b0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:21 10.243.0.116 ** 3556 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.702753] IRQ stage: Linux
Nov 19 11:05:21 10.243.0.116 ** 3148 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.725133]  ? cmp_ex_search+0x1e/0x40
Nov 19 11:05:21 10.243.0.116 ** 3075 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.746888] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 19 11:05:21 10.243.0.116 ** 3025 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.768384] R13: 0000000000000000 R14: =
0000000000000046 R15: 0000000000000004
Nov 19 11:05:21 10.243.0.116 ** 3092 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.790402]  =
kernelmode_fixup_or_oops+0x135/0x160
Nov 19 11:05:21 10.243.0.116 ** 3065 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.812269]  ? =
load_module.cold.80+0x38d/0x38d
Nov 19 11:05:21 10.243.0.116 ** 3000 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.833668]  ? =
irqentry_nmi_enter+0x83/0x90
Nov 19 11:05:21 10.243.0.116 ** 2935 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.854453] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:21 10.243.0.116 ** 3002 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.875624]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:21 10.243.0.116 ** 2998 printk messages dropped **
Nov 19 11:05:21 10.243.0.116 [  130.896878] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Nov 19 11:05:22 10.243.0.116 ** 2998 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  130.918256]  exc_page_fault+0xcf/0xe0
Nov 19 11:05:22 10.243.0.116 ** 2976 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  130.939339]  page_fault_oops+0x124/0x3c0
Nov 19 11:05:22 10.243.0.116 ** 2950 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  130.960262] R13: fffffe000016c66a R14: =
ffffffff890e5bcc R15: fffffe000016c0c0
Nov 19 11:05:22 10.243.0.116 ** 2924 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  130.981114]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:22 10.243.0.116 ** 2978 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.002327]  =
bad_area_nosemaphore+0x11/0x20
Nov 19 11:05:22 10.243.0.116 ** 2971 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.023363] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:22 10.243.0.116 ** 2988 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.044532] RBP: fffffe000016c008 R08: =
fffffe000016c080 R09: fffffe000016c1b0
Nov 19 11:05:22 10.243.0.116 ** 2961 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.065595]  __die+0x25/0x30
Nov 19 11:05:22 10.243.0.116 ** 3005 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.086742]  ? =
search_exception_tables+0x58/0x60
Nov 19 11:05:22 10.243.0.116 ** 2839 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.106993] RAX: 0000000000000000 RBX: =
fffffffffffffff8 RCX: ffffffff890e5bcc
Nov 19 11:05:22 10.243.0.116 ** 2857 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.127331]  =
asm_exc_page_fault+0x27/0x30
Nov 19 11:05:22 10.243.0.116 ** 2872 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.147640]  ? =
load_module.cold.80+0x38d/0x38d
Nov 19 11:05:22 10.243.0.116 ** 2883 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.168123]  =
asm_exc_page_fault+0x27/0x30
Nov 19 11:05:22 10.243.0.116 ** 2894 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.188715]  =
asm_exc_page_fault+0x27/0x30
Nov 19 11:05:22 10.243.0.116 ** 2828 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.208854] RSP: 0018:fffffe000016ff10 =
EFLAGS: 00010046
Nov 19 11:05:22 10.243.0.116 ** 2845 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.229071] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002df13
Nov 19 11:05:22 10.243.0.116 ** 2903 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.249689]  ? lock_release+0xd5/0x420
Nov 19 11:05:22 10.243.0.116 ** 2887 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.270295]  ? print_modules+0x88/0x121
Nov 19 11:05:22 10.243.0.116 ** 2813 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.290296]  ? =
fixup_exception+0x32/0x420
Nov 19 11:05:22 10.243.0.116 ** 2769 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.309918] RBP: fffffe000016e0b0 R08: =
ffffed107bc94f64 R09: ffffed107bc94f64
Nov 19 11:05:22 10.243.0.116 ** 2846 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.330111]  ? print_modules+0x88/0x121
Nov 19 11:05:22 10.243.0.116 ** 2844 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.350364]  ? print_modules+0x88/0x121
Nov 19 11:05:22 10.243.0.116 ** 2755 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.369941]  ? cmp_ex_search+0x1e/0x40
Nov 19 11:05:22 10.243.0.116 ** 2779 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.389791]  ? print_modules+0x88/0x121
Nov 19 11:05:22 10.243.0.116 ** 2688 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.408966] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002df13
Nov 19 11:05:22 10.243.0.116 ** 2686 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.428092]  ? cmp_ex_sort+0x50/0x50
Nov 19 11:05:22 10.243.0.116 ** 2735 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.447595]  ? lock_release+0xd5/0x420
Nov 19 11:05:22 10.243.0.116 ** 2706 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.466846]  =
asm_exc_double_fault+0x1f/0x30
Nov 19 11:05:22 10.243.0.116 ** 2568 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.485191]  ? =
kallsyms_lookup_buildid+0x9/0x170
Nov 19 11:05:22 10.243.0.116 ** 2688 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.504276]  ? =
fixup_exception+0x32/0x420
Nov 19 11:05:22 10.243.0.116 ** 2586 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.522558]  ? print_modules+0x88/0x121
Nov 19 11:05:22 10.243.0.116 ** 2531 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.540600]  exc_double_fault+0x9f/0x110
Nov 19 11:05:22 10.243.0.116 ** 2521 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.558375]  ? print_modules+0x88/0x121
Nov 19 11:05:22 10.243.0.116 ** 2523 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.576310]  ? =
search_bpf_extables+0x136/0x190
Nov 19 11:05:22 10.243.0.116 ** 2455 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.593703]  ? =
fixup_exception+0x32/0x420
Nov 19 11:05:22 10.243.0.116 ** 2440 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.611165] R13: ffff888118d24780 R14: =
0000000102568002 R15: 0000000000000000
Nov 19 11:05:22 10.243.0.116 ** 2410 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.628319] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 19 11:05:22 10.243.0.116 ** 2542 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.646334]  ? print_modules+0x88/0x121
Nov 19 11:05:22 10.243.0.116 ** 2573 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.664722] R13: 0000000000000000 R14: =
0000000000000000 R15: ffff88811d198000
Nov 19 11:05:22 10.243.0.116 ** 2602 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.683266] RSP: 0018:fffffe000016e858 =
EFLAGS: 00010046
Nov 19 11:05:22 10.243.0.116 ** 2574 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.701504] RSP: 0018:fffffe000016e858 =
EFLAGS: 00010046
Nov 19 11:05:22 10.243.0.116 ** 2571 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.719811] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:22 10.243.0.116 ** 2672 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.738810] RAX: 0000000000000000 RBX: =
fffffffffffffff8 RCX: ffffffff890e5bcc
Nov 19 11:05:22 10.243.0.116 ** 2707 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.758046] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: fffffffffffffff8
Nov 19 11:05:22 10.243.0.116 ** 2737 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.777405] RSP: 0018:fffffe000016f078 =
EFLAGS: 00010046
Nov 19 11:05:22 10.243.0.116 ** 2764 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.797192] PGD 30ae1a067 P4D 30ae1a067 =
PUD 30ae1c067 PMD 0
Nov 19 11:05:22 10.243.0.116 ** 2813 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.817224] RSP: 0018:fffffe000016f898 =
EFLAGS: 00010046
Nov 19 11:05:22 10.243.0.116 ** 2841 printk messages dropped **
Nov 19 11:05:22 10.243.0.116 [  131.837396] R10: ffff8883de4a7b1b R11: =
ffffed107bc94f63 R12: 1fffffc00002df94
------=_NextPart_001_007B_01D8FC07.A542AAD0--

------=_NextPart_000_007A_01D8FC07.A542AAD0
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
9w0BCQUxDxcNMjIxMTE5MTgxMTE3WjAvBgkqhkiG9w0BCQQxIgQgGXf5ap6rm/Vj25Hbt0vPty7b
eUN5C3qZ6HuR+74ZPgwwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQBs
21Z3L7jlMjdCbv9oyRrDcJlJn3eNViFhPnUAc1ipiEMCakG3jk04ncE+9NzbTWKfjLNXfCkGArcS
oGM/UrdOwO6u5yyE4xUeN/2acoLI6dHuaoi+6XqCBygDtvj/J3ZQaD1NR3gBKhqhcjR9P4Z47MKL
QCT3kOZjwpg9pxOgKGsFQWo2i76vhc/JvVFI5mYWNnHF+OQjpZ1PKVmPh1DccT3Mb/MeuE2UUrrm
6M32WGbWl66oOl0TFXplOKRzLiqNSXxNyAOWG1quCJ39ZCsztpGybYaCyAlyQd5VzPlmAgNLNCWl
uuxrbCF6jhgaL2rqtVmmfuwX3nEmKg71usD9AAAAAAAA

------=_NextPart_000_007A_01D8FC07.A542AAD0--
