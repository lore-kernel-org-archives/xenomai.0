Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8861C36C
	for <xenomai@lists.linux.dev>; Thu,  9 Feb 2023 00:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675903290; x=1707439290;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=AFggsCqnP1VVAze0EnctxLvIqJnWId5MMypb0of3FQk=;
  b=bEutelAZ8DR+RVxiuLrcxcaWW4ZNLu79QP+AuOJMPLRphGhlD5dNTl5K
   LkgCg7JZBbBd2Nz62ZIPrTnF6xOFXHgEedljdDfI4ePpT8GAy7ScnFIRX
   YfWtT3jpkiBsoGwsSGyVOFe+X3I5Z8m92I9pITsLIPVg8sH/1Z4kIXBnQ
   U2xEWGdTU1Rh83d0Fb1BixwYnVroKg3pYEGJGQEewJLDlGs95nimrUbjD
   TERGQh+JhKxCnGgaYIKRg7/fW6J0AhkplVrQUwro0YAaZ0pnezoMM2KlR
   AjK74SbKfM3lv9f+cg5UZ9Q+HB6vZyG4N4thnMquNSgpe8I5Cujcv3hkA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="317975918"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="317975918"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 16:41:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="912926833"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="912926833"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2023 16:41:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 16:41:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 16:41:29 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 16:41:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 16:41:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJeP1r+tkX8jvp8IjOtgHpLdJOD84idp8vj57IB2FnrK7CmTnfaE794SChjnjcDiGlec1TpIkNdWGTAsAh7GeDiUHKT4rDj4EHH/QL2ZXP4lg1UwNE1iy0YhUsJUpdq/lWuUGWc8WEZLY5ijdbYjRXL05pcCyan80d/53hFUwZi/myHPmB8oA3ujDMLElYu68YQ3fdeNuzLUmFvC75r+aemQ+D+VOKvruHFaivABrS2KwTBEGrRgpZk1IOll+BVtUwfS2UCWqC5g3f6mBpT4A3qmmIh7IhHp6JvlzaY/QR8HOu19M4qf2ICpkRWkPJoXQLFVhh5NYvt0anVGg8iVlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFggsCqnP1VVAze0EnctxLvIqJnWId5MMypb0of3FQk=;
 b=QHZ7DyadtFc8ZCUxywgpC3v4XDOLz7D1BEMgheFqff+UV5uCL6LP57oJIcQwjGlHcksSFgqsHM443HawzUFyAZaLHK37iRhg/SOrqFyyOB6bJmghM6mEW5ZiADkwW7A/sAHpS/JdhJhRinPby78icSaQ9uGzq6JfxFG0g8y87gqUPISjq7X4vNf0AWEziA61JS4LgB+SIzdqxYVmHQIRDFLeShsuP8rBfau9WUTeUyzVCUZPGe6Gzd0SG/UdmFztnToSGnwiC2DpI7bne0nuJ3RXn8suDYyGxmVdVCXZVZI3BD43G6p75szhTKQBr6z1DuSdrMem0X129fbPyKRZtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Thu, 9 Feb
 2023 00:41:17 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2%7]) with mapi id 15.20.6064.035; Thu, 9 Feb 2023
 00:41:17 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Feb 8, 2023
