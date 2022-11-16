Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D229D7C
	for <xenomai@lists.linux.dev>; Wed, 16 Nov 2022 03:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668568119; x=1700104119;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=xOG4Po9/7uiXDC8K5F4drW0bmsUu+QeecRhiIMeLa/g=;
  b=HsDE63YGKFhMRHulbC/xExrYJBOwoQPW3vANoMhLN4TbgxnCj/EFAbEP
   iOctAssIn3z9TZDBW10yCANs1x7I1U1mFqJXneQztr+foiJwsbhmD36Gm
   q5xZ4qMQoagPIas1as1B6igQAsfyg+AFdyuhLo9h6lxpcDwMLolF/YEv9
   9b1tw+VKUDS05ClGAmqALzo7F1K2wQnLSzLSP43DdQ0asrDypPftgpTfm
   JQMTipqm8pRIAdfkYU4lRsI4K6RKdVeBd8uymxNx1Z2EbMpcQNmIF7sKT
   A0y+WU2ZNat1n5rBSH0oqr/rdSWmBknLZDabn089kJ9tl6e72qJD5LpVg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292822644"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="292822644"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 19:08:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="590027809"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="590027809"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 15 Nov 2022 19:08:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 19:08:38 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 19:08:38 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 19:08:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbqKxVGS7sOEpxXBoFsroziGwaeWItHBem+XUT2USyYsQgH2/iGbt6MyxWy9hdjKz1lUPmze7psOI6Ly7jmavR962gUFUZK+cCV5aUsFI9/P2HG0GqkYFbyF4+bdvrnkBAPR/mk3UPi4PQ5lJMTjLSyxPA7hKxyJtpqRsNs0SH13uIAYQUFrUlAZ/LR4ip50G6IcclSyY1Mum84iC5Rccj358zCQDcgaD1Q0EU6qjLe68um78+30up1CECYzQWv54o1p2VLGXuXqAoj4quOY8Yo62JlFxZa4NFIQW7p7fxBdt8S2d8KrEAvN839GBXiGcyu5z2jf4UK0dWvWCzvtCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOG4Po9/7uiXDC8K5F4drW0bmsUu+QeecRhiIMeLa/g=;
 b=SDoYdrUVvJR0bW873IbdeIgvan1224GX7FaFjpfkhD7vEqcTIGMXjvcDoWi1dS+wIvJLvDWaXCPPP5yn+OI5hOC7NXOa+8sDObnJpYZ9xViK+Ffavd9e3Kzn69PvdtKdCfk34LceCWnHs7R40D9TV7sWpZW+mQBv+lEACWzCAq8I/ykOW3J5hVLdTsijtBdQV9bY5pme1nKowPd0eX9x0A/VimqKFAZprEZ77daniHYbnUxsWS7P5ORvfhfaBCgVh7RFC33a5alCPZqAw8O9TVw8ZmeS0ny1qiPMqHJcaGYS8o/rNUAP8252jYWO37QUJKefcLhDzfve/ryTeGVx6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 03:08:36 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::27cc:d8ed:9947:fecb]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::27cc:d8ed:9947:fecb%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 03:08:36 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Nov 16, 2022, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Nov 16, 2022,
 UTC 7:00 AM
