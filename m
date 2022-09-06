Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DE315A4
	for <xenomai@lists.linux.dev>; Tue,  6 Sep 2022 02:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662431177; x=1693967177;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=aKHXn9zZZz6MMe7RpoMzMT/g74uJpzjM/HekTHnyt/M=;
  b=PFQBrdj8TjRDQvr8ES6XoLJTbpUBkname/yg5VS7YLkigby2stEznmZ5
   q/uxdKbYsCJBkGZRdFlyftmb/wZl6R4I2B6Qd7qBKySMxUGzbKKjuoBe9
   ahOu1lVv14vV0uE+IXP7+QtcYpTvEy2jT5pJkMy2GImNXRoTW418dtSDp
   d2AgY/XQ4yjWPWp67Wm9Ii6TfS3G5kS+PCqS6LqcVIDG0x3YPVaN0ODnK
   8hReKhxeQPnH80k2bPvrmzFCqPDnZcrRa3W/nX59QpyC+OkxFgQI+grQW
   JixfzVcSiD9nLy4P0yKa1Yrm4pA9nuC3DCK3Mu5EbCocIPDqbziXGJF/7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="276223244"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="276223244"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 19:26:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="942280656"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 05 Sep 2022 19:26:16 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 19:26:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 19:26:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 5 Sep 2022 19:26:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 5 Sep 2022 19:26:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9Uu0j+ArgYmCJRQ0GhiMaZoEP9Y13yjdcEqUCm4piKWOwwFgW+Wkqyh0TXH1dssQb3KldmwfyXLfvA+ZMfBCB8L+I3QpU04atDKcputVX/S99xMaxZERIK7wDBocjWpcqe7C/bTPbNIF+0e1RGIwvhaODscSNnjPzIoKX0sWLeLvRyQnxEM5XDt1Kk46lTLEIbxMdIlXfgP1xhcn5IvJ8UViDF0YrXZzdVvWM0YgJDGFd5h8OQRhZ7fb1l7kjecM1rtj3fc96CFh+TTJzRFARp6INgDn6CW22TShlb6dezvUMe9hBJWylXK83XB14vR5mEvyozm4zbOnAEs4wJffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKHXn9zZZz6MMe7RpoMzMT/g74uJpzjM/HekTHnyt/M=;
 b=KdjMG+rNohew2AM0o50luUQr0x0WdWn4TO58wxZ/JaqgfUoTrSV80oMt007z9tZRErUHVWjlyRGLZNLND4vPpT7d6+TpvNtTIGNEo2xcY3/WemYaVp7jdpsLAixEjw0ClwkV83WzneqgXJEcV+YQfX6GQ6XLStI1PViCvbQZhyHY9dbnp2dCqT4ojDrDE0/f2K/740SdLwOmZKrEs9sT6GJenLHaAm8wlXndVb1DYWfyf6ATBtOIzAQUtDGH2NNzY2FbEQUBlp/op3ujdYcTjdMNy52a+eJGlPGt/2LxJCvnApSeBKT+sO95jM6VAgZHzDlQ6QyXE9MZmtK6G240Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by PH0PR11MB5951.namprd11.prod.outlook.com (2603:10b6:510:145::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 02:26:12 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83%3]) with mapi id 15.20.5588.015; Tue, 6 Sep 2022
 02:26:12 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: [PATCH 1/1] net/drivers: igc: introduce rt_igc driver
Thread-Topic: [PATCH 1/1] net/drivers: igc: introduce rt_igc driver
Thread-Index: AQHYtcgruiRa5GU0bkyfaILtFgMj5K3Q0rAAgAAArACAAB+EAIAA0KZQ
Date: Tue, 6 Sep 2022 02:26:12 +0000
Message-ID: <MN2PR11MB428565EA25BADA041AF7FA55F27E9@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <20220822011821.21283-1-hongzhan.chen@intel.com>
 <20220822011821.21283-2-hongzhan.chen@intel.com>
 <2b643cbb-add7-fc03-7b22-fe691072d9df@siemens.com>
 <21a7d392-041e-05e7-3b9a-00134725f41b@siemens.com>
 <6ea2824b-fdaa-ebdd-6873-af0668763671@siemens.com>
