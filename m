Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD001F163
	for <xenomai@lists.linux.dev>; Thu, 13 Jul 2023 15:45:59 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id C6E361A0003
	for <xenomai@lists.linux.dev>; Thu, 13 Jul 2023 15:45:51 +0000 (UTC)
Received: from USG02-CY1-obe.outbound.protection.office365.us (mail-cy1usg02on0716.outbound.protection.office365.us [IPv6:2001:489a:2202:d::716])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 8F1027803DF
	for <xenomai@xenomai.org>; Thu, 13 Jul 2023 15:45:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=dwwfYG3VknujtRThAhvKCkSIitiUNG6iNxsQZTHwGHes+O4NR9DLFogPz3Go8d4BFgVMNedwbMyfk592z32c5j7Yoev/ZKXDJxekXFVbtkiqdju5sB2nB1GJs8o52uOMcMCrBqygImK08JdgWNJSzTu/StPNZtmC9E/UH8Fu+/u3oNQDS1HTNykhWTJvGWXkWxb5T8RhO3cvAJ2Lb7sTQYA5HbNsoAGTb1wGczawwrnTl6+h+9KOHiGNwHW90SJmV76d02r9Sx+wVr0+vk4RJlCXIrX45GEZUYy/4TxwiVKfUi9RC5drjs8+Wk+g3jUbVQaKwbMa6tnUyuPmkBlx3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNtUhT18hTH6BkOERYnWILKQfQrri+/NrvH7L9bgz8o=;
 b=JoXdXru3nytOlnW+0KWWrYyICBrS2XBkV05F/ieDoCGZlWo0cwxkRWG++UOJ/iWgSuq3My5RwbtPvXLkQCt4XUX7tYeYcPGREtBft2YBw7FjQXeF7tYYfZmP+p1t5WZhtrORVviio9cSHw+sthnTnzs5z1SerzcZh7xyycd4zZVvtb+CcBqujuW1r3whnEGGRamU6cmFfzFOGEk1rWl/HBB3ZONQA07gxX1WgKBqOYiSnOXZPdDkAf2idVn9VtA/X/EZ+PWRMgi+H/ltVvILMeU+ZPiROknW+Lw0X6SeIy3f1jv6rfXb+2tSGAlRp9u65DDTDnsHa7D6aRNiR9JFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=relativityspace.com; dmarc=pass action=none
 header.from=relativityspace.com; dkim=pass header.d=relativityspace.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=relativityspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNtUhT18hTH6BkOERYnWILKQfQrri+/NrvH7L9bgz8o=;
 b=HI6jsjDWm7w9R0xzn3rI9D/EZ113uKsQPXyDVFYPBPqgXb2Ci2rWwzuuZzF1xdt56KZ0Yfbj3CqwJWQLrLbQjXy6pebluNgZvT413yg0n/WU9l5iOgsq/NH6ixWBtaxpyPagD8R9Bq5OR7Zl09pVqHGN01LMX+x/w/89zrIPub8=
Received: from SA1P110MB1278.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:194::20)
 by SA1P110MB1056.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:170::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.45; Thu, 13 Jul
 2023 15:45:45 +0000
Received: from SA1P110MB1278.NAMP110.PROD.OUTLOOK.COM
 ([fe80::3664:f457:a4ce:ac7f]) by SA1P110MB1278.NAMP110.PROD.OUTLOOK.COM
 ([fe80::3664:f457:a4ce:ac7f%6]) with mapi id 15.20.6521.045; Thu, 13 Jul 2023
 15:45:45 +0000
From: Brandon Ho <brho@relativityspace.com>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
CC: Jay Sridharan <jsridharan@relativityspace.com>
Subject: UDP checksum incorrect when using RTnet network driver
Thread-Topic: UDP checksum incorrect when using RTnet network driver
Thread-Index: AQHZtaBDn4K4F1kqg0uumZzUUQmrxw==
Date: Thu, 13 Jul 2023 15:45:45 +0000
Message-ID:
 <SA1P110MB1278E19EF6B5E38108A221CED337A@SA1P110MB1278.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1P110MB1278:EE_|SA1P110MB1056:EE_
