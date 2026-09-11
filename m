Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013038.outbound.protection.outlook.com [40.107.162.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC033F383
	for <xenomai@lists.linux.dev>; Fri, 11 Sep 2026 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135901; cv=fail; b=g4kXE6H0Xk9mzZJzCDg5MkM+IxR5lT7eMim7ZwAYjXpVKfUDUt6I4TawVPpmmvdK1tpjHyyCHKFEQnuMMayrpH9slW8uqZ7wsUsnjApUImHMOa/uBQGzgxccGzIcs/t8zKm4i4nFo2oyqdJ61mxRrRTUV0NOm5vfvK3QGhz8mp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135901; c=relaxed/simple;
	bh=GOKswLCKLXkAj1TJYynJ+P/Vq/UDqrV2yt44NrVlNV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IMsd52Vho8bg3+sKwleDmKuaALdDnrmJuo/tXyiIH2PXFmWbtQjInT1KTHHP4v8/deavE9ERS867ROwMuSB047jlyNTnw9O4qENMyBiItXcsz32mG3zhztHI0sHE6g9ZZz7VVJGhaZvHCMTZMbGeSjNGhyRyNqq0VgNR0Puf+hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KGkqQmUc; arc=fail smtp.client-ip=40.107.162.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KGkqQmUc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHO69d6n8mxICffov/oWKioEo5WqI12LuKvaEjqE4QOMi3it2wu0P5dqMGig7XYekpsQO20dELDxPqEKJ1VeGtIWLFEmV4qxJ7yXt+Flpo5AAaiyQ+jxiuEtu1N2OKDClLTXUjsWuSBbcLNQGbIE48FQfwFxoNi8Yz6aVvJlnZmZ9+Zry2bCRNoF+yBs5CfzX+uoQr/CNGqOXS6HF6ZdyqIz9qrcDsUYheyzMHv5ZVTc/Ekj4e0uUekfwaeFihG5Ph2vM5Se1lurrbbP10wAgXjsmRNNHwHHwGVPnh1qToEMyz2aYd3NOoj0inJdyeRcfG8BaEe1pr0+0jFLc30KLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOKswLCKLXkAj1TJYynJ+P/Vq/UDqrV2yt44NrVlNV0=;
 b=nCMd4gnabmjZ0bmJaVh0pChPn/vvaiK4eAtm/kDRXnkbAWCTcsjNN1/uzKERrCAP4acIS0YFzjohsGaQBEUVwvdNRiXacYPN4qRXluu/9OpBA/tni261VZFCaCf3LRDJHSnBPQ830OWwBUyK/hR9cD2HcX3DSqErffmxVACatwKos7HCYjvk7vtEd3/6PbDLSG6dOkF9jsfIOUsTeGNEM32ZAmCvtNUuHsHFhnlDKgrDPGlkiVV+ynKOWn2NYXmL3GN5KdqPE5n0ApU91LGDTPsOd3uffUYbMcAHIOgjJ8cDxAnvfRN1FzlFFKmGSlydA6cjPcjVf/KGLe01Lmdnpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOKswLCKLXkAj1TJYynJ+P/Vq/UDqrV2yt44NrVlNV0=;
 b=KGkqQmUckBEEsNjXq53da3T15hBqwGmTYBwuhim3vwMl5m658EC4fjZMQ3UhHcps1vnbqFPAodQh5zMK2SoVOczgMmcGnA6G69BiMi13teamf0k3B/dS1U2i1Bb/wJceDe+/DZRx8mCmHGLeNgFeydqRlyH3wI1SwnekgpkUNYX/NzN0Ilmctcn3NecJUbRdzH+Ej5MtgMWQlbm9Ck2xTYSUhqdDkvXyhOLkbbOn9LnomdxrOYEvs1zIilB8d1Lu+Id1o0tF/NLFeL18pIidUV6rgwCV46clNudLdXcsfQ3Pw9r6zABUVQ1/PnZnT0YcaTR/8lYvck+Zk683W3LIYQ==
Received: from DU2PR10MB7766.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49c::5)
 by VI0PR10MB8335.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:238::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 14:11:35 +0000
Received: from DU2PR10MB7766.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aed8:db10:ff00:63db]) by DU2PR10MB7766.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aed8:db10:ff00:63db%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 14:11:34 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "andrew@elk.audio" <andrew@elk.audio>, "rpm@xenomai.org"
	<rpm@xenomai.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>
