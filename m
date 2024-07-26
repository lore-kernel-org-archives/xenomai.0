Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9161E2B9C4
	for <xenomai@lists.linux.dev>; Fri, 26 Jul 2024 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721990424; cv=fail; b=LFzT+VMqT4PmwuYAfnLAi7VrdIDZuv9IVNUaANaZ7uAY2n8pdU58W4G5NohDuoZYSI/gobTQDCkkRBCIDyX6Qi3Y04TACAEdqdHNNZQV5kv/NQFTfMWMnLOPXagSUxggD1JTdHEGAmDR9VpX5/ZiKIPK4/305qDUWL9I1xgpXAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721990424; c=relaxed/simple;
	bh=D9kRX9tiQhZWB+DKnDla7Uc//FLYFcbdbnk/J7ifNYg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gialJiHcBodw6zNIBoGVWhpdmF40oW9F5u9s1kctjc1Zz4YFG7Z6ZqLv1/DgQPY/7iLvYJRzctq0bSpLnWehn+jc2ufBsQ2LA8Ozq8iBcs2L0f9kjAJ09oXDP10IELtw/d+Sb6zA1kJL0E30KaW9Gwos6FcnMVPVR7CuYlNNTCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kU2q6JYA; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kU2q6JYA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721990423; x=1753526423;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D9kRX9tiQhZWB+DKnDla7Uc//FLYFcbdbnk/J7ifNYg=;
  b=kU2q6JYAdul5OZgaYOsqyGRkJkVcqihkv6ylNI5aklkGE2Pdsf5YYqGU
   2hJwFe8nACBB30zKsHcm9KzDllqEmLlZhF8UpL8qHkP1cIwhBygRICHRS
   91GZx58XSpJs1+lzkPhiMmjOvElttWL/BdQL0OsyTV1YrefzgdaQgtav7
   7E0XVk9/JjOdg1wSRtVE1ScJ/UHbjnFWRmaQkingfsNdKnU8gn2b5kFwi
   +uDoiT+ZJP8I4lKTqG+YqKmDoxylQSBCebLvIhDA0nSPpjM841RYv8iv0
   8kdidQpqc8zdxZIkRr3AHVtMGGRowJLwq3LRbSXx4Rcty+4EeJnCcHMr6
   w==;
X-CSE-ConnectionGUID: DMhOIGu0Q8+KlcQlaBBZkA==
X-CSE-MsgGUID: 0WSEebWZQPOwaC4Jrmb8Sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19963405"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="19963405"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 03:40:22 -0700
X-CSE-ConnectionGUID: QU0DHddXScOLIcYDnjPUVA==
X-CSE-MsgGUID: Ow8K0RcuTTuRqf7p4DBW0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="84190222"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jul 2024 03:40:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 26 Jul 2024 03:40:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 26 Jul 2024 03:40:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 26 Jul 2024 03:40:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 26 Jul 2024 03:40:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYZhOoOyB7qLYj8AqKx2iMx6J474hjVgiK+J5wX96JcILNJsX062u8KBf0OLAXuaa25uO7h9xjAvO6NaRHGHZvL0tBtlwhX4ijnZzF4p1Lr8hSHwxpfoy6MtC7Ia/Xz3+oO7frl8APXkNZtQnigSIc5OoTtfJFxNt0g7sckskNLZRzTr92VlrE5UtCY1ZAhJGyjC9YQsWrNvwog6wPJvFLY3cmEVDJv9XW9ZJ8ZD2qt1FazMgemWqRlPf0N9kZD/w/Ld+KuAXrDNPRUUw3Hj0uB2p1pwAs+nRhTVzLWzYguHSsvKHutTtt1VhVIOBQ69QCMWjgrzrURQkHHvF4MS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3LnbsXfMrzH+1xGHdcLqPosIdGaVOA8k/jiThXPG24=;
 b=YOPaCrpn6JZ9SK9nuOgn8cvPrgobPlZOFqFAIDER4sTIyGw7DsjS4KDdiAyhGgcQhqbu80gaDPqmh9xGFw7YBxrzW+O/3T8qXKLf0U/vtn+ahKhU8xPnuH8cMME04ydZkck42YcyJRwiDVgudmOjk8i80fwi5U+2bxEYHtTo5iZxuX0Wcw/oY2N+Vd2pwZW3+HQtYIiGGDSlWNCIMEQBP4/OXabNwlW8tYU/Fw51w7ghPUUIWYuxL1aFqdTkWT3i8rSvVN2y5MFMstJ6WZiOaj0REdUe7TEyASW5oOkboFuAqdLDbY4s1ZD0LSVpG2g0guoyUnOgmpg67fi5CRbi+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by SJ0PR11MB7154.namprd11.prod.outlook.com (2603:10b6:a03:48d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Fri, 26 Jul
 2024 10:40:12 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%4]) with mapi id 15.20.7784.013; Fri, 26 Jul 2024
 10:40:12 +0000
