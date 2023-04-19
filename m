Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5D115A8
	for <xenomai@lists.linux.dev>; Wed, 19 Apr 2023 01:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681869505; x=1713405505;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=3ZXQTJ58J/mhg2SD3jinHFUcku9QKrJwDeOXnt5F9eQ=;
  b=UBYbg9RX+9XF1HWpCzSyDz5NQ37YFYyslzftrKM797gIujsKiFZ0Tt9d
   SYvCgtPHOAKmd7S2nrrqeTqM+M4gYOBaNsIlEXTrHEwMrGRwiJTqXwbUp
   Pk97Th0CrAKvXGKrouFitwUIqiLsdmJFL60hceAv2P2CBLb7eiBLJ06yq
   Ekf8kLj/P+Dq3Qe9CxWvnVAQJDgqWck2x6fPLD6Lh/c2Rfbr91FL3tG95
   Wr1LyrylMmJa9SFd55M/1xk+jt8sNFE4kF9jtBNULqAWSRD9YAGgr60ow
   OEXHFA/bmHGZEzjIFPFc5HiPiusIADgLy9PmE07bVCofu8Luh7WYkq9a0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="345324746"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="345324746"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 18:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780690891"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="780690891"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Apr 2023 18:58:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 18:58:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 18:58:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 18 Apr 2023 18:58:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 18 Apr 2023 18:58:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YE7g2oqODmjoC92HEl8Uc5t39grZg6k94vnPw3TrTBr/axztEXwHD5WanV1QVr8Yey61+BKKqOB78OqoZ7EjAnu4med+LSOkABP/tRR/sYMtskp3NyM2e3OqGa7kq1rVLYzq+RQ0B1qs+FXdQlkt7foWopWlJtI5i25Con29gyxJEf3KtoN2iFq5RbZZ6lWLcjE81F2c3dmG2M33973uBh3uJeZiEzMo5+ssss6fXFzQ5FWTOoA2fbO4Vo8F3R6YsEYgh8sx/gftreizhXUSom2HvIJ1By9dV85OoIIgGp/QL8y46IWItp9p/t3GzapWl/kY6vrvj2pSJz/iLkZ/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZXQTJ58J/mhg2SD3jinHFUcku9QKrJwDeOXnt5F9eQ=;
 b=b5O8auavMPzQwQ4Ye8LDBf8dLevwAGLal6xHaqH9PZ7RV2m6TJFIoUy97d+idF/i8WjBB6bZAman0Zob7hjSqB9ZTd9+U/GzIYc8HoI+4OBv34fKHWV8f4Ve4eilos/H86h9jrEj6QVoHdUp1W61ucN/XoQ0O4cmf3EWWYGE0ms1YgtE23HuEU2EQUB/Jn7pmQ60w9bMnBXUDo/HSeesm+08vFCTgAMduVvKy0rPBYYnVgE0f+j0ABdPStke6aDI/yXDpS7/fkUjPbddB54pB5Yy0Wt3CSujkIpzWf+RaYNgP37yoWvuirap2vlyyUP1zbT/tT0ykWULU7QmICEKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by DM4PR11MB6429.namprd11.prod.outlook.com (2603:10b6:8:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 01:58:11 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9822:1058:3a7e:e502]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9822:1058:3a7e:e502%5]) with mapi id 15.20.6319.020; Wed, 19 Apr 2023
 01:58:11 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Apr 19, 2023, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Apr 19, 2023,
 UTC 7:00 AM
