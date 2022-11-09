Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130137.outbound.protection.outlook.com [40.107.13.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1AB257B
	for <xenomai@lists.linux.dev>; Wed,  9 Nov 2022 07:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBJe2Zz+06fWmPC9mJ1+hcoiuQ2/RWQ0+C2UPATK84jjD5ZdD9AACtjT7SuJR9aAR13I7taLaeHTN8jr0TWuwDSGNGtzDvj7un9Su+ENNDuSnirAQP2bqktUt4pZL88g+q6b1vFDN9CXSbJiG2/htFlrYbYqJC4ItYEfOdHcxIAHBOrXG+Ewd7jrQHZpQZAhSnBmgS3WFvcCATx4bEwPpnKq2YK+uw6R824BjPJNh9uS2YgjXrMTwXy+wQ3QctJET7b8g+C4zkhmq5hXFXacz9x2DdjM6JK5iY7hw8LQ4Sb1XgEcDS4W7mBXd8cvHy2K6WKkKjz66tJRdLlcT6+c/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMv9A+B42Jdhm4DOj/nQxcFVxFcpHkLjchxU4tvSsgM=;
 b=XYi6e/WAp5WvlWMlbcdfp61+cQs8LeHGPhuRDYqt7wr5+DFRKjmx8iDKtZSrwo6qz5r5+Y4rwdJK3jpTCTc/p4iiIY1rMlY35T5EiPXdkZX23/IpaXgX2SvQl0itmQYIMlNZsmw5aaeUcTQgKDfYQ/HrGLHV2C5ZI4expYNjbgy5Hw8BpEIpK7+REEwkrImzoa2BIq9WVzglEjbfHMhxYjhht5LGg6fchofbFRs/UojiTjGgNoa8HSLwAeOyVV47vplOCPy4M+2oOcVRp7mpCv40c+0EpU4AMuPCr06pldD+C6XJP1yYnSYi3GqG7LxYmWo0/gEwBvlk8Yb3Zs9ybg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMv9A+B42Jdhm4DOj/nQxcFVxFcpHkLjchxU4tvSsgM=;
 b=Vj+Cd7Grc8bYoLbyGaPulDOwsQt7rtCJYIZm02YVtSvjzyLkaIEDPbHtXtJCHXe6YQXzssiBjO6+oRBi3E5267Evh0GIB/RmcrL1RQ80UPJVQYjEhYte3j37BWtQswSIS495PrV2twKWMMQbh4sFsOlT0R6axATNXEwR84UvFh8=
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by AS8PR08MB9597.eurprd08.prod.outlook.com (2603:10a6:20b:61b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.11; Wed, 9 Nov
 2022 07:31:35 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::8ae5:ee34:abf2:12f6]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::8ae5:ee34:abf2:12f6%4]) with mapi id 15.20.5813.012; Wed, 9 Nov 2022
 07:31:35 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>,
	Philippe Gerum <rpm@xenomai.org>, Richard Weinberger <richard@nod.at>
Subject: RE: [RFC][PATCH] x86: dovetail: Permit to declare a trap handled
Thread-Topic: [RFC][PATCH] x86: dovetail: Permit to declare a trap handled
Thread-Index: AQHYkpnmoysKxd93Y0qoFLI8cNHP4K10DwyAgMHVdAA=
Date: Wed, 9 Nov 2022 07:31:35 +0000
Message-ID:
 <VE1PR08MB4909620AE0E4EE0139B54276923E9@VE1PR08MB4909.eurprd08.prod.outlook.com>
References: <006148b8-dfa1-1abb-b243-029db08ceb0a@siemens.com>
 <8929fce3-cbe6-79cf-d0a9-5e8399e3dec4@siemens.com>
