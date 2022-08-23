Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5FC7E0
	for <xenomai@lists.linux.dev>; Tue, 23 Aug 2022 00:16:02 +0000 (UTC)
Received: from relay12.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::232])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 54730CAAB6
	for <xenomai@lists.linux.dev>; Tue, 23 Aug 2022 00:11:24 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 28A63200003
	for <xenomai@lists.linux.dev>; Tue, 23 Aug 2022 00:11:16 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from KOR01-SL2-obe.outbound.protection.outlook.com (mail-sl2kor01on2055.outbound.protection.outlook.com [40.107.129.55])
	by spool.mail.gandi.net (Postfix) with ESMTPS id DDE12940807
	for <xenomai@xenomai.org>; Tue, 23 Aug 2022 00:11:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFvGUZbSssk+3iBsH5hW+S7Xvzmi6J97w2yvvRRT2te1mRVNF8+FYTqKkqDdz1gfY3BNwGLHAy6oG8j0hWkJqfb1Y7kBhc2vjvYemB1L/vLe1+CuGNBF3yGZgTLncDgfK6bvnAEHmALbgDijjsN6Utp67ZNdg9wSt/UVZfHrZG9h9VhyktcAexaqe23q9MtwDA08rNHKhaRYuZntlnseA+viVAKUP8DHo4N1CCJAgLgsq7L1UqPdVnSwtmC2+cjjYJnlyJwJhRCFL5UH2H18MH43vGOMzAH1ljEytpAIrVZf+VhIzXi1lP7aY8EBw8Aod2hntz/MgsGguGoHao5H+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIekKe+UdJmXVKCAUcsE/UN9Hs/VGvX61cyDhCefjjA=;
 b=a35a0sO22hwSPuJz/SMOC8mfGmuMGsy0U5XcdoDNFph/AWv8I0FisACdToDLbgrABTFP233+IAFzYktjvslL9fIgckaiaSR/CtJJLozuaIBov0HkDL9J3H2jZi8G2LFB0N31Tgg/e6hdG+1b0Sob6QFtlMPfr9B0bIrsW75AVverXfe3Zn/sEXBdpuD921g3yQto2OJ0+oi8QhJ6FGKaKCa9PvRAj1U30yw4mwwy1ux8FOEvAzuBgoH0KPWyX/qrb8oQEAlQWNx4q9tf7cI/BVsP69feDEPM6qgHbuWCLPDDjdddivCTIR+B3YXY8J98iAGGd1D54pgZutwdu/YOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Doosan.onmicrosoft.com; s=selector1-Doosan-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIekKe+UdJmXVKCAUcsE/UN9Hs/VGvX61cyDhCefjjA=;
 b=JNjeyOBlKWVkjRS9GGLCnx1cIzW7i6LVSbaliWfQRvfu1/Zrdag6jyHd7W4acpQnZ+oOUwOYzZOAQTnFe9OgR4zUygP8RLZzmwh/fUt782XiUv+rPuMEcBDqokXoQd6PY4Si5OLAJMrtqMVRI/IXNPSrSM6tbK816W7n2bQyYoc=
Received: from SE2P216MB1394.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2c::13)
 by SL2P216MB1529.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Tue, 23 Aug
 2022 00:11:09 +0000
