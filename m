Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479862DF7D
	for <xenomai@lists.linux.dev>; Tue, 17 Oct 2023 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="auoERi23"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697584686; x=1729120686;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=IelTq9trpUh19GSCbHxMc0e2gBMyih96YSTLm667X28=;
  b=auoERi23SqozIlb9rAZrbQOWx8nD9jC0YUAIltsjJuITFJ492HzKcpLm
   PKDAV1zHz4e2wDtn6q88k2SD7UDHp/O8JjjUfcPYjCS84kOi+7wuW+g8z
   3Mdc9EpLPGFD+zMSyrs1h87GTlI8E3ipK6/TVGuMLhpA/FLL0t3ssGNcG
   Cwz9liosQTYviMeRxBWWhfv7NtuL82ZAb6OO+lq51GO08zX0ZIyhNDLvj
   OuLdctQCdCYrQ4Eq/rpB9PQg0DggXI5WInW+lEhVw/5++DVYrmfsDCbd7
   PjXMc5OVUdkc0hsJ2NJl4TZ9+evT8G9pP4Hc5nxTiH6LFOVKPUmoat/Fo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="376267524"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="376267524"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:18:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="759997528"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="759997528"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 16:18:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 16:18:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 16:18:04 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 16:18:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+9Cgq1XrZi78Da6Ig3J5gClAIhJ6ladj1X/6P+G6LEm8BSxSjDuWHzjaakBpF27N4J4TPSsUuvdITHuXoz9Epyss3e9/Pxw5vE0+XfKpLE3HsjX2uyFwDncNnga2hWlJezl4eQHULjDnetvHrFZr5hcLxIrlfecKCR4jqtsAVt0yU8yn5y/SpDOj6gG4gxV2pl7stuQx/879v2fn4QKNrFFzscY7YqD2FqxdgkPznf19hbDl/jvh0tAHCppU7tspgi7SABHr2PTBiBKON8Zlst/tqsjozaYQ+y3Mnoi0xJCQJWnDalrygCUAonGfYszRsRDpUkzPodmiOpmHG93XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IelTq9trpUh19GSCbHxMc0e2gBMyih96YSTLm667X28=;
 b=iZhihD/1e34g+hs2as96Tpq+jFOMmgSahIfnr1341Y2M1I7eCupXwzaHI1G+GPAh68lBYTnkfiEcF7SOZ0IzeN8dVwMppc21CNXHENRB2U0q+gRalhr2TEKkR5HPxAv7KA/CutnkZ1UDslTwmb8mUKbfDJG23JifKtB8OGnNRc0mYfDzHOwI63XxnwH17myaCA33dP6Qoi54vIaGtnad/bd6HvId4kksgcdNfUDqW172WABo9uivdIbwQnliv0UJMMzkE6Oz3U8LWguInemFcC5QAU+dg2kmejOddzpnJGgKz9uyXezCmH6ZPTpz5HuAVCgZZFAIxawYOlRPkJnqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by SA3PR11MB8073.namprd11.prod.outlook.com (2603:10b6:806:301::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 23:18:02 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::b563:f43a:242e:5c5f]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::b563:f43a:242e:5c5f%6]) with mapi id 15.20.6863.047; Tue, 17 Oct 2023
 23:18:01 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Oct 18, 2023, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Oct 18, 2023,
 UTC 7:00 AM
