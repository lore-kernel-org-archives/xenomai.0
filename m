Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B447B8F41
	for <xenomai@lists.linux.dev>; Mon,  7 Nov 2022 13:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667827111; x=1699363111;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LuScOxrLGu/NaAD3iHtlbnIj42bdPZpNkRtgkbt0BW4=;
  b=GZiyyDj5o8PqYGM9Opwo5fnmbSAnC2rD9Ewv/An0ttdVRBiC9dvU4KNt
   MtdmeOCxRpUW4s9BGbGLukXKqwGrVPbLXPTJ5Q1wSI/vRd4VMgz9AkwA3
   olpIVitjqhMIyXBkNBwdMbx8uEToqxnCLTDSHF+X6SazCclbwrEufcOWJ
   YRIYOazEcWTX6ZYaVaxwro3K6RaLw52Hcot64+O7sVOvG4zrSHbGjRi16
   q5VlEKjYNh11FYMnyKEZVkZsyg6r9tOWRyQJolgtCsag9/uZ+qhryH7HX
   LDL8hVwOyrEOEwOTcrrjMjz9hJtoKuRTOYX/vS/RQmaNj6QUT8LAfI3Qn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="396702418"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="396702418"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 05:18:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="638363063"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="638363063"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 07 Nov 2022 05:18:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 05:18:30 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 05:18:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 05:18:30 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 05:18:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luYz6xw2hg86Qru97g4Fu4wcMGABUPiRogvVIGAzG5886G84N7NpMqd1YF5yfyO+CFj22QFwEDNrvubC8X0AJC9RyCeWO1KAUqIhWL/C0gK0veSm98BGk9flthKtY5al9uPULdF8mP4bgV03DHjsA490BxUMnu+tphMSrUpJLRBNL9T8Jrd+eEOfIPTo3Fx4YZ4BbMCspMjmpxd3k4kAY3nAunndJnNzFGqN038vwkn6wH3664ckn2+yThETQ//2S3ujCWZyBvZ2nyOXyUzKm49mdHd5i2asJjtxQMctUS9nELHepViUgOEFN3PWyC2+8lKHrZx+EBUaGSQck+a/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuScOxrLGu/NaAD3iHtlbnIj42bdPZpNkRtgkbt0BW4=;
 b=ORfSHT7syZh32nBRjCPNitnneZ21W1dwkt8G3bRwoDXHcx2RgGKUHiZSNC2HMDEj1htBJKJEFDmRm7HqH0f19pWBUOcSSqfXaL6uhRIeH3MewAO3NDbBmHG62FPC+afh4W/37x0lke4Tg9yswrrYsESppffDuNsip8jN0XBVEBz5gE86GdbzuQNuqv4N1C/7q4Cgs4rvCKiCRNGROzshXek+sjUDTHlnRx6PAQV8XsjcuLsyNi3DGBsVb/uZ1Y9wY/M05bV1ii7GNG25rouASx4k6MmRkKPTHoc6GtzRQBZ3h7pIl3YOLh3rb2Pp3u7I1LF4O7AHietFYMoR2XP9VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH0PR11MB4837.namprd11.prod.outlook.com (2603:10b6:510:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 13:18:27 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3b52:52d6:eff7:8d02]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3b52:52d6:eff7:8d02%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 13:18:27 +0000
From: "Zhang, Qiang1" <qiang1.zhang@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Heber, Stefan"
	<Stefan.Heber@zwickroell.com>
CC: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "Wang, Rick Y"
	<rick.y.wang@intel.com>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Memory corruptions upon strcpy and similar when being interrupted
 by scheduler
Thread-Topic: Memory corruptions upon strcpy and similar when being
 interrupted by scheduler
Thread-Index: AdjUuPBUbK+UhP87T6Sf3hDOZQOijgTLBYqAAA1CmiAACKQcgAA/AGAgAV0zStAACIauoAAAw4AAAOySfgAABi7zgAADOIVQ
Date: Mon, 7 Nov 2022 13:18:27 +0000
Message-ID: <PH0PR11MB5880A19D008C286A96BC9495DA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <FR2P281MB265487EA098F01EFC0F77CB8FC569@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <ca3f971c-87e1-b7b4-262c-bf80483ef9fd@siemens.com>
 <PH0PR11MB5880908DA18819B93D4DAEB9DA319@PH0PR11MB5880.namprd11.prod.outlook.com>
 <4a08b7af-039d-99ef-ec9e-4749cb47379d@siemens.com>
 <FR2P281MB265412CDC9321A60BA8B87BCFC309@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <PH0PR11MB58807DD17256817B3BFC54A3DA399@PH0PR11MB5880.namprd11.prod.outlook.com>
 <FR2P281MB265432E604FFEB38A3FB7AB9FC399@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <b49df726-0eb8-1f65-f584-37eba99aae77@siemens.com>
 <151047c2-a1cf-db66-d4d6-61d0df96976f@siemens.com>
 <b16e958f-bd57-5b18-c1fd-e2e67cc8f589@siemens.com>
