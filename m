Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D8D393
	for <xenomai@lists.linux.dev>; Tue, 10 Oct 2023 00:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AR2RsGLV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696898219; x=1728434219;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gruydWUwxbXPa7sFdNKl2U4SrqXZqIVQomeUWHUtYBY=;
  b=AR2RsGLV+wiPT/094qQO2MBRUthFrbq+AbZ47egUMxOR4sI4Q9uI5Aaj
   8jr1JCgGLtyeFbs5htHGTvtmUNQsUW5LNY7pHinzm4F+kM95AA/QLzNNJ
   xctZHM8+l5MH7cMRatDs/h3WKucakDa8F3AZhC6M8wE1SEupFnO6OzwUg
   wTLICd0fRxNdnAXDGM47nM3mAHxcQc1X15oDjtvgFVVv3OTfiX+e7S1JX
   VqcfHC5CNhyvnIA3pK/OZHF4IBIQrAxHUmHjd6d0aQ5LgcrLLOH4tILcF
   /YWTCa+wnV9gW3ofPAItXs+UOWKQyFX70IL9wZZRnKJWTwv47Z9rmPnxm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="384139327"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="384139327"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 17:36:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1000444812"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="1000444812"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 17:36:58 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 17:36:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 17:36:57 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 17:36:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WULnQF4cfmoRgwCHEgIE0ZHL+ChIpfYx+zf/WqrAcf4jvLMOiTaquVqKNNYYTbLFRfzh8kyECWE5GKFKCoQtuhtZxaLW5dQNGFMIMSir8reEsnz0mGZXaOqdDsGkMP3T196Xpqs784vCoPACvAUVRd94RC/THtZwGWymDSABQOx8kP6QiIb0wYohnjDH8/J/wgixYlCHuNd6hPRO0snK11fYsyXsttDcNO9z1eHUT49U8tm6pb+KBanMC6Vi0dthiX+GX9d/S8pm1o6zj9vFM3RyD97Q9cykDvNXDex9TS9WpcNrtbmBj0wW1WXpIQeuuxjzpubWFP8RnkBBqFYUfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gruydWUwxbXPa7sFdNKl2U4SrqXZqIVQomeUWHUtYBY=;
 b=U2WlU146HbTMFRBnpPkvUcKvvlKJMiHKRhxik1OQxqejQku1R+z+8sJ5zXflY36o7lbKIkA01ylJWjFxUze5zBSkgiYyNt9AjnshzBzG4v35UKDr0wSxWf+/teoitqcXnxM14tN+CIcmuP0dWAx1pDkgRPXGDUhxSgECHmn7yg3nuLY1MjXdyks52gkcNlT020Zova7ay1hWLzv2bkklGV1QiR3L1u95U/RSM1zOO4N4MeIbdpTmIRzhNiSwB+oMIp3vOLFzLeEp2yJBDoJOsbophREFioOEl1Y8S5F9/pgiBpARaQpIxhl65+ED169aX0dMdf7ksSx/xlr7Xw9cUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by CO1PR11MB4836.namprd11.prod.outlook.com (2603:10b6:303:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 00:36:48 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::b563:f43a:242e:5c5f]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::b563:f43a:242e:5c5f%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 00:36:48 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Richard Weinberger <richard.weinberger@gmail.com>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Reminder: Xenomai community call on Wednesday, Sep 20, 2023, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday, Sep 20, 2023, UTC
 7:00 AM