Thread-Index: AdoBUAwY0dLNvmt9S5u6uOdRE9CBPg==
Date: Tue, 17 Oct 2023 23:18:01 +0000
Message-ID: <MN2PR11MB42858C73ADCB5825037102D4F2D6A@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|SA3PR11MB8073:EE_
x-ms-office365-filtering-correlation-id: 0c80df76-ea70-4728-3048-08dbcf674eb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vWgGltFZgfT+sZtn2pw56HJBZHeCVsPVh8StVCVVz+as27A17HhrU3GnuQLHebdANZDaa2fvmK4KVzI/H6TNxd10OE7J8r/ldn1xpLjejU7CkdsAOYWE7R7PZvDQWMwnd9wGIQuGbZ5FVMRBKbW7LrZKHqLwwazATa7wfzd56ev+bvv6KxKaQoP/87nOtpR2RLJwxGrfbn9zXs9eotWXFppdmS1GcTzGyp9CY7xYvaYnx6j/7qnjllX4ZZ5TaTxvz+eakGDt8ugKqIEmVi8yoG7BYQKMR62A0YGOhRMRsOg/x0NBlaG7ei/bSPhC1HjT8Mo+5+WYO5UOMo4T3zjT/KTEG1MeEpBewD+51RVvdwuOKVEzlBRQm72iI8elxRUQNrCGX7VnDG8xAstb9VIoEOw5WBuxqGy5ZfY8mOCHRHDf/GT3mYviKPbaojPZhYhCIH2wea9m4RMNCxdhocG0tpHk6IiUGARq85DGSs+aYe2sBY0y/9O8hEHapvb0uvnHJDKxaPo27M3sjajFPmzcSBpGZp/GoG96UFsdKUPOIP1qNXBnNSx78bvzwXEniSjf98kmyYkUwZueeBO1FNUzGUjRgR841I40iFo7tjLn8FW01sr+d2frCFVcaAC0CycIIRBPCLbDzkzNBWlPREX2Tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(366004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(66446008)(66476007)(478600001)(66556008)(76116006)(64756008)(66946007)(966005)(6916009)(6506007)(7696005)(41300700001)(38070700005)(33656002)(9686003)(316002)(26005)(5660300002)(52536014)(8936002)(8676002)(2906002)(40140700001)(122000001)(38100700002)(83380400001)(71200400001)(86362001)(82960400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVE5YVowb3lmRk5UL2JRTU9VNWJGZTF3NXZGVHZxMUg0L3haT01uNmRQNjk0?=
 =?utf-8?B?WFl4ODhDay8zNkpvSEZGeWRiL0ZCUDJ0M1ZHUVYxd0lIOEhSSnU1cDdsYmFD?=
 =?utf-8?B?UkhLRWlPYzc1U1MzVmRITDg2eFovU2R6RkhON2sydnpQR0taeDBLNTR3UjI5?=
 =?utf-8?B?a1A5a0tlWGZhRVhWMGQ1ak94am1ZVDROa01KVUpPR0hkT0lEQjZycTVHMnRn?=
 =?utf-8?B?NnlSYmhscW1XSnZaM1R3RFQ1RnNmNzRqYlUvV1YySjlFbkFrVWxic2FUOGJJ?=
 =?utf-8?B?eFhNUVZvS093NnlSOUluQmNrVk1SR2ZKaS9mdEJRZXE4bzB6WVRQZ2hNY3Fx?=
 =?utf-8?B?cnRPQ3JoU1hlSERJSExVem5zN1dNSW4wZlhiL1psazNPUkRLYnphcTZzMFNP?=
 =?utf-8?B?Yy92ZmI5OHZTaEJNNmViS0lDUlVyaDZHc1ppZUNneFJ5Z2pPTDgwWHZxcFNW?=
 =?utf-8?B?eWdTYmpLTzlTcHkwMjJVSENuNEpldnJNV3FjUVFreGEya3FVK2E5VDBGUGVU?=
 =?utf-8?B?SkJVYkhRYVhuMnRCTTdCL1BkcWVlZFJYT0pLY25Ha2FnUzhVQ05jc3RtZFE4?=
 =?utf-8?B?Ylp1dUdNN01RZ1pHa09BUXUrc3J1cEoremcxMXVzYlY3UXZVSnl6aHRjZUxD?=
 =?utf-8?B?elNjNWNPdUJNZE1mdXVXSW1RY0h3Q1pteDl0R0wyNUZKSWZxZElPSjMyU1ky?=
 =?utf-8?B?Sk9aRkxDTVkvWG9pbm9jTXU1ZG5NYUl4SG1yNm1Rbm1NUVF6UUNKdFdmakdm?=
 =?utf-8?B?R1VZS2w5OUdUWStCdGd4UVNnUjZ4c1czNERGRnRzVTdsYVRzSVNXV1FwVXVM?=
 =?utf-8?B?Yy9lWm1SMUdMdXI1YWdEZVZOUDdlUVZhRmpSbUtoc2FuTXpvcXI0SG56ZGdm?=
 =?utf-8?B?YjBjdlduSHVtdkhlSmFweEo2SlpZVXA2SDBxUFpxanhXNFpZNnlWVE9MT1d4?=
 =?utf-8?B?NldzTzhVYU1lZkJQK04yUkY1YXFzbDNNbm0rZ1J1UlMvWXpEbGZ0SHRTNmxO?=
 =?utf-8?B?d2FOUVJjb2xDWFdNVGx0b1VYOHI5OEFpQzlQa0d5SGNDdFJXazA1MHhTVU9z?=
 =?utf-8?B?L2xuQzEwek0zeWNLVGFlcGhDcDFLOStQQmFidDBUVE04L1YyMVhjSmpnZmNF?=
 =?utf-8?B?dUJwZUl6OW9teVZhK2pXQXBUMW9oQU1XbGtiakZnOGh5b0U4SGFXN2loczJQ?=
 =?utf-8?B?UllGakJPaDhYcERmUHNwUU01VVBEcEpYUXFwTExoS1gvaWVhN2pLKzMva1E2?=
 =?utf-8?B?VmxxbHVWMHVmYzJPOERoWC9LMmZxWDdXeTN2b0ZQZWVPOGRESW9mdFlwU2F4?=
 =?utf-8?B?TVdod3NycElPU3paRTJTd3BZbGl6SHd4a2pCNFR3TnQ0ZTAyVGNlUGU5QVRj?=
 =?utf-8?B?cTlRaUJJS1ZFaC9tQnhnQVhybVpLWlFyVGszL2ZvdkI3MnhmaG1QVkxuNDNM?=
 =?utf-8?B?YlU1WnhjZ0FISlQ0NlpwN1Q3cU45YkpSVldicjN2OFFPQ0xyK285SXp4b3lJ?=
 =?utf-8?B?MUVRcW5EejdOeG1kcjhWY2tPMUVRLzVRb09ZQUh1YVJKekJ0eDdrQ2Ivd3dQ?=
 =?utf-8?B?cnB1ZTZmQ3p0bHpmSzd0Qkl4UFd2TzYzNmdSdDhQSXA0blFpQVBiQlFoeGZ0?=
 =?utf-8?B?Q1c0VU96a05xMEdsRDVQK2x4dTFhaGdsN0hibUdwc0VWajQ3ZkZiTVdMdkx4?=
 =?utf-8?B?d2JFMHh4YWZydTZmMTZUd2paZ1ZTTHJtcTNyL3E1Z0Z0aFpWOVFmUml3Nkhz?=
 =?utf-8?B?MjVxaEhYaXNvME5zWDJ2WmFtUGg5b05zMnpYazRLenlvS2VLQ3dOZXRqOHYv?=
 =?utf-8?B?S0xsZmNkT2xuRHN2QVREYUVjbk1KVXp0K0RuQTgvc2tSMGtPRTlsajhiRVBr?=
 =?utf-8?B?cU9JUlFVaFd2dmV6dFR0K0JLVGdWS2l2TGJJY1Y5TG5PbTFib083cW1DYXdm?=
 =?utf-8?B?Z25ybEM3TUxQME5GMHhQZXRTZCtVNnhQZXNaVTlmclZTOWgvRlhNRTlHRm05?=
 =?utf-8?B?VWRDMDBoT1RtYWZvRDRVUFZLWjhpQWR5Y1B5a3VwM1lLOHFJMDZyNlhGRlRD?=
 =?utf-8?B?TSt2SnVDdkVxTEd5UnoxOE9NUG92dFNZckhDejRGdEl4UXdSZThLMFRjRnhF?=
 =?utf-8?Q?akCCO7eD8+eQZqBkp6IkWTJ7m?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c80df76-ea70-4728-3048-08dbcf674eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 23:18:01.1670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KzdUct2CoywdLzJbtQVXDd26FAOyG+xvCivkKYdjsus4L5Nc5OgwYv31hqjGEU4ojlou8uWvf/MN9cLz3/5D9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8073
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgT2N0IDE4LCAyMDIzLCBVVEMgNzowMCBBTQ0K
UGFyaXMsIEZyYW5jZSBDRVNUIDk6MDAgQU0NCkNoaW5hIENTVCAzOjAwIFBNDQoNCkpvaW4gWm9v
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
