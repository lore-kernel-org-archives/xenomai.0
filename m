Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2097.outbound.protection.outlook.com [40.107.247.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFB16AA3
	for <xenomai@lists.linux.dev>; Tue, 26 Sep 2023 16:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAs7/GGg1PNp5JifqBeVLT7Vz6SGF2RctOmVFkMosvUnkYebe8YTAwdrqKVG7dFxSSX5Qma8x9Iw4iJ/YqnXAiaWkEx1CQ2jr7ZYZ1PN23IRxBpwrLxnxLhWKnys9dyQgxeG2Sux80ZrvUUG6nJxM2sShZQ7ZVg5fjx1oTjt1shOTpVxLabZnnrFSRlzXh7ryCd4G5nof5TogDOoQYthzCODhfKTT5SY04ci1lBk5O2BgD6vbPMQ8UxQlhHViGi3yhUxz7n0u8FGS6DZ3wykDb+kQCkbRquF2pRxU6E6/tzDseHz0WsXHaoKAnfOTrgAlt/+/y0sbnIZLv+ATl0STQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwAeg5EPP0dxgqh6QjjtdfbBIighQEqHKv6yA67G0yc=;
 b=OxC+FPeGduEHJefYGVqNFHbYS8Qy+NYKtTSJ27KvkeeZVDe7KVdW7boBo3bE7ljGHB/XDxA/1zdfolAy5Kot/J0vRh5dTkZqjQXuo/EUSSe7ZUd//gfJELFPR9a6xoxmcwJVJmcSsldB++7FZuOw+nGULbOlN0mVwlqourpKWm3Zf9ZP778Iwk2GTAdHvLlq4StGgireYt9CfTSZXBDkee6Bnyw8wAykyiZ0WzRkJMwwbSCPwd+ntljmHYZRLHFplfRe1EJgYPoU6ZIFpV+LX+MMFTjgFxx9STweg/nLlMlkkfG793dRgNix4alTL8a/U/vMKfnq/6nsM2yYi4dyLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ecler.com; dmarc=pass action=none header.from=ecler.com;
 dkim=pass header.d=ecler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ecler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwAeg5EPP0dxgqh6QjjtdfbBIighQEqHKv6yA67G0yc=;
 b=XPQH+6RGNzLyouGEPg6cyR5zK+gnEjCV34nj1SDJybUaBlzV4kgMSKvsaSGPCksdOCMYTaCRU6En2HVCm2G5dxt7bDm4FyD8ymy3Bbl7ZACd0cX7M45SWovKpKPAdXk8e8F7BaDpWrI5GEYbtIZSkt5PKMroS3dCodvcQssv1FQmnNDJ7ocbc+67G/FSPDXrv0vZeCKtoUdvYnNKVSeXXfgDri7MphiZ+nUjNbDAdoqR9qBOLwVVSUJ4VN3cPGqlFVb/d6DrITgVovf4SUnbV/yrEpDUPSQxeiWr2vnXip7XBtRlNUyywY77pWy4QZwtX+I9haNy9oVINDocMTuP5w==
Received: from DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::17)
 by PR3PR10MB3835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 16:04:33 +0000
Received: from DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::724b:81b0:1a33:23c8]) by DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::724b:81b0:1a33:23c8%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 16:04:33 +0000
From: Jesus Villena <j.villena@ecler.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: [EVL] Problems writing to physical memory with mmap on oob
 context
Thread-Topic: [EVL] Problems writing to physical memory with mmap on oob
 context
Thread-Index: AdnwZ6yKI9X5QCLEQ5i2sLHRmtbSswAHD/AAAAKbMhAAAJCfAAAASC4A
Date: Tue, 26 Sep 2023 16:04:33 +0000
Message-ID:
 <DB8PR10MB3706CC719B10DB6F15F7C64BF9C3A@DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM>
References:
 <DB8PR10MB370698CF0BAFEAE2198D24A3F9C3A@DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM>
 <87sf71nf1h.fsf@xenomai.org>
 <DB8PR10MB3706B544A1AD8812E2ACA78BF9C3A@DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM>
 <87o7hpndh0.fsf@xenomai.org>