Thread-Index: AQHZ9o+anrWo8ul4R0yqbIjt3g7MfrBCNHkA
Date: Tue, 10 Oct 2023 00:36:48 +0000
Message-ID: <MN2PR11MB42853939B9B762880D88439AF2CDA@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <MN2PR11MB4285288BBE0F81E94669D614F2F9A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <CAFLxGvz0Rov5jmASLW95ndxmAH-shKBRgwb0eFr+uFk=-fU+Jw@mail.gmail.com>
In-Reply-To: <CAFLxGvz0Rov5jmASLW95ndxmAH-shKBRgwb0eFr+uFk=-fU+Jw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|CO1PR11MB4836:EE_
x-ms-office365-filtering-correlation-id: 72a40a49-51c6-4555-6076-08dbc928fd19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qAYmz8xwlClm7cWbPy85EVJ1icelwB+okhhOeZivoCmYu96QhvbHbv5+GehUXngie+pd3asPcVPLHkkXp3DYeMMEeUaMyUzVohp+fw87bGwWLC8bAoyhxujOlNNpSRlhL6LVAiEcsq4VWR6ZvTmM/1k2tLBCHyiyIpq6m4QvDDFQsS7IqWwrRnYoN3meL0NogOme5FfZIjfZ4zsxVGUz+b3Or+cPA6qxY+bRsEyZ60GtqicolH/CrO55X9bxLuE6FYVMPu5dm+jY/bqD9FWitiHP8nDvQ6g8OWQ5uLbMsxFAaUsw7AaRvdzHa4X9pUDSw9wFeO9qg0r1ja3c0HEfFOyVZIUtNHtpclT+Q/alo8OLZ8oPQQ4KlPU+ufMTCsIIALbjP5IAHcZiwuAc5gLBoFFadvqxSssPKcnXUe9zn8Vw/mAmkbM18I7oDAohct0Clhba2o5QmHLHN+x7b5ysh3VtHUD0c6EGLbhyOg8yFeD/RmvS3cv+6oKhbdO2bM3A+R0qQxoVk6na32xUkRNscmEB3M0FzEwA2dPn7a+xc5+g2cXvDZ+i3dAuWBfRwSEthXxZ1y+QsstIkrNBA+tTApQgYPW9U7M/Fzp1pb1wcOmz68vPfddMQ9W1BVWtokuNVHWZrmfBPhnRoIJpmR0U4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(55016003)(9686003)(83380400001)(5660300002)(26005)(76116006)(66556008)(66476007)(6916009)(66946007)(66446008)(64756008)(8676002)(71200400001)(7696005)(52536014)(41300700001)(2906002)(478600001)(4744005)(316002)(6506007)(8936002)(4326008)(33656002)(122000001)(82960400001)(86362001)(38070700005)(38100700002)(511114005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akVYRkhDQVRrOFA5Uk1YSlhJVy81Uk9lbk1sdHNWOVNnRW1BV2VNQ3lqenJY?=
 =?utf-8?B?Ym1ndmgxTTMzZlFjemtrM2xXMUxSblhjM3pZOVZWb0owbjFZamtNb2RoSFBt?=
 =?utf-8?B?b3hDWW5XYzU3RThDY0luT2RVaWQ4eDhhTWNTd0R6RmNhSXRLamxzK2VPZmM4?=
 =?utf-8?B?RW5SU1o5Z2l2TGZoZGcyMWx0ZVUyNUVqVytjeFFsREc2K0QwUVlJWXAyblpm?=
 =?utf-8?B?UGRIZzZpT3Jld0taZEszUG10VVRGMC9MMUcxY0l1Qm1qb2FMRVIrYzd2VmE4?=
 =?utf-8?B?dit6a0hpUVo2Z0V2OVVoOVdXUENvNkdZa3RVb1BuL3BkRVlVNXlMV1JrTUUv?=
 =?utf-8?B?WTdZRVRHclQ1cWRxdnFrWjZTam85LzN0NXZqRFRpWmZDeFN1YjBKMkVzV01G?=
 =?utf-8?B?MnN2NnNyYzJZd09WalQ5c1llV0tIV3dqVTJyRnhVWEMzNzRDRWRkaDd3Vm5r?=
 =?utf-8?B?ditnMit0cUk2YVQ5TXRWcFd4RG94WWRSbFpoZUVndUJkcHQrb2JHOUtkQmNX?=
 =?utf-8?B?dWdoaERIZUJxcDVBNDdiSzhzNVVMZkFJV2Y3U0hsSlVTUnBDaUtqUy90T1ZS?=
 =?utf-8?B?U01sUXJxNnA2WEZlOS96Yi9RMDBGTVcrbCtRdnU2a3pGVXQ2ZUcxcnJrVXlS?=
 =?utf-8?B?MldaQVZ3QXlYMW93ZXU0RUJxN3B4Njdvb0JoVlViVFExZjg4WGszbkUwVVQz?=
 =?utf-8?B?L3JNcmNpL2U2OXNoT0dvbXNqVmRPYTNiNWN1WTNicVAxQ0RyU0RHQTVEeXZL?=
 =?utf-8?B?NEtacW5pMTU1NkpBc3hrTjdkN1UrWjcyZjBtcG5XMDF0OUxSUUdoWEVLdkpS?=
 =?utf-8?B?Y01nS254OGgxeXdJMTRkSVJ4WWdXazAxV2ptY1orRGNVeHkraVRVWVNDdm56?=
 =?utf-8?B?SWJ4dWFwQ3MzcDdWN0diQk1XU2x0THJ3emlwNEoyVUIxTE9MMDhwS0JoTUtD?=
 =?utf-8?B?MThyVGVKSmV5cCtnZzlXRTc4dW5mQktwdlZWdG9ic0IxMVlpT2V0QWlsbE53?=
 =?utf-8?B?b0JaYmtOSDdYRUxDanlZTXBWWGpnbmp2dmtOMHR2S0VyWVE3ZWljV2VTcm1B?=
 =?utf-8?B?ZDJrOGx4WTRpVDR0ajdBRlpGWkFIOGFhUmt0SDBVNlExc2FqMkFtOWZLelNP?=
 =?utf-8?B?QXpUYjI1aFluSVVmM3VqYnZyTVBiOWttSGx4LzJhNkdnTElEampCSlJwV2ZE?=
 =?utf-8?B?MXNOd25zUEdGd0ZOSEpsQUJmWVhJa2Z1L0g2MU12Q21aWXI2blR6ODd5MW0r?=
 =?utf-8?B?NnZRNGFwbWM1aEpkU2JaN1I1S013NTFQb05yMGNFL214ZjhNNk9iR0ZOVFJP?=
 =?utf-8?B?TndnTkVVMStGd242TDdFV1MrUk1rbjNGZEJKK1MvbE9NT3Fvc1JHdlBPcG9D?=
 =?utf-8?B?a1lldjQ0cjVUdUN0ZHNoWnNQK3RFTFNJZlZNME4rUmdpcXpPZEZ5L05BNWFY?=
 =?utf-8?B?SzBZUHpOWXNhTlhmYjhnbER1V1FVc285WTBJWjJiMCtPd3d1YUdmQUtvNGc5?=
 =?utf-8?B?Rm9SMllZL3pKOG1KSFRhVzJibjAxS2VrL3drdUlHK21vTDNvTjFrVzgvclZ2?=
 =?utf-8?B?UUI4NDhXTDhTMlBMQnhVeCtTQzlqRDJ4KzNlZjIwL1VET2N1NHFDNHlvZ0Rl?=
 =?utf-8?B?WmF4aHNzaDVoTDJnOHFSalF6b0lWNmhUbjA3RTR6TDZjREswNXAvbnlkcUhZ?=
 =?utf-8?B?eG04Q1p6cFU5SUlsMkhPTTg4RTc3Q0d6ZS9tV0xJVXFWZkZjbTcwbWxuQ3M5?=
 =?utf-8?B?T1RCVG40c0xqR1ZhNnB6a1dZYVhNMk93SHF3azE4U0o0ZzhLSS9GV3hQQWps?=
 =?utf-8?B?ZXpwMXNIVWZqUDUrZldpYWkxNW5KK1lUQWNqWEFIaVZsNmpaU3ZGRGlXSHNV?=
 =?utf-8?B?U2FzM3RxYzlNZDBVTmRUOVNCU293dlBpOFhRRlozcnRDWURnQWtkcmxnVGIv?=
 =?utf-8?B?TTJPRGZOeDU2VEViYW5KVUpSeXhXa0hJWHA5dzA0MzQ5MUJCUTgzanJGSDVX?=
 =?utf-8?B?WnZuSGhIcndEMGlWZ0YzYllVZlVYS2JnajIwdXNWOXdYQzJGNk0vWmtGZll2?=
 =?utf-8?B?NEdMUThtQjB5WmpVaEI3ci9GVUhqcnk2SFc0elRMVlVrbEVSTEVsWTdyeHJX?=
 =?utf-8?Q?WlpfYpWIlV10dOOCMu8neXMYH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a40a49-51c6-4555-6076-08dbc928fd19
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 00:36:48.5030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2aD8Ia+sN9Hc/Y2lgtgKHC6U7xOv+6Ui0gAPVkTp1Hvjybhv82Mj6625SqNrbEMjvunpakToXgJDUrbMOkujXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4836
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFJpY2hhcmQgV2VpbmJlcmdl
ciA8cmljaGFyZC53ZWluYmVyZ2VyQGdtYWlsLmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIE9jdG9i
ZXIgNCwgMjAyMyAyOjU0IFBNDQo+VG86IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGlu
dGVsLmNvbT4NCj5DYzogeGVub21haUBsaXN0cy5saW51eC5kZXYNCj5TdWJqZWN0OiBSZTogUmVt
aW5kZXI6IFhlbm9tYWkgY29tbXVuaXR5IGNhbGwgb24gV2VkbmVzZGF5LCBTZXAgMjAsIDIwMjMs
DQo+VVRDIDc6MDAgQU0NCj4NCj5PbiBXZWQsIFNlcCAyMCwgMjAyMyBhdCA0OjE34oCvQU0gQ2hl
biwgSG9uZ3poYW4NCj48aG9uZ3poYW4uY2hlbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4NCj4+IFdl
IGhhdmUgdGhlIFhlbm9tYWkgY29tbXVuaXR5IGNhbGwgdG9kYXkuDQo+DQo+SSdtIGxvc3QuIFdo
YXQgaXMgdGhlIGN1cnJlbnQgY29tbXVuaXR5IGNhbGwgY3ljbGU/IFNob3VsZG4ndCBiZSBvbmUg
dG9kYXk/DQoNClNvcnJ5LCBJIG5vdGlmaWVkIHlvdSB2aWEgZW1haWwgYWRkcmVzcyBSaWNoYXJk
IFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0PiBhYm91dCB0aGUgbWVldGluZyBjYW5jZWwuDQpJ
IHdvdWxkIG5vdGlmeSB5b3UgdmlhICBlbWFpbCBhZGRyZXNzIHJpY2hhcmQud2VpbmJlcmdlckBn
bWFpbC5jb20gbmV4dCB0aW1lLg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg0K
