Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF761841
	for <xenomai@lists.linux.dev>; Wed, 21 Sep 2022 02:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663726983; x=1695262983;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=9Mh4VE1/Gj3sAN7BQoRnWDaAQ27/9zb+2MM2rF7StQE=;
  b=mYk2tc250KVjXdNxr4d9U7UhfR/oMhwBA9vy+hYwmoijnqeRXlN6ihDc
   wJO0WUBVFHHRynqbnVYNyInYdwf5zZqRKvYa4KdNRpthKUlND4G1ddtl0
   RFJNQ7395Wju7iHQBotFDfToHSeTyxaeqE1ja7tzoDI1QOkAe0uT8rL6v
   Uud0A73FnbpvjEe9B9ISndik1yq/HB7u0Ey7lAxNXX/MGo7+metw7mB0c
   SVeShHK02BUn1IA4SJeWO6ZVeKpsLPhUxHn9yrAJnUI4ypdCTLaDH/T01
   fIqJiiOQ3lZY70tpcgYzHqV62asjiwe46RFeEldffNy0n/Q8orkq/Kbf2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="363852218"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="363852218"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 19:22:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="621496750"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 20 Sep 2022 19:22:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 19:22:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 19:22:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 20 Sep 2022 19:22:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 20 Sep 2022 19:22:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYgUXpsPBqt58xfNskLQf2xW9Bb6139wzznGTcwxnHCTPa09bC5AUW6Eqy7/Ss4N1jx7tE1LewEQDNOglql6BIOyvn0f8Q8vPXCLCTk9OMK/vsk5BcfEDgjODqICSyEvZ0ON/yHS1+w9DdThHTmJ4hBEYDQbV7KTfYIjvlYk7Ee8ED0mqd9JWOsOzas83ScNa8C6dmSF94jW93QNfYndNmZM6xO+BvuFMmj8eWFPlqX8ZIzCB9ervEHfXbs9SFVuPNIS5DWU/mnIQ50p5rAzBrH/7aMU4Ay4BOum/LT/+svucRgTaIf3XDjEf0K70MkxtM/OfkkOt4pMnR8ycCAxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Mh4VE1/Gj3sAN7BQoRnWDaAQ27/9zb+2MM2rF7StQE=;
 b=HC2MU1+b/MmjSACBB1buh58YLXp1Zp5C5gb/evb2SQoIuBHSzUl9Sq/WEs2hiEtAstW6eyz5LigkUD5HyKzcer0CfxKL+SEwY7NwdhYL5o+dWU+TGW+8szEafTs1Qd5ayDgdUaqJZQxdmurqHv8CoT7zjlww3Xvu/FIoOWDhCnO7wNxYV7ergyyvaY5adwKLtegBFxr9Yj+e8TaJ6FdnXu55eigp9jbLZuF6QMeXorCZrZDYNm4T4FmlhehHgA9HJTEqK4NasvWchzkt+9DTMmR1KpmoDrjF7aPy6xHfwiPTy0Acn2xP+Ux/m6FUXdgT+7raXqwhKlhJ5l3g0nLEKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by CH0PR11MB5562.namprd11.prod.outlook.com (2603:10b6:610:d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 02:22:53 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::d461:9280:aab7:e2f5]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::d461:9280:aab7:e2f5%7]) with mapi id 15.20.5654.014; Wed, 21 Sep 2022
 02:22:53 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: How to debug realtime interrupt latency
