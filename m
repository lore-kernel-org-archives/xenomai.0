Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D319C800
	for <xenomai@lists.linux.dev>; Tue, 25 Oct 2022 02:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666665592; x=1698201592;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zr788pQ9nVMUNId8W05Cg1kIVv/HWLFrmonsKrrrVzg=;
  b=TMSVXtI/u4XKss3Rq1kN473UiEEm2LlHVozIoxlbX2exyxtj0MRH+VVG
   1uxnTF7iFSWatWdcv25h+6iAsQz7hIMpbKSDhebFipUxuGnIM1ph/jitb
   eD9cT5r0Q1sUSaGr+s5np0fT6ZSnJCRcl/K53n+tRS06FRbxyEqMCsnDJ
   w0+qK1oCVKc14R6YdUEc1RlYfZmVjl+RnYienspO6qI2xzIBI0yLuDFOo
   bC/Sew1fDuyoALE1GOHIFtmbqkckuArEvX8G+uKqQ+JOaMqbMQm/nd5cl
   2Z7KVI5E4BTSNcQYsoVajFumOKW69cgh1r43aSxp01aBy/iZK3GS0lIlL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="307564567"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="307564567"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 19:39:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="633929204"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="633929204"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 24 Oct 2022 19:39:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 19:39:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 19:39:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 19:39:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd8VXfjpityiWNU2sl3tjpnlZQPG4nJwvDnBt8GyIwNTQ9Lqttu5BmnuQISsDKeyLr5QcSGpMz1pplWzh3hBwFryZTZ2w58umIGuz5I5g2zxLfDLGOWvSAWiCl18vi1DTGf2F7+odoqdTyYfBP95D/Eb4bxOHH+9T+XUlELAwml0P59Pxez0IFGWAu5fCyN0s9VtAjydTQ6HFpWf09nsMRgx4lj7kM+SC72XWi2rO5xcgSCsMD35/uH+UvMG2KGRbhsUx3jOCS6O1HAD0NuPvtsoDjcdWR+9whVf0fUWt8+SRtjvBKmh2Q9w3e4xxyY57qy85xFEpmB89AiXpwbYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zr788pQ9nVMUNId8W05Cg1kIVv/HWLFrmonsKrrrVzg=;
 b=BQdwHNTZuhzFMCi7pmJb8ZcjX7jbWXuPM66NidqOuLzHSqSi6q6Gci5cVW550Ffov7Hd4ueWlW8GY4M75Pql3VUoruejLXxzX6AF2chBr+be+J4OgIJaEU6JF/Zv3i3WEeatUnm2os/VL+fo2fz8K5SdPbgg9WL4oYHU4V+k3Z2hVFH2LUlf+NlZWAlSrajGXlflqiuoKX9j/+XLBdGGEPmW5tiuZMyAsvgea24aZBRiclz1POGVEvkLSlRTXsmJlXudxuyIZXckEEA/FTGUWXCOmCasymCFA/UX/pnAUS6OCeyGBraJQFXvNSd+R+Ls03r82T5lH71DaMhFArmwcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM4PR11MB7349.namprd11.prod.outlook.com (2603:10b6:8:106::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 25 Oct
 2022 02:39:49 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0%8]) with mapi id 15.20.5723.033; Tue, 25 Oct 2022
 02:39:49 +0000
From: "Zhang, Qiang1" <qiang1.zhang@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Heber, Stefan"
	<Stefan.Heber@zwickroell.com>
CC: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "Wang, Rick Y"
	<rick.y.wang@intel.com>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Memory corruptions upon strcpy and similar when being interrupted
 by scheduler
Thread-Topic: Memory corruptions upon strcpy and similar when being
 interrupted by scheduler
