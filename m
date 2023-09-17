Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3933D8F
	for <xenomai@lists.linux.dev>; Sun, 17 Sep 2023 13:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694958189; x=1726494189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v9NvyoNy9MPEpePbsotSEF/1eb+9qB4Gy3zZKAnePkU=;
  b=i8eLUC0mxJQz8CmqJVXdFVkxwlVvk1zWWUP7V/WCKv7dFhVBXu1W6l0P
   2/rkXHYmANb+gzF9xfJ86g/LlrXTXpkhnVey+e2zjUkcT9YvmBxHbyc6Y
   jrZTLTIaWAsYGwXcxnPnl6G3WxKs4C36xnB2OUqyrkFu/zoi9Q69gxBCI
   XmYjFMlJoZI/qzJSbUMmvdnvRrXyZWT1uXThG6ltYO3hqpgudtgI/KN39
   9CyKZGFJBKF1U/y61jF0iRbronBBqG6LuZR/QtRQ/6j/HZX/CfrCV/BBP
   v7YNREaLR78Pfu5kEAxiA8ERcAXtZQsWUGm6DDFJbbp+9yRsYt4+9evor
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="359745769"
X-IronPort-AV: E=Sophos;i="6.02,154,1688454000"; 
   d="scan'208";a="359745769"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 06:43:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="860758468"
X-IronPort-AV: E=Sophos;i="6.02,154,1688454000"; 
   d="scan'208";a="860758468"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Sep 2023 06:43:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 17 Sep 2023 06:43:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 17 Sep 2023 06:43:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 17 Sep 2023 06:43:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BU684GB09wna/zZs8mjGNtai6kXfBs7hV9PQsk6KANMPW0sefF0Tax+JX2C80G/UGc0kgLMXNNnpyQ6x/YD0KwQhXTYn+v1uYbqMqKw3BZijteELgQAcd41i+e5WVSugNbZlJg7HpuuFj5qa4Zoxn+CTo/BfqI6+wKu2U4irHRQ8yHIpgkQhWv5y/m4UbdceJbBPQ3qzD4YIXYbPjuZA6cPOTDpvT5jqQJZMMa1/lQ6x5zMdgwP3wTyaaWNt8CcrrwBtbb5Ua/0qedYJREZ9zI0gWSdKvdOrEvTkeWFTLSL9EDqxzlw+cVr/IkDeuIe4eG95f2czE0nSGxZjenjQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9NvyoNy9MPEpePbsotSEF/1eb+9qB4Gy3zZKAnePkU=;
 b=j8G+d67HuEpat/zWihTybexNVUT0NmBJsei0pBe4jbrAE4j50IMt305M238tOlLkijSviw6QbCunpQUSu23xtkwrNnJyY96icx6Y3ccSQk1zmSjmSqHCGbN0/024VbyaBOfiJrZBGgukwP9E0Le6ydJ+FHPSpzx65QNFojtcrF1fyc8oB3yFXfPiFGBqqixkytEodtYpeGr2s+JO9XsQ9M1fPwKmYX4yYld4YbdP9QYP1lqv8D80QBDpvnQySrtJk3bIO1P3tGy0zbuXdLOhAtCsNHxGqpk6d5cD7i/Go+lRYlATZhDnArk6IINGnjMtI40aMSURzZ+MNhuVoMtpFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by PH8PR11MB8039.namprd11.prod.outlook.com (2603:10b6:510:25f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Sun, 17 Sep
 2023 13:43:06 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::39e:eb8d:6d9d:78fe]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::39e:eb8d:6d9d:78fe%3]) with mapi id 15.20.6792.024; Sun, 17 Sep 2023
 13:43:05 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: [PATCH] genirq: irq_pipeline: fix irq flow handling with stacked
 irqchips
Thread-Topic: [PATCH] genirq: irq_pipeline: fix irq flow handling with stacked
 irqchips
Thread-Index: AQHZ595rgwDLOaKO8U2U8baARsLYXLAelhwwgAAQoQCAABJygIAAT1Cw
Date: Sun, 17 Sep 2023 13:43:05 +0000
Message-ID: <MN2PR11MB428550B2680336839C7A64EDF2F4A@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <87o7i3o7cd.fsf@xenomai.org>
 <MN2PR11MB4285939337A3D811141514B7F2F4A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <MN2PR11MB4285BACD1E28C473D9D681A8F2F4A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <878r95rw2f.fsf@xenomai.org>
