Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2092.outbound.protection.outlook.com [40.107.21.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24231186A
	for <xenomai@lists.linux.dev>; Thu, 31 Aug 2023 14:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et+AwJk1cKHtRb1szCaWBE0h1KE6u2kIKtj5RDXVpzVud4NK6IdyWieniIl2NKgw4DXzK2aOczmGvKOEaVEJ7hxLMl3ME2j+kXJ6y1aUnq2lo4dIotpHQS0N9jq4lKxmBIZQQ6XN5LumgE72XZ3Mw8ArXcVXwpnwqAgdhKI6jGBJYbhwkmo+dQn+yT7tou7wVQNKMZICzL+wo5LGQtUQ2oksgr9FQpliacg/EkcP88mPvAVxWXZcmD73MzLTokBXt/AOEADxxyTnhlUFJVlZHNTqhDRUues1aVA95GrKmYrYQvkINXQa+9jLiSK4ZY1TBrBQ1VXipu76AkRLsRMUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rk0Vl9C7UGsSmmby+SFVp2fIb3vxnFM6/1XmDNDhTLk=;
 b=QqvSXBzG/fndS5kECWs5miVw9D3zZ4vrEhsoiKA9eggmYYc8CruYm79bFnkNi0s4lQKY9d/VuIc7whCmwgU1C6q2mOM96kydj4Gy162maDmB1IkBcMcLTlU5MCYOVBSU1VhkxkAbPgPdf2T2gwxqF7yv7QXYaiIwtZaEEc3i+gl4C98w07KcM9MEbzR3+k54TNJnBeK33t7XTlhVrdJ76s5KCgVeuAQlQJDYyyPwxsANtkHSDDLDajM0jw5gZWTKYwsrtKeEBDthePNunCLlbx1UMAG9bVMF7OIOGEXvRev+kFpSaqlXnHi5ZS+HrxkGcMnp4dogJY7qaK5aA8xV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ecler.com; dmarc=pass action=none header.from=ecler.com;
 dkim=pass header.d=ecler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ecler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rk0Vl9C7UGsSmmby+SFVp2fIb3vxnFM6/1XmDNDhTLk=;
 b=B25gW5qo+jV0i1EIMcFrPtq8Ml+si1Y1cE+/phy5JkEmY8IROVT4S3mU/9Jmw59VIphpPzSs047Sha3uWEFnLDWAvN2eep4UBSCXlya+2fQZPs+iHMrabN+dWQYwQr1JDQvOmYGwl5NicJGw0M/zf+sQAcNAVDtJmsxgsw9RrA6EDiMbWIpPTUfy3eddvT3dC2G2zBYK8qMngI3qFys6Q/ERS7l3Lv95+7JprOvyJaBMTHCsq4fMTHz2KKZTkcEbchwNVr8vup1A52iR/59xkxP6fFi6ETtVYpKMxNFhvV0OH6XlWaoEHtqFuRmjVyRXAjXnCRnDLIUiXJVtCxeHQw==
Received: from DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::17)
 by PAXPR10MB5615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:245::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Thu, 31 Aug
 2023 14:59:17 +0000
Received: from DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e1c:67bf:856c:9c98]) by DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e1c:67bf:856c:9c98%6]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 14:59:17 +0000
From: Jesus Villena <j.villena@ecler.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: [EVL] GPIO driver error
Thread-Topic: [EVL] GPIO driver error
Thread-Index: AdncBeRRjgB7kKECQA2lYHfUvYqVyg==
Date: Thu, 31 Aug 2023 14:59:17 +0000
Message-ID:
 <DB8PR10MB3706C1F288ABC9A40F6E7E3AF9E5A@DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ecler.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR10MB3706:EE_|PAXPR10MB5615:EE_