From: "Nechita, Ionut" <ionut.nechita@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: Philippe Gerum <rpm@xenomai.org>
Subject: FAIL Kernel v6.10-evl-rebase - EVL: In function 'do_sysvec_inband':
 error: duplicate case value
Thread-Topic: FAIL Kernel v6.10-evl-rebase - EVL: In function
 'do_sysvec_inband': error: duplicate case value
Thread-Index: AQHa30gxte4UNNjgkke64hDODuBJLQ==
Date: Fri, 26 Jul 2024 10:40:12 +0000
Message-ID: <PH0PR11MB5949D5E4DC2C8DF215617B6CF4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
References: <PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87wmnmq8v9.fsf@xenomai.org>
 <PH0PR11MB59491C18ADB51F5FEAEF4B3FF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <PH0PR11MB59490B50D2D2717B8155EFCDF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87h6eprhbg.fsf@xenomai.org>
 <PH0PR11MB5949B24CB222FBB2D387BF24F4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87cypdr5fm.fsf@xenomai.org>
 <PH0PR11MB5949453FBEBCA4520CAF80A2F4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5949453FBEBCA4520CAF80A2F4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5949:EE_|SJ0PR11MB7154:EE_
x-ms-office365-filtering-correlation-id: 8e9ce7ee-5db0-485d-a7c1-08dcad5f545c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RmmFRb+4BEVDmkD1CddJ97xG2v69eWJKN/MlKX6Hi9QWOEaMuRnAbYC48cUR?=
 =?us-ascii?Q?UKJRhbhh1Q+PCGdLyHzZGKJsCBC5gFFGJgfIIVKo+idGDUdXd9dwVByFlLye?=
 =?us-ascii?Q?4mHLwIDDvu9MEop62/TpmUH+ovy/B7hXW/ghQCWfDdDaF0vHXv6voQLbNVOt?=
 =?us-ascii?Q?fE+SBmcbNUekwFMbh8n4yiWIBZohntbLbosHhFAsvjL5fln4pqyOgItVioMh?=
 =?us-ascii?Q?CVx/Go2n7B/RDJ8gH8NSOwm4Ib5vAelvjAJNmAuXMvenAjUpisAnhG8REp1G?=
 =?us-ascii?Q?3CuuI0W3Z8nmkzrl76FgxGNv5rxg13RI5jpVP4hNCvqStqguaOxdmxpYsOC1?=
 =?us-ascii?Q?9lSUMR2Ar/mY+LSOr2GN9783G4qNpzzsWzSxdCZJcBdvgU8YNwxu8BYmXSHM?=
 =?us-ascii?Q?nZk28zAcwEqD2e666J4y3Gc5FN91D7p9cE8OlWSqRW4jbA3EqmRORPlGsXcc?=
 =?us-ascii?Q?ZhOR9wIJMGDVhUlXN50YP6+6/oMGtGOJmuGSvF3yiTSqR/k3UMWJ+/NVn0dq?=
 =?us-ascii?Q?Vdc5op88Rro0qe4QS4qolUldngp6Lt40uTnt57IFE0ALjv/qixvA6EzIJd/T?=
 =?us-ascii?Q?KqTJZeLHxDtFb6JnxGLYPOpLdJS58Zz9Q/DkmZO/kZmmqPqulKAEWu59RQsX?=
 =?us-ascii?Q?IRDe0CTTQOoZ/qaOIn5CEUhsUsi5PHSxbiQASbrPKPlaC24huoLSVGrbb3bq?=
 =?us-ascii?Q?0ZeYKBBdPjllYMQvd5+4heMUyPObJCTukCV39+pI7laHYfW9XdilU4x35zHh?=
 =?us-ascii?Q?tp1Rtst61ZeqHrYJH97d1q3YAJ8p9J4OYDZj9v+r/xj0jDaEzwQOt89qjZxV?=
 =?us-ascii?Q?X2Q3vKwRWvdEZ0u4JaCPJr5D3rMz3vc0zlHqeTRaySwCrl3RuQBAczzfb8vQ?=
 =?us-ascii?Q?izoNY5zjzcTpTB+FeUtKZdEsmAbbefAnawr7CUGR0n5sr8aOZp0nroo1Kt9X?=
 =?us-ascii?Q?4lNNGlHwVfVHlcv8paSjK8RqnEzqYnK3rk0y7WVI9Bw06eqGlFRMuQDJY4ND?=
 =?us-ascii?Q?oNJjVDJtvYXH9OiUux/Eduj8ldiP9nbh6Z4v8dwCRRh4/G2FrRsYQ2ss56Hz?=
 =?us-ascii?Q?RoTCYdxKf2zc5lNoFUhQOd1uenO1fL0IsQF773CZ6h++FixLtJsMZuMOo308?=
 =?us-ascii?Q?LaH/jM/S4v7Z4APu1JRQ//FHexM4gmrIrLFcQZR0SYjPVx0/0O/NqnyP+Cal?=
 =?us-ascii?Q?B7x7T3t2FV19Ilgm5t1M4Lct8Xymrlg0eeyXRjBQOsZuuLKhXV34ufYnRcpo?=
 =?us-ascii?Q?QkHYM15taNeq4soIuTgzI4LCtB6gBWlZdDD7yAWhRDxdEd6kesoL3Xv8Xvik?=
 =?us-ascii?Q?/X8reYMJOTmHKNPmXUgMwQbjIuNmn0ntKPfKIi0h4byIkYcCEl81+E/EkGdI?=
 =?us-ascii?Q?9ew/KsvMBrYSLvFNqPQGbXbxo6g4Oq7tPWaVbnLGtGpB1FgdJA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s75HmWxY1gY7xHMee8/cY/zigp7Ax4gPtz+5j0OX97nVLGAuXyR+n5q58nF4?=
 =?us-ascii?Q?d2iA9H1OFKNr2d0tkf4qHEHL7PBwrGoNzD5YciYHeGEKb5TcPTiaewV2/eq4?=
 =?us-ascii?Q?2Bmlj7VKEaMtgX5qUcWpUNIDlsjwR0XTW3dA1zZV/88CvCXJYFyxbqFLaKRZ?=
 =?us-ascii?Q?ILsI+Q20S2psV0XxKqPSjOJutX7FRva6j8wcKTIRMagzorM4euCF150vMO51?=
 =?us-ascii?Q?BEIytIUlQhkID8tZKIE/MRwHeNhqA49/AyFWFNzhaJwMvFMh7wbAitxf5Fcb?=
 =?us-ascii?Q?jhXB1wLByryXmfbvOfWew7RPpoxw1iXPhk9NzpQ0s9ymGcQrHG3C752tMGQ7?=
 =?us-ascii?Q?MIwyS3dZ0w7fnWy+K8yGNOV7Po8FowoJGqAqCj9O0rieZ7SCdPbgLWUvdE1X?=
 =?us-ascii?Q?anr7zONnzwmoR+HK699m06c8pBz3RFKoTfLbUBzKKbMbq2Adq1EOkEPZk5YQ?=
 =?us-ascii?Q?dF2LZHSWVIQhC1S7b6fVAXOHSmkUTQtVlrJ7Io1uTmGh0GxZizjMepECDT0B?=
 =?us-ascii?Q?Ryix5p2XkgiPpyQZFJ42ykH0jDC/y/bx7MKISeV5g7JISqcjCmeAzIlT3u0w?=
 =?us-ascii?Q?5yKBLp66mIW4dYTWOYafP+ayi0wjDJTQ35thG8w/1+b6sytBGgRk6nkX5p+d?=
 =?us-ascii?Q?xOAe+eIxVSNk9ixI+AlUMDut6wRkHpjDWU9fgCGN2XUapKkYAkMLMeiITFRe?=
 =?us-ascii?Q?VKmg3eJyIMr1/bW/EKWyD0vkPFW2eMJOJ5ocu2uwNfbUUmW8GLTLmxXdFJKW?=
 =?us-ascii?Q?TdHIVTMBiB52ZU7GwahDHToaLvTk1Y+1eqvGVYX+ieHUFIMsUyCuAXiuX1R3?=
 =?us-ascii?Q?YuyGUP5bUrm0NgmRadZBSTItyOsnep1WFlrlabV/67PoZVD/9VcmgVBR8Ir9?=
 =?us-ascii?Q?ImUWOMZRSrYT4vCqc6RepXLiRDKdm0KjMEdz2HC4BHZ3EaEeqzzleFXrky7B?=
 =?us-ascii?Q?L5A2bG7lNNYvM6HrYZDTppQc8CDGgcmiK23msiRLUyIaw2fS05YVlc6k861O?=
 =?us-ascii?Q?OGJ5JkXrLURkIvool1x97zP/a5rCIvUkNFGF6LS19ThnS304Vp2zuc4vmXa6?=
 =?us-ascii?Q?VQxzuwECNgzWAJhnV9mGMm9247NZlzk9JXuv9OFOBEuDWPBJxh84Y8LVFWqv?=
 =?us-ascii?Q?cLezFXa3VZgnIDnnTo4e/ZEhmDYFMQLBUxFcy3rHkl9pT5Ewt1JQhHXU8GUG?=
 =?us-ascii?Q?S9C1LyMZP6vkr0kdD1eCtbilNpvtFjuR0VjqBGThjgQK61EoTDkc08IqkzIV?=
 =?us-ascii?Q?7rxuZ+TzMlmnKemOwxaH5htuA0JBHgyLypeyr5GSefsYUtskgnFwpqW6XWaI?=
 =?us-ascii?Q?FavUuuYD5m3q9TejCrudFxXQ3nEpJm5sXRdzG3syEGF49clRhg54Ij52viT6?=
 =?us-ascii?Q?pVG+fSqyhy8IqphUYKt3WNhWPaP31GjAzKPchQT1v/qyzcMddKmXEgdK86QR?=
 =?us-ascii?Q?Kse3O8CnJhM42I6+K0Jgs7F8vZPw9AVqp8+a7IoV7OmAbhVknBrdZiL0ONpb?=
 =?us-ascii?Q?KMm0MTqmjYx2n6nuDMN7UD2idvSw7JUGX6w8Edu2PfdD5yTiWLqp1gc3/dgu?=
 =?us-ascii?Q?KNSSW3hZzyPSl0kY8sXd8sY0YyThQEdG6QA3TttA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9ce7ee-5db0-485d-a7c1-08dcad5f545c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 10:40:12.8045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3e45AV63YyVQe72rhzSzxexAo0HxqgIpC2zi/f++wZijsLh2YhiuiAhbJsdvZmN42HFqubeJE7gl2bDPAQLUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7154
