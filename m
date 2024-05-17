Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81802F55
	for <xenomai@lists.linux.dev>; Fri, 17 May 2024 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715954747; cv=fail; b=t7Yr7Vv1cSIoaXFkXEoyGFy82CJGv/UkKR6HLqUeSV2DLJWt2C+670NNLECi5xKDdjDfGub2OpO7K3cV0JgUhmNxGUBGOYx4eYo27/UkpNZ1wFEdLCITq1FL1XFwU0pCPzOCPOvbtJm3BmY0y+ngPUzbiIAcscbMG9o7UvwSf0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715954747; c=relaxed/simple;
	bh=HWlal4qHF85kgihk2OT0gVISgfAyVN3jJG/volwZpoA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V5nUmjEX3sNzU9xysNRrtIY+P33Lm648IvAVZYELlYk2XiX2lkCJS2TRGcjuC1b6ALHv0dvpmgeCqIB/wrdjqv0Zww99Zd/QNKZa+Dp3SALuGeyOiH7T+GeukSFrDuWh1ZSjI5xZnygIQJuxpJe/NmQgEarOz15gTvChSQgV1UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3mX+w1C; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3mX+w1C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715954742; x=1747490742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HWlal4qHF85kgihk2OT0gVISgfAyVN3jJG/volwZpoA=;
  b=j3mX+w1CWw6058OwpDlP+IFmjstyfp5SMPuA4jGMHM5TDncTPG8xTNSx
   tZt0BtPFFl1vcaNsSLMMbHiqA7ivYD4AtevyIWqteGklr0vHPuQRivW8N
   8B6c9nF2+cwj4q+EbUqLwgxyTfao/rkY/+FddXlfCRGim0Juvgu+T1vgp
   3p2vbiyOOFTEcOTWPb34sntXE8dwNNpQ/n9dwq3lVmqc/1j0PxInjqOgm
   3LGYMe0uDuSwjxaY5uk0sMTeZagIGveUv48io9gqbzVDAqgL+5h2Yct2M
   wecC4lIaAzaa6VIwGwMsIGSSlNiXwkZaDqQj4YmXatoztlnBGrye90FLP
   g==;
X-CSE-ConnectionGUID: rEzGEg+PSvu18dS7odHqlQ==
X-CSE-MsgGUID: yDYTOnT1RtmHtHw4SjWgHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="11980647"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="11980647"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:05:25 -0700
X-CSE-ConnectionGUID: jporIFToSKuii7QrohxGlA==
X-CSE-MsgGUID: GsqOTuLuQ4eQNzmmaavmyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31891871"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 May 2024 07:05:24 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 07:05:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 07:05:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 07:05:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErHOgojsQoL8jEUtHMp8fJKR0j+3NrEENIvOTmq+wy3wGgteVf+plvco5fJ18vhwsrOYDOQ/nfd/3GYWSAUfcMq4isD7Iij/7jTM1S/hqH1xTBD4DOZtKllAqPhI38TZv++UcW623syKTan0x4LPDGK3w0iQ4vGbxIexLDVkMQqVnW1Y4vVqqZygKtQP/GL9QWqYy170IzMM1gWm7iWlg4m+vbaZbtVQ3TZnLmQnbr3UUz2ZoweK1DI74kVTYcQcVuAxoRjVC303h2VdbcVFMCPVVrv4P55uHd3v9c3SmXf62ie5TVXcLJTEQmXQXGbtWWugh4xv77iOc0Mtj/nuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSGz3KXvlQACl6OADwxHMKrwikysQ+11ryex5G/MP+0=;
 b=Rnz5Q6MP6u1eDqlEol3pejDb28UbDrSYiSm1VZymyKoSkr9LgJRNkhiT92PyPVwVyWsDcL5FjRY2AbqgKHnBpRVQXj8vFQ31wsiI2R0Y3IRfWGdzdocMjwIowpHvPIIhstmtc6LwCicf2y5hh+XpWg+veeAPfh6D/MwE2lN2EhpRhh4pJKABv6fuqwZjUk3/zdGg200x6Fo1XYCgmOGjEMnv5VJMn4m2kQ04XY9txtKmtW6ruR0JSehfk7Erd/68yn9IZjzO5/6WP2lemErg8EXXxW99njjpjHDfX1uI3HoNuOoSDrChSLvY2HeB/h3ZoeB/oRTH1zy4DyDJeKQzxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by PH7PR11MB8252.namprd11.prod.outlook.com (2603:10b6:510:1aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 14:05:13 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%6]) with mapi id 15.20.7544.052; Fri, 17 May 2024
 14:05:13 +0000
From: "Nechita, Ionut" <ionut.nechita@intel.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: WARN Kernel v6.9-evl-rebase - poll_idle
Thread-Topic: WARN Kernel v6.9-evl-rebase - poll_idle
Thread-Index: AdqoWfw8Y7O5/BzdQqKimOgS8hEcJwAAqXOAAAGPliA=
Date: Fri, 17 May 2024 14:05:12 +0000
Message-ID: <PH0PR11MB59499F4FD2B2648610192BE0F4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
References: <PH0PR11MB594952BA30D4672C8271E6A0F4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87ttiwr2zi.fsf@xenomai.org>
In-Reply-To: <87ttiwr2zi.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5949:EE_|PH7PR11MB8252:EE_
x-ms-office365-filtering-correlation-id: d227c18f-a985-4593-231b-08dc767a5edf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?XOjR1+Q0lUiZjMwE4wIlKP4N0arCgJMfsCPVKBmOrS62ykRiNaqcjiPz28w4?=
 =?us-ascii?Q?exVNl2nFLmMOYQAIKGckE6RHGIIIc6H24KmbjVQwMecTlMvIKOJqkdEvmd6H?=
 =?us-ascii?Q?NGQ60fw87IfbPC6jWEJxPHp9EFE+RH8mXbD3qRo1mS2rgfizAOAUuhn9vbOr?=
 =?us-ascii?Q?/DRUuxQxc1sHWl7zbKDyPYtBFKTZCb1iErd2ZgpxA+wtWyhXHHyxKqL53SN4?=
 =?us-ascii?Q?HzLTiu2udaAZV/gD6alO1WcEWoXG7MQ3JiT7SzGgH5ajXhrEe/eiCwsb1XSE?=
 =?us-ascii?Q?doXyXKei5F8zhtfd8M+SgpF0v0wLyCoRQlTBHX4z4AuEeN2x1WYh1+4mFJHB?=
 =?us-ascii?Q?BHiPUeMYEX/kWZM7Nx7v2Ox5Bz4JMXr4RUH7ybY2frbczOPr4yqZ7z3YHFFV?=
 =?us-ascii?Q?tQNxbN17GYWBiW/RJ139GYg54eIciAB+GVYcrvz7/Q8d5XYpZ1W/RnAiMTMG?=
 =?us-ascii?Q?FPUXRi6Xwi2Lvv3zcVivkvVjVLm5dEBkRv8KzeTbwphpZOlz5yAl89EXGOrj?=
 =?us-ascii?Q?HLPpDWBaAL4H0KachwMNR+GkjuUDq9HxjJMoXLHGdOVWZ10Cp5W1eONdaIOH?=
 =?us-ascii?Q?j7sSCgkH1Rhv6FXOxgY+kpIkJarMb8VoLIR+XVj+O61ZU2Rj2MtGbCx4viyc?=
 =?us-ascii?Q?/G9KjD3WnGnvXX0ACxN4+By65a9lqYpgypGzvKGlygqCt99XoSCFUEY4JiQn?=
 =?us-ascii?Q?PTjaaJDjS6D4fRbHnhr6vnQd1C+Cq7yD7+N42RnB7xag7cbPAKk/oJZWuvK8?=
 =?us-ascii?Q?lAy88Tm3mjDa1yBIajDHEIHH57ge7CbiRZkuT2ZdU3op4JFs7Y2dvOuJu4ds?=
 =?us-ascii?Q?cGyV7zBkWZN0Vy73zbb4J75q1X7Xsf/yb5ysSYvbPiYw30y3CCS6PRmXhgia?=
 =?us-ascii?Q?FmRZOgW51VFDnS5ApwPGHGdpdx/1Crdt7+BNsjf0z6yzPNiI+7YHAEyex8QP?=
 =?us-ascii?Q?8wcMEPrVcGyChAojHTff1pbDrDVapq+Lw6D3lTjJEOth7rBtZ7S1V8hKaCNQ?=
 =?us-ascii?Q?jRRa9q8GHaN0CTeWr53Ysf/N2z7T0Zxby+irGpVR049pUuz22XAutEYP+UW3?=
 =?us-ascii?Q?RQ4GM7PIR4P8rXWdc8GNzmjhJ/NpYA+xXVKpWL0A5QpYdSgqJAsCoKbHQGF8?=
 =?us-ascii?Q?JY/jb/XH438IedUxaYe03MxaGB46mUu4Hosi1tYF+T6vP5b9J6Gy3zpSn98c?=
 =?us-ascii?Q?OyxIaei/GcIYsAoF0pOkJdMI7Ey3Q/cOwvetYlo/vhYdKTkKrRvKi5UApzdZ?=
 =?us-ascii?Q?gv33MDJk35S5Fb0P1Wlipuk+v6Q4rmCMqm3BTk9hV1l3KshXs0GauxWM/bX2?=
 =?us-ascii?Q?E/M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fxo5nHXRRosdSJhitd891/YLGSo+NZCFP7/jky92Wka67sePBU5HfxP1EmYG?=
 =?us-ascii?Q?FkVLlrfZ+GfWyjr8bTYzi0WcOF0WjBYm/DIvEppIEVsOHjpfVPi26mLjDPJ5?=
 =?us-ascii?Q?TjnZONcWs0CL7pFdx/2h4I0h6+riemrVin2qgiSRU9AMMHlGee5aFScS71VN?=
 =?us-ascii?Q?lRWN3noLUIOtg4UDkGkJRvP6XkRSqWOvSSYnkTKvpB0pBeVoM/fh41Wfb02z?=
 =?us-ascii?Q?rccD01J3YwzKA163B+GBX54gSMACDRwuVlxx1JdCjsoEAU2yrU6VN2gJBdWX?=
 =?us-ascii?Q?UDTloWitBUT9WDC1lFbtIUxd+Bj4d/QwMG5xeXp+WHgWo/8AQzvLlioWUCHt?=
 =?us-ascii?Q?vlDATW+FvP+e6n/1+4mw09LGgVrmFU+G82T3f0RIePdIlvgO2JM1rgyaPZog?=
 =?us-ascii?Q?TaD9WjKWLeXAuz0lTwLK+HP/UcwdOxInSKC9BBQVIGV2OZANsIzQ+BaH4lI6?=
 =?us-ascii?Q?G8gZ3HAA92p+ff84S8XsspxBzVqQEja2JlxYmHt/0pKvLLFUXJwvrSLiJ3Ih?=
 =?us-ascii?Q?ZgnQ7hQjo5CbZlJZeya6AM+fOSGMeJg52p3IbAScVe5V5OQT0lPe06go4u3D?=
 =?us-ascii?Q?3DmQAekcze7n1UmYYWbpL1qa9dVckDsSRvkBkreDOmGjvxPCvUoQ+E74cN1V?=
 =?us-ascii?Q?1Qrvdp+ICl7KIUl1tx76vY6aGSTZSazvSOyVIWNAd8plGTcDDYZYVqkxHTDP?=
 =?us-ascii?Q?8jPCpNq3YQNfubCXPNFEf/jj282r99OAR7TgC/Qni01SFj6K7k2cfh68iQfd?=
 =?us-ascii?Q?dqUYG+CV3/G5VbJWgh6U3cBwvaMyv20eCzueVU72mM0fa52CutPm2X8AceVd?=
 =?us-ascii?Q?BMb7nvFIHUOaIFkDYYDhnwYkr0ApPdsqVUksfubM5GFoT59zPMzmljLhdySX?=
 =?us-ascii?Q?JN0s5Kz4o3ffc3ErJFmuY1bBQEFwnO97m2qUWPDxejCdH4qtmGMJrpm3vKhz?=
 =?us-ascii?Q?/35VlsXKuwmyM+UmJChXjcSMinp/zhLckPRJxcgCkso5jXaNFUrK9B3ZdzPL?=
 =?us-ascii?Q?osRGZmoTCj211ZmCvWWbL+HcZliYoxk1EB2A40dxWWY6/mqHY9tR1GCoaGCt?=
 =?us-ascii?Q?i1e9xBKWs4Uwmt3ikTOZC8eOUiQrCmOdEiZRDILzh15IM8Sj/rpTEi4KtTfl?=
 =?us-ascii?Q?qht/T6ox0o+axUaSGX50YxFt2TY5XCn01p9DxmNkHaqkTLsjt0jfmz/4aVdP?=
 =?us-ascii?Q?iFCc8UhtGdnkCW8fwVzfNyqBcbK5+3gyrfaDsl3164Xor0EdJXRA4jWLkBsI?=
 =?us-ascii?Q?XwNaGTNr3VCmY06+QGwgq3vxMJxkVMVhOYn/HIcPfgk0Vn6Hz9BPGDnlC+4Q?=
 =?us-ascii?Q?eqnfQBVTbZAPHfqP0ck/EhRxwPwgr4jzMpysiln5/kVrbZEJQlgtN3XCTr2X?=
 =?us-ascii?Q?BoFyJKB5N7O0x8c9/vDYAqN2fadE7LPjgpq43rX1/T4YkG9y8HwJX7P8qdzx?=
 =?us-ascii?Q?UdzvSUdOE+d3x/7fMQnR+SqmUdZCVV5YY3mkae+pGTXYGfotrwTFyMF/l2sJ?=
 =?us-ascii?Q?YDSF6u+ohci6UaHkPz2qBe4CrMzQn8rB+Azc6eb7bc9QTe6Zw1K/ffz512rV?=
 =?us-ascii?Q?n8fQdw3y3ubBDpoiH+jihW9DlkuujC4TJs5H1xpH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d227c18f-a985-4593-231b-08dc767a5edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 14:05:12.9054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NYUjx1AekvQzz8ou/ULGdz8BaTYmw+EE0M3gEkZSyPlapT5OrZwhTHBbSV6bd/C6k5yiSYE25WQztvEH2s00dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8252
X-OriginatorOrg: intel.com

Clean now in dmesg.
Thanks for patch.

Clean and no RIP keyword now.

Output(dmesg):