Thread-Index: AdjUuPBUbK+UhP87T6Sf3hDOZQOijgTLBYqAAA1CmiA=
Date: Tue, 25 Oct 2022 02:39:48 +0000
Message-ID: <PH0PR11MB5880908DA18819B93D4DAEB9DA319@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <FR2P281MB265487EA098F01EFC0F77CB8FC569@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <ca3f971c-87e1-b7b4-262c-bf80483ef9fd@siemens.com>
In-Reply-To: <ca3f971c-87e1-b7b4-262c-bf80483ef9fd@siemens.com>
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
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DM4PR11MB7349:EE_
x-ms-office365-filtering-correlation-id: 23603b89-7859-47ff-c6dd-08dab6322f96
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SgvE3PtkunhjwFuOSYK3tnV25ni0SkEf+etdFS6U6zI8xxTaPpO5trOh0iO9O4KEOqa6qymjtzH9/xmm/lWRuKbNMIw/jGvAnZXRAjA5WQYINwytO5jwHEDgX4s90lWPCbS1GeqbOlqbxPmD2Ou9zsA7X/gty1DWnfxwkjLZcgpZtrkKkzs+QhUPT+ESjl+XnwhAbYQCIOXah+u1AsKgfX9V4pBjX28yYdBqOHAeTWaH3ieFQEd/4FbZpFcgH7wFZ6S5hHo+3ADY1tvPKIvh7xTHon7FFNInHZ9yny88stMxclR/9QRyygvtIKXg62ELOs8yJ9OFT149JENwaJt4z7NIVCggrkzipngxoBJoG+URHXZC1SYuJMn2E1QhE9QiJkQW6ipRXehfSNM+sTM0mgmsEAZsotRYmjs1fbrugAEVNh0kr/tMHFFbNt8ZYAF6Pjsw24QIQRHqz2q6JirBEwZjHogrxijEmUTbwXN9sfJwq1EbenQfCDpaVu/JPRbptNlfe5yRF+Ken0vGx5zszyxHkHcaRBPT4DUE5e0ibQ5tv0YiMX6cjH4xasb+zjQRCkxlrS9VH3AHFQz69806knCyZkutUrMIns0rZwT5GacMI/XTouJ1AVxpoltguGIfUYEJLKSfXOkGbijwF5hC/dmlJaAITO5vk9kKQ0h1JLkqUBhNS+U/DNwgWo5NZVAvmpbzpQpu8A3c5A9ceRb+DXWueaSYnw3J9Fwe7GIDbw5zJXM346nqQSYv5FBpChAUNAhvQ4DtlvpRHELWNv4vmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199015)(186003)(71200400001)(38100700002)(82960400001)(478600001)(2906002)(33656002)(110136005)(41300700001)(9686003)(54906003)(316002)(5660300002)(8936002)(76116006)(4326008)(64756008)(66446008)(26005)(53546011)(66476007)(52536014)(7696005)(83380400001)(6506007)(55016003)(38070700005)(8676002)(66556008)(86362001)(66946007)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlVVWml5dk1lZVFxbmlVSGczMnBXWUdhdUNvL0dMUzdXRVNlVnlyS0RtTi9J?=
 =?utf-8?B?MjJSZjk4VlpWMWVCZHRtdmlSNGlSUUVleUtwUUprMUpJdGwyMmFrVTVQc1pv?=
 =?utf-8?B?ZW5VdVorSzVIem1NV2pmSjVvV1dJMEhTSHpPSEk0UEFMZWwxdjcwY0Y4ODU4?=
 =?utf-8?B?UnF2Y3hvRmlxSzZhQ1JuMGVPUFAwY3VJMm0yTmRvSWZLQ3hSTXU2dzAxTWNR?=
 =?utf-8?B?YVhSRTBwaVdjaytObC9wWW45QUdybTlqaEtoZkRBWTVxejF4ZXczdXNaa2xq?=
 =?utf-8?B?T2JCSkk4ejY4U2JQZVRDYytLa3pwcDZ1ckJ6OVNteStDZUlHcnZ1TGxscjRk?=
 =?utf-8?B?WHV3eVpaYXNYemI5bElnaDR6QkZxaGg4V3FXcTc0aklYcDE1Qlo4WS9RSDBs?=
 =?utf-8?B?WitEUklGWi9TY056ajhHejlESDNveHdJT21XUVlHNzJPRWF2ZmU3WlhyVndT?=
 =?utf-8?B?RThyd0dkK255eVA2YXQ1bGUyVk1ycWFLTmZpYmF6ZDIwN1hQTDRiTEZYb0lB?=
 =?utf-8?B?azZJaUFlb2g2aWpWM09rN3NubnZvTzNNUVQzbWxZK1Rxc2dDQnprRTRiaFNF?=
 =?utf-8?B?SDRERmtVUlBFUndZbzgzaCtPcVkxV1R1WUJJSEdSci9GeFhWTmxqWTVhaksw?=
 =?utf-8?B?Zk1ITjd0emZLYkR1b3hKdVFlZFhHV2gvS2pHclpxSjNURjlPeGs1TzRzYTFU?=
 =?utf-8?B?QWY3MmxBVUhUQXVHSm5Yem8rZWp2amd5aHdpRDZDUWVJMGJlbjhjYjk3bjRQ?=
 =?utf-8?B?RDh3Nzh4TkRqWG00SGIxaG50RDJNZENDN0FiSEpWWnlxQ0NqdjZrTWxOVUkr?=
 =?utf-8?B?MEdmQzBHZG04YWlGVzJDaGJHaEhVQUxXMGJDZlNRSkxIUzNkVlJRWjJpQ0cr?=
 =?utf-8?B?dWY0VEEzN3FMd1R0eE9qTDhMWlNSL09saTFZdTZvSFlOblVOQ3drZjdsRXgw?=
 =?utf-8?B?NVl6L1hrZkdCc3poUHZGWVNwVzdYTHE2UUIyU2JpYnN2OUh0VTRuQ0NiNnRP?=
 =?utf-8?B?a1dPQVJLZWRjOXBMRGlPTkQ2RjBaek5jbXNXZ2p2YmRrM29tQnRqbW1YR1VR?=
 =?utf-8?B?YU02eEwzc1prTzlNYkUrZEFFeHhyajlwM3pjbHpoRG9tNFJwZ2RNN0tTbUF2?=
 =?utf-8?B?NCtUT1ZLMHlVY056S0EwbUQvbGczYTJGTk9uZnVJbVVuOTdxcWNKdEdCVS8r?=
 =?utf-8?B?bkp1b216bVVtMmlYNmZTR2xtTWpDTUhCMnVZY1lZWHc5T1pKOVpYTDdZZmtx?=
 =?utf-8?B?blpaUEErS3NZdVV3Q0hwUjFINmNQdlZNSVpBOFZKNjE0RkJSUld4R0lWSE9R?=
 =?utf-8?B?QmJJd0VrZ1R0U2wwNlJkS25MYVJvZ1owaHlHdXFlR2JTMWhYNnRTdU9CeG9i?=
 =?utf-8?B?REUrMjJwVkdNMWtsanBFME1mbytLMmNsSzhMb2t4WVJ1ZkNiMmpYRTQwZ01P?=
 =?utf-8?B?cUlPa1VmWWF6ZWkzWndpUHhPblROV1J5Qkh2bFNXWjQybVFuK3JET1pzZFEv?=
 =?utf-8?B?RHQwRTlkSUxKemFVS2FaenpESnRyeldCQXhGL0U2YkF0VmdOZDd5eGtBaGlD?=
 =?utf-8?B?SjNMa3VrTU5VYlcwNmtkMUlvTkpKWmVmQWpiTVM0NWF6ZFVHby9CYlBWOUNI?=
 =?utf-8?B?STdEL2cyMCs0aTF5U0FmWnRsZVNrV292UnVmMHpjK2lLTzRhVlRPcUVEc2w4?=
 =?utf-8?B?STk4TTlQWG9TSkdGZURIZWNwSktFY3NuUjFyY01KK0tmSm9sdWVmd1Jzd3I1?=
 =?utf-8?B?ZzdHSElnL3ZLQ0I5TUREc1U2S3RXS0ttc05HenROWktzczNiVkd4ZlZCajNR?=
 =?utf-8?B?clVINEJpRmJFMEZ1Njd6UTh2b09yRERxQjN0WVJKT0ZocVE4c2FpWFdKeW5Q?=
 =?utf-8?B?QlFqdWxYVitoU1ZCUHUvYVBWbkVTM05TMkhsMUI1bWM4QitLaWFHcjUvZXBG?=
 =?utf-8?B?S3VrK1hRTW1mWHZYdFg0QUZxSDlGU1pvWkl0NHY3ajBmNld5Q2VraWhwSndO?=
 =?utf-8?B?RnkyMUNPOG9kazlTV1NNVEVLWjBPM012c3RMUWJGVUtsU2lBVkY3MWRZNmZJ?=
 =?utf-8?B?OU4xOVBEQjE0dzB5M1VYTUFZakZPTXNjcDZIeUNhbGtpNXhYWi90NVViVU4y?=
 =?utf-8?Q?zKUfoBKkG/9JDu8PYxFWhH+yz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 23603b89-7859-47ff-c6dd-08dab6322f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 02:39:48.9064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 81C2Lg5AXb1iSVfnwWb0GEWSrPdx1KNWK8d0CauKzdOLc/nTREl27bGtXOd1yDQdXBOFY/bUgnpd1y8ML8lxpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7349