x-ms-office365-filtering-correlation-id: d2879b76-62e4-4d9f-8e23-08dbaa32d981
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +zHf5R9p9zK7grKrWPoGp5DV0Q1uAWMzgWfaD98MDo5lWiuTQ9XnLOdOUMFEzPWflxU6RDyoKTT5J6IhcU+sIse4xB9kjqz304KstzU36HvnmTFc6uYPBP3L56t0EDCpFrnGuXZGiuIAwaHpiJ5VXHxbHU9s2KH8MChUNTes2DXXWHv7a8lBm3WE8tpqnppWm1JJu4Kix7w2XlmaKJA8cEm5VLrLuLc/FoRxESza+XFHSr3VkAGDKITf8k07JPCXCLzvAqyJs2s9WiIiUBy1ZFN5VRTYFOHMJRauN41D8Xel1pVAPFndrcBT+EYylQOHxqtuM2PNeX8thhMlAkVUz9Es3OuCdCnz9GaMeR0nLoomeHsGfs5GtsLs5kkI9auxwEZd0z0rr7nB3Rey8/yFiq1OoLW8ckvK8hNopKDyZAWjanjp+jSwp77f/+umX9YC6vdKEey7VJKS508GK05uWW8KHiajuYZ3DnndIb4Wd9QTm0uFqBJzzD2SY2sr2x7mwW2X2tiI0dIp2rKXu/F5nLHYXD2x5NqKIhofSkigrQfqT0bv0JauRVd6EYXUaLo2Xv5+VNmm0oA5Sv7QZCh+ohhFZUAB9r+CVwmgadfJactRkitFUUH/nzuKTiaFCsavw2iVLh0z2FZ+bh+GfdULk4EnAa0+hPB0CTy45S8m4H0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39850400004)(186009)(1800799009)(451199024)(8936002)(66946007)(122000001)(478600001)(76116006)(7696005)(64756008)(66476007)(6506007)(71200400001)(66446008)(66556008)(6916009)(38070700005)(316002)(38100700002)(41300700001)(9686003)(26005)(8676002)(5660300002)(2906002)(55016003)(4744005)(86362001)(33656002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Np1twCfdjk+dA9pv9JSoG8Ya98Riq94owTAaK/kxbTW9mUrr3ApMqXDyeZ?=
 =?iso-8859-1?Q?geHelHhk4822/1ayUX+AAsTDZ4RY87Y3ztbb5D7mtn3V+mR9XLVn9tST7o?=
 =?iso-8859-1?Q?eNW5bshkdt9OcDMON7R5L79GE7eyUq8J9GpRCSXaAbikPcyjGvLGzecvrJ?=
 =?iso-8859-1?Q?quDBcOi+5/5xJCw/QZWh5YglIbndaCk2UrYTDuwdNYDuznspZqg6sAn4pc?=
 =?iso-8859-1?Q?ABksogbhyYcj1KaV5ZXUYRnYIKME4Kr0UevMVUPYsEgTJaKWVIb2Z4Vckw?=
 =?iso-8859-1?Q?2UEu1qDAfx0WyAOhfEu3uDroJsAVe0lpg8eJIQBI90Psvy/LT82dC0SXi7?=
 =?iso-8859-1?Q?qF8GS2F0nIt8aNKk4EYX7B8LuNBqgcyfX50QJDRLBRNXyNJIGGNU8QFRG5?=
 =?iso-8859-1?Q?Nv1ZSz6bnY+RMCkqLSeqmlCrCtGXnEggke+guz/UAG7X3SuK5/QUTGO2z+?=
 =?iso-8859-1?Q?2ZliupRINcfa9uCV8fBIiXOPiSMk2sraEGbDzJrG7H9GRtifydWM7A0Bqo?=
 =?iso-8859-1?Q?vu9lDT6b76gawrnBSL4gUPAQlplq2VtjybxhDM5DOOXM1Ek0ALqWojszZ9?=
 =?iso-8859-1?Q?unth+hmA2jz2TuaDmWZUo52BpfOu9ruoNND1scrFICeAZcaed5YAvyRS/T?=
 =?iso-8859-1?Q?j/T2VHx5NqAlkVoAGjfCOFQcvyemxkBpBHEt6FAmnBKwSTqvsO2dLtPD9P?=
 =?iso-8859-1?Q?0hy9xqpeoUYIR+/5vvrSGIzaS6DvVuqIdH6V5AkiI/Aa0SHnPoqi8+HLaW?=
 =?iso-8859-1?Q?cauHCV9CsPwo2HXsugczK25gu3M+pd/CGHUCcmzZkm1IBQ27XOeVw1Qd+W?=
 =?iso-8859-1?Q?mVCegADkiGK8eozxNhrauKKH15E9MEufYe8/Nv5ZPmOH98ZUg/uJZUa5qQ?=
 =?iso-8859-1?Q?mpfbrJ+lcRjQktVL9HS2XmylzmYZQ5ZdxB1y47/SdVL/LhsFKhNRXF/v/G?=
 =?iso-8859-1?Q?kifW9ra1Tt0+R69YO1aKhbDROHE6J8hm3PzpFg6XKel997NbinCyTozNwI?=
 =?iso-8859-1?Q?wsuzM6Pk9geTzJJXm2b6YkLGKd3+UvARC8W9RKpknLNQYk+2V4MAkUOKTE?=
 =?iso-8859-1?Q?N3Uu8aqxRB/m5K+chePTF7HLkRYwZ42JjqfCKHziYoUvBmxCmEt/qR5vEG?=
 =?iso-8859-1?Q?Q0bhSp4SwELhMFODE6v3Eakb+NTsy7ZZcB2/lp5vjgBsKiwIIGh1Uu1spD?=
 =?iso-8859-1?Q?jiByYxEtQDuIEAGeNorLfCxVwGynsEK/Af79c9QWoFXk0aolVv7kB4o8GM?=
 =?iso-8859-1?Q?pqsNiuIAHy/c5fqTTGxBscfLr1Ffgtk1x44RCb/G8D/zUn/W789g5KzECk?=
 =?iso-8859-1?Q?ITVKCb8y/9O4Tni2zEgkdA3NQb3HScec7XkCoI+jir9kOCVElRW3va1IBY?=
 =?iso-8859-1?Q?AK4MxBxVVadVjG+/4ubkQfaERu3GGyGddOpPo1G6K/xy7gTAiNszkCpLGS?=
 =?iso-8859-1?Q?GfabuRFXiSX+vA5y6Q0gmFqiGSZ1EHhHg2gbl5uX2o9OnT1EJb4O/am6n9?=
 =?iso-8859-1?Q?U0G8mQhJH424iyHJOQsjaYnB7X+zR5jozXx1YlREymT64MazWKtY7hxcoM?=
 =?iso-8859-1?Q?2eHs1iZrXL90ic/SZn6jQCBUufNwF/46c0rT6aWtRDtC11/6BxfNje+zYi?=
 =?iso-8859-1?Q?MIHPPdk4laZpA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: ecler.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d2879b76-62e4-4d9f-8e23-08dbaa32d981
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 14:59:17.6860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6f9193a3-7ddb-4a6c-9664-df2759e0e5ac
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HoQ9E4wnYY+fcJ+kNqSmOHdh6j6H3x/7Urd2mjnLBWvs95Xz9o/ogYzgO/t8HEaW+duGeXTWSnz5IWO7dOmTEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5615

Hello,

I have found and error on drivers/gpio/gpiolib-cdev.c: the function lineeve=
nt_create doesn't call to init_waitqueue_head(&le->wait), which leads to a =
critical kernel error plus rebooting when trying to use GPIOs under an EVL =
enabled kernel.

On branch v5.10.y-evl-rebase the fix would be on line 2026:

2025 =A0=A0=A0INIT_KFIFO(le->events);
2026 + init_waitqueue_head(&le->wait);

I have seen that this error is present also on the other branches.

Greetings


