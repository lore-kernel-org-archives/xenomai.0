Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6EA6AA5
	for <xenomai@lists.linux.dev>; Thu,  7 Sep 2023 13:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694093134; x=1725629134;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=CeuXI31z2ZTaOucXpgbgJ5wB8xx+ODsmL1fTQ54c0sE=;
  b=Uwg86jjO1Lg0viIipWtIC7Qf/lA2oyWLLtgxGqb8aWN7Xp/jOdEMBIdl
   lMIRsSNiiGpJmNjmW8I70+7oSwna9qC9fCtK1KjC6Oj3WZOyrtjP8VXB8
   QOP+aVOu7cCU1F3GCllN4KIXCu9GUvlvPQeaca/lQt13CVU/gjPEFAl/w
   WlsK+VCsRS6V/vYfIJMNSTFty4mMYeMDoYAyDgttMNkaEW3uK6NWp8ja6
   QDyjqjauQerUFt1M2mtarEXmEyDMzHEpY6kAyh++87/F1oh61RaO6vAoE
   8HwH9VHTEiX19INNjFR5Bc4ytT0oQQLGrnIJHxBlkPHCzJoAzWZUDtTPX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="356827405"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="356827405"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 06:25:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="771270425"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="771270425"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2023 06:25:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 06:25:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 06:25:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 7 Sep 2023 06:25:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbVPskKlzubWgzf3mw1rAUyxIR4QY5EqVTYYo4r6EZ3HO0UQQdKPvBh6wQTCtpnjEHgf/6ffMLkTwGkGNcwIPdSYVgGy53SoXmBQL5JoMTSzg1cKxNcBGdzx6nSb8tMg0dqaqY9KVnbCIsJMOMlmS7uilS7giUIvrrEri0o0MAowNlN+3xH7yTjG1NuYTMf5uXRDuXbua02KMHMKsn9wbzm/KclJrPy/uoy32x/ZpGnnHTcJgbY6VNt/tKUIGMtq0pkaSUvgTS6tPVE8jwq3/RhbU+qC+mDxxsbtpDUVb2+pk1QysdLYo8iU7RpPhF2kUdniAbTma+2HlDzjYPkOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeuXI31z2ZTaOucXpgbgJ5wB8xx+ODsmL1fTQ54c0sE=;
 b=n3N22bibVcP9rjc2GwhXzeTGZ3vj+o0ezIOs9bVR3SnVQ7Xf+DSyOBUjFTN7iVITD0HKmCGgEljQyOBIbVddqIhVRnFH7WerRxmXS84mQqBNjrL/E8SpwAUm+kF0IzGwNI4y8hOT2y5//CeHdG5+TL9j2CFB1guynQZjHf+MC5QkAlX8E2fk16I3nphiIc1tDBK41riBG0g3SjS8vtTIIIoGQFHmJ5kjZETgBe7kNXOlANsnexdd330jrwUZa3657a1mMwFz6OlQhbYOdzEHnKnCxQ9HWfR4PuwX9vAd9x0XjpHKsqNESL3uZj6cPIwtXXK7rs0+Zxxi7ddykES3jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 7 Sep
 2023 13:25:30 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::b478:c959:e429:dbd1]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::b478:c959:e429:dbd1%4]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 13:25:29 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: [PATCH] pipeline: irq: ack the irq when it is postponed inband
 irq from outside of the pipeline entry path.
Thread-Topic: [PATCH] pipeline: irq: ack the irq when it is postponed inband
 irq from outside of the pipeline entry path.