In-Reply-To: <b16e958f-bd57-5b18-c1fd-e2e67cc8f589@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|PH0PR11MB4837:EE_
x-ms-office365-filtering-correlation-id: be9ee965-d156-480e-f382-08dac0c28eb4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tA8t7m2sYepiSeUpsVogsxpaPC7FMIkZ4IYK7FrdgNPkJsufVyJ533sR905TVTo6chmGxJwfFrMVLTNMFdUDq17Wg2PW/i6GKQpo/UZIrtD8ueLvaNmSBgLvDCwIUn8cXHGGdBj2KYg3f+uRY047OIUDzkN7oDYIDRc9bnPze7qkP7h/zghTXSfjM84wVmJKy0Ra8w+NJZQmTAG/kt42ts09x+AvFVA2G2yepKD0iBa44xXvCMS0dtA/bJCFGyqiPRSG2vsm+4ovewMAHa9qkzoDtptofIakQiVSG528m6YVezhgC4u92jAVDitnYa+IJaaj168X6CUooCkJYgOvZJVtnION9U+StCRnEC8bQxUbJ1rHr0LV9vMMr+Ut9/+GnCfJdF67OVkKCW1MkFcbcrkeQCwkkObaxsL3J0r2CvoqA3G7s8HpYTH9KjCbgMGZVvngbkI5ipNZHP3fC1fWBCFKcJbYmnLCKiyzJvvkBaiDRWG5VQLee/+QZdWh+E7z93io5QEqfid+fQa9xtyKF1Vdt+04ekUq8TJayZgVsYyPGtbKoferDGkZUQJ9J8U7ZLMsQol7dRXwm7AgCfXGmF1CEh7MaKTxmQKpbV1npjM8rCYLmfiPq6rTMpq9c/L6Zk49sQuO5S7mni0ChJ3c8auSWGHA6ocZW75ADrJO5XPTRMx8/kuCSwRYu4JRh8cuNbwkl1gyWnwEE1FwMSELFe+oCAhMcoQGMIKqf2fM75H6JDhC6xUjgaupeCQee7DPLR0U/sBMOUGqY6L43dujWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(8936002)(5660300002)(52536014)(2906002)(186003)(33656002)(55016003)(76116006)(66946007)(316002)(86362001)(110136005)(478600001)(38100700002)(82960400001)(122000001)(66556008)(38070700005)(64756008)(4326008)(71200400001)(66476007)(66446008)(8676002)(41300700001)(83380400001)(6506007)(26005)(54906003)(7696005)(9686003)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2RGeFRtRlpXZ01KMFNjZWVwL0JQRjVycUNoZVN2WHV2VjFZT1VzOTZ3Y2xR?=
 =?utf-8?B?aWdYRzZEeC9kS0d4TU1TUnJTZmdWNjFVa2hKUDhTeTNQemk4Zks0Z0ZadzBn?=
 =?utf-8?B?NDl2MUxqZ3dFQUR6WkFtZU1UbTJLYmFoYW1aaG94QklHSDJNSytlRk1oRTA0?=
 =?utf-8?B?TVRoR0YrNzJHQ3dackl5S3dZQkx1VGRxRUE4dysraFV4cUpaU3ZjQy9UQTIz?=
 =?utf-8?B?NmUyeU40YytncDBxRkd5U1hzakFrWUpTaEt2aGp2UDhRODJlL2luVytpSXA2?=
 =?utf-8?B?dlNXYUl0MXJlNEc0cDROUEYrOEtOeHM3dzBUWnN0eGJFRitxcE1acitWbU9R?=
 =?utf-8?B?Yys2cVg2eG9HdytHeEhLRjNzT3ZOdDBodVJWa1hkcEZxZTdPWGV3OXNSSWs3?=
 =?utf-8?B?RHRxcDlOU2ZZM1RDUmJqOHlYb1BEOUIxL2tIODcwcGJ5UG93U0FTVUE1c1Qz?=
 =?utf-8?B?dU9mVDFNZTZXcjdKcXBnOE5lNDE1SDBsdFhoZWZiRkM5NDFWdG9KQzM5cGFI?=
 =?utf-8?B?ODRuNVhiSjRLRkpvUXJ4dG5VcG41YTNkYy92cHd0eWsxTmZsbXAya2dJWXBL?=
 =?utf-8?B?RlhsNnhaSEdFWHFneW5GbEwxWWNOeEhKS0tyQThZejNUUlZ1MktVQUgrOWp0?=
 =?utf-8?B?OWI3RmtBQWFkSVNGeWxuODg5dE9GWkJ4eHN4MW96K2VwMHNWVVFLaDE5QWtB?=
 =?utf-8?B?dGcyRHI1dWJIdXozMFhmOHNZQWoxVVR2UE5DT1N4MkR6ZmtMNXRvVFJDOWZ0?=
 =?utf-8?B?cHhYYkgxL0tWUHkvR3cyb3k0eDJPSTJRSGhpL0RPdC9lMDRKbFZ6Yk9sZFNs?=
 =?utf-8?B?N24yTEJ5dEp6cVZ6Nk1JUjhVcnQ0eHUrcGdGVkdZUlQ1RjVUdWRqZnRiK1Ur?=
 =?utf-8?B?WVhDVjhkRXFXN3dQUHhsQStpdlBUc25hVnlISWFiWGNiblg4bk90VklDRm01?=
 =?utf-8?B?M0RIQVpQbzBXeHZjZTJaaGRqVUU3SW9xcTN2L0FHME9GM0hhQTVUdmhwKzdP?=
 =?utf-8?B?eWVLRE9TLzVSWnREUjZKRDRLbnIyektTbllmaS9xbXpaUGx3MUc3YTVsL3Nl?=
 =?utf-8?B?aXlUNzZCV3hCdkU5R0pxeTNxZXRaamZ4K0RPSDlTY1loQ3YxblBUd3Bqa1Zx?=
 =?utf-8?B?Wmpub054Y0MrRzZZRVFvUVZWMXV4Z2J1QzRBdXg0aFZ3REw2SXpSZ2IyWVZG?=
 =?utf-8?B?ZVJyVXZodmtzcnNoWU5GZHRiS2g5bjN1OVd5Mk81dVdHOVhXcGRPVklYVGxG?=
 =?utf-8?B?SXlaai81S3ZhNzB4R0pjVVRKZFhlR3FjNG1ueVEvdlZNYnRTZWtFT0gwUUll?=
 =?utf-8?B?b1VWa1BmUFZUWi9ZY1RwNXpYMmRVem1Jb2VSSTFkR0dIUlRYcEQwU2gxTjEv?=
 =?utf-8?B?TlVTd3RTb2lXUjdHSGFWSEU5TjhTYngxRXMyTTAxUlhXT0VBZTMrUkRoV3V5?=
 =?utf-8?B?QVJMOXI4WG96aklSVmU3S1RLMFBJTzZOVk1kTFRhQU91Tm9Ed3IvTDlWM1FI?=
 =?utf-8?B?SVNoYkcybFJsREMwZ0NGaXVadzROTitIS1pRdzlMYTNPSXZsQVdnL2ZIbTEr?=
 =?utf-8?B?VmxBOEJ5SFljOWVtNVNZQ0J3NFk4R1ErdlQ0NDR6eUlvUHZCQXVtTUs2aUo0?=
 =?utf-8?B?U3AxdGlRbVNlbEUxK0JRdzZOU1BEUVpNZHNPcUR4NFVkN3ZFRE5JRSt0Sk5V?=
 =?utf-8?B?cnVrYWJnTit1NzlxNnliRGw3bE5FaVhlQVR3THVlYXRvTE1XcXVTMkpHU1pj?=
 =?utf-8?B?YW5PSE5kOWw3c3BNeldKazF5czgwaFdJeGFoWm9IdGpsbmFOTkUzUVdLSWxU?=
 =?utf-8?B?cXVZcVNHQ3NRendZbDg3KzEwekZsa2I2MklienVFeC9EdjhRTkV1ZWpGUXZ5?=
 =?utf-8?B?UlN0RW5yWmg5U3JNUUdhalc3R1dERGJvVVFNVm5xSkRNczFFV25BUmU5YVdp?=
 =?utf-8?B?WW9tTElOOW9nazFsU0lnT1ZNaHpWQTJOaXBEU2Y1blQ5NytHNWU1TVZyczNy?=
 =?utf-8?B?VDlQOTVqdEx3TE1vQkZlWmhtN0YvWkdEN0RNSHNwSXV4N0FuOC8vYXpJMzFh?=
 =?utf-8?B?MnVtTFE1S0xRVlFFb0FPVFJsaUlmelQydFRzVHBQK0RxVWJTdGxINXhmZWFZ?=
 =?utf-8?Q?qi60zcUwqJOMUzXLo5FUzx5nD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9ee965-d156-480e-f382-08dac0c28eb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 13:18:27.6445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h+06NzWoJEe4XhO62PHOMxxtIF6SM/7L0LDoNPDbIYEU0P0rPJo30eRfjIwr3HHYw1LlXZsnCz7YSnj0yWT4Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4837
