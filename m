Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97A6F513
	for <xenomai@lists.linux.dev>; Wed, 24 Jan 2024 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079126; cv=fail; b=JJqRI/LnUBJD1RohC36YRQdVgCqUV8O7mx/cpBop3XLni5qv4lNQxH6NGykdx+T+f117UwV1aovARO5BJ8tphw1Js2DbNpc1Sjsfvr5CaLUk0nog8UL21KU0S3xJMu98Cw5jAoMocZt2dt/BlxSrhYQ3w7wHrBcLNxDORjxjwfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079126; c=relaxed/simple;
	bh=AXCBqs3eDGRLo1pCUHwUReHMwwyjWzgNKWRfvbV2Tys=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V6xHdyjh5qL9/cc51387B5YEGQBmnmm90YY3Bi0lhMskyFtYn2VFcH8tVF89QI9cLArjXHUfshwaY/mhSf11QORYtV7abTFyuTwrFgAjupYMhx+5VVHp8JCpr1zHZbl9WYjJ20iST6zblN2uUo38TaNbPPslM6tMhSU+HRatwL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jyr0Zo4D; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jyr0Zo4D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706079124; x=1737615124;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=AXCBqs3eDGRLo1pCUHwUReHMwwyjWzgNKWRfvbV2Tys=;
  b=Jyr0Zo4DsRfAvgZZUxm7Nv1sg5mURwx0BEF5JHFeyrwhm5jHR1GIobx9
   F9KiyjbFt+HARPJEjCMRAkqVsTGqIvla4Raaeldzlggozg/iBBO8Fe8Ky
   9XXpjiJ1IH0y2vNRzkMdYLRkwhFpf2S/kHXALxUjxuk+1lu4PeYKOoQbo
   1BzN+u+SbR3Y3KdwZciNNTH54jvv65J3rAOQ+yPXZVuv15PrDHtj3IXVb
   i2AYCoze8FJNGBGLVCKiTL2F0aZ6iy0d9lTWv+ABkMWmnx9UPaw2c4opA
   GpYEhtZKaq/L0nYuIA7GXfLRd72PbRTifkvZtU1vQHMoUcs/5N4IuoCLp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="405510189"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="405510189"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 22:52:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="34672594"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2024 22:52:04 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 22:52:03 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 22:52:02 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 22:52:02 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Jan 2024 22:52:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVhJmJDpdV6f1a7c/Af9vC3nVG9lV/bDK7SuvX/D3l9j2TsglGEKnVVEfyMleHJlRKGf7be9mNNsFdAgVHM6GYhJ+CGfZdl0NHvWchq4oAakznPdqJ3jySP3oTwY12zGZP30wCp9QBqbNMH0446+JbRqebzNDGw9PUVybGjUohO+zqLYg6h5AWP3wGJg5PjztNY3lXR1f5hh4qh2jz6Tmt8dijziOQQYJ8A0qcqFhlEH0X+NazY1ASzILx6Obg1EtqbFX7rXu6OXMQAJ8F0hKlgmFjuVRZeYMcUmz0z/lthA/bpEtssrF/Dh/OEEVoAJ3PUnYv84tYGnVz3WZyz+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXCBqs3eDGRLo1pCUHwUReHMwwyjWzgNKWRfvbV2Tys=;
 b=VWKk5os1BPz749WnHwXyOmIQFlIFAmMRbgWUkjg+t7kXFCD+TAFOdp9gmdpFVFftp7bA22SRJU+znhvohERHsTMuL03SLzsu7jOmgS/pJQYvw03ambpsfvEoCFssyaiLB7FQqUIJtKtOx8wbNSZv93+Vz1Wg/5lNkkXSRq2YGmF+zSYebPaumicK2xyw9lEHtASwCIFRZJ/FdJMUcSBMzMfMo8IMC8D8Bp1iztdkNIJPRioPQvdQIn6ystqJqbIOeybvdACQc8YNhzGhIGG0R6zMcrZHSkAFcZSGs08Wo48TX/tc8vvHNsB/2hNrv1KRJ079pgwEUsUBmOirsMbCIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by SA2PR11MB5195.namprd11.prod.outlook.com (2603:10b6:806:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Wed, 24 Jan
 2024 06:52:00 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::8900:99b9:a57c:839c]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::8900:99b9:a57c:839c%7]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 06:52:00 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Jan 24, 2024, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Jan 24, 2024,
 UTC 7:00 AM
