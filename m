Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7074715CC
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 14:33:02 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 5F52AE0015
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 14:33:00 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 621DA780468
	for <xenomai@xenomai.org>; Mon,  4 Jul 2022 14:32:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOpEi4Zwp9qZIRIiJy/ILD/V6corzpGcQqTKz4SqFWnQ5FFj3h7KnvhkMH2PGv2og1OXSKw/gutufqnSmwz1++ThempP5oa76zG4ZwAMiqLl16iwkbUFJ41C1WU/vIKsHR/GUa2xr6WW6KMHFZ9RwdQ0yCZosHwnD1hGBqpiJ1QuNLO2xhLnIfKFBcUO8jIrSzn20zuAb5J2s0+htqVQrGRtJ1BUBKjyu8UOzCK+x5/EIMa82sRi0o96/5eMiYJT6K31AxP6HZk/5kRoCPZN+QazDD8kjpwmnrPR9bC1X5FMyyx/26YLbuAf1i+HppomFD18TnEliQ7LED8+vXn1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TFanJ9JXm6oVYXvHuCZdmrKuE+LJD8/R+bgWOTprRQ=;
 b=PWLkgir4huomuEfLw/PajBkk8EQqLOXibAy/SxdHyKR2TKn9EJ8lhhWQOHTiY+kjoDcO+Tf1oHaeNashzsa5+b1CE0Ii+T+4kpRuBn0cNsO2n3sxmSXh1XBtxSwtxjfLEjEn7A0uB/IuYFPpLWPA5QhbmA2r3dQTF89XhP5GBoH6Aw36HjM9j8RZqNAiC91HNcGv+sTMcImZw7UDY5qdM831G/6S1U43Ns4ZtaYv10K+EsFIOwz3ww/Luh94qTn6p18O1PUfckXJ07AUMGFEaTYSa6gL4pSkwUbq+AzAtABu4EcuYIlRsKiEqYXPIpn/LNfhxH5McKHVjofW1x6DFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TFanJ9JXm6oVYXvHuCZdmrKuE+LJD8/R+bgWOTprRQ=;
 b=EU9+gavbtnjLQd0tXUdU3s9cD2DxvQ98XwP0rH6VJX0pBzSDLYqQWnqX6b1JYB9VV3mBa7p4stzyCoF0s7u7PwoasePVmv9mWgfcMnIarpPQuLS2tt5wTq1/vDM+edtD9utYAliXvbrYP+6FuhPanfbPSe2/49A5c0726DJsoWcdOSmy5TCxDtzIhQEaUxYOsWUktRvrLa39hc2u3Ka/heAYuSEq/bpUAGHZvjUXwrJzr/Hew4ZnvDdTEfaF9L/sDsarditZIlSGKdKkf6CI/B7K7r+qVHTavgYKRJST6B5h5wJow6Y09wGjZO2Qoqc1tU2txUGMgLXQ8bRpWcEgZg==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by PA4PR10MB4461.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:100::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 14:32:58 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::31fa:3b8c:f022:4ac4]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::31fa:3b8c:f022:4ac4%4]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 14:32:58 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>
CC: "gunter.grau@philips.com" <gunter.grau@philips.com>
Subject: Re: [PATCH 05/15] drivers/net: Switch to dev_addr_set
Thread-Topic: [PATCH 05/15] drivers/net: Switch to dev_addr_set
Thread-Index: AQHYj6dIF5BpXiXHPEqAcW1RxWvyKq1uRpmA
Date: Mon, 4 Jul 2022 14:32:58 +0000
Message-ID: <3bc48f68be16235291bae284fb438ec25b7679f4.camel@siemens.com>
References: <cover.1656940114.git.jan.kiszka@siemens.com>
	 <fed48b9dd1275fd788bbbc3571608b07b88d681e.1656940114.git.jan.kiszka@siemens.com>
In-Reply-To:
 <fed48b9dd1275fd788bbbc3571608b07b88d681e.1656940114.git.jan.kiszka@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.2 (3.44.2-1.fc36) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a665d95-6b03-423b-5238-08da5dca1770
