Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDC51E515
	for <xenomai@lists.linux.dev>; Mon, 29 Jul 2024 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262167; cv=fail; b=ha0tn6U3kx8LtFkeqHKI+hDMNuqHe+Z97YhNXiIOjxSFwFPp0pC3b9jDbLqv+e5Wp/pP04hWDQH6P57d0qpR14pxDBnWxHLZ1wmzKIVBqelyKW9hLFe+o3UZNJVszbUDvPe/LXgQ9IaaAbgY6uZCWRxdGnz7lxJcWV3NnbP1uoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262167; c=relaxed/simple;
	bh=XXqlvRl1gHIs0qrZHiRMvu1vdOOIoSmLjz4kRXOkF2A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pLUQ/6uSvcqjT5Ty6GgL718xplooN+g3AE7Xna9HmkKncsWCZBxUmVFsn+uqc3VTAqh4NJPpDjYVkCc8qPMd3hvMSrB/Yli9ZZalMmaCYS4/cfiwY71kQ2NdIzTlQoMcmMolvJizdIAVD0ShIU/nzIlo68RvSF/Clz5DclEiGlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A87kI4vy; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A87kI4vy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722262166; x=1753798166;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XXqlvRl1gHIs0qrZHiRMvu1vdOOIoSmLjz4kRXOkF2A=;
  b=A87kI4vybNWGEQeMYFv9MrGIrZ/EynhjasxzlIsgRcWKpAY6aWZxPals
   JZnBiyjPxL0U+TRt8KBL4mRcvoq8m5a7ZSKUEHZ7P6L7dtAZcBlFGCssB
   +4IWm1BWWRqnzrWUfSANypA4fspYUCMJ0nBs/dvCYygVmHOai+m1QnjRN
   med8vPnNy4xtQWTV+BK7nS1xM0Yr05xQgRhTD0lN2GMHk2l9n/TT6qIQi
   UXaDSme38qNY0r2IylpxYHmDtIF7jno475qchh4RLvpIYlm021GY/+mr/
   YLq6L9h+VV0EVnWLFCenOlRuQZKF+FYuMvyFpBs6Gxrz7wJsMwhX0ZhkX
   g==;
X-CSE-ConnectionGUID: w1To8kaTRXOQgNX2WWZk7g==
X-CSE-MsgGUID: o+wWAT8eRp2iH5kSMJUOdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="19720683"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="19720683"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 07:09:25 -0700
X-CSE-ConnectionGUID: Q8QE0yh3TyyAheevAydD+w==
X-CSE-MsgGUID: fCDvU3vQSyO/kRKP/HpxYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="58306133"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jul 2024 07:09:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 07:09:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 29 Jul 2024 07:09:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 07:09:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OG8K4z9mg0qaNe3G8aVnt4NR57u6aZqxt/k2HrH8x/f8ZnKRqDEgM8qX+h2VRe8pG5hRzLFkkt/WXvxFbxu+01hNdGK88spwxFjD5DpVBqU6uE9iODe4SWyDXrONSG5UA+/9qDGveoopcGbMfkMw/ACgXF4S2qc2hCSdMVVieWhFoiQ3svFF23J4fwGlp9uLMtY5l0eBGku46ZcQIpaNSZrW0qFOH94buQX1zw6EUso9ufGkYhQ8VA/qbyLB8YXbCOHZPMbv8LZdOD2t84kJwOpYPrlr74ohDWpJlXujs4DYbJaCWezMdVNPuSc3Tn591eOf+q/sV+6FL7nL13OwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXqlvRl1gHIs0qrZHiRMvu1vdOOIoSmLjz4kRXOkF2A=;
 b=K1XUGhFDixJ6r/MRnQ4iHl8VYzYwybTZ9aD4zJwR8LmBmYo0pao2MguJPBnBw0wDylouPhOATdJfErUkvb7Jg4QRXp1mQgUPjo5uISHMi75AoEtvE+MsphfrArl6RvzUjrPprPCeRdJQDU6VsZTXgr6V+mU7DJmcAqIYGO0lkaXEtkTnMEon4TtbB/5ypaJ2HsiR1teAwnYdDGBniH3mHRFhJZbx8nfbeeirm/y/Iy8cXGiYRnE3NJ/Sd6MoN3kCER9ThVMP3ENMBsTdGTVGVdqtFBgrvy3DIyaqIqeeiLNvObJywlKvhqeZ/xDA0P3VcCx2cbb0pVVzjN3rjtQCQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by DS7PR11MB6014.namprd11.prod.outlook.com (2603:10b6:8:73::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 14:09:20 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%4]) with mapi id 15.20.7807.023; Mon, 29 Jul 2024
 14:09:20 +0000
