Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2048.outbound.protection.outlook.com [40.107.7.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A753C8E2
	for <xenomai@lists.linux.dev>; Thu, 30 Nov 2023 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="biep2KRT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtPrtC4iPWhk0s8KjQu3yoZ7hiQUcNQbYjULPPWkQTnVUtWtPdyJB2e44zf4UxYktjuYRec92yVqgP89OfVtVGla2AYfNAzla+t3Nbs8jvfZqr8G5d6J4FqZBmDS9CCPz6KRS7sVXBaSt52rsZ2BYBuWY25xvysreA2QLdNgycgKcmX8bVNYwvBm/Trfd3noluWQKUxjYCkEqxjWr8FE+M2eml0ZqLX6gFbnY+KNHTWuvllHy+0TFAIT/5kJl83rPaAfYrAVr1CmOMLEhf/O1KJRvNZ9rniphTSKchm8wO8tWib8hH9goVe4YSJ0ZuOux7aN1afc1wva5dhWsgfymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUfGHvZOA52rFVopT1qu2j9t5x3ri8NN20uOI/S+6EQ=;
 b=Emt7+AIqhXASHWvUDQ93zEK2+s6t6WEMcheJj8bv5LHRohcir6tzfD1GFD9tNgDurajR/xwnxH4FKtAJ72c/4MQQQpSRHtaO1yWZk+ZGY5F+VJ/BBSVjLcE1vk2fiInEkWvUQTaLpXUNXuGv7xAZSsyZJeqIK5jVEKI8n8XKDBdP0GJb7WBv5qnHb8ZbP2CdHLcuuFA5NXL9A2F/SBqi1ueKAlTlHTDBiL2C2uq/hraOJJ6zmFdWl+pW/eQUGrvcjqa0TcX2wKhmVyBh7rN5kN4q67LJK8NA+rA0VWCZ83vzqkChIZXW3SjHkaJVE6oDH3zOeId1Hp5+zIzAtGv0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUfGHvZOA52rFVopT1qu2j9t5x3ri8NN20uOI/S+6EQ=;
 b=biep2KRTgEvJ95SZmBl4qLWP4jA8oQ7z7F8EuPhb192qqsGk/VAjjmzcGwgcfYQyNb4AF30m7FchjzLw0Ehz9jHfYbRJ5MXj3VIRYNOYG96UxPWYd2WgSLIKBUNGf1dCeNkOET2penlBjbN5CLC+KNyWi6tICUZcIhw6MZV7EuDsmKqrqcWXDPRNeXy9+mWjKh3ZeKGdayqoJfSX2LQhYJupvgZU9OO+OcJmPtB7rJWT+JcqTX4AAO8I6g/QTu9qDgQRQdiSbgWwF6rOAT1T0rM64Ug5wiiqgz/QifJI3qvXvQBScwyi8XcuneSS2Lxkf2tE7qnx/K+eY5AsjlC5Vg==
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:672::17)
 by AS1PR10MB5721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Thu, 30 Nov
 2023 07:08:10 +0000
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a6de:d440:23ed:d8cd]) by AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a6de:d440:23ed:d8cd%6]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 07:08:10 +0000
From: "Kowalsky, Clara" <clara.kowalsky@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: evl: Problems while trying to build up a debianization 2
Thread-Topic: evl: Problems while trying to build up a debianization 2
Thread-Index: AQHaHF3ZUo78hQzcVEWcjXs1yhNjzbCRl6+AgADnH/M=
Date: Thu, 30 Nov 2023 07:08:10 +0000
Message-ID:
 <AS5PR10MB81734701F7F0C8A7B9933D029382A@AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM>
References:
 <DU0PR10MB75546BED8CB2E8DE4763395E93BBA@DU0PR10MB7554.EURPRD10.PROD.OUTLOOK.COM>
 <87h6l4jwwu.fsf@xenomai.org>
