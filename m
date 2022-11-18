Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80044.outbound.protection.outlook.com [40.107.8.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1857F2F43
	for <xenomai@lists.linux.dev>; Fri, 18 Nov 2022 15:13:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6sD5WgLhqPbasYQcyaRux2KSdu3wyCXyP0am/BJiuLeXrd+5N7b5W8MoMxZFgALOXRKd/gAS/YDugenCEv9JWeO2JLIvaKkbScLkTZHGOE0V5f9wVDE3cn4tWJ0GsgWkU9mT4fx2RVKJkzLCH1se491HARkIfcef8RQ/1od+qLLPR4uy4ILonyGiBF08wflJx9PMgrrTH/AHCXMHcM8jmTP4ZGckXnoUmlvtsBlhO+fB55aX+8NmuyycCiEzHphK0e8LYHx84EgHp2GsoaoZrPMD52GMgcDnSn14wk/sJGVpRIF14AZ7bbjh0ego/SxNNtt26HHyPGJ8VrfGr9A9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk6Y8y4TIv5XxtvnPDuSbD0miyNnxlLpdz4384BmUTo=;
 b=StzWwwoHEdCx+qJTKzkRIjs0glFr+yEqcHqZKYWrFikF/lLCbIY4nSBIOpMnz6E4ErLePCZIRxvQ7iEX/r3hMsKS6uSZd62wAWqDcTD3aNGMNVfdBQbK1AVLMzDZA+FeatlUiA4iCfb7W3nIJsqW1fDTh7w90ErYIJ8EFaq2acXUDW6biExSrkn6OdDJu6fm4ALWrAW+4B3jVFMG/7ZFV5x+kFmwUilIncu/m2x2jflnPjqnt0m/Va0bemYuK3Aa6626sXF+gW8YclAEvTEA1by5e3YFv2TkRNNATfbO/5Ry4SfLI1ATc0kjez5voZwaihqUgkEwiTAZCXSt4ljLxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk6Y8y4TIv5XxtvnPDuSbD0miyNnxlLpdz4384BmUTo=;
 b=0IB5C4MPChdnY5yKKezHHESMtu8Aczd7XB5NQby1ynj4IkL8C2omtcRT7dLuSQVgHQIOu9ssJ3Q1TSND2ZiWRRxLQJ2MCdDxjamCBfr2n/A8qdphMMnZYGYbCplbWtINTGxhZT2fy3uvRZAQaYMHD0Q9PCsOQRwCi6Pd00+DDFyL3ZRddLosyZfDjjRhXic4S3a1qred2aC5P05MYnpDBOCsOVFioUmACjZfgtram5pcHWfoVvbZFEs7TNW6CGinoB83/LrTrczEsnBnaPi0WBoU4vlUltFtQz7HugbumVMtTc5XXpUA4dF5fImBmRYT0bmzmPIm7eJQrJNnPcmf/A==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB3PR10MB6836.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:43d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 15:13:28 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13fb:15f4:a3c5:4ec3]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13fb:15f4:a3c5:4ec3%5]) with mapi id 15.20.5813.018; Fri, 18 Nov 2022
 15:13:28 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: Re: [PATCH v2 2/4] drivers/rtcan: Implement compat support for the
 rtcan driver
Thread-Topic: [PATCH v2 2/4] drivers/rtcan: Implement compat support for the
 rtcan driver
Thread-Index: AQHYzOwG0hT63RZ3KkKng313Mn2rw634o5MAgAVNe4CARzW4gA==
Date: Fri, 18 Nov 2022 15:13:27 +0000
Message-ID: <884d0d5c4d574c36e8b2d35170e63c1ad74aa486.camel@siemens.com>
References: <20220920122503.115682-1-florian.bezdeka@siemens.com>
	 <20220920122503.115682-3-florian.bezdeka@siemens.com>
	 <3ed01ad123d1ad28298d9ae4fca06046b24e3805.camel@siemens.com>
	 <9a209271-dcd2-b19d-8421-283d734ae259@siemens.com>
