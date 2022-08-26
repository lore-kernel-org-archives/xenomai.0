Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10958185F
	for <xenomai@lists.linux.dev>; Fri, 26 Aug 2022 02:41:33 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 2E43A100003
	for <xenomai@lists.linux.dev>; Fri, 26 Aug 2022 02:41:26 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from KOR01-SL2-obe.outbound.protection.outlook.com (mail-sl2kor01on2083.outbound.protection.outlook.com [40.107.129.83])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B501DD802C7
	for <xenomai@xenomai.org>; Fri, 26 Aug 2022 02:41:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STARdul8hituCXVeNvy+o8HavEQRVNVh4m8gjSB+Xe8MbHSOTKNqnBEGy4fL+zRZmlrzTAsisVwCMUuq5X+SNZHDA6FSzM3fRHBpx2jMl0AJohWxOOXLgMJJBWlbPyCaJH6zJfSYYhQvfYRjqknaZXyEvoOwpG+grt5Z3UWogN2KJ9KrweSSe/XfSl5NA/TC4/sKr8+ZtSdZiW0hwJYzVBvNFJ7+0Ydagu+5D/X5PhYYHoc4n2PEInqttVMAx6Er2p3B5k5tvHOWhWZUtCU4QIlcHnkEP7kcsJBjcMlBrGhHUY1MkkHrJ+XIf3KQ61bIvXo8un0OWNZ96lZKXbHbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AybpaeTh7lWBOJVLC1+mOtDMFI/facliAUjQI6wYveE=;
 b=SpHKqC/xxNkoFL6ctnEX8q8KcECFaDCyNrTNFSskC6DkmeAnp+iUX2kYD93Au4KYHyQmL3Tvu4eu2CwvyUl58pZ+A5De7oDZrrsqsPeLkNHZtSwoo+0bPKGMZBqT00Qo9vB0XsuS7mWweY01SIYZm8FWNbKXSKc4OXj25axiZItWNfqz3yVTEHdED+kjiwuHREbpDVZLlHXMr9B9LX+p5Bb3Q1O0SF3DNQT+aoqIUDsDCKFzSzW7eaNszU0bqTVe2jNVA9DhAVmCVwxMvwQAgr/S7UUlt4RCow+bHMOmzMC9GullPzKEeQ9kXxqr/W7NUWYI5mMefQE1WijVUcbbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Doosan.onmicrosoft.com; s=selector1-Doosan-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AybpaeTh7lWBOJVLC1+mOtDMFI/facliAUjQI6wYveE=;
 b=0ncLH2mCpWZ/fkvvXHRIPdzQvtkKLve/B/53e/nMOOY8Hcuy+IAR7CeLBy4vZR1wEMlBJCaMFG4pJzTNrDqECIZnwtOroVV6wQgL9aONNGKN7D/eUyA3ICV8wHwq1nepYJOoEFWjIXmFL7Nz9/9KvhVFc+h8f3ThW20Co7N8nhg=
