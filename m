Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2115.outbound.protection.outlook.com [40.107.241.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0963EECF
	for <xenomai@lists.linux.dev>; Sat,  9 Nov 2024 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731172995; cv=fail; b=mgudoRmcWkciTwG2Y8mJgVUVHgZ7cQn3FiXfjij81/d98KdInkTcUWrzc2Z9OpZUO9eOtqkOCvDyZGOfs2Lewsy+A6UxvDeRT5VPVj+nrPkBxktGsflCXXIeLSNu7uXMjoT9c/wPdlg7jtinRJWJN/SI9BXIiwH7VUkoi1pcV04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731172995; c=relaxed/simple;
	bh=yFxQvq65fTZeYn8xgQY41VfHSeB0vRuuTIiAyy9xfcs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DvJ6pGwA4M+9H5ytU3k4F6tl2kH7DDKD+zv8lk2l54D469oY5OJ/C/CCcO9dhzlBrfUP41iv57AMvzMG3hznXPXn0WChC6qeNvwyagtshxhJLSYmRr1m0/Y6+PQbZug7+Bpcuqba9RT71KeVPSQvRa7bgf1I5EhGol2/8egtAFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ecler.com; spf=pass smtp.mailfrom=ecler.com; dkim=pass (2048-bit key) header.d=ecler.com header.i=@ecler.com header.b=CMI6U948; arc=fail smtp.client-ip=40.107.241.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ecler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ecler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ecler.com header.i=@ecler.com header.b="CMI6U948"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQpnovN4unAMgSW1gVH9UgiUNhC1rokw7cQWiy4E10lgnUEeQLC0ZDQYSp6L+KKdrfYfhJIBx8XTj1CSS/50M86ji55aPlo8tXu0NPGeR6ZbVhPBlp9VPU0vZKlTaZNBGQ6vanRytgtbalbibG/B1Tghjer5bNWSuzOTVvEXiytodSGkwJjvKWkXU0QEZljspnBI2/OOjFQaqN5l0MfpmxRR5+GhqjVJI+LxHNYhO1g9zM3LR42BFDVokygM7RKSTMGDmiyX+bgOzguawSOdK48H8EUHf37T7RT9lh4gRNjJyDrzFXRnjmM2bi5DHWhRdZ0H3vcSDZRo786QMxUgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFxQvq65fTZeYn8xgQY41VfHSeB0vRuuTIiAyy9xfcs=;
 b=cYxvDQduGKZjuyUCNtyl/4vJ4+Qi6fBaPVfoH/T+LxaiP06aGplutExcnrG2U2OMNXkrfn3JDYf5xf0xU6sotpg305MkxkuvjDXsSLK1rZqLD032vt82S5zyZ0CNPUpAS75a3VLDhSgMEysXqpDW/ZgBHG8oUPvTSqZq5U2lHty2FeHmED53fkE8wftNwNTCmbQ+X2DnX9WWSecaABQpSNwjIxTYhOx0GizAmA9dabSNoKNqIKuY3IUd5272dnCdibAhb1yIgkQkwgGfkwvPnmP5nEQjCsbyFLbY1eKGfUGINYbnNCjZ2H+vBHW3Mdh/z4WLIn8BqFlwMvMfgU4jww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ecler.com; dmarc=pass action=none header.from=ecler.com;
 dkim=pass header.d=ecler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ecler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFxQvq65fTZeYn8xgQY41VfHSeB0vRuuTIiAyy9xfcs=;
 b=CMI6U948HsOUOF83+2r95FkQdbBizzEu5xv2yF289/jjlCQC66b/17V3avZSKZfyM5KOz6yR/YKeql7CU5T2E6R0HF99e3mZH9Ucke0WsjnrArtizdBfhdRVCFnZkKorKccFlRPW7F/2+0JJ1BqeJcIJ+yb6tx92qVNOoKRX0WZgF+l/c4iQXIWCJmyko6Up00LXE8/7hTUGMWCgqF4qc2BQKsK9mKieqy8iu6jrmJSFlOh7qqkWs6y7Kl6wad5JRgQNs3AbjfCDq9gkHs12H/BSN7NkS4QmrjomSspxAyrGPj2zS3Dsry9sFoa+gg8Saii1v9x9CnZAp0El187dtg==
Received: from DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::17)
 by AS1PR10MB5508.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:473::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.11; Sat, 9 Nov
 2024 17:23:06 +0000
