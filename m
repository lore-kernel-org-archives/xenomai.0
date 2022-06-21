Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60068.outbound.protection.outlook.com [40.107.6.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A188EA44
	for <xenomai@lists.linux.dev>; Tue, 21 Jun 2022 07:19:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyCFiFrX6ZT/CW+Uis5PexqwkLuZwTL88nzDs3hKzR5IuwRrn22fUp8C9Ge8ZVp8CVKvr1sq1FlYutXiBACKp9KSy8ghFskEC8PQdhkwtIP+sLGOK/JTqxVP+31vTBvU4zghF9T+aBYtIC8uLIBSIDWuYfRji7YdjLWueC0JTFP4oekkhb2p/HExP9twQVkE5cd6u73ZWy1KRTJ8njpot6pPkfZYgHa+QztARPQlZgvFzAT+S9iT2EgfYy2LL1hYEMm3wEVLLfKlm1vIA6aAl/ySRncdPwGVsrPAq6zdcggHAuOcDQfIiv7rcEzPa3n50TJYKGHQx+U7x7uyDjM54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DF4NJDINZUvUOHvr9tWHVz6AZqODVBr4B8lzp/c3vU=;
 b=PiS070+bqGQsnpFbfz4WSWgFj2ofJMcY6OILEZwK2U9pz0tAmEzQIAcyx/ppM1/Fgq12C5mCzzDIku0jKqVRtQ5FwkYidQFQVNlVTv4qOnJ0BkVYRdtRNKdg/fw6LI2NjgdhDG1/HdpQnXd8WsGZVga4jiMO9nh8WLfdNY1sv6N4a2jsdiyUyYF2iPW6yrFR/VwEQL7WTSmUfKdx0DGTNjtGDWNpYiAYGp0vLFFg5Z04eba1L+Rq0qe+u4VpQUaZauP0URYkjK2KaUgxBLvhh82QJMxAocttD36rDFxzJPPr1gEleSthinHUfhpBMifbB9qUQQaKbpomnf21qdJcKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DF4NJDINZUvUOHvr9tWHVz6AZqODVBr4B8lzp/c3vU=;
 b=C2uXyFqO7Pb/3m6vrVUT3Z6NyutGSOQZ1v6jmyufAFNVnYHh2PD6nHRdksx5WSk+ZzdzYaVLDeQSEmuhq+1Gqr9fCVXrqfpYiQP0RCtupvzd14MJKhf18FzLjZfZPAb2YsGyCxivB9aQfnUi+KUmlDWM+BnP/9M4ojLmVvcIsrikn98E94skL2xFH2cNjaetxqEbfTUloRb9CbtbKc2UjNswWs93fIVDb/POztptSMGaLxLPVci797MkZKUPK2tBRN1gQ6lXFqJTGxSkYjex4IHj/Y+33+S8RJJ4eWnC2ERHCsSkhCBHqPDQLYwEMTGEDVE7TsJauQWOzeSw8zpf+g==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by VI1PR10MB2831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.21; Tue, 21 Jun
 2022 07:19:36 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d73:ef73:6807:c6dd]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d73:ef73:6807:c6dd%4]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 07:19:36 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "rpm@xenomai.org" <rpm@xenomai.org>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: 5.15-dovetail or mainline regression?
Thread-Topic: 5.15-dovetail or mainline regression?
Thread-Index: AQHYhTWmFNjHRqlfYU6wyvmILdN1n61ZayOAgAAI9oA=
Date: Tue, 21 Jun 2022 07:19:36 +0000
Message-ID: <a5d4cc9a4ba0457913c522048fb061444a7bce04.camel@siemens.com>
References: <88b02fec-830d-24aa-ae41-bab5031dafed@siemens.com>
	 <2307b8d0-e901-2642-6d19-bf1dca91f015@siemens.com>
