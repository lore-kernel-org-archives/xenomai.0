Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CD02E8DE6
	for <xenomai@lists.linux.dev>; Thu, 11 Sep 2025 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612280; cv=fail; b=LguayFR1pTKetTK+JZM82PXqB0eoGkpSU5XLWNlXHHmDFab2mUCiCnsy35P3k3Z4NjRX4/tafu/FtRyCeX04UUMll2tUJEb0MPzYHsQkI1cFTCipnfG0JPx2zrvi9cq2Woil3EdjaEbxMu/sbSIVRdw5XweW+hl4fL/KNT5qZAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612280; c=relaxed/simple;
	bh=0T6Ra6o8qhRx0aOYAIc/ehLwDYhiuFsexZyiv282gCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ea2b7od8R9xO7jKJD0otJiZbOQKrd5LF4fFeFHeIXxSz2+5ZIlCTg10zCLChLMsjO2BaDpuK1WrsnOMErckZcYFYERvt/Do93txxeLPDr72F+tFgk14DnO1IYrJ9CKqDwuI4q9lu8thEoos0pQVV0S+02TphLtG9sVoq0QFHcQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com; spf=pass smtp.mailfrom=festo.com; dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b=n4osCJxH; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=festo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b="n4osCJxH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkKIFWIUcLEywu0aYelbs11A0+3JhEUBjCFiSVvsjn4Cj4bkcaHojdE7mIlcQWBo6FBN1cxBEWj0ohKKodZuKLhCYO9Z8ws0ng+6vYrmOCJOSy7pQm7TXrYys7OIDEJV/Znh/UcS0vOiQ/SvwH8NK9kcysJOLa11kB6mCOziyt0YOh2ShFbppHQsFTEAEosLwuyg6SofebGJAbws+yAuoH8Jl9PuqlyYS5Zukn/yRxAuC19MAiLRL1ypGcZwxysfDBvlC6PR+eRfUpOnW2hzTiFxvI43AUwf2J1E0NZTIm4pIdfQ0aVYd3/5XW9QciTdPwO0kCVB16BbAZ6Dedq53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89KzUeVUAAui2Zf/NVUxs96DLjTJMpVcCdKT+/EnA/E=;
 b=mXXf5EjbmkXmxc6V+u1BZ7V7O/pwLZHz0Cje7j9wHdwdxetkN8SKZyXMj83jmkbaaXtRi9CJKyU3g4+ioOvM8a//4o2boIkBudIlTV8+uHlUbBMQ76h3fBclYcB+ON6DuoApR8UHJ2fXU+EOZ+EoGPJAGEP08HXkZW4k3MMTDxgq2J3XpTLULmHvdEQULLV7B6oQjx0ee002QfNDf10wmHAzTh7EyG/WWMe3wSR5MTp6Ujl8u+sNcvxEurt0lyCFhNQYWOLeo4MVZFIzaKgZUrMasnwdecFRt9E1b0U5b4xd+3hxMJDDUakPeN/Qe0Qa9fBL4po+BkJRMs5vO+Kz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=festo.com; dmarc=pass action=none header.from=festo.com;
 dkim=pass header.d=festo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=festo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89KzUeVUAAui2Zf/NVUxs96DLjTJMpVcCdKT+/EnA/E=;
 b=n4osCJxHmA4VlQxy9kKB8c9+dc8/GnoMI9VwN3XfFmLKu/FJZRRBAJGhBswFxzO+fjOCwobzFDK9lSC6KMlmuDQhk0Rz/03qE3OXgOtbjyqhBPwjAKsHBL3CjzM+iMCitYL5pMjjVnkYStgBfqymWh3XOdbART9Q+vmRr/7sUkY=
