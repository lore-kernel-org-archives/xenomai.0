Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047F120FF
	for <xenomai@lists.linux.dev>; Wed, 11 Jan 2023 11:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673437617; x=1704973617;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=qJGQDwTIOWRfz2Tr1vYBsMYnUvM66Y+B2uCq/8MMr+8=;
  b=TLLW6jpPfQrDlyx29WsVqUBL+KRtY0my8SOjRCAUDE0fyKQ6crZCMH+q
   COG4FonpS/ih/WPC0G/OEftGb1umpfXWfFNheoM+p3nt0wOmC36rKVmmM
   BB+Bu2hQan/B13PxA3S/0g6SirCaWkpEXFgqzG6CeNhDv73SkxdvJ/FBg
   7ubguURGXsGFfbT7ovzpcYJ29qXWzOKHI/LPBypyhK81qM1hQASX//9Ze
   m2ATiHmUHTrUKtoKsOR0CPAUcAqgTi6EEifCNTT1BVFOq+TVXm9Ot1FX3
   XWXdX8FUHKfgM49S3k1YgIF8XPnmJiwnVzWfG+vCT/6FzmmH6taEMDbOs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="409635044"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="409635044"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 03:46:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="687907387"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="687907387"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 11 Jan 2023 03:46:32 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 03:46:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 03:46:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 03:46:31 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 03:46:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ox7IzLCAzBwuExH9qVPhrMln3zwVOH9NNQBAlPjO6J2VF/IOMyikzXyMfnTDHcZ39P3ApfyuoMvnq5/wB+gah6dCbElN0uUHOrTbMu0UtD0sQ0e2j6V14uhRfZyVI4GMTD873XiExibLwRhkP/upmYwcKdJHafdNG1VyG0WcOSxdXExaaKj6K5LrGO2aIMThhmejbaSTMY8QIWKZNHsPerPh+EcA3Pcxzrhhz+hdkakgr/wyLl6fTXWw82191TIvQgubQZgIs1TkOcwTizJzv9b+So9ZvlMxni5a/OmDy3kPEvQKDt6kkQidGN293eaCJtRzfp36xp1iDUF1+yo/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJGQDwTIOWRfz2Tr1vYBsMYnUvM66Y+B2uCq/8MMr+8=;
 b=Migm3Ez+k5z5qZ16JW8wdLmD1VZF5laQlhjOhXDR/NJRTC/6EivZ5oPqgCs8u1efsG9+O99YUIBWaTVroO0uyfWo/ptsarEd+hSIlWjeHgh4usYIiQgKu+qulmC71FWTrYEs2ep+twJ8U07l8oOt9IG1xkhPeaENYeUakluZLWjF0WvXqD4dwxN8hz8EagR9vvzAtOzhrVxaPooDmdVPQR7lqvPiNJQe/YnasUTfxCIqhQB/jOWhlkBefUzeHeCAhriNmvDqVnHrs2wisSw9X2T3PX5GpdHmuLoyoUoHNSPEnuF9z5XbM8HBRwvpsxie/4FnHUa3ABUK00HEgNLcmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by CY5PR11MB6284.namprd11.prod.outlook.com (2603:10b6:930:20::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 11:46:30 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2%7]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 11:46:30 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Jan 11, 2023
