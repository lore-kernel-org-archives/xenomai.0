Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012049.outbound.protection.outlook.com [52.101.66.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6FD1DF73A
	for <xenomai@lists.linux.dev>; Tue, 14 Apr 2026 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776182765; cv=fail; b=XO4oXEACi4c/2DqClt6yTF6CwqeG1xcCTEjqFoyamtG02FFZJ9VeRqhQn3qS4PQRdXKEnO2vIIAGYYyht/u0qLgd63EiupZx2tbiYQtuCqBWiThiFP87NMTFO0xjaeH19m4CnqE4bhStddzW9hNfCLzI6SxyHHqxl7/RtmmONEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776182765; c=relaxed/simple;
	bh=3RnagnEFtwGPUSGXREbAPhF6S9cduqNt72OCr10OqYw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OZ9cj4asdjn/dGTsIiml9B8apb4ToD1ohT3R95RMwDs9ZqMu3T70wyN40ZUcD6PozAf3EUtoPbE+gi9ejsABgzKpooEpOEusmyUgqaHKQ7fn4e+4d/z1LiBWhoBFYPdweCHCiyrdojx7XtIfsFhEY/PKzUSA4vtaJfL+OTlQrRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WIO6d1AI; arc=fail smtp.client-ip=52.101.66.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WIO6d1AI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBFuh9evoTqfZP0UGRwCeR8kqG2BKAeGT9kf8xHheZbLPncqCuI3Ab2fGVsp9gBhat+rGxFBLcNgQ/5IqCCU9tEiaTETa7P1fu/pN11FsZmwFXeMih5gDPH3LIRy7t7j8oNo0iTR0Hr8vywVfFPe8TcjH2J2tBYEqE8Bu/VJJCxZARYnS13NwlFB7Mi8S/CO2xqeaub4ETlfZTt3MHsaxvUvGcNFU4/Oo2lofp/mhFu82FS7RLpC7GwmE1djVcbgw6Pz+0PBBWhh2AnEju6937Gr7+Pa05oNY7/DYC4UDKE8pGnU94y2UBtq710rcWmsu45ezNTDvov1XHGjcWWSlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RnagnEFtwGPUSGXREbAPhF6S9cduqNt72OCr10OqYw=;
 b=K3zOxZKNZBbSLaAeAQKXAX8Iu4whkTbrT/9HHFyaX8kiNyGQroG80ba41ojHHirOKDDA0TClOqWhNkQb6/sZ/He0oaO5FGZVkiMSqjwD6Qb8SZJF++b585paIBaiS9JSxagSyvclyvy5QuAR1ZfT75oufwrYA5GJrp+iuu2d4/lhJxOWaY6PdQEIM3252hF9YKYXMs+o/TmqYGoB5MCjpUWLlPZLHrlYYvA2EdJtI3+R4pntn+5gtPXTbd9reBD5wOvpIOQVZy6MT5SnI/uChddJRT3U7ci8FWuLXLfBMB5IrvYKWWYeOvOUeFcOACmT2wmu6Y3P9jVN+DSuIX8LVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RnagnEFtwGPUSGXREbAPhF6S9cduqNt72OCr10OqYw=;
 b=WIO6d1AIM9bY7H2PAjgtQ57vG9+5dMqvptzkVTvq+RDufpZv09soMVNC9MZZnDeNOf/06BlzaeGhN3JIAIMv9fSP+8FW7Bgy8EeyRuWBbmW82MKfIY8HHqtErRQqkQBnbb8tMpgH9iucuspjSNBkqbQtABKZiThsGi5LqNtmj0+e1QRf55Jfuub7EvviztoIViZOXCuWXzAtwAlFilWq1b0l3BwPQoJccM8NCu7BTemd/Y5Wtx05RKxcXtaS/sJ8wWMM/GyX6c5rFsTAjxPOMTlGzULJfe8dXXbQ1QEcWy+E5wq4M4wLfIB7YtqOo0OVev8MTn0tdXGEa4Ns5lINeA==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AS2PR10MB7108.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 16:05:57 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4072:14dc:7d1:74c7]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4072:14dc:7d1:74c7%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 16:05:57 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: Re: [PATCH] cobalt/posix/syscall: Account for changes in kernel 7.0
