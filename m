Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87F41847
	for <xenomai@lists.linux.dev>; Wed, 30 Aug 2023 07:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693380773; x=1724916773;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=+3pdZFQZUG30VtQ+hqR+Ly86cUifCaVxQChg1GDPQJw=;
  b=iK4rUkHonhRL5e3IQHe3Zvk3BYGacPeH4ISvd2bRaqQws6N4enxo3glX
   AeQY19cZEtEODHDtZUh3k+8JH4WWhB4/NnlGAWbGgSK/wCJY0p1hTGxoM
   B4cc6xKF8dHO4GErtub8p51EHcPkEdSVy+O6qePP+aH5H6l/dXjz4LvNM
   N1L0gTK61h8PzbH6y4EGqsjCEWVh0DcU36q938g+oHZLahXPLpUQ//f9R
   B4bNJ3xcDY3cVrvpt2Yy60eHBOY2wRUHqoi01STmjLTpWNl2BBG5I/OXh
   NpylASedtqQe/hhy5vfICHZH4BzMygQUgyaiE1YbWmZ25UlpkEI9H25if
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="360570928"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="360570928"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 00:32:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="882628938"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 30 Aug 2023 00:32:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 00:32:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 00:32:52 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 00:32:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7JJrnBf7Hxq0bd8v4CHQv1jFcfHx3dGtdTAil3vvJRr6qmQCry8D2dfcaIcZazURXuaYj1uUhRt9am7yCSHWgiNuzpHlcxmJfMKSsEjZIaLT5HOf+6Chu75tTvoATSnoS23bEd4Wb0aOPVa8rVx4mHfZSw9YEBxpvx2pigymCEBV+B1ax7TvASI8SFyw1Y4ABC+FIO/YOIwJ8soHhRT/vIqmbli9j5NxEcOiGZzX9GQ/jaOJxE5Pb3fsxbbiMM2X6TjB8NRRGuj8cH808cS/n6f2hSCHCTcoFPg6KDs4HL3ay8LDiyFHIHJvpKsKChwP+Jt/PV6hKC2yxuz8NWwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3pdZFQZUG30VtQ+hqR+Ly86cUifCaVxQChg1GDPQJw=;
 b=XG1w2oUl375Y2yMFmcep/b5xAt2ut4V2IwKLE/jF6yIcJ2qGW8GWONL9NryeyVBOoAbx4NMzfeTj6tbbDSbP31dJMCfmc3/upBNFFuCryLEFfJpzu5qsJbDW8vrNJD28cMRGO7r6DWH/ntH7XIMc8mJckP6PowHY1L5lmNuH0zuRESwinXoRNCcv2M98ujmWCEQ/lS8l7bc5mP5NB2dOtvUOC9BX+0YOvnEhtGeATMYuXbSLQAiBncKBT/kvqkm2rMXrXHEfhShw1dMfL6VUBTIKmp4xlKEEdjZRxZmwVtWwh6YUSqhlKkgOiz7L1Rdt5qrd2qp0IYXwUMpTLMaXRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by SJ1PR11MB6081.namprd11.prod.outlook.com (2603:10b6:a03:48c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 07:32:44 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9f36:bd07:796b:9d38]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9f36:bd07:796b:9d38%7]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 07:32:44 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>, "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
	Philippe Gerum <rpm@xenomai.org>
Subject: RE: irq storm on sd/mmc card detect gpio interrupt alloced from
 pinctrl device
Thread-Topic: irq storm on sd/mmc card detect gpio interrupt alloced from
 pinctrl device