x-ms-traffictypediagnostic: PA4PR10MB4461:EE_
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2xEOszhYwX3AM+ojvGRzl3Wgp0M5F/0hF7m2iHaZH7rUq1+OuPjkO0zvKMQowTvjGTLokV/lRU0tcecNgVjZ0BpisZWFS0OREQTIiwIOpq809w4r8Ttsad1oyxoFBjIqWoGRty35opIgFN3z88Sn1RSfTCI4IBlHNIAcuyWXb6+UiP/1clSPVCc+jQbgoSCdxn9IU7yFixKnqvqcDW3hI1MYpb/wYu59UCWF3LUjq7UUR+051lj1ihhZy4kt/0fXzcYUhKiZ4DBDnsBT6VI/0trWl4KZRbzLyTu3LnDjUY/tkv8vVwH75Wmd8f/R4XiH0ecVyM+HAlrfO0AFv6mreH0nHljmkvQNrhaS2sD43bt2AaTQ1zuzeP7ju3TkXINY0Qe5Nga1p58CpX+Xy1VULe9Vpa9WD1zfol6zGXW0ZwRpKGokuyDwPRrHD71W+cGcl39yogCpSRO8gWHgYYchTDM+uOUWcLSwaeQt9mNjDMKUAiEDW0dJt+E9H+G/zVg+vUsBwjZPX5E0tuFUwYgsYx56FuQKT3CmkcL6GgfikhoaZuyfMEHL7O6x/9KQJ4yWhdZMT/PLVNI2iua6mbGoGl8ITbjTOMGxMkMmBtz18V4Cwjmatghl6mlMu+oBEsSb7uYmzJG8YzV8xY4RYMm6XfjgEBnqpUFQZJgbofiIWRHxfSbIFs/zgwWqAV7SnDDRw0dTUJxGiHqW35qXYY4doMZsxwpa5DXwuS9nFL5D6dRYk6VWTTBjqrGFsJS/rfCGtt5dNcXf1y8JZUA0WOp3zJ6wL0Kg8XqkUHxbrIi08426q2PozDrfT1qPNB+plxTL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(5660300002)(6486002)(8676002)(316002)(91956017)(66446008)(6636002)(110136005)(6512007)(82960400001)(41300700001)(6506007)(86362001)(4326008)(8936002)(76116006)(66946007)(38070700005)(478600001)(122000001)(71200400001)(66556008)(66476007)(64756008)(36756003)(186003)(38100700002)(2906002)(83380400001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UlFwRVhlN01WQ2pYckVveWhxMHJVMkdYTjROWUV2aWwrRk16aFNRU2VjaCti?=
 =?utf-8?B?eXBvTGhHWG9TVHJXQjJQV3lYbVJqV25OTHhJNnc2VFROVm9uTXI3cUpSQnlv?=
 =?utf-8?B?T1QrVGNnZGFON1F1TThIY3QrbCtMeXV3blloOG1XeUs0aDdkYXF0dkdMNEIw?=
 =?utf-8?B?eURyaU9LRWFOMm1NRkI0NkJOMGJuTWRlWjByL25GMjdoVEpYQzRZSm1pbVdF?=
 =?utf-8?B?YVVxWGNyWFBoYWxwMHZPVjByVTc5NEdYMWxhdkNzcUxaTnY5WmZnekdabWk0?=
 =?utf-8?B?SHlmL2UraUpDdjlYWjRWaUVjTVcrMjFUcXVpY3BUbDRwYWVIWk12M3p1Kzlx?=
 =?utf-8?B?c0Z5b0FrNDBJdzVSY2lraEp2OTFsaVFZZCtmeVdFaldaWjJhZHN2MTAzS2Ir?=
 =?utf-8?B?UUV2ZDNhaHhZYytzWGJDSVZIZmo3ZnRuYk9PVlRUV3VqRHJscnk3bnZkVklP?=
 =?utf-8?B?Wk1qWVlhQnllS1VWbHQ1Z05aUGhOczdmZGFqYlpaZGhCTVphbFZWSmJDQnpK?=
 =?utf-8?B?N1hOdFEwRXdJTTQ5M09ERHNybWRZZWcrTkxKdmh3anNUeVV5Y2FMNUF6bFQ2?=
 =?utf-8?B?bnFGdkduc3hpZVB4ZWg0UGxnNnN1cDZJRUhyenVLYmh1NFBaQnJxY2pveGJI?=
 =?utf-8?B?UzVybThtME1wWTNGV09MalBlSFB4cE9Id0JuMTMxcE1BTVo2cFZoWW9OaU5W?=
 =?utf-8?B?RkRJVEx1VEhiazVhakRLQXQyZ1lSb1NQUVY4RzlTVTlpYnRrMWxJdU9ObFo5?=
 =?utf-8?B?NlpWT0N1YjJ1RzRlbWZLVGJDb1Z3QWRGSWFXREFQejlxUnRFZmovUlluK1h6?=
 =?utf-8?B?SE5KQUx4MW8rYnllWnU0T0ZYZHprV01FSEpYZXFWYlZ3MTk4bkQ5VVBjaGVn?=
 =?utf-8?B?QkJ2eS9LdjFMVGIrMkdwNjYvTlYxdk9DcldwRlpyYThiWWM4RUI0S09HYVpP?=
 =?utf-8?B?ZXZzVWFoYzN1NXhqeUVLTCtNUUw3WlFMcDVzR2F6QXBEUXpzOTFCZ2tyTGZF?=
 =?utf-8?B?VDBYaXZFTjJ6Z0dqMHoxbDB1Z0dEUVZFM3FSYzVleHZ1dkhzWDl2dStPUHk3?=
 =?utf-8?B?TmR1WWZnbFVEaXZ6RTBJdW9KKy9lb1VPaTdzL2pxVW8wUWhwOHE4WW42YnNl?=
 =?utf-8?B?VjljWU1QbVZsV0ttNCt5My9PdW5YaG5hZXdJWnFPeWZWRTNFMTYyY1RmYzly?=
 =?utf-8?B?VkJQS0owSnRjdHNpSkY3N1BZbEYyNjE1WXVVdTl5NEt1dm9nS0tRWS9WM05a?=
 =?utf-8?B?UFVwTUNaQUVqOGkvYjMvUHhNRnl1N0tSSy9jYkRadUJ3bmU4d04zSVNVUFk0?=
 =?utf-8?B?dVdqN01wYzIxQnpHRTBnMDJYakRsSUhRT0lCUTl1cUZwQ0hGbEUvWUx1djZB?=
 =?utf-8?B?eGFQemduWEN4SXU3NmxLM2E5TXBIaStaQXpDL1dqcUQ0WmtidHgxcXMwekdN?=
 =?utf-8?B?Y3VoaXYxRlRQNERoMzRMUDd3UjVOWCtIUkNYaDZWdC92bnhPaVlNUnF2Zndp?=
 =?utf-8?B?YWszWjdudU9PdWYxOU9vb0RGNFAyTXVDSDd3TGV3MFNvZUJOV05kQ3Jucjgz?=
 =?utf-8?B?akJMaGRzNUF5aG50S0V1dzc5U2lVNkdyckdKTDd2WitqcVFVUU5BcUNmU0FT?=
 =?utf-8?B?WXdGMFJveEFuVDFsUkptdnRPQXZaNGFoVnNUV09BY2x6d2t2dEpFQWppZGJv?=
 =?utf-8?B?NElVb3ZZSFlWL3phOWZiN3pQdWFOS1Rvbi8rWVNlK0tYU290eitpVEo5aWw5?=
 =?utf-8?B?K3JkYmlqSFE3cmFwVUxtaDdKMnFOakQ4RDlaWThueXU2ekFiK1R0dHE5N2Qz?=
 =?utf-8?B?RmZlRE83UlRTQkY1a1pHWGpLQUFQQ1NuSFhiZ0hJM3JMZEpUZlpMTGdaNzUr?=
 =?utf-8?B?S3VDU2VUWWNyUStRMnRJU212bXBBMGJLeDFpaldCek9STEN2dFJTbjh4N0FO?=
 =?utf-8?B?M2VUYmNJYURyNTZ3dGt2ZlVkb2kvS0lYR2ZGckVRQ3VUc2xMT1IzVzRVZ2dz?=
 =?utf-8?B?ek5uNUxiMUdNa2VnKzRIUzV6SDlqUEUyVnpiMGdNM0FDalRKTFhNWGZBWEwx?=
 =?utf-8?B?R2dIWmduanhoTit3dWxmUWZDQnZsMDN0YmlFVXoxbmQ0UUpQcEp1aTRWeU0y?=
 =?utf-8?B?eWZkUyt5SGF2dUlZTVBJdmRQN2lta1pzTGxpUzIzVnNwNkRBaVEzZVFuWXlB?=
 =?utf-8?B?dDNFdXMxaDIzanVnb0lVQUwxdjBLMnNmUStYK0k1TEk5bHJKdGdiam5uZFc2?=
 =?utf-8?B?L1d4TTRCa2w0RzBYV1dyNEpnZUZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52B1F66E1D81D2449F11D85F94540C31@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a665d95-6b03-423b-5238-08da5dca1770
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 14:32:58.4204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sjCFgTzdwgxXwr0ROJ9Kb9BrI/KXVzawNm5S61BTelzQ1Kz5KCJ986oLOzwhKzT5P7dMVNECVu1xGuq0HMTqC/36ivyX/XVpPhIu0CyCtrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4461
Received-SPF: pass (spool4: domain of siemens.com designates 40.107.104.61 as permitted sender) client-ip=40.107.104.61; envelope-from=florian.bezdeka@siemens.com; helo=EUR03-DBA-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=EU9+gavb;
	spf=pass (spool.mail.gandi.net: domain of florian.bezdeka@siemens.com designates 40.107.104.61 as permitted sender) smtp.mailfrom=florian.bezdeka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=none) header.from=siemens.com

