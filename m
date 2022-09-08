Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E167C
	for <xenomai@lists.linux.dev>; Thu,  8 Sep 2022 01:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662598846; x=1694134846;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=oJeDHutPS/PglVbCizc85p8goGWcKzbMQiLlYhbrOIw=;
  b=Nq7KFKYVTr0PnSTeEHH2v4qFF1TWScrR9iKTQyjrLMaKw6TdcsRfP88x
   qc4kn8TZkCDhQftrlaC/3OxC622PBLxcy1QniDjYoCjAf5EG47E3S0MTn
   9+QjmsYTYFdEV/65HlBaV1D0dahMQ4wDXPHkp8R8IHNqtYOK+UiEB1Hmz
   MapxhMKo5Xb6sD1D2Ql5Lj4UNzHpCeMkmhd1S0Yid+0fyyMOKkA+IEsJd
   lM7x9z0OxpzLbtSTgJLB2U+2bFD5zKKw+RR++N0/2N0yiZA/AAkh61k0k
   sUL5OOdzK7gZXHFhECfgXSLiUaEhQk26Vyuj/wSrrI4Gn8N/ctSN7fRaP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="295769331"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="295769331"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 18:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="676450561"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 07 Sep 2022 18:00:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 18:00:45 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 18:00:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 18:00:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 18:00:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuWt95GbqsMS2TpjmanHno7KGRh2yDSX96KWjvytUNa1GCzCbRNmnR2zSP4/ChFpLQP8gdpQmTE1blyb+FrP55+aJDgbPsYUwmlU5KIZi0jZS415RQGeu6U0Y9Wpdbped5K4ah4XAWONehVQ40Au0ocd7iPeZSTfAkYqZQIlhnftviA3K6KjRADIVyTlwMqrz+zXmhnvUUfM9n1rNkcKlx5rPf8ElEvpAehdwcZdiwfG4Cvm+nX6Pg4el5MRsX334Om752dD2/GK7pXrxE0Vn1cdCML+gZsRLAUgM+HlXj4YITmSW1BCdkIGqwfOdb4XjU4gEiwwZ4GtQKZe6ov9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJeDHutPS/PglVbCizc85p8goGWcKzbMQiLlYhbrOIw=;
 b=geU0nNotOeDFFR7LPtnnbh/9soR/xiJklXTB7KbEnMkfovcLkrvQrFmiXLSNEj1xTJfjOfe0pVTJK2PM2tEROyuBR1GFiZTZNYmbNFHxNtL9UGIO47N+LY1zomzD+6jveojAvZP7wP9/TFXaCF2VpIqF/NmGehrR32PU7NGCh0+hu48+dqE2JtiHmWlA5JM3O62K6RCKp/AejIM6Z7SQ/wsC9t2jFAOwqzMDEiTMSRQkjUHTT99sa3PEiKVwAiE5plH63K7LznZKpBTN1EuX7/f0TwGSKAquSbRj48zR84bKe+B+EVGrzv2ElLue/+y16YwKIW/9LEpBxKsJYhP//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by CY5PR11MB6320.namprd11.prod.outlook.com (2603:10b6:930:3c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Thu, 8 Sep
 2022 01:00:43 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83%3]) with mapi id 15.20.5588.018; Thu, 8 Sep 2022
 01:00:43 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Sep 7, 2022
