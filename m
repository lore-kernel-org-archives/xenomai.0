Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDAD7F
	for <xenomai@lists.linux.dev>; Sat, 24 Sep 2022 00:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663977678; x=1695513678;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rP6xPG92lqQtebjHYYQ6zVAVPOw1UX7WMsog1EC4miM=;
  b=NgAj4JOFpvBwXSjwHc3esaCDVCZaoxQ0GcoMt8a+wvbIvNhusq+0nYQj
   BwHfd5KJPfAa64wPFzGos9zv9nTJXqpsFczmPGUKx1tnsS8Hvsu3WpPPt
   2kI1SAGVe3UUfmc9ta/Dcm+0zkS7CykoQ4oyK+CH4DMcFq8eXkXbeJ0T4
   t5oK+5O699lHQtx9hNr6RT6es6k2Qaj1X1DVkTLOaHptzJLwXzhFIO+c6
   UZZM29SUHtoeWellMq9uXN6rwxJ0vL7cAR6WekCiai5ltflgVVWojsBgl
   /ZDF9kB4YHoYFT0CNj/kRhSKkmfOmtdh7/WUpfqJeUBGVpjTaMy7P33/9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="299445359"
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="299445359"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 17:01:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="865483699"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 23 Sep 2022 17:01:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 17:01:16 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 17:01:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 23 Sep 2022 17:01:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 23 Sep 2022 17:01:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itEf3V4b3EHdAYRbgMSyC6Kq4CBxWykagxqQz+Pw/M5GanFNsAH7PhQuba8evRwObmQF3qotekEqENKaNh6ZUVj7zObagmPP5Kwh+8B+CvxZz3Xrr/rhc4c8b31U3uS7ZU8yVYZ/0uMNq+W8F/t3UYqgr22HSo3JwzsCo/7vORpRNlYI2plJH/dt7DlPVtcjwGW9xNKQjXOse0NXCiK1U4iXHxVzFqxhxRIxNgMW5D04N66UADXzcBju1NMZDgm/8yayBB3I4TnJVT+bYqad6gFRD1PsNPktX6mOcdkHAbSIJ39zO4OXGyP55luSs2oPzjZSKN05yjt0++qr//VFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rP6xPG92lqQtebjHYYQ6zVAVPOw1UX7WMsog1EC4miM=;
 b=DgdLIjbvbbt0tfz31xMMV1jysQqSv/CRte7H9xJTzl0ppVlsixVA+unmGvwogDzUKUO4E4bjgOVf7fuYuIxoeT4gL6nX6SVKr2yoDWzvJ3ckhAYgae8tp1Dw+gYHd53XHHWOUcbmiUFRw/FSGTtj+henq6dXmJlBiqHIVTfy51/FlleYZZ7+rCLu86try0vy1GCyDdKzzEbzLaj3+WwjlZchnZ9lZ+EPl86GOjFQ2TxDEtVD2XiDZLUtqfaF+AqmOoA4esP6605j/5T88mx2gX7gYvLDvjTqduI+g8rDXEwpf8dTyWSDQvlXUB9xUYxMLrtd4zaKm0l51ylXJ8LkYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by PH0PR11MB4837.namprd11.prod.outlook.com (2603:10b6:510:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Sat, 24 Sep
 2022 00:01:14 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::d461:9280:aab7:e2f5]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::d461:9280:aab7:e2f5%7]) with mapi id 15.20.5654.020; Sat, 24 Sep 2022
 00:01:14 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: How to debug realtime interrupt latency
Thread-Topic: How to debug realtime interrupt latency
Thread-Index: AQHYzAv4CNLljF6+OES35pLMXLUCVK3pdSwAgABxD4CAAp5WgA==
Date: Sat, 24 Sep 2022 00:01:13 +0000
Message-ID: <MN2PR11MB428503099915AEC91F4855E3F2509@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <4WAGIR.N142QYZSDNER1@lapp.in2p3.fr> <87y1ud3vzn.fsf@xenomai.org>
 <X4BKIR.IUOSEN2ZXQGV1@lapp.in2p3.fr>