CC: "ghoogewerf@lmi3d.com" <ghoogewerf@lmi3d.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: Re: [PATCH Dovetail 0/2] Obsolete marking tick IRQs with IRQF_TIMER
Thread-Topic: [PATCH Dovetail 0/2] Obsolete marking tick IRQs with IRQF_TIMER
Thread-Index:
 AQHdQGgfnzIZb1YtT02+R0XN2mh+IrbHxNEAgAACJACAABxRgIABMJgAgABEVICAABMuAIAAArYA
Date: Fri, 11 Sep 2026 14:11:34 +0000
Message-ID: <a2d138b2ec34b403ee83f8e0e1f21dffb0f8233c.camel@siemens.com>
References: <20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com>
		 <CACiVkwnKDck51TD6jC1K9CJoF05X9hd8xRKiskzdAd4dcj7FQg@mail.gmail.com>
		 <e10b288c461075397c67dad4ea3870cab0154239.camel@siemens.com>
		 <CACiVkwmeN=8k=oRyusakE78uVYcz2zKws8ytRecFnL2ah8ySZA@mail.gmail.com>
		 <6b918b0e226a2763352632f78edc4036c1a42de9.camel@siemens.com>
		 <CACiVkwkY2-q2twEkuu+6oOerimz=0BLLEM43fctEG=FYAuxuuw@mail.gmail.com>
	 <39118cc382b8b1e74720c84a660d18330ea7b93a.camel@siemens.com>
