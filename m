Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46B21118
	for <xenomai@lists.linux.dev>; Wed, 22 Mar 2023 01:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679448248; x=1710984248;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=/5BDyg4aT4wNQd2Cpew4v6QAmxIhNcD8aKCypB+QfP0=;
  b=aWaHdfWiO1NJkKNaFuRh27/mCZjMGzKU9IoR4u1gTe5iKb0CtuSjM8Nj
   UScx20olOwEr+xt6v4VB9Qyaytm6k6KYHyk0WTPre+mBTxH/YZYro8Pwm
   VrRTSbiiuGn1CjdsKvkP8sZZINwfWoasT3+UGgeN4WNL8QQEY0Rd+yRNs
   XA7e/Z2va5MaGNG3u6j+T5lQM47Q7eEGMFGVfDhmGqspyEryXnu90xEx9
   le9Pn6Z6mG+SXpMM995BWHkpzsWRV8AHynmlRUysoqz9DDJV/8/MU2SWq
   SqYlepI26On4DrQqf6MQA9gZhUMAEBTkgkcaf4GmnfQa3qQ7IP4zNdH3/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="337825557"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="337825557"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 18:23:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="855933907"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="855933907"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 21 Mar 2023 18:23:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 18:23:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 21 Mar 2023 18:23:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 21 Mar 2023 18:23:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2NGKU6xOUOX1KQWEcdVi+UMSi6xtU6bzxf+O7tArBZrJWRA3T8wy7LNxpssBwPbhkmpnGM9aniIeCneLLqTL8VKrpuZenUepA/QWU4mvzga7PbkcxPtVoCKbnf3PGoQf4MQNZZuhgTC2kLTSypWKInPvM53pBWmfbAC56T2y5ZqjCShGNVoMKN4fmsX2ksp5ZstWEI0Pwk2rrSNqIsXJYvL2XgV1Ek7hKRtVNQW/KXiohXqVZvBkkj6O0+jyszeazPYiXU7EruuSGKPshBOdbieMiNng5u7L6IApaE9fKbAV7292BSTqaTdg26dMHlpc4MsLKBdoy4arZCQjQKoKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5BDyg4aT4wNQd2Cpew4v6QAmxIhNcD8aKCypB+QfP0=;
 b=aiHHGsw2kCu30y7466mEBLsHzMjDwWKfKPlaugj0nnBniSM7kHOJX6SM7lcKsBTTt2TFHDK4/vxvnBn6eGnvoIX61albdaMe8uR0+SvhaoDR/BppWq5ivlqT5Xp3Kg/nD/3KJN0PAW0V8TauEAM2JMEptohCG2hbE36FEp/r8hVwv+xqy90nFPsy5vfa+dKHD94yvg+5QyYyxFpNzF3IM2zQRwDLz7lpk1NzZEDrElLSraiUoQ4lNsE4hl0PijabvJKJAEZ/dubfo+BWn1ednPez7YmkVAMPOBbk5DNjMUf9fnQBqWJTQcfmq5YBskTA2PHedtOsDyuoEWYZ/eprDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by IA1PR11MB7812.namprd11.prod.outlook.com (2603:10b6:208:3f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 01:23:43 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::e1b2:52d4:e80c:dfac]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::e1b2:52d4:e80c:dfac%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 01:23:43 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Mar 22, 2023, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Mar 22, 2023,
 UTC 7:00 AM
