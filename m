Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F91E158DB1
	for <xenomai@lists.linux.dev>; Thu, 14 Nov 2024 02:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731551150; cv=fail; b=oaXpeUJX6H/2PTWuZqOG4WQwCwuqCZbYBCgc0fJglKH5/8as+PC5tkttYzveQy5JfdlCTeQZbuxA1QTY28vi30DACkic5xJvtMm2SP/Oxv5pfnCRR0pe+JuZm1SVs4myDm/7SqQxCuWhFuON31brJQpb6XiaPFc6fSwSEiLdMcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731551150; c=relaxed/simple;
	bh=U37BJLN4G33HS7IvqF85oGZcujwSkA6e9FY2/e09goo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TvZ75KKH9CPtiTQZ7RG9/3muJBMopTttMqaTjdeNbn1blu1CHCXHbMXJdI3up2i8rRdWXUYSjfqPsBO/uYXfnVEvJcu9z7/OV65W6DgLNyUNummyJ3rNPlrt4nvSDJ38NPhbmcmM6NdbWMmCJCJ6oXqc+jP7UTQT3s3cYL3DJpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A9GRXKFq; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A9GRXKFq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731551149; x=1763087149;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=U37BJLN4G33HS7IvqF85oGZcujwSkA6e9FY2/e09goo=;
  b=A9GRXKFqGxkHpUP3chpGFf1fSRSiAUL+tIFMTLKIc4yrDv65CkkEbJEq
   IB4iBj5ymtebF8Jq2WjLlRl5tEYfT8gM+S+lsMmQq4ov4XQmtOeMm+eDf
   MLzlO7AxTZS5VHOYFeGLTiizchm108Sf0hcLAKmTUzu/jLr77TB4NdCiI
   P+9fTkJgeHsO52ZQC328FGoAlWc6x5CCvimDTHdLuHqOEKnpJqD+ybVYq
   c0Ms88/Zl39jSNBuy+h8XLCYmp0C4eIUnnEO9djC7yNkkl00J3WYDwsJ0
   oURb5/Zw2XO/vw7C98FG0GcWBa4a9gIdu9Wt8Z2I3m68tRt2A7axPmXY9
   Q==;
X-CSE-ConnectionGUID: Ayl0mODWTjO/2W8ESB/sfg==
X-CSE-MsgGUID: 5kj2iumSQ3S6UI+tmBZybQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="42588625"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="42588625"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 18:25:48 -0800
X-CSE-ConnectionGUID: FwaMcA2nRYC2Vvkc4freUQ==
X-CSE-MsgGUID: cbrMYyzgSvuFbtiifq6krg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="88158268"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 18:25:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 18:25:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 18:25:46 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 18:25:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxP2DDQu5znhI5qTkhw+rZPkuS74IKiu6WIT8ZUEfBgG47oHmnVDamEtROgUwu+486z8APQdcdTj40mr7LNM1aGI3tKx9jYgr/lHVUwwMdQtLYijRMan+sV5aB49ke25QONGLrjLqpNko1+kXzKJKzO2N2Qzn7eskKmZA37WwPr2/N17EcfloYBhlL2hNSZxvf/PJFsgwYZTGpQM+901IO3X0m1dyRiLay0L6xGLkUAtC5eGnXmoqlfANHf7U6vFKQZSyC0YEHHRGmHra3iERB2MJ4AvyGotBScj9QFLo7TRLpsoUkPwOVztncYFTvJmVFdMqe7F13Q2BcHNe/xiIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U37BJLN4G33HS7IvqF85oGZcujwSkA6e9FY2/e09goo=;
 b=QfJCL8REYzVDKsm+y6ltCtuvD1XivvA8IiceWYfcQwa9RLYvGttuxURUM6DA7fbTh+a7v0lB06N5zCvlbVjl4osy0NJ99oC27lwCxsvv7keDB87hh5P1SNSl0BbTMgdm0rJFNZytWIXVhnvJD53q7IYz/0SBo5O7PKJJy9BTbh2FFT7d1BBLohygw7sS8orMZwtiXoG+SLzUIv+Hzf952p5Y0eD8ri3VmNkSNv1L7A6VDrAfy/I7yYiF/n14ZnBKaICLGZw7eyGT56a8su08KWtjv7QA/ewc4Cz0vAbe2fuW9vIXsaez0DWWLiGB6EPTtNxj1Refx9sCWnt6zh3Jjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 02:25:43 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%4]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 02:25:43 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Xenomai community call on Wednesday,  Nov 13, 2024, UTC 7:00 AM
