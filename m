Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427EBA49
	for <xenomai@lists.linux.dev>; Wed, 20 Sep 2023 02:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695176242; x=1726712242;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=B4C5O1UvYYhr7MM6+01ghwy5v9fJlHrK5YLK0iLvK3U=;
  b=kUNneZMyCuHE8P9tnqOpHbTQpLxQAlsRuoEBhuNZoQtHCc2+A8iKaRlc
   pTJMmQvivIENi5slDwOn9ASJoLkWnb9TuXnvt4R83qj1TrmHX543RDfhz
   Lt3Fs8+5tN+G7vNMEscQ+lG5OR3crhEhgNSqL+Jt3hNDwLtwpN9etEfX8
   QhCquX8C31o9JkwPiy8GERE2Uc1/I1a6GvFiSontupEEbKjuy3okRBwGc
   X4RwYYJ1DwwVFyGEUtv/Bz2UQFkdzNcHq6+A9Yku9AKFvAWYWlv/oTcyi
   DT9+Fvw60Sj/skU5OEueK5nX3Sn296nkB+0my6gzEJ94X7O6a8EXiAnjb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="370417895"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="370417895"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 19:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="870181301"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="870181301"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2023 19:17:21 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 19:17:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 19:17:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 19 Sep 2023 19:17:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnFO/a98XsPj5Uys1mNwDGzI6FSGum4CeV+pOvFh4+Uk2EN2CAe7oviTASzSsxhLLdaYXlyDn7FIpxA2uN/9CDDTWa5CsOatw29QBWOsnLa/nLIV/6Mdkecmp59t0s3JiMxTX3DounFz596wleWwLX8rlJrZ6ixJ9EcJFI7bxvo9hxOyO3iS7R6MGb/edCY9zvWihOeuyz0Cz3nYqXEcqF7dXiQvDIg4umZfo7Qu5hMUA6Y/6FdN9mVhCgZ37lTRmDf81OtFQJIpVTNF10RnFVh/+/UgPGAG4QyHeHL8h7QeEv+qXOfkyBSMmMUPdHk7vvhlQberhG2gHm5d/stRAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4C5O1UvYYhr7MM6+01ghwy5v9fJlHrK5YLK0iLvK3U=;
 b=FHiO7+zanGi6kOQNoG/qYqxI4WukIjyP6q4gCAQhxgRumdI55G44Z3OnXNUOOmQTeP5C9F6taS1+HDzQ3MIocfx1TB7Qghh7VnTLNLDeFLVfBZLdIxAt2kTtY5irkgQZyZ/OPvWqcIYCTvGNZ/Wl78tjg2tJPFNWYYtRbI+TZFohFvDrnl2A6AFIv8gn5EEWzpyNYnL34VCnK5KAODONidXw+gw04J4OYUAsfQIAazikfDw4f5h1oblPZk6v2TmyZhoaRRuJc8vp9wE1vAkzJR54GjGiBUBmqrhR8sYZbbedX5TkzYWMZwSdizjHu6zs5bFW2YTjDezCqsSk3UOQCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 02:17:19 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::39e:eb8d:6d9d:78fe]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::39e:eb8d:6d9d:78fe%3]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 02:17:19 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Sep 20, 2023, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Sep 20, 2023,
 UTC 7:00 AM
