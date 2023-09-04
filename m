Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A36194
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 00:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693788174; x=1725324174;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T7N42MiNgFlFR6K/puOzWny4jS2bSqqOZ4539VXZRkk=;
  b=VqO787pGD4uzre9EDPhiE53Ql3R7pAB67DMDhyX0KdwfJrFjmmpb9GL3
   ScnUJSHadSFyjcJ1ucDOXViY2lcmYKk80ESIkA7xdarC8rgGCx24kGQjQ
   YOmrdT84tXYi3wZBXSM9Nk7mEc5jIYptq2fWqbrrxKHG3JS5M6O6I32DA
   NARbuNei3uln14Y/vFcPsD805sJiCpN4n8s92Rgw48p0S72kbJmN/HTp0
   sl7HEktBjRre4typDgQoaHJxmEkbUcAjB1l+VsyfNDKUoo+APt5nl6LRN
   fDK4JmDtBzfxdj+gWaJOwFDdt3L1twLFvDuARscJaYVBUIPMvlT7Rk/xa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="380283179"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="380283179"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 17:42:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="914324678"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="914324678"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2023 17:42:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 3 Sep 2023 17:42:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 3 Sep 2023 17:42:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 3 Sep 2023 17:42:52 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 3 Sep 2023 17:42:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkE5ux9go0SKj5oV3NBe0oJhrxKZ302aAuDxORIATQI5bdDUzcS4PTCGxf9BkRQ75LxQ3OyFft2VX22y4RW+4lXm5l8gY/U1K2cU5QrOJXvi/9YJnCbNKI2/LDkONaIULLmr/2R/MRDwM2qnldILfHkLWSlLxytSoGlXG1oWyvSrAJcEu2+m43n7s8tQZG8SN9kPYcYftsoMwrLYvdMx5T3kd5SjWmLEzEGBksdHkio+mDeGvIEEGpsA/P/Y6/FkBLI/hrNjDazIH57Y9OhNLDcM3PPiPTJoLDZbrkDMR2fjjCTDnetVfd8SeNOGk0jSCEvaotGil6aJXvqybGmecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7N42MiNgFlFR6K/puOzWny4jS2bSqqOZ4539VXZRkk=;
 b=guTaWXLQG9kgAD8J0a0aAwZZClUjGCDEk6IAbuwIzXrpQl8I6kHzHn/KQX/a7Hn1+Ed8eUp7yWwMLcSzasZzZguLrP8TetDK7jw5RwAKFmSfVypfyPs+Zw7WokwHhiVo8CCSlxzQE3utZFtcuTSo74wKmuZa8PLNyhCc9Md3o3h5/7IFCxybFj1rysAugH2Zdbdi6t6jeoKIYaMu4ExmS/9V4Fw0dFIZkJ1/zOZIGayBJx35CYUoypNccc81C0yDU3YAq0o5D3kW30bYUHT5Pw4YckKnt3WPAlU8qmNk0FApeLtzV0aLAIIAVpUM9OwLckMVGBRsSTRmXsSEHsJ4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by SJ0PR11MB7701.namprd11.prod.outlook.com (2603:10b6:a03:4e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 00:42:49 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9f36:bd07:796b:9d38]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9f36:bd07:796b:9d38%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 00:42:49 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: [Dovetail] Intel GPIO pinctrl
