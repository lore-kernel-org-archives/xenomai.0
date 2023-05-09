Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2078.outbound.protection.outlook.com [40.107.103.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94672154AC
	for <xenomai@lists.linux.dev>; Tue,  9 May 2023 12:03:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoFdumBn4+LbSwDE8eGTI9Ukm6zV8PFhDVCE3xZgi0+0V/bMHGaksddsCfxLdOCNQDlsooirwqpH86/0yUlqCPNFHRAkICQ7QQ6Td+R9WeDkmgD4SrJBxqC3NC2OBtFlmZA78+gfi+aqhl5BHNSJ5RLlV7kuQ4HFyFZPmC5WsUOEkkPUgz8hqHCijXtHPWaFRjVp9AG9Iw6nj7/uvS5FRYYEsD+NhygCfKijpvAzsXXXR9yXuOnMoffVGR2AlViMn6HY6aSuN5ehnvUyE6JkOnJqs915gZ4zrZMginqBGo9PqXRlzXyK5vWgoGUbNC7frPdPwMrOBoNLVaZKNY8m5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqPzn20d01xRPH8KaMpmOc2D1UVAuHOSuFdvVjdAuWw=;
 b=NxJzbcOo7QnaZmnk8c/aTjexIXtmmkQT4ou73jXhBGg0Qb1UxMZtyRw2shXi1LmCcBJAefCwSmX0feeGbbBBlCD8i+hYxRY2vd+N0/59GbKd62J4Z9KXUTFMsR1Pjw32bc8wdHSPVRfAQBM7t433KDQIvCSKI4Ktcn1Efrm4Q4oWkf0hm5SCm/7cPjVJVS0xZubE+Hf0KMUc5U//g0szdU52oFQHmZtzyTr0s4hEMnXY2ANV19B5JXP6UKNPBbKdjmHhRxFQsGMBNnayOKOOuiUoE4UPA7YnuwK1NoLqCBq0yGmc1WsqwK5iPcSFFhJOgmVAhWssUr94g4/peAlubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqPzn20d01xRPH8KaMpmOc2D1UVAuHOSuFdvVjdAuWw=;
 b=X+JvoySWHb041QTTNNf3nw7W6dADtgLDkxiDAqNvu6Yy2MciYkbwivVr4xMkNGmYu9SqgIiz3zSAPHMeyL0sGXUQjR0IwHe7Lr3+T5GbG/9F+uS7qu5U2A8IL0aHYUOqJZHsFeGoF8Tn2tHHDmhXFrJ73wjHW8raJnJOhGgjewXPZfHb65lvfR6BW8z1H8St67tZZ9GQhlX+gpSti38jDnC/CgK0E1B2LNTBLQq+/mqUm3O/R5pwa+mi+gQ0aZhU8s2OxATu7VVVIA/P24qQE3tmNO5GYUkQmnAvsiYyg6g6DoGfsYVjZwJk6Zv9zBdbTIc4gkNZ9zzx2p9TLHpX7g==
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DB8PR10MB3131.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 12:03:32 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::19f4:4131:d2ed:d5fe]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::19f4:4131:d2ed:d5fe%4]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 12:03:32 +0000
From: "Schaffner, Tobias" <tobias.schaffner@siemens.com>
To: Felix Frey <frey@stettbacher.ch>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: Re: Some newbie questions
Thread-Topic: Some newbie questions
Thread-Index: AQHZgbvgHUknGx75k0+HG0IAMHiwtq9R2RQA
Date: Tue, 9 May 2023 12:03:32 +0000
Message-ID: <cb471327-dba6-0b4e-de3a-0fb3d25e558b@siemens.com>
References: <214d5fea-6991-44f9-d858-8034687dba8a@stettbacher.ch>
In-Reply-To: <214d5fea-6991-44f9-d858-8034687dba8a@stettbacher.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB6349:EE_|DB8PR10MB3131:EE_
x-ms-office365-filtering-correlation-id: 155ad6be-f40a-4e68-baca-08db5085690e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 grKoCncs6bMVJ8r5/LrdSigQLPbfPiICAyU/dBrf+4hZEbViuakM8jv8QWGKHwJJLQgNTrGLh3oOdOs5PhySAAViJoqbDGjgYLCb/LG9PtWwBn61P3hK0GSNky+liBvmj/ON35eUwsibYRlSJdryuoX70k2QtSXcqfa2ceYubavoQguLlFfE+XonMEHLhZozr6zKr3PE8GQdXHi9GbdZ5E79pTD/nh60oVNgIe88zETD/Afi9xvd6n+KcjHBKcO5yJl4dq4Aw5eXqV4rO8kgp+Pu2XDHlWQsg+Keu55cwQgoxRookmTGPqN1U/CJF6htoyjg8zdzM5jpxIxEzPe8WoFJRsvtG0NZIe3MFipgGkwuT1x5Puhfp+wEEY+Kcg4vpdNfWzen7SOrS8XVog06N1i+vFPKW1lMW5h4VbT3MAj02laNBFrkYCEsTPXKnLeLTtncuCHaWKyZGAo5FpHhH4t1OfKut6pFPpxSBWxcveGWioHJ9tEXsfBf7wojUDJb89MSeuXINozhwVtknPp/NDmXPrfIxJcSkPtO7xsDZtVR+CRalzswVizAz0Uin6b1l/kZ8f3bkugW7h9JpsCHepBDEkg6s5PN13fkTGtWmn7NXbv3bD/9i2XdgOalLzpAv5/T8a0HJ8JFbeJ+LeKgaUrA1fdJxQYEJGm77fPW940=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(91956017)(3480700007)(76116006)(966005)(6486002)(478600001)(71200400001)(2616005)(6512007)(6506007)(53546011)(110136005)(186003)(2906002)(36756003)(5660300002)(38100700002)(122000001)(66476007)(66946007)(64756008)(66556008)(41300700001)(66446008)(82960400001)(8936002)(8676002)(316002)(38070700005)(86362001)(31696002)(7116003)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXVMdWx6bVh2MkN2ZEYwOGhHTjZVZGNaOFp3WUg2YVVtcFBaSFhVbjNaYUtE?=
 =?utf-8?B?b2lsWEYxL0hMUlhmblhuY0ZQWDNVT3hQWFZuMGsrRHNLVjEyRDZKTTVPN3o3?=
 =?utf-8?B?RmZIWGJuaE1vQW5MNGJtc0daM3VYVTVsc2M5b2kybHhxUm4vak1oUjBraTBH?=
 =?utf-8?B?S050M2pPa09Hc3FQVGpleUdzYVBLNkV0WmZ0NEtLSmI4RkRnVXgzNk9SeWpW?=
 =?utf-8?B?TXdXeVhoUEtaMGxBbUh5TWpieU9mVTh4Z3k2TXhWb0kyQnlKTmw0NURsamJa?=
 =?utf-8?B?TVJpMWk3VFJpd0xEcW0zZG5MUnNOVUhrSlduNktuZG5GRHQvbG5DOE51SC9o?=
 =?utf-8?B?cnF5b0lvN3lZWUFZL0k4V1JKWjlWYzdzT01qaExqWjRFVkJlNEIwUUdBUWNo?=
 =?utf-8?B?TWxGMnRYcS91cW1KOUdNbk1xUjJaYXU5L016MzJnbGtPdTlJOHRrKzNKTlds?=
 =?utf-8?B?b0tIbndtMS90R0ljZXRSS3BNYkVRL25uY1lmTTBYd25qWlZMZEdnNWZ5bTdq?=
 =?utf-8?B?K3k2Rk54cUxKb2o2blUwbkFpWjFSMW44elFXbjlTcUFUT096L0c1NU1SM3dm?=
 =?utf-8?B?OXdnQkJPSjU1cGw0eTB3RWl6Sk5SbmxpRmMrakNlQnNNSmw5Wmh0VzR4Z0dm?=
 =?utf-8?B?TlFSZDVRTjJCeEFpTUk5dmRuRlVQM0piYkhMWjk0emhIUWdhYTRzSjZsbVB6?=
 =?utf-8?B?TGt6TkZCUG5yeHQ3dFlYZzVKSnNISWI1QlpuQ0xmRDNCOXV0NXBSUmlJS3kr?=
 =?utf-8?B?UUpFNjBZcnNXT0hHSkdRbTZMZ1k4YTZONnZBNzVZR3NiSG9XRjRLQVJSb0ow?=
 =?utf-8?B?dm9uNVg4M28rdzVkZWVPZlZxVW5SYzdMWGkxZXhlOWpSZGd2NDFFdnVINWxX?=
 =?utf-8?B?S0JydGIwOWVEQnRYR1VpcmZ2bDB6L1Bxb2tyR1FNTGM2TFFvUGtVb2p4a3lw?=
 =?utf-8?B?WHdZd0h1QnJTelpVaFV6U0tGMng4Zi9Dai9TbWlFK3RlZmRETFByVElyK1do?=
 =?utf-8?B?RzFaYmlqcHRYaFVwUzdNRUJmUVljWUNEajFZYkw5MWFzZFJhUWtlSHc4ZVcz?=
 =?utf-8?B?Y3paKzErYmE3bzAwUVMzYm9pMmhON3FXbUc3dWFKVFdBOWNlYlFSWW5ibmpE?=
 =?utf-8?B?VGRadlc4bGdUbFdJNzBld2Q2c1Z0MFVzWUdRaHAyL056QjVZc2QydzFYYTNF?=
 =?utf-8?B?VE5Ma0V5bnhGck5IT0tMcnVYZDNmUWlDQzdaRGppUkdrbTVhWi83Rm1JUFFP?=
 =?utf-8?B?KzY4RXp2YXBpcDJaNDdXOVBabERFNERLYXgwTnRhaTdMcFFQdGR1Y0JkYy9a?=
 =?utf-8?B?V3ZkNEZXbEgyLzZvdk0xcTduSkN0VExwTUMxUmlZYWtpMWdxSDdCUFNWR3NZ?=
 =?utf-8?B?WDh3emthOFRIZ3dMdzBhVXdOaFMyZ0lzRFozR2NCVXY0VjJKWk1WY1BaNnVO?=
 =?utf-8?B?VHBSM29jQW0rL3pPSkFRN094UXlyVzJ2clNiZ010ZTFIM2lQZWkyWjNFZDNZ?=
 =?utf-8?B?OTRrR1ZPQXhjbGUrSFN3YlRrenJ5QVJHajBmM2RIYXlGZ1BnL2NhZHdjVXBt?=
 =?utf-8?B?YlhuU1B3eGNicHl2Mmlpc0JaOGd3cXRwVHJyaDE4YzZscjhYcmswWjRxanBx?=
 =?utf-8?B?Z3NnSGJtNTlXb214NmRtWTV5OXZzS2hzUUpqL2lzWGo3aDVXNWgvMVVwRXVk?=
 =?utf-8?B?Ymxlcm9tQ3VJbTNPU25QYllNOXVaa1BNMVBoaGlOaUxkNmw0cUxPOFJEQTFm?=
 =?utf-8?B?UnRNWm5SZEhqd0dYblBVWkxmZXcrRStNWjF1MFF2b05QS3lmQVFCR2doRHpW?=
 =?utf-8?B?Q1M1RTNMSGw3L3BESm5TVzBpbkI2TUpJUlZ5MUdWa1MwUzRTenFhZnpHODdP?=
 =?utf-8?B?YzFRZTdXaTd1bXM4MHk3Sy9wczVUN3k1MW0wQnhncjUzK0xBMlZ3U1JjK1Vy?=
 =?utf-8?B?RVg0M3NvYzFJZmg5N2NvM0wzOW85SVk0dXZYRlpLcC9QT1BVcFRTVjNNSUFT?=
 =?utf-8?B?ZHRpc09TZVNDcnE3S3hERkJWTUhrREplRUJuZkxSMmtJVERHR3BncW9ONGJi?=
 =?utf-8?B?bmJIaTJGRlkzTmtHNHlhRjMxejhoOU13SkIrT1Z3cE5ldGVsOG1NbnBqSXV3?=
 =?utf-8?B?KzFKUVVpaUJmR1YxQ21aUHdWWEFwdmIwSXltZE8wa3VvSldJekYrZFJlcTRv?=
 =?utf-8?Q?dcDV6QDCvcABOmebzpdNmplqBUiredAAXuxeRsDsoOG2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF7484A26ABB3047A57C9E44CFB86A97@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 155ad6be-f40a-4e68-baca-08db5085690e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 12:03:32.6023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D3VQ2pD0rF+hvxxXbz5vzfa/KmAIPZHsjtPXps9derYOmLYuR4HDJwEyPIQZVvIcLul1WkejnnpApfFQoa7dzH5JfjUfJvKtMQAUm+lkSls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3131

