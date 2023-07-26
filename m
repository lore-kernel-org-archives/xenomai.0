Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FCC7C
	for <xenomai@lists.linux.dev>; Wed, 26 Jul 2023 02:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690338566; x=1721874566;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=A7zlQVFSvUekTZjnSa0h0Bl3CbOk83i7m9ATurofd/o=;
  b=FqRLVpRji10aa7qlP3DypZBBqwo2YN/arDutNlfJvobSSTB2H+ITLlzi
   Lr1cHylzUeLSNvzD+ci3nFtxg6abJdGEiACyBtOnWF5IpqXrcI3feLvh7
   IjaB401L4LiEJps8iRqScrFDeYdvwCE0ZiVKCBgYnRZ2i0xFBsrbYeyDs
   GKLXf548Tkmp87rO1hKS9UwSnwMoz56d3z2STzDKfSuCBWMewOU9vFcE4
   S7tpGgayrZU86XL1P41RXRsoQr2/nDFODTDq0sC+FuSiM6sG2TzQFOrvc
   DWwPWPFDkmZktRQyM2qY5KSp5RTjV4U29fK7znWFrDVY9xihnA21qbiw2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="352796994"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="352796994"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 19:29:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="869706486"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jul 2023 19:29:23 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 19:29:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 19:29:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 19:29:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAZkCZKe09lY8sgFdvqfc4I/YDqyTWXXMfmah6+z16c5ZAM9N2eJ+nzPj3bdfGUnqJIkIt6kBbKlpHrilkN5boMR8lx5338VDG6ks7NEBgkEoezPRU8QGGrjUhqmtq4JPrWYoUeAc3BoPcyd4rEmDEZtVds9FLB2xA2K0dEUxvccGcLpOBjS3PxaTFLWOU0jnGNxolG6/2ZALaI2PSUObtBEIVBKkWh017R0W4zxlrD7Ypz1s5UQglFcOxUMNe1Qbv67PcBRMrZItZlW1KplPro9Vdw2UpQwtAORuNRucHuPKcmg8k57EN9B9GQTvYAKOuJvdlvEq8dGFPCfbS9HTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7zlQVFSvUekTZjnSa0h0Bl3CbOk83i7m9ATurofd/o=;
 b=PhZtmibYI/kdgHwiH/ewUcFS+8wjLXMdKm+uDCnoyYe24IKl3FvodaIfw1/1/TwoXR29f1LW5gu423lolgNlGvcobbwyyUJcIUGWRMaTfKUiOKOSLouhWywVTEBVZVM1MHGG0lS4lhcn7kV0L2K14QutCdmO2kpa+i7OxS13h0njsTbI8BJ9fMGEHqsCJ2UHJ3Ij0/86ytDnq02nirFZXmuC/+NWID+Sjb6Y2PSd3vb4GHti7iujzeXpHZA/upuX7BaEECmeGlwHCV0HTK7spihuwHUMO4tBxqrzacvhcg0gL9sWxdFtte2x88vE4k+noVt1j66ZerljXO35j5qqJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by CH0PR11MB5235.namprd11.prod.outlook.com (2603:10b6:610:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 02:29:19 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::431f:7b31:39c7:e9be]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::431f:7b31:39c7:e9be%3]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 02:29:19 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Jul 26, 2023, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Jul 26, 2023,
 UTC 7:00 AM