Thread-Topic: [Dovetail] Intel GPIO pinctrl
Thread-Index: AQHZ3L8xFGTAEpgpNkqcC+oQvBaCmLAJ148g
Date: Mon, 4 Sep 2023 00:42:48 +0000
Message-ID: <MN2PR11MB42858A80CBF7D11D73AE0CDEF2E9A@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <87v8cuuqzb.fsf@xenomai.org>
In-Reply-To: <87v8cuuqzb.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|SJ0PR11MB7701:EE_
x-ms-office365-filtering-correlation-id: bf497759-a7a0-4bd0-95f5-08dbacdfdcda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a5Hd8ZQ201iFVtP+3qZLOoeek8uHTbm1IOSi/z2zQdL2rTj26v4nkLS9xoG8akj6VjX1T8HkX35S/C8JKES7lsBBIHpld1dRG8GoEL0+FuDEgs9GqLxJ2YlwyerE6wzxiMzxNwi0/Eo4ItnU+yP1rryouEPnMhQB7o6vOu0c9iz0lupAjr/eC63Ne+YcvByRap0117+X8zvqRiqbE0DGs8LBYDgHRVGmgpMzsd6icZpYLIRUv2TxJve4q8bsSX5FcsAJA/HMnP9qOLNIQLrWtakbT62NvBvduIWAMzP3ds0+yYVeB5iQcX5ZnoWpD+dsBEyMjo9V3fU+c7dd1bfkYaLkCSEZSvVTKOspqGhPe3+D7AbbyvCkwG+NJA/zrUl3FM51AcFyOzMOJC4uOtzGdVBkH/BRDXSLYJnJ6jVnLiuxwfVPxwDa5HBTvW3MvgzjemzA4UseNXI+6ywSu3zAX08AGIJHgwfeTrwrpm0QVlW2AHgm6PKlD/Rlkt81Hh1MmhBwNZVPySqw8jut6MPpkL9l2pv5XkTjR4iyfGiweKVhgs1kqZazeJbMKtjepk7ftPNlXbzlYtOWZGAXqX8s2vJo45/QIUvqk80XhkTJE4mrIQopfkusiukdFF+P9R8L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199024)(186009)(1800799009)(66556008)(66446008)(66476007)(316002)(2906002)(64756008)(76116006)(66946007)(86362001)(6916009)(33656002)(55016003)(5660300002)(52536014)(8936002)(8676002)(4326008)(41300700001)(9686003)(38070700005)(38100700002)(83380400001)(26005)(4744005)(478600001)(82960400001)(122000001)(6506007)(7696005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3NhMS8xUENsNk1nVXU1aHJwb09EZUVVang0UFFUNU1KSkpRcXFTREVkTkV4?=
 =?utf-8?B?WlJoc29sam1Ua3BERDR6aEJ1bStocG8yVUJ1UnVaTUVIK2x0azJ2MmdjOTdu?=
 =?utf-8?B?MjQ0WU5xbElobGJrWEF4b2hnbXpHaVgwbGQvMXBxZG96OUhtRUF5NkNuMFgr?=
 =?utf-8?B?UDhZQkpRRE04K3puRDZRZWQyb1h5Mm45V1IyRDlGNGI0NWJuaFQyR21GY0s0?=
 =?utf-8?B?bGxZT1lYeFlMa0tTenFZdlJYWXEzTzA1ajNTRTBZZmFEUG1HRVUvaU1kVnI2?=
 =?utf-8?B?UmhZRlBTdlp0U0pyRUxDNnZIMHBpZktxWDBRMjFiOGRmZy9SSFNJdnhIOEh4?=
 =?utf-8?B?dDZQSUdMR2pPWWFUMTNBK05pWXNLSGIxaUgvZUhtcEJOU0pUSEkwc2Z6NXdU?=
 =?utf-8?B?Q0ZvZFIxZmNQWmJIZTF3ck1XVTJWQUZMNUc4S0U2am43elBCQjVkdWxHKzVx?=
 =?utf-8?B?S2RXT3JjY2M4SDFQeHdrdGZSQjdYR0h1a1VtRTJkalNSSGthcmU4bVRnMGUw?=
 =?utf-8?B?Rk5PM3FncVd6NmpqY0JNV3dFeEFvOFE2SEFIVHdYTlJQQnlvZ1hVL2lzditt?=
 =?utf-8?B?UlF4QnU1OE13M1FDSUo3R2ZpMzlNR3Q1dmFZdWZEaTBKN0dEY1ZROVk0bHZV?=
 =?utf-8?B?cjFZK05WN29xOERSVjdiUVpQWUZPT3NvSVBOdVFDdVRhakl0KzFRUFBacFdU?=
 =?utf-8?B?bXBpWUZuSTgyWG0yRm9meENYc1diRU84a210L0tadk5kSGxZdGdxcWtVZUhG?=
 =?utf-8?B?YjN3YTBEUEs5b2RaWGtwNGJqWjkxMUp3OG4xL2ZmTUtKOWxsUW9mdlp3S1dn?=
 =?utf-8?B?bGFlT01nWmd3TlphcnNCZ1Z6cVRsVFZ4Qm8zOHI3dDN2S29lVk5Henc5cGp3?=
 =?utf-8?B?bFIveStDRHlCZWpTMGNNK2dDeTdjZXZqWnFzMk42NGxtSjhXdWo1d2t1YTZr?=
 =?utf-8?B?K1E0Q0ZwTnpicHV0ZWp5aTRqVG9YZWZSbC9CVE5paVBRaFhjVFZ1SlQvMkZN?=
 =?utf-8?B?RTNkdHJxU2FyT3N5Q3RZcDd4cTJINHdQaUNqUGV4WkllM3RxQzBJbWpZdVNG?=
 =?utf-8?B?bVVFclVzdURtc1NBOWk0d3NzZ1ZzVS8yRHNSdi9Lc3VOa0lMbVB1bHhuM1Fk?=
 =?utf-8?B?ckhrSGcxeXNtVjZwQW9WQWV6UlU5cnd3Ry9IdWtFUXV5bkZxMlQrOVFnLzY2?=
 =?utf-8?B?aUJ0ODNDTDBrR2VKekFuM2dEclpHSjIvZ3hnOGRLTE1rZldxdW9pVHNSTlRV?=
 =?utf-8?B?N3FSREN2dDFVYVhQaTNka0k3eWxpT2RUaHJUUkFoakZPdndFS1BoUEVPeTVM?=
 =?utf-8?B?eGZCOUZVYS8yWkRUUkJFUFY3TmREazZkZEZoN1h4Tk5MSmEzZ2pWTFVsbElF?=
 =?utf-8?B?ckRkcURzdGFuYzZHb3hjV0YxMEo5VTZzanM0MzRaM1NPeHJPU3dXQzltMWtr?=
 =?utf-8?B?RFN3d0s2aTJSY1BjL1dnMUY3NGFxeE5sNTRkQnAvQ2E5WVQ3cFQyTklJL0RR?=
 =?utf-8?B?TTJnOVZlQ0xhN3lldjVHRGZaWExDN0toSUdUK1VhMDZrUjR3cHlPMUordjEx?=
 =?utf-8?B?ZHNKNFpZTDZhQzQvVnR2TjRDTVNMMVk1aFZzSnpwRDEvV3paSGVORjI5RklP?=
 =?utf-8?B?TUpVdmJ6eTNRdXV1cmRtK0djdkY0Y2RELzhMTWs3anVrMFpWbU5iWkcxUXp4?=
 =?utf-8?B?dE50a0wxNms4bWZTUDJRWm5hdTNHZHBDbktrNUsrSTZtNVR2TEVZcldDRk9K?=
 =?utf-8?B?RElGeHJ0U3BWcGQrL0tOc1dOYS9GbklPZngwME9TK2dOa2R4Y29MR2NDVERG?=
 =?utf-8?B?V24zaXU4R2VUWGdmcFpWSTJVTDdGY3FkaDFKelZSZmlTckdNc3JIc0x0VWFP?=
 =?utf-8?B?RU5YcFVjNS8zNk5LRWFrYVQ4R1NVWC91N0lLLzVyT3RvUDNGcEh3NzFuK1hn?=
 =?utf-8?B?dnZ4YTdncVZaSWU1TGRka2ZxZEZPd3BGSEJ2ZGZqaDBMWXA1WDV3NUpqSmlC?=
 =?utf-8?B?SnE2OE5pOElaaTQwaUZzS2JhTlFzUXIwQS9zQTAreXZZbVhXaVZZUDNxV3R1?=
 =?utf-8?B?TlA2L2NPVklPZWRMbFBJU1U5RWdsVUJiYUVWUTFXcTYyRE9nK2NIZTBzM0k1?=
 =?utf-8?Q?/dTNlfQoebU5ZWA+2XSQACt32?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf497759-a7a0-4bd0-95f5-08dbacdfdcda
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 00:42:48.5460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqNoooEQAkfK63AnvTdG1KGx3FEAC8AyjqMOmcOLmnP09jrLEcdxejb5nOOqFheUMaD6M0tf/9yw14qEdVZBaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7701
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBoaWxpcHBlIEdlcnVtIDxy
cG1AeGVub21haS5vcmc+DQo+U2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMSwgMjAyMyA2OjE3IFBN
DQo+VG86IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVsLmNvbT4NCj5DYzogeGVu
b21haUBsaXN0cy5saW51eC5kZXYNCj5TdWJqZWN0OiBbRG92ZXRhaWxdIEludGVsIEdQSU8gcGlu
Y3RybA0KPg0KPg0KPkhpIEhvbmd6aGFuLA0KPg0KPkluZGVwZW5kZW50bHkgZnJvbSB0aGUgb25n
b2luZyBpc3N1ZSB3aXRoIHN0YWNrZWQgaXJxIGNoaXBzLCB0aGUgZHJpdmVyDQo+Y29kZSBmb3Ig
SW50ZWwgR1BJTyBwaW4gY29udHJvbCBpcyBsYWNraW5nIHRoZSB1c3VhbCBpcnFfY2hpcCBhbmQN
Cj5sb2NraW5nIGZpeHVwcyBpbiBvcmRlciB0byBzdXBwb3J0IElSUSBwaXBlbGluaW5nLCBmb3Ig
dGhlIEJheXRyYWlsIGFuZA0KPkx5bnhwb2ludCBjb3JlcyBhdCBsZWFzdCAob25seSBDaGVycnl2
aWV3IGlzIHRoZXJlKS4NCj4NCj5EbyB5b3UgaGF2ZSBwYXRjaGVzIGFscmVhZHkgYnJld2luZyBm
b3IgdGhlc2UgaW50ZXJuYWxseSwgb3Igc2hvdWxkDQo+dGhleSBiZSBhZGRlZCB0byB0aGUgdG9k
byBsaXN0Pw0KDQpZZXMsIEkgaGF2ZSBwYXRjaGVzLiBJIHdpbGwgc3VibWl0dGVkIHRvIHJldmll
dy4NCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo+DQo+LS0NCj5QaGlsaXBwZS4NCg==