Thread-Index: AQHZ4GcrY+SYGCxHrUqsumJ0suSTaLAPXHCg
Date: Thu, 7 Sep 2023 13:25:29 +0000
Message-ID: <MN2PR11MB4285E261F806B025581E1947F2EEA@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <20230906014113.28637-1-hongzhan.chen@intel.com>
In-Reply-To: <20230906014113.28637-1-hongzhan.chen@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|IA0PR11MB7185:EE_
x-ms-office365-filtering-correlation-id: 6bb49a18-7e2e-48c1-aab2-08dbafa5e7d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5DuteQ1RXncqIQQbZlo1e2TN4dW31k1E2DzzqhTDTpFB/gE8WuRa1/f1e2z00NAZ2C5KTj3zKPBdm+Cw9u7g3xHNqpy/kvk6TgopTc/BZdxJKGcdhWJY70fhJvQeKzFc+0a6VPgvZNXbMe2cSC1hTglsbB674Mxl96+G03BIg8dbFg1oB+9B8Exzw+uF8VBof4IZzu5SjLFIWWowk3q7ez4dD3IVn8lCveKfGV8f36RxN2adYblsn6XXy5YV7yWA/N2FB6E4A3cWXQmtMZMa6Q7eUI7Xk2h6BmaZJtDtUx6dUmx2iyMBld5I77kFLVIZwzkshL3GqOcZkBegdHUzeIsIwBshL+OUXHV/fgQtlX/SvBmLA1sIH5ode+vc7dYcdAjmR5bN4OiM056aqmS4YZt9ZVoPJAySakOYMzlQbl5X4xWegIg8YJqOvJNUTU8RPRwCcViyJBY+/uLrm84Y7wB202SyJ53CtaTrv96wNpnkg/OKtYD/7JW76d49uLBWQm0s2zkgScoG6Qd0OgUq3P2QB6WIgzjh+djF6QRnWuTLHPZkvw9R2bybmFn5VvQV7IOJ4pwjR1WgZLbkt1oA92HsyfZcJIKN4o9SpJi1PJo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199024)(186009)(1800799009)(52536014)(5660300002)(8676002)(8936002)(6506007)(7696005)(316002)(64756008)(76116006)(66446008)(66556008)(66946007)(66476007)(41300700001)(478600001)(45080400002)(2906002)(110136005)(71200400001)(9686003)(26005)(83380400001)(55016003)(38070700005)(82960400001)(122000001)(38100700002)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXRiZGRFWVRzeGdnZUlrcERwVFpIcnBvd1pvM3FHMVpVOUNyV3pzbVhlVko1?=
 =?utf-8?B?OE5SNUdLNVkwUk5OeVFWOFB2VVRRdlBQZkZhRmF1OFQvNVRHcTRLYlZ3RE5r?=
 =?utf-8?B?eGx0b09WRU9Wb1ZYSDJLeTZHa044RjJZVkdEN3AzRkFWV1ZtRjFkdWtlb0Yw?=
 =?utf-8?B?N0xpT0x2ZkZkYUZhaDh5bUZ0YnRtNGl5UVRKMjlaQS81VjFtTVBVZjRpbDJo?=
 =?utf-8?B?V092alpzcCsxMmVydEtTdjh2OS96c3BIakYvMnl5enhaOU5zKzlnQ0U1MGZR?=
 =?utf-8?B?bEJQSkhkeU8vK0F1blZxWFRxd2tGUGFId0tTY0ova3dtL2JEOU5NYlRiTHcx?=
 =?utf-8?B?aXRnUVFZdnpGOEV2bStqSVJ4OVRLbFVoNEo1Vm9SUUdKSWpwVUJ1OFVkQjRu?=
 =?utf-8?B?RnZvRUE0eDM5VE5tTmZSOWdsdmZseEVQNmFPZGJUOWlucGhlTFdHRlA5eklt?=
 =?utf-8?B?RnVnaC9DYUxmbzJxZ2JDeVErU0xRaDFCelRlVDJNSStTY3RYMnQ5NFlJbjBH?=
 =?utf-8?B?d1A5N05TanVhd2d3eXFtVENLNzBXSFFqTnMweHNWMlFiQStGa1VWZzlvdXhH?=
 =?utf-8?B?Qi9tNi9NcUx4U2RLbnU2eEpOMVl5NlBsczdOTm43bzlQTFRRajF2VW0wdTJB?=
 =?utf-8?B?b1poSFVjbTUrcUs5c0hCZ3h4ZEhULzNObWt4aEZCUkppUzNwMm1VdXlDY05x?=
 =?utf-8?B?dzlsMHFPc1BDVlZRNFk3cWdwZHg2VE1ucnFaT3lwdUM0aUFsdk9RNUdDa1Zq?=
 =?utf-8?B?TXlVejBhbWFlQWJRRUxKOGhnTVd0TExUZkZiK2hFejVyb0FGSFRzcmU1c0l0?=
 =?utf-8?B?K1I0dyt6Wk1SWFcyeDlRQk5EZ2hicnczMi9WU25DakN5L2Y5WnZEVFMvU1Vl?=
 =?utf-8?B?U3hJNGg1Sld4eFpYdWI5ekJzeUJ2NEZCK3liQlFveWZ0MEVZSDRhRUVIVkVC?=
 =?utf-8?B?ZUxQN01LNVA0aTA2b3R4bDB3cmoyOUJvZVBRVmxoMmZWMGpvSVRJcUtWOFBn?=
 =?utf-8?B?K1RNSVl3bW5sVDR3U3UzeWZ3emVPYVNRN2JPWFdhdmkzcDkzMzZFbUpPWXJR?=
 =?utf-8?B?MEZWLythWjhESmVnaytNM01PR0FqazZqVGd1YWlqU1E0OTU0SmhQOUtDbThM?=
 =?utf-8?B?ZU1iY1RkWW44eHk0blRSQTBYY3A0TVoxWEh1Y0dSLzdsV2VvcG9IVmkydURC?=
 =?utf-8?B?TlAxRUdEQVBsVVJCOFBVWFV0RGRBcDBqdjMwQVBZMlhKWEtheTVscVFFN1dP?=
 =?utf-8?B?MGRidlp1elA1dFZ4QmxYMGVubS9BK2s3TE9CMExSZkFJT0Y3ZEFXaklqNG4x?=
 =?utf-8?B?QlYyWjUydkhKV2dMN3VJK1hQeGcwU0owQm4rV0dzN0NBRWMxSlpJYmYwRmN0?=
 =?utf-8?B?aGhjUUxHc3lwYndNeDk1QTZIc2NzekRObmJ3K1BqeTVmR25oS2xGWEIwZ1JQ?=
 =?utf-8?B?blVadEhCVzNFa2dtWmJ0OW1lamlwQ0p4Q3IwRHYyRE1pYjI2RmdLVEI5bno2?=
 =?utf-8?B?QmFpZEpZcmhjTXAydDBtRHVZMnJlYzNSZS9YemFwU2J4TWIwblowaG0rUzVU?=
 =?utf-8?B?UzdRTVNUdmRLWnc4TkoxNWlLcVJEUktXSHlkemxuL1dWQkp6UjQrbWFHTTVV?=
 =?utf-8?B?RUplcVlMOXVNeW5aejlOOEdnL1JuMHcyeFIvRXFNaGtMaDBYS3B1eVJDaUtB?=
 =?utf-8?B?SjB0UTBrRWZqOVdtTDJqYW5uTC9hVHFtWHFsVzk0ZUlyOEkySzlPeklCaW5z?=
 =?utf-8?B?Vnh6QWtOMCtsOURkQzNIR0JXTFNkMHZFNjFwbklFeDd0eDFsUUZaSllwcmNn?=
 =?utf-8?B?ZTN4Q3B0cXlCbHZYREtwUVprMGpRcXpzNDVBbmhOU3BDbDJnY1ZzeFFEMk0r?=
 =?utf-8?B?eEhMdXRMM1V3R2diZWZ4QWEwdXYwWmgyM0EwMGtMVHB5VnhEek5SV3h1ZW1v?=
 =?utf-8?B?b2NkQlZNeXg4a3lQeWRLOW02dGVIa0VHcExkeFNITGVpRkhlcTJrb3JoOHZ6?=
 =?utf-8?B?clZOVmUrbGdnWmZSUlY3cXhxOHF0SXd5YWZwN00rdko5NEFSVXNLb0F3Mm4x?=
 =?utf-8?B?UzFOVUVuc2hBVjAvWXBvMTFNS1orcWtYeC9aOXpmWlNqVGl0aE1zalU5RW5E?=
 =?utf-8?Q?8ahDV+ysI+ml5bUj40EaJKiIq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb49a18-7e2e-48c1-aab2-08dbafa5e7d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 13:25:29.6585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kHfMww57Edo7lMZ3G5qtA+WXJAk6Q0dGwvFr4QfulLzLqX7wILzdF/VcLOmJZF54QJKwZZrNSR3juu80iQ2wQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7185
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEhvbmd6aGFuIENoZW4gPGhv
bmd6aGFuLmNoZW5AaW50ZWwuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDYsIDIw
MjMgOTo0MSBBTQ0KPlRvOiB4ZW5vbWFpQGxpc3RzLmxpbnV4LmRldg0KPlN1YmplY3Q6IFtQQVRD
SF0gcGlwZWxpbmU6IGlycTogYWNrIHRoZSBpcnEgd2hlbiBpdCBpcyBwb3N0cG9uZWQgaW5iYW5k
IGlycQ0KPmZyb20gb3V0c2lkZSBvZiB0aGUgcGlwZWxpbmUgZW50cnkgcGF0aC4NCj4NCj4xLiBU
byBhdm9pZCBkb3VibGUgYWNrIGZvciB0aGUgaW50ZXJydXB0IHRoYXQgYWxyZWFkeSBhY2tlZCBp
bg0KPiAgIHBpcGVsaW5lIGVudHJ5IHBhdGgsIHdlIGFkZCBuZXcgZmxhZyB0byBub3RlIHN1Y2gg
c3RhdHVzIGFuZA0KPiAgIGRpZmZlcmVudGlhdGUuDQo+Mi4gRm9yIHBvc3Rwb25lZCBzdGFja2Vk
IGVkZ2UgaXJxIHRoYXQgaXMgaGFuZGxpbmcgb3V0c2lkZSBvZiB0aGUNCj4gICBwaXBlbGluZSBl
bnRyeSBwYXRoLCBhcyBkaXNjdXNzZWQgaW4gWzFdLCBhY2sgdGhlIGlycSBkaXJlY3RseQ0KPiAg
IGJlY2F1c2UgaXQgd291bGQgbmV2ZXIgYmUgYWNrZWQgaW4gdGhlIHBpcGVsaW5lIGVudHJ5IHBh
dGguDQo+DQo+WzFdOg0KPmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3hlbm9tYWkvQlk1UFIxMU1C
NDI3NkZFRkEyQzZEODhDNEI2Q0ZGRUZDRjJFDQo+OUFAQlk1UFIxMU1CNDI3Ni5uYW1wcmQxMS5w
cm9kLm91dGxvb2suY29tL1QvI3QNCj4NCj5TaWduZWQtb2ZmLWJ5OiBIb25nemhhbiBDaGVuIDxo
b25nemhhbi5jaGVuQGludGVsLmNvbT4NCj4NCj5kaWZmIC0tZ2l0IGEva2VybmVsL2lycS9jaGlw
LmMgYi9rZXJuZWwvaXJxL2NoaXAuYw0KPmluZGV4IDZhY2E2YzAzNmFkYS4uNzI4MGEzMzhiZDNl
IDEwMDY0NA0KPi0tLSBhL2tlcm5lbC9pcnEvY2hpcC5jDQo+KysrIGIva2VybmVsL2lycS9jaGlw
LmMNCj5AQCAtODYzLDE0ICs4NjMsMjMgQEAgdm9pZCBoYW5kbGVfZWRnZV9pcnEoc3RydWN0IGly
cV9kZXNjICpkZXNjKQ0KPiAJCWNoaXAtPmlycV9hY2soJmRlc2MtPmlycV9kYXRhKTsNCj4gCQlk
ZXNjLT5pc3RhdGUgfD0gSVJRU19FREdFOw0KPiAJCWhhbmRsZV9vb2JfaXJxKGRlc2MpOw0KPisN
Cj4rCQkvKiBGb3IgaW5iYW5kIGlycSwgd2UgdGFnIGFja2VkIHN0YXR1cw0KPisJCSAqIHRvIGF2
b2lkIGRvdWJsZSBhY2sNCj4rCQkgKi8NCj4rCQlpZiAoIWlycV9zZXR0aW5nc19pc19vb2IoZGVz
YykpDQo+KwkJCWRlc2MtPmlzdGF0ZSB8PSBJUlFTX0FDSzsNCg0KUGxlYXNlIGlnbm9yZSB0aGlz
IHBhdGNoLiBuZWVkIHRvIGJlIG9wdGltaXplZCBoZXJlLg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFu
IENoZW4NCj4rDQo+IAkJZ290byBvdXRfdW5sb2NrOw0KPiAJfQ0KPg0KPiAJa3N0YXRfaW5jcl9p
cnFzX3RoaXNfY3B1KGRlc2MpOw0KPg0KPiAJLyogU3RhcnQgaGFuZGxpbmcgdGhlIGlycSAqLw0K
Pi0JaWYgKCFpcnFzX3BpcGVsaW5lZCgpKQ0KPisJaWYgKCEoZGVzYy0+aXN0YXRlICYgSVJRU19B
Q0spKQ0KPiAJCWNoaXAtPmlycV9hY2soJmRlc2MtPmlycV9kYXRhKTsNCj4rCWVsc2UNCj4rCQlk
ZXNjLT5pc3RhdGUgJj0gfklSUVNfQUNLOw0KPg0KPiAJZG8gew0KPiAJCWlmICh1bmxpa2VseSgh
ZGVzYy0+YWN0aW9uKSkgew0KPmRpZmYgLS1naXQgYS9rZXJuZWwvaXJxL2ludGVybmFscy5oIGIv
a2VybmVsL2lycS9pbnRlcm5hbHMuaA0KPmluZGV4IGE5MTIxZjZlNmYxYy4uMWI0MzQ2N2I1NDA3
IDEwMDY0NA0KPi0tLSBhL2tlcm5lbC9pcnEvaW50ZXJuYWxzLmgNCj4rKysgYi9rZXJuZWwvaXJx
L2ludGVybmFscy5oDQo+QEAgLTU0LDYgKzU0LDcgQEAgZW51bSB7DQo+ICAqIElSUVNfTk1JCQkJ
LSBpcnEgbGluZSBpcyB1c2VkIHRvIGRlbGl2ZXIgTk1Jcw0KPiAgKiBJUlFTX1NZU0ZTCQkJLSBk
ZXNjcmlwdG9yIGhhcyBiZWVuIGFkZGVkIHRvIHN5c2ZzDQo+ICAqIElSUVNfRURHRQkJCS0gaXJx
IGxpbmUgcmVjZWl2ZWQgYW4gZWRnZSBldmVudA0KPisgKiBJUlFTX0FDSwkJCS0gYWNrZWQgaXJx
IGxpbmUNCj4gICovDQo+IGVudW0gew0KPiAJSVJRU19BVVRPREVURUNUCQk9IDB4MDAwMDAwMDEs
DQo+QEAgLTY4LDYgKzY5LDcgQEAgZW51bSB7DQo+IAlJUlFTX05NSQkJPSAweDAwMDAyMDAwLA0K
PiAJSVJRU19TWVNGUwkJPSAweDAwMDA0MDAwLA0KPiAJSVJRU19FREdFCQk9IDB4MDAwMDgwMDAs
DQo+KwlJUlFTX0FDSwkJPSAweDAwMDEwMDAwLA0KPiB9Ow0KPg0KPiAjaW5jbHVkZSAiZGVidWcu
aCINCj4tLQ0KPjIuMTcuMQ0KPg0KDQo=