In-Reply-To: <2307b8d0-e901-2642-6d19-bf1dca91f015@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e6be7f6-80d3-4e45-f55f-08da5356657e
x-ms-traffictypediagnostic: VI1PR10MB2831:EE_
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-microsoft-antispam-prvs:
 <VI1PR10MB28318E218C740BC38CEE2981F6B39@VI1PR10MB2831.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FlhKL8LzvX4xOLmrzWKKjW3s/AmReqELpP7LH+FzCKN4FEHgz9k6MHwfgQe9Vqt/mpTG9RO0NRMC59dn6uonfn088h5Hx+rLjkpH7c/DBevjLmh1nJgDFe6EzE4tCmtCQ1lYb9I9Hpi0h9nkF8y4KsSGe9/Q+javHevP+J6dZopSwT+RVareB3sifotBVH+5HVnG9C9xqIckdgTzKt0l70A48xn4WjbXTMNDtPTk3lhD0eq2I50O1ast+l+wDkb1aYp7cR5/szlp+oEphRg2NeOOTpXl5+RGOAoTTb+Jo5qfBEG6f9LYuRzbvr6cSsmqPhyqaMJa0vGEVBiFCO8tbWS/eDjf4B9WHa7FoLEb5m7g/5so0P5Q7MqE83EboWRm5DRs83AA7YuECG40r+vHLOHElGE186EXLfScme+pQgh6rWorBbeqWd4z2CaW0A/bJKmtvwyz8GPub3NWB1fTI7QX6NZjdTOO6SKGXd5T/zzByb7yT6geYo+Jpu4j7E1VA20umUJrlvJH7+y59Io0GoTG2IXS3nM3poLeozsyLQNSD2k8rJCknJZfpB7eLzjr2Imwh4/9dx6lt7odVdGB2MU6RH6IVJ0o8phmoqtPU2I0KmU/eJDbC8YOvKBWMP+f32huWNpjMOKflwkKGSIXuIZefv+yaviwalZHne6UsSam3EVbsog9NLUP0gpxOJFYjphV7UUf2YKXz8DdwQqbZAEIQ938ttkbXG9xy/lcZ4ogdnY7W/aoQb0H+1GY10RRuvApdml8+HeI+RJMeDnpH07VZg8APa2BzRF7T2kkUTA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(76116006)(64756008)(8676002)(91956017)(66556008)(66476007)(66446008)(83380400001)(5660300002)(316002)(66946007)(186003)(478600001)(36756003)(71200400001)(966005)(8936002)(110136005)(6506007)(2906002)(6486002)(2616005)(38070700005)(82960400001)(41300700001)(38100700002)(53546011)(122000001)(86362001)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0hPSDlleWlNUm5LaTY0aVB4TGhRdTF1MkV5WHRpYXR0WVFXWFVqRUNzWm5E?=
 =?utf-8?B?cTJEUzBRclBtblpXN0kvQXFkNk8vQXNVUTdONC9nZTRqMUx4YVFBWTUyODFJ?=
 =?utf-8?B?QXllSE5BMUZWUUwxVkp0aDBlZTMvNXdVZzZENVVVQjdXSjVyVko0ZDM5emhK?=
 =?utf-8?B?UjJDNmRnSUYyWENZZjdwRjRjc2FMMldHTkFmbHV2OTZqVGtVc1I1aXE2RFNB?=
 =?utf-8?B?YWc2R3hTWWhpbnEzc0NTcktJVHk1QjlxcVkxY0M5cURmaGJrbUUxd2M0SDVG?=
 =?utf-8?B?elFEMHZTV1hoQU5UYUVRRHRmSkovQ0Nvcm1OcWtFcDl1V0xBTG1ycHoyZEtC?=
 =?utf-8?B?WW1kS2Z2aXc3MlZleE94dEtmQ2I3ajVGQlNsK1VpdmdWNEVidkxiemEzTVlr?=
 =?utf-8?B?V3dkRFFqTWRDMW1LZG1Wb1kwVDhQdmV3OTVJbFF6MTdEczVXVGFqMWZmL2M2?=
 =?utf-8?B?WjNnWVp4YnNHYkE5enRMSFZ1OFdOTXY5djdzbGVlMmR0RnlodDVSSzllYTRz?=
 =?utf-8?B?K0gzaU00WTNYUWlHME9NZmZQREMxeUdXaGs4RytOMDJuWDlha3doRTFNaEVI?=
 =?utf-8?B?bmtNdFhPQ1RRc1M3T1JUZzlsMHdHWXdDajhiZWpmKzc4TWZYQ3BQdllKNnN4?=
 =?utf-8?B?TjdqcjFwL01ScFQxbnJVS3JFU0oxektTMUFJbzQ3OUpFdGIvVzB2elRZKytj?=
 =?utf-8?B?UFZ4YWY1dTdaVk42ZzN2TmhEMXA3KzBVak1idmtPcW9odjRMaVlsT0pwMm5Z?=
 =?utf-8?B?NElrMHdyV3RwUE5MTFd4Uk1hTFlrMloxTy9Xa3lCcld1QnhMUjJ1MzRCZ2Rj?=
 =?utf-8?B?amtvUnVNSVdXNnQ2bkR4ZmwwbDQrdEJEcFVrM3ROMnVqVzMyb0tWcEx2TGVu?=
 =?utf-8?B?VG9qSndNejU3Mk9TN3k0WWk1WTIzdXVHalVqWHd3eTh6a01CcUZ0ck43S2Nl?=
 =?utf-8?B?N1IwbWJDdk9yMnRzZk1FTy9jNGdlOVJTRkdmMkZvRitNWkdkV0NiQXZYbDB2?=
 =?utf-8?B?WTFaL3A0Q2lKWUcvRmlYVTF6cXdvTW9SaS9BK3h1TGNyZWU4WXQweGhjMjRW?=
 =?utf-8?B?YTdsNTJPbWpvQklKblM0SnVWQnlqejFEN1JoUDNFbmcrcWp1cU0vVFhUYXBx?=
 =?utf-8?B?aFdrSm1tL1dkSEZ1SzBHRkVuOU9jeUE4MFY2bjFnUlN6ZDlBYnowbjcxcmYv?=
 =?utf-8?B?Uy9PeTM5eEFOUjB6MlVRWjVhU3J0Yk1ENUt4b3MyY0FTZFFqaGZFZVQ1K0o5?=
 =?utf-8?B?T285dFptekttVTN3Z3lwd0l5OXZJMzcxdEZpcitBNjh2a0U3Nk51UkR6Ymds?=
 =?utf-8?B?ZnM2bGVGN0tod3NiMzFtS3BtZzNacmtaSzFJZlU2WCtBa0JGclR2YnJiMEV5?=
 =?utf-8?B?TXIwczk0OTZuSU5jV2VlTzZaM2t3TVBZYXRWajhlTXV6TlBFUWRvTExLZitq?=
 =?utf-8?B?RmhzQXZjMEdJWFJNNXJPa3d6V05JS29mbE1KaDhxMXFBcnFkaFFqTisxTzl0?=
 =?utf-8?B?T2NqUmVOcC80bU1ibk5VRjdPWXlxRkZxNDNESkRCQ2c0WHNMdEI4c2VWUUdR?=
 =?utf-8?B?U2ZNT0tYaitvakFtWGJIdWdManFXMUpwSW9aUmxPQ3hWODFaK2w0SkdKR3Fy?=
 =?utf-8?B?cHg1L0Q4cTNzOUg1bHZkRVJnekg5NzBSQnZKOGdJUS9ZODJ3YjBhcmhkdHVu?=
 =?utf-8?B?ZENhQmVvSmpCc0NhdVVVWFpDNUFPSVNxN3hVOVBLa1BCK0xCVGRnM3Y4NmRt?=
 =?utf-8?B?SVVGa2JvZmwxS2VTYU0xcUJDMTZoeS96ZEhHTDlmRnNTQk0vSFNpTFRqRkdD?=
 =?utf-8?B?NG41TitlQk5DL3l5VE5kdFd0eEV5eGM3d2VVTlgrREl4RTcvbGpWVkpyUFYz?=
 =?utf-8?B?UXhXbHRHU0YrNDFXTkRFM3RuSHowS085SUJmeFkyT3pBTHpmeUtJNTltcUZy?=
 =?utf-8?B?Z1FvZjBoWXh3WTNtcDNFN1FsQStzamZsUUF5cytFbStXUVM4aWgxSXg2MkNn?=
 =?utf-8?B?OTB4bmNVbTMrWDdBNTQ0MEVIOFR6QzJVZExkdktvcUVzQ0NIRGc3VXRwalFI?=
 =?utf-8?B?YXFXVDllMU1JbnRpTDUyb3JpR3dFVU9EdW1BajR4VmJNemJxWHh3Y3R4VjNn?=
 =?utf-8?B?NnRXYzgwUHU4MGgyN0t4REY2Z0ZCcCtvaFBaMzliaDhraXRLdTVWSEhnMnI1?=
 =?utf-8?B?WEdQckpxc3Ivc0p5MGhXN3cxZjRKelNabGIrN0FNWit2VHlqTzgrY2dKclpX?=
 =?utf-8?B?N2NVaUlSZ0llSnlNNzMwZWZsYnJKRWRUVHlwbFJQZk83Tm90dHdiVVZpSXBU?=
 =?utf-8?B?RE9Qc083OXNzQSt1Q1NTci9PZEdoQXd2NGNrY2NWMTJYVXFkWitXMW9yekk1?=
 =?utf-8?Q?2sRg/cydlOirz489W4Wm4auX7gFozuxI8sKzBIk+dRzE6?=
