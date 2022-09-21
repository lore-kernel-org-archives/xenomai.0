Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9E07C
	for <xenomai@lists.linux.dev>; Wed, 21 Sep 2022 08:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663749503; x=1695285503;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9pYdnN3CWsmIcOC33lfKJG2+L4LHUpzKy+mOFGPHy+Q=;
  b=lDXMJXcOlkDUOMBju/UMz1kn/uMm0MB3RCdejAEfOMLZ6FhOH9yvFZ6+
   BPT0B8iISAZchqIwYkv/ndhJH4TB0XOQfwRttAjasm1pgh56EqdjJfgvd
   NN/RYIK6sMmmt/Ya3xKDXCJDfqBFl59Wab4RbMK1nD6FUZgoDz34P740/
   9v3NGjHcLJXA/Sa8D2w+NGAUtGzT38/lEsJ9f6yXGPi3Aq7QuI4yoadur
   PrcW4lGmXmHRjmq+IdhM19bpkmZTVU1bPJvc5trADxHwQDTvS/vc4N7mY
   EwEXF/VYcoNc10vWGF4jv/kEW2Ft8HRrE9P8rBZ7A3xANcBjE7ekknOTf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="299928664"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="299928664"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 01:38:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="761662460"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 21 Sep 2022 01:38:22 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 01:38:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 01:38:22 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 01:38:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNndjPPd6KyIA25kMa4wJFoG7Sa9vmJli6bXXHD81stV9e2Swczvn7pcBKJNIyfNA7FB+JyjpQwtzdk8XI/zBy/IpklQPU2ZOUz30UvMGIsb3+Khh7CAK6yIRDP0U0ur5cZc+L3xDd7e/YpZCIwikL43YrKF7iQVrRaVL092mxg4qVYQdpImJulDOtMfgqakGcFiezOf7nR8g4mPiS9zNqG8kIhUSj/wzMqISH4bYFb6MJJ4TiY1oq9m8jbHb7cKUfH5xUIsB2gRmlLqAWNasftt4HX/jRMtUD/KRCal28+x/UF5+5y1WAlRL2k7WuD2tj7TCEBllGuO1p8pHNwIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pYdnN3CWsmIcOC33lfKJG2+L4LHUpzKy+mOFGPHy+Q=;
 b=hJh39zM7MKEbkM7lzIX+r7zFvw5SZwI/bjG0U/ZmxNc4IlVyO05ItSghEu4ysV3po6VNB8gdvpgPCXru2OVEPlxiFweJreJJUPunflV5YL+p55W0yQ/nvOqO5AQSF2iODjc3czVJqVc/agu4cHcc+87ahC+ENNTHkvI6AAXWaqXznWjBmnh4GJOhXLfwX4R6sAEECj7HzrQomgbx6R++cjixMI8TwQHU2BCa3b1l4JjfWtf6XbyD9h3QcnrBVUiJx72BmREskMtg5QhoOUbefmGa1DLP7NBgapLgkgr19Plz7MB1ue3B9m3gniqE6PkR9ZkqsGuuKp7dQmpqFh6bUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 08:38:19 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::6559:8d47:624e:df6]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::6559:8d47:624e:df6%4]) with mapi id 15.20.5632.017; Wed, 21 Sep 2022
 08:38:19 +0000
From: "Zhang, Qiang1" <qiang1.zhang@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "rpm@xenomai.org"
	<rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: [PATCH] drivers/net: Make rtskb pool cache being an usercopy
 source
Thread-Topic: [PATCH] drivers/net: Make rtskb pool cache being an usercopy
 source
Thread-Index: AQHYzWdbSODqqVMRbkWTJAT3Ocbp8K3pZF+AgAAq6bA=
Date: Wed, 21 Sep 2022 08:38:19 +0000
Message-ID: <PH0PR11MB588040603FD49E24B154EED9DA4F9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220921031416.445763-1-qiang1.zhang@intel.com>
 <2c0cff52-6976-713e-3285-f3215ac00d2b@siemens.com>