SGkgRmVsaXgsDQoNCk9uIDA4LjA1LjIzIDE2OjQ2LCBGZWxpeCBGcmV5IHdyb3RlOg0KID4gSGkg
ZXZlcnlib2R5DQogPg0KID4gSSdtIG5ldyB0byBYZW5vbWFpLCBob3dldmVyIEknbSBmYW1pbGlh
ciB3aXRoIFJUQUkgYW5kIHRoZSBkdWFsIGtlcm5lbA0KID4gY29uY2VwdCBhbmQNCiA+IHJlYWx0
aW1lIGRlc2lnbnMgaW4gZ2VuZXJhbC4NCiA+IE5vdyBJJ20gZmFjaW5nIHRoZSBjaGFsbGVuZ2Ug
b2YgcG9ydGluZyBhbiBhcHBsaWNhdGlvbiBhbmQgYSBkcml2ZXIgZnJvbQ0KID4gUlRBSSB0byBY
ZW5vbWFpLg0KID4NCiA+IEZpcnN0IG9mIGFsbCwgd2hhdCB3b3VsZCBiZSB0aGUgcmVjb21tZW5k
ZWQgdmVyc2lvbiBvZiBYZW5vbWFpIHRvIHVzZTogMw0KID4gb3IgNCAoRVZMKSA/DQogPiBGb3Ig
bm93LCBJJ20gbm90IGJvdW5kIHRvIGFueSBhcHBsaWNhdGlvbiBpbnRlcmZhY2UuDQoNCkkgZ290
IHNvbWUgZmVlZGJhY2sgdGhhdCBYZW5vbWFpIDQgaXMgaW4gYSBmdW5jdGlvbmFsIHN0YXRlIGJ1
dCBhdCB0aGUgDQp0aW1lIHdyaXRpbmcgSSBkbyBub3QgaGF2ZSBtdWNoIGV4cGVyaWVuY2Ugd2l0
aCBpdC4NCklmIHlvdSBhcmUgc3RhcnRpbmcgZnJvbSBzY3JhdGNoIGl0IHdvdWxkIGJlIGdyZWF0
IGlmIHlvdSB0cnkgaXQgYW5kIA0KcHJvdmlkZSBmZWVkYmFjayBvbiB0aGUgbWFpbGluZyBsaXN0
LiBJIHdpbGwgdHJ5IHRvIHByb3ZpZGUgaGVscCB3aGVyZSANCm5lZWRlZC4NCg0KID4gVGhlcmUg
c2VlbSB0byBiZSBzZXZlcmFsIGRpZmZlcmVudCBhcHBsaWNhdGlvbiBpbnRlcmZhY2VzIChza2lu
cz8pLiBPaywNCiA+IHdoZW4gSSBnbyB3aXRoDQogPiBFVkwgdGhhbiBpdCdzIGdpdmVuIGJ5IHRo
ZSBsaWJldmwuIE90aGVyd2lzZSB3aGF0IHdvdWxkIGJlIHRoZQ0KID4gcmVjb21tZW5kZWQgaW50
ZXJmYWNlPw0KDQpGb3IgWGVub21haSAzIHlvdSBjYW4gdXNlIHRoZSBza2luIHRoYXQgZml0cyBi
ZXN0IGZvciB5b3UuIElmIHlvdSB3YW50IA0KdG8gcG9ydCBhIHBvc2l4IGJhc2VkIGFwcGxpY2F0
aW9uIHRoZSBwb3NpeCBza2luIG1pZ2h0IGJlIGJlc3QgZm9yIHlvdS4gDQpPdGhlcndpc2UgeW91
IGNhbiBzdGljayB0byB0aGUgWGVub21haSBBUEkuDQoNClhlbm9tYWkgNCBkb2VzIG5vdCBwcm92
aWRlIHRoZSBza2lucyBhbnltb3JlLiBZb3Ugd2lsbCBoYXZlIHRvIHVzZSBsaWJldmwuDQoNCiA+
IEkgbmVlZCB0byBpbXBsZW1lbnQgYSBkcml2ZXIgd2hpY2ggaGFuZGxlcyBhIHJlYWx0aW1lIGlu
dGVycnVwdCBhbmQNCiA+IHJlc3VtZXMgYSB1c2Vyc3BhY2UNCiA+IHJ0LXRocmVhZCB3aGVuIHRo
ZSBpbnRlcnJ1cHQgYXJyaXZlcy4gV2hhdCB3b3VsZCBiZSB0aGUgc3RyYWlnaHQgZm9yd2FyZA0K
ID4gd2F5IHRvIGltcGxlbWVudCB0aGlzPw0KDQpXaGVuIHVzaW5nIFhlbm9tYWkgMyB5b3Ugd2ls
bCBoYXZlIHRvIHVzZSB0aGUgUlRETSBpbnRlcmZhY2UgdG8gY3JlYXRlIGEgDQpyZWFsdGltZSBk
cml2ZXIuDQoNClNlZToNCmh0dHBzOi8vc291cmNlLmRlbnguZGUvWGVub21haS94ZW5vbWFpLy0v
YmxvYi9zdGFibGUvdjMuMi54L2luY2x1ZGUvY29iYWx0L2tlcm5lbC9ydGRtL2RyaXZlci5oDQoN
CllvdSBjYW4gaGF2ZSBhIGxvb2sgYXQgdGhpcyB0ZXN0aW5nIGltcGxlbWVudGF0aW9uOg0KaHR0
cHM6Ly9zb3VyY2UuZGVueC5kZS9YZW5vbWFpL3hlbm9tYWkvLS9ibG9iL3N0YWJsZS92My4yLngv
a2VybmVsL2RyaXZlcnMvdGVzdGluZy9ydGRtdGVzdC5jDQpBbmQgaXRzIHVzYWdlIGluIHRoZSBy
dGRtIHRlc3Q6DQpodHRwczovL3NvdXJjZS5kZW54LmRlL1hlbm9tYWkveGVub21haS8tL2Jsb2Iv
c3RhYmxlL3YzLjIueC90ZXN0c3VpdGUvc21va2V5L3J0ZG0vcnRkbS5jDQoNCldoZW4gdXNpbmcg
WGVub21haSA0IHlvdSB3aWxsIGp1c3QgaGF2ZSB0byBhZGQgc29tZSBldmwgc3BlY2lmaWMgZmls
ZSANCm9wZXJhdGlvbnMgdG8geW91ciBrZXJuZWwgZHJpdmVyLiBIYXZlIGEgbG9vayBhdCB0aGUg
ZG9jdW1lbnRhdGlvbjoNCmh0dHBzOi8vZXZscHJvamVjdC5vcmcvY29yZS9vb2ItZHJpdmVycy8j
d2h5LWRvZXNudC1ldmwtaW1wbGVtZW50LXJ0ZG0NCmh0dHBzOi8vZXZscHJvamVjdC5vcmcvY29y
ZS9rZXJuZWwtYXBpLw0KDQogPiBBbnkgaGVscCBpcyBhcHByZWNpYXRlZC4NCiA+DQogPiBSZWdh
cmRzDQogPiBGZWxpeA0KID4NCg0KQWxsIHRoZSBiZXN0LA0KVG9iaWFzDQo=
