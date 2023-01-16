Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6419410EA
	for <xenomai@lists.linux.dev>; Mon, 16 Jan 2023 03:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673838316; x=1705374316;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=4Lau3qYmz3yWk4OQVTXcOk0XqJmoETaMWKwxcBa9Vzc=;
  b=R7w0qjcMZd4sXV7ev1g/yilQULrvIx6v4xCErEmjY+PzOfSKbNRYc10S
   N6PLjvV6jYPaqXVQXgWAaaF7iQLiOn4qaWcVmXgElQnEi7vS6W6b6Lvmi
   ZxGXPe0LzQXuZSjQz5e3RQyFQQyECl7eDWtZCCTDA+xuthIE0x0Dy/AzL
   9Wtp9Hq1jyNkkLqt0AMjc1a12cj4qzHAPe98zXI/P9kOyIxqCD1oklQpY
   PoMWO1FwV62hmBEBN5xScoYLjnav2O/n07fIG73Er/JflbH0TXeLWL605
   kPq5emwQBTy8CbUHqjrk1pe0tDBRMzAWghPQKY2jZrbVUJOwvQEO2FXX6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="323075220"
X-IronPort-AV: E=Sophos;i="5.97,219,1669104000"; 
   d="scan'208";a="323075220"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 19:05:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="747554246"
X-IronPort-AV: E=Sophos;i="5.97,219,1669104000"; 
   d="scan'208";a="747554246"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jan 2023 19:05:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 15 Jan 2023 19:05:15 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 15 Jan 2023 19:05:15 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 15 Jan 2023 19:05:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWwR9kdiBJ8C2VlG4ihF0P4ZO9Ltb7nIT+5HNs6OwA3X0EcvWUg8Kriu4fD3qzpyq2OK3zed23+DfhIMQZ0erU8WHdtw9qmbzLlqDRWdUG224G79eEp3Z02zW+LcOozecNzB1mn3MuVjUyfFU5xcPa8hn5uwfsk7254BPHeWgZAGFm3mQ2r1AJeJhm9q52HTJGoEHmv4TF3AR8Cu897pgY/VNDg7nag5PikWCkTuT3433bysyaDXo9huonxbkwFaKhxqNeZK/jGNjhy2eSg2ENiuq0UOxogxKApQe9W1yOTbWYPvTkdgNQ+ZjVMjf6SLcBTS7wrMShNiVbt9hS854g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Lau3qYmz3yWk4OQVTXcOk0XqJmoETaMWKwxcBa9Vzc=;
 b=d5M9c8derwvgdfjSrYbgY7NUVt49RzFszOn3y7Ptuc/1Y6rv8y06l5b2r8rb8Avv5jKXnt6pL8zoXhcQE88SjoQiuIq5kepTrwApBgovf6ls6nybX23p9w2bbN+tnDnDPpKe2/3h92pzPytH+aaghCX+8/TljYl4GoOJaenlzbkyoP7SbwszZ/yEEOMAN6S9fqRquYtFrIgUwMeSkpdUQsKaTSCLD6QZBRKx5c8eZxX1KLf7Lif34k58YZfYg1e9EsUapa+PzoeW6yKu67w8GcwHBAO+BhO/FGRv2iBgK/7JjCFWxqTvA2L1wU4F7ncfW3vFHFw/vG4dYPhDgCdNcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 03:05:13 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2%7]) with mapi id 15.20.5986.019; Mon, 16 Jan 2023
 03:05:13 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Yunjie Gu <yunjie.gu1@gmail.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: while loop in a multi-core cpu
Thread-Topic: while loop in a multi-core cpu
Thread-Index: AQHZKPuJYrpVvpaAY0Snx/eP6+qfq66gWcgA
Date: Mon, 16 Jan 2023 03:05:12 +0000
Message-ID: <MN2PR11MB42854A69C41937ADA0F29CDAF2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <1673779013-11742-mlmmj-00f27513@lists.linux.dev>
 <CAKcohPxHzbQvztgQMQaFq-EoXGbpfQxi1HpPV9nogBUaQ+PUSw@mail.gmail.com>
 <CAKcohPxdhCMohJZfSNaL2EvEDcLdm8CRgdy3hUusCu9Y5jexxw@mail.gmail.com>
