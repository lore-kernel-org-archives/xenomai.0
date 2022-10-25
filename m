Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913937B
	for <xenomai@lists.linux.dev>; Tue, 25 Oct 2022 07:40:14 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::227])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id AF4EDC3882
	for <xenomai@lists.linux.dev>; Tue, 25 Oct 2022 07:28:54 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 62D8E2000C
	for <xenomai@lists.linux.dev>; Tue, 25 Oct 2022 07:28:47 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (mail-ps2kor01on2051.outbound.protection.outlook.com [40.107.128.51])
	by spool.mail.gandi.net (Postfix) with ESMTPS id CE5B3780486
	for <xenomai@xenomai.org>; Tue, 25 Oct 2022 07:28:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvbCyF9RVyZyELxOECAQS6xzlzUqulZwGp9Hm67DXmhR60mpQi2WtCF/MgzRWdYSeP470V0ZIoKV/A+rLEXNH+fzq4W4fIScwZr3/7/uwYBc1pvw8MUN+wKBLzLlcK1cylqShQDS6tIwRUVHs2qfrV36+LOn/HbbZ/ZBCM2zitS8N7MvLGYQGl7FYofxwZREkeQQOAT6iuh3TPuB2iHsU/jZqSUVgDbJ/26j9XTx2+9f88JovQuSTeyEUCHILy37M9IxIA8f3z7sYG2HNmZOTk6fmUw0H0cUvmPDsLQWfiTspA7ndvtAF+ozH1o6OARMpJ25kUs8bSkvZsA6SvM3Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpHkIYhh1YEQyUYBr6vWOaT3yUWNwkVs8xAjNPNN0mc=;
 b=aagUiAkS2Ih0wONQKSSPIBUE2ZSsTy9IdgLjzLz2Vhvtd4ag8OTBlP23+zeM1Sz102F4+f3X+IB/EB/TWcYY9YqSEYkTFceNPK2E7lXmgEBEtDVKDsegnHEk9nJmmucW3Dmujnpp3tLpfXvcro8A45oeHHesnPM5RleJed2NymeXUir1pwCk//6pOxLi9HARbZsj8IVOxy4dcDPAZhL6pfdW2DON7jM7Cek9VfymYno164vd59oFaazpCAkIHykGVUosmoPFALT1vtD7JuDnNLpu8FZb+LI8bV9Mw2NG1rc5MpSvPFKC82Z9iqxo95O+bEr0z+L0Os6G3Ijjb1hReQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Doosan.onmicrosoft.com; s=selector1-Doosan-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpHkIYhh1YEQyUYBr6vWOaT3yUWNwkVs8xAjNPNN0mc=;
 b=UD6tOhflKoEmI1ynkQGRPROd5EcCW0YbcWLuOQdGuPOCnvUJg1czW/IVGyHocYbKLU6qn3nURz/vqSe9PN+8vx57Os1QUHote/BEc5O6Nu0nO6zgqSPKucwiEpbwJ4ZQIO3a1h2rr4BsG3sKHgtpjKbU6g0gbVcBID4052TbyOI=
