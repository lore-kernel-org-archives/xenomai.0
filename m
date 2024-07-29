Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D8C140E29
	for <xenomai@lists.linux.dev>; Mon, 29 Jul 2024 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251377; cv=fail; b=TS4d7VDOIxIFvggwMJksZICPW5/uCWM1cQtLCK8Ia0K7PeuqmeJFxfFaPm/mn7tqFLyaxqyGAEsNX6JmYzUNrtLiJSfTETSZ30T0VqlWGBPhidgOYLAkO2A5DHuBCLTSsvJ0FNN1l69x6gsJVJ1sH9bqX0ydjbw9339rMtU7SVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251377; c=relaxed/simple;
	bh=OCL550fqUF7aves3xF8eyzoIheHw0W/A0/S52ugKUhU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JZYnRJgt0Af7eZqhAqxXLNFq9kNCTYTCssysfQKtDhoI78LKfJ/2EFD5S8yozryjghq4xDCQJ/yFER0uXk0jZPAXjKYEHIVdDxQ7vptSiTjswSAYmT5d6TtpRJfzlXzJ/XIE79mhkBS7KRIN/opzxZDtUlYc9SKA7x8xCcIoP8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ndiV7lXz; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ndiV7lXz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722251376; x=1753787376;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OCL550fqUF7aves3xF8eyzoIheHw0W/A0/S52ugKUhU=;
  b=ndiV7lXz3V1z9+uQGoPP438RfJvqC+4m7ZcU3SR2cCThQ+0qJ340IGOr
   qqs1aw4fe3ivNun+WwdSyzB1eVEdthcVvVoqXYZevqOthcNgDIbsPTigx
   hm8b8Zoq7BDsHliPn835doDTUSWypfPWQZj/n32mvnpZQqcfrLpMrN/Qi
   wXk8y7l+wrh6YL3iu372KfEvLBm7rTamhQ32iLwMKYpm9xI1I/FhV1uU2
   EbOcuqIIcVfKI7E8P3wy9L4Ny3X0H0kfuX0D5S//OgErma8QJUAm16tcY
   dPc0+p7SpBxBmNi8t3A4bMbEvKTwowborUQuhGnJpsnV8fDSksHOsL1Ok
   w==;
X-CSE-ConnectionGUID: zZvyKz7STPqry1MWMPAB1A==
X-CSE-MsgGUID: WlCXYfviR8GBulBCuGjdFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="19949247"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="19949247"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 04:09:35 -0700
X-CSE-ConnectionGUID: kcCT1/BnQqipSIr7pcG6BQ==
X-CSE-MsgGUID: 4dFhxEKQT3258IPuYhUw+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="77180311"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jul 2024 04:09:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 04:09:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 04:09:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 29 Jul 2024 04:09:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 04:09:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVUsR/Gsf2Z/pbMbS1xOHA4/WpjpTdQPyl1XstafNuomdfMY8UxRaqKTyebX2L6cpk7Vm1/emrUIbGgKkla6IO5jgPBH8v4KTdpDTIGH97grp3pBDJgbQf2p9PI/mvRdQe7NW9hAQKpQr/l7mpN/3otKTE+IA1qdVHmrgldJFIPdxhPR1wZ1CEY/N98FVB4OAVNie8CnkLUVpveit0x/ZQdItMyp3j8Xp80RQkR3i8kmet+gTC+AllPAD4aMXjanU0fyTXdhdze7W8Sp3QEMsxPh8C1UZ2AS9+OlTGzHD/rtQG/UwwF240o3W/NS5BfnjQIGsYAJPXVaDL+P4OHV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/tHb4VFp8m4/GR0YBZz3kdNO4K112VYj09i7sYvVy4=;
 b=AM1Bd19FFFRkK4qNdVJZoXgrArLSkXRYyvLCxYd6bshKNZBH0AVR/TCavvcMTw4JFnGOuhroS7D+WJ8PAhh6DK1sFXfJBiSMM+V8UAxkVxu4DniArAZefScsZeN3jbD/wwO9P+/4rVqc0gr0UebktxNPjkKaHl2c17G177jaDQqtjxAC7+nhWB83kzx5AvLNwX546cvfZkIrprtAR6P5gkHaRDu706irAKbMoJPGnVb7+e1vhDmluHBlCd/srBi8Dg+ZiFJ+URrElchqOxGm0pawYZnj9OuS7JnqlfVUwcxez+1+onn1/sYzKv8dGQErLE2J8mPI9Lh+2WS8PfpFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by SN7PR11MB6604.namprd11.prod.outlook.com (2603:10b6:806:270::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 11:09:30 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%4]) with mapi id 15.20.7807.023; Mon, 29 Jul 2024
 11:09:30 +0000