[Vi mai 17 16:58:03 2024] Linux version 6.9.0-x64v1-evl1 (root@f45666bb6d9c=
) (gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld (GNU Binutils for Ubun=
tu) 2.38) #8 SMP PREEMPT_DYNAMIC IRQ_PIPELINE Fri May 17 16:48:38 EEST 202
[Vi mai 17 16:58:03 2024] Command line: BOOT_IMAGE=3D/boot/vmlinuz-6.9.0-x6=
4v1-lowlatency1 root=3DUUID=3D6202d57a-239b-4b0b-ba48-ee04a7d2b1c1 ro audit=
=3D0 clocksource=3Dtsc tsc=3Dreliable quiet splash vt.handoff=3D7
[Vi mai 17 16:58:03 2024] KERNEL supported cpus:
[Vi mai 17 16:58:03 2024]   Intel GenuineIntel
[Vi mai 17 16:58:03 2024]   AMD AuthenticAMD
[Vi mai 17 16:58:03 2024]   Hygon HygonGenuine
[Vi mai 17 16:58:03 2024]   Centaur CentaurHauls
[Vi mai 17 16:58:03 2024]   zhaoxin   Shanghai =20
[Vi mai 17 16:58:03 2024] BIOS-provided physical RAM map:
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x0000000000000000-0x000000000005=
7fff] usable
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x0000000000058000-0x000000000005=
8fff] reserved
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x0000000000059000-0x000000000009=
efff] usable
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x000000000009f000-0x00000000000f=
ffff] reserved
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x0000000000100000-0x000000003fff=
ffff] usable
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x0000000040000000-0x00000000403f=
ffff] reserved
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x0000000040400000-0x00000000704f=
cfff] usable
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x00000000704fd000-0x00000000704f=
dfff] ACPI NVS
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x00000000704fe000-0x00000000704f=
efff] reserved
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x00000000704ff000-0x000000007a10=
dfff] usable
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x000000007a10e000-0x000000007a5a=
2fff] reserved
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x000000007a5a3000-0x000000007a5e=
8fff] ACPI data
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x000000007a5e9000-0x000000007aa0=
5fff] ACPI NVS
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x000000007aa06000-0x000000007aff=
dfff] reserved
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x000000007affe000-0x000000007aff=
efff] usable
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x000000007afff000-0x000000007fff=
ffff] reserved
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x00000000e0000000-0x00000000efff=
ffff] reserved
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe01=
0fff] reserved
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec0=
0fff] reserved
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed0=
0fff] reserved
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee0=
0fff] reserved
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffff=
ffff] reserved
[Vi mai 17 16:58:03 2024] BIOS-e820: [mem 0x0000000100000000-0x000000087eff=
ffff] usable
[Vi mai 17 16:58:03 2024] NX (Execute Disable) protection: active
[Vi mai 17 16:58:03 2024] APIC: Static calls initialized
[Vi mai 17 16:58:03 2024] e820: update [mem 0x6a408018-0x6a418057] usable =
=3D=3D> usable
[Vi mai 17 16:58:03 2024] e820: update [mem 0x6a3f7018-0x6a407e57] usable =
=3D=3D> usable
[Vi mai 17 16:58:03 2024] extended physical RAM map:
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x0000000000000000-0x000=
0000000057fff] usable
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x0000000000058000-0x000=
0000000058fff] reserved
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x0000000000059000-0x000=
000000009efff] usable
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x000000000009f000-0x000=
00000000fffff] reserved
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x0000000000100000-0x000=
000003fffffff] usable
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x0000000040000000-0x000=
00000403fffff] reserved
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x0000000040400000-0x000=
000006a3f7017] usable
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x000000006a3f7018-0x000=
000006a407e57] usable
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x000000006a407e58-0x000=
000006a408017] usable
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x000000006a408018-0x000=
000006a418057] usable
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x000000006a418058-0x000=
00000704fcfff] usable
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x00000000704fd000-0x000=
00000704fdfff] ACPI NVS
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x00000000704fe000-0x000=
00000704fefff] reserved
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x00000000704ff000-0x000=
000007a10dfff] usable
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x000000007a10e000-0x000=
000007a5a2fff] reserved
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x000000007a5a3000-0x000=
000007a5e8fff] ACPI data
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x000000007a5e9000-0x000=
000007aa05fff] ACPI NVS
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x000000007aa06000-0x000=
000007affdfff] reserved
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x000000007affe000-0x000=
000007affefff] usable
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x000000007afff000-0x000=
000007fffffff] reserved
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x00000000e0000000-0x000=
00000efffffff] reserved
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x00000000fe000000-0x000=
00000fe010fff] reserved
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x00000000fec00000-0x000=
00000fec00fff] reserved
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x00000000fed00000-0x000=
00000fed00fff] reserved
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x00000000fee00000-0x000=
00000fee00fff] reserved
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x00000000ff000000-0x000=
00000ffffffff] reserved
[Vi mai 17 16:58:03 2024] reserve setup_data: [mem 0x0000000100000000-0x000=
000087effffff] usable
[Vi mai 17 16:58:03 2024] efi: EFI v2.7 by American Megatrends
[Vi mai 17 16:58:03 2024] efi: TPMFinalLog=3D0x7a9d5000 ACPI 2.0=3D0x7a5b10=
00 ACPI=3D0x7a5b1000 SMBIOS=3D0x7ae08000 SMBIOS 3.0=3D0x7ae07000 MEMATTR=3D=
0x787c6418 ESRT=3D0x7ae04418 MOKvar=3D0x7ae23000 RNG=3D0x7a5b0018 TPMEventL=
og=3D0x705fc018=20
[Vi mai 17 16:58:03 2024] random: crng init done
[Vi mai 17 16:58:03 2024] efi: Remove mem53: MMIO range=3D[0xe0000000-0xeff=
fffff] (256MB) from e820 map
[Vi mai 17 16:58:03 2024] e820: remove [mem 0xe0000000-0xefffffff] reserved
[Vi mai 17 16:58:03 2024] efi: Not removing mem54: MMIO range=3D[0xfe000000=
-0xfe010fff] (68KB) from e820 map
[Vi mai 17 16:58:03 2024] efi: Not removing mem55: MMIO range=3D[0xfec00000=
-0xfec00fff] (4KB) from e820 map
[Vi mai 17 16:58:03 2024] efi: Not removing mem56: MMIO range=3D[0xfed00000=
-0xfed00fff] (4KB) from e820 map
[Vi mai 17 16:58:03 2024] efi: Not removing mem57: MMIO range=3D[0xfee00000=
-0xfee00fff] (4KB) from e820 map
[Vi mai 17 16:58:03 2024] efi: Remove mem58: MMIO range=3D[0xff000000-0xfff=
fffff] (16MB) from e820 map
[Vi mai 17 16:58:03 2024] e820: remove [mem 0xff000000-0xffffffff] reserved
[Vi mai 17 16:58:03 2024] SMBIOS 3.1.1 present.
[Vi mai 17 16:58:03 2024] DMI: Intel(R) Client Systems NUC7i7BNH/NUC7i7BNB,=
 BIOS BNKBL357.86A.0083.2020.0714.1344 07/14/2020
[Vi mai 17 16:58:03 2024] tsc: Detected 3500.000 MHz processor
[Vi mai 17 16:58:03 2024] tsc: Detected 3499.912 MHz TSC
[Vi mai 17 16:58:03 2024] e820: update [mem 0x00000000-0x00000fff] usable =
=3D=3D> reserved
[Vi mai 17 16:58:03 2024] e820: remove [mem 0x000a0000-0x000fffff] usable
[Vi mai 17 16:58:03 2024] last_pfn =3D 0x87f000 max_arch_pfn =3D 0x40000000=
0
[Vi mai 17 16:58:03 2024] MTRR map: 4 entries (3 fixed + 1 variable; max 23=
), built from 10 variable MTRRs
[Vi mai 17 16:58:03 2024] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB =
 WP  UC- WT =20
[Vi mai 17 16:58:03 2024] last_pfn =3D 0x7afff max_arch_pfn =3D 0x400000000
[Vi mai 17 16:58:03 2024] found SMP MP-table at [mem 0x000fcd00-0x000fcd0f]
[Vi mai 17 16:58:03 2024] esrt: Reserving ESRT space from 0x000000007ae0441=
8 to 0x000000007ae04450.
[Vi mai 17 16:58:03 2024] Using GB pages for direct mapping
[Vi mai 17 16:58:03 2024] Secure boot disabled
[Vi mai 17 16:58:03 2024] RAMDISK: [mem 0x6a419000-0x6e171fff]
[Vi mai 17 16:58:03 2024] ACPI: Early table checksum verification disabled
[Vi mai 17 16:58:03 2024] ACPI: RSDP 0x000000007A5B1000 000024 (v02 INTEL )
[Vi mai 17 16:58:03 2024] ACPI: XSDT 0x000000007A5B10B8 0000F4 (v01 INTEL  =
NUC7i7BN 00000053 AMI  00010013)
[Vi mai 17 16:58:03 2024] ACPI: FACP 0x000000007A5DDD60 000114 (v06 INTEL  =
NUC7i7BN 00000053 AMI  00010013)
[Vi mai 17 16:58:03 2024] ACPI: DSDT 0x000000007A5B1240 02CB1C (v02 INTEL  =
NUC7i7BN 00000053 INTL 20160422)
[Vi mai 17 16:58:03 2024] ACPI: FACS 0x000000007AA05F80 000040
[Vi mai 17 16:58:03 2024] ACPI: APIC 0x000000007A5DDE78 000084 (v03 INTEL  =
NUC7i7BN 00000053 AMI  00010013)
[Vi mai 17 16:58:03 2024] ACPI: FPDT 0x000000007A5DDF00 000044 (v01 INTEL  =
NUC7i7BN 00000053 AMI  00010013)
[Vi mai 17 16:58:03 2024] ACPI: FIDT 0x000000007A5DDF48 00009C (v01 INTEL  =
NUC7i7BN 00000053 AMI  00010013)
[Vi mai 17 16:58:03 2024] ACPI: MCFG 0x000000007A5DDFE8 00003C (v01 INTEL  =
NUC7i7BN 00000053 MSFT 00000097)
[Vi mai 17 16:58:03 2024] ACPI: SSDT 0x000000007A5DE028 000359 (v01 INTEL  =
NUC7i7BN 00000053 INTL 20160422)
[Vi mai 17 16:58:03 2024] ACPI: SSDT 0x000000007A5DE388 003163 (v02 INTEL  =
NUC7i7BN 00000053 INTL 20160422)
[Vi mai 17 16:58:03 2024] ACPI: HPET 0x000000007A5E14F0 000038 (v01 INTEL  =
NUC7i7BN 00000053 MSFT 0000005F)
[Vi mai 17 16:58:03 2024] ACPI: SSDT 0x000000007A5E1528 0009E3 (v02 INTEL  =
NUC7i7BN 00000053 INTL 20160422)
[Vi mai 17 16:58:03 2024] ACPI: UEFI 0x000000007A5E1F10 000048 (v01 INTEL  =
NUC7i7BN 00000053      01000013)
[Vi mai 17 16:58:03 2024] ACPI: SSDT 0x000000007A5E1F58 000A5D (v02 INTEL  =
NUC7i7BN 00000053 INTL 20160422)
[Vi mai 17 16:58:03 2024] ACPI: SSDT 0x000000007A5E29B8 0017AE (v02 INTEL  =
NUC7i7BN 00000053 INTL 20160422)
[Vi mai 17 16:58:03 2024] ACPI: LPIT 0x000000007A5E4168 000094 (v01 INTEL  =
NUC7i7BN 00000053 MSFT 0000005F)
[Vi mai 17 16:58:03 2024] ACPI: SSDT 0x000000007A5E4200 000141 (v02 INTEL  =
NUC7i7BN 00000053 INTL 20160422)
[Vi mai 17 16:58:03 2024] ACPI: SSDT 0x000000007A5E4348 00029F (v02 INTEL  =
NUC7i7BN 00000053 INTL 20160422)
[Vi mai 17 16:58:03 2024] ACPI: SSDT 0x000000007A5E45E8 003002 (v02 INTEL  =
NUC7i7BN 00000053 INTL 20160422)
[Vi mai 17 16:58:03 2024] ACPI: SSDT 0x000000007A5E75F0 0000DB (v02 INTEL  =
NUC7i7BN 00000053 INTL 20160422)
[Vi mai 17 16:58:03 2024] ACPI: SSDT 0x000000007A5E76D0 0002E9 (v02 INTEL  =
NUC7i7BN 00000053 INTL 20160422)
[Vi mai 17 16:58:03 2024] ACPI: DBGP 0x000000007A5E79C0 000034 (v01 INTEL  =
NUC7i7BN 00000053 MSFT 0000005F)
[Vi mai 17 16:58:03 2024] ACPI: DBG2 0x000000007A5E79F8 000054 (v00 INTEL  =
NUC7i7BN 00000053 MSFT 0000005F)
[Vi mai 17 16:58:03 2024] ACPI: SSDT 0x000000007A5E7A50 0012E5 (v02 INTEL  =
NUC7i7BN 00000053 INTL 20160422)
[Vi mai 17 16:58:03 2024] ACPI: DMAR 0x000000007A5E8D38 0000A8 (v01 INTEL  =
NUC7i7BN 00000053 INTL 00000001)
[Vi mai 17 16:58:03 2024] ACPI: NHLT 0x000000007A5E8DE0 00002D (v00 INTEL  =
NUC7i7BN 00000053      01000013)
[Vi mai 17 16:58:03 2024] ACPI: BGRT 0x000000007A5E8E10 000038 (v01 INTEL  =
NUC7i7BN 00000053 AMI  00010013)
[Vi mai 17 16:58:03 2024] ACPI: TPM2 0x000000007A5E8E48 000034 (v04 INTEL  =
NUC7i7BN 00000053 AMI  00000000)
[Vi mai 17 16:58:03 2024] ACPI: WSMT 0x000000007A5E8E80 000028 (v01 INTEL  =
NUC7i7BN 00000053 AMI  00010013)
[Vi mai 17 16:58:03 2024] ACPI: Reserving FACP table memory at [mem 0x7a5dd=
d60-0x7a5dde73]
[Vi mai 17 16:58:03 2024] ACPI: Reserving DSDT table memory at [mem 0x7a5b1=
240-0x7a5ddd5b]
[Vi mai 17 16:58:03 2024] ACPI: Reserving FACS table memory at [mem 0x7aa05=
f80-0x7aa05fbf]
[Vi mai 17 16:58:03 2024] ACPI: Reserving APIC table memory at [mem 0x7a5dd=
e78-0x7a5ddefb]
[Vi mai 17 16:58:03 2024] ACPI: Reserving FPDT table memory at [mem 0x7a5dd=
f00-0x7a5ddf43]
[Vi mai 17 16:58:03 2024] ACPI: Reserving FIDT table memory at [mem 0x7a5dd=
f48-0x7a5ddfe3]
[Vi mai 17 16:58:03 2024] ACPI: Reserving MCFG table memory at [mem 0x7a5dd=
fe8-0x7a5de023]
[Vi mai 17 16:58:03 2024] ACPI: Reserving SSDT table memory at [mem 0x7a5de=
028-0x7a5de380]
[Vi mai 17 16:58:03 2024] ACPI: Reserving SSDT table memory at [mem 0x7a5de=
388-0x7a5e14ea]
[Vi mai 17 16:58:03 2024] ACPI: Reserving HPET table memory at [mem 0x7a5e1=
4f0-0x7a5e1527]
[Vi mai 17 16:58:03 2024] ACPI: Reserving SSDT table memory at [mem 0x7a5e1=
528-0x7a5e1f0a]
[Vi mai 17 16:58:03 2024] ACPI: Reserving UEFI table memory at [mem 0x7a5e1=
f10-0x7a5e1f57]
[Vi mai 17 16:58:03 2024] ACPI: Reserving SSDT table memory at [mem 0x7a5e1=
f58-0x7a5e29b4]
[Vi mai 17 16:58:03 2024] ACPI: Reserving SSDT table memory at [mem 0x7a5e2=
9b8-0x7a5e4165]
[Vi mai 17 16:58:03 2024] ACPI: Reserving LPIT table memory at [mem 0x7a5e4=
168-0x7a5e41fb]
[Vi mai 17 16:58:03 2024] ACPI: Reserving SSDT table memory at [mem 0x7a5e4=
200-0x7a5e4340]
[Vi mai 17 16:58:03 2024] ACPI: Reserving SSDT table memory at [mem 0x7a5e4=
348-0x7a5e45e6]
[Vi mai 17 16:58:03 2024] ACPI: Reserving SSDT table memory at [mem 0x7a5e4=
5e8-0x7a5e75e9]
[Vi mai 17 16:58:03 2024] ACPI: Reserving SSDT table memory at [mem 0x7a5e7=
5f0-0x7a5e76ca]
[Vi mai 17 16:58:03 2024] ACPI: Reserving SSDT table memory at [mem 0x7a5e7=
6d0-0x7a5e79b8]
[Vi mai 17 16:58:03 2024] ACPI: Reserving DBGP table memory at [mem 0x7a5e7=
9c0-0x7a5e79f3]
[Vi mai 17 16:58:03 2024] ACPI: Reserving DBG2 table memory at [mem 0x7a5e7=
9f8-0x7a5e7a4b]
[Vi mai 17 16:58:03 2024] ACPI: Reserving SSDT table memory at [mem 0x7a5e7=
a50-0x7a5e8d34]
[Vi mai 17 16:58:03 2024] ACPI: Reserving DMAR table memory at [mem 0x7a5e8=
d38-0x7a5e8ddf]
[Vi mai 17 16:58:03 2024] ACPI: Reserving NHLT table memory at [mem 0x7a5e8=
de0-0x7a5e8e0c]
[Vi mai 17 16:58:03 2024] ACPI: Reserving BGRT table memory at [mem 0x7a5e8=
e10-0x7a5e8e47]
[Vi mai 17 16:58:03 2024] ACPI: Reserving TPM2 table memory at [mem 0x7a5e8=
e48-0x7a5e8e7b]
[Vi mai 17 16:58:03 2024] ACPI: Reserving WSMT table memory at [mem 0x7a5e8=
e80-0x7a5e8ea7]
[Vi mai 17 16:58:03 2024] No NUMA configuration found
[Vi mai 17 16:58:03 2024] Faking a node at [mem 0x0000000000000000-0x000000=
087effffff]
[Vi mai 17 16:58:03 2024] NODE_DATA(0) allocated [mem 0x87efd4e00-0x87efffd=
ff]
[Vi mai 17 16:58:03 2024] Zone ranges:
[Vi mai 17 16:58:03 2024]   DMA      [mem 0x0000000000001000-0x0000000000ff=
ffff]
[Vi mai 17 16:58:03 2024]   DMA32    [mem 0x0000000001000000-0x00000000ffff=
ffff]
[Vi mai 17 16:58:03 2024]   Normal   [mem 0x0000000100000000-0x000000087eff=
ffff]
[Vi mai 17 16:58:03 2024]   Device   empty
[Vi mai 17 16:58:03 2024] Movable zone start for each node
[Vi mai 17 16:58:03 2024] Early memory node ranges
[Vi mai 17 16:58:03 2024]   node   0: [mem 0x0000000000001000-0x00000000000=
57fff]
[Vi mai 17 16:58:03 2024]   node   0: [mem 0x0000000000059000-0x00000000000=
9efff]
[Vi mai 17 16:58:03 2024]   node   0: [mem 0x0000000000100000-0x000000003ff=
fffff]
[Vi mai 17 16:58:03 2024]   node   0: [mem 0x0000000040400000-0x00000000704=
fcfff]
[Vi mai 17 16:58:03 2024]   node   0: [mem 0x00000000704ff000-0x000000007a1=
0dfff]
[Vi mai 17 16:58:03 2024]   node   0: [mem 0x000000007affe000-0x000000007af=
fefff]
[Vi mai 17 16:58:03 2024]   node   0: [mem 0x0000000100000000-0x000000087ef=
fffff]
[Vi mai 17 16:58:03 2024] Initmem setup node 0 [mem 0x0000000000001000-0x00=
0000087effffff]
[Vi mai 17 16:58:03 2024] On node 0, zone DMA: 1 pages in unavailable range=
s
[Vi mai 17 16:58:03 2024] On node 0, zone DMA: 1 pages in unavailable range=
s
[Vi mai 17 16:58:03 2024] On node 0, zone DMA: 97 pages in unavailable rang=
es
[Vi mai 17 16:58:03 2024] On node 0, zone DMA32: 1024 pages in unavailable =
ranges
[Vi mai 17 16:58:03 2024] On node 0, zone DMA32: 2 pages in unavailable ran=
ges
[Vi mai 17 16:58:03 2024] On node 0, zone DMA32: 3824 pages in unavailable =
ranges
[Vi mai 17 16:58:03 2024] On node 0, zone Normal: 20481 pages in unavailabl=
e ranges
[Vi mai 17 16:58:03 2024] On node 0, zone Normal: 4096 pages in unavailable=
 ranges
