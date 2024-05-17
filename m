Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143DE1E507
	for <xenomai@lists.linux.dev>; Fri, 17 May 2024 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715953130; cv=fail; b=ogomF1dZCEKhHs5zA8WCd21yxJMUjFRnKextZoVali5fRfT72PrxAQCB7uLcUxqoxHmhSZf/vrUVQb55WjkC7pq5ZnC+t9nhwvqkRCFaqtdh2czU/z2QvW5WuynAccNrN+MRq9Hb71EtF9ONiQ0MpST9EyoNhD/votouyeAMDxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715953130; c=relaxed/simple;
	bh=wq3awdMdKNoTqGWZEPl7VEC3Ft9hck/t0XJDD8tVLJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bhqn0B96oTc7Rsm8r8V8IDEn0l1v1JnmSDifYCcgnNwgjwSkfWM3O4elWScLcNkay6fotnA2DV4LMJEo7znImn5A4cWifUDHpn7IuInTLRKThtFuInx4GKvv3YdRj53Qa38QYsXIAozwMprhcB6lR9+JIfNRWKLcZTz2L7Qqv1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XfhEJPXV; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XfhEJPXV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715953127; x=1747489127;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wq3awdMdKNoTqGWZEPl7VEC3Ft9hck/t0XJDD8tVLJM=;
  b=XfhEJPXVLnjWfp2oGTWDGhy9Jd9yH5fbJlK9QGJs6TYPvt+I78E1y7MS
   ACxTUZKrvPej6moEZ+RDZD0n9VcX8bq7xlDeGB5iNaya8c+4Uosbq7bmV
   8rT/K1PGT1Smyigb4CIdwc4H+i3YvJ+E5lML2jbOqSmGNZAqJMbeZiatW
   P4eRhyYhah5FDBLUzWur1U5qA2qeJIpG+3kV4hBK+3FN5/ONpnWL/FeJo
   VMnm/oAOTOOEyu+PhyurNfAB0wjORQL1ybrEndOog0AvlePQ9mRHX0xl5
   zF/jy1xEfg0ei/jxngi/yhFb3BfuFwjySZAQKt8ZNMDJe0p1X1ustxxYX
   A==;
X-CSE-ConnectionGUID: 0ZJfYTy/SPWQxeiVs0eLRA==
X-CSE-MsgGUID: jHriK20tRBWqt20kgF2N0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11970672"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="11970672"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 06:38:42 -0700
X-CSE-ConnectionGUID: IGj+wcDfQ2eYlV+JM8tqag==
X-CSE-MsgGUID: NQBUCFD8Tq6CrU7WrSUgrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31807238"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 May 2024 06:38:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 06:38:41 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 06:38:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 06:38:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 06:38:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTTGueO129MypFgbmbf+x3NiCEAUf04wOaDvxQE5fnPPSTax1bZf72emVC8VKUg0uFJkDbFcnnANHgDO6TEpAUFd5/EmGLURwBwRPu684OcSAl6xdyohmI1yr74oN3rdzGxNRorth3oxqAp5wbEgNfmvbEyxa3M2YQ+heMyNDJxqAlOf4z3VL5RgerWTjcHOHqsZJo1uQBTHRYMTn6s2ATYXN3YGHS3O+TJks5a8RIZNLWyxP0HWmAE1vgjQG6f55ZDGF5Ob88dP5tbzbMlM8DEL3mW08B/QYQADVfTTFyL32emob/tCoGTx+ITFV6CDxUcIKujMxS5NERkfWMNchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouDah8wkdzIDDeAb4LQjEDRIxH/89FV37HdjPfLt8mw=;
 b=m8EORgE9O5tm/N2uER0pv595ie0f5BlnwzhHAzXZGXbKDoqRU21Tc9ah5u8WCfbLy9nnh9E73N4rEc2JXmc1dnqHKRBj7fqx+C8hahkHpwQ+YFmlFv3v5q5BKNwXc67wSQOOX1st/ssWH0EQmpVaQNKXrINBDTG6PVO3c3cmNwgKZOSR2wRVKgvm1TjPcrOu7Ji86i30c/OYjD0FgBw2DT8x1khl2leKh8bs1dj+qp0ESyXbSxfqlFewhgbuVTLKiutoz6H9u8lUkoxYTKyzJ3MPLOepgfSnQd9X6IQ+rqaC3G/f5S6eqkwqTCtWRvj3QnwpnGAvn3Jv+lywcRTpPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by LV2PR11MB5997.namprd11.prod.outlook.com (2603:10b6:408:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 13:38:37 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%6]) with mapi id 15.20.7544.052; Fri, 17 May 2024
 13:38:37 +0000
