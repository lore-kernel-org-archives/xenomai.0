Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C1023A8
	for <xenomai@lists.linux.dev>; Mon, 16 Jan 2023 14:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673878194; x=1705414194;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=evY0qtlUNyI+XpK67OttZpVCKdlsq7QbRpjhn8/Igwo=;
  b=YD9voK1tR+edapaCY1z2GjKw7TEYRuKgYFAeoQzP80b2rUv5e5OMVH9E
   C1xagK0wEWoC8TZjqMaRRP2dvE10DRTGUqybh3DB0XBjiRE0kXwpnITVU
   hFVQ51tWZgc4DG121AOd4ivV4e9gOhtqz3S5v5T0cke/W72DCAoorHRNh
   4uylWzJU/fnoxa0CqmujFbYolAnxEsvvWnO9j4DJcJPpqCwZrV1wzvBUG
   pKUQls6R1FjiCXmdo6cld5LBVIy49oQmZ5CMeDE/nUZGc0ZpIlBhAKaHm
   XWy9KaNGi4f31YNJgNTB/Nfdm4tfHxovwOg9JeJg3r+ZwJdRwBvzLfBVy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="410716912"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="410716912"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 06:09:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="747740171"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="747740171"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jan 2023 06:09:52 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 16 Jan 2023 06:09:51 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 16 Jan 2023 06:09:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 16 Jan 2023 06:09:51 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 16 Jan 2023 06:09:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMSNZzQKd0OCrCLBURkRW1/nu8eXGBUl+AHx4QM4FtZUFjcqSbtqzGWyclRNhHM1yon7uhtSatZmym6vEITJLknLc7C4xnxnzqsdeOfbnHdy/d85TayDUySphyNcv9mCVLkedoXO3ZoPtSBu07tku3fUNjsZUXKLj/NiXnv3iMdE2wVNDIEDcFzzzBGXXwwOmetMxyMVJW+guNaRBTP0rfkdyqI7YNBGOD4oBZl3A1Kggr46No3WgKvtnR0oWCwNiJ2wQlqiJry1RUurpbJrpXuTj7jFU9IGrgKew4A6C1wgz4/S1hE7XpGkDM4zNvoozv412WmWn/KNAIUvTsE+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evY0qtlUNyI+XpK67OttZpVCKdlsq7QbRpjhn8/Igwo=;
 b=YHyxWWKgt3pBf2d6818IwfCqX0lCfzLh1dkMUQZYuHNK7AF7oOz8Go0NyUi3rT/AhAOHr4qv47jIqjCswO1fCs7GRXy9iNqGw/El03h0/IH6w3NFMxWPoXNTCKn6K4ARKcZnesAr6Cd+6zGl0qqCcprcvXZrMLpMvZ6pJ7xS7++wPtnvWenAF2nOn5pRgZZnTw9mnvPR3KFPdFpntZcrHuWaL4fZ+XashUg0ktFrkW105xno5yT0/nJpuam6H5im7R/JUmBEaWnFHFYjpmMxaU7uGvqJpTh0zFniaeX+HlCc/ikfQjg2eL2dhb8vsjNLC1oDtas9Zrh7BgyAHPV3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 16 Jan
 2023 14:09:49 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2%7]) with mapi id 15.20.5986.019; Mon, 16 Jan 2023
 14:09:49 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, Yunjie Gu <yunjie.gu1@gmail.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: while loop in a multi-core cpu
Thread-Topic: while loop in a multi-core cpu
Thread-Index: AQHZKPuJYrpVvpaAY0Snx/eP6+qfq66gWcgAgAAnu4CAAAlM0IAAOAeAgAAAuoCAAE/kwA==
Date: Mon, 16 Jan 2023 14:09:48 +0000
Message-ID: <MN2PR11MB4285E612761676D50EF5571DF2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <1673779013-11742-mlmmj-00f27513@lists.linux.dev>
 <CAKcohPxHzbQvztgQMQaFq-EoXGbpfQxi1HpPV9nogBUaQ+PUSw@mail.gmail.com>
 <CAKcohPxdhCMohJZfSNaL2EvEDcLdm8CRgdy3hUusCu9Y5jexxw@mail.gmail.com>
 <MN2PR11MB42854A69C41937ADA0F29CDAF2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
 <e8f0810b-7104-18a2-9931-a1df6ede2917@siemens.com>
 <MN2PR11MB42855B83E5F981669B6B0ED9F2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
 <94fdf3b0-bc07-7063-7cc6-f6987ad1ed10@siemens.com>
 <847c0a00-2e91-6391-d8e4-6677ca719baf@siemens.com>