x-ms-office365-filtering-correlation-id: 55356d0f-44a2-4fa8-b5b5-08db83b838d0
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pczdCSJRdXlUMCXRUHR1pcMM4GgR0E/RaG8YNxepgCjbiGkETSFaroRjtRBPn9xOd+U+XcNhHbodXnL2K0nEey50Ep2NiJo0+LQ7hUxBxsIPB0FAMbJF1CkyxMUIcB/vdW5fN313K678NMAC7iHTcimYVTFt1B0hen6bOHmX6YNOTR/Yt9rAQEP7KJeJx955xsohfy/pGARdps6MCEjWN36QXmvEIgay0zw0aAJSLpnRJnYhm3geK5NmdWJekZzIU+4IkxvUGIYl2iEwDcQvYAN7KH3tk/eyBrLcDiKVn+gySuMe9K9jI6gGMjBLtkfSkfke/jI79ujmbCSqGyJ6WDsheQshR1psk0tS/xZYniyliLBB2C/V5tR9Q+/88wAHghlfUPGfverceEXPcJGW2Kgq1qYZeEfjHpW3i5NhTXNwpeCZ4cYf05/EdW1YoBAjmwWt7uyNNo4MKYsgTurCJ0EE0gc7Ucg80mvNAyHvEj3rchycml6rxTImtW+8chAXNnq+tD4dQVyYWqQ4hjFfmI3TtGIlj/MGc0eGbBi5ljawY6OHwllXMJRnr6Dplkwceq4zLSpsZFmpHHePgGayrMH1jEaeozrkxSMkqZbGoC1uiU4bZZGpYrufzOMGLVLK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1P110MB1278.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39830400003)(136003)(451199021)(5660300002)(6506007)(26005)(508600001)(2906002)(186003)(9686003)(83380400001)(55016003)(41300700001)(122000001)(86362001)(38070700005)(8676002)(8936002)(38100700002)(7696005)(66446008)(71200400001)(52536014)(66946007)(41320700001)(107886003)(64756008)(966005)(66556008)(4326008)(33656002)(76116006)(6916009)(66476007)(554374003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 USjQ/Pa5ZKCGR6NfMgdj6wvvFRYu1L0cSJiyc9Xlfotzz7wc7d/gQKnelGcVrgDVNHLB1AuxspAn2wc1WL00oZVQLd8bBs5kM0MR/DEUeGgN4Kb5D+9WvgV6+VhRniV5kU7nfy3GJf1LKocBaSxETwZJS1orh2xPL4r/Jp/OJdXsjR80Qa3g0/gLduax1Ebw13XSi9i2DHvkCINVl6fylxQ/sTxovmDILe35oq1MPWVvIEyqQMW5Kt/DgNJAgNDT1f2vzu31gMfVhcixZn5iElBvopWaX2yuYI25rWrmO/BqH+6UFKcg17jw0AFK482jKtYLlR2NHdJlm9JMygfeAx8KboKWS2Ob+iXGj1IaDSW+vPNPqm88xsGTfH323ajoelrBlQsu1QHgFt3dVf89OsCiREMnOJ81IIvPPF4d/t4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: relativityspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1P110MB1278.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 55356d0f-44a2-4fa8-b5b5-08db83b838d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 15:45:45.3455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 95efb839-1b37-48d6-a201-7187831a1c9c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1P110MB1056
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=relativityspace.com header.s=selector1 header.b=HI6jsjDW;
	arc=pass ("microsoft.com:s=arcselector5401:i=1");
	dmarc=pass (policy=reject) header.from=relativityspace.com;
	spf=pass (spool.mail.gandi.net: domain of brho@relativityspace.com designates 2001:489a:2202:d::716 as permitted sender) smtp.mailfrom=brho@relativityspace.com

SGksCgpJIGhhdmUgYmVlbiBwbGF5aW5nIGFyb3VuZCB3aXRoIHRyeWluZyB0byBzZW5kIFVEUCBt
ZXNzYWdlcyBvdmVyIFJUbmV0IGJ1dCBoYXZlIHJ1biBpbnRvIGEgd2VpcmQgYnVnIHdoZXJlIHRo
ZSBVRFAgcGFja2V0cyBzZW50IHdpdGggdGhlIFJUbmV0IG5ldHdvcmsgZHJpdmVyIGVuZCB1cCB3
aXRoIGFuIGluY29ycmVjdCBjaGVja3N1bS4KCkN1cnJlbnRseSBJIGRvIG5vdCBydW4gUlRtYWMg
b3IgdGRtYS4gVGhlIHNjcmlwdCBJIGFtIHJ1bm5pbmcgdG8gc2VuZCB0aGUgVURQIHBhY2tldHMg
aXMgdGhlIGV4YW1wbGUgWGVub21haSBuYXRpdmUgc2NyaXB0IGZyb20gdGhlIFJUbmV0IHJlcG86
Cmh0dHBzOi8vc291cmNlZm9yZ2UubmV0L3AvcnRuZXQvY29kZS9jaS9tYXN0ZXIvdHJlZS9leGFt
cGxlcy94ZW5vbWFpL25hdGl2ZS9mcmFnLWlwLmMKCkkgdXNlIHRoaXMgc2NyaXB0IGxhcmdlbHkg
dW5jaGFuZ2VkIChqdXN0IGNoYW5naW5nIHRoZSBkZXN0L2xvY2FsIGlwIHRvIHRoYXQgb2YgbXkg
ZGV2aWNlcykKCkEgY291cGxlIG1vcmUgZGV0YWlsczogCgpNeSBzdGFydHVwIHNjcmlwdCBmb3Ig
UlRuZXQgaXMgYXMgZm9sbG93cwoK4oCC4oCC4oCC4oCCIG1vZHByb2JlIHJ0bmV0ID4vZGV2L251
bGwgfHwgZXhpdCAxCiAgICAgICAgbW9kcHJvYmUgcnRpcHY0ID4vZGV2L251bGwgfHwgZXhpdCAx
CiAgICAgICAgbW9kcHJvYmUgJFJUX0RSSVZFUiA+L2Rldi9udWxsIHx8IGV4aXQgMQogICAgICAg
IGVjaG8gJEVUSEVSTkVUX1BDSV9CVVNfTlVNID4gL3N5cy9idXMvcGNpL2RldmljZXMvJEVUSEVS
TkVUX1BDSV9CVVNfTlVNL2RyaXZlci91bmJpbmQKICAgICAgICBlY2hvICRFVEhFUk5FVF9QQ0lf
QlVTX05VTSA+IC9zeXMvYnVzL3BjaS9kcml2ZXJzLyRSVF9EUklWRVIvYmluZAogICAgICAgIG1v
ZHByb2JlIHJ0cGFja2V0ID4vZGV2L251bGwgfHwgZXhpdCAxCiAgICAgICAgbW9kcHJvYmUgcnR1
ZHAgPi9kZXYvbnVsbCB8fCBleGl0IDEKICAgICAgICBtb2Rwcm9iZSBydF9sb29wYmFjayA+L2Rl
di9udWxsIHx8IGV4aXQgMQoKICAgICAgICAkUlRJRkNPTkZJRyBydGxvIHVwIDEyNy4wLjAuMSAg
IAogICAgICAgICRSVElGQ09ORklHIHJ0ZXRoMCB1cCAkSVBfQUREUiBuZXRtYXNrICRORVRNQVNL
CiAgICAgICAgc2xlZXAgMwoKICAgICAgICAkUlRST1VURSBzb2xpY2l0ICRIT1NUX0lQIGRldiBy
dGV0aDAKClRoZSBJUF9BRERSIGlzIHRoZSBsb2NhbCBhZGRyZXNzIG9mIHRoZSBkZXZpY2UgYW5k
IHRoZSBIT1NUX0lQIHJlZmVycyB0byB0aGUgZW5kIGhvc3QgSSdkIGxpa2UgdG8gc2VuZCBwYWNr
ZXRzIHRvIC0tIGFsbCBvdGhlciB2YXJzIGZvbGxvdyB0aGUgY29udmVudGlvbiBpbiB0aGUgZGVm
YXVsdCBydG5ldCBzdGFydHVwIHNjcmlwdC4gSSBhbSBhYmxlIHRvIHJ0cGluZyBteSBlbmQgaG9z
dCBzdWNjZXNzZnVsbHkuCgpXaGVuIEkgd2lyZXNoYXJrIG9uIHRoZSBlbmQgaG9zdCAoZGV2aWNl
IHJlY2VpdmluZyB0aGUgVURQIHBhY2tldHMpLCBJIHNlZSB0aGF0IHRoZSBjaGVja3N1bSBpcyBj
b25zaXN0ZW50bHkgd3JvbmcsIGJ1dCB0aGUgZGF0YSBwYXlsb2FkIGlzIGNvcnJlY3QuIFdoZW4g
SSB1bmxvYWQgdGhlIHJ0IGRyaXZlciBmcm9tIHRoZSBuZXR3b3JrIGNhcmQgKHJ0X2UxMDAwZSkg
YW5kIGxvYWQgYmFjayB0aGUgbm9ybWFsIGRyaXZlciAoZTEwMDBlKSB0aGUgY2hlY2tzdW0gaXMg
Y29ycmVjdC4gSnVzdCB3b25kZXJpbmcgd2hhdCBtaWdodCBiZSB3cm9uZy4KClN5c3RlbSBpbmZv
OiAodGhpcyBpcyB3aGF0IEkgc2VlIHdoZW4gSSBydW4geGVuby1jb25maWcgLS1pbmZvKQpYZW5v
bWFpIHZlcnNpb246IFhlbm9tYWkvY29iYWx0IHYzLjIuMiAtLSAjNjJlZGM4YSAoMjAyMy0wMi0y
NCAxODo1MDo1MSArMDEwMCkKTGludXggeHh4eC14eHh4eHh4eC0yIDUuMTUuOTgteGVuMy4yKyAj
NCBTTVAgSVJRUElQRSBUaHUgTWFyIDIzIDAyOjA0OjQ3IFVUQyAyMDIzIHg4Nl82NCB4ODZfNjQg
eDg2XzY0IEdOVS9MaW51eApLZXJuZWwgcGFyYW1ldGVyczogQk9PVF9JTUFHRT0vYm9vdC92bWxp
bnV6LTUuMTUuOTgteGVuMy4yKyByb290PVVVSUQ9ZjIzNmUwOTQtNGE4YS00OWU4LTgyOWYtNDJm
NTRiMWViNWQ4IHJvIHF1aWV0IHNwbGFzaCBpOTE1LmVuYWJsZV9yYzY9MCBpOTE1LmVuYWJsZV9k
Yz0wIG5vYXBpYyBub3NtYXAgeGVub21haS5zbWk9MSB4ZW5vbWFpLmFsbG93ZWRfZ3JvdXA9MzAw
MDAgY3B1aWRsZS5vZmY9MSB2dC5oYW5kb2ZmPTcKQ29iYWx0IGNvcmUgMy4yLjIgZGV0ZWN0ZWQK
Q29tcGlsZXI6IGdjYyB2ZXJzaW9uIDExLjMuMCAoVWJ1bnR1IDExLjMuMC0xdWJ1bnR1MX4yMi4w
NCkKQnVpbGQgYXJnczoKClRoYW5rcyEK