From: "Nechita, Ionut" <ionut.nechita@intel.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: WARN Kernel v6.9-evl-rebase - do_int80_emulation
Thread-Topic: WARN Kernel v6.9-evl-rebase - do_int80_emulation
Thread-Index: AdqoUB42H/OnAc6gQSyqVaNVHGTu7wAA2ngAAADkauAAAU+/AAAAI7fAAACbpVA=
Date: Fri, 17 May 2024 13:38:37 +0000
Message-ID: <PH0PR11MB5949D3CFA8AD77346C36097FF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
References: <PH0PR11MB59492DDE7F2301CECFD2D8A9F4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <877cfsskke.fsf@xenomai.org>
 <PH0PR11MB5949EC28B447C7534BF8292DF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87y188r32a.fsf@xenomai.org>
 <PH0PR11MB5949CA43AC47E322BE97B5AAF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5949CA43AC47E322BE97B5AAF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5949:EE_|LV2PR11MB5997:EE_
x-ms-office365-filtering-correlation-id: 1a8f4793-c565-401b-312d-08dc7676a821
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?8Nvmjv+pvN/DmmJAZBeNYFVxwS8ZQACUyQxXFTCiX/pMSYuILT2bRysL6NrL?=
 =?us-ascii?Q?2dQYp/TJGIZXpQDNqSREq+5PF243wPtoyYswAkbuK0gFFik5ze3avuFcha41?=
 =?us-ascii?Q?2ttULfFAXBq7RFSdZb/iyNboZ8CdoyCwLcAmy4XMwPexkxvMoShqQsU2CXLF?=
 =?us-ascii?Q?DMJoJ17pCa1fDVCRr4gpFJ/ZQIJfOJCLGHyzePya/dGHAqBD76Ww9fkUMqrN?=
 =?us-ascii?Q?GUWYmXrbAAJL4Is004biTN5uNT4Q9bW0sBL918l5GlRctLw/jMs/tZ+a24EB?=
 =?us-ascii?Q?dobF87MjCAajoJlU2epZm7e5Pw3oHdrXXxFTHofoUwtCDhb0ekbPsskq9C+P?=
 =?us-ascii?Q?ocZX1yKyNK47ONYa39V4JG2FT9TW+ri3k4eIHTv17ktEhjpz0g2UhcVwCx1Z?=
 =?us-ascii?Q?gxDhUlA+AJpev6CAafqt0wxXs/gQZHq3nInrkZvEje+MM/48DZ5uLhkk2VZZ?=
 =?us-ascii?Q?6KVHuArta+iNDcyF4+9S2RMOaBZBdnHhAWFMSqhgdyaRbcTv8Lt58S8I7auP?=
 =?us-ascii?Q?VCNKLgqW/RYc1kN/f2yfMLwBm+UtZb0YrXgPF5BjhMtIfgQoX4xVzEZz5mGM?=
 =?us-ascii?Q?uzw5UlhMgUZHWxopg2E4RAmS1S9sW4ViIUYnbCp7xtUle7A/UKiBDc6IlWFI?=
 =?us-ascii?Q?bNpSim0aaC0RMzw+rGnE7JUUsd2omt6NbW/Um9tn/f0AQoBzWm5ur2Nv35U5?=
 =?us-ascii?Q?0IQQLQ6c6jF4PgTP8FR/nATDxZVKHADkf17gbRVNwtmdmt0QqYEO/CeJ5/VD?=
 =?us-ascii?Q?rtXBaXw6ltZ7OmqeEU9FnPHH/iacEcHd6krfTpmvc9NQdoBzcgh0dtwFiXAC?=
 =?us-ascii?Q?vWB8VMmQG5/yzFOs/spAYH8IJYaZvrmiSTCKx4Yru2D7kbM80YUipnOs4cjO?=
 =?us-ascii?Q?2+wC+z8rJ+tnPEL0DGTfKm9kTZqmcEYmd5p7IjJFQKkd+dzgmxS2bDuR8L+8?=
 =?us-ascii?Q?xGl7p8pjCLQn602lE18YAST0cqU0GWZyGDK2L2jdaGcEb7MPNgMTNdTKmMx4?=
 =?us-ascii?Q?U7Aefkz9PGsr/z9JCli7uxX+oNt4NMkB8/flqMgnaf9pjsqj+IrsQO+CZm/K?=
 =?us-ascii?Q?dnYZqG7ffEQUHonWJwm/jv2kDlJjYKOr2P2xq13GgATZjojWenu/YbLoDZHu?=
 =?us-ascii?Q?mXKH+VC+6pwcvBKhQ4g9PFv8+wcASPGFBydeaeq26KC9AupBLXceYdHs330U?=
 =?us-ascii?Q?V5yi6Llr6mvGT5WBDuopqtL0GQ/YFfQyhbINFbJOZBBbcZL6r1nrXUI9Be+n?=
 =?us-ascii?Q?qUkBohI9XsTpHZrwNJaexeQxztowN6czEmZtsHRK6/Y9MdwTRGwiuX+BGxri?=
 =?us-ascii?Q?ui/kPpp5UxSc75p93n8l3G7qt3GNP9ZWu9dAFWYwQETUqg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SWQKmOD6DOYtfT612YysRtDbA81NAkBtY0mkj05bgdXjhKO5JglEpJ9/MC1w?=
 =?us-ascii?Q?hSt3z9D5+ctTweBTEyA7MMZbmcVzyrIvX5XL9BfoqT23n7+HPumVoValAGrc?=
 =?us-ascii?Q?lYyEltUsIUqNCEh8Cdjid1j5cMMSnludk13qn/TnpWUsvjQ2Qc8yD7iHt/K+?=
 =?us-ascii?Q?JXCHUNWncA2MATR+LZrSxeZhKHt+qK33ssKGd1BsuDkKFlWfuhDv1d/fpEaW?=
 =?us-ascii?Q?6iXCvYc4Bnd/vyK/E+8tklfzmEP4SQcCV4EAaUNkiaLremcVfEqSkOCEP6PO?=
 =?us-ascii?Q?AcOL6OvVYI5UbodzARHBPbmX2TpKd/xhSUYRayvMTHlJN9bkDSskfYz1kC1q?=
 =?us-ascii?Q?jyED30jMIp1C0gBVHi1gApcFe8GJ84VIfOa5crX9YRlmphmcJFV3mCwqQJ8N?=
 =?us-ascii?Q?AwFd0+/Vh43ho0FBxjxgbb5i++9kWr8wEmr9Dv8T1Gi2LnuFrsiLLlMjtE9S?=
 =?us-ascii?Q?c0hdxiK9oH6lKfD5mXEt8SWXcYQmxFO+FYR3s1Js8TmT8L/Wtx3Kpjj3/VxE?=
 =?us-ascii?Q?xUfyGUjX9N7Ddm62LWYtKrgKgVOOZyyCMJNrkyjfn1lq23NUAVG/ixZGcWR7?=
 =?us-ascii?Q?sTA892QxN5AixB/Ym2g4AkVYVPChb84ij0TnQoIW3EynVTL7kfAGjA/HdMxm?=
 =?us-ascii?Q?aE9nflRdpADBydj+Pd5/En9ulA4bYqjpTS+/kPK9NgDnLjfmoiPt268d5ihz?=
 =?us-ascii?Q?E/VpoSGltt+Yht+0+kU2CifjOm0yhVWQDXG1hwawhkTRkqiO99ftXQuc5s/n?=
 =?us-ascii?Q?BGWp7fSuCUcFe8SsX+LLu7DG2BEhvPGcM97M7Q/GRR4djGD/Hjn98Z0NgTGW?=
 =?us-ascii?Q?WyGGygO/SoLw43vWOFQF3+spKHQ9UGdaF/u67LLas6zG7EloTe6sbudNpSoI?=
 =?us-ascii?Q?jgpC53g5pQtfylR7J1Yx/NzpGGh/9LTZbUxVFLwYTu2JMenWcZ61Ip05sjn+?=
 =?us-ascii?Q?W19Pxqd0EvXQIb3J6WI9nGbQTsuhNivjQjVtm+qPMJyOmG+lWovBXGhn07GT?=
 =?us-ascii?Q?rCBoIM3OhF9HR3CF/3KEjQuIFVnUpq6LYtfaYewOCPzPdyrB0Hjz+c7ZsgQA?=
 =?us-ascii?Q?22dk42lehMYuAuuGqP6XumWUHJxcPFOm/Ksw028ApyY0ydDLafa0uSq7lDxp?=
 =?us-ascii?Q?Cm2lS0Yr6fGooTNxKYeer7cVf4Bl7VNFIMLeQUfH7KK5Gn02owjvW/8vt9ew?=
 =?us-ascii?Q?blEmAWWsWgA9nXIk1u9e5aYU+5X+dWKB2cxsu5NGNDV4im14aHjn9qWxHV1K?=
 =?us-ascii?Q?7biQ+VRCPxNfFoGL/FGuPTWKIcyL9T/5f8lUkKPDbot0MMieyS63p0rjeRZN?=
 =?us-ascii?Q?DDYZnOiy9IVbmy/HAw2yxFkvx2rMF3cyuC+yZEelcSiZmh+5C4VK4JtXsiWZ?=
 =?us-ascii?Q?E+QF0xgvSxO+UluY8QmVd0cuGXJ43jJ5yjVRxkGAwZtKF4BabLUHFlQrxiAU?=
 =?us-ascii?Q?9NfhWkTzYbuziEh0ec9OlLkuXtkVmT57TUlKt5P0e0fA9xG5MC4uQwAHSt8B?=
 =?us-ascii?Q?nJT9B9V0Gu6/zRl9jEoLT8pPaiBI1Y1bUBR8JyNQvOpmE0SxAGkvzHhYL9AQ?=
 =?us-ascii?Q?sQ0odpliaz+Dk3MvIBfl/O74rUPE8fKVKo4sW4+5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8f4793-c565-401b-312d-08dc7676a821
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 13:38:37.8402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7DEZ54ZdoZoWJg7WQw25cBKXte0Pxhv0/5g5RDxWz9Wwon8/TCuWRiNuF0gUSCfib/oLavnheOOBsDjfDJJ99A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5997
X-OriginatorOrg: intel.com