x-ms-exchange-antispam-messagedata-1:
 9H0eMEoCBH0us96XLHa80lb2lJWV7cnLeQ1jsOk9HJ0k2HwkUQ51UXNU
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CE453E50D4EAE46B79F9FC403CEC19C@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6be7f6-80d3-4e45-f55f-08da5356657e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 07:19:36.0989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tAH85cClxxBdRR8ZGNgvfFzInuEmyUQWtufxlT6nr3czCIqLQzbaVpzUCy5Pa7LQ3+nV/708a5raH+Fu2ZrXmwc+COYtERRH3VahKOjJYy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2831

T24gVHVlLCAyMDIyLTA2LTIxIGF0IDA4OjQ3ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAyMS4wNi4yMiAwODoxMCwgSmFuIEtpc3prYSB3cm90ZToNCj4gPiBodHRwczovL3NvdXJjZS5k
ZW54LmRlL1hlbm9tYWkveGVub21haS1pbWFnZXMvLS9qb2JzLzQ1Mjk2OCAocWVtdS1hcm02NCkg
DQo+ID4gDQo+ID4gMjAyMi0wNi0yMFQyMzo1NzozOSBbICAgIDAuMzM3NjQzXSBwcmludGs6IGNv
bnNvbGUgW3R0eUFNQTBdIGVuYWJsZWQNCj4gPiAyMDIyLTA2LTIwVDIzOjU3OjM5IFsgICAgMC4z
NDk4MDddIFVuYWJsZSB0byBoYW5kbGUga2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwg
YWRkcmVzcyBmZmZmODAwMDM2NzVjMDAwDQo+ID4gLi4uDQo+ID4gMjAyMi0wNi0yMFQyMzo1Nzoz
OSBbICAgIDAuMzU5MzM0XSBDYWxsIHRyYWNlOg0KPiA+IDIwMjItMDYtMjBUMjM6NTc6MzkgWyAg
ICAwLjM1OTUwOF0gIGxvY2tlZF9pbm9kZV90b193Yl9hbmRfbG9ja19saXN0KzB4NjAvMHgxODAN
Cj4gPiAyMDIyLTA2LTIwVDIzOjU3OjM5IFsgICAgMC4zNTk1NzddICBfX21hcmtfaW5vZGVfZGly
dHkrMHgyZTAvMHg0MzANCj4gPiAyMDIyLTA2LTIwVDIzOjU3OjM5IFsgICAgMC4zNTk2MDNdICBz
aW1wbGVfc2V0YXR0cisweDUwLzB4ODANCj4gPiAyMDIyLTA2LTIwVDIzOjU3OjM5IFsgICAgMC4z
NTk2MTddICBub3RpZnlfY2hhbmdlKzB4MzdjLzB4M2YwDQo+ID4gMjAyMi0wNi0yMFQyMzo1Nzoz
OSBbICAgIDAuMzU5NjM2XSAgaGFuZGxlX2NyZWF0ZSsweDFiMC8weDIxYw0KPiA+IDIwMjItMDYt
MjBUMjM6NTc6MzkgWyAgICAwLjM1OTY2OV0gIGRldnRtcGZzZCsweDgwLzB4ZDANCj4gPiAyMDIy
LTA2LTIwVDIzOjU3OjM5IFsgICAgMC4zNTk2ODhdICBrdGhyZWFkKzB4MTUwLzB4MTYwDQo+ID4g
MjAyMi0wNi0yMFQyMzo1NzozOSBbICAgIDAuMzU5NzA3XSAgcmV0X2Zyb21fZm9yaysweDEwLzB4
MjANCj4gPiAyMDIyLTA2LTIwVDIzOjU3OjM5IFsgICAgMC4zNjAwMjldIENvZGU6IDExMDAwNDIx
IGI5MDAxMmExIGQ1MzhkMDgxIDhiMDEwMDAwIChjODVmN2MwMykgDQo+ID4gMjAyMi0wNi0yMFQy
Mzo1NzozOSBbICAgIDAuMzY5NDExXSAtLS1bIGVuZCB0cmFjZSA5MWNhNDliNTAzNWU4MDUwIF0t
LS0NCj4gPiANCj4gPiBIaXR0aW5nIHJldHJ5IG5vdyB0byBzZWUgaWYgaXQgc3RpY2tzLiBUaGUg
cmVhbCBhcm02NCB0YXJnZXQgd2FzIHN0dWNrIA0KPiA+IGluIHUtYm9vdCAodGZ0cCksIHNvIEkg
Y2Fubm90IHRlbGwgeWV0IGlmIGl0IGlzIG9ubHkgYSBzaWRlLWVmZmVjdCBvZiANCj4gPiBlbXVs
YXRpb24uDQo+ID4gDQo+IA0KPiBUaGUgaXNzdWUgd2l0aCBRRU1VIHN0aWNrczoNCj4gaHR0cHM6
Ly9zb3VyY2UuZGVueC5kZS9YZW5vbWFpL3hlbm9tYWktaW1hZ2VzLy0vam9icy80NTMxMTUNCj4g
DQo+IEJ1dCBub3cgQ0kgaXMgZmFpbGluZyBpbiB0aGUgaW5mcmFzdHJ1Y3R1cmUsIHNvIEkgY2Fu
J3QgcmV0ZXN0IG9uIGhpa2V5Lg0KDQpHaXRsYWIuY29tIGlzIGZpZ2h0aW5nIGFnYWluc3QgY29u
bmVjdGl2aXR5IGlzc3Vlcy4gU2VlDQpodHRwczovL3N0YXR1cy5naXRsYWIuY29tLy4gVGhlIGhp
a2V5IGpvYiBmYWlsZWQgYmVjYXVzZSB0aGUgcnVubmVyIHdhcw0Kbm90IGFibGUgdG8gZG93bmxv
YWQgdGhlIGNvbnRhaW5lciBpbWFnZS4NCg0KDQpQUzogQ2FuIHdlIHVzZSB4ZW5vbWFpQHhlbm9t
YWkub3JnIGFnYWluPyBUaGVyZSB3YXMgYSB0ZXN0IG1lc3NhZ2UNCnllc3RlcmRheSB3aGljaCBs
b29rcyBwcm9taXNpbmcuDQoNCj4gDQo+IEphbg0KPiANCg0K
