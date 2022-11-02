Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BCB622
	for <xenomai@lists.linux.dev>; Wed,  2 Nov 2022 02:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667356058; x=1698892058;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=fRhpHHIjkTCngw4FjZ4xmMrvOnok79EnSyP4OSOwm24=;
  b=ZpM/dccbBZChMmZRjyPAGschwPQAZ8XqmC9xtZs5h5aqYzr/J18qZCCW
   OcxZqqiKxN1yopUjxajikUPKB8IGRd5+/ghZryseVtGSHZ+/c85ZIFaFI
   kcNDK/2gYjUSuo0xkPMgxlvVVQmZS89QGFRNzGDgq+1sZl56HKNAwD/7U
   jhc8x/1zfzZtTo6X6PCw4Htj/FUWNfRkDAHpM0zY3f1K49HMaRdz+yICt
   SQeG2x3ZYGHuDU5anOib3vtJeS+303pplZIOmIJ37aog29lP0RWpyjCdH
   RaAGYg4Ezq2e0XpeLsUhgmTK7u0BleF3gTTy6VBecCicU/xQ/77gpv161
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="289682144"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="289682144"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 19:27:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="879307592"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="879307592"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 01 Nov 2022 19:27:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 19:27:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 19:27:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 19:27:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2+zzzDB02aQpkqDLT0mahXZO+lsyjmHWpY50sBvjxBd6Grdb91j75OxBnq88Nj1TDHtnV1xienmNgzPgES2O0WeZjmLPYhjG6ybcwtsAyPtLt1dhaoJe19JwPfQKa/W/wZgxbQ/njofL2LhKeI7h7ZlFS8DhF/yR2nzpAq1C2NhFOsKBcZML+mKE9C50fi+Dx0/B+jDY1XVVBfQxIYbYeX+D6ujxCV5YXhYH+9u/Qlu9XlnNh8CEmMHGLlpo01iJMHUf5u7cuwcQ6EOSs0S8gXpzpCNZqVvQWHyAQvTMDvYbCumtByed8yEgLT+/9kUQ4Q4dPCNP8vSo3qMb/8ULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRhpHHIjkTCngw4FjZ4xmMrvOnok79EnSyP4OSOwm24=;
 b=eLQSy3aBbmcVN4omPeM/zHMANdhwyYB1rAguWNdqp+B1d/I88JA18z2NK8umG8sv9aUTT/1bMvQ9hmdK4+yK1t/yPxpf658lrAarYUETStXFaB/eQkpgptUpDLyOYMOHW0zgztEI6pK0OQ7osuUBI7pklH4/U8pOWTb7VvdI34+4Z3j2HViAQ/xaUTa7OaZp8lfZ3KYtPEsJq8d9/NdixK6XWZvBG5KZ94P29nG8A4QeMd4vbE5PoVTfnXvvtc/5A0aHvIJ5yxv32kAGMXj2XpUcXI8A+6cWsV8WWcUXzYDAT8APW5FS+2MvaoMzaraRYDjNmxzdds147cH+pXiwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by MW5PR11MB5931.namprd11.prod.outlook.com (2603:10b6:303:198::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Wed, 2 Nov
 2022 02:27:07 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::27cc:d8ed:9947:fecb]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::27cc:d8ed:9947:fecb%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 02:27:06 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Nov 02, 2022, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Nov 02, 2022,
 UTC 7:00 AM