[Vi mai 17 16:58:03 2024] Reserving Intel graphics memory at [mem 0x7c00000=
0-0x7fffffff]
[Vi mai 17 16:58:03 2024] ACPI: PM-Timer IO Port: 0x1808
[Vi mai 17 16:58:03 2024] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1=
])
[Vi mai 17 16:58:03 2024] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1=
])
[Vi mai 17 16:58:03 2024] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1=
])
[Vi mai 17 16:58:03 2024] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1=
])
[Vi mai 17 16:58:03 2024] IOAPIC[0]: apic_id 2, version 32, address 0xfec00=
000, GSI 0-119
[Vi mai 17 16:58:03 2024] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 d=
fl dfl)
[Vi mai 17 16:58:03 2024] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 h=
igh level)
[Vi mai 17 16:58:03 2024] ACPI: Using ACPI (MADT) for SMP configuration inf=
ormation
[Vi mai 17 16:58:03 2024] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[Vi mai 17 16:58:03 2024] e820: update [mem 0x75c90000-0x75cf1fff] usable =
=3D=3D> reserved
[Vi mai 17 16:58:03 2024] TSC deadline timer available
[Vi mai 17 16:58:03 2024] CPU topo: Max. logical packages:   1
[Vi mai 17 16:58:03 2024] CPU topo: Max. logical dies:       1
[Vi mai 17 16:58:03 2024] CPU topo: Max. dies per package:   1
[Vi mai 17 16:58:03 2024] CPU topo: Max. threads per core:   2
[Vi mai 17 16:58:03 2024] CPU topo: Num. cores per package:     2
[Vi mai 17 16:58:03 2024] CPU topo: Num. threads per package:   4
[Vi mai 17 16:58:03 2024] CPU topo: Allowing 4 present CPUs plus 0 hotplug =
CPUs
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
x00000000-0x00000fff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
x00058000-0x00058fff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
x0009f000-0x000fffff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
x40000000-0x403fffff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
x6a3f7000-0x6a3f7fff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
x6a407000-0x6a407fff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
x6a408000-0x6a408fff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
x6a418000-0x6a418fff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
x704fd000-0x704fdfff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
x704fe000-0x704fefff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
x75c90000-0x75cf1fff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
x7a10e000-0x7a5a2fff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
x7a5a3000-0x7a5e8fff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
x7a5e9000-0x7aa05fff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
x7aa06000-0x7affdfff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
x7afff000-0x7fffffff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
x80000000-0xfdffffff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
xfe000000-0xfe010fff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
xfe011000-0xfebfffff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
xfec00000-0xfec00fff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
xfec01000-0xfecfffff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
xfed00000-0xfed00fff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
xfed01000-0xfedfffff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
xfee00000-0xfee00fff]
[Vi mai 17 16:58:03 2024] PM: hibernation: Registered nosave memory: [mem 0=
xfee01000-0xffffffff]
[Vi mai 17 16:58:03 2024] [mem 0x80000000-0xfdffffff] available for PCI dev=
ices
[Vi mai 17 16:58:03 2024] Booting paravirtualized kernel on bare hardware
[Vi mai 17 16:58:03 2024] clocksource: refined-jiffies: freq: 0 Hz, mask: 0=
xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[Vi mai 17 16:58:03 2024] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_c=
pu_ids:4 nr_node_ids:1
[Vi mai 17 16:58:03 2024] percpu: Embedded 137 pages/cpu s438272 r8192 d114=
688 u1048576
[Vi mai 17 16:58:03 2024] pcpu-alloc: s438272 r8192 d114688 u1048576 alloc=
=3D1*2097152
[Vi mai 17 16:58:03 2024] pcpu-alloc: [0] 0 1 [0] 2 3=20
[Vi mai 17 16:58:03 2024] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-6=
.9.0-x64v1-lowlatency1 root=3DUUID=3D6202d57a-239b-4b0b-ba48-ee04a7d2b1c1 r=
o audit=3D0 clocksource=3Dtsc tsc=3Dreliable quiet splash vt.handoff=3D7
[Vi mai 17 16:58:03 2024] audit: disabled (until reboot)
[Vi mai 17 16:58:03 2024] Unknown kernel command line parameters "splash BO=
OT_IMAGE=3D/boot/vmlinuz-6.9.0-x64v1-lowlatency1", will be passed to user s=
pace.
[Vi mai 17 16:58:03 2024] Dentry cache hash table entries: 4194304 (order: =
13, 33554432 bytes, linear)
[Vi mai 17 16:58:03 2024] Inode-cache hash table entries: 2097152 (order: 1=
2, 16777216 bytes, linear)
[Vi mai 17 16:58:03 2024] Fallback order for Node 0: 0=20
[Vi mai 17 16:58:03 2024] Built 1 zonelists, mobility grouping on.  Total p=
ages: 8228312
[Vi mai 17 16:58:03 2024] Policy zone: Normal
[Vi mai 17 16:58:03 2024] mem auto-init: stack:off, heap alloc:on, heap fre=
e:off
[Vi mai 17 16:58:03 2024] software IO TLB: area num 4.
[Vi mai 17 16:58:03 2024] Memory: 32647484K/33436328K available (20480K ker=
nel code, 3754K rwdata, 8092K rodata, 4952K init, 5436K bss, 788584K reserv=
ed, 0K cma-reserved)
[Vi mai 17 16:58:03 2024] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, =
CPUs=3D4, Nodes=3D1
[Vi mai 17 16:58:03 2024] Kernel/User page tables isolation: enabled
[Vi mai 17 16:58:03 2024] ftrace: allocating 57080 entries in 223 pages
[Vi mai 17 16:58:03 2024] ftrace: allocated 223 pages with 7 groups
[Vi mai 17 16:58:03 2024] Dynamic Preempt: full
[Vi mai 17 16:58:03 2024] rcu: Preemptible hierarchical RCU implementation.
[Vi mai 17 16:58:03 2024] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to=
 nr_cpu_ids=3D4.
[Vi mai 17 16:58:03 2024] rcu: 	RCU priority boosting: priority 1 delay 400=
 ms.
[Vi mai 17 16:58:03 2024] 	Trampoline variant of Tasks RCU enabled.
[Vi mai 17 16:58:03 2024] 	Rude variant of Tasks RCU enabled.
[Vi mai 17 16:58:03 2024] 	Tracing variant of Tasks RCU enabled.
[Vi mai 17 16:58:03 2024] rcu: RCU calculated value of scheduler-enlistment=
 delay is 25 jiffies.
[Vi mai 17 16:58:03 2024] rcu: Adjusting geometry for rcu_fanout_leaf=3D16,=
 nr_cpu_ids=3D4
[Vi mai 17 16:58:03 2024] RCU Tasks: Setting shift to 2 and lim to 1 rcu_ta=
sk_cb_adjust=3D1.
[Vi mai 17 16:58:03 2024] RCU Tasks Rude: Setting shift to 2 and lim to 1 r=
cu_task_cb_adjust=3D1.
[Vi mai 17 16:58:03 2024] RCU Tasks Trace: Setting shift to 2 and lim to 1 =
rcu_task_cb_adjust=3D1.
[Vi mai 17 16:58:03 2024] NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs=
: 16
[Vi mai 17 16:58:03 2024] IRQ pipeline enabled
[Vi mai 17 16:58:03 2024] rcu: 	Offload RCU callbacks from CPUs: 0-3.
[Vi mai 17 16:58:03 2024] rcu: srcu_init: Setting srcu_struct sizes based o=
n contention.
[Vi mai 17 16:58:03 2024] Console: colour dummy device 80x25
[Vi mai 17 16:58:03 2024] printk: legacy console [tty0] enabled
[Vi mai 17 16:58:03 2024] ACPI: Core revision 20230628
[Vi mai 17 16:58:03 2024] hpet: HPET dysfunctional in PC10. Force disabled.
[Vi mai 17 16:58:03 2024] APIC: Switch to symmetric I/O mode setup
[Vi mai 17 16:58:03 2024] DMAR: Host address width 39
[Vi mai 17 16:58:03 2024] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[Vi mai 17 16:58:03 2024] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1=
c0000c40660462 ecap 19e2ff0505e
[Vi mai 17 16:58:03 2024] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[Vi mai 17 16:58:03 2024] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d=
2008c40660462 ecap f050da
[Vi mai 17 16:58:03 2024] DMAR: RMRR base: 0x0000007ab9a000 end: 0x0000007a=
de3fff
[Vi mai 17 16:58:03 2024] DMAR: RMRR base: 0x0000007b800000 end: 0x0000007f=
ffffff
[Vi mai 17 16:58:03 2024] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 =
IOMMU 1
[Vi mai 17 16:58:03 2024] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[Vi mai 17 16:58:03 2024] DMAR-IR: Queued invalidation will be enabled to s=
upport x2apic and Intr-remapping.
[Vi mai 17 16:58:03 2024] DMAR-IR: Enabled IRQ remapping in x2apic mode
[Vi mai 17 16:58:03 2024] x2apic enabled
[Vi mai 17 16:58:03 2024] APIC: Switched APIC routing to: cluster x2apic
[Vi mai 17 16:58:03 2024] clocksource: tsc-early: freq: 3499912000 Hz, mask=
: 0xffffffffffffffff max_cycles: 0x3272fd97217, max_idle_ns: 440795241220 n=
s
[Vi mai 17 16:58:03 2024] Calibrating delay loop (skipped), value calculate=
d using timer frequency.. 6999.82 BogoMIPS (lpj=3D13999648)
[Vi mai 17 16:58:03 2024] x86/cpu: SGX disabled by BIOS.
[Vi mai 17 16:58:03 2024] CPU0: Thermal monitoring enabled (TM1)
[Vi mai 17 16:58:03 2024] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[Vi mai 17 16:58:03 2024] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1G=
B 4
[Vi mai 17 16:58:03 2024] process: using mwait in idle threads
[Vi mai 17 16:58:03 2024] Spectre V1 : Mitigation: usercopy/swapgs barriers=
 and __user pointer sanitization
[Vi mai 17 16:58:03 2024] Spectre V2 : Mitigation: IBRS
[Vi mai 17 16:58:03 2024] Spectre V2 : Spectre v2 / SpectreRSB mitigation: =
Filling RSB on context switch
[Vi mai 17 16:58:03 2024] Spectre V2 : Spectre v2 / SpectreRSB : Filling RS=
B on VMEXIT
[Vi mai 17 16:58:03 2024] RETBleed: Mitigation: IBRS
[Vi mai 17 16:58:03 2024] Spectre V2 : mitigation: Enabling conditional Ind=
irect Branch Prediction Barrier
[Vi mai 17 16:58:03 2024] Spectre V2 : User space: Mitigation: STIBP via pr=
ctl
[Vi mai 17 16:58:03 2024] Speculative Store Bypass: Mitigation: Speculative=
 Store Bypass disabled via prctl
[Vi mai 17 16:58:03 2024] MDS: Mitigation: Clear CPU buffers
[Vi mai 17 16:58:03 2024] MMIO Stale Data: Mitigation: Clear CPU buffers
[Vi mai 17 16:58:03 2024] SRBDS: Mitigation: Microcode
[Vi mai 17 16:58:03 2024] GDS: Mitigation: Microcode
[Vi mai 17 16:58:03 2024] x86/fpu: Supporting XSAVE feature 0x001: 'x87 flo=
ating point registers'
[Vi mai 17 16:58:03 2024] x86/fpu: Supporting XSAVE feature 0x002: 'SSE reg=
isters'
[Vi mai 17 16:58:03 2024] x86/fpu: Supporting XSAVE feature 0x004: 'AVX reg=
isters'
[Vi mai 17 16:58:03 2024] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bou=
nds registers'
[Vi mai 17 16:58:03 2024] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR=
'
[Vi mai 17 16:58:03 2024] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:=
  256
[Vi mai 17 16:58:03 2024] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:=
   64
[Vi mai 17 16:58:03 2024] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:=
   64
[Vi mai 17 16:58:03 2024] x86/fpu: Enabled xstate features 0x1f, context si=
ze is 960 bytes, using 'compacted' format.
[Vi mai 17 16:58:03 2024] Freeing SMP alternatives memory: 48K
[Vi mai 17 16:58:03 2024] pid_max: default: 32768 minimum: 301
[Vi mai 17 16:58:03 2024] LSM: initializing lsm=3Dlockdown,capability,yama,=
apparmor,ima,evm
[Vi mai 17 16:58:03 2024] Yama: becoming mindful.
[Vi mai 17 16:58:03 2024] AppArmor: AppArmor initialized
[Vi mai 17 16:58:03 2024] Mount-cache hash table entries: 65536 (order: 7, =
524288 bytes, linear)
[Vi mai 17 16:58:03 2024] Mountpoint-cache hash table entries: 65536 (order=
: 7, 524288 bytes, linear)
[Vi mai 17 16:58:03 2024] TSC deadline timer enabled
[Vi mai 17 16:58:03 2024] smpboot: CPU0: Intel(R) Core(TM) i7-7567U CPU @ 3=
.50GHz (family: 0x6, model: 0x8e, stepping: 0x9)
[Vi mai 17 16:58:03 2024] Performance Events: PEBS fmt3+, Skylake events, 3=
2-deep LBR, full-width counters, Intel PMU driver.
[Vi mai 17 16:58:03 2024] ... version:                4
[Vi mai 17 16:58:03 2024] ... bit width:              48
[Vi mai 17 16:58:03 2024] ... generic registers:      4
[Vi mai 17 16:58:03 2024] ... value mask:             0000ffffffffffff
[Vi mai 17 16:58:03 2024] ... max period:             00007fffffffffff
[Vi mai 17 16:58:03 2024] ... fixed-purpose events:   3
[Vi mai 17 16:58:03 2024] ... event mask:             000000070000000f
[Vi mai 17 16:58:03 2024] signal: max sigframe size: 2032
[Vi mai 17 16:58:03 2024] Estimated ratio of average max frequency by base =
frequency (times 1024): 1141
[Vi mai 17 16:58:03 2024] rcu: Hierarchical SRCU implementation.
[Vi mai 17 16:58:03 2024] rcu: 	Max phase no-delay instances is 1000.
[Vi mai 17 16:58:03 2024] NMI watchdog: Enabled. Permanently consumes one h=
w-PMU counter.
[Vi mai 17 16:58:03 2024] smp: Bringing up secondary CPUs ...
[Vi mai 17 16:58:03 2024] smpboot: x86: Booting SMP configuration:
[Vi mai 17 16:58:03 2024] .... node  #0, CPUs:      #1 #2 #3
[Vi mai 17 16:58:03 2024] MDS CPU bug present and SMT on, data leak possibl=
e. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html =
for more details.
[Vi mai 17 16:58:03 2024] MMIO Stale Data CPU bug present and SMT on, data =
leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vu=
ln/processor_mmio_stale_data.html for more details.
[Vi mai 17 16:58:03 2024] smp: Brought up 1 node, 4 CPUs
[Vi mai 17 16:58:03 2024] smpboot: Total of 4 processors activated (27999.2=
9 BogoMIPS)
[Vi mai 17 16:58:03 2024] devtmpfs: initialized
[Vi mai 17 16:58:03 2024] x86/mm: Memory block size: 128MB
[Vi mai 17 16:58:03 2024] ACPI: PM: Registering ACPI NVS region [mem 0x704f=
d000-0x704fdfff] (4096 bytes)
[Vi mai 17 16:58:03 2024] ACPI: PM: Registering ACPI NVS region [mem 0x7a5e=
9000-0x7aa05fff] (4313088 bytes)
[Vi mai 17 16:58:03 2024] clocksource: jiffies: freq: 0 Hz, mask: 0xfffffff=
f max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[Vi mai 17 16:58:03 2024] futex hash table entries: 1024 (order: 4, 65536 b=
ytes, linear)
[Vi mai 17 16:58:03 2024] pinctrl core: initialized pinctrl subsystem
[Vi mai 17 16:58:03 2024] PM: RTC time: 13:58:03, date: 2024-05-17
[Vi mai 17 16:58:03 2024] NET: Registered PF_NETLINK/PF_ROUTE protocol fami=
ly
[Vi mai 17 16:58:03 2024] DMA: preallocated 4096 KiB GFP_KERNEL pool for at=
omic allocations
[Vi mai 17 16:58:03 2024] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA poo=
l for atomic allocations
[Vi mai 17 16:58:03 2024] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 p=
ool for atomic allocations
[Vi mai 17 16:58:03 2024] thermal_sys: Registered thermal governor 'fair_sh=
are'
[Vi mai 17 16:58:03 2024] thermal_sys: Registered thermal governor 'bang_ba=
ng'
[Vi mai 17 16:58:03 2024] thermal_sys: Registered thermal governor 'step_wi=
se'
[Vi mai 17 16:58:03 2024] thermal_sys: Registered thermal governor 'user_sp=
ace'
[Vi mai 17 16:58:03 2024] thermal_sys: Registered thermal governor 'power_a=
llocator'
[Vi mai 17 16:58:03 2024] cpuidle: using governor ladder
[Vi mai 17 16:58:03 2024] cpuidle: using governor menu
[Vi mai 17 16:58:03 2024] ACPI FADT declares the system doesn't support PCI=
e ASPM, so disable it
[Vi mai 17 16:58:03 2024] acpiphp: ACPI Hot Plug PCI Controller Driver vers=
ion: 0.5
[Vi mai 17 16:58:03 2024] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe00=
00000) for domain 0000 [bus 00-ff]
[Vi mai 17 16:58:03 2024] PCI: not using ECAM ([mem 0xe0000000-0xefffffff] =
not reserved)
[Vi mai 17 16:58:03 2024] PCI: Using configuration type 1 for base access
[Vi mai 17 16:58:03 2024] kprobes: kprobe jump-optimization is enabled. All=
 kprobes are optimized if possible.
