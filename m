Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16FE7F
	for <xenomai@lists.linux.dev>; Wed,  8 Feb 2023 03:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675825506; x=1707361506;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=4RrTBkpbzpM8lRaWPWYWnmo//FbxSiEsTjj+Wek51d0=;
  b=lUXSxSNL0y8qEhJY9HVUZ6ePbff1UnjWHAXvd0zX8xYFNSqg8JISbVUy
   Un9wisrJj3tbAmkRiTSQrk9U2lIcZtWQNh3kGwvZOh2dgS4PutY+YqfVI
   DkR9XVqWSaNR5kEMrWZ4eAzduSCNBP1WT6fAjbkamd+KpHCugXhq5xMu1
   NJfe+k3qg0M7AM3cRzqI63/L1WDW5w7ztnRcE5p3/ae9WQGjq5mXxgunU
   gi2/zGZ60bt9AfnOxoRuocVP0vlWWlIwx0AtNrPTNuif09D0q25/sM1Ff
   OnZBVzVr97Xgb4LI39cIBY5wkX1kc/5VAi0GEvPYG0CuTxv3mJIaz79tU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="392093865"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="392093865"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 19:04:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="912568815"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="912568815"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 07 Feb 2023 19:04:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 19:04:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 19:04:57 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 19:04:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICxG7sk0NF/i20C6B6J7mr/ZXVM7isB8s2FIMKzl+kn/28ZytxfF2p3Lhx9Ckx+xhs0joWfZO/jAFLe3wkF+tEEkGiDU2OMdqvUQH05Dqy/4x0UpXhRPAr3z+cHc8LEZIke1Yex7iGzOhALTQx7x0QDVWQiqG+V9+/CSfMeZfCIWm9MjRUU5v2CbTbyJqgpPle/7giRgv8JWM/0ubm74iroFOIyWxZMuBUabAgCU+JtlJwBsqxA63+odDa9hRWAPysyZPpmD86NIkR/X5afIN8G9NsXqgaouEqThFl18NWry5Cz88f9NNzItsv0Dtmi4zyzlDy5RkgMyhaZmwhNoBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RrTBkpbzpM8lRaWPWYWnmo//FbxSiEsTjj+Wek51d0=;
 b=XddrkEpHTg9fljrkGUo4RxNtLJ7w9Loxdm6c9X/zYXIJTqfxBm0fPNWf4rBkMV0wOpPWtF0qjrsniEN1KIFjrCdj3QYh8srGmoap7RUSy43LF7FehmVuu9qnUf09qYVPqQY1Agbhe4pq7/6Qa8SuiXpp0Q0cLsNAxVSLCaSbAg923cWJvjJN2b4uKSIgC3m/BlG79Y48phwOmAu0nK3PPAQipBHPRiPZ8TtOHJOxWUz45pGVHtqdJSz7koq3TyiCk+qpMs9YSYuI0vJZA8Vh2ZR9wdbIvaRDivTmIPLjX3HhEgv8LXpNSawPzWin8jjXDt/TahklWquy4nh5S6YL9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by DM4PR11MB5376.namprd11.prod.outlook.com (2603:10b6:5:397::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 03:04:55 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2%7]) with mapi id 15.20.6064.035; Wed, 8 Feb 2023
 03:04:55 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Feb 08, 2023, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Feb 08, 2023,
 UTC 7:00 AM