In-Reply-To: <6ea2824b-fdaa-ebdd-6873-af0668763671@siemens.com>
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
x-ms-office365-filtering-correlation-id: 12657324-c391-4527-ab15-08da8faf2aa2
x-ms-traffictypediagnostic: PH0PR11MB5951:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mD8/z+nm4d8IzppcNWGyBVhPnOxfWn/JjR7z+zDMSzXPbIlDS5hzFn4pf6oEEmR+z/6RoOvciFJUg7yRUD1vnRB3ilDhKR/tJLGCbdxWeyKy764STihSLdLpDrc8DPpthuZbJuxpZoxwyu06zikGY2B9cYIw80APbmz41l3szyhcgGuQ0yzX14wYSxH56F/WGhQAWsfWc40/hFfkbW4cRTjnhaLEQocLrv1aSoAQkSKmB33Ovh44Mrdj0PeGN+UffbhH/8T1lolKIK6uZ7RiU3Wy8Rdp9+qoGshpnTbSw7W3HhBkk33Y3BZ93bNmRvkoIbpUjgXQp5gkbil+eQ7SOJ2QHK4+3zKRtihXQxqSmaWyDfU/f/OLBd7cDZpIBiTrXNz1RHpqQiaqt6+TbpcZ0bsPpznhMmYPkJVtSxJI5T646fMvxgM6t/aMgWQoBI/pvuVcadGxyicqj6k3CJqjhEXmbcAfJxl97oHzcB3qJpu50nEWFe28VUbjNelqLgDjNXLSGpmeqkeUKQunFDLFPin8n14bP+I5i4U/+araoz8UqtSjgckvoYXlYsPLC1BgLLJWrcRClx1Bf9A683xpPWZ4gs3uejtNZOFc21oub/dA+2g82UGAnB7zJN8yZJGNHEC1aAJ6WKq3KMRJ5M6YZuNJowbTXmSFPwWKHWoL2YaSz7VlyVJfs/7qQ02c/jSPyMlDI3FTn3UhUZ3aH6L18eJstj4ll6EC1zT+BOYJVvGamUKbtEvgwLU/orwLaJAEGiNVBUVWbVTl2w1DIUzrmzNSN1PRq0vmLATZheqLONo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(366004)(346002)(376002)(39860400002)(186003)(38070700005)(82960400001)(110136005)(55016003)(83380400001)(71200400001)(316002)(8936002)(26005)(2906002)(122000001)(52536014)(41300700001)(9686003)(53546011)(8676002)(5660300002)(7696005)(6506007)(478600001)(33656002)(76116006)(66946007)(66446008)(64756008)(86362001)(66476007)(38100700002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YklqallQRkk2VnNoRGNJdDJTaDhhNnJrUVdKZGlPenM5eTJqQzhVRGNlZURZ?=
 =?utf-8?B?WmcvQXkrS2lIT3NDeVhWeHE4NlJYT3FsWHBUTVppRVhaaDNPY1dibytZZDli?=
 =?utf-8?B?QlRuUWtpY0pINThmZTEwK2Q3NnpJNXpTUTA0YXlXdXUyTWhVbDhKSHRzRXAy?=
 =?utf-8?B?OXI0RmpTT0pXV3NEMmVwM3JFK05PalkxK1Y4VmN2cVFsVG15TU40b2ozZEdm?=
 =?utf-8?B?cFNLTkdZOE1qK1Yya1VWdDFtTWk3Z1pod3lEbHM3MVhrN2VBSWo0RWVDTm1r?=
 =?utf-8?B?czRSUjdJazN6WkVWSHVPbXZqNkZwSzN2Vi8zcXJLVm1iVDFYalJpcEtmbk9Y?=
 =?utf-8?B?NzA4UGEzMFhQUEJHV25ETkxBRldTN3ZnOGlRQTh4MlhSa2lQdFhHRVptTU0r?=
 =?utf-8?B?cG1VcUhXc1pkK2RHUkdmZmdPeTlMdTdJZ0VlK1pmUG5XNkFJNEVvcHJ1Yk0z?=
 =?utf-8?B?cXd4dGtGdHlqZ0hBYzJ3MHN4Q01xMy9wTzB5bmVQb1RKRENxZkgyS2Y3djdN?=
 =?utf-8?B?VDVQdWcrQUFvLzE0UGIyQXRPbkx3dVptSlppclV2VHBDdlZieWpjSjc2YnEw?=
 =?utf-8?B?cHQ1QkRicGtvRWEyTDVvRDBoeVpyeitacDVGR2NNMzlBdFBpL2ZLZlh0a1ZS?=
 =?utf-8?B?cVVhZmxUVXdIcStuSkp4Q2Y1RVdIVStCZUczb1cwcnkzeUd4UTNHTHcvb2dX?=
 =?utf-8?B?a2drcTFKeHBGRE8rOVNpNC9ndHNibnY4dmZkR3BwWXgyemJXSVliYkNRYXhJ?=
 =?utf-8?B?SDdLRE9PSGxqM1ZRalE3THFNQlpiRVRCdnE2Y1hKRDBJajdNWTBDaXg0T3d6?=
 =?utf-8?B?MDJYTHh4Q3hIYzhFNzVpK1pVVC9HVlNTMHBoSE1zMTB3WXFWS1gwVTBNaVZB?=
 =?utf-8?B?cGR3VHRYZktHdkJFNzBiZ3FVSWhabFlqeHRRMFZlMlROTEw1YUQ0VHdSWEtj?=
 =?utf-8?B?aDQxaCtGSkJNbGhlakI2cnNFWUc2RGF4N0dQV2VFZGtwekV4MktlWnlkOTdC?=
 =?utf-8?B?ODJ4Nlk2SkdLcEJ5eGdtMTJxZXRWZ3RnZ2ZwZEVha1hwL2xSdlYvRUNpYlVz?=
 =?utf-8?B?SHBkbTFsSFhIbnFsNnlwOHhRNUxZTXZXK2hZUExwYy9UbEMwMTRHQUE0N3A4?=
 =?utf-8?B?cER2VG9PTEN5K3hTeXNJNG10VXlPR3RocGlUakVNNURCOWcyNXNYOW1zK1JR?=
 =?utf-8?B?ZUVlS1E3NkhvOGJadmNtZTRoM1R1MlM5TVF4eW83cmp3OEYrMUQvdkQzU2cx?=
 =?utf-8?B?VFRpM2pLK2FjYy81UFZ5S1htcHBobzdSZ0IvR1N2V3ZmVEZGU2xLUXFBbmhq?=
 =?utf-8?B?RWRtMjV4a0o2V3NZd3VwTzZzL2hhSDFLMS9Pc3AzM1Ywd1grc3RWYUloSXdo?=
 =?utf-8?B?a3dSbHpwTlB6OGlpaWQ3Y0ZmMm5JTFEreEVGTDRFaWYzZTVSdm5vYzdvenhJ?=
 =?utf-8?B?ZU9ETWUvQ2Q4VnNYUFYvRkZrQmQ4VVBheDNMZDdvRUJkWEd3Ui93Z25MdEhC?=
 =?utf-8?B?K3dkRCtTL254bmpWdzR1dFErdGFHdEE1MkthN0pjVEJQbmRjTGV2SWdlM0t3?=
 =?utf-8?B?bDI0djFuQ3kzNHdYcGJ5N0dITjdvN0NhZmRweXdtOVBnZEdKRFBVZHJad3ll?=
 =?utf-8?B?NGk0MTI1aktvV1Z6Qkh3VUZaNTNJdzBSek94NEpOY2Y1V1BkUitYbzc0cFg4?=
 =?utf-8?B?VjVzVFF1bXkxU1lhMkJ0aERPUFVRcTJmNlZyaVJKSkVKTW50YnZZeHk3cm52?=
 =?utf-8?B?bjhSOWp6R1FkeFR4MDZycjhaZ0w1UUh6NGN4bGRLV1J0VVViemNKTGZBRjdx?=
 =?utf-8?B?bVpFN0lXbGsrL1g3YUsvM3JwckNEb2ZHLzdiSkNmR2dGVGZwMEpSbEpycHJN?=
 =?utf-8?B?eFdNVk5EWjR0cWIxRnNmRjJjRzRFWkliZUphY2JzTkRSdnN6ZDBhYk9PQysz?=
 =?utf-8?B?S01SOGJjaW52OFdmbGVXZ0k1ZjE0Q2FoblEvTTNZRnFNbEVtZy9hZ044WUxY?=
 =?utf-8?B?Mmk1TkJ5S05zdDZmd3NERHNtdzlFcmVpQVlvWU1jYktaRmVBU09jaTNSR2ZU?=
 =?utf-8?B?TEc1aFJkTTJPL2lkUDdsODhqVUR5TFRIWWFvR0FKNnVwcWxsSUdNVnNHeVdk?=
 =?utf-8?Q?S7cMKcH3+M9hFpOFYmY0UnHFn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12657324-c391-4527-ab15-08da8faf2aa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 02:26:12.3230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PvwA03jHjHjrQDQYTpRyHr+6w88B9vurOlXzcfawazoFCr/jmBrbQxVBuOLv9sglw5Mix0qyPxPIqoklYYN/Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5951
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgNSwgMjAyMiA5OjU2
IFBNDQo+VG86IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVsLmNvbT47IHhlbm9t
YWlAbGlzdHMubGludXguZGV2DQo+U3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIG5ldC9kcml2ZXJz
OiBpZ2M6IGludHJvZHVjZSBydF9pZ2MgZHJpdmVyDQo+DQo+T24gMDUuMDkuMjIgMTQ6MDMsIEph
biBLaXN6a2Egd3JvdGU6DQo+PiBPbiAwNS4wOS4yMiAxNDowMCwgSmFuIEtpc3prYSB3cm90ZToN
Cj4+PiBPbiAyMi4wOC4yMiAwMzoxOCwgSG9uZ3poYW4gQ2hlbiB3cm90ZToNCj4+Pj4gcG9ydGVk
IGJhc2ljIG5ldHdvcmsgZnVuY3Rpb24gbm90IGluY2x1ZGluZyBUU04gZmVhdHVyZS4NCj4+Pj4N
Cj4+Pg0KPj4+IFBsZWFzZSBlbmFibGUgdGhpcyBkcml2ZXIgaW4gQ0kgc28gdGhhdCBpdCBpcyBi
dWlsdCByZWd1bGFybHkuDQo+Pj4NCj4+DQo+PiAuLi4gaW4gdGhlIGZ1dHVyZS4gVGhpcyB0aW1l
LCBJJ2xsIGp1c3QgYWRkIHRoZSBmb2xsb3dpbmcgdG8geW91cg0KPj4gY29tbWl0LCBjcm9zc2lu
ZyBmaW5nZXIgdGhhdCBub3RoaW5nIHdpbGwgZXhwbG9kZToNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
LmdpdGxhYi1jaS55bWwgYi8uZ2l0bGFiLWNpLnltbA0KPj4gaW5kZXggMmQ0Yzc2MzVjYi4uMDNk
MzM4MjExNyAxMDA2NDQNCj4+IC0tLSBhLy5naXRsYWItY2kueW1sDQo+PiArKysgYi8uZ2l0bGFi
LWNpLnltbA0KPj4gQEAgLTEyOSw2ICsxMjksNyBAQCB2YXJpYWJsZXM6DQo+PiAgICAgIC0gLi9z
Y3JpcHRzL2NvbmZpZyAtbSBYRU5PX0RSSVZFUlNfTkVUX0RSVl9OQVRTRU1JDQo+PiAgICAgIC0g
Li9zY3JpcHRzL2NvbmZpZyAtbSBYRU5PX0RSSVZFUlNfTkVUX0RSVl9WSUFfUkhJTkUNCj4+ICAg
ICAgLSAuL3NjcmlwdHMvY29uZmlnIC1tIFhFTk9fRFJJVkVSU19ORVRfRFJWX0lHQg0KPj4gKyAg
ICAtIC4vc2NyaXB0cy9jb25maWcgLW0gWEVOT19EUklWRVJTX05FVF9EUlZfSUdDDQo+PiAgICAg
IC0gLi9zY3JpcHRzL2NvbmZpZyAtbSBYRU5PX0RSSVZFUlNfTkVUX0RSVl9SODE2OQ0KPj4gICAg
ICAtIC4vc2NyaXB0cy9jb25maWcgLWUgWEVOT19EUklWRVJTX05FVF9FWFBfRFJJVkVSUw0KPj4g
ICAgICAtIC4vc2NyaXB0cy9jb25maWcgLW0gWEVOT19EUklWRVJTX05FVF9EUlZfM0M1OVgNCj4+
DQo+PiBKYW4NCj4+DQo+DQo+VG9vIG11Y2ggcmVkLCB1bmZvcnR1bmF0ZWx5Og0KPg0KPmh0dHBz
Oi8vZ2l0bGFiLmNvbS9YZW5vbWFpL3hlbm9tYWktaGFja2VyLXNwYWNlLy0vcGlwZWxpbmVzLzYz
MTM4NjI3NA0KPg0KPlBsZWFzZSBhZGRyZXNzIGFuZCBhZGQgdGhlIGFib3ZlIGh1bmsgaW4gdGhl
IG5leHQgcmV2aXNpb24uDQoNCkFsbCB0aGUgcmVkIGlzIHNhbWUgb25lIHJlYXNvbiBiZWNhdXNl
IG9mIG1taW93YiB3aGljaCB3YXMgZHJvcHBlZCBpbiBuZXh0IGJ1dCBJIGp1c3Qgd29ya2VkIG9u
IDMuMiBzdGFibGUgYnJhbmNoLiBJIHdpbGwgbW9kaWZ5IGl0IGFuZCByZXRlc3RlZCBpdCBiYXNl
ZCBvbiBuZXh0IGJyYW5jaC4NCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQoNCj4NCj5KYW4N
Cj4NCj4tLQ0KPlNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCj5Db21wZXRlbmNlIENlbnRlciBFbWJl
ZGRlZCBMaW51eA0K
