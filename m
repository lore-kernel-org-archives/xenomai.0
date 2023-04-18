Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212721C02
	for <xenomai@lists.linux.dev>; Tue, 18 Apr 2023 08:20:10 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 5BFCFFF80E
	for <xenomai@lists.linux.dev>; Tue, 18 Apr 2023 08:20:09 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 65FA2D81013
	for <xenomai@xenomai.org>; Tue, 18 Apr 2023 08:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681806007; x=1713342007;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=MBMxGOCSFskQMGtAO4PVhWHVC8aeNyyKN/zI5dbg66Y=;
  b=GTSC5fmL91B9osrGuQjs5DkPEMJJSwm903+QPUcM4U/EvhQVFRxPohZU
   rUznUMtnqh4kzK/5nqBJnKGNTOKEa4X8toCpOOA0jUW1SlUd/5HDRkUX/
   eMdClVF7yNmruyyBaJLIsrK8K4Hdjak7JNi7lo2G1zRrYwAk3ph0WPy9f
   uGOJ2VCcBxx2xIN/5Teehwjs8+yj/vv7ga0U1BmXV5fMtmXQdq3/Hulby
   9Xhb91gn8XJ1dkzezk1dgiWAp42cmSQq1yGkPSA/zklG3Z76icDLn4+/R
   La4/DjHgI6908czHophN1ghliEEZzSEuqRa1ajxRcZpm8DkbP2LbVjNFy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="329281871"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="329281871"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 01:20:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="802462604"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="802462604"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 18 Apr 2023 01:20:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 01:20:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 01:20:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 18 Apr 2023 01:20:03 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 18 Apr 2023 01:20:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWlUnimFCn53ieap0aT8PvLsyf7ghHh9A0XD/kwtBuz0P8VGaaMG6GRvc8XnDQy38D9z1rpj+E+Zz8G+v20JKYsBKGkjg7PvorQj/O6QhpotQPfTNS/4oFMc4xb9BQXxU33NUjtg+eazOuzQ5eXYOrrc2b/IcqnAob1bYLKGbBC7zUDqhC/q/Ddi+7Rk4cxE+iKoJBIQbFH7beNEAbjXZiyJd6AX9UgfrqZqeL0qHTHsBobGULVS7esxpkgHgaJdcibGaGWoYwwUa6ZHlw9j+1zwccK7fgHfN1rlSYMOR0dt6jEI/1lM0eeDQqt1yfSJO2NUd9iFrvzYsxyMqBuXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBMxGOCSFskQMGtAO4PVhWHVC8aeNyyKN/zI5dbg66Y=;
 b=a/FeiLKAMBkUTVyv6L2O7CXJBVYIJGT9PcAp6VSirBKfg3VaLjrRUezIa8eIqkFHbSy2wr/JiEMNrbokkHeOHBmrnCij1RA0BWpRtd3rvqAAamxmcTjmvCby+VINL5ltFw6X2jMc8LVRHAZ91TNb5MrpsLbz0HHrhS0EFkkPT+p41XBqUsSy2MkZJq09cHvglrWr0Un0b/72pkdMa8U7sMncYAVNWuNiGzv8fENgkK+S7u4oLHdwfbD1nGZYLT1lXP0TZIv09cCPIs05jAcwFN+UBf+4PPk618mxjuX4u+bT3tFd/0CTJ5qnD32JvO7X4Sgf4SZ25/Skg6afK2hsCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by SJ0PR11MB5632.namprd11.prod.outlook.com (2603:10b6:a03:3bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 08:20:01 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::57f2:3e63:c6a9:56c0]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::57f2:3e63:c6a9:56c0%5]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 08:20:00 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: linz <powertree@163.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Subject: RE: Repeat initialization for wd_data->dev
