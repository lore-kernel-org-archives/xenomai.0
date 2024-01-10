Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032AC210B
	for <xenomai@lists.linux.dev>; Wed, 10 Jan 2024 03:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XdKuGyfk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704856237; x=1736392237;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Riourb76vX0DLG9DyIPVxvRb+HKQawFDnShnhJUEgiA=;
  b=XdKuGyfkEzE0QMwPU8qChpFl5Jo57ZGdFxrDVxlXntASdXUehQQeQasS
   3DwFHUIgd0uZd/40zvt9lIoXVvXh6poEzpcvtpEzcgXv9sgxwr/ekTs0R
   JLzRgSuUlkJy/x9DgIwHbB1SNSE4Syz7MV1FmXNLQ+xLWx2i8gAB+jqT2
   Ak11DnBOgfqj4iPN8NASNkQEF2DPEr2meYJA8tSr0QGZSemSAoJZfKytS
   AkTeEMFtkiJ2JVs+phFTDSmaqg2dTWDzuZebeW5FBSL3WH1lh49GvfHyl
   wzpOI1ZsMhnXI+zX9cJUw/R0gf3a/OF0cIItgKfuwUBYyShzK4+k4U4Rd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="429580751"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="429580751"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 19:10:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="816197816"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="816197816"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 19:10:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 19:10:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 19:10:36 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 19:10:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccnBAvVyjV/iNw9O+rwMRCShJnHTwcWy6ICc0D6NYmjQU8jOuJRY/VgFolTzHbbVp01zKJuux7//pNAmM+G90z2SgPFezWRKH9MXjCHHh+sjSQ+fZG8CVMIKvhyBalRL+4gHKf6GCbw5Qf7v6wuE1e7oS8Y/Q8JSHABB+cktCvdn+NuIKi6oO3tork6elvJL2xF/9tC50cGuPigHujxA0WU8M8Eiv8LBp8pD1nOOw1/p9+kha97iiQ9WpEmj45aj/xSBojphjh2OZRrXFYcgREGZYjDKWMgManqZcnQa4wIpwPNaLYmmohX1KP5r7CdExAYVB9sQhsJLS4VAf2Kyjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Riourb76vX0DLG9DyIPVxvRb+HKQawFDnShnhJUEgiA=;
 b=PO8QVcNsn/kWDuIfd8SeAc1gl+UFZIidaKB/VIWBTf1kHzn4tXS+lmTdQcGSoGsi0XLHw8sYLhmq0zv9yJByCzvfo9NVIrmuFIZeoxjuIINF5ZOpMyVsj+OvXdocb5+IEnwvXDzdGThfXKPa9PNvBzdQ7edxXnS8Il7mPnIOAYwW+hzSmMMLiWV88uVZ6AAZy8lICkUMpTNjt+9MHKc2gKvHFWRBsV+ATx1Pygw2ap2jxJPqzAYvo78cyD06b934w0+m/It4HtsyXJzGB87QEOVaVoIQ1CIv5VM11RP1VYhyEiN15H8S6rgOPV4chza3RiLhNXpmpzDDmILHJqb3vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by SJ0PR11MB4864.namprd11.prod.outlook.com (2603:10b6:a03:2d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 03:10:34 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::c885:af6:b3d6:4d9f]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::c885:af6:b3d6:4d9f%2]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 03:10:34 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Jan 10, 2024, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Jan 10, 2024,
 UTC 7:00 AM