Thread-Index: Adna7t33BX+CE6qmT/ikjq1kbx2b0QAIly+AAAB/6eA=
Date: Wed, 30 Aug 2023 07:32:43 +0000
Message-ID: <MN2PR11MB42852983D928B17ACD55F44AF2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <MN2PR11MB42855A234CF8BF7D17E9E2ECF2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <30b0a905-f652-41e4-babf-030a861c8051@siemens.com>
In-Reply-To: <30b0a905-f652-41e4-babf-030a861c8051@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|SJ1PR11MB6081:EE_
x-ms-office365-filtering-correlation-id: 585edcc6-cf9a-4573-ecdb-08dba92b4cd1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RoAjKCHDJaJy7JD+z8SdZWR6iyvqwLM9HqJNyVyMtwXIvIAA1tPeUwYnQGKvD7nPPQHbsCu4c0tLkVze1FWpgTkntrmvVrVFN4wdi8GuAiMoKD1Mfa6ZAQt2bAs5ifZlf7+hoKbEQW9fNuLqsEr3ri2QK/iCIqiyf7rZqVwgZh/HSqRTUmjWLcXxV+1syBkB+pRl/foXHL38cvJ+UhZFsR8PCj0iO/n/DPq7+dPl5hutB4sFdhDkKDYkghxXozfnft205v184bIdGdfd0EGRcAzihJBzYdWrtN24VGnEyTW8aU5rPOiWii4IZyv2bGYAOzFWPiejiYQIhTxgUrVGEa5JLfpIbwWqhXrDPsWymL0M1rN34ByDBoUwKj1AFJI8cFbWrzpXDjxwpKkQ8aHyQjcyh9Cb00yA4FTZYupJ4DiP1XGzaJNx0qoZEx8FTS5rylXAzEAjdwxyrQLaaJ3dawh8y2bRuODAO5ZuqQGbtLFtOBrdFOfLA0VYKPBwKKmODcbyDhQaBpwmUkfVRWnOAGuxk7GMdQb49VuafF0qxRMO2M4QJ8oa82/jTX6Nrm94PfZfuPfTnZBGsIp0gM5DFPDgs5h/302jzyNUPqaHWOBYVOwzOGBJDH9WFcbjqE7l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(396003)(136003)(186009)(451199024)(1800799009)(55016003)(71200400001)(110136005)(6506007)(7696005)(9686003)(8936002)(66556008)(5660300002)(2906002)(82960400001)(33656002)(52536014)(38070700005)(86362001)(66446008)(66946007)(316002)(64756008)(76116006)(41300700001)(38100700002)(66476007)(8676002)(122000001)(83380400001)(478600001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFNjbStGb3hUd0FMOWRtWXJGcXNPa1lGZEFPUUtkL0VTWDF6cE1MRDVkMXR3?=
 =?utf-8?B?MjBCc1gwVStWSVNyYjRyY2QwL0VsUFI2M1NEK0p0VkxET1M5VFJlS3ZHZlNZ?=
 =?utf-8?B?Q0o3QTdFVmpOZVNHUEJKODN0L1plMHBlZlZUOHdCYWtTOWpmUGZjbXNkTGh5?=
 =?utf-8?B?Q29LeGJJS3RvR3V5cjhyekhRdnJtbUErVUwxUkZWcG9BREdqSVQ4V09xNUNK?=
 =?utf-8?B?dy8vMDVBMjRjaTlvSjdxVnZiM2dJa2R0OStDcW1MbTAxZ0paZVFHSlNCVU8z?=
 =?utf-8?B?cS9tcnpJYzlGZDdFTWJ2K0xqQk9kc040eW5PTzhwRGc3MEFsVGh6QmNwaEhW?=
 =?utf-8?B?MHFtOUVPSjNXVzVrSmR0RWFIdnpYZHYwWC9NV2x3MVNZVTFCWlRCRmhna1gx?=
 =?utf-8?B?ZTN5UWM5Z0VPVzc0TmxwL2IwR2xxT3pqTGQzak85S3BJNVdPNnJWa1VxZEpm?=
 =?utf-8?B?dG9xY3E2UUl5YjVFb3lHWk8rd2s0QStiQ0ZJWk1qTW1ENUEva2NBU2VxTm9n?=
 =?utf-8?B?SU9PSjZUMHVRc3JlQ0dvMDA3bStqWDBYalhvLzlYRSsvcFhaeTdzejN2ejla?=
 =?utf-8?B?Z2FTcWIrdVpYSURiZjhGaVFDeDhrSVhuemRFZEhrYlQ2cU1qZUlraCtaL3ZK?=
 =?utf-8?B?cFk2YWhORUlrcC9LZDl6N090YzJYY3lQMGNDcHRqdGhkUzVUMXVFNHpIaWxR?=
 =?utf-8?B?cVV1T1NZQWhXSExvVWgxazRQZU5Eaks0ZUdNTU9mNWZQQWZUUmNrSjFCQ1Vj?=
 =?utf-8?B?WkVhcDQ0TzY1TUlIUUlzbGVabmN1NGJZTEFkYW1STklIQmdzU25VOUlXYTJr?=
 =?utf-8?B?WG5HT2xjOFBXbmhxVTh0bVB5ZThGZnpSMndKUlBvYVl4cVBZZkRKUHRkYzd1?=
 =?utf-8?B?amxwRGg2MTg1MUNGYjZhV0tuUTNXWDdmVUw5OTI1NXA5dTZsc3JtRGVaa3gy?=
 =?utf-8?B?OXBlNnFncnNiakk4dmJyVTFzWTVLVU5TSjZ3bzVqUkFxaWhjd2JpREh3dHc4?=
 =?utf-8?B?MnBDQmhXUHFvc0EwRS9jTE02S1hHZC9ZTVlBN1E4NXNkYXJHT1B4bFFrNHQz?=
 =?utf-8?B?YzZNTFZ5K0NYbVpUc3liVGpNMExhRVRnTUk4N2oxcnQzVkRYT3l0ckNwMHVu?=
 =?utf-8?B?M0JKclpuc3ZSOTkvZkgrMTN2cG1VOXUwaHBDQndSWWVoQ3AzUkFiVHlrN1M0?=
 =?utf-8?B?TWlLRkp4bmtqdlo2ZEdCTmk5b0FvZHByak5rLzNMcnFtZXJqTllFS3FmTVFz?=
 =?utf-8?B?NTRkVWIvWkR0L3ZkczBibzRpNnA2T3d5ZmtYd3BWSnQyaVRRWVl3OEtHby96?=
 =?utf-8?B?WXBrYVpwdTd6c3o0MWpSQ1h5ZXBtVkpxUDYwOVd1ZCswdUVxdEI0L2NRV2h5?=
 =?utf-8?B?bjY1Z1JVV2RhNkljU1E0SVdpOGE2U1VUZitSZ2RlSlQrTjJDZmNPMG1UTXBk?=
 =?utf-8?B?WTlIcnNiSytQNmdjTC9hS0NNWVNkL3dZN3hhbkZCOVRScjdTcitPeGk2OWtT?=
 =?utf-8?B?ellnaVFzeVFpd3NoUzIxcFVFbG81SFRacTlWRDNYK2hYQkZrZWUrOTdkOXFK?=
 =?utf-8?B?VnBzZ2lEaEJsOWdiYWtxQTlyUXduZVlEb0U2MVUzcFV4amVheU4yRTBrWUZl?=
 =?utf-8?B?bWVwdXJQZVpUeVY0dmtGSmx0RUt0OVRFQjF2ejBDNEhLN0Y3am5hazBkZnVY?=
 =?utf-8?B?SDVEdUd0WUxKZE9Ed0MzOTJvcGdKTFV4SDFiRHAwME16aEdUb2FtQ0tuQWt5?=
 =?utf-8?B?dmFCeklRQmJmR25yYk8zQUtFeGNLaC9VaHRvejdFNDBaZ1BZSHkzNTd5VFpF?=
 =?utf-8?B?ZzhnRXplNlNaSGJMRTZabnl6OThKd0FaeEJZZ3hvMGg1SkxDejJLNWFhMlU1?=
 =?utf-8?B?NUt1ZmJ4LytRL25lVzcwYUtJQzl6YUFnaU95N0NjTWRNTWdGdHoxZ0Qrb1BX?=
 =?utf-8?B?YTlFUEYrbEU0NFBjWlFyREdHMTNoQzcycmhTZEtSd1BEdk5jSkF0bHNLWXVD?=
 =?utf-8?B?OUZyZnhHUEJJRk9KWk5xYzlFRHFHeStQekpxZEw1Z0NJUEpIS1pkc0MyM2R0?=
 =?utf-8?B?d04yZTRxMGJTdFRieHUrMVhad2c0RS9iWmNBNGVyZi82Yk9nNlEzb3VHRzl1?=
 =?utf-8?Q?q+KkR+5frNGG+gg7Uyp7z0Sj9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 585edcc6-cf9a-4573-ecdb-08dba92b4cd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 07:32:43.9995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZjSKgn2FSrtK+LlyoPzc9dCWkJcyNea0p01TQSDSfn5DvCYUAoRpXtCYQfWg/V0pn8df6epSZqIY8XU2IpYUnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6081
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMzAsIDIwMjMgMzox
MiBQTQ0KPlRvOiBDaGVuLCBIb25nemhhbiA8aG9uZ3poYW4uY2hlbkBpbnRlbC5jb20+OyB4ZW5v
bWFpQGxpc3RzLmxpbnV4LmRldjsNCj5CZXpkZWthLCBGbG9yaWFuIDxmbG9yaWFuLmJlemRla2FA
c2llbWVucy5jb20+OyBQaGlsaXBwZSBHZXJ1bQ0KPjxycG1AeGVub21haS5vcmc+DQo+U3ViamVj
dDogUmU6IGlycSBzdG9ybSBvbiBzZC9tbWMgY2FyZCBkZXRlY3QgZ3BpbyBpbnRlcnJ1cHQgYWxs
b2NlZCBmcm9tDQo+cGluY3RybCBkZXZpY2UNCj4NCj5PbiAzMC4wOC4yMyAwNTowNSwgQ2hlbiwg
SG9uZ3poYW4gd3JvdGU6DQo+PiBIaSBQaGlsaXBwZS9KYW4NCj4+DQo+PiBXZSBmb3VuZCB0aGVy
ZSBpcyBpcnEgc3Rvcm0gaXNzdWUgbGlrZSBbMV0gb24gc2QvbW1jIGNhcmQgZGV0ZWN0IGludGVy
cnVwdA0KPmFsbG9jZWQgZnJvbQ0KPj4gcGluY3RybCBkZXZpY2Ugd2l0aCBYZW5vbWFpIDMuMiBE
b3ZldGFpbCA1LjEwLioNCj4NCj5JcyB0aGlzIDUuMTAtb25seSBvciBhbHNvIGFmZmVjdGluZyBu
ZXdlciBkb3ZldGFpbCBrZXJuZWxzPw0KPg0KPj4gQWNjb3JkaW5nIHRvIG91ciB0ZXN0LCAgdGhl
IHBhdGNoIFsyXSB3b3JrcyBmb3Igc3VjaCBpc3N1ZSBpbiBvdXIgY2FzZS4gSXQNCj5zZWVtcyB0
aGF0IGhhbmRsZV9lZGdlX2lycQ0KPj4gbmV2ZXIgYWNrIHRoZSBpcnEgdG8gY2xlYXIgdGhlIGlu
dGVycnVwdCBzdGF0dXMgZm9yIHRoZSBMaW51eCBncGlvIGludGVycnVwdC4NCj4+DQo+PiBJIGFt
IHdvbmRlcmluZyBpZiB0aGVyZSBpcyBhbnkgc2lkZS1lZmZlY3QgZm9yIHRoaXMgcGF0Y2gsIFBs
ZWFzZSBzdWdnZXN0Lg0KPj4NCj4NCj5SZW1pbmRzIG1lIGEgYml0IG9mIEZsb3JpYW4ncyBpc3N1
ZSwgdGhvdWdoIGhlIHdhcyBzZWVpbmcgdGhhdCB3aXRoDQo+bGV2ZWwtdHJpZ2dlcmVkIGludGVy
cnVwdHMuDQo+DQo+QXJlIHRob3NlIGludGVycnVwdHMgc3VyZWx5IGVkZ2UtdHJpZ2dlcmVkPyBK
dXN0IHRvIGV4Y2x1ZGUgdGhhdCB3ZSBhcmUNCj5zZWVpbmcgYSB3cm9uZyBoYW5kbGluZyBpbiBn
ZW5lcmFsLg0KDQpZZXMsIHRoZSBHUElPIGludGVycnVwdCBpcyBzZXQgZWRnZSB0cmlnZ3JlZCB0
eXBlLiBBZnRlciBwYXRjaCwgdGhlIGludGVycnVwdCBjb3VudCBzZWVtcyBjb3JyZWN0IGxpa2Ug
Zm9sbG93aW5nLg0KDQoxNDogICAgICAgICAgMiAgICAgICAgICAwICAgICAgICAgIDAgICAgICAg
ICAgMCAgSVItSU8tQVBJQyAgIDE0ICAgIC1mYXN0ZW9pICAgSU5UQzEwMjA6MDAsIElOVEMxMDIw
OjAxLCBJTlRDMTAyMDowMywgSU5UQzEwMjA6MDQsIElOVEMxMDIwOjA1DQoxMjg6ICAgICAgICAg
IDIgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgIElOVEMxMDIwOjAxICAxMTIgICAg
ICAwMDAwOjAwOjFhLjEgY2QNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo+DQo+PiBSZWdh
cmRzDQo+Pg0KPj4gSG9uZ3poYW4gQ2hlbg0KPj4NCj4+IFsxXToNCj4+IGNhdCAvcHJvYy9pbnRl
cnJ1cHRzDQo+PiAgIDE0OiAgICAyNDQwMTkwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAg
ICAwICBJUi1JTy1BUElDICAgMTQgICAgLWZhc3Rlb2kgICBJTlRDMTAyMDowMCwNCj5JTlRDMTAy
MDowMSwgSU5UQzEwMjA6MDMsIElOVEMxMDIwOjA0LCBJTlRDMTAyMDowNQ0KPj4gMTI4OiAgICAy
NDQwMTkwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICBJTlRDMTAyMDowMSAgMTEy
ICAgICAgMDAwMDowMDoxYS4xIGNkDQo+Pg0KPj4gWzJdOg0KPj4gZGlmZiAtLWdpdCBhL2tlcm5l
bC9pcnEvY2hpcC5jIGIva2VybmVsL2lycS9jaGlwLmMNCj4+IGluZGV4IDZhY2E2YzAzNmFkYS4u
NGQwOGVhZjA3NmU5IDEwMDY0NA0KPj4gLS0tIGEva2VybmVsL2lycS9jaGlwLmMNCj4+ICsrKyBi
L2tlcm5lbC9pcnEvY2hpcC5jDQo+PiBAQCAtODY5LDcgKzg2OSw2IEBAIHZvaWQgaGFuZGxlX2Vk
Z2VfaXJxKHN0cnVjdCBpcnFfZGVzYyAqZGVzYykNCj4+ICAgICAgICAga3N0YXRfaW5jcl9pcnFz
X3RoaXNfY3B1KGRlc2MpOw0KPj4NCj4+ICAgICAgICAgLyogU3RhcnQgaGFuZGxpbmcgdGhlIGly
cSAqLw0KPj4gLSAgICAgICBpZiAoIWlycXNfcGlwZWxpbmVkKCkpDQo+PiAgICAgICAgICAgICAg
ICAgY2hpcC0+aXJxX2FjaygmZGVzYy0+aXJxX2RhdGEpOw0KPj4NCj4+DQo+DQo+TG9va2luZyBh
dCBhIGxhcmdlciBibG9jayBvZiB0aGlzIGZ1bmN0aW9uDQo+DQo+CWlmIChzdGFydF9pcnFfZmxv
dygpKSB7DQo+CQlkZXNjLT5pc3RhdGUgJj0gfihJUlFTX1JFUExBWSB8IElSUVNfV0FJVElORyk7
DQo+DQo+CQlpZiAoIWlycV9tYXlfcnVuKGRlc2MpKSB7DQo+CQkJZGVzYy0+aXN0YXRlIHw9IElS
UVNfUEVORElORzsNCj4JCQltYXNrX2Fja19pcnEoZGVzYyk7DQo+CQkJZ290byBvdXRfdW5sb2Nr
Ow0KPgkJfQ0KPg0KPgkJLyoNCj4JCSAqIElmIGl0cyBkaXNhYmxlZCBvciBubyBhY3Rpb24gYXZh
aWxhYmxlIHRoZW4gbWFzayBpdA0KPgkJICogYW5kIGdldCBvdXQgb2YgaGVyZS4NCj4JCSAqLw0K
PgkJaWYgKGlycWRfaXJxX2Rpc2FibGVkKCZkZXNjLT5pcnFfZGF0YSkgfHwgIWRlc2MtPmFjdGlv
bikgew0KPgkJCWRlc2MtPmlzdGF0ZSB8PSBJUlFTX1BFTkRJTkc7DQo+CQkJbWFza19hY2tfaXJx
KGRlc2MpOw0KPgkJCWdvdG8gb3V0X3VubG9jazsNCj4JCX0NCj4JfQ0KPg0KPglpZiAob25fcGlw
ZWxpbmVfZW50cnkoKSkgew0KPgkJY2hpcC0+aXJxX2FjaygmZGVzYy0+aXJxX2RhdGEpOw0KPgkJ
ZGVzYy0+aXN0YXRlIHw9IElSUVNfRURHRTsNCj4JCWhhbmRsZV9vb2JfaXJxKGRlc2MpOw0KPgkJ
Z290byBvdXRfdW5sb2NrOw0KPgl9DQo+DQo+CWtzdGF0X2luY3JfaXJxc190aGlzX2NwdShkZXNj
KTsNCj4NCj4JLyogU3RhcnQgaGFuZGxpbmcgdGhlIGlycSAqLw0KPglpZiAoIWlycXNfcGlwZWxp
bmVkKCkpDQo+CQljaGlwLT5pcnFfYWNrKCZkZXNjLT5pcnFfZGF0YSk7DQo+DQo+DQo+aXQgaXMg
aW5kZWVkIHVuY2xlYXIgdG8gbWUgd2h5IHRoYXQgIWlycXNfcGlwZWxpbmVkKCkgY2hlY2sgaXMg
dGhlcmUuDQo+V2hlbiB3ZSBhcmUgZW50ZXJpbmcgd2l0aCBpcnFzX3BpcGVsaW5lZCgpIGFuZCAh
aW5fcGlwZWxpbmUoKSwgbmVpdGhlcg0KPnN0YXJ0X2lycV9mbG93KCkgbm9yIG9uX3BpcGVsaW5l
X2VudHJ5KCkgd2lsbCB0YWtlcyBjYXJlIG9mIHRoZSBhY2suIFdobw0KPmVsc2Ugd2lsbCBkbyBp
dCBpbnN0ZWFkPw0KDQpZZXMsIHRoYXQgaXMgdGhlIHByb2JsZW0uIEZvciBvb2IgaW50ZXJydXB0
ICxpdCB3aWxsIGJlICB0b29rIGNhcmUgb2YgYnkgb25fcGlwZWxpbmVfZW50cnkuDQoNClJlZ2Fy
ZHMNCg0KSG9uZ3poYW4gQ2hlbg0KPg0KPkphbg0KPg0KPi0tDQo+U2llbWVucyBBRywgVGVjaG5v
bG9neQ0KPkxpbnV4IEV4cGVydCBDZW50ZXINCg0K