X-OriginatorOrg: intel.com

T24gMzAuMDkuMjIgMTM6NDcsIEhlYmVyLCBTdGVmYW4gd3JvdGU6DQo+IERlYXIgbGlzdCwNCj4g
DQo+IHdlLCBhcyBsb25nIHRpbWUgWGVub21haSB1c2VycyBub3cgaGF2ZSBhIHNldmVyZSBwcm9i
bGVtLiBXZSBhcmUgY3VycmVudGx5DQo+IGluIHRoZSBwcm9jZXNzIG9mIG1pZ3JhdGluZyBvdXIg
aHVnZSBhcHBsaWNhdGlvbiBmcm9tIHhlbm9tYWkgMi42LjQgMzJiaXQgDQo+IHRvIDMuMi4yIDY0
Yml0IChsaW51eCA1LjQuMTA1KS4gSW4gZ2VuZXJhbCB3ZSBhcmUgYWxtb3N0IGRvbmUsIGJ1dCBv
bmUgDQo+IHByb2JsZW0gcmVtYWluczogT2J2aW91c2x5IHdlIGhhdmUgbWVtb3J5IGNvcnJ1cHRp
b25zIHJlc3VsdGluZyBmcm9tIA0KPiBzdHJjcHkgZnVuY3Rpb25zICh0cmFuc2ZlcnJpbmcgbGFy
Z2UgY29uZmlndXJhdGlvbnMpIGJlaW5nIGludGVycnVwdGVkIGJ5IA0KPiBoaWdoIHByaW8gdGFz
a3MuDQo+IA0KPiBXZSBub3cgbmFpbGVkIHRoaXMgcHJvYmxlbSBkb3duIGluIHR3byBtaW5pbWFs
IHRlc3QgYXBwbGljYXRpb25zIGluIG9yZGVyIA0KPiB0byBydWxlIG91dCBhbnkgcHJvZ3JhbW1p
bmcgZXJyb3JzIGluIG91ciBvd24gc291cmNlcy4gVGhlc2UgdHdvIA0KPiBhcHBsaWNhdGlvbnMg
YXJlOg0KPiBhKSBhIHNpbXBsZSB0ZXN0IHRoYXQgc3dhcHMgdHdvIHZlcnkgbGFyZ2Ugc3RyaW5n
cyBmb3J0aCBhbmQgYmFjayB2aWEgDQo+IHN0cmNweSAoYW5kIGFsdGVybmF0aXZlbHkgb3RoZXIg
Y29weSBpbXBsZW1lbnRhdGlvbnMpIGFuZCB0aGVuIGNoZWNrIHRoZSANCj4gc3RyaW5nIGNvbnRl
bnRzLiBUaGlzIHNpbXBseSBoYXBwZW5zIG9uIHRoZSBtYWluIHRocmVhZC4NCj4gYikgYSAic2xl
ZXBwcm9jIiBhcHAgdGhhdCBzaW1wbHkgY29udGFpbnMgYSB3aGlsZS9uYW5vc2xlZXAgbG9vcCB0
aGF0IA0KPiB3YWtlcyB1cCBldmVyeSA1MDBtcyBqdXN0IGluIG9yZGVyIHRvIGludGVycnVwdCBh
cHAgYSkuDQo+IA0KPiBXaGVuIHJ1bm5pbmcgdGhlIHRlc3QgYXBwIHdoaWxlIHNsZWVwcHJvYyBp
cyBydW5uaW5nIHdlIHNlZSBzcG9yYWRpY2FsbHkgDQo+IGVycm9ycyAodHlwaWNhbGx5IGxlc3Mg
dGhhbiAyMCBydW5zIG9mIHRlc3QgdW50aWwgd2Ugc2VlIHRoYXQgZXJyb3IpLiANCj4gV2l0aG91
dCB0aGUgc2xlZXBwcm9jIGFwcCwgdGVzdCBydW5zIHdpdGhvdXQgZXJyb3JzLiBBbmQgZG9uJ3Qg
d29ycnkgDQo+IGFib3V0IHRoaXMgbWFnaWMgdHhyMTkzOTEgcHJlZml4LCBpdCBpcyBqdXN0IGFu
IGlzc3VlIG51bWJlciA7LSkNCj4gDQo+IFNvLCBjb3VsZCB5b3UgcGxlYXNlIGhlbHAgdXMgYW5k
IGhhdmUgYSBsb29rIGludG8gdGhpcyBwcm9ibGVtPw0KPiANCj4gU29tZSByZW1hcmtzOg0KPiAt
IFRoZSB0ZXN0IHNlZW1zIHRvIGJlIGhpZ2hseSBzZW5zaXRpdmUgY29uY2VybmluZyB0aW1pbmcu
IFNvIHdlIGhhZCB0byANCj4gZmluZS10dW5lIGEgbG90IHRvIHNlZSB0aGUgZXJyb3IgaW4gdGhp
cyBtaW5pbWFsIHRlc3QuIEFsc28gaXQgc2VlbXMgdGhhdCANCj4gZXZlbiB0aGUgQ1BVIG1heSBp
bmZsdWVuY2UgcGVyZm9ybWFuY2UgZW5vdWdoIHRvIG1ha2UgdGhlIGVycm9yIA0KPiBkaXNhcHBl
YXIuIEFub3RoZXIgd2VpcmQgdGhpbmcgaXMsIHRoYXQgaWYgd2UgbGV0IHRoZSBzbGVlcHByb2Mg
c2xlZXAgDQo+IDEwMG1zIHJhdGhlciB0aGFuIDUwMG1zIHRoZSBlcnJvciBkaXNhcHBlYXJzLg0K
PiAtIEluIHRoZSB0ZXN0IHdlIGNhbiBlaXRoZXIgd29yayB3aXRoIGluZGl2aWR1YWwgbWFsbG9j
cyBmb3IgdGhlIG5lZWRlZCANCj4gMyBzdHJpbmcgYnVmZmVycyBvciB3aXRoIG9uZSBsYXJnZSBt
YWxsb2MgYW5kIHNwZWNpZmljICJwb29sIGFsbG9jYXRpb25zIiANCj4gZnJvbSB0aGF0IGxhcmdl
IHBvb2wgYnVmZmVyLiBXZSBjYW4gc2VlIHRoZSBlcnJvciBvbmx5LCBpZiB3ZSB1c2UgdGhlIA0K
PiBwb29sIGFwcHJvYWNoIChzZWUgdGhlIHR3byBvcHRpb25zIGluIHRoZSBjb2RlIHN3aXRjaGFi
bGUgYnkgY29tbWVudGluZy8NCj4gZGlzY29tbWVudGluZykuDQo+IC0gV2UgdGVzdGVkIDUgZGlm
ZmVyZW50IGNvcHkgbWV0aG9kczogc3RyY3B5LCBtZW1jcHksIHR3byB0eXBlcyBvZiB3aGlsZSAN
Cj4gbG9vcHMsIG9uZSBmb3ItbG9vcC4gV2UgY2FuIG9ubHkgc2VlIHRoZSBlcnJvciB3aXRoIHN0
cmNweSwgbWVtY3B5IGFuZCANCj4gZm9yLWxvb3AuIChhbHNvIGhlcmU6IHNlZSB0aGUgb3B0aW9u
cyBpbiB0aGUgY29kZSkuIE1heWJlIHRoYXQgZGVwZW5kcyBvbiANCj4gdGltaW5nLCBtYXliZSBp
dCBkZXBlbmRzIG9uIHRoZSBpbXBsZW1lbnRhdGlvbiAuLi4gd2UgZG9uJ3Qga25vdy4NCj4gDQo+
IENQVXMgd2UgdGVzdGVkIG9uIChhbGwgd2l0aCBtb3JlIG9yIGxlc3MgdGhlIHNhbWUga2VybmVs
IGNvbmZpZyk6IA0KPiAtIEludGVsKFIpIENvcmUoVE0pIGk1LTg0MDBIIENQVSBAIDIuNTBHSHos
IDQgY29yZXMNCj4gLSBJbnRlbChSKSBDb3JlKFRNKSBpNy03ODIwRVEgQ1BVIEAgMy4wMEdIeiwg
NCBjb3Jlcw0KPiAtIEludGVsKFIpIENvcmUoVE0pIGk3LTQ3MDBFUSBDUFUgQCAyLjQwR0h6LCA0
IGNvcmVzDQo+IC0gSW50ZWwoUikgQXRvbShUTSkgQ1BVIEQ1MjUgQCAxLjgwR0h6LCAyIGNvcmVz
IC4uLiBoZXJlIHdlIGNvdWxkbid0IHR1bmUgDQo+ICAgaXQgc3VjaCB0aGF0IHRoZSBlcnJvciBh
cHBlYXJzDQo+IA0KPiBTbywgdGhhbmtzIGluIGFkdmFuY2UgYW5kLCBidHcsIHRoYW5rcyBhIGxv
dCBmb3IgeW91ciBleGNlbGxlbnQgd29yayANCj4gZHVyaW5nIHRoZSBsYXN0ID4xNSB5ZWFycyEN
Cj4gDQo+IEJlc3QgcmVnYXJkcw0KPiBTdGVmYW4NCj4NCj5PaywgY29uZmlybWVkIHVuZGVyIHhl
bm9tYWktaW1hZ2VzLCBxZW11LWFtZDY0LCAzLjItaGVhZCwgNS40LWhlYWQuIEJ1dA0KPml0IGRv
ZXMgbm90IHNlZW0gdG8gdHJpZ2dlciB3aXRoIDQuMTktaGVhZCAoYWxsIHRoZSByZXN0IHdhcyB0
aGUgc2FtZSkuDQo+U28gd2UgbWF5ICJvbmx5IiBoYXZlIHRvIGxvb2sgaW50byB3aGF0IG1ha2Vz
IDUuNCBzcGVjaWFsLiBEaWRuJ3QgZGVidWcNCj5hbnl0aGluZyB5ZXQsIHRob3VnaC4NCg0KDQpN
eSB0ZXN0IGVudmlyb25tZW50ICh4ZW5vbWFpLXYzLjIuMSAgbGludXgta2VybmVsdjUuNC4xMDUg
IHFlbXUpLCBjYW4gcmVwcm9kdWNlLg0KYnV0IGFmdGVyIEkgbWFkZSB0aGUgbW9kaWZpY2F0aW9u
IGFzIGJlbG93LCB0aGUgcHJvYmxlbSBkaXNhcHBlYXJlZCwgDQpJdCBzZWVtcyB0aGF0IHRoZSBs
YXJnZSBtZW1vcnkgY29weSB1c2VzIHRoZSBGUFUuDQoNCi0tLSBhL2tlcm5lbC9jb2JhbHQvYXJj
aC94ODYvaXBpcGUvdGhyZWFkLmMNCisrKyBiL2tlcm5lbC9jb2JhbHQvYXJjaC94ODYvaXBpcGUv
dGhyZWFkLmMNCkBAIC0xNTMsNyArMTUzLDcgQEAgdm9pZCB4bmFyY2hfc3dpdGNoX3RvKHN0cnVj
dCB4bnRocmVhZCAqb3V0LCBzdHJ1Y3QgeG50aHJlYWQgKmluKQ0KICAgICAgICAgICAgICAgICAq
Lw0KICAgICAgICAgICAgICAgIGNsdHMoKTsNCiAjZW5kaWYgLyogISBJUElQRV9YODZfRlBVX0VB
R0VSICovDQotI2lmIExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTig1LDIsMCkN
CisjaWYgMA0KICAgICAgICBpZiAoIXhudGhyZWFkX3Rlc3Rfc3RhdGUob3V0LCBYTlJPT1QgfCBY
TlVTRVIpICYmDQogICAgICAgICAgICAhdGVzdF90aHJlYWRfZmxhZyhUSUZfTkVFRF9GUFVfTE9B
RCkpIHsNCiAgICAgICAgICAgICAgICAvKg0KQEAgLTIwOSw3ICsyMDksNyBAQCB2b2lkIHhuYXJj
aF9zd2l0Y2hfdG8oc3RydWN0IHhudGhyZWFkICpvdXQsIHN0cnVjdCB4bnRocmVhZCAqaW4pDQog
I2lmbmRlZiBJUElQRV9YODZfRlBVX0VBR0VSDQogICAgICAgIHN0dHMoKTsNCiAjZW5kaWYgLyog
ISBJUElQRV9YODZfRlBVX0VBR0VSICovDQotI2lmIExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJO
RUxfVkVSU0lPTig1LDIsMCkNCisjaWYgMA0KICAgICAgICAvKg0KICAgICAgICAgKiBSZWZyZXNo
ICdpbicsIHdlIHN3aXRjaCB0aGUgc3RhY2tzLiBIb3dldmVyLCB0aGVyZSBtaWdodCBiZSBubw0K
ICAgICAgICAgKiBjdXJyZW50IHRocmVhZCBhdCB0aGlzIHBvaW50Lg0KQEAgLTQ0NSw3ICs0NDUs
NyBAQCB2b2lkIHhuYXJjaF9zd2l0Y2hfZnB1KHN0cnVjdCB4bnRocmVhZCAqZnJvbSwgc3RydWN0
IHhudGhyZWFkICp0bykNCiAgICAgICAgICAgICAgICByZXR1cm47DQoNCiAgICAgICAgY29weV9r
ZXJuZWxfdG9fZnByZWdzKCZ0b190Y2ItPmtmcHUtPnN0YXRlKTsNCi0jaWYgTElOVVhfVkVSU0lP
Tl9DT0RFID49IEtFUk5FTF9WRVJTSU9OKDUsMiwwKQ0KKyNpZiAwDQogICAgICAgIC8qIHJlZG8g
dGhlIGludmFsaWRhdGlvbiBkb25lIGJ5IGtlcm5lbF9mcHVfYmVnaW4gKi8NCiAgICAgICAgX19j
cHVfaW52YWxpZGF0ZV9mcHJlZ3Nfc3RhdGUoKTsNCiAjZW5kaWYNCg0KVGhhbmtzDQpacWlhbmcN
Cg0KDQo+DQo+SmFuDQo+DQo+LS0gDQo+U2llbWVucyBBRywgVGVjaG5vbG9neQ0KPkNvbXBldGVu
Y2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQoNCg==
