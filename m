Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130113.outbound.protection.outlook.com [40.107.13.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A306F257A
	for <xenomai@lists.linux.dev>; Tue, 28 Jun 2022 11:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5YK4w5O+XFP8MEvLMaF3nUJ+EbVefFYFIJe+pyCZg4dzMzLMU+KjE3Z2/EMUbWL2d6BM0if8dpkFIUr6u6vaX21jHIp4prPJtgAF5r3ikfWD/B90Aa6g2SC1klgFJjGHF/zD+woHs/twg5qDZr3Npxmd5krWoOpTDr60yVuFfpU+JgbSnG+P/gyV0R4T/2jy2Zh9yzDfmCnM/usE0KycE6vJwg38ROMKJw/heJu003pwi/ztXHjXq6IpQjEl6XGchyZrKmNKDgZUy7KdgrQ5EY5mmhUTxLPA5gUDqXM6TnWhXl7ng219ZMpTLo6wbYkOGHvrjgZGEZ9jMns90JDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=568URIiLTXAAcfXyS8mMdSFGLG5TO36Am1koPq48gH8=;
 b=IYbL4v4YqbZsGMsuKuE4IzmM/BeqdiZbD4lMwF/Dk5HfgIVQU4/tE0ZORDh/+SYvuk7iljGDlk5Nl15knXttktT0sr4HuMlmKlTM/D2rGFERPFzXfKjQC6G3TyFqNEEV2cKSecrJx2PpnjsQwIYblTa6BFqWgw8tAEmmpgap+iQLfclYKJfvLGJr12sz/ICnbcFjsoZ4uWXafAmb0MS9kdfTSe5LF5xJg5JwroaqporgRHexOk+EKHu2uuRSI4Nv/0OLRAKA94d1CCiAaOiWouk+9ppBTEcLzXE+Hm/NUfIWe/pNCesVRd1/nmN9f8086SiwGerugRfneM1Oe5rNsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=philips.com; dmarc=pass action=none header.from=philips.com;
 dkim=pass header.d=philips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philips.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=568URIiLTXAAcfXyS8mMdSFGLG5TO36Am1koPq48gH8=;
 b=tVhSbRw5nuu1ONI6bp3wQpbLBImIY0ALSIN9pSI99XCqo+3LdlnjzT5K8C3lxX8byp/OnobvZIPd75dLg7zFGk0nDVfr68Jx/uCdBtItNLYpK0O4X9o/b7h9ahQakvY43QqG+I+fn/9Ydha21DfX2vh5aN67uznsjy4viazcmhg=
Received: from AMAP122MB0225.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:193::14)
 by DB8P122MB0140.EURP122.PROD.OUTLOOK.COM (2603:10a6:10:b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 11:04:28 +0000
Received: from AMAP122MB0225.EURP122.PROD.OUTLOOK.COM
 ([fe80::1c80:fc56:12e7:52a4]) by AMAP122MB0225.EURP122.PROD.OUTLOOK.COM
 ([fe80::1c80:fc56:12e7:52a4%6]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 11:04:28 +0000
From: "Grau, Gunter" <gunter.grau@philips.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: [Xenomai PATCH] atomic: Use __typeof__ to be compatible with c++
Thread-Topic: [Xenomai PATCH] atomic: Use __typeof__ to be compatible with c++
Thread-Index: AQHYisVGSGL/Q5uork20TyUJMP5Upa1kf/8AgAAn0BA=
Date: Tue, 28 Jun 2022 11:04:28 +0000
Message-ID:
 <AMAP122MB02252056A06D7A60448FACB8F2B89@AMAP122MB0225.EURP122.PROD.OUTLOOK.COM>
References: <56f788c9-f7c1-a88d-6018-c5de0aaa3a76@siemens.com>
 <20220628080113.2527683-1-gunter.grau@bbl.ms.philips.com>
 <11b10ed7-043b-6f37-a186-53b7d57a1ccc@siemens.com>
In-Reply-To: <11b10ed7-043b-6f37-a186-53b7d57a1ccc@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=philips.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0278af0b-753f-43f7-212c-08da58f5f872
x-ms-traffictypediagnostic: DB8P122MB0140:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pVZoH3QCKYt+SB6DpWTcxirukWfcv7H0e6ehEx/aB1vduw2FhfbLYUkLLDjBuboEMLyKNp+/p4PnJGc+OZxLoK06JAepXXQ1oHEkBZoXqX4hvd4/RoPJ6L+LfEYbxj2YsqsJAMaVr7NT2N3hsWchpfsCzTnFHlmKDqCvqUitaRMjS3KdutXbigcv7NfuVAzHMh7PMwi6Giua0diXtT9lzJzHFmLL7z5NmCRsR/1yCNFqLTXR8PSbCeMZEUkzEffIRVm8ATTsuAy/yxw48TENOv+dzaoRQ9BaarERb8o+cJHqc4w3MjV7kcWfqhe4ewuygbbN0KtwzFZQpvmRyolRW2x7Ig9kzEfMKq6O1YhqRPE2uymCFs8iK+vVtUAunvFrBjk56QLolJgtNP5wHycu+GZtwnNTakIyV737Qjwjf0Solzy8phPI289JS2Hx4CPOQiwAqk6+UAH6Jdaz+JIJEhCEMa1JEbJ+Q0qxpIwjINFlujT+goB+hCI/CVyY4i2OQVceOHBdEWs27mRnlKXGYwbyHnn1ICQjEfL8sWa24xU5JqP0qqiT8RMjneGGX9fHcFO+IVOJI/A7IdZwDzSq1Qfie3xc0Xnt56vRJxTFUiLdooTJnIFyaWBcp3Vr0qJaM2q/NSSMEWuyEq0G4N4nYhis2omy/OpO+dsn/XSaTKg30G6i7h2buxrjiJ5Gkq/4dOUsD/BCC/lIengVE4olsKJnYsYmRaM0PZdFBPjMdpY2r4GJGnplQfBNU5MCF0uWigqePNQO2DiJRMPtHczruqa7tomSZPFFaFl48SaHc4U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMAP122MB0225.EURP122.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(26005)(8936002)(6506007)(9686003)(38100700002)(53546011)(52536014)(33656002)(5660300002)(41300700001)(86362001)(7696005)(110136005)(71200400001)(2906002)(82960400001)(66476007)(478600001)(66946007)(64756008)(316002)(8676002)(122000001)(66446008)(55016003)(83380400001)(38070700005)(76116006)(66556008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Uk9sNHh2WmhvbzQ1NHhic3JjVDNidmh2MFVJNS9lNG45OE5iOGV2V0MrM1R5?=
 =?utf-8?B?ZWdSenRTZjZ2dHlnbU43VUZUNUs1T1AwNE1kNlBVd3o2bDBCdEJDd1pVYVg3?=
 =?utf-8?B?MWloNnorcGYwR3Fpa1l6ejJNYWN6WnJKSnlJc1lNNnRNSm9kemxQN2pUdGkx?=
 =?utf-8?B?NExKV1RhR1hRZGs5cGFvMHlTZkwzWUVHOG1vaUYwNytoSm40NUtFcnlrSWNw?=
 =?utf-8?B?cnNyY3c1TkI4cWRuKzdQejdwNjFYd1hkaXNuNS9oTVB1dVltMjhRS0JXb2Rs?=
 =?utf-8?B?QjZ1SXcwVUN6eGlwcy9TM0xBNXVmdG90UHNFbmV6OThhcGYzQ011a0NmV09i?=
 =?utf-8?B?U1Urc2k1b3V2NDY3UXYrdHlBZ1RiMzYxTXRqTEF0emxYa1BZQXRxdGZ2RHpX?=
 =?utf-8?B?eS9rQitEc2hGZU92elBsL2VBaHRPTk96Rml1V0pOZXM3YjA0VWYxV1huZzRP?=
 =?utf-8?B?NEJqQW14Sk83Z1g3di9LV09ML3hXZm9IcnZGU2l6bnZZRzRiSjlYRlZFYzFP?=
 =?utf-8?B?RnRoQkFxUmdlVTc5dXVhQ0tKa0l5Ui9xQmdDWUpLMXN0em9SVmw2R3dUbGQv?=
 =?utf-8?B?aWZCUXBreFJaMWJPV2VyMklLRFdVUGlsN1Fsc3hvOHh4dW9FNWhBbzR2dWph?=
 =?utf-8?B?TjRoVitOdGRoR1ZLK3dWRVF6Rkw1cTk2dDg4VzRJclVMeWJrUERnZHBXMmZk?=
 =?utf-8?B?S05pTnpHQ1hsV1E1Snh5T1BHMFFWR0hFT2FrQk9FM1RNM2tkUnNRd3pYKzRt?=
 =?utf-8?B?ODNHc2luOFAyVEV1MGNNd0RpLzBwMjA4aUNHWUgzTXpLVmVjVmtBZCt4ZW9o?=
 =?utf-8?B?a1ZlQ3hjSW1HdlRpTnZYNW0rbXJnZFVTMnBRTnUwS2RNUGtXQXdpcVo3bFRm?=
 =?utf-8?B?VmRSRWNjUk96cWxoZTUzekcyQzVRazAwWnhmdTUyZEM2SWFGZFhqVGNCKzBx?=
 =?utf-8?B?WFMra2xFU21WdTcxYTMvWjJMa3FSZlZ2ZkxRY2RsRWZIa0t6dTd2OTNaUWhm?=
 =?utf-8?B?aHNKVi9TR21zKzd3YU5ZL0xtZnNTMmhrcXBBTWIvVTRMNEtZdVFMVWZVdE5J?=
 =?utf-8?B?bTRhV3JOdFRlaUZsZkJ5aGNTNEZJbHM5c3N2WG04OFM0K3pRTStzZjlHNktl?=
 =?utf-8?B?cVlveDJwVDlhOHBSV2ZKYTZOSXhRUTB6c004RlJZbkFobVFvWlM4S2s4MFZZ?=
 =?utf-8?B?TU5ycWhxcTl2OUM5TFhjWVZKb2pZSjBxNW8ya2g1SUFCMkkvcVVndEJqOEV5?=
 =?utf-8?B?RFgzd1Q4bGZjNWZqVmdJYW5pUTRMSzdjLzhDb01pQnR5Nk1GTVpaVkZPUGVx?=
 =?utf-8?B?QWJzamxwR0tBNGdWdVkxSzE3MU5ZdkRJS0VjckFNeWlmV2o4WUZXVjFlL2w2?=
 =?utf-8?B?OEtadDFWaWlVMHNMMElQM2RodUd3QXZ4RTc2ZHB4dXJkUW15bGVQczRHeEVi?=
 =?utf-8?B?Qk9NUUtHVDdzZEpvb2lLSkM1NlhvM3ZId2QyWFdFNm5PSmViSnlmZEE3VDN0?=
 =?utf-8?B?bUJvWUs1SjU2Y2h6enN5R0Zhb1hIL2FNanFZWUo2cTI2Ris2a09aRUJGZUxU?=
 =?utf-8?B?NWNRNk52SUZpMGlXam9rbEMzZEZEUGg3a2FFUkdKZk9mL2c4NkUvYmNMT2dR?=
 =?utf-8?B?clBvd1lyWW1lYzNTSTF2djB1TzNEV29sQXFDKyt0NlUybURMRVlwSzdmNk90?=
 =?utf-8?B?UUZNRzFaSzE2UjhMREtYMC9iMHl1V2NkS1JUbUZQMmhxcS8vZHloZ1V4WlJp?=
 =?utf-8?B?dGVjM1lTRjZTZldrUUx2ZXA2MTVCRDZHWkowcGkzdmNMYytHMkZ0Z3pCcU5B?=
 =?utf-8?B?VmEwZURVb1JOOUN4SGh5aXdibFE1bEd5K0MvQ3VDZlI0VlV1bEZzTElOVDcy?=
 =?utf-8?B?N1laeG1HVk5iZ1NHOWllOVI0b05mRTc1cTd6Ukc4eS9EaU9mMGsvb0NQSld4?=
 =?utf-8?B?RTJhek5NeWVNS2x1RFZ3SVI1c1B5Q0YxL0ZpY0F4RFVZMVNrbVhSYVFoU1lw?=
 =?utf-8?B?UmswakJxUzVnREpiTGk5L29GbHlrZk14UmxjRkRXTkY0NGFYKys1WGFLUTNX?=
 =?utf-8?B?L3Rzay9JeUdCRGcvSEcwNXVlWW5rOXVrYVlQWG9IeVR6SHhjaGt1NU9uek52?=
 =?utf-8?Q?D56h1jZERk9LHVUf8OmDztlrd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: philips.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMAP122MB0225.EURP122.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0278af0b-753f-43f7-212c-08da58f5f872
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 11:04:28.4338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IInw5Jzt7/fQHyupurYG//sOhEenDtj99+TwN9WhbjaG+wH4E70YVc8vGj4gKfz05hnWAlhAKdsyOm2IMnX50w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P122MB0140

PiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiBTZW50OiBEaWVu
c3RhZywgMjguIEp1bmkgMjAyMiAxMDo0MQ0KPg0KPiBDYXV0aW9uOiBUaGlzIGUtbWFpbCBvcmln
aW5hdGVkIGZyb20gb3V0c2lkZSBvZiBQaGlsaXBzLCBiZSBjYXJlZnVsIGZvcg0KPiBwaGlzaGlu
Zy4NCj4NCj4NCj4gT24gMjguMDYuMjIgMTA6MDEsIEd1bnRlciBHcmF1IHdyb3RlOg0KPiA+IEZy
b206IEd1bnRlciBHcmF1IDxndW50ZXIuZ3JhdUBwaGlsaXBzLmNvbT4NCj4gPg0KPiA+IFdoZW4g
Y29tcGlsaW5nIEMrKyBwcm9ncmFtcyB3aXRoIGUuZy4gc3RkPWMrKzExIGNvbXBpbGUgc3dpdGNo
IHRoZQ0KPiA+IGNvbXBpbGVyIHJlZnVzZXMgdG8gdW5kZXJzdGFuZCB0eXBlb2Ygc2luY2UgaXQg
aXMgbm90IHBhcnQgb2YgdGhlDQo+ID4gYysrIHN0YW5kYXJkLiBTaW5jZSBYZW5vbWFpIDMuMiB0
aGUgYXRvbWljLmggaGVhZGVyIGlzIHB1bGxlZCB2aWENCj4gPiBkZXBlbmRlbmNpZXMgYWxzbyB3
aGVuIGNvbXBpbGluZyB1c2Vyc3BhY2UgYXBwbGljYXRpb25zLg0KPiA+IFRvIGtlZXAgdGhlIHBv
c3NpYmlsaXR5IHRvIHVzZSBoaWdoZXIgYysrIHN0YW5kYXJkcyB1c2UgX190eXBlb2ZfXw0KPiA+
IGhlcmUgaW5zdGVhZCB3aGljaCBpcyBhbHNvIGFjY2VwdGVkIHRoZXJlLg0KPg0KPiBMb29rcyBn
b29kIHRvIG1lLCBidXQgeW91ciBzaWduZWQtb2ZmIChEZXZlbG9wZXIgQ2VydGlmaWNhdGUgb2Yg
T3JpZ2luKSBpcw0KPiBtaXNzaW5nIGhlcmUuDQo+DQo+IEphbg0KPg0KDQpIaSBKYW4sDQoNClNv
cnJ5IGZvciB0aGlzLiBEZWZpbml0ZWx5IHNob3VsZCBkbyB0aGlzIG1vcmUgb2Z0ZW4gdG8gZ2V0
IHVzZWQgdG8gaXQg8J+YiQ0KDQpUaGFua3MsDQpHdW50ZXINCg0KPiA+IC0tLQ0KPiA+ICBpbmNs
dWRlL2JvaWxlcnBsYXRlL2F0b21pYy5oIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2JvaWxlcnBsYXRlL2F0b21pYy5oDQo+ID4gYi9pbmNsdWRlL2JvaWxlcnBsYXRlL2F0b21pYy5o
IGluZGV4IDczMTk2MWUzYi4uNGVlNWYzOTMwIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvYm9p
bGVycGxhdGUvYXRvbWljLmgNCj4gPiArKysgYi9pbmNsdWRlL2JvaWxlcnBsYXRlL2F0b21pYy5o
DQo+ID4gQEAgLTc4LDcgKzc4LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGF0b21pY19zZXQoYXRv
bWljX3QgKnB0ciwgbG9uZyB2KQ0KPiA+ICAjZGVmaW5lIHNtcF93bWIoKSAgICBkbyB7IH0gd2hp
bGUgKDApDQo+ID4gICNlbmRpZiAvKiAhQ09ORklHX1NNUCAqLw0KPiA+DQo+ID4gLSNkZWZpbmUg
QUNDRVNTX09OQ0UoeCkgKCoodm9sYXRpbGUgdHlwZW9mKHgpICopJih4KSkNCj4gPiArI2RlZmlu
ZSBBQ0NFU1NfT05DRSh4KSAoKih2b2xhdGlsZSBfX3R5cGVvZl9fKHgpICopJih4KSkNCj4gPg0K
PiA+ICAjZGVmaW5lIGNvbXBpbGVyX2JhcnJpZXIoKSAgIF9fYXNtX18gX192b2xhdGlsZV9fKCIi
OiA6IDoibWVtb3J5IikNCj4gPg0KPg0KPiAtLQ0KPiBTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQo+
IENvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQoNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQpUaGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgbWVzc2FnZSBt
YXkgYmUgY29uZmlkZW50aWFsIGFuZCBsZWdhbGx5IHByb3RlY3RlZCB1bmRlciBhcHBsaWNhYmxl
IGxhdy4gVGhlIG1lc3NhZ2UgaXMgaW50ZW5kZWQgc29sZWx5IGZvciB0aGUgYWRkcmVzc2VlKHMp
LiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCB5b3UgYXJlIGhlcmVieSBu
b3RpZmllZCB0aGF0IGFueSB1c2UsIGZvcndhcmRpbmcsIGRpc3NlbWluYXRpb24sIG9yIHJlcHJv
ZHVjdGlvbiBvZiB0aGlzIG1lc3NhZ2UgaXMgc3RyaWN0bHkgcHJvaGliaXRlZCBhbmQgbWF5IGJl
IHVubGF3ZnVsLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ug
Y29udGFjdCB0aGUgc2VuZGVyIGJ5IHJldHVybiBlLW1haWwgYW5kIGRlc3Ryb3kgYWxsIGNvcGll
cyBvZiB0aGUgb3JpZ2luYWwgbWVzc2FnZS4NCg==