[Vi mai 17 16:58:03 2024] HugeTLB: registered 1.00 GiB page size, pre-alloc=
ated 0 pages
[Vi mai 17 16:58:03 2024] HugeTLB: 16380 KiB vmemmap can be freed for a 1.0=
0 GiB page
[Vi mai 17 16:58:03 2024] HugeTLB: registered 2.00 MiB page size, pre-alloc=
ated 0 pages
[Vi mai 17 16:58:03 2024] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 M=
iB page
[Vi mai 17 16:58:03 2024] Demotion targets for Node 0: null
[Vi mai 17 16:58:03 2024] fbcon: Taking over console
[Vi mai 17 16:58:03 2024] ACPI: Added _OSI(Module Device)
[Vi mai 17 16:58:03 2024] ACPI: Added _OSI(Processor Device)
[Vi mai 17 16:58:03 2024] ACPI: Added _OSI(3.0 _SCP Extensions)
[Vi mai 17 16:58:03 2024] ACPI: Added _OSI(Processor Aggregator Device)
[Vi mai 17 16:58:03 2024] ACPI: 12 ACPI AML tables successfully acquired an=
d loaded
[Vi mai 17 16:58:03 2024] ACPI: Dynamic OEM Table Load:
[Vi mai 17 16:58:03 2024] ACPI: SSDT 0xFFFF972EC1F2B000 0003FF (v02 PmRef  =
Cpu0Cst  00003001 INTL 20160422)
[Vi mai 17 16:58:03 2024] ACPI: Dynamic OEM Table Load:
[Vi mai 17 16:58:03 2024] ACPI: SSDT 0xFFFF972EC1F82800 0007BC (v02 PmRef  =
Cpu0Ist  00003000 INTL 20160422)
[Vi mai 17 16:58:03 2024] ACPI: Dynamic OEM Table Load:
[Vi mai 17 16:58:03 2024] ACPI: SSDT 0xFFFF972EC1F94000 000D14 (v02 PmRef  =
ApIst    00003000 INTL 20160422)
[Vi mai 17 16:58:03 2024] ACPI: Dynamic OEM Table Load:
[Vi mai 17 16:58:03 2024] ACPI: SSDT 0xFFFF972EC1F2A000 000317 (v02 PmRef  =
ApHwp    00003000 INTL 20160422)
[Vi mai 17 16:58:03 2024] ACPI: Dynamic OEM Table Load:
[Vi mai 17 16:58:03 2024] ACPI: SSDT 0xFFFF972EC1F29400 00030A (v02 PmRef  =
ApCst    00003000 INTL 20160422)
[Vi mai 17 16:58:03 2024] ACPI: _OSC evaluated successfully for all CPUs
[Vi mai 17 16:58:03 2024] ACPI: EC: EC started
[Vi mai 17 16:58:03 2024] ACPI: EC: interrupt blocked
[Vi mai 17 16:58:03 2024] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[Vi mai 17 16:58:03 2024] ACPI: \_SB_.PCI0.LPCB.H_EC: Boot DSDT EC used to =
handle transactions
[Vi mai 17 16:58:03 2024] ACPI: Interpreter enabled
[Vi mai 17 16:58:03 2024] ACPI: PM: (supports S0 S3 S4 S5)
[Vi mai 17 16:58:03 2024] ACPI: Using IOAPIC for interrupt routing
[Vi mai 17 16:58:03 2024] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe00=
00000) for domain 0000 [bus 00-ff]
[Vi mai 17 16:58:03 2024] PCI: ECAM [mem 0xe0000000-0xefffffff] reserved as=
 ACPI motherboard resource
[Vi mai 17 16:58:03 2024] PCI: Using host bridge windows from ACPI; if nece=
ssary, use "pci=3Dnocrs" and report a bug
[Vi mai 17 16:58:03 2024] PCI: Using E820 reservations for host bridge wind=
ows
[Vi mai 17 16:58:03 2024] ACPI: Enabled 7 GPEs in block 00 to 7F
[Vi mai 17 16:58:03 2024] ACPI: \_SB_.PCI0.RP06.PXSX.WRST: New power resour=
ce
[Vi mai 17 16:58:03 2024] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00=
-fe])
[Vi mai 17 16:58:03 2024] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfi=
g ASPM ClockPM Segments MSI EDR HPX-Type3]
[Vi mai 17 16:58:03 2024] acpi PNP0A08:00: _OSC: platform does not support =
[PCIeHotplug SHPCHotplug PME AER]
[Vi mai 17 16:58:03 2024] acpi PNP0A08:00: _OSC: OS now controls [PCIeCapab=
ility LTR DPC]
[Vi mai 17 16:58:03 2024] acpi PNP0A08:00: FADT indicates ASPM is unsupport=
ed, using BIOS configuration
[Vi mai 17 16:58:03 2024] PCI host bridge to bus 0000:00
[Vi mai 17 16:58:03 2024] pci_bus 0000:00: root bus resource [io  0x0000-0x=
0cf7 window]
[Vi mai 17 16:58:03 2024] pci_bus 0000:00: root bus resource [io  0x0d00-0x=
ffff window]
[Vi mai 17 16:58:03 2024] pci_bus 0000:00: root bus resource [mem 0x000a000=
0-0x000bffff window]
[Vi mai 17 16:58:03 2024] pci_bus 0000:00: root bus resource [mem 0x8000000=
0-0xdfffffff window]
[Vi mai 17 16:58:03 2024] pci_bus 0000:00: root bus resource [mem 0xfd00000=
0-0xfe7fffff window]
[Vi mai 17 16:58:03 2024] pci_bus 0000:00: root bus resource [bus 00-fe]
[Vi mai 17 16:58:03 2024] pci 0000:00:00.0: [8086:5904] type 00 class 0x060=
000 conventional PCI endpoint
[Vi mai 17 16:58:03 2024] pci 0000:00:02.0: [8086:5927] type 00 class 0x030=
000 PCIe Root Complex Integrated Endpoint
[Vi mai 17 16:58:03 2024] pci 0000:00:02.0: BAR 0 [mem 0xdb000000-0xdbfffff=
f 64bit]
[Vi mai 17 16:58:03 2024] pci 0000:00:02.0: BAR 2 [mem 0x90000000-0x9ffffff=
f 64bit pref]
[Vi mai 17 16:58:03 2024] pci 0000:00:02.0: BAR 4 [io  0xf000-0xf03f]
[Vi mai 17 16:58:03 2024] pci 0000:00:02.0: Video device with shadowed ROM =
at [mem 0x000c0000-0x000dffff]
[Vi mai 17 16:58:03 2024] pci 0000:00:08.0: [8086:1911] type 00 class 0x088=
000 conventional PCI endpoint
[Vi mai 17 16:58:03 2024] pci 0000:00:08.0: BAR 0 [mem 0xdc24f000-0xdc24fff=
f 64bit]
[Vi mai 17 16:58:03 2024] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0=
330 conventional PCI endpoint
[Vi mai 17 16:58:03 2024] pci 0000:00:14.0: BAR 0 [mem 0xdc230000-0xdc23fff=
f 64bit]
[Vi mai 17 16:58:03 2024] pci 0000:00:14.0: PME# supported from D3hot D3col=
d
[Vi mai 17 16:58:03 2024] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118=
000 conventional PCI endpoint
[Vi mai 17 16:58:03 2024] pci 0000:00:14.2: BAR 0 [mem 0xdc24e000-0xdc24eff=
f 64bit]
[Vi mai 17 16:58:03 2024] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078=
000 conventional PCI endpoint
[Vi mai 17 16:58:03 2024] pci 0000:00:16.0: BAR 0 [mem 0xdc24d000-0xdc24dff=
f 64bit]
[Vi mai 17 16:58:03 2024] pci 0000:00:16.0: PME# supported from D3hot
[Vi mai 17 16:58:03 2024] pci 0000:00:17.0: [8086:9d03] type 00 class 0x010=
601 conventional PCI endpoint
[Vi mai 17 16:58:03 2024] pci 0000:00:17.0: BAR 0 [mem 0xdc248000-0xdc249ff=
f]
[Vi mai 17 16:58:03 2024] pci 0000:00:17.0: BAR 1 [mem 0xdc24c000-0xdc24c0f=
f]
[Vi mai 17 16:58:03 2024] pci 0000:00:17.0: BAR 2 [io  0xf090-0xf097]
[Vi mai 17 16:58:03 2024] pci 0000:00:17.0: BAR 3 [io  0xf080-0xf083]
[Vi mai 17 16:58:03 2024] pci 0000:00:17.0: BAR 4 [io  0xf060-0xf07f]
[Vi mai 17 16:58:03 2024] pci 0000:00:17.0: BAR 5 [mem 0xdc24b000-0xdc24b7f=
f]
[Vi mai 17 16:58:03 2024] pci 0000:00:17.0: PME# supported from D3hot
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060=
400 PCIe Root Port
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.0:   bridge window [mem 0xc4000000=
-0xda0fffff]
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.0:   bridge window [mem 0xa0000000=
-0xc1ffffff 64bit pref]
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.0: PME# supported from D0 D3hot D3=
cold
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.0: Intel SPT PCH root port ACS wor=
karound enabled
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.5: [8086:9d15] type 01 class 0x060=
400 PCIe Root Port
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.5: PCI bridge to [bus 3a]
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.5:   bridge window [mem 0xdc100000=
-0xdc1fffff]
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.5: PME# supported from D0 D3hot D3=
cold
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.5: Intel SPT PCH root port ACS wor=
karound enabled
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.7: [8086:9d17] type 01 class 0x060=
400 PCIe Root Port
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.7: PCI bridge to [bus 3b]
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.7:   bridge window [mem 0xdc000000=
-0xdc0fffff]
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.7: PME# supported from D0 D3hot D3=
cold
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.7: Intel SPT PCH root port ACS wor=
karound enabled
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.0: [8086:9d4e] type 00 class 0x060=
100 conventional PCI endpoint
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058=
000 conventional PCI endpoint
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.2: BAR 0 [mem 0xdc244000-0xdc247ff=
f]
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040=
380 conventional PCI endpoint
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.3: BAR 0 [mem 0xdc240000-0xdc243ff=
f 64bit]
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.3: BAR 4 [mem 0xdc220000-0xdc22fff=
f 64bit]
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.3: PME# supported from D3hot D3col=
d
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0=
500 conventional PCI endpoint
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.4: BAR 0 [mem 0xdc24a000-0xdc24a0f=
f 64bit]
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.4: BAR 4 [io  0xf040-0xf05f]
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.6: [8086:15d8] type 00 class 0x020=
000 conventional PCI endpoint
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.6: BAR 0 [mem 0xdc200000-0xdc21fff=
f]
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.6: PME# supported from D0 D3hot D3=
cold
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
[Vi mai 17 16:58:03 2024] pci 0000:3a:00.0: [8086:24fd] type 00 class 0x028=
000 PCIe Endpoint
[Vi mai 17 16:58:03 2024] pci 0000:3a:00.0: BAR 0 [mem 0xdc100000-0xdc101ff=
f 64bit]
[Vi mai 17 16:58:03 2024] pci 0000:3a:00.0: PME# supported from D0 D3hot D3=
cold
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.5: PCI bridge to [bus 3a]
[Vi mai 17 16:58:03 2024] pci 0000:3b:00.0: [10ec:5229] type 00 class 0xff0=
000 PCIe Endpoint
[Vi mai 17 16:58:03 2024] pci 0000:3b:00.0: BAR 0 [mem 0xdc000000-0xdc000ff=
f]
[Vi mai 17 16:58:03 2024] pci 0000:3b:00.0: supports D1 D2
[Vi mai 17 16:58:03 2024] pci 0000:3b:00.0: PME# supported from D1 D2 D3hot
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.7: PCI bridge to [bus 3b]
[Vi mai 17 16:58:03 2024] ACPI: PCI: Interrupt link LNKA configured for IRQ=
 11
[Vi mai 17 16:58:03 2024] ACPI: PCI: Interrupt link LNKB configured for IRQ=
 10
[Vi mai 17 16:58:03 2024] ACPI: PCI: Interrupt link LNKC configured for IRQ=
 11
[Vi mai 17 16:58:03 2024] ACPI: PCI: Interrupt link LNKD configured for IRQ=
 11
[Vi mai 17 16:58:03 2024] ACPI: PCI: Interrupt link LNKE configured for IRQ=
 11
[Vi mai 17 16:58:03 2024] ACPI: PCI: Interrupt link LNKF configured for IRQ=
 11
[Vi mai 17 16:58:03 2024] ACPI: PCI: Interrupt link LNKG configured for IRQ=
 11
[Vi mai 17 16:58:03 2024] ACPI: PCI: Interrupt link LNKH configured for IRQ=
 11