Thread-Topic: Xenomai Community Call Minutes - Sep 7, 2022
Thread-Index: AdjDHWYDeaFj+pJYTfuOt64AIr0ldw==
Date: Thu, 8 Sep 2022 01:00:43 +0000
Message-ID: <MN2PR11MB428577F31882AC1B608AD842F2409@MN2PR11MB4285.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: f4cb6ebc-acb2-4ac5-51b3-08da91358e2f
x-ms-traffictypediagnostic: CY5PR11MB6320:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VbGF3LPhtaiXTaGZnET7YTosZ/E3oh5dYSvjpOpnVtiLFsjoDr9G137gnHqZoSrdWQ2ukDkXgJehy5XgsDk0VE4p8i9i3sJhxCALkMJURKnXa1ZPTsHG1RMFSD1QKTTRbZ8FpEUajPe4yAXvtdO/xTQTmxExwSvCza9aA3cnhMNbPWFxt6WKVu1dD5c+m/ZuaI3dAeHDvDyyaEmzENAj7dNNGa+vF0FlNHgnUG4vS2Xhql02GaiYMZnK47t7TafErfobAD/NGNSr/rAkIP1QXLTKoYp/xN29OeWsP6UxWitHmytnlfjBk9Fpr4gNwAl36sybiMFT9yLVyYg4aKs4sJK60sJNlLjBDE0VsOoM5+Q7GqG0ujQC1Kdr+RX3TDNQ8HxkAUn3/vUC4osP52tUPJrm1D3Ho0HxGCscutFW6yATTB0K7JkbniSP6doJlyyQud7B6E8qELvzvp2fz+uEYeAlVJ1r6Be6YqTAQJciXZXTLeD8mzecHIDR9V0y/BSg6rhWbYdrum6FVW/+JLEmAb6JaK/LgcLURMFNdbsAmf7aeOy8z2uSuBj40HWTYZnAlEgq18ujsPiDguh42g7HBC5SFupc+JsUqVVz2lIbCNFnzt+TA3vJmDhxGO07zyA8LzjQFA5flAtADPsPwaxOAcAjgl4i1fPgLDh6LbMfrFKckHisXXFiAn8NlmfDFvLlpLJjtMV0LdYXNttvSHewLB2MDtiyquWbLRGnz2APO0nEtz08g5efui/3UCuqAUC+BRAlfyoVyAAEgwggin3x0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(39860400002)(136003)(366004)(346002)(66476007)(8936002)(66446008)(86362001)(66946007)(55016003)(76116006)(316002)(8676002)(6916009)(71200400001)(52536014)(66556008)(4744005)(478600001)(5660300002)(2906002)(64756008)(38070700005)(82960400001)(83380400001)(33656002)(186003)(122000001)(6506007)(9686003)(26005)(7696005)(38100700002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzM5OWxZdktQMkQzamVlZHpxVzA3RFh3czBrMnJhLzF0SE9CMVEvZ0FIWTd1?=
 =?utf-8?B?bmVPQWV6SExBbDM0OXZOV0h4eHNvL2hSWTdMVTRXL0N3UFdScWFyc3dQVUV4?=
 =?utf-8?B?c3p5eHZEVTVpMGhRK2xjRHlmZ2R6QVMyczdGdEhFbGtLQVBnTDBINk93dzVY?=
 =?utf-8?B?Q1FSL0Zxb2dOdFpBbUhGOUxZZGt1dThaQzR6RTVWcWoyb2VnYUo4ZFdMakk3?=
 =?utf-8?B?WkZmMGRXSXpDM1RoWkFjUUNjUXVOcFJFaVFSb01GczZRQkVWalRmUXF0ZnJZ?=
 =?utf-8?B?OWR2bjlWTXB5dTdEWFZ5Nm54Y2drY3hxV0RYcWVXTzAzanpoWkd2ekt0aThv?=
 =?utf-8?B?T1lYa3NKWFROT09MMnhmd2VBckE5bStFQnhGMzAwMU42NVJ0aDBranlWbVN4?=
 =?utf-8?B?L2ppak1PWUhLa0dDd2tVSDhqUDllME95b1EzVDVkbHQvUzFLNDJZRkRsMDE4?=
 =?utf-8?B?VlkzYVovR1h4TU1XT2VPVmhEU1ZKRUVNN1BGSVdyYjBqM2FzR3IwZmphQ2U0?=
 =?utf-8?B?LzBiS0t4TnNuam1vZmNweEk0WVkyRTRTRWVxUEkwL2N3d2ZieVN1L0hzSUdl?=
 =?utf-8?B?UTVESVRzeFN6RlEyd2haZG9xbFhnYkFvMnU1blVBOTNWQXY1cWxEdkZEUE1X?=
 =?utf-8?B?ZjRnU0JQcFA2QkJWblpyeVFYdXl4RmM0emo0WFAxV2kxaDFUTCtTeHR5T20v?=
 =?utf-8?B?WGlWbUwzcERPNURtTC8rRnNzMWFGMVNWdTl4VlhDVTRuSDBQd3VGbnVLUnpt?=
 =?utf-8?B?em9SakYvTU1tUXlMZzg2ekwwYTExM3FwWlZkUVN1MnZFVE9tKzJ0eG14bGI1?=
 =?utf-8?B?M0F0ZWVwdUprOVJMbE96clk0YUVEQnZQcjNqbUczWmJWaCtuOC9wRGQ4Vm1R?=
 =?utf-8?B?N1lFUUh5aHoxZlh6MklGWmJXOVp2SWdaSVM3ckVVUXE2T29RWjAyVVlyMkR3?=
 =?utf-8?B?K3B6STJRMU1sQmpWRkREOVhpZElLOHJtc3Z1c0dzeENxeXVCVmp5TCtmbXdB?=
 =?utf-8?B?ZTk1NTFRUThtQ0FqaEpsRWNTRldnWlpaYmNTMVlkcWZTUjdiUTdjaUtXNW9x?=
 =?utf-8?B?NVZUeDJtQktxWXRuNWwyLzAwRW5FVkpaaEpEUTVvK3VHeDdXbzcyaHVIdXI4?=
 =?utf-8?B?RWNheXduT2pFRlJ0VG1Fck9za2Z3Rit0bDdjTHo0aFdLOXFYc3JEZ2k2WU03?=
 =?utf-8?B?amhvSVBOOURUSGdUem5UTjNJQnVlak1rS1E5dEJ3cGxhSWdLQ0NjNXdCc2hh?=
 =?utf-8?B?OWJDVk91ZTdhQ3dLWHJUbmZKc1pVN2NXY3V4SDQwa3o5K2ttWnV2TW44U0V4?=
 =?utf-8?B?TlV1cWxqSk9Va0piQVpNQlEybE80eWp4Smt3dExOMzczdU9oRVU2Z1FHMG9j?=
 =?utf-8?B?Q2RTZ3hKUGkva0lMYWtpVnMrQUtEaGROdTNBcGgwaUpIWlFhdG84b21UMnBE?=
 =?utf-8?B?TXJ1ZEZyTGFqbkJlYzJhSUJaNVJmMDZmQ1NCKzNhbGJ5UzBWOGtkSFNTRGVP?=
 =?utf-8?B?WmNvV0lUaCtWVjZtSUlJTEhyaVplVlNXTUh4d1RMajA5N29FdTdkLzhJYTd1?=
 =?utf-8?B?dkhMNjJIdFQ2RmRCVTZOQktPMWl4Sm0zZ2R1WWlaUVpUL2R2bjVpV2ZmemRF?=
 =?utf-8?B?Wkl2cWtjRlR1RWhCamo4Rlo0UkFHRXd2YTFyOWJCUFhkVzBzTG81aWFNcFIw?=
 =?utf-8?B?Rzk2OEJzZlJYOWRVU1gvRmpUdDdtR1E0VVg3Z1k2eFpXbjRhS3dCN0pjL3dm?=
 =?utf-8?B?WEhsVVZueEJXQjh2eHRxdkxzQVdTWWF6bkpyeEo4Rlc5RkJSV2VSN0xLQjlZ?=
 =?utf-8?B?MStpSGMzZm5aSENzYmFlRlAwVFZsV2kzMjhMamJQYy94WkVGc2cwdmZJTjRJ?=
 =?utf-8?B?UXVsY2RQYjkra040em1ETkZaS3Z5Y0VtSCtMNmVxeDBuZ3NTL2FIbkEzK1No?=
 =?utf-8?B?aEFKempRQ3ZMMCttRU5GaHBqbGpML3lGQzlXMFk1RkRSaTB1K0Rtb1Q4dm5w?=
 =?utf-8?B?NUdpYjFsUFZkTUVXZy83dU9wWDlkNXVteTB0WS9wU1NwL0I1VHpoQy9UUXUr?=
 =?utf-8?B?S3UwOUJhYkRDb0xZVkZYdkUrYWtBVzhOeVNrbi9SVjlTSWVOeFhmKzVpVnBG?=
 =?utf-8?Q?+pwkwxLPxMdDGKBQvkTugNQm8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f4cb6ebc-acb2-4ac5-51b3-08da91358e2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 01:00:43.0794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ir/rDH70glMcwrEiSHaZgi8dw9mcq97M53EnUrM3xInfQqMVDdcURU8vmIxQW3P2QLj4OVk1s0Vc9Z6zBPuNsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6320
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBSaWNrIFdhbmcsIEZsb3JpYW4gQmV6ZGVrYSwgUmljaGFy
ZCBXZWluYmVyZ2VyLCBEdWNrc291bCwgWGlhb3lhbiBHb25nLCBZYW5mZW5nIFB1LCBIYW8gTGks
IFFpYW5nIFpoYW5nLCBIb25nemhhbiBDaGVuDQoNCipDb21tdW5pdHkgdXBkYXRlOg0KCUVWTCBy
ZWxhdGVkIHF1ZXN0aW9ucyAtLSBoYW5kbGluZyBieSBQaGlsaXBwZQ0KCTIwMzggaXNzdWUgLSBj
b21wYXQgc3VwcG9ydCAgLS0gb25nb2luZw0KICAgICAgICAgICAgICBSdF9pZ2MgZHJpdmVyIGZv
ciBydG5ldCAtLSBvbmdvaW5nDQoJQXJtIHJlbGF0ZWQgYnVncyAtLSBuZWVkIHRvIGNoZWNrIG91
dA0KDQpPcGVuIGRpc2N1c3Npb246DQoJcG90ZW50aWFsIHNvbHV0aW9ucyBmb3IgZW5hYmxpbmcg
VFNOIGluIFhlbm9tYWkgDQoJCS0tIHByaW9yaXRpemUgZXZhbHVhdGluZyBtaW5pIG5ldHdvcmsg
c3RhY2sgaW4gRVZMDQoJCS0tIG1ha2UgdXNlIG9mIFNSLUlPViBpZiBOSUMgc3VwcG9ydA0KCQkt
LSBEUERLIHdpdGggVFNODQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
