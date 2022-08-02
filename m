Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46377F
	for <xenomai@lists.linux.dev>; Tue,  2 Aug 2022 16:58:09 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 16370C0003
	for <xenomai@lists.linux.dev>; Tue,  2 Aug 2022 16:58:01 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 7D6B6740002
	for <xenomai@xenomai.org>; Tue,  2 Aug 2022 16:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yf7Sfz9eh/x8d0ROIh0O2t6/vo7jpk9MA0rnlncJR5QPAzuvI2w22znWzOSQVAZ/oS0t/fA88+ajX/ZN3eRpCDl1F+dYIUj/K4NYTS6O4KRrdDdMWBIeaiB8nVzBeQSJtLQ9PG7tdLJ032AL9oyK5B6PflImjYfzENvCdRQNQnLCeruAfthZJuDDHGw5ZAfQct+sGbJ5tQwO4MUeo+fBJpU0HC23Rm1j/W0Ob8HioF4hwJYXTy8oKoXr7IrZfo5HxumbM6oKFl+Tl0RSsBfqIF372pjr+PAEAl0Lyt0Ockhm6+FcI9NtqJjffkVX7u62J294HmJ2E+YjbqVJkx4wNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcUWLvOs0Pa2iAkJG5fKCjzolKIiOTAsqpSop3B/X0s=;
 b=KbCl70hSQF+0jUa2Cxs9XzofuCqDrrZAVDZS3hona9MMxJproGSQoLjko5Fp5jO29KqZVtp6CApVsica9FaHfP/R2PhSh72ub+g8hju+ZAmI9ETPJ+s+5rsiv75nOHI55hilJ5bF78uTjAuXWY2m7Z2af7vFXgbxukcjX0IHEyWlLPvtohmKxvnunBn5v764uhjK0TcOJmYD2bPsduJJwvWYV8sr4CmVk2cF/gcJy/7egTdv2qB33gpNwnm6GO4AEauVhXC8we0PZV0zeR7P/BBO+037qVZdKC6opKIp/+Mj1g/CNYicNRKaDkG5A2Vbxx24ualjdoS4iRRHfLcYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcUWLvOs0Pa2iAkJG5fKCjzolKIiOTAsqpSop3B/X0s=;
 b=uFmJLDQ1bsKkdncAZi0PyBThTwZdV8cvdmOh04UAP+hMeZ1YZk8QmuhcLvb1OTCE9Zdt2DECbTklw7dJvfhgu/Y/YrTvgHioDXeg8Fetsfm82x8CxdTWBTnCgZi9NoeUgSFowgiwj2moxyCIKWdr5juXCUF522IflIrkzxqNrlFA18ek29GHuA08cEzemdVS9cS6ASblUn4PEM/VW4U4888TWiDZzetHjZfT/wBvcb5Tmnwr03samOPeSomAO//DHGSeY/ln/Ok7RjpNmRedA5x9fc0jPzMgTo+tQ0Z2Z8CIMzjQXmhQtW2Q0bDsq32mj/470VRZOqAu7y6nwBJSCw==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AS2PR10MB6847.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 16:57:59 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 16:57:59 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "ksmola51@gmail.com" <ksmola51@gmail.com>, "xenomai@xenomai.org"
	<xenomai@xenomai.org>
Subject: Re: [PATCH 1/1] drivers/net/stack/ipv4/udp/udp.c: added 32-bit compat
Thread-Topic: [PATCH 1/1] drivers/net/stack/ipv4/udp/udp.c: added 32-bit
 compat
