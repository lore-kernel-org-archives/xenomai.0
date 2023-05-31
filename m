Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35881A21
	for <xenomai@lists.linux.dev>; Wed, 31 May 2023 02:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685500995; x=1717036995;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=nZMLz4WMb9S1aSilZD02sgVqxgQGy43wkf4w3ESQHUQ=;
  b=C8IpndDy+Yrf22nxiY3PIM5hlA3WhyvGuMXx+HLCo3DW8VlMVKvVXdNZ
   TvKoFGFFAFB0lnRl8G55kbLCF1oy+g/acy41P12zm6IgHM0WgJuXCxyTR
   hAasgZlXRqi0rAcBmxuOoYHX0ikVFL6yQ7YSVyD2DrxENNjcZR+9Dkss/
   yVSYuMAMu6qb5iHZ0FWFpGqj5oiRsUK8HfCM3dztxWTZEe8FXeG6xjKmU
   3yc1DFWFRU1xmBPHXgPaG1zdMbWOsXRUQUwGbppOKJv/xHlzInRQumm0T
   3LETSlC+oY78oRpunqRUcL+6M+GdmD2nWTZvH0oZCyDsrv6diIDg4G272
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="358374836"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="358374836"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 19:43:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="700907426"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="700907426"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 30 May 2023 19:43:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 19:43:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 19:43:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 19:43:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 19:43:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1Dwp5iAwzGfjwe1w6e8ncYT+nTTPVeH+bIJ2iI0DJt7jcD/DecAYxRiwatMl/qb49KFgz65JD50FDiN3EcQt7P4sJNU0PyoNLZn/GtzvDogQONV+Lja38+6j3lfWThowMjeblayDYye5YLdmJ3qWO+NzQd/oIZC7nyrIe4hT0rp3CSSFFYZzJpAtZsZVQdn0HrOU1eBNbJwCWFXPLgO4T/rUFyD47ttqQowjTWrB6EqoeMhv6oLWwS48f0y5PMzlznZlF8/FT9XYRFbtvdC8rZM6vXaMPXrHWWJvLkkMXa8yvnpa6PVyQkZbHxbysqfRffH1tsLqjIZOUJe4GtGag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZMLz4WMb9S1aSilZD02sgVqxgQGy43wkf4w3ESQHUQ=;
 b=G4RlIeFSq2qJgLa1NJzPn/WmE5DZW4t+8mhteLHtB1xiCILhLQB1OgSNX/KBnZsKZDGQW+lDCA2gCTXu7kRB3+F6PX+p3cpEwK1+4rcdeDZSs5vLwDap8gSxytsa3t1hS86fISaWvJLrTG6gAa1JtsjvKsjitYH34twKStR6JByPt0BmKldPCm+2H4Ek21Ii4dte0f83RAuqEOjc6fEswcwEk3qVXkIytsaGedP8D7qiSJ8hN8QAxzcXAmQ8WFh74j6NfStP1X+SlpErHLw7Un6zBZ4VKzKySPkSZQl2ce4pQMv2EN5WrQs5SvXhxbZ+aKgbN8MylK49B4LnkyrpZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by MN6PR11MB8171.namprd11.prod.outlook.com (2603:10b6:208:471::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 02:43:12 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8%7]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 02:43:11 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  May 31, 2023, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  May 31, 2023,
 UTC 7:00 AM
