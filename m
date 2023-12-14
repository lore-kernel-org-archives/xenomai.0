Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E791463D
	for <xenomai@lists.linux.dev>; Thu, 14 Dec 2023 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVNpC/aG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702516879; x=1734052879;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=wkNkc3/yV5aDD5cEbqUV7ky5caIQTxwg174hkOL5uXY=;
  b=jVNpC/aGyIWu8EF9aOHtH+emnJh72KnQe2yBDqoZMPsTJPIRPtUvrNwl
   APN/6JLeR/oJFWa80ZcyHqAUd2uwsUfBoUHxPk1cHwfiIMeJeOccFsSOV
   lFj4ZXbz9TUizNHnRDA5KBQXFfHrW/xIqpuU/isHA/StsxHw4s8/PVgmM
   LOuQpF1EwOLWaX5AJGfqVoT4gvNXZRDVO60v7ypU4AtHVWRf6YJalgCP+
   lYpGOO+njU2IM9KbeP5vLac7DueZgG3IUdKHq1tLIiM/CYBQBC6n0EMKH
   w5JjbwKSFvNIZoYOeGwoxtIxx7jVXNpGtmUSI4GnyYed7neMSMHvfRq7E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="2224657"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="2224657"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 17:21:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="803076254"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="803076254"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 17:21:17 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 17:21:17 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 17:21:17 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 17:21:17 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 17:21:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxuxeACa9FiO8ayZXFYWjzZIIU418jEx/R6fjdm6O2bkEzGUCbgAnuItxyWVERyK89slq15FGDax/GIBTYeOmAOPawA2ofldtmdypzslImCs1q5u6H/3eyTKAdUXrNvW6xdIXJ8+0VdweavA3Zb7ChdDLgRsJQGlinvjM8hFR8c7eP2Kt9eA4u4GuQrNdjQH8cu0pgtROTh43d0uvhccRPV9idF+Ae8Lk7XC3lRKbHobpx0sO3PpwsnudvL0Ybli6k+d5jCoixrwZzQzX0vd01Dnk+N6enfrY2pnhdAUotHoe6mlARKoe1LTF/GEp7o53xPZXzCxDofViP9m2W5ERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkNkc3/yV5aDD5cEbqUV7ky5caIQTxwg174hkOL5uXY=;
 b=RqJW9awhGjP4aE2eSH43nwDTo+k9Dh9pRh0258WcN/ddkopxMpJgcuKryeG+1kKiNTUuITtGZhWuPcAERLCoCcuRdmKpPsys55qp9w0P3tg1cSyctpY83yTZo2owxB2J+S+xTqh60tt8P/B/X9EQfj7P5gVljJZZgVM7XDHO4L1S7J9hdH0vFhm4QAM0BDrLUeIagvkq2ATKl45OefA+E1OAUdI5XX/QXGoIF23GmDZZVB23gQrNhF3yHV/1glpxXHOEYkpLXvlFeuuJI3+TUGLkDYoTUkzs6myG0wRkN2xqBW81J3cMthMTMnndDhFnsXfCFnpTd0gMKcmB5qtKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by DM4PR11MB6264.namprd11.prod.outlook.com (2603:10b6:8:a5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.28; Thu, 14 Dec 2023 01:21:12 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7b71:c300:be05:d512]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7b71:c300:be05:d512%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 01:21:12 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Yao Yongxian <yxianyao@126.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: What are the differences between different versions?