Thread-Index: AdlyYlEI2rqfHCfoRlmw6Tb46lpdRA==
Date: Wed, 19 Apr 2023 01:58:10 +0000
Message-ID: <MN2PR11MB4285710FC546B7C5DA7B56A4F2629@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|DM4PR11MB6429:EE_
x-ms-office365-filtering-correlation-id: ee1901b0-8bac-4995-2574-08db40798762
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IezbYbxB5Exg2U8WBlb5NcSxN5aMfzo+kYaubnj5xHWkib10QLDCgLh+M/jMX+AESNwNefsQgaiPGqwTW9moSojOFXwMxziq+cA2vh7DKZfg9pucjfK0//4GFqZY0iBkLrv01za5DvXyPXr6swn8mgoc4Z+69p8w3dsxJycnZxzrXdHcMmsdzziTnj/18JHy2bXYRcH9SSwm0mo2YU2EabRDWx2OYmb/yz6OjhB7KRg95XgCMzTwcy4cJFlzZ4Wg6rQDjckuBzRITK1vU2nINFWNK/JUQBSbVRTJs8zCiibTqRALCg4L6yB9DpcYqwwudnXL2EqH1IgG7Y/GZkNpJ9HgELceXGYe7mfMVy1GWh8w3RlS/KOZlpLMosTUMP73Ct05a1eXpej4LgbCMx9kO5VCj9HccbVA8m/03FRYplrTwHVqtmhXHm/Wb3yqFBarqwglzqmBLHIDOX2zgJHPDgrSynJp7XUwaPBW24XWwdhlyUgI3ByjpZQhOQ+8NAw8wuKipU7ep0XcutQhaEPmFR6mCbx4evyV6o99JzP8JFxnbwNKe9HLQqfAtylRu3zGr9lwADNMBtK/TSKMgjerRkUfjbehXLs7YqWswK56N86zZXwyILLHs4gow3UJdBMfwKpE3lwgtLDc6nGFkeR6pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199021)(40140700001)(33656002)(76116006)(316002)(6916009)(66946007)(66556008)(66476007)(66446008)(64756008)(966005)(41300700001)(478600001)(71200400001)(55016003)(5660300002)(8676002)(8936002)(2906002)(52536014)(86362001)(38070700005)(122000001)(38100700002)(6506007)(9686003)(26005)(83380400001)(82960400001)(186003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2pUd09CeW8xMFl4NlZkbXFJbzFyUWI2RnhKM1lpRE1XT2d0YkhqNlF5RHZa?=
 =?utf-8?B?dEtDZkl5M3ZUSGpzNDRKeU93RXZWc0xVVHdrRnRIV1FBY1pmRUhDK3B4OFU2?=
 =?utf-8?B?N1QrMXNHdTg5WU43TXk3dXFUaGlTWCt5eE9KRTRiUnFiSzRPTzVUaWVmc3du?=
 =?utf-8?B?QUtmWGJmdnFTbjFmVWVOL0w2Q2VEMDlzMGFvcWRFYy9iWjBWTWRSWU9jQjdD?=
 =?utf-8?B?MlFuSkh5UjVYNFEyaUpRUmhsMmpXNFkvaUVMSEVTMUlBM2c3bGNmZDFoRVpm?=
 =?utf-8?B?RWE4a3NlcjByUklZR3lhRlcwTGZkV1RkcktQcGt2djhxR0JreWp5NEV6Mzkr?=
 =?utf-8?B?UE10c2tyMGhqR0JVV041UG1MMDlRWlBUNVJtY2NjcXdRcDB2WS9SaDBpOTY5?=
 =?utf-8?B?bG1qS2k5a05aUEpqNmlVR0lBeDdSNGRnaXkvbEh3dlI3Z3NYMWF6bDVpdU5V?=
 =?utf-8?B?dkdjM3BpTGIzTjBoU1Bzd0xqeVBZNjBtZXBKTUhBK1U2Z0ZrQUY2WmVnUkxV?=
 =?utf-8?B?eFpGdkRIZHZxM1pnbnFJU0xwbENWeFQwWHdYb3AyTVBqT1ROdkpweEx6dnds?=
 =?utf-8?B?QXhFMVJ3NG52aVkvVWN1b3pyelpjSkZPV25tTVFvUnpCNUw3U0lKcDk5Z044?=
 =?utf-8?B?ckRQbm9JcUtUUXNudEgyRitXUGo2aTVxQVVQTUFDTks1Nng3QmE5U3RUYnlM?=
 =?utf-8?B?MFREdzlQZFcvMFdjY1JzUEpuRXh6dFpZbDJoWC9qa0lSZ3dNdFVQNkprWTNG?=
 =?utf-8?B?T08wdFkxbURKdDBxam11OHRZRU13em9ub1RDL1ExK043Ymp0azhmbGdRZmtq?=
 =?utf-8?B?dnZUREU5clY4NWNmUmRaOXNoaGt1SGM1b29vc0hyNjg4RXNndTREbkIvYmE2?=
 =?utf-8?B?aDlRbWxLaXc2Qkw5VUJxS3YrbHU3cEJFZXpWUjN0eW5GTXV6djY2OUkxMzlL?=
 =?utf-8?B?dUg5MDlDeFhqZTdPUUxVYkdqR2ZJdFQ5aXR5bktQR3F2Tk1mRmNRZUdhWDh0?=
 =?utf-8?B?ZmRBcnhLYnRJR1kxaUpSdUYyRVBsWEFCT1Q2QUIweWI4Zi9UNkk2SzA3S0Zr?=
 =?utf-8?B?TzU0K0hsOG95VXFFaHJEK3hqRTNNMURMQWJOcEo3MDF6V2JLanVZc21qaDV4?=
 =?utf-8?B?SVRvTHZVQkRCWVcrZU4yN0xWSGk4eTFCWFgzVUVPQTBndWwrYlI5NGlqR3dq?=
 =?utf-8?B?WnRTVjNpZUVwSmdIMWE0ZmpjdjZab0p4Zk54eGtLSUduYnZsK21HcXMydDFw?=
 =?utf-8?B?T3BSS0Z6RDM4bkluOUI0bmpVUmMxQWFUelVFQWRkaVh6UHJON3U1aktUcXRo?=
 =?utf-8?B?bmtaOGFjTzhPSUNUWWNiaWp1ZG5lVzBscGh1Z3ZVQ0hOQVpNaEU2QzFrbFZP?=
 =?utf-8?B?N2g2YXZZcE5Id1l5V1NoaDdFdVJ0bkNvZ1BzN3JrOGUrVnhyNy83Umc3K0pq?=
 =?utf-8?B?SHpWVnJLQWJKZlVGTUU4VUdIeHFKUFBrdHhickROOUxKWm4zUnNxRWxOWm9T?=
 =?utf-8?B?V0VvZVdWTXZkN3ArOWNFS2sxc2pqZlNzTnJjenIvS0FRTU14Z2twWnJzV3Jx?=
 =?utf-8?B?ZGw5Si9jL0FwUFdoSmE1V0lndkZtaFZ0RW11RDNJdW9LWmx4aUxxWUtrUng4?=
 =?utf-8?B?cVk0UHNUR3hSMncreHMyNDhVdmloQVRZOWpVaHhIUUNCTDAxZC85dVY2WjJM?=
 =?utf-8?B?bHhuY0tBczFnZStDNXhnWHVXYUtpWlZrWUhLUDV4bmhBQitOSUlNTTdJcDc1?=
 =?utf-8?B?VWw4VHRqL29XbG1penR6YnI0T3EraTI3djY5SXlsWng0RUY1NUk5UW9ObmNH?=
 =?utf-8?B?UmpoYVpOY2RuTXBUM1QrMFRBYVo5RFdRMzdOYjNGRzNUS1BxQm5vSCt1UUtr?=
 =?utf-8?B?OWZuU3FpUUtQWXJhVk8wREJVRkdvMXZGZEVuSEZJK0FLNzZ6RVAvWUN5VWdO?=
 =?utf-8?B?Lzdld2hWak9DQ1I0ODFFcEsyNHZEZTNFNHJNMnh3eVl6bDEwSFljV1JLeHVN?=
 =?utf-8?B?azZnd1hzdVZMZVVHdkVtSzhzcGtVTkdYL05abGRxRmx2OVgrelVlZ2xnMC9B?=
 =?utf-8?B?SU9tejladm1meTlqeVRjT3kxdHMzakFWSmtodkxoL3Z3L3pYMThMd1VDZkRE?=
 =?utf-8?Q?M5WsxTQwnS8fSFbGKdN8laDk1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1901b0-8bac-4995-2574-08db40798762
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 01:58:10.9039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBFDc4vT4WTzwdU8esKtfDi9cprGMUVCmkOkG7DWVCyaq9uNOIx4YUy8oKnGRai3mouCLb1EZB2cxTPL5CLSGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6429
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgQXByIDE5LCAyMDIzLCBVVEMgNzowMCBBTQ0K
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