Received: from DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::98a7:517:7df7:93f7]) by DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::98a7:517:7df7:93f7%6]) with mapi id 15.20.8158.011; Sat, 9 Nov 2024
 17:22:59 +0000
From: Jesus Villena <j.villena@ecler.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: EVL SPI support for Rockchip
Thread-Topic: EVL SPI support for Rockchip
Thread-Index: AdsyzAW2Vwu2tCcET/CBFdt2yNnvQw==
Date: Sat, 9 Nov 2024 17:22:59 +0000
Message-ID:
 <DB8PR10MB3706C336E9D93F9FC5C1BCFEF95E2@DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ecler.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR10MB3706:EE_|AS1PR10MB5508:EE_
x-ms-office365-filtering-correlation-id: 35d4ebcd-637f-439a-870f-08dd00e32887
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?DxSGsV3ixBuAIr2fY7HKb+ChFTEdk0XwNCDtXDWHOQ8pK20TZ6PJv8Jnvo?=
 =?iso-8859-1?Q?Amb0bJwggOgDb0QUu++8aj2eP+MoxFSjrg1McMaCVcZrZtSnWiRP1cRsod?=
 =?iso-8859-1?Q?vLzB8TbDiXu6XhiIEt1dF8Na04oE7IHfstzJqZZtVjWAJbCmM3SnlXOcP+?=
 =?iso-8859-1?Q?ZnDPGgRgFpPaJJez9Nc6I1QltyqBDOcd/hx77Z6gImyc6mms8gzTqZKPQL?=
 =?iso-8859-1?Q?QkdtPwBSzBDaJCVJ5XuWiugQ5Q8Npdo0KLHGoPsgwGzftLgxb8mFrF/tHI?=
 =?iso-8859-1?Q?wJxRL64jehlPTiPOQ3+95Racn72aOT0ATjDOkMzUoybgjlAY2Lj7RaAt3d?=
 =?iso-8859-1?Q?nrSl2wgfgHffG1fLsfOQVkF3qidEnDHHJIsfyu10JpGOX9/94m8k46dk53?=
 =?iso-8859-1?Q?MgkbjqhJndAI+YbG2o5bFL2TCXuz48tOSO327miDvjYjQSUyu0OiCMG6cF?=
 =?iso-8859-1?Q?/l9lHvOYcdnASA0gQdvJqFa07F7iudbqIwLYyk9AM3bMHX6dnB4upBqDk6?=
 =?iso-8859-1?Q?58rW8bsyQnKideJPDntmdS9zto5+SXUuLJcVO+HduVEvPnw17Bv5Gg04SG?=
 =?iso-8859-1?Q?OJPTGyRmfoZQrJ+OtX+qVsaaToK0VzRhKswQKK8qfjVBG2AMIIAGymYY/0?=
 =?iso-8859-1?Q?uNjtQKACT1/B4p3Gu7gSbRhG9iM1l0lbEFBPLb8gYpsxHJNTRwAiKpxfsD?=
 =?iso-8859-1?Q?XgbXncFaXxHxBbF+IZ+2RA7O3NrYQaYXGJRbjlZxsJKn9M/FEqrCHDBgkd?=
 =?iso-8859-1?Q?QXoalL+gPcsVpkPPAJ/P5GdTAmTXoLwObE/ctvVjIXtKIuIuRGUAoRlmNV?=
 =?iso-8859-1?Q?ktaB7t+Mz2T5k6vUJFY9LZ7brQEyG1re1sgGZbqpw3R/JHjwUaNGGeVDAj?=
 =?iso-8859-1?Q?h64vUDYV6AJ3vFbPhZ5948v0h9YG2LSPahXxhc+QtSCiSrJAbUjvsozB7g?=
 =?iso-8859-1?Q?xURF+EEHWiPA0Mi95yofHapIMsW3Mc5KFBuZQ7arI2gjlnzxl69eDSXKb7?=
 =?iso-8859-1?Q?9qvyTxzrEefbEo+cyfyEhJ2l8y9opLobS3DitSbTNo1LE/1xJGS0LIHYQf?=
 =?iso-8859-1?Q?2p83sy04OEcbZlEsPmwHJ+ukqIUidQ/iCeLNThSIOEVVxCgfOABxWtvVfD?=
 =?iso-8859-1?Q?WvMI4MV/D8MEtDOAsyj4MfEwBcBCkUgGsa0fhZ3z1BTFxTJLLOljqUUByG?=
 =?iso-8859-1?Q?+S38r0IX0+ELJwjLTdxhKr3GM3/jniXY22d7S9qD/cuTKmbEasOXYrnylu?=
 =?iso-8859-1?Q?kWW+mNV3pRRO5GbmhJqFp8Jipdzxus4joU7N+rbDyKg/khUXF8y5SGt46d?=
 =?iso-8859-1?Q?rvKGQmJ4f/gEAZdY4K4ii1gBzao06gVCyV51l34T6Lt/+Zk6oq/rRFFvWt?=
 =?iso-8859-1?Q?bGU0aeaegLIbjDzrE/AEiHcXtY8ur1ePkMxPliJGF9sb6KAT3NeuI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/SFTufKIU9KZnujZAzbKfH9JjnoBezKLFeHJwi3KY5QAThUB4vEA/d82b1?=
 =?iso-8859-1?Q?DafEP1jbXmOSLr5TnoXwgOsdOn57xTZpjAEzVrofTW1MAM3lkGpnijavDj?=
 =?iso-8859-1?Q?lCr0vb6yWqKOGND7IjmzAtC+cly6skrd+fclLcDmWvCRqJr7M8Yq67zZP2?=
 =?iso-8859-1?Q?gsy1CH7TEwjnIJ0bhIu1dLRpTwRZGfh63Z3J94nYSPt9snllJzDyIWdSIW?=
 =?iso-8859-1?Q?jS/5LPPRGZefznMZdgIsORIkKBO2IWCdPD95gY70/0t7dTztoq1I1fjZtL?=
 =?iso-8859-1?Q?8Npw8l2UAK4yPFLXtBH0jEjrZLni5YE/Iw4iqyuOxAwCFT/X6pEHGie2v5?=
 =?iso-8859-1?Q?KQ/Iia3qzL7tj8UB57bN08HjYNuR3SNY1G00ocnjxQS1zjkcevFh5cqFnS?=
 =?iso-8859-1?Q?FtWDOkLxgM2XCFovKNfGU6s93YFOAZSUwHK0Z3APJmNHt3baqGHavJgSe7?=
 =?iso-8859-1?Q?KLs1MTWC0wmX+hxCpkbhvrPnAo1HHyrTvVeH/ttqOijdyCgI2CneBzOA0v?=
 =?iso-8859-1?Q?kVYv5s/Nw65WTplaBhSI/WyahQCr5vAxdVAOG42V9oX7n3OjE6zz5YuJKP?=
 =?iso-8859-1?Q?soKOCcAdrPI8qUuKR882FO2aCb6XmXdA4Sn04axrBTQHTJwM3+lNF7Juh8?=
 =?iso-8859-1?Q?18x391EaU5SXvWAddOOBOJOveJEA+qykEcUJ3qX2/Tqhyh0c8RxhtudWoC?=
 =?iso-8859-1?Q?5RRG2YqY4AY2ast8HaWndFCaRY0v6q+7PLrxFReIH/bN4R2S8kA6s8rI8V?=
 =?iso-8859-1?Q?uPYKdzjAXrrhRhPAJb1NDoxbiFLRngr+COe9t288SKsHHX0KhkAWIFBbPv?=
 =?iso-8859-1?Q?FdzzFiF5AekX1pu5AiaE6DOrGp4cCHx6THjYrtoSQI3KQl+spNNfmuD2ab?=
 =?iso-8859-1?Q?3NrHZbc0HN+35Sqek2MfqGh7HKtTW8v+aLNwdszgh85iokdwEaDlZhYwrn?=
 =?iso-8859-1?Q?7X49ka02MaybMbNnomaMGKIbiTL58Da5KOHwUxXySWWnzwfo4M5/DkODFZ?=
 =?iso-8859-1?Q?y7NwbjcpI+UCmN7I5WLfZ1/Z9W9alJlb02OCa8LdwBZCgnoBrgfoLtYxP8?=
 =?iso-8859-1?Q?RKfpZ/EREBRXChBtJRSUDTNpFhMHej0gPX9qbqZ/5TTJMiJ18NfiTUFq89?=
 =?iso-8859-1?Q?mvAXhCN0CbkVSm6h5R82EIohAOAhiInqslwQtpwgFe322JkhS4lLN9u4/v?=
 =?iso-8859-1?Q?5Koarg1y7HET+weHay0WQBs85+gM4MG5MAhQ9oc/GM+0nylsz8xur3eZ+t?=
 =?iso-8859-1?Q?guBaIG6qy7cG3I2WBuKylrRF9MDhyzawHBTUlAL9pPkATe/hpn/jvJUFVW?=
 =?iso-8859-1?Q?g7PS+8WBdqBUQpmaerlTXkQEkvHTCgBq0l3gKj9wZaVeNunq0TJtpZtBqv?=
 =?iso-8859-1?Q?d9woj00oIrdj7oMHxWo/24HgBXp2T6nRcTg7tKo1X69/WqS0gPXoZ5x9oP?=
 =?iso-8859-1?Q?mxDAZLieCqudOi30I4/FwZ9B5DPbJtnScs+R2RAJQ45Jdth8Fy5pLyDddR?=
 =?iso-8859-1?Q?UMqmnO9mHKuwFyw52oV0Ii2s5VR6f9y2D3yM+MGZ3uLF7Pl75JCIdNrSPT?=
 =?iso-8859-1?Q?nf0kNZyhbTHahv7piAakz4F8laPWIicGu7w/f6yrWxUprYsSw80sZxdr6b?=
 =?iso-8859-1?Q?ZJ1RBzB0YJHec=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d4ebcd-637f-439a-870f-08dd00e32887
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2024 17:22:59.3969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6f9193a3-7ddb-4a6c-9664-df2759e0e5ac
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dYD/I8maAMyJ+Rv05GC6Zom6Q5LdgUS4KcP5jwcAj9x8D/BD9ivrb2Ee+Ye9hRAc357sg14gdPFMsSN2MFQaXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5508

Hi,

I would like to know if someone has added oob EVL support =A0to the Rockchi=
p SPI driver (spi-rockchip.c), which is used for all Rockchip SoCs. If not,=
 any help?

I am working with a RK3566 board, and I need to use the SPI peripheral as a=
 high speed and low jitter communication link (multi-channel audio) with an=
 external MCU. Previously, I have used this method with a Rapsberry Pi 4 an=
d it works like a charm, because SPI and DMA are already supported in EVL.

The most efficient way to use SPI would be to use DMA (as the oob BCM2835 d=
river does), so it would be needed to change the DMA driver too (pl330.c)

I have seen that other drivers have added oob EVL support additionally, as =
imx-dma.c, and looking to the changes from the mainline version, it seems t=
hat it shouldn't be so hard, but I haven't the necessary skills to do it wi=
thout help.

Greetings