Received: from SE2P216MB1394.KORP216.PROD.OUTLOOK.COM
 ([fe80::2945:32b7:6b5e:7f0d]) by SE2P216MB1394.KORP216.PROD.OUTLOOK.COM
 ([fe80::2945:32b7:6b5e:7f0d%4]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 00:11:09 +0000
From: =?utf-8?B?6rmA7IS47ZiEKFNlaHl1biBLaW0pIOyXsOq1rOybkCDrkZDsgrDroZzrs7Q=?=
 =?utf-8?B?7Yux7Iqk?= <sehyun2.kim@doosan.com>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
CC: =?utf-8?B?6rmA64+Z7KO8KERvbmdqb28gS2ltKSDssYXsnoTsl7Dqtazsm5Ag65GQ7IKw?=
 =?utf-8?B?66Gc67O07Yux7Iqk?= <dongjoo5.kim@doosan.com>
Subject: What causes the latency of the rt_task_yield() API?
Thread-Topic: What causes the latency of the rt_task_yield() API?
Thread-Index: Adi2hA+8NshNMGH/S1C5hT38XRCzfA==
Date: Tue, 23 Aug 2022 00:11:08 +0000
Message-ID:
 <SE2P216MB1394874A00E10A497FE73DE0C2709@SE2P216MB1394.KORP216.PROD.OUTLOOK.COM>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccae40b0-ef16-4ed7-b004-08da849bfada
x-ms-traffictypediagnostic: SL2P216MB1529:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 b74mnbgbukTNFGGAh4BoymwEg7iwfsGdbstODS2VERYQWlElFNjbpSRHkX4oaOMSTkGxa+4C3o1D8ldNhCSl8vgd7jCWNc0zegHi60acShIF3AvWG9Qt1jvDX5Ify4sYcmeYcsjbHObPuBzeoMd0V+8N6eN4wx/wgznSx9/J6WE9zcQ0zKgNx0iZW+gFEALwFDjtpABcUBJlBZuNK13LDZho7ag2nYi9Jol0/sHnU2LeLrTGkmJMEz2vOiX42odZ7nb3wljT0XMtwGH/XCs2auDIWuwCa9BzipxpUuFAXSeZ8/IjDsJC+twLZj54VzY0MuFELKS46I+fS6Jb323H+yLgcnf77YjAnIiz3FFS1aLPJ2xrXvzGOeS1XzunBjv/9mU4oBAeiX1wOcnnxJ71UYnNUW8ti56ZQlj7fFaXfQqPci3UnI1yxMcDSJmVlaGGMKsdrhVTT8lwqs3di6LrbQgdaWKmZPco5MvBJYARYSPqmZZtAeDD8Ip44FC1IhF2dhnTWGwHtGFcfCsMHaXRQbEDM5TkRJORwwzOWsFWV+9Z/9K+iufweepXMi2DMXx+yKTfUr7n/fiQKW8yqXPD0+oWveVJrBx5UP1n6gVXHf5d2ZiuzyIhJOUIfku9jKgvY+0gf37wZdHqVVtp1oMluFXuF9PlKvqCe0obJFzRfho5yHoJnSpsVdMndhrFhy/04hQc1FgVCoyM0U+ZfN5AHkHZiLM7pshid374ovjDXeKWb0X4zm2h1v69/PVrAStqfDQHkoXZaLTe5mT53r+FNfDhHeWLpT8LeIe6aMiCqB4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE2P216MB1394.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(38070700005)(15974865002)(86362001)(122000001)(38100700002)(316002)(6916009)(52536014)(4326008)(8936002)(2906002)(6506007)(5660300002)(66446008)(66946007)(76116006)(66476007)(8676002)(66556008)(64756008)(83380400001)(186003)(478600001)(55016003)(41300700001)(71200400001)(26005)(7696005)(9686003)(33656002)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUh2cE1UWGdTTDhwYUJDeE5BRGg0S2tjcEpDZ0RDREZPdUlTOGFHUi9CeFNv?=
 =?utf-8?B?UjhtcVJydlpOSXpmbXZTSVRvdjZmbHV4TExneTJLY1NiZGdxbDNxdFZsYjl6?=
 =?utf-8?B?VkF6UTRTZVJFYkROSDgxdWZrZ1JML3k4MkFCcmZtMS9qY21NSWNlelQ2bVRC?=
 =?utf-8?B?K1FHZ2ZsVmtFU0dLZ1JiM2QxNkhzWjVpWDJjZEh3ekhLdlZ1ZExnVDhUTG85?=
 =?utf-8?B?SklEclZYVEU1RWF4TlI5bTBRNUxoczZMQW1oZk55Wkt1YlF2ekFJWmhQbWpo?=
 =?utf-8?B?WTk2V1AvaXhPa2tLME9KM1N0ZFMzNElHRVFLVVpHQ25nNmpISyt3UmNrbDJp?=
 =?utf-8?B?dnJadGR3MW45M2VkbWlCV3ZNNGNkVFVXK3A3S3ZScXNXUHN3NWZTUXZ3OURO?=
 =?utf-8?B?YTFqTkM1ekFmTDJzVjVsMWNsK2YwMTdhUlMrdUd2OTRSL3pBT2ZMTGJNdy9v?=
 =?utf-8?B?T0c3VFFaM0ZUSysxQWNjeEtLY0c2SnV0Zkk0TzMvZGZJUzJ1OTN2QzFKdTMv?=
 =?utf-8?B?YjVEZmxobzBwRStrTzdFc0hwalE3L29mWGU4cHUyK3d2dmJrMFpRaGo2ZDg2?=
 =?utf-8?B?MjBRdWFXV1pYWkZZK21tNUo5S3k1MENMWmFiMWNIdUVsaWhtSFIwQXlXVUZN?=
 =?utf-8?B?dHVHcmtDYVNQUHllRUR6SlBmMTJwWmhpb3cvdjNUbW9QZXF0RHhLQVBVWjM1?=
 =?utf-8?B?OURHZC9rTmtwdjVONTVVSlFxZXdqN3pOa1dJSCtnUlJ3cTJUT1RQcG54UnVZ?=
 =?utf-8?B?aURMVFd3eEdEYTR6a2I4L2ZJcHZKbkpLVW1kbjdqNjNBRHhoOHdrbDkxWCtr?=
 =?utf-8?B?WDFSazBwNnlXYXBSR0ZhQXo0WTd2RjZweFZNUE1YWFc4QTNUNG15MEdCUTFY?=
 =?utf-8?B?Z1REdUN5SlFqMW5DcTFRa0NnRkFlS1ZhL2RNeUR3V2tmQm94MW1rYVJvOTNK?=
 =?utf-8?B?Y2VBc0RmNlpqSVcxY2NsUHFnRTF1eFhucUFqK0dFQVFjQWcyM2cremIwRmlh?=
 =?utf-8?B?VlA5d0IwRmY1eVQrUFVURng0QkQzaHAyR3ZpSExYeEVHQUNWeXBGV1VlM0cx?=
 =?utf-8?B?WFkrSndEbWtpdE1DekozNzR2R29VSUdybnRYSzhVRGxuYkZYa05RTEZQaWxD?=
 =?utf-8?B?S1U0b0dLT1FkSUVPODNiVytkNEI2c3gyb0NyZHphUEhLaDQrK08vSjNvNE03?=
 =?utf-8?B?ZEgxT3lnL1JFYmpZYWg4dHN3cnozZ0MrQm9NNnJlRmowNTVEcnlmYVhpYjdC?=
 =?utf-8?B?NzZOa2tKYlFHSTNFUlJZNFhPN2NvdURjbUxHY1dZVC83aURjYnJpalo5WE4r?=
 =?utf-8?B?ODZGRmljUGJGTXVGMS9jemhwWTczUE5tc3lSRi91Y3d0OGpuZ01IcGxKZ0k1?=
 =?utf-8?B?WkcrdGNUTkRSYVQ2TWNacW9jRlRLUGlEQkhHZGVSNkI1MWdxcVNpL09FZHFF?=
 =?utf-8?B?WGxWQXJEUmxjYWhFR1RjZkhWTjByYlYrNCtvclVOMVNMVVhNYzZwWEFFYU5i?=
 =?utf-8?B?OVc5aXVRcVlxT2JoVHhka21hMUVsVnhzRmpUTVdyTXB6dyszZVBBNnExWnlD?=
 =?utf-8?B?aTdIZDdyRzdoUmszSUJMdG93d0p3VDRYSm40VUc1aXc1dXR4QVZ6ZUFWZ3Ev?=
 =?utf-8?B?K1hFQ00zWkY5MkF2Y1dIUGtwNFlIenpkREpkb0RQUzhMbVRjc09kWWhva1lr?=
 =?utf-8?B?ZERwUFc1Q2k2ZldZMDkzSUt1UXV5a3FiRWZyYlNSTjUyMmVuU05SZnZjN0Zn?=
 =?utf-8?B?SGhmTFFTSFhTUlBncEU1aDZLeFdkMTlQcmNDWndhaTAvMmhqd1ZGV3JrYk9W?=
 =?utf-8?B?Y3MrN0RpUXh0SnkzSTlTSUdyLzRicHNaMXFpU3A1eFI0ajRZdHZLR0F6WTBL?=
 =?utf-8?B?d3JYNEJHbExhWVEvRDhHQ3d6N0d5NmFqTGNVVzNwdVlma0tjWHhTbVN0ajh3?=
 =?utf-8?B?dmdJUGdYcVl3OHQ3Z2NQLzlLTU9vVVN6WjRoNk5aTG5STFo2U0tuVlpaWW1w?=
 =?utf-8?B?YTdhWHhJYUdaa1ZnRy9JVER1NHhPSE1YZFVjTXBtZHFuUEgxTWl3WGVTc3BU?=
 =?utf-8?B?bHpGTzYvVFc5dzQrWEF3czVjeUF4WVh3dXRXUTVHQUNsWU9TRmRremI4S2Vs?=
 =?utf-8?Q?MXsNm311kWtq8XIhtPVns7NDK?=
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
X-MS-Exchange-CrossTenant-AuthSource: SE2P216MB1394.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ccae40b0-ef16-4ed7-b004-08da849bfada
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 00:11:08.9311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQePR140UxurHAd5v1l8lRHrvb5iKoR8LmJWJVgjR1f3YIfpE4bKAhmaTXOitUEAOFI2fGUT4KhoX44yInrw5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2P216MB1529
Received-SPF: pass (spool1: domain of doosan.com designates 40.107.129.55 as permitted sender) client-ip=40.107.129.55; envelope-from=sehyun2.kim@doosan.com; helo=KOR01-SL2-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=Doosan.onmicrosoft.com header.s=selector1-Doosan-onmicrosoft-com header.b=JNjeyOBl;
	spf=pass (spool.mail.gandi.net: domain of sehyun2.kim@doosan.com designates 40.107.129.55 as permitted sender) smtp.mailfrom=sehyun2.kim@doosan.com;
	dmarc=none

DQpDdXJyZW50bHksIEkgYW0gdXNpbmcgeGVub21haSAyLjYuNSB2ZXJzaW9uIGFuZCBhbSB3b3Jr
aW5nIG9uIGNoYW5naW5nIGl0IHRvIDMuMC44IHZlcnNpb24uDQoNCldoZW4gdXNpbmcgdmVyc2lv
biAzLjAuOCwgdGhlcmUgaXMgYSBkZWxheSBvZiBhYm91dCA0bXMgd2hlbiB1c2luZyBydF90YXNr
X3lpZWxkKCkNCg0KQWZ0ZXIgY3JlYXRpbmcgYW5kIHN0YXJ0aW5nIG11bHRpcGxlIHRhc2tzLCBy
dF90YXNrX3lpZWxkKCkgaXMgc3RpbGwgcnVubmluZyBvbiBhbGwgdGFza3MuDQoNClRoaXMgaXMg
YSBwcm9ibGVtIHRoYXQgZGlkIG5vdCBvY2N1ciBpbiB0aGUgMi42LjUgdmVyc2lvbi4NCg0KSXMg
dGhlcmUgYW55dGhpbmcgSSBuZWVkIHRvIHNldCBpbiB2ZXJzaW9uIDMuMC44Pw0KSWYgbm90LCBp
cyBpdCBhIGtlcm5lbCB2ZXJzaW9uIGlzc3VlPyAoVGhlIGN1cnJlbnQga2VybmVsIHZlcnNpb24g
aXMgNC4xLjE4LikNCklmIG5vdCwgaXMgdGhlcmUgYW4gQVBJIHRoYXQgY2FuIHJlcGxhY2UgcnRf
dGFza195aWVsZCgpID8NCg0KDQotIHByZXZpb3VzIHZlcnNpb24NCg0KWHVidW50dSA6IFh1YnVu
dHUtMTcuMTAuMQ0KDQpMaW51eCBrZXJuZWwgOiBMaW51eC0zLjE0LjQ0DQoNClhlbm9tYWkgOiBY
ZW5vbWFpLTIuNi41DQoNClhlbm9tYWkgSXBpcGUgOiBpcGlwZS1jb3JlLTMuMTQuNDQteDg2LTEy
LnBhdGNoDQoNCg0KDQotIGN1cnJlbnQgdmVyc2lvbg0KDQpYdWJ1bnR1IDogWHVidW50dSAxOC4w
NCBMVFMNCg0KTGludXgga2VybmVsIDogTGludXgga2VybmVsIDQuMS4xOA0KDQpYZW5vbWFpIDog
WGVub21haS0zLjAuOA0KDQpYZW5vbWFpIElwaXBlIDogaXBpcGUtY29yZS00LjEuMTgteDg2LTcu
cGF0Y2gNCg0KDQpMb29rIGZvcndhcmQgdG8gaGVhcmluZyBmcm9tIHlvdS4NCkJlc3QgcmVnYXJk
cy4NCg0KDQoNCg0KDQoNClNFIEhZVU4gS0lNDQpSZXNlYXJjaGVyLCBSJkQgQ2VudGVyIENvbnRy
b2wgRnJhbWV3b3JrIFRlYW0NCg0KRW1haWwgOiBzZWh5dW4yLmtpbUBkb29zYW4uY29tDQpXZWIg
OiB3d3cuZG9vc2Fucm9ib3RpY3MuY29tDQoNCg0KDQoNCg0KDQpUaGlzIGUtbWFpbCBhbmQgYW55
IGF0dGFjaG1lbnRzIGhlcmVpbiBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgb3IgcHJpdmlsZWdl
ZCBpbmZvcm1hdGlvbiBhbmQgaXMgZm9yIHRoZSBleGNsdXNpdmUgdXNlIG9mIHRoZSBpbnRlbmRl
ZCByZWNpcGllbnQocykgbmFtZWQgYWJvdmUuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCBy
ZWNpcGllbnQocyksIHlvdSBzaG91bGQgbm90IGRpc3NlbWluYXRlLCBkaXN0cmlidXRlLCByZXRh
aW4sIGNvcHkgb3Igb3RoZXJ3aXNlIHVzZSBhbnkgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVp
bi4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3Rp
ZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBieSByZXBseWluZyB0byB0aGlzIG1lc3NhZ2UgYW5k
IGRlbGV0ZSB0aGlzIGUtbWFpbCBhbmQgYXNzb2NpYXRlZCBhdHRhY2htZW50cy4gT3VyIGNvbXBh
bnkgZG9lcyBub3QgZ3VhcmFudGVlIHRoaXMgZS1tYWlsIGlzIHNlY3VyZSBvciBmcmVlIGZyb20g
dmlydXNlcy4NCuydtCDrqZTsi5zsp4Ag67CPIOyyqOu2gOyekOujjOuKlCDrspXrpaDsg4Eg67mE
67CA66GcIOuztO2YuOuQmOyWtOyVvCDtlaAg64K07Jqp7J2EIO2PrO2VqO2VmOqzoCDsnojqs6Ag
7KCV64u57ZWcIOyImOyLoOyduOyXkOqyjOunjCDsoITri6ztlaAg66qp7KCB7Jy866GcIOuwnOyG
oeuQmOyXiOycvOuvgOuhnCDsoJXri7ntlZwg7IiY7Iug7J247J20IOyVhOuLiOudvOuptCDrgrTs
mqnsnZgg6rO16rCcLCDrsLDtj6wsIOuztOq0gOydgCDrrLzroaAg7Ja065akIOyaqeuPhOuhnOuP
hCDsnbTrpbwg7J207Jqp7ZWgIOyImCDsl4bsnLzrqbAsIOuzuCDrqZTsnbzsnZgg7J6Y66q765Cc
IOy3qOq4ieycvOuhnCDrsJzsg53tlZjripQg7JWI7KCE7ISxIOusuOygnOyXkCDqtIDtlZjsl6wg
64u57IKs64qUIOyVhOustOufsCDssYXsnoTrj4Qg7KeA7KeAIOyVhOuLiO2VqOydhCDslYzroKQg
65Oc66a964uI64ukLiDsnpjrqrsg7IiY7Iug7ZWY7IugIOqyveyasOyXkOuKlCDsponsi5wg7Iah
7Iug7J6Q7JeQ6rKMIO2ajOyLoO2VmOyXrCDslYzroKTso7zsi6Ag7ZuEIOyCreygnO2VmOyXrCDs
o7zsi5zquLAg67CU656N64uI64ukLiDtmJHsobDsl5Ag6rCQ7IKsIOuTnOumveuLiOuLpC4NCg==