Thread-Topic: [PATCH] cobalt/posix/syscall: Account for changes in kernel 7.0
Thread-Index: AQHczCRcgCd3IM/JAUiM5p4ERjY9MrXeuC+AgAAArwA=
Date: Tue, 14 Apr 2026 16:05:57 +0000
Message-ID: <030ff74e3f1517e8bff7b92bbdecc8dbdda32dae.camel@siemens.com>
References: <ed1ca8c0-93ec-457f-8615-aad03b06f6ef@siemens.com>
	 <5a8c53d0507a1f8e0816ea6a1f6a02ab2fea1c58.camel@siemens.com>
In-Reply-To: <5a8c53d0507a1f8e0816ea6a1f6a02ab2fea1c58.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|AS2PR10MB7108:EE_
x-ms-office365-filtering-correlation-id: 8c8640dd-c365-4124-33d1-08de9a3fb6a3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021|56012099003|22082099003|18002099003|55112099003;
x-microsoft-antispam-message-info:
 dCFuWp2f1d4oIBlFg6PZ2Ef2f65Ufnb3r5NtHDJ8JSdmWGzqp1xttc/xMLuvtObnI6XWaoNuCD/KjheZWIKeLEGNUArgR4Tr54/FSu6bJChiJ1RKLaa52stbRdZ8yt61EwkDhm4OHdRdC1qvE2YpZD8kmOv1V9oFjCzP5mzHErlrJ1SWn/YbJPdkng5hbSGUabM3mUUkMbekHF9LLK9+/iMDqDDIMXpRBLo6XeR9KaO5TcZ4jj5ilRL5r3EWP6+5iGE39c1G5L5bzQQOOSxXYGZAbaDY8cLGxGUx+QQHtAf4LNNVpa0uxlsOXOKDT9K6xfQhezrOXTizzJ5NQur5QKRNt2sqG/G4kFLH7D6WSyuBou5l21tgVWeYPqHbJujkuzyzug9FuKOBF0cuoA7eWmOu8eQ5c11h5kyCPARVn5ZDR9aBUYRKRq117J2TBnSbNQrAkQ7QwKZ7eoCvGcTF6Qz4ac3b6kRNnNlbUvq74DvLfncWIDkjHuAdPQB7kzG0EKiundVm16fB8N5qGbnBfMSbIwiHu0H9/ibgPSA/VNQoSlUQPiHmQ97hPmoTJdxFVuen5GfFqnkVpVh2YtwtbNrnzTcKkNiNT1fFXI4yp6oynwuumGWQYuy128wEe/0QPZBwDH31h2sqJISeL6KvSKFY+DfZvslj6h3S1/VfsTVQ4KCJipdICP4y3Q4UWwLm9U2G8EW+L1Cai7taeBZpc2sX/Yu1LRqfPIU1NeOtwzh/yP6Ktqkx82858I00P6c/a/r3XUM9IXuk6hu0fJsiV0H/01oBGqjgr1HryW/NIoo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RE05N2hzRnF2Q0RaenhvZmhtRS94UUhPcTBTZFFGcFU4OVBjbVNmcnV3ZnpR?=
 =?utf-8?B?QmZ1aDV5Rk1ocDZxaThTbnJFQ09odWRFeVRLNlNUQmpKN0hXbVdsYWc5a3RO?=
 =?utf-8?B?bFdkMDdXNHR0dDVnZGxKOTBWcEhEdzJKY3pETk92OXphODczRUJnWmlIVVZN?=
 =?utf-8?B?SzNiL1JJUXY0NEZKeEZYK0xpQUdYZzBtWkNlbUt4cFhsS0JHZUNLNGN2VEl1?=
 =?utf-8?B?cVlUcndMcHM0V2tUQ3NHdTBvd0lIOXRKMEd6NEpUZFhrYXU2V1NWeG9LWDJj?=
 =?utf-8?B?NDg2eTRoUE53N0F3ZTZTZGFLbDlIRUtyYXUzYXV2MXZpQnFHV1BqUlhUVFYz?=
 =?utf-8?B?V0ZxQnhxdmZNTkpSV090eUljb1RtbGJNYndZbUhxM2Q2aFl2QVJ0aXdlMXJJ?=
 =?utf-8?B?a2k1TlNSR2p4N0NFQ3ZPRk0xR3hqclFLK09KQzlGb0ZtN3oyaW1pb0d6dG1X?=
 =?utf-8?B?bXBzZXdmSmtoajhRVmlmS1JSSm5zRHBrYU9EOWJjRllzV2VTZ1hWZVlFOEcz?=
 =?utf-8?B?Wis5Rm5UK1I4ckN3STJMOWw0UXZqUksvb0dtYXNhSUZTVXRES3VQNHoxTE5Q?=
 =?utf-8?B?RDFUbUM2SU94cHBaV0p6NTJieEpnMXB0T0lEUFNhamlxbGl4dFVYUjVRbDhL?=
 =?utf-8?B?RGhUaWxGV2wyV2RjWkw5RjAxMFRxTDRwVEhOM00vZlJqMm1FWHRhd1B6eGtC?=
 =?utf-8?B?eWVNRFdxR05EREJLcktlVU5VSVBGZmwwNVV4eWhNRmZQRVgxYTBBVDdiSGpx?=
 =?utf-8?B?OXZTeFhBN3grdW45ckREd3VGb1RHMGxSaW90em1HU1djTDRsN2JlWllpbWdM?=
 =?utf-8?B?dGl6dWQzYlpsNlhEaG9ybzM1NElESmlXMmk1NEg1cmVaeStBOHUxZVNEaFhr?=
 =?utf-8?B?ZEZzSjN3L00xOFllNzNWemdUYjJnYkdqRnZyeGZZN0ZxVE5LNmY3eW40SWpQ?=
 =?utf-8?B?QithNnZLeWU0T09IL1hsV3plVGRNMmxaS3plT3MrdE56WDBlR2cwbFhZZjFE?=
 =?utf-8?B?V21pVGlmbjUxeFFpS1JMQWEva2NPcWlWMVFOd2xUN0c1Ynl1OEZ4TlZhTG1y?=
 =?utf-8?B?VmV6dHV0K1pkTngzUXRKTEtJY2M0cXNiSlJKR00rN1dXRStUNVVSakVEMFc1?=
 =?utf-8?B?VjByaXBoZStra3pISEUxQlNwTThIOU83UWY2aXBaY1RSNFZCQm5BVFo4WEJ2?=
 =?utf-8?B?K1FVUUQzNTkxWnVFWHB4TXJNZmNvd1g5S1ViSzlTRVBTaDVnd0N2ZWhOY2Mw?=
 =?utf-8?B?aU1uL0JRK2tJVHgyZVhlYjl0NEdsdnlFUXFwSGE4Uk1pdGlmWTQ5dXQ5UE5a?=
 =?utf-8?B?d295VEYweHc1Z2lWelBvMUdnMWNSaUlSZitUQkMrL3JmamMrSFhMZFR4N1c3?=
 =?utf-8?B?UVdrTVhuYm5ISmJrWGVHWGhKTGZRWFlyRC9lVzg1M2J6K1NJMXZwZkkyWDhE?=
 =?utf-8?B?MTNZSVFmSXd3dlptUjAzcHMyN0tMUHlrck1nYnc0R3IyMDFIUEN4S3lHTFUx?=
 =?utf-8?B?WDFwaXdnSlUvaTRobEV4ak9TelJIcUZPQW5QbWhIMWlweUpLRktvMUpoZlNC?=
 =?utf-8?B?SDdGdkF6dW5vMHNFNmVqQ2puZ3VhV1JibzBxcEkzL29ha3VValpzZDZ6UEZm?=
 =?utf-8?B?TmpUZjZEeHI2cDJPd2gxVW9XTDNIUHZVVTNsdU90QTMvNWQvUVA0UmJySzdQ?=
 =?utf-8?B?N1l3eWF4UE5tRDRYUW1nTkY5RHRaTmU3b1BQdUVodUlJaUFDZVI4dmVrNUZO?=
 =?utf-8?B?RzhJbGhJQlhxN3VVM0ZzaUdmaVpncE42clNNbndQVTVCVGNEbXRlQXBCaTUv?=
 =?utf-8?B?R2xlTGNzb212ZFh2ZGlOT1lKQkViVkdpdUtLYjNqZXlqa2JLOExvQWdwaS9z?=
 =?utf-8?B?NE1GVUMwaWNSS0ZoaDRHMXgxQTBGaExlRVNOWWV5MWF2Y3JicXZ3TlpzRFBD?=
 =?utf-8?B?Y3l4MHhtczF5STN6dllNTHowSXZFVCtBeFdyTzUzTktEVDc1OENYU1Z3YWdR?=
 =?utf-8?B?aldKOXdUdTZITUZubjA1RU1sTWlFUnJ5OHpodWNPWXYrRmZSbU1EbGtRRkxn?=
 =?utf-8?B?SGgxQmd6aURmUTVzcFN2VU9taVovWmladFIySEVkMXFYNmJQMnpLYVJGNnBv?=
 =?utf-8?B?eTAvcUNRR29IZHhiR0NWUitnRklTTzFNNTV6ZC9waDhDQnNpU2htUnRDS3dh?=
 =?utf-8?B?bVo2NDhlUWFWMEZXOHBpVWhsWDgxdnlKRUo0ZFVoQUdLdCt5VURIMTczb0Nl?=
 =?utf-8?B?T0o4UC83WXp5eXBsd25HZjRUNnBWYTRna0VSVGwxOUtzenhUNGVBU2FBdzRo?=
 =?utf-8?B?NjlCdVE0QkdlUFlseVRCQ2lSeG9HZGFuYWVoYlJwV2Vqa1dCOUszK3lEQ2JC?=
 =?utf-8?Q?DkPCx5vJWS8I98Jyff3mHatq1/vUvgW0tKLEsJvIToEEi?=
