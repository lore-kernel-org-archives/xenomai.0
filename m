Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD3F1847
	for <xenomai@lists.linux.dev>; Wed, 30 Aug 2023 07:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693382056; x=1724918056;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=miRratNlNSBpcQzhQ5zWS8tWduRQ57cZUBT7srCFjys=;
  b=F2gwnLcRGaKY25Fs6BODZXBCsq13HYjM+xJXAub2ROidhD6uJt+bQwEJ
   s1vrgI2xtdJ7KjESexva6IZZz4bFee7qi0acghPt1/WypIPFAOvMhSi9u
   nmOuBGqCDJKc5gqqFlYOjFs3yGfKntKX7+DW+BCxxXexs0qaCjMSPclCK
   av4yCx2vURCAkyG8oMZN+pQm7g4PETTl6C30FufFLvFRCRysR/vWBhE28
   N+sPI2TB66Ey6O6emosKiFrs66vY4IpoA661KAirXXZDModWm1Ee5Gyai
   1jzXgA6OUNWD3Pd/Z5LtWWlQOSRw8Z3PaSBr0YdYKE4S+uRfHBh3kOHCp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="372980247"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="372980247"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 00:54:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="768330588"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="768330588"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 30 Aug 2023 00:54:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 00:54:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 00:54:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 00:54:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 00:54:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgd/od4hK63DX0VFXZsUgNuZGNb1j/9Eq5pBo1UtPgR4uw9BHbPrc8LMXzP6qFh7mg9D4HK7QOjLjGLRniw3S5F7peXXAMvWUgQuT9KvFmCnNHK86FKrcBCspwmraw2yGZmFu84UadgB0UjsNaozU8Jmut+MqqhDg9i01jEm6/ut+gLBwBfaD7WkpqT4TzYZ2+ZMFt73gybDgXUJ1nZkTBToRx92e1A4sxVlai9ONncKRyCQsmPuCCGd4JzMrCoBEzFdrBD4G5dSpf3r0IEBauHoeSuIHTZB6QhURQadH7zdVTrcBGtsNZ8z+ujZgDcBVFNB86la4ZMSDFFcSViQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miRratNlNSBpcQzhQ5zWS8tWduRQ57cZUBT7srCFjys=;
 b=Pdaq2xcgF8aB4jDOiDZg+4wjv2tV61s7xW0znJc44LakF8f4Uwg4b2a1k073+ILxyanEM5lHEfsf57yF3uq01433YC59I0sDgKPfxGUSggeLc31ttQzKWZJDU/IG9bs9M6VfdLXtIX6pfLe+z/TKJssD19NaMgyuaCD9HvhNB5nhc3YYamClUec7CAli4OQWWgioSm1/KbreMGDh1a3N74bqMCCXy2tMg+Ts4vW5P511Kc6hRO6sFjHXKNqhsky/P5jETK1wLOpevxHiSREX9w1WYR2Pd4rgoAEw8VFEsmA6lhgOfSkiWbE1Zhom+rHSygAjrG7bECa/RfCF4BGpaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by PH8PR11MB6658.namprd11.prod.outlook.com (2603:10b6:510:1c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 07:54:09 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9f36:bd07:796b:9d38]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9f36:bd07:796b:9d38%7]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 07:54:09 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: irq storm on sd/mmc card detect gpio interrupt alloced from
 pinctrl device
Thread-Topic: irq storm on sd/mmc card detect gpio interrupt alloced from
 pinctrl device