In-Reply-To: <2c0cff52-6976-713e-3285-f3215ac00d2b@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|IA0PR11MB7355:EE_
x-ms-office365-filtering-correlation-id: a49f2a97-6f20-4f38-4052-08da9baca2ee
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VaneTtaK3EE+hb1upsPJUEwjOOWkGOFf2cMbpZIlOn7ljWR59/h5N4qkfbADT4rQWS6G+C9WV45MOBjeq9Fbp5Ps4iOmJDiz52I2ghr4z15O266goYake08QJUm+iQrOm5ImWMceC9rcryOtGWz63RIZ0/6xLzYwAmS7IPxyHIIK3s2Oi67WsPWGzDCVJ5vlRhk/ijYqyKPs1HCEll2QIS9VjYuG/73phPx1mKY6N/tWqHrM8UBd8EW/f6zIjGBSQSQgLwNvBEQNuUx/UlUMxWA+Ni/K8W2lv7t5z5eSbsnnxy/yIFslV0+BDe74eZMTwuW3hX1dE50AImN1YFOucTRrmPl7iqcSMjQb+d74suBp5grBnNgy27U8JwLg+fzHMwC/K7c6qd+iibC7bJtbUysm22wDooUU4r/CUudg8MnSSZO0980VblBMLYSc6Kc4vUTktfd9LT4GY7YP4mqhQA4vN9WBQT2t4nzPoIp7arI8ztCzSoH+2qIg03wbYXkhsS9mT4jwAsA3HNioyTRPtljAFfKHmTN1yAbQhj9Alfdy4NNzvYGy5oHNl/LJXsumQE7ocXcMaBwi1HwQ2eJgKvqUO+K9HpbeUX3gyf3jBupxPOsi7gelS+kJeAqIyfCvxkp2djRrnKvuhndAeV+gYAM+smMtY3AQhoV+Yl1DNrA+ExDg1jzGpKoGMzUQP+PqdBLcJXdsSoRwwBL14flwrIXOKPf3UiSAw6ZChsFsqKSId3B3TrazfORIvJGSwz2f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199015)(71200400001)(66476007)(122000001)(33656002)(82960400001)(38070700005)(5660300002)(2906002)(38100700002)(66946007)(478600001)(66556008)(4326008)(64756008)(66446008)(52536014)(110136005)(8936002)(316002)(76116006)(55016003)(186003)(83380400001)(41300700001)(86362001)(26005)(9686003)(7696005)(6506007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VE1HSmErT1lEV29xcWhPdjZXUUc0a1RFUGhwbnVnejdVOVYwYlRuSU1Lb1hR?=
 =?utf-8?B?ZXY5TE5YdGY2Rm5sY3BsYU1TbitIZk5TcVlIY2F2Zi81bHFjOW5NWldwOFlF?=
 =?utf-8?B?aFI5NW91cGxHalRMUUhoV3lFQnhPMTRuWVBCYkJvMG45YjR5K2ZrSGFvSkVR?=
 =?utf-8?B?QVZBNGRiMTE5Uzk2ckJXUlJWeWtadHM2bjVoQWlGWWUvbzBRMElYaGRGYXIy?=
 =?utf-8?B?M3NCU29oZ3N5a2tjb1plSGM4RUdrZWp1WmhlSXl5ZDFwUlowVzUxY1YxUXF3?=
 =?utf-8?B?aGcyZ0RVYjlKOU5jVDd0bnpPVnZCOXZOY24xL2hGc1pzR29LQWI5S2pqUlY1?=
 =?utf-8?B?MGhlWDk0TW5sazlWZnk4ZGRpTVB6RDRTd2ZVbzl2b0QxODJIUTZ0V2x2dTJR?=
 =?utf-8?B?MDZWTkFEcnMrNFlzUFFsRnY1QWpMdHdaUTFXUFlMdDJpZFBhWXZ4bG5YSWF6?=
 =?utf-8?B?NjM4cm43KzBxMFdHUitJQUdvM2RKNVRMWS9pakIzL2pJbTRhbEFqUlYwVVgx?=
 =?utf-8?B?a3MvcUpqdlViaVNNQmJINHdWT3RuejFYdU5JM284RWZEdHhHSEtEMHRSRk5Y?=
 =?utf-8?B?SVFTbHdoenFQeEljSEt3NnhxcU44MEo2MFhuWkRadjdMRklrcFdIWUhGOFRp?=
 =?utf-8?B?ejN2UHdBdWZNUTlTUFpOcyt2RHhmeTJrS3VjaURFQk5LNzZQblNVeE1ZK0ZD?=
 =?utf-8?B?L0lXQ2pxNzRUR2F6ZnJVanJmZHozSFc3L21nRlZraWFiQ2ppN2p6bi9XWDBT?=
 =?utf-8?B?R0t3NmN2TTJrZS9EdXV5N1BQT1ZLRDRYbzdRdmQyWlBNNlR5WGkwYUtVUHJC?=
 =?utf-8?B?djNXY3hvWlAvekNzT1dSUXZHNm9seEdxanlqcVJHdzNEdEtNNXFpN0ZhdGtn?=
 =?utf-8?B?RUg1NThDYUdNajArbU5Ublg5c0tCVk1nZmJwcW5TTEsxOVoxckE2TS9oTURJ?=
 =?utf-8?B?TFNkY2hYcEd6bjFEam5RS0NCdDBjU2dhcFFGMXljcm9qS1FERmxCOFFqbTBB?=
 =?utf-8?B?b0w4R0VQYU11ZnpKeURoWHJuNXRjQmpBZ3hsVDJWcHhXK3E1QUdFYXViNlF5?=
 =?utf-8?B?ZGxzcE4rM01jMGhRa0xGbTVFMHBZRnRRb2RBcVZYMVcrWUlrMUpBMk9Ecm5s?=
 =?utf-8?B?QWg0cmtJZ2JUUU1DUGlyVlhLaG96dGljbHNUc1V5Z2p3U2JUQlRSbG9JeW1r?=
 =?utf-8?B?OWVoNVRObE5IVlNVdVRhaytPeXhJWGs2VDhYOVRaYzljVlV4S3JpeG1leEtQ?=
 =?utf-8?B?aE1WTW5KY0xCc0dPOU9PZlQxa1Vkc2JwMlMzeEtwczZSSTI4STVBaUlJMTkv?=
 =?utf-8?B?dGR6UFc3cnVWTkRRWXo0a2pZSmI1WTQ3V3dUZHlGY2toYUlzUXR6QnFLNzRM?=
 =?utf-8?B?VW5wSXQrekUvRW9aNDc4YlYzMDQ2RjVVOVlQQVZjMnNoRFI4M29ldHdKNEh1?=
 =?utf-8?B?ZkMwVGhpeFRSYnhCckZpT2NUakIyV0w1R1JSQWNsQnZ2ejlNVFBnb0Jua0ZH?=
 =?utf-8?B?ekVJTWpvWFRoTDhaZW5xbXhIUjRncjFrekpPcXVxNVVIZ2N3ZmFOTWgvWnBO?=
 =?utf-8?B?SzFIVUFNSUJNMmE2bTlTY0FZTEVEcFdudUpYdkpveW9nN013NktnS3VMcUg1?=
 =?utf-8?B?QTFJbVZKMk9KR1B1L0tJdWljcGtpelhOUmR2ZVdmTi9zcVozSVJTSFF3dXgy?=
 =?utf-8?B?Q2NiTFpySEJBUVhiZGFYN2pKK2FGZDN5NmtjZlZmbVJXVE5haXJTWjdaYnp0?=
 =?utf-8?B?eW9walVxN25mQUhMaFhkdEpmTnVvNU9QY2NIRWY3NGc2RW1GTWI5MlNrRFRC?=
 =?utf-8?B?U0JSaDJSMVdoTkxoRGRUWEtRbUlzTDJ0eFowekE3cnJkZFhPaU5TTjlvb3lQ?=
 =?utf-8?B?eW5rY1NnWlN6SFRHbExKakt4Q3lzREZ0L0hzWnRGdGpJRnVZc25QY29VMGtR?=
 =?utf-8?B?YVZBK0lNcTNleCtjYlRRckh0UzNnS28wUkRpOUlHL3NPeFpnYWZ5VDcxY05X?=
 =?utf-8?B?UlE5ZlFXeTlUdjJJay9nTDFoWmllcDd6ZkZrZ3dhbVFMbW9Gemc4cG91VWQ3?=
 =?utf-8?B?NVU5cmdDbHBvNWQvRGpEYXd1S2RPZGFpbTc1anpweldXQlAzanVtTkFDSkc0?=
 =?utf-8?Q?quGN3F9l5WxV8qvAojIV8j3tn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49f2a97-6f20-4f38-4052-08da9baca2ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 08:38:19.6235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z2jivVtET2pFBfzoeylKb8mpFjmv/PW2RpyonIPhjciWhTvnK3Bw51PEw5hAJC4w/8SZBTz/Im7IFFvZbpJ25g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7355
X-OriginatorOrg: intel.com

PiBXaGVuIGtlcm5lbCBlbmFibGUgQ09ORklHX0hBUkRFTkVEX1VTRVJDT1BZIG9wdGlvbiwgc2lu
Y2Ugbm90IG1hcmtpbmcNCj4gcnRza2Jfc2xhYl9wb29sIGNhY2hlIGlzIHVzZXJjb3B5IHR5cGUs
IHdpbGwgdHJpZ2dlciB0aGUgZm9sbG93aW5nDQo+IGNhbGx0cmFjZS4NCj4gDQo+IFsgIDU5NC40
MTM2MDJdIGludmFsaWQgb3Bjb2RlOiAwMDAwIDEgUFJFRU1QVCBTTVAgUFRJIElSUV9QSVBFTElO
RQ0KPiBbICA1OTQuNDEzNjAzXSBDUFU6IDIgUElEOiA0OTIgQ29tbTogcnRjZmcgVGFpbnRlZDoN
Cj4gWyAgNTk0LjQxMzYwM10gSVJRIHN0YWdlOiBMaW51eA0KPiBbICA1OTQuNDEzNjA0XSBSSVA6
IDAwMTA6dXNlcmNvcHlfYWJvcnQrMHg3Ny8weDc5DQo+IFsgIDU5NC40MTM2MTBdIENhbGwgVHJh
Y2U6DQo+IFsgIDU5NC40MTM2MTBdICBfX2NoZWNrX2hlYXBfb2JqZWN0KzB4YTYvMHhjMA0KPiBb
ICA1OTQuNDEzNjExXSAgX19jaGVja19vYmplY3Rfc2l6ZSsweDEzNi8weDE1MA0KPiBbICA1OTQu
NDEzNjExXSAgY29weV9zdGFnZV8xX2RhdGErMHg0OC8weDcwIFtydGNmZ10NCj4gWyAgNTk0LjQx
MzYxMl0gIHJ0bmV0X3J0cGNfZGlzcGF0Y2hfY2FsbCsweDE1MS8weDMyMCBbcnRuZXRdDQo+IFsg
IDU5NC40MTM2MTJdICA/IGNsZWFudXBfY21kX2RlbCsweDcwLzB4NzAgW3J0Y2ZnXQ0KPiBbICA1
OTQuNDEzNjEyXSAgPyB3YWl0X3dva2VuKzB4NzAvMHg3MA0KPiBbICA1OTQuNDEzNjEzXSAgcnRj
ZmdfaW9jdGwrMHhhMC8weDI1MCBbcnRjZmddDQo+IFsgIDU5NC40MTM2MTNdICBydG5ldF9pb2N0
bCsweGRmLzB4MTcwIFtydG5ldF0NCj4gWyAgNTk0LjQxMzYxM10gIF9feDY0X3N5c19pb2N0bCsw
eDgzLzB4YjANCj4gWyAgNTk0LjQxMzYxM10gIGRvX3N5c2NhbGxfNjQrMHgzOS8weDUwDQo+IFsg
IDU5NC40MTM2MTRdICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0NC8weGE5DQo+
IA0KPiBUaGlzIGNvbW1pdCBtYWtlIHJ0c2tiX3NsYWJfcG9vbCBjYWNoZSBiZWluZyBhbiB1c2Vy
Y29weSBzb3VyY2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBacWlhbmcgPHFpYW5nMS56aGFuZ0Bp
bnRlbC5jb20+DQo+IC0tLQ0KPiAga2VybmVsL2RyaXZlcnMvbmV0L3N0YWNrL3J0c2tiLmMgfCA1
ICsrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9kcml2ZXJzL25ldC9zdGFjay9ydHNrYi5jIGIv
a2VybmVsL2RyaXZlcnMvbmV0L3N0YWNrL3J0c2tiLmMNCj4gaW5kZXggYzkwNDJkYjkzLi5mYTc1
Y2E2ZWMgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9kcml2ZXJzL25ldC9zdGFjay9ydHNrYi5jDQo+
ICsrKyBiL2tlcm5lbC9kcml2ZXJzL25ldC9zdGFjay9ydHNrYi5jDQo+IEBAIC00OTcsMTAgKzQ5
NywxMSBAQCBFWFBPUlRfU1lNQk9MX0dQTChydHNrYl9jbG9uZSk7DQo+ICANCj4gIGludCBydHNr
Yl9wb29sc19pbml0KHZvaWQpDQo+ICB7DQo+IC0JcnRza2Jfc2xhYl9wb29sID0ga21lbV9jYWNo
ZV9jcmVhdGUoInJ0c2tiX3NsYWJfcG9vbCIsDQo+ICsJcnRza2Jfc2xhYl9wb29sID0ga21lbV9j
YWNoZV9jcmVhdGVfdXNlcmNvcHkoInJ0c2tiX3NsYWJfcG9vbCIsDQo+DQo+U2luY2Ugd2hlbiAo
a2VybmVsIHZlcnNpb24pIGlzIHRoaXMgZnVuY3Rpb24gYXZhaWxhYmxlPyBDYW4gYWxzbyBiZQ0K
PmltcG9ydGFudCB3aGVuIHdlIGRlY2lkZSB0byBwaWNrIHRoaXMgcGF0Y2ggaW50byBzdGFibGUg
dmVyc2lvbnMgd2hpY2gNCj5zdGlsbCBzdXBwb3J0IG9sZGVyIGtlcm5lbHMgdGhhbiA1LjEwLg0K
DQpUaGlzIGZ1bmN0aW9uIGhhcyBiZWVuIGF2YWlsYWJsZSBzaW5jZSB2My4wLg0KDQo+DQo+ICAJ
CQkJCSAgICBBTElHTl9SVFNLQl9TVFJVQ1RfTEVOICsNCj4gIAkJCQkJCSAgICBTS0JfREFUQV9B
TElHTihSVFNLQl9TSVpFKSwNCj4gLQkJCQkJICAgIDAsIFNMQUJfSFdDQUNIRV9BTElHTiwgTlVM
TCk7DQo+ICsJCQkJCSAgICAwLCBTTEFCX0hXQ0FDSEVfQUxJR04sDQo+ICsJCQkJCQkwLCBTS0Jf
REFUQV9BTElHTihSVFNLQl9TSVpFKSwgTlVMTCk7DQo+DQo+SSBzdXBwb3NlIHRoZSBpbmRlbnRp
b24gc2hvdWxkIGJlIGRvbmUgYSBiaXQgbmljZXIsIHBvc3NpYmx5IGJ5DQo+aW5kZW50aW5nIG11
Y2ggbGVzcyAodHdvIG9yIHRocmVlIHRhYnM/KSBidXQgY29uc2lzdGVudGx5Lg0KIA0KVGhhbmtz
LCBJIHdpbGwgcmVzZW5kLg0KDQo+DQo+VGhhbmtzLA0KPkphbg0KPg0KPiAgCWlmIChydHNrYl9z
bGFiX3Bvb2wgPT0gTlVMTCkNCj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ICANCj4NCj4tLSANCj5T
aWVtZW5zIEFHLCBUZWNobm9sb2d5DQo+Q29tcGV0ZW5jZSBDZW50ZXIgRW1iZWRkZWQgTGludXgN
Cg0KDQo=