Thread-Index: AdpOkczcJEZ6+DOwRo2ve6IwWy28bA==
Date: Wed, 24 Jan 2024 06:52:00 +0000
Message-ID: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|SA2PR11MB5195:EE_
x-ms-office365-filtering-correlation-id: 6119a207-354d-4d54-e6ed-08dc1ca8f712
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +O8sIWrrXPxof3JVaZy85wUjlG+fv2aUxyCwQWVlgMJgngAY7K3MkhltUG8ZZ9O/MddiC0CnkPq7P1taglEvbEC+Jv3g2nZtbep2ve+WEKCrUs1XOuo5dCQND3egPtOEKxhDanfNvRdNAaDUhOe2fqSPPDvFwkyJW83cDc5xXHbVje5moKMYI5K2+O8x/RfT4gB2CecCtYK80CoWKaYj6eC7gAEeSOTEYORQmY6vomKyowC39h1RihX2sFuuRVwE++NJyIS8UIsvj2EqMkJhey+1cpEgzX6gep5Gbhi6XtFhOD4avR+VEeL/SwuJ4MpJT2SKPT8Z9S9C1E2uxYXt3ldnroQsthtcX8X15Tp3iLx5i/fU2rRA+I1bBdCPWc8xkCjnZADuq6vLt5SNnHtcQKcLTGqXhsvlchEQm2F6YQr0EFppAzFZ9crGI1IL5p469s1YlF5XvVmIumG+cJsVDcOk+esTsN82Hif1Qh8gTqfgLZ/c4qnUyV1s80pyIUKIgnYr9hjZxkJjNMXBba+12ZPeUvhNEwEdpmSf0zX1o+4E9iHHGpUBC5jgYGrO0vE9LsXJe6WYsv4PW94U9R4nUce1PXDPy+GQZFfT6oKaoBcg4tjuECMr610GWhDc0NNaVP7KFcmTKfYZIkrVGSrMBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(71200400001)(7696005)(26005)(9686003)(6506007)(2906002)(6916009)(8936002)(5660300002)(66556008)(316002)(52536014)(64756008)(966005)(478600001)(76116006)(83380400001)(66946007)(66446008)(66476007)(8676002)(82960400001)(122000001)(41300700001)(86362001)(38100700002)(40140700001)(38070700009)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkdzbDdZbHFRc1FxbXdHc3VBeXU2UEtnL0dMNmJWMXdOYlVXMlFsT2VMUC9F?=
 =?utf-8?B?Mkd5SWZPcUlLODFJWGpnMUVnaVZrUWtTR3dXVVZrWW1iM2dHNzVXVG93aGtv?=
 =?utf-8?B?S2U3OE1kcXRhbngyenBvSjN5Ukc2WmIrTEhObXB3UGcvTG9seTZwMll3UEFD?=
 =?utf-8?B?cnAyeTY1azY5WGFDNXdTRjg3RDVwNVFpMHFaQ05OaE9RZnRsQlh1ZWpoWHRH?=
 =?utf-8?B?ekpURjlaRVA0dVZ2SEV3T0NsS0twM3MvZUlMWC9QSlFzTUpOV3pxblMzejRx?=
 =?utf-8?B?UGJWMkZVTnVwL1NXaC9saStDUnhYNnByVEZ4cUtITUlnU1IyTVEwby9NK1JL?=
 =?utf-8?B?dzc3Q3RiMnRiOHI4SG9jdGpZYXB1bURKVWVJUWwzb1lpT0RBRVpETmlqdlNT?=
 =?utf-8?B?SDZEazBFbUpOenFGa0NDQlU5M2pKWEM0c2FKWG81TmYrRDk1b3BPUlFyUmFE?=
 =?utf-8?B?bzdRSk1BbzRXMmdvSG1QQ2E2OVdIYUFNblAwRXlQdFVadlZsZGQzWU1NK1k2?=
 =?utf-8?B?Wk9KWEdxUUw4N0FmZDhiNGpOSE85RmxGR1dUdkZUZWFIVUx4eEplc2NqempH?=
 =?utf-8?B?VjdGM0V4L1E2VitDbi9OY1ZiZUtXVjFaNlpWNGFXeTFCbllFR0JUTDY5TmRo?=
 =?utf-8?B?MW5xYkhlWS9FM3p3RWVpbHcyOFdaQXp2dVNHTzZVanQrMjJneXNNWXRha3pB?=
 =?utf-8?B?dlJQU0h1ZGlOekdWRHM3WGt2U2RKelNxd0d6d04ybnA0bDk0d1MrRXZZNVF1?=
 =?utf-8?B?bzBhQTNNL1JBcUZnZEFwT0dnOE1iTkF0Y2hkUXNEWFFuYTNsalhUcURkMEVQ?=
 =?utf-8?B?MHc2a0ZWSTNQemZpRkpkR29pT3lYQXR6Sldqenc2czFaVE9IL1lxbzhweHM4?=
 =?utf-8?B?WG84QzYzazkwS1hoL2ZzZDhmQjhXZi9lekRDVGpTQ3ZMSzlCL0s1UWtrSGYr?=
 =?utf-8?B?MVBDeU9kRXJTZFlrRUkwcGJHb2VZYngzSzlKQXpxRkNWRHpmeHNKU2N6bThr?=
 =?utf-8?B?bXVGOGhNclNTNVRGMXcwb0xrclZ4YTgzdkZxNjhUYlMwUjBsbElZSGxCRnZP?=
 =?utf-8?B?eERWYk1kbjJ5Y1Z0WTFOYUVrQ3NrcmpkbStyWVJ4aEJubzBBcENtMXluWWVY?=
 =?utf-8?B?c3gwSUVzcTREZEJKL2xUMlZ5YXVNb1NtRUV1WGdOa05TRGhKR2MrTUpLbGpD?=
 =?utf-8?B?bUIrWnZBbm9OcmZlUWgyMXh5TUFJQ0lYTlo2WG54VWpvcENSdVNtM2RJQU1m?=
 =?utf-8?B?RW5sUm1rM2dhSDZIVFIxSWVqZm8wL0x4VmRZRGRBZlBTVW9qeWpKOVhmQjRG?=
 =?utf-8?B?TzRvczVndzFod1Z0cWxHcnE2M0ljK2NGNE5XeTdHWlorS3VEMjFlUUoxWTRD?=
 =?utf-8?B?WDdjQVhMNzhlc0ljWG1mMXBMajZHZTIwb1AxeFo2OXFYUDNWcHcrSmhrdVNp?=
 =?utf-8?B?NWdpRzNzSUpTaXhaeHZUZzNwZ0l2MWJkdjBMaitGdTlQOFVxeXRIWHlrTzdj?=
 =?utf-8?B?TTdzcDFZNXgyemMwTjlGeUFVd05jenNKRG5abkxVVEZIUFZmNGdjUW1FT1hr?=
 =?utf-8?B?aE93eFZ0UGxhVkxaeE44b3ZVRFRZTFFtc2t6ajdNK1hRR2V1a3ZaS1pFNkkv?=
 =?utf-8?B?VnRkcFhhVzkvVmN1b1cwbFpEOUI4dWViaXZqalBiY0NkZ2FLYTZlMERBN3c3?=
 =?utf-8?B?YUlrNzFDZ2dyV2NxaCtmeHB3eWthZGw2TGZqSU54MkRFSmVRY0RlNTd6MHhG?=
 =?utf-8?B?SlJsWFpXcXUvMkc5MUJxMmlzNysxOWdqQ3Fxd3VrUmJ6eU5JdkNFM0cyc3Fw?=
 =?utf-8?B?NDZ3NGlYTlJncDY5ZzZNd2w3U0M5d2JLQzY4d2xsRk9nL01rWStZcnlFczdi?=
 =?utf-8?B?M0poN3pLVzJWVVQ5a1dIVEMvMlZqSWdFM2laS3hLYVZUUUR6NjZIeGg2Q3Vs?=
 =?utf-8?B?WDRaZW5ndzVEOXpPNzNJNVFJUTNWL205NXdvbFlDb1pZSmVLZWxCQjk2REtI?=
 =?utf-8?B?V1JhRk56N2JOVVpzSmM4Vy9YSjExeGtjZzFvOGFIS2EzMXV5YmUxc2ZGbnZi?=
 =?utf-8?B?TEVtclpzU05kSDNDWXVhbktHT1dCdTlRakhNL3B1Ync1eUtOSXBFYUo1Wktt?=
 =?utf-8?Q?FeQ1KfsZwtdbqC4R2cNfDHfA2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6119a207-354d-4d54-e6ed-08dc1ca8f712
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 06:52:00.4761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nt7EkgqPakOXvW6QAAj+fvmKrnhTK7ftEYYSgM1mjTQHUO7432jdBhzVEPRQtvvY1qzKjxyWXaXNaDiQbf4Jrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5195
X-OriginatorOrg: intel.com

