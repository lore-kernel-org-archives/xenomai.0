Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC310942
	for <xenomai@lists.linux.dev>; Wed, 20 Mar 2024 02:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902498; cv=fail; b=p/8mCFsW5IfcySTUiOV4bLUNtBtBu+dcmAzUGT4FDLNjCTqHcb5eP5WEwOb4JtS6kS0o56gEwye9PiGoV7Grl4FEttunpzbwIBz7IdwnefwnZesZ2OOnQEAmmHp/dYQspB+7DQWImUYIrI7xHFsJSFK16xZ8e/CQc718M2nNkvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902498; c=relaxed/simple;
	bh=yVzjl3WGQsMxnKntmb941kX2GyDMxcFu71UUcExo8CY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G0ADmzkaNMEnTOu8DG+lhf3vAhVfSp8lF4oHvEYvXxGEwwxtbIDbOpbdl3UpsrBnNaHMEI4mfLKFoxjUq2jqsxXuhLdkh/S1vddX/htjiCNvtjVE7m8qXLeLoc23ASBz+0MISgE/WsBHHIZkfe7n5SIJJBMrbeis6K808rsAytY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eHqctACa; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eHqctACa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710902496; x=1742438496;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=yVzjl3WGQsMxnKntmb941kX2GyDMxcFu71UUcExo8CY=;
  b=eHqctACafcV8CDkOuBNRTTWgqoNW/JyORKn/lAiBzjLIiHHYX6Kq4AFs
   CfgEeCTTug0wAj6yMpIzEHi3h8fVzV4Z2tfTom+dIw54uII/vI/G9YcZW
   kic0Iao9FTWBgtLSKdGb1B2htoRY7VImi3A0pyQVzCqai70P7asdyAARJ
   ZH+0f5nn1w0Bhta/XGvtFo9aVpA8svjilXZFekTSy8N3seCn5Yefl5ZUa
   SyNJBn+WzwCmPE8GCaURqnAErJUO8COID98B5fFM+6YYafnVg4X4NGRAb
   EG7zxzcy51NtQzx+BnVpIVqcokXrBF49Fem8qu2QmIIxzPJ33zEJ9D1GF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="8754354"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="8754354"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 19:41:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="13913521"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 19:41:27 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 19:41:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 19:41:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 19:41:18 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 19:41:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTD08lCDEw/1dN7W8AGSRZgO7RCkPG1OhxOepARr4Vc2EYarz3kMxOJZCSFyWgr5Yjx+vSjyoE5XbeAgzQ/VOaIIYitSWhrAhySJIuLPpi0O+dooD0hWZ1y83hqToSMwAxQ6h0f+k6pE4V601EJgn5ZiDHWadECFraEt/uKkICw9f7UdQPWuLbOO1qvHu4bpU5iqOZQTMjgrTiFwuq80EspCMpkt5Hb/9wKvHVEqGv79QMbvrHcanFWAmqwUmpk29gwGCRTAchgwA1iDwyveMYboG/hPQq3h3I7EMzuVCk0Oh/qd5ZTxfFIlWvgA9O/bb92z8iPx7Z/IC3F2EGPh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVzjl3WGQsMxnKntmb941kX2GyDMxcFu71UUcExo8CY=;
 b=dbYoHXk5Ql/uBAcpx2L65eNFRAZmfbmbau03HiUiKlV/YSplLE5TvqNxeZfQIBt9E8CqRJn+v+Y1zqI7Y7HdOZ626mEnKPgKA0QHezzGlWqly27rZui3TtnzJ4PDxt+gPxWJI35NvM+eLJNbsLkexMukSWvmyBv1dv1kERAYKqrqRqbCAwjvfyuIwx04J5kWWMu+1GMi7g8pY2atpUuXccD+BOM1/huz7+rd/09Ig5+S3MPPJZNRUVHscebAq1pH+rp1NwcRNmaaQqM0i73ALYayFR/Aqe90qzDnzJGIDn4f+4FGzTFJlXgQR11fJ7KgHtaR9iwSxVQHZiA+FtUP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by PH8PR11MB7022.namprd11.prod.outlook.com (2603:10b6:510:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 02:41:13 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::19d6:5ade:3ea:583d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::19d6:5ade:3ea:583d%3]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 02:41:13 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Mar 20, 2024, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Mar 20, 2024,
 UTC 7:00 AM