In-Reply-To: <CAKcohPxdhCMohJZfSNaL2EvEDcLdm8CRgdy3hUusCu9Y5jexxw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|PH0PR11MB5095:EE_
x-ms-office365-filtering-correlation-id: 481224a6-5ba3-49e8-01bf-08daf76e7bf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oaa8AIuCiBRgc7D1DaMqTi3rw4kes/1yLxf+R/QgzqrBo4ppJ5TL04/k/2xksrPsLDuD5FJAC4sjTA9DcI2x5vKJkll+amXjj/dAdx66paSLAjsEl8DWoIwAy5NH+enZH7fgeJyhcZXeRfSn6lBCLLhlMBsJT97Mjyo5/AC3obl3sNo9gndizfFnf67yLaRtlbP0eeMuoZSf/4DHVwxus3aXo1ZfTg0KEErfY0FbRAlarGrVZdJM+aM8g2kS+bVWMmiLf1olbNnYhPCXfuZ3pCsgneq4FvW9idCfrpILBYHPz8ml6RkBNrklKliUOfXrcW2hs40HYcccvZY9bLsqcfJR711YzQJAZtrWhA6BWVZcPotkqhctLXfeiKz/FMj+pq/SAO4CwZilrIWvU4oOJO2H6UzxpUK233BLLquSJounvALgqinpPLTgFHXF3OmEDI3OWtNSt+b+C8eON7Xg3Tg3G63KWQsVWwm223I9BWui1K3GtopzYdiMEj1AW4Aqd97l+iDSCEpwSBK4+qMQO3Ucdns3Nqh2wj9B373w+vGa2ITMG/oKO40z/Bs+o+auTzGhKOu9AUI8aHPX4Q3nUEW2pvClA1ID0k4szcJRmCcpcFi1hCfU/E1bWHW6SYdfiMP5B8lf6rDfVSE6Yi4upq+25iQ/yQ7fu+qoKgRX7NMsqsp4NinDUzEkaIwPrkYq/t/kireCC1NyOFEvzAE0qA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199015)(71200400001)(33656002)(7696005)(66446008)(478600001)(8676002)(64756008)(76116006)(66476007)(66556008)(66946007)(41300700001)(110136005)(316002)(55016003)(82960400001)(38070700005)(122000001)(38100700002)(6506007)(26005)(9686003)(86362001)(5660300002)(186003)(83380400001)(2906002)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmFuc1VBV1A2STV0MFJwRnV3M0xPeHljYnB6Q0RXYXpxdVN5N2ZkTDdXMDVG?=
 =?utf-8?B?UW1YcGxhbFB6bXIwTFRHbzV4ZWYzQ0ZHOEpBalRzTzh2ZjRLcWRIUnRBbS9o?=
 =?utf-8?B?cmlmZ1YyOHA3MTdCdWhGdlE4UGk4cUtyRUU0TGloM0NKR1BSYjJGRFJQc3Ju?=
 =?utf-8?B?UUlCT3A1eGxlUGZXT3k4eURnUmxMaHM1T3krNUxSNTJPaC8zOXVXTmdBaERp?=
 =?utf-8?B?MlZ5dWNIR293YkdtMVptV0F4ZStEM2dRTTlOcmk3c3BXbFN5VGJzNEV5K2lK?=
 =?utf-8?B?T1NXK1BDM0N1N1FOdWoxZFU0WFlKOTBmUWRxSGx5MVNZbFAzcTZEalNzeDNT?=
 =?utf-8?B?UXpJVFlQSHNpYzdIL1QzWjdDQlR1T05yTDBNQ2RZTjBBVEk1dnU1aEtSSGox?=
 =?utf-8?B?bGJ4eHZHc256S2U1TGZPTGx3aFFWRjBJdEswdWhMN0FnK1cyY3dDR052Z0FE?=
 =?utf-8?B?QkJvMlhvTGxKN1E1ZmVaSVhGOHB2WVMzMS9oT0xYajB4NHhYR2o4S0kwL1J0?=
 =?utf-8?B?aEp0VjQ4aFVnQTBjK3U5N25jdWJoM09vQ2hoOTd4V3htSW9QSlprNHVVRXZZ?=
 =?utf-8?B?WTdSeXdJU2Vha1J0cExpdllOUytvV2c2Njh3QjFUS2Y4T3pwY2NxWW9QeWxU?=
 =?utf-8?B?UWUzVjdaY0llTXZmdmxEcldqd3JEc0ZhZDVwOUhvOGg2Nm5RUFI1bU9Ma3dv?=
 =?utf-8?B?a2pWU2hwdU8zR3p4OWJ2Nm15ZkhNS1AyclRIMUpHTnhTYlI1WEJLMTdDdnQ1?=
 =?utf-8?B?WGpZTy8rM2o4VXhkLzBIY2djN2xIMkV2TXEzSWZKZjhoaU5Qcm1jMUxMT3Zt?=
 =?utf-8?B?QVF2Y2pkMkhERW5QalpaWWd5Z09SY3ZWMk9aaUFBMkYvNjdBTHFBYnlPZTZj?=
 =?utf-8?B?OVZHOW1ySkM4UC9CcUVHblJHNUF4THBlWndFMlBUazE2aFV3bnAxRk1zTmtN?=
 =?utf-8?B?ZWg1MzFCNS9aaU1VRWt0NDE2eTlqLzdMd2tIN1JuVFhpMUNwSy8yVzZSak4y?=
 =?utf-8?B?MWxwUElIb1gvdHV5QXIvK0dUQmRaeDcwN1U3NFhhU2kvNHJjeGZUVUw5VXFS?=
 =?utf-8?B?UnJOVzdzU1l5alpZeldBcE5qM0d1MjMyb0xwbDBYWkYvNTBTK2tNMlF5T1hz?=
 =?utf-8?B?U0YrWjNHaDZvRWU2OU9RQndXOEZtdmFtam5rUmZsSkdScExaa3JoZG54UzA5?=
 =?utf-8?B?dXVDdDYxMUtvMy9ZVWZjRGJJYmxEYWF3bmh4dlJBQjhvVXhGMmxYSGNrdjRX?=
 =?utf-8?B?WVJ2SWR3eWJKbWswMUZYWEFHKzJkYWhTZWprOXlEeVh2ZmRzanBhV0h2UnJJ?=
 =?utf-8?B?b3M0ZWpST0cxTjYrWDh4aUtWZkh5VCt2djIyeWU5RmRYdkNLdzhGRnAvNmVE?=
 =?utf-8?B?UmgvRjNvYU1FM1dpemorU3dDeG1hZmhyclE4WmNXbjZLTDhkeDh0UkJiUkw2?=
 =?utf-8?B?T1orWHdZWVFjM0lsd1BiNnV5VWlhbDFGd1hGOTkyTUZ1ZE1OZEdDcDFqdjdx?=
 =?utf-8?B?eVZEL1N2bXdXMVRydnRFR3BzQ1o1eFVWbUtJNkMxUWltejUzelRPRE1DQUV0?=
 =?utf-8?B?U0RmSk9ZVzk0dlA3ZjRyYjZIYm0wamN1eGUwOTlxNEZQZkxoTDNKUXZwcTR0?=
 =?utf-8?B?dGFtUU83VkhTa25uajRXeVVhbW5PbTJYOS85TUNhelhhTlFTaXpxT0lhVGdW?=
 =?utf-8?B?MTAvRnRTaFdpUUIyaHd1cDlxSkhvSVk0Y0plS1ltQklvMWkzeUxYVzVEaFpy?=
 =?utf-8?B?WmpKd082NGpkWk81bm5yZTFaMGQ5cVNMOFhKSDhCZnlyWVJ2ckRRbzdtRW1O?=
 =?utf-8?B?cEczRC94R0UzamdpbHZsbE5uelJZcUozT2JMNlBHRWZYSU9aOEJvNmo0S0ln?=
 =?utf-8?B?RFE2bDhscTkweEtUeUNhQzViV29zN0JjaGZaeTZiVGE1bUkrL282d2NjLytq?=
 =?utf-8?B?aGljTk43UWtLbjNwZmZUQVB4cFF3NkRMMG9lYXZ2ZDhaTmxweFVieTc2cUwr?=
 =?utf-8?B?Yk9kY2ZQZHVDdzlBbjN2d25mOHNVbkt1dkFPTmg1cHlhSEYvL2Rra0doUUZU?=
 =?utf-8?B?RGl6Z2hPUGhPZitOcm55Z3VubEhQNVBrNUo5VTRQSnJxVlFNQnZCYUt2Slhz?=
 =?utf-8?Q?ICXifRQkxypeyzUURgchuU/AQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 481224a6-5ba3-49e8-01bf-08daf76e7bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 03:05:12.3798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I7M87l0I3CMwow2KehVVYsY64i2MBxDaLBPSW/EyATmiVzUpHTVxqKdb6SSaBPXby/AYrdMaMRko3oydIWCt7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5095
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFl1bmppZSBHdSA8eXVuamll
Lmd1MUBnbWFpbC5jb20+DQo+U2VudDogTW9uZGF5LCBKYW51YXJ5IDE2LCAyMDIzIDEyOjA4IEFN
DQo+VG86IHhlbm9tYWlAbGlzdHMubGludXguZGV2DQo+U3ViamVjdDogd2hpbGUgbG9vcCBpbiBh
IG11bHRpLWNvcmUgY3B1DQo+DQo+SGkgR3V5cywNCj4NCj5XZSBhcmUgdHJ5aW5nIHRvIGRldmVs
b3AgYSBwb2xsaW5nIG1vZGUgdGhyZWFkIHRvIHNraXAgdGhlIGRlbGF5IG9mDQo+dGhlIGludGVy
cnVwdCByZXNwb25zZS4gVGhpcyBpcyBkb25lIGJ5IGEgd2hpbGUgbG9vcCB0byBjaGVjayB0aGUN
Cj5oYXJkd2FyZSAoc2F5IGEgZ3BpbyBvciBhIHRpbWVyKSBjb250aW51b3VzbHkuIFdoZW4gd2Ug
ZGlkIHRoaXMgd2UNCj5mb3VuZCB0aGF0IHRoZSBzeXN0ZW0gd2FzIGZyb3plbiwgbWVhbmluZyB0
aGF0IHRoZSBvdGhlciBjb3JlcyBhcmUgbm90DQo+ZnVuY3Rpb25pbmcgd2hlbiB3ZSBydW4gYSBw
b2xsaW5nIGxvb3Agb24gYSBzaW5nbGUgY29yZS4gQnV0IGlmIHdlIGRvDQo+dGhlIHNhbWUgaW4g
YSBub3JtYWwgTGludXggdGhyZWFkLCB0aGUgc3lzdGVtIGlzIG5vdCBmcm96ZW4uIEknbSBqdXN0
DQo+d29uZGVyaW5nIGlmIHBvbGxpbmcgbW9kZSBpcyBhbGxvd2VkIGZvciB4ZW5vbWFpLCBvciBp
ZiB3ZSBkaWQNCg0KWGVub21haSB0aHJlYWRzIHNob3VsZCBub3QgZG9taW5hdGUgY3B1IHRvbyBt
dWNoIHRpbWUgaW4gZHVhbCBrZXJuZWwgY29uZmlndXJhdGlvbi4NCldoZW4geGVub21haSB3YXMg
ZG9taW5hdGluZyBjcHUgdG9vIGxvbmcgdGltZSwgZnJvbSBMaW51eCAncyB2aWV3LCBjcHUgaXMg
bGlrZSBkZWFkIA0KYW5kIExpbnV4IGNhbiBub3QgaGFuZGxlIGl0IGNvcnJlY3RseSBpbiBzdWNo
IGNhc2UuICBJZiB5b3UgZW5hYmxlIENPTkZJR19YRU5PX09QVF9XQVRDSERPRywNCml0IG1heSBu
b3RpZnkgc3lzdGVtIHRvIGF2b2lkIHN1Y2ggdGhpbmcgZnJvbSBkZWJ1ZyBwb2ludC4NCg0KUmVn
YXJkcw0KDQpIb25nemhhbiBDaGVuIA0KDQo+YW55dGhpbmcgaW5jb3JyZWN0bHkuIEEgc2ltcGxl
IHRlc3QgcGllY2Ugb2YgY29kZSB0byByZXBsaWNhdGUgdGhpcyBpcw0KPmF0dGFjaGVkIGJlbG93
LiBPdXIgY29kZSBydW5zIG9uIFJhc3BiZXJyeVBpQ000IChmb3VyLWNvcmUgQVJNIFY3bCkNCj53
aXRoIExpbnV4IDQuMTkgYW5kIHhlbm9tYWkgMy4xLg0KPg0KPkJlc3QgUmVnYXJkcywNCj5ZdW5q
aWUNCj4NCj4jaW5jbHVkZSA8c3RkaW8uaD4NCj4jaW5jbHVkZSA8dW5pc3RkLmg+DQo+I2luY2x1
ZGUgPGFsY2hlbXkvdGFzay5oPg0KPiNpbmNsdWRlIDxhbGNoZW15L3RpbWVyLmg+DQo+I2luY2x1
ZGUgPGFsY2hlbXkvc2VtLmg+DQo+I2luY2x1ZGUgPHJ0ZG0vdWFwaS9ydGRtLmg+DQo+I2luY2x1
ZGUgPGZjbnRsLmg+DQo+I2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+I2luY2x1ZGUgPHN5cy9p
b2N0bC5oPg0KPiNpbmNsdWRlIDxzeXMvbW1hbi5oPg0KPlJUX1RBU0sgZGVtb190YXNrOw0KPg0K
PnZvaWQgZGVtbyh2b2lkICphcmcpDQo+ew0KPiAgICBSVF9UQVNLICpjdXJ0YXNrOw0KPiAgICBS
VF9UQVNLX0lORk8gY3VydGFza2luZm87DQo+DQo+ICAgIGN1cnRhc2s9cnRfdGFza19zZWxmKCk7
DQo+ICAgIHJ0X3Rhc2tfaW5xdWlyZShjdXJ0YXNrLCZjdXJ0YXNraW5mbyk7DQo+DQo+ICAgIHBy
aW50ZigiVGFzayBuYW1lIDogJXMgXG4iLCBjdXJ0YXNraW5mby5uYW1lKTsNCj4NCj4gICAgICAg
IC8vLS0tLS0tLS0tLS0tLS0tLS0tIGhlbGxvIHdvcmxkIC0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ICAgIHdoaWxlICgxKQ0KPiAgICB7DQo+ICAgICAgICBwcmludGYoIkhlbGxvIFdvcmxkIVxuIik7
DQo+ICAgIH0NCj4NCj59DQo+DQo+aW50IG1haW4oaW50IGFyZ2MsIGNoYXIqIGFyZ3ZbXSkNCj57
DQo+ICAgIGNoYXIgIHN0clsxMF07DQo+DQo+ICAgIC8vIHJ0X3ByaW50X2F1dG9faW5pdCgxKTsN
Cj4NCj4gICAgbWxvY2thbGwoTUNMX0NVUlJFTlR8TUNMX0ZVVFVSRSk7DQo+DQo+ICAgIHByaW50
Zigic3RhcnQgdGFza1xuIik7DQo+DQo+ICAgIHNwcmludGYoc3RyLCJoZWxsbyIpOw0KPiAgICBy
dF90YXNrX2NyZWF0ZSgmZGVtb190YXNrLCBzdHIsIDAsIDUwLCAwKTsNCj4NCj4gICAgcnRfdGFz
a19zdGFydCgmZGVtb190YXNrLCAmZGVtbywgMCk7DQo+ICAgIHBhdXNlKCk7DQo+ICAgIHJ0X3Rh
c2tfZGVsZXRlKCZkZW1vX3Rhc2spOw0KPn0NCg0K