In-Reply-To: <87o7hpndh0.fsf@xenomai.org>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ecler.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR10MB3706:EE_|PR3PR10MB3835:EE_
x-ms-office365-filtering-correlation-id: d9b221ee-1b1f-42fb-4212-08dbbeaa4671
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UI7oYaC3Jpj+y/YYP829OuIPhbwTbXKZq21ghRplx+8nmis+KB+CaFoNMh6dR7YLSyKilMZNCtkVhQ/Qn8O0hAWQQrdCbejJsnl7yPCty+ij7F/Xc5GWRRr7IG2br3rN2HRAG4d+yrvp0yGUPnH5DtbFR7Fi+AWod5krQM/zNq+ivu9lozvifKyuAxUTmx6VQzHIqwTAb3iEWdTUB/eWDRsCLpQfdXV1aQ/m+ARBlwB50tC94MnVFikfilRS3G9Mo2f7cxi7ZWKGstO1B4d+EI/frEbTU5Ul4MQYFYdLyOpF+EnCssli617JduYRIm9YYI6oLvuwc9/TR1VU7npnADOPGznKjf8GkeeCxHjF+rTmoPbjboySl3e10EJFuPk6O+X+btWz4Mcb5UC4iZ3NMebCYcGoXmfbrggwSF15digpe4VIuM6lf2WKwRHMyFLQVSQATpvQhw+lXxbNBdOpHBU450Uf3heQbFn/0YQXO8Cz8NHazEc3x+Jxvkew4HLCMA2SHT5LLPA8eM1nVcY+Y18iABbfu5kUQug9ywIkPtbzeDXn09ID9WkDmkFfrXsQRZquqZEwiPZhsi6FfYKLc2mpEYWvxz0ECULQdCCdbX2IZhkg1fkH0joVsWDu7MsR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39850400004)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(6506007)(71200400001)(26005)(86362001)(7696005)(66946007)(66476007)(66556008)(9686003)(33656002)(66446008)(64756008)(478600001)(38070700005)(38100700002)(122000001)(2906002)(76116006)(55016003)(83380400001)(5660300002)(316002)(8936002)(6916009)(8676002)(41300700001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lh4HfZERUpfmgfVzEArC2kAHnPQoW41A0ygu052icUftOdEqMQCxn6Oh+/00?=
 =?us-ascii?Q?WwyVcj2Fh4LyaS/hIXu40Fp3GFw/FACu1N0TnI78AgRuZxjXzodTerezI8iM?=
 =?us-ascii?Q?sLo9tF2fcphKOlAMNHpKiNT2WBiqLtPQ15AguJtwRbWrGOThsVMus4LCTv9p?=
 =?us-ascii?Q?YvfcO+W65pvs5Dz9+B+q4ySI5frAl2FGWtA9VIMg1dL1P9bXER/7wlWscIEL?=
 =?us-ascii?Q?Ky57N2I9yMlqvYwv4nsaNZ+33QsSSOoFRkzHYULgFuRXuR3wzrLBVf+sI+r7?=
 =?us-ascii?Q?QteLVypqIuDCflmnxcf2hi3zKd6bkMYdtRzhmvWDMRKG6+HP/1hJcdgkHxFM?=
 =?us-ascii?Q?Jx0VDolsDRsdtNTKezP+Fy8JtTPjzdyOXEZuXmB6V9J7rr16poKDabgXvU9f?=
 =?us-ascii?Q?7tmVKv7dZE7P8ATjMsjcHk84lL2kevHLykX1t//2f6k0+RhDVU0UkXqVJI0v?=
 =?us-ascii?Q?+CotT3yBsDJchB1pwJMkCalfan1ld8WXR/eNUgXQQbheS0xSHn1PWYSS53p/?=
 =?us-ascii?Q?UvClxNHpxxgs/tvRhEs4en/PZTIdtE/NoLtXEmZJE6xm6SpkJYawtkLieuvn?=
 =?us-ascii?Q?e3kBrVbWA30LWTDN2mpgR8iQTf3jBZ2+i5t1aQWrsYzV/JJwIRTZim7DtsLH?=
 =?us-ascii?Q?3dOWjPHZiTmlZ/sp4rGvx82lSCUlp+iklC44xWv+mlbj/qakIP769j8Z3gA+?=
 =?us-ascii?Q?V/O78ON6ZgbzV1nb0tM6OQeKJYnH5M6rUcufo9SmE0juvFyFC57g9+CCrPsB?=
 =?us-ascii?Q?/wFLp4DZlbDvFs+Yk3lMcXOsIH9GK8g4N+V6V++EuQANo8C92vNrO0sMO07C?=
 =?us-ascii?Q?/ldky93ZBuhqc89SCUFC06lpkPXm+VEXaE7lt4AkdNQTI+jgy9TG/kb86Jvk?=
 =?us-ascii?Q?Exmlnuf2KDzOadhJgB65XHetTBxSz89/Ysc3MepMoOqqvsXdYiFvVoe9NEKG?=
 =?us-ascii?Q?yfRdjocizAoIoaf5L+fvVXZisZ07tar9AiTCgAaHRmq4twfUnzs3+2xsg46T?=
 =?us-ascii?Q?C27O4lQx7mi+8gnp+a7lupIQW9vLyINqz7F/IfRHkGKV6gTTufa4k+HwQ1DT?=
 =?us-ascii?Q?a6aviEkfNVCuZbEw9qCO3zSoChqXchA2ULJbz1TBiGzH5dNdc9tWthYIs0/F?=
 =?us-ascii?Q?Wn6TFsBLT5eMHqFMBcvfOIMgBcciPw4WllhAECZo/PpDE9X9PbdyY7JBrtYE?=
 =?us-ascii?Q?BEru4Pp339iA2jcjElXiy3AxXVdNT6DSZs/Vksh6ZOpVVh0/3fE8u437mWWR?=
 =?us-ascii?Q?U/DA30YHFdNrkK1jdoEO10KKz/HwMMMBS1qTZ2jzsBGMphnJLf81l9/zeqiE?=
 =?us-ascii?Q?4xHYpRQQCOwhUtKSbJt6aCpkTnMO7htu4DH17SHWaIjcndsvcFAKHySlvN+L?=
 =?us-ascii?Q?Z1hJTC+kD3VN+6+Il0upVTXVJmCWvROuXh3HBlgpSFBeGamsB+5rblmBzKeE?=
 =?us-ascii?Q?n+qu31BXg1gZ69C8JgUcE661RmEuedg/ro1cTFKYJ/t/4ND/8SYOEN3otLF+?=
 =?us-ascii?Q?n5QuB19+FU6988kzlMkadMpiJClMhhUK+KFqha4QgwdfM8yOmSUH31kcBIyI?=
 =?us-ascii?Q?7bfXTSvyg4tiFUqBt2ErMJN3xzQpwUr5nKMPh3km?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b221ee-1b1f-42fb-4212-08dbbeaa4671
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 16:04:33.8458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6f9193a3-7ddb-4a6c-9664-df2759e0e5ac
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZ64WZivkxSpQb+CTNUr9SXRaonazomrE+oSWEPGwRMbDP4yW10B5yGVShoSx2EsCjD04ZZX4b/OGbAmam64/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3835

Yes, that's what I understood!

Anyway, I have made some progress: if I write something to the shared area =
(which is less than 4KB) before going to oob context, it works as expected!

So, it seems to do with a page_fault the first time a write is issued in th=
e shared area. Sorry, but I don't understand properly all complexity about =
accessing Linux virtual and physical memory, security, and protection.

Regards.

Jesus Villena


> -----Mensaje original-----
> De: Philippe Gerum <rpm@xenomai.org>
> Enviado el: martes, 26 de septiembre de 2023 17:46
> Para: Jesus Villena <j.villena@ecler.com>
> CC: xenomai@lists.linux.dev
> Asunto: Re: [EVL] Problems writing to physical memory with mmap on oob
> context
>=20
>=20
> Jesus Villena <j.villena@ecler.com> writes:
>=20
> > Thanks Philippe,
> >
> > I have already tried the custom driver solution you mention, mapping th=
e
> shared memory in kernel with ioremap, and adding read and write handlers
> instead of mapping the memory to userland, and it works, but I would pref=
er to
> do a proper mmap to access to the memory in a transparent way.
> >
>=20
> I meant writing a driver exporting a mmap interface restricted to your SR=
AM
> area, instead of using the generic /dev/mem device for this.
>=20
> --
> Philippe.