X-OriginatorOrg: intel.com

Hi Xenomai Kernel Team,

I notice today one issue when compiling latest version, v6.10-evl-rebase.

>>> error: duplicate case value
  160 |         case HYPERVISOR_CALLBACK_VECTOR:

# make -j208 bindeb-pkg  LOCALVERSION=3D"-1-lowlatency-evl" ARCH=3Dx86_64
  GEN     debian
Using default distribution of 'unstable' in the changelog
Install lsb-release or set $KDEB_CHANGELOG_DIST explicitly
dpkg-buildpackage --build=3Dbinary --no-pre-clean --unsigned-changes -R'mak=
e -f debian/rules' -j1 -a$(cat debian/arch)
dpkg-buildpackage: info: source package linux-upstream
dpkg-buildpackage: info: source version 6.10.0-g9ba4271318cf-4
dpkg-buildpackage: info: source distribution unstable
dpkg-buildpackage: info: source changed by root <root@0296de802d65>
dpkg-buildpackage: info: host architecture amd64
 dpkg-source --before-build .
 make -f debian/rules binary
#
# No change to .config
#
mkdir -p /srv/tmpfs-disk1/build/linux-evl/tools/objtool && make O=3D/srv/tm=
pfs-disk1/build/linux-evl subdir=3Dtools/objtool --no-print-directory -C ob=
jtool
  INSTALL libsubcmd_headers
  CALL    scripts/checksyscalls.sh
  UPD     init/utsversion-tmp.h
  CC      init/version.o
  AR      init/built-in.a
  CHK     kernel/kheaders_data.tar.xz
  CC      arch/x86/kernel/irq_pipeline.o