In-Reply-To: <8929fce3-cbe6-79cf-d0a9-5e8399e3dec4@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR08MB4909:EE_|AS8PR08MB9597:EE_
x-ms-office365-filtering-correlation-id: 2a3c5385-33e5-467f-7b4e-08dac2246e63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NWO0CR/YDRwivvg6o/2EEmT2NzJxKwRBlrCWmSptEJTqCjjQumoM06rJIsdgSPhtTI0aI45q+KPzFLn9KqDGD6L2QHlLNeiVhqpRsD2/Doj4aOHp2wdeDuQBsfy+w9CXjlpUFkug36JwAZPNyBG+xkHj9tmsBqHqzqc1F9PAr14BTwdBYcGqvA3sOWqaz6g0DbUtvLAs1HrKTzxVN04KnJC+f63jR5JGaZxt+fSANi4/ssQCh6+QZRcjqlwrpVOZuaZKf/VaGMEizT20rNX1HI/DLKmhIWnlgQ8Z650yKs3yA6GCyp/AX5UJtRl3ZOq8xsgWhSlqF/iv2ujOzetNHTCEAG/zn6VaS+AUxJNxD6OTQnvZc1AyqiOgrE6RVNFBkVKYMV2PQlxPeTWCrJQ8RYKpRAiZtrBm2ZogsRukNbxcOoMRbNcsTOhJ2Wg3r8V61Mb5P8nNb/BwPe1o4VK91eEu3P0vzds1nSQ/SQV8BZ9Ii+x6Z6p/ehChrT0fBEKCwA5M4KaNGZniV+qEN9pUnZJZ6LbiBYJ490fAb5jsdbyRaH/3xqdPyg6Fw7Fb7Bm0dgJUpXpBpSLGLI+KUg1fb/l79+Y5lbq+adq+bLGWulPhWCS+xReTRi+wAjmWc/jGszM3J+l0RQFR6lM8DfUfZDgi3zjqfmANh6XmIXEbzdFipxae5iJkHTZ7X6q/v+ycfYIu5vGBiwTu9SNbQDq3wlrSrJkdVbZizmCA1aQ1tO/ztjEbxCTh5nWtKTUPzu0RBk/1yEvZemOCMlZ+JleXUQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(396003)(39840400004)(346002)(451199015)(76116006)(55016003)(66556008)(53546011)(38100700002)(316002)(44832011)(110136005)(33656002)(66946007)(66476007)(8676002)(52536014)(7696005)(41300700001)(122000001)(8936002)(66446008)(6506007)(71200400001)(5660300002)(83380400001)(478600001)(26005)(64756008)(186003)(9686003)(86362001)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Uk9VTU45S1Y4Y2diWVhHZ0JpWStpdGlqMVhmR1hMYTAxdzhlSk0waXVPOE1B?=
 =?utf-8?B?eElVMXJUUjZpbi9RUmdkbHdmWThBSm9OeWxKY3dwaExja2R0amt0VVluWlNS?=
 =?utf-8?B?aHl1MkNzemhhMWlrSmVTNUtmbVdNdmxCOG1qTTBFYytpWFB3L3BNdkk3NUdj?=
 =?utf-8?B?aVRyUzZ1bjFVbHBweGNKRkFVaXRlR05keVVNemNzMHlEZjZHb3B4V2Z4dHB2?=
 =?utf-8?B?ODZNTCt4cW91ZXBrMHFZYW9Vb2xtaWVRSVNRdmtpcExxZ1dlWlpCclZZSkEv?=
 =?utf-8?B?cDNubW1MR09oYWEvMDB1ZkVtY3lmNXBOV284bGg3ZDB0KysvL2poR2MxeDUr?=
 =?utf-8?B?TUJFL1hYM2ozOGVxSXBseHVFOFRENDUwb3Y1QVlHQlc0MjZSclZvRGY0aVhj?=
 =?utf-8?B?VFppYW83YWZJbXBncmNQNEU1ZmlxL0FrV3NNa2w2MmtCdmdxcjVQeUtwQzBh?=
 =?utf-8?B?L2UyTUFJc0JQQlZYNDlvZ0FlaEh6c0t6Nm1WLy91SHFCL3cwZlljWW8zZGl6?=
 =?utf-8?B?Z24vVFNaQ2hGS3ByaWhrNlNLaGtmU3F6MHFGRVpzZVo5VC9mbTArTVpYK3Ev?=
 =?utf-8?B?UkpzNEFrZW5DWTFGUUw3TjRVN1dsU1V2SVF1UkwwdWNUQnFPdnZWVlpGUk9J?=
 =?utf-8?B?UXE3WUJuTWorbDYvai84STREY2hOa1lGQ0tFbkpUZFF0djlGbTZMQ1I4MjRM?=
 =?utf-8?B?bW9LNjl5ZXF4S0M1UTFlN1B6b2lFNnlQd0pHa3d5Z0xHaktreVpGSGl0ck5C?=
 =?utf-8?B?ejNGNmsxZXV0d0kvejdoVjJNOU1HczNBakpRMFlXdGYvbWowWkxnWFcyZTB2?=
 =?utf-8?B?RFF2OVNnZ2Y4QmtmOXFvYVdWbG1pZkJTa1RqOEd0N1RUd0c1NWtFMGgzWXJw?=
 =?utf-8?B?bDZUS3ZCeHEvL0hWcnhTS0pQTVlEUTdFNHI0cjUvZlVYRHFEUGppd3Y3WFRk?=
 =?utf-8?B?b0RndFBhdXNlbnZnSzR0U0ZTcVg0cFJESUtUZWo0aXVQMUlTdjJCZzZyRHYw?=
 =?utf-8?B?Q1Jiamk2SDFqeG5ZdHVmMVBwNXNFeHhnQ3BSMmxSd255c2JzVlZWTHA5dld4?=
 =?utf-8?B?S1hmOTBXZ3ArWFpVejJubDlNcnArY3RFU1ZMRHhpdmwzNENrbFFBMlZGMVpX?=
 =?utf-8?B?WVBucXdjWkZRYzVVZzVZVm1VeTRxWExqM1paR2VVWUhJb2J5VyttRjRpUE9B?=
 =?utf-8?B?NTlNSVJMUm9DNVdITk9SV3JPVkdkNDVnWlFIK3NPaUd1U2VMc0RzdC9ndmwz?=
 =?utf-8?B?R25keDZWbGg0WWJqSEVHelpMNU1EalJjQmFGNUhidDNqNWtUbTZuSnVnZlV3?=
 =?utf-8?B?Rjlpdnk5SWptdlRMWWFyVkJnSDZWRmpZSm1EL1NFY3JHVFFmQnNHN1JEdjBE?=
 =?utf-8?B?ckJyNjRVdFZSWnd3OWdxTG5XTEZ1cHZueXgxYWRZTFJOZnQwTTdQTC9jV2la?=
 =?utf-8?B?YjZoU2ZLamFsdUJSUW9xUnRCZmk0R2NwUXNKOTBOV2M4QzFvc0t5ZDkxelJn?=
 =?utf-8?B?bGRtbCtCWG0zK1BSbTJWNytJemxEdjkzNmppWi9wZWJiZlh3MG1hS29SNnFR?=
 =?utf-8?B?MENNS1g0RnBMU3Q5WnorLzBGYzExSjh5SzRpdGNJUkw5NkNYeXZnWitDbGhK?=
 =?utf-8?B?RHZzUHJJVUdBU3E2V1Y3akUvSW5vY2todlVOMGNabWdaV0Y2QjJxN3pjSnNt?=
 =?utf-8?B?djVvOTdNT3ZqVnZiZmN1S0hIWDhWajdEVmYyL2dKNHpMQW1jQ0VyNnVpVlZ5?=
 =?utf-8?B?N2l4Vmx4Y0xSMDdIcXRjMVNucUp1ZUNUcmZQRlowSWlSdzNNVExBTmxPYTg3?=
 =?utf-8?B?eGxZOGh3ZWdMSzNHa1B0NmxKYWplQW8zNjZXOGFqQzlKbzBuWnpaRUxkb0Ry?=
 =?utf-8?B?aUN6OEU4TnlrRkwxS3ByU3djL1NSNzRvOGxtaVJtbE9rVTFPYWJzcUVQZjBq?=
 =?utf-8?B?ZTUzenQzZ1N0WVVSL2YxVE9idHNrb09sTGFlUzZnVnEvYXpoVWhrN0lTd2FM?=
 =?utf-8?B?dTFUK0M3Qjk4Q2VMVFkwbmZXVDMveFRUc0Zxd2NXSUIzZmRhcStuZGw5Y01m?=
 =?utf-8?B?LzYxVDFVZWszTWRuOHVDRWlRS1BuVFRocGMxQm01OWFDWVJBZ2J5VnhIMXNw?=
 =?utf-8?B?RktDN0NmNUd4aStnVGhLM0dqOTBXVndUd2JRT0Q5UnFvV0hFK29HR0liRW11?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3c5385-33e5-467f-7b4e-08dac2246e63
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 07:31:35.2502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XtsrX5qhROz66Eo9wdaLq8FnGLpdro0RdqtOWa4HKdvcY+xL89U6gzMt9lk3/BQRlT+HhykyJb9ERcU88a5qdm0inSjI1PC38uoIgwOe/a4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9597