Thread-Index: AdpDcnCJqBkrY+DXSVKGA7+4qXlCgg==
Date: Wed, 10 Jan 2024 03:10:34 +0000
Message-ID: <PH7PR11MB749964E5744FD46F7BFD5618F2692@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|SJ0PR11MB4864:EE_
x-ms-office365-filtering-correlation-id: 82cc7dea-1de5-49f2-001a-08dc1189b632
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BNVfhlPUYSx+TqshJFGlJTMAxPaQbieKA7Iu3O+StcHZtJ02pLQLKW40bG6gUoTbvHrxwJcRQgkMNVQ2Z/YaSoka/rtchYWCD3R+l9ASqG9RATUhuJf0C8GFXD+ePlK7BBngdC21o72vQ0vKoL3Tq6ZDKDkbJgYAgRZPL1za2OO+tRry3yLZ4zGeXVbW1U0MnzR/7DGKt1riSkGjtavYdCwXG7p7Ab/4fgJbEgTlAQeV02XT3k02z3+LkUY+3CjMglGI9tChP+W7oM7nI1ceCJbF/c8RxUBVXClR6LC5Ui3LveDa4W5So9B7MXUlN+dUcX3Fku54uTQ6DZL47PgesrSpTmRYhGN1dTMEF0q6ZZpwUh6qDFMCSXbQtT545M/c1kmVZqnd4zEAWl0MSBs8KMm84AqdXC2Eg/xB/zH0yFfJ8DZS/0S7xWupLi0/X0v1Xe/VAsQYfSeuwAcavbpjJTllZY4qfQyAQrbPH/+5oiNjiIiKmxD19ecA+7k88wq5Th426v57EJx1S/k4zg5ed3gCQ/IOavG52IyjaZC3VA2D3EdulKD3BlXgzHV8NmPPDARF7EWThM4choQyZOevtzjtYMlo8RPB2XNXyd+12M4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(55016003)(2906002)(5660300002)(6916009)(38070700009)(8936002)(66946007)(316002)(66476007)(41300700001)(64756008)(76116006)(66446008)(66556008)(82960400001)(40140700001)(6506007)(71200400001)(7696005)(33656002)(966005)(86362001)(8676002)(478600001)(26005)(9686003)(83380400001)(52536014)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjh4LzVlVndZZlhPTnhIRjZpQVdrMmRrNVhLU2ZiYldiQkU3dUp1QzA3OEZl?=
 =?utf-8?B?d3l4TnBCY0hXSjB2YS9TelRsMW95WWxzc1FjVkJMWFB2UHVtZm5JVlFacWVq?=
 =?utf-8?B?YUJyT2JsU2x4dlRjekk2OFdCekl1R0UzOFl4QWdQV1FSL0VEUFovSEwvU0Rh?=
 =?utf-8?B?UmJidUhteVJjU2FCdFFiTkp3Z1RjQlRxd3UvVVVDSENSTFlRVXFScnFBblJr?=
 =?utf-8?B?WW5IMk5ic2pkZi9rbFRORGpqL0RuRDliZ0RyTVpadjdCM0xybnVUc2VaTm5M?=
 =?utf-8?B?UStpbXBpU1VNYmJ6SGpLTmg3Z20vZHI3akh5OXhGVXFrMmZLN21FLzZIUFAz?=
 =?utf-8?B?eXV3OFZGdFBUaVhpVUNsZmpNSjRaU2VZMy9zYnJwcjRwVlcvTEM4OXVaZ0dN?=
 =?utf-8?B?K0ZVZDI5Z054ZUVQU0FOdVFjTVhRUkl3SExJNEZWVHI0RGhVMm5PTWx6MkJw?=
 =?utf-8?B?VDRtaHhkZXg3WHM2Z2JGZjFjNjFBNkJNUmF1UzZva25zODQrTFRQVFpJTFhF?=
 =?utf-8?B?WW14cnhiTnY3bStlQndjdFVyblJHTFUvdHNTQWFHYVF5Z1plS1AwbUQxTlZH?=
 =?utf-8?B?bjhScldnVHprdEhGOEk4WGhwZjJ3Y1BEaE83SzBRemFxblhNcUpWMUljWGM0?=
 =?utf-8?B?WWFXeWVDdGZXOElVckoxZkRPTzYvMjdRcmRENEg0aHF2cHkyWHlNSFZUWk9l?=
 =?utf-8?B?RjlGWFhCMTEwQVBaaWVsMEpLY3ZKTUU1bzJEem9HZFN5STR2Z3RTeENjL1pl?=
 =?utf-8?B?eml2TDR6cFdDMml0dTdUMzZjcXowd2ZoVE56NmloL2ZxQXFxWlcvZFlpY1gv?=
 =?utf-8?B?Q3RBWVF3ZWk4ZDFtRlhWNUg3U0JGc0dzNGV6aVUzNC83SzY0WEh6Z1JMc0tl?=
 =?utf-8?B?YXRsODVpSEJETDZOZ2ZaYklnY0VxL0NJbWxXNTV3THBTZjZDQkV6VGFhQUww?=
 =?utf-8?B?QmJwbmRiNTcwdzBFTWtJLzJuZzU1UURTQ0tqekNHT0F6anNDSUNoU0FqREFC?=
 =?utf-8?B?ekJmZlJURG9Qc2twQmdnTG9PUkJLZUZCdnV5NTNyWTlDN21pQUgxQW1KaDRv?=
 =?utf-8?B?cDFZTDZUelh6V2lTMnZXZ1VrM2ltbzBwb3Y4R1JTSUVDZ0thMCtJWkhGeksy?=
 =?utf-8?B?d0c3QzBNZXRlRHZNa3NSN1FwbEdIN3VoT0hxS2FmRnlsYS9mN0JFNXduT0ZL?=
 =?utf-8?B?MXRZV01QQlhhaGZsUHlCVVVLbTljS0JTbWU0TnYxMGM3SHl5RDhJbHBNRmJ1?=
 =?utf-8?B?MFlJQUgrWDRjVEkvbk0rT3ptbEJsOTBwQ0pucW9xeFVQeE9WS0ZQMHpqdWc0?=
 =?utf-8?B?Nm5ZVVR4VndZU3crSmtxNG5PU3VHaUdjQUluZDR2TkRPaWpRUlVJVElCd2do?=
 =?utf-8?B?eTdCTlRGOFJHbkRxYldTbFJ0ZlJZYWx5NTFQbjhLQm9vMTNBTXhtQmgxSVZ1?=
 =?utf-8?B?cDgxL0tZcWkvYXo3dmZKTHYzR3pMODNOTE9GU3lWcFVFOXNPM0dnT3VFY3lp?=
 =?utf-8?B?RHhpRDhERGRLOWEyVHBoMFJJUWEwRjdoMHk0eVFHV1YvT2ViUTJNS3JGWkFW?=
 =?utf-8?B?bjU5dURNdXEwbHZXMEM4bnV1KytzZ2wyQVdhRkV2Zm1GWHVvLzNid1c5eVBt?=
 =?utf-8?B?SGEzMDRsMmU2SFJTd0tmRUxITUEwaVhxWGhZWkE2ZXFWZkVEYmcxcDkvSFcw?=
 =?utf-8?B?SFJidEUweVk3MnRSSGpFZlZ6R0R5dTVUZ3hkSk1QeHVLYmVudDBLN3QrMVpr?=
 =?utf-8?B?djN3QUNZREsrMldQczVsS1VjOEk5Q250dVI2TDBBRXd4T0FXNnVkengrM0lR?=
 =?utf-8?B?MVd6dUdmcnJ5MGdyNnluOHYvQlZwL0gzYnhJSEhWL3JGUDZ4aER5TTRyNXR5?=
 =?utf-8?B?bXZXWkx1ZEQ4ZENoQkJTSFlMMlZyZ0RzWjNQZkR0TG13Qzd4Z0NTYkEwSEtH?=
 =?utf-8?B?b2ZDQnd3VHltalZPM3RhVWFrWFc2Wi9WcDZRK2xkeUhGc0ZpcWt5QkxLMURu?=
 =?utf-8?B?YXRON3VzNk50UDJnY1duVmllcGp3Vkc5SVhrTkxMSDgzVk54ZUcweHlHYWho?=
 =?utf-8?B?aHZBOHdQQUZXbmdvOHB2bUxwcURQdXVTWmp4RWF3VmhQVmpGNm9XeUhDL3BB?=
 =?utf-8?Q?QmHv9RX6hSe585UvsKwxxfj7r?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cc7dea-1de5-49f2-001a-08dc1189b632
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 03:10:34.4135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5TI2TUXStNhCLfKSeWX56sSIu4nn1YUWd+h+Q9cLYEgZKQ1D+rT/qHZzcwPtpT4rq74CM9CX1FAuZTHvvSXPQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4864
X-OriginatorOrg: intel.com

VG9waWNzIG1heSBpbmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0
cmVhbSBwcm9qZWN0IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1
c3Npb25zLiBJdCdzIGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9p
biBhbmQgYXNrIHF1ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgSmFuIDEwLCAyMDI0LCBV
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