In-Reply-To: <878r95rw2f.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|PH8PR11MB8039:EE_
x-ms-office365-filtering-correlation-id: 5fecb6f9-c16d-408e-9bda-08dbb7840506
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eQWU7qtPKPlAG+aPcr0aO4sOmkoXFMHvIQZylrosQgE+b1UUcGhuJmyUMV4QZj22tch1/qH/W6AzlTUrL6U8w9a4yXGUame0Wp0jRdAZ9Ap6APZz97jsRTKzW0N3KVaHq67r1A4tct5pZxfqk8bR3dSPbAcbv7eaWfunZxZ7MXtp0bi9GYMX64KFbtHn1QkmRCSFzwvuteTlmzJxQFBuhLtCC56uC7zeSUicop7hxnZZieRyHHZHwvDMTDdjaxGBGgULoSpn61rk9mLfzRvCIXScZXA0kTF8Bts0/iUAN/UnvUvr05zOvtmo7DPACAQa1EOhm+ssf59wdrXGR1Hr0Ixq7yur3EcVG4GLhE/WowPBZXRLqtr9wPIi/Q8uLq68gh7KMXzlElV8/+ABl+evK6k3Byw6dKqIhnDPqmgrZlHAUanIM00aFEI1M901ie0dQHupyI610RPW5VJZr9FOgq4mJq6fl7cVs0M+QwMWieF+fb5uGVE05b9Iiyy72EVzXnE5gmIrI1sMQItyKItQMBZMdcdk/o6VhKhpkOTTGSqUvCiWZ4AUe61un01qLk87k4+ce8y0sr9bTDDITecBGTddJIwBEbROPxQUTtdolNseKGI8Qnv7WAJpr8S/OxKm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(1800799009)(186009)(451199024)(52536014)(26005)(5660300002)(8936002)(4326008)(8676002)(2906002)(86362001)(122000001)(82960400001)(38100700002)(38070700005)(33656002)(83380400001)(55016003)(66946007)(6506007)(7696005)(76116006)(66556008)(66476007)(66446008)(64756008)(71200400001)(478600001)(9686003)(41300700001)(316002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVJlK2JqTlFuVmYwbXVXWm9Gbi9MM051bXViSC9nSCtmK3NNY28xVDBjVkQr?=
 =?utf-8?B?WWxKS2gySTVPYVk2cDJEYkhHcE82Um9NTVRxN2tCUGlvWktKRVpXOXgvSkpJ?=
 =?utf-8?B?dCswTG9qSUcyY0FtN0IybG94cEIrTWt6TEZSa1FjZnNiWXl2NHViam4wdWFD?=
 =?utf-8?B?ZWtNb1ZLRnJzd0MrM1hrQ2l0RlVCd3ppajRsdlZmbTBvNnpISW9XZ0pvUjZh?=
 =?utf-8?B?akV0U3ZwV3V6Uk1tUk92S3ZiUWdPcGExOG9Zd3RSdGlMUWl6Z2Uvb2p6Z2R0?=
 =?utf-8?B?MzdzSmcxTXRHcFhqQXZmekYwNkhLZXkycVV1NTVEZUpQNGdhYllDL3E3YmxU?=
 =?utf-8?B?YlNkcmVhdVN4V042YVZzTDVUSGNyd2NJWkRCQnd1ejZlQ3VCb1p0a2JrOTFD?=
 =?utf-8?B?bDZ3UVlaWmVjVXRqaDJwVGpEZGVMM2hsQkd0V0Q1SjljVUpHcWovUTE3bkdP?=
 =?utf-8?B?N3VIRXZEVERVdGhaQnBTdWpYcjRydWZzalYrWlBtNGhWaDFOUy8yWUV6SU54?=
 =?utf-8?B?WDdrVG81eXByZi9yZVJkN3pyaWtCUTZoVkJ4Zjk5NTFoeHNQaUlRQ2FiSWp5?=
 =?utf-8?B?RWNUT2RpZVNWT3BRZFFaQXJVUU9paENEb25KcGpkL2dWSE5JdjhDWWJCSDhY?=
 =?utf-8?B?ZTY3MUs1RHdFMmZWanI3S0VpKytPNndGejZrNXkvNGtGOEUzTnNuOHVGdHBS?=
 =?utf-8?B?QmpjZUJPZHp3aUdpRU9YNnpSdmxFakNHRG80WGRHT1BKTUQrN0pqVXZTejVO?=
 =?utf-8?B?bjF4L3BEU05JVmJvNnUyd3VubEVnYmcydk4remFSYmRXZWlFZHhWMlg5ZDNh?=
 =?utf-8?B?QjU3TE5jbDMycVkrdkdYU3A4TVVaWFlDall1c1JjZ05Fb1U4dVZIMjNvUk9i?=
 =?utf-8?B?UCtZY0VBNmltNHBCb29LWG1uMStkaytHMG9QYXJuZUk2cmp0VlJtV1F6TjdI?=
 =?utf-8?B?RkhJampDVjFqelhvR1dPS2YvNFd5dTZqaC9NRnZGRmJ3SmFwUTVaRnR5VGdL?=
 =?utf-8?B?eWJPSHJza3NNZ0JEVHdVbUx5ditnTXFjOUs1NDRCcU85RmY3ZXRxZnh3dUpN?=
 =?utf-8?B?SU9TNDQ2UjRmZUpHVElmY1EyNkw0OXNTMlcwNXdOWGdxZGtBRmQxTVNZRTF0?=
 =?utf-8?B?cVg3RlRJa2sycVdsOFRPdFNHTDk4cktIYXhuc2ZuK2d0N2VVN1piWGdVbjc2?=
 =?utf-8?B?QVB5aWJXQW9LOFdOTXNhNHFQN0tUL0ZNS2Yyc3NETnRKSDFQcUk5LytqV1NY?=
 =?utf-8?B?U05JbWpaNnp5cVowckNoazRFbmltVVJRTSs2SkhNQTFucktJNnVTbUZ1ejNR?=
 =?utf-8?B?ZFlPRVdnRG5pSTNydEk4ZDNZNHJwMWkwRDRENUF5ZWNZckN1QnkzZnE2UjQ1?=
 =?utf-8?B?OWg2K3ZnYUFvY2FBSGxNUVczR0x4VjU5TkVDb1E5R1ArcUV3N1FHY3VGUjBC?=
 =?utf-8?B?MDlaMFI3MGNvbTVEYTdFbDRIRzNYeStQbkZKYzBYMnFqMjU2NUZ1OTVDUDdR?=
 =?utf-8?B?dzltcHJxd25MSWFPZlMxbmdhRWNMbC9GSmJ2b3JxdHBhZVArMGVtZGl5TFhZ?=
 =?utf-8?B?ZGtkYWhVYVZlclBFZnJhOXdVZWhQR05jUmVWK2NZSWJ5RGtiY2x1YmIzcGE0?=
 =?utf-8?B?ZUtYNmlBRWtXOXpBODE2cWE4SmdBUWt0Lys3TTFzQTc5alFPcE11bm5uaGpZ?=
 =?utf-8?B?UXpkNS8vb1U1TzNBYlUvd0F2MDZjNmNNQjl5WkJZSFkwdHhOaGUyMjF6Tk0v?=
 =?utf-8?B?TnJDTmxST3RiQ0ZBUHJaTDEvNitSelFJMHlXQXVRd1pBTlQ2L1ZXd3cyTmxr?=
 =?utf-8?B?NHNSWVlKNGNyR25LNmNlays4WC9aemhsaXdtaStHazdqNDdLeDJMZ3BWVGRQ?=
 =?utf-8?B?ZjhvM0xqRE53bUJNaEI4S3o2VGgvbWdDTUQvcmlkajZNRVlNZFdESDhHYlMz?=
 =?utf-8?B?Qit2K1o2ZC9hdGttSmZrUk00ZkpjRW1qYmRxdU81TG9NN3ZhYTE0S3ZFSVFH?=
 =?utf-8?B?eDVlUWRuaVZGeWQ2SzVpK2R4MWJZSXNLWTJOK01PczhJUmZPNHY1TlRselly?=
 =?utf-8?B?ZGpsdm4yM3pmNnN3Ty9QTituaDk0c3hUalRpUElFRDR2NDBxbldCSWdXZzk2?=
 =?utf-8?Q?q7s57fQE8KrryHQUjoqC/sr6u?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fecb6f9-c16d-408e-9bda-08dbb7840506
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2023 13:43:05.0651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oaMB/IK1hd0YLAynB1OxqjwvhIH32/2urEsXldyaDCxv7KPpH2R8RiHyCdFFS2n6aXbLCvjNS1TyGxUpLE5BZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8039
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBoaWxpcHBlIEdlcnVtIDxy
cG1AeGVub21haS5vcmc+DQo+U2VudDogU3VuZGF5LCBTZXB0ZW1iZXIgMTcsIDIwMjMgNDo1NCBQ
TQ0KPlRvOiBDaGVuLCBIb25nemhhbiA8aG9uZ3poYW4uY2hlbkBpbnRlbC5jb20+DQo+Q2M6IHhl
bm9tYWlAbGlzdHMubGludXguZGV2DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gZ2VuaXJxOiBpcnFf
cGlwZWxpbmU6IGZpeCBpcnEgZmxvdyBoYW5kbGluZyB3aXRoIHN0YWNrZWQNCj5pcnFjaGlwcw0K
Pg0KPg0KPiJDaGVuLCBIb25nemhhbiIgPGhvbmd6aGFuLmNoZW5AaW50ZWwuY29tPiB3cml0ZXM6
DQo+DQo+W3NuaXBdDQo+DQo+Pj4+QEAgLTg1OCwxMCArOTQ2LDEyIEBAIEVYUE9SVF9TWU1CT0xf
R1BMKGhhbmRsZV9mYXN0ZW9pX25taSk7DQo+Pj4+IHZvaWQgaGFuZGxlX2VkZ2VfaXJxKHN0cnVj
dCBpcnFfZGVzYyAqZGVzYykNCj4+Pj4gew0KPj4+PiAJc3RydWN0IGlycV9jaGlwICpjaGlwID0g
aXJxX2Rlc2NfZ2V0X2NoaXAoZGVzYyk7DQo+Pj4+KwlpbnQgZmxvdzsNCj4+Pj4NCj4+Pj4gCXJh
d19zcGluX2xvY2soJmRlc2MtPmxvY2spOw0KPj4+Pg0KPj4+Pi0JaWYgKHN0YXJ0X2lycV9mbG93
KCkpIHsNCj4+Pj4rCWZsb3cgPSBpcnFfc3RhcnRpbmdfZmxvdyhkZXNjKTsNCj4+Pj4rCWlmIChm
bG93ICE9IElSUV9GTE9XX1JFUExBWSkgew0KPj4+PiAJCWRlc2MtPmlzdGF0ZSAmPSB+KElSUVNf
UkVQTEFZIHwgSVJRU19XQUlUSU5HKTsNCj4+Pj4NCj4+Pj4gCQlpZiAoIWlycV9tYXlfcnVuKGRl
c2MpKSB7DQo+Pj4+QEAgLTg4MSw3ICs5NzEsNyBAQCB2b2lkIGhhbmRsZV9lZGdlX2lycShzdHJ1
Y3QgaXJxX2Rlc2MgKmRlc2MpDQo+Pj4+IAkJfQ0KPj4+PiAJfQ0KPj4+Pg0KPj4+Pi0JaWYgKG9u
X3BpcGVsaW5lX2VudHJ5KCkpIHsNCj4+Pj4rCWlmIChpcnFfZmVlZGluZ19waXBlbGluZShkZXNj
LCBmbG93KSkgew0KPj4+PiAJCWNoaXAtPmlycV9hY2soJmRlc2MtPmlycV9kYXRhKTsNCj4+Pj4g
CQlkZXNjLT5pc3RhdGUgfD0gSVJRU19FREdFOw0KPj4+PiAJCWhhbmRsZV9vb2JfaXJxKGRlc2Mp
Ow0KPj4+DQo+Pj4NCj4+PldoZW4gdGhlIGlycSBpcyBQSUxFVVAsIGFjdHVhbGx5IHRoZSBwcmV2
aW91cyBJUlFTX0RFRkVSUkVEIGJpdCBoYXMgbm90DQo+YmVlbg0KPj4+Y2xlYXJlZCBhbmQgdGhl
IGxvZ2dlZCBpbi1iYW5kIGlycSBoYXMgbm90IGJlZW4gc2VydmljZWQgeWV0LiBEbyB3ZSBuZWVk
DQo+dG8NCj4+PmNhbGwgaGFuZGxlX29vYl9pcnEgdG8gc2V0IElSUVNfREVGRVJSRUQgYW5kIGxv
ZyB0aGUgaW5iYW5kIGlycSBhZ2Fpbg0KPndoZW4NCj4+DQo+PiBJdCBpcyBtZWFuaW5nZnVsIHRv
IGxvZyB0aGUgaW5iYW5kIGlycSB2aWEgY2FsbGluZyBpcnFfcG9zdF9zdGFnZSBmcm9tDQo+aGFu
ZGxlX29vYl9pcnENCj4+IGluIGNhc2UgY3VycmVudCBpcnEgYWN0dWFsbHkgcHJlZW1wdGVkIGlu
IGRvX2luYmFuZF9pcnEgd2hlcmUgdHJpZWQgdG8NCj5zZXJ2aWNlIHByZXZpb3VzIHNhbWUgaXJx
IG51bWJlciBhbmQgYWxyZWFkeSBjbGVhcmVkIHRoZSBsb2cgYmVmb3JlIGNhbGxpbmcNCj5kb19p
bmJhbmRfaXJxLg0KPj4NCj4NCj5UaGF0J3MgY29ycmVjdCwgcHJlZW1wdGlvbiBtaWdodCBvbmx5
IGhhcHBlbiBhZnRlciB0aGUgaW5pdGlhbCBpcnEgZXZlbnQNCj53YXMgY2xlYXJlZCBpbiB0aGUg
bG9nLCBidXQgYWxzbyBhZnRlciBJUlFTX0RFRkVSUkVEIHdhcyBjbGVhcmVkIGluIHRoZQ0KPmZs
b3cgaGFuZGxlciB3aGlsZSByZXBsYXlpbmcgdGhpcyBldmVudCwgc28gd2UgbmVlZCB0byBzZXQg
dGhlIGRlZmVycmFsDQo+ZmxhZyBhZ2FpbiBmb3IgdGhlIHN1YnNlcXVlbnQgZXZlbnQuIElPVywg
dGhlIGNvZGUgcGF0aCBmcm9tIHRoZSBjYWxsIHRvDQo+aXJxX2ZlZWRpbmdfcGlwZWxpbmUoKSBi
YWNrIHRvIGRpc2FibGluZyBoYXJkIGlycXMgb24gcmV0dXJuIHRvDQo+ZG9faW5iYW5kX2lycSgp
IGlzIG5vdCBhdG9taWMuIEZvcnR1bmF0ZWx5LCBzeW5jX2N1cnJlbnRfaXJxX3N0YWdlKCkNCj5s
b29wcyBhcyBsb25nIGFzIGV2ZW50cyBhcmUgcGVuZGluZyBpbiB0aGUgbG9nLCBzbyB3ZSB3b24n
dCBtaXNzIHRoZQ0KPnBpbGluZyBvbmVzLg0KPg0KPklzIHRoaXMgcGF0Y2ggZml4aW5nIHRoZSBv
cmlnaW5hbCBpc3N1ZSB5b3UgZGV0ZWN0ZWQgb24geW91ciBmaXh0dXJlPw0KDQpMb2dpY2FsbHks
IGl0IGZpeCB0aGUgdGhlIGlzc3VlIGJ1dCBJIGhhdmUgbm90IHRlc3RlZCBpdCB5ZXQuIEkgd2ls
bCB2YWxpZGF0ZSBpdCB0b21vcnJvdyANCndoZW4gSSBhbSBvbiBkdXR5IGFuZCB0aGVuIGdpdmUg
eW91IGZlZWRiYWNrLg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCj4NCj4tLQ0KPlBoaWxp
cHBlLg0K