Thread-Index: AdmTaYSdWAeCSTwRS6aDDTEbj6c9fQ==
Date: Wed, 31 May 2023 02:43:10 +0000
Message-ID: <MN2PR11MB4285F4C28F6677FC031B6D7AF2489@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|MN6PR11MB8171:EE_
x-ms-office365-filtering-correlation-id: 45080871-cd16-4eaa-4ca0-08db6180c5fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zBX1uYyjFD1Bby77Xitx6CvI//IqtUL5QnD4TZcY2GQ9m6uOxJbxw1p90XZHWHtYDbrEWyTT78oFdDD9sCDUvsWQWHd68lNrxeBchYzuJwIbKOlP56RUjxTqDPFi1kuvrj/zoMvPyHTdvQ2wBqAh+Qf8Un5gQlk1RfnrltzrR/6LncZaf8Vnq/MeMsxBgZydjCU4MzVzvpi0hg/FmXuI+HkC8S3YM16zJgc3sBhoCf2tvCm/9hihGtW4nRQjYnUqEG3VHR1zVv5zkr80hWz0yYwlAfxm/c1T44RV3T7YpeUuPN1bfJXR9nZxwvK7rNFpxlCz8kukOvcZ8/BtNy48epWV+uWLJAmofJ12LywFxW60fXi9ulwHGCKf1PbLIMwJuxWRuZNTjHCxQ7Rird8CSfvwQtIrfrkldxM9QqqQmFyofT8DmcMd3iKoBI29Wh2B5XCdZkev1GzviOGFHbLf/EsWh/ypq2v/8Ht2F56MMTJDPlAjl3OhUlT3fyAOkSomNcLp4oBt0XYUrX75jZqY4/455cYVRf7jRCy2GcNJXi7TeCdX1psTB3zKUb0wbWllc2DR9esVXAXLgY/8iPuq8x8wLD/dhUoAZf7Z1lcgAso=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199021)(6506007)(9686003)(186003)(2906002)(478600001)(83380400001)(7696005)(8936002)(38100700002)(82960400001)(8676002)(41300700001)(122000001)(966005)(55016003)(64756008)(76116006)(66556008)(316002)(33656002)(5660300002)(66946007)(86362001)(71200400001)(66446008)(38070700005)(66476007)(40140700001)(52536014)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clZMNXZYOXZ5MEVlcG5ZbktETmQ3R01GbitqTS8xS2xLY1BQTHo5dFdQbmZZ?=
 =?utf-8?B?NlRjOUpiR3l1OUFVaGpKTkdMTHd5cEd3OFpLSXl4UU5yOUpkQk0wdHo1eGVm?=
 =?utf-8?B?SEgvMTg1MHBlNTN6S2E5d1hNVGNQZ04zbDJNOWRyUmdRREg3Y1hpUE1FZXdx?=
 =?utf-8?B?MnlpVy85MlZBZUd2TmpQbG56OVQ1WWQ4b2NnNVhFM2t3cU4vTDkvTGtUcTd4?=
 =?utf-8?B?MUREQ1pTT0tVbTVuYk5PU2V4cmhJVnV5amZDLytYSS9CaTVZSHgyZUtqaFdZ?=
 =?utf-8?B?eFd2NUpaOHl0V1pEa2pIRXdwODNJa0RKRm82NThaRUU0YXRWVUMwSUFCcnI5?=
 =?utf-8?B?ckRhRTUybHR2cUFsMTdOUXBUZ0dncllKejJ3WFRFb0RGaENJNENOL2cwSGdO?=
 =?utf-8?B?RzQreWdpNXhKZXZralE3cWsyQ1pxaGFGWExsUG9INVVDa2lCRXd3eG8vUUlq?=
 =?utf-8?B?MjhvdzFBWHR1d0xXbzNpc0U4My9RcVpzS0RrcTlSVUt6WHRUYWdDaVRBSVUr?=
 =?utf-8?B?b0NFR1h2ZXJkRUViY1hiSHVQanRIYWg3bEhJclVKVnFtams5bDNlMlBqb3hY?=
 =?utf-8?B?OFBDL2V5RXUyZS9YUlRUeUQvNFZvTHNqM1BaK3drWjYxdHFsenpENTdNWlpk?=
 =?utf-8?B?Tk15WmJ2K0hZNGlRMEZwVWduNUVwSENXYVg3cmNCblAxVVVZRjZoN2xpYUJU?=
 =?utf-8?B?SitlOGxOQ21mb2NEUFdJZ3Fxc0dncVRQTDdtdjJLOHRCNjZkSnorZUhOODd2?=
 =?utf-8?B?Z3hVeHhKbERWbkJ4M0VvblltaSs0UHQzeUlUVTJKR2FpT25uNk5obGFwMngr?=
 =?utf-8?B?Q2cvYlQwS0lCZlhYZk9sNWJ3YWlvYkFSUEtHaG5xSllSVFFyZ0tTTHdIL2xS?=
 =?utf-8?B?dHBlMlJDTHg4KzhsUUoyTXlJZlExV0wySmI0Kyt6Q2tVU2drcHBKMWJrSnhU?=
 =?utf-8?B?QkdsVUNsNmdCVFFLMUo2TC9SSUZGL2FSR1o2eUZwN2wzc3dKcXNHc1ZUMnlG?=
 =?utf-8?B?dXN6cTd0UU1OVVJkS0F3alFITXJLa3pRcjNMaHhqWGJicjEralF0aXpsaG5j?=
 =?utf-8?B?MkEyd2k0QlZCbW5YbDIweUdybW9OeDRxVHNzd3dKNDN5c1IwQmJkaDBJeWRq?=
 =?utf-8?B?ZklqWTZLODBiYVpwN2M3eHFRdWVORHVCNU5BMEV0RjdHdjgySld6dnY2dUJY?=
 =?utf-8?B?QVBVWjh0ZFUrOUgrSDFLUkRNR2dYUXdtVVVVR1U1dXdJaWtXSEdrQjR1T1M1?=
 =?utf-8?B?WDNUZXBUZ3VqaW9OOVlIMVdhOXNYU29oVHpxQWNvaU14L2IwMGExb3lyazg1?=
 =?utf-8?B?b2R4bXFZOGQybjJ4SW01UFhUQ0U3Y3dubisrd0V1MDVOSjlvbTlpUUQ2Z1Y4?=
 =?utf-8?B?VlgrdTJSS1ZZYzN3NEFHdEJ2NUlqYURKN2R5cWpxVEZOR1dPZ0tqR2FtWFIx?=
 =?utf-8?B?REszVkZHSHBZV2xyM25OSFg1ZEFrQXlQNitELzg5azNlSVEvSzBDcW1ndjFN?=
 =?utf-8?B?RWh2RU8weXFMMUlSKzZDNnhpMG5TaVZqSXlpa1htcHUrcmMyKzlZREJxZzhL?=
 =?utf-8?B?K0p0VVhoWVkvRTdWQzd4T3pnL3JSOWdyK0N4dXRETkw5MmF5NVJPZ0JHa1ds?=
 =?utf-8?B?OFRjQndlQWNXNjcrTyswWDIwQW9mczYyd2RzOHRWVW1EdVdxb3BYeTFMK0ZG?=
 =?utf-8?B?c1QvRVovRE4ySVB2MEY3emNiWDF6ODNDRlh4cVpYQytsMzl1ZFBDSC8va3FC?=
 =?utf-8?B?bUZwZWNtaGswRWVPWjZVUUx5VGttT2dmbk1Td0crR0hwQTFTYSswcTQvWEMx?=
 =?utf-8?B?d2VteTVhZTRSNWFjZ3NtbjFxOWhsSkxnaVNKeUFnMUlCcDhramRKSnlnUEc1?=
 =?utf-8?B?ZGZvemNpQ1lEbElSbnRId0NUeTlWTEtkb2JjWkE2N3dTRGRpdVZDdjZrbTBI?=
 =?utf-8?B?T0lqVU1jQzRiMjVJUmlVNDZaZU1HdWlKY29wV3lVam95eXVJbjJSQXNDMTRw?=
 =?utf-8?B?dFpDSkpESmk0eG83T1p5ZmN4djBRWVo2UXdEend0eDdOQkIrNG1YMldXdHoz?=
 =?utf-8?B?TkJ4bDlBM3RDNFM2ZytkYVJNSnhSRlZ2ZWJ5MHZHVW9iMTlhT05lY0RyYWNu?=
 =?utf-8?Q?IlJY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45080871-cd16-4eaa-4ca0-08db6180c5fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 02:43:10.8168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2bAOawbLEs2xxMkXyePKqS1viIoHbmtrecr0YrAzX8epgPJgh5kzMHl1ko1fBxyHlfOZEuCu2p6tEu6ArCj3gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8171
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgTWF5IDMxLCAyMDIzLCBVVEMgNzowMCBBTQ0K
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
