Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02429642
	for <xenomai@lists.linux.dev>; Wed, 15 Nov 2023 04:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0ssCOoD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700023220; x=1731559220;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=VDxAHG16uPJoodHPeImungcw0WfZfewFCaJ4Lzn+p8A=;
  b=B0ssCOoD0yhn1nYf2Wfgd3bYE4zXPFGbo62A+QfRReWeJBeearQ2zPuO
   ngmuoZQSGmds2zwt+CUPD5BBZPPISK1czdLL8mkp5srHeDtnkTe9Df/e0
   QczY0qYCHOMDueUjnhys6DpuRTO4Nw3apAm6vIEAuUXq92O5MOiImK5zq
   WMOdlqyh+bEthkH8zw7+YqTTohOjpSIKoWPgFMAd/nP1gB/4zRYOpLQa2
   BQz9uYzJ8eR/BhzqSyFnna0DbAO+H7QxscPFXueEBU/Ixa14OFHSa8Itu
   xXuQ3OPRcCtTKMN+9XSJjb8dCM8zsFCwUd2E708tEfuId+aO1RzqgVfjF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="375845610"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="375845610"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 20:40:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="835286258"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="835286258"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 20:40:19 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 20:40:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 20:40:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 20:40:18 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 20:40:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoi8AvG7nCBXWoaNWtV3FE3auj0ANUBV5F8yGrrNn4Lwhkpd/LCMZtNn4lZW0BlK9b+eD7NzMYW881jcu21oxhB9ppApJjIdwBidFKt3z6rPmgmVA8gHjne+UO4TC3SvxTdGGnHPakxmNKCnehgw96inGo3/6ZrJu/ryfzJ3+Rbu0aPUIUTfIEt/rPqxRJmswfjWyhOcX9xOvhFTl2adOM6sE5GTJlCNvIgPQDvt8wOHNspndEvov+mCOemNkE8lJZYBLsPzx64xqxsm7Kzo5HgPZU0UDKLzDvlr9vTeCbEkTGE72YPiCa7I5smSKxMLe8QrRvbfV+zcasz1quLQwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDxAHG16uPJoodHPeImungcw0WfZfewFCaJ4Lzn+p8A=;
 b=aDRiv2sLgyz7sQ+t0DCeI/Ox5c3/G26Wu+5w9RAfAGtA+JaR334K9dBq3zHCmCsSFX4pH+73TZuGo+Z+yFr7bnb2SZwhPzJD4A3SJUxN2+1alBiSZveX96HNeYg+39m++FVICPATzq2fMAl2UnyToDgwy594nMcJr+CXn9+Zl+/pJuIfp9DRrBqulnAb81hh1ErxfFIZYqBqOvmbktu8H4h0d0pNgst5BAH8QOP5a9MrCbhkyKxfDjb9xO0yikhXsR7njh1J1vdYl6n/zCBJEUN9ajIRBbYeNy4ajK1qv8KLY92Mqu/Q9QgemFCFNzNAr4XolXWwJpP4rDPUUEa15g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by CH3PR11MB8708.namprd11.prod.outlook.com (2603:10b6:610:1be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 04:40:16 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7b71:c300:be05:d512]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7b71:c300:be05:d512%6]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 04:40:16 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Nov 15, 2023, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Nov 15, 2023,
 UTC 7:00 AM
