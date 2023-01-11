Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9265B433
	for <xenomai@lists.linux.dev>; Wed, 11 Jan 2023 02:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673403583; x=1704939583;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=MQcEeIj9B3EP/T1JQTebCauhvLwBJJ+Zvshp/oN7y4c=;
  b=WT4QFcZtzWjKFq9B+j7lkd653uVyb0Dp85Rfxx0JkBIoP5G2kiwLrpZI
   VvuKXiDJZNE7N3sdygaZJiZ/vPnN9lDKf6E9tzBkxraQQz3JbKgbJWa0J
   ja3LIDr3CqT9CdubWrmQOWw/88b0kok2yFFAUCGVSz6TbZ7HyYzVzdKB1
   XTRQzFa7VNS2YijKMY6udQWx4A9RmiQx4U8klJeY1WEUn4VuJGKyFNwa3
   Li0pAk/F9hhY2SsyJLDgpUdbM+ffxFNKrwIpKf48QOcqdIcmWb8/qagQS
   YDMFypJLaGbPc/zlO0ZPZHiS6iW6gfLM3FmBkYxDL53hSYTCBItN7hIAn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350538965"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="350538965"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 18:19:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="764979546"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="764979546"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jan 2023 18:19:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 18:19:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 18:19:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 18:19:42 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 18:19:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNL6JrHs9VEYKZNlBaHJfAnT4eEghwlyK/i7jY9XX1//tCPnnx2DUvh2xFdUem60S6p5cHCTX3+ngJ96kYJVvyVSuLv2zXc5nGcGwmD0gbOUW4FWllqrLobi9Rvjw0+qEEQsDaEXkSDdjd66GoW9i4E8GVWp1fmTtxYIAJWRrVdnFdz5AjlTjGlWu3eq/VkPdLzwZdzoPYKS6HP8PFZoOmQh8Lj2yGP/YtJcMOz22ljlL3bjzeCXxDSH9KbUR+KC6zpWHvfjikYFFNZrYmApM0jwBHDSlwSgpUM1ec8v8tLVu0yu9cMvPezFkaTFtKQXZRIT6f1LMTmuU/Z7y0hqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQcEeIj9B3EP/T1JQTebCauhvLwBJJ+Zvshp/oN7y4c=;
 b=nQ8J6yzimJqm2hLivKg/E+zutgSQul+xdof6uhK1HFKTtPDA/LVrIJa73H9YCwGxx3XmhJU40bzJ3SQK4GHtXClehYEK3oFHTvG9UIfyMv84t/jGaz67rLEM2pZPquEmHFkxKIsu/gpYdgS18u8KdOyNfnSxX9MLsg5UV9DpinkLkshGrPOxp+XHUY8jFae81nvOk4QIMjgVb7yC3HRiJuo5823XQMJo/n2m/+BuQPhQ9zjMLQwt597LO0jeLTRgVo/v+CO5vmqF9qc6r5+3UydtgDPInANSQq/keLGmmlkP7WAD16qo0uNRzdeuqp6KGHFdZV8gpu6hPG+Bb2mLng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by MN0PR11MB6256.namprd11.prod.outlook.com (2603:10b6:208:3c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 02:19:40 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2%7]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 02:19:40 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Jan 11, 2023, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Jan 11, 2023,
 UTC 7:00 AM
