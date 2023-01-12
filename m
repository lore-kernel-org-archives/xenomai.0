Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDC78F6F
	for <xenomai@lists.linux.dev>; Thu, 12 Jan 2023 23:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673567505; x=1705103505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z71Veq15mg72G7f0GhhNvuPcwzz2/xbbiDbTJW3WT5A=;
  b=E5H2l7Cpp8DMm5I5mYNFqaUCsknel7r7zLEbmZkzqtb555vEoi1LNpmB
   6VJIhSyyZZ81dkj7eO7PzxQh/LMvWdbluU+/NgQ/Cm57UUhGEkgcZvh8S
   jRMOlwpyebu72s1IwTK1jIyYyz3cot9iAkbEEBHz15Oze3Pa/zM3znvL9
   9uAlxOXaC9fwwlaKBBT0KensvHVVEKVARZrmv6ml+V5PxJVmEAI+Xh+9l
   GGBJcFnxHPW5nCv2ldUvB9kdmjK6hX+iYrXGufBggpFgN40FYVHSqO3hd
   DHoZhBu3C+vTYtO7tkjmo9LU+0EgxgbiyNiIamQ1VALuhZe0DsrqrYz8A
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="325919719"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="325919719"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 15:51:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="903394118"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="903394118"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jan 2023 15:51:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 15:51:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 15:51:41 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 15:51:41 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 12 Jan 2023 15:51:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzTuCgE3w4oXClTvs4FQOkixtOFGb7nlo7/ml9CGd74lMCL2ZHXV6qPC9RCXiOimq/FHTxAOTnrEiy70ulS0IQh6BTvysePidJdtUZiekKlBWYwfx/+wp/Pznf9vMos3wSDQf0taM6FvrJQVzBCAlI9LQcTToQfFG62Lx5wCrsh9aMbA6gC9Aoe782E7/dkU+mZu0e4hCX8C/+JuehChvwEy442pZRsOpWH8a02Sqg79mLwP/1pAzSS3lcey2UrLPE8cJJolOBdQSplqTNrjUYMJ+vpFXE1DAFLo/GjRW2+Dv5JVy/IVu3X+M1p2fI0fHEK1t6DbxfcT5BTfrx7EgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z71Veq15mg72G7f0GhhNvuPcwzz2/xbbiDbTJW3WT5A=;
 b=UOnReaTru7rS4c2gHybh8fPc71TxSloVDV2TndIEqodkIEOnDU7XNtr7+FBS6XCc6keYIlw0OUpH4cc8WwqwnNzz97YXhfHofG0A74FWwLzBTewP3/Incls39QBPwgxOh5G9zdA1Wh8Eta/Jo+YKl3eVo/R0EfWCuZj9g3u2zMjeSL0s+HL3wQ5lMbJoqg8EsQOpY6HBPRvnP7GqSr++2PlXcLZvjlFcwmeAnAffxGm+jkHKQZSR8j1b1PMbsUVRCSrFJULfgZJdCd6siUwCthzd+fN9VU7D+QGeY6IHFhcFNha1kGD1FVKA+tXUOJipClO6CMRuBIQaih3tKeE8Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by SA2PR11MB4906.namprd11.prod.outlook.com (2603:10b6:806:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 23:51:38 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2%7]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 23:51:38 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Richard Weinberger <richard.weinberger@gmail.com>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Xenomai Community Call Minutes - Jan 11, 2023
Thread-Topic: Xenomai Community Call Minutes - Jan 11, 2023
Thread-Index: AdklslZGMk9pD/j9ThaZVkcRtrgTxwAyPr6AABkofZA=
Date: Thu, 12 Jan 2023 23:51:38 +0000
Message-ID: <MN2PR11MB4285BD4FDE1816EC6C416CB2F2FD9@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <MN2PR11MB4285900B48A09E859AD39964F2FC9@MN2PR11MB4285.namprd11.prod.outlook.com>
 <CAFLxGvz3eC7HZpAFnjRzFARV9+PxLm3iBiS8agGdvqitP=0YBg@mail.gmail.com>