In-Reply-To: <87h6l4jwwu.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-11-30T07:08:10.265Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR10MB8173:EE_|AS1PR10MB5721:EE_
x-ms-office365-filtering-correlation-id: 332c954d-2c47-4f2b-3c1a-08dbf1731c94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 t0dVjqJc8WVxcvQZu/BcJWDzw4NXhvjHdptOA5R1ww/tAYAJlIJ40RUzlK2E6uZJEg4ZbA5zioDi1I/hIWHyj0SKfi3yAYjlXCoq8qSW2Gr7LsQPxg8NADyXfukg+n7I8b0sFGojPN+Sw7TS83Y2zKyhfyyvjVqKT0FfTO2PhjplQhit5YAHj22Mb8F4UUtA2EHCBB/9GQUEjjZ9qrYVH8Zg5qycP+VEvled3UJjEeEBJaOQYORE+/1zXY5rh3wH/wOQTGhrZFxoGD82t1cgFi9Li4se3WaIZdDUFaCkFnqCBo/xwb7Ts//qP46ZGofGHulkgePMLqNJiJDU0rvqtT1E63iXQXuoSLifZsP322w3MUb15cyeS2+gMp1Na0q++SMlIjsEWdz0HOXEzthpuXX6+a58RGdrntATSQZNmK0JVljwaz+Ln44P+CNiCuG7qHsyDmHV7evex8Y8pXHCF+SFXaz596mlOLELy85wmXbUm1OdqT6AonXA1rSP56SNrRz3Z1GdYsivIjabIg2TYrEnmTQZGP4Ci5WezG2MNV//SPmNNqi/16bGN69NqXVCVTW9EWicWiuEj4l1hQprb8iLkoF/VmuVCpaiGCBMlnuFFIc6z8Vr6fcRcYS4Uuw9agMfWd4cvt56zF6UTrgRshZDa8jBobBdRiOxQkUBvDI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(71200400001)(122000001)(7696005)(9686003)(26005)(478600001)(6506007)(5660300002)(83380400001)(8936002)(4326008)(41300700001)(66946007)(107886003)(2906002)(52536014)(66476007)(8676002)(6916009)(54906003)(66556008)(76116006)(66446008)(64756008)(316002)(91956017)(38070700009)(38100700002)(86362001)(82960400001)(33656002)(55016003)(202311291699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?EG2m7uRTIcX9sifWsljh/qQPDtmYNtZ+0NhhHcZaD7GfGCCz6ozQ76ltxb?=
 =?iso-8859-1?Q?UYDzk5rKDw7v/VrD3CYaScEXYBVuXBuZKsSuPqKg49P5YEWHQi9O0Kk65E?=
 =?iso-8859-1?Q?ksW0l2gDhOEJskZdWLD8vm7cZw/6QuKdkphNVf3W86fo6e2lNRnyJke2fF?=
 =?iso-8859-1?Q?ImIgkogRiU34B9p4Ww/rCGjPXGiWCJ5zcbgNIy1ib8CiQ0Y8z5Ukih2Ta7?=
 =?iso-8859-1?Q?jsKuCqJuWZ6BIG55p5RuHBKNh7rqBiXIGVXX+lDqKRgP3Pz3F62Qo3citi?=
 =?iso-8859-1?Q?p7yePxJPX5u/zqhmsPwbLuaGh6kWUBP9fn+O5Y4oLHj26yNQMdhSVrkwQ+?=
 =?iso-8859-1?Q?oMZDCnCmGiwJRZ+/Q5gCOQzYbO2+7tyIaf0RPjGWwRj4HHlkjzt6hKvY4/?=
 =?iso-8859-1?Q?7PPCJ0mUAiFtdLorwvj0+ZR1JgE0Sjupq555ZBWDH3bOr56SThCoaesELw?=
 =?iso-8859-1?Q?pl6RqB3z7pRtWGBaYuCY6XrsQS6Te3WzysomgAgYUsOKlJ+M/7IObn0mjA?=
 =?iso-8859-1?Q?s2O5GKhwz0MdJeGolwVoFrLJqlvhOh38Ln1+E1qpT7OFMTfBeZt+8OoMCe?=
 =?iso-8859-1?Q?X6hAYqizsKK7+e/o51K5f0JU0cgOIRpyMMv/m6pWbvloVRUkQoFRuOZznT?=
 =?iso-8859-1?Q?+t/JlcM2GkORWv1PL/GK2iHTzxRenZcnG7jLFk2S57xoUQbOxW6grLSgGx?=
 =?iso-8859-1?Q?TErruCsMPKHju8i2t+4xbDq2nZh5WRfaWa/bgWyM11w9nwWe0hgp+oQKPT?=
 =?iso-8859-1?Q?zJPiK5khqsfQc6vncS8EsKI1kO842k1K7eXlQj87iFaACD66yafvyqrR7d?=
 =?iso-8859-1?Q?UMzkU82LHhhxaOkMY9Ht8apsSV3uU5zGu/zqjC6mH1LtqxJjnB95KHO6Hm?=
 =?iso-8859-1?Q?LhQ3NkWAPqDAU/jXgCX36VPoIX1KVDveHHZFxBi5XlLC1Qpkkd4rtK8C6N?=
 =?iso-8859-1?Q?Z1a3NmE5AU4U4JjI3YVsbgjXkBHhwPQP4oWZgmS18zoAlTG7e8UAWokoL6?=
 =?iso-8859-1?Q?gBqmoXZZy0UaTLEbUyiE4Pm65Rbj6Py/FPY8TIwKuhcJV2jXWWYtgmHjIw?=
 =?iso-8859-1?Q?XmLmeQy0mGIp8TpE6iFW1LGtO4x7J59IQkcL+hjcsEjgkJyd1sYMuttlb7?=
 =?iso-8859-1?Q?SciQC8tvvVGBNLbFaIYSGdY8iTOoAjFw9tITBXT8PG7k8JTR0dp4s75SCr?=
 =?iso-8859-1?Q?urqE+7OYyi3xNMwPfq8AOJdL+8la2379N/ta/Nx1Zifv1vjYoa9FNVU3bT?=
 =?iso-8859-1?Q?ZTE7Ud8eSNpJEm4nlGUfg+gb67miEdqIEFH9wsJcNwnHhpdGHgsm/8DqG5?=
 =?iso-8859-1?Q?O4tqvrdoeqPc1OCM4ow6wGwLF3oDv3jSfdkliqUNJtPG5DzWc0Z3DHtfFc?=
 =?iso-8859-1?Q?RAg1jsXBrulGmi0F5NfMpmZH6xdvaXHzMb28BQIh+fKU4VUhJP3XxlsgQg?=
 =?iso-8859-1?Q?Ubj8ip4JjJuO6PoSV+p3ZhEbO77JETUH6fFnOVsoCdFbkm3d+TXWP2wy64?=
 =?iso-8859-1?Q?Bf6gT1l/xfEc5cYGp6yZzSaYMmXjIROAFLm4YOGgr/fOQD51k4uvvLfAHS?=
 =?iso-8859-1?Q?dMnsbrnZjjCVAPdSWzdWSYmbaNYXQcVk4C65cyda+pZAhOLewJx6eMYibm?=
 =?iso-8859-1?Q?Z7iv0FWIhqZlAtAsjf07EWwsN2XF5sLCEr?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 332c954d-2c47-4f2b-3c1a-08dbf1731c94
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 07:08:10.5467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41asAxcPOZuvI2hQ52+OR98xn9LNSctF+Mc+Xo2usENRqRyoFue7tpOwt14zYF/rIzZ1kYWdh1WZ84G1OfXszEHU6b8PmDtbA8Tz57hh4nQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5721