Thread-Topic: What are the differences between different versions?
Thread-Index: AQHaLaj9b8G2miNQkUeox3PYSfhKV7Cn9WoA
Date: Thu, 14 Dec 2023 01:21:11 +0000
Message-ID: <MN2PR11MB428539504F3EF0AA84AEE6BCF28CA@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <208a3551.545f.18c62666921.Coremail.yxianyao@126.com>
In-Reply-To: <208a3551.545f.18c62666921.Coremail.yxianyao@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|DM4PR11MB6264:EE_
x-ms-office365-filtering-correlation-id: 6f3c3e96-2701-4664-2aa1-08dbfc42f569
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AtpVBy9exraDvNKw33tQly4Zek2pMySu4I03/tnJUp7U6ySiARUyS8cqlA90tQGvc9LG0ICMgy6RTghny7yhBXD1E0nptuq7vmtKNwZ/5G/U6FUVq5xuX4kgBW4tkwMlE9kbHiHJNfULkm43og8ISgwDaJF9+QB8e+rTTy0Yv2nyhJMvq/Y2ma1OO+cbjLv14swXxzxrH/Hgcoj75GmIf11g8faEViRLU6u6vqt99v7ILYgpXR2pGnZarKCvL41z6nhjjzy1pUWScfWXoYpw4YoLK95tpPFAEKFQFoej+9V8U7wNjiSSRusqBuhnH1I15ezH7TBjXTAbquqd65O3OeeTi6LsJr+OW8JLseVJH5IdYqDUX74ubbhYpjkupYgI102fNYYmuW9FZu7xtXawHZYZq/DF/El3M539p78/75DXt7H+PdDqWqyybjFn9UigITatkyRBAhOU33x3DHgbrXHDGicq9lg46S/eWWa7zBVs4horHe0tziPIvpGEMOutmJfSKQsVmoZT+OYM5UwNUwtRKHdH4PXO5dcQQnX4IhkvLbPr5x0wRHgck4TnT3X3WRNsGAoy6ZLJ/urE37CSFZPtXBWEjTMRH7SxOzsXpxn7wSgxwnB/sFkvjH7nwZi4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(9686003)(71200400001)(83380400001)(64756008)(66476007)(316002)(76116006)(66946007)(66556008)(66446008)(110136005)(6506007)(8936002)(7696005)(8676002)(55016003)(26005)(478600001)(52536014)(5660300002)(122000001)(4744005)(2906002)(82960400001)(41300700001)(86362001)(38100700002)(38070700009)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWdOdk9pNXpkbWY1UmJ5K3JIaVBlRCtPV1ByT0hjM0N1YjdPU3doZkx2aE11?=
 =?utf-8?B?cGlUQTBZY0I4WUZndTgvdlo5MVhIdHJacGxUZGdsRk9tM2tkZ0FXcm1rS05V?=
 =?utf-8?B?clNIUnBUYllZOGhONng2a2FuS0FOUytGNk1LTzNkaU5FK0FwUmFtUVZ1TGJC?=
 =?utf-8?B?cVRVMllsYUZ0elBkcU92ZnROeTVSSzRFbGcyMzJhVzQ3WlpsZ1o2dDlUT1BV?=
 =?utf-8?B?b3JXdklVdmpqY0VuTStmMmdzVWk0cEg3RGw0cktmSnFveG5iZ3M3d2FvTzFR?=
 =?utf-8?B?Z0ZMRDA2RGthSWYydFpPVlZjU1hycUt1ZFNsMVdTZnZ1YmVuS2ZSUnhFQWFy?=
 =?utf-8?B?ZU5OWVhpekRFTTlDazRpbzFzN3gxQUpOTGNrVTFmNXJwcmFvMHNUZytSVGwz?=
 =?utf-8?B?dWhVaHJnR05DSWczaFArUE9JR01iVG9zT1FGVWhHL0FET0NWdWM5SGMrZUUy?=
 =?utf-8?B?QmlNRzJONXBDa0t2MlpQampVeDI2MVBHaS8wanMrQkt5N2dYcmczbXdvSDlG?=
 =?utf-8?B?WUsvMDZCTFNwZWlvcGtxRlZrV0pBdVlWQm1QaW9pWkx0eWVjTDdsell1eU1F?=
 =?utf-8?B?QUdBa2lua3MvVGZHWjYrNjFyaWF2M2RMNytGUVhRYkdFOUhJOUxhcy9tOXpa?=
 =?utf-8?B?QlI0ZWxzYkVsZ3pYSCtnRVl5Yk5SUE00YXZpL3g4OTEwKzRiSmcrZk9jNUVt?=
 =?utf-8?B?TXBVVXc4OUZIZTMzQkRNeFQzT3BPOEYxNEFTVmltaEFyMFJ5bmFXTzJ0Z2FV?=
 =?utf-8?B?M2hNdVg2R2ZEQ05nTWxTTTZtNmhnWDViWVVtdFBZNzM3dnRuR1hlV2dGUlpp?=
 =?utf-8?B?Z3orUHp3SlkzYnoyVDFoaGNBU25ldENMWWNnUVRPZkJzaStNYjFmUW80c0hT?=
 =?utf-8?B?c2ovY2NMN2VRdHhmUE8veXczSnlaNUd6OXRUcW1NQjQ1RUxBNUwramkwN0xt?=
 =?utf-8?B?b3BlOW4rS3I1ekR1aEdMMzZNb0JZWURpUUMrbnpmR0ZPT09EOHI1QWh0L1NC?=
 =?utf-8?B?K3N6VU5QUS9QSURhVzE2ZUZrbmlRTVFpSi9pcHZJSGpoa1VMNzJMN0tydUZ5?=
 =?utf-8?B?VC9JV3FnRm94ZDNOaWNKMkdjQStTS2Rta0xMdExWaXFMcHpOVWNPMGRlYnd4?=
 =?utf-8?B?OUQ3QWw1WmFhS1daZWdqdHYzNjU2THFNTzYrSlBkRUpqMW1EOWQ1bHdGa052?=
 =?utf-8?B?cVpidkxHb1ZpUWlTL3pNOWNVN2NHbllOVENPTUdMdXk3c0RMb1V0a3N1VTVO?=
 =?utf-8?B?L244TzgvQ2RqbnBiZk9QWENTdnoweWF4ZFh3MHVObDJYc0tBeDVEcFhUZThF?=
 =?utf-8?B?RU1haFhqSFZtNWFFRHVtZjh2VGtWdWtnbWRFS2MrQTVqaUhnY1BJRmwxUWRS?=
 =?utf-8?B?MXUvQTBRRk5YcnBZSVNTOExPcHY0VkNja1owdTdxU0hnNkpYeDFXSUpZbzY1?=
 =?utf-8?B?cTI1YnZPMk1qU0JrRHJtYkhDUDd1NHdTMkJpVzdQd1BCd2pRQ1E0WHd0Qjhh?=
 =?utf-8?B?NjF2R3NKZ0UxR2NVN1J1SnIrVGxPcDJNTG44OE14Y21rbDJGa29GUXZUaXVx?=
 =?utf-8?B?R0NpN3FyS0FJR0ZDd2N2NWpRdVlnbWo3djBnVlhqeTQrSDhFZVdCUWJ4SkdW?=
 =?utf-8?B?dHFqN2J5eGZYWkEzRjI4aXVZTWlTZkgrU2daVHVQT2RORWh3eDdMbmZNZ3Ri?=
 =?utf-8?B?QzRISDJFSTU1ZG42M0V0QTNOTzRud0pvU3dmY0N5ekNBRFhEMHBjd056L0Rz?=
 =?utf-8?B?blJ3amxQeUJaTkNZNWVzM1M5bkpIYUtKcnlnN0ZOTU54U1VPMllnSkhsbkVs?=
 =?utf-8?B?T0d2VUYxT0xaRHhDYnltWG1Sa1lFckFMcGgzZ3I1dm8vMks2bzhDUEUvTTl4?=
 =?utf-8?B?dVNsMnJtbEp6L0orOVdGSlcxOTdpa1JqZFBkck80eDNKR3BIYkdPejFyaGNo?=
 =?utf-8?B?dEZURUNMbUpTV05KUVE3Tk8vK25HVFhCZGNqS1NJV0JBV0Jzclc2MjF4dmNY?=
 =?utf-8?B?dmp4NjlXbi81ckY3N0I0RlNERy9ndTJKVjBNa29uaHUxc01tdTZoZXM3d0lE?=
 =?utf-8?B?dTZqZ0IreHkwbldCSXhJZm5ybkdjYVBuZm9HMWdZOUhXR0dmUlNPY1JQZTlx?=
 =?utf-8?Q?oAedfyHJTVKTGrF6E7FRwgjIR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3c3e96-2701-4664-2aa1-08dbfc42f569
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 01:21:11.7850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajtQjTYsQmcTOKRWij8B9m73WkAgpbc9eXBEIjuNJj2IqpFvouw07yW7Itu45EHjti6kPVusAeNRJrbb3vKZcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6264
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFlhbyBZb25neGlhbiA8eXhp
YW55YW9AMTI2LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDEzLCAyMDIzIDQ6NTkg
UE0NCj5UbzogeGVub21haUBsaXN0cy5saW51eC5kZXYNCj5TdWJqZWN0OiBXaGF0IGFyZSB0aGUg
ZGlmZmVyZW5jZXMgYmV0d2VlbiBkaWZmZXJlbnQgdmVyc2lvbnM/DQo+DQo+DQo+SGkgQWxsLA0K
Pg0KPlRoZXJlIGFyZSBzZXZlcmFsIExpbnV4IGRvdmV0YWlsIHZlcnNpb25zIGluIHRoZSBjb2Rl
IHJlcG9zaXRvcnksIHN1Y2ggYXM6DQo+DQo+djUuMTAuMTk1LWRvdmV0YWlsMSx2NS4xMC4xOTUt
ZG92ZXRhaWwxLXJlYmFzZSwNCj52NS4xMC4xOTUtZG92ZXRhaWwyLHY1LjEwLjE5NS1kb3ZldGFp
bDItcmViYXNlLCBldGMuDQoNCiotcmViYXNlIHZlcnNpb24gcmVhcHBseSBhbGwgZG92ZXRhaWwg
Y29tbWl0cyBvbiB0b3Agb2Yga2VybmVsIGJhc2UgdGlwLCANCndoaWNoIHdvdWxkIGhlbHAgeW91
IGVhc2lseSBmaW5kIGFsbCBkb3ZldGFpbCBwYXRjaGVzIGZyb20gdGhlIGJlZ2lubmluZyBvZiBr
ZXJuZWwgYmFzZSB0aXANCmNvbXBhcmVkIHRvIG5vbi1yZWJhc2UgdmVyc2lvbi4NCklmIHlvdSBj
aGVjayBsb2dzIGFuZCBjb21wYXJlIHRoZW0gYmV0d2VlbiB2NS4xMC4xOTUtZG92ZXRhaWwxIGFu
ZCB2NS4xMC4xOTUtZG92ZXRhaWwyLCANCnlvdSBjYW4gZmluZCB0aGVyZSBpcyBuZXcgZG92ZXRh
aWwgcGF0Y2hlcyBmb3IgdjUuMTAuMTk1LWRvdmV0YWlsMi4gDQoNClJlZ2FyZHMNCg0KSG9uZ3po
YW4gQ2hlbg0KPg0KPkkgYW0gY29uZnVzZWQgYWJvdXQgd2hhdCB0aGUgZGlmZmVyZW5jZXMgYmV0
d2VlbiB0aGVzZSB2ZXJzaW9ucz8NCj5XaGljaCB2ZXJzaW9uIGNhbiBiZSB1c2VkIG9uIHRoZSBw
cm9kdWN0Pw0KPg0KPi0tDQo+WWFvIFlvbmd4aWFuDQo=