In-Reply-To: <CAFLxGvz3eC7HZpAFnjRzFARV9+PxLm3iBiS8agGdvqitP=0YBg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|SA2PR11MB4906:EE_
x-ms-office365-filtering-correlation-id: 46ba6813-5d99-414a-10ba-08daf4f7f21b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: elr+KvtbsZl2JUqfaaizyqATSP0frKKQPdNLmhOqFsQIasoMVNEIgCWIRHCUvaMPZ5bhvX2hLyTfAqjMTkyjo0J0mOv6jsWLKk1jnRl/ap0hJWVyLEONzpP8aN3hIhzFXx7IvN84xq1ntCvMNjpkFnSEJ7OHT+6diyaAq2LG1KdlqnyCP03etcOdmIQGKFyBAL7cLoDjSoN/7D95rCOHdCfNkZFK7NL9HC9LehuVV24mcBj09IaSQ5kIp5XAaryG3eyVIIuUbLF39+jDalNcTI3Nw1t9eWg5/cdnz/bHwBwqDTFIlvGIhMDuFgM0IQQbR/pcK05E91ryETJQcy193TWGy/I90yblBaZhHbHQc+/x5972YkpzdSlFSzSXJ4+D6WQeulOwTKKPYqJFYFhFP4Jbzjbx8k8HS4BHANS8HitEiKavY/Ai3Jb60hJwAdd4j7VpXs436YrXmL8Ocujs8HH7Ve+RB6Z68CushNuZxw+0l1JIBtt5u0PfRB+0AcTkHk0STB9IEFne4JbxaJTugYv+Gw/G5BVuGMEx6lxkgW4ynx4KNBcHByjxlsWCPtjSlNu8fMz6L/kgnclMvIV5tr0TncqifJmCw/cgh4B7y7Nr0Y1RSbYk4Fzt3obp/ygF9SNfisDrxjgDaeQhmT98DYYVV3HPKVjPXB4zG3+x3oFwcCr2iDJ9e6Q6ahkyx1o5NKVubGhCxL97RNXrrX7v5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199015)(33656002)(6506007)(26005)(55016003)(9686003)(186003)(4326008)(66476007)(66556008)(316002)(6916009)(66446008)(64756008)(7696005)(478600001)(76116006)(71200400001)(122000001)(38070700005)(86362001)(82960400001)(38100700002)(83380400001)(41300700001)(66946007)(8676002)(52536014)(5660300002)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0FRRHN1NUJCY3EyaUg5UXJFTHRETjNuMU1UanZnaFpoMG9wRmlsWnN6b3pw?=
 =?utf-8?B?dE40MzZjaFRJbzd4ODNtMThHZThGSm5iTG4yWm9GTjNJSU5HZFJYQmUzUk13?=
 =?utf-8?B?cy94UEJnU0FGc09MRXc1VnpReHJua1hUQ1ZKV3pNZVFVaytwQW8wek01TUtJ?=
 =?utf-8?B?b1FrN1c3SjZLWmhXbVc4VFNleWQ0QTg3NnkrbHlmVitrazdvS2Ryd21HSm0r?=
 =?utf-8?B?eW5lVWhJS3lvNXVCYnBndWRpUDE0cDdKdW4yZkdwWU1pTWV2SmlkdWRGYmhT?=
 =?utf-8?B?SFJUbFVScVVyMW5jMWZoMWR4WmU1My9ETDlpYTJhQTIraGR1TmtTcFVKZStW?=
 =?utf-8?B?TDZZSG1XL21aODJrZTBkdVdxSzZ4ODFCdFM0ZERtbEtFd095Nm1LTSs3MnNy?=
 =?utf-8?B?U1RoSmFTTWhzYTliNkZ1Y2Y2UlFHbitCSEpZR1d3L1ZOc3gzcm1ZaGhBRDQ3?=
 =?utf-8?B?YnNORFhGdzhwazd4TWliY1BIRXZiQnp5ZmNkQ2E3d0lDU2VxNHlZemJzbGgw?=
 =?utf-8?B?SnY3eEZyK0J0RGdSbWxlMEdWZXdtRVBOa2ZBdmh6V1JBYldVaEhkUWdUYmNi?=
 =?utf-8?B?UCtBUU5JZkFnNUR0V0twa29GTzQ3V1hTUE5zdksvL3JlaXMrdUdObjFNakxC?=
 =?utf-8?B?VEVsVkgzQWZHL09FZGgzeXA2K21yeGlFTllZUHFhZS9WUzlVV09yejVPaDlx?=
 =?utf-8?B?VjVFNFkzbnNrMzgwendQL2lPNHcvYXN2anN6MEp2dGo5UWgwazU5cE5DV0J1?=
 =?utf-8?B?T0lMU01iblErODJjeTlSaU82RDN1OVFpdjVwVlRQSVN1dUlVQVFXTVVXaUZQ?=
 =?utf-8?B?a0s4ZDBZa0JvWG5qcWFsY29CWHh2cnFCRWlLc0hTQ1BHbkRqL29VQXJEQVBL?=
 =?utf-8?B?R3NlTE5yemtXYmc0MmdkTVV3ZnF5TE1GQnhnNEtXNGpMeHh5UzRrenpFaHRm?=
 =?utf-8?B?QlBrMm9tdkNLYTlmdWZLZWMwQnJtZ1huUmJIYTRzb3pWa3p5WWsrV1UyeDRs?=
 =?utf-8?B?MTJmKzZxaDdxOFprWCt2azhvZXlKYmhOdWp4WHdaUkYxZXhaSndhZWt1YTRY?=
 =?utf-8?B?dnRpRVp3dzlma2kxdkZXZW92Z1p2NlZLNWNOVHJDeVV6b0FuVjcwbld2YlJR?=
 =?utf-8?B?d1lmam9MYmRsUlU1RkxzOTZrRStXQUNOY0ZZdHU1V3hwYk5aL0RVWnlscGdC?=
 =?utf-8?B?akVjem9HQVE5NnJKTXpIdTgwZHpBSjZKQk1xQWFwblJMS0ZPSlp3V0kvTjhq?=
 =?utf-8?B?ZUdVVENWRG45UXhUekh1ank2dkZTY25yYy9oZDZiSUpKRm5XemIxYjluY09P?=
 =?utf-8?B?dUJJaGdKZHc5UnFzaFZDOGJWVmpOTURsTWpseXNMWVg2WGNQaFdFcm40dWND?=
 =?utf-8?B?b1NjVTg1VklndXBZU2toOXJlMHpGZzErbVlxc09QeWZMcUV0WExEMUYwVC92?=
 =?utf-8?B?QnpFcll2cllyMTF6a2JYRjF5eXB2VG5mZUdpUHFBVUNKNHpSZEtrQlZxaGQr?=
 =?utf-8?B?VklDMVNYNG50dUpYSS9hcC9iUXVmOGRxbjFxdjRBQmRGd1FHWEZQSGxEdFFl?=
 =?utf-8?B?M1FuYlFDcFhRWCtSTWxHNkxlVFhQeUdtZ0NOVXAzZU40c21ITE5UMEF2Mk9x?=
 =?utf-8?B?RFpoRDBjUlNGT2lZT0tuUmhGUlZNa3YvUEdqcEl3N0FWYmZ5WktIcnkzNUxV?=
 =?utf-8?B?T1VYaDJMT294UTNuc24rWUEwZTBCZ0hsQjZYK2RYWnVRTEM1YTZqTjlwSlNs?=
 =?utf-8?B?eTBWMEZVaHA0MzJnZGVocDVBQ1ZnNTMzaFdkV0tydVgyY3Fvak93VGpSblRh?=
 =?utf-8?B?NmtsaTZTeldWNi84dnpMWmFobzF1ay9EUllIbG1FN2g4cmhERjJXN2t1a240?=
 =?utf-8?B?cEJyTnU0QzlLZXlpU1NTRjBSUm9XaWFldDdzTTNueVk2bEJOT3FUTTFWTHpz?=
 =?utf-8?B?czNuOTVGTXlsSTJlM0FxMzFxUmNBRGpJbzFNdEVRa3JpcGUxWnZoNmhCYkxo?=
 =?utf-8?B?cEtHcGJTdEpaZ0E5MDVKakYzYlIvWGcrV094OUV0WTlDZGFGRkErNW9xeVVW?=
 =?utf-8?B?YUdyaVhXSjcvWXhKd2RjY280MldWMndFem1TUWxtOXZadGlLZDNRd0hFenMw?=
 =?utf-8?Q?CLVHrkwDr23CJWBY0JsosIovI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ba6813-5d99-414a-10ba-08daf4f7f21b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 23:51:38.1837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4to+dJFbiLcszQzMgconpfFdAHvCpBraYx7sNPARHp5QFo8MZz+WVB88frOTfQyvHTcaI6AYITYyUPWFaX99ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4906
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFJpY2hhcmQgV2VpbmJlcmdl
ciA8cmljaGFyZC53ZWluYmVyZ2VyQGdtYWlsLmNvbT4NCj5TZW50OiBUaHVyc2RheSwgSmFudWFy
eSAxMiwgMjAyMyA3OjQ1IFBNDQo+VG86IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGlu
dGVsLmNvbT4NCj5DYzogeGVub21haUBsaXN0cy5saW51eC5kZXYNCj5TdWJqZWN0OiBSZTogWGVu
b21haSBDb21tdW5pdHkgQ2FsbCBNaW51dGVzIC0gSmFuIDExLCAyMDIzDQo+DQo+T24gV2VkLCBK
YW4gMTEsIDIwMjMgYXQgMTI6NDcgUE0gQ2hlbiwgSG9uZ3poYW4NCj48aG9uZ3poYW4uY2hlbkBp
bnRlbC5jb20+IHdyb3RlOg0KPj4NCj4+IEF0dGVuZGVlczogSmFuIEtpc3prYSwgUmljayBXYW5n
LCBGbG9yaWFuIEJlemRla2EsIFJpY2hhcmQgV2VpbmJlcmdlciwNCj5IYW8gTGksICBRaWFuZyBa
aGFuZywgSG9uZ3poYW4gQ2hlbg0KPj4NCj4+ICpDb21tdW5pdHkgdXBkYXRlOg0KPj4gICAgICAg
ICAgICAgICBGaXhlZCBpcGlwZSBpc3N1ZXMgd2hpbGUgdXBkYXRpbmcgdGhlIENJIHRvb2xjaGFp
biAoRGViaWFuIDExIC0+IDEyKQ0KPj4gICAgICAgICAgICAgICBGaXhlZCBleGNlcHRpb24gYnlw
YXNzaW5nIGlzc3VlDQo+PiAgICAgICAgICAgICAgIEJyaW5nIHVwIFJTSUMtViBzdXBwb3J0IG9u
IFhlbm9tYWk6DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUGxlYXNlIGNvbnRhY3Qg
SmFuIHRvIGdldCBSSVNDLVYgYm9hcmQgaWYgYW55b25lIHdhbnQgdG8gam9pbg0KPmJyaW5naW5n
LXVwIFJJU0MtVg0KPj4NCj4+IE9wZW4gZGlzY3Vzc2lvbjoNCj4+ICAgICAgICAgICAgICAgRW5h
YmxlIGRwZGsgb24gWGVub21haSDigJMgcG9ydGluZyBkcGRrIGwyZndkIGFzIGZpcnN0IHN0ZXAu
DQo+DQo+VGhhbmtzIGEgbG90IGZvciB0aGUgbWVldGluZyBub3RlcyENCj5NYXliZSBpdCBpcyB3
b3J0aCBub3RpbmcgdGhhdCB0aGVyZSB3aWxsIGJlIG5vIGNhbGwgaW4gdHdvIHdlZWtzIGR1ZQ0K
PnRvIENoaW5lc2UgTmV3IFllYXIuDQoNClNvcnJ5LCBJIG1pc3NlZCBpdC4gVGhhbmtzIGZvciB5
b3VyIHNvZnQgcmVtaW5kaW5nLiBCdXQgZGlkIHlvdSByZWNlaXZlIHRoaXMgbWVldGluZyBjYW5j
ZWwgbm90aWZpY2F0aW9uPw0KWW91IHNob3VsZCBiZSBpbiB0aGUgbm90aWZpY2F0aW9uIGxpc3Qu
DQoNClJlZ2FyZHMNCg0KSG9uZ3poYW4gQ2hlbg0KDQo+DQo+LS0NCj5UaGFua3MsDQo+Ly9yaWNo
YXJkDQoNCg==
