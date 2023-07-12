Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53D8DDA5
	for <xenomai@lists.linux.dev>; Wed, 12 Jul 2023 08:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689149380; x=1720685380;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=JNMaFTqDpdAi6xp3bIZsUoVQBQKZk1SEzTX7Z2nAYyk=;
  b=ClG1/t0dFBRIUYkpnUPEEo1yH4czkKwAYnjdLwXVwOHLxowhoX1pt8z+
   JGmjkyf6w+Hpbh4dfYcIgRPTL3z1Mk4/fBNPaCgpBrTcdbCfY9h5rRlyD
   3RLbP04gCsWtfp+CIrJWQd7lqP3E2UMb+3dtZOXYOG7NTQGLyC43Gvls0
   e4Eco6GQFBpPt6Gp1REDRWfzEO3DdEkHgb2aLarkA9g+5yJ2EmJdqo1Co
   5Ea+k3h2PY0SRuwTjzm21ZaKHLVQiDhWaQF1vxuCToE/77NifCqTr2aCm
   6nXDt7NtpU9cvy3YVzi+ENmgy6f2/eO7EF+yGXUbs3ExfP7/f5rjZxELp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="451194376"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="451194376"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 01:09:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="811483064"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="811483064"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jul 2023 01:09:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 01:09:38 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 01:09:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 01:09:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 01:09:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDdbhD0C7xE/YSvfCex0ph551JOea7fShIbz203FFl11hmFF2h5SoqVZLMOtfYzlNmpk4fAsHEdrlqnlIy7TsIJbbEqp86dgXNVO4d+cwWTysxlBNf5aL5NYXFrZcCNUToQXAtp3ilBt6BMGPHHY+WwEGgZFI7+3McM4ptqrZlOFlGuPaElIZ5MoPW+XtLVLVDDMyJR9ORxb6ZcFBC0vLbqjbjprkC7QyAGYNSBV3C3yKX8da4oTSA8Pus+0kMBzPKV3IcOrJFsvZhW0uXiz454UM8EQIXwYKaw6177b3IdrDtuNhyDnDWcFyE1FMIbSOPLWe6Q+TfKM0PjWKrwY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNMaFTqDpdAi6xp3bIZsUoVQBQKZk1SEzTX7Z2nAYyk=;
 b=X7pEHUArTxS4ZLVdXZylbT2xYzArSzAlhF8CY5POif2/kmVbCGG1Ahyhj2iSMkaZuHGgDMeayDKQv7X8KToMeMEPK3XT74fn/oheVcnYXxAnqwgqTCFSCQpzTvU1JAv9UZN4vhr2ms/2iKgq3H4HiZpbftocOHT+fBqDfq5Idr8qaIAaqyNetYvpW5kyWshytxBQ9spbKMq049RYnnNRw8I/mgxeZ3URvAeGzfsh1290ZPVRaQxjAYDjOdy/RddBmHwC8aPA9IyCmdWOQqQ7ZAknyoLYbxAk/JzUBbrAyMD9oQqM+lne7x4LiLCf/AnMu7iTCxjAfievSsdy6Uu8Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by CY8PR11MB6866.namprd11.prod.outlook.com (2603:10b6:930:5e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 08:09:36 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8%7]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:09:36 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Jul 12, 2023
