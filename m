Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383087E0
	for <xenomai@lists.linux.dev>; Wed, 30 Nov 2022 02:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669773933; x=1701309933;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=argSegHVwHWktHNlxLjSjYyk9u5tqCguWiby9nVHL9k=;
  b=GJYlH7zCKOcw3QLxT3cRP6dtQdg9oNAq10XWcBlPI3xSo9rP7MV5FphS
   etZKDu8ww7z+PeNfNiVWOzOcqOPImZJPNg+kpJPGJQbKLz1kBHLZXNLM7
   SPI9mnOr5noAvAudm1AMf3XYWnZNuIh2wHCqF09pLVwm3ZJe5095tyxoZ
   t9h0SDv0hIkoli+GOzQLvfpyB7MsoxT+ueUU+dIPbV99unTaeM2+xLmHD
   qswuNiOZQZrtTZISb1rdWPxOed8n640C3guknzOVutcP26RyDQ0J4wWSN
   9RcxjMbyV32WUa+LhgSV+qJkLOGEVbUEQ+/OxWuHBTVWnqKmbhTvONZJ6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="315312773"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="315312773"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 18:05:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="750132131"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="750132131"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 29 Nov 2022 18:05:32 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 18:05:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 18:05:31 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 29 Nov 2022 18:05:31 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 29 Nov 2022 18:05:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEQEwaYDmAVi1th/AiEC+24v24djhCaCSE0OOtwrMfVk4jeIwpqdPB/fAOn2W3ftQ5M1fJYhoKCxlzw2GIJ0SmY6+wlpV34l0V1LLwxp6N2cWuWDrkQoAuxbS/txFHKCwd0+Vb4ZTFNG5nfgWTKv1X+jqm1E+KmtEBTog8FQUuTC0XVruLY8nefSBsQhUQf+o9kyQoxlPESbYUS0k9CgxxNY3qaxfrh6T+nLUj88rRKDYuu7Mc+q/F5twiRAEfTFLeFHvF+CCoezb0rWZNjrSHpauTGixMN2g6BQoHPmujfQSU3OUW1Z7tg5JhYqqOqJFzleUyAr3/Sex9U2njxNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=argSegHVwHWktHNlxLjSjYyk9u5tqCguWiby9nVHL9k=;
 b=a0srjXB5MHQjYZkdb9krE+EQk4t9HAHyFrOgNntm01ui188+BW/brMIDVis5P+xnpHfuzf0ee+5RK7fKjfVoiWoia4lEY55AlGJ1tc/1I5dch2/o8j69FDv6Sr78Xs5NirD5hky3XSP+iGOrZCPaWZwpwFfss0+PWilHsyEkN0nfZj71etufh6pnzGlxwHcbW0irQlJSTsYJGeqsnJ3V+z3jieOoJ6W1npjp5qHGXwzWicnb3V+ZcGqCbd0pZxms5KRdXa4QTjcNZY9bMQZOCq7X5fin19fnfHxlOfMZPGsejYRR7VTN9D1UuOe56ipcndE2UGEsLYrB27segYJoJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by DM4PR11MB5232.namprd11.prod.outlook.com (2603:10b6:5:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 02:05:29 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::27cc:d8ed:9947:fecb]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::27cc:d8ed:9947:fecb%7]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 02:05:29 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Nov 30, 2022, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Nov 30, 2022,
 UTC 7:00 AM