Thread-Topic: How to debug realtime interrupt latency
Thread-Index: AQHYzAv4CNLljF6+OES35pLMXLUCVK3pJGjA
Date: Wed, 21 Sep 2022 02:22:52 +0000
Message-ID: <MN2PR11MB42854F88BC212E32EA6D6885F24F9@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <4WAGIR.N142QYZSDNER1@lapp.in2p3.fr>
In-Reply-To: <4WAGIR.N142QYZSDNER1@lapp.in2p3.fr>
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
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|CH0PR11MB5562:EE_
x-ms-office365-filtering-correlation-id: 08dc4dfb-e87b-49fe-cfa2-08da9b782ffe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i3UEnzAP5jrkwiRzhsvq1LsiucAy9kwblp5kTxpYKd+nzTxA//1gcBapjxgmBnc6pmKp95X1572cjH47qvQstQYFYXeFmLQSjRrq0nZNkxnj+ns8dabbO1F61AwIhfDPpircF1pbpmA/v9ND8mvY2moJGT3S3zRgQEu+7n5oytnS6Rjg+qkuXKxipjTmWy6xca13piVsWQyz38lw1yIcV0/kq2lwGq9a2MOP57lqyk9CfYoSeOwlTfYA0oTmo1uMrS+pp/kNc8YQI7MWOQ3MhLDqKskDIiNWOv9tEIMYHlXWyI3+Ev6EYoo3iSPHQBqEftaLBdoYQ9GDQZpReIdw7F//nqrSaksOnWnUfr4F6QsMmGiqUM/S5hsQ9xETK0WQ3vQdCAV8sfwdiS/Ki2D7Oi3Yclh2mejU9uUoqmf8tMQ1WwLL15k11vjSSL1iT8jNggTWZkIqe6M7iaLVrsJOhnrddg2IdPIaZiBusTrbYDbkX2ka+KKLxnjTdvgN5b10egtiNTg2jizB6+sMGDqhBVPLbUKZIJX8ZIgT2xKtzr1bdST+tDwimUxcBCxKtCJzurQd3xvGlBqtkcp1SIvzhFf41QbEjJLIFUR+4b0VOklmTQqH1IJxxr5Edp3XCD3xgG6LE3z3svVxDYAss6ujTsM0Rzv/xSPAcs4d/f+whtbjVuIQX1JMw1i0RsqU1OFdgdzYX344oVbQrQbiyrgaSvlyr1lW1hoQZChsCq600BqYU/+bjOZqoAqKHnuX8r//ft+3IrY7R+yaByPCdn9Lnj6iFs+ZXyYEXoahSP4Y+GXF+BX/CUvwPvqretCMvPWE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199015)(38070700005)(7696005)(6506007)(71200400001)(9686003)(26005)(66446008)(66476007)(66556008)(64756008)(86362001)(110136005)(66946007)(8676002)(76116006)(41300700001)(33656002)(55016003)(82960400001)(122000001)(38100700002)(83380400001)(186003)(2906002)(478600001)(316002)(5660300002)(8936002)(52536014)(15866825006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTIrUGdieVRQUTBiS3JQbHlDTzRNM24wOTlqT0lNMmMrc1VJKzYvejF4QTFE?=
 =?utf-8?B?SXFXbWd5VGF5d0k0bEVrNWUvNncrc3A1OUZMaUhqU1lQQy9aR0Q4b2hlOGRp?=
 =?utf-8?B?a2t1N0R6N2lKY1NPMG1PeW95QWRHbEhsNlJPY1IzREpzdm5HUkRJcStNNUx0?=
 =?utf-8?B?M0hIL1huSzdwV1U5emhGK3l6NmRESVk2QWZUUkNsMm9aSnBXelZZci96UkZw?=
 =?utf-8?B?b0loQ2pTclZyMTRGSFdDY1lUeGk3UENWRFkwWHEwWFVDUThSaUhmaUcyajNM?=
 =?utf-8?B?c3pQWXlaUUQzK3N4bVhRTFhQdnhzRVhDR3lrWitaMW5yWkNEdjI4Tk9qT1Zk?=
 =?utf-8?B?N0dlQWdlTjV2QXZuTkRYdEhhbUR4c1hrcHZWT2JzR1NUbVo3OU5Od1phOGk2?=
 =?utf-8?B?L1VjeEpHenlPckRZQlRFaFprQVBEOVNabDZEYnhDL2JGNUFlcnJPSkI0RWor?=
 =?utf-8?B?MVJLcFFud3dwdUtEb2RhVFZRTVRPQzloQ2dZVWlMZnFaTThhSFU4ZjA3cTds?=
 =?utf-8?B?c21nMkFqVVBhcUovaTZWUTJwYXBqOHRrd2lYN0FjeWhWZGVaZjZiaUlLelZm?=
 =?utf-8?B?V0ZrL3dma1pIVWxGeStvSUt0WDRMd2d1YmxZb0RJc1k0eW5JMjVIU01iblA2?=
 =?utf-8?B?Q2Fnd1hMZDVZckh3dnh0TEpWMS9BcnpncVNIMDBCVjB1OTRBNWZoMkcvbVR0?=
 =?utf-8?B?U2oyNmJmV29KQ3dQMXBTbDdvcS9nS3NlOEFxenIzLzZicUVGMlJrQlcvc1Br?=
 =?utf-8?B?QVkrczAxY3gyVDA1RWdxdjhTVG14akZveFB0Ynh5bis3cWk1cjhDOHRDWHA3?=
 =?utf-8?B?Tm9hV25jd3dKakt1aHozN09Pdml2RmRNV0RUMUVHbmNPbzdiRjBBcDRKYm81?=
 =?utf-8?B?b0FQTEtqaUl1L2ZxZXZDZDd4Mmo2RlVmenpubnVYZEMzUXZ0UHV5dG5lUG0z?=
 =?utf-8?B?MUMyLy9mSElkbCtweUkyYlJSQXpXM0szV0EyQWJNRmtNSHBWWlVuM09USVVk?=
 =?utf-8?B?K0twenNxWmJzTG9nZERPUnBFeUVUdTVHbWgxQWFETnNWUVNLOHRSQXk0SXF6?=
 =?utf-8?B?TVREbTB5bXlTQy9MczV1N2E0NG5oSEhaZUU2ZmtGZDl4Y0RjT25sSGJ2SFhG?=
 =?utf-8?B?VEc4OWdISm9xRSs4ZnFaelRSdGtiRlBJZjFCS253VlVUdmc2ZEZWTG9MRWNZ?=
 =?utf-8?B?cVg0dkNoemE0ZmVXZFZTNzNhaHEvTEFEU3R0ejNsVm45RkdwUjBxc29PMUY1?=
 =?utf-8?B?cis3dWxrTkZxU2dpR1FXcXh5NHdGL29uMTh3aUpoR3FQcERTQ0sxaTBpRkxZ?=
 =?utf-8?B?bTI5MmdVUjk2RXJsVjJtd2w0bVVRaEIzZGV4YUtqbmcxN2RZaWxvV0hnTEFW?=
 =?utf-8?B?b3ZMNHkzMjVpYmlueFRtWUJUWlJKRXJudUJqWThuekxCdjdnQld3MjdBWVVE?=
 =?utf-8?B?ZXFtUXRFQWFiU3FydzBwTks3T1NSS1Z6Z25sVXllRkc5aXdWblJCWnpJNjc3?=
 =?utf-8?B?bDduOGJmMUtpWG1XTHJhOWVHL1JYcFlidUp3RnNaSkxmWDNuN2pWV0REZDF0?=
 =?utf-8?B?dkhIbElmMFgwdHM0TWtZYjF2cktPZy9uTUlwZ1RTM0hwUVVyTnZZakVpMWFx?=
 =?utf-8?B?V1RCWWlqamExK2REVjJsV29vZ1VyT3hVaTdnSDhjYVQxY0xXWERnbWY0OUpV?=
 =?utf-8?B?SmlZRi9Gald3dDJScFdNWFczeGlwRG94U3p2ZXNncXFFZ1EyeDcySThvVnhx?=
 =?utf-8?B?aXJWQkZWVUR0T0NvR2FYNllhUm9lM2NkaGVVdUViaFVONjhQSllIMTNyOVAx?=
 =?utf-8?B?UnJkdTF6RGRxUzhWdGduZndSb3UxNHdlVVRudVJabkJ4NVJXeVhYcUlXMzhm?=
 =?utf-8?B?dTl6WlV6a1NkYmRPWFExbWJqcEIycTlqNStMTko5QjdhekVwVWpqREdqYTF5?=
 =?utf-8?B?R3kzeDFCQXRnUFBXWVhCc245RWtkdEwwMTEwMkhxcVNqTEJhSEtKYVhaa3Zr?=
 =?utf-8?B?NVpDbU9FRGVpRi8zTFpjRUd0RW5qK2xyWGVlWFMyMk9wSG1YcDRkeG5lRXU3?=
 =?utf-8?B?akpiVUdTMndRSEJ3U1JWZTFKeExqVXRVbTZ3L3YzVmFWZmh3YjFEbUlvcFNT?=
 =?utf-8?Q?9dDNFzVBFru+wERFnA6QZrTp7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08dc4dfb-e87b-49fe-cfa2-08da9b782ffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 02:22:52.9330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4abfQyI7XE7nR2fA+NhkhDvq8KjbVJoNY8lxyi+cs8Dgd1KRZvKgRWZd7G3bXWUYDr9gihkZHU8n3eWDfrm7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5562
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVtbWFudWVsIFBhY2F1ZCA8
ZW1tYW51ZWwucGFjYXVkQGxhcHAuaW4ycDMuZnI+DQo+U2VudDogTW9uZGF5LCBTZXB0ZW1iZXIg
MTksIDIwMjIgNTo0MSBQTQ0KPlRvOiB4ZW5vbWFpQGxpc3RzLmxpbnV4LmRldg0KPlN1YmplY3Q6
IEhvdyB0byBkZWJ1ZyByZWFsdGltZSBpbnRlcnJ1cHQgbGF0ZW5jeQ0KPg0KPkhpLA0KPg0KPkxl
dCBtZSBpbnRyb2R1Y2UgbXlzZWxmIGFuZCB3aGF0IEknbSB3b3JraW5nIG9uLiBJJ20gYSBzb2Z0
d2FyZQ0KPmVuZ2luZWVyIHdvcmtpbmcgb24gdGhlIHJlYWwgdGltZSBhY3F1aXNpdGlvbiBhbmQg
Y29udHJvbCBzeXN0ZW0gb2YgdGhlDQo+VmlyZ28gaW50ZXJmZXJvbWV0ZXI6DQo+aHR0cHM6Ly9l
bi53aWtpcGVkaWEub3JnL3dpa2kvVmlyZ29faW50ZXJmZXJvbWV0ZXIgLiBUaGlzIHN5c3RlbSBp
cw0KPmN1cnJlbnRseSBiYXNlZCBvbiBSVEFJIDUuMiwgd2hpY2ggYWxsb3dzIHVzIHRvIGltcGxl
bWVudCBjb250cm9sIGxvb3ANCj51cCB0byA1MCBrSHouIERhdGEgYXJlIGV4Y2hhbmdlZCB1c2lu
ZyBvcHRpY2FsIGxpbmtzIG9mIGluLWhvdXNlIFBDSWUNCj5ib2FyZHMuIFRoZXNlIGJvYXJkcyBh
cmUgc3luY2hyb25pemVkIHVzaW5nIGEgZGlzdHJpYnV0ZWQgY2xvY2suIEVhY2gNCj5pdGVyYXRp
b24gb2YgdGhlIGNvbnRyb2wgbG9vcCBpcyB0cmlnZ2VyZWQgYnkgYW4gaW50ZXJydXB0IGdlbmVy
YXRlZCBieQ0KPnRoZSBQQ0llIGJvYXJkLiBGcm9tIHRoZSBpbnRlcnJ1cHQgaGFuZGxlciwgd2Ug
YXJlIGNhbGxpbmcgYSBsaXN0IG9mDQo+Y29tcHV0YXRpb25hbCBmdW5jdGlvbnMgcnVubmluZyBp
biB1c2VyIHNwYWNlLg0KPg0KPkknbSBjdXJyZW50bHkgZXZhbHVhdGluZyBYZW5vbWFpIDMgYXMg
YSByZXBsYWNlbWVudCBvZiBSVEFJIDUuMi4gVGhlDQo+Zmlyc3Qgc3RlcCBjb25zaXN0IGluIG1l
YXN1cmluZyB0aGUgaW50ZXJydXB0IGxhdGVuY3kuIER1cmluZyBvdXINCj50ZXN0cywgb25lIG9m
IG91ciBtYWNoaW5lcyBzaG93biBiaWdnZXIgd29yc3QgY2FzZSBsYXRlbmNpZXMgdGhhbiB0aGUN
Cj5SVEFJIDUuMiBiYXNlZCBwbGF0Zm9ybSBydW5uaW5nIG9uIHRoZSBzYW1lIGhhcmR3YXJlLCBv
ciBldmVuIHRoYW4gdGhlDQo+c2FtZSBYZW5vbWFpIDMuMSBiYXNlZCBwbGF0Zm9ybSBydW5uaW5n
IG9uIGEgZGlmZmVyZW50IGhhcmR3YXJlLiBUaGF0DQo+aXMgd2h5IEknbSBsb29raW5nIGZvciBh
ZHZpY2Ugb24gaG93IHRvIGRlYnVnIGludGVycnVwdCBsYXRlbmN5Lg0KPg0KPkhlcmUgaXMgbXkg
MyBzZXR1cHM6DQo+DQo+Q2VudE9TIDcgKyBMaW51eCA0LjE0LjExMSArIFJUQUkgNS4yIG9uIERl
bGwgUG93ZXJFZGdlIFI2MzAgSW50ZWwoUikNCj5YZW9uKFIpIENQVSBFNS0yNjIzIHYzIEAgMy4w
MEdIeg0KPkNlbnRPUyA3ICsgTGludXggNC4xNC4xMTEgKyBYZW5vbWFpIDMuMSBvbiBEZWxsIFBv
d2VyRWRnZSBSNjMwIEludGVsKFIpDQo+WGVvbihSKSBDUFUgRTUtMjYyMyB2MyBAIDMuMDBHSHoN
Cj5DZW50T1MgNyArIExpbnV4IDQuMTQuMTExICsgWGVub21haSAzLjEgb24gREVMTCBQb3dlckVk
Z2UgVDc0MCBJbnRlbChSKQ0KPlhlb24oUikgR29sZCA1MjIyIENQVSBAIDMuODBHSHoNCj4NCj5F
eGNlcHQgZm9yIHRoZSBrZXJuZWwsIGFsbCB0aGUgc3lzdGVtcyBydW4gdGhlIHNhbWUgT1MgKE5G
UyBtb3VudGVkDQo+cm9vdCBmaWxlIHN5c3RlbSkuDQo+DQo+VGhlIGludGVycnVwdCBsYXRlbmN5
IG1lYXN1cmVtZW50cyBhcmUgaW4gdGhpcyBmaWd1cmU6DQo+aHR0cDovL2VtbWFudWVsLnBhY2F1
ZC5mcmVlLmZyL3BhcnRhZ2UvaW50ZXJydXB0LWxhdGVuY2llcy5wbmcNCj4NCj5BbGwgdGhlIHN5
c3RlbXMgaGF2ZSBpcnFhZmZpbml0eT0wIGFuZCBpc29sY3B1cz0xLDIsMy4gVGhlIGFmZmluaXR5
IG9mDQo+dGhlIHJlYWwgdGltZSBpbnRlcnJ1cHQgaXMgc2V0IHRvIDEuDQo+DQo+VGhlIHJlYWwg
dGltZSBpbnRlcnJ1cHQgaXMgaW5zdGFsbGVkIHVzaW5nIHJ0X3JlcXVlc3RfaXJxL3J0X2Fzc2ln
bl9pcnENCj5vbiBSVEFJLCBhbmQgeG5pbnRyX2luaXQveG5pbnRyX2FmZmluaXR5IG9uIFhlbm9t
YWkuDQo+VGhlIGludGVycnVwdCBsYXRlbmN5IGlzIG1lYXN1cmVkIHVzaW5nIHRoZSBpbi1ob3Vz
ZSBQQ0llIGJvYXJkIChhIHRpbWUNCj5yZWdpc3RlciBpcyBsYXRjaGVkIHdoZW4gdGhlIGJvYXJk
IGVtaXQgYW4gaW50ZXJydXB0LCBhbmQgYSBjdXJyZW50DQo+dGltZSByZWdpc3RlciBpcyByZWFk
IGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGludGVycnVwdCBoYW5kbGVyKS4NCj4NCj5XaGF0IHdv
dWxkIGV4cGxhaW4gdGhlIGxhdGVuY3kgZGlzdHJpYnV0aW9uIG9uIHRoZSBERUxMIFI2MzAgKyBY
ZW5vbWFpDQo+Y29tcGFyZWQgdG8gUlRBSSBvbiB0aGUgc2FtZSBtYWNoaW5lLCBvciB0byBpdHNl
bGYgb24gdGhlIG90aGVyIG1hY2hpbmUNCj4/DQoNCklzIHRoYXQgcG9zc2libGUgdGhhdCBzb21l
IGludGVycnVwdHMgaGF2ZSBub3QgYmVlbiB0cmlnZ2VyZWQgYXMgZXhwZWN0ZWQ/DQoNCllvdSBt
YXkgZW5hYmxlIC9zeXMva2VybmVsL2RlYnVnL3RyYWNpbmcvZXZlbnRzL2NvYmFsdF9jb3JlL2Nv
YmFsdF9pcnFfZW50cnkNCiYgY29iYWx0X2lycV9leGl0IGV2ZW50cyB0byBkZWJ1ZyBzdWNoIGlz
c3VlLg0KDQo+RG9lcyBYZW5vbWFpIHBlcmZvcm0gc29tZSBvdGhlciB0YXNrcyBiZWZvcmUgdGhl
IHJlYWwgdGltZSBpbnRlcnJ1cHQNCj5oYW5kbGVyIGlzIGNhbGxlZCA/DQoNCkkgZG8gbm90IHRo
aW5rIHRoZXJlIGlzIG90aGVyIHRhc2tzIGNhbiBjYXVzZSBzdWNoIDEwdXMgK2RlbGF5IGJlZm9y
ZSB4ZW5vbWFpIHJlYWwgdGltZSBpbnRlcnJ1cHQNCmhhbmRsZXIgb24geW91ciBwbGF0Zm9ybSB1
bmxlc3Mgb3RoZXIgcmVhbCB0aW1lIGludGVycnVwdCBoYW5kbGVyIG9jY3VweSBjcHUgd2l0aCBp
cnEgb2ZmLg0KDQo+SXMgdGhlcmUgYSB3YXkgaW4gWGVub21haSB0byBtZWFzdXJlIHRoZSBpbnRl
cnJ1cHQgbGF0ZW5jeSBmcm9tIHRoZQ0KPm1vbWVudCB0aGUga2VybmVsIGlzIGF3YWtlbiBieSBh
biBpbnRlcnJ1cHQgc2lnbmFsIGFuZCB0aGUgbW9tZW50DQo+WGVub21haSBjYWxscyB0aGUgaW5z
dGFsbGVkIGludGVycnVwdCBoYW5kbGVyID8NCj4NCj5UaGFua3MsDQo+DQo+CUVtbWFudWVsLg0K
Pg0KPg0KDQo=