Thread-Topic: Xenomai community call on Wednesday,  Nov 13, 2024, UTC 7:00 AM
Thread-Index: AQHbNZDSWBAAeWZUnESGvE1yBFUGJLK2DDCg
Date: Thu, 14 Nov 2024 02:25:43 +0000
Message-ID: <PH7PR11MB74992033B790CB6EAAA7BB10F25B2@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D3E2C96C4F21DAEBE4F2212@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499C4BB71E159B3AB98D686F2332@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482613E8A9D78229EA71D07F2EC2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB74993A52AA247D08069980E4F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499D816A0B79C85EF7CD712F2D62@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499161719AD2EC0D1651C48F2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482106CBDA92B4A595D7363F2AA2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB7499B238FF2BECBDD784752AF2B82@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D39A66B3EC8E9431E6F28E2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499BDD1032C1C09D4107EE7F29C2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E15D2AD5555818A6E5C4F2462@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993258CAA8CDDA598B287DF2542@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E32BB1968236810DF6B3F25A2@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7499E32BB1968236810DF6B3F25A2@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|SJ0PR11MB5866:EE_
x-ms-office365-filtering-correlation-id: befa2540-39dc-4c80-447f-08dd0453a3ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VDRlVkJrZVdEUmkxL0twcnErK29nRStYeGtLdWgwTHM5dElhdU5Nd2xoeXlJ?=
 =?utf-8?B?Ky9ITlljRVY5eU9qaE9tRzJwNkM3SWxHdVpTWmVGUUthM29OVEFSd3VLWUZp?=
 =?utf-8?B?VXFQMnl5cW1JS0ZNd1haQWxwYW1YQ1NWWDNzeGp6cTNqclNYWENielJobmI0?=
 =?utf-8?B?engyNERFYmU1dTN4NzUyY2NyTmljVkJoTU9CaXAzcXZyVmVuMzFiR2o3Z0Nt?=
 =?utf-8?B?MjIvT0RRVmtiMlV1d2ZYT1VuQWJIckJrSlFwZlhSOWJMQjVwRkYyYWE5ai81?=
 =?utf-8?B?OG1lYU9HQ3dsd0pyVW1nQkFUSjNnWWVaVmdCWm82cTVIbkY3anQxKy8zMVhB?=
 =?utf-8?B?TEV6UFZPbmVIR2NFcmxoN0piREhuTnNkc283aWNIUTIvbXJ6cmVZTkRndFRp?=
 =?utf-8?B?aUZSOHRGNG1GSUg4d3EvZnROQm1lalUvL2NaOUhpVlBLc0lIamR3YWlsaUxx?=
 =?utf-8?B?eVVzWGgrZXFaMWFndFRCNjZjUlZJTUNRRGk5VGtwWkZyZ2ZJdWIrOVVqQ1Rt?=
 =?utf-8?B?RHF1cEMyYzdJa0N1VEFWS3RtTS9pZHB2SDcydDFlR2xCanJkeVdpTmVteUUx?=
 =?utf-8?B?elluaXZrRGFXVFFUUVAzK2Z1MUVSdW1zNlhHUHdCUXg3R3BOaEg0VUM5ZVhI?=
 =?utf-8?B?bnlZRkhsS2Z2eHRNTlpESW9Wb01LTTdNNmROVXNnMWx4SmpjWC9VT0dRdVFy?=
 =?utf-8?B?ZTkwbi9QSDFoY09FK2lMSTBQbVdUYlc0aEdoWCtqZW9FN1dEZnFPUFAyV3VI?=
 =?utf-8?B?NklrV0F6bUR2bkhIdFdNNjkxZ0NKU1RIRHpvWHlCNU1tRDhZL0dVV0NaNERo?=
 =?utf-8?B?Q25menlhRUIxNU5NZTJSTENjRmVEdG1YNy9vTEdvS2NEbWJTRkNMR0NFTzVu?=
 =?utf-8?B?UVNxSTlZLzRlaDVpZlcxNGV2Um1PUG91bTJWd2x4M0puUG1CVG1vaGQzVkkv?=
 =?utf-8?B?WXVCdE4zWlFVbE93WFg2L1VYekVRa3cwS05CZjJuUGRteHlscms1Uk8yT0Q2?=
 =?utf-8?B?bXBPT3dkVThZaG5vUnkwa2lQZUpvWXpjd0lDNWpoWEgwV0dyV3YxYWxvS3Vy?=
 =?utf-8?B?bWE4R1pGODRaM1JaN0l4Y1hJSUxvdStuL3NhM0RMTkdrT1MxSnQydUJ1VUMr?=
 =?utf-8?B?aWRRTmJTbkx0dm9HL0ZFSEgrRmtmMjhTakhoQUE1cnVpOFBTYm9xZEFFbHpp?=
 =?utf-8?B?Y0dEc2RLRENORTBRdSswYWNIS21wdVNFc0dRVis5Y2tiQmRHNVRveVViSXpz?=
 =?utf-8?B?bmxvMDA0SzFHc002QVZhVjBHaTBnNXdFVEkrSUJLNzJ6dVVOM25FNjQvNERX?=
 =?utf-8?B?NmM2VUppZWtiZWFDZ2NlN2hRVktsNWgxb29jZUlNaTYybUxLcnRVRk9PVFVj?=
 =?utf-8?B?VUxoejFBWjByL1MxYncyQXVqY0c1anJiczlzNFp3U3dIOG1RWjNFQnp3dXNw?=
 =?utf-8?B?UHRNWW84bG1iT2RGTFFWODZzSzlkbUJHZS9mOC82UjJYWmdiMHlBZWRvMkcr?=
 =?utf-8?B?dE16bGVWR3lwbVM0bEkvVjZmRnE4Slpnd0hQcWtzSVRFRVEwUmZ4NklzSHJF?=
 =?utf-8?B?Ty9DOU84S3BzQkdhTnJaQmhBUVRLeXNiOWdobE1ZSDZPTU1vVXRoS0pSQjAx?=
 =?utf-8?B?Q3gvdnFueGZhV2JzeVNTcHRxcXFibzFJTkRZUGZJUGZWSEp6RFlQVUpuZ1c4?=
 =?utf-8?B?RHZENDJ2Q3dTdmoxV3NWSGdsdzlKYU1hakd2K2VBM0QyYjc0bU90eVhKcnFN?=
 =?utf-8?Q?kGcysqpoGKkEX9uxOMNkJWc+bpxi6oFSiXI/D49?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUxCa1lhL3cwTG9POGxvOUVjczNZRUNiUVRpTDkxUnN5YmpaVjc0UDIyZk02?=
 =?utf-8?B?U255MHROMUZNL0diK1BqNlV6bm1vRUVKSHpRNnR6TkhCVWs2SHA5aFNFc0ZR?=
 =?utf-8?B?d0h4V09DenFWTHNCYlV3ak4yZXRzOUtUbjR5dE5VdlhqQ0VwOEFwSnJEU2k3?=
 =?utf-8?B?clllU1EyTHZrbzhrNFBhMkI4OFRqMUx3T1RNd1ZMTE9Nd3h2RWZLWHhXUDdC?=
 =?utf-8?B?dGlQZVhYak5qQ3JkUHNkTXV0bE5TVFY4TzhobUxSankrRkFZN0t4VWNJS2Fl?=
 =?utf-8?B?cmxrSjB2L05hV2RDVVBhb0ZHdE5VTzcyVVdyL251OHg2TzV3WEJlN0pnWXc5?=
 =?utf-8?B?cHRUY1pHWTNZdnZTU2VWMlI0L1FuZXIwWmh6OUg3bEF4OHBaYnNGam5uQXov?=
 =?utf-8?B?MGpaY2VSRVdTYVIxMU1WSnFSVVM5M0xCL05ZUG83Zkkrek05UEhBWXZQckRl?=
 =?utf-8?B?V24xYlc1WEpGZWU1S1VlYWlHS2l2b3FrK2orMmFDZ2QrWDgxMGJQR09BbjE4?=
 =?utf-8?B?VUJzOUxxME5hOFplRUNmQ21XQ1hORjFmdllua2gyOGQ3Qi8xMDUvQzMxVmx1?=
 =?utf-8?B?Nk55Y0Fwb0dPNHo1ZVROOFJKeEtjc21WTW1wUktxd1dBZnVWVC9ISG1sSmZH?=
 =?utf-8?B?UllRcjdKdWRlUEJEaVkvUkowdDR4cnE2VjdGenBUUnpkbTh0d2gzSHlzRWdZ?=
 =?utf-8?B?bzNhZ1FZa1pjbGpCeVlSbkZJcGU4Yzc1WHNJNEFuWHZWWFE5OHZxeEdkdmlV?=
 =?utf-8?B?c2EvZ2Zmbkp3aDM5UzJpcVdxZVl2MUlvMVdHZThlNUl6akNMSFliY2lIek8v?=
 =?utf-8?B?UG54WHNaYmJ6RVJmOGtWOGtGN1F6Smw5OFNOUFYxdlh2NjJ4aU5hYnZtaS9j?=
 =?utf-8?B?LzB6Y0N0eWtQQk01NUgvYjRoYmtiank1OUtoRzNMNTRFN0poSG5iVjlwVXg1?=
 =?utf-8?B?TGpMR0dsNzVLd0NNeUN2Wkw4dGRkQUR3OUEyaHZkSEtYLzEyZ0c4a3ZhcGtM?=
 =?utf-8?B?Y2dNYUIwM1h0bXMwa1VFVnFhVDluWm9Qb0JWSlk2OEI0U1l4MnA5YmFKQzBB?=
 =?utf-8?B?ZHFacHVCT2c0dDR5YTRtMW9SQTdIYWVqQzVFaGtML29MK1lJMGt2VlBrZFlN?=
 =?utf-8?B?ejVCQ2wyZW85TThLMUxuOGlsNkpwVzZFdkZhbmF4dVB4eGNwU1lmbWxhdzNi?=
 =?utf-8?B?SDBIUVlJQ0VHRWw4L2xJU3NtUEZGZnhnd3VvZENEY0JGM25qWFNpWXhVaFB5?=
 =?utf-8?B?OHErVkMrVFByaVhIOG45ZCtGc01ObCt4MXhhUm1sVkF5cGNaY1pzSHJFcjZa?=
 =?utf-8?B?U080a3NSUVZ4VGZ3dFYyeHdqbk5tNTIxeHp0L3d0Tlp0dVpWa0loRnI3MkN2?=
 =?utf-8?B?L2xFTTVjbzFUOHZtL3RVMWxzU1Bpd21ST2MzaTVpZm5WUy9XcGVyOGZLRElS?=
 =?utf-8?B?ZWo3cXFaRkw3ZXZNTm5sSXFDbEhGOEhVaG1iMTZUaytsUGVzcUZUQmN6cW1l?=
 =?utf-8?B?WGp2Y0g1dzVBYnA0OHg3bm12c2M3cGlBdTZEUU5Rc2Y3c2lyT3hLeXlKbUZi?=
 =?utf-8?B?QkpxL0JDUjVmaStkSzd2d1FVT1RGa1VXeDhNNFRnQ3ZMZjdBVzNhTklLUkti?=
 =?utf-8?B?RlUrdm1iVVVnSDRiajN0eDcrSm5wbTZSY3k4aEdUTXN1aVNFc2NVYURsZk5o?=
 =?utf-8?B?ZjhkNkRBZXlOeHdVYlN5N0Qxd0lzRzFVdStQZUx4cDdVYVpYMkIrYkxwV0RC?=
 =?utf-8?B?MVkrYXJ5WFRHVEg3TG15d1BkZWVkcmE3dzZjSElxMUlpS01TcHlxS1JxSHBK?=
 =?utf-8?B?b0MrNmtHQWNRWWhtZHlkN21yQ2kxWC91V0JQcWJUL3lsVDF2UXo1YnRxQ0xT?=
 =?utf-8?B?L25YNUpLZURYVG16Sk9haC9Qd09zR25Vay9YL2V2bk9KL0tGZlV2WXBsSHll?=
 =?utf-8?B?STVMZ29mYjhXWjJrelhnMzdrR1VQRUJSMGN3Y09oR2RmRTdBSGxrMDJIQXRF?=
 =?utf-8?B?OVVjbkdjbFRNYWJEK25xbDhYRmNCdXp3NnBVaUVlNFhSUjJzRWlpVFVabHhS?=
 =?utf-8?B?dHhZNVhvRFRXZFpzazU2T3N1dWFsWFFrVHJSaG1iYVVkczdldk1QaFA4aDEz?=
 =?utf-8?Q?FYJhQ17VZtUK/fyy4w8zZTsJ6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7499.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: befa2540-39dc-4c80-447f-08dd0453a3ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 02:25:43.2246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdBQq0cnfszresZvVEQlcdUjppZPTCNDqn+stpzKt6yBptayd/s4MwImHxRBIN0W7/Ere4b1Y0AQi/I4QATq0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5866
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENoZW4sIEhvbmd6aGFuIDxo
b25nemhhbi5jaGVuQGludGVsLmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDEzLCAy
MDI0IDE6NTcgUE0NCj5UbzogeGVub21haUBsaXN0cy5saW51eC5kZXYNCj5TdWJqZWN0OiBYZW5v
bWFpIGNvbW11bml0eSBjYWxsIG9uIFdlZG5lc2RheSwgTm92IDEzLCAyMDI0LCBVVEMgNzowMCBB
TQ0KPg0KPg0KPlRvcGljcyBtYXkgaW5jbHVkZSBidXQgYXJlIG5vdCBsaW1pdGVkIHRvIHVwc3Ry
ZWFtL2Rvd25zdHJlYW0gcHJvamVjdA0KPnBsYW5zLCBzdGF0dXMgdXBkYXRlcywgYW5kIHRlY2hu
aWNhbCBkaXNjdXNzaW9ucy4gSXQncyBhbiBvcGVuIG9ubGluZQ0KPm1lZXRpbmcgdGhhdCBhbnlv
bmUgY2FuIGpvaW4gYW5kIGFzayBxdWVzdGlvbnMuDQo+DQo+VGltZToNCj5XZWRuZXNkYXksIE5v
diAxMywgMjAyNCwgVVRDIDc6MDAgQU0NCj5QYXJpcywgRnJhbmNlIENFU1QgODowMCBBTQ0KPkNo
aW5hIENTVCAzOjAwIFBNDQoNCkxldCB1cyBwb3N0cG9uZSBhbGwgc3Vic2VxdWVudCB4ZW5vbWFp
IG1lZXRpbmdzIGhhbGYgYW4gaG91ciB0byBVVEMgNzozMCBBTSBhbmQgc2hvcnRlbiB0byBoYWxm
IGFuIGhvdXIuIElzIGl0IE9LIGZvciB5b3U/DQoNClJlZ2FyZHMNCg0KSG9uZ3poYW4gQ2hlbg0K
DQo+DQo+Sm9pbiBab29tIE1lZXRpbmcNCj5odHRwczovL2ludGVsLnpvb20udXMvai85MTI5NzI3
OTI2OT9wd2Q9V21kd1MwcERPRFJOTVM5dFFrNTRZMWR2Yg0KPkZscVVUMDkNCj5Pcg0KPmh0dHBz
Oi8vaW50ZWwuem9vbS51cy93Yy9qb2luLzkxMjk3Mjc5MjY5P3dwaz13Y3BrNTJhOWY5NmQ5ODll
N2UyMGI2Mg0KPjhjMmMzNmU0OGI2OGUNCj4NCj5NZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQo+
UGFzc2NvZGU6IDM2NzUyOA0KPg0KPg0KPlJlZ2FyZHMNCj4NCj5Ib25nemhhbiBDaGVuDQo=