Thread-Index: AdnraIHbBxG6vPC0R0eZWjXM4YqS1A==
Date: Wed, 20 Sep 2023 02:17:19 +0000
Message-ID: <MN2PR11MB4285288BBE0F81E94669D614F2F9A@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|DM4PR11MB5262:EE_
x-ms-office365-filtering-correlation-id: d14378b2-3617-4535-5ae2-08dbb97fb752
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DfkRSGMY7pQnX9ZwGWkyDQQKxwhsUqtJwzpNkmAVJNckHEMfTzTG/MA0Ou0VawL0iPMkCa09W9lQHpKJWg5TPpoogClsIRvCV+00mAcaBYoMJTeuvs0zj7GLLAShWkN7g5ZWNREOTrJH54yt2lmzGGNrisODHeUYw8QgsDYj4ld1tTvLUXOpXgAHEbxCLMfvnixsx5228JnzGpuGQg5oh2CMC3WRGHoywKUI5WU+Lc7aOqcfNMJqV463BkDVTLDRFY9AonpznYLeyrTm475jhcPjlvZ2+lGwQgjHxC2v0Xd0/rUJt+DLcE1y+6VRR0mKmpIE1ESsOsA6L2gsUdyLJX+GStodAAO/4Uff7uhE7bnXwo9vgFI4shgVPsilY/nQvp7Uvyw1l9XS9E/2++d5iBjS3bb0ZpCSeBTwafdFu/KKkRUQCILqqlB7hVhtEQQb3sXPg301c8Z/WntUEMw8alqKNKZNgA6iuIhAKRI1pIRV5VLnfW8sjlnYt5MF/OEVIW/sT+7u9ee49N9zQPkoxe+/KluIt83CUWj5x/QeL2zwTEuo/K17ISe8R3G4Vb/wGhdG6CKpwmnlZKveR1U29LSNvsl7GrorRZ0H5BegmBpszk1egN+m1VkSmb+ZPi0fYarZuYbbIKlJblCK8SkiXTlusqBZ6zQx0kxftdM43nvgsxZmIGSWQX45x6m0wpb/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(346002)(366004)(186009)(1800799009)(451199024)(71200400001)(966005)(9686003)(6506007)(7696005)(122000001)(86362001)(66946007)(76116006)(41300700001)(64756008)(66476007)(6916009)(66446008)(478600001)(316002)(66556008)(38100700002)(38070700005)(82960400001)(8936002)(8676002)(33656002)(26005)(52536014)(40140700001)(5660300002)(55016003)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTk4OE9HS3FyanQwcXlORDBDeitDSXNjK2hSV2QvU21HUEpOT2RMTFl0ZEpv?=
 =?utf-8?B?OWhIa1p3WE5ySUp1WlFuczJBa1FEcEVaWXdKdUdocUloTWFRU3lJYWh4b3Bp?=
 =?utf-8?B?bEZJZUVCd09tcGwvYWlwQTl1VzdzYjRhdzFtZkN0aEZwTXBhUFUzMHRIZm45?=
 =?utf-8?B?VVpwZWpPbGVjOHIrYnM2dVVNaEhLYllaSGgrTlBOK1hicVYzM3NNVDRSTWVn?=
 =?utf-8?B?SGtsZ3ZFY01rbC8vTldldDR1blFhb1lHUmhHOU5NYlZkZmJMV3puNjV2a25S?=
 =?utf-8?B?aWFvam9WdklQeTI2K1NWV09MUHFFZVcveWMyMVI4RnYySm5VOUgwS1d6aGNG?=
 =?utf-8?B?dFJsT2trVTVSV1JoMFcwY2N3OG81bXZxZEMrYnVaOFQya3JhdGZqZ0N6dURw?=
 =?utf-8?B?TDA4d1BlajczdVVWUXJlMHJxbVBtZGYzbzQyMDFUV1lNcDQ1aHdQZFNDZzBz?=
 =?utf-8?B?UE9PbzlidlFWeFFlczJIdEp6OXgwcnFMZFVJZnQ5MDcwb1BrSVQwWkZSTXhz?=
 =?utf-8?B?SEJrSUhoRUxoQ0RTc01MZUxtRG0ydUNMOTRQUG1GNXFaWHNzWFFTWUFJMG9p?=
 =?utf-8?B?RDhGSlMrdHUrdGpmaHBZME8ybGZKSjlSZ0pzaHova2xCanFoa2dNMjdCL0Rl?=
 =?utf-8?B?dzZkdkVISlJXVnBUSHlObHVqdDduZzVQZVBRVVRKMFZ6VWlnQ1JUME9NVm52?=
 =?utf-8?B?U2VLdU1xUXczVS9QdlU3dHhrNlBUNGpxNmcreFpJZ0FPS29yOXRTekNHa3Vs?=
 =?utf-8?B?KzhZOGFtUGhOTXVlRk5uZmRjN1BoMUJuTE5naXhTNEt6SHoyTXV4TlRveXBB?=
 =?utf-8?B?TjZZNXAwUWJHQVo5VkZzWkpkb3pOUHhRdkszZ2ZxSzgrTy9EYmYwL2FkUGJj?=
 =?utf-8?B?L1luV0tUY2x4QThFenNEdWw4enZoNGs1WkhGQnFKa0RhQ1NqNDdKb0dpY1ZV?=
 =?utf-8?B?TllEbnZpb0Erb2Jmak5nSkhYUHR5M2N0VHRjYWQvb1cwOWI4ZnFKMVhDT2VS?=
 =?utf-8?B?cTBsSkNmSkdoM2Q0THhjekZnQjhoYWJTTHRNV1d5QlBHREQ3ZlBOcFYrSHcw?=
 =?utf-8?B?RjRNQ0hCRzViSG5CYjE0UU4zcjlRamdVZWlaa0w5TXpUZms5Syt4ZVNSY3VJ?=
 =?utf-8?B?MUtyU1BIV0s0cVY0MWI5KzF1MUtNaEFBaFVzTHpsK1pIT004VzBPOHE4OW5t?=
 =?utf-8?B?YmFsWW5BSW1XM1dXMXF2eXliZjFiSUQ3KzRvTE4wVGkwNC9ZSy8wT04wRDR3?=
 =?utf-8?B?azY4eWI3TndxUDlRV2NjbWs3REJmMHovRkFtMWJxdzdpMGtmTm9RcjVEZUlj?=
 =?utf-8?B?M0JubEc4cmZrTmhiL0tubGhyR215NkhqYm1JQVFqTEhFUzJpeDlodVJ0bWRX?=
 =?utf-8?B?MWYzakI0djROWitVSUJwaUwwWkZDQ1prR0h3R2p4NXpjYVEyNTE3MUVINHNk?=
 =?utf-8?B?bm9TdW5XdVpsODZrZWRsL3M0eUtoWnRwN1M3WGh5VEFsVHA1eHV0MW5vZ1Ix?=
 =?utf-8?B?SXdZMUNPV2hVUnliblBVYThBMDhhTDY4QlFRVE5JTlpFR3pEemRkb1JQclla?=
 =?utf-8?B?dVRMR2pGSnpmeVQ2eGVBcmpVSE81WGViU3F6eU91SmVuMzMrRkRtMjJ4N2xQ?=
 =?utf-8?B?LzNaTURDRUI5bTBlbERZLzZXdk9BL2xOR1dCWUtvRVdhdzJYN2FNM3hvT0Vh?=
 =?utf-8?B?dlg5dTR0b1loZkFkbGU5YUdPREJnb25obTJCMHpZYm05Ymtwc3ZYYWx3Zjcz?=
 =?utf-8?B?c3JpWU1NSVpGY2U1eUpSeUIvVWxORFpmZkk0ejByMUFIa2lBcCtWVkpvWjJN?=
 =?utf-8?B?TGJIZDBZRFQxbWJxUlRrU2pKMEo4THhldmExZEV0cGNmRno5bXNxNUdWZmlW?=
 =?utf-8?B?MjBQNHlWb2k4YTM0TXlOaEdvQlV6UkNxU2RNSktJaHVzSVE1cHljY3R4RFJr?=
 =?utf-8?B?RkpRNGhTMGd2ZXQvcjhWVFRPZ0x5NTdQMU93Y3NHZ2lSczlHaytpa1I3M1Uv?=
 =?utf-8?B?bmFtdGtLZHpDa2UwSjlTRmpEMVAzblN1eGpKcG9WemZYNFZYS0l4NTJmQnpP?=
 =?utf-8?B?ZE1LVEpIMStWbExZZHAwV3I4Mks1VDcvaWwvb3BtMkJPblNSWmdnT2RWODdR?=
 =?utf-8?Q?eXaI+n88sXTrqi7Sv6nQ90rLI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d14378b2-3617-4535-5ae2-08dbb97fb752
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 02:17:19.0618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24KYxLFZ1tWOZulLAceW9j3ALYRUrq5sNY6seIfCnBAB5d/pFlJzEJXiiRi5PBoL20jeFDF2uFPG8zMFEbb9+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgU2VwIDIwLCAyMDIzLCBVVEMgNzowMCBBTQ0K
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
