Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F9B1FCC
	for <xenomai@lists.linux.dev>; Mon, 18 Sep 2023 04:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695011064; x=1726547064;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0tNUTH+8TgbKHdlNvAszdE+aqcOcJ55tKo4bTo/e3SY=;
  b=B0Zx++xFgLDbjZqFXCHhl1Rg4Edj3bP9yOwbdRoan+p1sf46/VmC2/XZ
   15f+0pz+Xya3pV6v9i34s3RE4eP7eI3iXzfGaFVrgW1RRCLupev4+/CaK
   Rb279um+ng0YLehF6+4Byqvwcrn4RBMyfJUBdQwMIvZNyzqfi6iWoyX9O
   lF1gT4H1DtAwZk8uPe87za13dH+J2UoCJSgLx6gkrqRPNGZTAE76j9t+s
   LCGEUE/2hbbK1CTZ7fSxv+Wfe1Mgc4oR//5HXo0on1YxH/iijnPBAeWSH
   M/orZIq8X/amcOZ+d1esIsknj/nBHZb4txjJbuSIvlpELse66kGJqi13W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="382304440"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="382304440"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 21:24:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="780754643"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="780754643"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Sep 2023 21:24:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 17 Sep 2023 21:24:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 17 Sep 2023 21:24:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 17 Sep 2023 21:24:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLT1IDyuGM4THlcfBRPiVtLgl9sAKXAbr2GoQwuS0GmPk3KQQvaF/OGD6+S5ZRWV8dAZMlmW0r2H4LI7ZODRswiv1Z7Bewr7ophN75bjZYZR8mYwHA9FtVNSKI5Q4q14Hrk/hLxkGgVWsvyUrbEhAXX8ufiV5NlTkHStdLfpnmsKTmluskoqiJRouMlCg8MaMYTTiOpuWMs/wcV/CNGYmiEoxMa+Cc+HaNJ8SAoGOfJAKVAHjcoAATMqaALwzi1CyJ/1z1J/hx9ls2ZvbBGxnBxUc6M+88yM8/yAC7BgiVbAcjIpCMDxYOx0DXVO60IFDIyNm9jKqrJzPagzH2eysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tNUTH+8TgbKHdlNvAszdE+aqcOcJ55tKo4bTo/e3SY=;
 b=ZAeD6L+yXkaZNPGKflkm+RttYxMRfemOwav8unZtputrNAlYnXMQ88DrA5Bw+RNXTF4Hh6Ri8Mze7asFOJTS6cgc0j6jld65RVIvr37kNrmqOI6THUepat1yYh1SAF58Psik4krpxWplL7nEoJAkTjkQ20r5KcLxWs8B1Z3ClDA6rlPMxju9TFXAPpc1EZYxcyFmowh0SgciKL+fi/YkcTsJmdV45II28huK/NCMj2iu6l7DKN9oNvAkTwlS9FcJuFY8bppG+Jawd6Ycq8UroBTTdzZYheVwxrq5k9INlYZq71iZ/uUfzSQS2Q5iVqxrON9K+A+oe4pml4VFzMpVEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by DM4PR11MB7301.namprd11.prod.outlook.com (2603:10b6:8:10a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 18 Sep
 2023 04:24:14 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::39e:eb8d:6d9d:78fe]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::39e:eb8d:6d9d:78fe%3]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 04:24:14 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, Philippe Gerum
	<rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: [PATCH] genirq: irq_pipeline: fix irq flow handling with stacked
 irqchips
Thread-Topic: [PATCH] genirq: irq_pipeline: fix irq flow handling with stacked
 irqchips
Thread-Index: AQHZ595rgwDLOaKO8U2U8baARsLYXLAelhwwgAAQoQCAABJygIAAT1CwgADxiyA=
Date: Mon, 18 Sep 2023 04:24:14 +0000
Message-ID: <MN2PR11MB4285C7F8B3C27EBA9ECEC339F2FBA@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <87o7i3o7cd.fsf@xenomai.org>
 <MN2PR11MB4285939337A3D811141514B7F2F4A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <MN2PR11MB4285BACD1E28C473D9D681A8F2F4A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <878r95rw2f.fsf@xenomai.org>
 <MN2PR11MB428550B2680336839C7A64EDF2F4A@MN2PR11MB4285.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB428550B2680336839C7A64EDF2F4A@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|DM4PR11MB7301:EE_
