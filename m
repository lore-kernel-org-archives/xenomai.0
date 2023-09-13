Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537D7FD
	for <xenomai@lists.linux.dev>; Wed, 13 Sep 2023 02:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694572622; x=1726108622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zVti5kfkxJSl0nN2okakh1QAgkdSeXshFleQImZishc=;
  b=l/E3uDxFam27+hKf4AlVzTT8SrlNv+Cvkc+SpSW84PWBCJGsRr4/zxTu
   Vz9x4xX5z/NkEMdct4n/iiokP91aXKdFpaYSqLCPDyOeUA2Ox6BsPFJcI
   4zIbAa65eh/X8dZX+quXVtf7cwcWAz5Vk9IZZHEtTsDa+Np249qNhQftT
   jOB6DMOoBziCDi5OzFmOze69EFZRncIE0IIttFBWy6UvNOFCPsLsdn0i6
   p3aQHqQdFmh134FreYw4hg1OiAa2RXN0utfvN42JbcePeiG6O50fAEbil
   iu7zLpemSA+fmFTbbe67knuJytQvNvKao8WhaRLEOqBN6QRtzKDtwYfUe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="381247798"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="381247798"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 19:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="917663526"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="917663526"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 19:37:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 19:37:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 19:36:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 19:36:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 19:36:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFEPQdvrVfTkxq2WFN7d2AkVQDbG2u3BuKBJ1wq3PsB11OjgnbW3cSITKDnUwXizYB9VeSRYnG8BiJMo3Z/ERtYyp9/Y1QDU4DPlrCl1K9Rww4vxSiar05mHDi0F+WV0+YYUuTJbU5ek7S8E3kDSfewvZRToSBDOjnVci6C7bovngXDxU8qDb1+VQN3r0aYsDWXLdybX6DFGLE9I61v0T3f1szoALO7MT1RLwTCSyua00NOgKfQUzOfKLQjKSrs+ABYoroqH8JDDLVDLXbZCnvGfvRbOozPdgtpHu52f47waRs/dgwwxinUrr/qVtLGKD4bnhcam8wL7QfYEF7uZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVti5kfkxJSl0nN2okakh1QAgkdSeXshFleQImZishc=;
 b=KlqTPJz+kyrHMurpcTbRC95b4JmvJmpbX2tkoqJcFHjP2Y2zL3TC3O+CTlfSSCJ6MspBpKcA/+9sFrOQY805OdVWDHkB3sfH4pGG/Q5u9o6jAafFxKEyYgnZS5wYlf6VlRqQtIrMUmsPG6UeoaSbuzCUjG9vNa7PDACRKou3ogdQ6hA1TWN7KanbXlQWwZDxxlU03YMvNDXB5AlDEf7fLqSQPUHs9fjW1SlkiyrzJUR299MfqssJ7czCubUWOsBjuf0q9B3lmAWIJfyNQUudQl+jVqkFArEQueqxRWv0VifTguzaEUo0jkLIXT5fmUByx5QLxLAOcQ94B+AJMs34Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by DM6PR11MB4722.namprd11.prod.outlook.com (2603:10b6:5:2a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 02:36:52 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::b478:c959:e429:dbd1]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::b478:c959:e429:dbd1%5]) with mapi id 15.20.6768.036; Wed, 13 Sep 2023
 02:36:52 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