In-Reply-To: <39118cc382b8b1e74720c84a660d18330ea7b93a.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR10MB7766:EE_|VI0PR10MB8335:EE_
x-ms-office365-filtering-correlation-id: 7e78e46f-6bd8-4996-4e10-08df100e966d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|23010399003|366016|10067099003|56012099006|11063799006|6133799003|4143699003|55112099003|18002099003|22082099003|38070700021|13003099007;
x-microsoft-antispam-message-info:
 t64rSo1l9Pk4sU8xvy12pM4PuPilJ5p+yXpyvo/Nn23c/p3RR8kSrEXHL8HKHTATfZB2Cv/7B3GZTAkWCnemDZk+2uriZgd2M/LjP8lkhbz0guoqxKB2vUZ7u1c5gjWakT7EzlF9lK4kxeBSILqrJmwkVEx6cEtY2GvbQ69chE75hyAnyTBkUP3Ydt0KbyPBt0Gs5UpeVWYcalGpezv8ZXo9TZ1ernoWJbezh6j8enQNYFl42Ew5V0qOvyncWhfjLU9QJ0RyRXbKgwHyzDOGT4V3QiGN+7UIG4dF207HFQYjQVNoCKp0lGs12/wVm61xqyp+aWjWETpWGyzvAfvJrVtu7VbxqTnAH8MaLE0G5XAK1WrXO/nFrjO+vxMwJyA/zwbgTaGInGIvSoNCcwS0iQH/u5vLpIk/6KMIPDh5R+3k8kRqNbiU57Xd+UHS+aTu1mCAIg7hxsXhDhe3puWAEjjnmHexSBalMC03TurNBLAbSsGasYfKXv7C4weQt+rTwLAStZBSNkzgoWdt3pktjTV0TEZbs7On/CPK/KQKHvFzdgFMKuPsK/ZbjKn6n12nYWGy8GhDc0DsTUW99QVHQkfj8aEq33Yd+nJ0m10kutjBFptdzmuzA5Q+bf4z9wXXR3PH14dcAQEBGm02F8z4UEWnBuHsSVQJXCMVY0sMjaU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR10MB7766.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(6133799003)(4143699003)(55112099003)(18002099003)(22082099003)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VnRNd1o3V0pINHFhaGVhanBxaDZkTHkxMURUQU9XZmZhd3A4ZVZEOWYvQkV3?=
 =?utf-8?B?QjdLRXJ5TkNTWWlVOElzZEJVcVVScTQyRjNpc3lyZU53QzlJeXR0V1ZScHQy?=
 =?utf-8?B?MHYyYmNPZ0h5R05vWHNhWk5HTXIyWHBKOGtOek5DWmFKNUZKLysyOFpYTEFF?=
 =?utf-8?B?ekhyVy8rd2xtS2NkMWpzNjJObEV0TzVwbzJWdWMvbjJ4TWxhbDlTV1FwNWQ4?=
 =?utf-8?B?VnMrSzVPSk1pK2FjVHk3bXR6b1RqenhEaGlHQVBWQk9qQ0kvZ1FqdE4ySzlP?=
 =?utf-8?B?T3lCUGJydXNpaTNmT0Z1SWlnemJHZlRGNUJGclFkSWgrVjk1eGkveCtKL0ZX?=
 =?utf-8?B?dVFWVExHdjh0MWcwL1dsYjdtUjhJM3BobXdFcS8wMEZ0YTdRaHBSQjFMUG11?=
 =?utf-8?B?K0FWTFY5L2ZhZWh6ODB2clhnSFE1S2dodWFaSld6dEFiNkZIVGxmSUk1bHpO?=
 =?utf-8?B?QkMvR0F4VmlkK2V5R1FJamE2TXRMbUpZQnY5dmd3Y0ZFOGNDUWR1aGNNRG1E?=
 =?utf-8?B?QlUzbWpFblMvR1ViUnJlOEdhTGdhTW1SMG03OTBkbTI3WVBIcExmbUdYV0Fz?=
 =?utf-8?B?U0RuY0FBb2VlOGZBVE5obDkwSjQ5TzZOV3JIQkxLM2JWa00zM2I4Y2xtMzgx?=
 =?utf-8?B?Q0RobXBiaVU4dXNjamVHNzFwS2kwM1N0UnVtOU12b0JEM0Y3OHFQeGQvS2V4?=
 =?utf-8?B?UnphOGJIQ0ZVL21JdDBoemgrZHR4OEIzMTdhWnF3bUNkS0J6dEZRbnZhZnd4?=
 =?utf-8?B?eEpHWUR6Y2l3Q29zS1JQNC8vT2ozMWhyR1ZINm95eUdabXJIdkVsVk1PejB0?=
 =?utf-8?B?bXUxZkptUjk1RlBQU0swcEZOclR2ajB5b0x1NjIrczhMcXJMWUtFMlByWmdl?=
 =?utf-8?B?Q1hWbjRPK2lqbVVmNGEzMWVyTmpweFMyNC8xejdMRnl1a3R5eEQzRTkxN2FW?=
 =?utf-8?B?RXd1Q253ZjdGSUtFclI0ZDVwaUEvZlhxZFhNUnNCeWtEV3JtVkR6N0I3QVFP?=
 =?utf-8?B?MVFnUTU2bjhwdmtFUTNKcEFETTFNOEdVM1hIZ09oQnJYS3F0MWxiQVhvZ1FX?=
 =?utf-8?B?Z2JGNy83ODFTbGVJK1pRbHBYYklOS1RXTlBCREVUSHJQcnpJVThOV0RQMGdY?=
 =?utf-8?B?NUkyL2lxNnAySkdrdkEza2E5UGtnVmc5QytuWXJEOVBtRHAvbWxrTU9UN1lU?=
 =?utf-8?B?bFlHYWEwMm16WkQrTUREQmtqTXdkbHZhNmN6UXRtdWZ1TC9veEtWa05uREFY?=
 =?utf-8?B?YnpYeFg3S09yZ2licHBQZ0lBSEdSaUgwSkpGKzJ1eFcwSitETGdMMCt3bjV2?=
 =?utf-8?B?a1VhUGE4eXJSSUdpT0VlQWJIdWFiMEVIMWI0MElMbk5tZE9NckNBZXhKNjZj?=
 =?utf-8?B?ZkpLd1ExWXNvSUYzVm5yWnFLYmd2SWE5VHVMcnZ4MURETUFtYXI0QnZuTis4?=
 =?utf-8?B?SDJHZjJaSHMzS2NFM3JMQ3cxM3FKeGxJak1qSFBaalJHZ0JnSU1rbmZVa3hz?=
 =?utf-8?B?a25xUXRmbS9jc3ZjU1gwWDhFdmZjNWwxOU9KOUZQcDBXcHNIUFQ4T1ljcXc2?=
 =?utf-8?B?eTQzdTUyTGt1Z0M0ZUxGb0RobGJaUlhscFVTNTRNZ0U5d1lweHlqSFQyNmRN?=
 =?utf-8?B?VG84VXY4OEx2QzZUQnhuVmRLQmY0TXBlS0pJdm9qTHc4ZGwxbk9RQ2w3WmRq?=
 =?utf-8?B?TzVOR2NXRWdwbDJ6NnZhMDJHVTBSWitweUxWWEtYWi9vN1pPR2ZRMWhTc2JG?=
 =?utf-8?B?TWlGeDg2eklOVUp4Nkl1b09GcUxCdjdEclFreUdmYzM3VlA5S3dORUduSnFU?=
 =?utf-8?B?ZkVwcldkSk1jVjA4Y21YYVgrVi8rSTV6S0hRM1NvSDc3WFY3NEJZTG9BcUdx?=
 =?utf-8?B?aDMzb0NKNEtadlhzN2RGaG5FL2lIZUNxN0czQ0FldnpSc3lvS1RHQnZKdWZx?=
 =?utf-8?B?OU9BK0JnbzBhZTRsWml2aW43RVpuY1JzMHR0aENMb1pGUXRENm1kclhHek1v?=
 =?utf-8?B?aFNBRWQ4UG1MZ0dXVkJDelJuU0RHcGluWFNvb2EyK1ZPdmxjTXg4c1FSRlg1?=
 =?utf-8?B?a3cyckNsb1lVWGw0SWJ5eHZJQS9YczBhUXB2OVJLSXJDK0NpWDBtMU5hRTgz?=
 =?utf-8?B?SWlrWXFBc3ZZYm1XY1FuZFprQ0FOSkY0VmdHd0FuNS80QUZyMCtXZUZkcWVw?=
 =?utf-8?B?R3NxdURsT0Z3ejRQZEtuYzJMNnR1ZWJ5QTIrTHNlNHljb0ZDKytjZG1FakJG?=
 =?utf-8?B?bnhDME5HWVJDdWZ0OHNBcFQwRlJCMVdOMG9KWTNBclV4Y2RjaEU0SG5qd1N0?=
 =?utf-8?B?K3p1bFhDSGNBSVpZb3I2MXhyL3VSZmlmNVhXc1lFbjZaNVhEV2RzUlVyTGNF?=
 =?utf-8?Q?Su2L/LFGDz7MtZaYWuVl1nVZVUTieewoLwMmYWz9KL1hO?=