Received: from SE1P216MB1509.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d::8) by
 PSXP216MB0903.KORP216.PROD.OUTLOOK.COM (2603:1096:300:15::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.25; Tue, 25 Oct 2022 07:28:41 +0000
Received: from SE1P216MB1509.KORP216.PROD.OUTLOOK.COM
 ([fe80::f846:bbc0:bde6:591c]) by SE1P216MB1509.KORP216.PROD.OUTLOOK.COM
 ([fe80::f846:bbc0:bde6:591c%5]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 07:28:41 +0000
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
 =?utf-8?B?66Gc67O07Yux7Iqk?= <dongjoo5.kim@doosan.com>,
	=?utf-8?B?7J207J6s7ISdKEphZXN1ayBMZWUpIOyDgeustCDrkZDsgrDroZzrs7Tti7E=?=
 =?utf-8?B?7Iqk?= <jaesuk.lee@doosan.com>,
	=?utf-8?B?7J207JiB7J6sKFlvdW5namFlIExlZSkg7KO87J6E7Jew6rWs7JuQIOuRkA==?=
 =?utf-8?B?7IKw66Gc67O07Yux7Iqk?= <youngjae7.lee@doosan.com>,
	=?utf-8?B?6rmA7IOB7KSAKFNhbmdqb29uIEtpbSkg7IiY7ISd7Jew6rWs7JuQIOuRkA==?=
 =?utf-8?B?7IKw66Gc67O07Yux7Iqk?= <sangjoon.kim@doosan.com>
Subject: RE: What causes the latency of the rt_task_yield() API?
Thread-Topic: What causes the latency of the rt_task_yield() API?
Thread-Index:
 Adi2hA+8NshNMGH/S1C5hT38XRCzfAABQnKAAEPabkAAHYUU4AADTiNwAAcm6LAABFvNgAAqXeuQAAWtTIALzeIasA==
Date: Tue, 25 Oct 2022 07:28:41 +0000
Message-ID:
 <SE1P216MB150910153918CA5DA4FFC8B1B1319@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
References:
 <SE2P216MB1394874A00E10A497FE73DE0C2709@SE2P216MB1394.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB428519AFC0F522BB25FDA093F2709@MN2PR11MB4285.namprd11.prod.outlook.com>
 <SE2P216MB1394C7C6A067126F36022F23C2739@SE2P216MB1394.KORP216.PROD.OUTLOOK.COM>
 <SE1P216MB1509579188F44BA6C35E8547B1739@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
 <BY5PR11MB4276CD67150EE6042EB1A849F2729@BY5PR11MB4276.namprd11.prod.outlook.com>
 <SE1P216MB1509E22586BCCE1E4899A946B1729@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB4285E860217DB23B18016495F2729@MN2PR11MB4285.namprd11.prod.outlook.com>
 <SE1P216MB1509ED1D62553AC566FDA209B1759@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB4285C21FFFA82081782F2CDFF2759@MN2PR11MB4285.namprd11.prod.outlook.com>
In-Reply-To:
 <MN2PR11MB4285C21FFFA82081782F2CDFF2759@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB1509:EE_|PSXP216MB0903:EE_
x-ms-office365-filtering-correlation-id: 22d7b01f-54e4-4beb-c82d-08dab65a8a74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 voOcB1DyitL/6dbS3S1boO9E3TdfbPN8hqPQEAs9fwMPHpFiPrnORI68xQJlUsEgmaQPW2dRYGtZDWkfXcEMP9AhqV5HIyKJ0aS6XdpqiNgj+bZ/7pyTLDJV1K7K9P0oA85oWLbCBbZUVLar8b090+JguIbL6CglOyWX7baWmg4jHilT+kdTRD2jATyTKEiWpAVchYNr6sr3tkxW8z2IiWL36WIhw/1UO4aNB4B7bgMmXwrSUwoMc+2peOqMQuqB4EPRDfs0DeExcubxByItEVnXMu7r48N1avE/mtHBJi53hk3RY+n1/RPlDea/sOCdsMDYsa0mIwLyqr5a1pl6zIIkfOdXx3EOBHVNDlGvsXiNzy4zb8UJy+cSoIqNeARO18KDTqM7nO0fkkdHcljA2FNpGpOR9+GtVGDXTyJ/00/SB3XgtFWJuHYwmYyK0oC3iyZddh1FmscFjv/1TJfXvItnyUQkhtUzrKAoF9j24Y4E8C8PRg0/39tiIGyl4NW0f1h/BVkJCpE434oAME67rHCcjCGVeuGrvD6mZ3sJUiCFr6nB0smc/S+FXP+yyHmKjx87bUF3JNb6gejcdudxqcxi/iBEqfc7Ko3eTz6BBS25GxMagpih7smnUKdKDp6H5XrMfLzX674D8qDht2YNDXm0Cig8t2V+6W5O+KAny8y3yG7Nj8103FnI7yOvXGO3ymtlr1a+HjMpJZh9pMxmbFnHbF9IEviTqQIqBUsTPibhWUQ42zBsSOJarQUvsW3VSLJ2u1DZSCNHa5G7eUzQZZeW7+a0beqaW0ObNyyAvKs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1509.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(478600001)(966005)(83380400001)(86362001)(71200400001)(107886003)(66446008)(64756008)(53546011)(54906003)(110136005)(8676002)(66556008)(7696005)(6506007)(316002)(4326008)(9686003)(41300700001)(8936002)(5660300002)(52536014)(26005)(76116006)(66476007)(2906002)(122000001)(38100700002)(55016003)(186003)(66946007)(33656002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dS8rTTZZTlRzMjlFTjlobUwyWnFrZ0Q4VjQ2Y1JUdlluQXNoUHh3YXdPQXBS?=
 =?utf-8?B?VGUxU21QNE1JdHNPZVhmTHlGdTlIcy8xYXcvV2FTc2NwWFBFQkJHcFVYZGVG?=
 =?utf-8?B?TkxOb1JBc3RrcTVwa1VVaEJuRWphRFpZTkxVcTkwYy9CM2Y0c2Yyb2R4azEw?=
 =?utf-8?B?SGRmM2QybXJuaXVjZDFoVUNwVUxVMDFsclNzazB5enpYU0cySDBraTlWYWY3?=
 =?utf-8?B?QlZEeUZDeVZpd3RXSWVXL3dDN0FuS1FYMEVJb0ljWU9VNHIzUFV0Z1lGS3VH?=
 =?utf-8?B?WGtLOFB5UnBxamo2V3VBM25BNjI2ZXM0N0llbnVSeVN5ZkFpaG8vVWNYTUNm?=
 =?utf-8?B?T3NSVHhVYWk4WWFLeUFEcWE1YVBURGY3NktSMlBUN0IwRVdWU0k4ZmJHbzRF?=
 =?utf-8?B?QTAzL1d6MHFjMFBGWDhhQ2R1ZzZ6bkNyYUlQTGk1cVBQbGl4TFJpYnZGUW1v?=
 =?utf-8?B?Y0RxU1NKYzhNSzVpOGpMZkJTU2ZFTEIvRTBWYk02R2FNelc4SXhzNmZ4UVNV?=
 =?utf-8?B?ck1VeCsyejNHMVVibVhCV1R5TnpjQnlSSUVjYjFVZmNBeFhLZnpoR1k4cjBE?=
 =?utf-8?B?RGxONU9HYmdnYkVtOUJCWEpBK2Q2cG15aDRqR1dvYytYbllSZnBMUUdQVGdn?=
 =?utf-8?B?ck9ZL2NXVGVITjN0V0x2VjY0RWdzbVU3L20ySXhoYk9zT0FvTlRZTGRlWmFv?=
 =?utf-8?B?d1VEK00zelMvNnNBUHJrcEc1WURpczFnemdOc0tiNmV0U1JXZTBQS1Z0MzVW?=
 =?utf-8?B?Wm9zRlhiUzhkeHR5NzM3SmVDODhKKy96U1ZwSEYvZ2R5VDRmalBqTkdsdG8y?=
 =?utf-8?B?WndLcTlJUmZxbXUwaXd4Q2xuL0E3QnpBeHVlR2gxT2Y5WVBFUXdDUUtlQW9P?=
 =?utf-8?B?YVBTUDJLVTkva2NnaG1ER3Y2RDdVZmZTWHh4b2h1RW90SGFITDdGeGM2dXNF?=
 =?utf-8?B?NzFUeGNFNGZVbXpRa01pSEV3eXhnOVhTQUdPL3FxcmtidGVCOGVjM20vaDlY?=
 =?utf-8?B?S3V1cU9VQWw4RldzNkhaZHB1cndwbjNqQWlEMjg4NE01eHBEZllZZ0R1dW9O?=
 =?utf-8?B?ZjdnRDRXZGluNk9kUXFCVVJMUE5vRkZidFlnbkF6OXJHQ2Jtc2ozQlFiM1lG?=
 =?utf-8?B?d0x5WlNTazZYM3F5UFdFSFZJWHMwL0dyR3ppTWx4c0R4ZDZieGxsNm1uK1VP?=
 =?utf-8?B?ZEdFRGFRb3E5VUo1ZWQxTzFPKzhpNGRWaGhvaG1iV1c4NmJvSjZiMDhjd0pn?=
 =?utf-8?B?VGVjTVFtcWFvVDIyNDNwSzRDLzRMYWd4WWFodFB6TC9KRlZHdXlkSlZhZ1hW?=
 =?utf-8?B?RzgwcU1ubmdPVlJZY2R0QWFHYWZYZkg1WHlsYVNKVWY5OFVZdjBzRGlPRFN6?=
 =?utf-8?B?bDV4UEduTGROem4ra2t2Ym85ZDE1OU8xd1BiWFUvNWh1aHhpTmUvNE8rVnp2?=
 =?utf-8?B?bHBadTExSEhpejJFWkUyT1hScWdISVN4S1Bxc3RaNEw4Qlg3Qi9CRi9wZUlU?=
 =?utf-8?B?bzJDRldMa1VwRXMyMk8xcGhLOUZWMGsxTjkybkxtMDBmVm4yaDFKU1hwRmlv?=
 =?utf-8?B?b01sWjVVLytLekdyWHJZWlE3MWp0a2IzYjJUV3Q1OGFhWkxxOXBxRGpxSEhu?=
 =?utf-8?B?SWVYVUs0QWtRSkdQS2FWbUpsbTE0TElDeGsyVmJkM0ZtUzBBUUVtOGRqMFRV?=
 =?utf-8?B?NUFFYUh5QlNrVUNLOXZHeFVXdzczK09KYkw0MkJIMVVFeEpzbnNKR1pnMmQ1?=
 =?utf-8?B?ZlQxUkRsZkI5Q2Q3OEtrSEtHOS9HbzQwYUFuZlN4N1VxaXZtUFNja1dXS05G?=
 =?utf-8?B?RlJYaHdoTDdlMFM2NExpeHE3SXorYjZqcTRRYUU5Q3N2SXQ0VzRGcFNsaXM2?=
 =?utf-8?B?d3B4UUxNeUhzNkl0RnlHdG9RREZaWDdUZWE4TkNFZ1dtazVDSUpGSWRDOXdU?=
 =?utf-8?B?NEpKNUVjSzlkUUdvYURSUUNTWUZvMFVoUkZOVXZPQ0xpWUVCdmh6Y1VwcjBt?=
 =?utf-8?B?UW9McE1zQlh4bTVFd2pCU2tmNWR1YnUrL210ZDJyNlgzU3k5WGYyWVZwaDZM?=
 =?utf-8?B?ck4wSFZGb011UEhhVkwrb3hrN2ZIVmZzSzVMRDR2dFhTMG9wWlN0RXFPL2I3?=
 =?utf-8?Q?/qoNZwgUF6W0gIwa5uT9/IK2P?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d7b01f-54e4-4beb-c82d-08dab65a8a74
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 07:28:41.1942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0WpQcgbtTBI59LsqabTd4w/ms5Hhchch5AC/jwXN/sUUdZUgJVHO56cXkC79svTNEPTHCb6KE0GxVxwYVt6LtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSXP216MB0903
Received-SPF: pass (spool4: domain of doosan.com designates 40.107.128.51 as permitted sender) client-ip=40.107.128.51; envelope-from=dongjoo5.kim@doosan.com; helo=KOR01-PS2-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=Doosan.onmicrosoft.com header.s=selector1-Doosan-onmicrosoft-com header.b=UD6tOhfl;
	spf=pass (spool.mail.gandi.net: domain of dongjoo5.kim@doosan.com designates 40.107.128.51 as permitted sender) smtp.mailfrom=dongjoo5.kim@doosan.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=none

RGVhciBYZW5vbWFpLm9yZywgQ2hlbiwgSG9uZ3poYW4NCg0KSSdtIGRvbmcgam9vLg0KDQpBZnRl
ciB3ZSBkbyBhIGFnaW5nIHRlc3QgYXMgbGlrZSBsYXRlbmN5LA0KV2UgZ2V0IGEgc3lzdGVtIGhh
bmcgYWJvdXQgdGVuIGhvdXJzIGxhdGVyLg0KDQpBdCB0aGF0IHRpbWUsIE91ciBzeXN0ZW0gZG9u
J3QgZGV0ZWN0IHVzYiBtb3VzZS4NCg0KQWZ0ZXIgcmVib290aW5nIG91ciBzeXN0ZW0gYnkgZm9y
Y2UsDQp0aGVyZSBpcyBubyBzaWduaWZpY2F0aXZlIGxvZyBpbiB0aGUga2VybmVsIGxvZyBvciBz
eXNsb2cuDQoNCkNvdWxkIHlvdSBoZWxwIHRvIHVzIGhvdyB0byBzb2x2ZSB0aGlzIGlzc3VlID8N
Cg0KDQpXZSBzZXQgdXAgb3VyIHN5c3RlbSBhcyBsaWtlIGJlbG93IHN3Lg0KDQoxLiBYdWJ1bnR1
IDE4LjA0IExUUyAzMmJpdA0KDQoyLiBMaW51eCBrZXJuZWwgNC4xLjE4IDMyYml0DQoNCjMuIFhl
bm9tYWkgMy4wLjggMzJiaXQNCg0KNC4gS2VybmVsIGNvbmZpZw0KICAgV2UgcmVmZXIgdG8gdGhl
IHhlbm9tYWkgcGFnZSBhcyBsaWtlIGJlbG93Lg0KDQpodHRwczovL3NvdXJjZS5kZW54LmRlL1hl
bm9tYWkveGVub21haS8tL3dpa2lzL0NvbmZpZ3VyaW5nX0Zvcl9YODZfQmFzZWRfRHVhbF9LZXJu
ZWxzI3VzZXItY29udGVudC14ODYtcHJvY2Vzc29yLXR5cGUNCg0KVGhhbmtzLg0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5A
aW50ZWwuY29tPg0KU2VudDogRnJpZGF5LCBBdWd1c3QgMjYsIDIwMjIgMjo0MCBQTQ0KVG86IOq5
gOuPmeyjvChEb25nam9vIEtpbSkg7LGF7J6E7Jew6rWs7JuQIOuRkOyCsOuhnOuztO2LseyKpCA8
ZG9uZ2pvbzUua2ltQGRvb3Nhbi5jb20+OyB4ZW5vbWFpQHhlbm9tYWkub3JnDQpDYzog67CV7JiB
7LKgKFlvdW5nY2h1bCBQYXJrKSDsiJjshJ3sl7Dqtazsm5Ag65GQ7IKw66Gc67O07Yux7IqkIDx5
b3VuZ2NodWwzLnBhcmtAZG9vc2FuLmNvbT47IOuwleqyve2biChLeXVuZ2hvb24gUGFyaykg7IiY
7ISd7Jew6rWs7JuQIOuRkOyCsOuhnOuztO2LseyKpCA8a3l1bmdob29uMi5wYXJrQGRvb3Nhbi5j
b20+OyDquYDshLjtmIQoU2VoeXVuIEtpbSkg7Jew6rWs7JuQIOuRkOyCsOuhnOuztO2LseyKpCA8
c2VoeXVuMi5raW1AZG9vc2FuLmNvbT4NClN1YmplY3Q6IFJFOiBXaGF0IGNhdXNlcyB0aGUgbGF0
ZW5jeSBvZiB0aGUgcnRfdGFza195aWVsZCgpIEFQST8NCg0K7KO87J2YOiDsnbQg66mU7J287J2A
IOyZuOu2gOyXkOyEnCDrsJzshqEg65CY7JeI7Iq164uI64ukLiDrp4Htgawg7Zi57J2AIOyyqOu2
gO2MjOydvCDsl7Trnowg7IucIOyjvOydmO2VmOyLnOq4sCDrsJTrno3ri4jri6QuDQoNCkNBVVRJ
T046IFRoaXMgZW1haWwgaXMgc2VudCBieSBhbiBleHRlcm5hbCBhY2NvdW50LiBQbGVhc2UgdGFr
ZSBleHRyYSBjYXV0aW9uIHdoZW4gY2xpY2tpbmcgdGhlIGxpbmsgb3Igb3BlbmluZyB0aGUgYXR0
YWNobWVudC4NCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogPz8/KERvbmdq
b28gS2ltKSA/Pz8/PyA/Pz8/Pz8gPGRvbmdqb281LmtpbUBkb29zYW4uY29tPg0KPlNlbnQ6IEZy
aWRheSwgQXVndXN0IDI2LCAyMDIyIDEwOjQxIEFNDQo+VG86IENoZW4sIEhvbmd6aGFuIDxob25n
emhhbi5jaGVuQGludGVsLmNvbT47IHhlbm9tYWlAeGVub21haS5vcmcNCj5DYzogPz8/KFlvdW5n
Y2h1bCBQYXJrKSA/Pz8/PyA/Pz8/Pz8gPHlvdW5nY2h1bDMucGFya0Bkb29zYW4uY29tPjsgPz8/
KEt5dW5naG9vbiBQYXJrKSA/Pz8/PyA/Pz8/Pz8gPGt5dW5naG9vbjIucGFya0Bkb29zYW4uY29t
PjsgPz8/KFNlaHl1biBLaW0pID8/PyA/Pz8/Pz8gPHNlaHl1bjIua2ltQGRvb3Nhbi5jb20+OyA/
Pz8oRG9uZ2pvbyBLaW0pID8/Pz8/ID8/Pz8/PyA8ZG9uZ2pvbzUua2ltQGRvb3Nhbi5jb20+DQo+
U3ViamVjdDogUkU6IFdoYXQgY2F1c2VzIHRoZSBsYXRlbmN5IG9mIHRoZSBydF90YXNrX3lpZWxk
KCkgQVBJPw0KPg0KPkRlYXIgWGVub21haS5vcmcsIENoZW4sIEhvbmd6aGFuDQo+DQo+SSdtIGRv
bmcgam9vLg0KPg0KPlRoYW5rIHlvdSBmb3IgeW91ciByZXBseSB0byB1cyBvdXIgcXVlc3Rpb25z
Lg0KPg0KPkFuZCwgV2UgaGF2ZSBjaGVja2VkIHRoZSB2YWx1ZSBvZiBUSUNLX05TRUMgaW50IG91
ciBzeXN0ZW0uDQo+DQo+I2RlZmluZSBUSUNLX05TRUMgKChOU0VDX1BFUl9TRUMrSFovMikvSFop
DQo+I2RlZmluZSBOU0VDX1BFUl9TRUMgICAxMDAwMDAwMDAwTA0KPkhaICAyNTAgKCBNYXggMTAw
MCApDQo+DQo+VGhlIHZhbHVlIG9mIFRJQ0tfTlNFQyBpcyBkZWZpbmVkIGJ5IGxpbnV4IGtlcm5l
bC4NCj5BbmQsIEJvdGggTlNFQ19QRVJfU0VDIGFuZCBIWiBjYWxjdWxhdGUgdGhlIHZhbHVlIG9m
IFRJQ0tfTlNFQy4NCj4NCj5TbywgVGhlIGN1cnJlbnQgdmFsdWUgb2YgVElDS19OU0VDIGlzIDRt
cyBiYXNlZCBvbiAyNTAgSFouDQo+QW5kLCBJZiB3ZSBjaGFuZ2UgdGhlIHZhbHVlIG9mIEhaIHRv
IDEwMDAsIFRoZSB2YWx1ZSBvZiBUSUNLX05TRUMgbWF5IGJlIDFtcy4NCj4NCj4NCj5XZSBob3Bl
IHRvIHByb2Nlc3MgYSB0YXNrIGV2ZXJ5IDIwdXMgdXNpbmcgcnRfdGFza195aWVsZCBhcyBsaWtl
IFhlbm9tYWkgMi42LjUuDQo+DQo+SXMgdGhlcmUgYW55IG1ldGhvZCB0byBhY2hpZXZlIDIwdXMg
dGFzayBkZWxheSB1c2luZyBydF90YXNrX3lpZWxkIG9yIGFub3RoZXIgeGVub21haSBtZXRob2Qg
Pw0KPkFuZCwgSXMgdGhlcmUgYW55IHByb2JsZW0gdG8gcmVkdWNlIHRoZSBkZWxheSBtb3JlIGxl
c3MgdGhhbiBUSUNLX05TRUMgPw0KDQpJIGp1c3Qgd2VudCB0aHJvdWdoIHRoZSBpbXBsZW1lbnRh
dGlvbiBvZiBydF90YXNrX3lpZWxkIG9mIFhlb21haSAyLjYuNSBhbmQgZm91bmQgdGhhdCBpdCBp
cyB0b3RhbGx5IGRpZmZlcmVudCBmcm9tIFhlbm9tYWkgMy4wLjguDQpJZiB5b3Ugd2FudCB0byB5
aWVsZCBhYm91dCAyMHVzIGZvciBjdXJyZW50IFJUIHRocmVhZCAseW91IG1heSB0cnkgY2FsbCBj
bG9ja19uYW5vc2xlZXAgLg0KLg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo+DQo+DQo+UmVh
bGx5IFRoYW5rcy4NCj4NCg0KDQpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGhlcmVp
biBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgb3IgcHJpdmlsZWdlZCBpbmZvcm1hdGlvbiBhbmQg
aXMgZm9yIHRoZSBleGNsdXNpdmUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykgbmFt
ZWQgYWJvdmUuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQocyksIHlvdSBz
aG91bGQgbm90IGRpc3NlbWluYXRlLCBkaXN0cmlidXRlLCByZXRhaW4sIGNvcHkgb3Igb3RoZXJ3
aXNlIHVzZSBhbnkgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbi4gSWYgeW91IGhhdmUgcmVj
ZWl2ZWQgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1l
ZGlhdGVseSBieSByZXBseWluZyB0byB0aGlzIG1lc3NhZ2UgYW5kIGRlbGV0ZSB0aGlzIGUtbWFp
bCBhbmQgYXNzb2NpYXRlZCBhdHRhY2htZW50cy4gT3VyIGNvbXBhbnkgZG9lcyBub3QgZ3VhcmFu
dGVlIHRoaXMgZS1tYWlsIGlzIHNlY3VyZSBvciBmcmVlIGZyb20gdmlydXNlcy4NCuydtCDrqZTs
i5zsp4Ag67CPIOyyqOu2gOyekOujjOuKlCDrspXrpaDsg4Eg67mE67CA66GcIOuztO2YuOuQmOyW
tOyVvCDtlaAg64K07Jqp7J2EIO2PrO2VqO2VmOqzoCDsnojqs6Ag7KCV64u57ZWcIOyImOyLoOyd
uOyXkOqyjOunjCDsoITri6ztlaAg66qp7KCB7Jy866GcIOuwnOyGoeuQmOyXiOycvOuvgOuhnCDs
oJXri7ntlZwg7IiY7Iug7J247J20IOyVhOuLiOudvOuptCDrgrTsmqnsnZgg6rO16rCcLCDrsLDt
j6wsIOuztOq0gOydgCDrrLzroaAg7Ja065akIOyaqeuPhOuhnOuPhCDsnbTrpbwg7J207Jqp7ZWg
IOyImCDsl4bsnLzrqbAsIOuzuCDrqZTsnbzsnZgg7J6Y66q765CcIOy3qOq4ieycvOuhnCDrsJzs
g53tlZjripQg7JWI7KCE7ISxIOusuOygnOyXkCDqtIDtlZjsl6wg64u57IKs64qUIOyVhOustOuf
sCDssYXsnoTrj4Qg7KeA7KeAIOyVhOuLiO2VqOydhCDslYzroKQg65Oc66a964uI64ukLiDsnpjr
qrsg7IiY7Iug7ZWY7IugIOqyveyasOyXkOuKlCDsponsi5wg7Iah7Iug7J6Q7JeQ6rKMIO2ajOyL
oO2VmOyXrCDslYzroKTso7zsi6Ag7ZuEIOyCreygnO2VmOyXrCDso7zsi5zquLAg67CU656N64uI
64ukLiDtmJHsobDsl5Ag6rCQ7IKsIOuTnOumveuLiOuLpC4NCg==
