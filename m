Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2130.outbound.protection.outlook.com [40.107.22.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0B01802E
	for <xenomai@lists.linux.dev>; Wed, 19 Jun 2024 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810266; cv=fail; b=ljtMNpfpc2wzMkC1fIL2MFhNWwilw6CVaFXyPZvL57AHyhiYSSx36r8MCA41FyBppCzoL8gDeXApmIS5gLuhnusK2Sulz0e40JeTPmbwqWLn1RfzmoOoD6DqrQ6TIFRFtSbDzRisjmaOLgsy4ovqaPPu61pwAsDnXYqw7ZPrpTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810266; c=relaxed/simple;
	bh=AbnNcvoZsh6Xsy4OhWLliwCwuESR211tdABWBb0NpcE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d8KtW+QU6B8hYmvK7WCMGVfs+Sg2lBB7WpLehjoTdqgErFDhloca6Hz7nhQnVoTbu28ZicxIcfNi9db/2hNUVNKXGQVc5uBZEEwKzR3qUZkWD2wkWUMgbXjnIvG0DmbrlRyeCK7gNQDbWj0fxHcDnTyCdTkDxu7OIJLQ1WiYm78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fareco.fayat.com; spf=pass smtp.mailfrom=fareco.fayat.com; dkim=pass (2048-bit key) header.d=fareco.fayat.com header.i=@fareco.fayat.com header.b=h/3g7urW; arc=fail smtp.client-ip=40.107.22.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fareco.fayat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fareco.fayat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fareco.fayat.com header.i=@fareco.fayat.com header.b="h/3g7urW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkQTFyUKtYxD4hZpx0GsXW8rbtdbVlP+3hwr7XwQAnbJUR3rk8QsB7MMl8Li0n5m2BgB+8dZanXVoSF9fXYm2yFEtEDEQyCf1uV4GZgKNEXs64bxInauRxAJ9i1elvBwWS+gBfijw8nNEs7PMxM2mWLMmgs64XfQ434Tfy68d4PCfRw7gcg2OOJeD7xZTiGex3A1N5FcVP8zmiS8F2VqSbbvvOGNuEhk1w0l0eXW66tBlur5rrdcxeb++YgEmzgxbgX7/Zp74lUsCJXTHPMFeTxOrFi1Hqt888SaBMtAexKkZfiu5BeqoeMQAr3gezHbStD9uqmWtXh/VmzNTsa8aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbnNcvoZsh6Xsy4OhWLliwCwuESR211tdABWBb0NpcE=;
 b=YKRyt0bBlwIjE/ndHSCfyO4efY7OSSUhPivAMxsy+Niqpgpbe8gMcPL5yXa86YOuDloXrSH2harPuvkXHw7wSz9ei2ecdsMX6mdhMxLshjPiJoBBbE8UH64moaoTUOKWlpgx0VTZQt4B6NB5aSB4OxLHnkbE3zsyEWzHhv0Dn6OVkpSJysxt0RZ2ObnUhy4V2bbBy1vot44zMx3Q+8cCv+ZpeTdhU6w5/RNZEEaMNVULYJ7rlDW1aXWFFmI2e8ZKUZiC48W9mjgTkQbLxWsxw6EAk7dluE7OY3OMAlApEBRYq1LYo7Bl4xUws2K7ic6u/U4/GY6gugvEDUNiGpTfSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fareco.fayat.com; dmarc=pass action=none
 header.from=fareco.fayat.com; dkim=pass header.d=fareco.fayat.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fareco.fayat.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbnNcvoZsh6Xsy4OhWLliwCwuESR211tdABWBb0NpcE=;
 b=h/3g7urWx7cA0yxGDbFINtUOF1e9dHVWSdBJCPRS6DiQ7PTM7mqRgxs5u1zxoqtNRQSprAoxup17bHAtT4s+J4D6oektukWl25rUR5L5fTDWFDOpkt8zz4ZQ0ABzgt8pdNBDhFv1oR7pG7/TirCLY2AsoDYSaCM1Lp2dE2fWxldJvTc+d1nWCDrOm3YQmf4ocaruMYmxvLnPUMMwstXsHrr0m6NiJBxavyK5rs406gbJTDqsey5XUi1etB7RxnGo/ZEaENTMOKpuc+XFqTY565UnupHxH6KZf9500ooHPr2XpBeldCN3vEwcQhnSOvGtbLF3nwD5syi7asc4j+M4Fg==
Received: from AM6PR05MB6024.eurprd05.prod.outlook.com (2603:10a6:20b:a4::24)
 by AS8PR05MB8037.eurprd05.prod.outlook.com (2603:10a6:20b:319::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 15:17:41 +0000
Received: from AM6PR05MB6024.eurprd05.prod.outlook.com
 ([fe80::67ee:17dc:6f66:7f6e]) by AM6PR05MB6024.eurprd05.prod.outlook.com
 ([fe80::67ee:17dc:6f66:7f6e%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 15:17:40 +0000
From: LE-DOUARAIN Marc <m.ledouarain@fareco.fayat.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: EVL kernel config on x86 only for 64bits ?
Thread-Topic: EVL kernel config on x86 only for 64bits ?
Thread-Index: AdrCUq5QrjF0qMKbQKiFC8H04gzpIAAAl0UAAADvdoAAAHMEUA==
Date: Wed, 19 Jun 2024 15:17:40 +0000
Message-ID:
 <AM6PR05MB60245777DA0C3A6A57EEC44EADCF2@AM6PR05MB6024.eurprd05.prod.outlook.com>
References:
 <AM6PR05MB602449A0F0A755F035EF66BEADCF2@AM6PR05MB6024.eurprd05.prod.outlook.com>
 <ce3d9b5c-f9f8-412d-86dd-2d3579043359@siemens.com>
 <87bk3xrneq.fsf@xenomai.org>
In-Reply-To: <87bk3xrneq.fsf@xenomai.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fareco.fayat.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR05MB6024:EE_|AS8PR05MB8037:EE_
x-ms-office365-filtering-correlation-id: eb70ecd8-5461-4c78-6bae-08dc9072f61a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ISy5fN6tacLhYGkOyWU/dYZTdFV+A/rbpj802MJmWT4b3s2Z1bkh/Y7v5674?=
 =?us-ascii?Q?6J2cmNdvKPHNUGYfSrlpdAtFnVrHcTnxTeEczMsYtXJEn4G4XA7hw+rzqh7z?=
 =?us-ascii?Q?B9oI8SeyEUMCGt7IqAuH9oQuH800ptIiBk7KlBKUCCJlVvKACCaL3t3a/yrz?=
 =?us-ascii?Q?OlTP5T8HmLjz74tNqlLKL+asBkv12O7Q43V4eTiFeN9KCuvacPfXeBlNDVvP?=
 =?us-ascii?Q?nXryDszFsxEvkyiSR/7Ghet5rCcIgqQeRyN/r/0WmCRz2hyguwhMVwtOJVwj?=
 =?us-ascii?Q?RH6H2ZdEz+U9rfwYMIpqXLCjEOTFkRJNPW9ua4ZscKTqxcMepYjIB32IYymD?=
 =?us-ascii?Q?5zDo1N/aCzusox7rY3Qu9nOYMcF4KKm5ymPxWVkC6sniN1GDk5aDezziyt4X?=
 =?us-ascii?Q?EkDj009uyW3yR0ro+3kNeWNmD1hFRM1gO3F+PbO4wJHCMHouoaoWti5663u9?=
 =?us-ascii?Q?txMnsoL5TJXPGhPxq/o0FUfizmRODShHxl/nTDk+PbZJU+cSK/7wkT8Nw1eB?=
 =?us-ascii?Q?vmHS36UFF5eH2XtycKZ1iFBfnhqPF95tlVhw/SFChAb5YflSkxYW3XQEhObU?=
 =?us-ascii?Q?N//Am/Wb68CXJnQd1mhG7uAp+qLZRlGpjHx8XDItBNp4E5yoV7hEFirk8ekl?=
 =?us-ascii?Q?cLqmtGDigMzVI9eaaHjwtqJN0G4MlO5ctLNtcm/ybPDYqe/A8bnCzFbXMQUr?=
 =?us-ascii?Q?176nCaSO72VtBoMutC5CMlta0uYIureibWyhS+4J7RNHb45o3h/zWE9O7GQn?=
 =?us-ascii?Q?eJio0jDsJi53X9eQ/AJ+Cjgm/6rHKNB8aXBiIUfWnrF47Fr1uWpgDbFqsoQZ?=
 =?us-ascii?Q?0uJTQ97+AoDSqix/wGGbDFNB47Br41nbHQQVuPGEL7LrVdxUpGTVucyBt/SW?=
 =?us-ascii?Q?nqWoRUzePX6q/zw5B2fNa5sjIOw7LqwPGmhI/NNEhIwlvwD3gja0Mn9RwQkh?=
 =?us-ascii?Q?5xTM3ntycqCitKnOrXSuourrvtpLVD2pEr+RWoYCDlyr5KQlf83b5yzqCRWV?=
 =?us-ascii?Q?e3EELFFUufTzBpulfg5bBnuPQbGZADkcVrD6x34bswaXLkvN3/gtOrR4SZZA?=
 =?us-ascii?Q?i5xJUXcblIH2oZm4w24C3a11M6wx3wnLeLQf2MlBVHcoUBBvWXcLcFCZFw9e?=
 =?us-ascii?Q?ZlT4nOwcJQw8IWkc6iJE726Iaot9MGdx5lsQMsPvyIdkTpfApy53UmJKqUnB?=
 =?us-ascii?Q?CzDftTD0l8mKaZlBBKmMyUCEiOc3Y6e3a+tGJYLoII4jCJ1F8GNc+WgmN+k5?=
 =?us-ascii?Q?B4okKbmaEQ8Wro6bWA65kAUPGMpjGjpA3TCZpmU14rqBHLse8Yyj5/BmDs3V?=
 =?us-ascii?Q?SwOn+eJGwjbZef99JiObbj4g?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6024.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+hqtORwIPIanp/2PyvRJ1xS5ST90bHa/ya80zf2KjSNM8cQKKf0C9MawdU3F?=
 =?us-ascii?Q?s7Z2HVFLixNZXJBK5xcQElZ98L9oxqsXpMMoxrT+rCgzh8lODxkkJ0IzrZoJ?=
 =?us-ascii?Q?cGMob7O24aHdpa0LIHLodN5fs7gpLyynqtUG38TNWaSW0QQ4B9+Jm24UStL1?=
 =?us-ascii?Q?QXr9JjBm8D/H+iMSdlxQJo7DtOx7pgCJlHXrgXlhe37hUD1nV12sk263BCIs?=
 =?us-ascii?Q?DLTrVf+qrcbK3PLhIZxnUaEHe7RcSrh6GcW1E+kNbkYpbOYjdMq5S9789jB6?=
 =?us-ascii?Q?mJdVrfAo/84JajcCvQ4hS/Hi3S53ze8t1u5HbvJdeo7L1vO7FOLv+TJqUACW?=
 =?us-ascii?Q?ogd5roMnm6zkOE394Mpxd8NBua9ko45QibS4OCz9f217ikYsrYma7TMVOGme?=
 =?us-ascii?Q?Xu2QY2/iRgrEYAqoDnGkiwGV4z16bNmw0U2JL5iO/8WYyWHG3M2jtPjamzGe?=
 =?us-ascii?Q?c+ep6YPEEpEZZ6djhL2VLBCa/m5jeUx/rGP287FAc+jleYfq++G9jzenrFAi?=
 =?us-ascii?Q?K0B8Id0VT2qRVisqhVtMLnIRlkSFuNJGf2iLlxSFkcbJPqaVVF1AeSf98Kvy?=
 =?us-ascii?Q?EKDthTa89nhA0O/eh6r1tliPxN9qXyQNz0s+p720X2+rUvuZLVLkAP0e3KBM?=
 =?us-ascii?Q?p/4PCELHBo1SKNyZ2GjPqbH4tpE2myYIAb98j0FPCmMLRo7g5ELQKJsO9mZy?=
 =?us-ascii?Q?ON9ZNfecHbEx30AWZw6W9BWFUvEYhfL/4XJKZE3sv0zHEJ29Pk5KRnRZQJjc?=
 =?us-ascii?Q?Nn6qa7p09jhgLUJdrLAX5zs3KhP/IZ0KnrqGhWK4cH6GOuEnbuRlWcjYoF1B?=
 =?us-ascii?Q?0Th5M6FlVzwjbsHeYptLPbGGQKymIoociqJi8uA5w+IdvNQYrq9DBpgnij7N?=
 =?us-ascii?Q?Y8MKRxMiidScU4+DMVpHm+z6F6+28j4+/FpY9HaMmEJ6b+gX5hG7dq08UoWm?=
 =?us-ascii?Q?HK3STaLRKvgVN2UbyiVKMqEUx8988ouu9YpjC7NAoROzHsDQl2w6bJS20Sk/?=
 =?us-ascii?Q?RMfyUZL7H7kQSg1SAep7pdyFFs6FTFfIm3wmRLyssAlaH8SnRpgovO9Ysl8T?=
 =?us-ascii?Q?4uZozzU7BiMQv7rtuOHMZ2zMeSr/oQmhX1I4RaRziJ2giDwUegj7LU8JZKOz?=
 =?us-ascii?Q?TxCvjyWewrM7oVaM19L5PGVYSHFntLH/BpV/xD005ogIfUt76N6UujSMGL8Y?=
 =?us-ascii?Q?w0knKcM468b/OuxvE+hbVMVXICwjTvlw28AlCfidD8YDqC8DVPuV+ShUXThx?=
 =?us-ascii?Q?+u5vXQ5ulw9PoCZNNvILkAcmSxeEBqaeFJJpHgHG0dKCfNkRMxnmSJxb7mpA?=
 =?us-ascii?Q?uGRjlWKTOOn4UywAbPTRM8760S/7zzw7g5YY0Uly/Cjpsf0XQSsLjJ7NBfJ/?=
 =?us-ascii?Q?qNiHOO1zww+iZFRWmVZyErM1UMtYebMQTRqgoNAUTSn4Vzd/RKDT8hC28mkZ?=
 =?us-ascii?Q?8AUFPBJBLngss7ortNJ0wGnrh4CE2DRtBbsk9cvcXqQ/GqGZyg2axV93Bnwm?=
 =?us-ascii?Q?9voyicDX6pNQ486oDNKrBq74ly5HmuUG2qnTP/rOxUTEGKNn9nhxUAaJFFqc?=
 =?us-ascii?Q?lejlTVCLQTUaeol0G20rEe/fL/IrIBOMhzr4ZpRwUwzgfliUcZ7FGbD2dqQi?=
 =?us-ascii?Q?rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: fareco.fayat.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6024.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb70ecd8-5461-4c78-6bae-08dc9072f61a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 15:17:40.8985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75428ef7-843d-4df6-9a8e-20c93eb7b405
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24JeOtKjDVaTPxpyg/tDgxpIQJqr45Z0ibtpcaR1X3wkivuC6j/rpsXekjnMG5XaB0TtrY2PhsuUmyIMwK4+1H+/5e5r2IpnAHs2F/R/GVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB8037



>
>Jan Kiszka <jan.kiszka@siemens.com> writes:
>
>> On 19.06.24 16:13, LE-DOUARAIN Marc wrote:
>>> Hello,
>>>=20
>>> It took me some time in kernel config for x86 to discover that the EVL_=
CONFIG menu is hidden if < 64-bit kernel > is not checked.
>>> Is EVL for Xenomai 4 on x86 not compatible with 32 bits processors ? An=
d Xenomai 3 would be the only choice available.
>>> If it is the case, it should be precised at https://v4.xenomai.org/port=
s/ for x86.
>>>=20
>>
>> 32-bit x86 is processors are history now (no longer in production for=20
>> almost a decade IIRC). 32-bit-only x86 kernels should no longer be=20
>> used for many years already, also on 64-bit CPUs supporting 32-bit=20
>> modes still. Use the compat interface in that case (32-bit apps on=20
>> 64-bit kernels), but that is indeed Xenomai 3 only - unless I missed=20
>> something as well.
>>
>
>x4 does support x86_32 apps over x86_64 kernels in compat mode, and
>armv7 apps over armv8 kernels.
>
Thanks for your prompt replies !

In the world of industry and embedded systems 32-bit processors are still u=
sed
(example with Vortex86 CPUs in our case, handy for some historical PC compa=
tibilities)

So a small addition to the web page on this point to clarify it would there=
fore be interesting.

Best regards,
Marc.