In-Reply-To: <9a209271-dcd2-b19d-8421-283d734ae259@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|DB3PR10MB6836:EE_
x-ms-office365-filtering-correlation-id: 5ae11c70-cbe3-4102-d6c3-08dac977723f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RZbtcJlTjhC6xJIHaF6WILVoXZcvpo3BanfgKmu7kkcopMtf4y1WizG66zb+TbiToSYP5RKfxAzRlMqb9P/RslRI6QT6qyslk+vCxDkKD5QnVnD9WKKbWiMchOeD7aD1MrohfFlpcmUt+oa86MxMpribW0tLKVD7REC9969Rk4alo9lQwGOdLRY1OX+S+5qQnHVeO0t+0LsCXLppFR6rshFUMkakjJJh0fV0y8weUbPljyoKb8QO+BsaOzIyfwL56TI9p+AmqiNGkTR3CNNilJlE4Xi3kAQOfI7syeU85nq1bhgnNbCyqG/UBypwfHxlW3xhn8duCnrC5U5Nhn1oYcZpiXZtwLgMritL2/SycI0787OSG53Cxg+RdQjwzLPr6y0G3avBmNOmsOFKoonvLdr/RRM1wOI+gysEXK6uWVQ7uR4DlPy+Hg386NwYxIr0rE+wMBYQRTOyRQOwHXcAkWSuQMBmIkNZAKrOduJaqPhsLSxsKeBhbCR2xEUYoeW7G3yPkhucjtnmd/jKi6LCqfLhNleBZ8ixZZLax3npdNFD6h/2C+fX91/nrUjgT5UcfYFDQGmIT4CkEm00v9IbTcdXJhnUHpJaxNmmaCPKdnsA9TxkdFOhYP4Fl79RHwr/x7CHxGAVY9ZHylafZIs0g5f8d36pa6l7HBlgy6clDgPqnKzpkrWocu5jVoaWjYV7QV+5cCRZOfuoRxFvfcdofQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(5660300002)(186003)(6506007)(316002)(110136005)(53546011)(2616005)(8676002)(6512007)(76116006)(91956017)(66946007)(66476007)(8936002)(66556008)(64756008)(36756003)(66446008)(122000001)(38100700002)(38070700005)(41300700001)(82960400001)(86362001)(83380400001)(2906002)(71200400001)(6486002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alRHV3YrZ3M4MkxITmFrWWVTdGtSZlFGQ094TzR3SGZjOHo3eVl6cmVtdm1l?=
 =?utf-8?B?a2FMNmFrTXNPR2Z5Y1VKdzJ4d2hsZG1LTlRjakw5N1V5ZGtnc2VUblRTVUpC?=
 =?utf-8?B?WHRsMzhkcjdlZ0FUVnRSVXl0UGQzMS9qN2s4bVZvRDdUeCt0dEp3RUlrQkdI?=
 =?utf-8?B?Qkl3VzVLWGUrQkw1V3RiRmR4TEJKdWlkNTVTU29tTmFRWEJKa2xGT3RnWit6?=
 =?utf-8?B?WUVrU29yRTFnMm1ndEl4dkJCVHlkeDVjQjlzTHlkdVQzZlZTQ0dOWldIRHFZ?=
 =?utf-8?B?RUtkbGxsZ0dnZ1QvcHRhNDJ1ZVdTOG1ldFd4aWlNNEdjZHB1ZVRwQVhvVElE?=
 =?utf-8?B?TTVRZHMrZTRLdUJXNWpOK3J6SmJsVzlzZVVlS256eTFxVklyWXB6NTJPUGZy?=
 =?utf-8?B?VGt5R3IydENIZFpzdURxamJxWmRqSzRLZkJsV2UrQmVoK1VkTnJobFMzQ2JD?=
 =?utf-8?B?NFkvTUU0RG1QektQSjVjanRVelF0S25udTdYSm9oVUJOdU4vR0NhM2FMb1E0?=
 =?utf-8?B?U0g0L3I3azFOS3JxeWg3bVNzdVJnUGp1L0wzL2kyZjhmeGkxYWZSaDRoUzl6?=
 =?utf-8?B?djlDZW9xbjhKdjlYcFIyckZOMGlJYXV1ZEVwZzhyYmpqUlhVNnRMTEZSOU56?=
 =?utf-8?B?MEZ3MmhUWmt6Y3NSZUNYdlQvL3pKMVl5Vi8yd3UxdEIxSWQrRm5yajJjWEJm?=
 =?utf-8?B?UkI0eFV0RXV2UjBmVEZ3Y3hjaVJqeTFpcDA3ZG1XSGN5cHNKZlpOQkM4VmVo?=
 =?utf-8?B?NGs4Ykt0U2h3aTNFeTBnKzE2ZEVNVXhXQ29hRWM3cEpvc2FjNnh4NFdFWlRV?=
 =?utf-8?B?dGRrSGNhcitHeWk0ZjlPa1MySndjN3ZEdk1HZDl0RGNiTzQyMCtZd1Q0VnBj?=
 =?utf-8?B?MWRFemRwcEl0ZUpuemV1ZENnZ1lMcTEwMVArWTdIN1B2b01ISGlWTUFqeVkw?=
 =?utf-8?B?Ym1sMGhXQmEwMFIwdXZKUStKd3J0RUljNUtkb21YL0hTeGJUZGpNNWlmVkdZ?=
 =?utf-8?B?cUlDbnpXWDZWejdrUXdyek0vTjRQcnBVWHBFSERwYnBPSEpMSDdubVY1cUJ0?=
 =?utf-8?B?YWNLSlVvZFZqUVBxK2szOGVHOG1CZXU5Q0swVk9ZSGxGVStYT3R4TVJIb050?=
 =?utf-8?B?MW1LZXBwb2ZxTDI1M2JSSzVBWDl2SDlwY1VFcEhvUUcrUEpma20vS2VTbHRy?=
 =?utf-8?B?WGFIUU0wUnN4Qit6aEcwVE5oMzhvcVN0T1dTd3R2Sk4wY3JTUVhyQmFZSFN0?=
 =?utf-8?B?YTZTL01QK253UmRiN3lPaS9uRXpHNnpRbDdEL0xhRW1KUFJRZjRHQkI3YmNz?=
 =?utf-8?B?L0diYVZRNXBoTHVMdS9RWG5Lc05xR0hINk5CT2EwUmdUOVpNMmdyTENWa1Ir?=
 =?utf-8?B?c3cxYjNvZkZiS1RZcXZsdmR0S1J3dmJ2aUZPeG1iS2pZenM5NzJDTlJUU2tq?=
 =?utf-8?B?SzlvaFRac2kwTXZQck1oeG0zQys5c1piOTAyaUNWWDFScE9CeWJIdWhmWjZa?=
 =?utf-8?B?UTZZaXJybXlwS052c3RncENxSDFEK3dFZDlqcmVUQTIweHk1R0xBeHdoV0Zn?=
 =?utf-8?B?c0NTcGtxU3lUdkhzNW1GU1VEcDZ6Q0R5YWpLQ2dEQUV6VTZ4OUJTVGhTcldC?=
 =?utf-8?B?MTFSMjRoNjRLUmo3RERhZVgvblJES1dScElkRUhXWUIrL25JdUFsQkVLSEY0?=
 =?utf-8?B?MnlGRUt4eUpxZi9CVHRQRWVXRS93ZkVQdXQ1aVJaeDhJS1laaEpvRGZzUFBZ?=
 =?utf-8?B?UlNGWkJYeUNDaHNuZ1hvQVdpVFlMc3JBcVljV1ZLRnh3M3FYODRHY0ZCVm5N?=
 =?utf-8?B?RXJDeFNnVU5XYlhPTkMxcU8xVUVUZktUak90QXZ3eDVqK0JCWEJUYjFhTmY5?=
 =?utf-8?B?Z0JWY2FzdnFmRzhOMzR0RHZMVFd2MFhySUZackh2MzlxbngvaEkxRENPL3kr?=
 =?utf-8?B?dWRMSE9sT2RsMFQyTUI3NnF2c29ZUnlrd2w1dDFaQ01WZ25jcGdnMURsV3Zk?=
 =?utf-8?B?LzdhMVdRZkxzbGU1L1ZkKzBZQUkwcnQwUGhtbDBPdlVUenJEbDJFZHJ5a01U?=
 =?utf-8?B?eFJ0cWs5dkdqQXk5ejBSSHk2UkRweWVJQlpFOERVV2tTUVdmd1pDa2llY1h1?=
 =?utf-8?B?RmRhN0UzTVQ4ZU1RdW03WTlmZ2lLUGtpMmNjeUJQL0hpMC9VVVN0V1JEdkF4?=
 =?utf-8?B?MzhJUDc2VFpuQ1RBV0JBNG9nYXVLN05kSlhFbzBudVRYZTFGdFp2emVibDlP?=
 =?utf-8?B?SmdKdVhkTDNYbm1qVHRNWER6TUhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3578374C694A44ABD8500C35AE7A31C@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae11c70-cbe3-4102-d6c3-08dac977723f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 15:13:28.0330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZ5ebcvw1WEKY7FT1MpalwDZ+KHj7WQi38qcLEsNt3qhIgQmItS+3BSB4aI+eK+T7xrrNq6WppzVjxhV07nz4XHSB25EE1ppy7GcErykRrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6836

T24gVHVlLCAyMDIyLTEwLTA0IGF0IDA5OjQ2ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAwMS4xMC4yMiAwMDo0OCwgQmV6ZGVrYSwgRmxvcmlhbiAoVCBDRUQgU0VTLURFKSB3cm90ZToN
Cj4gPiBPbiBUdWUsIDIwMjItMDktMjAgYXQgMTQ6MjUgKzAyMDAsIEZsb3JpYW4gQmV6ZGVrYSB3
cm90ZToNCj4gPiA+IE9uY2UgWGVub21haSB3YXMgcnVubmluZyBhcyBjb21wYXQgYXBwbGljYXRp
b24gKD0zMmJpdCBhcHBsaWNhaXRvbiBvdmVyDQo+ID4gPiA2NGJpdCBrZXJuZWwpIHRoZSBjYW4g
c21va2V5IHRlc3QgZmFpbGVkLiBUaGlzIHBhdGNoIGZpeGVzIHRoZSB0ZXN0IGJ5DQo+ID4gPiBp
bXBsZW1lbnRpbmcgdGhlIG5lY2Vzc2FyeSBjb21wYXQgYml0cy4NCj4gPiA+IA0KPiA+ID4gQWZm
ZWN0ZWQgaW9jdGxzOg0KPiA+ID4gICAtIF9SVElPQ19CSU5EDQo+ID4gPiAgIC0gX1JUSU9DX1NF
VFNPQ0tPUFQNCj4gPiA+IA0KPiA+ID4gQWZmZWN0ZWQgc3lzY2FsbHM6DQo+ID4gPiAgIC0gcmVj
dm1zZw0KPiA+ID4gICAtIHNlbmRtc2cNCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogRmxv
cmlhbiBCZXpkZWthIDxmbG9yaWFuLmJlemRla2FAc2llbWVucy5jb20+DQo+ID4gPiAtLS0NCj4g
PiA+ICBrZXJuZWwvZHJpdmVycy9jYW4vcnRjYW5fcmF3LmMgfCA0MiArKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMo
KyksIDI1IGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gDQo+ID4gPHNuaXA+DQo+ID4gDQo+ID4g
DQo+ID4gPiBAQCAtOTIyLDEwICs5MTcsNyBAQCBzc2l6ZV90IHJ0Y2FuX3Jhd19zZW5kbXNnKHN0
cnVjdCBydGRtX2ZkICpmZCwNCj4gPiA+ICAgICAgaWYgKHJ0ZG1fZmRfaXNfdXNlcihmZCkpIHsN
Cj4gPiA+IA0KPiA+ID4gICAgICAgLyogQ29weSBJTyB2ZWN0b3IgZnJvbSB1c2Vyc3BhY2UgKi8N
Cj4gPiA+IC0gICAgIGlmICghcnRkbV9yd191c2VyX29rKGZkLCBtc2ctPm1zZ19pb3YsDQo+ID4g
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2Yoc3RydWN0IGlvdmVjKSkgfHwNCj4g
PiA+IC0gICAgICAgICBydGRtX2NvcHlfZnJvbV91c2VyKGZkLCAmaW92X2J1ZiwgbXNnLT5tc2df
aW92LA0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKHN0cnVjdCBp
b3ZlYykpKSB7DQo+ID4gPiArICAgICBpZiAocnRkbV9mZF9nZXRfaW92ZWMoZmQsICZpb3ZfYnVm
LCBtc2csIGZhbHNlKSkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBeXg0KPiA+IFRvIGdldCB0aGUgcncgY2hlY2sgdGhlIGxhc3QgcGFyYW1l
dGVyIHNob3VsZCBoYXZlIGJlZW4gdHJ1ZSBoZXJlLg0KPiA+IE5vdGljZWQgd2hpbGUgZ29pbmcg
dGhyb3VnaCBhbGwgdGhhdCBhZ2FpbiB0byBtYWtlIHN1cmUgdGhlIEFQSSBpcw0KPiA+IGNvcnJl
Y3QuDQo+ID4gDQo+ID4gSmFuLCB0aGlzIGlzIGFscmVhZHkgcGFydCBvZiBuZXh0LCBkbyB5b3Ug
d2FudCBtZSB0byBzZW5kIHYzIG9yIGNvdWxkDQo+ID4geW91IGRpcmVjdGx5IGZpeCB0aGF0IHVw
Pw0KPiA+IA0KPiANCj4gSXMgdGhhdCBjb250cm9sIHJlbGV2YW50IGF0IGFsbD8gQXJlbid0IHdl
IGFsd2F5cyB3cml0aW5nIHNvbWV0aGluZyBiYWNrPw0KDQpJdCBoYXMgYmVlbiBhIHdoaWxlLCBi
dXQgSSB3YXMgYWJsZSB0byByZS12aXNpdCB0aGlzIG9uZSB0b2RheS4gSXQncw0KZmluZS4gV2Ug
YXJlIGluIHRoZSBUWCBwYXRoIGhlcmUsIHNvIHdlJ3JlIHJlYWRpbmcgb25seS4gVGhlIFJYIHBh
dGgNCndpbGwgd3JpdGUgYmFjayBzbyBhIHJ3IGNoZWNrIGlzIG5lY2Vzc2FyeS4gSSBmaXhlZCBh
IGJ1ZyB3aXRob3V0DQpub3RpY2luZyBpdC4NCg0KRmxvcmlhbg0KPiANCj4gSmFuDQo+IA0KDQo=