Thread-Index: AdlcXO7zYPeI6t6KQaarNu5kDG5YmA==
Date: Wed, 22 Mar 2023 01:23:43 +0000
Message-ID: <MN2PR11MB4285B44E15C3A0056C74ED61F2869@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|IA1PR11MB7812:EE_
x-ms-office365-filtering-correlation-id: 39d30b26-e11d-40c2-0a4f-08db2a74136a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h3yau5NoRthTlZeV05CaS0YxGWrzDfsmJafHOb7rd5nVCKeulA60UFj+jbHQcNkcXDzsNNVGC+tq3Fdod06UtUHGrktAzuJFa6v3PRN01rGvobmOGpQBo+ACi2EZNu7BX4YrVbWmHjf8/4PSTrpMpgA+MXhVX+SoM62d781wabisrr78H4NtJtR4OjtBUs4hdnQMMSuqSnokkBcg+zTHMnHi+VOo26B0Kfl2LofMUEiY50wGE255p/BLa8hCskcLpyxDStbNU5Cnb+zCeTgJcVTRL6b6c2UA8qpeVVcmGMQW2rjVKW8JCttJib0KeA3ovVrtt204AF/TLNC8ekHMu8ScmMBF9k9mUbjHYs/2exQugroEonqZcPXIlOO4SQ2klQvkQC70PwCC577wKguiojv3LuVSMgMkpV96VrAKgH8kRGmDoL3aYshvKSvaQ3/pHTahKyg8EWkpCVYe5VTKwlf8McM1evUmG+nPlR12JCYLEsooSvd7sy9CJMUClct2kHpDTIqKnHZTHogId5AtXt+cPcbzmxopCg4KjXvbfU/iTrZgFkWsR04xum2A7KoT5RlrwlGFOZS38QUzsOOmUYxUKChQWZhgRrGI+yaesNNlUDfAJP5CY14pK255sMdGWkwXm1roqnoImfHI4Nh4WEXhTcsAY9uTM7gsTZ5wWR+AdUcC15ZajV0BWcqV5TZgXIbav7l7lK9UxX4JiwwL1ssN9tVbkUVspdI0ePSeQAU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199018)(316002)(478600001)(38070700005)(71200400001)(6506007)(26005)(7696005)(9686003)(76116006)(8676002)(6916009)(66556008)(66446008)(64756008)(66476007)(66946007)(966005)(83380400001)(122000001)(2906002)(82960400001)(86362001)(41300700001)(186003)(38100700002)(55016003)(5660300002)(33656002)(40140700001)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGxrVlhKRzVUUDBDcHhNbkxCdVhZek90WE1JbVJSYnNQTHF1ZDd5WllOZFVv?=
 =?utf-8?B?OXZFWm1oQXBGR3dwTzJyOE1NSjJsZ1FoVnlBTUZ5NXhIZzUrQ3FYVE1CdWx2?=
 =?utf-8?B?dEwwZngreXlRYlFRUlp1amgvZnR0aVhFa0pJd0dFZ0k5dXBsd2dNUnlaUmJI?=
 =?utf-8?B?MWs1dUk4cEJ4YVcvVVNCNEhJVEQ2QWlQRGxCTXBTMWpXSmdNeGowK3M3K3ps?=
 =?utf-8?B?OHh4bDhkSCtXenpxeGJPQjJNSXRrTW1jYlU4VWQ0a1o2UnY5NXI5WHBDdUF6?=
 =?utf-8?B?djNyVTRKQ2JxaGh0V0pNME8yRW0wVCtDVXh3VXBqZ1R3K3lwc3czVjU4cU9J?=
 =?utf-8?B?bTNiL1BoTVBtOGtpaVlHZVZPRnl2cS82cnVJelBxa2x3OXpXZGt4T2l3RHJ5?=
 =?utf-8?B?WXlqSFQ1WFB0b0VwUUR4RmlnZjJLY0JMUkRHZGpWQUVKVWd4TFhLSTZydlFh?=
 =?utf-8?B?aHpMOWt5L3E5QjM5U2NCRWVtd2dYVWFNcVNReEtLc24rRUJPMzQ0S2VvS2xR?=
 =?utf-8?B?TCtrUlozRUhxR3M1ZVhkTnVxMFVTa21oVVMzVzBFOGViYmk1M0U5SVZ6NDUr?=
 =?utf-8?B?Wjh5bThqR1l2RGE0VkkvN3Myb1F5T05ra25NYnF5Yk5SbXd0bWEyeWo2d1BB?=
 =?utf-8?B?NmtmeEZsU05QQ1VSQ1g0REZMbWJjaXhxSlNTK0lNNTBTNXQydWJzSCtWTk1M?=
 =?utf-8?B?RzAvY1k4UUkwZ1F3Y3ZwblVoOEdEWDliZ2tBUWpXMG00VkE0QXJoUWt6Yytw?=
 =?utf-8?B?bTNYQlpjUStwM2MrU055MGpPcGh1Sm1MY2JzaHdna1Z0MGxUcjZ5UHIyY00w?=
 =?utf-8?B?QWtHZXVCNU5aWCtON0svQ0ttZHJjQkpKd2srM3E1bmFGaU1KcGczUTJwbzIv?=
 =?utf-8?B?Q1gzdkZvQi8rRElURFVBdmIxZ1E1YlZoMjBTcjg3OWxtWUZRalpSaWxrVHQ2?=
 =?utf-8?B?Z1l0MG9uWWV4WGZWRHNUcU1PdVpnV1JlekI5SU9oeFNyNFUxZkFCWDNmc3ds?=
 =?utf-8?B?R0QzM1REcjFtZWl4QlNjdUJ3eUM5WDhremsyazBMMFZqTytRYjNncHFWV3Vm?=
 =?utf-8?B?Z2hRUmExVzhVTkQ2VTVLWFZwYmgzZVpabmhpUUNaenZKOUYwSXhkd3lVQW43?=
 =?utf-8?B?Ulo3YkNUMHB0aUJadWxIS3JKNGR6ZmFhMkVXaTcvM3RWLzNUSGwwMXdRWi93?=
 =?utf-8?B?ay9iOE40RFYxTGQxSjlHMW9WU1JBSzdaWGVqeVowc1d0Qnd2c3N2QURsMk1I?=
 =?utf-8?B?NW9WUG5wS0VVaDdvOHhHNzhNVFFYcGxDV2pSNllsL1E5N3hSeStuK3NEUTM0?=
 =?utf-8?B?aFdhR29saHdhcjk3eW4xbXZVQnBlRnhPV1JadDdYV1NRK0hMS1VTK3VJMWw3?=
 =?utf-8?B?V2xUZTdUcEhyZHA2RGxEcjErcjd5MFRiT3EwUGpoZUZsZmo4Ri9vWVEzb09o?=
 =?utf-8?B?M3ZSMHc4K3ZqSk9wZTh5WGpLaTZFYzdRZVg3dnoxdjN6eTVScDRSUSt1QmVz?=
 =?utf-8?B?ZnR4dXp0Mkc5WEhkMTVhK1N1MXdxUHZ5WlFBMlArRmlpMnFscWZNOTRwRGUv?=
 =?utf-8?B?OVdnUDRUNnJ0cTgxTXBoeU5yTkZta3BLRnppYTg3c0tMRkNoL0lJL3pVazI2?=
 =?utf-8?B?S0RkZXB0K056OFZUa3JFWktnNFRFdkRRcXFPYmJQMzJ0QnJTWGk1bUZJNDQ4?=
 =?utf-8?B?Q2YrOUd4UnErUnZRY0p5K1BKQnBNZWNoSUFuNk9zcElvcGpOV3hqczIvSWRF?=
 =?utf-8?B?bjNFQ3BMZGVIOGIyK0FvNWxMUndpNVRrQmREQlgxN0xjZzhib0RYTkg0Sm9H?=
 =?utf-8?B?MStEUXFPRUJ3eTJDMGZzeG05M28vVDlJTmYrZnZ6Y25RYjRMMDcyRSsraVhU?=
 =?utf-8?B?S2RJcW55ZE5hSGt6VVFITy9YY1o3dU9vWHNqUmw0ZTB1dVA1dTFBamMzL1hN?=
 =?utf-8?B?dGZEWGVXWkVUemEvS05Ba09YK2h6dGlMTDJQa2dFZFdpemxvbWxUU25HMkha?=
 =?utf-8?B?Y3dQUkdpZ3V1SUdjNVFWSGozSjJXeCtuc0gyeU1LMzR4cHFrUE8wVThNZXl5?=
 =?utf-8?B?QndoU2NCMVhIUFNyaDlPWkt3emNYNHROSDRLcEduT3lKVENKZDRISEtIOEFm?=
 =?utf-8?Q?gxSJqqBZ8Ijvv3c2gUvGUGa3f?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d30b26-e11d-40c2-0a4f-08db2a74136a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 01:23:43.3190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V155SmFn+yi8GwldXTkZKsL48qu29eAVaswtqULp0glxe4G5Php7oVrVEkhuDXiqcr4aru7LBn5vA65sRibYfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7812
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgTWFyIDIyLCAyMDIzLCBVVEMgNzowMCBBTQ0K
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