Thread-Index: Adk7afz5jWEITINnQk6YjADvaY1cMQ==
Date: Wed, 8 Feb 2023 03:04:55 +0000
Message-ID: <MN2PR11MB4285698A277A3F0BFBD55D08F2D89@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|DM4PR11MB5376:EE_
x-ms-office365-filtering-correlation-id: dabd9aab-cb45-49bf-f2b0-08db09814159
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W4dtulfULY+x5VrWMpE1Knr7JYjmR7vjhlGWITgMWl9459QylIohxMkVmD3U4vXREFjCFyvJ4x7W7DhVFzJEvLS+GZM8jW/eXocHCHuAJE1u99B8mgwCl80SoPhfTZLoQOUK+jS/ELnMA6DN1GW+9DFLwJAsHHVFDLFc7xJZohKtaCyqxmBGgK1WWHUi6oHoMg2i6A10UjfCUPoEo+sv//ldk4WsZhGPolNXUKH/VBrH/ypyt2f2GPsftoVRQF6A5wxXg+U2vjurmIpJ+HcrPxsmLFrpA+n3G5H3jElVgYGuxb2dvlDCvOpiFVSi2fjial+XMryACs6hble6aLSuGVY71vqL373YXqt7KMQ+OURqkHdQcZKxByY1GOjBzPkKdeDy5xodPpZwEYw/1mqTEQRePGI0VMD69MLWMGLf5w/JjVPRv+6MSl+CeoYFq9tEdBdLMMAAQE8PKJgTWk+BMMSLGjE/ezsizffQVvAl2Ja4P9tZw1h5ce6eLEc1ZIDZoFNK6XwsfdOz9pwPZofl7qjCOpjb6wW24X4sF5FJj6b+lXovBQN2j9aHW1eLz7Yqt3tRpEijNhIUtgsNor1FBy1engHBfbs7l/+TG8jwdz1wSp7oD7dAvEc0YG/it6E82mKg35NKQF5bfNYA5dgCIlAtNBqB+CNM24nH+23aVVum2dn5upcoI/41AAveJ9BCFmMCMOSjyHjm6DCQAXSx1SJaSMcASzDDydWGhS5vVIyVInez+vLW40k0lQQ4V7QLX0Xe6Ap6d7s6/uW6t0Mh4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199018)(41300700001)(52536014)(82960400001)(2906002)(33656002)(122000001)(7696005)(71200400001)(38100700002)(38070700005)(966005)(478600001)(26005)(6506007)(40140700001)(6916009)(8676002)(64756008)(66446008)(66476007)(66556008)(9686003)(66946007)(186003)(316002)(76116006)(86362001)(83380400001)(55016003)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGpkK2U3TXFZNTVORzdzd1lxNzdGZE9VTE01V2pzdXlmVTk1eVZwRWFubW5X?=
 =?utf-8?B?Y1NaRVpVeWFnSmN0MWEzNTFXNG1icHEwWXhubVhZa1RuWldrRU4yNlJ1VTZB?=
 =?utf-8?B?SDBGZ0RHaVlSUDN4S2w4ZUxaMVVrUUVaYnRsQ1hSQkJOcGpKMFN4QUlkRTZQ?=
 =?utf-8?B?SzI3NDVzWForUWhZbEdZaGxMT1JYOEUzUUlhc3NsSmFJWE0vWXNuZ1JVaUMw?=
 =?utf-8?B?SHdhRTRhb1ZSSXNFazFYUkh4S0dmYm5aOTAxMWY3U1g3UXhjSU9TaWNMV2FG?=
 =?utf-8?B?NTJJbUlrUXhhT1hjSXB1S0MyYlhEN3VvZUFKUW4xMEpRd3pnSkkzc2lJWi9P?=
 =?utf-8?B?UEdQT3ZidHh2K2hTNVhjYWNSaHFLbmlSaU51ME8xVjJ0dnF2andhM2QzSzhI?=
 =?utf-8?B?cCtUdjY3TkRMOCt6WnNyNmNNZWg4d3I3ZXU5MjFFSFgvTnFPMmh1c2ZmaWlm?=
 =?utf-8?B?OHV5R2RiTU9iT1RSZllOOFRJUDBWY3FlN1RjQTE1MWgwZUV5OWNNcVNadVRE?=
 =?utf-8?B?cDN4RDluaHBSV2xrdC9KNkdDaTNIRTBZb1RmRURXVVhFdkhuTnBXb3lUcE1j?=
 =?utf-8?B?TFIxTVVaNU94ZGJILzZobE5WNXUwSUR4cEk5WDEybmR4dzRFemxqNW9ub0NB?=
 =?utf-8?B?NzM1a2hodSs3VHFkMmxKOUMrck5oUTVPTTVaS005QW1YUU8wUHkxSUdMU2N1?=
 =?utf-8?B?R3VIL2lidEZoYmFibjNqMW5Bc2lCQitOSzdTa0NuZnQ1Q1dWVWlKalY1cFlC?=
 =?utf-8?B?R3FQaC9vSVhIaXpidWFVcHFuRnlFdkt3Znh3cTYrUTJ4RzdYeTFqemtxVVNL?=
 =?utf-8?B?ZkNjQ1JkYVNudmp2VlRPKzMwZHI2Vi9wdkNMVitjVm5MbnlxVDV6dzg2VlJq?=
 =?utf-8?B?ZjloeFR0WGN4Q2phblFXN3l0SGRwL1JkRFhuVktTRkF1dy9MYVRBYWdNK0tk?=
 =?utf-8?B?d2hhTFVxNE9pQTFmajBnUGdWYjZYTnpKOFc0OVBmTWVUcy9rMEQ0RUNybjJ1?=
 =?utf-8?B?aHlUSk5SQm1uajJuOG56VVFaR1RKTXZBOGZ4SXJ1eVRsQ2RsTW1TR0R0TXdn?=
 =?utf-8?B?OHdnNHlYNVNzZExqdGprM0g3YVltZkdZOXlnT2UzQjNLZUEzc1lSbjlnOXlu?=
 =?utf-8?B?MEhSckgxQTdaQTNkdDBjK3JMRUQwM2szeHNCUWN0UEZ6MkgxNlBBaHVzd1pM?=
 =?utf-8?B?STc5TVNiWmNySkFyays4cVdpM1VpWDlwcVRDc1RlYlZEMVplbWc5YjVObUFh?=
 =?utf-8?B?NG5TWEw0ZGNkck1PVUNCSE42bnhrODJ1cWl6TitRVGNuSk8rbzllN3RnYy9m?=
 =?utf-8?B?end2YkUwUVdRNUV2YUU4R2xyWk91MnVWbnllUVg1cXJtenlBcllyblpZdU1s?=
 =?utf-8?B?eGRQVDFSbFR2TjluL2xvcEFVcU5VNVV1aEtoTklNNzQza0lBbXR0SFNIaDNu?=
 =?utf-8?B?WW0zMEtBMHFVV3lGbUhSRzZCZ3c3OUhZRHhheXVsS1BKenhtbForR0dtdXJj?=
 =?utf-8?B?Nk9ubHVMRHg4T0hidXlKRGZZME8ybElCUG1zZmM3VTdPc3FXTDdlcmYwemVN?=
 =?utf-8?B?WkMzVFRmZWRrbVRWQXZyZVNMaWQ0ZFk1OFZQbWIvQVp5T3EvVWNyTE9vbjJm?=
 =?utf-8?B?TUhIZUEvOTRjbURjZDA1eDQ4MmhFOFc4QlNBU29GMDlyVmJNQzBpV2hPVTNx?=
 =?utf-8?B?S045c080RzloWWtScmQzZ2NTdlBNVkltZVVhNHVwL3FPazNOR1B3YzJDL2Zj?=
 =?utf-8?B?R1ZPU0o3S1JqOUdzSUZyeUc3WVNYWGJkQjRNalEydmN6Zlk3UzdnT0daeHRO?=
 =?utf-8?B?L000aEJrbG0zUnlYMWM3T3NlR0pTYkhLanBqdWRIVmFSZzVTbmxOZ2prU3pB?=
 =?utf-8?B?cW0wd2ZkWnpPNkFzRCtqOWd5U2xxWS9HdzZzREhQckErNU5iUVpSSE5DUzdy?=
 =?utf-8?B?dHZqTVpUVlkxNTF5S3U0ZlBGenRjTENmMS9BVW5KM29oa2N4eFdnc3NUVklO?=
 =?utf-8?B?Q3AvZFZJVlVZMGYyZjVBZG5DeHFndVlUemg1QTlnM0hBYk5wYkxSTVpzeGwx?=
 =?utf-8?B?NnRmNmV3STFNeDU4ZUNvSzFMa3MwcUJQYUpoeWIzNXpmS0VkaGtpVGtiOGMz?=
 =?utf-8?Q?DtLkMgngIFWsDG3Nh6Dradciq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dabd9aab-cb45-49bf-f2b0-08db09814159
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 03:04:55.4745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /7zoCSLARl3n5Y/iL9svm04/sR6R2gKQh9ELFtHaM47TsNAdzxP2DeI6V0zlLNvBgXwkjfaAFbHJX8LGDQBWCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5376
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgRmViICA4LCAyMDIzLCBVVEMgNzowMCBBTQ0K
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
