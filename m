Received: from PUWP216CU001.outbound.protection.outlook.com (mail-koreasouthazon11010001.outbound.protection.outlook.com [52.101.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B346E639
	for <xenomai@lists.linux.dev>; Mon, 15 Apr 2024 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713141594; cv=fail; b=iqiA4DU1Z1YpsWxM4eTyer+nAaeex3vlup/vCAExw/zIccK20JzfAMQNtJbAUnItbKf/qn5IjvQDJ0kIDDZCBfmWk0So+JR4vk3nrAesZ6Dn5wJWY9NLaeAVitwzNoWddbhd417OmdLgKC0LXIBI+jQuLQlL1Pj0qy0U/J/yOfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713141594; c=relaxed/simple;
	bh=hggZ+1cXpLWsCe3Phi72hjQnw/A0mveoCMgD6oHQLXk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SDIswyh+BX+fqrx/zlGnl2tMfln6dDf3sLPB4nCup2R6LSkw/XFdE3OhX1eUtFQpm1NsnDuykndM9d55k9abTkDgLElGJmu7Ljr/jaY3a0ddf8693MqFLKQYKeLHAwHhAScdPrqlVm0XvonD3B42WwjIf6vRBzDh4cv7m8IuyOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com; spf=pass smtp.mailfrom=doosan.com; dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b=pECpyOo5; arc=fail smtp.client-ip=52.101.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doosan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b="pECpyOo5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M24s6DmvlWBavi0BvUwjU+iUux/g4xR9mdZ8EEqKR5v0SiZwKkAJfgmyz/HpNcjzaIwtU7bbyl7nG/wrn4uhSqzhM5a3d2XzOiP3ABYTlo0WIFyTXzX76Q5u33tkYw+4gIZ+sQ2ZbJOgstEWdw7lXjqcXotoniRljfhDoh3RPwCX+liPMG4ViMquhQf8DNcvVV9IZDW3Q1lsOBCLNYBV+acJcjjNLdax00ki3v/iQDcPWaU6plp84jk1L6YvQkC4I4fDFtJT/1/1E99Z7D6xKTRaE0CVSeD2ySSXzeNb9EFgVbGm7ZH7wzQqEVJmAwXoGmJ7oplToEjfQOnBI3I72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hggZ+1cXpLWsCe3Phi72hjQnw/A0mveoCMgD6oHQLXk=;
 b=hM6qCY6nNRfa2i5bXVA5OI5YupOfkPmLgKYJzKlFDwYM7f8OEenrK+4Z62PyGprFniP5IyNWYT5OvuOGzOpZH+ScVNaR2ZvGrjWHYiaBX3oGwBF2xkQdWOQiSRQj6yDOcS4MltPbj4GcXjUQ24j4+Ymlat4D3KCGagQ+Oo8NSUx+bp+kpNlfuu9q55PRmcpeH7jGrCEeR6J5eXvCsKKpFNeVywHx1WXbpnDr1bvpRiqQkeTS2VEhq6GUA4az9OSNq3ZSCDBFjI0kE8r9ze6xa9aLaPm5iDY0cM2PN+4nmLfYjEh4HOY5scGyMJQpPHskXEicRTg4FChlm3JQWJIeoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doosan.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hggZ+1cXpLWsCe3Phi72hjQnw/A0mveoCMgD6oHQLXk=;
 b=pECpyOo5RQKrjx9pOY6jqx7p6SSUq6rX8xBOnvvCPHR0738jHHiUGbBsXzcPZQJZPOMJ6p+QpQiCTQIoSncCsYSSFdyTAwMyIm/fAPKnSHGvuSkR8erEq+UpZpQQhMQQt+ORK3EO6cBRuk6nwdD1ZHBXlYCizFRNjGXelC911Tc=
Received: from SL2P216MB2274.KORP216.PROD.OUTLOOK.COM (2603:1096:101:151::13)
 by PUYP216MB3034.KORP216.PROD.OUTLOOK.COM (2603:1096:301:154::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 00:39:48 +0000
Received: from SL2P216MB2274.KORP216.PROD.OUTLOOK.COM
 ([fe80::1369:3712:b569:7e37]) by SL2P216MB2274.KORP216.PROD.OUTLOOK.COM
 ([fe80::1369:3712:b569:7e37%5]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 00:39:48 +0000
From: =?ks_c_5601-1987?B?wNPB2Lz2KEp1bmVzb28gSW0pILz2vK4gtc676rfOurjGvb26?=
	<junesoo.im@doosan.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: =?ks_c_5601-1987?B?udqw5sjGKEt5dW5naG9vbiBQYXJrKSDGwMDlILXOu+q3zrq4xr0=?=
 =?ks_c_5601-1987?B?vbo=?= <kyunghoon2.park@doosan.com>
Subject: asdf
Thread-Topic: asdf
Thread-Index: AdqOzNHs+228A0MhSFmuuE+FFFCv8w==
Date: Mon, 15 Apr 2024 00:39:47 +0000
Message-ID:
 <SL2P216MB22748E1629FA8E97C4B9C12FE0092@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=doosan.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB2274:EE_|PUYP216MB3034:EE_
x-ms-office365-filtering-correlation-id: f8e68e00-a13c-4aff-7dbd-08dc5ce48dbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 coONj6C4pSJDz66MVvcxi9dLIaJ+Uo/qssWhiWLkMs2up4Rk9EqCTRbY6ndycu5AWv5IDGdE1105hMytdaq/bBzUBwUPGUf86n7CoScuwnOs8It6gYJLgD2/Zg89wOshHsmcv42sg+qxN6g8O93UJ+aX11YPgNaAaNqI+WM7LbMVDoD1fpgwXjTS1s2a8opJReOOdPYDvGIxg2fsWPUUOB9PzYRqS49XQyB+DLwAfzbD/C3QA5VHQP0w+RzviXzmVkJovLlPD4Q+t9UahWW7ZD8GHOrHVGnz3JsvY4aNSHherciLCPrBYjvSB8OmSDBrIJm9uZPZz0uCESPSSfrydkE0Vx2kVZT39GaZZJ18EyakbapASxbDFBDfB47IzAE6crYgDbUKg9S+emUnQM5RM6dnic5qky9ZXywS25Ovdfk1cclnkbxfGldhLtaekDBfxB1Y5FaLMY5pAEyVX0UJySXgQ5hnmNSbyGCBXWZESeHAN7j2aHXUZHR5ym2avsRzeecyX0/J025eud9uBOYyFrZV7QT2n+n0b0muD4guB9ypsmJC3zBEEZ44mz0BEfeLkTSrp2df1KT/ZU61iYndPKt6LjZpwwaO2aJi+lHPq1g59u7OQ55slexVLjkbWjsDxqiqGL/Sy0b+F2fZhwom3KH6caQ9t2XRapJePWJyHeA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB2274.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?ks_c_5601-1987?B?aG1jR1RrMytqNjRmWmNBb1lXWjVubmZTM3VRbEdFdjh1RmRsSzRx?=
 =?ks_c_5601-1987?B?b2liZ21vcnk4N1hQN1VxMXI4a3BrZ1hmZXVMZFdkSWdVMVlHRzMv?=
 =?ks_c_5601-1987?B?K2FTZXlGOFZEWUZRL2FSSjZFOUVFTVR5Z1ExVjUvbHNEaWlWRkUx?=
 =?ks_c_5601-1987?B?M3plQkVUeXpXcFRRMWt4ems0UHc2WHFTaUVHbVIxb2Zjd0ovTUR4?=
 =?ks_c_5601-1987?B?U2NHaDNNQWZ0dUpXMXBtTFM1TXZ5TW9TbUxJTi9ENittV3I0aVg0?=
 =?ks_c_5601-1987?B?Qk1HY1hlSFVDakduV1Y3c2NxQXArUTJOSzJET1QvaE5TT1ZMd0dq?=
 =?ks_c_5601-1987?B?M01lcEhDZUhHYmRzNS9jTE45eVRtckdwWVBPRDl6R0NVaVduRWxZ?=
 =?ks_c_5601-1987?B?ZFB0ODl1bGZSblFzbDN1dEFDVUtCV1ZXVVdiWW5GN2V6R2JWZHZ0?=
 =?ks_c_5601-1987?B?WXhYa2hNaVI3ZlQ3cWhESzU4TldmZjduSmJ0b3hRSXdvd2g4Mkdj?=
 =?ks_c_5601-1987?B?UTRtY3dKbG1FWnhjcXdHYU1VNE53WlUwS2pKMFgzZEIwUWQyOGFs?=
 =?ks_c_5601-1987?B?N25uRys5U0hsSitCZWxXaU14Z01VbW05UmJWZnRzbWdncmxRQk5W?=
 =?ks_c_5601-1987?B?MVduVlB3K241ekpkckVQMkpvMTI5MUlIYUJKTGNvMTdIY3huU3Zr?=
 =?ks_c_5601-1987?B?WkRHRy9vUCtaRFVza1JkMllJdlJqek5CTy9MbXBZNGVKNVdCNzIr?=
 =?ks_c_5601-1987?B?bmdHcm9UdmRCQ2VXV2hJYWtMMVFxeFJkWlNCNnZ6UTJRUlNxVG0x?=
 =?ks_c_5601-1987?B?MUREZWUzY3dUWlNHbEdweXR2L2s0cmp6RG9uQU9KZG9WK1dMd2Q2?=
 =?ks_c_5601-1987?B?NUlmdGNjb1NRV281dm1VVnpRWGVYb2ZvdVd0NkR5ZURmL0RnRkxO?=
 =?ks_c_5601-1987?B?cDV4b0lMOWdLN0JWeTdDYjR6WTFKOUVQcFBhaHBheUp0MGl2Y2th?=
 =?ks_c_5601-1987?B?QkVzRjN1aE5RRGhaQ2F0aWd5eGg1Q2ZFMHNPRytrMFlaMDhLS2I5?=
 =?ks_c_5601-1987?B?b3ZpQnBXckR4K2c0L3pMdmtja29LVm9nWksrNG9VdEhHenk0MDRR?=
 =?ks_c_5601-1987?B?Y2xtQnZSYUVzQXRNbWZlNUJaT0lnc1IzKy9hSDBwVjhPb0g4SmVY?=
 =?ks_c_5601-1987?B?bmt3cHVCM2RoemVnNTNtVm5DMmdRTFA4RGNyRklJUk9zTHpzcUN6?=
 =?ks_c_5601-1987?B?bFlEVzlKN0x1ODlvVjBDY0hXRjBwVnlEMDFwTVo3YmV2QWVZWWl4?=
 =?ks_c_5601-1987?B?L1RRZU9HSXdIeTF5TkROYjc5STk0cVB1SGhFa3BkMi83b1h5S0pO?=
 =?ks_c_5601-1987?B?ZzBCQ0lkWm5BVStZcjhJeFNRT2dDRm1COFliakFIQXBTWVlxSzlN?=
 =?ks_c_5601-1987?B?RXNMcU1VODN5TWZxTE9JMStCMXhyS05yQUtuQjNkVCtEbG9HNnFL?=
 =?ks_c_5601-1987?B?NnpQeGcwa0ZWVGZsTFRDL2x2REdQdUpRZThqU25XN0YzcDBnbjBR?=
 =?ks_c_5601-1987?B?Y1VHQWttSUxQRlAzTFEyaEhESHVUWWtYMm43NndZL0ZpZ2tpS01k?=
 =?ks_c_5601-1987?B?UWJoTE9OYkxWcjUvc1o1OFZMYVVtUHRHOE5mWkRLYmhnZlBKWmYy?=
 =?ks_c_5601-1987?B?cE5taTlMNC94eGdoa0s1Q1BhNENVM05hd1dqc3pRdFl4R0Nablgy?=
 =?ks_c_5601-1987?B?VkxJc1dQYi9Ka2l4WmJacVNmWkMrL29FSEY2VHd6ckoxR2tQdExX?=
 =?ks_c_5601-1987?B?YkZHS3cyQXJHTXhhZENlRGQrVDdnM2NxOTNGckNGUkZGMTNmL2M2?=
 =?ks_c_5601-1987?B?Y2ZzWTJOWUs3aVExdFlaelVldlNVYWR3OXVjZjZIM01idUM2bjVJ?=
 =?ks_c_5601-1987?B?MnNKbEtJL1pKQ0xEZUxkNTI1MDg4SXZSdlBTRVFLNC9rQnpuWmxR?=
 =?ks_c_5601-1987?B?VXVIQVp4YXJkQlpkMnNtVFdydHZEVUVRdG0yWmo5endTdklRODFs?=
 =?ks_c_5601-1987?B?RGNUeTZ6SkdaR0dWZEphcG5XK0hYeXViOWEvSXZXYkxNNFptTEVn?=
 =?ks_c_5601-1987?B?NEN4TFJPSm9ldnZsSGdJTlYwdzVPMm9iRmdvQlZMZ2hVS1pvb0gy?=
 =?ks_c_5601-1987?B?YUJpcEwrM0JLSVVBZUF3OGZmQ2hEK0g0N1hiUVVkQ2cyQkN0azR4?=
 =?ks_c_5601-1987?B?MXNJajRFRVVGa0RXb3RUUGloTENLaFh3aWxaV0JCcXRIYVlVZVFE?=
 =?ks_c_5601-1987?B?TGI5Y0VGd1hndWZFSFdNSVV1WU9kWXl1QkU0ZG0wWHNUMklNc1FO?=
 =?ks_c_5601-1987?B?RjRISS9SRDh3UG1YVC9QS21aTDdFVWZNaFJHWng5VzN2N1ZZZlJ4?=
 =?ks_c_5601-1987?Q?VfJMCwzBSKuxWvWH0VBesTrgiWclqDtSbeyNkyUK?=
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: doosan.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB2274.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e68e00-a13c-4aff-7dbd-08dc5ce48dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 00:39:47.9652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8qmrCKACVc8/q2MH+4IZ5AxN1DlHBJCByc3RbgbQ4Xs8el5zDmupiSF0EX8eHZnEH9hXt587maDCVu0SemyvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUYP216MB3034

aGVsbG8uIEkgYW0gYSBMaW51eCBBcHBsaWNhdGlvbiBEZXZlbG9wZXIuDQoNCg0KQXBwbGljYXRp
b24gdXNlcyBYZW5vbWFpIDMuMXguDQpUaGUgbWFjaGluZSBlbnZpcm9ubWVudCBpcyA2NGJpdCBh
bmQga2VybmVsIDUuNC4yNTUuDQoNClJlcGVhdCBtYWNoaW5lIHJlYm9vdCBhdCA1NSBzZWNvbmQg
aW50ZXJ2YWxzLg0KTW9zdCBvZiB0aGUgdGltZSBpdCB3b3JrcyBmaW5lLCBidXQgc29tZXRpbWVz
IHRoZSBzeXN0ZW0gZnJlZXplcy4NClRoZSBtb3VzZSBkb2Vzbid0IG1vdmUgYW5kIHRoZSBrZXli
b2FyZCBkb2Vzbid0IHdvcmsuDQpUaGUgc2NyZWVuIGFsc28gZnJlZXplcy4NClRoZXJlIGFyZSBu
byBzcGVjaWFsIG1lc3NhZ2VzIGluIHRoZSBrZXJuZWwgbG9nLg0KVGhlIHNhbWUgZ29lcyBmb3Ig
c3lzbG9nLg0KDQoNCg0KU28gSSdtIHJ1bm5pbmcgc29tZSB0ZXN0cy4NCklmIHlvdSB0ZXN0IHdp
dGhvdXQgcnVubmluZyB0aGUgYXBwbGljYXRpb24sIHRoZXJlIGlzIG5vIHByb2JsZW0gd2l0aCB0
aGUgc3lzdGVtLg0KUHJvYmxlbXMgb2NjdXIgd2hlbiB0aGUgYXBwbGljYXRpb24gcnVucy4NCkhv
d2V2ZXIsIEkgZG9uJ3Qgc2VlIGFueSBzcGVjaWFsIG1lc3NhZ2VzIGluIHRoZSBhcHBsaWNhdGlv
biBsb2cuDQoNCg0KSSBoYXZlbid0IGZvdW5kIHRoZSBjYXVzZSBvZiBGcmVlemluZyB5ZXQuDQpJ
IGFtIGN1cnJlbnRseSB2aWV3aW5nIHRoZSChsGh0dHBzOi8vdjMueGVub21haS5vcmcvdHJvdWJs
ZXNob290aW5nL6GxIHNpdGUuDQpJIHdvdWxkIGxpa2UgdG8gdGVzdCBzb21lIG9mIHRoZSB0aGlu
Z3MgbWVudGlvbmVkIG9uIHRoaXMgc2l0ZS4NCklmIHBvc3NpYmxlLCBJIHdvdWxkIGxpa2UgeW91
IHRvIGxvb2sgYXQgdGhpcyBzaXRlIHRvZ2V0aGVyLg0KDQoNClRoaXMgc2l0ZSBpcyB0YWxraW5n
IGFib3V0IEtlcm5lbCBjb25maWd1cmF0aW9uIHRoYXQgbmVlZHMgdG8gYmUgcmVtb3ZlZC4NCiJD
T05GSUdfS0dEQiINClRoaXMgb3B0aW9uIGlzIGN1cnJlbnRseSBlbmFibGVkLCBzbyBJIHJlbW92
ZWQgaXQgYW5kIHRlc3RlZCBpdC4NCkJ1dCBGcmVlemluZyBvY2N1cnJlZC4NCkEgcHJvYmxlbSBo
YXMgb2NjdXJyZWQsIGJ1dCBzaG91bGQgdGhpcyBvcHRpb24gYmUgcmVtb3ZlZD8NCg0KDQpUaGlz
IHNpdGUgdGFsa3MgYWJvdXQgIkZyZWV6ZSBvciBtYWNoaW5lIGxvY2t1cCIuDQoxLiChsFN0YWNr
IHNwYWNlIG92ZXJmbG93IGlzc3VlIG5vdyBiaXRpbmcgc2ltIHJlYWwtdGltZSBrZXJuZWwgdGhy
ZWFkP6GxDQoyLiChsFNwdXJpb3VzIGRlbGF5L3RpbWVvdXQgdmFsdWVzIGNvbXB1dGVkIGJ5IHRo
ZSBhcHBsaWNhdGlvbiAoc3BlY2lmaWNhbGx5OiB0b28gc2hvcnQpobENCjMuIKGwQSBjYXNlIG9m
IGZyZWV6ZSBpcyBhIHN5c3RlbSBjYWxsIGNhbGxlZCBpbiBhIGxvb3Agd2hpY2ggZmFpbHMgd2l0
aG91dCBpdHMgcmV0dXJuIHZhbHVlIGJlaW5nIHByb3Blcmx5IGNoZWNrZWQuobENCg0KDQpUaGVy
ZSBhcmUgdGhyZWUgZXhwbGFuYXRpb25zOiBJIGhhdmUgYSBxdWVzdGlvbiBhYm91dCB0aGUgZmly
c3Qgb25lLg0KSG93IG1hbnkgdGhyZWFkcyBjYW4gdGhlIHhlbm9tYWkgcHJvZ3JhbSBjcmVhdGU/
DQpXaGF0IGlzIHRoZSBtYXhpbXVtIHN0YWNrIHNpemUgcGVyIHRocmVhZCBpbiB0aGUgeGVub21h
aSBwcm9ncmFtPw0KT3VyIHByb2dyYW0gaGFzIGF0IGxlYXN0IDIyIHhlbm9tYWkgdGhyZWFkcy4N
ClRoZSBzdGFjayBzaXplIGlzIGRpZmZlcmVudCBmb3IgZWFjaCB0aHJlYWQuIEl0IG1heSBoYXZl
IGEgbWF4aW11bSBvZiA4IE1CIGFuZCBhIG1pbmltdW0gb2YgMiBNQi4NCg0KDQoNClRoZSBxdWVz
dGlvbiBpcyBjb21wbGljYXRlZCBhbmQgbG9uZywgYnV0IEkgZGVzcGVyYXRlbHkgbmVlZCBoZWxw
Lg0KUGxlYXNlLCByZXBseS4NClRoYW5rIHlvdS4NCg==