T24gTW9uLCAyMDIyLTA3LTA0IGF0IDE1OjA4ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBG
cm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiANCj4gTGF0ZXN0IGtl
cm5lbCBjb21wbGFpbiBhYm91dCBhY2Nlc3NpbmcgZGV2X2FkZHIgZGlyZWN0bHkgYW5kIHB1c2gg
dXMNCj4gdG93YXJkIHRoZSBhY2Nlc3NvciBmdW5jdGlvbnMuIFVzZSB0aGF0IGFuZCBwcm92aWRl
IGEgd3JhcHBlciBmb3INCj4ga2VybmVscyBwcmlvciB0byA1LjE1Lg0KPiANCj4gQ0M6IEd1bnRl
ciBHcmF1IDxndW50ZXIuZ3JhdUBwaGlsaXBzLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSmFuIEtp
c3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gLS0tDQo+ICBrZXJuZWwvY29iYWx0L2lu
Y2x1ZGUvYXNtLWdlbmVyaWMveGVub21haS93cmFwcGVycy5oIHwgIDQgKysrKw0KPiAga2VybmVs
L2RyaXZlcnMvbmV0L2FkZG9ucy9jYXAuYyAgICAgICAgICAgICAgICAgICAgICB8ICA1ICsrLS0t
DQo+ICBrZXJuZWwvZHJpdmVycy9uZXQvYWRkb25zL3Byb3h5LmMgICAgICAgICAgICAgICAgICAg
IHwgIDIgKy0NCj4gIGtlcm5lbC9kcml2ZXJzL25ldC9kcml2ZXJzL2ZyZWVzY2FsZS9mZWNfbWFp
bi5jICAgICAgfCAxMSArKysrKysrLS0tLQ0KPiAga2VybmVsL2RyaXZlcnMvbmV0L3N0YWNrL3J0
bWFjL3J0bWFjX3ZuaWMuYyAgICAgICAgICB8ICA1ICsrLS0tDQo+ICA1IGZpbGVzIGNoYW5nZWQs
IDE2IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2tl
cm5lbC9jb2JhbHQvaW5jbHVkZS9hc20tZ2VuZXJpYy94ZW5vbWFpL3dyYXBwZXJzLmggYi9rZXJu
ZWwvY29iYWx0L2luY2x1ZGUvYXNtLWdlbmVyaWMveGVub21haS93cmFwcGVycy5oDQo+IGluZGV4
IDg4MTUyYTI1ZTEuLjY0ODljODJjOGMgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9jb2JhbHQvaW5j
bHVkZS9hc20tZ2VuZXJpYy94ZW5vbWFpL3dyYXBwZXJzLmgNCj4gKysrIGIva2VybmVsL2NvYmFs
dC9pbmNsdWRlL2FzbS1nZW5lcmljL3hlbm9tYWkvd3JhcHBlcnMuaA0KPiBAQCAtNTQsNiArNTQs
MTAgQEANCj4gICNkZWZpbmUgY2xvc2VfZmQoX191ZmQpCV9fY2xvc2VfZmQoY3VycmVudC0+Zmls
ZXMsIF9fdWZkKQ0KPiAgI2VuZGlmDQo+ICANCj4gKyNpZiBMSU5VWF9WRVJTSU9OX0NPREUgPCBL
RVJORUxfVkVSU0lPTig1LDE1LDApDQo+ICsjZGVmaW5lIGRldl9hZGRyX3NldChkZXYsIGFkZHIp
CW1lbWNweSgoZGV2KS0+ZGV2X2FkZHIsIGFkZHIsIE1BWF9BRERSX0xFTikNCj4gKyNlbmRpZg0K
PiArDQo+ICAjaWYgTElOVVhfVkVSU0lPTl9DT0RFIDwgS0VSTkVMX1ZFUlNJT04oNSwxNywwKQ0K
PiAgI2RlZmluZSBwZGVfZGF0YShpKQlQREVfREFUQShpKQ0KPiAgI2VuZGlmDQo+IGRpZmYgLS1n
aXQgYS9rZXJuZWwvZHJpdmVycy9uZXQvYWRkb25zL2NhcC5jIGIva2VybmVsL2RyaXZlcnMvbmV0
L2FkZG9ucy9jYXAuYw0KPiBpbmRleCAxZTg2NDQwNjk5Li4zNzg0YjY1MjI2IDEwMDY0NA0KPiAt
LS0gYS9rZXJuZWwvZHJpdmVycy9uZXQvYWRkb25zL2NhcC5jDQo+ICsrKyBiL2tlcm5lbC9kcml2
ZXJzL25ldC9hZGRvbnMvY2FwLmMNCj4gQEAgLTI2Myw5ICsyNjMsOCBAQCBzdGF0aWMgaW50IHRh
cF9kZXZfb3BlbihzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KPiAgCWlmIChlcnIgPT0gMCkNCj4g
IAkJcmV0dXJuIC1FSURSTTsNCj4gIA0KPiAtCW1lbWNweShkZXYtPmRldl9hZGRyLA0KPiAtCSAg
ICAgICAoKihzdHJ1Y3QgcnRuZXRfZGV2aWNlICoqKW5ldGRldl9wcml2KGRldikpLT5kZXZfYWRk
ciwNCj4gLQkgICAgICAgTUFYX0FERFJfTEVOKTsNCj4gKwlkZXZfYWRkcl9zZXQoZGV2LA0KPiAr
CQkgICAgICgqKHN0cnVjdCBydG5ldF9kZXZpY2UgKiopbmV0ZGV2X3ByaXYoZGV2KSktPmRldl9h
ZGRyKTsNCj4gIA0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL2Ry
aXZlcnMvbmV0L2FkZG9ucy9wcm94eS5jIGIva2VybmVsL2RyaXZlcnMvbmV0L2FkZG9ucy9wcm94
eS5jDQo+IGluZGV4IGY3MDU4NzY3OGEuLmIzN2I0MmM5ZGUgMTAwNjQ0DQo+IC0tLSBhL2tlcm5l
bC9kcml2ZXJzL25ldC9hZGRvbnMvcHJveHkuYw0KPiArKysgYi9rZXJuZWwvZHJpdmVycy9uZXQv
YWRkb25zL3Byb3h5LmMNCj4gQEAgLTMyMSw3ICszMjEsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQg
cnRuZXRwcm94eV9pbml0KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpDQo+ICANCj4gIAlkZXYtPnR4
X3F1ZXVlX2xlbiA9IDA7DQo+ICAjaWZkZWYgQ09ORklHX1hFTk9fRFJJVkVSU19ORVRfQURET05f
UFJPWFlfQVJQDQo+IC0JbWVtY3B5KGRldi0+ZGV2X2FkZHIsIHJ0bmV0cHJveHlfcnRkZXYtPmRl
dl9hZGRyLCBNQVhfQUREUl9MRU4pOw0KPiArCWRldl9hZGRyX3NldChkZXYsIHJ0bmV0cHJveHlf
cnRkZXYtPmRldl9hZGRyKTsNCj4gICNlbHNlDQo+ICAJZGV2LT5mbGFncyB8PSBJRkZfTk9BUlA7
DQo+ICAjZW5kaWYNCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9kcml2ZXJzL25ldC9kcml2ZXJzL2Zy
ZWVzY2FsZS9mZWNfbWFpbi5jIGIva2VybmVsL2RyaXZlcnMvbmV0L2RyaXZlcnMvZnJlZXNjYWxl
L2ZlY19tYWluLmMNCj4gaW5kZXggYmUwZWQwYzUxZS4uNzJlZTRkZTczOCAxMDA2NDQNCj4gLS0t
IGEva2VybmVsL2RyaXZlcnMvbmV0L2RyaXZlcnMvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gKysr
IGIva2VybmVsL2RyaXZlcnMvbmV0L2RyaXZlcnMvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gQEAg
LTEzMTUsMTEgKzEzMTUsMTQgQEAgc3RhdGljIHZvaWQgZmVjX2dldF9tYWMoc3RydWN0IG5ldF9k
ZXZpY2UgKm5kZXYpDQo+ICAJCXJldHVybjsNCj4gIAl9DQo+ICANCj4gLQltZW1jcHkobmRldi0+
ZGV2X2FkZHIsIGlhcCwgRVRIX0FMRU4pOw0KPiAtDQo+ICAJLyogQWRqdXN0IE1BQyBpZiB1c2lu
ZyBtYWNhZGRyICovDQo+IC0JaWYgKGlhcCA9PSBtYWNhZGRyKQ0KPiAtCQkgbmRldi0+ZGV2X2Fk
ZHJbRVRIX0FMRU4tMV0gPSBtYWNhZGRyW0VUSF9BTEVOLTFdICsgZmVwLT5kZXZfaWQ7DQo+ICsJ
aWYgKGlhcCA9PSBtYWNhZGRyKSB7DQo+ICsJCW1lbWNweSh0bXBhZGRyLCBtYWNhZGRyLCBFVEhf
QUxFTik7DQo+ICsJCXRtcGFkZHJbRVRIX0FMRU4tMV0gKz0gZmVwLT5kZXZfaWQ7DQo+ICsJCWRl
dl9hZGRyX3NldChuZGV2LCB0bXBhZGRyKTsNCg0KT25lIG1vcmUgdGhpbmcgaGVyZToNCg0KZGV2
X2FkZHJfc2V0IHdoZW4gYXZhaWxhYmxlIGluc2lkZSB0aGUga2VybmVsIHVzZXMgbmRldi0+YWRk
cl9sZW4gZm9yDQpwZXJmb3JtaW5nIHRoZSBtZW1jcHkuIERvIHdlIGV2ZXIgc2V0IG5kZXYtPmFk
ZHJfbGVuPw0KDQo+ICsJfSBlbHNlIHsNCj4gKwkJZGV2X2FkZHJfc2V0KG5kZXYsIGlhcCk7DQo+
ICsJfQ0KPiAgfQ0KPiAgDQo+ICAvKiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICovDQo+IGRpZmYgLS1naXQg
YS9rZXJuZWwvZHJpdmVycy9uZXQvc3RhY2svcnRtYWMvcnRtYWNfdm5pYy5jIGIva2VybmVsL2Ry
aXZlcnMvbmV0L3N0YWNrL3J0bWFjL3J0bWFjX3ZuaWMuYw0KPiBpbmRleCAxMzhlMjc2YWQ5Li40
YjQxNzg1ZGI4IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvZHJpdmVycy9uZXQvc3RhY2svcnRtYWMv
cnRtYWNfdm5pYy5jDQo+ICsrKyBiL2tlcm5lbC9kcml2ZXJzL25ldC9zdGFjay9ydG1hYy9ydG1h
Y192bmljLmMNCj4gQEAgLTExNCw5ICsxMTQsOCBAQCBzdGF0aWMgdm9pZCBydG1hY192bmljX3Np
Z25hbF9oYW5kbGVyKHJ0ZG1fbnJ0c2lnX3QgKm5ydHNpZywgdm9pZCAqYXJnKQ0KPiAgDQo+ICBz
dGF0aWMgaW50IHJ0bWFjX3ZuaWNfY29weV9tYWMoc3RydWN0IG5ldF9kZXZpY2UgKmRldikNCj4g
IHsNCj4gLQltZW1jcHkoZGV2LT5kZXZfYWRkciwNCj4gLQkgICAgICAgKCooc3RydWN0IHJ0bmV0
X2RldmljZSAqKiluZXRkZXZfcHJpdihkZXYpKS0+ZGV2X2FkZHIsDQo+IC0JICAgICAgIE1BWF9B
RERSX0xFTik7DQo+ICsJZGV2X2FkZHJfc2V0KGRldiwNCj4gKwkJICAgICAoKihzdHJ1Y3QgcnRu
ZXRfZGV2aWNlICoqKW5ldGRldl9wcml2KGRldikpLT5kZXZfYWRkcik7DQo+ICANCj4gIAlyZXR1
cm4gMDsNCj4gIH0NCg0K