X-OriginatorOrg: intel.com

T24gMDcuMTEuMjIgMDk6NDIsIEphbiBLaXN6a2Egd3JvdGU6DQo+IE9uIDAyLjExLjIyIDE2OjQ4
LCBKYW4gS2lzemthIHdyb3RlOg0KPj4gT24gMDIuMTEuMjIgMTY6MzQsIEhlYmVyLCBTdGVmYW4g
d3JvdGU6DQo+Pj4gSGVsbG8gWnFpYW5nLA0KPj4+DQo+Pj4gV2UgdGVzdGVkIHlvdXIgMDAwMS1J
UElQRS1pZ25vcmUteGVub21haS1GUFUtb3BlcmF0aW9uLnBhdGNoIG9uIG91ciBzeXN0ZW0gKExp
bnV4LWtlcm5lbCA1LjQsIFhlbm9tYWkgdjMuMikuDQo+Pj4NCj4+PiBUaGlzIHBhdGNoIG1ha2Vz
IHRoZSBwcm9ibGVtIGRpc2FwcGVhciB3aXRoIG91ciB0aW55IHRlc3RhcHAgb24gb3VyIHN5c3Rl
bSwgdG9vLg0KPj4+IEJ1dCB3aXRoIGEgc3lzdGVtdGVzdCBmcm9tIG91ciBodWdlIGFwcGxpY2F0
aW9uICg+MjUwayBMb0MsID4yMCB0aHJlYWRzKSB0aGUgcHJvYmxlbSBzdGlsbCBleGlzdHMuDQo+
Pg0KPj4gVGhlIHBhdGNoIGlzIHN1cmVseSBubyBzb2x1dGlvbiwgYnV0IGl0IHBvaW50cyB0byB0
aGUgZGlyZWN0aW9uIHdoZXJlIHdlDQo+PiBuZWVkIHRvIGRpZy4gVW5mb3J0dW5hdGVseSwgSSBz
dGlsbCBkaWRuJ3QgZmluZCBlbm91Z2ggY29udGlndW91cyB0aW1lDQo+PiB0byBzdGFydCB0aGF0
Lg0KPiANCj4gSSdtIHN0YXJ0aW5nIHRvIHVuZGVyc3RhbmQgdGhlIHByb2JsZW06DQo+IA0KPiBT
b21ld2hlcmUgYmV0d2VlbiA0LjE5IGFuZCA1LjQsIHRoZSBrZXJuZWwgbW92ZWQgRlBVIHJlc3Rv
cmF0aW9uIGZvcg0KPiBpbmNvbWluZyB0aHJlYWRzIGZyb20gdGhlIHRocmVhZC1zd2l0Y2hpbmcg
Y29kZSB0bw0KPiBwcmVwYXJlX2V4aXRfdG9fdXNlcm1vZGUoKS4gSG93ZXZlciwgdGhpcyBwYXRo
IGlzIG5vdCB0YWtlbiB3aGVuDQo+IHN3aXRjaGluZyBpbiBhIHByaW1hcnkgdGhyZWFkLCBhdCBs
ZWFzdCB3aGVuIGl0J3MgY29taW5nIGZyb20gc2Vjb25kYXJ5Lg0KPiBOZWVkIHRvIGxvb2sgZm9y
IHRoZSByaWdodCB3YXkgdG8gYWNjb3VudCBmb3IgdGhpcyBub3cuDQo+IA0KDQo+QSBmaXJzdCwg
c28gZmFyIHByb21pc2luZyBmaXggYXR0ZW1wdDoNCg0KSGkgSmFuDQoNClRoYW5rcyBmb3IgdGhl
IHBhdGNoLCAgSSBoYXZlIHRlc3RlZCBpdCBiYXNlIG9uIFhlbm9tYWkgdjMuMiBhbmQgbGludXgt
djUuNA0KVGhpcyBwcm9ibGVtIGRpc2FwcGVhci4gIEkgZXhwZWN0IFN0ZWZhbidzIHRlc3QgcmVz
dWx0Lg0KDQpUaGFua3MNClpxaWFuZw0KDQo+DQo+DQo+ZGlmZiAtLWdpdCBhL2tlcm5lbC9jb2Jh
bHQvYXJjaC94ODYvaXBpcGUvdGhyZWFkLmMgYi9rZXJuZWwvY29iYWx0L2FyY2gveDg2L2lwaXBl
L3RocmVhZC5jDQo+aW5kZXggN2UyODkwM2E0Mi4uOGJkMmNkOTEyYiAxMDA2NDQNCj4tLS0gYS9r
ZXJuZWwvY29iYWx0L2FyY2gveDg2L2lwaXBlL3RocmVhZC5jDQo+KysrIGIva2VybmVsL2NvYmFs
dC9hcmNoL3g4Ni9pcGlwZS90aHJlYWQuYw0KPkBAIC00NDMsMTUgKzQ0MywxOSBAQCB2b2lkIHhu
YXJjaF9zd2l0Y2hfZnB1KHN0cnVjdCB4bnRocmVhZCAqZnJvbSwgc3RydWN0IHhudGhyZWFkICp0
bykNCj4gew0KPiAJc3RydWN0IHhuYXJjaHRjYiAqY29uc3QgdG9fdGNiID0geG50aHJlYWRfYXJj
aHRjYih0byk7DQo+IA0KPi0JaWYgKCF0Y2JfdXNlZF9rZnB1KHRvX3RjYikpDQo+LQkJcmV0dXJu
Ow0KPi0NCj4tCWNvcHlfa2VybmVsX3RvX2ZwcmVncygmdG9fdGNiLT5rZnB1LT5zdGF0ZSk7DQo+
KwlpZiAodGNiX3VzZWRfa2ZwdSh0b190Y2IpKSB7DQo+KwkJY29weV9rZXJuZWxfdG9fZnByZWdz
KCZ0b190Y2ItPmtmcHUtPnN0YXRlKTsNCj4gI2lmIExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJO
RUxfVkVSU0lPTig1LDIsMCkNCj4tCS8qIHJlZG8gdGhlIGludmFsaWRhdGlvbiBkb25lIGJ5IGtl
cm5lbF9mcHVfYmVnaW4gKi8NCj4tCV9fY3B1X2ludmFsaWRhdGVfZnByZWdzX3N0YXRlKCk7DQo+
KwkJLyogcmVkbyB0aGUgaW52YWxpZGF0aW9uIGRvbmUgYnkga2VybmVsX2ZwdV9iZWdpbiAqLw0K
PisJCV9fY3B1X2ludmFsaWRhdGVfZnByZWdzX3N0YXRlKCk7DQo+KyNlbmRpZg0KPisJCWtlcm5l
bF9mcHVfZGlzYWJsZSgpOw0KPisJfQ0KPisjaWYgTElOVVhfVkVSU0lPTl9DT0RFID49IEtFUk5F
TF9WRVJTSU9OKDUsMiwwKQ0KPisJZWxzZSBpZiAoeG50aHJlYWRfdGVzdF9zdGF0ZSh0bywgWE5S
T09UIHwgWE5VU0VSKSA9PSBYTlVTRVIgJiYNCj4rCQkgdGVzdF90aHJlYWRfZmxhZyhUSUZfTkVF
RF9GUFVfTE9BRCkpDQo+KwkJc3dpdGNoX2ZwdV9yZXR1cm4oKTsNCj4jZW5kaWYNCj4tCWtlcm5l
bF9mcHVfZGlzYWJsZSgpOw0KPiB9DQo+ICNlbmRpZiAvKiAhIElQSVBFX1g4Nl9GUFVfRUFHRVIg
Ki8NCj4gDQo+DQo+SmFuDQo+DQo+LS0gDQo+U2llbWVucyBBRywgVGVjaG5vbG9neQ0KPkNvbXBl
dGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQoNCg==