Thread-Index: AdklYxMbjT1M5VooQSKeF0g639iTqA==
Date: Wed, 11 Jan 2023 02:19:40 +0000
Message-ID: <MN2PR11MB4285D62AFE43D1ED0586DBF2F2FC9@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|MN0PR11MB6256:EE_
x-ms-office365-filtering-correlation-id: 04ccc449-f122-424e-6388-08daf37a4b8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WCqxcae65P2Je1N5TFEqWQoT9XcX527idaSKd3TNxpOj0ZpCBwdYei3VoJCmzbB8aZZZiyZiHSeDo5ReCR5XsRYCL2w03gAkzgcV2qGx+iPlQVW1MWpeKVvLFwg/9MaejcCT0/5a24hrsod6+5VkPXjBuR6672dNvhdrXjifPsjUlmY2fmQA1yRrqrjc8Hq6xyi7vLf6DEXwGG5mfJ8yjVRMaR/Z+oS/6gN9QQqPQnZyWakkmpVpNas3KtmdcdxYiVoXIhku2oY7L5YKSGH0wb/rbqReZVp8rb4xRZyB+usavSHmsqtLcrs7o9hsAL8LxCMaxAGVECkpC1hpkOlyNsfn0C29ycaEB6YrUZRDRr/XYeB5hSOzFqtf0lrCkgg+dNR3GUj3GQ73mvQaaqELUlTKF0MjvOOrbviXXnxogQVS4z9uzDjoWczLRr/h32Ei2wNeCnXs1sCC2Uqra7tkL6TRqwPOqtjRXokqB4+UWBrllj31tDYObpeu0wQgMqjY38W0UWwMgrlv1H6FX/m1Z4CTH9H5UDTEzu4BfplT6agx1/s96nLS7ar28n4zUpxUPgYk25nOSFzcUBHZG54bV3k6vGfleFOw6FVSJgKnBYvcKZlmsPy2YAZBUmfsVSbBJrJ3UHD6jU5RJlBO5tjDq4am36qEdIrzEwnbvj+E40MX+5F6hkYs/kPPEkwuVE7HrhFXT+Fpco4SIMcNkCCj6EQgNFxqrHZccZsMWrgrxa4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(6506007)(26005)(478600001)(9686003)(33656002)(55016003)(6916009)(186003)(966005)(66476007)(76116006)(8676002)(64756008)(71200400001)(41300700001)(66446008)(66946007)(40140700001)(316002)(7696005)(83380400001)(82960400001)(86362001)(38070700005)(38100700002)(122000001)(52536014)(66556008)(2906002)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejNJSzl0cVpYSDh6MXhzOFR0K0I1THQ1R0VQR3d4R1N1VWxtZmVqTVFWU0tS?=
 =?utf-8?B?eWpCdzVCMDBqcEtJVHBmNlRvSXgzZG1yczFIR2FOcWRvMisxRVdQZEl2RDFu?=
 =?utf-8?B?UWlzelV6UGFhRGYzcThodzR4aWx6bmJ6UG1pUG9ldmhUUjFEaHUwM1BYcEtS?=
 =?utf-8?B?Rklzb3R6NGNMaU1qMmFMd3ZTcFFjcnlvVnJFK3YwaEZtUnlKeUFUNmUrKzMz?=
 =?utf-8?B?WlhIc292M3FWWU9yUlFiYXA3ZkUrdTZHMkYzbGlBR2JmN2Jva3FMalNVU05R?=
 =?utf-8?B?YnBSZ05xVGNwQlgrV0RtN2pyTndxRVdpRlhQbXdLSGEwRjhibWliZ1QrclhR?=
 =?utf-8?B?a2xqeUxCTXpUZ1RUdURoaWFRZW1VTk9aVDd4d2VIN0dhbjBOSTY3dlBxTzJ5?=
 =?utf-8?B?SkhoYk51T3lpOTVlNlpjU012TlNPRC9YWWpVVzIrTWZqdVNzMU9XVk80RWl5?=
 =?utf-8?B?aUppNEdsS29Yb0FVbXdqUG5EWURMa1FGZ2ZVK1V6eW92R0Z4OG4xOEpHM0xV?=
 =?utf-8?B?ZlVaY3dUa3VFMTBMdDNWY3BZWUFBQjNzMHlEcGY2Tjc2MnVlazhjVHdoZWVO?=
 =?utf-8?B?NGk4bDVBZ3hVNitBbW14R1ZQb3BmN01MNDNoYXBpUHpFQ0NlTW5rZ0UzVHJE?=
 =?utf-8?B?NHlFc2ZrRkZ4Njd1dmFjWENJK2xEdUt2QVJKZm4xekMrUWMwenJmNjNmdjYy?=
 =?utf-8?B?QWp6b051anZLV1E3UkhvQkdzdFB0RFFpY3p0bko1R0sxZEtmZEE3dG9oTExU?=
 =?utf-8?B?a2pOVkdJVEs3R3oybXZsV2dUdlJudDVHUHpEdXJselFudGRESEYvMXZIUmR4?=
 =?utf-8?B?c2M4d3ExMEx6SVZjR2dvcUVjRjYvUlNKSS81YXNIbExXYVdIVTg3bVpCdTM2?=
 =?utf-8?B?eWR6RTFPdi92MDNBc1lzaEdRdHZESzJwT1lKYS9YeG5uT2I3YVM0N1FzcVg3?=
 =?utf-8?B?WkJYZlBRRTRWOWFQejd4RkZTb2tHQ0lBSlJSck5naHNGZWNoV3IxY3U1eGlF?=
 =?utf-8?B?VFVGenBrSW5SN0NDcWVmVlVpaWZEcXd2dEVQaXhGTE1uT2tsVDJ2QUpmLzkz?=
 =?utf-8?B?SkNXRmJYVjIwR3piUHFEeWhHcXJqZG1VNC9PMWZzWWkzSFBmblVUMGtzbzhT?=
 =?utf-8?B?eWdDOGE1R3lYcGRyY1NUaUsvN1MwWE9MK1o4MWdvVkwxSHlKTk4vazBKbzc1?=
 =?utf-8?B?MDhxOUxqbk16cTJUcmZPNkdMZ20vNDErZGZUVHkzSmtUenhLSWpRTjRpVzlM?=
 =?utf-8?B?ZGNqZjFNcDVDSW9SYVNCL0psamJaTlRRMjRPSWphem01Nk5uYWd5K2RzM0U2?=
 =?utf-8?B?SWd3eDQ2OVNYSHBtWnJlQlA0N1hBN0ZWK201ZFVsZFlWNTMyMGJNZkZicTVW?=
 =?utf-8?B?WWx3QnVmdFBIMlZ3eWFINWE5WnY2WnRGQWZvMkRZRitwVDV0ay9zQkREWEtv?=
 =?utf-8?B?UG5KQzVjbzRrbmUxVmoxK05STHpNbzR6Rk1WMjlzWW1teDRxZkMyelVYSnhp?=
 =?utf-8?B?Uk1mSGRRQnhYTlFzSmV4aWp4bVlidHJmTTFLZFh0a3RmRWZTalZvcVo1R3ZZ?=
 =?utf-8?B?MzZHL1ppNXlwV0l0Y0RObTVqWklpL3ZnTGZWRGZlbEZFaFphWXpyUzZpMFMr?=
 =?utf-8?B?SHMyMUE0b3RQQmtsZjBFaGVJK1VPWjQ1SzRPeFNSRzNPZXRHNnZDaS9VeUx6?=
 =?utf-8?B?Uk5RTEFFclNJYkt2NHFHM3Z2ZC9xb3YwTjZlVms2V0NUWkRsMUl0QkF2V1FK?=
 =?utf-8?B?aG1sck5jeitGL1lqVHI1dVlsVC95UmkxUnJXVVFNZjVhWFh6dXVaMTRUSUcr?=
 =?utf-8?B?T3ppZ0YrR29MYXJwRG5qN3NneFQ1cnYreWtQOGNpemc0M1lrOVFFcllUYklp?=
 =?utf-8?B?UEhTUWwzVmxQZWtucFJLaWhSUUlVTnBJV2lwdVdGbEU5dy9HSys0VnlXNFYx?=
 =?utf-8?B?RGxxUGlpRE54emFiZzl1ZlRSbThMN3dXYm5LSSs4Znp3TTlBcmsySW1BY2JS?=
 =?utf-8?B?WFZrR2JjUk9ibEJkcU5DVEIwNzFINzlPQlBEdGJoRm1VeVFCaFRMYmtsdW9J?=
 =?utf-8?B?TnVRN1BzZlIvTDBid2t6OXQrMER5Q2dldmdsbkNIalhzTmRVTk1vcjAwZGR6?=
 =?utf-8?Q?Y6mtVtFHK/ulk+D77XRg+UJ0E?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ccc449-f122-424e-6388-08daf37a4b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 02:19:40.5438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kbXq3L1X4jkE/K5KPVEFEowA6bJQ+XtumyM1z4DFnvJY8UqUO2Y7XCGw8mndA4Tlla73tHwSWeIG1GMIIUjITA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6256
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgSmFuIDExLCAyMDIzLCBVVEMgNzowMCBBTQ0K
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
MzY3NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