[Vi mai 17 16:58:03 2024] ACPI: EC: interrupt unblocked
[Vi mai 17 16:58:03 2024] ACPI: EC: event unblocked
[Vi mai 17 16:58:03 2024] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[Vi mai 17 16:58:03 2024] ACPI: EC: GPE=3D0x14
[Vi mai 17 16:58:03 2024] ACPI: \_SB_.PCI0.LPCB.H_EC: Boot DSDT EC initiali=
zation complete
[Vi mai 17 16:58:03 2024] ACPI: \_SB_.PCI0.LPCB.H_EC: EC: Used to handle tr=
ansactions and events
[Vi mai 17 16:58:03 2024] iommu: Default domain type: Translated
[Vi mai 17 16:58:03 2024] iommu: DMA domain TLB invalidation policy: lazy m=
ode
[Vi mai 17 16:58:03 2024] SCSI subsystem initialized
[Vi mai 17 16:58:03 2024] libata version 3.00 loaded.
[Vi mai 17 16:58:03 2024] ACPI: bus type USB registered
[Vi mai 17 16:58:03 2024] usbcore: registered new interface driver usbfs
[Vi mai 17 16:58:03 2024] usbcore: registered new interface driver hub
[Vi mai 17 16:58:03 2024] usbcore: registered new device driver usb
[Vi mai 17 16:58:03 2024] mc: Linux media interface: v0.10
[Vi mai 17 16:58:03 2024] videodev: Linux video capture interface: v2.00
[Vi mai 17 16:58:03 2024] pps_core: LinuxPPS API ver. 1 registered
[Vi mai 17 16:58:03 2024] pps_core: Software ver. 5.3.6 - Copyright 2005-20=
07 Rodolfo Giometti <giometti@linux.it>
[Vi mai 17 16:58:03 2024] PTP clock support registered
[Vi mai 17 16:58:03 2024] EDAC MC: Ver: 3.0.0
[Vi mai 17 16:58:03 2024] efivars: Registered efivars operations
[Vi mai 17 16:58:03 2024] NetLabel: Initializing
[Vi mai 17 16:58:03 2024] NetLabel:  domain hash size =3D 128
[Vi mai 17 16:58:03 2024] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPS=
O
[Vi mai 17 16:58:03 2024] NetLabel:  unlabeled traffic allowed by default
[Vi mai 17 16:58:03 2024] mctp: management component transport protocol cor=
e
[Vi mai 17 16:58:03 2024] NET: Registered PF_MCTP protocol family
[Vi mai 17 16:58:03 2024] PCI: Using ACPI for IRQ routing
[Vi mai 17 16:58:03 2024] PCI: pci_cache_line_size set to 64 bytes
[Vi mai 17 16:58:03 2024] e820: reserve RAM buffer [mem 0x00058000-0x0005ff=
ff]
[Vi mai 17 16:58:03 2024] e820: reserve RAM buffer [mem 0x0009f000-0x0009ff=
ff]
[Vi mai 17 16:58:03 2024] e820: reserve RAM buffer [mem 0x6a3f7018-0x6bffff=
ff]
[Vi mai 17 16:58:03 2024] e820: reserve RAM buffer [mem 0x6a408018-0x6bffff=
ff]
[Vi mai 17 16:58:03 2024] e820: reserve RAM buffer [mem 0x704fd000-0x73ffff=
ff]
[Vi mai 17 16:58:03 2024] e820: reserve RAM buffer [mem 0x75c90000-0x77ffff=
ff]
[Vi mai 17 16:58:03 2024] e820: reserve RAM buffer [mem 0x7a10e000-0x7bffff=
ff]
[Vi mai 17 16:58:03 2024] e820: reserve RAM buffer [mem 0x7afff000-0x7bffff=
ff]
[Vi mai 17 16:58:03 2024] e820: reserve RAM buffer [mem 0x87f000000-0x87fff=
ffff]
[Vi mai 17 16:58:03 2024] pci 0000:00:02.0: vgaarb: setting as boot VGA dev=
ice
[Vi mai 17 16:58:03 2024] pci 0000:00:02.0: vgaarb: bridge control possible
[Vi mai 17 16:58:03 2024] pci 0000:00:02.0: vgaarb: VGA device added: decod=
es=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[Vi mai 17 16:58:03 2024] vgaarb: loaded
[Vi mai 17 16:58:03 2024] clocksource: Switched to clocksource tsc-early
[Vi mai 17 16:58:03 2024] VFS: Disk quotas dquot_6.6.0
[Vi mai 17 16:58:03 2024] VFS: Dquot-cache hash table entries: 512 (order 0=
, 4096 bytes)
[Vi mai 17 16:58:03 2024] AppArmor: AppArmor Filesystem Enabled
[Vi mai 17 16:58:03 2024] pnp: PnP ACPI init
[Vi mai 17 16:58:03 2024] system 00:00: [mem 0x40000000-0x403fffff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] system 00:01: [io  0x0a00-0x0a1f] has been reserv=
ed
[Vi mai 17 16:58:03 2024] system 00:01: [io  0x0a20-0x0a2f] has been reserv=
ed
[Vi mai 17 16:58:03 2024] system 00:01: [io  0x0a30-0x0a3f] has been reserv=
ed
[Vi mai 17 16:58:03 2024] system 00:01: [io  0x0a40-0x0a4f] has been reserv=
ed
[Vi mai 17 16:58:03 2024] system 00:01: [io  0x0a50-0x0a5f] has been reserv=
ed
[Vi mai 17 16:58:03 2024] system 00:01: [io  0x0a60-0x0a6f] has been reserv=
ed
[Vi mai 17 16:58:03 2024] system 00:02: [io  0x0680-0x069f] has been reserv=
ed
[Vi mai 17 16:58:03 2024] system 00:02: [io  0xffff] has been reserved
[Vi mai 17 16:58:03 2024] system 00:02: [io  0xffff] has been reserved
[Vi mai 17 16:58:03 2024] system 00:02: [io  0xffff] has been reserved
[Vi mai 17 16:58:03 2024] system 00:02: [io  0x1800-0x18fe] has been reserv=
ed
[Vi mai 17 16:58:03 2024] system 00:02: [io  0x164e-0x164f] has been reserv=
ed
[Vi mai 17 16:58:03 2024] system 00:04: [io  0x1854-0x1857] has been reserv=
ed
[Vi mai 17 16:58:03 2024] system 00:05: [mem 0xfed10000-0xfed17fff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] system 00:05: [mem 0xfed18000-0xfed18fff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] system 00:05: [mem 0xfed19000-0xfed19fff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] system 00:05: [mem 0xe0000000-0xefffffff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] system 00:05: [mem 0xfed20000-0xfed3ffff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] system 00:05: [mem 0xfed90000-0xfed93fff] could n=
ot be reserved
[Vi mai 17 16:58:03 2024] system 00:05: [mem 0xfed45000-0xfed8ffff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] system 00:05: [mem 0xff000000-0xffffffff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] system 00:05: [mem 0xfee00000-0xfeefffff] could n=
ot be reserved
[Vi mai 17 16:58:03 2024] system 00:05: [mem 0xdffe0000-0xdfffffff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] system 00:06: [mem 0xfd000000-0xfdabffff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] system 00:06: [mem 0xfdad0000-0xfdadffff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] system 00:06: [mem 0xfdb00000-0xfdffffff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] system 00:06: [mem 0xfe000000-0xfe01ffff] could n=
ot be reserved
[Vi mai 17 16:58:03 2024] system 00:06: [mem 0xfe036000-0xfe03bfff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] system 00:06: [mem 0xfe03d000-0xfe3fffff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] system 00:06: [mem 0xfe410000-0xfe7fffff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] system 00:07: [io  0xff00-0xfffe] has been reserv=
ed
[Vi mai 17 16:58:03 2024] system 00:08: [mem 0xfe029000-0xfe029fff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] system 00:08: [mem 0xfe028000-0xfe028fff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] system 00:08: [mem 0xfdaf0000-0xfdafffff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] system 00:08: [mem 0xfdae0000-0xfdaeffff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] system 00:08: [mem 0xfdac0000-0xfdacffff] has bee=
n reserved
[Vi mai 17 16:58:03 2024] pnp: PnP ACPI: found 9 devices
[Vi mai 17 16:58:03 2024] clocksource: acpi_pm: freq: 3579545 Hz, mask: 0xf=
fffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.1: [8086:9d20] type 00 class 0x058=
000 conventional PCI endpoint
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdfffff=
f 64bit]
[Vi mai 17 16:58:03 2024] NET: Registered PF_INET protocol family
[Vi mai 17 16:58:03 2024] IP idents hash table entries: 262144 (order: 9, 2=
097152 bytes, linear)
[Vi mai 17 16:58:03 2024] tcp_listen_portaddr_hash hash table entries: 1638=
4 (order: 6, 262144 bytes, linear)
[Vi mai 17 16:58:03 2024] Table-perturb hash table entries: 65536 (order: 6=
, 262144 bytes, linear)
[Vi mai 17 16:58:03 2024] TCP established hash table entries: 262144 (order=
: 9, 2097152 bytes, linear)
[Vi mai 17 16:58:03 2024] TCP bind hash table entries: 65536 (order: 9, 209=
7152 bytes, linear)
[Vi mai 17 16:58:03 2024] TCP: Hash tables configured (established 262144 b=
ind 65536)
[Vi mai 17 16:58:03 2024] MPTCP token hash table entries: 32768 (order: 7, =
786432 bytes, linear)
[Vi mai 17 16:58:03 2024] UDP hash table entries: 16384 (order: 7, 524288 b=
ytes, linear)
[Vi mai 17 16:58:03 2024] UDP-Lite hash table entries: 16384 (order: 7, 524=
288 bytes, linear)
[Vi mai 17 16:58:03 2024] NET: Registered PF_UNIX/PF_LOCAL protocol family
[Vi mai 17 16:58:03 2024] NET: Registered PF_XDP protocol family
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.0: bridge window [io  0x1000-0x0ff=
f] to [bus 01-39] add_size 1000
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.0: bridge window [io  0x2000-0x2ff=
f]: assigned
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.0: PCI bridge to [bus 01-39]
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2=
fff]
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.0:   bridge window [mem 0xc4000000=
-0xda0fffff]
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.0:   bridge window [mem 0xa0000000=
-0xc1ffffff 64bit pref]
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.5: PCI bridge to [bus 3a]
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.5:   bridge window [mem 0xdc100000=
-0xdc1fffff]
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.7: PCI bridge to [bus 3b]
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.7:   bridge window [mem 0xdc000000=
-0xdc0fffff]
[Vi mai 17 16:58:03 2024] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 wi=
ndow]
[Vi mai 17 16:58:03 2024] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff wi=
ndow]
[Vi mai 17 16:58:03 2024] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000=
bffff window]
[Vi mai 17 16:58:03 2024] pci_bus 0000:00: resource 7 [mem 0x80000000-0xdff=
fffff window]
[Vi mai 17 16:58:03 2024] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7=
fffff window]
[Vi mai 17 16:58:03 2024] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[Vi mai 17 16:58:03 2024] pci_bus 0000:01: resource 1 [mem 0xc4000000-0xda0=
fffff]
[Vi mai 17 16:58:03 2024] pci_bus 0000:01: resource 2 [mem 0xa0000000-0xc1f=
fffff 64bit pref]
[Vi mai 17 16:58:03 2024] pci_bus 0000:3a: resource 1 [mem 0xdc100000-0xdc1=
fffff]
[Vi mai 17 16:58:03 2024] pci_bus 0000:3b: resource 1 [mem 0xdc000000-0xdc0=
fffff]
[Vi mai 17 16:58:03 2024] PCI: CLS 64 bytes, default 64
[Vi mai 17 16:58:03 2024] DMAR: No ATSR found
[Vi mai 17 16:58:03 2024] DMAR: No SATC found
[Vi mai 17 16:58:03 2024] DMAR: IOMMU feature fl1gp_support inconsistent
[Vi mai 17 16:58:03 2024] DMAR: IOMMU feature pgsel_inv inconsistent
[Vi mai 17 16:58:03 2024] DMAR: IOMMU feature nwfs inconsistent
[Vi mai 17 16:58:03 2024] DMAR: IOMMU feature pasid inconsistent
[Vi mai 17 16:58:03 2024] DMAR: IOMMU feature eafs inconsistent
[Vi mai 17 16:58:03 2024] DMAR: IOMMU feature prs inconsistent
[Vi mai 17 16:58:03 2024] DMAR: IOMMU feature nest inconsistent
[Vi mai 17 16:58:03 2024] DMAR: IOMMU feature mts inconsistent
[Vi mai 17 16:58:03 2024] DMAR: IOMMU feature sc_support inconsistent
[Vi mai 17 16:58:03 2024] DMAR: IOMMU feature dev_iotlb_support inconsisten=
t
[Vi mai 17 16:58:03 2024] DMAR: dmar0: Using Queued invalidation
[Vi mai 17 16:58:03 2024] DMAR: dmar1: Using Queued invalidation
[Vi mai 17 16:58:03 2024] Trying to unpack rootfs image as initramfs...
[Vi mai 17 16:58:03 2024] pci 0000:00:02.0: Adding to iommu group 0
[Vi mai 17 16:58:03 2024] pci 0000:00:00.0: Adding to iommu group 1
[Vi mai 17 16:58:03 2024] pci 0000:00:08.0: Adding to iommu group 2
[Vi mai 17 16:58:03 2024] pci 0000:00:14.0: Adding to iommu group 3
[Vi mai 17 16:58:03 2024] pci 0000:00:14.2: Adding to iommu group 3
[Vi mai 17 16:58:03 2024] pci 0000:00:16.0: Adding to iommu group 4
[Vi mai 17 16:58:03 2024] pci 0000:00:17.0: Adding to iommu group 5
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.0: Adding to iommu group 6
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.5: Adding to iommu group 7
[Vi mai 17 16:58:03 2024] pci 0000:00:1c.7: Adding to iommu group 8
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.0: Adding to iommu group 9
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.2: Adding to iommu group 9
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.3: Adding to iommu group 9
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.4: Adding to iommu group 9
[Vi mai 17 16:58:03 2024] pci 0000:00:1f.6: Adding to iommu group 9
[Vi mai 17 16:58:03 2024] pci 0000:3a:00.0: Adding to iommu group 10
[Vi mai 17 16:58:03 2024] pci 0000:3b:00.0: Adding to iommu group 11
[Vi mai 17 16:58:03 2024] DMAR: Intel(R) Virtualization Technology for Dire=
cted I/O
[Vi mai 17 16:58:03 2024] PCI-DMA: Using software bounce buffering for IO (=
SWIOTLB)
[Vi mai 17 16:58:03 2024] software IO TLB: mapped [mem 0x0000000071c90000-0=
x0000000075c90000] (64MB)
[Vi mai 17 16:58:03 2024] IRQ pipeline: high-priority EVL stage added.
[Vi mai 17 16:58:03 2024] CPU3: proxy tick device registered (437.48MHz)
[Vi mai 17 16:58:03 2024] CPU1: proxy tick device registered (437.48MHz)
[Vi mai 17 16:58:03 2024] CPU0: proxy tick device registered (437.48MHz)
[Vi mai 17 16:58:03 2024] CPU2: proxy tick device registered (437.48MHz)
[Vi mai 17 16:58:03 2024] EVL: core started=20
[Vi mai 17 16:58:03 2024] Initialise system trusted keyrings
[Vi mai 17 16:58:03 2024] Key type blacklist registered
[Vi mai 17 16:58:03 2024] workingset: timestamp_bits=3D36 max_order=3D23 bu=
cket_order=3D0
[Vi mai 17 16:58:03 2024] zbud: loaded
[Vi mai 17 16:58:03 2024] squashfs: version 4.0 (2009/01/31) Phillip Loughe=
r
[Vi mai 17 16:58:03 2024] fuse: init (API version 7.40)
[Vi mai 17 16:58:03 2024] integrity: Platform Keyring initialized
[Vi mai 17 16:58:03 2024] integrity: Machine keyring initialized
[Vi mai 17 16:58:03 2024] Key type asymmetric registered
[Vi mai 17 16:58:03 2024] Asymmetric key parser 'x509' registered
[Vi mai 17 16:58:03 2024] Block layer SCSI generic (bsg) driver version 0.4=
 loaded (major 235)
