Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031BB371E80
	for <xenomai@lists.linux.dev>; Thu, 11 Sep 2025 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610898; cv=fail; b=LFys4fZoXFFRrFPyTQ+E0uGFnxE369x+o8ifXTbiO6VenRCxcFcp/atPeCuro/SmpM26z/pjo/JqQI4qGTF+YePXT1HFJUFk3Pa68aJGrLLikV5IZKboxriRKCWq16jDCdR/NjZf+49Nhod5SxydbTLdtMGzMjj5yC5gtPUEZ50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610898; c=relaxed/simple;
	bh=/0DL1fl0YIoWFyl6H7Ca0udpb/esXDxTQy8Gn4EfDuk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WH7I2TA/X6s7X5A/QRLogo2PPgJ2oBMyi7irg8zON0j3s2dCZYnmg1xy1lHUmZ9hDUgFMpO1EYZ46mRQBmE/bVIq6oxmfYeQg7z5ihx+DkcVQdhqAu3lhRnRQTxwqW44jd/GiM59se9WYIG2RqYEZ5g+Kug+WzGLuR8+4nUQA/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com; spf=pass smtp.mailfrom=festo.com; dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b=haiU15xi; arc=fail smtp.client-ip=40.107.159.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=festo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b="haiU15xi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bq1+D2/4ANHQArr1LcE3n8crEUfaZKm987DnCZm+agycHq9tqk8mUwEIRg/cuVCJD4W91UFJeSNcpv3FIxmHvslWpzQw1BVb82v2GbCW18CpxvNaG7eEplQKsoJp+CkYAnKjUpBkYxFlB1X0FtnlAOUO40GzYVl645PZaGlr/JadFu8/dNdQVlfnTMYTxttydj55RK/bFh5osEzJ5vV+eOegK93UhFYxGQ+t3oogJPMP4KjiAN3CjtreuOv50cBZSTWemMptCmF0TuU+kBePE4ijQdoVbYAQRJstEBAdtqVILyCPpl7pb/n97qMS/709P+U3muBLEtGEQYI14N/ozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKIWrcpHkhzq2pHhb/JX0p9QUz+zjdInx+7MiMV/40c=;
 b=d2Ds77WAo6SIk2n34xv396tFCcq18ygIq7GUC7sNxMryYLRxWeD6qbr9yM9rftLzJgsTG9smEPOUuslzsPpxXZxAYSuD4ER7UzduilwfX3M7sdapT0iEvcyq8EMoErlxg8z/DeiKFDJx/6OzvzxlECwgwuxe80GUrjgnRbt3RH+A29XKCS8/WyDFoo+4+N7Hy7LKzY0U78/NL8GS78U1lUvll0iOfgIrfssUhE19RTSpME7uRZjDAB08VPUTthT1NzUuy2Ovok7RGaGSFPKgSsfqFU3ZRKFV/Ro8JGbczgFvoxx+zzYGgDQKYXBmv+41yCJMPXXyeehAz2U+g0bM7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=festo.com; dmarc=pass action=none header.from=festo.com;
 dkim=pass header.d=festo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=festo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKIWrcpHkhzq2pHhb/JX0p9QUz+zjdInx+7MiMV/40c=;
 b=haiU15xi1pK/gRcFko7zM7ppOa9y7uIJzN3+zi1mlgvGEJtlduYRj7EBWlMIU/Lu27bp/zT30vaTJXRdfq8C91rq9hwlgV36ynE7uQgwKkY0AVpc8hAMiGdlyRi/5QDQ2WbRKvAIJEigF+gJ/yttpjrrl7igrPxx/IuJnbSxt9w=