Received: from AS8PR03MB10056.eurprd03.prod.outlook.com (2603:10a6:20b:63d::7)
 by DU0PR03MB8910.eurprd03.prod.outlook.com (2603:10a6:10:475::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 17:37:52 +0000
Received: from AS8PR03MB10056.eurprd03.prod.outlook.com
 ([fe80::5350:1f43:188a:6db5]) by AS8PR03MB10056.eurprd03.prod.outlook.com
 ([fe80::5350:1f43:188a:6db5%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 17:37:52 +0000
From: "Xie, Nick" <nick.xie@festo.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Error during libevl build and runtime settings failed
Thread-Topic: Error during libevl build and runtime settings failed
Thread-Index:
 AdvhNCsPSr13v8uwQHKA1c0dN9vzhQhJ1t/wAAMSmAAAFusnuwfrxy3QAAfyhxgAKuLKwAABK2KQ
Date: Thu, 11 Sep 2025 17:37:51 +0000
Message-ID:
 <AS8PR03MB100561D915B59849E100C37768B09A@AS8PR03MB10056.eurprd03.prod.outlook.com>
References:
 <AM5PR03MB2882F5ED2ADBA37FAA9562608B7DA@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<AM5PR03MB2882F38E95A99A0760C60D1F8B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<AM5PR03MB2882726DD078E29EB76589518B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<878qk3za1e.fsf@xenomai.org>
	<AS8PR03MB10056F9D6FBDE93A148E03F5A8B0EA@AS8PR03MB10056.eurprd03.prod.outlook.com>
 <878qimxczv.fsf@xenomai.org>
 <AS8PR03MB100561B2E374D4680213E55DD8B09A@AS8PR03MB10056.eurprd03.prod.outlook.com>
In-Reply-To:
 <AS8PR03MB100561B2E374D4680213E55DD8B09A@AS8PR03MB10056.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_ActionId=f1d87f20-13e1-437f-ba51-5088eabec0ed;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_ContentBits=0;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Enabled=true;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Method=Standard;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Name=Internal;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_SetDate=2025-09-11T17:03:03Z;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_SiteId=a1ae89fb-21b9-40bf-9d82-a10ae85a2407;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=festo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB10056:EE_|DU0PR03MB8910:EE_
x-ms-office365-filtering-correlation-id: d995d1ba-8f2b-429e-5e73-08ddf159eef7
x-ms-reactions: disallow
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zIl3pzixhFz0QiHh2TWN9kB1mja+ZCan+mdmeHqk3bC6HVgk2f6p7zuqo2hr?=
 =?us-ascii?Q?aT15sLf86vg0veZinyeLZtZpv7T+/EGlvdoBCtrRDfMC1rLkbAZBrw7hxxqH?=
 =?us-ascii?Q?sX6ccuXGfM3WMX8+hX2YsHn+VjaHwTMxxaAzM5O+f1EYPSdtaimqpPGpX3mT?=
 =?us-ascii?Q?Q6jlboPO4Hg9BzIu5O+yKBaQZD621cPKujCEnx0O8uydARCXA6Ej8RbYjPnh?=
 =?us-ascii?Q?wIIsO2XJowKHgH8qed5+i7kcOH7P8WGkbZQ4CuNL7I6i61TPQ6CbmTnDrHc9?=
 =?us-ascii?Q?gvj7GMoTDnnJvG9fhxipCtb9oNKjCZHDb++S11E/Uu1X4xeLzgeetZ6VyYdP?=
 =?us-ascii?Q?iD1Qs6XlvtZxsK3ELSUnwaU56mMpJ3PJdB0N9nFYTHwhHFsRpihbqmrZ59nt?=
 =?us-ascii?Q?9B8+TOgGOAYkYiurbhNRPiXeU974H2tTnX/Sa/6pZybagFBS4y8wURJxY1UB?=
 =?us-ascii?Q?1WvAewm6lP8YS9KKpmKJf186aJn6b35smww4fJhkLz8H3yoV/mVBpQG185cL?=
 =?us-ascii?Q?THkPZh9l5DXUa/0eYLI8nzAMqIQLk0JuJXA0u0PMTdVoUUM33t7qtL0yiKYz?=
 =?us-ascii?Q?ril+efHsRxkLim88wOtaqr9xpdopvjZaoJ/289fogm+B5G84oUacy4/8avb9?=
 =?us-ascii?Q?NyjySZLUbThYxJdLwN/k+reJKGGjMXquzQUASrop10KaZ+1MbD6xHkLxNVez?=
 =?us-ascii?Q?jPWkrc5gBf8yamjOX57HsR3OGTGXyHbhg1+xQFp+Amt7Vyt2nM1l2c4xseKj?=
 =?us-ascii?Q?YhnrAj9jC2OMSGW2ann+IqaXvMTayH5NfH6jn0kvpKFyNbt9uKM+yawNGxbM?=
 =?us-ascii?Q?FuuNXnrzJAq0n6jqYSzzlRpFsZTP22jGc8Gd0cascHOHrGFhcAcjUREsaHvo?=
 =?us-ascii?Q?MWmq+0l/WVvJ+iZ0X6TUq9nTBeGDwf0sqPunInfXJC4wXnlK2bhU+h3VZmII?=
 =?us-ascii?Q?rP5wkJJzg4x23HGwH35rKuWXhWWZnIYCMqInZ7YG9/mIRsrY74rYFZcN42vJ?=
 =?us-ascii?Q?5WUT74uVoZVHAWB9W0QggmWOeslKdyLwwawWpqBmeTka8Som4MquUs5tvu+g?=
 =?us-ascii?Q?xIcET4atsbgsDJy3zIFSI2pvPcATxzbYrnhvG+fo6kf/LXYCwSxgNdt8k8Jj?=
 =?us-ascii?Q?zMJgIK0txpYxZpBhJrirJFuOwkGToWgsLZ6XdVT3g5uXR1BnsvegoSjyFI6T?=
 =?us-ascii?Q?rwByeAeDty63OQ/pjfyLytgUIuwt3hGzCsDTYfRMZ0SSK7AdzApgVifs//YW?=
 =?us-ascii?Q?OvLonoEEVxk3BreltMjTgPOfY0BfxH8r7EKEjVpcoetVVjMpXaU0319LAjZ8?=
 =?us-ascii?Q?lEn1N2KIvrWEBxrb1qQzZgae1JMxUyAXuYatz8rJeZZdcU1PgjS9jejS6duh?=
 =?us-ascii?Q?Vbt4YcOxD2/JAQlj/kAnLWzizwbMsqJ9F4PdEJd6hYpUipNRP0hQr94C3s1p?=
 =?us-ascii?Q?PKVYPzCKcVfXqGWggFpr/+wOyzJmpkOIGrOmHBw5OjC3lvehecyry+EGTC/I?=
 =?us-ascii?Q?otL7ccStSef5JZw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB10056.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZPxI0B2W6LtXC6++gUVieDUnfViCb8L+c4XNcen397hmbntdeGpOF+646qrl?=
 =?us-ascii?Q?vvrBPZ4j7r3utssljraVQvLJC8xhdZUUKXHiHXDf9f8PvPwmTNMVXmDN3WjE?=
 =?us-ascii?Q?Ue2j9s6qLfE7EogbAEtDCe81SbAdepCxrPiPqOydqdOoOjSxe0se2Z96snan?=
 =?us-ascii?Q?9Af+ueyiBg+12QrW9htfMlIkcNSSanu0GT5OIssDe4T3f7VU5CgA39qjEByS?=
 =?us-ascii?Q?M1lA/wB5SiivBOrjL5qyVY4wFuXA2xwmgpM5FN3WFVrSqF8Rlztl6wc7ejOF?=
 =?us-ascii?Q?X21M8JicNnQyC8gfa1LE2bbPwZ6YO/Yo4VVoDmqb64AHN8+elaczTebfgqDD?=
 =?us-ascii?Q?Va1HxShH29cvGkvC+tUHNpt4xASJLejy2y+PSbdwyN/2itujyv8qLy7hs+XB?=
 =?us-ascii?Q?Odo4SDDZzMjgxMG/CrGRkzHrYCOvudi512BzL7qhAt65iISWw+DsTPMbNlnt?=
 =?us-ascii?Q?hF6VW0bfgcz+ixlY0xVAm+rFLbhBXDe96e//Apy3T1zEH8CBIG1Mm5rT3Sc2?=
 =?us-ascii?Q?Vs9fvRKqyR+7GpTXXLEzeOJGTQQDyHEuo/KNW+OEFE/XD2Md5nr8o8LGD6ws?=
 =?us-ascii?Q?uBByI8nWnxJm4VW6EAEwjy/C4JJTmNHg8xd5tzHkhYtW8Azj9wOcjOAopGsr?=
 =?us-ascii?Q?Jp46BbmHJMroaoxY2s61jEh/Ca51RFNiIPm4Mes9fN7QJGVPJdv26LFUmaCd?=
 =?us-ascii?Q?ZgntQHf6i/pTTcFey3AdQkQCU+eLG0z69EnAmrck8cc2ycC7Xcq5UPveDqLB?=
 =?us-ascii?Q?6/3s9AEO9BSHLy0YivYrfIRCtP5hZttD0uwzzWNupgix0Ugw46DhrSKfxVuR?=
 =?us-ascii?Q?HzhSTdtq6y8wHBqqO35bFqzDiDtFiCDNoIHG16mYqqUy+wGBUWQONB8U2U6e?=
 =?us-ascii?Q?IMQRHcYF5he1siMV+K+l7qZ2QgdkYoaju5HRAxM0W/v+Utpgr/p2wi17ZLXD?=
 =?us-ascii?Q?hM+nV5nQPOZ5lHBb+kAfuT+tQR9jwJOUHXInIqhjvavi2PnBYMTruXXY/u8K?=
 =?us-ascii?Q?CEAVHqKjqMKXA91+dSNn8Lfpx12stZctRgqnckztlHliIcLoo9fbOTa5O8Ll?=
 =?us-ascii?Q?kOIaCmp3qBz1lOw4qIPHEXbX2tOZjdq3HifAKgmya8Vmc9u3+JgQ3/crubha?=
 =?us-ascii?Q?a/W+PJ5Bqi0K9lH8hOz3pbwf/tdCa/SdQleFygK1E9w1G4JqZajxH20GksIp?=
 =?us-ascii?Q?sxdHBFIdOX6WoHeP7+QxpLA+V2Qg188zgTS6dtTwz+SoQCelQqOm+qAphp6X?=
 =?us-ascii?Q?ltJ3lfBU3iwEn4pKOCmu1EpGAh3tx6+F+d924PaHczabUIDYSCP4Huv+D9nA?=
 =?us-ascii?Q?OPulcopoocTkCrC3jbTgQCB5DvlizYf5HlJgNAukbQ+nfphpgVEX3HcDkhZ0?=
 =?us-ascii?Q?tB0oEG1MgpfxbxP5iVjzoUEGGZ14jbDS9RU8BVDhkM2NiiBige0CibIpLhlb?=
 =?us-ascii?Q?JTapLQ6N+a49eoas6GCceL4kCd+Oll/tpK9TrxmSHWEwnV5EW6Zpm10gWVxO?=
 =?us-ascii?Q?g6pVEs03jwNO6ENWnxqlAaJ0tCS6WaN1wwMaK/RWKdb67ZKvrJRkGhr8qdkO?=
 =?us-ascii?Q?aJPD5rdGrRYnAHigDuY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: festo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB10056.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d995d1ba-8f2b-429e-5e73-08ddf159eef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 17:37:51.9627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a1ae89fb-21b9-40bf-9d82-a10ae85a2407
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O6d5k+GJMm96UpXy3GRagXLNkEIFqf/F9wSBTOTm/pFmZ3P5TcpfMyPWZBn/gOIe1dbuAAayhcu/8srwIpwTsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8910

Hi Philippe,

I tried again and fail on install step. It is different from before. Please=
 see below.=20

nick@nicklinux:~/linux-evl$ sudo make modules_install install
  INSTALL /lib/modules/6.12.30/modules.builtin
  INSTALL /lib/modules/6.12.30/modules.builtin.modinfo
  INSTALL /boot
run-parts: executing /etc/kernel/postinst.d/initramfs-tools 6.12.30 /boot/v=
mlinuz-6.12.30
update-initramfs: Generating /boot/initrd.img-6.12.30
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/crypto/xor.ko error=
=3DNo such file or directory
dracut-install: could not get modinfo from 'btrfs': No such file or directo=
ry
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/crypto/xor.ko error=
=3DNo such file or directory
dracut-install: dracut_install '/lib/modules/6.12.30/kernel/crypto/blake2b_=
generic.ko' '/lib/modules/6.12.30/kernel/crypto/blake2b_generic.ko' ERROR
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/lib/lz4/lz4hc_compre=
ss.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'f2fs': No such file or director=
y
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/lib/lz4/lz4hc_compre=
ss.ko error=3DNo such file or directory
dracut-install: dracut_install '/lib/modules/6.12.30/kernel/arch/x86/crypto=
/crc32-pclmul.ko' '/lib/modules/6.12.30/kernel/arch/x86/crypto/crc32-pclmul=
.ko' ERROR
dracut-install: dracut_install '/lib/modules/6.12.30/kernel/crypto/crc32_ge=
neric.ko' '/lib/modules/6.12.30/kernel/crypto/crc32_generic.ko' ERROR
dracut-install: could not get modinfo from 'isofs': No such file or directo=
ry
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/fs/nls/nls_ucs2_util=
s.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'jfs': No such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/fs/nls/nls_ucs2_util=
s.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'reiserfs': No such file or dire=
ctory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/lib/crc-itu-t.ko err=
or=3DNo such file or directory
dracut-install: could not get modinfo from 'udf': No such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/lib/crc-itu-t.ko err=
or=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/lib/libcrc32c.ko err=
or=3DNo such file or directory
dracut-install: could not get modinfo from 'xfs': No such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/lib/libcrc32c.ko err=
or=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/fs/lockd/lockd.ko er=
ror=3DNo such file or directory
dracut-install: could not get modinfo from 'nfs': No such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/fs/lockd/lockd.ko er=
ror=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/fs/nfs/nfs.ko error=
=3DNo such file or directory
dracut-install: could not get modinfo from 'nfsv2': No such file or directo=
ry
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/fs/nfs/nfs.ko error=
=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/fs/nfs_common/nfs_ac=
l.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'nfsv3': No such file or directo=
ry
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/fs/nfs_common/nfs_ac=
l.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/fs/nfs/nfs.ko error=
=3DNo such file or directory
dracut-install: could not get modinfo from 'nfsv4': No such file or directo=
ry
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/fs/nfs/nfs.ko error=
=3DNo such file or directory
dracut-install: could not get modinfo from 'psmouse': No such file or direc=
tory
dracut-install: could not get modinfo from 'nls_iso8859_1': No such file or=
 directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/hid/hid.ko e=
rror=3DNo such file or directory
dracut-install: could not get modinfo from 'usbhid': No such file or direct=
ory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/hid/hid.ko e=
rror=3DNo such file or directory
dracut-install: could not get modinfo from 'xhci_plat_hcd': No such file or=
 directory
dracut-install: could not get modinfo from 'extcon_usb_gpio': No such file =
or directory
dracut-install: could not get modinfo from 'extcon_usbc_cros_ec': No such f=
ile or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/platform/chr=
ome/cros_ec.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'cros_ec_spi': No such file or d=
irectory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/platform/chr=
ome/cros_ec.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/mfd/intel-lp=
ss.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'intel_lpss_pci': No such file o=
r directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/mfd/intel-lp=
ss.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/spi/spi-pxa2=
xx-core.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'spi_pxa2xx_platform': No such f=
ile or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/spi/spi-pxa2=
xx-core.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/dma/dw/dw_dm=
ac_core.ko error=3DNo such file or directory
dracut-install: dracut_install '/lib/modules/6.12.30/kernel/drivers/dma/dw/=
dw_dmac.ko' '/lib/modules/6.12.30/kernel/drivers/dma/dw/dw_dmac.ko' ERROR
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/platform/sur=
face/aggregator/surface_aggregator.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'surface_aggregator_registry': N=
o such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/platform/sur=
face/aggregator/surface_aggregator.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/net/802/garp.ko erro=
r=3DNo such file or directory
dracut-install: could not get modinfo from '8021q': No such file or directo=
ry
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/net/802/garp.ko erro=
r=3DNo such file or directory
dracut-install: could not get modinfo from 'ipvlan': No such file or direct=
ory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/scsi/iscsi_b=
oot_sysfs.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'be2iscsi': No such file or dire=
ctory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/scsi/iscsi_b=
oot_sysfs.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/scsi/libiscs=
i.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'bnx2i': No such file or directo=
ry
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/scsi/libiscs=
i.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/net/ethernet=
/chelsio/cxgb3/cxgb3.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'cxgb3i': No such file or direct=
ory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/net/ethernet=
/chelsio/cxgb3/cxgb3.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/net/ethernet=
/chelsio/cxgb4/cxgb4.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'cxgb4i': No such file or direct=
ory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/net/ethernet=
/chelsio/cxgb4/cxgb4.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/scsi/iscsi_b=
oot_sysfs.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'qedi': No such file or director=
y
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/scsi/iscsi_b=
oot_sysfs.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/scsi/iscsi_b=
oot_sysfs.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'qla4xxx': No such file or direc=
tory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/scsi/iscsi_b=
oot_sysfs.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'scsi_dh_alua': No such file or =
directory
dracut-install: could not get modinfo from 'scsi_dh_emc': No such file or d=
irectory
dracut-install: could not get modinfo from 'scsi_dh_rdac': No such file or =
directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/message/fusi=
on/mptscsih.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'mptfc': No such file or directo=
ry
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/message/fusi=
on/mptscsih.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/message/fusi=
on/mptscsih.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'mptsas': No such file or direct=
ory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/message/fusi=
on/mptscsih.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/message/fusi=
on/mptbase.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'mptscsih': No such file or dire=
ctory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/message/fusi=
on/mptbase.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/message/fusi=
on/mptscsih.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'mptspi': No such file or direct=
ory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/message/fusi=
on/mptscsih.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'scsi_transport_srp': No such fi=
le or directory
dracut-install: could not get modinfo from 'dax_pmem': No such file or dire=
ctory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/nvdimm/nd_bt=
t.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'nd_pmem': No such file or direc=
tory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/nvdimm/nd_bt=
t.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/firewire/fir=
ewire-core.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'firewire_ohci': No such file or=
 directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/firewire/fir=
ewire-core.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/firewire/fir=
ewire-core.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'firewire_sbp2': No such file or=
 directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x5857750cf910 path=3D/lib/modules/6.12.30/kernel/drivers/firewire/fir=
ewire-core.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'pwm_cros_ec': No such file or d=
irectory
dracut-install: could not get modinfo from 'pwm_bl': No such file or direct=
ory
dracut-install: could not get modinfo from '842_decompress': No such file o=
r directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/drivers/md/persisten=
t-data/dm-persistent-data.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'dm_cache': No such file or dire=
ctory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/drivers/md/persisten=
t-data/dm-persistent-data.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/drivers/md/dm-cache.=
ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'dm_cache_smq': No such file or =
directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/drivers/md/dm-cache.=
ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/drivers/md/dm-region=
-hash.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'dm_mirror': No such file or dir=
ectory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/drivers/md/dm-region=
-hash.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/drivers/md/persisten=
t-data/dm-persistent-data.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'dm_thin_pool': No such file or =
directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/drivers/md/persisten=
t-data/dm-persistent-data.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/drivers/md/dm-region=
-hash.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/drivers/md/raid456.k=
o error=3DNo such file or directory
dracut-install: could not get modinfo from 'dm_raid': No such file or direc=
tory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/drivers/md/raid456.k=
o error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/drivers/md/dm-bufio.=
ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'dm_snapshot': No such file or d=
irectory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/drivers/md/dm-bufio.=
ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'raid0': No such file or directo=
ry
dracut-install: could not get modinfo from 'raid1': No such file or directo=
ry
dracut-install: could not get modinfo from 'raid10': No such file or direct=
ory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/crypto/async_tx/asyn=
c_raid6_recov.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'raid456': No such file or direc=
tory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/crypto/async_tx/asyn=
c_raid6_recov.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/drivers/gpu/drm/drm_=
vram_helper.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'vboxvideo': No such file or dir=
ectory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/drivers/gpu/drm/drm_=
vram_helper.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/drivers/video/vgasta=
te.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'vga16fb': No such file or direc=
tory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/drivers/video/vgasta=
te.ko error=3DNo such file or directory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/drivers/virtio/virti=
o_dma_buf.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'virtio_gpu': No such file or di=
rectory
libkmod: ERROR ../libkmod/libkmod-module.c:191 kmod_module_parse_depline: c=
tx=3D0x60a7cff82910 path=3D/lib/modules/6.12.30/kernel/drivers/virtio/virti=
o_dma_buf.ko error=3DNo such file or directory
dracut-install: could not get modinfo from 'psmouse': No such file or direc=
tory
run-parts: executing /etc/kernel/postinst.d/unattended-upgrades 6.12.30 /bo=
ot/vmlinuz-6.12.30
run-parts: executing /etc/kernel/postinst.d/update-notifier 6.12.30 /boot/v=
mlinuz-6.12.30
run-parts: executing /etc/kernel/postinst.d/xx-update-initrd-links 6.12.30 =
/boot/vmlinuz-6.12.30
run-parts: executing /etc/kernel/postinst.d/zz-shim 6.12.30 /boot/vmlinuz-6=
.12.30
run-parts: executing /etc/kernel/postinst.d/zz-update-grub 6.12.30 /boot/vm=
linuz-6.12.30
Sourcing file `/etc/default/grub'
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-6.12.30-g0014b990ba7f
Found initrd image: /boot/initrd.img-6.12.30-g0014b990ba7f
Found linux image: /boot/vmlinuz-6.12.30-g06a9a69b631e
Found initrd image: /boot/initrd.img-6.12.30-g06a9a69b631e
Found linux image: /boot/vmlinuz-6.12.30-g06a9a69b631e.old
Found initrd image: /boot/initrd.img-6.12.30-g06a9a69b631e
Found linux image: /boot/vmlinuz-6.12.30
Found initrd image: /boot/initrd.img-6.12.30
Found linux image: /boot/vmlinuz-6.12.30.old
Found initrd image: /boot/initrd.img-6.12.30
Found linux image: /boot/vmlinuz-6.8.0-79-generic
Found initrd image: /boot/initrd.img-6.8.0-79-generic
Found linux image: /boot/vmlinuz-6.8.0-60-generic
Found initrd image: /boot/initrd.img-6.8.0-60-generic
Found linux image: /boot/vmlinuz-6.6.0-rt15
Found initrd image: /boot/initrd.img-6.6.0-rt15
Found linux image: /boot/vmlinuz-6.6.0-060600-generic
Found initrd image: /boot/initrd.img-6.6.0-060600-generic
Found memtest86+ 64bit EFI image: /boot/memtest86+x64.efi
Warning: os-prober will not be executed to detect other bootable partitions=
.
Systems on them will not be added to the GRUB boot configuration.
Check GRUB_DISABLE_OS_PROBER documentation entry.
Adding boot menu entry for UEFI Firmware Settings ...
done

-----Original Message-----
From: Xie, Nick=20
Sent: Thursday, September 11, 2025 1:15 PM
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Subject: RE: Error during libevl build and runtime settings failed

Hi Philippe,

Thank you for your response. I tried to enable the console output in grub s=
etup, but nothing is showed and it stuck at the same place.=20

You mentioned booting over a ramdisk inherited from some distro-specific bo=
ot setup builder is discouraged. It reminded me that the first time I run "=
 sudo make modules_install install ". It failed and reported as below. I ha=
ve to enable "support initial ramdisk/ramfs compressed using gzip and zstd =
option under general setup" to get the install done. This is very different=
 from my previous build. I have never need to do this. I would redo everyth=
ing from the beginning and see any different. Is 6.12 the correct version I=
 can use with new libevl? Do you have other through? Please advise. =20

nick@nicklinux:~/linux-evl$ sudo make modules_install install [sudo] passwo=
rd for nick:=20
  INSTALL /lib/modules/6.12.30-g06a9a69b631e/modules.builtin
  INSTALL /lib/modules/6.12.30-g06a9a69b631e/modules.builtin.modinfo
  INSTALL /boot
run-parts: executing /etc/kernel/postinst.d/initramfs-tools 6.12.30-g06a9a6=
9b631e /boot/vmlinuz-6.12.30-g06a9a69b631e
update-initramfs: Generating /boot/initrd.img-6.12.30-g06a9a69b631e
W: zstd compression (CONFIG_RD_ZSTD) not supported by kernel, using gzip
E: gzip compression (CONFIG_RD_GZIP) not supported by kernel
update-initramfs: failed for /boot/initrd.img-6.12.30-g06a9a69b631e with 1.
run-parts: /etc/kernel/postinst.d/initramfs-tools exited with return code 1
make[2]: *** [arch/x86/Makefile:321: install] Error 1
make[1]: *** [/home/nick/linux-evl/Makefile:347: __build_one_by_one] Error =
2
make: *** [Makefile:224: __sub-make] Error 2 nick@nicklinux:~/linux-evl$ ma=
ke menuconfig


Your configuration changes were NOT saved.

nick@nicklinux:~/linux-evl$ make menuconfig


*** End of the configuration.
*** Execute 'make' to start the build or try 'make help'.

nick@nicklinux:~/linux-evl$ make menuconfig


*** End of the configuration.
*** Execute 'make' to start the build or try 'make help'.

nick@nicklinux:~/linux-evl$ sudo make modules_install install
  INSTALL /lib/modules/6.12.30-g06a9a69b631e/modules.builtin
  INSTALL /lib/modules/6.12.30-g06a9a69b631e/modules.builtin.modinfo
  INSTALL /boot
run-parts: executing /etc/kernel/postinst.d/initramfs-tools 6.12.30-g06a9a6=
9b631e /boot/vmlinuz-6.12.30-g06a9a69b631e
update-initramfs: Generating /boot/initrd.img-6.12.30-g06a9a69b631e
W: zstd compression (CONFIG_RD_ZSTD) not supported by kernel, using gzip
E: gzip compression (CONFIG_RD_GZIP) not supported by kernel
update-initramfs: failed for /boot/initrd.img-6.12.30-g06a9a69b631e with 1.
run-parts: /etc/kernel/postinst.d/initramfs-tools exited with return code 1
make[2]: *** [arch/x86/Makefile:321: install] Error 1
make[1]: *** [/home/nick/linux-evl/Makefile:347: __build_one_by_one] Error =
2
make: *** [Makefile:224: __sub-make] Error 2 nick@nicklinux:~/linux-evl$ ma=
ke menuconfig

*** End of the configuration.
*** Execute 'make' to start the build or try 'make help'.

I enabled CONFIG_RD_ZSTD and CONFIG_RD_GZIP to continue.

nick@nicklinux:~/linux-evl$ sudo make modules_install install
  INSTALL /lib/modules/6.12.30-g06a9a69b631e/modules.builtin
  INSTALL /lib/modules/6.12.30-g06a9a69b631e/modules.builtin.modinfo
  INSTALL /boot
run-parts: executing /etc/kernel/postinst.d/initramfs-tools 6.12.30-g06a9a6=
9b631e /boot/vmlinuz-6.12.30-g06a9a69b631e
update-initramfs: Generating /boot/initrd.img-6.12.30-g06a9a69b631e
depmod: WARNING: could not open modules.order at /lib/modules/6.12.30-g06a9=
a69b631e: No such file or directory
depmod: WARNING: could not open modules.order at /var/tmp/mkinitramfs_TKnlg=
v/lib/modules/6.12.30-g06a9a69b631e: No such file or directory
run-parts: executing /etc/kernel/postinst.d/unattended-upgrades 6.12.30-g06=
a9a69b631e /boot/vmlinuz-6.12.30-g06a9a69b631e
run-parts: executing /etc/kernel/postinst.d/update-notifier 6.12.30-g06a9a6=
9b631e /boot/vmlinuz-6.12.30-g06a9a69b631e
run-parts: executing /etc/kernel/postinst.d/xx-update-initrd-links 6.12.30-=
g06a9a69b631e /boot/vmlinuz-6.12.30-g06a9a69b631e
I: /boot/initrd.img is now a symlink to initrd.img-6.12.30-g06a9a69b631e
run-parts: executing /etc/kernel/postinst.d/zz-shim 6.12.30-g06a9a69b631e /=
boot/vmlinuz-6.12.30-g06a9a69b631e
run-parts: executing /etc/kernel/postinst.d/zz-update-grub 6.12.30-g06a9a69=
b631e /boot/vmlinuz-6.12.30-g06a9a69b631e
Sourcing file `/etc/default/grub'
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-6.12.30-g0014b990ba7f
Found initrd image: /boot/initrd.img-6.12.30-g0014b990ba7f
Found linux image: /boot/vmlinuz-6.12.30-g06a9a69b631e
Found initrd image: /boot/initrd.img-6.12.30-g06a9a69b631e
Found linux image: /boot/vmlinuz-6.12.30-g06a9a69b631e.old
Found initrd image: /boot/initrd.img-6.12.30-g06a9a69b631e
Found linux image: /boot/vmlinuz-6.12.30 Found initrd image: /boot/initrd.i=
mg-6.12.30 Found linux image: /boot/vmlinuz-6.12.30.old Found initrd image:=
 /boot/initrd.img-6.12.30 Found linux image: /boot/vmlinuz-6.8.0-79-generic=
 Found initrd image: /boot/initrd.img-6.8.0-79-generic Found linux image: /=
boot/vmlinuz-6.8.0-60-generic Found initrd image: /boot/initrd.img-6.8.0-60=
-generic Found linux image: /boot/vmlinuz-6.6.0-rt15 Found initrd image: /b=
oot/initrd.img-6.6.0-rt15 Found linux image: /boot/vmlinuz-6.6.0-060600-gen=
eric
Found initrd image: /boot/initrd.img-6.6.0-060600-generic
Found linux image: /boot/vmlinuz-6.2.0-37-generic Found initrd image: /boot=
/initrd.img-6.2.0-37-generic Found memtest86+ 64bit EFI image: /boot/memtes=
t86+x64.efi
Warning: os-prober will not be executed to detect other bootable partitions=
.
Systems on them will not be added to the GRUB boot configuration.
Check GRUB_DISABLE_OS_PROBER documentation entry.
Adding boot menu entry for UEFI Firmware Settings ...
Done

Best Regards,
Nick Xie=20


-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>
Sent: Wednesday, September 10, 2025 4:35 PM
To: Xie, Nick <nick.xie@festo.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Error during libevl build and runtime settings failed

CAUTION: This e-mail is from an external sender. Do not click links, open a=
ttachments or provide your password, unless you know the content is safe! I=
f unsure, report the e-mail using the Outlook button.


"Xie, Nick" <nick.xie@festo.com> writes:

> Hi Philippe,
>
> Thank you for your information. We tried 0.54 and 0.55 and got error. It =
complained " EVL kernel uapi is too old " and then we rebuild the 6.12 kern=
el with the newest update. The whole processing seems fine and please see b=
elow. But we have a new problem now.
>
> The startup stuck at
> "Loading Linux 6.12.30- g06a9a69b631e,Loading initial ramdisk "
>
> Please advise. Thank you in advance.
>

Since this is a runtime/boot error, please get a full kernel console output=
, so that we can figure out where the boot actually stops. There is no way =
to help only with the information above. Using a serial console is preferre=
d over a vt.

PS: booting over a ramdisk inherited from some distro-specific boot setup b=
uilder is discouraged if a problem arises in the early steps. This only obf=
uscates the issue. In order to understand obscure boot issues, you may want=
 to strip your kernel configuration in order to statically enable in the ke=
rnel (i.e. not as modules) only the device drivers which the hardware requi=
res for a minimal boot. Once the boot issue is understood and solved, you c=
an switch back to whatever boot setup you see fit.

--
Philippe.