[Vi mai 17 16:58:03 2024] io scheduler mq-deadline registered
[Vi mai 17 16:58:03 2024] shpchp: Standard Hot Plug PCI Controller Driver v=
ersion: 0.4
[Vi mai 17 16:58:03 2024] input: Sleep Button as /devices/LNXSYSTM:00/LNXSY=
BUS:00/PNP0C0E:00/input/input0
[Vi mai 17 16:58:03 2024] ACPI: button: Sleep Button [SLPB]
[Vi mai 17 16:58:03 2024] input: Power Button as /devices/LNXSYSTM:00/LNXSY=
BUS:00/PNP0C0C:00/input/input1
[Vi mai 17 16:58:03 2024] ACPI: button: Power Button [PWRB]
[Vi mai 17 16:58:03 2024] input: Power Button as /devices/LNXSYSTM:00/LNXPW=
RBN:00/input/input2
[Vi mai 17 16:58:03 2024] ACPI: button: Power Button [PWRF]
[Vi mai 17 16:58:03 2024] ACPI: thermal: [Firmware Bug]: No valid trip poin=
ts!
[Vi mai 17 16:58:03 2024] thermal LNXTHERM:00: registered as thermal_zone0
[Vi mai 17 16:58:03 2024] ACPI: thermal: Thermal Zone [TZ0] (-263 C)
[Vi mai 17 16:58:03 2024] Serial: 8250/16550 driver, 32 ports, IRQ sharing =
enabled
[Vi mai 17 16:58:03 2024] hpet_acpi_add: no address or irqs in _CRS
[Vi mai 17 16:58:03 2024] Linux agpgart interface v0.103
[Vi mai 17 16:58:03 2024] ACPI: bus type drm_connector registered
[Vi mai 17 16:58:03 2024] loop: module loaded
[Vi mai 17 16:58:03 2024] tun: Universal TUN/TAP device driver, 1.6
[Vi mai 17 16:58:03 2024] PPP generic driver version 2.4.2
[Vi mai 17 16:58:03 2024] i8042: PNP: No PS/2 controller found.
[Vi mai 17 16:58:03 2024] mousedev: PS/2 mouse device common for all mice
[Vi mai 17 16:58:03 2024] rtc_cmos 00:03: RTC can wake from S4
[Vi mai 17 16:58:03 2024] rtc_cmos 00:03: registered as rtc0
[Vi mai 17 16:58:03 2024] rtc_cmos 00:03: setting system clock to 2024-05-1=
7T13:58:04 UTC (1715954284)
[Vi mai 17 16:58:03 2024] rtc_cmos 00:03: alarms up to one month, y3k, 242 =
bytes nvram
[Vi mai 17 16:58:03 2024] i2c_dev: i2c /dev entries driver
[Vi mai 17 16:58:03 2024] device-mapper: uevent: version 1.0.3
[Vi mai 17 16:58:03 2024] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) i=
nitialised: dm-devel@lists.linux.dev
[Vi mai 17 16:58:03 2024] intel_pstate: Intel P-state driver initializing
[Vi mai 17 16:58:03 2024] intel_pstate: HWP enabled
[Vi mai 17 16:58:03 2024] ledtrig-cpu: registered to indicate activity on C=
PUs
[Vi mai 17 16:58:03 2024] [drm] Initialized simpledrm 1.0.0 20200625 for si=
mple-framebuffer.0 on minor 0
[Vi mai 17 16:58:03 2024] Console: switching to colour frame buffer device =
160x45
[Vi mai 17 16:58:03 2024] simple-framebuffer simple-framebuffer.0: [drm] fb=
0: simpledrmdrmfb frame buffer device
[Vi mai 17 16:58:03 2024] drop_monitor: Initializing network drop monitor s=
ervice
[Vi mai 17 16:58:03 2024] NET: Registered PF_INET6 protocol family
[Vi mai 17 16:58:03 2024] Freeing initrd memory: 62820K
[Vi mai 17 16:58:03 2024] Segment Routing with IPv6
[Vi mai 17 16:58:03 2024] In-situ OAM (IOAM) with IPv6
[Vi mai 17 16:58:03 2024] NET: Registered PF_PACKET protocol family
[Vi mai 17 16:58:03 2024] Bridge firewalling registered
[Vi mai 17 16:58:03 2024] Key type dns_resolver registered
[Vi mai 17 16:58:03 2024] ENERGY_PERF_BIAS: Set to 'normal', was 'performan=
ce'
[Vi mai 17 16:58:03 2024] microcode: Current revision: 0x000000f4
[Vi mai 17 16:58:03 2024] microcode: Updated early from: 0x000000ca
[Vi mai 17 16:58:03 2024] IPI shorthand broadcast: enabled
[Vi mai 17 16:58:03 2024] sched_clock: Marking stable (717025116, 5860489)-=
>(759349186, -36463581)
[Vi mai 17 16:58:03 2024] Timer migration: 1 hierarchy levels; 8 children p=
er group; 1 crossnode level
[Vi mai 17 16:58:03 2024] registered taskstats version 1
[Vi mai 17 16:58:03 2024] Loading compiled-in X.509 certificates
[Vi mai 17 16:58:03 2024] Loaded X.509 cert 'Build time autogenerated kerne=
l key: 881fb317bdb8ee782953e710424b9aea3a831e75'
[Vi mai 17 16:58:03 2024] Key type .fscrypt registered
[Vi mai 17 16:58:03 2024] Key type fscrypt-provisioning registered
[Vi mai 17 16:58:03 2024] Key type trusted registered
[Vi mai 17 16:58:03 2024] Key type encrypted registered
[Vi mai 17 16:58:03 2024] AppArmor: AppArmor sha256 policy hashing enabled
[Vi mai 17 16:58:03 2024] integrity: Loading X.509 certificate: UEFI:db
[Vi mai 17 16:58:03 2024] integrity: Loaded X.509 cert 'Microsoft Corporati=
on UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[Vi mai 17 16:58:03 2024] integrity: Loading X.509 certificate: UEFI:db
[Vi mai 17 16:58:03 2024] integrity: Loaded X.509 cert 'Microsoft Windows P=
roduction PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[Vi mai 17 16:58:03 2024] integrity: Loading X.509 certificate: UEFI:db
[Vi mai 17 16:58:03 2024] integrity: Loaded X.509 cert 'CISD FW Update - Ce=
rtificate: 068268b4a41c93854262d49b4f788f13'
[Vi mai 17 16:58:03 2024] blacklist: Duplicate blacklisted hash bin:47ff1b6=
3b140b6fc04ed79131331e651da5b2e2f170f5daef4153dc2fbc532b1
[Vi mai 17 16:58:03 2024] blacklist: Duplicate blacklisted hash bin:992d359=
aa7a5f789d268b94c11b9485a6b1ce64362b0edb4441ccc187c39647b
[Vi mai 17 16:58:03 2024] blacklist: Duplicate blacklisted hash bin:c452ab8=
46073df5ace25cca64d6b7a09d906308a1a65eb5240e3c4ebcaa9cc0c
[Vi mai 17 16:58:03 2024] blacklist: Duplicate blacklisted hash bin:e051b78=
8ecbaeda53046c70e6af6058f95222c046157b8c4c1b9c2cfc65f46e5
[Vi mai 17 16:58:03 2024] Loading compiled-in module X.509 certificates
[Vi mai 17 16:58:03 2024] Loaded X.509 cert 'Build time autogenerated kerne=
l key: 881fb317bdb8ee782953e710424b9aea3a831e75'
[Vi mai 17 16:58:03 2024] ima: Allocated hash algorithm: sha256
[Vi mai 17 16:58:03 2024] ima: No architecture policies found
[Vi mai 17 16:58:03 2024] evm: Initialising EVM extended attributes:
[Vi mai 17 16:58:03 2024] evm: security.selinux
[Vi mai 17 16:58:03 2024] evm: security.SMACK64
[Vi mai 17 16:58:03 2024] evm: security.SMACK64EXEC
[Vi mai 17 16:58:03 2024] evm: security.SMACK64TRANSMUTE
[Vi mai 17 16:58:03 2024] evm: security.SMACK64MMAP
[Vi mai 17 16:58:03 2024] evm: security.apparmor
[Vi mai 17 16:58:03 2024] evm: security.ima
[Vi mai 17 16:58:03 2024] evm: security.capability
[Vi mai 17 16:58:03 2024] evm: HMAC attrs: 0x1
[Vi mai 17 16:58:03 2024] PM:   Magic number: 8:93:989
[Vi mai 17 16:58:03 2024] machinecheck machinecheck2: hash matches
[Vi mai 17 16:58:03 2024] memory memory32: hash matches
[Vi mai 17 16:58:03 2024] hid_bpf: error while preloading HID BPF dispatche=
r: -22
[Vi mai 17 16:58:03 2024] RAS: Correctable Errors collector initialized.
[Vi mai 17 16:58:03 2024] clk: Disabling unused clocks
[Vi mai 17 16:58:03 2024] PM: genpd: Disabling unused power domains
[Vi mai 17 16:58:03 2024] Freeing unused decrypted memory: 2036K
[Vi mai 17 16:58:03 2024] Freeing unused kernel image (initmem) memory: 495=
2K
[Vi mai 17 16:58:03 2024] Write protecting the kernel read-only data: 28672=
k
[Vi mai 17 16:58:03 2024] Freeing unused kernel image (rodata/data gap) mem=
ory: 100K
[Vi mai 17 16:58:03 2024] x86/mm: Checked W+X mappings: passed, no W+X page=
s found.
[Vi mai 17 16:58:03 2024] x86/mm: Checking user space page tables
[Vi mai 17 16:58:03 2024] x86/mm: Checked W+X mappings: passed, no W+X page=
s found.
[Vi mai 17 16:58:03 2024] Run /init as init process
[Vi mai 17 16:58:03 2024]   with arguments:
[Vi mai 17 16:58:03 2024]     /init
[Vi mai 17 16:58:03 2024]     splash
[Vi mai 17 16:58:03 2024]   with environment:
[Vi mai 17 16:58:03 2024]     HOME=3D/
[Vi mai 17 16:58:03 2024]     TERM=3Dlinux
[Vi mai 17 16:58:03 2024]     BOOT_IMAGE=3D/boot/vmlinuz-6.9.0-x64v1-lowlat=
ency1
[Vi mai 17 16:58:04 2024] ahci 0000:00:17.0: version 3.0
[Vi mai 17 16:58:04 2024] e1000e: Intel(R) PRO/1000 Network Driver
[Vi mai 17 16:58:04 2024] e1000e: Copyright(c) 1999 - 2015 Intel Corporatio=
n.
[Vi mai 17 16:58:04 2024] e1000e 0000:00:1f.6: Interrupt Throttling Rate (i=
nts/sec) set to dynamic conservative mode
[Vi mai 17 16:58:04 2024] rtsx_pci 0000:3b:00.0: enabling device (0000 -> 0=
002)
[Vi mai 17 16:58:04 2024] ahci 0000:00:17.0: AHCI vers 0001.0301, 32 comman=
d slots, 6 Gbps, SATA mode
[Vi mai 17 16:58:04 2024] ahci 0000:00:17.0: 1/1 ports implemented (port ma=
sk 0x1)
[Vi mai 17 16:58:04 2024] ahci 0000:00:17.0: flags: 64bit ncq pm led clo on=
ly pio slum part deso sadm sds apst=20
[Vi mai 17 16:58:04 2024] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[Vi mai 17 16:58:04 2024] i801_smbus 0000:00:1f.4: SMBus using PCI interrup=
t
[Vi mai 17 16:58:04 2024] xhci_hcd 0000:00:14.0: xHCI Host Controller
[Vi mai 17 16:58:04 2024] xhci_hcd 0000:00:14.0: new USB bus registered, as=
signed bus number 1
[Vi mai 17 16:58:04 2024] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci =
version 0x100 quirks 0x0000000081109810
[Vi mai 17 16:58:04 2024] i2c i2c-0: Successfully instantiated SPD at 0x50
[Vi mai 17 16:58:04 2024] scsi host0: ahci
[Vi mai 17 16:58:04 2024] ata1: SATA max UDMA/133 abar m2048@0xdc24b000 por=
t 0xdc24b100 irq 127 lpm-pol 3
[Vi mai 17 16:58:04 2024] xhci_hcd 0000:00:14.0: xHCI Host Controller
[Vi mai 17 16:58:04 2024] xhci_hcd 0000:00:14.0: new USB bus registered, as=
signed bus number 2
[Vi mai 17 16:58:04 2024] xhci_hcd 0000:00:14.0: Host supports USB 3.0 Supe=
rSpeed
[Vi mai 17 16:58:04 2024] usb usb1: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.09
[Vi mai 17 16:58:04 2024] usb usb1: New USB device strings: Mfr=3D3, Produc=
t=3D2, SerialNumber=3D1
[Vi mai 17 16:58:04 2024] usb usb1: Product: xHCI Host Controller
[Vi mai 17 16:58:04 2024] usb usb1: Manufacturer: Linux 6.9.0-x64v1-lowlate=
ncy1 xhci-hcd
[Vi mai 17 16:58:04 2024] usb usb1: SerialNumber: 0000:00:14.0
[Vi mai 17 16:58:04 2024] hub 1-0:1.0: USB hub found
[Vi mai 17 16:58:04 2024] hub 1-0:1.0: 12 ports detected
[Vi mai 17 16:58:04 2024] usb usb2: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.09
[Vi mai 17 16:58:04 2024] usb usb2: New USB device strings: Mfr=3D3, Produc=
t=3D2, SerialNumber=3D1
[Vi mai 17 16:58:04 2024] usb usb2: Product: xHCI Host Controller
[Vi mai 17 16:58:04 2024] usb usb2: Manufacturer: Linux 6.9.0-x64v1-lowlate=
ncy1 xhci-hcd
[Vi mai 17 16:58:04 2024] usb usb2: SerialNumber: 0000:00:14.0
[Vi mai 17 16:58:04 2024] hub 2-0:1.0: USB hub found
[Vi mai 17 16:58:04 2024] hub 2-0:1.0: 6 ports detected
[Vi mai 17 16:58:04 2024] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized):=
 registered PHC clock
[Vi mai 17 16:58:04 2024] usb 1-8: new full-speed USB device number 2 using=
 xhci_hcd
[Vi mai 17 16:58:04 2024] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Wi=
dth x1) 1c:69:7a:08:35:94
[Vi mai 17 16:58:04 2024] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Netwo=
rk Connection
[Vi mai 17 16:58:04 2024] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA N=
o: FFFFFF-0FF
[Vi mai 17 16:58:04 2024] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl=
 300)
[Vi mai 17 16:58:04 2024] ata1.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY F=
REEZE LOCK) filtered out
[Vi mai 17 16:58:04 2024] ata1.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CON=
FIGURATION OVERLAY) filtered out
[Vi mai 17 16:58:04 2024] ata1.00: supports DRM functions and may not be fu=
lly accessible
[Vi mai 17 16:58:04 2024] ata1.00: ATA-10: CT500MX500SSD1, M3CR023, max UDM=
A/133
[Vi mai 17 16:58:04 2024] ata1.00: 976773168 sectors, multi 1: LBA48 NCQ (d=
epth 32), AA
[Vi mai 17 16:58:04 2024] ata1.00: Features: Trust Dev-Sleep
[Vi mai 17 16:58:04 2024] ata1.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY F=
REEZE LOCK) filtered out
[Vi mai 17 16:58:04 2024] ata1.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CON=
FIGURATION OVERLAY) filtered out
[Vi mai 17 16:58:04 2024] ata1.00: supports DRM functions and may not be fu=
lly accessible
[Vi mai 17 16:58:04 2024] ata1.00: configured for UDMA/133
[Vi mai 17 16:58:04 2024] ahci 0000:00:17.0: port does not support device s=
leep
[Vi mai 17 16:58:04 2024] scsi 0:0:0:0: Direct-Access     ATA      CT500MX5=
00SSD1   023  PQ: 0 ANSI: 5
[Vi mai 17 16:58:04 2024] sd 0:0:0:0: Attached scsi generic sg0 type 0
[Vi mai 17 16:58:04 2024] sd 0:0:0:0: [sda] 976773168 512-byte logical bloc=
ks: (500 GB/466 GiB)
[Vi mai 17 16:58:04 2024] sd 0:0:0:0: [sda] 4096-byte physical blocks
[Vi mai 17 16:58:04 2024] sd 0:0:0:0: [sda] Write Protect is off
[Vi mai 17 16:58:04 2024] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[Vi mai 17 16:58:04 2024] sd 0:0:0:0: [sda] Write cache: enabled, read cach=
e: enabled, doesn't support DPO or FUA
[Vi mai 17 16:58:04 2024] sd 0:0:0:0: [sda] Preferred minimum I/O size 4096=
 bytes
[Vi mai 17 16:58:04 2024]  sda: sda1 sda2 sda3
[Vi mai 17 16:58:04 2024] sd 0:0:0:0: [sda] supports TCG Opal
[Vi mai 17 16:58:04 2024] sd 0:0:0:0: [sda] Attached SCSI disk
[Vi mai 17 16:58:04 2024] e1000e 0000:00:1f.6 eno1: renamed from eth0
[Vi mai 17 16:58:04 2024] tsc: Refined TSC clocksource calibration: 3503.99=
9 MHz
[Vi mai 17 16:58:04 2024] clocksource: tsc: freq: 3503999000 Hz, mask: 0xff=
ffffffffffffff max_cycles: 0x3282124c47b, max_idle_ns: 440795239402 ns
[Vi mai 17 16:58:04 2024] clocksource: Switched to clocksource tsc
[Vi mai 17 16:58:04 2024] usb 1-8: New USB device found, idVendor=3D8087, i=
dProduct=3D0a2b, bcdDevice=3D 0.10
[Vi mai 17 16:58:04 2024] usb 1-8: New USB device strings: Mfr=3D0, Product=
=3D0, SerialNumber=3D0
[Vi mai 17 16:58:04 2024] EXT4-fs (sda3): mounted filesystem 6202d57a-239b-=
4b0b-ba48-ee04a7d2b1c1 ro with ordered data mode. Quota mode: none.
[Vi mai 17 16:58:04 2024] systemd[1]: Inserted module 'autofs4'
[Vi mai 17 16:58:04 2024] systemd[1]: systemd 249.11-0ubuntu3.12 running in=
 system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +=
GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +=
LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY -P11KIT -QRENCODE +BZIP2 +LZ4 +XZ=
 +ZLIB +ZSTD -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=3Dunified)
[Vi mai 17 16:58:04 2024] systemd[1]: Detected architecture x86-64.
[Vi mai 17 16:58:04 2024] systemd[1]: Hostname set to <gliaf1n031>.
[Vi mai 17 16:58:04 2024] block sda: the capability attribute has been depr=
ecated.
[Vi mai 17 16:58:04 2024] systemd[1]: Queued start job for default target G=
raphical Interface.
[Vi mai 17 16:58:04 2024] systemd[1]: Created slice Slice /system/modprobe.
[Vi mai 17 16:58:04 2024] systemd[1]: Created slice Slice /system/systemd-f=
sck.
[Vi mai 17 16:58:04 2024] systemd[1]: Created slice User and Session Slice.
[Vi mai 17 16:58:04 2024] systemd[1]: Started Forward Password Requests to =
Wall Directory Watch.
[Vi mai 17 16:58:04 2024] systemd[1]: Set up automount Arbitrary Executable=
 File Formats File System Automount Point.
[Vi mai 17 16:58:04 2024] systemd[1]: Reached target User and Group Name Lo=
okups.
[Vi mai 17 16:58:04 2024] systemd[1]: Reached target Remote File Systems.
[Vi mai 17 16:58:04 2024] systemd[1]: Reached target Slice Units.
[Vi mai 17 16:58:04 2024] systemd[1]: Reached target Mounting snaps.
[Vi mai 17 16:58:04 2024] systemd[1]: Reached target Local Verity Protected=
 Volumes.
[Vi mai 17 16:58:04 2024] systemd[1]: Listening on Syslog Socket.
[Vi mai 17 16:58:04 2024] systemd[1]: Listening on fsck to fsckd communicat=
ion Socket.
[Vi mai 17 16:58:04 2024] systemd[1]: Listening on initctl Compatibility Na=
med Pipe.
[Vi mai 17 16:58:04 2024] systemd[1]: Condition check resulted in Journal A=
udit Socket being skipped.
[Vi mai 17 16:58:04 2024] systemd[1]: Listening on Journal Socket (/dev/log=
).
[Vi mai 17 16:58:04 2024] systemd[1]: Listening on Journal Socket.
[Vi mai 17 16:58:04 2024] systemd[1]: Listening on udev Control Socket.
[Vi mai 17 16:58:04 2024] systemd[1]: Listening on udev Kernel Socket.
[Vi mai 17 16:58:04 2024] systemd[1]: Mounting Huge Pages File System...
[Vi mai 17 16:58:04 2024] systemd[1]: Mounting POSIX Message Queue File Sys=
tem...
[Vi mai 17 16:58:04 2024] systemd[1]: Mounting Kernel Debug File System...
[Vi mai 17 16:58:04 2024] systemd[1]: Mounting Kernel Trace File System...
[Vi mai 17 16:58:04 2024] systemd[1]: Starting Journal Service...
[Vi mai 17 16:58:04 2024] systemd[1]: Starting Set the console keyboard lay=
out...
[Vi mai 17 16:58:04 2024] systemd[1]: Starting Create List of Static Device=
 Nodes...
[Vi mai 17 16:58:04 2024] systemd[1]: Starting Load Kernel Module configfs.=
..
[Vi mai 17 16:58:04 2024] systemd[1]: Starting Load Kernel Module drm...
[Vi mai 17 16:58:04 2024] systemd[1]: Starting Load Kernel Module efi_pstor=
e...
[Vi mai 17 16:58:04 2024] systemd[1]: Starting Load Kernel Module fuse...
[Vi mai 17 16:58:04 2024] systemd[1]: Condition check resulted in File Syst=
em Check on Root Device being skipped.
[Vi mai 17 16:58:04 2024] systemd[1]: Starting Load Kernel Modules...
[Vi mai 17 16:58:04 2024] systemd[1]: Starting Remount Root and Kernel File=
 Systems...
[Vi mai 17 16:58:04 2024] systemd[1]: Starting Coldplug All udev Devices...
[Vi mai 17 16:58:04 2024] systemd[1]: Mounted Huge Pages File System.
[Vi mai 17 16:58:04 2024] systemd[1]: Mounted POSIX Message Queue File Syst=
em.
[Vi mai 17 16:58:04 2024] systemd[1]: Mounted Kernel Debug File System.
[Vi mai 17 16:58:04 2024] systemd[1]: Mounted Kernel Trace File System.
[Vi mai 17 16:58:04 2024] pstore: Using crash dump compression: deflate
[Vi mai 17 16:58:04 2024] systemd[1]: Finished Create List of Static Device=
 Nodes.
[Vi mai 17 16:58:04 2024] systemd[1]: modprobe@configfs.service: Deactivate=
d successfully.
[Vi mai 17 16:58:05 2024] systemd[1]: Finished Load Kernel Module configfs.
[Vi mai 17 16:58:05 2024] systemd[1]: modprobe@drm.service: Deactivated suc=
cessfully.
[Vi mai 17 16:58:05 2024] systemd[1]: Finished Load Kernel Module drm.
[Vi mai 17 16:58:05 2024] systemd[1]: modprobe@fuse.service: Deactivated su=
ccessfully.
[Vi mai 17 16:58:05 2024] systemd[1]: Finished Load Kernel Module fuse.
[Vi mai 17 16:58:05 2024] pstore: Registered efi_pstore as persistent store=
 backend