Thread-Index: Adj5aKwMJaRc2/L+SPa/KNz06eDM3Q==
Date: Wed, 16 Nov 2022 03:08:36 +0000
Message-ID: <MN2PR11MB4285CF48BF7010F1C5B35D52F2079@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|LV2PR11MB6069:EE_
x-ms-office365-filtering-correlation-id: ee75d99b-737d-4a97-4471-08dac77fda2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c/EjqVBLVftweJLAI/w6iO8qyXQHNI9N5EHY0bafgYKwFTOABK9Apb1YonjRNopUxLOrQOKKN8+5YfEc/7U1eQ6yv+eTcIsrEqQoxeiUHty8Ny7HTbzxDgTUBCWTDmnzvnxzsYp2g7P0MQ4QcIvg1OZY7yffZalji5HveHVDWrVDVrf7Cxq/gGQ9BZ+VnAZG62Zc4O/t7U4OiObnXlgDjHMXFrOyVyso0l32JlWRo3kcen3oti0Of1bkXzYAo0aLedXLrGhwhl20aIDZpuBQcNmxPtmIHwyVxlim2Iukh1258TRUMtCDT0PKnNBsuWfshLpcHsrr4t5UNubbzTnPckFJ/mFVngBNHhDuF/Cp/4+hJHdGs/yJ4FCzn/Hysv3XNt9zCDMaAMPjn78ReTq1/CcopDJwbsOJz3CLIHIYb1P2JwlPx+mZIut8McSRhA0tw/gm70hlE0IgkX9g5SacfJhXK6jgF8aRg5K2GXW34QKKQ0sBay6S0nJd3fz4nbbmhVc67BRRZeN6ca/mSmLZ94tBrW3LZiVZBIxis3c4Ws0mSvOD7+sw5Ww+5SzmE4nwnITSD7i+Qm6tyiQAZLUDUvquK4uQH2iweeaIrZzuupnL0UgXf/ztFwuDZywhgty8D7tcLybvJWIsNgjRqePqlf8xz2UYOa3K05A/j+BxiWcxvZYIXtF+tB5hHHuMb1oyHQwauh80CAxjDNAaYgtDhNs/klISLYn6TFhzPz7o//u1Myhn7sf7MCtIJhAlb5AF4CFqsB42cbPesRiF0rg2yVPMtpF1k/6LLTZ0FHtOQkmu0iYhs5skoVy537TzSL0dr9f4I3Zt0h3PBU18WT61ZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199015)(7696005)(9686003)(71200400001)(478600001)(6506007)(26005)(66446008)(66476007)(41300700001)(66556008)(66946007)(64756008)(76116006)(8676002)(6916009)(316002)(40140700001)(83380400001)(186003)(966005)(52536014)(8936002)(38100700002)(55016003)(33656002)(5660300002)(86362001)(122000001)(82960400001)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDRzSXBoZk5YVytVRjkvTTJFZnowbnFmV0NBclJVb2xGRUZkUjBXMUl3dzZX?=
 =?utf-8?B?TXpQaDJsdVNDUlVxL2E4LzVmQnR6NWYrMFZodVd6VlNuUEJacVNXR3RrT05K?=
 =?utf-8?B?b2UzRjVuNGczbEdMT1FHUjFlTnpSNURibGxZM3hrUE9pZXJQaXptY1NjZHJh?=
 =?utf-8?B?VGJlTGwraU1PeTFpa0kvTGFzdTJZYzFUejNpRHo5Z3gxeExEUXV5ZFp6R2pN?=
 =?utf-8?B?TXM3SzVNTTdub25CMnpGMlJETUYwTzlYTGFGWTBPM1FNSnZJS2c0dklkcDUw?=
 =?utf-8?B?RUl5MUZZVEtPVEg1UXhTTG1TUkNvMEJvckE3eVh4QzE4cFlJTFVUd3ZUSHcw?=
 =?utf-8?B?VlkvZkVSRUVQOWFPa0YzWEZLL0FBYmFHeWtCOUJ1b0RRTFVEbHFEWEZ0YWQv?=
 =?utf-8?B?UFVadGdLNncvRnNMYys0K0NyVWlNZi9mOW0zT3Q5STIyd0NIWTNhT1JSK2xs?=
 =?utf-8?B?OVV2bm5HSjVwbEdXWmRReFFqOXlBL0NYU1RYRzZ2bXNUMlNsMlZ4eVF0V2d0?=
 =?utf-8?B?WXIwdlpFTGs1WEVNbDhVSEhqKzVJeDd4Tit3cW4zeTJiMnpWQlM3ekFwOEtj?=
 =?utf-8?B?RG1SdzRtRWRxSWp6TEJkN3l0dkJwRElvckl5Q3pwdFNJd3RIelVNZytLZks5?=
 =?utf-8?B?bHRmUE1BR1o4K2hIRnJzUURiNXRJQUNjaXpzaC9GOTcyTFk5ditzUEU3ck9t?=
 =?utf-8?B?RldnQ215WmQyL0NsRDMxM2hubWRlaWZ0Wi8zcmVnellqSDNDdHJOd1lrdmJ6?=
 =?utf-8?B?a1dpdmFWb3BTMitXUjF2Vm4xTmcweXZMeHJWTUdQcTdJUlA4THIydGd1d2hl?=
 =?utf-8?B?NVRFR2tlanc2eDVmL0lJYkJrcitYNDZWanF6a1J4WmNqTUQ0SUloYXRFSDdy?=
 =?utf-8?B?QUxxQ0pmbmNvNmZ3RC8rTVJVYm83c2RTMWR2aU9Xc2dSWDViRG5zR0MxUFlV?=
 =?utf-8?B?QmNiMnpwZjFmdHJXOHhYMUdTYmlEaDFFYjBUN2FDV291aC95Ui8xZ0NuSzE1?=
 =?utf-8?B?TTNsOE1nRHpLUjY2R2dEM01vbHZIVC9WcGtyZ09hZml2VlNnMkZ3VGJuRHh4?=
 =?utf-8?B?NGtMRHBjbVFWd3JJdGtzUVZ5MXRBME1sdXA2YWk4ZDhTWGFXR1psYW1GS0li?=
 =?utf-8?B?bGpFbEJ0QlV5Vm1GWmFSd3h5RTg4R1g5V05xcE15NlRXNkRBbWRmMGc3SEg4?=
 =?utf-8?B?NEpCUS81aGo4bFBmcWNuU2FyRXpNRWUzSFMvMmFKellTUXVwUXFqYzNrYllG?=
 =?utf-8?B?MFdlVGw3eUVPVnRWK0ZkWWZkMDhBTWU4cHlQNzFkd0FkT3dUTEF5UzRCT2Zn?=
 =?utf-8?B?MFNrKzRFcmNsOUt6ZUtKdGdieGVSTk9BTTdWOVVkVmNnSndaUjF5WlA2a2hq?=
 =?utf-8?B?bXd2cDR5TVpBU0hpV25wSTN2dnBzcVlIOHM3b2lVcndRK3hqTnFabitjVHc3?=
 =?utf-8?B?aHh6Y2hneE1JQ0dDekJsMWd1Mkw3NklYSXA3eWx6MTVTenlva0tVWXBwM1d1?=
 =?utf-8?B?eDQweGVqWEx6eExEVGdmeVZua2xld3ZOa0tPaHQzK3JzNU5aMXJ1bXR1VlM4?=
 =?utf-8?B?NEVXb1JONDVqV0QwcWhDRjM5bm14MnlDM2QzeU90NTN3THg5cldHVDdMUjlm?=
 =?utf-8?B?UmZJc2RGUTd5bHNMckxUbDhUZnp4TWhFTWI4Y09SUURtZjZqZFV2SVZUU2Vw?=
 =?utf-8?B?K05FY2pGNlpUMUZCbHQ5dnpqK3hiQXNwS011eEthb1YxUGJyOGVOeUVpYXdD?=
 =?utf-8?B?K3NoR0g1L1lrb3Fna08wTXdTNE42NFFlSmkyREF2Lzd4UzE1cTR1Wkllek4v?=
 =?utf-8?B?Wk1MbzlDWDA2aUpzNE5nVFgwa3A4TkdPa0QwQldSQ1dVYjVhQ1RqanRGV3d6?=
 =?utf-8?B?T3ExSlAvNC9iQjMxOHBuZGJZVE5mUWxjNkxkNWJjMVgvYU4rWllUN1RCQWt1?=
 =?utf-8?B?ZXVMdnpiVlVPcEUxNlI4VXZKdGNoWkI2Q29Fcm85NC9vYit0N2NvYm5DR3ha?=
 =?utf-8?B?bFJHNHBpQytQQUlCeFcvUHlnZ0J4c1p2WGFXRjE5MU9YeitWMjVXM2lOOEtu?=
 =?utf-8?B?MXFrUm5FVlNJbjVKL3RMQWRKbmZXVC8wNU1IOHFVVXVlVm4relF6VkpyV3Q4?=
 =?utf-8?Q?r+kbOqhhzmnY4Uca7i192f4GM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ee75d99b-737d-4a97-4471-08dac77fda2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 03:08:36.1495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vb8ApAHv5Us0i9oYrkCh8aSn5aomnNgQ2gm8ltutwmryD2G7+NhCx841XUWZ9aBcpayIV9+Yqv6FGWGiSaF9LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6069
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgTm92IDE2LCAyMDIyLCBVVEMgNzowMCBBTQ0K
UGFyaXMsIEZyYW5jZSBDRVNUIDg6MDAgQU0NCkNoaW5hIENTVCAzOjAwIFBNDQoNCkpvaW4gWm9v
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
MzY3NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQoNCg==