In-Reply-To: <X4BKIR.IUOSEN2ZXQGV1@lapp.in2p3.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|PH0PR11MB4837:EE_
x-ms-office365-filtering-correlation-id: 6386126b-89ab-412f-7cd1-08da9dbfe51c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BHvBQ/updrVSsXo1VKs9/ElgVhydyTNashH8Idc5fHqZm+Ut9fVupe6aeV99WzNwGv6hC1T18/CHtjagt/drEvAT44ffmyiNlH2rCWtjWsWak8K5VfSgznuf/8lqyyfPEkNmUKvT2M1RqvQpH/fRPlEhJ1WoKk+jm5JXPR2PEG/fpfxhrCYYmorBzKV9EHIc4n63OKcqRHqaQ8+fFSsBzVihtZc12cbaW1d38FJl45Qr9c3LRtwCHLE22tm67XiupoI8BP8y7wbn/smRr0UbvTCbdx4uCi6AL2RZUy4Gfq1B5yWZcRyIoj+xxCVwu5PvfkTuxQGpaz6r9BmA1bLeGFCRvM0kqFh/jVFS/m5SzLMCjymycA70AU/4XJAPNFWzESAIndmxI0bxFz2YdA6EXyasWkUOulBeJj1+e0AFO4R6shg+8aGAjUhlfOa3A9POEH4KIRivNyLmHIm/V2/uX7XI6y1Rnmc3JEHFFfESI+b5lbpySsHQ1x0RzWMJdCSxLwmc5n1H8hH3zFYgj/+hFxRmJDEwQlfG4CYfVxJG8JOF/v1xBzMTjgHEcVrVjg0aALz5Zvs9LJYlILEI+AOlOqMF9wJTc0+LnY3DBx1cCWk8ltaBYXkYiuHmyAG/eIBoLaI1P4rTvhKS0HGShO8PeAqfzKcHN5tqHvFLXvsqODELA7771uQ45Rajj0OW5rdvt5SqbHwwkFPWogqCrEcSx5rU8G3YA3wTdfupQp2uBwZKC6WFGitGZcoq0O1NQdIFrrLUJjrmBNliPtYDlM8frw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199015)(316002)(6916009)(86362001)(2906002)(52536014)(5660300002)(38070700005)(33656002)(4326008)(82960400001)(8936002)(66446008)(38100700002)(122000001)(66476007)(66556008)(76116006)(66946007)(64756008)(66574015)(41300700001)(186003)(26005)(8676002)(6506007)(83380400001)(71200400001)(9686003)(7696005)(478600001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmQwN1dSZSt4ODh3U1dURDNWejBER3cwa0ZzTkZmK3VFeC9lRGU3Z29oRmdr?=
 =?utf-8?B?KzdqaFZxV0VpcE9VeFJEVlNGZS9WaFlWL0gra2FMc2Z6cXdqZVFPZ3VzRHNu?=
 =?utf-8?B?SzNsV2lSUHVnVGovTmxVTlBkYW1sRlNrUm8xaVdaYnk4Zkh4dnowa1QxN0s0?=
 =?utf-8?B?eTZFeko4eVpwL21ZQk4yUStRR3BVTzhNZkJJTDVOc3ZSdHpoWkt2VFRxcVBZ?=
 =?utf-8?B?MEpkaHM5K3FGRVJmUmlHWkZkdGEzaGl4Wi9sdy9ZanpZYTZMaU0wYmppTHR3?=
 =?utf-8?B?bnB5RjJNY0d1cHRzTkZHcWRUL2VqQzR6RStMQ0Z2Vjhscnl0alpkaGNERFBN?=
 =?utf-8?B?TStZbEdNZWVoUlpXK0hkdTZMbzFpV2dRNDJsc054N3l2cks5V3NpVTNWT3lP?=
 =?utf-8?B?VkhaL0lEUTBPQTA5NTN3ZXZwbVdBMGRMcXpzTFU3anl0dXA0MHZxenNMenVD?=
 =?utf-8?B?ZDFmSTdEYk9YeGV5ZWVrLzZNVnpDUGlRL3R3S016Y211N2FYWmp5WlhZT25m?=
 =?utf-8?B?MEhKd2dHcUZTL0svZUNJWlBXeC9HUFR6ei8vTmk5SkllNzBrejRjczFCbFRD?=
 =?utf-8?B?MVJLaXVmMGF6WUliakI2d1VZTmRlVDh0eTVNcFlSaTNtTU1mcGx4UzZ4ZmU5?=
 =?utf-8?B?dk0xUFNZMCtvdVhqem9RRVZzRTA4cm8zOHhDZzliZVQxVVdsbTY4RStHKzBN?=
 =?utf-8?B?T1lOLzlpK1hsUVJad3NMRDZ3L1FvQWFiWm5XUHlMVmkrOUxUN2VhVGJwWGhU?=
 =?utf-8?B?SHIwSDBSSGt5OStOb1FweDRhRytGcUdTVGZhS2RCN2luMWhFclRpSGYyOWlp?=
 =?utf-8?B?N1JZNmZwaTRTNnV0Rm9tbFd2ZXVDRTN2UWVPQkg0R045ay9nOWNBK3F3RGs1?=
 =?utf-8?B?MmlyUDNUY2NudW1Vbm9FaXFkUlFONmFYaS9vdVFTS3FQZTVEeXFhRjRzY3lw?=
 =?utf-8?B?Mm1YQXZIUmJXdmk0WXo5WDNtTWROSENDbHhLTmpXRS9tMGpKcHgxZm1PQ2tX?=
 =?utf-8?B?VTJ4L3JDRm55ZWNIWXZxRVV5Q2V0MzNVbjVFRlRhMjRHdDZhQk9VM2s0azVX?=
 =?utf-8?B?a2NHMFZkci93MFpxNkVUcUR2ZEtmZlhBNlBoQTA3dUx3S0JHV2dHczY1SWJF?=
 =?utf-8?B?UjhWeE01NEdNN0NQdm85WnFvUlZxcVNsQm5GSnBCYkdHcXh4SElsQWd3Ry9x?=
 =?utf-8?B?MXhNUHpLYi9hdXV6MzF1bmxhUE8rcEdidVF1M3lqWXdJMTJxY3ZaVm5SMmV3?=
 =?utf-8?B?Yi8vSlJzcFZvTEZpUm1GN2x3Q283ZVY4d01GYjBaTnV6VUhZTnVocjdPdURt?=
 =?utf-8?B?UUVScWJTdWs1QWZJMDBGZUtrbDdvUDI0Q2FPMkFWWlFzbkJmV2Nqb21ic1JB?=
 =?utf-8?B?VnRwQ1VjSEJ2QU5UeGRGWmd2QlhMTncvdEZrVWMzcDRKZm8wdHp1d1A1N2x1?=
 =?utf-8?B?REYvWGc5cEI5R3hIUHYrOEJVN3VFMnV0VXhMa1dwYUxOY1VnZndQVzdPd2s2?=
 =?utf-8?B?MEJFaDlteHp1ZEJnK0hBZHNIeWJjbXYzbVBWRXNzeWQyNys3K0VVQ1hYZXBH?=
 =?utf-8?B?ZXJMd1pVaDEwR1dvd2FhYXJuVXZXK3ZQYVdCeGxPWjhhOTRsQlVUckhQV2VO?=
 =?utf-8?B?NXgvOVAvbFp5KzVEMklRcE4vdDdLYTUwMmMvc241Y3lveUllTGJvUjZtRDgw?=
 =?utf-8?B?NzdJYUdINlhpaGhNMnBwSWJKcWpBdUJ0MmdLOEFSTDlHWC95RzQ0Q2RKWFJF?=
 =?utf-8?B?SVpNK0MvYlRUeTN2QTBIK085d2I1eXdJTHN4VGZ3KzNQM1ZYbGpoa2pyWnZM?=
 =?utf-8?B?YWtNdExDMzVvekptaUVnanlvZFphSFhuL1lIbjVHVVJnRXZQVUY0YWlXR2ZX?=
 =?utf-8?B?WVExU2lSbEhWSjR6MU5ObTlLTTZXdHVUV3NWS2xUMnU0YUtZOTNhMStxeFd1?=
 =?utf-8?B?RGhkK0ZoRUErd3djZ0IzaDZmZHJjT0FrWWk2WnpQaE5xL01DbWtpWWkrQXFO?=
 =?utf-8?B?ME8xa0prUmVCUDZDanZRVnd2R2IxQUF3dkRTSXRmdmx3NGlIM3pONU56aTU5?=
 =?utf-8?B?MlRJN0dYM2ZjYWwzZ3ZiRFpWYU5NYnA3ZUs2b1FVOFkwdHZiSUtsZUF2TUVE?=
 =?utf-8?Q?C/+znm6KJo3ldGiUP3LhEjFwR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6386126b-89ab-412f-7cd1-08da9dbfe51c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2022 00:01:13.4354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pd2N9gDiJZv8/IPrNe7e5SfJVC8lD9LX2KVU7HXMDxQEtOPJCPPGTtMFoI/xdc5xHftBHvZ36jq02plQSIWVtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4837
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVtbWFudWVsIFBhY2F1ZCA8
ZW1tYW51ZWwucGFjYXVkQGxhcHAuaW4ycDMuZnI+DQo+U2VudDogV2VkbmVzZGF5LCBTZXB0ZW1i
ZXIgMjEsIDIwMjIgOTozNyBQTQ0KPlRvOiBQaGlsaXBwZSBHZXJ1bSA8cnBtQHhlbm9tYWkub3Jn
Pg0KPkNjOiB4ZW5vbWFpQGxpc3RzLmxpbnV4LmRldg0KPlN1YmplY3Q6IFJlOiBIb3cgdG8gZGVi
dWcgcmVhbHRpbWUgaW50ZXJydXB0IGxhdGVuY3kNCj4NCj5IaSBQaGlsaXBwZSwNCj5MZSBtZXIu
LCBzZXB0LiAyMSAyMDIyIGF0IDA4OjUxOjU0ICswMjAwLCBQaGlsaXBwZSBHZXJ1bQ0KPjxycG1A
eGVub21haS5vcmc+IGEgw6ljcml0IDoNCj4+DQo+PiBFbW1hbnVlbCBQYWNhdWQgPGVtbWFudWVs
LnBhY2F1ZEBsYXBwLmluMnAzLmZyPiB3cml0ZXM6DQo+Li4uDQo+Pj4gIFRoZSByZWFsIHRpbWUg
aW50ZXJydXB0IGlzIGluc3RhbGxlZCB1c2luZw0KPj4+ICBydF9yZXF1ZXN0X2lycS9ydF9hc3Np
Z25faXJxIG9uIFJUQUksIGFuZA0KPj4+IHhuaW50cl9pbml0L3huaW50cl9hZmZpbml0eQ0KPj4+
ICBvbiBYZW5vbWFpLg0KPj4+ICBUaGUgaW50ZXJydXB0IGxhdGVuY3kgaXMgbWVhc3VyZWQgdXNp
bmcgdGhlIGluLWhvdXNlIFBDSWUgYm9hcmQgKGENCj4+PiAgdGltZSByZWdpc3RlciBpcyBsYXRj
aGVkIHdoZW4gdGhlIGJvYXJkIGVtaXQgYW4gaW50ZXJydXB0LCBhbmQgYQ0KPj4+ICBjdXJyZW50
IHRpbWUgcmVnaXN0ZXIgaXMgcmVhZCBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBpbnRlcnJ1cHQN
Cj4+PiAgaGFuZGxlcikuDQo+Pj4NCj4+DQo+PiBXaGljaCBpcyB0aGUgZnJlcXVlbmN5IG9mIHRo
ZSB0aW1lciBldmVudCBpbiB0aGlzIHRlc3QgY2FzZT8NCj4NCj5UaGUgUENJZSBib2FyZCBzZW5k
IGFuIGludGVycnVwdCBhdCAxMGtIei4NCj4NCj4+PiAgV2hhdCB3b3VsZCBleHBsYWluIHRoZSBs
YXRlbmN5IGRpc3RyaWJ1dGlvbiBvbiB0aGUgREVMTCBSNjMwICsNCj4+PiBYZW5vbWFpDQo+Pj4g
IGNvbXBhcmVkIHRvIFJUQUkgb24gdGhlIHNhbWUgbWFjaGluZSwgb3IgdG8gaXRzZWxmIG9uIHRo
ZSBvdGhlcg0KPj4+ICBtYWNoaW5lID8NCj4+DQo+PiBIYXJkIHRvIHNheSBBVE0uIDEwLTE1IMK1
cyBjb3VsZCBiZSBleHBsYWluZWQgYnkgc2lnbmlmaWNhbnRseSBtb3JlDQo+PiBjYWNoZQ0KPj4g
bWlzc2VzLCBlLmcuIGFmdGVyIGEgZHJpdmVyIGZvciBhIGdyYXBoaWMgYWRhcHRlciBoYXMgaXNz
dWVkIHdiaW52ZC4NCj4+IE9yDQo+PiBzaW1wbHkgZHVlIHRvIG1vcmUgY29udm9sdXRlZCBjb2Rl
IHBhdGhzIHJ1bm5pbmcgdGhlIElTUi4gSSB1bmRlcnN0YW5kDQo+PiB0aGUgdGVzdCBlbnZpcm9u
bWVudCBiZXR3ZWVuIFJUQUkgNS4yIGFuZCBYZW5vbWFpIDMuMSBkb2VzIG5vdCBjaGFuZ2UsDQo+
PiBzbyBjYWNoZSBpbnZhbGlkYXRpb24gZnJvbSB0aGUga2VybmVsIHNob3VsZCBiaXRlIHRoZSBz
YW1lIHdheQ0KPj4gdGhvdWdoLg0KPg0KPlRoZSBlbnZpcm9ubmVtZW50cyBhcmUgdGhlIHNhbWUs
IGFzIHdlbGwgYXMgdGhlIGtlcm5lbCBjb25maWd1cmF0aW9ucw0KPihleGNlcHQgZm9yIHRoZSBS
VEFJIGFuZCBYZW5vbWFpIHNwZWNpZmljIGNvbmZpZ3VyYXRpb24gb2J2aW91c2x5KS4gU28NCj55
ZXMsIHdlIHNob3VsZCBoYXZlIHNlZW4gdGhlIHNhbWUgYmVoYXZpb3VyIHVzaW5nIFJUQUkuDQo+
DQo+PiAgTG9uZ2VyIElSUSBtYXNraW5nIGlzIGFub3RoZXIgcmVhc29uIG9idmlvdXNseSwgd2hp
Y2ggaXMgb2Z0ZW4gYQ0KPj4gZnVuY3Rpb24gb2YgY2FjaGUgYmVoYXZpb3IgZHVyaW5nIHNvbWUg
aW50ZXJydXB0LWZyZWUgc2VjdGlvbi4NCj4NCj5EbyB5b3UgbWVhbiB0aGVyZSBjb3VsZCBiZSBz
b21lIGludGVycnVwdCBtYXNraW5nIGRvbmUgZnJvbSB0aGUgbm9uDQo+cmVhbCB0aW1lIHBhcnQg
b2YgdGhlIGtlcm5lbCA/DQoNClRoZW9yZXRpY2FsbHksIG5vbiByZWFsIHRpbWUgcGFydCBjYW5u
b3QgbWFzayBwaHlzaWNhbCBpbnRlcnJ1cHQgIHRvIGNwdSBhZnRlciBlbmFibGluZyBYZW5vbWFp
IGJlY2F1c2Ugb2YNCnRoZSBpbnRlcnJ1cHQgdmlydHVhbGl6YXRpb24gbWVjaGFuaXNtIGltcGxl
bWVudGVkIGJ5IEktUElQRSBpbiB4ZW5vbWFpIDMuMS4gVGhhdCBtZWFucyBpdCBzaG91bGQgbm90
IGJlDQpyZWxhdGVkIHRvIHZpcnR1YWwgbWFza2luZyBkb25lIGZyb20gbm9uIHJlYWwgdGltZSBw
YXJ0Lg0KIA0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQoNCj4NCj4+PiAgRG9lcyBYZW5vbWFp
IHBlcmZvcm0gc29tZSBvdGhlciB0YXNrcyBiZWZvcmUgdGhlIHJlYWwgdGltZSBpbnRlcnJ1cHQN
Cj4+PiAgaGFuZGxlciBpcyBjYWxsZWQgPw0KPj4NCj4+IE5vIHVucmVsYXRlZCBob3VzZWtlZXBp
bmcgc3R1ZmYgaXMgcGVyZm9ybWVkLCBvbmx5IElSUSByZWxhdGVkIHdvcmsgaXMNCj4+IGludm9s
dmVkIHVwb24gcmVjZWlwdC4NCj4NCj5Pay4NCj4NCj4+PiAgSXMgdGhlcmUgYSB3YXkgaW4gWGVu
b21haSB0byBtZWFzdXJlIHRoZSBpbnRlcnJ1cHQgbGF0ZW5jeSBmcm9tIHRoZQ0KPj4+ICBtb21l
bnQgdGhlIGtlcm5lbCBpcyBhd2FrZW4gYnkgYW4gaW50ZXJydXB0IHNpZ25hbCBhbmQgdGhlIG1v
bWVudA0KPj4+ICBYZW5vbWFpIGNhbGxzIHRoZSBpbnN0YWxsZWQgaW50ZXJydXB0IGhhbmRsZXIg
Pw0KPj4+DQo+Pg0KPj4gQXMgSG9uZ3poYW4gYWxyZWFkeSBtZW50aW9uZWQsIHlvdSBtYXkgd2Fu
dCB0byBnZXQgc29tZSBmaWd1cmVzIGZyb20NCj4+IHRoZQ0KPj4gJ2xhdGVuY3knIHByb2dyYW0g
WzFdLCBzcGVjaWZpY2FsbHkgdXNpbmcgdGhlICctdDInIG9wdGlvbiwgd2hpY2gNCj4+IG1lYXN1
cmVzIHRoZSBJUlEtdG8tSVNSIGRlbGF5IGluIGtlcm5lbCBzcGFjZSAoZXhjbHVkaW5nIGFueQ0K
Pj4gYWRkaXRpb25hbA0KPj4gbGF0ZW5jeSBicm91Z2h0IGJ5IHN3aXRjaGluZyB1c2VyIGNvbnRl
eHRzKS4gVGhpcyBzaG91bGQgYmUgZXF1aXZhbGVudA0KPj4gdG8geW91ciBjdXJyZW50IHRlc3Qg
Y2FzZSwgYmFycmluZyB0aGUgZXZlbnQgZ2VuZXJhdG9yIGFuZCBjbG9jaw0KPj4gc291cmNlLg0K
Pj4NCj4+IFRoZSBJLXBpcGUgaGFzIGEgYnVpbHQtaW4gdHJhY2VyIChDT05GSUdfSVBJUEVfVFJB
Q0UpOyBydW5uaW5nDQo+PiAnbGF0ZW5jeScNCj4+IHdpdGggdGhlIC1mIG9wdGlvbiB3b3VsZCBn
ZXQgeW91IGEgc25hcHNob3Qgb2YgdGhlIGFjdGl2ZSBjb2RlIHBhdGgNCj4+IGJlZm9yZSB0aGUg
d29yc3QtY2FzZSBmaWd1cmUgd2FzIG1lYXN1cmVkLg0KPg0KPlRoYW5rcyBmb3IgdGhlIGluZm9z
Lg0KPg0KPj4gUXVlc3Rpb246IGFyZSB5b3Ugc3R1Y2sgd2l0aCA0LjE0LCBvciBjb3VsZCB5b3Ug
dXBncmFkZSB0byB0aGUgNS54DQo+PiBrZXJuZWwgc2VyaWVzPyAoNC54IGlzIEVPTCBoZXJlLCB3
ZSBtb3ZlZCBhd2F5IGZyb20gdGhlIGxlZ2FjeSBJLXBpcGUNCj4+IHRvDQo+PiBEb3ZldGFpbCBb
Ml0gd2l0aCBYZW5vbWFpIDMuMikuDQo+DQo+Rm9yIHRoZSB0aW1lIGJlaW5nIGl0IHdvdWxkIGJl
IGJldHRlciBpZiBJIGNvdWxkIHN0YXkgd2l0aCA0LjE0LCBhcyBpdA0KPmxvb2tzIGxpa2UgdGhl
IDUuWCBrZXJuZWwgc2VyaWVzIHJlcXVpcmVzIGEgZ2NjIHZlcnNpb24gbW9yZSByZWNlbnQNCj50
aGF0IHdoYXQgaXMgcHJvdmlkZWQgYnkgb3VyIHN0YW5kYXJkIGJhc2UgT1MgKENlbnRvczcpIC4g
QnV0IEkgd2lsbA0KPmRlZmluaXRlbHkgdGVzdCBYZW5vbWFpIDMgd2l0aCBkb3ZldGFpbC4NCj4N
Cj5UaGFua3MgYWdhaW4sDQo+DQo+CUVtbWFudWVsLg0KPg0KPg0KDQo=