Thread-Index: AdkEYC1eD7czqLUHRJmKZcjvc7k6+Q==
Date: Wed, 30 Nov 2022 02:05:29 +0000
Message-ID: <MN2PR11MB42852EC1E5241AB659DEE1ACF2159@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|DM4PR11MB5232:EE_
x-ms-office365-filtering-correlation-id: 753ce6aa-f1be-401f-b1da-08dad2775aee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4gj1ZCAQz6AQVRhNs3pYf1PeVB6b2QwJplPofro68yhaz9QV/KS1MdhrgksRRD4nhlXH6bq04foH5SBCLKuiHd/xrtTbbgG4ksh9/PN2Ylrs5cOGgP2TGALNoziOIcu1fKodW00sS9sdh/9OzT8it5klUeTaHoDQCKUJIRoImzn3oJZeNmkGuNbGMkcNwvPeYMJndbwfGFoUev7N2HzaqdPdatkbVGGR/9yPExQ8LTXDeFJxIub4mFKBDkmYO0Y2klKCKWYPxvC65TTz6zh5H0cd/TOrZ6eLT337gs0KICgfkAyMbG5NJ6uQjP0scmvX2gKVOU7TGYNZKeyXIAN/6tM1J33Z9WmI2WGxhFsDOUpi/hss/G6VV0zSAKGvyBsKCGTbmiKkg9JQ+FQPK4AxFHWtZ6af5tQApONF61NOr2VKjGeDHGjQvy1hhhBqdfE+u54t1HXXllpuHn1YeH25yy8P2plzj7d3hPsWI2iOAvgXlpoYB2aaHpYuThrlx0tjcDsC3hilyo4SSzyfm//rHx/DcGzwVgq7S0HBgILgPZvIV9aRSdOZoPehDG7n3L7HDxC2OBaqa90XhUfE+QfVmGoir6nQHpISsYS9yxN8iN1RSj0fekS9E0QK3NKSFAn/xjPQNGb/CiW1j0ZT40i0co+K++0ptEJ/U3IXXxyGKXJDj4PVZYJk90C9bliHeZA/U/ztmrsqIqavxFKNi+jR+KVQQFHotgwZK3RVmOL9AzBB6dWEmuMOAIsuOK+Szv0xSm9Ks7p9urU+MioPh3C/zA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199015)(55016003)(38070700005)(2906002)(86362001)(966005)(7696005)(71200400001)(40140700001)(478600001)(41300700001)(26005)(316002)(76116006)(66946007)(66556008)(6916009)(5660300002)(66476007)(66446008)(8676002)(64756008)(52536014)(8936002)(6506007)(186003)(33656002)(122000001)(82960400001)(83380400001)(38100700002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGRBNWNQcmIrUFJlYVJIS3g0WVVQRC9KSnBJbDM4MU5qWVFKd0NOQThvRkRN?=
 =?utf-8?B?dlAvMVRQc3hLQ2JxMW9SNVRDUXVyMzRCU3FOenV3Qm9yS0NEUWZGaUlXY2RH?=
 =?utf-8?B?R0RFNkJRQ2NaUUo1dEt3Wlc0NVZLaXZBRDZHNHlHSnRDUHJqZEZ6OXNkM055?=
 =?utf-8?B?UkxzcGlpWFlVejA0MllGQUR0aWZoZzNoSnZNL2plNUhrcUpsSGVVSmkxbS9K?=
 =?utf-8?B?Vk55V1JoaHJXY0NKVmFKbFhDTlVsM09vZkJGbWVYa0pneFhlVWx4VWgxNnNU?=
 =?utf-8?B?UzFseEtIOWRoSmcydDgxSndoUnZ0d055WDRGVUY5RG1BdE1qQkNENExsbWJW?=
 =?utf-8?B?bERsT2tmUC9kdy9BRDg0Wjc3WGdoSmliSDRaVzZuOEtCR205NEFrUEhnZWts?=
 =?utf-8?B?d3g2T1BnTlAyVGwyeUExQW9GMDF1clRBNFRKbDZJbW83K0FtK0ZDN2dzTVI0?=
 =?utf-8?B?TXIwMXM3bWJJTFkxRXZqQ2RkQkVvbXQyUlBqTmE3a0xOMkdOZEZLVmJTRWh1?=
 =?utf-8?B?UHZSWmxqRmM2dUpzbkVpR2xpbUdJNUh0bjRyOWZvVnFZNlFwcVVkQVVqQlRK?=
 =?utf-8?B?U2RHVElZbzRhWXJaRXl5cFZZb0ZjeU1IM2MvTWNWN2hHS0w1U0ZTT2c3cVVl?=
 =?utf-8?B?U0VVd2dPTFFNWndwQ1NjMkVXMXMzUnkza29UcUJtK1dmYmdxcHJFN2V3MlAr?=
 =?utf-8?B?a1NGN3pyMDU2QmN6Rlk4bmRYS1BpcTdHVnVwK21LeVdtaVhHMXJPWTVhdHBK?=
 =?utf-8?B?U050c1h1aDM0UXNFNnA0RHNQc3c3aDlyZUxGMkNLdUI2S3dGTEplZ1lJTnl0?=
 =?utf-8?B?MmIwcGM0enM5aVZFVGNVM2RNWVZlalcyVXpTUFhJT1Z5MXF1VEh3Umt6NDZu?=
 =?utf-8?B?a0tMQXBDczd6QnNwVzRsLzZzYi9teStZdngyN29LZ20wR3J1dlJKZXAzWkd2?=
 =?utf-8?B?bFozbnEyZW5jbkhobjhDYlUzTGJndENZV2VKVHM1MjZFNkFjczJLMDVzdVVQ?=
 =?utf-8?B?S3pRbFkyYzZtdUJmV1h5Q2FRd1FLU3F0ejlVRUZWWDBCN3lzem9GMGllZC9Z?=
 =?utf-8?B?d0ZqOVFwNWtEYVpFTEtkaHh1dlVINTdjREZoaXk1ZDRGUWJ6QXZmdFVsY1pG?=
 =?utf-8?B?c1VoM010YVcveVlJbkt4aDZLZTdRMlF1NGI1REZLUDVqMUFScmRtR29KN3Rk?=
 =?utf-8?B?djNZTXRNTUI5ZnJNYXZmWmVrN2hFKzk2Z0NuZlJZMHY5YVB0ZHhCSlRQczRn?=
 =?utf-8?B?ajgyaWdnRWxyOVVoKzR5TVNwSjI3YkMxNUo4d0NGOEExQUZ1eXVna2owNjV2?=
 =?utf-8?B?SE5wUkxBOVdqUExXYUtoTFNlcU9NMmF4dVdzcWcvL3FFaWpoRHQ4WGx0QVlz?=
 =?utf-8?B?bkJKeWg3Z3RyUHg2dW1iNnZuUUJ3UXROSndLS3FpRUxrRTFRWFh3bWQyWUdF?=
 =?utf-8?B?TS9panJMelZDWnJzZzc3ZlczdUQrQkE2cUIwcVA0b2FHcW91NzFaVklCZWIy?=
 =?utf-8?B?blNKNk9jWlhEYWNwYk9IcHVFY25KRGUvSlVnZ3VLSlVHUkNKeVhoTzIvY2V5?=
 =?utf-8?B?Nlp1a1duTHRjMDlwVnRrcEpRckV3dGRpUkhvUUJlTUNYZ1pGRzFrb0dLdjg2?=
 =?utf-8?B?VnRxZ0hTdFFuMERFdXZsSE5VbXk5QnlwQ3c3bXN3SUZxblg4R3htWm1Mc3BW?=
 =?utf-8?B?TFk4VXdqRWhFZFBORlN3V25KUFZ6M0NjVjltbS80U2JzOUo1M1lOK2lqRUxC?=
 =?utf-8?B?WlBZOStaSzhSUkVzUzAxUUNsVE9YM3BmUVFLV2dBeCt5YXZKUTAzYmtHcmhL?=
 =?utf-8?B?ZGtpU2d6bVlkNHRmalg0Mkx6R2E2Z2Y3dHpyNHVkVGMwb3dCVStjeVhNN05E?=
 =?utf-8?B?QkJ1WExiZEZiSndKc1VleEcyRjdXcWRHdmwrWHVlUGZiZlQ4cElaMWVOTnV0?=
 =?utf-8?B?enRSNmM0TGFtU3k5Z3AwT1JCMm95QkQwallmTWxqNzRzSjgzaHdCejRRMVQz?=
 =?utf-8?B?WWVPdit2WG94dUNMQUM2cXpBdGhaeExVdFhkQ0c3SlpGdzFMQjZ5R2hsc0pv?=
 =?utf-8?B?SWVPOHZxOEl1ZU5ERDB6RHRFNGZhYWxZUUFnRFJsT0ZjelRmZTY5bDBDSEND?=
 =?utf-8?Q?OKvDMqsbFdOH2MB7cDbmZ+fba?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 753ce6aa-f1be-401f-b1da-08dad2775aee
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 02:05:29.4723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9uJxyBqZLx3378Md7Mx3VC1UNZHcBWSDl5fjNFRKvsmKK3TAFej0hUnNoKBq/GIYzrB9O2Qu5oXr+i5+Pv6rdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5232
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgTm92IDMwLCAyMDIyLCBVVEMgNzowMCBBTQ0K
UGFyaXMsIEZyYW5jZSBDRVNUIDg6MDAgQU0NCkNoaW5hIENTVCAzOjAwIFBNDQoNCkpvaW4gWm9v
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