x-ms-exchange-antispam-messagedata-1: mtGJj9liuBxVlXELiqqQLM9lL4HPdrz3GbU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80AE48D96535024AB14E02A3BAF92317@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR10MB7766.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e78e46f-6bd8-4996-4e10-08df100e966d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 14:11:34.8592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBHGgSTI4NZqkMG34xxz11LcRElEMgZwhbD9EXRBhc704+Rm4vcmOVBzEnvdY980Q3Bhr/w8wtDK2B0Fl3Tj+6MW7EBvfmuorOJcmYaUHGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8335

T24gRnJpLCAyMDI2LTA5LTExIGF0IDE2OjAxICswMjAwLCBGbG9yaWFuIEJlemRla2Egd3JvdGU6
DQo+IE9uIEZyaSwgMjAyNi0wOS0xMSBhdCAxNDo1MyArMDIwMCwgQW5kcmV3IE1hY1BoZXJzb24g
d3JvdGU6DQo+ID4gT24gRnJpLCAxMSBTZXB0IDIwMjYgYXQgMTA6NDgsIEZsb3JpYW4gQmV6ZGVr
YQ0KPiA+IDxmbG9yaWFuLmJlemRla2FAc2llbWVucy5jb20+IHdyb3RlOg0KPiA+ID4gDQo+ID4g
PiBPbiBUaHUsIDIwMjYtMDktMTAgYXQgMTY6MzggKzAyMDAsIEFuZHJldyBNYWNQaGVyc29uIHdy
b3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gPiBrZXJuZWwgQlVHIGF0IGtlcm5lbC9pcnFfd29yay5j
OjI0NSENCj4gPiA+ID4gPiBJbnRlcm5hbCBlcnJvcjogT29wcyAtIEJVRzogMCBbIzFdIFBSRUVN
UFQgU01QIEFSTQ0KPiA+ID4gPiA+IENQVTogMCBQSUQ6IDUyMCBDb21tOiBYWFhYWFggVGFpbnRl
ZDogRyAgICAgICAgICAgTyAgICAgICA2LjYuNDggIzQNCj4gPiA+ID4gPiBQQyBpcyBhdCBpcnFf
d29ya19ydW5fbGlzdCsweDE0LzB4NjQNCj4gPiA+ID4gPiBMUiBpcyBhdCBpcnFfd29ya19ydW5f
bGlzdCsweGMvMHg2NA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiAgaXJxX3dvcmtfcnVuX2xp
c3QgZnJvbSBpcnFfd29ya19ydW4rMHgyOC8weDNjDQo+ID4gPiA+ID4gPiAgaXJxX3dvcmtfcnVu
IGZyb20gYXJtdjdwbXVfaGFuZGxlX2lycSsweDE0OC8weDE1MA0KPiA+ID4gPiA+ID4gIGFybXY3
cG11X2hhbmRsZV9pcnEgZnJvbSBhcm1wbXVfZGlzcGF0Y2hfaXJxKzB4MjgvMHg4MA0KPiA+ID4g
PiA+ID4gIGFybXBtdV9kaXNwYXRjaF9pcnEgZnJvbSBfX2hhbmRsZV9pcnFfZXZlbnRfcGVyY3B1
KzB4NjgvMHgyMjQNCj4gPiA+ID4gPiA+ICBfX2hhbmRsZV9pcnFfZXZlbnRfcGVyY3B1IGZyb20g
aGFuZGxlX2lycV9ldmVudCsweDU4LzB4ZjgNCj4gPiA+ID4gPiA+ICBoYW5kbGVfaXJxX2V2ZW50
IGZyb20gaGFuZGxlX2Zhc3Rlb2lfaXJxKzB4MTU0LzB4MmY0DQo+ID4gPiA+ID4gPiAgaGFuZGxl
X2Zhc3Rlb2lfaXJxIGZyb20gaGFuZGxlX2lycV9kZXNjKzB4MjAvMHgzMA0KPiA+ID4gPiA+ID4g
IGhhbmRsZV9pcnFfZGVzYyBmcm9tIGFyY2hfZG9fSVJRX3BpcGVsaW5lZCsweDU4LzB4OTANCj4g
PiA+ID4gPiA+ICBhcmNoX2RvX0lSUV9waXBlbGluZWQgZnJvbSBzeW5jX2N1cnJlbnRfaXJxX3N0
YWdlKzB4YWMvMHhlMA0KPiA+ID4gPiA+ID4gIHN5bmNfY3VycmVudF9pcnFfc3RhZ2UgZnJvbSBo
YW5kbGVfaXJxX3BpcGVsaW5lZF9maW5pc2grMHhhMC8weDE5OA0KPiA+ID4gPiA+ID4gIGhhbmRs
ZV9pcnFfcGlwZWxpbmVkX2ZpbmlzaCBmcm9tIF9faXJxX3VzcisweDYwLzB4ODANCj4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IEZhdGFsIGV4Y2Vw
dGlvbiBpbiBpbnRlcnJ1cHQNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiANCj4g
PiA+IEkgY2FuJ3QgcmVwcm9kdWNlIHRoYXQgb25lIGhlcmUuIE5vdCBvbiA3LjIgbm9yIG9uIDYu
Ni40OS4NCj4gPiA+IE1pZ2h0IGJlIHRoYXQgdGhpcyBpcyBkZXBlbmRpbmcgb24NCj4gPiA+ICAg
LSB5b3VyIHdvcmtsb2FkIChpcnEgd29yaykNCj4gPiA+ICAgLSBrZXJuZWwgY29uZmlndXJhdGlv
bg0KPiA+ID4gICAtIHhlbm9tYWkgdmVyc2lvbiAod2hpY2ggb25lIGRvIHlvdSB1c2U/KQ0KPiA+
ID4gICAtIHFlbXUgdnMuIHJlYWwgaHcNCj4gPiA+IA0KPiA+ID4gSSdtIHF1aXRlIHN1cmUgdGhh
dCB0aGlzIGlzIGEgZGlmZmVyZW50IGlzc3VlIGFzIHdlIGhpdCBhIEJVRygpIGluDQo+ID4gPiBp
cnFfd29ya19ydW5fbGlzdCgpOg0KPiA+ID4gDQo+ID4gPiAgICAgICAgIEJVR19PTighaXJxc19k
aXNhYmxlZCgpICYmICFJU19FTkFCTEVEKENPTkZJR19QUkVFTVBUX1JUKSk7DQo+ID4gPiANCj4g
PiA+IE9uIGZpcnN0IGdsYW5jZSB0aGF0IGxvb2tzIGxpa2UgYSBjb3JydXB0aW9uIG9mIHRoZSB2
aXJ0dWFsIGludGVycnVwdA0KPiA+ID4gc3RhdGUuIEFuIGlycV93b3JrIGV2ZW50IHdhcyB3YWl0
aW5nIGluIHRoZSBJUlEgbG9nIGFuZCBnb3QgYXBwbGllZCB3aXRoDQo+ID4gPiBhIHdyb25nIGlu
YmFuZCBJUlEgc3RhdGUuDQo+ID4gPiANCj4gPiA+IExhc3QgdGltZSB3ZSBmb3VuZCBpc3N1ZXMg
b24gYXJtIHdhcyBwcm9iYWJseSBbMV0uIFNlZW1zIHRoYXQgdGhpcw0KPiA+ID4gc2VyaWVzIHdh
cyBub3QgYmFja3BvcnRlZCAoeWV0KS4gWzFdIGdvdCBtZXJnZWQgaW50byA3LjEuIE1heWJlIHlv
dSBjYW4NCj4gPiA+IGdpdmUgaXQgYSB0cnkuIEkgZG9uJ3QgaGF2ZSBmdXRoZXIgaWRlYXMgYXQg
dGhlIG1vbWVudC4NCj4gPiA+IA0KPiA+ID4gQmVzdCByZWdhcmRzLA0KPiA+ID4gRmxvcmlhbg0K
PiA+ID4gDQo+ID4gPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcveGVub21haS84N2lrNnF2
cWNrLmZzZkB4ZW5vbWFpLm9yZy9ULyNtMzE3MDFhYjk0MjA2NTc0Yzk2Y2MyZDJiMjRkNzdkOTc5
MzM1OTg5Mg0KPiA+IA0KPiA+IEkgdHJpZWQgYmFja3BvcnRpbmcgdGhlIHBhdGNoZXMgZnJvbSBb
MV0gYW5kIHRoZXkgZG8gaW4gZmFjdCByZXNvbHZlDQo+ID4gdGhlIGNyYXNoISBOYXJyb3dpbmcg
aXQgZG93biBzb21ld2hhdCBpdCBzZWVtcyB0aGF0IHNwZWNpZmljYWxseQ0KPiA+IHBhdGNoZXMg
NSs2IHRvZ2V0aGVyIGFyZSBlbm91Z2ggdG8gZG8gaXQsIGlmIEkgb25seSBhcHBseSB0aG9zZSBh
bmQNCj4gPiBza2lwIHRoZSByZXN0IHRoZSBjcmFzaCBpcyBzdGlsbCByZXNvbHZlZC4gV2l0aCB0
aGVzZSBwYXRjaGVzIHBsdXMgdGhlDQo+ID4gZWFybGllciBvbmUgSSBub3cgZ2V0IGNsZWFuIHJl
c3VsdHMgZnJvbSBhIHBlcmYgY2FsbGdyYXBoIHJ1bi4NCj4gPiANCj4gPiBBbiBMTE0ncyBzdGF0
aWMgYW5hbHlzaXMgb2YgdGhlIGlzc3VlIGlzOiBkb19wYWdlX2ZhdWx0KCkgY2hlY2tlZCB0aGUN
Cj4gPiByYXcgaGFyZHdhcmUgSVJRIGZsYWcgaW5zdGVhZCBvZiB0aGUgY29ycmVjdCBpbi1iYW5k
LXN0YWxsIHN0YXRlDQo+ID4gYmVmb3JlIHJlLWVuYWJsaW5nIGludGVycnVwdHMgLSBhbmQgcGFn
ZSBmYXVsdHMgYXJlIGZyZXF1ZW50IGVub3VnaA0KPiA+IChyb3V0aW5lIG1lbW9yeSBhY2Nlc3Mp
IHRoYXQgdGhpcyB3cm9uZyBjaGVjayBmaXJlZCBjb25zdGFudGx5LiBTaW5jZQ0KPiA+IHJlYWwg
aGFyZHdhcmUgSVJRcyBhcmUgZGVsaWJlcmF0ZWx5IGxlZnQgb24gZHVyaW5nIERvdmV0YWlsJ3Mg
aW4tYmFuZA0KPiA+IElSUSByZXBsYXksIGFuZCB0aGUgc3RhbGwgYml0IHRoYXQgZ3VhcmRzIGFn
YWluc3QgcmVlbnRyYW5jeSBpcyBhDQo+ID4gc2luZ2xlIHVuLWNvdW50ZWQgZmxhZywgdGhhdCB3
cm9uZyBlYXJseSBsb2NhbF9pcnFfZW5hYmxlKCkgY2FsbA0KPiA+IG9wZW5lZCBhIHdpbmRvdyBm
b3IgYSBnZW51aW5lbHkgbmVzdGVkIGludGVycnVwdCB0byBjb3JydXB0IHRoZQ0KPiA+IHN0YWxs
L2hhcmRpcnEgYm9va2tlZXBpbmcgdGhhdCBpcnFfd29ya19ydW5fbGlzdCgpJ3MgYXNzZXJ0aW9u
IGRlcGVuZHMNCj4gPiBvbi4NCj4gPiANCj4gPiBUaGFua3MgYWdhaW4gZm9yIHRoZSBoZWxwIHRy
YWNraW5nIHRoaXMgZG93biENCj4gDQo+IFRoYW5rcyBmb3IgdGVzdGluZyBhbmQgcmVwb3J0aW5n
IGJhY2suIEhpZ2hseSBhcHByZWNpYXRlZCENCj4gDQo+IFNvIGxldCBtZSBpbmZvcm0gInN0YWJs
ZSIgbWFpbnRhaW5lcnMgdGhhdCBbMV0gZml4ZXMgYSByZWFsIHByb2JsZW0uIEkNCj4gd2FzIGp1
c3QgcmV2aWV3aW5nIHBhcnRzIG9mIHRoZSBhcm0gcGlwZWxpbmUgaW1wbGVtZW50YXRpb24gYmFj
ayB0aGVuDQo+IGFuZCByZWFsaXplZCB0aGF0IHRoZXJlIGFyZSBwb3RlbnRpYWwgcHJvYmxlbXMu
IE5vdyB0aGV5IGdvdCByZWFsIDstKQ0KPiANCj4gQEphbiwgUGhpbGlwcGU6DQo+IENvdWxkIHlv
dSBwbGVhc2UgdGFrZSBjYXJlIG9mIFsxXSBiZWluZyBhcHBsaWVkIGludG8gb2xkZXIsIGJ1dCBz
dGlsbA0KPiBtYWludGFpbmVkIGJyYW5jaGVzLiBUaGFua3MhIA0KPiANCj4gVGhpcyBzZXJpZXMg
d291bGQgYWxzbyBiZSBuZWVkZWQgdG8gZml4IHNvbWUgcGVyZiBwcm9ibGVtcyBvbiBhcm0vYXJt
NjQuDQo+IEJ1dCBsZXQncyB3YWl0IGZvciBzb21lIG1vcmUgZmVlZGJhY2sgZmlyc3QuDQoNCkZv
cmdvdCBvbmUgZW5kOiBBZGRpdGlvbmFsbHkgd2UgbmVlZA0KDQo1OGU4ZTBmNzRjMmIgKCJBUk06
IGlycV9waXBlbGluZTogc2F2ZSByZWdpc3RlcnMgdXNlZCBmb3Igd2Fsa2luZyB0aWNrIGZyYW1l
cyIpDQoNCnRvIGZpeCB0aGUgcGVyZiBpc3N1ZXMuIENvdWxkbid0IGZpbmQgaXQgb24gdGhlIGxp
c3QuIFNlZW1zIGl0IHNuZWFrZWQNCmluIHNpbGVudGx5IDstKQ0KDQo+IA0KPiBbMV0gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcveGVub21haS84N2lrNnF2cWNrLmZzZkB4ZW5vbWFpLm9yZy9ULyNt
MzE3MDFhYjk0MjA2NTc0Yzk2Y2MyZDJiMjRkNzdkOTc5MzM1OTg5Mg0K