SGVsbG8gYWxsLA0KDQpJIGp1c3QgcmVjZW50bHkgZm91bmQgdGhlIHRpbWUgdG8gdGVzdCB0aGlz
IHBhdGNoIGluIHRoZSBjb250ZXh0IG9mIG91ciBydF9zaWduYWxzLg0KQXMgYSBtYXR0ZXIgb2Yg
ZmFjdCBpdCB3b3JrcyBxdWl0ZSB3ZWxsIGZvciB1cy4NCg0KU28gaXMgdGhlcmUgYW55IGludGVu
dC9wb3NzaWJpbGl0eSB0byBicmluZyB0aGlzIHVwc3RyZWFtPw0KDQpJIGFsc28gZGlkIHNvbWUg
c2ltaWxhciBjaGFuZ2VzIGZvciBhcm02NC4gQXMgd2UgYWxzbyB1c2UgaW14OCBib2FyZHMuDQpJ
ZiB0aGVyZSBpcyBpbnRlcmVzdCBpbiB0aG9zZSwgSSBjb3VsZCBwb3N0IHRoZW0uDQoNCkJlc3Qg
cmVnYXJkcw0KSm9oYW5uZXMNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiBTZW50OiBGcmVpdGFnLCA4
LiBKdWxpIDIwMjIgMDk6MTMNCj4gVG86IFhlbm9tYWkgPHhlbm9tYWlAbGlzdHMubGludXguZGV2
PjsgUGhpbGlwcGUgR2VydW0gPHJwbUB4ZW5vbWFpLm9yZz47DQo+IEpvaGFubmVzIEtpcmNobWFp
ciA8am9oYW5uZXMua2lyY2htYWlyQHNpZ21hdGVrLmF0PjsgUmljaGFyZCBXZWluYmVyZ2VyDQo+
IDxyaWNoYXJkQG5vZC5hdD4NCj4gU3ViamVjdDogUmU6IFtSRkNdW1BBVENIXSB4ODY6IGRvdmV0
YWlsOiBQZXJtaXQgdG8gZGVjbGFyZSBhIHRyYXAgaGFuZGxlZA0KPiANCj4gT24gMDguMDcuMjIg
MDk6MTEsIEphbiBLaXN6a2Egd3JvdGU6DQo+ID4gRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3pr
YUBzaWVtZW5zLmNvbT4NCj4gPg0KPiA+IFRoaXMgYWxsb3dzIHRvIHNraXAgcmVwb3J0aW5nIGEg
dHJhcCB0byBMaW51eCB3aGVuIHRoZSBPT0IgaGFuZGxlcg0KPiA+IHJlc29sdmVkIGl0IGRpcmVj
dGx5LiBUaGUgaGFuZGxlciBjYW4gc2lnbmFsIHRoaXMgY29uZGl0aW9uIGJ5IHJldHVybmluZw0K
PiA+ICJ0cnVlIi4gVGhpcyBmZWF0dXJlIHdhcyBwcmVzZW50IGluIEktcGlwZSBhcyB3ZWxsLg0K
PiA+DQo+ID4gQnkgaW50ZW50aW9uLCBub3QgYWxsIHNwb3RzIG9mIG9vYl90cmFwX25vdGlmeSBh
cmUgZW5hYmxlZCBmb3IgdGhpcy4NCj4gPiBEZWJ1ZyB0cmFwcyBhcmUgbGVmdCBvdXQgYXMgd2Vs
bCBhcyBhc3luY3BmIGluIGt2bSAtIG5vIHVzZSBjYXNlcyBmcm9tDQo+ID4gT09CLXBlcnNwZWN0
aXZlLg0KPiA+DQo+ID4gTk9URTogYnJlYWtzIHVucHJlcGFyZWQgdXNlcnMsIGJyZWFrcyBub24t
eDg2Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVt
ZW5zLmNvbT4NCj4gPiAtLS0NCj4gPg0KPiA+IEknbSBoYXBweSB0byBhZGQgbm9uLXg4NiBzdXBw
b3J0IGFzIHdlbGwgaWYgdGhlIGRpcmVjdGlvbiBpcyBmaW5lLg0KPiA+DQo+ID4gQW5kIGlmIHdl
IGludHJvZHVjZSB0aGF0IHRvIGRvdmV0YWlsLCB3ZSB3aWxsIGhhdmUgdG8gYWRkIHNvbWUga2Vy
bmVsDQo+ID4gdmVyc2lvbiBjaGVja3MgdG8gWGVub21haSBzbyB0aGF0IGl0IGRvZXMgdGhlIHJp
Z2h0IHRoaW5nIHdpdGggdGhlIHJpZ2h0DQo+ID4gZG92ZXRhaWwgdmVyc2lvbnMuIEZlYXR1cmUg
ZmxhZ3MgYXJlIG91dCBvZiBmYXNoaW9uIHRoZXJlIGFzIGZhciBhcyBJDQo+ID4gdW5kZXJzdG9v
ZC4NCj4gPg0KPiANCj4gQW5kIEkgZm9yZ290IHRvIHdyaXRlIHRoYXQgdGhpcyBpZiBmb3IgdjUu
MTktZG92ZXRhaWwtcmViYXNlLiBJIGhhdmUgYQ0KPiA1LjEwIHZlcnNpb24gbG9jYWxseSBhcyB3
ZWxsLCB0aGUgb25lIHdlIHVzZSBpbiBhIGRvd25zdHJlYW0gZGVwbG95bWVudA0KPiBmb3Igc29t
ZSBtb250aHMgbm93Lg0KPiANCj4gSmFuDQo+IA0KPiAtLQ0KPiBTaWVtZW5zIEFHLCBUZWNobm9s
b2d5DQo+IENvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQo=