[Vi mai 17 16:58:05 2024] lp: driver loaded but no devices found
[Vi mai 17 16:58:05 2024] ppdev: user-space parallel port driver
[Vi mai 17 16:58:05 2024] EXT4-fs (sda3): re-mounted 6202d57a-239b-4b0b-ba4=
8-ee04a7d2b1c1 r/w. Quota mode: none.
[Vi mai 17 16:58:05 2024] systemd[1]: Mounting FUSE Control File System...
[Vi mai 17 16:58:05 2024] systemd[1]: Mounting Kernel Configuration File Sy=
stem...
[Vi mai 17 16:58:05 2024] systemd[1]: Started Journal Service.
[Vi mai 17 16:58:05 2024] Adding 2097148k swap on /swapfile.  Priority:-2 e=
xtents:17 across:485892096k SS
[Vi mai 17 16:58:05 2024] systemd-journald[241]: Received client request to=
 flush runtime journal.
[Vi mai 17 16:58:05 2024] loop0: detected capacity change from 0 to 8
[Vi mai 17 16:58:05 2024] loop1: detected capacity change from 0 to 151992
[Vi mai 17 16:58:05 2024] loop2: detected capacity change from 0 to 152040
[Vi mai 17 16:58:05 2024] loop3: detected capacity change from 0 to 552192
[Vi mai 17 16:58:05 2024] loop4: detected capacity change from 0 to 554480
[Vi mai 17 16:58:05 2024] loop5: detected capacity change from 0 to 1017816
[Vi mai 17 16:58:05 2024] loop6: detected capacity change from 0 to 1034424
[Vi mai 17 16:58:05 2024] loop7: detected capacity change from 0 to 187776
[Vi mai 17 16:58:05 2024] loop9: detected capacity change from 0 to 25240
[Vi mai 17 16:58:05 2024] loop8: detected capacity change from 0 to 26472
[Vi mai 17 16:58:05 2024] loop10: detected capacity change from 0 to 82800
[Vi mai 17 16:58:05 2024] loop11: detected capacity change from 0 to 79328
[Vi mai 17 16:58:05 2024] loop12: detected capacity change from 0 to 952
[Vi mai 17 16:58:05 2024] loop13: detected capacity change from 0 to 904
[Vi mai 17 16:58:05 2024] intel_pmc_core INT33A1:00:  initialized
[Vi mai 17 16:58:05 2024] mei_me 0000:00:16.0: enabling device (0004 -> 000=
6)
[Vi mai 17 16:58:05 2024] ee1004 0-0050: 512 byte EE1004-compliant SPD EEPR=
OM, read-only
[Vi mai 17 16:58:05 2024] cfg80211: Loading compiled-in X.509 certificates =
for regulatory database
[Vi mai 17 16:58:05 2024] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[Vi mai 17 16:58:05 2024] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7f=
f06c7248db18c600'
[Vi mai 17 16:58:05 2024] Bluetooth: Core ver 2.22
[Vi mai 17 16:58:05 2024] NET: Registered PF_BLUETOOTH protocol family
[Vi mai 17 16:58:05 2024] Bluetooth: HCI device and connection manager init=
ialized
[Vi mai 17 16:58:05 2024] Bluetooth: HCI socket layer initialized
[Vi mai 17 16:58:05 2024] Bluetooth: L2CAP socket layer initialized
[Vi mai 17 16:58:05 2024] Bluetooth: SCO socket layer initialized
[Vi mai 17 16:58:05 2024] Intel(R) Wireless WiFi driver for Linux
[Vi mai 17 16:58:05 2024] iwlwifi 0000:3a:00.0: enabling device (0000 -> 00=
02)
[Vi mai 17 16:58:05 2024] usbcore: registered new interface driver btusb
[Vi mai 17 16:58:05 2024] Bluetooth: hci0: Firmware revision 0.1 build 19 w=
eek 44 2021
[Vi mai 17 16:58:05 2024] Bluetooth: hci0: Reading supported features faile=
d (-16)
[Vi mai 17 16:58:05 2024] Bluetooth: hci0: Error reading debug features
[Vi mai 17 16:58:05 2024] Bluetooth: hci0: HCI LE Coded PHY feature bit is =
set, but its usage is not supported.
[Vi mai 17 16:58:05 2024] iwlwifi 0000:3a:00.0: Detected crf-id 0xbadcafe, =
cnv-id 0x10 wfpm id 0x80000000
[Vi mai 17 16:58:05 2024] iwlwifi 0000:3a:00.0: PCI dev 24fd/9010, rev=3D0x=
230, rfid=3D0xd55555d5
[Vi mai 17 16:58:05 2024] iwlwifi 0000:3a:00.0: loaded firmware version 36.=
ca7b901d.0 8265-36.ucode op_mode iwlmvm
[Vi mai 17 16:58:05 2024] RAPL PMU: API unit is 2^-32 Joules, 5 fixed count=
ers, 655360 ms ovfl timer
[Vi mai 17 16:58:05 2024] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[Vi mai 17 16:58:05 2024] RAPL PMU: hw unit of domain package 2^-14 Joules
[Vi mai 17 16:58:05 2024] RAPL PMU: hw unit of domain dram 2^-14 Joules
[Vi mai 17 16:58:05 2024] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[Vi mai 17 16:58:05 2024] RAPL PMU: hw unit of domain psys 2^-14 Joules
[Vi mai 17 16:58:05 2024] cryptd: max_cpu_qlen set to 1000
[Vi mai 17 16:58:06 2024] AVX2 version of gcm_enc/dec engaged.
[Vi mai 17 16:58:06 2024] AES CTR mode by8 optimization enabled
[Vi mai 17 16:58:06 2024] i915 0000:00:02.0: [drm] Found 64MB of eDRAM
[Vi mai 17 16:58:06 2024] i915 0000:00:02.0: [drm] VT-d active for gfx acce=
ss
[Vi mai 17 16:58:06 2024] Console: switching to colour dummy device 80x25
[Vi mai 17 16:58:06 2024] iwlwifi 0000:3a:00.0: Detected Intel(R) Dual Band=
 Wireless AC 8265, REV=3D0x230
[Vi mai 17 16:58:06 2024] thermal thermal_zone2: failed to read out thermal=
 zone (-61)
[Vi mai 17 16:58:06 2024] i915 0000:00:02.0: vgaarb: deactivate vga console
[Vi mai 17 16:58:06 2024] i915 0000:00:02.0: [drm] Using Transparent Hugepa=
ges
[Vi mai 17 16:58:06 2024] i915 0000:00:02.0: vgaarb: VGA decodes changed: o=
lddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[Vi mai 17 16:58:06 2024] i915 0000:00:02.0: [drm] Finished loading DMC fir=
mware i915/kbl_dmc_ver1_04.bin (v1.4)
[Vi mai 17 16:58:06 2024] iwlwifi 0000:3a:00.0: base HW address: 90:78:41:2=
7:48:54, OTP minor version: 0x0
[Vi mai 17 16:58:06 2024] snd_hda_intel 0000:00:1f.3: DSP detected with PCI=
 class/subclass/prog-if info 0x040380
[Vi mai 17 16:58:06 2024] ieee80211 phy0: Selected rate control algorithm '=
iwl-mvm-rs'
[Vi mai 17 16:58:06 2024] iwlwifi 0000:3a:00.0 wlp58s0: renamed from wlan0
[Vi mai 17 16:58:06 2024] snd_hda_intel 0000:00:1f.3: DSP detected with PCI=
 class/subclass/prog-if info 0x040380
[Vi mai 17 16:58:06 2024] intel_tcc_cooling: Programmable TCC Offset detect=
ed
[Vi mai 17 16:58:06 2024] snd_soc_skl 0000:00:1f.3: DSP detected with PCI c=
lass/subclass/prog-if info 0x040380
[Vi mai 17 16:58:06 2024] intel_rapl_common: Found RAPL domain package
[Vi mai 17 16:58:06 2024] intel_rapl_common: Found RAPL domain core
[Vi mai 17 16:58:06 2024] intel_rapl_common: Found RAPL domain uncore
[Vi mai 17 16:58:06 2024] intel_rapl_common: Found RAPL domain dram
[Vi mai 17 16:58:06 2024] intel_rapl_common: Found RAPL domain psys
[Vi mai 17 16:58:06 2024] snd_hda_intel 0000:00:1f.3: DSP detected with PCI=
 class/subclass/prog-if info 0x040380
[Vi mai 17 16:58:06 2024] snd_soc_skl 0000:00:1f.3: DSP detected with PCI c=
lass/subclass/prog-if info 0x040380
[Vi mai 17 16:58:06 2024] snd_soc_avs 0000:00:1f.3: DSP detected with PCI c=
lass/subclass/prog-if info 0x040380
[Vi mai 17 16:58:06 2024] sof-audio-pci-intel-skl 0000:00:1f.3: DSP detecte=
d with PCI class/subclass/prog-if info 0x040380
[Vi mai 17 16:58:06 2024] i915 0000:00:02.0: [drm] [ENCODER:94:DDI A/PHY A]=
 failed to retrieve link info, disabling eDP
[Vi mai 17 16:58:06 2024] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[Vi mai 17 16:58:06 2024] Bluetooth: BNEP filters: protocol multicast
[Vi mai 17 16:58:06 2024] Bluetooth: BNEP socket layer initialized
[Vi mai 17 16:58:06 2024] Bluetooth: MGMT ver 1.22
[Vi mai 17 16:58:06 2024] NET: Registered PF_ALG protocol family
[Vi mai 17 16:58:07 2024] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c=
54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
[Vi mai 17 16:58:07 2024] [drm] Initialized i915 1.6.0 20230929 for 0000:00=
:02.0 on minor 1
[Vi mai 17 16:58:07 2024] ACPI: video: Video Device [GFX0] (multi-head: yes=
  rom: no  post: no)
[Vi mai 17 16:58:07 2024] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS=
:00/PNP0A08:00/LNXVIDEO:00/input/input3
[Vi mai 17 16:58:07 2024] snd_hda_intel 0000:00:1f.3: DSP detected with PCI=
 class/subclass/prog-if info 0x040380
[Vi mai 17 16:58:07 2024] snd_soc_skl 0000:00:1f.3: DSP detected with PCI c=
lass/subclass/prog-if info 0x040380
[Vi mai 17 16:58:07 2024] snd_soc_avs 0000:00:1f.3: DSP detected with PCI c=
lass/subclass/prog-if info 0x040380
[Vi mai 17 16:58:07 2024] sof-audio-pci-intel-skl 0000:00:1f.3: DSP detecte=
d with PCI class/subclass/prog-if info 0x040380
[Vi mai 17 16:58:07 2024] snd_hda_intel 0000:00:1f.3: DSP detected with PCI=
 class/subclass/prog-if info 0x040380
[Vi mai 17 16:58:07 2024] iwlwifi 0000:3a:00.0: Registered PHC clock: iwlwi=
fi-PTP, with index: 1
[Vi mai 17 16:58:07 2024] fbcon: i915drmfb (fb0) is primary device
[Vi mai 17 16:58:07 2024] Console: switching to colour frame buffer device =
160x45
[Vi mai 17 16:58:07 2024] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buf=
fer device
[Vi mai 17 16:58:07 2024] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (o=
ps i915_audio_component_bind_ops [i915])
[Vi mai 17 16:58:07 2024] snd_hda_codec_realtek hdaudioC0D0: autoconfig for=
 ALC283: line_outs=3D1 (0x21/0x0/0x0/0x0/0x0) type:hp
[Vi mai 17 16:58:07 2024] snd_hda_codec_realtek hdaudioC0D0:    speaker_out=
s=3D0 (0x0/0x0/0x0/0x0/0x0)
[Vi mai 17 16:58:07 2024] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D0=
 (0x0/0x0/0x0/0x0/0x0)