Thread-Topic: Xenomai Community Call Minutes - Feb 8, 2023
Thread-Index: Adk8HbnhuhwkVP5lRDCBuwGFzJKLxQ==
Date: Thu, 9 Feb 2023 00:41:17 +0000
Message-ID: <MN2PR11MB42859FC2758AAABAA4BEABBAF2D99@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|DS7PR11MB6269:EE_
x-ms-office365-filtering-correlation-id: 6518a941-5352-487e-1e85-08db0a365ad4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aToxKtP60l4BgJ83ghWgg5auhpTKh7ScQ+zconObXt/nmEXJplqlQF3KIaFbulU/OH4xTByp+vko7tV1SUnc5DYM+DJahQ40ascA1sOqv3BbuIWXSCL7Jgtk1rzo/PvwJa6rwxoklrv6ua7m2N2EsUqBvELdt/AKAqhnUZsu0CUMfbpWYCeYHFzAfyWn7eWFLWY2T1BSfxDbxCIsHufUY1XpSBQofqmmRj7B9GtmSOwLYLPImcR2pa0rI4jDd3f24s5SupL0Ql8qkAeN/pEiEtQRdnz4HvMLPndFNliesko1uRsxIuWZcdtVnKPKnLL7q4CecEF54rVGUtYSwlz4AlJHkIwrnT2ZQ+dWRbmtaSNAn/QfbORJgMmldMREHjRyL7vg7mWFFnEZNCtOK/RpU4zX+QLaR/XWPsE+7zoH2OfpkLIo0BSQlKXhjsU1xJYKlVT6vM1HTE+cw3s4n/eqYNHQHmSDLodltOnQz3Etju4ffk2yftbn21RwU1QBpa3pQDOvatbN+J0kB2cjstBDzjNff2DKGOiQOM/7xUXyQ6jmugBjMH+H04AKHYrGXxLCoZhub/D+DPOr3gGk8DFiOqQtVRGY2FnR1lKvI7Id+31cUNjW/8o+wGIJBzmHqUOQRcEW8YhpYjzJIZ1bqcMImnKd+sCAh8HUZAWqs8617QLdjQfnylp7FuyJjucnwYHEjQflV+ftPQms/2zq1XtHYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199018)(86362001)(52536014)(316002)(5660300002)(186003)(9686003)(26005)(71200400001)(7696005)(478600001)(55016003)(6506007)(4744005)(33656002)(2906002)(38070700005)(38100700002)(82960400001)(41300700001)(122000001)(66556008)(66946007)(76116006)(66446008)(66476007)(6916009)(8676002)(64756008)(83380400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlFtZktjSFhjNzZFdk84UzVHRG8xNkkrbXhpWWZ3eWJESFVyR2E5KzFHQm81?=
 =?utf-8?B?ajB6by9jWFBUSFUvcmIyWnpWdUR6TGFXb1d5S2hCWGwydmJoMTZhd2YwTld3?=
 =?utf-8?B?N0NjNHdoTEFOaTJ2Z2ZBWit4cUdUOTM2eUZnUVgvbWZMQ05tVXFtRVZTelJR?=
 =?utf-8?B?Y3ZSSXk1TW1aZE1mQjJ0a2RaQlRNNWRjQjcrcFBmMW0yUi9CMlVoeE5SSXE0?=
 =?utf-8?B?TWE0R3FnTjViR3VETUJ3aTZtREZsTlZpRWVRbCtCejhoU09PMEJEa0thcjhM?=
 =?utf-8?B?VGIwbEZjdkNjVGdKQkUxc2tzajNCcE45Ty9ZS2RTcmhMRFkvUm91d3ZFWEg4?=
 =?utf-8?B?ajBnRWJmWEpObXZnNHA0QUxFd1FQZDN0VnJEUTh0TndqVEU1b29yd0k5U2Fr?=
 =?utf-8?B?NkZoakJqazB1N0E4TnBUeWpQVkpyQ1U1OW0vYVBLME9iTnNFeXNQTmZYYXRa?=
 =?utf-8?B?QU1PYVdWcDlmTUhGNklnMFgvWmRZRS92cjdQaXAxQWt1NnpibVZHOHdWQ05T?=
 =?utf-8?B?SWdydzQvRkgvck9OK28raGYzai8vUXlRVENVNTV5dGZUYVZjSGs1Z3JtTzFX?=
 =?utf-8?B?aE1sTXp2b08zWDJzb2NXYUEwNEx0MEtOQjRIQ0VGd3VBbmdzSTRMeHdsb1dS?=
 =?utf-8?B?S2FsNFBTUU81YlVsck5STFVUUmtPbXUrUUYxYWRHTm1NNFBMb3RoUXdibUlB?=
 =?utf-8?B?ejYvWDQ3NUlrUW44TzBSV2puRG5kaWxyaWRwSDAzUzV0elRkdC9sVCs5RUw5?=
 =?utf-8?B?ZDl0ZlhjcHA5NEkxQkxkMFMzaXJ0T2pDbkZMdU1vaE5BRXhzMkRtZUhNeGRm?=
 =?utf-8?B?QnEra2RSanpqQ2hSbHR4VDR6bVlIMEdmWlRpOHFNOEE0dzhzdGNiNEVvSE5Y?=
 =?utf-8?B?NUVhaVlMVjBPV3QySVl3WlhNdW1qWk9PcnQyMWJZN0pZN3VJZ2JsWS9EbWs4?=
 =?utf-8?B?c25ueEd0ZXFjT3JrSGVPUFJQRDAwOEUyb0tyK2UzUTY2WG9pbHVFWWg1WFYz?=
 =?utf-8?B?bWNsbis4NWh5bUFGaFhEejBGZjVpMHkyVGlZZTJKWUYzQmpJTWtueUo2ZHNl?=
 =?utf-8?B?bFcybXFMWW9QV3JyaUJnWG1uUHkwcUNRZWQ2OXZsLzEzVjJ2WTd1dWMyRFk0?=
 =?utf-8?B?R3FqNFFsbFZxeEowZENHaWM5Tlk1dmtodVM1cVlQT1Y1WXpqZnlIaXl4RGE3?=
 =?utf-8?B?bTJ4bTArcGhQcnFsYkhWbC9iNlpqUlhKNHM2Nml5UWJoU2FrL2w1WEZPR083?=
 =?utf-8?B?bWlZS2tJQWc3SmVqWkY2azc5VmJaKytaaVE1QVppeisxb2xZcFdkdmh0SlE1?=
 =?utf-8?B?ekh1a0VKZTdzQzlBbThsR2NvUTZESGhvSy9XQ2RrdThVTUdPRUJGYnR6YkVw?=
 =?utf-8?B?dHBNaVZxdENyd09rVytwQk9VbGFVMlJkd3hZaUZ6QitJQ0R1aGVCY0hyOHJZ?=
 =?utf-8?B?RE9EcWNRN2FHS2x2enMzcjE4YTdwY3dVYVNpa2Y1Z3pxRUFPVVYxVWlLQUhk?=
 =?utf-8?B?eUJscGtmRnM1cVBNZXFPdXExM2hlQjRKOVRYeG0yTzFtdWp2TFRKU2JxZyt5?=
 =?utf-8?B?L1hNQVBmZ3hUQmt6TTdKbWZ1ZzJzT2RlalgyZGtEYWNUMEZ0RXdSb1NEWkls?=
 =?utf-8?B?bzg0OE9LK0JYam5VMXMrcVRzOWtKL1Q0clhhUUM5bVFWVjgxVW9hVUFGdE5q?=
 =?utf-8?B?ZXcveXZ3R3FlTmZOQlJERXRrQ0ZNUVE0OVRraFJYdHIxZFlZM2J3dldmdGl5?=
 =?utf-8?B?NG1MbSt3MmEveGNRVmF1MklMZDhpeitBcTJSdDM4ZStOeXNpcTVLM0RMcGZk?=
 =?utf-8?B?WGJBWW52OGNXQ3hpVGlHSVV1ZTMwMVFTVHByMzBsQmtBamM3WnpyaWNxUEJ3?=
 =?utf-8?B?Z0hrQ1VhYzZPUmRTWURkYS9tZ0ZxWmxtdkZXd0VoQjVyd1NMT2h3NUV4SHVw?=
 =?utf-8?B?NVJSaEkvdHNHbzl2TjQ0azVGeWdhUUMzYlFYRU5XNmJSMDBHSFBQRE4zUDNk?=
 =?utf-8?B?UmorVU1JQzRFT1BtVDF6UmZLWlhrYjgrMUQ0U0psTDA3cUVBSHI5TzJVN1RS?=
 =?utf-8?B?VUMrREMrNFBDUmNVamZoNWtrcW5ROUE2bDlka2ZtRWh2NlV1SVEwOVBaRGlQ?=
 =?utf-8?Q?Kzk5370jB3HVT39KTf1zI47HN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6518a941-5352-487e-1e85-08db0a365ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 00:41:17.1263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A1CZ2f5KaB/HnFgDVLq3dn/j/SV2RkBpWF1K4A2SdhH+v6ERcakGaK+AFa38IuczTECs5im95Pbg4Y0836bcvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6269
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBSaWNrIFdhbmcsICBSaWNoYXJkIFdlaW5iZXJnZXIsICBI
YW8gTGksICBRaWFuZyBaaGFuZywgSmlhbmJvIENhbywgSG9uZ3poYW4gQ2hlbg0KDQpDb21tdW5p
dHkgdXBkYXRlOg0KCU5vIG1vcmUgdXBkYXRlIGV4Y2VwdCBEUERLIHJlbGF0ZWQgaW50ZWdyYXRp
b24gcGF0Y2guDQoNCk9wZW4gZGlzY3Vzc2lvbjoNCiAgICAgICAgICAgICAgRFBESyB1c2VyIGNh
c2UgYW5kIGRldmVsb3BtZW50IGd1aWRlDQoJMjAyMyBNZWV0dXAgZmVhc2liaWxpdHkgJiBwb3Nz
aWJsZSBwcmVsaW1pbmFyeSBwcmVwYXJhdGlvbg0KCUNsb2NrIGRpZmZlcmVuY2UgYmV0d2VlbiBJ
LVBJUEUgYW5kIERvdmV0YWlsDQogICAgICAgICAgICAgIA0KDQpSZWdhcmRzDQoNCkhvbmd6aGFu
IENoZW4NCg==