Thread-Index: AdoXfdMxlPiiCLkjQO+Wqeqs4xbTxw==
Date: Wed, 15 Nov 2023 04:40:16 +0000
Message-ID: <MN2PR11MB42859780ADF9D03E67D25BB9F2B1A@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|CH3PR11MB8708:EE_
x-ms-office365-filtering-correlation-id: 0155cabf-d278-4d8b-8430-08dbe594f6d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mmvf2rXxfp2ayp24li2Dq8KwGX7QVKgvXeaNAe9fxp/HWHlFsQ3fHQ2t1IVrz9cyjpagxcMST/aNaYxzBeMAHdopI4/JTsvjh+BiDKiwX2XfyCt3TG4cIr7tRa4ll+ASDnn+OVC7EP54bBZ3bfeCTG9akzYTpjK4VuQP04p2Z9sgLKoUiN7q62l8ID1UiBll9H8YjL8AI1O/P5W0jeAKBM2Mcu9OzW81RWCnLHZbY3ZlQ/F5b2kfOzbJET1rNPF8ycWTiNjuhZPFNJmpbvliQw+CoDW2zoYMyI/oBcygzt8mABAOKnhiOzAqH/I7O5H3C/sTPyQal/kkInb+7VJJNqahZKjWO/N+jyRJUk+DrJJ7FxOeZFdRBY/7TxPpq31eVOEb50pBAn7vGi1R7CYeJL8RIxG1eYg4rOeRAC+sIgcTIb4HVemazygWQzcMUWLxGtL9qA2OqBsRhMR43nvIPQ/sk44JmzoBH7z9WRkCDOcOwf7pb1hoBrWwXT1vdTG+96+ayz8F8eXKwCFtLboSpe2JUGAgJxJ4NrqZw0OXtu/80yrmaVVpX5tUt2L+30qq2Px8FapL2BmUHbzskG4YqRYChjYp5WqSHyY+T5jj6lTZU9nqTvSVYHanoDS0WsHqL7HnHmFMsl4Y2fY2VYLh0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(5660300002)(41300700001)(38100700002)(64756008)(33656002)(66946007)(71200400001)(66556008)(40140700001)(86362001)(82960400001)(6916009)(9686003)(122000001)(26005)(76116006)(478600001)(6506007)(7696005)(83380400001)(52536014)(966005)(38070700009)(8676002)(316002)(8936002)(66476007)(55016003)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWxBSkdSMmFBQ1o1NWVaUjFFdm8xRCt6NlRaRWJNOWtDem9rTXIvT2xOMzA5?=
 =?utf-8?B?cFJuK2UvYjkyZjZjOWRtZEJuRTBFeTIrcUlLWVltY2tmbERqeEZ0VWxtUXZK?=
 =?utf-8?B?M0taY2ZaeXcrM2JleVhvT1ptb0Y3OWk0RGI0Wk5abVFHOVRKaU5zakFJeFla?=
 =?utf-8?B?WFYxc0RRYTl3TWNhSHhEYUF3UmNvRkUzZTcvUEk4UlUyYjBVL0p2L2dmWnNU?=
 =?utf-8?B?MkVERGFpbVVCcU0yc0QwRklJcXkyNG9icFlKaDJRdTg0bGt5dXlBbFdWZno5?=
 =?utf-8?B?WnFteUFJY0h3dFUzdWdldDJWR2pHZ0xjYkQ1S3BtK0VWSkZ5MC9HVXBENWR4?=
 =?utf-8?B?c2JwLzlNSXBDRm9rNFB1d3FteThpc0YybDkwR0t5aEdKNlN2V0dUVzl3Wkhj?=
 =?utf-8?B?V0sycEZzNlNSMnJ1bDNnL2RoQ280alArWXVkM0FTaEdSWlpWL0tCYllhR2hi?=
 =?utf-8?B?Q3c3eDFva2R1Uk5CcHd5WTJjK2lDRC9LaVUxYTZUUkY3RGxUZkxJdVdnNFoz?=
 =?utf-8?B?dzN3SUtUWFhPVllMRkl6OXQwY2hLYmN4cGhnWjdKdkJpaXFKTVE2ZWNGWE1a?=
 =?utf-8?B?RU01U2Y0VTZNRnlwenRBbXE1NFNibVQ2SWdjdWxOZVlXcmhodERCZ2pCUU5w?=
 =?utf-8?B?ZnpESEhBSGd4SFlrU0Q0ZStSeEhCbytPR3c1M0JGMGErRXlVYVYzLy9ZZlFC?=
 =?utf-8?B?a1g3OXNMWHZpVU9aSFZzNDRib2Z4dDc4bzRxTS83REdLaS9PbFFlSGpqTWZW?=
 =?utf-8?B?cUlzQ2kvR2VLZWlCSzFBVU4xT3p6QkVsSHEzLzVIRDY1RDhMN3NMN1QvaE8w?=
 =?utf-8?B?QjFEL0RFVVV3K0VOaWtmWjB3RnBveW9ScmQvS2RmS3d2bWhmeE9XdDExRzVO?=
 =?utf-8?B?RFRDOVN6VUFMNFoyWE1aZnNwS3BqVjMrZjdRanhDbFRab2NZbG5Gd1dka0x2?=
 =?utf-8?B?eEo3TjRMeVVzemoyQ3BRMTlPZHlTM25YTUhjQVY5YzllVVlyRTVncTJRNzBZ?=
 =?utf-8?B?SzRYNXFDZGs5bUhnVzRxUTdxUGRPeFp2NjRzK3RISWRFMElsRkhkRm82NThh?=
 =?utf-8?B?WHBNck5iSUpvaFFLd055azdxRjZUQ2Y4OGdQZ3UzRklLN0RXTVNjc0ZSZVNo?=
 =?utf-8?B?czU4TlZqOE1jOWFvV2psS0pEV0FIOFl3cmZ4N2lPUEVvSmU2bFF3S1RBMWNW?=
 =?utf-8?B?bkMxMW9NeFUyYU1JZENrZExOeDJreUxPWWRLOGg4ZFNiZWs4RlpyOTJUWVdo?=
 =?utf-8?B?UTJhMlVJdVlSMzhCWDV5U3orenZWcEVMYlNTUGVCZ0UxNDRVMXNSTTM3NklB?=
 =?utf-8?B?cUFtT3doYWJjQ3hWaVFiTThFQzNzd3prYlRKLzlFdTZjcG4yN2ZjSlF6Rmlh?=
 =?utf-8?B?Vk9nKzBoeWhDM0hHQ0svMDlkWFNGQ3k4Skw1Y0MwbUxQaUdkYnBGY0Y1dmNQ?=
 =?utf-8?B?YmpVVDcxVFdFczNWNG5VS0ZDTmFFN0RoTlBxTmtoTkFnc2NibkpDV0ErQ3hK?=
 =?utf-8?B?YkRrVmlxYVFmMmpVMnZsdy8wVktrT2pXL0JBOEtNRUNDclVsM09VNVJlaUJu?=
 =?utf-8?B?cFRzNFplMzNtLzhxZ1BwZzBXQ2NsQUlndE9WdlBBT2RVT0ZVT1grUkJrbkRI?=
 =?utf-8?B?eE9Lb3BxcHJlLzdBSGdkVnR3VzQvNmtudk9ZMjJBUHJtNWcwUExmanRVb3RG?=
 =?utf-8?B?emhmYTBhTzZ3dkN1TUl5QWM1V1AxN3lNSmlFTjg2ZlQybUhZYUhOZzlKYW1t?=
 =?utf-8?B?dGMrZVE1Z2JvTFNHbTM0VXVpL0hvQVBXU3UrV0RWVUxMQkRxRnRDNGxPTWtP?=
 =?utf-8?B?RDBSdE84YnR1cUcza2pURnZBMHQyOUxObGdYVmdab1NUTzU1SmRTSUdvcGFJ?=
 =?utf-8?B?RWRFakhUZVNpaFQvR1EwcjVHRi9iaEwrWE5GNDJLbEs4bnFZTitqamlmeEFK?=
 =?utf-8?B?M1hFNGhQYnZ4YTJpVUF2Q2pGZTRoYWlINzdYRlZYb0d2U3ZLMVVrZWw0N3JG?=
 =?utf-8?B?dzhPMzRkOFBsdCtoZU82eSswUUZSKzN0TktlNkZLQTc2eWZmYUxVS3p3Lzhi?=
 =?utf-8?B?UWxUUkRYak95U0l0UFEybHpzSXAvNUJhMlB1L2NLV3oyd1B1NE14L2FIMnFo?=
 =?utf-8?Q?nXkHFFOVlIhd8psZIkuNOjCrZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0155cabf-d278-4d8b-8430-08dbe594f6d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 04:40:16.2126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TIEAOM6iMBhTIdKF7BH28ogMxcFshgQfokIokFmMUpfcK9sEBJnn13CdJokPQTir3+Alq+z+mMLElpMQ9mlSyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8708
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgTm92IDE1LCAyMDIzLCBVVEMgNzowMCBBTQ0K
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
MzY3NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQoNCg==