Snip log for kernel build:


...
  CC [M]  drivers/crypto/intel/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.o
  LD [M]  drivers/staging/most/i2c/most_i2c.o
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_pin_dbg_show':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:169:14: note: in expansion of macro 'CLASS'
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |              ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:632:9: note: in expansion of mac=
ro 'scoped_guard'
  632 |         scoped_guard(hard_spinlock_irqsave, &chv_lock) {
      |         ^~~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:632:9: error: cleanup argument n=
ot a function
  CC      drivers/mmc/core/host.o
  CC [M]  drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.o
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/cleanup.h:120:17: error: implicit declaration of function '=
class_hard_spinlock_irqsave_constructor'; did you mean 'class_raw_spinlock_=
irqsave_constructor'? [-Werror=3Dimplicit-function-declaration]
  120 |                 class_##_name##_constructor
      |                 ^~~~~~
./include/linux/cleanup.h:169:14: note: in expansion of macro 'CLASS'
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |              ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:632:9: note: in expansion of mac=
ro 'scoped_guard'
  632 |         scoped_guard(hard_spinlock_irqsave, &chv_lock) {
      |         ^~~~~~~~~~~~
./include/linux/cleanup.h:169:9: error: declaration of non-variable 'class_=
hard_spinlock_irqsave_constructor' in 'for' loop initial declaration
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |         ^~~
drivers/pinctrl/intel/pinctrl-cherryview.c:632:9: note: in expansion of mac=
ro 'scoped_guard'
  632 |         scoped_guard(hard_spinlock_irqsave, &chv_lock) {
      |         ^~~~~~~~~~~~
  LD [M]  drivers/staging/most/net/most_net.o
  CC [M]  drivers/hwtracing/intel_th/acpi.o
  CC [M]  drivers/platform/surface/surface_aggregator_cdev.o
./include/linux/cleanup.h:166:28: error: implicit declaration of function '=
class_hard_spinlock_irqsave_lock_ptr'; did you mean 'class_raw_spinlock_irq=
save_lock_ptr'? [-Werror=3Dimplicit-function-declaration]
  166 | #define __guard_ptr(_name) class_##_name##_lock_ptr
      |                            ^~~~~~
./include/linux/cleanup.h:170:28: note: in expansion of macro '__guard_ptr'
  170 |              *done =3D NULL; __guard_ptr(_name)(&scope) && !done; d=
one =3D (void *)1)
      |                            ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:632:9: note: in expansion of mac=
ro 'scoped_guard'
  632 |         scoped_guard(hard_spinlock_irqsave, &chv_lock) {
      |         ^~~~~~~~~~~~
  CC      drivers/devfreq/governor_performance.o
  CC [M]  drivers/pinctrl/pinctrl-mcp23s08.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_pinmux_set_mux=
':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:671:9: note: in expansion of mac=
ro 'guard'
  671 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC [M]  drivers/ufs/core/ufs-debugfs.o
drivers/pinctrl/intel/pinctrl-cherryview.c:671:9: error: cleanup argument n=
ot a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard484' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:671:9: note: in expansion of mac=
ro 'guard'
  671 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC      drivers/devfreq/governor_powersave.o
  CC      drivers/extcon/devres.o
  CC [M]  drivers/staging/media/ipu3/ipu3-css.o
  CC [M]  drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.o
  CC [M]  drivers/pinctrl/intel/pinctrl-alderlake.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_request_e=
nable':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:747:9: note: in expansion of mac=
ro 'guard'
  747 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:747:9: error: cleanup argument n=
ot a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard487' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:747:9: note: in expansion of mac=
ro 'guard'
  747 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC [M]  drivers/staging/vt6655/baseband.o
  CC [M]  drivers/staging/sm750fb/ddk750_mode.o
  CC [M]  drivers/pinctrl/intel/pinctrl-broxton.o
  CC [M]  drivers/staging/fbtft/fbtft-core.o
  CC [M]  drivers/staging/sm750fb/ddk750_display.o
  CC [M]  drivers/platform/chrome/chromeos_laptop.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_disable_f=
ree':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:796:9: note: in expansion of mac=
ro 'guard'
  796 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:796:9: error: cleanup argument n=
ot a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard488' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:796:9: note: in expansion of mac=
ro 'guard'
  796 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC [M]  drivers/ras/amd/atl/denormalize.o
  LD [M]  drivers/virt/vboxguest/vboxguest.o
  CC [M]  drivers/mmc/host/sdhci-pci-o2micro.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_set_direc=
tion':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:811:9: note: in expansion of mac=
ro 'guard'
  811 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:811:9: error: cleanup argument n=
ot a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard489' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:811:9: note: in expansion of mac=
ro 'guard'
  811 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC [M]  drivers/staging/sm750fb/ddk750_swi2c.o
  AR      drivers/clocksource/built-in.a
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_config_get':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:169:14: note: in expansion of macro 'CLASS'
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |              ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:842:9: note: in expansion of mac=
ro 'scoped_guard'
  842 |         scoped_guard(hard_spinlock_irqsave, &chv_lock) {
      |         ^~~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:842:9: error: cleanup argument n=
ot a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/cleanup.h:169:9: error: declaration of non-variable 'class_=
hard_spinlock_irqsave_constructor' in 'for' loop initial declaration
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |         ^~~
drivers/pinctrl/intel/pinctrl-cherryview.c:842:9: note: in expansion of mac=
ro 'scoped_guard'
  842 |         scoped_guard(hard_spinlock_irqsave, &chv_lock) {
      |         ^~~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_config_set_pul=
l':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:922:9: note: in expansion of mac=
ro 'guard'
  922 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:922:9: error: cleanup argument n=
ot a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard490' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:922:9: note: in expansion of mac=
ro 'guard'
  922 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_config_set_ode=
n':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:983:9: note: in expansion of mac=
ro 'guard'
  983 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:983:9: error: cleanup argument n=
ot a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard491' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:983:9: note: in expansion of mac=
ro 'guard'
  983 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC      drivers/interconnect/debugfs-client.o
  CC [M]  drivers/pinctrl/intel/pinctrl-cannonlake.o
  CC [M]  drivers/staging/vt6656/usbpipe.o
  CC [M]  drivers/staging/vt6655/rxtx.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_get':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:169:14: note: in expansion of macro 'CLASS'
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |              ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1104:9: note: in expansion of ma=
cro 'scoped_guard'
 1104 |         scoped_guard(hard_spinlock_irqsave, &chv_lock)
      |         ^~~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1104:9: error: cleanup argument =
not a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/cleanup.h:169:9: error: declaration of non-variable 'class_=
hard_spinlock_irqsave_constructor' in 'for' loop initial declaration
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |         ^~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1104:9: note: in expansion of ma=
cro 'scoped_guard'
 1104 |         scoped_guard(hard_spinlock_irqsave, &chv_lock)
      |         ^~~~~~~~~~~~
  CC [M]  drivers/staging/vt6656/channel.o
  CC      drivers/mmc/core/mmc.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_set':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1120:9: note: in expansion of ma=
cro 'guard'
 1120 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1120:9: error: cleanup argument =
not a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard494' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1120:9: note: in expansion of ma=
cro 'guard'
 1120 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC [M]  drivers/pinctrl/intel/pinctrl-cedarfork.o
  CC [M]  drivers/extcon/extcon-adc-jack.o
  CC [M]  drivers/pinctrl/intel/pinctrl-denverton.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_get_direc=
tion':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:169:14: note: in expansion of macro 'CLASS'
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |              ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1137:9: note: in expansion of ma=
cro 'scoped_guard'
 1137 |         scoped_guard(hard_spinlock_irqsave, &chv_lock)
      |         ^~~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1137:9: error: cleanup argument =
not a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/cleanup.h:169:9: error: declaration of non-variable 'class_=
hard_spinlock_irqsave_constructor' in 'for' loop initial declaration
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |         ^~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1137:9: note: in expansion of ma=
cro 'scoped_guard'
 1137 |         scoped_guard(hard_spinlock_irqsave, &chv_lock)
      |         ^~~~~~~~~~~~
  CC [M]  drivers/crypto/atmel-i2c.o
  CC      drivers/mmc/core/mmc_ops.o
  CC [M]  drivers/ufs/core/ufs_bsg.o
  CC [M]  drivers/staging/sm750fb/ddk750_dvi.o
  CC      drivers/of/platform.o
  CC [M]  drivers/pinctrl/intel/pinctrl-elkhartlake.o
  CC      drivers/mmc/core/sd.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_irq_ack':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_t'; did you mean 'class_raw_spinlock_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1179:9: note: in expansion of ma=
cro 'guard'
 1179 |         guard(hard_spinlock)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1179:9: error: cleanup argument =
not a function
  CC [M]  drivers/ufs/core/ufshcd-crypto.o
  CC [M]  drivers/crypto/ccp/ccp-dev.o
  CC [M]  drivers/platform/surface/surface_aggregator_hub.o
  CC [M]  drivers/crypto/ccp/ccp-ops.o
  CC      drivers/dpll/dpll_core.o
  CC      drivers/devfreq/governor_userspace.o
  CC      drivers/dpll/dpll_netlink.o
  CC [M]  drivers/pinctrl/intel/pinctrl-emmitsburg.o
  CC      drivers/mmc/core/sd_ops.o
  CC      drivers/of/property.o
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/cleanup.h:120:17: error: implicit declaration of function '=
class_hard_spinlock_constructor'; did you mean 'class_raw_spinlock_construc=
tor'? [-Werror=3Dimplicit-function-declaration]
  120 |                 class_##_name##_constructor
      |                 ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1179:9: note: in expansion of ma=
cro 'guard'
 1179 |         guard(hard_spinlock)(&chv_lock);
      |         ^~~~~
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard495' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1179:9: note: in expansion of ma=
cro 'guard'
 1179 |         guard(hard_spinlock)(&chv_lock);
      |         ^~~~~
  CC      drivers/dpll/dpll_nl.o
  CC      drivers/of/kobj.o
  CC      drivers/mmc/core/sdio.o
  CC [M]  drivers/staging/media/av7110/av7110_hw.o
  CC      drivers/mmc/core/sdio_ops.o
  CC [M]  drivers/staging/rts5208/rtsx_scsi.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_irq_mask_=
unmask':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1192:9: note: in expansion of ma=
cro 'guard'
 1192 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1192:9: error: cleanup argument =
not a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard496' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1192:9: note: in expansion of ma=
cro 'guard'
 1192 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC [M]  drivers/crypto/intel/qat/qat_common/adf_cfg.o
  CC      drivers/mmc/core/sdio_bus.o
  CC [M]  drivers/pinctrl/pinctrl-tps6594.o
  CC [M]  drivers/staging/rts5208/rtsx_card.o
  CC      drivers/devfreq/governor_passive.o
  CC [M]  drivers/extcon/extcon-axp288.o
  LD [M]  drivers/crypto/intel/qat/qat_dh895xcc/qat_dh895xcc.o
  CC [M]  drivers/staging/rts5208/general.o
  CC [M]  drivers/hwtracing/intel_th/gth.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_irq_start=
up':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:169:14: note: in expansion of macro 'CLASS'
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |              ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1244:9: note: in expansion of ma=
cro 'scoped_guard'
 1244 |         scoped_guard(hard_spinlock_irqsave, &chv_lock) {
      |         ^~~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1244:9: error: cleanup argument =
not a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/cleanup.h:169:9: error: declaration of non-variable 'class_=
hard_spinlock_irqsave_constructor' in 'for' loop initial declaration
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |         ^~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1244:9: note: in expansion of ma=
cro 'scoped_guard'
 1244 |         scoped_guard(hard_spinlock_irqsave, &chv_lock) {
      |         ^~~~~~~~~~~~
  CC [M]  drivers/mmc/host/sdhci-pci-arasan.o
  CC      drivers/leds/led-core.o
  CC [M]  drivers/extcon/extcon-fsa9480.o
  CC [M]  drivers/staging/gdm724x/gdm_mux.o
  CC      drivers/hv/channel.o
  CC [M]  drivers/mmc/host/sdhci-pci-dwc-mshc.o
  CC [M]  drivers/mmc/host/sdhci-pci-gli.o
  CC      drivers/mmc/core/sdio_cis.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_irq_type'=
:
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1336:9: note: in expansion of ma=
cro 'guard'
 1336 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1336:9: error: cleanup argument =
not a function
  CC [M]  drivers/pinctrl/intel/pinctrl-geminilake.o
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard501' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1336:9: note: in expansion of ma=
cro 'guard'
 1336 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC      drivers/hv/channel_mgmt.o
  CC [M]  drivers/vdpa/vdpa.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_irq_handl=
er':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:169:14: note: in expansion of macro 'CLASS'
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |              ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1408:9: note: in expansion of ma=
cro 'scoped_guard'
 1408 |         scoped_guard(hard_spinlock_irqsave, &chv_lock)
      |         ^~~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1408:9: error: cleanup argument =
not a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/cleanup.h:169:9: error: declaration of non-variable 'class_=
hard_spinlock_irqsave_constructor' in 'for' loop initial declaration
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |         ^~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1408:9: note: in expansion of ma=
cro 'scoped_guard'
 1408 |         scoped_guard(hard_spinlock_irqsave, &chv_lock)
      |         ^~~~~~~~~~~~
  CC      drivers/of/fdt.o
  CC [M]  drivers/staging/media/av7110/av7110_v4l.o
  CC [M]  drivers/ras/amd/atl/map.o
  CC [M]  drivers/platform/chrome/chromeos_privacy_screen.o
  CC [M]  drivers/crypto/intel/qat/qat_c62xvf/adf_drv.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_pinctrl_mmio_a=
ccess_handler':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1599:9: note: in expansion of ma=
cro 'guard'
 1599 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1599:9: error: cleanup argument =
not a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard502' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1599:9: note: in expansion of ma=
cro 'guard'
 1599 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC [M]  drivers/staging/rtl8712/rtl8712_cmd.o
  CC [M]  drivers/platform/chrome/chromeos_pstore.o
  CC [M]  drivers/extcon/extcon-gpio.o
  CC [M]  drivers/extcon/extcon-intel-int3496.o
  CC      drivers/leds/led-class.o
  CC [M]  drivers/crypto/intel/qat/qat_c62xvf/adf_c62xvf_hw_data.o
  CC [M]  drivers/crypto/intel/qat/qat_common/adf_isr.o
  CC [M]  drivers/crypto/intel/qat/qat_common/adf_ctl_drv.o
  CC [M]  drivers/crypto/ccp/ccp-dev-v3.o
  AR      drivers/staging/vme_user/built-in.a
  CC [M]  drivers/staging/pi433/pi433_if.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_pinctrl_suspen=
d_noirq':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1712:9: note: in expansion of ma=
cro 'guard'
 1712 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1712:9: error: cleanup argument =
not a function
  CC [M]  drivers/staging/rts5208/sd.o
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard503' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1712:9: note: in expansion of ma=
cro 'guard'
 1712 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  AR      drivers/powercap/built-in.a
  CC [M]  drivers/staging/fbtft/fbtft-sysfs.o
  LD [M]  drivers/crypto/intel/qat/qat_c62x/qat_c62x.o
  CC [M]  drivers/staging/pi433/rf69.o
  CC [M]  drivers/hsi/hsi_core.o
  CC [M]  drivers/hwtracing/intel_th/sth.o
  CC [M]  drivers/accel/habanalabs/common/mmu/mmu.o
  CC [M]  drivers/pinctrl/intel/pinctrl-icelake.o
  LD [M]  drivers/crypto/intel/qat/qat_dh895xccvf/qat_dh895xccvf.o
  CC [M]  drivers/parport/share.o
  CC [M]  drivers/staging/fbtft/fbtft-bus.o
  CC [M]  drivers/staging/rts5208/xd.o
  CC [M]  drivers/parport/ieee1284.o
  CC [M]  drivers/crypto/ccp/ccp-dev-v5.o
  CC [M]  drivers/accel/habanalabs/common/mmu/mmu_v1.o
  CC [M]  drivers/staging/rts5208/ms.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_pinctrl_resume=
_noirq':
  CC [M]  drivers/staging/media/ipu3/ipu3-v4l2.o
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1739:9: note: in expansion of ma=
cro 'guard'
 1739 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC [M]  drivers/accel/habanalabs/common/mmu/mmu_v2.o
drivers/pinctrl/intel/pinctrl-cherryview.c:1739:9: error: cleanup argument =
not a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard504' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1739:9: note: in expansion of ma=
cro 'guard'
 1739 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC [M]  drivers/parport/ieee1284_ops.o
  CC [M]  drivers/platform/chrome/chromeos_tbmc.o
  CC      drivers/platform/x86/amd/wbrf.o
  LD [M]  drivers/crypto/intel/qat/qat_c3xxx/qat_c3xxx.o
cc1: some warnings being treated as errors
make[8]: *** [scripts/Makefile.build:244: drivers/pinctrl/intel/pinctrl-che=
rryview.o] Error 1
make[8]: *** Waiting for unfinished jobs....
  LD [M]  drivers/virt/acrn/acrn.o

...

Best regards,
Ionut Nechita.

-----Original Message-----
From: Nechita, Ionut=20
Sent: Friday, May 17, 2024 4:23 PM
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Subject: RE: WARN Kernel v6.9-evl-rebase - do_int80_emulation

This is happened when CONFIG_DOVETAIL is =3Dn and CONFIG_EVL is =3Dn in .co=
nfig.
When using disable this and using generic configuration/flavour; CONFIG_PIN=
CTRL_CHERRYVIEW with =3Dy is not build.=20
Maybe rebase is not fully completed on 6.9-rebase-evl.


Will try to append kernel log build.

Best regards,
Ionut Nechita.

-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>=20
Sent: Friday, May 17, 2024 4:16 PM
To: Nechita, Ionut <ionut.nechita@intel.com>
Cc: xenomai@lists.linux.dev
Subject: Re: WARN Kernel v6.9-evl-rebase - do_int80_emulation


"Nechita, Ionut" <ionut.nechita@intel.com> writes:

> Clean now in dmesg.=20
> Warn message not appear.
> This patch is fine.
>
> But I notice issue on compiling CONFIG_PINCTRL_CHERRYVIEW at builtin opti=
on.
> Kernel failing when CONFIG_PINCTRL_CHERRYVIEW is =3Dy.
>
> I use CONFIG_PINCTRL_CHERRYVIEW=3Dn to compiling your change.
>

There must be something else at work. Builds fine here with CONFIG_PINCTRL_=
CHERRYVIEW=3Dy.

The failing build log would help.

--
Philippe.