Thread-Index: AdjuYk0AyLTbL1ByQIenRKRBqUCx5Q==
Date: Wed, 2 Nov 2022 02:27:06 +0000
Message-ID: <MN2PR11MB4285657004EBD65CE6B1214FF2399@MN2PR11MB4285.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|MW5PR11MB5931:EE_
x-ms-office365-filtering-correlation-id: 242810ce-6ed8-4e7f-525b-08dabc79bc55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GmQst9V8kPpf75pAdlbt0n4ZMDFkw693gVcXdNAPiEjYM+Us4ycqvmnKWXBD+Pt+vrSkjA0XMw+Nw3cFY9UFLlozZzS4QFtDxgS++0aO2vGilVJxS6Y6UFATHKi7z/pqZ/Rvrj6HjM0pnAJP3HSTE6JINGeyzhnwzO1BJP22oMSvjHSbzxtu06AwmRlpvhG/ZgI+P8Oen3k9rjU2Oi9bAijVpPL8U+nTR+Z9Omb+bjatB1jBNj8dGvl/umtdWyw6TmK6yfRAeRF6R9o4VkDSPtbSDuxEWU8XusBM7Y8PvWc4AAttNF4rErGuyMI0cIP8vew2zWsogkkNIziQJz67gfGRb9PuacRFyUm4+eb3ptUk3FpfV/WZjkloN4OVBd2aVLT1usmp1edCvvMu0/LWyFQcFb+AoDHJCQJZ/mL6EvWsiBbpwOHlR8TMSJN4JY9YesCsZWqJJcFlZ3EuZ95+3H5YBw9eLucxZ1Tng/69pkNkwUsUL37c5e0DvBW9Y4xRUVmzTrwCtgDX9K97YczbIEhhK130ArfsUogIQ28k6tp9RCd66+UDLmlzM9HamMjHVuL9fl9I0s/3ep/vba1FOcAbgooPg7N5N7S0EWJzv6+duZrBEHKrm1d/ACERvXRoFvcb1fblH5maE8lam43uIWU99wJMB3liXGItCiOfihwax7u1yPuvIm/pwjq+BY5QjYoIluRH+3/CWCiGntMZ22Au89BnoDKRFXEHcK025HQvmKYrNeQY/PMmZMsHNzN5pNrHxqtb/Z+CeVAlbY84cTKql2r7iH2SLjAQ4F+qC+fTaQUKih3L7h8peNexbvsH02MGzW3Jf8heF2JhfRO4OQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199015)(478600001)(86362001)(6916009)(41300700001)(5660300002)(71200400001)(33656002)(40140700001)(2906002)(8936002)(52536014)(38100700002)(55016003)(82960400001)(122000001)(26005)(7696005)(6506007)(9686003)(83380400001)(38070700005)(966005)(66476007)(64756008)(66446008)(76116006)(8676002)(66556008)(66946007)(316002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEVURk5FTnVxRmtzNlVaQ3pJU25TUVBFd0l0MVVVSHMxY2hxbFUybFcydXEw?=
 =?utf-8?B?bisxSkVKQTJ6cFAyUnFtUU9ZRjl3MjQ1TVdpOURCWGROcnpuWlRiQ3VhT0cy?=
 =?utf-8?B?TDBiV0dDclRhS1BGdFFvRXJUV3h3azhRdUpVdFg2MzdGWnBoaTMwdzRTSG1u?=
 =?utf-8?B?Z1NSaW9MY0NVeUNsejNBdE4zWGhJd2ZjSERRMFBMUFpLa0o0MFNJZG8yVVhR?=
 =?utf-8?B?cC9YTkRtWlFGdG0rNGlkaGcwUDBPTXByZmhRcGlWUjhTVG52QWtmejVUZE55?=
 =?utf-8?B?T3F3blplYW1QT28ybVlCa2lqS3JtSHovbU1BWThBaThOdWRoYTU1THY2MXRY?=
 =?utf-8?B?cWg3RFcvbE9aMmFxWjNXVG9Fa01pTDgvdWc5blFKNjBpRlpQVDk5UWJtTVFk?=
 =?utf-8?B?RDRNajdBZWVzRlhhNFAvNjdNK3p1ZGRkZllzZUc1NXU3enIycHpnMFdKUlB1?=
 =?utf-8?B?bFoyVnA4ZHpOSEZKdjlTTEs4SFRsc0MwbEtpMVJzK3dPY1VVMzh5QTkvcnUz?=
 =?utf-8?B?YlZhb2Z2UFBYbHBMU0xLdVh6Yk5Uc0diVDczV1JRc1dac3Qyd25wRFBIY0Z3?=
 =?utf-8?B?UkEyTkMxWXUzcktoR3B3TjB5RXlmZEU0Q0tMWCtRLzRKbjFET1doKzVmUVZm?=
 =?utf-8?B?bThqTHlsRmltNnhaUEpvNkM3amc5TkZ6RkRrUjJSS25EQmpGZWpxdDc3TWpW?=
 =?utf-8?B?cW5yaWE0WVc4NUVDRW9hNUpwYXRMVmVTcXM2Vm9GaUNybWN4U0psYm9tVXky?=
 =?utf-8?B?TnRpQmVLUWF5Z0ZrcW1RRFJ1ZEdHVEI4SlNEVWx1dFlCRXpOdUtycjZjR3Js?=
 =?utf-8?B?cCtPbHFqTGxDV3Yrb3ZhcmFWVnFOWFRQYVZxWVo4K0x1dFBMbWhHNHEvb3Bv?=
 =?utf-8?B?U29JakdqdVBuVGNUTFlhaDBrcmpOQlJ3NFhlVG9rUzRWNitFejk4bWU1QVF3?=
 =?utf-8?B?aXNMZytCRW8zNFRmQkFpMG5PQUp0Mmljbm5tbUFjYVpKVWZmZTNYaUt4anRT?=
 =?utf-8?B?YVhGa1Q2R2VQTTZRSTNxR3I3c2ZqTERZREIyM3ZRRHY1SjA0SWJISEdhRGRI?=
 =?utf-8?B?cVNGWjl0RWFRMmFXejJwOWk0RHpaWHprb2gyNW56Y2VRbmRqZnRvZUl5U2Ev?=
 =?utf-8?B?SW5ZUVhTQXpLcDJnL1Irc1VqYWdTanJtUVJ0ZFl2SHZEeGlTd00wbnRaajlY?=
 =?utf-8?B?Z3g2a1VxRURoVmNDaDhJcG9COVNVczhqY1gxOE1ONnZIaW1HZkdiaEhDcVhq?=
 =?utf-8?B?dXcrMThuWTFyaE9CTFc5ZDRHemJVNEp1YlprbkgvaVdvczBzZU9UaWZSd2lB?=
 =?utf-8?B?dmY0RWszNG5UYWJCSEpVUUdlNVJUbWZHYjhmOXQ1clp0SU5LZlJiaFovemh5?=
 =?utf-8?B?OS9rK0hmRVkzV1dEK1MzRllIZEh3TTlDb1J3MytTc0lXbS9naGY0bE1RSDhE?=
 =?utf-8?B?T2hiYnkwMGpneEQzZkpqUnZrWVpMVzJiak42SXhWcTdPYm80NTkxVk5FNjY5?=
 =?utf-8?B?Kzc3T2FqaFUza2NqWnFxSlBaOTRLRHgzMkpnVlRFWlhEMFpRUE45OEJtZkli?=
 =?utf-8?B?bVY5cERIWHB1YWk4YXhhODlwU1IyUG8vTVN6UWZDdFl5WFFDbjVYa1N1ZjI4?=
 =?utf-8?B?aHhUOFhGSEFBUWQ0ejMvODVKeXV3cFJEMHJVa1JvQ1BqUFRQOXNSSHo4SDVn?=
 =?utf-8?B?YXk5NlBFLzZBcFFHZHFab1pnTEdsRWw3QnhUYmhkVmhWaTZtMFR6YXg0cFRm?=
 =?utf-8?B?dlFUZHRxQ05LY3VBSXgvTjExVndKMitoZWFwcVQvRU9HZE8yWGFUV05tK1RE?=
 =?utf-8?B?ZWlGZkUzeXVpTHVoSnRuL0ZSNVRObzBuQ243Z3VaNytyM2dGZ3R4RTNDNjhW?=
 =?utf-8?B?Ykc2bEFOUEJCQTRoZDZDbHh6SVdWZnEzVkliazlhci9WNUNNeXYvc01aT1lB?=
 =?utf-8?B?bTk2aHJGN0EyTlQvRzBLWTQwVmFubGlYcy9ZU1Q3cEZiOHhNbkhJREU4aEhW?=
 =?utf-8?B?Z0drelltYUZjbTJ3VnpRcHpDRUxlTFdSaXlGcWlwazRPVHNuNFF6Vy9DeStH?=
 =?utf-8?B?YzhXdVZVeE1HMVRGa05ORkFReWR2YXpyQ1ZORXRreC9La2xxVVU2dGN0N3Nm?=
 =?utf-8?Q?Iyl7EZwW6UwGRAfhnXycfeAQU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 242810ce-6ed8-4e7f-525b-08dabc79bc55
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 02:27:06.2494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mLggPN1WtD1jQvdT/+POdfFWD+MOzVYLyauUPsXYN5tDa8pUse3B8t5/12m37q4ecs1oRS4ncmMbZms86CaNFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5931
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgTm92IDAyLCAyMDIyLCBVVEMgNzowMCBBTQ0K
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
