Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13247E1
	for <xenomai@lists.linux.dev>; Wed, 31 Aug 2022 08:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661934299; x=1693470299;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ZMSX8QZZsxXUZnfFZVlCN6wRrTMnbl09HhRXH6Lr5gs=;
  b=CgGvK87+tkFub2Bwc02ZbnRolQ56B8YRHZc5Tzn9bEmKwioL2TcFlbfi
   6j1XqSrQaCN508WSKE4GzHDNJgwMyGrdGKdwOFY9zzaULsd/24vRyIJ6K
   KaBePUXHTe3xw+tVg7aGnkqujxX1zGBEKf9J4RTXKwzsXPbVoAS+9UfQL
   YZpyWuv0vUF+1lkawub6Zy9cLd+0hXDOsEco7oNIBvpXwawyk5XlUxCbZ
   IV/mZpg5wHQzkbC66QLsPxOBMFDXS2dFx7b3b8CIC10n2+w1+YT5CcGMD
   OqWtQ3Tni7pGefHdF7iJ0b4r53wsoS31xZVgvwbmKO+zKDLkNP9Eo+QOb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="275804581"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="275804581"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 01:24:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="940360269"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 31 Aug 2022 01:24:59 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 01:24:59 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 01:24:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 31 Aug 2022 01:24:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 31 Aug 2022 01:24:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3R5hPbAOu+NUQqa7zRGc0UpQG7qNP5MOStvo6FP0v8ZE5PiiYZFSRg/2u1smDamQl4MXMCabdhGvzlme9C1I0r4wmAs7ovtG23R9l5ByT7EDe7UDHK+gihdZAwmKziBzdRAcY5CpbSDUeeibXRGsUku1jIAGblTxr3xhpE2OhVN1Q4m4E0m6HEd19OF0rpsGY8KTtc9mSKo9l4p/tFiS8iGhjSIx+WLhIkf07xVuHMnl6RiutyKAI9IVa1tCradawpb1tUHoZzDQDltFMkiYsp20JDyRMLc6tGyloIJ+9xU931SSZXAuZQu+Pgcxc9f+QvTDq35StAZYHhR1tdYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMSX8QZZsxXUZnfFZVlCN6wRrTMnbl09HhRXH6Lr5gs=;
 b=InXrbiYxibAIqv90yn6SymPrv7sjwKS6Mzai2Fs/HTkrsdmRqPUh5PK0pJt7mrVbqaRwj5QxBdvTqoSTOjnUdoq6uAaJt2wrtI+1GWfdYTXST0tUAMymkqCF1fbQQYe2k3vFcSN/AB5+Ir3vaJ1VFhDnAnbWi8la6bYJo8EUyAPmKTFq+chImtn+ieY/Du5/yC+6YeqQ7d8E8jpwss4HwJxGP+OPC7pE3LWDJUCeU1+4lHYV/P8lH5RLhCQ25Cmtv4mlk1ALaaxV5R/544tPixVcXpl8g1uXC+ZTVNCPQDerllG1HQnte3q3zc1pAdELvF15o9jPotj3zJ3/hViYaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by BN6PR11MB0004.namprd11.prod.outlook.com (2603:10b6:405:68::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 08:24:56 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83%3]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 08:24:55 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Jan Kiszka <jan.kiszka@web.de>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: [PATCH 0/1] net/drivers: igc: introduce rt_igc driver
Thread-Topic: [PATCH 0/1] net/drivers: igc: introduce rt_igc driver
Thread-Index: AQHYtcgZgq7mtu1cZ0KhlErBpHBIpK3BZbQAgAc9FiA=
Date: Wed, 31 Aug 2022 08:24:55 +0000
Message-ID: <MN2PR11MB4285D85CEB6935A1CC30EE64F2789@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <20220822011821.21283-1-hongzhan.chen@intel.com>
 <ad5ac2e9-e662-ee94-94fa-c7d42b6e4b68@web.de>