x-ms-office365-filtering-correlation-id: f7693982-45cb-48a9-81df-08dbb7ff1d76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JzoN8bxPF8HqK83/MvAdNEPaPiPPj8SgAReJir3+xyuMBde/NSUkzDqhNsfVh/qr9ZkwndsSzDksDA2p7I7Kyop4tWJGtz4b9Ztp+gb41p8T0oGkKOG414dfKR0ZjfZ/xtnkKzu9LQ0+wInos36AlQno3ZTiPNteT8Oz4dwupMwEbK2c0Yh5O+DlnPmdS8SgDEcXSbOjPnEJgXD22IkTOI+qxuT+/oP8Capu8d4lN+sqrcdHUxRzx2+vkDRPetZokjQqSi6VBpgSaf16AyyIDNZZvaITGV1PRTgeb2HIonNCNYNBmLsNFegMzP5QUT9RQ/mqwNalkIgv4hX2hOpqDcf6UN0ll2EvmP0nGIV3Q8AwmogP2OEUGH5GvEvwFvLxrb8u6YtcoqaTKmEgxKLxCVErV90Gbol83oQZRSohSdQ3QiweSy6QJGEH5F4QTTlpcqx0y5z0paZ895v2cHS00z+lPBYCrmfDMPUTukzOAhhehTZLmXvEM+F+dfVFAtCe3eHDaMfGSNU+13AW/atGjkssuBKIKVEzKGE7DzYNy2KIlV1FcYyvCoSPbaIP0ndvAXxBWVvvhTiW8JO2mMLnOndQGa37ZqQvWv7Nk6/H2687gTN0j3GIoOAShforxBwm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(186009)(1800799009)(451199024)(26005)(83380400001)(52536014)(5660300002)(8936002)(4326008)(8676002)(7696005)(6506007)(9686003)(478600001)(122000001)(71200400001)(41300700001)(66946007)(110136005)(64756008)(66446008)(316002)(55016003)(66476007)(76116006)(66556008)(86362001)(2906002)(33656002)(82960400001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVVJQjNYTTJ6Q1JzVTVkSTRrdGUxMnZlNE01enRSRUExOVpBMkdTSkZ6bEs2?=
 =?utf-8?B?ZDZJRHdFYnBXMG1sS2tVb3dCZXY2ZitBQmZ1bG9Zc0JxQ2llQnpLWUozK09m?=
 =?utf-8?B?aE1QUFpaZmU3VFlqcmp2REczNHl0NGVhRkRjY0kra0NDc1lVMXo0NVlROG14?=
 =?utf-8?B?UmxlTGU5a2FNQXFjWk9tdnNjTTFOc1EySDFUWlFYb0Q1cUdXNGoyQWphT2pQ?=
 =?utf-8?B?dm5kcXZvejcyeGxHUVFNNm9ObkVGaG9XbHQyeXFhRGN4a2VBbTAvUTRKKzlQ?=
 =?utf-8?B?b25wWHhqRm1tenQ4cFVPNkJCYisrR2R6SGxDWlNIWjhRTDEvNzNuV1cvdXJK?=
 =?utf-8?B?cXNEdGJuTFFVeGlWWmpmVWEwZTBpTUVTaCt4cTJoZDh6eWxEc3N2WXQvYnVI?=
 =?utf-8?B?UlBOcmYwVkxrcGZpOWhTTDdLazJRK2RCTkF5aGNOdDU0Qm1FSjlva2N4QnZZ?=
 =?utf-8?B?ZGYxcWxyeWIvRitJRUhRbFVrd0hGQkQyNnZHdUtYRzl0bEVGYWVMSkNPMWxa?=
 =?utf-8?B?SFQwSDlmYjN1WmJUaXZXQXFEeVpUMytmQ2ZnaVBZNWtnZmcwSHJtV3JRdDBV?=
 =?utf-8?B?NmY3UlZVQlM1QkkzbHNxTEM1UkVmSEZrSStmT1VSTkFKbldZZFEwUjhDV0FF?=
 =?utf-8?B?OFpvK1VNWURyWlR6QmwvVUY2SWRpdmdxVGZ3M1RKZHV4LytNMitCMHQ3L2dP?=
 =?utf-8?B?L1NRMkFlK3BEUVpRK3NjVmx6aWFuVzRRaEdOcGRJQnNRakNnTWNZTnBQMmxV?=
 =?utf-8?B?RmUxeDNRZ1BVcTZCVWozSmNMV05TZVdmMWhrMmlCUnhjaDNlZFVndzB0azha?=
 =?utf-8?B?dTBWdEg2UHhYczRLSG1sTUs1Z28zNHU4ekR2OHlJRGNGZ0d1dDRWUC9BQUJ2?=
 =?utf-8?B?bHlnM1ZTR0hEbUx4YnRDV0JYY3lqUGZxRlpvZDRrcFdiWDFUSGpBQlV3VlRn?=
 =?utf-8?B?Zktsa1VkT1dOMTFvOXhkNnhFZTZPQ0FqTlo3Q2NtWkprRmhDS1F6aTlDd1Vw?=
 =?utf-8?B?RWtLZGM0eGhPQ2JzY21KRmRWY0FPZ1RGQW5HZWVkVjFnTnJpclhvRGxiQjZk?=
 =?utf-8?B?SWhOekU3OUU2eGFBMXVZTlJzbTl1ZUlvaW1vei8rSWFIZjg1VDRMbWpPS2pt?=
 =?utf-8?B?SVdwR3dRajV0bG5KSDJIL2JxTFF6T1pEUkJmUC8xeGpGOEh6emg3NnM3bENO?=
 =?utf-8?B?bTBmUS8yallxeTRZbDlBWWhYWllzMFBFWVVuMDFPa2Z0Zk5zTkJkRkxheUZQ?=
 =?utf-8?B?T0tETTR1TzljbEk0bkQ1RkhtdlRzaDZxK1ROcU1iU1NlamtZRG1OMFpSNytO?=
 =?utf-8?B?UE4wS3I4eHI1QlhabFJGWW5aMjNHcmhwbHVqQVdnK2lnZEl3bDZXZkV5dlp1?=
 =?utf-8?B?ZjR3SE9kOFZ6QzJoZ3JIaWVLSzVUMlJKOWtmMjVIMnhXVnlZV1RHNkNaNnZw?=
 =?utf-8?B?MlhwN2pPT1Ezc3dCZHJVL0dManA3U2NSMmRKVWlybXFvTXNzM3BJbGpzNWVp?=
 =?utf-8?B?RlJicGZ6Q0tQODNiSTRWT2RMS3RHNnJUbHcxQWhwYzEvVlN1RlZNUjdQWWNm?=
 =?utf-8?B?bHZHUEtabjdEU0JRckRaSm1nQXR6MlNTQ2NxWUhIcm1MYlU3Uk4zT3o5MXQr?=
 =?utf-8?B?Vi81SUc4Sy9Cakh0UFAySXc1QW5sOTRCNUNnUWxjQUNyQXFoNlYweDRHc3VH?=
 =?utf-8?B?Y1M4NUswWXJNOVA0ejgxSW92dkQydFFKRk9UbG16TkhpVnlxWEVVK3RhQzBX?=
 =?utf-8?B?OHRGTkdQbGtwTXc5cHQvY0IrRncrU3o4L1UyWG9KUEZGWmZtdlpUMHhESHEy?=
 =?utf-8?B?aFNJSUxSV2drTi91OEFna3lIcTd1ZjB6eGFibXIrNWRqSEdvSEI2clJYU2ZH?=
 =?utf-8?B?QkkvY3k0YzZsYWJya29nUUF6bVNlWGdXcE1QdUN6WHM1OHY4ZUZ6MTBncVhN?=
 =?utf-8?B?Z1E2MzY3d29wQnVJTFVZdXlEOGR3TUhuTHVNZVRVQnZqcW96VlRuOC8reFFL?=
 =?utf-8?B?S3lSUy9SQ1hhZGJzSElOditHTHg2ait5NEFlZjVsOUtBbm9SQkIxQVExK1Qw?=
 =?utf-8?B?NWN2RTRxZWU5VjhmT1RtZ20wN0N1Vis5MEkxOGdmOVNjb2lTUFAxK2hCcGlB?=
 =?utf-8?Q?2SkKZRqF8Fcoba/UbfiSk2DOD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f7693982-45cb-48a9-81df-08dbb7ff1d76
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 04:24:14.1752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kUkzHi+N5Z0fADjqXDb0T60WpvcPSS8q4Czd8w6FE1Co9ttYHUN+yVbE/ysXB8rSn+hfhQwbiH+64SQUh7RRbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7301
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENoZW4sIEhvbmd6aGFuIDxo
b25nemhhbi5jaGVuQGludGVsLmNvbT4NCj5TZW50OiBTdW5kYXksIFNlcHRlbWJlciAxNywgMjAy
MyA5OjQzIFBNDQo+VG86IFBoaWxpcHBlIEdlcnVtIDxycG1AeGVub21haS5vcmc+DQo+Q2M6IHhl
bm9tYWlAbGlzdHMubGludXguZGV2DQo+U3ViamVjdDogUkU6IFtQQVRDSF0gZ2VuaXJxOiBpcnFf
cGlwZWxpbmU6IGZpeCBpcnEgZmxvdyBoYW5kbGluZyB3aXRoIHN0YWNrZWQNCj5pcnFjaGlwcw0K
Pg0KPg0KPg0KPj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj5Gcm9tOiBQaGlsaXBwZSBH
ZXJ1bSA8cnBtQHhlbm9tYWkub3JnPg0KPj5TZW50OiBTdW5kYXksIFNlcHRlbWJlciAxNywgMjAy
MyA0OjU0IFBNDQo+PlRvOiBDaGVuLCBIb25nemhhbiA8aG9uZ3poYW4uY2hlbkBpbnRlbC5jb20+
DQo+PkNjOiB4ZW5vbWFpQGxpc3RzLmxpbnV4LmRldg0KPj5TdWJqZWN0OiBSZTogW1BBVENIXSBn
ZW5pcnE6IGlycV9waXBlbGluZTogZml4IGlycSBmbG93IGhhbmRsaW5nIHdpdGggc3RhY2tlZA0K
Pj5pcnFjaGlwcw0KPj4NCj4+DQo+PiJDaGVuLCBIb25nemhhbiIgPGhvbmd6aGFuLmNoZW5AaW50
ZWwuY29tPiB3cml0ZXM6DQo+Pg0KPj5bc25pcF0NCj4+DQo+Pj4+PkBAIC04NTgsMTAgKzk0Niwx
MiBAQCBFWFBPUlRfU1lNQk9MX0dQTChoYW5kbGVfZmFzdGVvaV9ubWkpOw0KPj4+Pj4gdm9pZCBo
YW5kbGVfZWRnZV9pcnEoc3RydWN0IGlycV9kZXNjICpkZXNjKQ0KPj4+Pj4gew0KPj4+Pj4gCXN0
cnVjdCBpcnFfY2hpcCAqY2hpcCA9IGlycV9kZXNjX2dldF9jaGlwKGRlc2MpOw0KPj4+Pj4rCWlu
dCBmbG93Ow0KPj4+Pj4NCj4+Pj4+IAlyYXdfc3Bpbl9sb2NrKCZkZXNjLT5sb2NrKTsNCj4+Pj4+
DQo+Pj4+Pi0JaWYgKHN0YXJ0X2lycV9mbG93KCkpIHsNCj4+Pj4+KwlmbG93ID0gaXJxX3N0YXJ0
aW5nX2Zsb3coZGVzYyk7DQo+Pj4+PisJaWYgKGZsb3cgIT0gSVJRX0ZMT1dfUkVQTEFZKSB7DQo+
Pj4+PiAJCWRlc2MtPmlzdGF0ZSAmPSB+KElSUVNfUkVQTEFZIHwgSVJRU19XQUlUSU5HKTsNCj4+
Pj4+DQo+Pj4+PiAJCWlmICghaXJxX21heV9ydW4oZGVzYykpIHsNCj4+Pj4+QEAgLTg4MSw3ICs5
NzEsNyBAQCB2b2lkIGhhbmRsZV9lZGdlX2lycShzdHJ1Y3QgaXJxX2Rlc2MgKmRlc2MpDQo+Pj4+
PiAJCX0NCj4+Pj4+IAl9DQo+Pj4+Pg0KPj4+Pj4tCWlmIChvbl9waXBlbGluZV9lbnRyeSgpKSB7
DQo+Pj4+PisJaWYgKGlycV9mZWVkaW5nX3BpcGVsaW5lKGRlc2MsIGZsb3cpKSB7DQo+Pj4+PiAJ
CWNoaXAtPmlycV9hY2soJmRlc2MtPmlycV9kYXRhKTsNCj4+Pj4+IAkJZGVzYy0+aXN0YXRlIHw9
IElSUVNfRURHRTsNCj4+Pj4+IAkJaGFuZGxlX29vYl9pcnEoZGVzYyk7DQo+Pj4+DQo+Pj4+DQo+
Pj4+V2hlbiB0aGUgaXJxIGlzIFBJTEVVUCwgYWN0dWFsbHkgdGhlIHByZXZpb3VzIElSUVNfREVG
RVJSRUQgYml0IGhhcyBub3QNCj4+YmVlbg0KPj4+PmNsZWFyZWQgYW5kIHRoZSBsb2dnZWQgaW4t
YmFuZCBpcnEgaGFzIG5vdCBiZWVuIHNlcnZpY2VkIHlldC4gRG8gd2UgbmVlZA0KPj50bw0KPj4+
PmNhbGwgaGFuZGxlX29vYl9pcnEgdG8gc2V0IElSUVNfREVGRVJSRUQgYW5kIGxvZyB0aGUgaW5i
YW5kIGlycSBhZ2Fpbg0KPj53aGVuDQo+Pj4NCj4+PiBJdCBpcyBtZWFuaW5nZnVsIHRvIGxvZyB0
aGUgaW5iYW5kIGlycSB2aWEgY2FsbGluZyBpcnFfcG9zdF9zdGFnZSBmcm9tDQo+PmhhbmRsZV9v
b2JfaXJxDQo+Pj4gaW4gY2FzZSBjdXJyZW50IGlycSBhY3R1YWxseSBwcmVlbXB0ZWQgaW4gZG9f
aW5iYW5kX2lycSB3aGVyZSB0cmllZCB0bw0KPj5zZXJ2aWNlIHByZXZpb3VzIHNhbWUgaXJxIG51
bWJlciBhbmQgYWxyZWFkeSBjbGVhcmVkIHRoZSBsb2cgYmVmb3JlIGNhbGxpbmcNCj4+ZG9faW5i
YW5kX2lycS4NCj4+Pg0KPj4NCj4+VGhhdCdzIGNvcnJlY3QsIHByZWVtcHRpb24gbWlnaHQgb25s
eSBoYXBwZW4gYWZ0ZXIgdGhlIGluaXRpYWwgaXJxIGV2ZW50DQo+PndhcyBjbGVhcmVkIGluIHRo
ZSBsb2csIGJ1dCBhbHNvIGFmdGVyIElSUVNfREVGRVJSRUQgd2FzIGNsZWFyZWQgaW4gdGhlDQo+
PmZsb3cgaGFuZGxlciB3aGlsZSByZXBsYXlpbmcgdGhpcyBldmVudCwgc28gd2UgbmVlZCB0byBz
ZXQgdGhlIGRlZmVycmFsDQo+PmZsYWcgYWdhaW4gZm9yIHRoZSBzdWJzZXF1ZW50IGV2ZW50LiBJ
T1csIHRoZSBjb2RlIHBhdGggZnJvbSB0aGUgY2FsbCB0bw0KPj5pcnFfZmVlZGluZ19waXBlbGlu
ZSgpIGJhY2sgdG8gZGlzYWJsaW5nIGhhcmQgaXJxcyBvbiByZXR1cm4gdG8NCj4+ZG9faW5iYW5k
X2lycSgpIGlzIG5vdCBhdG9taWMuIEZvcnR1bmF0ZWx5LCBzeW5jX2N1cnJlbnRfaXJxX3N0YWdl
KCkNCj4+bG9vcHMgYXMgbG9uZyBhcyBldmVudHMgYXJlIHBlbmRpbmcgaW4gdGhlIGxvZywgc28g
d2Ugd29uJ3QgbWlzcyB0aGUNCj4+cGlsaW5nIG9uZXMuDQo+Pg0KPj5JcyB0aGlzIHBhdGNoIGZp
eGluZyB0aGUgb3JpZ2luYWwgaXNzdWUgeW91IGRldGVjdGVkIG9uIHlvdXIgZml4dHVyZT8NCj4N
Cj5Mb2dpY2FsbHksIGl0IGZpeCB0aGUgdGhlIGlzc3VlIGJ1dCBJIGhhdmUgbm90IHRlc3RlZCBp
dCB5ZXQuIEkgd2lsbCB2YWxpZGF0ZSBpdA0KPnRvbW9ycm93DQo+d2hlbiBJIGFtIG9uIGR1dHkg
YW5kIHRoZW4gZ2l2ZSB5b3UgZmVlZGJhY2suDQoNClRoZSBpc3N1ZSBzdGlsbCBleGlzdHMgYWZ0
ZXIgYXBwbHkgdGhlIHBhdGNoIGJlY2F1c2UgaXJxX2ZlZWRpbmdfcGlwZWxpbmUgbmV2ZXIgcmV0
dXJuIHRydWUgZm9yIHRoZSBjYXNjYWRlZA0KZWRnZV9pcnEgc28gdGhhdCBpdCB3b3VsZCBuZXZl
ciBjYWxsIGNoaXAtPmlycV9hY2soJmRlc2MtPmlycV9kYXRhKSBhbmQgaGFuZGxlX29vYl9pcnEo
ZGVzYykgaW4gaGFuZGxlX2VkZ2VfaXJxDQoNCiAgIGhhbmRsZV9pcnFfcGlwZWxpbmVkX3ByZXBh
cmUoKQ0KICAgIFtvbl9waXBlbGluZV9lbnRyeTogdHJ1ZV0NCiAgICBhcmNoX2hhbmRsZV9pcnEo
KQ0KICAgICAgICAgICAgaGFuZGxlX2Zhc3Rlb2lfaXJxKCkNCiAgICAgICAgICAgICAgICAgICAg
aGFuZGxlX29vYl9pcnEoKQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hc2tfY29uZF9l
b2lfaXJxKCkNCiAgICBoYW5kbGVfaXJxX3BpcGVsaW5lZF9maW5pc2goKQ0KICAgIFtvbl9waXBl
bGluZV9lbnRyeTogZmFsc2VdDQogICAgICAgICAgICBzeW5jaHJvbml6ZV9waXBlbGluZV9vbl9p
cnEoKQ0KICAgICAgICAgICAgICAgICAgICBoYW5kbGVfZmFzdGVvaV9pcnEoKSBbIW9uX3BpcGVs
aW5lX2VudHJ5XQ0KICAgICAgICAgICAgICAgICAgICAgICAgICBpbnRlbF9ncGlvX2lycSgpDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaGFuZGxlX2VkZ2VfaXJxKCkgDQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaXJxX3N0YXJ0aW5nX2Zsb3cgIDw8PCBy
ZXR1cm4gSVJRX0ZMT1dfUkVQTEFZDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaXJxX2ZlZWRpbmdfcGlwZWxpbmUgIDw8PCAgcmV0dXJuIGZhbHNlICANCg0KUmVnYXJk
cw0KDQpIb25nemhhbiBDaGVuDQoNCj4NCj5SZWdhcmRzDQo+DQo+SG9uZ3poYW4gQ2hlbg0KPj4N
Cj4+LS0NCj4+UGhpbGlwcGUuDQo=
