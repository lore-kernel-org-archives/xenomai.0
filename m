Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9EE63D
	for <xenomai@lists.linux.dev>; Wed,  3 Aug 2022 11:21:28 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 1E675C0005
	for <xenomai@lists.linux.dev>; Wed,  3 Aug 2022 11:21:27 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	by spool.mail.gandi.net (Postfix) with ESMTPS id C55C0AC102D
	for <xenomai@xenomai.org>; Wed,  3 Aug 2022 11:21:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ixv200/5ixxdR8J1KiBjigbKrKTopDbGezRHaf8tFYE+X1GoVor+ws0Q6zGo7kRNvgoOjs+h8ABwddZwydycA7Lf+wSktosR+WbIm1IsSzlt2I6RZoJVIWmXWf99H+4Ey4DBUO2dhspim82nsH9TDueAl7V+j3sjeEJfncyKhLe1+hdOBFtZoDKUWY3crctJd7lYwekyyURxIjO6L6VvLSWYN/Jl7Ot64uZm5SIs1nvb4dIjuwn6deA3e3Lf1XDcG9/hVjFVoyM4OWeGKIpFjqD0OKHUKs0bYLe3Lalsc22998xY9Zg9+enMZ+O9yqmkl7dT33JgbaaeJ5n7MFBceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hr9zFMxrXUweRg+8XaJNyyEHFRxYvpDFyR+RaS88RRg=;
 b=l01h0c3XM8IMesUlSHz+VhQk0RcwKrEMEP8U5SvZdqrRvAhYiPpxb4OahjF6VPkevrkiy0hy3AWMmeTDYSC79+PJ9uDGvUDSZTdM3knk5yBS4CYbAaQ4VrkeCh9gRbNorVktDq2MbtYksizTtdHo/CwAkwqLZTSbjvJVVcJJcvLajqISjsW1EH+Vdy4VXfVVTWFC1u4xBbJL94GimVJyx1AmKiYLnlCKjLJsNiXRniaDGOD8OOa6XjbCuafnrU8buf43v/eJv5RFkqC9X6QkpvJylpo/SVDFE8mxr+LMVfTf9L3+RZmDkV9qBlPyq5/YIM78J2F4SqJaSKkICpKD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr9zFMxrXUweRg+8XaJNyyEHFRxYvpDFyR+RaS88RRg=;
 b=E4yUcpVDHhk8GrrCDF5nByR/vdCL5I3rQBmHFkqYAu9UWbea8JW3RhZ6phzN5MqXZtUb8o7VJXJoPpK6DWFZIHLrdV7wbsB2Or8iH4/hlc3ev5RgfD5xnC9Q5s040duJonxD0K7vva0nH1x8XKpmrFgJTZIKk9QtivjUuo5eRUogVvgDeC0Sskw89I8QH7m1kjPltjyjwEy2sc6E55YZ2CjB7c5pYUNlZHJTIZB9GN6zoS5lIpWcxFvr17mfCm4BSqheKWzBIhGfp9GbLrTcYq6fnTrdvBiJTOs5xZ6C5+UDnCxwspbIzlaB3K/2QRX7EneAAq09c6LL7X5E8DcHpA==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AM0PR10MB2449.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:dc::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Wed, 3 Aug
 2022 11:21:24 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 11:21:23 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "ksmola51@gmail.com" <ksmola51@gmail.com>, "xenomai@xenomai.org"
	<xenomai@xenomai.org>
Subject: Re: [PATCH 1/1] drivers/net/stack/ipv4/udp/udp.c: added 32-bit compat
Thread-Topic: [PATCH 1/1] drivers/net/stack/ipv4/udp/udp.c: added 32-bit
 compat
Thread-Index: AQHYpo+LrIsVWE3eXE2kID+4yx1Omq2b1OkAgAADBoCAATFDAA==
Date: Wed, 3 Aug 2022 11:21:23 +0000
Message-ID: <8e4c061501a5aeaaa89c15f0b9a58fb672c0a7a6.camel@siemens.com>
References: <1659458811-3014-1-git-send-email-ksmola51@gmail.com>
	 <55a4975055367ceadd17446d311b0147f0621939.camel@siemens.com>
	 <1f8b7ac6585181ec27549a443abcc67973b129b8.camel@siemens.com>