Thread-Index: AQHaenASMUAQxnCjFkiW06mGAX+GPw==
Date: Wed, 20 Mar 2024 02:41:13 +0000
Message-ID: <PH7PR11MB7499C4BB71E159B3AB98D686F2332@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D3E2C96C4F21DAEBE4F2212@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB749988D3E2C96C4F21DAEBE4F2212@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|PH8PR11MB7022:EE_
x-ms-office365-filtering-correlation-id: 966f58a2-4979-4b97-15d5-08dc48873541
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sbwRvWvL84bda00m+NV9OEmXnBir5kphmF/oanLmNU7kPoJ58ypXX4gcWlLfSlR9Spkd7emnKCXWbw66TDCn+qjn8vjxo4cYyuSgimKije5ZslLlGHVV4vGAW5uwr1EpVMDctcWAM0AhqU1Inyrvwea8zi4vfDVxASqM8YqlD3S1TCrLI4IYepm2oUyZaUCIDK+Pg79KVrQosDm4l7WMUOFy9JWzjVm5qgfed7SKJ48fslCyHrpO0W7Lfa62iWgzkaYKNyyVEi0Hysbkrlvh90lHK2L28bKqnwPwIhwy3mvxMeg79Lk9g3ioxp3RQEjSm+oxSuAe0dvldsVqCUyH2kogesR1N1sAUaPjFLAxdAt4yPTXEhggifNfHE5Y1IE4q+1Bs8Bdp0G5DVgLZ6nxh/BZ0rnZGL85rmc0QKKFEV305Z4kMfdY9PkQIIc6YIHkf+MPlhvD5FF6c70gLDSpDGVrGr/0tUSJDql2UBP5O6P1PUcER2neKV8ojnxx2Nlm1sqL6GIATm57Qf1Van9DoRHKCbTYeXwnhRqQsdDFSjYjy7oRUM+jMEL4E+87iAv6gfbvanhEz5aHtVaZ0spXXZBNoWugYP+CyJ0+4U8mZjuYR+5cudxin4h0LmEwBhu8ykTZIN6reDuOm5MX5XjuaROIyXAFkTkNPTH9zBQRbIE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tzd5aHdQV2pPTGJOZVZyOFFPRmtweFZ2YjVoTFJTWFpKYXpQaStwZnI1dHdM?=
 =?utf-8?B?RWxDV3hMNzZLc09BTlJ5QnNTR0hLaWhKWE1ndER3dE1VZU9kTDVjdTcxN3Jn?=
 =?utf-8?B?MHhwQVkzU2NOV2JVd0pmSjRIS0FCRGZuV2l4S0FGZ1pHTEhxSW0rcGhncWtC?=
 =?utf-8?B?UzJSN3piWVRIRU92ZzVLc0V0b0dFQ0RNNkh5N2lkbmhBenBuV1R5UjFEMVcy?=
 =?utf-8?B?dFRrOHB3YWVuQW11N05qcWNRd0NYekVzYWRoVGhrNml0YTVSbkU5TFkvRGdw?=
 =?utf-8?B?WTJrWlNhSC9wZHQ4Znp6MTcwUGRiVWVvNHhPVTBZQ2NJL25XZUJ3Q3N4VW40?=
 =?utf-8?B?WUJvd1ZMZWxFbStoTjdsZnArNktaS3EraW4xNlR0K2c4bm1mWVVOM0grNE84?=
 =?utf-8?B?a3hucWhXSzc0cFIyaWRubm9kMnJOQkxaMDJnaklqU3lPZHZSSnhTRUZqSDJp?=
 =?utf-8?B?RWZqMURITDRjdEtPS0Q2ZVpPQU1GZnVFNkZ1ZmZ5OHRmWXdHMU4wOWFOK3py?=
 =?utf-8?B?QnJDRmhCTGdjTHhhajZGVG1ocnFycnozU1lIb2Zmb0RnbXpIZjFjc2ErR2Ry?=
 =?utf-8?B?ZGsvQy9Jb1VCVjRpMTZxOVBMNktJbWdHdnNvVk5ubERmWHF0QkkyWmFORkZ2?=
 =?utf-8?B?Uk8rSGhNQ0o5dnhoeWoxb3B5cXJTYjNpUHVIUWFRU1Y2NTBjVUhIalZRM29G?=
 =?utf-8?B?OTR0TzNZZ2IyR0hvS2lLTVhNQVhleW5Pd3JsSUJzMWdyTU43aXNWaUxtd29S?=
 =?utf-8?B?MmtUcnl5ZTZNekwrVndaUHR3bU13ZGFIeFRYV1VnejFqc2VvZHhJaDVoRGti?=
 =?utf-8?B?Vm5Pd0ZEMm9xaTVKeFcrRTRCTEV6UTYyL3RBai8wcnZCRityKzhERy9Ldkg2?=
 =?utf-8?B?SWRaL0txcTBxc01LcTNjSU04UWdMREhHdjQ1KzhXYUwxZXQvcjhtZDFTc1gv?=
 =?utf-8?B?UEZFaDlnL05jcG4xZjllM0lJWnVDRElHU3B1RmpRVXkyMnM1NXdEZGxoRnQy?=
 =?utf-8?B?b1J4OFZvVEplM04xcHI1dFlJRkduK0pZNGRzTWRlNmlDc3lTNDFEeHgwV2Jn?=
 =?utf-8?B?TXFwVjdLQjl2dmxYWDE2T3c2RFVEa09hR3p0SEV6MWNIK0N4dUo5MTJqKy9m?=
 =?utf-8?B?UTRjZ2IvV2lMWlBWcndSTlhMRitQeGorTld5M290TUlRTThZNUNCUGhnRlhz?=
 =?utf-8?B?UTBrVWNaS2EvY2c0dHFSS0RhL3F4VjA3ejlOUGJpUXFqZEduY2g4RUNOVzd6?=
 =?utf-8?B?ZUdYazFwazhQZVBiZitjcVNDYklDWEo1czF3MjNTYkZ3TzFkZG51NFhRV2JB?=
 =?utf-8?B?TEl6ZXdtOTdVM2hER0t4Q1VhOEhKSVJBZnZWVk5KTGNOQlAzaUhEZFNSaVg2?=
 =?utf-8?B?WnF2d3pVWUFacXJlVFo2ZzMxSFpxdGlUSERBbGNXSThVU3RhU0JGeTVrallz?=
 =?utf-8?B?THFXWURlVVFESDMwa01BaHlvWVpVMkM2Nk9vcWo1ZVIwQzg5cXZ6S0w3K3h6?=
 =?utf-8?B?MVZpYUxPZFhrNDdQT0ZSNis2NllBWjM1WWw1THltSVEvQVRsVVExcHhvRGE2?=
 =?utf-8?B?WlNoWDQzVFoxUFB5aGliQ2YzS096dks2N055RWVPWTJXTTRnU01Vemxoa0cy?=
 =?utf-8?B?MWRUdzFVNjh4V0lxd2xqK2JKc1A4WkhWeVlNelg5NUN6ZnZPNlU5WjFZekh2?=
 =?utf-8?B?UkdMQmQ2bUFOenFXU3RRRFFEenlBM1VncmN6N1h4NktldVJUc2lnK2hIaUVM?=
 =?utf-8?B?anROUmxHTVpscUVpczhFSFRtM2xsUWZraEZpUC9mSll4TS9tUzdleGplclBz?=
 =?utf-8?B?S3dMV3JQWkFOSEQ2MU9vc0JNRkI1ajBWM1VnS3F1TkJUMG44NjV5VDZsVUJ5?=
 =?utf-8?B?ZlVXYW92azU4ejhNMVVWU1RBNjJDeGViV1RNMjl5d3NBT2kwZVc2N2hmUkxo?=
 =?utf-8?B?Z2RLQlRkKzlxS3BJc043RVUxMUtiMEhNNDhQQTVTaVVEU3RnSzVLVFRDeFFG?=
 =?utf-8?B?aFFyUzlRTmpPR0tySS84R3BYbXJpM2t1UXM0WjJmK0hKY1FDVDR3eHF3R1M1?=
 =?utf-8?B?TTlOTWVJbGxQMUgxdE8wdllROFlaNVlkK2dRQnBCN0cvK1RaWWM0ZFVkMnk5?=
 =?utf-8?Q?O0tE3eS/i5Mp/c1GVRYdYQBtw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7499.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966f58a2-4979-4b97-15d5-08dc48873541
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 02:41:13.0577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3DkeGNnDxP3x7hc/xRv/gpRlqzaHtBALFaccDJoNJd59/QhDDVHgH+B0NFVRHxpYcSSj0IuN13eyRZfPaL7bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7022
X-OriginatorOrg: intel.com

VG9waWNzIG1heSBpbmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0
cmVhbSBwcm9qZWN0IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1
c3Npb25zLiBJdCdzIGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9p
biBhbmQgYXNrIHF1ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgTWFyIDYsIDIwMjQsIFVU
QyA3OjAwIEFNDQpQYXJpcywgRnJhbmNlIENFU1QgODowMCBBTQ0KQ2hpbmEgQ1NUIDM6MDAgUE0N
Cg0KSm9pbiBab29tIE1lZXRpbmcgDQpodHRwczovL2ludGVsLnpvb20udXMvai85MTI5NzI3OTI2
OT9wd2Q9V21kd1MwcERPRFJOTVM5dFFrNTRZMWR2YkZscVVUMDkNCk9yDQpodHRwczovL2ludGVs
Lnpvb20udXMvd2Mvam9pbi85MTI5NzI3OTI2OT93cGs9d2NwazUyYTlmOTZkOTg5ZTdlMjBiNjI4
YzJjMzZlNDhiNjhlDQoNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAzNjc1
MjgNCg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