Received: from SE1P216MB1509.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d::8) by
 SLXP216MB0878.KORP216.PROD.OUTLOOK.COM (2603:1096:100:12::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Fri, 26 Aug 2022 02:41:20 +0000
Received: from SE1P216MB1509.KORP216.PROD.OUTLOOK.COM
 ([fe80::9be:2a34:c3aa:a362]) by SE1P216MB1509.KORP216.PROD.OUTLOOK.COM
 ([fe80::9be:2a34:c3aa:a362%8]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 02:41:20 +0000
From: =?utf-8?B?6rmA64+Z7KO8KERvbmdqb28gS2ltKSDssYXsnoTsl7Dqtazsm5Ag65GQ7IKw?=
 =?utf-8?B?66Gc67O07Yux7Iqk?= <dongjoo5.kim@doosan.com>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org"
	<xenomai@xenomai.org>
CC: =?utf-8?B?67CV7JiB7LKgKFlvdW5nY2h1bCBQYXJrKSDsiJjshJ3sl7Dqtazsm5Ag65GQ?=
 =?utf-8?B?7IKw66Gc67O07Yux7Iqk?= <youngchul3.park@doosan.com>,
	=?utf-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDsiJjshJ3sl7Dqtazsm5Ag65GQ?=
 =?utf-8?B?7IKw66Gc67O07Yux7Iqk?= <kyunghoon2.park@doosan.com>,
	=?utf-8?B?6rmA7IS47ZiEKFNlaHl1biBLaW0pIOyXsOq1rOybkCDrkZDsgrDroZzrs7Q=?=
 =?utf-8?B?7Yux7Iqk?= <sehyun2.kim@doosan.com>,
	=?utf-8?B?6rmA64+Z7KO8KERvbmdqb28gS2ltKSDssYXsnoTsl7Dqtazsm5Ag65GQ7IKw?=
 =?utf-8?B?66Gc67O07Yux7Iqk?= <dongjoo5.kim@doosan.com>
Subject: RE: What causes the latency of the rt_task_yield() API?
Thread-Topic: What causes the latency of the rt_task_yield() API?
Thread-Index:
 Adi2hA+8NshNMGH/S1C5hT38XRCzfAABQnKAAEPabkAAHYUU4AADTiNwAAcm6LAABFvNgAAqXeuQ
Date: Fri, 26 Aug 2022 02:41:20 +0000
Message-ID:
 <SE1P216MB1509ED1D62553AC566FDA209B1759@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
References:
 <SE2P216MB1394874A00E10A497FE73DE0C2709@SE2P216MB1394.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB428519AFC0F522BB25FDA093F2709@MN2PR11MB4285.namprd11.prod.outlook.com>
 <SE2P216MB1394C7C6A067126F36022F23C2739@SE2P216MB1394.KORP216.PROD.OUTLOOK.COM>
 <SE1P216MB1509579188F44BA6C35E8547B1739@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
 <BY5PR11MB4276CD67150EE6042EB1A849F2729@BY5PR11MB4276.namprd11.prod.outlook.com>
 <SE1P216MB1509E22586BCCE1E4899A946B1729@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB4285E860217DB23B18016495F2729@MN2PR11MB4285.namprd11.prod.outlook.com>
In-Reply-To:
 <MN2PR11MB4285E860217DB23B18016495F2729@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dc08467-07b3-4cfc-8896-08da870c7576
x-ms-traffictypediagnostic: SLXP216MB0878:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 z5hj+kWrdb3f79sjxdKoYvVCf+8jwp/0TteAbomrl+DVuy3uRmmI211whovMUCjE2vGrohOtOHZYpAp52ljv3ID16EzkXoymwCI++6nGJURb1NP/QMgbwN/9P5J+0Q8A0wgg3C/7TuQHkywyk2PEdClJRCdCjAF6l8810+KxKUtpQnRIwap4Eu0gr11YbU+klFgs261qTrWWrRZqz7u/3znl/yQvivwcT1vvx3eYm37vWbCveT3Nd+hkWYxrlgk+dya3FGMaFZpUXlZQYj8dV3O2D4TIVznGv2QYnQVGkfWmNwywEugEcXyU/MT4sxCsBhoxm8oYkzfcp24b2+0PFrZy0Mbnhfs9STigdc6KJ/BNZ7bN5N+6jUZNUhjm1ja4mj3ZDUNATm80MPOcklvXT9xx7XWEVFHzhofuy+UZLAyKJFZVkZg0hfaJvEnANoP5k3pJ3aUiyz3XBIimILuucnH1Af7YPeho14X2GLBJLCvQKV3fJQmJyouPesYU3pwI3aSs/I2OTIAvvEa45LWIjGyKtWnTUZWyqTca95M5wYy7MhbQPkJratJIXaPaMyg8WxKlhi3eGeWGz4OGwm/Zn88+aUC7RVHb5WP+bacUwgPFaFc2ADGKeUD65l0YRQMHT1HGvhaVuu+1ULDnTj4KNdYt3oTl/NrJoda8ySgq167U3wPSonJwgeRcq3cRdDEzkq5p4CEUgPR+JUb0SvJmf5dHjYeooquOoKltoKpKXEHEsM2ycoIfA9JeOXcj2dC08QCpIEURjKeQMkUsiBq1uw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1509.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(478600001)(86362001)(52536014)(8936002)(5660300002)(54906003)(110136005)(316002)(71200400001)(41300700001)(8676002)(38070700005)(66946007)(66556008)(64756008)(66476007)(76116006)(4326008)(66446008)(2906002)(33656002)(186003)(9686003)(7696005)(83380400001)(6506007)(53546011)(55016003)(38100700002)(26005)(107886003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkFmems4RG4zcno2dXduZld5aU5FQ3YxNUY3WTMyRDQwOWtybDZVczF5UUlZ?=
 =?utf-8?B?N2pJK2dVRzNWMHQ4djZmVmFudk8vRXhzb01MZWVCTVhqbWVVSHVEUDI0QWk0?=
 =?utf-8?B?MFpoR0ZBQngrTHZWcFBlaUt0QjNUYXdDcStWLy9EK3hoZDlLNHZrbU16Z2NU?=
 =?utf-8?B?UDJMSFR6Y3phbjZFRzFCVm92KzRvYnEyN2YySHpSR3F4YWRvbXV1dmdxSHNz?=
 =?utf-8?B?KzAxT2hHdzlUMGMzSzVUY2JXMHN3VjJsYkhObGp5OFBzc29PTGpvZERweUI0?=
 =?utf-8?B?ZUR4UkdaVFZHUmZFT0FhK1lGUnl6djE2NGZkbFZiZ2xPM00vWVZiOEFaV0hu?=
 =?utf-8?B?Zi9odU9FYi9nV2RXcnNSTlhTT1pvUDErdzZxVkU1YnI4cEx2a1VIanlXeWRB?=
 =?utf-8?B?T05hZEhzd1RndWxqbmdHU1NpdTNHMjFsLzc4MUM3eVlUc3NQT3R4NW9YRG82?=
 =?utf-8?B?a1hXNlNuVUZZYjZveGlSR0lwS3M1QnFlVUF3U053bmtqdE1VYlo1ajVma3Zq?=
 =?utf-8?B?TEcvbTNaMGNoMk9xZVAvSktCVFlNb1lFMzdEUkVDVnNpQmZYSlI3b3JMdzhM?=
 =?utf-8?B?VFVkK1RJTHdOeWFqY25Ub2U0TXRzTldIY2NsQWNpNWtsenZQRC9UUExQZy9n?=
 =?utf-8?B?SzJna3E4bE16Tkk4cHZIcis0SU9tVGpSNWx6SDlYSFUrZUNxODFxeThKVjh1?=
 =?utf-8?B?Q2tJQnFpVkQzUElwUHlKYVpZaVdmYUQyb1MrRmp2bDBkaDBXcWovQ0ZFWkp6?=
 =?utf-8?B?Q3FoTEw3RFdCZ1k5U0xFN1diNE9SbWpwVDFzSEdzcWVSMlFhRVhHM1dsWTl2?=
 =?utf-8?B?Q0h6TGNrR0djUzdCRG03WHY0Q2hmRVRadlBoSGtBcVpXL2haUmo3aEM4S1VM?=
 =?utf-8?B?ZUsxbFpCZFU0aTlJeFZwcm92UWR6QUZhTkJUdnZtZjBDL1VvNUNRTDJFRkoz?=
 =?utf-8?B?anpuSnJJZS9leUlMMzlwTWFaWmJGS2NIc1ozM1ZqTGFseTd5SWdrTHRRNFFW?=
 =?utf-8?B?WVNJbkc0MDZqTVJFcnpRNTR0MGtlelJLNHY1SzJvV3FSdktaQlhKOXBvL3pE?=
 =?utf-8?B?a0lueklqZkYyQnhMQ082dys1eGFaclFDbVExR2hKQ3hyN0d1Z1ppY1VDbERE?=
 =?utf-8?B?bGtNTWpzYlA2aGFFdjEvZWExM3hxaHBubC85aEFjaEplbWRXZmxCMzBqUkFk?=
 =?utf-8?B?cGltNUFYK1RMbDJlcjJZQlAzVUZWeXhjejVxVFhNd29EQkNUMEQvVXF2a2NM?=
 =?utf-8?B?YmdKRVdZMDVrWXlJRS9WNG00eW5XOGZIc21MQ0hQU1VGZjQ2Qm1FTStFOG81?=
 =?utf-8?B?VDhsUVV2WENLd2pmNlNrbm1MQzljMEs5WVNic05CV3VQNW1BVHY3cmc5NmlU?=
 =?utf-8?B?WlZtQW1JWjZoeThoM0JIZzlqNkpJam9aRkwwVk9EUitMcEZoYU5PQlFQNSts?=
 =?utf-8?B?dTRvSzZyU1BBaFh5ZGNjNWdpaVhMVGpCdDJLaDFIUXRMRmxQQ3VuOWhwQzlx?=
 =?utf-8?B?TXBkT3VvaTZFY00xbDRYUWZkb2l4aCtRUE5oYnVOYzEwSXIwZDluNWNXSExF?=
 =?utf-8?B?UTdXNjNvNUxJNU9sZWdOVzVtTUpjTmhtVkxHbGVUaGZ0RVRKM2dPNEtzSUxu?=
 =?utf-8?B?UXprcnh1LzVzcTRscG9GY2tRMnlqZlZuV24rRFErWEl0dmZTTGRjZTJlRS8w?=
 =?utf-8?B?N0g2OFlXRHNXblVXUS9tTDhqL1ZhK3JNdmdBY2REai9kVUhCMEIvUGlNcm50?=
 =?utf-8?B?VEVtYmd2WHZ5WE15RUFXUm1SM0s4S3ltQThsRVlESHJGM1VaeUkzNHRsa3Jt?=
 =?utf-8?B?SmVIbWkyN0x6ZTFXQnhOZHk2RDYyRUg5OHVvcnFBYjVVcjhiRURZcE5pZCta?=
 =?utf-8?B?bldHTkc5TkRKRzNiakI2UlRVT3NrcTBNZmhFL2tmZVg3bnBkQzBlUFg4Zlhj?=
 =?utf-8?B?NG9qQ0FKQ082VDA4anpGQ3NneVR4UUw5T2NSNGdkRW5HMW9jTHJtdkNpV2RK?=
 =?utf-8?B?UTl6LzZYYjJjOXJyWExSUk1OVWZkaFlYZndYaDVIQm1mZG5wY3pnSzVCMWla?=
 =?utf-8?B?Q1YwYU5XdWR0OXJvTkZEcHprd1kzaDc3K3RtdUhXNkJvN0tscm82djNzRmVK?=
 =?utf-8?Q?X8UTGsMskq0Zhk9zpg+R5BXTG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: doosan.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1509.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc08467-07b3-4cfc-8896-08da870c7576
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 02:41:20.5937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 805n/RCM2kD1isAQ83UjUl+Yhu81aSLlD3XGiWQTRIFxfNSVO9cSWXCm/JCVWUl8ozN9nPJ29/0AraJoqU+DWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SLXP216MB0878
Received-SPF: pass (spool5: domain of doosan.com designates 40.107.129.83 as permitted sender) client-ip=40.107.129.83; envelope-from=dongjoo5.kim@doosan.com; helo=KOR01-SL2-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=Doosan.onmicrosoft.com header.s=selector1-Doosan-onmicrosoft-com header.b=0ncLH2mC;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of dongjoo5.kim@doosan.com designates 40.107.129.83 as permitted sender) smtp.mailfrom=dongjoo5.kim@doosan.com

RGVhciBYZW5vbWFpLm9yZywgQ2hlbiwgSG9uZ3poYW4NCg0KSSdtIGRvbmcgam9vLg0KDQpUaGFu
ayB5b3UgZm9yIHlvdXIgcmVwbHkgdG8gdXMgb3VyIHF1ZXN0aW9ucy4NCg0KQW5kLCBXZSBoYXZl
IGNoZWNrZWQgdGhlIHZhbHVlIG9mIFRJQ0tfTlNFQyBpbnQgb3VyIHN5c3RlbS4NCg0KI2RlZmlu
ZSBUSUNLX05TRUMgKChOU0VDX1BFUl9TRUMrSFovMikvSFopDQojZGVmaW5lIE5TRUNfUEVSX1NF
QyAgIDEwMDAwMDAwMDBMDQpIWiAgMjUwICggTWF4IDEwMDAgKQ0KDQpUaGUgdmFsdWUgb2YgVElD
S19OU0VDIGlzIGRlZmluZWQgYnkgbGludXgga2VybmVsLg0KQW5kLCBCb3RoIE5TRUNfUEVSX1NF
QyBhbmQgSFogY2FsY3VsYXRlIHRoZSB2YWx1ZSBvZiBUSUNLX05TRUMuDQoNClNvLCBUaGUgY3Vy
cmVudCB2YWx1ZSBvZiBUSUNLX05TRUMgaXMgNG1zIGJhc2VkIG9uIDI1MCBIWi4NCkFuZCwgSWYg
d2UgY2hhbmdlIHRoZSB2YWx1ZSBvZiBIWiB0byAxMDAwLCBUaGUgdmFsdWUgb2YgVElDS19OU0VD
IG1heSBiZSAxbXMuDQoNCg0KV2UgaG9wZSB0byBwcm9jZXNzIGEgdGFzayBldmVyeSAyMHVzIHVz
aW5nIHJ0X3Rhc2tfeWllbGQgYXMgbGlrZSBYZW5vbWFpIDIuNi41Lg0KDQpJcyB0aGVyZSBhbnkg
bWV0aG9kIHRvIGFjaGlldmUgMjB1cyB0YXNrIGRlbGF5IHVzaW5nIHJ0X3Rhc2tfeWllbGQgb3Ig
YW5vdGhlciB4ZW5vbWFpIG1ldGhvZCA/DQpBbmQsIElzIHRoZXJlIGFueSBwcm9ibGVtIHRvIHJl
ZHVjZSB0aGUgZGVsYXkgbW9yZSBsZXNzIHRoYW4gVElDS19OU0VDID8NCg0KDQpSZWFsbHkgVGhh
bmtzLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hlbiwgSG9uZ3poYW4g
PGhvbmd6aGFuLmNoZW5AaW50ZWwuY29tPg0KU2VudDogVGh1cnNkYXksIEF1Z3VzdCAyNSwgMjAy
MiAzOjIwIFBNDQpUbzog6rmA64+Z7KO8KERvbmdqb28gS2ltKSDssYXsnoTsl7Dqtazsm5Ag65GQ
7IKw66Gc67O07Yux7IqkIDxkb25nam9vNS5raW1AZG9vc2FuLmNvbT47IHhlbm9tYWlAeGVub21h
aS5vcmcNCkNjOiDrsJXsmIHssqAoWW91bmdjaHVsIFBhcmspIOyImOyEneyXsOq1rOybkCDrkZDs
grDroZzrs7Tti7HsiqQgPHlvdW5nY2h1bDMucGFya0Bkb29zYW4uY29tPjsg67CV6rK97ZuIKEt5
dW5naG9vbiBQYXJrKSDsiJjshJ3sl7Dqtazsm5Ag65GQ7IKw66Gc67O07Yux7IqkIDxreXVuZ2hv
b24yLnBhcmtAZG9vc2FuLmNvbT47IOq5gOyEuO2YhChTZWh5dW4gS2ltKSDsl7Dqtazsm5Ag65GQ
7IKw66Gc67O07Yux7IqkIDxzZWh5dW4yLmtpbUBkb29zYW4uY29tPg0KU3ViamVjdDogUkU6IFdo
YXQgY2F1c2VzIHRoZSBsYXRlbmN5IG9mIHRoZSBydF90YXNrX3lpZWxkKCkgQVBJPw0KDQrso7zs
nZg6IOydtCDrqZTsnbzsnYAg7Jm467aA7JeQ7IScIOuwnOyGoSDrkJjsl4jsirXri4jri6QuIOun
ge2BrCDtmLnsnYAg7LKo67aA7YyM7J28IOyXtOuejCDsi5wg7KO87J2Y7ZWY7Iuc6riwIOuwlOue
jeuLiOuLpC4NCg0KQ0FVVElPTjogVGhpcyBlbWFpbCBpcyBzZW50IGJ5IGFuIGV4dGVybmFsIGFj
Y291bnQuIFBsZWFzZSB0YWtlIGV4dHJhIGNhdXRpb24gd2hlbiBjbGlja2luZyB0aGUgbGluayBv
ciBvcGVuaW5nIHRoZSBhdHRhY2htZW50Lg0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj5Gcm9tOiA/Pz8oRG9uZ2pvbyBLaW0pID8/Pz8/ID8/Pz8/PyA8ZG9uZ2pvbzUua2ltQGRvb3Nh
bi5jb20+DQo+U2VudDogVGh1cnNkYXksIEF1Z3VzdCAyNSwgMjAyMiAxMjoxOCBQTQ0KPlRvOiBD
aGVuLCBIb25nemhhbiA8aG9uZ3poYW4uY2hlbkBpbnRlbC5jb20+OyB4ZW5vbWFpQHhlbm9tYWku
b3JnDQo+Q2M6ID8/PyhZb3VuZ2NodWwgUGFyaykgPz8/Pz8gPz8/Pz8/IDx5b3VuZ2NodWwzLnBh
cmtAZG9vc2FuLmNvbT47DQo+Pz8/KEt5dW5naG9vbiBQYXJrKSA/Pz8/PyA/Pz8/Pz8gPGt5dW5n
aG9vbjIucGFya0Bkb29zYW4uY29tPjsNCj4/Pz8oU2VoeXVuIEtpbSkgPz8/ID8/Pz8/PyA8c2Vo
eXVuMi5raW1AZG9vc2FuLmNvbT47ID8/PyhEb25nam9vIEtpbSkNCj4/Pz8/PyA/Pz8/Pz8gPGRv
bmdqb281LmtpbUBkb29zYW4uY29tPg0KPlN1YmplY3Q6IFJFOiBXaGF0IGNhdXNlcyB0aGUgbGF0
ZW5jeSBvZiB0aGUgcnRfdGFza195aWVsZCgpIEFQST8NCj4NCj5EZWFyIFhlbm9tYWkub3JnLCBD
aGVuLCBIb25nemhhbg0KPg0KPkknbSBkb25nIGpvby4NCj4NCj5UaGFuayB5b3UgZm9yIHlvdXIg
cmVwbHkgdG8gdXMgb3VyIHF1ZXN0aW9ucy4NCj5BbmQsIFdlIGhhdmUgY2hlY2tlZCB0aGUgRnRy
YWNlIGxvZy4NCj4NCj5XZSBoYXZlIGxhY2sgb2Yga25vd2xlZGdlIGFib3V0IFhlbm9tYWkgQ29i
YWx0Lg0KPlNvLCBIb3cgZG8geW91IHRoaW5rIGFib3V0IG91ciB0ZXN0IHJlc3VsdCA0bXMgZGVs
YXkgdXNpbmcgYnkgWGVub21haSBDb2JhbHQ/DQo+SXMgdGhpcyByZXN1bHQgbm9ybWFsIG9yIGFi
bm9ybWFsID8NCg0KSWYgdGhlcmUgaXMgbm8gb3RoZXIgUlQgdGhyZWFkIG9jY3VweWluZyBDUFUs
IHRoZSBkZWxheSBzaG91bGQgbm90IGJlIGxhcmdlciB0aGFuIFRJQ0tfTlNFQy4gVElDS19OU0VD
IGRlcGVuZHMgb24geW91ciBzeXN0ZW0uDQoNClJlZ2FyZHMNCg0KSG9uZ3poYW4gQ2hlbg0KDQo+
DQo+DQo+T3VyIGlzc3VlIGFib3V0IFhlbm9tYWkgMy4wLjggKCBMaW51eCBrZXJuZWwgNC4xLjE4
LA0KPmlwaXBlLWNvcmUtNC4xLjE4LXg4Ni05LnBhdGNoICkNCj4NCj5Ob3JtYWwgOiBYZW5vbWFp
IDIuNi41ICggTGludXgga2VybmVsIDMuMTQuNDQsDQo+aXBpcGUtY29yZS0zLjE0LjQ0LXg4Ni0x
Mi5wYXRjaCApDQo+DQo+DQo+V2hpbGUgKCAxICkNCj57DQo+ICAgICAgICBBIGZ1bmN0aW9uICgp
Ow0KPiAgICAgICAgLT4gQSBmdW5jdGlvbiBpcyBwcmludGVkIGV2ZXJ5IDIwdXMgYnkgdXNpbmcg
cnRfcHJpbnRmIGZ1bmN0aW9uDQo+ICAgICAgICBydF90YXNrX3lpZWxkICgpIDsNCj59DQo+DQo+
DQo+SXNzdWUgOiBYZW5vbWFpIDMuMC44ICggTGludXgga2VybmVsIDQuMS4xOCwNCj5pcGlwZS1j
b3JlLTQuMS4xOC14ODYtOS5wYXRjaCApDQo+DQo+V2hpbGUgKCAxICkNCj57DQo+ICAgICAgICBB
IGZ1bmN0aW9uICgpOw0KPiAgICAgICAgLT4gQSBmdW5jdGlvbiBpcyBwcmludGVkIGV2ZXJ5IDRt
cyBieSB1c2luZyBydF9wcmludGYgZnVuY3Rpb24uDQo+ICAgICAgICBydF90YXNrX3lpZWxkICgp
IDsNCj59DQo+DQo+VGhhbmtzDQo+DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9t
OiBDaGVuLCBIb25nemhhbiA8aG9uZ3poYW4uY2hlbkBpbnRlbC5jb20+DQo+U2VudDogVGh1cnNk
YXksIEF1Z3VzdCAyNSwgMjAyMiAxMDowNyBBTQ0KPlRvOiA/Pz8oRG9uZ2pvbyBLaW0pID8/Pz8/
ID8/Pz8/PyA8ZG9uZ2pvbzUua2ltQGRvb3Nhbi5jb20+Ow0KPnhlbm9tYWlAeGVub21haS5vcmcN
Cj5DYzogPz8/KFlvdW5nY2h1bCBQYXJrKSA/Pz8/PyA/Pz8/Pz8gPHlvdW5nY2h1bDMucGFya0Bk
b29zYW4uY29tPjsNCj4/Pz8oS3l1bmdob29uIFBhcmspID8/Pz8/ID8/Pz8/PyA8a3l1bmdob29u
Mi5wYXJrQGRvb3Nhbi5jb20+Ow0KPj8/PyhTZWh5dW4gS2ltKSA/Pz8gPz8/Pz8/IDxzZWh5dW4y
LmtpbUBkb29zYW4uY29tPg0KPlN1YmplY3Q6IFJFOiBXaGF0IGNhdXNlcyB0aGUgbGF0ZW5jeSBv
ZiB0aGUgcnRfdGFza195aWVsZCgpIEFQST8NCg0KDQpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFj
aG1lbnRzIGhlcmVpbiBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgb3IgcHJpdmlsZWdlZCBpbmZv
cm1hdGlvbiBhbmQgaXMgZm9yIHRoZSBleGNsdXNpdmUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNp
cGllbnQocykgbmFtZWQgYWJvdmUuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGll
bnQocyksIHlvdSBzaG91bGQgbm90IGRpc3NlbWluYXRlLCBkaXN0cmlidXRlLCByZXRhaW4sIGNv
cHkgb3Igb3RoZXJ3aXNlIHVzZSBhbnkgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbi4gSWYg
eW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhl
IHNlbmRlciBpbW1lZGlhdGVseSBieSByZXBseWluZyB0byB0aGlzIG1lc3NhZ2UgYW5kIGRlbGV0
ZSB0aGlzIGUtbWFpbCBhbmQgYXNzb2NpYXRlZCBhdHRhY2htZW50cy4gT3VyIGNvbXBhbnkgZG9l
cyBub3QgZ3VhcmFudGVlIHRoaXMgZS1tYWlsIGlzIHNlY3VyZSBvciBmcmVlIGZyb20gdmlydXNl
cy4NCuydtCDrqZTsi5zsp4Ag67CPIOyyqOu2gOyekOujjOuKlCDrspXrpaDsg4Eg67mE67CA66Gc
IOuztO2YuOuQmOyWtOyVvCDtlaAg64K07Jqp7J2EIO2PrO2VqO2VmOqzoCDsnojqs6Ag7KCV64u5
7ZWcIOyImOyLoOyduOyXkOqyjOunjCDsoITri6ztlaAg66qp7KCB7Jy866GcIOuwnOyGoeuQmOyX
iOycvOuvgOuhnCDsoJXri7ntlZwg7IiY7Iug7J247J20IOyVhOuLiOudvOuptCDrgrTsmqnsnZgg
6rO16rCcLCDrsLDtj6wsIOuztOq0gOydgCDrrLzroaAg7Ja065akIOyaqeuPhOuhnOuPhCDsnbTr
pbwg7J207Jqp7ZWgIOyImCDsl4bsnLzrqbAsIOuzuCDrqZTsnbzsnZgg7J6Y66q765CcIOy3qOq4
ieycvOuhnCDrsJzsg53tlZjripQg7JWI7KCE7ISxIOusuOygnOyXkCDqtIDtlZjsl6wg64u57IKs
64qUIOyVhOustOufsCDssYXsnoTrj4Qg7KeA7KeAIOyVhOuLiO2VqOydhCDslYzroKQg65Oc66a9
64uI64ukLiDsnpjrqrsg7IiY7Iug7ZWY7IugIOqyveyasOyXkOuKlCDsponsi5wg7Iah7Iug7J6Q
7JeQ6rKMIO2ajOyLoO2VmOyXrCDslYzroKTso7zsi6Ag7ZuEIOyCreygnO2VmOyXrCDso7zsi5zq
uLAg67CU656N64uI64ukLiDtmJHsobDsl5Ag6rCQ7IKsIOuTnOumveuLiOuLpC4NCg==