In-Reply-To: <1f8b7ac6585181ec27549a443abcc67973b129b8.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.3 (3.44.3-1.fc36) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d3aab2a-e40c-4b9f-cdb5-08da75424c41
x-ms-traffictypediagnostic: AM0PR10MB2449:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 D5p1UZE9nNUlsMAHmNiC43kBRtbVhmDfsz5CLelU098Bsk+fbc1875gNQbPziJxoRn9o1o5jHIkQyB3OExyn7l0sqxmwSAmFhzyfOHXY5WZncXN2BrHVop3rmqoGEH2SuOPPcGJHD3bx5ucT+P6yYy+/4imPYUYIHS/WkV2x4p8uCXab49Jvk6XeS7ARTsTSmhcWEO2cLujo/MRzsOXwwxWL/OkdLhfeLGXrQAefjUg7ICpSxPt7Rrmp4XzxDfw4OKiOP8MP5+RGkKVfrOGk5yLcFH+q7DViAo5vKqPbYVpzqvw9cO3H+0oIrK7R72BCVR8GLMd7GaPeVz3c55X4qZPWahCEMCqnci4CXCI0k0xPYgl/zx7zv+BO0eBl1tY/1IFGcMVnP0SQvSXT5T3zn2U2qFTgr1JSaay8A7TMY57q5b3VLASIdAgbwNtphawwt48QDjji7JP0Fcs94XjBab0oCggiBtHZw6dO0Eh9/er7TcA9nXgoeEdAzWvYkzm2OGTUcLdrHserBnf/FLFSfKAK1gNn0i3kGiS8bZ7SY9Gwp9n6idA11ttG4eiN2WZ+oBedohfSysZH7pApNdAP9ahUGvNRZlHZa76HkDaF8EPIYtVLOowSYEgeIgOh/yUMS7mS3cqTQyGtx/zDi96C+t8hgRL2BVmYhWR///7LSVIlW3P57mLvb+y1BZWWjaM2CgSys8DdqxN1KDuoZSth+Xd/3hnxodmDK46hfp+bdy8oJbOYPkJD04YcR7s4wP4fP54nFoVOOqmQ0MB4TvLQod16C5AYShCc9pPbO53/wKCy8hm6Ftzar+Av4oS0Sg0bfPBATDvcrK89PUX4VK+U8XAc98dWhxGGlf/ng3NNHQtL89dd8UEza6ftvX7RWw/M
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(8676002)(83380400001)(66946007)(66556008)(64756008)(91956017)(186003)(66476007)(66446008)(2616005)(36756003)(8936002)(5660300002)(76116006)(2906002)(478600001)(966005)(6486002)(71200400001)(316002)(6512007)(110136005)(41300700001)(86362001)(6506007)(38100700002)(82960400001)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NTZxQm42NmNaQmRhRTFXZFR3cFd4TVNiZUlWZ0hySWNnRnJTK3BGc094Z28v?=
 =?utf-8?B?ekJwWVJHVUZKd3puZ1pRNCtKY2phTGJQTllOTlhMcGVRMDllTjJNS0xQQysy?=
 =?utf-8?B?cGJTTWxQb2d3bm01MnArNVNER0RtVFF6WjE5ODN1UDN2b2JrcDJ2OTNHZisr?=
 =?utf-8?B?aDVKYi9mMWUzWHgycndMbnNZR09Zbkt6MkVFN1NkdFl0NVY3TG9JSmdJbkhy?=
 =?utf-8?B?WmVlNFM3TWNmWDlaSVV5ZzArQ3J2dlAvdnZ0SFRjdDJiQUQ1dG4zUjFkQVZH?=
 =?utf-8?B?a0g2K2JvRlF3ZWp0RVI4U0llc3J6NHJEekJuWXQ2YkFvREtwZjBWTjRBbEIx?=
 =?utf-8?B?ZHhsRkppYUg2R2QvTUlsTWZGeThpZE5hQldwZ1RPY0lpVG5kOE83SE45Zi9X?=
 =?utf-8?B?RU9YZnR2RFloVVh4ZnNpcDEyMlVKem1Zd3ExeDJBdzEzNFBaaTVFQm9BN2hl?=
 =?utf-8?B?NXJRYmIwb1I2NWU2T2pZcHZIZjZHSUY2c1g2ZTFQczFzbEt5ZVd5WUdMTUVE?=
 =?utf-8?B?S1BlNXdkRG1CcGJOaTdUTEZsWGNiaVFScDBVUnMxMk5HWEdFdFpQUXhpdkc4?=
 =?utf-8?B?VVpmeGt1bTNSUjU3VzhzdlFqb1FieElnUXFZTktoUktXREZ6bXkyaGlacnc3?=
 =?utf-8?B?ZWtjd1plREx1YVpjcWMrbWF6Wlc5UGpEVitBYTBYN0FuZFJDM1JhcVRBM3NL?=
 =?utf-8?B?UE00ZGJlWU53TjFSbWhuL2VCOS8wbHBXQm8zZ3d1bDhOdFlEcUM5NnVweExH?=
 =?utf-8?B?RlRYdnY3MFR1S1JWL0hIRm91bjUxUFVzdmRsMHNodTRhMXRWdnE3djVWMVJ3?=
 =?utf-8?B?MHUyU0QyNi9UTGZ6MytYdnV6a1gxT2ZKMmtLeXhoRWNyUU84d2FabHIyWDVM?=
 =?utf-8?B?dlIyN0lTR3BVejFkSFhLZmxoL3U1NWd2WmFlOEFBRVJCNmpLUmhuSW9Kd01o?=
 =?utf-8?B?QWp6eFk4azVlMVF1VC9tNlByV2RveGdtaHJVNFRaMXR2eWtoZU5pQXgreVl4?=
 =?utf-8?B?Zzg1dEljcVc2SDRVRzR0QlhPbVN0VGljZ2Nya1ZYVGV0d3BUbFhlNndIeERr?=
 =?utf-8?B?YjI4RDhmTjhVeU9iWVVQc201WHRtTEJnai8rSUFkT092WGI3UEdoOThkekFO?=
 =?utf-8?B?eVh5NnpETXJhNXJ5a2JaR2dETWdHWENRMjFhVFczdWM3bWZ6ZXg2bFBOa2Er?=
 =?utf-8?B?Q0FvM2s2b2YvWEREdkZ6T3cxNmhSbWtYT0REaUhKZHFWRmxoWlpzckRtam5W?=
 =?utf-8?B?ck1DRm1OVkZwUVVVMHRhc245NkdBL0JuMWhiNWNpM0lpUmk2bWJoVU1FNC9i?=
 =?utf-8?B?QjZHbk8vU1puTE55UjN2N3lta0I4RldURUdkY2hHYmlzYklCTXE2VFlFT3Mr?=
 =?utf-8?B?amdPbzV1RXo2NmRqbG1CUzFTeThGRFpwdUVKSjVCL3JsZFU2ZHdzRGt0V24z?=
 =?utf-8?B?a1crOTBiS1p2bEsrN0N0alhMV0hZTy9VREpJajNHZDdNU294SUY4bkR1VjU5?=
 =?utf-8?B?b3RpeDNjN1FmNXFMS2Vvc2FzSVdqZXd5M3NHK0g0SUdybk82M3lTTnZieUUr?=
 =?utf-8?B?Z0pmakFKL1NOZ0ZUYkQySS9jU2RocHZ6a3ZsR2JSeFRCWktISHVSVG9ybzlJ?=
 =?utf-8?B?dFZQVXdzUDg5SitmSWdoa2pxemtJM08rNTAxelU3SmRpSTlkZlVuVThvZVAr?=
 =?utf-8?B?RVJQb3I2ZEM2cU1MWGJGK2VxU2hiQi85bVdBdFpHcWFrV21SVTY0OEQ1TXZi?=
 =?utf-8?B?UUlzdGFFa04wRDRIOG5wRnRDbGYrZjlkWUdiNXAvM3JZV0JHYXZKQ0xMU3Fk?=
 =?utf-8?B?bUF1WjZja09wb3hiVWZ5elhwbjhmT2RnYldDdEM0V001MUQreDM5QVNhbUpy?=
 =?utf-8?B?Q0FmdVREM0M2ZmVlZS9GWUpoY215UkNNRHJJNWhxRURMZXJWUmpiK3ByUURK?=
 =?utf-8?B?NDl1RzVJMWxuZGlwQktERzZPaEpUdExQODczM0RXY2ZVOHZtaU9qdlNGNlJw?=
 =?utf-8?B?RnN4Ry9YUk91VndRZXc2TjdqVnRGV2UwaW1RKzBFTlJwREhvV1FLZzQ1RU5L?=
 =?utf-8?B?QnVXd1I3RldLd0VyMWladFRtTDRsa1JIRVpjQmcrZ2xCYm5seXRscmhrbnVU?=
 =?utf-8?B?ZmxGWko2cHFwTitvQ3FXVjlHZGg5NTJwbmw1VHlueEpPSFBuQVpYOXNNSHFk?=
 =?utf-8?B?am1keWRrVkU1cVduMHFiYlJxa2ZFL0U0blVram9EaW1UOEtta1RCSEt3ZWcz?=
 =?utf-8?B?dzNEMWhKeUV5OVRRdmtoenJWZ2pnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <118FDED6FD636B4987D59F8BF694D5B6@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3aab2a-e40c-4b9f-cdb5-08da75424c41
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 11:21:23.3393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jXTuE9LCwQQ6uaInIhd7DfJy1qOOsuSJK4SlJwYSm0zl4N/mJsJPHzNh2WBoj4/gHzhfCdtt94z3hVn95+tOGHFKQzD4i3MDDVHFnxioiiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2449
Received-SPF: pass (spool3: domain of siemens.com designates 40.107.20.54 as permitted sender) client-ip=40.107.20.54; envelope-from=florian.bezdeka@siemens.com; helo=EUR05-DB8-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=E4yUcpVD;
	dmarc=pass (policy=none) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of florian.bezdeka@siemens.com designates 40.107.20.54 as permitted sender) smtp.mailfrom=florian.bezdeka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1")