CC: "Wang, Rick Y" <rick.y.wang@intel.com>
Subject: RE: [Call for Participation] Xenomai Community Meet-Up in Wuxi
Thread-Topic: [Call for Participation] Xenomai Community Meet-Up in Wuxi
Thread-Index: AQHZ5Zn5BOXMal10CEuN1Xikhv6fiLAYB94w
Date: Wed, 13 Sep 2023 02:36:52 +0000
Message-ID: <MN2PR11MB4285FD97FA97886D5D6900F9F2F0A@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <56c4c74c-d971-4cd3-88b4-0cf1ef50c4f4@siemens.com>
In-Reply-To: <56c4c74c-d971-4cd3-88b4-0cf1ef50c4f4@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|DM6PR11MB4722:EE_
x-ms-office365-filtering-correlation-id: 724810cd-4ce4-47e8-3a9c-08dbb40249b4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F8+o0wi0KA+k2LVJazYDLRyhhKcahYtJSOVOi+go2EX7JCyljy9UijzVfRgBKvoe/Z2SVrCbEw66PyIWOrQToMQru33YwhfIgdV4YvpqNTylIH+3l/M4hywt1xcN6xMS/qWxkqhHOwmXGvtoJS9ffNU8qTTWHL2D7gPHAVIjxT1nSQ8C7inheGXtbyQELXDMkMzbveA3CfnH5swOnRNSSXIrMuyoVmiPzgq5+cOSJ4FGLuw/Ne6JyQhn08BI8fF2JdJPSK8iEHXnX99pFd4F6yvGudNLUEvjD2pLgFPTf+1VgNKsSPgCHwpZ8izOz9HqG7xdv+FqeV0mFYOkMRkI3R67wLj4vz4qlW9mR19PbucQr0veSBrQlSY4IeuVJtFJLE0mKUpZnhrg2U8XCNn7git3nPtMC7Vrr4NoPYFsqx67/EBEMaoDfAFoas5w4nuIghvyqVEGIi+WL91JAgYT7samm1cn+cjfjsFWkiXo6c64ejP/6VcrH8Sqyr4sWek7CRNsgTGoxBRZKB6pnwUKr9Ajk/K7uQ6Qm+v38rFPsWjOkIKHryQ9mX5tyhIEUSWJu5MeGr8vrJxpi5oXIWkSwZMb2CofQcsqJxuvDIVwhNYoPX+u0fH/t2Wv8Zy6HKlY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(186009)(1800799009)(451199024)(107886003)(26005)(478600001)(122000001)(38070700005)(38100700002)(9686003)(6506007)(7696005)(71200400001)(82960400001)(66946007)(76116006)(41300700001)(110136005)(316002)(66476007)(66556008)(64756008)(66446008)(66574015)(83380400001)(5660300002)(4326008)(52536014)(8676002)(86362001)(55016003)(8936002)(33656002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzM0UEw4Zk0rZ1VGVkhNMURmZ0NYTWM1Z0lnRXpKOHJUS0FKQTNveThQS2t5?=
 =?utf-8?B?VGFlajhqZWhzeFEwcm02QkNrc0hZTk02Z2VsUmV6RVNSRW9hWnFvaWJxNHRk?=
 =?utf-8?B?V1ROanlUa25KaWtHczdrWnVkK0djdWdZb0pTdTEzS0RoMDdyVVRwL3E3Vm9J?=
 =?utf-8?B?SDRRS1pRNXdJc00vbEJ2OG5ybUM1czRVK2xwbW5NVTVXdlVVOTJ4bHJ1UWh0?=
 =?utf-8?B?ZmthTGZkdUgwUFJnTmYvUWczZ0dGcDFSM3l1THVoQ3V1WUF5NmszdmFpdUpX?=
 =?utf-8?B?QnhkSDFQTEQ0b3BoV3FVVFBZL21JQkI0R3NudThFVkJqMGdydkxKdnFMRWVI?=
 =?utf-8?B?NHA4L2xXYWhuSXl1RW9lVCtoQlJTd2crME5URE5WbU4yZEMwN1k3bk5mTmFD?=
 =?utf-8?B?OTRhd0dZbHZtaW9QT29DTkRlSGNGK29MRnZMKzBGemg3VFBUMy85ZXNmT2pT?=
 =?utf-8?B?aWFXZnIrSEV3eUhaVGZObm1wb0pySmRvTStFL1hwWHJmUlBiUU1iU3RzdFhG?=
 =?utf-8?B?cUFYK2I0V252ZlJQUmo4UkNncG1mTURQWVRWeXlVZHZwMkVDcEVmZEdqM0o2?=
 =?utf-8?B?V0hlOTVlNW43ZkNhNzdHT3I5MkxjeHRpYXMwZEdLVEVLK2RYVTF0alVZQlVX?=
 =?utf-8?B?TkR1RVZZMTBLNElvTjQ2bUhubE5xMStwRzJ1WUlrZENEdFkrcXNpem8vUkVh?=
 =?utf-8?B?dTlCYjhEYVJrdHNnLzEwY2ZwUG1MZnNUMkp2MjBjOS9TTmUrajljQ1QvUEEv?=
 =?utf-8?B?aHFIVmN2ZGhsQnRaV1k5SksxYkUyeVpjZnhwZW53UytzTmN1OUtVcE9tMzdp?=
 =?utf-8?B?anJ5Y0ZKVjUxNnUyRnJCT29lalU5aUp4Ty9JeVdDczNQS2JhTHErNS80SEdq?=
 =?utf-8?B?cElnVDNMSVV2MzEzVy9aMVpLSFhYQXkwVUtuUEhOZHE0R0lyMlFlOVd1U3ZS?=
 =?utf-8?B?dXE1K21zMGlaOG9KSG40aTF5cEYzQ1ZiaDBTcXRFSzhxWlRzUk0rekNDNUZ4?=
 =?utf-8?B?ZjhDQi9ldWZacTllN0FlWTNmUzdTVVlVZENlRVJPNEZIZk1wUUo2dTBPYm9F?=
 =?utf-8?B?UnlEVy9hU1h5VVptV3Y3QzNremZPYUd4Nk9RN3dmVm02akFYZDdVckVCWlhL?=
 =?utf-8?B?TWpVdlA2VTZmQ1R3bitBMXBkUWdydVlTT1BKNVpFQ08zUGtKdmxOT1l0UzM0?=
 =?utf-8?B?aFkySXZFVGRDSGVtd0x3U2pXRnl2Y2p5RkJSa2gzRXk0U3gyaVl5a2xTTHNp?=
 =?utf-8?B?RnJPd0V1VXh5U0pRTTN1ODRHQ0xhbE5ZMmlwV0ZnU2VFRVJ3RHVPSlM3NG1o?=
 =?utf-8?B?OUl5N0RKSFpCeGxNa1kwT285STZmZi9lOWtub3BoV1NGTythYVhwakZQVHBv?=
 =?utf-8?B?SGpDVmVlYjdhdUJZczlkU2dqci9FSHE4RXFQRHc2TUhMSjNJRit1aDdZTHAr?=
 =?utf-8?B?NTJ2L2t6R2lUWGZFQ2c1a2hxUWxGTkwxS3ZEU1MwdWJXc3ZBWEJ6TjNuZHR6?=
 =?utf-8?B?VGMxV3NhbmxrcDlFSFpQUmJXaTZhbWlCQXJFZklhUG9LZXhPOStOdXp2OVBL?=
 =?utf-8?B?UnNhYXJmeStQVzVScTYwZ05XeWsxV3UxaDVzM2JLT0ROZytYbGxKUjliRGFo?=
 =?utf-8?B?SWI3VG1tTnlZSEo0VFY5SHdzNjdUaXBWd0swZ1R3YmtvTEljNU1ZZC9sdHpl?=
 =?utf-8?B?THAyaW9KVzlxTDBqQm5heW5rZkZSMmM2SVQvRVNVd0VVZ2pUUGZjTmNPZ3lF?=
 =?utf-8?B?L1laSVdNdnVaQUUvd3o2NUZBeStWWGdJUnNXUjZ2emRuc0JSR0paNVA3VHNv?=
 =?utf-8?B?a2F0eForZU91U1lNOXVja2E5RGdQNUh2VSs0MG0zV2JnWmV1aE1Ma3h6V25n?=
 =?utf-8?B?d3c0VkpLR2JxWStadU50SUFOYTk3MzQxc1pkTEJFRlAvQWljQ1ZXaE8rM3dE?=
 =?utf-8?B?OCtQb0tTaDY4YmZBUnpjVnkyaEQ4RGVuaWRMb2x1d2M4WmNQUGNHamJHOEVm?=
 =?utf-8?B?SVh3aFpXNU5TbE5XYm5DaTcxQkNBWktoWmlrOFNBR0ViTlBEU25hWllEUUZl?=
 =?utf-8?B?aG9uUmFtYThiTDlCVk9rdEVoaVdQNFAyc3FGckp4SVVFOW5sbjRjcHNDeWFH?=
 =?utf-8?Q?wn73ocSYJS/jfA6WBsrA19yt+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 724810cd-4ce4-47e8-3a9c-08dbb40249b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 02:36:52.2115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pSBFE3N17as5iOx1osYwPO1xdtX+yhGPafJOWfMkQx5fKsYS6O6QE3oh1OGSrCigvehV+LSuskv42MhGD9TDnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4722
X-OriginatorOrg: intel.com

54Ot54OI5qyi6L+OSmFuIEtpc3prYeadpeS4reWbveOAguivt+W5v+Wkp1hlbm9tYWnnlKjmiLfl
kozmlK/mjIHogIXouIrot4PmiqXlkI3vvIzmnLrkvJrpmr7lvpfjgIINCg0KUmVnYXJkcw0KDQpI
b25nemhhbiBDaGVuDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBL
aXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogV2VkbmVzZGF5LCBTZXB0ZW1i
ZXIgMTMsIDIwMjMgMTI6NTUgQU0NCj5UbzogWGVub21haSA8eGVub21haUBsaXN0cy5saW51eC5k
ZXY+DQo+Q2M6IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVsLmNvbT47IFdhbmcs
IFJpY2sgWQ0KPjxyaWNrLnkud2FuZ0BpbnRlbC5jb20+DQo+U3ViamVjdDogW0NhbGwgZm9yIFBh
cnRpY2lwYXRpb25dIFhlbm9tYWkgQ29tbXVuaXR5IE1lZXQtVXAgaW4gV3V4aQ0KPg0KPlRoZSBY
ZW5vbWFpIGNvbW11bml0eSBpcyBwbGFubmluZyB0byBob2xkIGFuIGluLXBlcnNvbiBtZWV0LXVw
IHdpdGgNCj5wcmVzZW50YXRpb25zIGFuZCBsaXZlIGRpc2N1c3Npb25zIG9uIE5vdmVtYmVyIDMw
dGggaW4gV3V4aSwgQ2hpbmEuDQo+QXR0ZW5kYW5jZSB3aWxsIGJlIGZyZWUgZm9yIGV2ZXJ5b25l
LCBqdXN0IGEgcmVnaXN0cmF0aW9uIHdpbGwgYmUgbmVlZGVkDQo+YmVjYXVzZSB3ZSBoYXZlIGxp
bWl0ZWQgY2FwYWNpdHkuIE1vcmUgZGV0YWlscyB3aWxsIGZvbGxvdy4NCj4NCj5YZW5vbWFp56S+
5Yy65q2j6K6h5YiS5Li+6KGM5LiA5qyh6Z2i5a+56Z2i55qE6IGa5Lya5ryU6K6y5ZKM546w5Zy6
6K6o6K6677yMDQo+6K6h5YiS5LqOMTHmnIgzMOaXpeWcqOS4reWbveaXoOmUoeS4vuihjOOAguav
j+S4quS6uuWPqumcgOazqOWGjOWNs+WPr+WFjei0ueWPguWKoOOAgg0KPueUseS6juiDveWKm+aJ
gOmZkO+8jOabtOWkmue7huiKguWwhumaj+WQjuWFrOW4g+OAgg0KPg0KPlNlc3Npb25zIHdpbGwg
YmUgbGl2ZS10cmFuc2xhdGVkIGFuZCBhbHNvIHJlY29yZGVkIHRvIHNoYXJlIHRoZW0NCj5hZnRl
cndhcmRzLiBPbmUgc2Vzc2lvbiB3aWxsIGJlIGdpdmVuIGJ5IHRoZSBYZW5vbWFpIG1haW50YWlu
ZXIgb24NCj50aGUgbGF0ZXN0IG5ld3MgYW5kIHBsYW5zIG9mIHRoZSBwcm9qZWN0LiBXZSB3aWxs
IGZ1cnRoZXJtb3JlIGhhdmUgYQ0KPnNsb3Qgd2l0aCBRJkEgYW5kIG9wZW4gZGlzY3Vzc2lvbnMu
IEJleW9uZCB0aGF0LCB3ZSBhcmUgbG9va2luZyBmb3INCj50YWxrcyBmcm9tIHRoZSBjb21tdW5p
dHksIGluIENoaW5lc2Ugb3IgRW5nbGlzaDoNCj4NCj4tIEhvdyBhcmUgeW91IHVzaW5nIFhlbm9t
YWk/DQo+LSBBcmUgeW91IHdvcmtpbmcgb24gcG9ydHMgb3IgZXh0ZW5zaW9ucyBvZiBpdD8NCj4t
IERvIHlvdSBoYXZlIGJlc3QgcHJhY3RpY2VzIHRvIHNoYXJlPw0KPi0gV2hhdCBkbyB5b3UgZXhw
ZWN0IGZyb20gWGVub21haSBpbiB0aGUgZnV0dXJlPw0KPg0KPuS8muiuruWwhui/m+ihjOeOsOWc
uue/u+ivkeWSjOW9lemfs++8jOS7peS+v+S5i+WQjuWIhuS6q+OAgg0KPuWFtuS4reS4gOmhueaX
peeoi+WwhueUsVhlbm9tYWnnu7TmiqTogIXmj5Dkvpvpobnnm67nmoTmnIDmlrDmtojmga/lkozo
rqHliJLjgIINCj7kuYvlkI7ov5jkvJrmj5Dkvpvpl67nrZTlkozlhazlvIDorqjorrrnjq/oioLj
gIINCj7pmaTmraTkuYvlpJbvvIzmiJHku6zkuZ/lnKjlr7vmib7mnaXoh6rnpL7ljLrnmoTmvJTo
rrLvvIzlhoXlrrnkuK3oi7HlnYflj686DQo+DQo+LSDkvaDmmK/lpoLkvZXkvb/nlKhYZW5vbWFp
55qEPw0KPi0g5L2g5Lus5Zyo5YGa56e75qSN5oiW6ICF5omp5bGV5ZCXPw0KPi0g5pyJ5pyA5L2z
5a6e6Le15Y+v5Lul5YiG5Lqr5ZCXPw0KPi0g5L2g5a+5WGVub21haeacquadpeacieS7gOS5iOac
n+W+hT8NCj4NCj5QbGVhc2Ugc2VuZCB5b3VyIHByb3Bvc2FscyBjb25zaXN0aW5nIG9mIGEgdGl0
bGUgYW5kIHNob3J0IGFic3RyYWN0IHRvDQo+amFuLmtpc3prYUBzaWVtZW5zLmNvbSBhbmQgaG9u
Z3poYW4uY2hlbkBpbnRlbC5jb20uDQo+DQo+6K+35bCG5oKo55qE5o+Q5qGI77yM5YyF5ous5qCH
6aKY5ZKM566A55+t5pGY6KaB5Y+R6YCB5YiwDQo+amFuLmtpc3prYUBzaWVtZW5zLmNvbeWSjGhv
bmd6aGFuLmNoZW5AaW50ZWwuY29t44CCDQo+DQo+SW1wb3J0YW50IGRhdGVzOg0KPg0KPi0gQ0ZQ
IGNsb3NlczogICAgICAgICAgICBTdW5kYXksIE9jdG9iZXIgOCwgMjAyMw0KPi0gQ0ZQIG5vdGlm
aWNhdGlvbnM6ICAgICBXZWRuZXNkYXksIE9jdG9iZXIgMTEsIDIwMjMNCj4tIFNjaGVkdWxlIGFu
bm91bmNlbWVudDogRnJpZGF5LCBPY3RvYmVyIDEzLCAyMDIzDQo+LSBFdmVudDogICAgICAgICAg
ICAgICAgIFRodXJzZGF5LCBOb3ZlbWJlciAzMCwgMjAyMw0KPg0KPumHjeimgeaXpeacnzoNCj4N
Cj4tIOaPkOahiOW+gembhuaIquatou+8mjIwMjPlubQxMOaciDjml6XmmJ/mnJ/ml6UNCj4tIOaP
kOahiOe7k+aenOmAmuefpe+8mjIwMjPlubQxMOaciDEx5pel5pif5pyf5LiJDQo+LSDml6XnqIvl
hazlkYo6ICAgIDIwMjPlubQxMOaciDEz5pel5pif5pyf5LqUDQo+LSDmtLvliqg6ICAgICAgICAy
MDIz5bm0MTHmnIgzMOaXpe+8jOaYn+acn+Wbmw0KPg0KPkxvb2tpbmcgZm9yd2FyZCB0byBzZWVp
bmcgeW91IGF0IHRoZSBtZWV0LXVwIQ0KPuacn+W+heS4juaCqOebuOinge+8gQ0KPg0KPkphbiwg
SG9uZ3poYW4sIFJpY2sNCg==