Thread-Topic: Xenomai Community Call Minutes - Jan 11, 2023
Thread-Index: AdklslZGMk9pD/j9ThaZVkcRtrgTxw==
Date: Wed, 11 Jan 2023 11:46:30 +0000
Message-ID: <MN2PR11MB4285900B48A09E859AD39964F2FC9@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|CY5PR11MB6284:EE_
x-ms-office365-filtering-correlation-id: fbb178d1-754a-4833-58cc-08daf3c97ae4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4dkziWrgbabRnK3IuCsNOG8Bj6SO/1eR71JLdUHEzJLkF6HEtkVgYFcMeTrgB25wFdF+o/Sc7SDnIOPZ+A5H2d+qSErdBptZm+pR/YjThbMr+sbIAFVHwRcZqXZMjWj2or2Gl8fTS+TQK129vUKk1BqcsM0wDVeoBQ8l0xWBWi15uigJ6awOgcviW8WwNXaxlRqHJPVhyoSihZJhrIqgujzHQ0kA+rBIvAeHY1lCK4Cu0f2p0LHxu2kKznCtRonwvhtVmA5jFAzQgXBgM80nwM/4AsjJI8Ada8EuAH2s2e3AVzTn5IsMJeJtvvwXD5DclU/ytppMkzCl9vYp3pi1HYNnfH7fIBENBoZUg7E++uCqTvwSYLF/edBL3XcLmtJ4N0AsEVtUkp1nSnSQtFDy9zprsSCeePVxUSmTQY3IUfXdK7ZA7s0MQWbZxOmjyPnJA5HFKi0C6L4FclBPNBtURBJw3PPU5noqDN/362Phy9ISIcxsR6gXtBKa+KKUu4EiPvqpRu2XaNBsn4y4GFHhV+JNwTKBNPC2CHMxM+Udt2syJQ8tj0KKzVMjPnukLraaw5ctdnaIEfcqBRFWvZ5kBiXSj5O3nxdkF8v2piCmmGjbPOLqj0pR6RF7ZbEniBQ8ZoTWe9IM8I5vGrrIpRbY+j+PWJ7/WIexeBdLElkTyaw37oOjiBEeZ3HjuT7UD/6VpT4qdWU9Fmfw9WDeuymx/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199015)(41300700001)(66556008)(316002)(66446008)(66946007)(76116006)(66476007)(64756008)(6916009)(8676002)(86362001)(38070700005)(52536014)(82960400001)(122000001)(5660300002)(38100700002)(33656002)(4744005)(83380400001)(55016003)(8936002)(6506007)(2906002)(71200400001)(7696005)(478600001)(26005)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1ozeC91RW1JeEtUS1QrTVRCTUVXVXNOM0czQU5GaldCamRFYmxCbzVtU0tZ?=
 =?utf-8?B?cVFKVTVlSk1HdkNkK1ZldklvbXF3WHhwWmFaVG1keUpwYVYvWUhzbGpHdk9I?=
 =?utf-8?B?ZHFkbkhJMFNFNGNvaVcvTmxxSURqSmUrU3RyMnBLNXZLR3V5VUliMy9lN0pV?=
 =?utf-8?B?M1hWS0U4SFRuNG5JalNHcG91K3BBbkV0SjMzNEZNK1lhMVB6YjhZeFFkejhn?=
 =?utf-8?B?OVVZN2lRVFA2NVY3NXQ3Ny9PeXZlZUtINEdxM3V2ZGhkdktXZGFNbW1ZQURG?=
 =?utf-8?B?cGRPTkU1blI1YU5qcW5GQmRoWmNjbGVTTXNlTHRYZzdUYzZiOE8vTmFOZFo3?=
 =?utf-8?B?U1JhQWlNWjlhcDZFMFlma1pTSEVLRnhHTnNtakU4MFpMenhuU3NoSU5FK3Va?=
 =?utf-8?B?WXVqTlBuZVQ5L2x3THBGS0k5dFRxOWRuWUVIZnh3dmJSUUp0aGs4eWppNnQz?=
 =?utf-8?B?Mm1DUjcvMEhSc2JwTS9lN1E4bkhCVFhxZlc1SEdSd3pIUHZwNUQ1Ukp4blRW?=
 =?utf-8?B?RmhpY3I0R3JvNkcraEE3SW9zR1hCay8yOVZiTXd5anU3MmVTUnVMdUJFWWdH?=
 =?utf-8?B?N0JOYVZxSmljYlZzOXZEQUZGZVRFRnRXK3JQczZkZVhFcWgveHJ1ZjI4Ulh0?=
 =?utf-8?B?MTNZeFUwQ0tTd2FlaEpuRHBVWVVhejRYWDl6QkNIbHdSdTEyUEFjeHovUXc2?=
 =?utf-8?B?Y3kzelFxSmZRcVNTU25COUZuaGVNVnRlUjhqNklXMUJaN3BlV1ZaVmJzREY4?=
 =?utf-8?B?L2JIMEd2YXg1MmRIZ1lvL3oreS9jUTgxUEoxazhwanlUZFhwNHdXOTFXTnYv?=
 =?utf-8?B?SlQwZ3I3MWw3UjVIb25KeW1EaHRxcml3M0dLN09OcjJDN1pSZWVGMGRIcTVW?=
 =?utf-8?B?RlhaNlJob1ZHelJ2Skh4V0RTWVBmMXlwRGpMMkhUSERoVENNTnRVYWI4WUxM?=
 =?utf-8?B?RmpWQU5zVGNFd2ZsNSsxdkdTUjltTURCUTIvb0sxOGtMczFBSmI5bzBIdnNM?=
 =?utf-8?B?Nnk4V2c5WWRvYW0wRXd2Z0t1aElmcmZBT0FuYkFNNFdTSXJiNFp1YnJRVUI1?=
 =?utf-8?B?Z091elVKRGdTeCtuZ29ya2NSWldaaTJJMHFacmd6K1Q0eHNGWC9oUCtzZjdH?=
 =?utf-8?B?bG55T3NyTzV6Qk55Z1NmVi9wMXZIUXUwMHg3TlIzeE1IVEVDYVljRk9LTk9D?=
 =?utf-8?B?ZjNSZ09qY3FsVy9GU2cwMGovdnB2cEhBVDU5YUZVK3lHTkFiK0MrRllhUi9C?=
 =?utf-8?B?emt0dTNoYkFMa2FncDZJaUl2MlRWY1dvTnRENEZzYTY2NVRPUlczTW1tR09y?=
 =?utf-8?B?K0huL1BtS1BXWGpaUEZrWnJXUEp4OGUzdzNlOWxlVjJPSU1SWkNZZ2Q5L3R6?=
 =?utf-8?B?OWxndGliSmpJeEJoa25IdVg3WndiTG5NbFlmYTlPbjZwNTd2YVBPWXZmWVAv?=
 =?utf-8?B?T25CdjFpbzg5VlQvWnFyeHNGdXhjaGE0VDk0SzU4NElSL1o4MTN6MXpYRG95?=
 =?utf-8?B?TWdQTTYrdmZRMEZsL2toaC9lc0hDYzUwTTJOYzU3TjFaOFdFVVBrRVpFYVdh?=
 =?utf-8?B?SkpSbjZVV1FnM2hZK2p5MFIvMGs5RUpTTmNaUEk2OHUxeWxWMDRNNWRaZzZH?=
 =?utf-8?B?MDg5aS9Zc29aVzBUMjdZeEZBRGI0eHl4NFRVVW00N0FmcWhseDJ1Mkx4T2pC?=
 =?utf-8?B?bW5Ta3YybXhVYzlaSDJEUXBlbUpVQ2xKQnZPOGRBcGVoeUl0Rm1rVlhFNXln?=
 =?utf-8?B?TDF4RmJxRWNHS3ZJY1ZsR2E4MGFUODJkSU1ISGtjSWZlMEJUN1h3cDQ5UXVz?=
 =?utf-8?B?SWlBSVBPdWhOT2VrOFZPcnFkZUd3b2xCS1hlbmkyZy9xMGhLemhzY1RQTjVp?=
 =?utf-8?B?bTdBdll3cWlxRW5XbUdmWGgwYXlhemhJRjF4QkJkMm5WdHlaSjl1cEFRb2NL?=
 =?utf-8?B?cDhCVHY1NU9ibGJuZWFKWXR1ODNsangxV25qeUxSVkJyWC91V1pjMlB3Z2xL?=
 =?utf-8?B?RkVua0hGNnkvLzFyRzhlMzgxcStuVjlNQ1ZSa1lsVCtldWsxUHJoa0NtbGJT?=
 =?utf-8?B?WU01SHh1MnB1Myt5ay9WKzJ1Z2FSaGcvamgreEh2MlJsdDBKY0s2R3dwRjZE?=
 =?utf-8?Q?rMxy0Lg9ICVKfISt1QKlQEUIG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb178d1-754a-4833-58cc-08daf3c97ae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 11:46:30.1951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OiHoHDbKvEyWh+EU3icAa69/4HPk6f2OwT5ZEyG+dArgbTLDVFYOiP2l+wCHB59j8mMM7Jq6v8u8R4y479wcRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6284
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBSaWNrIFdhbmcsIEZsb3JpYW4gQmV6ZGVrYSwgUmljaGFy
ZCBXZWluYmVyZ2VyLCAgSGFvIExpLCAgUWlhbmcgWmhhbmcsIEhvbmd6aGFuIENoZW4NCg0KKkNv
bW11bml0eSB1cGRhdGU6DQogICAgICAgICAgICAgIEZpeGVkIGlwaXBlIGlzc3VlcyB3aGlsZSB1
cGRhdGluZyB0aGUgQ0kgdG9vbGNoYWluIChEZWJpYW4gMTEgLT4gMTIpDQogICAgICAgICAgICAg
IEZpeGVkIGV4Y2VwdGlvbiBieXBhc3NpbmcgaXNzdWUNCiAgICAgICAgICAgICAgQnJpbmcgdXAg
UlNJQy1WIHN1cHBvcnQgb24gWGVub21haToNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBQ
bGVhc2UgY29udGFjdCBKYW4gdG8gZ2V0IFJJU0MtViBib2FyZCBpZiBhbnlvbmUgd2FudCB0byBq
b2luIGJyaW5naW5nLXVwIFJJU0MtVg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KT3Bl
biBkaXNjdXNzaW9uOg0KICAgICAgICAgICAgICBFbmFibGUgZHBkayBvbiBYZW5vbWFpIOKAkyBw
b3J0aW5nIGRwZGsgbDJmd2QgYXMgZmlyc3Qgc3RlcC4NCiAgICAgICAgICAgICAgDQoNClJlZ2Fy
ZHMNCg0KSG9uZ3poYW4gQ2hlbg0K