T24gVHVlLCAyMDIyLTA4LTAyIGF0IDE3OjA4ICswMDAwLCBCZXpkZWthLCBGbG9yaWFuIHdyb3Rl
Og0KPiBPbiBUdWUsIDIwMjItMDgtMDIgYXQgMTY6NTcgKzAwMDAsIEJlemRla2EsIEZsb3JpYW4g
d3JvdGU6DQo+ID4gSGkgS29uc3RhbnRpbiwNCj4gPiANCj4gPiBPbiBUdWUsIDIwMjItMDgtMDIg
YXQgMDk6NDYgLTA3MDAsIEtvbnN0YW50aW4gU21vbGEgd3JvdGU6DQo+ID4gPiBUaGUgcnRuZXQg
aW50ZXJmYWNlIHdhcyBsYWNraW5nIDMyLWJpdCBzdXBwb3J0IGZvciBiaW5kIGFuZCBjb25uZWN0
IGlvY3RsLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBLb25zdGFudGluIFNtb2xhIDxr
c21vbGE1MUBnbWFpbC5jb20+DQo+ID4gPiAtLS0NCj4gPiANCj4gPiBoYXZlIHlvdSBydW4gY2hl
Y2twYXRjaCBhZ2FpbnN0IHRoaXMgcGF0Y2g/IEdldHRpbmcgYSBsb3Qgb2Ygd2FybmluZ3MNCj4g
PiBoZXJlLi4uIA0KPiA+IA0KPiANCj4gT25lIG1vcmUgdGhpbmc6DQo+IA0KPiBJIHdhcyBsb29r
aW5nIGludG8gdGhlIHNtb2tleSBuZXRfdWRwIHRlc3QgdG9kYXkgYXMgd2VsbC4gSXQgaXMgdGhl
DQo+IGxhc3QgZmFpbGluZyB0ZXN0IGZvciBteSB5MjAzOCBxdWV1ZSBbMV0uIEV2ZW4gd2l0aCB0
aGlzIHBhdGNoIGFwcGxpZWQNCj4gaXQgc3RpbGwgZmFpbHMgYXQgdGhlIElPQ19SVF9JRklORk8g
aW9jdGwuDQo+IA0KPiBJIGhhdmUgbm90IHNwZW50IG11Y2ggdGltZSBvbiB0aGF0IGlzc3VlIHNv
IGZhci4gTW9yZSBpbnZlc3RpZ2F0aW9ucw0KPiB3aWxsIGZvbGxvdy4gU28gZmFyIEkgb25seSBu
b3RpY2VkIHRoYXQgcnRkbV9mZF9nZXQoKSByZXR1cm5zIGFuIGVycm9yLA0KPiB1bmNsZWFyIHdo
eS4NCg0KRmlndXJlZCBpdCBvdXQuIHJ0bmV0IGlzIG1pc3NpbmcgdGhlIGNvbXBhdF9pb2N0bCBt
ZW1iZXIgb2YgaXRzIHN0cnVjdA0KZmlsZV9vcGVyYXRpb25zIGR1cmluZyBkZXZpY2UgcmVnaXN0
cmF0aW9uLiBQYXRjaCB3aWxsIGZvbGxvdy4gDQoNCj4gDQo+IFBsZWFzZSBub3RlIHRoYXQgd2Ug
aGF2ZSBhbiBvcGVuIHRlc3QgaXNzdWUgaGVyZSBhcyB3ZWxsOg0KPiBodHRwczovL2dpdGxhYi5j
b20vWGVub21haS94ZW5vbWFpLWhhY2tlci1zcGFjZS8tL2lzc3Vlcy8yMQ0KPiANCj4gSSBmZWVs
IHRoZXJlIGlzIHN0aWxsIG1vcmUgd29yayBuZWNlc3NhcnkgdG8gZnVsbHkgcmVwYWlyIHJ0ZG0g
aW4NCj4gY29tcGF0IG1vZGUuDQo+IA0KPiBbMV0gaHR0cHM6Ly9naXRsYWIuY29tL1hlbm9tYWkv
eGVub21haS1oYWNrZXItc3BhY2UvLS90cmVlL2Zsb3JpYW4veTIwMzgNCj4gDQo+ID4gQmVzdCBy
ZWdhcmRzLA0KPiA+IEZsb3JpYW4NCj4gDQoNCg==