Thread-Index: Adm/aOJjHwUI6OslQlyh2Jci3P12KQ==
Date: Wed, 26 Jul 2023 02:29:19 +0000
Message-ID: <MN2PR11MB428518794F557D8B706AFAC8F200A@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|CH0PR11MB5235:EE_
x-ms-office365-filtering-correlation-id: 630cccc9-3a8e-4185-f172-08db8d801db8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xcUkQuT3M9ha6cPbhFJWNBhLg19B0biS1kqLTYTgvuFYMbxQHcnbaBIzKFjEnxi1sJ4+FmKawCK8lnrRBth1vIeR1706cnCJ3LXm1h+hdPOG97RbFluoPdT5hSakzSKyi5cM3aRtT+cPyR0kWaaR4EKsvDIlI92XYz5q93/e6frd9t3rNYsamkvRUPiv2pKKbE2Oo3lvHOoFv+XCF9lDyXYe5ZJKqCN8aO14QVfwNcpIplXH+e3Q5RFaWCcC/gfPIFmqFWn3FMQCu1Z0IkDwRSI4DEpv0QofFeS5NKcu61ehtEe3gYu0G+kF709uw+k+tL02vRt/3sVqerH99KwZV+X7byKndycuFEKvsmUZdci2D4twIBjFmIXxEn7ggtkYiAX2vPCOq6sTFprTFKB7hk8P2LZ40FQhT1drx1I2oYgUrgM2bWuTacO0N0xq/S4HRyFpzbRfnLiJr62FTrcW2TvCBZLZmtM/lvTrrZ5RUzZplNIYy+YNR5QP5ANareVmW/pzdmtfySeLSMyFabBx5pqTm6BiE8RRYIODqWECuxE8gww7Ntw4NRwrac+DcKrpueha9Inj6yyf0XXtfPxu7KPAzwmDDoWOmc3I4vUCQfbJ9yTEpTuz0joJx/GiU6k9DhkmF1rUtUSVMKchaQZxKQ+BJiekfQb/CBTUv+bdpbX9Fo8PXGF07Uqs2LrlzKjC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(9686003)(966005)(7696005)(478600001)(186003)(83380400001)(40140700001)(33656002)(86362001)(38070700005)(55016003)(2906002)(66476007)(64756008)(6916009)(66556008)(71200400001)(26005)(6506007)(66446008)(122000001)(82960400001)(38100700002)(66946007)(316002)(76116006)(8676002)(52536014)(8936002)(5660300002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S00zSkZpNHlxMWVkOTVoWHR4cFJDbjV2R1FoekFYekJlVnpsS2tkQ2tTaVdR?=
 =?utf-8?B?UUVDVllqd3NGRGtSMXllZ1dBVllPUGtpa1dmQkVMYXR3emxzTGwwbklvaGdV?=
 =?utf-8?B?N05Tald5dWkycTlQdlZTSFYwT2d2Z0RQYjJLQ3JveFNPcGtyeVl0S3pIMmVR?=
 =?utf-8?B?SHlpblJBeDJzeDcvc3MrdGpUYzRyTkN3TmVDLzdvUGdjVXlLb3VZQWZmZU8r?=
 =?utf-8?B?eThUY05rR2hNY01kMDdJTU43NEM4YXB6clByQTg1em9Ud1NBMlJ0eU1FSXpV?=
 =?utf-8?B?eTU1N0hnbzRiTWJ6TmpMdTNoSkNGODNCR3hma1gwRW1mN3hqMEx6dUdoRmRq?=
 =?utf-8?B?bHRMeWZ0THY2UUJId3ZQTC91eDBDM3QvVDlaK0dEWU1KQXFRUnQxbUdxemRZ?=
 =?utf-8?B?OHFRdGRISG9LWjlrWUVUdFhwdzFKT0pVbU1ucCtEbTJZUzdINXJhZ3Q2Q1pC?=
 =?utf-8?B?OXJFRHNhU2JMM0ZsMHJWcWUzNGYxSk5XUTFCbGQxb1NYaDRCSWdXRVZjV0ts?=
 =?utf-8?B?S0U5TkVENlhjQjR2NGIzMEtmUXJVMHdqTnJhd2J6dU9pSWFrNFVnVGhVTzhj?=
 =?utf-8?B?cmo4bmJ1SjJrYzFPbjI0WDVwZTIxd1JSVlE0Vzl5YW1lU01WVVFKMEFxS202?=
 =?utf-8?B?bGxwNWpMOUdKdWY1ejNnTjJpTmFNUlNkVXdielkzYkV6cTRsaHZycEZ5TzEz?=
 =?utf-8?B?M21xbWE2cm80S3RWbG44aklkQU9CQlZ0a1ZFaDVjN05ZazMzMzZ4VmRNNlA0?=
 =?utf-8?B?WjFNUjRtY2lCK2NzMWkxUzZBckNzTXRoMEEyS2puWTRIRThHdWpsdFlscU1H?=
 =?utf-8?B?OFZLaWdic0JUZXdFRm4wRkVFWVQ5S0M2c2xSeXZLclkwazBlNEEveDhiRmFz?=
 =?utf-8?B?TjRmaUUwNk9odDY3TmE3Q1liTzQzRjdpRUl5R0ovMGFqSUE5UDUzTGJHSmE2?=
 =?utf-8?B?eEs1ZVNwUkZCWUErRzg0bEtoUzc2eUhLbEV4S0hGTCtuQTZxOGJXUTNZa0VJ?=
 =?utf-8?B?S2tSSE0yZUZWZmt2Q2Jhckw1YVZXY0RweGpiM3dPMnlhMXJwakJxTU5xaHV0?=
 =?utf-8?B?aDJZbnlxVnFTQnIweXZFblhjdExGUmZnL3ZOUE8welJyUTB0aCtTNk9vV0kw?=
 =?utf-8?B?QzlUbUM1d1loY3FGREhpV0VyR1RqSW1oUVJjMWFndDQzMzJKZmVCVi9TN09P?=
 =?utf-8?B?TlJJclVNUGxtd3hBYTgrSXUxcVNGQWtqWUVnUHJKcW1FZzYvOTBqU2JHVkRX?=
 =?utf-8?B?eEMxaW81d1M3SU1TWDhCRS9WV00vbU03WkZiWUZQYVZ1VUtyVDcvZTBub3Y4?=
 =?utf-8?B?TkJzUkpNODljbHdrQTcwRW4vbTZTc20zUmlNZWZhdmF2aUVjaFVROTk3Wk0z?=
 =?utf-8?B?dUNrZ3A1MVowT2RRdlA1Y0tmZGd0VEx6dHNiZGNqMXlnVXM4N1lRQzZpTnJC?=
 =?utf-8?B?QTdodWtCRzVvemN1UE9YQVB2V1E0NTRTME43N2h2UUxOeE1mT2x3bDh2ZC9B?=
 =?utf-8?B?RUIxVWJwclc2T282ZDdNdk9HRUREY0NHNlgzVUdybUNQRlVwR2JaWkIreWpJ?=
 =?utf-8?B?MDlkM0NrMC9nMlExdVExdllHVjBDTVIzTUdLTUptU0tFK2VtcXN2VTBGWElB?=
 =?utf-8?B?bm94TWpWTVQ2K3VnYWdMVTlRUElUMDNFSkQ3RkdDcVFPVE1Sa2o2VStiSzRk?=
 =?utf-8?B?WVZGa0hTWjlrRENqcXBnOTNITEtIaFF6ZUtpQllNdzR3aFF3VXYzU2diYzNI?=
 =?utf-8?B?M3NSS0IvS25YanFKbk5OUklHRjM3S3RUbVMrUW04YWYzWnpWTVlDVFlJYnBx?=
 =?utf-8?B?Kyt5aVcxd2d6Z3djWCtwa1J4ZlI1cXJkanZYQWVIOXp3YjFSdTJWMm83RTZX?=
 =?utf-8?B?WG9ocURaMDBlWnlWZGFqcWJlYnRkb1BuVG1MdmtRbkJmMExONFRkd09CSzJD?=
 =?utf-8?B?K2wyaEk4YjVrbEpLMlkvT2tJSWJiM2lkUXYxNEVNVThoNkxGZ1IvWTZVbjVP?=
 =?utf-8?B?OS9UVFRQeUR1cGo2ZDhuOWpid2hyODdNaXJwNjRjSWxjQ1BZQ21lQUVVblhF?=
 =?utf-8?B?MEhsejJBaFNaek5LbHdFOTV5UFJxVnJUb2VjNThhT3JWRGZTTC9rbGdINU1s?=
 =?utf-8?Q?hT0YQM89+u0uMzOF2Nm/hGc8P?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 630cccc9-3a8e-4185-f172-08db8d801db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 02:29:19.6707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tu+WuLnsrj9zS2rnqPDAosXrOLecLftJYG0fhF4ur97yOqzx7MvlPmtJgEzVtkVAcno4VsbRWNgb5BH6JIBRkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5235
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgSnVsIDI2LCAyMDIzLCBVVEMgNzowMCBBTQ0K
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