Thread-Topic: Repeat initialization for wd_data->dev
Thread-Index: AQHZccwycnagOV00ik2av3Mgk3VZd68wt87A
Date: Tue, 18 Apr 2023 08:20:00 +0000
Message-ID: <MN2PR11MB42858E0D781BE863F9FD4F40F29D9@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <0c88a90d-1a24-15c5-21e3-bd0a6d9c18aa@163.com>
In-Reply-To: <0c88a90d-1a24-15c5-21e3-bd0a6d9c18aa@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|SJ0PR11MB5632:EE_
x-ms-office365-filtering-correlation-id: b97b3935-1afe-4613-a3e6-08db3fe5b42a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mwZDVtoHIdQUqhQ1On9sQVSfGw4oL0XV8gBfmGzm++bUrYsU7Oi6OH5qe+Kto1K6xGZt8vXMYGQPogq/f+PJi8NRFyqRn6DY7MDon+I73u2s21fm5U53kaaJSyxClDQxG53RqGmqCiur/TFLkh7/jyS5SepEn1TvAQdP4m+vB+9StTyohJ4WbABq43DoCbek6VvVvO6JJbEXOVWk6eAn97LrC2GazKiXXiFIA9HTNBGRwFHilJhbT7PnBhPtPDN7d9iBLNGAUdTsu41QRFcUvlVIFND5UiJM+zRHxGDLVt1zkmdeB1Q1AhNL0SKBMw0baAHvu/6ynzqLwRpbcg/9lYZMv1uKkoIgkLerLZU5Ztw9YMjga+kaiuaqiWMMNzdmeFJddCc4MEEGFoV3paffJM9AEUo/CAY8Bw2elv5cGGYfs9IWvTIpuB/pMAHHBflMSNsWnEs5oZCWUijqeEzkrWchWKiWcfoUgByESkg720R5Wn03cF/nggBjWRREzb8uZ/ecX+K872eBv6W05NSRbt6GWIx3TK8dfxrMriYt9Y7g3rN+oTbJJ+GlOQB0NMkMyOF89Z7/SM2zVEd4ml6+tm66Q66WjpNWKuprmm/879n0QzjsSZj+hQoqYxYlUpjM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199021)(110136005)(41300700001)(2906002)(122000001)(26005)(71200400001)(33656002)(7696005)(76116006)(82960400001)(66446008)(8676002)(66476007)(64756008)(66946007)(66556008)(186003)(55016003)(38070700005)(316002)(9686003)(6506007)(38100700002)(86362001)(8936002)(83380400001)(52536014)(5660300002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFFva3JUclNJdmJjRTZtWHZySE5Kdzd6UWhRcGdTVjlZNVNpbUtsZzFTcmo1?=
 =?utf-8?B?SFVVQWNDWWdCdU1oellWb1BiQUxCenA5VWx0Z0FkZWVsbzNoRTE3V3NZUEk5?=
 =?utf-8?B?eHpXaDA4NWUzR0hKZFVPa2QxTExDMWQ3ZExMbHFFUUJVMFdPUDJNb2VWR3A4?=
 =?utf-8?B?SXlUY1g4enRPakhsMGUrS0xPelppTStxb0RUZW9TYURUa240bWI1NjNqMlh3?=
 =?utf-8?B?Zjd3UVFpR0pob2RDczluZzFxMEdxVTBDdGVxRnFMWHd5dy9xMFM1UzVYWDZU?=
 =?utf-8?B?OW1IUGJyTDVJRWlmSjdUNjRGdm9RTW9LMG5nZFVuVUJqcGFMaXRUQXI3eFRi?=
 =?utf-8?B?Nlh1N21aUWovQnRkU04vd1AxVjd6aE9ldCt4RjI3TlhET1lhT3VreUd6d0p3?=
 =?utf-8?B?TER1ZThiSXJkQ253c1VZQmZxYmtwMGhyS0c3d2VUa2U2Um41cDQ3YXJEbDhC?=
 =?utf-8?B?elozQ1RneDBRSHBhU2s4SS9vNzJoWHluYVVIZWR2ZGJxOWxRdWJKT2x5eTdG?=
 =?utf-8?B?SGlJbFhpalhNeGhnWjFja0VsVmF5VHhEd3VoUTY1WXdvMzNmOXF3NWJqYU44?=
 =?utf-8?B?Vy9NbzZnUlIyTHl0eXZ5cU44WFZJYmowNW9yNjhUWFpUU3dsa2V0bWpTdDc2?=
 =?utf-8?B?dTBXR1NwOS93S2FwcnlHdkVCWWF3R2grT3ZBdWhoVTUrTU15a2djRUZPZUd3?=
 =?utf-8?B?NFN1S0VVS1dvYU1HNkU0M3BWMzBCTE1XVHdNcGRWaXVqYUlKZTZSK3RjcXlL?=
 =?utf-8?B?blRvVTBDejdoNGNTR2I4d3UxZ1BiZDZUbVZRQmhtTDBaRmhGeGsvdS9UMFF4?=
 =?utf-8?B?dmZLYnJnVHphejZPdVdOd0NvWDA1RFlqTTc4OWtnb0c2TUhLNHhUVndERTdo?=
 =?utf-8?B?V25vLzlaOGpURlUvVS9iVjJrdEVRbjVOZXZGOXIzUEJXeDdsVXlBSWYzWVBl?=
 =?utf-8?B?MCs1NlZodE55SjY1OENVMllTUm5KNlZqQXhFUjNpbnV2NVR5cHZWeXlTVHBN?=
 =?utf-8?B?TzBQNUJtejE2ZjNmc1huZ0tYZ3hJbllsUTFmQWtHNGlScXZ0eHpERmNhVm9p?=
 =?utf-8?B?M0k0NHA4dFhacms1dmt4TTJsOE5tRTBsUlJBajl4OEFCSkhlSWtoQXRlUWFx?=
 =?utf-8?B?T2RJL0pXQXJ3NVpZek51dHlEanVsUUppckdWMTJDcCs1MDYvOGNxS2pUVS9p?=
 =?utf-8?B?TGNPOEh0MnV5SkM5YjNJMlN1T1hOa1BJUDgzcnBSaTBoNjA5S2VaZTFiU25q?=
 =?utf-8?B?VVVHczc2VVZZMHFTQUNKbThwT1U3ckVCTE1FOFZzMnhXSXVJS3RTeEo5Vkgr?=
 =?utf-8?B?VWYwUitENjdpeWNwUjhrdGx1OENNYTh4S3Z6NmhkYW1OaWxCdmlnUE9VendT?=
 =?utf-8?B?WWlaNVFodXowQVViOVM1bExEcTQ2UUtVUDZxT0F1NzFwL3B3T2haeG9yck1J?=
 =?utf-8?B?bGlSWFNPeFlJUEFOSmlvbTEyWngyd29pYlpROUVRdm9reW5OTjFlTE4yM2JH?=
 =?utf-8?B?dkZUUzltR0RKeU42Z09mVzlJZW5CV1p0UW1PQUwvenFZTmpkK2MwdzlBalIy?=
 =?utf-8?B?c3E1a2JkN2I4MXpyVERLWit2dlBoQTdUY0FZbmR0TG1oV045aXhHK242QWxw?=
 =?utf-8?B?bzRxSkJzM2FlM29WN25jQVJOSTFLcThGM290RFBoK2puM3Z6VEd3RC9paGlP?=
 =?utf-8?B?N3FER3plTGZjNkMwVmlYaXFvU3B3aEk3dkNIZk1taUlhV0ZrNUlCN211OUo3?=
 =?utf-8?B?cmNEaHNKMFhDMWdjT0l0dy9ZL2VhMktPUnlkdnBUbEltc1phQUZSSnB6c1V5?=
 =?utf-8?B?TkVPbXQ3V05GQ0M5SDlBZXp5TXN2TmU3bkpuVytadXNHZUhrUnl2eEdwL2NW?=
 =?utf-8?B?ZlFPRFRUaWJiK1huYUd4TnJzdHExVEhqQ1lmVW9kVXdtT0RCMkwyaU5ZK0ZR?=
 =?utf-8?B?c05Yb0VkVkYvT1ZTQUczQVcxdEQ5Q0c2TUdIZkxQN1pXcml6TWJsdXJDbVNq?=
 =?utf-8?B?L2ZNMkI0OWxZZnczRGlUa29GU0xCeklwekZ5cWNyQVlNQ0U1OUVaTlRGM05n?=
 =?utf-8?B?VkJFSDM3M3oxMThmbno2UWpRMVlrSytRS2luTXVPUjd5Y3NPNU9PODNXYzc0?=
 =?utf-8?Q?2shhMcUeUGa7L/JNv4BBbB+/3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b97b3935-1afe-4613-a3e6-08db3fe5b42a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 08:20:00.5302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nD3MiGk+1Tecav4ldVx1vSU/akP6wgmrp3FrL1sY/iRXGQSdcSl+GPDGNFmVB0i0FIoQ0qi9d110yUxLbbloyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5632
X-OriginatorOrg: intel.com
Received-SPF: pass (spool5: domain of intel.com designates 134.134.136.126 as permitted sender) client-ip=134.134.136.126; envelope-from=hongzhan.chen@intel.com; helo=mga18.intel.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=intel.com header.s=Intel header.b=GTSC5fmL;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (spool.mail.gandi.net: domain of hongzhan.chen@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=hongzhan.chen@intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGxpbnogPHBvd2VydHJlZUAx
NjMuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIEFwcmlsIDE4LCAyMDIzIDQ6MDEgUE0NCj5UbzogeGVu
b21haUB4ZW5vbWFpLm9yZw0KPlN1YmplY3Q6IFJlcGVhdCBpbml0aWFsaXphdGlvbiBmb3Igd2Rf
ZGF0YS0+ZGV2DQo+DQo+SGksIEkgZmluZCBhIENhbGwgdHJhY2Ugd2hlbiBhcm02NCBrZXJuZWwg
aXMgYm9vdGluZyB3aGVuIEkgdXNlDQo+cmVtb3Rlcy9vcmlnaW4vaXBpcGUvNC4xOS55LWNpcCBi
cmFuY2gsIHRoZSBDYWxsIHRyYWNlIGlzIGFzIGZvbGxvd3MNCj4NCj5bwqDCoMKgIDIuMDg1MTI1
XSBrb2JqZWN0ICgwMDAwMDAwMDdhMzY1YzUwKTogdHJpZWQgdG8gaW5pdCBhbiBpbml0aWFsaXpl
ZA0KPm9iamVjdCwgc29tZXRoaW5nIGlzIHNlcmlvdXNseSB3cm9uZy4NCj5bwqDCoMKgIDIuMDk0
ODA5XSBDUFU6IDAgUElEOiAxIENvbW06IHN3YXBwZXIvMCBUYWludGVkOiBHIFMNCj40LjE5LjIw
OS1jaXA1OQ0KPlvCoMKgwqAgMi4xMDQxOTBdIEhhcmR3YXJlIG5hbWU6IEUyMDAwUSBERU1PIERE
UjQgKERUKQ0KPlvCoMKgwqAgMi4xMDg3OTddIEktcGlwZSBkb21haW46IExpbnV4DQo+W8KgwqDC
oCAyLjExMjAxNF0gQ2FsbCB0cmFjZToNCj5bwqDCoMKgIDIuMTE0NDU4XcKgIGR1bXBfYmFja3Ry
YWNlKzB4MC8weDE1MA0KPlvCoMKgwqAgMi4xMTgxMTJdwqAgc2hvd19zdGFjaysweDE0LzB4MjAN
Cj5bwqDCoMKgIDIuMTIxNDE5XcKgIGR1bXBfc3RhY2srMHhkMC8weDExMA0KPlvCoMKgwqAgMi4x
MjQ4MTJdwqAga29iamVjdF9pbml0KzB4OGMvMHhhMA0KPlvCoMKgwqAgMi4xMjgyOTRdwqAgZGV2
aWNlX2luaXRpYWxpemUrMHgzYy8weGQwDQo+W8KgwqDCoCAyLjEzMjIwOV3CoCB3YXRjaGRvZ19k
ZXZfcmVnaXN0ZXIrMHhkNC8weDJlMA0KPlvCoMKgwqAgMi4xMzY1NTddwqAgX193YXRjaGRvZ19y
ZWdpc3Rlcl9kZXZpY2UrMHhkMC8weDJhMA0KPlvCoMKgwqAgMi4xNDEzMzhdwqAgd2F0Y2hkb2df
cmVnaXN0ZXJfZGV2aWNlKzB4NzAvMHg5MA0KPlvCoMKgwqAgMi4xNDU4NThdwqAgc2JzYV9nd2R0
X3Byb2JlKzB4MTYwLzB4MzEwDQo+W8KgwqDCoCAyLjE0OTc3Ml3CoCBwbGF0Zm9ybV9kcnZfcHJv
YmUrMHg1MC8weGEwDQo+W8KgwqDCoCAyLjE1Mzc3MV3CoCByZWFsbHlfcHJvYmUrMHgyNDgvMHgz
YjANCj5bwqDCoMKgIDIuMTU3NDIzXcKgIGRyaXZlcl9wcm9iZV9kZXZpY2UrMHg1NC8weGYwDQo+
W8KgwqDCoCAyLjE2MTUwOV3CoCBfX2RyaXZlcl9hdHRhY2grMHgxMDQvMHgxMjANCj5bwqDCoMKg
IDIuMTY1NDIzXcKgIGJ1c19mb3JfZWFjaF9kZXYrMHg3MC8weGNjDQo+W8KgwqDCoCAyLjE2OTI0
OF3CoCBkcml2ZXJfYXR0YWNoKzB4MjAvMHgzMA0KPlvCoMKgwqAgMi4xNzI4MTNdwqAgYnVzX2Fk
ZF9kcml2ZXIrMHgxNjQvMHgyMGMNCj5bwqDCoMKgIDIuMTc2NjM4XcKgIGRyaXZlcl9yZWdpc3Rl
cisweDc0LzB4MTIwDQo+W8KgwqDCoCAyLjE4MDQ2M13CoCBfX3BsYXRmb3JtX2RyaXZlcl9yZWdp
c3RlcisweDQ0LzB4NTANCj5bwqDCoMKgIDIuMTg1MTYwXcKgIHNic2FfZ3dkdF9kcml2ZXJfaW5p
dCsweDE4LzB4MjANCj5bwqDCoMKgIDIuMTg5NDIxXcKgIGRvX29uZV9pbml0Y2FsbCsweDUwLzB4
MTYwDQo+W8KgwqDCoCAyLjE5MzI0OF3CoCBrZXJuZWxfaW5pdF9mcmVlYWJsZSsweDE5Yy8weDIz
Yw0KPlvCoMKgwqAgMi4xOTc1OTZdwqAga2VybmVsX2luaXQrMHgxMC8weDEwMA0KPlvCoMKgwqAg
Mi4yMDEwNzRdwqAgcmV0X2Zyb21fZm9yaysweDE0LzB4MjQNCj4NCj5UaGUgcmVhc29uIGlzIHRo
YXQgdGhlcmUgaXMgcmVwZWF0IGluaXRpYWxpemF0aW9uIGZvciB3ZF9kYXRhLT5kZXYgaW4NCj5m
dW5jdGlvbiB3YXRjaGRvZ19jZGV2X3JlZ2lzdGVyIG9uIHJlbW90ZXMvb3JpZ2luL2lwaXBlLzQu
MTkueS1jaXAgYnJhbmNoLg0KDQpUaGFua3MgZm9yIHlvdXIgZW1haWwuIERvZXMgdGhlIGlzc3Vl
IGhhcHBlbiB3aXRoIGNvbW1vbiBMaW51eCBrZXJuZWwgYWZ0ZXIgeW91IGRpc2FibGUgSS1QSVBF
PyBJZiBub3QgLCBpdCBzaG91bGQgYmUgY29tbW9uIGtlcm5lbCBpc3N1ZSBhbmQgeW91IG1heSBs
aWtlIHRvIHJlcG9ydCBpdCB0byBMaW51eCBrZXJuZWwgY29tbXVuaXR5Lg0KDQpSZWdhcmRzDQoN
Ckhvbmd6aGFuIENoZW4NCj4NCj5UaGUgZml4ZWQgdXAgcGF0Y2ggaXMgYXMgZm9sbG93czoNCj4N
Cj5kaWZmIC0tZ2l0IGEvZHJpdmVycy93YXRjaGRvZy93YXRjaGRvZ19kZXYuYw0KPmIvZHJpdmVy
cy93YXRjaGRvZy93YXRjaGRvZ19kZXYuYw0KPmluZGV4IDg2M2IyZGZjOS4uOGZlNTliN2Q4IDEw
MDY0NA0KPi0tLSBhL2RyaXZlcnMvd2F0Y2hkb2cvd2F0Y2hkb2dfZGV2LmMNCj4rKysgYi9kcml2
ZXJzL3dhdGNoZG9nL3dhdGNoZG9nX2Rldi5jDQo+QEAgLTk1OCwxNSArOTU4LDYgQEAgc3RhdGlj
IGludCB3YXRjaGRvZ19jZGV2X3JlZ2lzdGVyKHN0cnVjdA0KPndhdGNoZG9nX2RldmljZSAqd2Rk
KQ0KPiDCoMKgwqDCoCBkZXZfc2V0X2RydmRhdGEoJndkX2RhdGEtPmRldiwgd2RkKTsNCj4gwqDC
oMKgwqAgZGV2X3NldF9uYW1lKCZ3ZF9kYXRhLT5kZXYsICJ3YXRjaGRvZyVkIiwgd2RkLT5pZCk7
DQo+DQo+LcKgwqDCoCBkZXZpY2VfaW5pdGlhbGl6ZSgmd2RfZGF0YS0+ZGV2KTsNCj4twqDCoMKg
IHdkX2RhdGEtPmRldi5kZXZ0ID0gTUtERVYoTUFKT1Iod2F0Y2hkb2dfZGV2dCksIHdkZC0+aWQp
Ow0KPi3CoMKgwqAgd2RfZGF0YS0+ZGV2LmNsYXNzID0gJndhdGNoZG9nX2NsYXNzOw0KPi3CoMKg
wqAgd2RfZGF0YS0+ZGV2LnBhcmVudCA9IHdkZC0+cGFyZW50Ow0KPi3CoMKgwqAgd2RfZGF0YS0+
ZGV2Lmdyb3VwcyA9IHdkZC0+Z3JvdXBzOw0KPi3CoMKgwqAgd2RfZGF0YS0+ZGV2LnJlbGVhc2Ug
PSB3YXRjaGRvZ19jb3JlX2RhdGFfcmVsZWFzZTsNCj4twqDCoMKgIGRldl9zZXRfZHJ2ZGF0YSgm
d2RfZGF0YS0+ZGV2LCB3ZGQpOw0KPi3CoMKgwqAgZGV2X3NldF9uYW1lKCZ3ZF9kYXRhLT5kZXYs
ICJ3YXRjaGRvZyVkIiwgd2RkLT5pZCk7DQoNCj4tDQo+IMKgwqDCoMKgIGt0aHJlYWRfaW5pdF93
b3JrKCZ3ZF9kYXRhLT53b3JrLCB3YXRjaGRvZ19waW5nX3dvcmspOw0KPiDCoMKgwqDCoCBocnRp
bWVyX2luaXQoJndkX2RhdGEtPnRpbWVyLCBDTE9DS19NT05PVE9OSUMsDQo+SFJUSU1FUl9NT0RF
X1JFTCk7DQo+IMKgwqDCoMKgIHdkX2RhdGEtPnRpbWVyLmZ1bmN0aW9uID0gd2F0Y2hkb2dfdGlt
ZXJfZXhwaXJlZDsNCj4NCj4NCj5UaGFuayB5b3UNCj4NCj4NCg0K
