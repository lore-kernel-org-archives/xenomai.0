Received: from mx0a-001f5801.pphosted.com (mx0b-001f5801.pphosted.com [148.163.159.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669FD7C
	for <xenomai@lists.linux.dev>; Mon,  5 Dec 2022 06:53:46 +0000 (UTC)
Received: from pps.filterd (m0090335.ppops.net [127.0.0.1])
	by mx0b-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B56jvaN029427;
	Sun, 4 Dec 2022 22:53:38 -0800
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02lp0151.outbound.protection.office365.us [23.103.199.151])
	by mx0b-001f5801.pphosted.com (PPS) with ESMTPS id 3m86gfjpsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Dec 2022 22:53:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=qieECyfWPkYxb9Bn1z22uosiIDUcywPtDXTFdAZHzfyLRKhXY8uvTDvhvd5bajYPbu40xZmXdAm010FaRD8+ggEsLyq+Upg5Ozkp8Jmt26U4lc0ie/dPbQTEqvQCd3xEmJLwHM9TT+lT+ItosRfvgbPH5cm0rHbD93DaDsTET4FLyrFaERFu3nzYBYGOYTM16mj994uKLX25GaBP0YLtxVnYimD3YbRXRzZ7MaMVJMqvkQScuw/+Per383E16U+NjQuH6n2ZltPvKznETkim646m3AaxREdawUUZEdWC/NRVyTSo6wC0oUt7TvZLFpzlsvQAA8j+8qZ326RAFudVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlbPdh14AZY/1WJWHMPb2K43I+yrrvOXhvStp1HTMeI=;
 b=d4ygpkPAn15jEpFPjWSrJiNXdXoEaGpS5XHJ+c7Ro/xRuqWJ+o+xVO0eQ1PQuk95KpDvQZ6RWIi5ErlBRtwBV+MvbvhLqFtCldJB2gmt0UGTaNTzp5t1AVbPJELjqlTQqRD+rSZbA7XdTdWc+WJ5ATGqmnDu/Y8Gg4y0rneK72SnKv9jIhKBtKHj9KzSCPYO6IUVuM/jwjtITIVagHdt2tqbkqveAuv6Kif3D56EOd1vrffaor4+LMR2k0Ke4NUnyG/fc3UOcdvVYxdd+3w50PoWQ6ObAZAXUO3rfk+8LPuFm8YuEbTwTgZxF18/9sFftDf3u304LTsLMcexhWbkoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlbPdh14AZY/1WJWHMPb2K43I+yrrvOXhvStp1HTMeI=;
 b=fcb1Y9sfvZ0Suv22rBRLuN6jqx1UT5xEMCPgjRtuXRKordDH2IKMMEfnviHd7k5FeZVtloRxnBQG/78HpEmrKMCwi6LVGFxQczPi+f8RoiHiWcSt9oQL4JPpJzRAOScqgR+DBuS/8Z+a+MJeRiBnCM3KKI8pz1ksAh9iqhXahhKicwIQtNem5Fh5e22knl13pl28HFxqATIgBqnaEL/MNggmcAzDibCLhnaX7c4Eqd4MiLCWq/rJfTRaJytxCD1QlJO+yJYXJgq8uR7nFrWC7+6B6hAetBk7tQ90xH3FZq70lpPahVrPAYJyM3ips2VMpY2ECEwBuoNnb3SAzAQdNw==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1348.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:189::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 5 Dec
 2022 06:53:34 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725%7]) with mapi id 15.20.5834.022; Mon, 5 Dec 2022
 06:53:34 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: Bryan Butler <Bryan.Butler@kratosdefense.com>,
        "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>,
        Shawn McManus <shawn.mcmanus@kratosdefense.com>
Subject: RE: [External] - Re: EVL Memory
Thread-Topic: [External] - Re: EVL Memory
Thread-Index: 
 Adjz0yff24VAOdNORJO8c3TjB/9lSwAgymPQAAE3ZMAAARoBAABtP6rQAH6X0oAAFuqKwAAYlRuAAA/9EKAABRGVgAAsa2CAAAwq7lAAKDcSAAAgIxWAAEP6SSAAYzsWgAAFcSNAAVlSalAAAyZ+gAAIpzogAFofRaAAL3JDAAALO44gABv0W4AADFRKsAAAioEAAACcvjAAA2mHAAAKjrLwABuwaYAACKPtgAAohXIAAA6rioAAGrFBgA==