"Philippe Gerum <rpm@xenomai.org> writes:=0A=
=0A=
> "Kowalsky, Clara" <clara.kowalsky@siemens.com> writes:=0A=
=0A=
> > Hi Philippe,=0A=
> >=0A=
> > regarding the enabling of xenomai-images to generate images for EVL, th=
ere are still difficulties.=0A=
> > When using the linux-libc-dev package produced during the linux-evl bui=
ld to provide the kernel headers needed for the libevl build, the libevl bu=
ild fails.=0A=
> >=0A=
> > The setup-uapi.sh script throws an error because it is missing the path=
 to asm/evl ("/usr/include/asm/evl is missing"). The other two paths /usr/i=
nclude/asm-generic and /usr/include/evl can be found.=0A=
> >=0A=
> > In fact, the path /usr/include/asm/evl does not exist in the linux-libc=
-dev package, instead only /usr/include/x86_64-linux-gnu/asm is present (De=
bian multi-arch support).=0A=
>=0A=
> I assume that /usr/include/x86_64-linux-gnu/asm/evl/fptest.h is present,=
=0A=
correct?=0A=
=0A=
Yes, /usr/include/x86_64-linux-gnu/asm/evl/fptest.h is present.=0A=
=0A=
>=0A=
> If so, this is solely a matter about the multiarch prefix, and a=0A=
reasonable fix would be to have setup-uapi.sh consider the target host=0A=
triplet for finding the asm bits.=0A=
=0A=
Yes, that should fix the issue.=0A=
=0A=
Clara=0A=