Thread-Index: AQHYpo+LrIsVWE3eXE2kID+4yx1Omq2b1OkA
Date: Tue, 2 Aug 2022 16:57:59 +0000
Message-ID: <55a4975055367ceadd17446d311b0147f0621939.camel@siemens.com>
References: <1659458811-3014-1-git-send-email-ksmola51@gmail.com>
In-Reply-To: <1659458811-3014-1-git-send-email-ksmola51@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.3 (3.44.3-1.fc36) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8733673-a508-4059-b589-08da74a8279b
x-ms-traffictypediagnostic: AS2PR10MB6847:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FwzgNEQkh3pVvnX+7u/+zie1RVSvo46YGydTLiWT4kA/YYR134V/LJmvlT0ddhnPidP0OoPark9dIZxgO1maYUpUpirkpTwKv1+wTi+P8qMrIn0eMnyovaVXPMaBjBKhbjfSNVGxdeqdSBh/0S1Zg854npx0pd0Zpdc8ebRc8J2+J0m37anPViT8Zw/L+B6UU6kALaFrih3FCodNP/KIGLNIrHK/u2LKsY7YzMCEF1g42bJCee2/afFZC0VIo+yAZMOuARX8Vhy9M4kbnlQAACH15OtYyRc/Dxn0e8x6tvOnyalTInG6d2Z2xhRi4YXn/thF9/Lt2YOy/EhBl1p0DTUL1OBJAza/mz5O08dhXAH4zxhLtgmnC6s6tfUr0Q5VXCLZ0G4niS4JFGKnHFA9ALIR7JjIF8Xa5ZFaYVki6QQABrlWB2qOOSXKiPr1GQm+Pn95VIEvQzIdmpBVSA9C/UcSp44VLPBAsz6rCACWnGZZ9Z8322x9MltI6PI+OjwBzRgUUEdM2ePUVqWRxnkyAKjET1/ddaLi4j8nuBdLh51sR8uO1PY+LxBPGcjQ6DPG86Y+fo+sjL6ytRTGUPBpVS0dbJ9D0O5gTKmO5Xlvi9Fujp7EhUHtTDNxfkMNNbBAVWgoT2V/XNuz97HJx3EcajeaUzTIOlYiLjJ+JAVJ5snywPJHziPo6Sa5ok1OndGkKMexLCd2IeiKBx2uFrWj3QsOpgagQzev1e7Mg0vOJIts2fthKMgXhuJSKjQjpoRf/ENO9e1qDB6es/mtcSZyPll+JK5zo3V14lR3Rct+JRiE2+Up75seRkRsYK5iOIXI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(6486002)(5660300002)(86362001)(316002)(64756008)(71200400001)(76116006)(66946007)(91956017)(66556008)(8936002)(8676002)(66476007)(82960400001)(110136005)(38070700005)(558084003)(6512007)(36756003)(66446008)(2616005)(186003)(38100700002)(478600001)(122000001)(83380400001)(6506007)(41300700001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODFlTTRiNU1FanE2N2crclI1bUFGUXBGNEdwODdmOVFpZVI1WWpWclB5dGdX?=
 =?utf-8?B?cWtrMHNWTDFFemZTVGJsVlgyT2s2SmJkbnpQTmszYnZCM0RTcWlxR3NlWjVF?=
 =?utf-8?B?NVVwdUF5K0RiUit2SzRuQkk2Yk5nT0FYK1FualgyMU9HRGx6WFB3RVk4SlUr?=
 =?utf-8?B?VUpWWkF5K09SY1YzK1d2eVZJY1BJd01nTUVUc0tCYjd2RkgyQjgxSVYvK21y?=
 =?utf-8?B?dXU5ZUhFTVpPSkVWcGM3WmNzR0MxUWpEMVlkMkthUU0ySkgvVXp3R0hWWUww?=
 =?utf-8?B?eGZHTmh4RVBEY3UzZHdsMytYLzNOaW9YbjAyYkxLZlNjTGZTQmRSak9WL1FL?=
 =?utf-8?B?VFlXdm9KZ1ZuaFNDQ01KWjBZNkg5QTZGeFNzVFdPT0dWVS8xMS9uenNJNk1M?=
 =?utf-8?B?anc4Q2NSVERIak9TSzFDUkc4dmxnc0hmdXRDNHJZR3I4dFY1Q2FzVWluRGdh?=
 =?utf-8?B?QWh4RUhxODZ5VjNQYkMrb1gyQ1ZxTnN0WVFSTnFTcWpreHozOUZhZEZwemlv?=
 =?utf-8?B?RWJoRUVVdGx4QzJBbTBvc1JTOStSUjBNdmVMdXpRTHByUm1xSk1GUGlLTkVQ?=
 =?utf-8?B?NTlkV0ZXUlZmM2ZrNjdlWHlvenR3TktqblhZbXdvbFROMS9QUGFFcnFoMTdZ?=
 =?utf-8?B?eFJLNS95aHh6WW1GWldtdTdUMWVzM3ZDbWlPL0V0K0tzVmZpdDdpM2Y1S1hR?=
 =?utf-8?B?TEs3d2tjSEZ4UTBobmJGSjlMOURqZTR1ZFZiWmQvQVA5a0ZGTkttNUdGWUR2?=
 =?utf-8?B?Qks1RnlNdFprQzdyZmNUcVdGSElNbVg0RUlaVkQ4UVZEdXlUZjNDWE5HdVB0?=
 =?utf-8?B?aGJxUG1WOEpvaGh0Z2g0UUJHOWpGc1MwMnV2U3kvOUFHRE9wYnNIS1BOUHl2?=
 =?utf-8?B?Q3JxTDJjUnRzY3k2dEJYVmMwbGM4Y1c3cWJoYUs1U0NtendWTXpWNzN2WHky?=
 =?utf-8?B?eFEvZEVCZjM3TG4rN094RjVEZmxxYUNhOFluSXlrNitQZkJWSVRpeXVLQlo0?=
 =?utf-8?B?eU1NaHhOTUtiWUhKZndiUDdNcVl5NTZiMSt1cm5yd1RRVE9UZFllOHNWRXNm?=
 =?utf-8?B?eDZzWUZvY0hRZUZzYnpoNzI0RzFwZEZnUnBETzJIUUVkc3hQU3pSVzFwSDJW?=
 =?utf-8?B?NVpVSXN5bXZ5dVBIYnptbWErOHBmd2k0MjRKNW9JQ1NpcVBvQ2Q5bjEzeURx?=
 =?utf-8?B?VXpMVEEwbWphVXI3dmVwVzA3c2l2TzZnQ2IveDdMQ2w2LzlZQm4reXZnbTN1?=
 =?utf-8?B?Vm1RQUo3T1RVc2tzQTJrOFdFcnpsZDdmVWpCNjRxMUxLSnZBMlg1QzRXU0Yz?=
 =?utf-8?B?a3VJZ21IeG5jYjNhTndSUFB3b3pNb29qdGg1VGFwRGY3WmdwUU5FcWo4dTJ4?=
 =?utf-8?B?Tm9nMzZnVVcrT0tDcHR6NU9jUndNdExCTzJaczZyeFAvUU1iQ09iTTVMWktk?=
 =?utf-8?B?U2JRaEUzUVlGclNxQnozcHpCZTlkNUxtZzZNVGFqVDYwYUFSK0kzNFRrTlBq?=
 =?utf-8?B?cHlUZk9nNDlqU2h4RUtkWS9McHByUFVSMFM1enNuMG5VTVFRcUFmWUo0SXZ2?=
 =?utf-8?B?SUNOSTVmakpobTA3enFtTnF1RzFQNkpULzZMVTVCaGNDUE5VNzRjT2J2bm9B?=
 =?utf-8?B?bCtHaTlkR0RvbkFja0dqUlJHM1RERldDZndJWEEvNmFVZG11TnEzak01eXkz?=
 =?utf-8?B?T3o2ZmowaTFvaWtpMVJrQ1h5ZHdJcXNMMlU1KzViY0JBQjRzTXdSYVIybG1o?=
 =?utf-8?B?eVFlTU1rSlovLzVZMzVaeStCMkpvZWJvM3lNU0xNb01UK1NhVm1QeTZsTVg0?=
 =?utf-8?B?Y1J0N3VYdStKUy9TbW1rYTVuU2V6UHJIb3pKSkFwU2hwa1VTc1krejJrR2Zy?=
 =?utf-8?B?Wld4QmNUeGkrR1RtUUN4Tlk2bHdZOUFYMFJIYXlnQys0dU5leDZYL2ZSdVFF?=
 =?utf-8?B?M1liTGVDNlJPN1V3QVBWSU5VMmt1d01FZFJydGZ3VXBxL0Z6NVEybml3NGd0?=
 =?utf-8?B?ejZkQzgwS3dZYUgwYklQTEdNY0NNNmU5K0kvZjlpeUp5cDF6VXdMQS9kL3hs?=
 =?utf-8?B?OCtkL2F5bmxQY0RoS3lUL0xPUjR0OEpWSlJ1TGd4SlJlbU5FajRLeDhWT3RV?=
 =?utf-8?B?eDg5eStHMVViempDTFJKMDlld29hL1NyTnNKTGp6Slp6clB3N3h1WnJvVGtv?=
 =?utf-8?B?YlZ0eVZNVUhBWFJDQks3V3RPZU9XK3NqRlNKS1h3WDZYR1B6QllQbVRIZTgx?=
 =?utf-8?B?aEp1bU4rd1U0d3FFWUZjTnRsNGJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB733AFF04E09C4CAF53FE1717919196@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c8733673-a508-4059-b589-08da74a8279b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 16:57:59.3565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KAXyBg/VOtIE2mNfEEG0uzIBEScxt0vEScNZJuWeCUWoPX9vFcpOaOK7bMkDvbIygT/9MX5HG96qMW8ycz16YxcPvte+7kcf8G/ojh/imM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6847
Received-SPF: pass (spool2: domain of siemens.com designates 40.107.20.50 as permitted sender) client-ip=40.107.20.50; envelope-from=florian.bezdeka@siemens.com; helo=EUR05-DB8-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=uFmJLDQ1;
	spf=pass (spool.mail.gandi.net: domain of florian.bezdeka@siemens.com designates 40.107.20.50 as permitted sender) smtp.mailfrom=florian.bezdeka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=none) header.from=siemens.com

SGkgS29uc3RhbnRpbiwNCg0KT24gVHVlLCAyMDIyLTA4LTAyIGF0IDA5OjQ2IC0wNzAwLCBLb25z
dGFudGluIFNtb2xhIHdyb3RlOg0KPiBUaGUgcnRuZXQgaW50ZXJmYWNlIHdhcyBsYWNraW5nIDMy
LWJpdCBzdXBwb3J0IGZvciBiaW5kIGFuZCBjb25uZWN0IGlvY3RsLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogS29uc3RhbnRpbiBTbW9sYSA8a3Ntb2xhNTFAZ21haWwuY29tPg0KPiAtLS0NCg0KaGF2
ZSB5b3UgcnVuIGNoZWNrcGF0Y2ggYWdhaW5zdCB0aGlzIHBhdGNoPyBHZXR0aW5nIGEgbG90IG9m
IHdhcm5pbmdzDQpoZXJlLi4uIA0KDQpCZXN0IHJlZ2FyZHMsDQpGbG9yaWFuDQo=