Thread-Index: Adna7t33BX+CE6qmT/ikjq1kbx2b0QAI4iMAAAETyqA=
Date: Wed, 30 Aug 2023 07:54:09 +0000
Message-ID: <MN2PR11MB4285D68E3408171C181D9C20F2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <MN2PR11MB42855A234CF8BF7D17E9E2ECF2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <d5505413fbbf778aacaeb40effe8cb0ea61107b9.camel@siemens.com>
In-Reply-To: <d5505413fbbf778aacaeb40effe8cb0ea61107b9.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|PH8PR11MB6658:EE_
x-ms-office365-filtering-correlation-id: 6482442b-7890-4170-bea2-08dba92e4b12
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G68q8GEHVU4fkeeYFzTAnqVkkGF0kr1vCIBljX9bhZa6F1ck4hYmST6lqM0Q7XDMMmjoZ/aEM/haqNaANoAWyRQVZJxyVJI2CfQUGqtidNAf9pdICKp5kyq2Lsr0lIrDpdp4IDUKIt5D2wuXku6uTCtrM0cwxz6bW+fhWI1tDswbZQ1S4jkLPMypIgqNpv5prtFzACDuj7u790QNQZEXmMcimEf+uz5/D3xTcPaFxcGwluxwJdGD995jrmmSFkWGajJ5G0s2RamyDq2zLpjhwgFzBoW/xDRZAN/HQVzWsE1Z5finH/V6iIMwqSanfQ3u4vVXguqIW7chlHRFMUhy8Sm+mk98CNrHVPvAtXy0ZoE3o9Z99xy5jcPpPxJmXJbjUjlu26y/ZI2S0TfSPrgQAiyhcTY/I0B4/x/QMI319kLTwg9Y271VQKim3tnXVyKkrZNWX4ajOg5YrcmWIVbIcphedWrcozly8u/9K8vR7f068zujXDZNNYJ2NmZvbIoneB6TX86GDyG7k99OaIvzKnnhHBEirTVMF31OD/2vnOUUZYHZzYfKB098OHyhj8NMvCvWJi6CxILTiYBHaNA9p5wr9KruAxg1vf+tAl20F2fEEv3bx3KaGuSvvMUke7Q8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(396003)(39860400002)(186009)(451199024)(1800799009)(9686003)(7696005)(38070700005)(122000001)(82960400001)(86362001)(6506007)(38100700002)(110136005)(71200400001)(478600001)(83380400001)(26005)(33656002)(66946007)(76116006)(66556008)(8676002)(52536014)(8936002)(5660300002)(66446008)(316002)(66476007)(55016003)(64756008)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXFrdEppc1Bya0xuMnpwekNkcTIzZE8rSGtaYnRoQk9hS2RZTk5RZkNCVjl4?=
 =?utf-8?B?SVlyMmljZ3dxc0ZzNWdhLzNFVzhOcmZWaWZWbkZvczRWT0JIZ3VGb2RvRFI2?=
 =?utf-8?B?b01jaVJsQmQ3Szd3bitycXdIUXIvaGRaWGlDdVppeFZDWm9jNlFMSDRVYVhl?=
 =?utf-8?B?bWhCQUhPVEUzZHdsNk83NGt0dzZSaDJnVWhrQUpHLzdjbDhqMnJVcG5BaVJP?=
 =?utf-8?B?Wm1YMHRrMjR6citldXJTWTJYOWVRcXI3WGhjQ0NTQWd3Qkx0K0pTOHptLzdK?=
 =?utf-8?B?cWNORWxNdC9QRENLbWNFWmI0QlE3Q2R4L2FWczFIczJwQkhpbHlXa1pUMW00?=
 =?utf-8?B?U3B5R3hpeDQzWVBOZ2sycmpQa0ZqUVc1bmFzdEF4VmZDSVVXZy81RTI5YWIv?=
 =?utf-8?B?V3ZsaGVLNVMzSWYwbDNhL2MrRy8wMkFkYTlIOS9qVzUyVGlqTHArVkpienVl?=
 =?utf-8?B?dWptTmZlRGhZZkpCczdFNHlnYmNNS1FJcG1SdldHNFc1Zk8yd01ZcGRLdmg2?=
 =?utf-8?B?SUpkZFd3bXdXSW5nZ3VDRU5SNllMbXRzNytMMW02QzcrTEo5RC9sNWJ0K3l6?=
 =?utf-8?B?NTVMN0QxYVBmZmZ1ZU9KTFNCQkRrUnAwRnRwcEEvQnZGYU5EVkJUeldxVVZX?=
 =?utf-8?B?Y2xuamtyZXhGSmlWSXhrV01FRlBYYVl5bzR2REFrUkl3QUlRc2RsSXkzcyth?=
 =?utf-8?B?Q1pobG4vYVA2eVJSK2p5N0owR2tETmRoM3pXdnEwOXppMlZkdG5VN1BhdUFE?=
 =?utf-8?B?RTdDSURadk9sU1AzZ2ZsczRBMkN2eUFGSVFhbktsc3hyNVpCL1JNOVhCS3Fs?=
 =?utf-8?B?MUJSTE5wL0lmT01sdDlVWDNVajdqclY4bVVVUUdHWlRiZVBDVWFaODR0SHhi?=
 =?utf-8?B?VjJ2K2lYcXBhenZjUHlINjBFT0QxZ21kL3JxUThxMENjSUpkZzI4S3RLdlFZ?=
 =?utf-8?B?RDUrcnRDMlhoNXJHU0M4VnNxNDgyRjh1QWJnejJFd0JkOFc5VWxnZ3ErUXQy?=
 =?utf-8?B?NkVYak5xZDR1Q3JyNVU2R1graGo2LzFueHo0UG9pSGlTQnJGSEd5NjVZSzBM?=
 =?utf-8?B?WVRVcFR1amxpNUc0bEZhdWlRQ3ViZmpJcHRtczRnT3c2NlhXTkV4dG93QUls?=
 =?utf-8?B?UzFMTW1ZKzlpeS83bSt4V0ZZOUhhejZuVW0yOTBRdDZON2hQYnRrNHRtUlZr?=
 =?utf-8?B?Z1hhdDRPeTJZRHF0RVVJcXRCb1lhN3g2SXVKdGVHSHFGMnFvL0hsc0J6MEpZ?=
 =?utf-8?B?T2xqeEpGUlByQkh5NEpWTUxTaWpDa2Y5QjRvUVdvODdTdG5UdnlXZlFZT3Vt?=
 =?utf-8?B?SVRHLzYwYjFscGxFM0RCcXAwU2VacTBJVEVwclZRM3BtYm1TUjlDTWV0WCtZ?=
 =?utf-8?B?SXQ0c0J1RkNGa0JUa3RXMWpyZjZqUW56a3JZbWxEWlpIMVBxWE45a2RDWEIw?=
 =?utf-8?B?MUhiQnlLRWNhaVNHeTNqSkVDWlNRSTZxSkpzUXpaZkNRTHpvM1huVXVKejlH?=
 =?utf-8?B?eVJpL05CZFAzQ0svRTg5TlhrMHY1RUpCN0Q0Zkx1QVJ4QW5UM2s0WFN0S0Rq?=
 =?utf-8?B?YUdFYjMrYnFMaDZCMDVPM01YUmVwemo4TWpzanlIWEY5MzRCRXIvdXRqVTYr?=
 =?utf-8?B?WDlqTVBoNkF3WGZxTGM3c3ZpRi91c1RXY2xsYzZjdGZLZ2twNXVrTVFuckxi?=
 =?utf-8?B?K05tM2g0UXhEaXh0M1Y5RU9IWlZ3QmMzazF5VU1sYTF4OE01KzJDaDNFN04z?=
 =?utf-8?B?dGt2REhGemdiSXBrbCtEbmNkWGhPaG4rNmZTM3NUQTIySWQvdFF6L0N2RW1C?=
 =?utf-8?B?Z3NpT290Q3lsa0JURUQ3TTFETFJ1KzFvRUgvOW5LYU8vN1VzcGRLTXZqdENB?=
 =?utf-8?B?ckZ2cThaSFd2RWhPWkNBMGlZYUU5TmxDVVZGa25MT3EyZ0dJci9taFpZV1JV?=
 =?utf-8?B?SUh0Mm8rOWMrdFVOczk2N2NDeWErcFR4ak96bWdud1RqODZNWHRnV25RSjNM?=
 =?utf-8?B?Zm1YQmgxbGV6bGhvQWsxWkplRXBnMy9lVjYyRkhTMFhyOVFaWmZtRHh6UW1h?=
 =?utf-8?B?K3hWRE13Z1h0dnFpck9QZCt5T3kwM0ZCZW9ldG1JQTZuL0p4Nk5hY1cyTThM?=
 =?utf-8?Q?zE6jAHrNyUl8oZ5wmyaEqju0g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6482442b-7890-4170-bea2-08dba92e4b12
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 07:54:09.6149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9I3+t05YFsCM6yoIZxWXRwfpAbSOxmHqt1d5p6zGcNZ9ePhsyqweKBZFEkFERgh2Q1MaiBLmv5R1JY+I07xPFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6658
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEZsb3JpYW4gQmV6ZGVrYSA8
Zmxvcmlhbi5iZXpkZWthQHNpZW1lbnMuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDMw
LCAyMDIzIDM6MjAgUE0NCj5UbzogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5AaW50ZWwu
Y29tPjsgeGVub21haUBsaXN0cy5saW51eC5kZXYNCj5TdWJqZWN0OiBSZTogaXJxIHN0b3JtIG9u
IHNkL21tYyBjYXJkIGRldGVjdCBncGlvIGludGVycnVwdCBhbGxvY2VkIGZyb20NCj5waW5jdHJs
IGRldmljZQ0KPg0KPk9uIFdlZCwgMjAyMy0wOC0zMCBhdCAwMzowNSArMDAwMCwgQ2hlbiwgSG9u
Z3poYW4gd3JvdGU6DQo+PiBIaSBQaGlsaXBwZS9KYW4NCj4+DQo+PiBXZSBmb3VuZCB0aGVyZSBp
cyBpcnEgc3Rvcm0gaXNzdWUgbGlrZSBbMV0gb24gc2QvbW1jIGNhcmQgZGV0ZWN0IGludGVycnVw
dA0KPmFsbG9jZWQgZnJvbQ0KPj4gcGluY3RybCBkZXZpY2Ugd2l0aCBYZW5vbWFpIDMuMiBEb3Zl
dGFpbCA1LjEwLioNCj4+IEFjY29yZGluZyB0byBvdXIgdGVzdCwgIHRoZSBwYXRjaCBbMl0gd29y
a3MgZm9yIHN1Y2ggaXNzdWUgaW4gb3VyIGNhc2UuIEl0DQo+c2VlbXMgdGhhdCBoYW5kbGVfZWRn
ZV9pcnENCj4+IG5ldmVyIGFjayB0aGUgaXJxIHRvIGNsZWFyIHRoZSBpbnRlcnJ1cHQgc3RhdHVz
IGZvciB0aGUgTGludXggZ3BpbyBpbnRlcnJ1cHQuDQo+Pg0KPj4gSSBhbSB3b25kZXJpbmcgaWYg
dGhlcmUgaXMgYW55IHNpZGUtZWZmZWN0IGZvciB0aGlzIHBhdGNoLCBQbGVhc2Ugc3VnZ2VzdC4N
Cj4+DQo+PiBSZWdhcmRzDQo+Pg0KPj4gSG9uZ3poYW4gQ2hlbg0KPj4NCj4+IFsxXToNCj4+IGNh
dCAvcHJvYy9pbnRlcnJ1cHRzDQo+PiAgIDE0OiAgICAyNDQwMTkwICAgICAgICAgIDAgICAgICAg
ICAgMCAgICAgICAgICAwICBJUi1JTy1BUElDICAgMTQgICAgLWZhc3Rlb2kgICBJTlRDMTAyMDow
MCwNCj5JTlRDMTAyMDowMSwgSU5UQzEwMjA6MDMsIElOVEMxMDIwOjA0LCBJTlRDMTAyMDowNQ0K
Pj4gMTI4OiAgICAyNDQwMTkwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICBJTlRD
MTAyMDowMSAgMTEyICAgICAgMDAwMDowMDoxYS4xIGNkDQo+Pg0KPj4gWzJdOg0KPj4gZGlmZiAt
LWdpdCBhL2tlcm5lbC9pcnEvY2hpcC5jIGIva2VybmVsL2lycS9jaGlwLmMNCj4+IGluZGV4IDZh
Y2E2YzAzNmFkYS4uNGQwOGVhZjA3NmU5IDEwMDY0NA0KPj4gLS0tIGEva2VybmVsL2lycS9jaGlw
LmMNCj4+ICsrKyBiL2tlcm5lbC9pcnEvY2hpcC5jDQo+PiBAQCAtODY5LDcgKzg2OSw2IEBAIHZv
aWQgaGFuZGxlX2VkZ2VfaXJxKHN0cnVjdCBpcnFfZGVzYyAqZGVzYykNCj4+ICAgICAgICAga3N0
YXRfaW5jcl9pcnFzX3RoaXNfY3B1KGRlc2MpOw0KPj4NCj4+ICAgICAgICAgLyogU3RhcnQgaGFu
ZGxpbmcgdGhlIGlycSAqLw0KPj4gLSAgICAgICBpZiAoIWlycXNfcGlwZWxpbmVkKCkpDQo+PiAg
ICAgICAgICAgICAgICAgY2hpcC0+aXJxX2FjaygmZGVzYy0+aXJxX2RhdGEpOw0KPj4NCj4+DQo+
DQo+VGhhdCBkb2Vzbid0IG1ha2UgbXVjaCBzZW5zZS4gQSBJUlEgc3Rvcm0gbWVhbnMgdGhhdCB3
ZSB1bm1hc2tlZCB0aGUNCj5JUlEgdG8gZWFybHkgb3IgZm9yZ290IHRvIG1hc2sgaXQuDQo+DQo+
QSBmb3Jnb3R0ZW4gQUNLIHdvdWxkIG1lYW4gdGhlIElSUSBzdGFsbHMsIHNvIGl0IHdvdWxkIG5l
dmVyIGJlIGZpcmVkDQo+YWdhaW4uIE5vPw0KDQpBY2NvcmRpbmcgdG8gdGhlIHRlc3QsIGl0IHNl
ZW1zIGZvcmdvdHRlbiBBQ0sgd2lsbCBrZWVwIGZpcmluZyBpbnRlcnJ1cHQgaGVyZSBsaWtlDQpm
b2xsb3dpbmcgY29tcGFyaW5nOg0KDQpBZnRlciBwYXRjaGluZzoNCjEyODogICAgICAgICAgMiAg
ICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgSU5UQzEwMjA6MDEgIDExMiAgICAgIDAw
MDA6MDA6MWEuMSBjZA0KDQpCZWZvcmUgcGF0Y2hpbmc6DQoxMjg6ICAgIDI0NDAxOTAgICAgICAg
ICAgMCAgICAgICAgICAwICAgICAgICAgIDAgIElOVEMxMDIwOjAxICAxMTIgICAgICAwMDAwOjAw
OjFhLjEgY2QNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo+DQo+Q291bGQgeW91IHBsZWFz
ZSBjaGVjayBpZiB3ZSBjYWxsIHVubWFza19pcnEoKSB3aXRoIEhXIElSUXMgZW5hYmxlZD8gSWYN
Cj5zbywgSSBoYXZlIGFuIGlkZWEgd2hhdCBpcyBnb2luZyBvbi4uLg0KPg0KPkZsb3JpYW4NCg0K