[Vi mai 17 16:58:07 2024] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_=
out=3D0x0
[Vi mai 17 16:58:07 2024] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[Vi mai 17 16:58:07 2024] snd_hda_codec_realtek hdaudioC0D0:      Mic=3D0x1=
2
[Vi mai 17 16:58:07 2024] input: HDA Intel PCH Front Headphone as /devices/=
pci0000:00/0000:00:1f.3/sound/card0/input4
[Vi mai 17 16:58:07 2024] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/=
pci0000:00/0000:00:1f.3/sound/card0/input5
[Vi mai 17 16:58:07 2024] input: HDA Intel PCH HDMI/DP,pcm=3D7 as /devices/=
pci0000:00/0000:00:1f.3/sound/card0/input6
[Vi mai 17 16:58:07 2024] input: HDA Intel PCH HDMI/DP,pcm=3D8 as /devices/=
pci0000:00/0000:00:1f.3/sound/card0/input7
[Vi mai 17 16:58:07 2024] snd_hda_intel 0000:00:1f.3: device 8086:2068 is o=
n the power_save denylist, forcing power_save to 0
[Vi mai 17 16:58:08 2024] loop14: detected capacity change from 0 to 8
[Vi mai 17 16:58:09 2024] rfkill: input handler disabled
[Vi mai 17 16:58:10 2024] e1000e 0000:00:1f.6 eno1: NIC Link is Up 1000 Mbp=
s Full Duplex, Flow Control: Rx/Tx
[Vi mai 17 16:58:13 2024] evm: overlay not supported
[Vi mai 17 16:58:13 2024] Initializing XFRM netlink socket
[Vi mai 17 16:58:13 2024] br-243ab13fe3ac: port 1(vethd774702) entered bloc=
king state
[Vi mai 17 16:58:13 2024] br-243ab13fe3ac: port 1(vethd774702) entered disa=
bled state
[Vi mai 17 16:58:13 2024] vethd774702: entered allmulticast mode
[Vi mai 17 16:58:13 2024] vethd774702: entered promiscuous mode
[Vi mai 17 16:58:13 2024] br-243ab13fe3ac: port 2(vethc86cb2d) entered bloc=
king state
[Vi mai 17 16:58:13 2024] br-243ab13fe3ac: port 2(vethc86cb2d) entered disa=
bled state
[Vi mai 17 16:58:13 2024] vethc86cb2d: entered allmulticast mode
[Vi mai 17 16:58:13 2024] vethc86cb2d: entered promiscuous mode
[Vi mai 17 16:58:13 2024] br-243ab13fe3ac: port 3(veth7897901) entered bloc=
king state
[Vi mai 17 16:58:13 2024] br-243ab13fe3ac: port 3(veth7897901) entered disa=
bled state
[Vi mai 17 16:58:13 2024] veth7897901: entered allmulticast mode
[Vi mai 17 16:58:13 2024] veth7897901: entered promiscuous mode
[Vi mai 17 16:58:13 2024] br-243ab13fe3ac: port 4(vethca8f75d) entered bloc=
king state
[Vi mai 17 16:58:13 2024] br-243ab13fe3ac: port 4(vethca8f75d) entered disa=
bled state
[Vi mai 17 16:58:13 2024] vethca8f75d: entered allmulticast mode
[Vi mai 17 16:58:13 2024] vethca8f75d: entered promiscuous mode
[Vi mai 17 16:58:13 2024] br-243ab13fe3ac: port 5(vethf50493a) entered bloc=
king state
[Vi mai 17 16:58:13 2024] br-243ab13fe3ac: port 5(vethf50493a) entered disa=
bled state
[Vi mai 17 16:58:13 2024] vethf50493a: entered allmulticast mode
[Vi mai 17 16:58:13 2024] vethf50493a: entered promiscuous mode
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 6(veth08e9f28) entered bloc=
king state
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 6(veth08e9f28) entered disa=
bled state
[Vi mai 17 16:58:14 2024] veth08e9f28: entered allmulticast mode
[Vi mai 17 16:58:14 2024] veth08e9f28: entered promiscuous mode
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 7(vethd67d42d) entered bloc=
king state
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 7(vethd67d42d) entered disa=
bled state
[Vi mai 17 16:58:14 2024] vethd67d42d: entered allmulticast mode
[Vi mai 17 16:58:14 2024] vethd67d42d: entered promiscuous mode
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 8(veth19254d5) entered bloc=
king state
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 8(veth19254d5) entered disa=
bled state
[Vi mai 17 16:58:14 2024] veth19254d5: entered allmulticast mode
[Vi mai 17 16:58:14 2024] veth19254d5: entered promiscuous mode
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 9(veth986c44f) entered bloc=
king state
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 9(veth986c44f) entered disa=
bled state
[Vi mai 17 16:58:14 2024] veth986c44f: entered allmulticast mode
[Vi mai 17 16:58:14 2024] veth986c44f: entered promiscuous mode
[Vi mai 17 16:58:14 2024] eth0: renamed from vethe6f7ec5
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 2(vethc86cb2d) entered bloc=
king state
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 2(vethc86cb2d) entered forw=
arding state
[Vi mai 17 16:58:14 2024] eth0: renamed from veth1782d52
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 6(veth08e9f28) entered bloc=
king state
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 6(veth08e9f28) entered forw=
arding state
[Vi mai 17 16:58:14 2024] eth0: renamed from vethbdf9e8e
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 7(vethd67d42d) entered bloc=
king state
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 7(vethd67d42d) entered forw=
arding state
[Vi mai 17 16:58:14 2024] eth0: renamed from veth50c06fe
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 3(veth7897901) entered bloc=
king state
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 3(veth7897901) entered forw=
arding state
[Vi mai 17 16:58:14 2024] eth0: renamed from vethd3a3e22
[Vi mai 17 16:58:14 2024] eth0: renamed from vethdf28b36
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 1(vethd774702) entered bloc=
king state
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 1(vethd774702) entered forw=
arding state
[Vi mai 17 16:58:14 2024] eth0: renamed from vethc3b5d70
[Vi mai 17 16:58:14 2024] eth0: renamed from vethf5f1304
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 4(vethca8f75d) entered bloc=
king state
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 4(vethca8f75d) entered forw=
arding state
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 5(vethf50493a) entered bloc=
king state
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 5(vethf50493a) entered forw=
arding state
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 8(veth19254d5) entered bloc=
king state
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 8(veth19254d5) entered forw=
arding state
[Vi mai 17 16:58:14 2024] eth0: renamed from veth58c08ce
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 9(veth986c44f) entered bloc=
king state
[Vi mai 17 16:58:14 2024] br-243ab13fe3ac: port 9(veth986c44f) entered forw=
arding state
[Vi mai 17 16:58:26 2024] vethc3b5d70: renamed from eth0
[Vi mai 17 16:58:26 2024] br-243ab13fe3ac: port 5(vethf50493a) entered disa=
bled state
[Vi mai 17 16:58:26 2024] br-243ab13fe3ac: port 5(vethf50493a) entered disa=
bled state
[Vi mai 17 16:58:26 2024] vethf50493a (unregistering): left allmulticast mo=
de
[Vi mai 17 16:58:26 2024] vethf50493a (unregistering): left promiscuous mod=
e
[Vi mai 17 16:58:26 2024] br-243ab13fe3ac: port 5(vethf50493a) entered disa=
bled state
[Vi mai 17 16:58:26 2024] br-243ab13fe3ac: port 5(veth1180d7c) entered bloc=
king state
[Vi mai 17 16:58:26 2024] br-243ab13fe3ac: port 5(veth1180d7c) entered disa=
bled state
[Vi mai 17 16:58:26 2024] veth1180d7c: entered allmulticast mode
[Vi mai 17 16:58:26 2024] veth1180d7c: entered promiscuous mode
[Vi mai 17 16:58:26 2024] eth0: renamed from veth616b98d
[Vi mai 17 16:58:26 2024] br-243ab13fe3ac: port 5(veth1180d7c) entered bloc=
king state
[Vi mai 17 16:58:26 2024] br-243ab13fe3ac: port 5(veth1180d7c) entered forw=
arding state
[Vi mai 17 16:58:28 2024] Bluetooth: RFCOMM TTY layer initialized
[Vi mai 17 16:58:28 2024] Bluetooth: RFCOMM socket layer initialized
[Vi mai 17 16:58:28 2024] Bluetooth: RFCOMM ver 1.11
[Vi mai 17 16:58:36 2024] br-243ab13fe3ac: port 5(veth1180d7c) entered disa=
bled state
[Vi mai 17 16:58:36 2024] veth616b98d: renamed from eth0
[Vi mai 17 16:58:36 2024] br-243ab13fe3ac: port 5(veth1180d7c) entered disa=
bled state
[Vi mai 17 16:58:36 2024] veth1180d7c (unregistering): left allmulticast mo=
de
[Vi mai 17 16:58:36 2024] veth1180d7c (unregistering): left promiscuous mod=
e
[Vi mai 17 16:58:36 2024] br-243ab13fe3ac: port 5(veth1180d7c) entered disa=
bled state
[Vi mai 17 16:58:37 2024] br-243ab13fe3ac: port 5(veth75295a7) entered bloc=
king state
[Vi mai 17 16:58:37 2024] br-243ab13fe3ac: port 5(veth75295a7) entered disa=
bled state
[Vi mai 17 16:58:37 2024] veth75295a7: entered allmulticast mode
[Vi mai 17 16:58:37 2024] veth75295a7: entered promiscuous mode
[Vi mai 17 16:58:37 2024] eth0: renamed from veth38a3106
[Vi mai 17 16:58:37 2024] br-243ab13fe3ac: port 5(veth75295a7) entered bloc=
king state
[Vi mai 17 16:58:37 2024] br-243ab13fe3ac: port 5(veth75295a7) entered forw=
arding state
[Vi mai 17 16:58:45 2024] veth38a3106: renamed from eth0
[Vi mai 17 16:58:45 2024] br-243ab13fe3ac: port 5(veth75295a7) entered disa=
bled state
[Vi mai 17 16:58:45 2024] br-243ab13fe3ac: port 5(veth75295a7) entered disa=
bled state
[Vi mai 17 16:58:45 2024] veth75295a7 (unregistering): left allmulticast mo=
de
[Vi mai 17 16:58:45 2024] veth75295a7 (unregistering): left promiscuous mod=
e
[Vi mai 17 16:58:45 2024] br-243ab13fe3ac: port 5(veth75295a7) entered disa=
bled state
[Vi mai 17 16:58:45 2024] br-243ab13fe3ac: port 5(vethcb5b930) entered bloc=
king state
[Vi mai 17 16:58:45 2024] br-243ab13fe3ac: port 5(vethcb5b930) entered disa=
bled state
[Vi mai 17 16:58:45 2024] vethcb5b930: entered allmulticast mode
[Vi mai 17 16:58:45 2024] vethcb5b930: entered promiscuous mode
[Vi mai 17 16:58:45 2024] eth0: renamed from veth507e81d
[Vi mai 17 16:58:45 2024] br-243ab13fe3ac: port 5(vethcb5b930) entered bloc=
king state
[Vi mai 17 16:58:45 2024] br-243ab13fe3ac: port 5(vethcb5b930) entered forw=
arding state
[Vi mai 17 16:58:53 2024] veth507e81d: renamed from eth0
[Vi mai 17 16:58:53 2024] br-243ab13fe3ac: port 5(vethcb5b930) entered disa=
bled state
[Vi mai 17 16:58:53 2024] br-243ab13fe3ac: port 5(vethcb5b930) entered disa=
bled state
[Vi mai 17 16:58:53 2024] vethcb5b930 (unregistering): left allmulticast mo=
de
[Vi mai 17 16:58:53 2024] vethcb5b930 (unregistering): left promiscuous mod=
e
[Vi mai 17 16:58:53 2024] br-243ab13fe3ac: port 5(vethcb5b930) entered disa=
bled state
[Vi mai 17 16:58:54 2024] br-243ab13fe3ac: port 5(vethe4d5413) entered bloc=
king state
[Vi mai 17 16:58:54 2024] br-243ab13fe3ac: port 5(vethe4d5413) entered disa=
bled state
[Vi mai 17 16:58:54 2024] vethe4d5413: entered allmulticast mode
[Vi mai 17 16:58:54 2024] vethe4d5413: entered promiscuous mode
[Vi mai 17 16:58:54 2024] eth0: renamed from veth89da9f1
[Vi mai 17 16:58:54 2024] br-243ab13fe3ac: port 5(vethe4d5413) entered bloc=
king state
[Vi mai 17 16:58:54 2024] br-243ab13fe3ac: port 5(vethe4d5413) entered forw=
arding state
[Vi mai 17 16:59:02 2024] veth89da9f1: renamed from eth0
[Vi mai 17 16:59:02 2024] br-243ab13fe3ac: port 5(vethe4d5413) entered disa=
bled state
[Vi mai 17 16:59:02 2024] br-243ab13fe3ac: port 5(vethe4d5413) entered disa=
bled state
[Vi mai 17 16:59:02 2024] vethe4d5413 (unregistering): left allmulticast mo=
de
[Vi mai 17 16:59:02 2024] vethe4d5413 (unregistering): left promiscuous mod=
e
[Vi mai 17 16:59:02 2024] br-243ab13fe3ac: port 5(vethe4d5413) entered disa=
bled state
[Vi mai 17 16:59:04 2024] br-243ab13fe3ac: port 5(vethd61073b) entered bloc=
king state
[Vi mai 17 16:59:04 2024] br-243ab13fe3ac: port 5(vethd61073b) entered disa=
bled state
[Vi mai 17 16:59:04 2024] vethd61073b: entered allmulticast mode
[Vi mai 17 16:59:04 2024] vethd61073b: entered promiscuous mode
[Vi mai 17 16:59:04 2024] eth0: renamed from veth8c88170
[Vi mai 17 16:59:04 2024] br-243ab13fe3ac: port 5(vethd61073b) entered bloc=
king state
[Vi mai 17 16:59:04 2024] br-243ab13fe3ac: port 5(vethd61073b) entered forw=
arding state
[Vi mai 17 16:59:12 2024] veth8c88170: renamed from eth0
[Vi mai 17 16:59:12 2024] br-243ab13fe3ac: port 5(vethd61073b) entered disa=
bled state
[Vi mai 17 16:59:12 2024] br-243ab13fe3ac: port 5(vethd61073b) entered disa=
bled state
[Vi mai 17 16:59:12 2024] vethd61073b (unregistering): left allmulticast mo=
de
[Vi mai 17 16:59:12 2024] vethd61073b (unregistering): left promiscuous mod=
e
[Vi mai 17 16:59:12 2024] br-243ab13fe3ac: port 5(vethd61073b) entered disa=
bled state
[Vi mai 17 16:59:15 2024] br-243ab13fe3ac: port 5(vethab75cd9) entered bloc=
king state
[Vi mai 17 16:59:15 2024] br-243ab13fe3ac: port 5(vethab75cd9) entered disa=
bled state
[Vi mai 17 16:59:15 2024] vethab75cd9: entered allmulticast mode
[Vi mai 17 16:59:15 2024] vethab75cd9: entered promiscuous mode
[Vi mai 17 16:59:15 2024] eth0: renamed from vethadca29a
[Vi mai 17 16:59:15 2024] br-243ab13fe3ac: port 5(vethab75cd9) entered bloc=
king state
[Vi mai 17 16:59:15 2024] br-243ab13fe3ac: port 5(vethab75cd9) entered forw=
arding state
[Vi mai 17 16:59:23 2024] vethadca29a: renamed from eth0
[Vi mai 17 16:59:23 2024] br-243ab13fe3ac: port 5(vethab75cd9) entered disa=
bled state
[Vi mai 17 16:59:23 2024] br-243ab13fe3ac: port 5(vethab75cd9) entered disa=
bled state
[Vi mai 17 16:59:23 2024] vethab75cd9 (unregistering): left allmulticast mo=
de
[Vi mai 17 16:59:23 2024] vethab75cd9 (unregistering): left promiscuous mod=
e
[Vi mai 17 16:59:23 2024] br-243ab13fe3ac: port 5(vethab75cd9) entered disa=
bled state
[Vi mai 17 16:59:30 2024] br-243ab13fe3ac: port 5(veth30802d7) entered bloc=
king state
[Vi mai 17 16:59:30 2024] br-243ab13fe3ac: port 5(veth30802d7) entered disa=
bled state
[Vi mai 17 16:59:30 2024] veth30802d7: entered allmulticast mode
[Vi mai 17 16:59:30 2024] veth30802d7: entered promiscuous mode
[Vi mai 17 16:59:30 2024] eth0: renamed from vethc6ec3a2
[Vi mai 17 16:59:30 2024] br-243ab13fe3ac: port 5(veth30802d7) entered bloc=
king state
[Vi mai 17 16:59:30 2024] br-243ab13fe3ac: port 5(veth30802d7) entered forw=
arding state
[Vi mai 17 16:59:38 2024] vethc6ec3a2: renamed from eth0
[Vi mai 17 16:59:38 2024] br-243ab13fe3ac: port 5(veth30802d7) entered disa=
bled state
[Vi mai 17 16:59:38 2024] br-243ab13fe3ac: port 5(veth30802d7) entered disa=
bled state
[Vi mai 17 16:59:38 2024] veth30802d7 (unregistering): left allmulticast mo=
de
[Vi mai 17 16:59:38 2024] veth30802d7 (unregistering): left promiscuous mod=
e
[Vi mai 17 16:59:38 2024] br-243ab13fe3ac: port 5(veth30802d7) entered disa=
bled state
[Vi mai 17 16:59:51 2024] br-243ab13fe3ac: port 5(veth2d649e1) entered bloc=
king state
[Vi mai 17 16:59:51 2024] br-243ab13fe3ac: port 5(veth2d649e1) entered disa=
bled state
[Vi mai 17 16:59:51 2024] veth2d649e1: entered allmulticast mode
[Vi mai 17 16:59:51 2024] veth2d649e1: entered promiscuous mode
[Vi mai 17 16:59:51 2024] eth0: renamed from veth71670f4
[Vi mai 17 16:59:51 2024] br-243ab13fe3ac: port 5(veth2d649e1) entered bloc=
king state
[Vi mai 17 16:59:51 2024] br-243ab13fe3ac: port 5(veth2d649e1) entered forw=
arding state
[Vi mai 17 16:59:59 2024] veth71670f4: renamed from eth0
[Vi mai 17 16:59:59 2024] br-243ab13fe3ac: port 5(veth2d649e1) entered disa=
bled state
[Vi mai 17 16:59:59 2024] br-243ab13fe3ac: port 5(veth2d649e1) entered disa=
bled state
[Vi mai 17 16:59:59 2024] veth2d649e1 (unregistering): left allmulticast mo=
de
[Vi mai 17 16:59:59 2024] veth2d649e1 (unregistering): left promiscuous mod=
e
[Vi mai 17 16:59:59 2024] br-243ab13fe3ac: port 5(veth2d649e1) entered disa=
bled state

Linux 6.9.0-x64v1-evl1 #8 SMP PREEMPT_DYNAMIC IRQ_PIPELINE Fri May 17 16:48=
:38 EEST 202 x86_64 x86_64 x86_64 GNU/Linux

Type flavour: -lowlatency

Best regards,
Ionut Nechita.


-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>=20
Sent: Friday, May 17, 2024 4:18 PM
To: Nechita, Ionut <ionut.nechita@intel.com>
Cc: xenomai@lists.linux.dev
Subject: Re: WARN Kernel v6.9-evl-rebase - poll_idle


"Nechita, Ionut" <ionut.nechita@intel.com> writes:

> Hello Xenomai Team,
>
> I notice one warning message today in dmesg, when using 6.9-evl branch.
>
> Output(dmesg):
>
> [    0.447973] ------------[ cut here ]------------
> [    0.447975] WARNING: CPU: 3 PID: 0 at kernel/irq/pipeline.c:303 inband=
_irq_enable+0x21/0x40
> [    0.447981] Modules linked in:
> [    0.447983] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.9.0-x64v1-lowl=
atency1 #4
> [    0.447986] Hardware name: Intel(R) Client Systems NUC7i7BNH/NUC7i7BNB=
, BIOS BNKBL357.86A.0083.2020.0714.1344 07/14/2020
> [    0.447987] IRQ stage: Linux
> [    0.447989] RIP: 0010:inband_irq_enable+0x21/0x40
> [    0.447992] Code: 90 90 90 90 90 90 90 90 90 55 48 89 e5 53 0f b6 1d 3=
5 05 3d 02 80 fb 01 0f 87 ba 6f fd 00 83 e3 01 75 09 9c 58 f6 c4 02 75 02 <=
0f> 0b e8 58 ff ff ff 48 8b 5d f8 c9 31 c0 31 f6 31 ff c3 cc cc cc
> [    0.447994] RSP: 0000:ffffa955c012be00 EFLAGS: 00010046
> [    0.447997] RAX: 0000000000000046 RBX: 0000000000000000 RCX: 000000000=
0000000
> [    0.447999] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [    0.448000] RBP: ffffa955c012be08 R08: 0000000000000000 R09: 000000000=
0000000
> [    0.448001] R10: 0000000000000000 R11: 0000000000000000 R12: ffff998b1=
ed88c20
> [    0.448003] R13: ffffffffad67f8c0 R14: 0000000000000000 R15: 000000000=
0000000
> [    0.448004] FS:  0000000000000000(0000) GS:ffff998b1ed00000(0000) knlG=
S:0000000000000000
> [    0.448006] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.448008] CR2: 0000000000000000 CR3: 00000005e2232001 CR4: 000000000=
03706f0
> [    0.448010] Call Trace:
> [    0.448012]  <TASK>
> [    0.448014]  ? show_regs+0x71/0x90
> [    0.448018]  ? inband_irq_enable+0x21/0x40
> [    0.448021]  ? __warn+0x8c/0x160
> [    0.448025]  ? inband_irq_enable+0x21/0x40
> [    0.448028]  ? report_bug+0x1ab/0x1c0
> [    0.448033]  ? handle_bug+0x52/0xc0
> [    0.448035]  ? exc_invalid_op+0x10c/0x140
> [    0.448037]  ? asm_exc_invalid_op+0x1b/0x20
> [    0.448041]  ? inband_irq_enable+0x21/0x40
> [    0.448045]  poll_idle+0x28/0xb4
> [    0.448048]  cpuidle_enter_state+0x9f/0x490
> [    0.448051]  cpuidle_enter+0x2e/0x50
> [    0.448055]  call_cpuidle+0x22/0x50
> [    0.448059]  do_idle+0x22f/0x2a0
> [    0.448061]  ? complete+0x6d/0x80
> [    0.448065]  cpu_startup_entry+0x2c/0x30
> [    0.448068]  start_secondary+0x119/0x140
> [    0.448072]  common_startup_64+0x13e/0x141
> [    0.448077]  </TASK>
> [    0.448078] ---[ end trace 0000000000000000 ]---
>

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c in=
dex d86fe89830872..79ea798076764 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -19,8 +19,8 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev=
,
=20
 	dev->poll_time_limit =3D false;
=20
-	raw_local_irq_enable();
 	hard_cond_local_irq_enable();
+	raw_local_irq_enable();
 	if (!current_set_polling_and_test()) {
 		unsigned int loop_count =3D 0;
 		u64 limit;

--
Philippe.