In-Reply-To: <ad5ac2e9-e662-ee94-94fa-c7d42b6e4b68@web.de>
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
x-ms-office365-filtering-correlation-id: 44f25eba-5dd0-42b3-99d9-08da8b2a4935
x-ms-traffictypediagnostic: BN6PR11MB0004:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BHrP45bSYPP6xDD/C5tYP7HAsGSN6CUf4XN8//OUt0fEeeZjkKC1PmYb275iBcf2LFtDH6W9SRyPs+20g+jN+WKmWVedLih/1JFRolEjkEL/35z5BOSWGw6I/7f65bsH7X7P+JBuczddMxYGfiecIoWHsysEcWO0q3hxFHaHtfM5iNAt3DRE3cs91P46JMqsqrDYO/NVtI1HkBX2tFkuincs8OTsBvWbX+3kUloFkDdO1iDdElCErKY4Y0d30JOiPBarlUzHPwl9obQhHrK67By3vBJkGnb/Ol2CLI2rYxzHNvW+ZLC6MCoO1VHfBgwJmaNhDQoV4mMGRhxsEzPlI8NEx9gBJCzy+gmer04e6+EWHe576bMRWskJVFOO8s6qjdqCUjfoTaEjzakp8/XqPckPPtCZihNFYF2yLJIymITQfv+UAiA0OM8bExFidI6ImGk7htB/JYbkWv8B2HhrX7a3Oe+UbcByT39zFk4sNHe2EtLnOWSbwsXuc1phXMV5eAMABg2Sf/ScElLLL1gwhjmTUCSHnWx89KBXP1fpEkql/wmB8XUFSPCUdUPNjGlIMrOFzuHM0cLu3dM5p8O67JM/Se5OZBg+DwTtz4owsr2qMGzwVOBLBjcAbNUyPdZrXJo3wLQhg0Ici6jhNOedk9YyY0reNDVeAY2okhyGYcL9e/ow4WBslcD9HKmBvlgfArsBmvF1ufxTUhDxBDli5fv7NcJvlfsSfM+xgJEkCSX5aOc4BQipX/BLGz0oexJrv35WLIQlSlA+UCLWmQQwhhvKYfBsB/mYoZgbEGH2hqNznGGjkmIw4pCc+dapO7OR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(136003)(346002)(366004)(76116006)(66946007)(66476007)(8676002)(66446008)(66556008)(64756008)(38100700002)(122000001)(38070700005)(82960400001)(86362001)(2906002)(52536014)(8936002)(7696005)(6506007)(5660300002)(9686003)(26005)(41300700001)(55016003)(478600001)(71200400001)(316002)(186003)(83380400001)(110136005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXVlc3hCL1E4ZHk4OC9FYnJud1ZORHo4TFpJSmNZT3lTRmtKMzRkdmNHa1pj?=
 =?utf-8?B?S0tjS3NMcnRmcVFyY2llQ2NGcC85OWZZOHNXTUQ2ejAzVGpFR05FblVHVUJt?=
 =?utf-8?B?V2xKT3RrWUFDU2c0bUgreEpVbFQ4Qy9DdDUyck8zT3NwNlRVSGRTaDNDZ1NQ?=
 =?utf-8?B?SmVtSmxYWVJtSW1nOVhKMG95elNjTFN5ZkFZK3lzcktDcWVQeUJ6aEhYNU0w?=
 =?utf-8?B?MVhkUVp1R3JjTE1zRkNMNlVLK1F2MC9hSkowcDl1RHFxSVpWdGt3dGc5TE1y?=
 =?utf-8?B?YlN6dURXZkY1bXhYd3FKYk1qMEJyUTBiaUd5bTNkK1BqV0NxOFk0ejduaXRx?=
 =?utf-8?B?SWxkWmJGWnJFK2oyTUJIbEhENTZNRGRob2xjT1FwMy9KWndoWDVrSGl4cEdv?=
 =?utf-8?B?OGt1dWdXNEJnbUd6dE5TUU1Wd3c0WVhQYzEzRzJDbEhrR3NaamZzK1BCdlpP?=
 =?utf-8?B?UGNNSlpOQ2pZWmdoYnFxdUlaQWdYK2U1NFJOU1plTVdNenZCbkpIK1FjUWVU?=
 =?utf-8?B?K2Nia1phbHgxd3ArNWFUbVZVK1hocTdBMzJmeFNibTVUZ3ZyRE9BWVdTZnNi?=
 =?utf-8?B?UlZ5ZGJhVFc5aU1wR0JYQnNZWHNZQXZnODQyeDBVOVdiam85cEpkRC9ZNHY2?=
 =?utf-8?B?MlRUZkViV1BwYWhkZXJkS1lTSWNmQXI3bk9WQWMrUExhRmoxdGJraXVqd1Vn?=
 =?utf-8?B?RGdJc0FOejN6bWdUYm9qSGovRTVHRkVUKzZVeGF5aHVOeWVGTGZHWG1Kd1hO?=
 =?utf-8?B?ZDBBL2txd3FRU3dsQnNTSHBVTUliSGlGdzkxOVM0bk1oMzk3QkdZaU0rR1Zo?=
 =?utf-8?B?QnNIdnd2OU0rQTRBNElCY1BhSnhMd3gvWVZNMWlQL2FKT1dZcmxzeFZiakFO?=
 =?utf-8?B?WldmYXdibHhFRGJVWE9mcGcvWEVvS1N4b2JuZVpuWDBBOWk2NEZubmJvb0Rs?=
 =?utf-8?B?Y092S0FnWGFwbURoV2I2TFAzSnM3MWUyNURZMjVCMzdGb0dxWktYSmJ5MEtF?=
 =?utf-8?B?SEdiNldMdHlScXJUTXV2L0lTUG42bkxRbHJBelJ5RUdYaTY5REFNYUZJU3JF?=
 =?utf-8?B?MkVVdWliY2ZtYmdMRUFGb3VSVkVTTC84cTQ5UW1CRzFNanBCRXp2WStMdHgr?=
 =?utf-8?B?bW5ldDJBZ3Q4V2ZrSnFMaDJxcGpzNzNLVTA4b08yVXQxQmZndWZMWE01Y3lH?=
 =?utf-8?B?NEd5SjBZeGh5RnlZdmE5NXgzWVdOdExHM1lVUk9oUzBwMit3cmVBaEdIZXJl?=
 =?utf-8?B?TzJ1Uy9neSszSGQxYlAyZSt2alFGSU1aWmFpa1FTOXdFek1jRUNXNkkxODdz?=
 =?utf-8?B?Ym9BVjhuemZxSUJ0Q1Vkc3VtYk93WktNRVJNc2RlYk9kNmFLQzZjYWx2Rlhk?=
 =?utf-8?B?S2JGeVhqQWFYOVR5NGJiZzZEWWVkYVliRnpRcDRiNXhBeitrcXNOb0hjc1NP?=
 =?utf-8?B?aDhoR0tHZEtmWXRCUjBSV1RINjhBYktZZVdFd3daekhCOWh4eHZuOTd5ZmFO?=
 =?utf-8?B?Nk5sNFU5YXVOeVNWaUp3NDA2bXRaaGdxOWhqUS9vYVJ5T2MybGQ4VWMvbmln?=
 =?utf-8?B?K1B3bzc5UENCWHU4WTR4bzhwWTFvVTRXUmU2OE12YnFMTi91alFoSFZYVjhZ?=
 =?utf-8?B?cmR4ZVNETXpaTTdVKzhORDFGMnIrK2V0aXlYdTNMVDd5VnE5QmthaWZMZU9j?=
 =?utf-8?B?TXNNQkJlbDhIbE9yNGlpYStscWtld0lMTmVsc0NMVmF0T0hmZTRiQ21lWjhn?=
 =?utf-8?B?ckhldzNGUDVKeTVaRmVrdTNrZ0EyN2k1K2JtbEJLVFN1cit1UlA5UG1NOG5s?=
 =?utf-8?B?cnZzaDQyWmpJZWtncHdDSk9XcFJUN1E3Rm5uZDF6aElxbHRDcEdGdk92bjdn?=
 =?utf-8?B?dTNvY2p1SEZNZThOSjE4Sm1VZ1pENWFWTml2ZCtXczZ3cTk0bE9EUCtMTkRj?=
 =?utf-8?B?bXlYbHpFRnVpSnNUSW5YWUhHVjhZMkU5REVtci9zZEhqeXp6ME5PY0d2MUY4?=
 =?utf-8?B?SnZCQUVXOXE4eitmTVl2alY5SzRnYzRZckhRWGhRR0dKcXBFYVhGeUdVMWpt?=
 =?utf-8?B?WVBPVk5XSlYrRXQrRXhMbmtSdUpxR05DN1I0TEY0dE9NTTlpS2M1OCt5UmNF?=
 =?utf-8?Q?oGcpAAw/uCqj4HiBq/v4IE8UB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f25eba-5dd0-42b3-99d9-08da8b2a4935
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 08:24:55.8858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /EmCO5D9xRRsQ7EoORDClhSuWQp4DlFmSvLK4dKpE1qmchfbMfM32eAXWblTwJ4EfshsM8UWyPuaq0vxitc0pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0004
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAd2ViLmRlPiANCj5TZW50OiBTYXR1cmRheSwgQXVndXN0IDI3LCAyMDIyIDEyOjI3IEFN
DQo+VG86IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVsLmNvbT47IHhlbm9tYWlA
bGlzdHMubGludXguZGV2DQo+U3ViamVjdDogUmU6IFtQQVRDSCAwLzFdIG5ldC9kcml2ZXJzOiBp
Z2M6IGludHJvZHVjZSBydF9pZ2MgZHJpdmVyDQo+DQo+T24gMjIuMDguMjIgMDM6MTgsIEhvbmd6
aGFuIENoZW4gd3JvdGU6DQo+PiBwb3J0ZWQgYmFzaWMgbmV0d29yayBmdW5jdGlvbnMgbm90IGlu
Y2x1ZGluZyBUU04uDQo+Pg0KPj4gMS4gcGFzc2VkIHRocmVlIG5ldHdvcmsgcmVsYXRlZCBzbW9r
ZXkgdGVzdDogVURQLCByYXcsIGRncmFtLCBCdXQNCj4+ICAgIEkgZG8gbm90IGtub3cgaWYgdGhl
c2UgdGhyZWUgdGVzdCBpcyBlbm91Z2ggdG8gdmFsaWRhdGUgdGhlDQo+PiAgICBkcml2ZXIsIHBs
ZWFzZSBsZXQgbWUga25vdyBpZiB0aGVyZSBpcyBvdGhlciB0ZXN0cyBuZWVkIHRvDQo+PiAgICBj
b3Zlci4NCj4NCj5JZiB0aG9zZSB0ZXN0cyBleGNoYW5nZWQgbW9yZSB0aGFuIGEgaGFuZC1mdWxs
IG9mIHBhY2tldHMgKHRvIG1ha2Ugc3VyZQ0KPndlIGFyZSBub3QgbGVha2luZyBidWZmZXJzLCB0
aHVzIHdpbGwgcnVuIG91dCBvZiByZXNvdXJjZXMgYWZ0ZXIgYQ0KPndoaWxlKSBhbmQgaWYgeW91
IGNoZWNrZWQgdGhhdCB0aGUgcmVwb3J0ZWQgbGF0ZW5jeSBpcyBjb21wYXJhYmxlIHRvDQoNCkkg
c2V0dXAgdHdvIGVudmlyb25lbWVudHMgdG8gZG8gcnRfaWdjIHZhbGlkYXRpb24gbGlzdGVkIGlu
IFsxXS4gSSBhbHNvIHNldHVwIFsyXSBlbnZpcm9ubWVudA0KdG8gY29tcGFyZSBwZXJmb3JtYW5j
ZSB3aXRoIGkyMTAuIEFsbCB0aHJlZSBzbW9rZXkgdGVzdHMoIFVEUCwgREdSTSwgUkFXKQ0KaGFk
IHBhc3NlZCA3MiBob3VycyBsb25nIHRpbWUgdGVzdCBpbiBbMV0uQi4gSW4gZW52aXJvbm1lbnQg
WzFdLkIsIHRoZSBsYXRlbmN5IA0KaXMgYWJvdXQgNjB1cyBiZXR0ZXIgdGhhbiAxMjAgdXMgbGF0
ZW5jeSBnb3QgaW4gWzJdIGluIFVEUCBzbW9rZXkgdGVzdC4NCg0KWzFdOg0KDQpBOiBJMjI1PC0t
LT5zd2l0Y2ggPC0tPiBJMjEwDQoNCkI6IEkyMjU8LS0tPkkyMjUNCg0KWzJdOg0KDQpDOiBJMjEw
PC0tPiBJMjEwDQoNCj5ydF9pZ2IgZS5nLiwgdGhlbiB3ZSBoYXZlIGEgZ29vZCBpbmRpY2F0aW9u
IHRoYXQgdGhlIGRyaXZlciB3b3Jrcy4gVGhlDQo+cmVzdCBpcyBmaWVsZC10ZXN0aW5nLg0KPg0K
Pj4gMi4gSW4gYWRkdGlvbiwgYW5vdGhlciB0aGluZyBJIHdhbnQgdG8gZGlzY3VzcyBoZXJlIGlz
IFRTTiBmdW5jdGlvbnMgb2YNCj4+ICAgIGkyMjUgaGFzIHRoZSB2ZXJ5IHNpbWlsaWFyIGVmZmVj
dCB3aXRoIFRETUEgbm90IG9ubHkgZnJvbSBjbG9jayBzeW5jLA0KPj4gICAgbWFzdGVyIGFuZCBz
bGF2ZSBhcmNoLCB0aW1pbmcgbWFuZ2VtZW50IGJ1dCB0aGUgZGlmZmVyZW5jZSBmb3IgVFNOIGlz
DQo+PiAgICB0aGF0IG1vc3Qgb2YgZnVjbnRpb25zIGlzIGltcGxlbWVudGVkIGJ5IGhhcmR3YXJl
LiBXZSBhcmUgY29uc2lkZXJpbmcNCj4+ICAgIGlmIGl0IGlzIGZlYXNpYmxlIHRvIGltcGxlbWVu
dCBUU04tZW5hYmxlZCBURE1BLVRTTiBkcml2ZXIgdG8gbWFrZQ0KPj4gICAgdXNlIG9mIGkyMjUg
aGFyZHdhcmUgZmVhdHVyZSBiZWNhdXNlIFRETUEgaXRzZWxmIGlzIHJlYWxseSBoZWF2eS4NCj4N
Cj5ZZWFoLCB0aW1lLXRyaWdnZXJlZCBzZW5kIGlzIGJhc2ljYWxseSB3aGF0IFJUbWFjL1RETUEg
aW50cm9kdWNlZCB2aWENCj5zb2Z0d2FyZSBhbG1vc3QgdHdvIGRlY2FkZXMgYWdvLiBJJ20gbm90
IHN1cmUsIHRob3VnaCwgaWYgd2Ugc2hvdWxkIG1hcA0KPnRoZSBjb25maWd1cmF0aW9uIG9mIFRT
TiBjYXBhYmlsaXRpZXMgb2YgbW9kZXJuIGhhcmR3YXJlIG9uIGludGVyZmFjZXMNCj4oUlRtYWMg
JiBDby4pIHRoYXQgd2VyZSBkZXNpZ25lZCB0aGF0IGxvbmcgYWdvLiBJZiBpdCBoYXBwZW5zIHRv
IHdvcmsNCj5vdXIgZWFzaWx5LCBpdCdzIGEgbmljZSBleHBlcmltZW50LCBidXQgd2Ugd291bGQg
bGlrZWx5IG1pc3Mgb3RoZXINCj50aGluZ3MgKFFidiB0cmFuc21pc3Npb24gd2luZG93cyBlLmcu
KS4gQW5kIHRoZXJlIGlzIGFsc28gdGhlIHF1ZXN0aW9uDQo+aG93IHRvIHNldCB1cCBhbiBvcGVy
YXRlIFBUUCBhc2lkZSBSVG5ldC4gIA0KDQpZZXMsIFBUUCB3b3VsZCBiZSBhIGhhcmQgdG9waWMu
DQpJbiBhZGRpdGlvbiwgdGhlIFRTTiByZWZlcmVuY2UgYXBwbGljYXRpb24gSSByZWZlciB0byAg
d291bGQgdXNlIHNvY2tldCBvcHRpb24gZm9yIGV4YW1wbGUNCiBTT19USU1TU1RBTVBJTkcgYnV0
IHJ0bmV0ICBkb2VzIG5vdCBzdXBwb3J0LiBJdCBhbHNvIHVzZSB2bGFuIHRvIGRpZmZlcmVudGlh
dGUgcHJpb3JpdHkgDQpmb3IgZGlmZmVyZW50IHN0ZWFtcyBidXQgcnRuZXQgZG9lcyBub3Qgc3Vw
cG9ydCB2bGFuLg0KVFNOIG1heSBtYWtlIHVzZSBvZiB0d28gbW9yZSBOSUMgcXVldWVzIHRvIGRp
c3BhdGNoIHBhY2tldHMgdG8gZ3VhcmFudGVlIGRldGVybWluaXN0aWMNCmZvciBoaWdoZXIgcHJp
b3JpdHkgcGFja2V0IGJ1dCBydG5ldCBkbyBub3QgaGF2ZSBzY2hlbWUgdG8gZG8gcmVsYXRlZCBt
YXBwaW5nIG9yIHNjaGVkdWxlciB0byANCnR3byBtb3JlIHF1ZXVlcy4uLiANCg0KUmVnYXJkcw0K
DQpIb25nemhhbiBDaGVuDQo+DQo+SmFuDQo+DQo+DQo+DQo+DQo+DQo+DQo=
