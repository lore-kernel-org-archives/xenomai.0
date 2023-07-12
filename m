Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AEF375
	for <xenomai@lists.linux.dev>; Wed, 12 Jul 2023 02:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689129231; x=1720665231;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=hNMW+tv0TLoW5gnoVjCOw5Cji3jgMSq/FaMkDI/ZObs=;
  b=magt2xJRGkxqZhjis6z01Rpn2uy+YNdbQpuIOu/DCNaEo458vHGn7pzP
   NyObftztSIbJOT/VQEGwYntdVyFFePfcX3CjrKUPkqlSMJfDhIcrxG7H/
   L2BSaprNr9qUHGhdoxVZQlLcDxd7AlAI44q6m6146523gE/+d7gQG5xJy
   ASlE+fzCybaJN1p5NcEG4fX4AZPHViqYQBi3GmR+lSgOmf47DiE2Dda9N
   Y10RxA9rz0i9erKi5MmONwguNuHfw2kJCEdUz6ZM9teSHbiNfDijX9r/d
   zQze9JhYtHoZyV8NGpgP0wKAhfIIYdhjSed3N1aPPQP1Yc8XivA+4CoJw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="345097530"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="345097530"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 19:33:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="715407468"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="715407468"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2023 19:33:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 19:33:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 19:33:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 19:33:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 19:33:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0O4BJWAGi0IswiQRePTI+78JHYyVteRbLgm2tWXwA4Lbd03I7K6P2G74nnGqzL/is9BSqdZ0iDk8qayXSoxpaR3zFrsojaqn5ecD0IEhSBhd1PPjnBSy6Y6C6lb5F5oJWQZGCzsbDqcXHur/eGbl0znda+NbgsmgSeJoXdxmPfYfhi8wyx+BHm8GT0lYg+WMEbEzUeuHXagGeqv9bKdBa8vqvGc/w9UwdpiPJoBQ5rOkjlKtu2sZMRtLuvJ7/OKruAQdsw5cd4DhJTuP6uaevCXU6aCHaZi7q227daQOy0PIrDZiQiFkhqJh+C5pF2c3ehuJvAvXfUbcUFBSCkfxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNMW+tv0TLoW5gnoVjCOw5Cji3jgMSq/FaMkDI/ZObs=;
 b=V8WOMUgPyuBZVmyrx64reqjsdNIxIMdKIQyrez+d+T7NhAa7NJQd/4kKoWatrlykBw4vK1QC2aonb5vkMLHisU7oeV+wnaaZ1NdaDzYzvZFNX0gwZ9bCG3FFpc9p5RAORD9Jl/jEL+2VgmvUHofkXrfE+rDGZlPBNhzyRiFXcNj5ZByVLmwhnB0jbbLvF61vf/ufMpnMsnbT5pbj7SmXQzC6RD+vSajPB3CYmpwj+2vXzC8I9OGfAR1H7wlt6LjP8OqHs3MEPhF0oIpwD2EjPbrc9qw2tXsYz8TMABWMR5enY6APItOzQcdrY6DrVpj+H8c9CROw8DOLgcWdgYhFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by CY5PR11MB6486.namprd11.prod.outlook.com (2603:10b6:930:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 02:33:45 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8%7]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 02:33:45 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Jul 12, 2023, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Jul 12, 2023,
 UTC 7:00 AM