In-Reply-To: <847c0a00-2e91-6391-d8e4-6677ca719baf@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|IA1PR11MB7198:EE_
x-ms-office365-filtering-correlation-id: f59be17e-33af-4374-04b2-08daf7cb5432
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2uNthWjFQvjBLXqGjBddeB732iBpnhA/F2r0GHzpYAGrNl4BCdrj6hjo7BE7gWDTSZLcBdk/EJu0tsqVZfl1V7MzwFSaprtflh/aRTOWDvV+coB1fbtIdiNmSgKnymYkdyUFvBmS9xK29QSMf/cars8yg10AtvtTCsN7p/9iT/jRs8sCKLutjl888EW0+EQ6GrRMgOaytV45jdGJmwa2mTgIOcdZXPjJyq4j1NQftSUh8qKUc6L6o4HyN4SFSHKaXSTw0TeLaggzV9Cy0j+wr0eznecD84PJBYLBRY4wrqhLphGIRFuXJE5EKeJ54ae31J9+B7Hhh1jbL2enlzOEhn0+nPJsKls5nInWrl1gxmCWipBKvXsAbhqEiOmXV650u5kCsfIuETOfyt1beFtTa98t5w3NBwbQjqnbp+C1nZnqUomewtyH/9Ky4FAWF+WAGfZYHtVM1q32d72Ip6zgQ3J84KZ1LtqtbR9xsZAFbrUNM75iGNBvi5bRSPsgBOrMKUs9jsg3geYUzYeQ6tzwzoL17pjROHRejWpLB5MNx7wLTOy6AxmlcgKoPXgsl52rERi5kvCta0jKfA1pPiSimwrq9Po+nWHJWBrcJoEq8AC32cI+/8vveQzqBgWMkWThGkp/4dJ8IsAukuiTS3Gnt+pOjfgdXCJkvfBH9gxKt5g9XkUjoURpkzq4c2pmz+x5bO7AHznUZ1imNDSRFQwCNTZoL2s3ph2ZB+iS1TCXp31ecjWL3KV9eqKxecPc1JJOIREJXlSGD8IiguXcy53thA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199015)(478600001)(110136005)(8676002)(76116006)(66946007)(86362001)(66446008)(66556008)(66476007)(122000001)(5660300002)(38070700005)(64756008)(52536014)(83380400001)(7696005)(41300700001)(8936002)(316002)(53546011)(966005)(71200400001)(82960400001)(38100700002)(2906002)(33656002)(26005)(6506007)(186003)(9686003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGR3VDdabVNoMFc3WWF6eEtIUWRHSkZHM050WXZwR3o5b3pGNmhHZTRVM0JJ?=
 =?utf-8?B?RTJRcjZVaDhVQS83K3JBNjJaMDYvSm9yYmR6eDNZQ1JHY2RMdFRxWCtkL0pn?=
 =?utf-8?B?S1NxZFFidVZUcjhWWWwwTFIzVXNwbllYdU5mMTg3YVZiOGljclI0QUV0QTc4?=
 =?utf-8?B?NW5LNUs0THZ6aFdtcXhqWU9OM05KS3pld0djdFlLSEcrUlZMa1lKYlBNMXJs?=
 =?utf-8?B?U0RxVnpQSmFMdytLd0RhK2lMQnk0NyttOTM0bzBCa0FWMndzaFc0aEZGZWdN?=
 =?utf-8?B?K3RSam1QSDRSVVk1TlMrY2FhZDUyaHgyTHM4eVAxU3B4Nk0rT0k4WUJiT1c2?=
 =?utf-8?B?b1ErODNTWjZHRkxqT1BCVFdRM1c1Ui81MllOZHg2YnNEaUM2LzRocFYwd2pn?=
 =?utf-8?B?S0lxNzczNEZXZ0dKdVNuN1dHdTRBMjN1UnVybkRyckpKWVl6SVRHK3pITTdK?=
 =?utf-8?B?a05ZU2lRQ3VhaFVSd2FKRGtuVmIrWm9PdGhXTE01dmUwR2lCRzlyWUoxNjd4?=
 =?utf-8?B?YktlcHRsSFJmZjF0clp4TUVIVmhoQU5qSExDNlovTVVGeHpBNWJVLzNCNWp4?=
 =?utf-8?B?V0s2Q0ZnOVM4eVQzZ2Y2UlVQT1BPb0xSNk4yUWx0YWhyNUlJc3E3U2pEN0NM?=
 =?utf-8?B?bWUxb0hkejUvVTRsR3N2eldCamJ3ZFdsMmFZVXAyS2xTM01VSkQ3Z2U5VlhZ?=
 =?utf-8?B?V0VtN3QrUW9qbXIyK1hNTGMzaFVwVWZ0T1gzMEN3cG53V1BUSnk4QUJqeFVr?=
 =?utf-8?B?REd4OE9uTlJ5YkxaeldIOGVWTHN1b29iVzA1VDJFL2dJVlVhTVRjbVdjUE1n?=
 =?utf-8?B?Q0VaK3RGTjRRVDNVUC9ZNUVxM2FVZ2VmT2JpdFFHZHFNeUVtNEpHL3ZETS8r?=
 =?utf-8?B?TGp6TGx6ZTBOT0pua1pyMTZML3RJZ3MzYmFWbWViR1hOT0NIZ25RcWYwQUhm?=
 =?utf-8?B?ZGRNTGRlS3JmRUtZZkxGUVBTWFNLR3FZVlhQM29IK213d3ljOUZGNm4rS0M4?=
 =?utf-8?B?VEZzd2dNQUNJaXQwRmhlU3p6Wk4yZGpUdzRCSGljWVZpcmpnTDFDZEMyOHpB?=
 =?utf-8?B?QUxnNXg5TUIzSVFrRGlJR0Z0dWpaTTRkNm9sanJYdEwxTEo0UGdMaUZSc29F?=
 =?utf-8?B?VkVWdlBkdzZWM3VsYkZDVVR0RU10V21Tc0JuaEFwbFdRbWc1RDRDRG5HLys3?=
 =?utf-8?B?Yi9HRDNsS2J3V2dIY0krSXlMb0pnMVllOXRSdFlvUTRIamwzWkU0d2pIdHJi?=
 =?utf-8?B?UVBER0d0TjBqOG9LdXFpQ1N5VzloQ3Nrd00weWtmT3M0dXRNbDF6S0FxcDlr?=
 =?utf-8?B?bUQ2Umd1NE1MZTBnTlFZMG1HZHRCUC9zSEVZWEhENmg3WW9IM2s2TUZWUEVH?=
 =?utf-8?B?anYxUDNmd0dkWUQ4Ym9vK2Z1NkZLclYzT2thZ0Y1d1pydFRVRE1XSzI3OWUx?=
 =?utf-8?B?UlFCdGVGQ3BtTW1GYUVMMUVzaGpBYUw3dWNodDRRWkplQW94aVo1UE1kdko5?=
 =?utf-8?B?d1FuOE5mTXBsanBQZkF3ZThSVFU1dGRIdUNWVEV2YlVHTFdscklmY0ZiZjZE?=
 =?utf-8?B?eXdKTmozb3FHTGZhdE92eUVZWnljU2x0cTUyMFlGRWZkL0pCL2pxOWZ3R1Q0?=
 =?utf-8?B?SkpVNFV3OC9wNXIzcFY1ZVM5R2VidUhEbEEvVkxnVU9Id05jbE5hTU9CMmdP?=
 =?utf-8?B?TmtGUlF0dkxmeGVycis3c25Gdm5WNlB1WndrNXJld1JtR1hOc2g3MG9udGYw?=
 =?utf-8?B?bW9ianpaOURBSkJKbkd3ditsamVEdCtRcWNLcDZGV3B5aSt1OEhlV3A2SkIw?=
 =?utf-8?B?S1FZSFlTNnlQeXkzZzcwN3dBOWxLbjFHL2dMcmoydzhQY1BDUDduQVdxc3ND?=
 =?utf-8?B?NXM0YlBrc2NRc2ZSZUc1d3BPenZQWnZLcDRtcVhVbTFRTTVuT0Qwd1pCd3FR?=
 =?utf-8?B?bWVjTWtSTTZ5eFZ2bmpvU05GRFR1S3BCZEVXeTQ5dHBJeGZzTFRuMldoVm9Z?=
 =?utf-8?B?REppN2VGSnNRTU8wU3o1UHdlb2NVZENwRzl0L0dYQXF3VTFvNDJsWUUrQWJ1?=
 =?utf-8?B?TlVsblpwelZTRjNDK244UUVta2EzUDV1R0ppRnA3Q1BtU0d0OFlzY0g1UTB1?=
 =?utf-8?Q?gK7vcwpbyFMSx2Hvhu9eAJ6Ey?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f59be17e-33af-4374-04b2-08daf7cb5432
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 14:09:48.8863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axfJ+GifLjCuvGP787BlT1/u5FTEG2LlNaD4oKCxqWgb1CrUTEV7OHXZCqpFRSAvcATcZ3+XhI1pwfH+eUT/lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7198
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogTW9uZGF5LCBKYW51YXJ5IDE2LCAyMDIzIDU6MTMg
UE0NCj5UbzogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5AaW50ZWwuY29tPjsgWXVuamll
IEd1DQo+PHl1bmppZS5ndTFAZ21haWwuY29tPjsgeGVub21haUBsaXN0cy5saW51eC5kZXYNCj5T
dWJqZWN0OiBSZTogd2hpbGUgbG9vcCBpbiBhIG11bHRpLWNvcmUgY3B1DQo+DQo+T24gMTYuMDEu
MjMgMTA6MTAsIEphbiBLaXN6a2Egd3JvdGU6DQo+PiBPbiAxNi4wMS4yMyAwNjo1MywgQ2hlbiwg
SG9uZ3poYW4gd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPj4+PiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPj4+PiBT
ZW50OiBNb25kYXksIEphbnVhcnkgMTYsIDIwMjMgMToxNyBQTQ0KPj4+PiBUbzogQ2hlbiwgSG9u
Z3poYW4gPGhvbmd6aGFuLmNoZW5AaW50ZWwuY29tPjsgWXVuamllIEd1DQo+Pj4+IDx5dW5qaWUu
Z3UxQGdtYWlsLmNvbT47IHhlbm9tYWlAbGlzdHMubGludXguZGV2DQo+Pj4+IFN1YmplY3Q6IFJl
OiB3aGlsZSBsb29wIGluIGEgbXVsdGktY29yZSBjcHUNCj4+Pj4NCj4+Pj4gT24gMTYuMDEuMjMg
MDQ6MDUsIENoZW4sIEhvbmd6aGFuIHdyb3RlOg0KPj4+Pj4NCj4+Pj4+DQo+Pj4+Pj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4+PiBGcm9tOiBZdW5qaWUgR3UgPHl1bmppZS5ndTFA
Z21haWwuY29tPg0KPj4+Pj4+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAxNiwgMjAyMyAxMjowOCBB
TQ0KPj4+Pj4+IFRvOiB4ZW5vbWFpQGxpc3RzLmxpbnV4LmRldg0KPj4+Pj4+IFN1YmplY3Q6IHdo
aWxlIGxvb3AgaW4gYSBtdWx0aS1jb3JlIGNwdQ0KPj4+Pj4+DQo+Pj4+Pj4gSGkgR3V5cywNCj4+
Pj4+Pg0KPj4+Pj4+IFdlIGFyZSB0cnlpbmcgdG8gZGV2ZWxvcCBhIHBvbGxpbmcgbW9kZSB0aHJl
YWQgdG8gc2tpcCB0aGUgZGVsYXkgb2YNCj4+Pj4+PiB0aGUgaW50ZXJydXB0IHJlc3BvbnNlLiBU
aGlzIGlzIGRvbmUgYnkgYSB3aGlsZSBsb29wIHRvIGNoZWNrIHRoZQ0KPj4+Pj4+IGhhcmR3YXJl
IChzYXkgYSBncGlvIG9yIGEgdGltZXIpIGNvbnRpbnVvdXNseS4gV2hlbiB3ZSBkaWQgdGhpcyB3
ZQ0KPj4+Pj4+IGZvdW5kIHRoYXQgdGhlIHN5c3RlbSB3YXMgZnJvemVuLCBtZWFuaW5nIHRoYXQg
dGhlIG90aGVyIGNvcmVzIGFyZSBub3QNCj4+Pj4+PiBmdW5jdGlvbmluZyB3aGVuIHdlIHJ1biBh
IHBvbGxpbmcgbG9vcCBvbiBhIHNpbmdsZSBjb3JlLiBCdXQgaWYgd2UgZG8NCj4+Pj4+PiB0aGUg
c2FtZSBpbiBhIG5vcm1hbCBMaW51eCB0aHJlYWQsIHRoZSBzeXN0ZW0gaXMgbm90IGZyb3plbi4g
SSdtIGp1c3QNCj4+Pj4+PiB3b25kZXJpbmcgaWYgcG9sbGluZyBtb2RlIGlzIGFsbG93ZWQgZm9y
IHhlbm9tYWksIG9yIGlmIHdlIGRpZA0KPj4+Pj4NCj4+Pj4+IFhlbm9tYWkgdGhyZWFkcyBzaG91
bGQgbm90IGRvbWluYXRlIGNwdSB0b28gbXVjaCB0aW1lIGluIGR1YWwga2VybmVsDQo+Pj4+IGNv
bmZpZ3VyYXRpb24uDQo+Pj4+PiBXaGVuIHhlbm9tYWkgd2FzIGRvbWluYXRpbmcgY3B1IHRvbyBs
b25nIHRpbWUsIGZyb20gTGludXggJ3MgdmlldywNCj5jcHUgaXMNCj4+Pj4gbGlrZSBkZWFkDQo+
Pj4+PiBhbmQgTGludXggY2FuIG5vdCBoYW5kbGUgaXQgY29ycmVjdGx5IGluIHN1Y2ggY2FzZS4g
IElmIHlvdSBlbmFibGUNCj4+Pj4gQ09ORklHX1hFTk9fT1BUX1dBVENIRE9HLA0KPj4+Pj4gaXQg
bWF5IG5vdGlmeSBzeXN0ZW0gdG8gYXZvaWQgc3VjaCB0aGluZyBmcm9tIGRlYnVnIHBvaW50Lg0K
Pj4+Pg0KPj4+PiBUaGVvcmV0aWNhbGx5LCBhIHN0YWJsZSBOT0haLWZ1bGwgc2V0dXAgc2hvdWxk
IGJlIGFibGUgdG8gdG9sZXJhdGUgb24NCj4+Pj4gdG9wIGEgWGVub21haS1vbmx5IHNjaGVkdWxl
IHdpdGggZnVsbCBDUFUgZG9taW5hdGlvbi4gSG93ZXZlciwNCj5hY2hpZXZpbmcNCj4+Pj4gdGhh
dCB1bmRlciBMaW51eCBpcyBhbHJlYWR5IG5vdCB0cml2aWFsLCBhbmQgSSBoYXZlbid0IHRlc3Rl
ZCBpZiBMaW51eA0KPj4+PiBpcyBhY3R1YWxseSBlbnRlcmluZyB0aGUgcmlnaHQgc3RhdGUgd2hl
biBvdXQtb2YtYmFuZCBEb3ZldGFpbC9YZW5vbWFpDQo+Pj4+IHRha2VzIG92ZXIuDQo+Pj4NCj4+
PiBXaGF0IGRvIHlvdSBtZWFucyBhYm91dCBOT0haLWZ1bGwgc2V0dXA/IElzIGl0IGp1c3QgcmVs
YXRlZCB0bw0KPmNvbmZpZ3VyYXRpb24gb3IgY29tbWFuZHMgcGFzc2VkIGZvciBsaW51eD8NCj4+
PiBJcyBpdCBwb3NzaWJsZSB0byBmaXggc3VjaCBpc3N1ZSB0aGF0IHdlIGRvIG5vdCBuZWVkIHRv
IG1vZGlmeSBMaW51eCBrZXJuZWw/DQo+Pj4NCj4+DQo+PiBJJ20gcmVmZXJyaW5nIHRvDQo+PiBo
dHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC90aW1lcnMvbm9faHouaHRtbCNv
bWl0LQ0KPnNjaGVkdWxpbmctY2xvY2stdGlja3MtZm9yLWlkbGUtY3B1cw0KPj4NCj4NCj5BY3R1
YWxseToNCj5odHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC90aW1lcnMvbm9f
aHouaHRtbCNvbWl0LXNjaGVkdWxpbmctDQo+Y2xvY2stdGlja3MtZm9yLWNwdXMtd2l0aC1vbmx5
LW9uZS1ydW5uYWJsZS10YXNrDQoNClRoZSBsYXN0IHBhcmFncmFwaCBvZiBrbm93biBpc3N1ZXMg
aW4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvdGltZXJzL25vX2h6Lmh0
bWwjb21pdC1zY2hlZHVsaW5nLQ0KY2xvY2stdGlja3MtZm9yLWNwdXMtd2l0aC1vbmx5LW9uZS1y
dW5uYWJsZS10YXNrLCBpdCBtZW50aW9uZWQgdGhhdCB0aGVyZSBpcyBzdGlsbCB0aGUgbmVlZHMg
d2hpY2ggDQphcmUgYXJlIGN1cnJlbnRseSBhY2NvbW1vZGF0ZWQgYnkgc2NoZWR1bGluZy1jbG9j
ayB0aWNrIGV2ZXJ5IHNlY29uZCBvciBzbyBpbmNsdWRpbmcgY2FsY3VsYXRpbmcgQ1BVIGxvYWQs
IG1haW50YWluaW5nIHNjaGVkIGF2ZXJhZ2UsIGNvbXB1dGluZyBDRlMgZW50aXR5IHZydW50aW1l
LCBjb21wdXRpbmcgYXZlbnJ1biwgYW5kIGNhcnJ5aW5nIG91dCBsb2FkIGJhbGFuY2luZy4NCklm
IHdlIGNhbiBub3QgbWVldCB0aGVzZSBuZWVkcyAsIG1heSBpdCBjYXVzZSBvdGhlciBzeXN0ZW0g
aXNzdWU/DQpJbiBkcGRrLCB3ZSBtYXkgYWxzbyBuZWVkIDEwMCUgZG9taW5hdGluZyBjcHUgaW4g
UE1EIG1vZGUsIGl0IGlzIHdvcnRoIGdpdmluZyBpdCBhIHRyeS4NCg0KUmVnYXJkcw0KDQpIb25n
emhhbiBDaGVuDQoNCg0KDQo+PiBJZiBhbGwgd29ya3Mgd2VsbCBpbiBzdWNoIGEgc2V0dXAsIGEg
c2luZ2xlKCEpIExpbnV4IHVzZXJzcGFjZSB0YXNrIGNhbg0KPj4gcnVuIGF0IDEwMCUgd2l0aG91
dCBiZWluZyBpbnRlcnJ1cHRlZCBieSBhbnkgdGltZXJzIGFuZCBvdGhlciBiYWNrZ3JvdW5kDQo+
PiBhY3Rpdml0eS4gRGlmZmVyZW5jZSB0byBYZW5vbWFpOiBJZiBMaW51eCBmaW5kcyBvdXQgdGhh
dCB0aGUgcHJvbWlzZSB0bw0KPj4gdGhhdCB0YXNrIGNhbm5vdCBiZSBmdWxmaWxsZWQsIGl0IHNp
bXBseSBpbnRlcnJ1cHRzIGl0LiBCdXQgaWYgdGhhdA0KPj4gc2hvdWxkIGhhcHBlbiB0byBhIFhl
bm9tYWkgdGFzaywgTGludXggY2FuJ3QgZXhwcmVzcyB0aGF0LCBhbmQgd2Ugd291bGQNCj4+IGJl
IGJhY2sgdG8gYSBkZWFkbG9jayBzaXR1YXRpb24uDQo+Pg0KPj4gSmFuDQo+Pg0KPg0KPi0tDQo+
U2llbWVucyBBRywgVGVjaG5vbG9neQ0KPkNvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4
DQoNCg==