VG9waWNzIG1heSBpbmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0
cmVhbSBwcm9qZWN0IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1
c3Npb25zLiBJdCdzIGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9p
biBhbmQgYXNrIHF1ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgSmFuIDI0LCAyMDI0LCBV
VEMgNzowMCBBTQ0KUGFyaXMsIEZyYW5jZSBDRVNUIDg6MDAgQU0NCkNoaW5hIENTVCAzOjAwIFBN
DQoNCkpvaW4gWm9vbSBNZWV0aW5nIA0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL2ovOTEyOTcyNzky
Njk/cHdkPVdtZHdTMHBET0RSTk1TOXRRazU0WTFkdmJGbHFVVDA5DQpPcg0KaHR0cHM6Ly9pbnRl
bC56b29tLnVzL3djL2pvaW4vOTEyOTcyNzkyNjk/d3BrPXdjcGs1MmE5Zjk2ZDk4OWU3ZTIwYjYy
OGMyYzM2ZTQ4YjY4ZQ0KDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTogMzY3
NTI4DQpPbmUgdGFwIG1vYmlsZQ0KKzEyNTMyMTU4NzgyLCw5MTI5NzI3OTI2OSMgVVMgKFRhY29t
YSkNCisxMzQ2MjQ4Nzc5OSwsOTEyOTcyNzkyNjkjIFVTIChIb3VzdG9uKQ0KDQpEaWFsIGJ5IHlv
dXIgbG9jYXRpb24NCiAgICAgICAgKzEgMjUzIDIxNSA4NzgyIFVTIChUYWNvbWEpDQogICAgICAg
ICsxIDM0NiAyNDggNzc5OSBVUyAoSG91c3RvbikNCiAgICAgICAgKzEgNjY5IDkwMCA5MTI4IFVT
IChTYW4gSm9zZSkNCiAgICAgICAgKzEgMzAxIDcxNSA4NTkyIFVTIChXYXNoaW5ndG9uIERDKQ0K
ICAgICAgICArMSAzMTIgNjI2IDY3OTkgVVMgKENoaWNhZ28pDQogICAgICAgICsxIDY0NiA1NTgg
ODY1NiBVUyAoTmV3IFlvcmspDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpGaW5kIHlvdXIg
bG9jYWwgbnVtYmVyOiBodHRwczovL2ludGVsLnpvb20udXMvdS9hVEVBMzdpNUcNCg0KSm9pbiBi
eSBTSVANCm1haWx0bzo5MTI5NzI3OTI2OUB6b29tY3JjLmNvbQ0KDQpKb2luIGJ5IEguMzIzDQox
NjIuMjU1LjM3LjExIChVUyBXZXN0KQ0KMTYyLjI1NS4zNi4xMSAoVVMgRWFzdCkNCjExNS4xMTQu
MTMxLjcgKEluZGlhIE11bWJhaSkNCjExNS4xMTQuMTE1LjcgKEluZGlhIEh5ZGVyYWJhZCkNCjIx
My4xOS4xNDQuMTEwIChBbXN0ZXJkYW0gTmV0aGVybGFuZHMpDQoyMTMuMjQ0LjE0MC4xMTAgKEdl
cm1hbnkpDQoxMDMuMTIyLjE2Ni41NSAoQXVzdHJhbGlhIFN5ZG5leSkNCjEwMy4xMjIuMTY3LjU1
IChBdXN0cmFsaWEgTWVsYm91cm5lKQ0KMjA5LjkuMjExLjExMCAoSG9uZyBLb25nIFNBUikNCjE0
OS4xMzcuNDAuMTEwIChTaW5nYXBvcmUpDQo2NC4yMTEuMTQ0LjE2MCAoQnJhemlsKQ0KMTQ5LjEz
Ny42OC4yNTMgKE1leGljbykNCjY5LjE3NC41Ny4xNjAgKENhbmFkYSBUb3JvbnRvKQ0KNjUuMzku
MTUyLjE2MCAoQ2FuYWRhIFZhbmNvdXZlcikNCjIwNy4yMjYuMTMyLjExMCAoSmFwYW4gVG9reW8p
DQoxNDkuMTM3LjI0LjExMCAoSmFwYW4gT3Nha2EpDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5
DQpQYXNzY29kZTogMzY3NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