Received: from AS8PR03MB10056.eurprd03.prod.outlook.com (2603:10a6:20b:63d::7)
 by GVXPR03MB11034.eurprd03.prod.outlook.com (2603:10a6:150:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 17:14:51 +0000
Received: from AS8PR03MB10056.eurprd03.prod.outlook.com
 ([fe80::5350:1f43:188a:6db5]) by AS8PR03MB10056.eurprd03.prod.outlook.com
 ([fe80::5350:1f43:188a:6db5%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 17:14:51 +0000
From: "Xie, Nick" <nick.xie@festo.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Error during libevl build and runtime settings failed
Thread-Topic: Error during libevl build and runtime settings failed
Thread-Index:
 AdvhNCsPSr13v8uwQHKA1c0dN9vzhQhJ1t/wAAMSmAAAFusnuwfrxy3QAAfyhxgAKuLKwA==
Date: Thu, 11 Sep 2025 17:14:51 +0000
Message-ID:
 <AS8PR03MB100561B2E374D4680213E55DD8B09A@AS8PR03MB10056.eurprd03.prod.outlook.com>
References:
 <AM5PR03MB2882F5ED2ADBA37FAA9562608B7DA@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<AM5PR03MB2882F38E95A99A0760C60D1F8B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<AM5PR03MB2882726DD078E29EB76589518B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<878qk3za1e.fsf@xenomai.org>
	<AS8PR03MB10056F9D6FBDE93A148E03F5A8B0EA@AS8PR03MB10056.eurprd03.prod.outlook.com>
 <878qimxczv.fsf@xenomai.org>
In-Reply-To: <878qimxczv.fsf@xenomai.org>
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
x-ms-traffictypediagnostic: AS8PR03MB10056:EE_|GVXPR03MB11034:EE_
x-ms-office365-filtering-correlation-id: 26a892a1-8a76-42c3-6467-08ddf156b7e4
x-ms-reactions: disallow
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ICvXEZwezg+G0MCxoLR67hFGigV0AbHGXcGnFGQktQqgIM7w42qvtxUr5cfW?=
 =?us-ascii?Q?MtPRJhxOV7lMBOho5TwaaBdWEYmNfw/Aw+zUYMallpoHeo1GVABpo9zRozkF?=
 =?us-ascii?Q?bZFJ/wyCnqL/Wh7jsiokY9xvRHac+xvXtfiss2T6n2YhfTNKEBx+/3FxEhLo?=
 =?us-ascii?Q?VTZ9axEMdSTCd9rz1kUDJNsHNFyhD/cbIk6X+8/jfHdQKYzQ9Sw2p4ZBG8Fi?=
 =?us-ascii?Q?nfN4Ey8Qhay4i/nT/8wSXqvCi+5iII8OnQveYVVmT0TeHOrEnKYpOWPpZ8xH?=
 =?us-ascii?Q?Hpy/Yhxexx7ivcdlsDcGz94rkQK5jGL8JsrdXA4eGQKUDTK/7Sef/h+hoBDU?=
 =?us-ascii?Q?bjwcQOdJ98CM9jqgGVO5hopqwRxBVFbEWf6ZpxZ2HBk85JGZvZRmBSN2y5yY?=
 =?us-ascii?Q?AjmY4MmYOgVy0K6Iv2HKZUrSLqExju8TgTUEQpgx/blLJp7AtKhAMKaAI9P6?=
 =?us-ascii?Q?q6VwJOgBhShD1jt8l34kAYYRsOqbB2C8AUzFfxhwK9DHCmS+4pLyRdTIkNu3?=
 =?us-ascii?Q?7eBdT0F2rS1ELlnyOlfNYME+QVUIn78GP8JAxODPqMqeXnOoSUNBO+GccWGV?=
 =?us-ascii?Q?aGdRfX7sKkkZNTU0XQTALtYbFKUVPmyOlB9vqMOqjiEb1Tu4eSwEAr/K205m?=
 =?us-ascii?Q?pkcL04A/IeoP697Gy3Q88oxp9G3SchbLzcCDG7JReXrPUNQIt9Nz0xrLVRyu?=
 =?us-ascii?Q?FvXHE5M2ZAGkpelQHyszyICVUx8zNUtFma+SPNTRBTkPXLncZtFj0EyEUEkk?=
 =?us-ascii?Q?zbfkQiObboFlrg2RKZKdV/ugxCVpU727i51EHQxTu5/bNxBd8uwCI9MR9zJi?=
 =?us-ascii?Q?ne2g4ZJwhGEhtsSouRODjTeQxib4wKwENnweHj1neHGERIdg7aYVAAFy7ANL?=
 =?us-ascii?Q?tPnLPbgyRZ2z4h6s3AsUT8+9v8w8Uue2mLIi5t719PM19eaB+DBarNFIdxKT?=
 =?us-ascii?Q?tNJfYqlmG21cEUJBg0JnaRelwNhk+GyhJlbicHKMglV/ZRRx5yDAkxp+6CNL?=
 =?us-ascii?Q?m5V1xtVfGvQUCgOWr3VM52UB6aPAobCn1S4zAxtm58JS+gP9602vT2BjQPf9?=
 =?us-ascii?Q?ZzLOAMo3UWAmd3hjkYO7eyuk00FzjCaaq2b49kFDYmI4zSQjp+aBvyAFtr8X?=
 =?us-ascii?Q?9yGr22JSEREBpXgdSU8DUAeKGRhxRLt9sMAFgaJ8uS28nBJClLHyv7i9k21v?=
 =?us-ascii?Q?SQBy6I+PRXthJsjNQf4XFtJaUaVMkVqYTTOE6tJ2DMj82PqgRIajNJenIU5Q?=
 =?us-ascii?Q?t6Qin1JcdbRrVr06Vw/OmVyqB9Sn/U9t5qM4tGoW0B2MrD9lGYK+qPg1Gkvr?=
 =?us-ascii?Q?2skCXxxKJtgkJTx5uBge0ajinXlQOj04q7vh13lpAIVbLcWbCFF/Ld7mYiNk?=
 =?us-ascii?Q?j28CZebcaTjixd4cWWuDG0IcPgR+8h9XCoQ+PgDRcXQlR/WkqRoya++B5SfQ?=
 =?us-ascii?Q?CnSwVgYzcw2IfrS0XYY/yi9gFNzXC500IjipGTvMYSAlGLxGGAaB6tb66XPB?=
 =?us-ascii?Q?Xr0Oa4SQn6xVPuw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB10056.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2MYYUGiQ1dIMNNv3phHb709m15axduRqQW2oRSa4FS3grYa4UH/t3Rs3UoBF?=
 =?us-ascii?Q?VGsTaopIuhYOn7Rb8zK9NL/SnghIYTVTEk9UHCoK6Ho9R8R0zu7nRQnOLRsh?=
 =?us-ascii?Q?jk/MVAMoAqrL/yzGk1WEk5UCAs0oUwXhEbPEXLav3MpmJm4nZaV04S7JFq8O?=
 =?us-ascii?Q?wgDQgmVAB8UlR0YsUrKREGR4nkuwJu40d2j+f/nIHONZkNYtPRaVvBaC2aLi?=
 =?us-ascii?Q?WE/e2lbtJEFL0mViOa/kBUjF0JCszbLIHMIMhmgsoQ+68RwwdLJQB3dsuWAe?=
 =?us-ascii?Q?9fwSDvWZi7r/UO8Ed5WEN4/qFYNnDtZey/4XDfRl3UlAx8i8TOO1nQzQbPzx?=
 =?us-ascii?Q?lGuXOi8vfew3O4WFVLn5tbiv99BJ7yR/XswMzlvxWpYIfMhjwjpmEhJPrHQp?=
 =?us-ascii?Q?0KkM6BgDMgCEBc+28FsJLZMdVwoAiiBjk56aHjli4j1TvhYh1LOJY3/e3HLs?=
 =?us-ascii?Q?aSn3xKVEwlwU4VAiQvkEC7yGECw83NhlxuddGnqiC2GIwLLeaLPCGI9gIwxi?=
 =?us-ascii?Q?nPSqevusBFs4Xgdb6Rd80KlqtU7dkN6apuQJcy+WtYO2z4cmCVJaCvRW7tuK?=
 =?us-ascii?Q?ZibEy8VaAkC39XShb3jrINh0pi7Hc15YIbcdCJpjB6JUCzXp+/jNnEGTBAIt?=
 =?us-ascii?Q?pf3JxIDN16qCVAL41xkZijr9VWHG4/rXvOhhffwCJ5ZMVaX/lbSe4awHE9Xs?=
 =?us-ascii?Q?leycxwWOQbqXvVcVg7XCXtSj26iAWvZD9QN7WwFCSObsnUQsIJcRzg2tuC9H?=
 =?us-ascii?Q?Vgi/ZtS7rHnLn3l1lQ7iGqWJKk1yLqyF6Yc9CTHYllkbhKk8qn+cG6gPk8ox?=
 =?us-ascii?Q?d9Tms8voxPukHYtzC2SEAAWHK6BTXAIqNbaoGMi/Jrc67mtIaJdefpCK3Zmk?=
 =?us-ascii?Q?L6OcZvjp1cD+wruhiKW+iY0872T3mYbL+l88jNYjSRBvXOkxKMTmO5GjSkl5?=
 =?us-ascii?Q?XEXf1R/ytLOMYRJTvjshUnv/IwP5SmSy7qA/EwQf+YZe45zTsx+oRn9DBFBb?=
 =?us-ascii?Q?hkTDAwfuW9+ilPJgELyzgb5o5cPtL44Gzcq22rAF7xkcpENzPQAQrNe+THAy?=
 =?us-ascii?Q?0fuJTox6YB/ppAWFYIZRY2v/HsM7WYEvoqB/W/fyVr0CvtzSrzyFgVlGv6Pd?=
 =?us-ascii?Q?rK0bNGoRg4/2TzH0NXhQ1w6ZPbsY48T2cqQdfOOSkALpyyDunKDWX7vPOIBF?=
 =?us-ascii?Q?xPgaHdE5CB80TKEQ/DeXZolub3VIN0Zruep0js3Grck8OtrXxCwKZNYLOTD/?=
 =?us-ascii?Q?LztCZcmj6z1/w7eqD4cz6lqDGHr5r0SMI5XmbBXYT1DugNk+r3wnlx9fcfBx?=
 =?us-ascii?Q?IH/ztEfrOeA5JoPkZ3b7BO/pNTOdT1bHDZz1JjHy0APxbwmVdlSZCgNdnfOK?=
 =?us-ascii?Q?VBDN6mBDo7iJoH0HZsvQ3T2BQQWeXCy6zZ/uQ1O/URk6XChxdxlyfuQ8OkLI?=
 =?us-ascii?Q?Cibe8dY/zXEHoeKu6400oBePic2ICNO4dgHwGJNghB7ANQhVCvNGPWkaT+dG?=
 =?us-ascii?Q?8dL9JqCp4jp3mMqhemmO6cgDEmY3akXsT2xhW1XPfBQ7QpCZi+G5xjTrNR9Y?=
 =?us-ascii?Q?Bjg9OLpj6vv8KR2aeTU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a892a1-8a76-42c3-6467-08ddf156b7e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 17:14:51.0838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a1ae89fb-21b9-40bf-9d82-a10ae85a2407
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gIp6POIZKRuu8BNseMaaLbWYd/iBE7/+0Th5JoTDe5czc9QdU5X3YW+2URgh9rjs47bVErwYp9aYk1RxM/ZovQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB11034

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

nick@nicklinux:~/linux-evl$ sudo make modules_install install
[sudo] password for nick:=20
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
make: *** [Makefile:224: __sub-make] Error 2
nick@nicklinux:~/linux-evl$ make menuconfig


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
make: *** [Makefile:224: __sub-make] Error 2
nick@nicklinux:~/linux-evl$ make menuconfig

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
Found linux image: /boot/vmlinuz-6.2.0-37-generic
Found initrd image: /boot/initrd.img-6.2.0-37-generic
Found memtest86+ 64bit EFI image: /boot/memtest86+x64.efi
Warning: os-prober will not be executed to detect other bootable partitions=
.
Systems on them will not be added to the GRUB boot configuration.
Check GRUB_DISABLE_OS_PROBER documentation entry.
Adding boot menu entry for UEFI Firmware Settings ...
Done

Best Regards,
Nick Xie=20


-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>=20
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