From: "Nechita, Ionut" <ionut.nechita@intel.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
Thread-Topic: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
Thread-Index: Adqobt1wsEThW759TTGOhdgp/60cKwD2+6CAAAAhQ+AABC7IUAAAPt4AAAFbp1AAB7gJAAywE7tAABOzV/QAjA22UA==
Date: Mon, 29 Jul 2024 14:09:20 +0000
Message-ID: <PH0PR11MB5949E741DE6A97AF6E1A741DF4B72@PH0PR11MB5949.namprd11.prod.outlook.com>
References: <PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87wmnmq8v9.fsf@xenomai.org>
	<PH0PR11MB59491C18ADB51F5FEAEF4B3FF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<PH0PR11MB59490B50D2D2717B8155EFCDF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87h6eprhbg.fsf@xenomai.org>
	<PH0PR11MB5949B24CB222FBB2D387BF24F4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87cypdr5fm.fsf@xenomai.org>
	<PH0PR11MB5949453FBEBCA4520CAF80A2F4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
 <871q3g3qva.fsf@xenomai.org>
In-Reply-To: <871q3g3qva.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5949:EE_|DS7PR11MB6014:EE_
x-ms-office365-filtering-correlation-id: 2792c51f-65e4-492a-0462-08dcafd80a75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?a8jQiIXOlhm3cwYZBETmuFHhnWUDJr9ZbEqXsCI1mJXN2g814ljcmzDP59wr?=
 =?us-ascii?Q?5UbqMb1wuinDcUBn0Wf0zJz2hrxAjzQN8dQSFy4ti83wOLt+QfQGbXPCqQgp?=
 =?us-ascii?Q?so5+trK8wDCA5xWp813AfEPPXZl+DPaTTFhNj9OlzGaG3a++MhmORJ8lOgRt?=
 =?us-ascii?Q?NGCvuQGtdweJd9Jxm7AvXW4lEx/PoE53gUk1l+TNRJxzU57BcTJP5rr5+4nF?=
 =?us-ascii?Q?dpHObBQsL50fFh0H8hGDAGENCB0vbulD0GLNSVaKq62nH+YvxFNDpgztDUIT?=
 =?us-ascii?Q?JxvYMqGyzWNWzU2ZoIueMU6LtideUhkPDhHIE0oakQa5QLEx6NhCFun4EcdQ?=
 =?us-ascii?Q?+a9P2I5Kbdbi3nVzSYOlK8H3vIOQrAk/Wfp0KFKOexga3F1goHbcTh+purNe?=
 =?us-ascii?Q?9sIGlcwJ/gnhl0U3xpUpTSIVbHRL0ndt+riYQK7rJ25bBXhqw5VUtkaLvNME?=
 =?us-ascii?Q?CfPWTvSq8WQxUFZKZElfTlfJDI4a53eMGaeyT3GdgXA3gEUghI8jbv1girKX?=
 =?us-ascii?Q?qnlf5D0lqRbYT9KvMq38GiRx2J/JlPVCOpLGJ5HaIIvFxRH9v7uNyI6d/XrR?=
 =?us-ascii?Q?D7HG5EmAS85boFho9RCBI8M437SNqq84LDTzv4YgMIqY5fxyLadG93/j7+cl?=
 =?us-ascii?Q?WgfL3obr/by/JI4ISl/0E5nQmYhaR5Lxn8PPKphTeFh1x/vprZ3ohxtnaCZv?=
 =?us-ascii?Q?5laIOjFhk9VJzHj7bquivOq4KkUqcH9pf+IytX/kl9wXxVIjRDx49Kn+HCVE?=
 =?us-ascii?Q?cEvNBz8jXky107e6EmHcR7545CFE9cF2HpuFKJXQ4Ae7KGQ4nc/1pjmgiSxx?=
 =?us-ascii?Q?n/1ql5MgmxQU3MCSpgA5jEfwl8fyCSb6m8QHzqCM8NX0MQQ8tpsbPTiqrpPU?=
 =?us-ascii?Q?fKYwziXEpb9W4GYayDrVGHp2jmby/5joNtxbtRPwwYpOCprSe/dbkb2f+ril?=
 =?us-ascii?Q?AjzlKTxXl51mKhUh0r5cgl1o5Ey6Lgw7mvxtyEU5XapsRqR8TiBcg6z2hlmF?=
 =?us-ascii?Q?n+OJzIJXmSiRh5uZ5DK3oC6k1I26QWj57SgcXM/1Pcb2Jz0G44RazIfAuQUm?=
 =?us-ascii?Q?hkr8JaiMk7GOcN/MaTxQSvmWH7Np0G9MxIzl0CQoV7z+s9TuB+NYztbG9N5Y?=
 =?us-ascii?Q?diFyA37U50MYs3SPhpX2Bxax+1oXe7B7ZJmtms5paju60dqsUMMOd2hpY+R6?=
 =?us-ascii?Q?2J+6ULHcmPl3+CxYRoMq5ffX0x2bwz0fHyv4w5/xUyetKG06z1fZRb3Y5wdQ?=
 =?us-ascii?Q?1CECgmjQ7PyTAQoInx6rFWfyVztKADwH0pC0RRAj/Tsc+yPWKDSfSaRL75qb?=
 =?us-ascii?Q?07A4U9mhTptya3oTA+qutIpsW/DKCAO9AMaCyEliFDpc+Yaj4Tn5Ty2ISJ3p?=
 =?us-ascii?Q?nRm/zZLWHu18Zc7P5t8f7sB55+VQseXtpQCru4l0W4sRthKi4w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QKS8CdYrG179SplJqw/Dcu+JUAoxdUiptcjMwG2N+EjBPgSLHs4BpArQhr6D?=
 =?us-ascii?Q?Aidag2v7CJ6QBPakJNTFqC47Br6X94ttcsI7gdLDxT5QsMIwk6vRgorCiFAo?=
 =?us-ascii?Q?I2iaaWBhR2GID1qB8h7z5M20A3gi6TuTQbo9GoqpJ9Vto3EVxw4lucM7nKTp?=
 =?us-ascii?Q?DVogKF1BPVqOENm4DmdtFgdWzW+QCSBW6PLAfTzoMTRQNc1mqWgZsanS7dHl?=
 =?us-ascii?Q?3Up98kaZDBN64eQTmo0kL2tQ9uxAqCjWHLVdpjDN2Swa5LAHC0hNpJ7oJkbd?=
 =?us-ascii?Q?yfYMw5olk2X6yrL18WG7bvqYrm3D23K+7ySLv8T1G+OF+GNIHbT1/SHAhD37?=
 =?us-ascii?Q?gG7YNi5MdM9qrspcdxYMDa+NB35HeY2pFA5yVsRFy9Ds65LLnlDJ3YNXM+4G?=
 =?us-ascii?Q?/p00M+Q3ccOlecn2dcvoRvd5Kpu7EvTiwvPvKZ9xtm0Mv3snTGnmM6Mty821?=
 =?us-ascii?Q?nCzUvZef8K6KG+esDmXzSilmRfjAP4ygk4Ts3FRz7rkH6NPel/jgXBlo8oHd?=
 =?us-ascii?Q?37tSZQNE0XhvZeN48Y/CYaO3A8XVg+vbK8CL0ojLEVDkMAPycIzhD2+8YFwX?=
 =?us-ascii?Q?91BTS6jzPskCZF2uJb6/6MWWPdPU/m0izNshhIwUYOIQO1xOWcfqEXnYvNbA?=
 =?us-ascii?Q?Y2ofW/xuzkGrpYPTwHc+QRIg0O5t1KZ60BvoqRsYGtsGDQRVv+wMegYb+Hr9?=
 =?us-ascii?Q?AmVc7bAc2yzAyuILfaXaoH4gIYBTvosU2J1i4zWXyF8hcelPkgS9G+7BFQ2r?=
 =?us-ascii?Q?LrNFXq0OP/eVPdOZWpAG0qDL5GLU2SFd73OLt8Dly2rHlOok6tg4w+p3jCeJ?=
 =?us-ascii?Q?06zPH0r/Y7pIeUJZfO0valqv0/XKYQLQgrwgDLVdpNQX6YZ0IR3KFHiI3Ce5?=
 =?us-ascii?Q?NZ5iCfhu4Fe8qX2vc0Q78yfqBdyByiB9CUT1AvMmGk9OcM2QXy/nF154aQgf?=
 =?us-ascii?Q?+45Ym7I+sQr9YDFNDA0xsCFHSaktTK6dwZLT4er1udbn5T2eVp8Y6Xe4OQ7H?=
 =?us-ascii?Q?EOUkySSbC0GfGJmSrGHmIyhRXeEJPPImAK6Yf8d54Eyu0C3PUPKvWJEJfvwQ?=
 =?us-ascii?Q?XtxHdvurcweLxO0+lZ7GItfgrcC7lTr4xhY32GkM1qLOkMMj6GP+qjswYlV+?=
 =?us-ascii?Q?fzosD+gmeUe+jFvyTEQ0eQN/O+3GdiqwWacdpdVHzp25uxkKIJ2vK/tS4rcS?=
 =?us-ascii?Q?uCR3tznxFHQSnUJm3er/VPU1G0HiC7L/VirM1/CYjzRo0BLsTQZ8rGfgPo+R?=
 =?us-ascii?Q?WHQ4z+s+/goWFCFYrEmGmNDW+4Jibr4Q+hpyk8qIlPnvJlvnQ0VY6Sh6zwEV?=
 =?us-ascii?Q?kWY1RONBHc8IYpp2vNB+7tj3eH8dBF2va5BRDRoWLmABxTpyssv5kLEVu5fr?=
 =?us-ascii?Q?Ux71jNQNjeIt7OxHra3mtkWkadZqkSXxY4J3YToU2CSTZbK5YvMi1kOsdjb7?=
 =?us-ascii?Q?ZBH8sF6FEaA/vpRVjglUkKSFkeXI7kgwUJ8AErhkk4MBp+guahMEFzc0+693?=
 =?us-ascii?Q?H/9VLimokVxIHjrC+45if4elhgSMSUR3ZZlOs5/Z432lziXsfVkN6w98SveE?=
 =?us-ascii?Q?HhBApTkEriGGbFmPdEDjYK0c69DiIpaOOn7UYgsY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2792c51f-65e4-492a-0462-08dcafd80a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 14:09:20.2916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rMupYmPNqqLRUvQ9HNed28dvmcc/BW4cYji2pjkG8E1Aw27JgvLTC07ZaMNMZF8378uemVSZsbwiT6+VjsZERw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6014
X-OriginatorOrg: intel.com

Hi Philippe,

How is possible to help to reproduce this(EVL: invalid out-of-band syscall =
<0x43564d41>)?

You need my .config file kernel configuration?

BR,
Ionut Nechita



-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>=20
Sent: Friday, July 26, 2024 10:17 PM
To: Nechita, Ionut <ionut.nechita@intel.com>
Cc: xenomai@lists.linux.dev
Subject: Re: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall=
 <0x43564d41> - Firefox browser

"Nechita, Ionut" <ionut.nechita@intel.com> writes:

> Hello,
>
> Any updates regarding this?
>
>


Stalled for now. Could not reproduce this issue yet.


--=20
Philippe.