Thread-Index: Adm0aSXzugWwkYOJTc6x/vMFwjjo4A==
Date: Wed, 12 Jul 2023 02:33:45 +0000
Message-ID: <MN2PR11MB42857040327DF5A2824EC1D1F236A@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|CY5PR11MB6486:EE_
x-ms-office365-filtering-correlation-id: b5db4ae7-c02b-4b06-3e6f-08db82806a5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ilv5V8AJ7ikrWR0sIMhaat2SPQb028RppzNtoT+y3F/8MujDhOvKX7r+1ISEfK4rNvAxew/xtFToH0EuwtlDpR7VKSdjiwWVg5hSJmtTmADXcc30QSJhPoVCbDVCJREqNdxBR0J/JiRn5+pZXH3r3hhx25any1gHevA9lcPndLR71p/vwAer+6rnI4kND0HvnQ3c+zLC1jowN2Oau7DFDyP8dZQ3hHrR2xTMX9+v1OULRCde9vpC1z1kN0LJ9nJyS0eGOt78Q6PI+KIYsMevGU+xAZF3gFPrAZPZI4y4JC4tHUU/S+YcuwzEuf6Ssi97B4oB7YdL5xJ7eyZNZWhUkM8Ef8kHsgkLnuGlcuyRa2je371+akinSA0ujCQDN3Ga5AcwI7iOh/IUy876AXI8qrg8+N6t4ZCXpsCc8GBZVWp6bhCR6EPfR7i327zwkU7NXLRYb7joZO6axh1UIoYDdzxPnHPrLO471cMR1/6jmirZy7mMu45XOX+iMr6736k7Q6tu5t8QnUqhaDAZ4grzRMv9KzkKM1Gxb7OokM8jrwZTi8ofQADNbPVVFl/MS0BLNHlSqBTgGo0YBNhS1KYUnAZbKNpCQ+/YVYz0E7WYhFlOG/q6E6R7zxYZUdPSw3H3xIT2Om7RT6G4IxZlik9pgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(8676002)(8936002)(5660300002)(186003)(52536014)(40140700001)(83380400001)(6506007)(26005)(86362001)(41300700001)(33656002)(7696005)(966005)(71200400001)(316002)(9686003)(66446008)(66476007)(2906002)(82960400001)(6916009)(66946007)(55016003)(76116006)(66556008)(64756008)(122000001)(478600001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0U4ajJEaXUxYW1ia3RmeWxXSUpYM042ZkQvRjdKMHlhNjl4M1I0YmtGNGha?=
 =?utf-8?B?VnFiOGJpaXRmVnJkNDRLVkV4bEp5WFN4QlVxSllFMlVONkxtQm9pVlFiRVNl?=
 =?utf-8?B?SDZLM2RjSzVlNnhYZzUycjJMZFFVU0taRzc0MmxGdjBuV01nWEdkamo3alNk?=
 =?utf-8?B?VWdFSGQ3VHljMmdKdHUzc1N6bGUxUkRGKzQ3aUlTUG45RG4xcW9Vd21Oalh0?=
 =?utf-8?B?YU9RdDQ3VThBN0FjWnVxOGVRWU9wZEJ3MjhTcnZzdllkdWJnQUw0SkZXVlJ0?=
 =?utf-8?B?Wkg4a3B2UTg0VS9DNC9MVGJnaXIyWk9xUm1WYlJjcTdQZGZFdCtWQTBpbGEz?=
 =?utf-8?B?c0VmMU4zS3RnbHB3eXBoZ1ZLZUFJUzdZOEw5VVZIVzJmS1BVTk9JNE5McjNU?=
 =?utf-8?B?NG1ISUt1Wmt3UExSRVYzbHlvYi9zZ25yeitHYldMUVM3UjVFTVdxbXEyeGlk?=
 =?utf-8?B?R0xtUWZjRjN1N2RaT0V6WlF2TXd6L24vRjhkTTY0VVhmcTlmUzBIZmtWZFhG?=
 =?utf-8?B?am1pRFdXeWNiK21rcTA5TGE0L2w0aXB0ak51WGZFZmJXNG40YnE3OFFwS2s2?=
 =?utf-8?B?MWJZT0hlb1d5RVVlb1U0bXpwOWpyRGN1RHo3L3V2aFM0d0xMS2pzS1EyQkk0?=
 =?utf-8?B?QUNUSyt6Y2dZczhjcHYyTm10NlNlWHVQeWZJYmYwYndGUDNSSm1TdjJqSUlE?=
 =?utf-8?B?WkMwT1cxay9KQ0tqT0RxSUUrNTdlZ1M1WXI3MHI5ZUh4OVpEWVRpeGVvekV1?=
 =?utf-8?B?WUo2RUIxanQ3R095ekNMcVp1bUdHSFcwSUxna1M1aXN5TEhZWTFzMU10Tmty?=
 =?utf-8?B?aS8vT3NIRngrbHJJMXRXaFRUODF2dm9uMTFKR2ZPVk9EYUFPd2JhTmc2ZnVy?=
 =?utf-8?B?bHQ4T25DTGk5Smp3ZzQrMkxEdVNiQ3ozY2hMendCZU1JUkFvWmM5blNwRUZP?=
 =?utf-8?B?UjhDa1dmYWl6Z2ZybmZoMzFxV240cDR6QmI0N3BLa041OVdud09uM3BiOFMw?=
 =?utf-8?B?L3UrZmlxS25wRWZXa2dNZmxBcE9tU0poL1JnTysrbk9SdUt0OFYrUHlZcm9V?=
 =?utf-8?B?MXlBYXJvY1UyTXpyV1pQZTE4UDhrSzlkYURERk44TVZzWVZEVjdZUGwybXlS?=
 =?utf-8?B?S3l4ZE9LZk9HZDdwa1YwenFCRlhiN3o2OUl5QTlCOXdjaGxabG9HZU1PWTlK?=
 =?utf-8?B?R25NdzFyczNzRDdKMnhvRTMvQ0FtNTV3NXMvNFZ5ZDVJTlVYMmpoRWhyUGJw?=
 =?utf-8?B?bGJUcWExV2g1RE5CejdSSy9VY1RYMUovVXprdHYzYk1NYmtLWVFKK3lxYm4w?=
 =?utf-8?B?Vm0yeUh1VVJjUElPYy9vcnNkbzhBNElIZHFzcmxVWmtpeGZXREpTVnFkSGNK?=
 =?utf-8?B?am02R3dOZ2hRMmNGVGI1ODk3Q1NJRHo3Y29kWUpPTnRBVEVUL0RPcy9lNlFH?=
 =?utf-8?B?RXBnVWd4SmphdUM2eUplZ0docG5SQm8yRlNOMkE2cVNseHdxaUNpTTJCQXVV?=
 =?utf-8?B?TlYvT1dXU3gxOWZ1d3F1UXJ6U05Nd2JWZXUzR1l3emd1d3J0ejBpVW5sQmh2?=
 =?utf-8?B?Yi8rS3o4ZTUyWDFVNDJXUHZvNkpGemdxWjZMczhBd0Y4amYxL2kxTUErRTNr?=
 =?utf-8?B?SWZ6TlBrSHhuVXIvbEJPcUkvbVJrb1hJVGc2UnBMVmo5cFpoNlZqMm5wY3ZR?=
 =?utf-8?B?RHhTKzdabXdtaGluZWlpZ0FqOXQ4b0gxY0lJYTM2aVBkVG5zaTV4MHRBeloy?=
 =?utf-8?B?TjVIN1JybUs2dFBrMUd1aGVDYWRoNWN2U0RqeEo0Vk5aZ1l2UXJYWm5xeDgy?=
 =?utf-8?B?VS9rcTJ4UlduM1h3WXFhWmhOVkovU0E4eEhmbWVGSm1IclltdU5tcXVRNk1V?=
 =?utf-8?B?ZXFWNExaRHBoZExPdHAyazBLVlJ5cTlyRHNwWjN1VjFFVTlZRlpwcGRIV242?=
 =?utf-8?B?cUhMMmJNRnl0VmJYTzZ2d1M3cUQ2bVIyeTlOa0oyTllETDE2UVdMQmtSMEVM?=
 =?utf-8?B?MGYvSy9VRmlwM1dseGFiSndvajluTWRpU2VsVnQzVG8wdmRHTWVqY0JScm5I?=
 =?utf-8?B?YlA1Z0V5NHlNMWh0NVJqS0tTZlhza0NyVHVtWjlMbUFtYjZQK1VGdFhGbFZD?=
 =?utf-8?Q?XlH4qtsKxRVXqvxe0ng7689xD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4285.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5db4ae7-c02b-4b06-3e6f-08db82806a5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 02:33:45.4209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GcQFj4PwrjfrNGSsB7J73+mOxnkpP7M9KxgJZsmQ6fLfSE1Q+fSfeE7Ja6VCAdwkkHPozkWZPqV/Kupgram/uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6486
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgSnVsIDEyLCAyMDIzLCBVVEMgNzowMCBBTQ0K
UGFyaXMsIEZyYW5jZSBDRVNUIDk6MDAgQU0NCkNoaW5hIENTVCAzOjAwIFBNDQoNCkpvaW4gWm9v
bSBNZWV0aW5nIA0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL2ovOTEyOTcyNzkyNjk/cHdkPVdtZHdT
MHBET0RSTk1TOXRRazU0WTFkdmJGbHFVVDA5DQpPcg0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL3dj
L2pvaW4vOTEyOTcyNzkyNjk/d3BrPXdjcGs1MmE5Zjk2ZDk4OWU3ZTIwYjYyOGMyYzM2ZTQ4YjY4
ZQ0KDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTogMzY3NTI4DQpPbmUgdGFw
IG1vYmlsZQ0KKzEyNTMyMTU4NzgyLCw5MTI5NzI3OTI2OSMgVVMgKFRhY29tYSkNCisxMzQ2MjQ4
Nzc5OSwsOTEyOTcyNzkyNjkjIFVTIChIb3VzdG9uKQ0KDQpEaWFsIGJ5IHlvdXIgbG9jYXRpb24N
CiAgICAgICAgKzEgMjUzIDIxNSA4NzgyIFVTIChUYWNvbWEpDQogICAgICAgICsxIDM0NiAyNDgg
Nzc5OSBVUyAoSG91c3RvbikNCiAgICAgICAgKzEgNjY5IDkwMCA5MTI4IFVTIChTYW4gSm9zZSkN
CiAgICAgICAgKzEgMzAxIDcxNSA4NTkyIFVTIChXYXNoaW5ndG9uIERDKQ0KICAgICAgICArMSAz
MTIgNjI2IDY3OTkgVVMgKENoaWNhZ28pDQogICAgICAgICsxIDY0NiA1NTggODY1NiBVUyAoTmV3
IFlvcmspDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpGaW5kIHlvdXIgbG9jYWwgbnVtYmVy
OiBodHRwczovL2ludGVsLnpvb20udXMvdS9hVEVBMzdpNUcNCg0KSm9pbiBieSBTSVANCm1haWx0
bzo5MTI5NzI3OTI2OUB6b29tY3JjLmNvbQ0KDQpKb2luIGJ5IEguMzIzDQoxNjIuMjU1LjM3LjEx
IChVUyBXZXN0KQ0KMTYyLjI1NS4zNi4xMSAoVVMgRWFzdCkNCjExNS4xMTQuMTMxLjcgKEluZGlh
IE11bWJhaSkNCjExNS4xMTQuMTE1LjcgKEluZGlhIEh5ZGVyYWJhZCkNCjIxMy4xOS4xNDQuMTEw
IChBbXN0ZXJkYW0gTmV0aGVybGFuZHMpDQoyMTMuMjQ0LjE0MC4xMTAgKEdlcm1hbnkpDQoxMDMu
MTIyLjE2Ni41NSAoQXVzdHJhbGlhIFN5ZG5leSkNCjEwMy4xMjIuMTY3LjU1IChBdXN0cmFsaWEg
TWVsYm91cm5lKQ0KMjA5LjkuMjExLjExMCAoSG9uZyBLb25nIFNBUikNCjE0OS4xMzcuNDAuMTEw
IChTaW5nYXBvcmUpDQo2NC4yMTEuMTQ0LjE2MCAoQnJhemlsKQ0KMTQ5LjEzNy42OC4yNTMgKE1l
eGljbykNCjY5LjE3NC41Ny4xNjAgKENhbmFkYSBUb3JvbnRvKQ0KNjUuMzkuMTUyLjE2MCAoQ2Fu
YWRhIFZhbmNvdXZlcikNCjIwNy4yMjYuMTMyLjExMCAoSmFwYW4gVG9reW8pDQoxNDkuMTM3LjI0
LjExMCAoSmFwYW4gT3Nha2EpDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTog
MzY3NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