From: "Nechita, Ionut" <ionut.nechita@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, Philippe Gerum
	<rpm@xenomai.org>
Subject: RE: FAIL Kernel v6.10-evl-rebase - EVL: In function
 'do_sysvec_inband': error: duplicate case value
Thread-Topic: FAIL Kernel v6.10-evl-rebase - EVL: In function
 'do_sysvec_inband': error: duplicate case value
Thread-Index: AQHa30gxte4UNNjgkke64hDODuBJLbIJYeYagADeCwCAAh7iL4ABMeiw
Date: Mon, 29 Jul 2024 11:09:30 +0000
Message-ID: <PH0PR11MB59491575F8AFF5D7DD7489FCF4B72@PH0PR11MB5949.namprd11.prod.outlook.com>
References: <PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87wmnmq8v9.fsf@xenomai.org>
	<PH0PR11MB59491C18ADB51F5FEAEF4B3FF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<PH0PR11MB59490B50D2D2717B8155EFCDF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87h6eprhbg.fsf@xenomai.org>
	<PH0PR11MB5949B24CB222FBB2D387BF24F4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87cypdr5fm.fsf@xenomai.org>
	<PH0PR11MB5949453FBEBCA4520CAF80A2F4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
	<PH0PR11MB5949D5E4DC2C8DF215617B6CF4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
	<87cyn03qxx.fsf@xenomai.org>
	<7edb3e30ad2fa511a189cf6262c5c7fa997d074f.camel@siemens.com>
 <8734nt31by.fsf@xenomai.org>