Thread-Topic: Xenomai Community Call Minutes - Jul 12, 2023
Thread-Index: Adm0mBvI/2eEZU2aTySwfMq552RBmg==
Date: Wed, 12 Jul 2023 08:09:36 +0000
Message-ID: <MN2PR11MB428571D2636A8A0A7B4CEA6DF236A@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|CY8PR11MB6866:EE_
x-ms-office365-filtering-correlation-id: 3b40e612-29d2-4bfd-e4b0-08db82af5526
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ldelv3lJNc96dRCvyKw7r1AlWO8vVU8YbqEibRme37mehwahtlaSj4VK2snzOWAdfCirMPhRHbAPAIId1bESDfG3ZWhhj8ijnFW7EttoVkOYEVky0/Qh37rWh6vRKidqrCshfJqmr0ox58p7MW7RAxvHX6sJXo63IA5EvK0Kdv7TIYWOUcDAkKQb9mSTzFobnyvjUB0uykRKNBeTBb/amPtWoqElVv6jj8AgIXwqXytHXjD+Ry3yn57Hb1Qq+4EDl4l1f2lFS4yCgeSTUXVI6WXfgOUeksk/fNEFNOz0O8Ym0VOvOlTNynHM/mB+0+xANK63wdEJMlZE2lqb7GFZvXw3hM6GRdq2rz//bh5JXIH5V6tMq1r3kzGsszXICw2ueXc1FylceSus5V+zaZEu7gKhh5X1X8cBQ0YK5K6DkUMSRe/gj5oUNRKsDjRe25s39w/bWZmy9RKOSdnVjVwrDBI/+9kzW2kyCK4J92BC/rwCHG5tgsIa0Qk5t7AKUg09WyWRh1JhX4ia2HA55Bg2PPKZM1p9qnhAHZyN+LCHbF9GWyzM8jxqc/fMAmBTch8TphMvntalKrQqJIRiNDk0y98iNBhdxF1S6Dc9pX2Xtq7FVKqhlE+Eh8BWdjUm4i/B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(41300700001)(316002)(9686003)(8676002)(8936002)(478600001)(7696005)(64756008)(66446008)(66476007)(66556008)(76116006)(6916009)(66946007)(83380400001)(6506007)(71200400001)(82960400001)(38100700002)(122000001)(33656002)(38070700005)(86362001)(55016003)(2906002)(26005)(52536014)(5660300002)(186003)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnN6OVVmRTVEc2svUGUyZFVwOHdWN284V3Y3MkxZdy9BY2E1UmhtVC93bnFz?=
 =?utf-8?B?cmFhZ09LWVlDM3hVSGtUcVNLWWlzSjV6a1lyRVRzV2hDejlPQXJ4TjFyOG0v?=
 =?utf-8?B?V21SK1QrQVVuck5VblBZYzl6amY1QnpqUC9kb21WUGVuaGRJUHZRUS9Zc21l?=
 =?utf-8?B?MUdRMjB2TkZ3Y0RGenA1Ym9rdjNFbVFZY0VJRzk4dU5kKzNqNGtxQ29pc1VM?=
 =?utf-8?B?c3NXR0IyMzZEbUQ3SEV6MzFaeTJ6bWFtaE5pNzYvdXdSaXBvRENWMjhXUEhh?=
 =?utf-8?B?Y2VIVXk5eE9mUVZvQUNkZkxHelhxTmNRL2lHQld6dU5pelVvM2kxSE1kRUtH?=
 =?utf-8?B?d2FUc1JiUFRUcExXWGR1eHV0Ry9QMDc3Mk9XNlRrMENGclZoTG9FNTRYUU5F?=
 =?utf-8?B?ZXFQY2hhR3ZSS2MrUlFCMy83RDhBS0h0Y2xQMXViNVQ3N2VIaE9rQWh3YldP?=
 =?utf-8?B?dVdpbkI3TjNVVFE3Mm9jRFJ6TFBKTDdYRkc1V3FYbmxpbGdhUk8vOUF5Mlp0?=
 =?utf-8?B?a2ZSMGx4RlN2NStIaThsVjZYT0NPeGZEK1cxWkovOVlPVStFd2xEUlZRSEg3?=
 =?utf-8?B?d1YxOWIxUmJmNm41bDNNRGkvSW9uRHBucjRaY1FJb3MvZzQ1VHlhZGRyR2J4?=
 =?utf-8?B?bU1mTVl0cm1RYThrZUFZMmdXbGtiU01yOWRnODZGdkRyVXVzV0sxelg4a3g2?=
 =?utf-8?B?K1EzaTJaK1VNdWl5RFRieEZGb2FWbGlKa09IQVpZTjdYb2NDUm8wY1pWZ1ZZ?=
 =?utf-8?B?VnVJM2pTdnVFMWg5T1FIaWJEWVJrNGZQOXVCL2FDUXJBSXRlK3JkYXJ5eWxa?=
 =?utf-8?B?aU8zNWQ1eVJhWjdFLzVqdkJ4K04yRGhzeFBVNHV0SkZJUG1QUjdWVG1IL0tT?=
 =?utf-8?B?eDc5b0lKaWtURVFRbHc4cjk1TVM1T2N4THd5emRpTUxGSmtqVUdkN3NHeGZG?=
 =?utf-8?B?Q0RwT2JhQWg1MTFRbjZJbzM2M1lELy9tUFN0TWhaeHRDK2VYQmRPS2QrNnUw?=
 =?utf-8?B?djlxbm1NYkZIcXNCVzZvNHJSd0cyclpSM29xM1pqRG93RXE3L1pFVUdubnB5?=
 =?utf-8?B?VkxYSk41Z3B6N0M0ZEY4NVhnRklHdnlsc2dlekYwZ3F4aUZyUlhtb0I1eTF6?=
 =?utf-8?B?SW9xbUY2Z2Y3MUtCdzQ4VDZkQXZXT2pUaSsyQWp2dXFLbDF5RkJGWFJBNDZS?=
 =?utf-8?B?SHY3OGRDN1BzMTV3Tm8zSTdsMEFTZzJHYUdreXB5UVdLU2lodDR0MXIvc3JC?=
 =?utf-8?B?a2Rpbml2UWs0NDh6eFFvTXBsMDJWQTUyZ3FrR0wxWkVZRGdTdStNL3Z1Q2dz?=
 =?utf-8?B?TEtBVDMyMFVjMW5jMWJwQ3lWMFBVeXd0Z0hIQk9UZmQ0ampQWUF5V2RLS1pO?=
 =?utf-8?B?U0hXUXBQa2w0SVE4dmo4clVyU0VZVlhsazdyV0VwakhEdjNoVk1TWHpIRGph?=
 =?utf-8?B?Q1gzNFZxSnJpWktEUFpjOHVnczc5ZnhOeDFHZlo2N1JvaDhpMXJQa2o2VWdM?=
 =?utf-8?B?T1RiVFVad01DczRTUHN2K3pzNkxJUVAxSU5JWUdaN2ZNdGJDSVJwbFVSS2p0?=
 =?utf-8?B?OGZJNlhCd3hobnRhMmx2TkFoV2ZLcmxOaVBoaHpXMVdzM0RNQXVDbm9CaFB5?=
 =?utf-8?B?TVg1emlhcEV5QjgxY0tQRjhzNko1VnUrZ2E1TUJvSHAyc1VoOU1QbkxwZ0Iy?=
 =?utf-8?B?SWJsNXRpQWtkREloeHp2dndHWFY2K3hOTi9WUDA2OFRQa0VQVkxyaGFnYVVJ?=
 =?utf-8?B?WWVrSmdxc2YwVW1uVXZkUW5sWFJDandCbmJuYUdvN2RibFptVnUxelJkeXNZ?=
 =?utf-8?B?UlRkc3crWURjZXhMbEJOaHowZFQxSU5ZT2hUZkQ1ZUE5TUcwdzJZSmovUHJH?=
 =?utf-8?B?aTZLaHJ2Z2V2bzY0U2hkaHVIYmJDWGlVZ3dhakRzOFMzelErdmlBUnZHditD?=
 =?utf-8?B?amRLU2tkRWE0WmlobFM5VlZXRkxLdnA4SllGWHFVaTZqQUlHMHBtQ2U1dFJC?=
 =?utf-8?B?d2xENTdrWUhIV0ZtQnNPZU55MW9iV3QzclYvbXBNTFVlRlZYVW5ySGJTL1VH?=
 =?utf-8?B?V25lTmxTeGF6SzdkTEpkakJKVWNPWHhUTUJXL25MMjk3VnRIbTZTUW9RbUNE?=
 =?utf-8?Q?TU/5zXCBqB1vq8g1PoG7e5vrz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b40e612-29d2-4bfd-e4b0-08db82af5526
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 08:09:36.2047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v7sKGz7ue33WRjOc/DHI+BoCAbk190hJeKeHtT/W8G0aDSUJM/obbwMJR4YuJarGUo2Xb+vZ/kg1Gc+nTbBUJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6866
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBSaWNoYXJkIFdlaW5iZXJnZXIsIEZsb3JpYW4gQmV6ZGVr
YQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUb2JpYXMgU2NoYWZmbmVyLCBIYW8gTGks
IEppYW5ibyBDYW8sIEhvbmd6aGFuIENoZW4NCg0KQ29tbXVuaXR5IHVwZGF0ZToNCglGaW5hbCBw
YXRjaCBzZXQgVjIgZm9yIHkyMDI4IC0gcmV2aWV3aW5nDQoJSXJxIHN0b3JtIGlzc3VlIC0gZGVi
dWdnaW5nDQoJNi4xLiogIGRvdmV0YWlsIC0gcmViYXNpbmcgDQoJQ29ycnVwdGlvbiBpc3N1ZSAt
IHN1cHBvcnRlZA0KDQpPcGVuIGRpc2N1c3Npb246DQoJTGFzdCBQcmFndWUgbWVldHVwIHNoYXJp
bmcNCglSb290IGNhdXNlZCBpc3N1ZSAiIE1hc3NpdmUgdmFyaWF0aW9ucyBvZiBleGVjdXRpb24g
dGltZSBvbiB4ODYiDQoJU3RpbGwgZG8gbm90IGhhdmUgZGF0ZSBvbiBXdXhpIE1lZXR1cCBhcm91
bmQgTm92DQoNClJlZ2FyZHMNCg0KSG9uZ3poYW4gQ2hlbg0K