Date: Mon, 5 Dec 2022 06:53:34 +0000
Message-ID: 
 <PH1P110MB1050A989B8056FC64EA8C093E2189@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87cz9kbrkr.fsf@xenomai.org>
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
 <PH1P110MB1050E66FF8CC978CF642CDF8E2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87v8mshg4n.fsf@xenomai.org> <87r0xgh4n2.fsf@xenomai.org>
 <87mt83zano.fsf@xenomai.org> <87iliryrgg.fsf@xenomai.org>
In-Reply-To: <87iliryrgg.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB1348:EE_
x-ms-office365-filtering-correlation-id: 4fc93bcf-087f-4d0f-d171-08dad68d6dad
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 1Sa7Q0Xc0dV+zSEXEj2FqQGLK0adTQqGE/HZi/JwIxNHDtMBTa/nCDhNllbCrVoPLW9HgtDhA6u+XCV2I46oJTqUezm00FX8VejzP8taPB8wvdAot1PffFs68k+n6y6ZJRxtpqLTZbVgpsnk8Ociyy0wBPSjz1cbA5AbhDCoBJe/yvuu1hjYC4Ly4/h3DvDWf/NCoXJQAFAhp5Kwux0HU/V7BMr0/jtvzkSn2eJN2BHLjFMM/qudKSe+RbFJmAQA/QtxSdsI5o/AVXcLP4KZLBcnXmTtaL2Nrh7CDT2xMV586tdTLtXllYvQmEUoM2GHX0ZbdFvAWUo3zcfyXI4AXPkqQGglgSaSiUfRwXcVyIhlGXZhnapYVZgII1uc0xZOdhTtgok8S8/+4aNuaqRRSSzNKrYfSioaOmTLhxioDOLOVqaOrtHbZjW//jhOazt3zIROHaGiJvjiH6tSJk5yB8ks/UVc/ctrvuQgS9VUqVoPOUsyWcS8x5G8+8F3tZPoE5M5/GbIFq9crszCOu77eYoaGHSHFSDHkLc4XromF3qpTjcEhOOc7/6ZPRdTO0k9dBLOEw+8jkTi2Mb4UWXgtQA6IhbD2JNBWN/E/OTPJWfMT9qOuKTKVVwlK60Ja2O89UkB4v805qpy1Z+KVIl+fYstXJIiwp8z67BsF200RPL9lJIdbubzgqGr5bwvDwTX
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(39830400003)(366004)(136003)(451199015)(76116006)(8676002)(5660300002)(4326008)(64756008)(66446008)(66556008)(66946007)(41300700001)(6506007)(26005)(66476007)(2906002)(33656002)(38100700002)(44832011)(54906003)(186003)(52536014)(8936002)(4744005)(122000001)(9686003)(55016003)(107886003)(71200400001)(38070700005)(7696005)(86362001)(6916009)(41320700001)(99936003)(83380400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?yq4wMGT2cOMOX1KneTbX6K80akFGpwJl8I/4S/dbAQUFFQTJo2p19AaCongY?=
 =?us-ascii?Q?7dF4WspGKBEQyNPmZrkMauCnYlmTg9vS+tb3VewlSvX6ZwoCjQtnkrRfbvEe?=
 =?us-ascii?Q?N/jfqU0/fnXsEpo6p8tlObMRgtkHwzVrIfmR3AjbKNUucLNfHrc1t1WKS2ut?=
 =?us-ascii?Q?vg6X7yj+6PAu9gdaqBbdGj5mrv7I76CrjpPHYCR0VwysHW0OOwQ8SNfi9jmm?=
 =?us-ascii?Q?z3ioopZ7qiWi5B4mPtStubKi8Yd310t8ZFUMSANQokyylydYaK4bMDhHS3iH?=
 =?us-ascii?Q?WFDewrv5xnCmtfRYUg9d4PdgTdyZdGvYUBuL0t597vZ+NEKmGbqQKrURxaUt?=
 =?us-ascii?Q?u1vy7QopIZVozLuYlFwaLtDZF7D5OmU8Cct79ozQBz7QebtUQMeDegmTHSX1?=
 =?us-ascii?Q?lXrrx1OR5hybc4lwepA5KqFkKNmMM2uA+5cWpw4CJQyrZc1dUWzOzLz0FLio?=
 =?us-ascii?Q?gl3g0+XKk/fvE+0omQPNIpAq7kWLGUMLbwiASWLsHbPTu9hrABUM6V8wYdny?=
 =?us-ascii?Q?5ajFstnoZ/GNKAw0XdRFetSKi+iIV9IBEYdddeN5DXfOvZwJ68YxJikD7htb?=
 =?us-ascii?Q?o2abOvI0BLGeN1pylEZxzjNntAXxXLERDj8pXJT19C95ry2/DXr7vLHUqEqa?=
 =?us-ascii?Q?LRlQCp5wFx8UnfJtsPlEXkthEk92VznhC3DSvY6Q1xIOEH+b/BNuR3/5case?=
 =?us-ascii?Q?5u8Q7diWHymjh29vYHUaq9d97NZC7W9B3qd9keTGsoRxhi3KOnBFvDiSK8II?=
 =?us-ascii?Q?GPsXsgg3LYaqBNfsDi+Ap2EFrQTTCklqKKKfQhtQlpg2Fvh7H41um64hPXIL?=
 =?us-ascii?Q?0CZpHBuzezzurXetscCsIsvaXkBTRY08xDc6oIr+MuOGJ4qlP4sppBS+iVI3?=
 =?us-ascii?Q?lXrJKDQXHPbif6gNXfWDb6RzGfuZMPfqeLyVGpsQ52Jq+PBbxxv3IHRqtbDT?=
 =?us-ascii?Q?fAgd5GvWzd0v6DI2+TxQR82fKtGeKfQqgM2ddd3FRt6+gQqXj20YqUdW+5zy?=
 =?us-ascii?Q?tKt8KHVZ1aYB4HlNcjnwSdszYe8l14R6YFrJv6z9awb2tRWvelmOyWPuCUqd?=
 =?us-ascii?Q?x0uoMjj692h6Chxtqa4nBVkfi9B1oMrKAnplQhhL4mTwdNS4hWE6N2t/TIi/?=
 =?us-ascii?Q?A8rnYdYXdBpnsXzgF0yQMhTwGIoz+ANln9qQN6BuQ6dwwigJIjiCKQJRVnwc?=
 =?us-ascii?Q?FPexX1F96+W/yswf3eqTBLZSIGRyCEy1HLs2cMVhHxoJpZuGm9qdW+NdF5Fe?=
 =?us-ascii?Q?wo2VT3xR2nmvuFRyTF4oT2i+G8BlqpyILvP7nMiBRkgYBVspaNSst5X9K3LN?=
 =?us-ascii?Q?3eIpjcI1gSB4rCwpXH8jQ/FwWDB6t/KwSabVPHXooF+L6AaD6sTBi9FCQpRN?=
 =?us-ascii?Q?uZjtdJCULewYgsXw4ZHyzr+yaqcIhuVfrpeIFBTF54k1qQgmfmUf9JTFtrVz?=
 =?us-ascii?Q?4YMPea5WDK+q+tkqXLKlsjOHtpwHZupObSTX9Nym+sSiCe/kcucumzi3i6d5?=
 =?us-ascii?Q?KqhtKZpp8Gs9WtC9DOM8yLqQ9+lUm0vKWvKbdgRibEHMhheNtR4+96RnBA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_0281_01D9083B.9D4619D0"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QX7e4F81JB2A8sbfodol8ghsy92v2jvnmTyvHQxB7uufhwl5hz9FqGaSxq8IHGrZbSaobm5M1lCXfeyq+FFE8XFZ1bW031/aFgpQsVSUKUZ0rxjCZrrrSR9FnpTkvdgl7MnKeuAqngJFmbgVmjh2VUfGu4LhC2UUF6acgFb9+fBFOEpIMwts1Wl0UZLLFfj8xYsz0zTsIJ8G6rWwHlaiphbg1osE5Kh9199VKoSB2Jjg1+IlR74VWj+zvbQqpLJwzrNIYCFnmBn2dIaP4EoUjZ6NxJxai2XjX6BsNrZVtz5bQJ35nkoOplpij5WARHIlY1jyIhpazLJIjac2PSEn/FUwF3syNn0Y+L0ME634ZQKw/VpJ9nPQ3hPD4NRX9wfXL+0MqEmZDe+XeEzIfLVWXaE+3qrBYzfxeY3RpJQNpf+TWyGMTPVMDg21vC+JiCghJIXzScWGMP1K0JFfIhEHtFBsyCk0YaRvRTaY8imCTC2ufRZhVEIo9M6mWmiM0Z0qgBL35QACn2lsu6khQGma7pwwwICc7YMbIJhWLWOOyOWs52VR95hnySDwXWDa6Q/1JbnuAyzTOXitwJCZskSuMooeAaV3ukBySVnIZw2E/xP6JVcOJ3rqfAyXcnLgvnH2qWwhsU9ez85pBf7conxCZdqA7R4js3FiCg/9LaFh1LkbiI3xE4AbdAPzJrNFWzqTX5wucptY9gXyos5p47hMPVZtitosAjFv/5XP3ALFo38Rwt9Y9QY6mSz9sdAB8I45orkOW2yrgQbapufsDKkiUqWA8rZJWdWgveWXk+vlqWdwVC8LE8J+L2VDEgs3BhDG
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc93bcf-087f-4d0f-d171-08dad68d6dad
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 06:53:34.4718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1348
X-Proofpoint-GUID: nSP46T3L_BWtG5zcO6pN_xkCmnfFN1MM
X-Proofpoint-ORIG-GUID: nSP46T3L_BWtG5zcO6pN_xkCmnfFN1MM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212050026

------=_NextPart_000_0281_01D9083B.9D4619D0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_0282_01D9083B.9D4640E0"


------=_NextPart_001_0282_01D9083B.9D4640E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Just ran the latest kernel from the next branch with the lockdep turned back
on and ftrace off for now. Good news is that I no longer see a boosting
issue. Thanks again for the work to track that down. All that is left at the
moment is one lockdep kernel splat which may not be important, but I
attached anyway.

Thanks,

Russell

------=_NextPart_001_0282_01D9083B.9D4640E0
Content-Type: text/plain;
	name="final_lockdep_trace.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="final_lockdep_trace.txt"

Dec  4 23:43:01 10.243.0.116 [  183.100173] ------------[ cut here =
]------------
Dec  4 23:43:01 10.243.0.116 [  183.100180] =
DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled())
Dec  4 23:43:01 10.243.0.116 [  183.100200] WARNING: CPU: 5 PID: 1561 at =
kernel/locking/lockdep.c:5550 check_flags+0x1a4/0x1d0
Dec  4 23:43:01 10.243.0.116 [  183.100214] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich iTCO_wdt =
iTCO_vendor_support mxm_wmi kvm_intel kvm irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
i2c_i801 intel_cstate joydev ftdi_sio intel_pch_thermal i2c_smbus =
input_leds sg mei_me lpc_ich pcspkr mfd_core mei ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper ixgbe sd_mod sr_mod =
syscopyarea sysfillrect cdrom t10_pi sysimgblt fb_sys_fops =
drm_ttm_helper ttm mdio drm ahci
Dec  4 23:43:01 10.243.0.116 [  183.100384]  libahci igb crc32c_intel =
libata ptp i2c_algo_bit pps_core dca fuse
Dec  4 23:43:01 10.243.0.116 [  183.100403] CPU: 5 PID: 1561 Comm: =
TxStartup Not tainted 5.15.77evl-g7564b3bed14f #3
Dec  4 23:43:01 10.243.0.116 [  183.100411] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Dec  4 23:43:01 10.243.0.116 [  183.100414] IRQ stage: Linux
Dec  4 23:43:01 10.243.0.116 [  183.100417] RIP: =
0010:check_flags+0x1a4/0x1d0
Dec  4 23:43:01 10.243.0.116 [  183.100424] Code: ff ff e8 1f d4 6a ff =
85 c0 74 21 44 8b 05 3c de 60 01 45 85 c0 75 15 48 c7 c6 80 04 69 af 48 =
c7 c7 40 d3 68 af e8 e6 e3 f9 ff <0f> 0b 48 c7 c7 c0 04 69 af e8 5f 7b =
fa ff e9 5c ff ff ff 65 48 8b
Dec  4 23:43:01 10.243.0.116 [  183.100430] RSP: 0018:ffff88810c9d7d90 =
EFLAGS: 00010082
Dec  4 23:43:01 10.243.0.116 [  183.100435] RAX: 0000000000000000 RBX: =
1ffff1102193afb8 RCX: 0000000000000027
Dec  4 23:43:01 10.243.0.116 [  183.100439] RDX: 0000000000000027 RSI: =
dffffc0000000000 RDI: ffff8883de137b78
Dec  4 23:43:01 10.243.0.116 [  183.100443] RBP: ffff88810c9d7d90 R08: =
ffffed107bc26f70 R09: ffffed107bc26f70
Dec  4 23:43:01 10.243.0.116 [  183.100448] R10: ffff8883de137b7b R11: =
ffffed107bc26f6f R12: ffff88810c9d7e80
Dec  4 23:43:01 10.243.0.116 [  183.100452] R13: 0000000000000005 R14: =
0000000000000000 R15: 0000000000000000
Dec  4 23:43:01 10.243.0.116 [  183.100455] FS:  00007fec6923c700(0000) =
GS:ffff8883de100000(0000) knlGS:0000000000000000
Dec  4 23:43:01 10.243.0.116 [  183.100460] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Dec  4 23:43:01 10.243.0.116 [  183.100464] CR2: 0000000000000000 CR3: =
0000000133cf8002 CR4: 00000000003706e0
Dec  4 23:43:01 10.243.0.116 [  183.100468] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Dec  4 23:43:01 10.243.0.116 [  183.100471] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Dec  4 23:43:01 10.243.0.116 [  183.100475] Call Trace:
Dec  4 23:43:01 10.243.0.116 [  183.100477]  <TASK>
Dec  4 23:43:01 10.243.0.116 [  183.100481]  lock_acquire+0x150/0x3f0
Dec  4 23:43:01 10.243.0.116 [  183.100494]  ? =
lockdep_hardirqs_on_prepare+0x250/0x250
Dec  4 23:43:01 10.243.0.116 [  183.100503]  ? lock_release+0x2ac/0x440
Dec  4 23:43:01 10.243.0.116 [  183.100511]  ? =
__context_tracking_enter+0x6f/0x80
Dec  4 23:43:01 10.243.0.116 [  183.100518]  ? =
lock_downgrade+0x3e0/0x3e0
Dec  4 23:43:01 10.243.0.116 [  183.100527]  ? =
rcu_read_lock_sched_held+0x5b/0xd0
Dec  4 23:43:01 10.243.0.116 [  183.100537]  ? sched_clock+0x9/0x10
Dec  4 23:43:01 10.243.0.116 [  183.100546]  vtime_user_exit+0x73/0x150
Dec  4 23:43:01 10.243.0.116 [  183.100553]  ? =
__context_tracking_exit+0x60/0x70
Dec  4 23:43:01 10.243.0.116 [  183.100561]  =
__context_tracking_exit+0x60/0x70
Dec  4 23:43:01 10.243.0.116 [  183.100568]  =
syscall_enter_from_user_mode+0xd8/0x130
Dec  4 23:43:01 10.243.0.116 [  183.100576]  do_syscall_64+0x1d/0xa0
Dec  4 23:43:01 10.243.0.116 [  183.100586]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Dec  4 23:43:01 10.243.0.116 [  183.100593] RIP: 0033:0x7fec75afbe44
Dec  4 23:43:01 10.243.0.116 [  183.100599] Code: ff 31 c0 87 83 1c 06 =
00 00 83 f8 fe 0f 84 42 02 00 00 48 8b 54 24 08 be 18 00 00 00 b8 11 01 =
00 00 48 8d ba e0 02 00 00 0f 05 <f6> 82 14 06 00 00 04 0f 85 e9 01 00 =
00 48 8d 7c 24 10 48 c7 44 24
Dec  4 23:43:01 10.243.0.116 [  183.100605] RSP: 002b:00007fec6922c960 =
EFLAGS: 00000202 ORIG_RAX: 0000000000000111
Dec  4 23:43:01 10.243.0.116 [  183.100611] RAX: ffffffffffffffda RBX: =
00007fec6923c700 RCX: 00007fec75afbe44
Dec  4 23:43:01 10.243.0.116 [  183.100615] RDX: 00007fec6923c700 RSI: =
0000000000000018 RDI: 00007fec6923c9e0
Dec  4 23:43:01 10.243.0.116 [  183.100619] RBP: 0000000000000000 R08: =
00007fec6923c700 R09: 00007fec6923c700
Dec  4 23:43:01 10.243.0.116 [  183.100622] R10: 00007fec6923c9d0 R11: =
0000000000000202 R12: 0000000000000001
Dec  4 23:43:01 10.243.0.116 [  183.100626] R13: 0000000001001000 R14: =
0000000000000000 R15: 00007fec6923c700
Dec  4 23:43:01 10.243.0.116 [  183.100637]  </TASK>
Dec  4 23:43:01 10.243.0.116 [  183.100640] irq event stamp: 6
Dec  4 23:43:01 10.243.0.116 [  183.100642] hardirqs last  enabled at =
(5): [<ffffffffae002725>] ret_from_fork+0x15/0x30
Dec  4 23:43:01 10.243.0.116 [  183.100651] hardirqs last disabled at =
(6): [<ffffffffaf13333d>] do_syscall_64+0x1d/0xa0
Dec  4 23:43:01 10.243.0.116 [  183.100659] softirqs last  enabled at =
(0): [<ffffffffae0c4ee2>] copy_process+0x12c2/0x3740
Dec  4 23:43:01 10.243.0.116 [  183.100666] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
Dec  4 23:43:01 10.243.0.116 [  183.100670] ---[ end trace =
f5eed2984649a17b ]---
Dec  4 23:43:01 10.243.0.116 [  183.100674] possible reason: unannotated =
irqs-on.
Dec  4 23:43:01 10.243.0.116 [  183.100675] irq event stamp: 6
Dec  4 23:43:01 10.243.0.116 [  183.100677] hardirqs last  enabled at =
(5): [<ffffffffae002725>] ret_from_fork+0x15/0x30
Dec  4 23:43:01 10.243.0.116 [  183.100684] hardirqs last disabled at =
(6): [<ffffffffaf13333d>] do_syscall_64+0x1d/0xa0
Dec  4 23:43:01 10.243.0.116 [  183.100691] softirqs last  enabled at =
(0): [<ffffffffae0c4ee2>] copy_process+0x12c2/0x3740
Dec  4 23:43:01 10.243.0.116 [  183.100698] softirqs last disabled at =
(0): [<0000000000000000>] 0x0
------=_NextPart_001_0282_01D9083B.9D4640E0--

------=_NextPart_000_0281_01D9083B.9D4619D0
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
9w0BCQUxDxcNMjIxMjA1MDY1MzMxWjAvBgkqhkiG9w0BCQQxIgQgTrAHdrB5Gi2b4bRS6LpB4QRB
WtB2Bx+in0O/jg0rfNkwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQCG
G/yteS7UbyK/sPNDYsqHYvBb6W+O5z7whGBIRRbw0WK1aXteZrCefFhCuz36MEJS72JKDWA6Ujt1
wtv9E0WGUu1DUQ1p3OYiBoCCZgazSOQ0vE++4hkq/P+3HpRFbAWt53dzO3/un08SEGQWkU2Yz7YD
RuwmLIx2a23xxqC4TZZjzvIvI9GZZhuvwWew5thIRJF/qZGmoqHOkre3V5Y6Ur05IYDLuCVXA8rV
v3OEpvWgdbzniOjU/eLB4LDNxPCjWhMI4N2teuy/KeGtx3pprdaqN5O3aHzq50QvNFumFqUh0D7f
IK7xWzs+CJ2UmiqqjokudvquPhAJ3O7gPjoCAAAAAAAA

------=_NextPart_000_0281_01D9083B.9D4619D0--