In-Reply-To: <8734nt31by.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5949:EE_|SN7PR11MB6604:EE_
x-ms-office365-filtering-correlation-id: c59b42dc-7b87-4889-58a5-08dcafbeeb50
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zyVPeWRomznr3avB1m8cGxp7XCWdmxi654iZwfpglIGwv+pW/mNx8OSLusVK?=
 =?us-ascii?Q?vINb5uTGQxT+nVO7HmikUgl+tKdTVX9muLzYG8NDmJoNjz3fLVA5HD02LYbP?=
 =?us-ascii?Q?ZMa8EP9akimHbRYslTx6RWGdsg3Kws/fQQYz9y+oUL45tHS1h4IJe7uIv5sk?=
 =?us-ascii?Q?RjxDC7fqgkhhXGbPHOwT6e7lkW2gGzT6wVZq91DFsFUh+viaK0XKw9ZsvRrC?=
 =?us-ascii?Q?+9K4J3xUtn7bRs5KibpTWChDPNUQb5Gf4O9+qpCx56jURJRt6O1TaKRLJ6Vq?=
 =?us-ascii?Q?JCsjXTBQb+DYPoTqBnsdNFzIDWhMS7DQARzMhqmKtjt0pVW08rklOHDa9EWh?=
 =?us-ascii?Q?6sP5MZNAJvP7GS0KMqIlk4esKROjKszUZKhIqrNVnGRU0SnQriUCiZUdD0ya?=
 =?us-ascii?Q?DuUD2dfVCp74+0ig3jdIqFQX/ZD4FVB5PT2SKaMzE2WHVuJ6P2zUKUb5hizt?=
 =?us-ascii?Q?kVVxPBMR7INlIz6Io6cCKACjk08w0yrFcXFqCmBzuh53RFUgtKOCpl7d21vH?=
 =?us-ascii?Q?GRymU/8He9OTsCzOyZ8+zgWbyA13okjuikU3xrHP4YL6JSZf8dTtpzSy3YYG?=
 =?us-ascii?Q?87djqtKCamnCwAXU400TEios6OiqYJ5G7xBA84KWjEvDqcQjDV+hfo/aD7d5?=
 =?us-ascii?Q?bykaquYmMfkCemY4WzbyJnGJkuWZ4Bi3XqLqB/AyL1sKSBReG3odWWJ4/ovt?=
 =?us-ascii?Q?gd3qcG2iCHPbKmq7yTnxznErsRRS38PPwsdS+UH2SNDDyFnSGo5tZ9oszkrl?=
 =?us-ascii?Q?UuWqNbBze0mYzbYLaFdJUloxwBOC4DZnPwjVe/Uh/Kg2nWtHOdgMW4tYofCG?=
 =?us-ascii?Q?MKkZ9mBtTgxbPBkcFWvHnpNRGDbpLV6PcPbp+AntHgyeAQnIVTQZkP1WPIdA?=
 =?us-ascii?Q?8Cr15aW4IsgM7gQG8+6/69rmFWaumUoG6WeQMdt4h6kEK5Jispn4EyX45zWY?=
 =?us-ascii?Q?y1nli8Gry2v1tgsPaZr7GuqFjG7DfTNn2dlG12jSk7lju/B50/9BGdjVSbcw?=
 =?us-ascii?Q?WzgQyBzoqiI+08P1zL31SvcqiZ6geOay+SSr6ckox5wMrQx08NupCVQnRHiQ?=
 =?us-ascii?Q?wCy1T0/rnA7/YqwE3VO6mwy/qDWbJnCMpda54HKEUOvh8QqkeRc3rL48hXjp?=
 =?us-ascii?Q?SvE51lQwPzF+0FRMo+wwHMGUy6RCMN/z1e3sq3oxatRY5YxwbNS8zcN4vjik?=
 =?us-ascii?Q?OyfRJELfeZJHpUGyuBM58CXH4okM8BFa71i74p0DZ79dGYSZx0A9UvrjqgfB?=
 =?us-ascii?Q?rpxqQba7nFDS/IozmvSuJyrGqEkK2uOJjHq7G6ZtG2eqfMF2EVYz1S5t93qJ?=
 =?us-ascii?Q?I+y/P95CBDGzA+U+lAejUHrSUoZSHbATO0ZifJFutqVUEN5dJbeLZ2p9IizU?=
 =?us-ascii?Q?Pz3TQ1GMj+sEpuW/nh7Etume3Np8CASw2wd2r+oDlPTg/YXijA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AKtv0/IKDMh7kHbLc6CONill0WTglsEgXikC1Wv0irSG79wHLyOl/KDW3WqK?=
 =?us-ascii?Q?j4GTDHRibFieF6wNYTsFk93VXkxIa18r8nK8+ScmxHWheUCnGkKtOkSXnB3B?=
 =?us-ascii?Q?3A6ex17/UADDOJtX6uNg39X5vTXdc2INRGPBL7h0W4WggKxu0TT6RuZfCv6S?=
 =?us-ascii?Q?pEOQivm340HGmbVj6y8hAQHaNLfFJcFe8g92Eh0m5DK2HiASNbnEg7KRjxCD?=
 =?us-ascii?Q?Ds+V0PE7KPJmIs/4TMEC+TrdkyOOvB2cZxETbFSL6cvTx5/+n8zt21SkVqYB?=
 =?us-ascii?Q?hL2q1wo6Iiox7TdW2Zf6vL+pEavrtwZ00UREciXT22D8FxKGlR2xCJr7ykj5?=
 =?us-ascii?Q?gHRGVImkqvxQplr3pC0H0WbDFdpKda75m8LkGIatDawNXKVtlgoSJlxPPQ2i?=
 =?us-ascii?Q?m1bsX71gfXF3lIjxHC4nKHW7cOKyIP8dvBI+DV1yHFj6GKtuqBndZoUlfDfX?=
 =?us-ascii?Q?rHV1RYGujMB9wcBpUASyAVtvwzq6g7UAz7m8j8zuxFhLGPJe9q5vkBi6jT12?=
 =?us-ascii?Q?Sh3WcPcdL0ZJkW98996bGHnNDAvKm1yo1sPERxL5Ga7HM9nNBjNP4ZV3ZYGm?=
 =?us-ascii?Q?AFLCcVxd7gPVWcHU8nox1R2X0ANDZLMPLxKeiBULp0NGe7q1Wgm9AaokzAfx?=
 =?us-ascii?Q?ernoLYF9SlrYyf8d+AXyAjtTFUNDM+oxo8oqPoegXNxuFIvx1thuLWjlMzjF?=
 =?us-ascii?Q?/cY7GQs0sg4KimlL/0RFWCqzJftdX/YXg2M/lfCdrs/Ti4WwyRs5kk/pYWQT?=
 =?us-ascii?Q?ndn7zMO3b6UcZWKKqDAxjKIFW316bqxdzz4P9u4aGctDkYK5Aan69ibptFcd?=
 =?us-ascii?Q?Q/rx+Xc9QTHRLKug/+myxAtS9zXaOvVwE4HN14+o0HVkc6xrJgsQNTMsK4sZ?=
 =?us-ascii?Q?dZlWV7EL6n5Ka8vsU6MgYayjXaYGvNOFbn965FVPRSp59/Vh6Ap845XDAZCs?=
 =?us-ascii?Q?5FlwBC4qhbKMq2Z3iy+cyuRQvw8tZniAKoyN4tEGjqcUKNqt/3j/Ih/ApmqJ?=
 =?us-ascii?Q?wTvXTLLOCv8vACqZHdSBJk+GrFswEajPuknyGVyKrDHmj5y/ak5eTarqQNFM?=
 =?us-ascii?Q?1ynnWYO/Vs9rNuzV7wj9uIp9n9Q5GeKvydr+re5Z9uzQSNJ7n8uPv1yfRvsB?=
 =?us-ascii?Q?An2Z7UnUDAE+tg4hDbBd9QHRCnif/58YHKvOlrr41pHTMgM0T5xfRa0XX9je?=
 =?us-ascii?Q?c6JplVK50SuOji1OIPx+20GeQ+ffeDjw6UV9r0fBsGFCBPsXlrT1ymJiA299?=
 =?us-ascii?Q?WSOl2o6VZ0C8jjcJEHH7qobHtgqse6EumPI4ybEuaa2s6Twha/73b3DFUnNi?=
 =?us-ascii?Q?X2d+OHxcfqQGnhQ1Agjp2oZ+SJww68jO76FVzeuwbgFvuPrTWBJNlLgWYrqj?=
 =?us-ascii?Q?RhaXfp5CN2dgZfxe2t2RJ6siMQNGyM/MnQbFdkhDyWla8CxQSoe4wFHhe4Eb?=
 =?us-ascii?Q?ptp8ZOdm50qJRflcx4zHmXUglCVJhbrSisz2rtbqMBhQrTbpb/qMUw8WmvEe?=
 =?us-ascii?Q?bFVFwPfj9P9odua1gosUWYsf9ip0AVFROI1vh3NM0/JYBwClKGmuaOjuo6FQ?=
 =?us-ascii?Q?oyb2ytDjh/RToIPOWwzkFEVWkmL+vux/O0zuPS0O?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c59b42dc-7b87-4889-58a5-08dcafbeeb50
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 11:09:30.5918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oeQfQuH4aUunwhK0Ipwsp/EqpLPRiy8xhIDE7+QqvL3LGH3ErqVKFsev7LNK48Be7y+P8dZL6MRRt9KHFjsBGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6604
X-OriginatorOrg: intel.com