x-ms-exchange-antispam-messagedata-1: QYCvLIwXE/RkX8CuD4APeqzIRmr1RyBtvJk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBB76FCC84C99D4490354C7B5117D405@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8640dd-c365-4124-33d1-08de9a3fb6a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 16:05:57.0332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOdVvjZasytmieIKP4nCDQ22mKaMTpV3ENXNIogc0UWrGPzM/d7kgdCD9aNEayufwsEE63YPQLFhBH7Gy5fSqN//kP9rhntGNOlXn/S1T1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7108

T24gVHVlLCAyMDI2LTA0LTE0IGF0IDE4OjAzICswMjAwLCBGbG9yaWFuIEJlemRla2Egd3JvdGU6
DQo+IE9uIFR1ZSwgMjAyNi0wNC0xNCBhdCAxNzozNSArMDIwMCwgSmFuIEtpc3prYSB3cm90ZToN
Cj4gPiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiA+IA0KPiA+
IFdpdGggNy4wLCB3ZSBubyBsb25nZXIgaGF2ZSBhIGFjY2VzcyB0byB0cmFjZSBwcmludCBmdW5j
dGlvbiB0aGF0IHRha2VzDQo+ID4gdGhlIHN0cmluZyBzaXplIGRpcmVjdGx5LiBbX19ddHJhY2Vf
cHV0cyB3aWxsIG5vdyBhbHdheXMgaW52b2tlIHN0cmxlbg0KPiA+IG9uIHRoZSBwYXNzZWQgc3Ry
aW5nLiBXZSB0aGVyZWZvcmUgbmVlZCB0byB0ZXJtaW5hdGUgb3VyIHN0cmluZw0KPiA+IHByb3Bl
cmx5LCBldmVuIGlmIGEgbGFyZ2VyIG9uZSB3YXMgcGFzc2VkLg0KPiA+IA0KPiA+IFdlIGNvdWxk
IGtlZXAgdGhlIG1pY3JvLW9wdGltaXplZCB2YXJpYW50IGZvciBvbGRlciBrZXJuZWxzLCBidXQg
YXMgdGhhdA0KPiA+IGlzIHBoYXNpbmcgb3V0IGFuZCB0aGUgZ2FpbiBpcyBsaWtlbHkgbWluaW1h
bCAodGhlIHN0cmluZyBpcyBzdGlsbCBpbiBMMQ0KPiA+IGNhY2hlIGFmdGVyIGNvcHlfZnJvbV91
c2VyKSwgc2ltcGx5IHN3aXRjaCBhbGwgdmVyc2lvbnMgdG8gdGhlIHNhbWUNCj4gPiBwYXR0ZXJu
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVu
cy5jb20+DQo+ID4gLS0tDQo+ID4gIGtlcm5lbC9jb2JhbHQvcG9zaXgvc3lzY2FsbC5jIHwgMTEg
KysrKysrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL2NvYmFsdC9wb3NpeC9zeXNj
YWxsLmMgYi9rZXJuZWwvY29iYWx0L3Bvc2l4L3N5c2NhbGwuYw0KPiA+IGluZGV4IGEyNmRhMTU0
YzQuLmJjMTgyNTY3NmYgMTAwNjQ0DQo+ID4gLS0tIGEva2VybmVsL2NvYmFsdC9wb3NpeC9zeXNj
YWxsLmMNCj4gPiArKysgYi9rZXJuZWwvY29iYWx0L3Bvc2l4L3N5c2NhbGwuYw0KPiA+IEBAIC00
Niw2ICs0NiwxMiBAQA0KPiA+ICAjaW5jbHVkZSAiLi4vZGVidWcuaCINCj4gPiAgI2luY2x1ZGUg
PHRyYWNlL2V2ZW50cy9jb2JhbHQtcG9zaXguaD4NCj4gPiAgDQo+ID4gKyNpZiBMSU5VWF9WRVJT
SU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oNywwLDApDQo+ID4gKyNpbmNsdWRlIDxsaW51eC90
cmFjZV9wcmludGsuaD4NCj4gPiArI2Vsc2UNCj4gPiArI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5o
Pg0KPiA+ICsjZW5kaWYNCj4gPiArDQo+ID4gIC8qIFN5c2NhbGwgbXVzdCBydW4gaW50byB0aGUg
TGludXggZG9tYWluLiAqLw0KPiA+ICAjZGVmaW5lIF9feG5fZXhlY19sb3N0YWdlICAgIDB4MQ0K
PiA+ICAvKiBTeXNjYWxsIG11c3QgcnVuIGludG8gdGhlIFhlbm9tYWkgZG9tYWluLiAqLw0KPiA+
IEBAIC0xOTQsMTIgKzIwMCwxMyBAQCBzdGF0aWMgQ09CQUxUX1NZU0NBTEwoZnRyYWNlX3B1dHMs
IGN1cnJlbnQsDQo+ID4gIAljaGFyIGJ1ZlsyNTZdOw0KPiA+ICAJdW5zaWduZWQgbGVuOw0KPiA+
ICANCj4gPiAtCWxlbiA9IGNvYmFsdF9zdHJuY3B5X2Zyb21fdXNlcihidWYsIHN0ciwgc2l6ZW9m
KGJ1ZikpOw0KPiA+ICsJbGVuID0gY29iYWx0X3N0cm5jcHlfZnJvbV91c2VyKGJ1Ziwgc3RyLCBz
aXplb2YoYnVmKSAtIDEpOw0KPiA+ICAJaWYgKGxlbiA8IDApDQo+ID4gIAkJcmV0dXJuIC1FRkFV
TFQ7DQo+ID4gIA0KPiA+ICAjaWZkZWYgQ09ORklHX1RSQUNJTkcNCj4gPiAtCV9fdHJhY2VfcHV0
cyhfVEhJU19JUF8sIGJ1ZiwgbGVuKTsNCj4gPiArCWJ1ZltzaXplb2YoYnVmKSAtIDFdID0gMDsN
Cj4gDQo+IFNob3VsZG4ndCB3ZSB0ZXJtaW5hdGUgYXQgYnVmW2xlbl0/DQo+IA0KPiBidWZbbGVu
KzFdIHRvIGJ1ZltzaXplb2YoYnVmKS0xXSBtaWdodCBiZSBnYXJiYWdlLCBubz8NCg0KSWdub3Jl
IHRoYXQuIFByZXNzZWQgU2VuZCB0byBmYXN0Li4uIFRoYXQgaXMganVzdCB0aGUgd29yc3QgY2Fz
ZSBhcw0Kc3RybmNweSBkb2VzIG5vdCB0ZXJtaW5hdGUgaW4gY2FzZSB0aGUgZnVsbCBidWZmZXIg
d2FzIHVzZWQgYnV0IGRvZXMgc28NCmlmIGxlc3MgdGhlbiB0aGUgZnVsbCBzaXplIHdhcyBuZWVk
ZWQuDQoNCj4gDQo+ID4gKwl0cmFjZV9wdXRzKGJ1Zik7DQo+ID4gICNlbmRpZg0KPiA+ICANCj4g
PiAgCXJldHVybiAwOw0KPiA+IC0tIA0KPiA+IDIuNDcuMw0K