arch/x86/kernel/irq_pipeline.c: In function 'do_sysvec_inband':
arch/x86/kernel/irq_pipeline.c:160:9: error: duplicate case value
  160 |         case HYPERVISOR_CALLBACK_VECTOR:
      |         ^~~~
arch/x86/kernel/irq_pipeline.c:154:9: note: previously used here
  154 |         case HYPERVISOR_CALLBACK_VECTOR:
      |         ^~~~
make[7]: *** [scripts/Makefile.build:244: arch/x86/kernel/irq_pipeline.o] E=
rror 1
make[7]: *** Waiting for unfinished jobs....
make[6]: *** [scripts/Makefile.build:485: arch/x86/kernel] Error 2
make[5]: *** [scripts/Makefile.build:485: arch/x86] Error 2
make[5]: *** Waiting for unfinished jobs....
make[4]: *** [Makefile:1934: .] Error 2
make[3]: *** [debian/rules:74: build-arch] Error 2
dpkg-buildpackage: error: make -f debian/rules binary subprocess returned e=
xit status 2
make[2]: *** [scripts/Makefile.package:121: bindeb-pkg] Error 2
make[1]: *** [/srv/tmpfs-disk1/build/linux-evl/Makefile:1555: bindeb-pkg] E=
rror 2
make: *** [Makefile:240: __sub-make] Error 2


BR,
Ionut Nechita