In this case exist one fix for this?

BR,
Ionut Nechita



-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>=20
Sent: Sunday, July 28, 2024 7:53 PM
To: Bezdeka, Florian <florian.bezdeka@siemens.com>
Cc: Nechita, Ionut <ionut.nechita@intel.com>; xenomai@lists.linux.dev
Subject: Re: FAIL Kernel v6.10-evl-rebase - EVL: In function 'do_sysvec_inb=
and': error: duplicate case value


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Fri, 2024-07-26 at 21:15 +0200, Philippe Gerum wrote:
>> "Nechita, Ionut" <ionut.nechita@intel.com> writes:
>>=20
>> > Hi Xenomai Kernel Team,
>> >=20
>> > I notice today one issue when compiling latest version, v6.10-evl-reba=
se.
>> >=20
>> > > > > error: duplicate case value
>> >   160 |         case HYPERVISOR_CALLBACK_VECTOR:
>> >=20
>> > # make -j208 bindeb-pkg  LOCALVERSION=3D"-1-lowlatency-evl" ARCH=3Dx86=
_64
>> >   GEN     debian
>> > Using default distribution of 'unstable' in the changelog Install=20
>> > lsb-release or set $KDEB_CHANGELOG_DIST explicitly=20
>> > dpkg-buildpackage --build=3Dbinary --no-pre-clean --unsigned-changes=20
>> > -R'make -f debian/rules' -j1 -a$(cat debian/arch)
>> > dpkg-buildpackage: info: source package linux-upstream
>> > dpkg-buildpackage: info: source version 6.10.0-g9ba4271318cf-4
>> > dpkg-buildpackage: info: source distribution unstable
>> > dpkg-buildpackage: info: source changed by root <root@0296de802d65>
>> > dpkg-buildpackage: info: host architecture amd64  dpkg-source=20
>> > --before-build .
>> >  make -f debian/rules binary
>> > #
>> > # No change to .config
>> > #
>> > mkdir -p /srv/tmpfs-disk1/build/linux-evl/tools/objtool && make O=3D/s=
rv/tmpfs-disk1/build/linux-evl subdir=3Dtools/objtool --no-print-directory =
-C objtool
>> >   INSTALL libsubcmd_headers
>> >   CALL    scripts/checksyscalls.sh
>> >   UPD     init/utsversion-tmp.h
>> >   CC      init/version.o
>> >   AR      init/built-in.a
>> >   CHK     kernel/kheaders_data.tar.xz
>> >   CC      arch/x86/kernel/irq_pipeline.o
>> > arch/x86/kernel/irq_pipeline.c: In function 'do_sysvec_inband':
>> > arch/x86/kernel/irq_pipeline.c:160:9: error: duplicate case value
>> >   160 |         case HYPERVISOR_CALLBACK_VECTOR:
>> >       |         ^~~~
>> > arch/x86/kernel/irq_pipeline.c:154:9: note: previously used here
>> >   154 |         case HYPERVISOR_CALLBACK_VECTOR:
>> >       |         ^~~~
>> > make[7]: *** [scripts/Makefile.build:244:=20
>> > arch/x86/kernel/irq_pipeline.o] Error 1
>> > make[7]: *** Waiting for unfinished jobs....
>> > make[6]: *** [scripts/Makefile.build:485: arch/x86/kernel] Error 2
>> > make[5]: *** [scripts/Makefile.build:485: arch/x86] Error 2
>> > make[5]: *** Waiting for unfinished jobs....
>> > make[4]: *** [Makefile:1934: .] Error 2
>> > make[3]: *** [debian/rules:74: build-arch] Error 2
>> > dpkg-buildpackage: error: make -f debian/rules binary subprocess=20
>> > returned exit status 2
>> > make[2]: *** [scripts/Makefile.package:121: bindeb-pkg] Error 2
>> > make[1]: *** [/srv/tmpfs-disk1/build/linux-evl/Makefile:1555:=20
>> > bindeb-pkg] Error 2
>> > make: *** [Makefile:240: __sub-make] Error 2
>> >=20
>> >=20
>> > BR,
>> > Ionut Nechita
>>=20
>> Mm, do_sysvec_inband() is wrong when it comes to dealing with=20
>> HYPERVISOR_CALLBACK_VECTOR. We need a global pointer to the=20
>> hypervisor-specific handler, that would be set up by the guest init=20
>> code which traps the vector. We cannot ask do_sysvec_inband() to=20
>> figure out this information, it depends on which hypervisor trapped=20
>> that vector in the first place.
>
> Exactly. It was me duplicating the "wrong" ACRN implementation while=20
> introducing the async page fault handling for KVM.
>

Strictly speaking, the bug was there prior to that addition, the async pf p=
atch only revealed it (I'm hereby claiming authorship of that bug! :)

> I think there is no way to look at the IDT and check which gate was=20
> loaded by the hypervisor guest code.
>
> I haven't checked yet if that would work, but at least the KVM=20
> implementation enables a static branch (kvm_async_pf_enabled) when=20
> loading the IDT gate. Maybe we can check if this one is active. If so,=20
> it's KVM we are running on.

kvm_async_pf_enabled seems to be controlled by a paravirt capability flag. =
Would we receive significant information from
kvm_arch_para_features() <- cpuid_eax() in case KVM is not there?

>
> There seems no such static branch for the ACRN code...
>>

IIUC, we cannot have more than a single guest allowed to hook that vector a=
nyway, so could we just track who's doing that in the places where this vec=
tor is trapped, e.g. by setting up some global function pointer referring t=
o the proper handler which do_sysvec_inband() would call upon HYPERVISOR_CA=
LLBACK_VECTOR event?

--
Philippe.
