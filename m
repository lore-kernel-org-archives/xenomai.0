Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011047.outbound.protection.outlook.com [40.107.130.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808622E040A
	for <xenomai@lists.linux.dev>; Wed, 10 Sep 2025 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757534101; cv=fail; b=LGOZDMERVg47uSJcE5Pn0AGAV3KJi5mIZqTSku9VEOKKN3CCO1ey9EDHTtlifo25MzADAph++Bte9pZFzvQqgsoS1SpamgIIDXhim2QaNhWnemoCBxCljL04tdGx4kqCfbCrtlEkih5XbFXcSieZQ80ZRTBqHPWjGwWw8/S7+5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757534101; c=relaxed/simple;
	bh=F+JTvOr05O96VTEpbn5jMzjLcVpTv5Iura8kwBwZZbw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OAdwWS3rAgkK58cBITVbOb+w9fNnKVnz8n62FqzRoDKfUToqpi+M2Z4IJFudnD7oPNXgtQUJ3XHcx80LqJ1TcrilDjQmCFyebjELNeGR0VA4zCsWQGwj5M30KDrU3Tr0aQ08nlq52KfhC7ROTBzSRA43OAPBgNwp8Iu7a7lcKLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com; spf=pass smtp.mailfrom=festo.com; dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b=cHiukuoX; arc=fail smtp.client-ip=40.107.130.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=festo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b="cHiukuoX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3nToRi5fUMrSE3ElWIhuNJ42eG2roYxw8UScV62KinBmD74S9zlZbkPwpRqYN3L8dRyGGu2uR6TpitryDNqMnBWIs3o//0RyIcnUfif0WjnSgBFETq2ouXEvuK0WB5kOu7XOMj24gMjCLJy08ON3kd1vEtKIdFWMZt2jiCE534uc/0nAHQRqpIVoFJApoeCuuMGrqlbLOFGCknx34C88GXqPma4zsHCTrK8TnKZb0lu+8F8sruqorMj5aGSAf7uH8RGqwT2/Ue2ki3zmXBaVKHRVW8pppz4QhMi3L8sxuSGCtVWQcKDY3dBcG3wX6T23AZlSUsEYV3SoeHJD2IyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vK+VXCJrbTloo++fS/CmC0WoBTHYAMXPly9QPAzI9ew=;
 b=PZKHvTI5zT66BXMAe4U6UL0H1ULkjrw73EO5ysWJQ2A05KYpmNfK3QYIiKnnSg7KfO4mznqEEOjw3kSjDejJ7aK7/ubU6e07iu6ls8WBQWVl0ljRyDit1DmHXJ3n5gPUpEeYVsZ9AyXwJWrseTO6piQU01bTSNX9ZMm5/fFZEpgKRWfIL5NgwNYvwnTkn+f9h3p69dvWtVxymjdJm+An7CceetSKtyQZQxLY/IYo1kEvO9X8K+cJrWj2iBhK5eV8DznQW74BZMaZ73rpW3yhnxlr50Fqhd0IJRl93avFLasX0GSbQbULbiLJc/86zq6LALfZzN62X7K8qlvWHG7lHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=festo.com; dmarc=pass action=none header.from=festo.com;
 dkim=pass header.d=festo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=festo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vK+VXCJrbTloo++fS/CmC0WoBTHYAMXPly9QPAzI9ew=;
 b=cHiukuoX8QfjNXUHBxhwrPZ6EYuKM8R85j/2tLEZ2zZIhHz3Z2rrPpH1CfRsCWMCID02NNcVpuMdCyKnX2fPewbGj4BLsY1ycro99rjQmAXD6tRKpK9iT6c0dxSonsmm04Juw4sYPNAh/vFagjo7AUThjuXD/v3C6kvSaXFnw6U=
Received: from AS8PR03MB10056.eurprd03.prod.outlook.com (2603:10a6:20b:63d::7)
 by DU0PR03MB8342.eurprd03.prod.outlook.com (2603:10a6:10:3a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 19:54:52 +0000
Received: from AS8PR03MB10056.eurprd03.prod.outlook.com
 ([fe80::5350:1f43:188a:6db5]) by AS8PR03MB10056.eurprd03.prod.outlook.com
 ([fe80::5350:1f43:188a:6db5%3]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 19:54:52 +0000
From: "Xie, Nick" <nick.xie@festo.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Error during libevl build and runtime settings failed
Thread-Topic: Error during libevl build and runtime settings failed
Thread-Index: AdvhNCsPSr13v8uwQHKA1c0dN9vzhQhJ1t/wAAMSmAAAFusnuwfrxy3Q
Date: Wed, 10 Sep 2025 19:54:52 +0000
Message-ID:
 <AS8PR03MB10056F9D6FBDE93A148E03F5A8B0EA@AS8PR03MB10056.eurprd03.prod.outlook.com>
References:
 <AM5PR03MB2882F5ED2ADBA37FAA9562608B7DA@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<AM5PR03MB2882F38E95A99A0760C60D1F8B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<AM5PR03MB2882726DD078E29EB76589518B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
 <878qk3za1e.fsf@xenomai.org>
In-Reply-To: <878qk3za1e.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_ActionId=b855f1ea-89a5-4922-b898-f6e10ed5c2e7;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_ContentBits=0;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Enabled=true;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Method=Standard;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Name=Internal;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_SetDate=2025-09-10T16:47:32Z;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_SiteId=a1ae89fb-21b9-40bf-9d82-a10ae85a2407;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=festo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB10056:EE_|DU0PR03MB8342:EE_
x-ms-office365-filtering-correlation-id: 26db8eeb-4578-467d-2cde-08ddf0a3e856
x-ms-reactions: disallow
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EMqaTbgG/t6i5GU90JC935k388aXResGZGHz3bJl1UzsS/OpXHt29TSCQDnt?=
 =?us-ascii?Q?6ODjRJHcuU/MocpiEUZ2LxQbCSNHP0pTRxW/wRf41kTWpsamFPkMghxQ3ICZ?=
 =?us-ascii?Q?SsuUvijlFAwyuPTEIezt02RplAKijx/DW/hkHVqQeZEYWoqBp2Gt5qux2l70?=
 =?us-ascii?Q?5FshHwoSMxywCvDr+2sbtSL/DGl2Kji+t9o5rijYRXbjC9kfXd3EnjkArHWQ?=
 =?us-ascii?Q?v2NvDy41sKao5ewVC3rM6ghz27IaiiY8Uot7u4U/+sa8r1bQ6NGvLF643PAY?=
 =?us-ascii?Q?rviB1ths4dMq7BsNr05jO4xY2oDNaFU+dGiqMnXSP9F3zyl11mM/pjcpZTm0?=
 =?us-ascii?Q?AW3QavIkJPKCT95v8zxXwTrzok5prUhh2ZXi/7bKgFb0fCvePiTOkrRZz3Z+?=
 =?us-ascii?Q?gJR7akS58vbJ2JcXpeWVAHSM3dfWQw+VamrkNAq4BwANWuGNn7ttoWzR+zTv?=
 =?us-ascii?Q?KSZITnq/EuAbi+N0kDXFK8g3Tmtg4hqJJIPTJDbuNb2hNsv/7pYcZ3Vn9410?=
 =?us-ascii?Q?aMvWpoKPjp80+tK4wT97RPXHl7tg35dh5RD5MG1DEsemGGJrILBDESVEucs/?=
 =?us-ascii?Q?zlTlueoeHe71nAT6rLDByLfM7SarEa+2CFlqUfYvGlTXwPiii7g2h16NnKZT?=
 =?us-ascii?Q?sBs9vaCz+F1mfQBnuHdVOKPlhSLa/x7rFzvTvqFOcTbaIhgbEamWZz8OCAQm?=
 =?us-ascii?Q?GqY4KFbgt5Qq2lagsWXUU4Loyyx0YabPgPEPLLvsnpzOOry5Pqz11wavaNO8?=
 =?us-ascii?Q?OtfalpAxaXZXHRgy+iNkIzXhnyEuQk/UR8/yIdcrFejCdZKGNLQl5W4H11uW?=
 =?us-ascii?Q?lBUelq2vDQXNYcpoPqQF/IWnHvbCfSGx9MfTrzJ9x0ShEh9wSFRBC9vwXaT/?=
 =?us-ascii?Q?G/E/wEZJtSKc30rC9O6QxeXTdnDRGr3pOziu01ffc9nrYIR/GszaGECT2cL5?=
 =?us-ascii?Q?b5ws/lwo8b3lzOnnziY9j9JjdHfBF1WRCpCcNlU+ax3rlL7CiLqXmZv5ckmU?=
 =?us-ascii?Q?AhA4KV1t6qWsvtyg5EW3ECay8wGBEm+U2y8Ta2MnE58NRoB2mOQ9yFKkC1Ka?=
 =?us-ascii?Q?tSGq6kAZdP2pDuiu6f8hNSl7cH361pPdJCTRZbTLON3Y+jS3Xn1jkh7YG71k?=
 =?us-ascii?Q?5/4HWhB3HCpknsfHj8tkIjWl6tioLLJNeAs1yl/FGPIC6cyRCtMrE6o56A58?=
 =?us-ascii?Q?ax1n1K2C3AcJxdgCYfMZ7sE+BMVHM6Z9foU89JxgzTXtE5WOUhpBjnqsEz2S?=
 =?us-ascii?Q?cezq4YXV+SpzAsMci39sArTUJFD2IaSIf7swrCwxFG4161zuarO3EVMb/1lD?=
 =?us-ascii?Q?h8ltUv+Epb0dL0eiGFvQtwnoGG5Yp5v4hiwT245hqurBeX148Y9DkOkW8sqy?=
 =?us-ascii?Q?5zoLNf/bR4JSNgndXqG7RTgPjvgP9mNG83xOa1z+boM85mSejGiBMDO0LNhx?=
 =?us-ascii?Q?rDrH9TOoGbRDSv2xYni7xicg9dK75Xip+E7oHLzWB00eAVBjXYdwFA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB10056.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kbkXD5AnWokOcABOpIT3CQ9azv/0j7yogWP1nGBX42GW2c3h64VE0SsddW0c?=
 =?us-ascii?Q?+Sc3bMwj/XixbfR+ZeMjK2T2rJS+VhJRrel5sL0jz7OP8vCz7db6UvGgVbz5?=
 =?us-ascii?Q?yDsQVLII0pgReQh/y6OyfLkrgnwrMifymNn8z86ZmfYOMtPAmktHpvqGbysl?=
 =?us-ascii?Q?NntRu33HYgBNKuBe+oR/MNKhC9Z6W8uHOHzensO2h1ybbx2CqTv2NvORqVPX?=
 =?us-ascii?Q?TbwSr9vVlRO4fTLx2trV9JhCbxRiJ1JO7GxoAE4pKFvx7IzzSTjA2pqBHYBQ?=
 =?us-ascii?Q?FidvhhR+3HhpU0sa/xYvfWvcu1po63G+lW0JLpsqZyh3uCLTcTx3J41tFG12?=
 =?us-ascii?Q?+nfINnZuprnNGkrEjXZBZiUvrq/IqGrZxY1a1NHLOZtF3pwfRwR4V/AMyPPR?=
 =?us-ascii?Q?BUTtSkgMFxNP4ZkJemy9bG8q9B1pONlW/9KEKO0MIVcOC2y3z7J66FPYoKqB?=
 =?us-ascii?Q?PtqqYzCBLvy8cQmTQEK5flwbQ7HRkvoC+ULRnw3dE54vwZCUDgArRReVoxTs?=
 =?us-ascii?Q?B5wb1teWo4nJKNHHbaZPG9wX4jPc9xury2+fnNE9oxP1gYBz4yYmZKd3+4fR?=
 =?us-ascii?Q?3s0682d2+ye70Sp8B5DpJ3xvT+BQWHWs8kLFKmJDaf6hVqmvJsm4W6igbfsz?=
 =?us-ascii?Q?AyUrDLdct4bWDO/veiK/koy4KmfwVWf+E5IlZ20rN7WxxefovCfPtq483rOK?=
 =?us-ascii?Q?ERWUd9wZYbRZcIYgsLnybu8BiIgaVP/jLVOulUvtVW2nx+37DqAaOdClZm2L?=
 =?us-ascii?Q?Hc0UZZyRDa512Ba209Xw3yMPmui3tMGNdTg8zsy0VTopEblF2ohYFH0Atv5C?=
 =?us-ascii?Q?q2W/qzOekvjTIRRhhtNoGpoBPpWpzPX2Kyo86M9SKFg5ddR/ivxH2C503jkr?=
 =?us-ascii?Q?SU00jbfLztjpGUQ3GN8W0EBsV9M48b/U5yCE0Mh9GcYr4yUvqtl1DCsJcwit?=
 =?us-ascii?Q?O67I6QgC6O6mBqzU/jvQaIf+CT/gKaQurHvV0Yva6UBrxAIC9RM1sK83WvBQ?=
 =?us-ascii?Q?cMx8kEWbejKArzT18CcFMMBmqF4luu4V5ow5QacvFcnRreVbFL7f8Sy/yf75?=
 =?us-ascii?Q?sXqdWH7Ld0+jPlgOCesvh4XVF6vQ4nluoFQ0rWhDR+NSIUxEkM6z4q/xcInf?=
 =?us-ascii?Q?H1YOFIwdeE1KFo9izIPkeHDxjDmwrufk9s01YYvLtm0Y0GJ0R48A8XzFAMoX?=
 =?us-ascii?Q?9Ic0V5RnuhYLgeqM0XA+uJZUx8BwlH1dAseXytiR/FzsQucS5QrpyEeNWOK0?=
 =?us-ascii?Q?HVV4erqmq50/zF/NJbV96v2rl9FBibFbKFDsPPF48Zn+e293Km+2A7qqwVKt?=
 =?us-ascii?Q?Xdk+lX2Hy2T+PBkGgXDv7+U16oisBBRwXETKLT5O0aweQHn1fSq3g8BX/eDA?=
 =?us-ascii?Q?CI8ECQ+esncmbEdTSgpJ3ErkdvRjx8AsZFHBdeHYjq9Nxby1CfxH2e9/urtz?=
 =?us-ascii?Q?fkhr/O7sa9Avdcg6DYPuG0qz36IS0LT54Ho9OsGOD0GqA2Cr4jr+6jUYBnzi?=
 =?us-ascii?Q?BCXNlyHd+Sw3dcQc0ZZZv9oLFy8iW32zVcStpyQEEgSpyuVXNn3pGdrCKdBz?=
 =?us-ascii?Q?Q8FC4is03AAJQbYWgRE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26db8eeb-4578-467d-2cde-08ddf0a3e856
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 19:54:52.3912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a1ae89fb-21b9-40bf-9d82-a10ae85a2407
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o5AIcD5mB/k93DdbAk/s4t0Jh6KVrHTfK6Y8C1fRaDrV3d1XzHVfCYmi7dUXUdER+gB+DQ1Vh0ffC7pwBI7/Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8342

Hi Philippe,

Thank you for your information. We tried 0.54 and 0.55 and got error. It co=
mplained " EVL kernel uapi is too old " and then we rebuild the 6.12 kernel=
 with the newest update. The whole processing seems fine and please see bel=
ow. But we have a new problem now. =20

The startup stuck at=20
"Loading Linux 6.12.30- g06a9a69b631e,Loading initial ramdisk "

Please advise. Thank you in advance.

nick@nicklinux:~$ cd linux-evl
nick@nicklinux:~/linux-evl$ scripts/config --disable SYSTEM_TRUSTED_KEYS
grep: .config: No such file or directory
nick@nicklinux:~/linux-evl$ scripts/config --disable SYSTEM_REVOCATION_KEYS
nick@nicklinux:~/linux-evl$ scripts/config --disable SYSTEM_TRUSTED_KEYS
nick@nicklinux:~/linux-evl$ make menuconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/mconf.o
  HOSTCC  scripts/kconfig/lxdialog/checklist.o
  HOSTCC  scripts/kconfig/lxdialog/inputbox.o
  HOSTCC  scripts/kconfig/lxdialog/menubox.o
  HOSTCC  scripts/kconfig/lxdialog/textbox.o
  HOSTCC  scripts/kconfig/lxdialog/util.o
  HOSTCC  scripts/kconfig/lxdialog/yesno.o
  HOSTCC  scripts/kconfig/mnconf-common.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/menu.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/util.o
  HOSTLD  scripts/kconfig/mconf


*** End of the configuration.
*** Execute 'make' to start the build or try 'make help'.

nick@nicklinux:~/linux-evl$ make -j4
  SYNC    include/config/auto.conf.cmd
  HOSTCC  scripts/kconfig/conf.o
  HOSTLD  scripts/kconfig/conf
  GEN     arch/x86/include/generated/asm/orc_hash.h
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  WRAP    arch/x86/include/generated/uapi/asm/errno.h
  WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
  HOSTCC  arch/x86/tools/relocs_32.o
  WRAP    arch/x86/include/generated/uapi/asm/param.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/uapi/asm/resource.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  WRAP    arch/x86/include/generated/uapi/asm/termbits.h
  WRAP    arch/x86/include/generated/uapi/asm/termios.h
  WRAP    arch/x86/include/generated/uapi/asm/types.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/asm/unistd_32_ia32.h
  HOSTCC  arch/x86/tools/relocs_64.o
  SYSHDR  arch/x86/include/generated/asm/unistd_64_x32.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_64.h
  WRAP    arch/x86/include/generated/asm/early_ioremap.h
  WRAP    arch/x86/include/generated/asm/mcs_spinlock.h
  WRAP    arch/x86/include/generated/asm/mmzone.h
  WRAP    arch/x86/include/generated/asm/irq_regs.h
  WRAP    arch/x86/include/generated/asm/kmap_size.h
  WRAP    arch/x86/include/generated/asm/local64.h
  WRAP    arch/x86/include/generated/asm/mmiowb.h
  WRAP    arch/x86/include/generated/asm/module.lds.h
  WRAP    arch/x86/include/generated/asm/rwonce.h
  UPD     include/generated/uapi/linux/version.h
  UPD     include/generated/compile.h
  HOSTCC  scripts/kallsyms
  DESCEND objtool
  HOSTCC  arch/x86/tools/relocs_common.o
  UPD     include/config/kernel.release
  UPD     include/generated/utsrelease.h
  HOSTLD  arch/x86/tools/relocs
  HOSTCC  scripts/sorttable
  INSTALL /home/nick/linux-evl/tools/objtool/libsubcmd/include/subcmd/exec-=
cmd.h
  INSTALL /home/nick/linux-evl/tools/objtool/libsubcmd/include/subcmd/help.=
h
  INSTALL /home/nick/linux-evl/tools/objtool/libsubcmd/include/subcmd/pager=
.h
  INSTALL /home/nick/linux-evl/tools/objtool/libsubcmd/include/subcmd/parse=
-options.h
  INSTALL /home/nick/linux-evl/tools/objtool/libsubcmd/include/subcmd/run-c=
ommand.h
  INSTALL libsubcmd_headers
  CC      /home/nick/linux-evl/tools/objtool/libsubcmd/exec-cmd.o
  CC      /home/nick/linux-evl/tools/objtool/libsubcmd/help.o
  CC      /home/nick/linux-evl/tools/objtool/libsubcmd/pager.o
  CC      /home/nick/linux-evl/tools/objtool/libsubcmd/parse-options.o
  CC      /home/nick/linux-evl/tools/objtool/libsubcmd/run-command.o
  CC      /home/nick/linux-evl/tools/objtool/libsubcmd/sigchain.o
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  CC      /home/nick/linux-evl/tools/objtool/libsubcmd/subcmd-config.o
  CC      scripts/mod/devicetable-offsets.s
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTCC  scripts/mod/symsearch.o
  UPD     scripts/mod/devicetable-offsets.h
  HOSTCC  scripts/mod/file2alias.o
  LD      /home/nick/linux-evl/tools/objtool/libsubcmd/libsubcmd-in.o
  AR      /home/nick/linux-evl/tools/objtool/libsubcmd/libsubcmd.a
  CC      /home/nick/linux-evl/tools/objtool/weak.o
  CC      /home/nick/linux-evl/tools/objtool/arch/x86/special.o
  CC      /home/nick/linux-evl/tools/objtool/check.o
  MKDIR   /home/nick/linux-evl/tools/objtool/arch/x86/lib/
  GEN     /home/nick/linux-evl/tools/objtool/arch/x86/lib/inat-tables.c
  CC      /home/nick/linux-evl/tools/objtool/arch/x86/orc.o
  CC      /home/nick/linux-evl/tools/objtool/arch/x86/decode.o
  CC      /home/nick/linux-evl/tools/objtool/special.o
  CC      /home/nick/linux-evl/tools/objtool/builtin-check.o
  HOSTLD  scripts/mod/modpost
  UPD     include/generated/timeconst.h
  CC      kernel/bounds.s
  CC      /home/nick/linux-evl/tools/objtool/elf.o
  CHKSHA1 include/linux/atomic/atomic-arch-fallback.h
  CHKSHA1 include/linux/atomic/atomic-instrumented.h
  CHKSHA1 include/linux/atomic/atomic-long.h
  UPD     include/generated/bounds.h
  CC      arch/x86/kernel/asm-offsets.s
  LD      /home/nick/linux-evl/tools/objtool/arch/x86/objtool-in.o
  CC      /home/nick/linux-evl/tools/objtool/objtool.o
  CC      /home/nick/linux-evl/tools/objtool/orc_gen.o
  CC      /home/nick/linux-evl/tools/objtool/orc_dump.o
  CC      /home/nick/linux-evl/tools/objtool/libstring.o
  CC      /home/nick/linux-evl/tools/objtool/libctype.o
  CC      /home/nick/linux-evl/tools/objtool/str_error_r.o
  CC      /home/nick/linux-evl/tools/objtool/librbtree.o
  UPD     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  LD      /home/nick/linux-evl/tools/objtool/objtool-in.o
  LINK    /home/nick/linux-evl/tools/objtool/objtool
  AR      usr/built-in.a
  CC      init/main.o
  UPD     init/utsversion-tmp.h
  CC      init/do_mounts.o
  CC      arch/x86/entry/vdso/vma.o
  CC      kernel/sched/core.o
  CC      arch/x86/entry/vdso/extable.o
  CC      init/noinitramfs.o
  CC      arch/x86/entry/vsyscall/vsyscall_64.o
  LDS     arch/x86/entry/vdso/vdso.lds
  AS      arch/x86/entry/vdso/vdso-note.o
  CC      arch/x86/entry/vdso/vclock_gettime.o
  CC      init/calibrate.o
  CC      kernel/sched/fair.o
  CC      arch/x86/entry/vdso/vgetcpu.o
  AS      arch/x86/entry/vsyscall/vsyscall_emu_64.o
  CC      init/init_task.o
  AR      arch/x86/entry/vsyscall/built-in.a
  AS      arch/x86/entry/entry.o
  CC      arch/x86/entry/vdso/vgetrandom.o
  CC      kernel/sched/build_policy.o
  AS      arch/x86/entry/vdso/vgetrandom-chacha.o
  HOSTCC  arch/x86/entry/vdso/vdso2c
  CC      init/version.o
  AR      init/built-in.a
  AR      certs/built-in.a
  CC      arch/x86/events/amd/core.o
  VDSO    arch/x86/entry/vdso/vdso64.so.dbg
  OBJCOPY arch/x86/entry/vdso/vdso64.so
  VDSO2C  arch/x86/entry/vdso/vdso-image-64.c
  CC      arch/x86/entry/vdso/vdso-image-64.o
  AR      arch/x86/entry/vdso/built-in.a
  AS      arch/x86/entry/entry_64.o
  CC      arch/x86/entry/syscall_64.o
  CC      kernel/sched/build_utility.o
  CC      arch/x86/events/amd/lbr.o
  CC      arch/x86/entry/common.o
  CC      arch/x86/events/intel/core.o
  CC      arch/x86/events/amd/ibs.o
  AS      arch/x86/entry/thunk.o
  AR      arch/x86/entry/built-in.a
  CC      arch/x86/realmode/init.o
  AR      kernel/sched/built-in.a
  CC      kernel/locking/mutex.o
  AS      arch/x86/realmode/rm/header.o
  AS      arch/x86/realmode/rm/trampoline_64.o
  AS      arch/x86/realmode/rm/stack.o
  AS      arch/x86/realmode/rm/reboot.o
  AS      arch/x86/realmode/rm/wakeup_asm.o
  CC      arch/x86/realmode/rm/wakemain.o
  CC      arch/x86/realmode/rm/video-mode.o
  CC      kernel/locking/semaphore.o
  AS      arch/x86/realmode/rm/copy.o
  AS      arch/x86/realmode/rm/bioscall.o
  CC      arch/x86/realmode/rm/regs.o
  CC      arch/x86/events/amd/uncore.o
  CC      arch/x86/realmode/rm/video-vga.o
  CC      arch/x86/realmode/rm/video-vesa.o
  CC      arch/x86/realmode/rm/video-bios.o
  PASYMS  arch/x86/realmode/rm/pasyms.h
  LDS     arch/x86/realmode/rm/realmode.lds
  LD      arch/x86/realmode/rm/realmode.elf
  RELOCS  arch/x86/realmode/rm/realmode.relocs
  OBJCOPY arch/x86/realmode/rm/realmode.bin
  AS      arch/x86/realmode/rmpiggy.o
  AR      arch/x86/realmode/built-in.a
  CC      mm/filemap.o
  CC      kernel/locking/rwsem.o
  AR      arch/x86/events/amd/built-in.a
  CC      arch/x86/events/zhaoxin/core.o
  CC      arch/x86/events/intel/bts.o
  CC      kernel/locking/percpu-rwsem.o
  AR      arch/x86/events/zhaoxin/built-in.a
  CC      kernel/locking/rtmutex_api.o
  CC      kernel/power/qos.o
  CC      arch/x86/events/intel/ds.o
  CC      kernel/locking/pipeline.o
  CC      kernel/power/main.o
  AR      kernel/locking/built-in.a
  CC      arch/x86/events/core.o
  CC      mm/mempool.o
  CC      kernel/power/console.o
  CC      arch/x86/events/intel/knc.o
  CC      mm/oom_kill.o
  CC      kernel/power/process.o
  CC      arch/x86/events/intel/lbr.o
  CC      arch/x86/events/intel/p4.o
  CC      mm/fadvise.o
  CC      kernel/power/suspend.o
  CC      arch/x86/events/intel/p6.o
  CC      arch/x86/events/intel/pt.o
  CC      mm/maccess.o
  AR      kernel/power/built-in.a
  CC      kernel/printk/printk.o
  CC      arch/x86/kernel/fpu/init.o
  CC      mm/page-writeback.o
  CC      arch/x86/kernel/fpu/bugs.o
  CC      arch/x86/kernel/fpu/core.o
  AR      arch/x86/events/intel/built-in.a
  CC      arch/x86/events/probe.o
  CC      arch/x86/events/utils.o
  CC      arch/x86/kernel/fpu/regset.o
  CC      mm/folio-compat.o
  CC      kernel/printk/printk_safe.o
  CC      arch/x86/events/msr.o
  CC      arch/x86/kernel/fpu/signal.o
  CC      kernel/printk/nbcon.o
  CC      mm/readahead.o
  AR      arch/x86/events/built-in.a
  CC      arch/x86/kernel/cpu/mce/core.o
  CC      arch/x86/kernel/fpu/xstate.o
  CC      kernel/printk/printk_ringbuffer.o
  CC      mm/swap.o
  CC      kernel/printk/sysctl.o
  AR      arch/x86/kernel/fpu/built-in.a
  CC      arch/x86/kernel/cpu/mtrr/mtrr.o
  CC      arch/x86/kernel/cpu/mce/severity.o
  AR      kernel/printk/built-in.a
  CC      kernel/irq/irqdesc.o
  CC      mm/truncate.o
  CC      arch/x86/kernel/cpu/mtrr/if.o
  CC      arch/x86/kernel/cpu/mce/genpool.o
  CC      kernel/irq/handle.o
  CC      arch/x86/kernel/cpu/mtrr/generic.o
  CC      mm/vmscan.o
  CC      arch/x86/kernel/cpu/mce/intel.o
  CC      kernel/irq/manage.o
  CC      arch/x86/kernel/cpu/mce/threshold.o
  CC      arch/x86/kernel/cpu/mtrr/cleanup.o
  AR      arch/x86/kernel/cpu/mce/built-in.a
  CC      arch/x86/kernel/cpu/microcode/core.o
  CC      kernel/irq/spurious.o
  AR      arch/x86/kernel/cpu/mtrr/built-in.a
  CC      arch/x86/kernel/cpu/cacheinfo.o
  CC      mm/shrinker.o
  CC      kernel/irq/resend.o
  CC      arch/x86/kernel/cpu/microcode/intel.o
  CC      fs/notify/dnotify/dnotify.o
  CC      kernel/irq/chip.o
  CC      mm/shmem.o
  CC      arch/x86/kernel/cpu/microcode/amd.o
  AR      fs/notify/dnotify/built-in.a
  CC      fs/notify/inotify/inotify_fsnotify.o
  CC      kernel/irq/dummychip.o
  CC      fs/notify/inotify/inotify_user.o
  AR      arch/x86/kernel/cpu/microcode/built-in.a
  CC      arch/x86/kernel/cpu/scattered.o
  CC      kernel/irq/devres.o
  CC      arch/x86/kernel/cpu/topology_common.o
  CC      kernel/irq/autoprobe.o
  CC      mm/util.o
  CC      arch/x86/kernel/cpu/topology_ext.o
  AR      fs/notify/inotify/built-in.a
  AR      fs/notify/fanotify/built-in.a
  CC      fs/notify/fsnotify.o
  CC      kernel/irq/irqdomain.o
  CC      arch/x86/kernel/cpu/topology_amd.o
  CC      mm/mmzone.o
  CC      fs/notify/notification.o
  CC      kernel/irq/pipeline.o
  CC      arch/x86/kernel/cpu/common.o
  CC      mm/vmstat.o
  CC      fs/notify/group.o
  CC      fs/notify/mark.o
  CC      kernel/irq/proc.o
  CC      mm/backing-dev.o
  CC      arch/x86/kernel/cpu/rdrand.o
  CC      arch/x86/kernel/cpu/match.o
  CC      kernel/irq/pm.o
  CC      mm/mm_init.o
  CC      fs/notify/fdinfo.o
  CC      arch/x86/kernel/cpu/bugs.o
  AR      fs/notify/built-in.a
  CC      fs/iomap/trace.o
  CC      kernel/irq/matrix.o
  AR      kernel/irq/built-in.a
  CC      kernel/rcu/update.o
  CC      fs/iomap/iter.o
  CC      mm/percpu.o
  CC      kernel/rcu/sync.o
  CC      kernel/rcu/srcutree.o
  CC      arch/x86/kernel/cpu/aperfmperf.o
  CC      fs/iomap/buffered-io.o
  CC      arch/x86/kernel/cpu/cpuid-deps.o
  CC      kernel/rcu/tree.o
  CC      mm/slab_common.o
  CC      arch/x86/kernel/cpu/umwait.o
  CC      fs/iomap/direct-io.o
  MKCAP   arch/x86/kernel/cpu/capflags.c
  CC      mm/compaction.o
  CC      fs/iomap/fiemap.o
  CC      fs/iomap/seek.o
  CC      mm/show_mem.o
  CC      fs/iomap/swapfile.o
  AR      fs/iomap/built-in.a
  AR      fs/quota/built-in.a
  CC      fs/proc/task_mmu.o
  CC      mm/interval_tree.o
  CC      kernel/rcu/rcu_segcblist.o
  AR      kernel/rcu/built-in.a
  AR      kernel/livepatch/built-in.a
  CC      kernel/dma/mapping.o
  CC      mm/list_lru.o
  CC      arch/x86/kernel/cpu/powerflags.o
  CC      arch/x86/kernel/cpu/topology.o
  CC      fs/proc/inode.o
  CC      kernel/dma/direct.o
  CC      mm/workingset.o
  CC      arch/x86/kernel/cpu/proc.o
  CC      mm/debug.o
  CC      kernel/dma/ops_helpers.o
  CC      fs/proc/root.o
  CC      arch/x86/kernel/cpu/feat_ctl.o
  CC      arch/x86/kernel/cpu/intel.o
  CC      kernel/dma/swiotlb.o
  CC      fs/proc/base.o
  CC      mm/gup.o
  CC      kernel/dma/remap.o
  CC      arch/x86/kernel/cpu/tsx.o
  CC      arch/x86/kernel/cpu/intel_epb.o
  AR      kernel/dma/built-in.a
  CC      kernel/entry/common.o
  CC      arch/x86/kernel/cpu/amd.o
  CC      fs/proc/generic.o
  CC      mm/mmap_lock.o
  CC      kernel/entry/syscall_user_dispatch.o
  CC      arch/x86/kernel/cpu/hygon.o
  CC      fs/proc/array.o
  CC      mm/highmem.o
  AR      kernel/entry/built-in.a
  CC      kernel/time/time.o
  CC      arch/x86/kernel/cpu/centaur.o
  CC      arch/x86/kernel/cpu/zhaoxin.o
  CC      mm/memory.o
  CC      arch/x86/kernel/cpu/perfctr-watchdog.o
  CC      fs/proc/fd.o
  CC      kernel/time/timer.o
  CC      arch/x86/kernel/cpu/capflags.o
  AR      arch/x86/kernel/cpu/built-in.a
  CC      arch/x86/kernel/acpi/boot.o
  CC      fs/proc/proc_tty.o
  CC      kernel/time/hrtimer.o
  CC      fs/proc/cmdline.o
  CC      arch/x86/kernel/acpi/sleep.o
  CC      fs/proc/consoles.o
  CC      kernel/time/timekeeping.o
  CC      fs/proc/cpuinfo.o
  AS      arch/x86/kernel/acpi/wakeup_64.o
  CC      arch/x86/kernel/acpi/cstate.o
  AR      arch/x86/kernel/acpi/built-in.a
  CC      arch/x86/kernel/apic/apic.o
  CC      fs/proc/devices.o
  CC      mm/mincore.o
  CC      fs/proc/interrupts.o
  CC      kernel/time/ntp.o
  CC      fs/proc/loadavg.o
  CC      arch/x86/kernel/apic/apic_common.o
  CC      mm/mlock.o
  CC      kernel/time/clocksource.o
  CC      fs/proc/meminfo.o
  CC      arch/x86/kernel/apic/apic_noop.o
  CC      arch/x86/kernel/apic/ipi.o
  CC      kernel/time/jiffies.o
  CC      fs/proc/stat.o
  CC      arch/x86/kernel/apic/vector.o
  CC      kernel/time/timer_list.o
  CC      mm/mmap.o
  CC      fs/proc/uptime.o
  CC      kernel/time/timeconv.o
  CC      fs/proc/util.o
  CC      kernel/time/timecounter.o
  CC      kernel/time/alarmtimer.o
  CC      arch/x86/kernel/apic/init.o
  CC      fs/proc/version.o
  CC      arch/x86/kernel/apic/hw_nmi.o
  CC      mm/mmu_gather.o
  CC      kernel/time/posix-timers.o
  CC      fs/proc/softirqs.o
  CC      arch/x86/kernel/apic/io_apic.o
  CC      fs/proc/namespaces.o
  CC      mm/mprotect.o
  CC      kernel/time/posix-cpu-timers.o
  CC      fs/proc/self.o
  CC      mm/mremap.o
  CC      fs/proc/thread_self.o
  CC      arch/x86/kernel/apic/apic_flat_64.o
  CC      kernel/time/posix-clock.o
  CC      fs/proc/proc_sysctl.o
  CC      mm/msync.o
  CC      arch/x86/kernel/apic/probe_64.o
  AR      arch/x86/kernel/apic/built-in.a
  AR      arch/x86/kernel/kprobes/built-in.a
  LDS     arch/x86/kernel/vmlinux.lds
  AS      arch/x86/kernel/head_64.o
  CC      mm/page_vma_mapped.o
  CC      arch/x86/kernel/head64.o
  CC      kernel/time/itimer.o
  CC      arch/x86/kernel/ebda.o
  CC      kernel/time/clockevents.o
  CC      mm/pagewalk.o
  CC      fs/proc/kmsg.o
  CC      kernel/time/tick-common.o
  CC      arch/x86/kernel/platform-quirks.o
  CC      mm/pgtable-generic.o
  CC      fs/proc/page.o
  AR      fs/proc/built-in.a
  CC      arch/x86/kernel/process_64.o
  CC      fs/kernfs/mount.o
  CC      mm/rmap.o
  CC      kernel/time/tick-broadcast.o
  CC      fs/kernfs/inode.o
  CC      kernel/time/tick-proxy.o
  CC      arch/x86/kernel/signal.o
  CC      mm/vmalloc.o
  CC      fs/kernfs/dir.o
  CC      kernel/time/vsyscall.o
  CC      arch/x86/kernel/signal_64.o
  CC      kernel/time/namespace.o
  CC      arch/x86/kernel/traps.o
  CC      fs/kernfs/file.o
  AR      kernel/time/built-in.a
  CC      kernel/futex/core.o
  CC      fs/kernfs/symlink.o
  CC      arch/x86/kernel/idt.o
  CC      kernel/futex/syscalls.o
  CC      mm/vma.o
  AR      fs/kernfs/built-in.a
  CC      fs/sysfs/file.o
  CC      kernel/futex/pi.o
  CC      arch/x86/kernel/irq.o
  CC      fs/sysfs/dir.o
  CC      kernel/futex/requeue.o
  CC      arch/x86/kernel/irq_64.o
  CC      mm/process_vm_access.o
  CC      fs/sysfs/symlink.o
  CC      arch/x86/kernel/dumpstack_64.o
  CC      kernel/futex/waitwake.o
  CC      mm/mseal.o
  CC      arch/x86/kernel/time.o
  CC      fs/sysfs/mount.o
  CC      arch/x86/kernel/ioport.o
  AR      kernel/futex/built-in.a
  CC      kernel/evl/sched/core.o
  CC      mm/page_alloc.o
  CC      fs/sysfs/group.o
  CC      arch/x86/kernel/dumpstack.o
  AR      fs/sysfs/built-in.a
  CC      fs/devpts/inode.o
  AR      fs/devpts/built-in.a
  CC      fs/ramfs/inode.o
  CC      kernel/evl/sched/fifo.o
  CC      arch/x86/kernel/nmi.o
  CC      kernel/evl/sched/idle.o
  CC      fs/ramfs/file-mmu.o
  AR      fs/ramfs/built-in.a
  CC      fs/exportfs/expfs.o
  CC      arch/x86/kernel/ldt.o
  CC      kernel/evl/sched/weak.o
  AR      fs/exportfs/built-in.a
  CC      fs/nls/nls_base.o
  CC      mm/init-mm.o
  AR      fs/nls/built-in.a
  AR      fs/unicode/built-in.a
  AR      fs/hostfs/built-in.a
  CC      fs/open.o
  AR      kernel/evl/sched/built-in.a
  CC      kernel/evl/lib/cache.o
  AS      arch/x86/kernel/ibt_selftest.o
  CC      arch/x86/kernel/setup.o
  CC      mm/memblock.o
  CC      fs/read_write.o
  CC      kernel/evl/lib/uio.o
  CC      arch/x86/kernel/x86_init.o
  CC      mm/slub.o
  AR      kernel/evl/lib/lib.a
  AR      kernel/evl/lib/built-in.a
  AR      kernel/evl/net/built-in.a
  CC      kernel/evl/clock.o
  CC      arch/x86/kernel/i8259.o
  CC      arch/x86/kernel/irqinit.o
  CC      fs/file_table.o
  CC      kernel/evl/control.o
  CC      arch/x86/kernel/irq_work.o
  CC      fs/super.o
  CC      kernel/evl/factory.o
  CC      arch/x86/kernel/probe_roms.o
  CC      mm/madvise.o
  CC      kernel/evl/file.o
  CC      arch/x86/kernel/sys_x86_64.o
  CC      fs/char_dev.o
  CC      kernel/evl/init.o
  CC      arch/x86/kernel/espfix_64.o
  CC      fs/stat.o
  CC      mm/page_io.o
  CC      kernel/evl/memory.o
  CC      arch/x86/kernel/ksysfs.o
  CC      fs/exec.o
  CC      kernel/evl/monitor.o
  CC      mm/swap_state.o
  CC      arch/x86/kernel/bootflag.o
  CC      arch/x86/kernel/e820.o
  CC      kernel/evl/mutex.o
  CC      fs/pipe.o
  CC      mm/swapfile.o
  CC      arch/x86/kernel/pci-dma.o
  CC      kernel/evl/observable.o
  CC      fs/namei.o
  CC      arch/x86/kernel/quirks.o
  CC      arch/x86/kernel/kdebugfs.o
  CC      kernel/evl/poll.o
  CC      mm/swap_slots.o
  CC      arch/x86/kernel/alternative.o
  CC      fs/fcntl.o
  CC      kernel/evl/proxy.o
  CC      mm/dmapool.o
  CC      mm/sparse.o
  CC      arch/x86/kernel/i8253.o
  CC      fs/ioctl.o
  CC      kernel/evl/random.o
  CC      arch/x86/kernel/hw_breakpoint.o
  CC      kernel/evl/sem.o
  CC      mm/sparse-vmemmap.o
  CC      fs/readdir.o
  CC      arch/x86/kernel/tsc.o
  CC      kernel/evl/stax.o
  CC      mm/migrate.o
  CC      fs/select.o
  CC      arch/x86/kernel/tsc_msr.o
  CC      kernel/evl/syscall.o
  CC      arch/x86/kernel/io_delay.o
  CC      mm/early_ioremap.o
  CC      arch/x86/kernel/rtc.o
  CC      mm/secretmem.o
  CC      kernel/evl/thread.o
  CC      arch/x86/kernel/resource.o
  CC      fs/dcache.o
  AS      arch/x86/kernel/irqflags.o
  CC      arch/x86/kernel/static_call.o
  CC      mm/execmem.o
  CC      arch/x86/kernel/process.o
  AR      mm/built-in.a
  CC      kernel/events/core.o
  CC      kernel/evl/tick.o
  CC      arch/x86/kernel/ptrace.o
  CC      fs/inode.o
  CC      arch/x86/kernel/step.o
  CC      kernel/evl/timer.o
  CC      arch/x86/kernel/i8237.o
  CC      arch/x86/kernel/stacktrace.o
  CC      kernel/evl/wait.o
  CC      fs/attr.o
  CC      arch/x86/kernel/reboot.o
  CC      kernel/evl/work.o
  CC      fs/bad_inode.o
  CC      fs/file.o
  CC      kernel/evl/xbuf.o
  CC      arch/x86/kernel/tsc_sync.o
  CC      arch/x86/kernel/mpparse.o
  CC      kernel/events/ring_buffer.o
  AR      kernel/evl/built-in.a
  CC      kernel/fork.o
  CC      fs/filesystems.o
  CC      arch/x86/kernel/trace_clock.o
  CC      arch/x86/kernel/early_printk.o
  CC      fs/namespace.o
  CC      arch/x86/kernel/hpet.o
  CC      kernel/events/callchain.o
  CC      arch/x86/kernel/irq_pipeline.o
  CC      kernel/events/hw_breakpoint.o
  CC      arch/x86/mm/pat/set_memory.o
  CC      arch/x86/kernel/pcspeaker.o
  AR      kernel/events/built-in.a
  CC      kernel/exec_domain.o
  CC      arch/x86/kernel/perf_regs.o
  CC      kernel/panic.o
  CC      arch/x86/kernel/umip.o
  CC      arch/x86/mm/pat/memtype.o
  CC      fs/seq_file.o
  CC      kernel/cpu.o
  CC      arch/x86/kernel/unwind_orc.o
  CC      arch/x86/mm/pat/memtype_interval.o
  CC      fs/xattr.o
  AR      arch/x86/mm/pat/built-in.a
  CC      arch/x86/mm/init.o
  CC      kernel/exit.o
  CC      arch/x86/kernel/callthunks.o
  CC      arch/x86/kernel/cet.o
  CC      arch/x86/mm/init_64.o
  CC      fs/libfs.o
  CC      arch/x86/kernel/vsmp_64.o
  CC      kernel/softirq.o
  AR      arch/x86/kernel/built-in.a
  AR      arch/x86/crypto/built-in.a
  CC      arch/x86/mm/fault.o
  AR      ipc/built-in.a
  CC      arch/x86/mm/ioremap.o
  CC      fs/fs-writeback.o
  CC      kernel/resource.o
  CC      kernel/sysctl.o
  CC      arch/x86/mm/extable.o
  CC      fs/pnode.o
  AR      arch/x86/platform/atom/built-in.a
  CC      arch/x86/mm/mmap.o
  AR      arch/x86/platform/ce4100/built-in.a
  AR      arch/x86/platform/efi/built-in.a
  AR      arch/x86/platform/geode/built-in.a
  AR      arch/x86/platform/iris/built-in.a
  AR      arch/x86/platform/intel/built-in.a
  AR      arch/x86/platform/intel-mid/built-in.a
  AR      arch/x86/platform/intel-quark/built-in.a
  AR      arch/x86/platform/olpc/built-in.a
  AR      arch/x86/platform/scx200/built-in.a
  AR      arch/x86/platform/ts5500/built-in.a
  AR      arch/x86/platform/uv/built-in.a
  AR      arch/x86/platform/built-in.a
  AR      arch/x86/net/built-in.a
  CC      arch/x86/mm/pgtable.o
  CC      fs/splice.o
  CC      arch/x86/mm/physaddr.o
  CC      kernel/capability.o
  CC      security/commoncap.o
  CC      arch/x86/mm/tlb.o
  CC      kernel/ptrace.o
  CC      fs/sync.o
  CC      arch/x86/mm/cpu_entry_area.o
  CC      security/min_addr.o
  CC      fs/utimes.o
  CC      arch/x86/mm/maccess.o
  CC      kernel/user.o
  AR      security/built-in.a
  AR      crypto/built-in.a
  CC      fs/d_path.o
  CC      arch/x86/mm/pgprot.o
  CC      kernel/signal.o
  AR      arch/x86/virt/svm/built-in.a
  AR      arch/x86/virt/vmx/built-in.a
  AR      arch/x86/virt/built-in.a
  CC      kernel/sys.o
  CC      arch/x86/mm/pkeys.o
  CC      fs/stack.o
  CC      arch/x86/mm/kaslr.o
  CC      fs/fs_struct.o
  CC      arch/x86/mm/pti.o
  CC      fs/statfs.o
  CC      kernel/umh.o
  AR      arch/x86/mm/built-in.a
  AR      arch/x86/built-in.a
  CC      block/partitions/core.o
  CC      kernel/workqueue.o
  CC      fs/fs_pin.o
  CC      block/bdev.o
  CC      fs/nsfs.o
  CC      block/partitions/msdos.o
  CC      block/fops.o
  CC      fs/fs_types.o
  CC      block/partitions/efi.o
  CC      fs/fs_context.o
  CC      block/bio.o
  AR      block/partitions/built-in.a
  CC      fs/fs_parser.o
  CC      io_uring/io_uring.o
  CC      kernel/pid.o
  CC      fs/fsopen.o
  CC      block/elevator.o
  CC      kernel/task_work.o
  CC      fs/init.o
  CC      block/blk-core.o
  CC      kernel/extable.o
  CC      fs/kernel_read_file.o
  CC      kernel/params.o
  CC      io_uring/opdef.o
  CC      fs/mnt_idmapping.o
  CC      block/blk-sysfs.o
  CC      fs/remap_range.o
  CC      io_uring/kbuf.o
  CC      kernel/kthread.o
  CC      block/blk-flush.o
  CC      fs/pidfs.o
  CC      io_uring/rsrc.o
  CC      kernel/sys_ni.o
  CC      block/blk-settings.o
  CC      kernel/nsproxy.o
  CC      fs/proc_namespace.o
  CC      io_uring/notif.o
  CC      block/blk-ioc.o
  CC      kernel/notifier.o
  CC      fs/eventpoll.o
  CC      io_uring/tctx.o
  CC      block/blk-map.o
  CC      kernel/ksysfs.o
  CC      io_uring/filetable.o
  CC      kernel/cred.o
  CC      block/blk-merge.o
  CC      io_uring/rw.o
  CC      fs/anon_inodes.o
  CC      kernel/reboot.o
  CC      fs/signalfd.o
  CC      block/blk-timeout.o
  CC      io_uring/net.o
  CC      kernel/async.o
  CC      block/blk-lib.o
  CC      fs/timerfd.o
  CC      kernel/range.o
  CC      kernel/smpboot.o
  CC      io_uring/poll.o
  CC      block/blk-mq.o
  CC      kernel/ucount.o
  CC      fs/eventfd.o
  CC      kernel/regset.o
  CC      io_uring/eventfd.o
  CC      kernel/ksyms_common.o
  CC      fs/aio.o
  CC      kernel/groups.o
  CC      io_uring/uring_cmd.o
  CC      kernel/freezer.o
  CC      fs/locks.o
  CC      io_uring/openclose.o
  CC      block/blk-mq-tag.o
  CC      kernel/stacktrace.o
  CC      io_uring/sqpoll.o
  CC      block/blk-stat.o
  CC      kernel/dma.o
  CC      fs/binfmt_script.o
  CC      kernel/up.o
  CC      block/blk-mq-sysfs.o
  CC      io_uring/xattr.o
  CC      kernel/kallsyms.o
  CC      fs/binfmt_elf.o
  CC      block/blk-mq-cpumap.o
  CC      io_uring/nop.o
  CC      kernel/utsname.o
  CC      block/blk-mq-sched.o
  CC      kernel/pid_namespace.o
  CC      fs/coredump.o
  CC      io_uring/fs.o
  CC      block/ioctl.o
  CC      io_uring/splice.o
  CC      kernel/seccomp.o
  CC      fs/drop_caches.o
  CC      io_uring/sync.o
  CC      block/genhd.o
  CC      kernel/utsname_sysctl.o
  CC      fs/sysctls.o
  CC      kernel/irq_work.o
  CC      fs/fhandle.o
  CC      io_uring/msg_ring.o
  CC      block/ioprio.o
  CC      kernel/dovetail.o
  CC      io_uring/advise.o
  AR      fs/built-in.a
  CC      lib/math/div64.o
  CC      lib/math/gcd.o
  CC      lib/math/lcm.o
  CC      lib/math/int_log.o
  CC      block/badblocks.o
  CC      kernel/static_call.o
  CC      lib/math/int_pow.o
  CC      lib/math/int_sqrt.o
  CC      lib/math/reciprocal_div.o
  AR      lib/math/built-in.a
  CC      lib/crypto/chacha.o
  CC      io_uring/epoll.o
  CC      lib/crypto/blake2s.o
  CC      kernel/static_call_inline.o
  CC      block/blk-rq-qos.o
  CC      lib/crypto/blake2s-generic.o
  CC      kernel/context_tracking.o
  CC      io_uring/statx.o
  CC      lib/crypto/blake2s-selftest.o
  CC      block/disk-events.o
  CC      lib/crypto/sha256.o
  CC      io_uring/timeout.o
  CC      kernel/iomem.o
  AR      lib/crypto/built-in.a
  CC      lib/argv_split.o
  CC      kernel/rseq.o
  CC      block/blk-ia-ranges.o
  CC      io_uring/fdinfo.o
  CC      lib/bug.o
  AR      kernel/built-in.a
  AS      arch/x86/lib/clear_page_64.o
  CC      arch/x86/lib/cmdline.o
  CC      lib/buildid.o
  AS      arch/x86/lib/cmpxchg16b_emu.o
  CC      block/early-lookup.o
  CC      arch/x86/lib/copy_mc.o
  CC      io_uring/cancel.o
  AS      arch/x86/lib/copy_mc_64.o
  AS      arch/x86/lib/copy_page_64.o
  CC      block/mq-deadline.o
  AS      arch/x86/lib/copy_user_64.o
  AS      arch/x86/lib/copy_user_uncached_64.o
  CC      arch/x86/lib/cpu.o
  CC      lib/cmdline.o
  AS      arch/x86/lib/csum-copy_64.o
  CC      arch/x86/lib/csum-partial_64.o
  CC      lib/ctype.o
  CC      lib/dec_and_lock.o
  CC      arch/x86/lib/csum-wrappers_64.o
  CC      io_uring/waitid.o
  CC      lib/decompress.o
  CC      arch/x86/lib/delay.o
  CC      lib/dump_stack.o
  AS      arch/x86/lib/getuser.o
  GEN     arch/x86/lib/inat-tables.c
  CC      block/kyber-iosched.o
  CC      io_uring/register.o
  CC      arch/x86/lib/insn-eval.o
  CC      lib/earlycpio.o
  CC      lib/extable.o
  CC      io_uring/truncate.o
  CC      lib/flex_proportions.o
  CC      block/blk-pm.o
  CC      arch/x86/lib/insn.o
  CC      lib/idr.o
  CC      io_uring/memmap.o
  AR      block/built-in.a
  AR      drivers/cache/built-in.a
  AR      drivers/irqchip/built-in.a
  AR      drivers/bus/mhi/built-in.a
  AR      drivers/bus/built-in.a
  AR      drivers/pwm/built-in.a
  CC      arch/x86/lib/kaslr.o
  AR      drivers/leds/blink/built-in.a
  AR      drivers/leds/simple/built-in.a
  AR      drivers/leds/built-in.a
  AR      drivers/pci/controller/dwc/built-in.a
  AR      drivers/pci/controller/mobiveil/built-in.a
  AR      drivers/pci/controller/plda/built-in.a
  AR      drivers/pci/controller/built-in.a
  AR      drivers/pci/switch/built-in.a
  AR      drivers/pci/built-in.a
  CC      drivers/video/console/dummycon.o
  AS      arch/x86/lib/memcpy_64.o
  AS      arch/x86/lib/memmove_64.o
  AS      arch/x86/lib/memset_64.o
  CC      lib/irq_regs.o
  CC      arch/x86/lib/misc.o
  CC      arch/x86/lib/pc-conf-reg.o
  CC      lib/is_single_threaded.o
  CC      io_uring/io-wq.o
  AS      arch/x86/lib/putuser.o
  AS      arch/x86/lib/retpoline.o
  CC      arch/x86/lib/usercopy.o
  CC      drivers/video/console/vgacon.o
  CC      lib/klist.o
  CC      arch/x86/lib/usercopy_64.o
  CC      lib/kobject.o
  CC      io_uring/futex.o
  CC      arch/x86/lib/msr.o
  AR      drivers/video/console/built-in.a
  AR      drivers/video/backlight/built-in.a
  AR      drivers/video/fbdev/core/built-in.a
  AR      drivers/video/fbdev/omap/built-in.a
  CC      lib/kobject_uevent.o
  AR      drivers/video/fbdev/omap2/omapfb/dss/built-in.a
  AR      drivers/video/fbdev/omap2/omapfb/displays/built-in.a
  AR      drivers/video/fbdev/omap2/omapfb/built-in.a
  AR      drivers/video/fbdev/omap2/built-in.a
  AR      drivers/video/fbdev/built-in.a
  AR      drivers/video/built-in.a
  AR      drivers/idle/built-in.a
  AR      drivers/char/ipmi/built-in.a
  CC      drivers/acpi/acpica/dsargs.o
  AS      arch/x86/lib/msr-reg.o
  CC      arch/x86/lib/msr-reg-export.o
  AS      arch/x86/lib/hweight.o
  AR      io_uring/built-in.a
  CC      arch/x86/lib/iomem.o
  CC      drivers/acpi/acpica/dscontrol.o
  CC      drivers/pnp/pnpacpi/core.o
  CC      arch/x86/lib/inat.o
  AR      arch/x86/lib/built-in.a
  AR      arch/x86/lib/lib.a
  CC      drivers/pnp/pnpacpi/rsparser.o
  CC      drivers/acpi/acpica/dsdebug.o
  CC      lib/logic_pio.o
  AR      drivers/amba/built-in.a
  AR      drivers/acpi/pmic/built-in.a
  CC      drivers/pnp/core.o
  CC      drivers/acpi/acpica/dsfield.o
  AR      sound/built-in.a
  AR      virt/lib/built-in.a
  AR      virt/built-in.a
  CC      lib/maple_tree.o
  AR      drivers/pnp/pnpacpi/built-in.a
  CC      drivers/pnp/card.o
  CC      drivers/acpi/acpica/dsinit.o
  CC      arch/x86/power/cpu.o
  CC      drivers/acpi/acpica/dsmethod.o
  CC      drivers/pnp/driver.o
  CC      drivers/acpi/acpica/dsmthdat.o
  AR      arch/x86/power/built-in.a
  AR      drivers/clk/actions/built-in.a
  AR      drivers/clk/analogbits/built-in.a
  AR      drivers/clk/bcm/built-in.a
  AR      drivers/clk/imgtec/built-in.a
  AR      drivers/clk/imx/built-in.a
  AR      drivers/clk/ingenic/built-in.a
  AR      drivers/clk/mediatek/built-in.a
  AR      drivers/clk/microchip/built-in.a
  AR      drivers/clk/mstar/built-in.a
  AR      drivers/clk/mvebu/built-in.a
  AR      drivers/clk/ralink/built-in.a
  AR      drivers/clk/renesas/built-in.a
  AR      drivers/clk/socfpga/built-in.a
  AR      drivers/clk/sophgo/built-in.a
  AR      drivers/clk/sprd/built-in.a
  AR      drivers/clk/starfive/built-in.a
  AR      drivers/clk/sunxi-ng/built-in.a
  AR      drivers/clk/ti/built-in.a
  AR      drivers/clk/versatile/built-in.a
  AR      drivers/clk/xilinx/built-in.a
  AR      drivers/clk/built-in.a
  CC      drivers/acpi/dptf/int340x_thermal.o
  CC      drivers/acpi/acpica/dsobject.o
  CC      drivers/pnp/resource.o
  AR      drivers/acpi/dptf/built-in.a
  CC      drivers/acpi/x86/apple.o
  CC      drivers/acpi/acpica/dsopcode.o
  CC      drivers/acpi/acpica/dspkginit.o
  CC      drivers/acpi/x86/cmos_rtc.o
  CC      drivers/pnp/manager.o
  CC      drivers/pnp/support.o
  CC      drivers/acpi/acpica/dsutils.o
  CC      drivers/acpi/x86/s2idle.o
  CC      drivers/acpi/acpica/dswexec.o
  CC      drivers/pnp/interface.o
  CC      drivers/acpi/acpica/dswload.o
  CC      drivers/acpi/x86/utils.o
  CC      drivers/pnp/quirks.o
  CC      lib/memcat_p.o
  CC      drivers/acpi/acpica/dswload2.o
  CC      lib/nmi_backtrace.o
  CC      drivers/acpi/x86/blacklist.o
  CC      drivers/pnp/system.o
  CC      drivers/acpi/acpica/dswscope.o
  AR      drivers/acpi/x86/built-in.a
  CC      drivers/acpi/tables.o
  CC      drivers/acpi/acpica/dswstate.o
  AR      drivers/pnp/built-in.a
  CC      lib/objpool.o
  AR      drivers/soc/apple/built-in.a
  AR      drivers/soc/aspeed/built-in.a
  AR      drivers/soc/bcm/built-in.a
  AR      drivers/soc/fsl/built-in.a
  AR      drivers/soc/fujitsu/built-in.a
  AR      drivers/soc/hisilicon/built-in.a
  AR      drivers/soc/imx/built-in.a
  AR      drivers/soc/ixp4xx/built-in.a
  AR      drivers/soc/loongson/built-in.a
  AR      drivers/soc/mediatek/built-in.a
  AR      drivers/soc/microchip/built-in.a
  AR      drivers/soc/nuvoton/built-in.a
  AR      drivers/soc/pxa/built-in.a
  AR      drivers/soc/amlogic/built-in.a
  AR      drivers/soc/qcom/built-in.a
  AR      drivers/soc/renesas/built-in.a
  AR      drivers/soc/rockchip/built-in.a
  AR      drivers/soc/sunxi/built-in.a
  AR      drivers/soc/ti/built-in.a
  AR      drivers/soc/versatile/built-in.a
  AR      drivers/soc/xilinx/built-in.a
  AR      drivers/soc/built-in.a
  CC      drivers/acpi/acpica/evevent.o
  AR      drivers/virtio/built-in.a
  CC      drivers/tty/vt/vt_ioctl.o
  CC      lib/plist.o
  CC      lib/radix-tree.o
  CC      drivers/acpi/acpica/evgpe.o
  CC      drivers/acpi/acpica/evgpeblk.o
  CC      drivers/tty/vt/vc_screen.o
  CC      drivers/char/hw_random/core.o
  CC      drivers/acpi/acpica/evgpeinit.o
  CC      lib/ratelimit.o
  CC      drivers/tty/vt/selection.o
  CC      drivers/char/hw_random/via-rng.o
  CC      drivers/acpi/acpica/evgpeutil.o
  CC      lib/rbtree.o
  CC      drivers/acpi/acpica/evglock.o
  AR      drivers/char/hw_random/built-in.a
  AR      drivers/char/agp/built-in.a
  CC      drivers/char/mem.o
  CC      drivers/tty/vt/keyboard.o
  CC      lib/seq_buf.o
  CC      drivers/acpi/acpica/evhandler.o
  CC      drivers/char/random.o
  CC      drivers/acpi/acpica/evmisc.o
  CC      lib/siphash.o
  CC      drivers/acpi/acpica/evregion.o
  CC      lib/string.o
  CC      drivers/acpi/acpica/evrgnini.o
  CC      drivers/char/misc.o
  CC      drivers/tty/vt/vt.o
  CC      lib/timerqueue.o
  CC      drivers/acpi/acpica/evsci.o
  CC      lib/union_find.o
  CC      lib/vsprintf.o
  CC      drivers/acpi/acpica/evxface.o
  AR      drivers/char/built-in.a
  AR      drivers/iommu/amd/built-in.a
  AR      drivers/iommu/intel/built-in.a
  AR      drivers/iommu/arm/arm-smmu/built-in.a
  AR      drivers/iommu/arm/arm-smmu-v3/built-in.a
  AR      drivers/iommu/arm/built-in.a
  AR      drivers/iommu/iommufd/built-in.a
  CC      drivers/iommu/iommu.o
  CC      drivers/acpi/acpica/evxfevnt.o
  CC      drivers/acpi/acpica/evxfgpe.o
  CC      drivers/acpi/acpica/evxfregn.o
  CC      drivers/acpi/acpica/exconcat.o
  COPY    drivers/tty/vt/defkeymap.c
  CC      drivers/tty/vt/consolemap.o
  CC      drivers/iommu/iommu-traces.o
  CC      drivers/acpi/acpica/exconfig.o
  CC      lib/win_minmax.o
  CC      drivers/iommu/iommu-sysfs.o
  CC      drivers/acpi/acpica/exconvrt.o
  HOSTCC  drivers/tty/vt/conmakehash
  CC      lib/xarray.o
  CC      drivers/tty/vt/defkeymap.o
  CONMK   drivers/tty/vt/consolemap_deftbl.c
  CC      drivers/tty/vt/consolemap_deftbl.o
  CC      drivers/acpi/acpica/excreate.o
  AR      drivers/tty/vt/built-in.a
  AR      drivers/tty/serial/8250/built-in.a
  AR      drivers/tty/serial/built-in.a
  CC      drivers/iommu/dma-iommu.o
  AR      drivers/tty/ipwireless/built-in.a
  CC      drivers/tty/tty_io.o
  CC      drivers/acpi/acpica/exdebug.o
  CC      drivers/acpi/acpica/exdump.o
  CC      lib/lockref.o
  CC      lib/bcd.o
  CC      drivers/acpi/acpica/exfield.o
  CC      lib/sort.o
  CC      lib/parser.o
  CC      drivers/iommu/iova.o
  CC      drivers/acpi/acpica/exfldio.o
  CC      lib/debug_locks.o
  CC      lib/random32.o
  CC      drivers/tty/n_tty.o
  CC      drivers/acpi/acpica/exmisc.o
  CC      lib/bust_spinlocks.o
  CC      drivers/acpi/acpica/exmutex.o
  AR      drivers/iommu/built-in.a
  AR      drivers/gpu/host1x/built-in.a
  AR      drivers/gpu/drm/tests/built-in.a
  AR      drivers/gpu/drm/arm/built-in.a
  AR      drivers/gpu/drm/display/built-in.a
  AR      drivers/gpu/drm/renesas/rcar-du/built-in.a
  AR      drivers/gpu/drm/renesas/rz-du/built-in.a
  AR      drivers/gpu/drm/renesas/built-in.a
  AR      drivers/gpu/drm/omapdrm/built-in.a
  AR      drivers/gpu/drm/tilcdc/built-in.a
  AR      drivers/gpu/drm/imx/built-in.a
  AR      drivers/gpu/drm/i2c/built-in.a
  AR      drivers/gpu/drm/panel/built-in.a
  AR      drivers/gpu/drm/bridge/analogix/built-in.a
  AR      drivers/gpu/drm/bridge/cadence/built-in.a
  AR      drivers/gpu/drm/bridge/imx/built-in.a
  AR      drivers/gpu/drm/bridge/synopsys/built-in.a
  AR      drivers/gpu/drm/bridge/built-in.a
  CC      drivers/acpi/acpica/exnames.o
  AR      drivers/gpu/drm/hisilicon/built-in.a
  AR      drivers/gpu/drm/mxsfb/built-in.a
  AR      drivers/gpu/drm/tiny/built-in.a
  AR      drivers/gpu/drm/xlnx/built-in.a
  AR      drivers/gpu/drm/gud/built-in.a
  AR      drivers/gpu/drm/solomon/built-in.a
  AR      drivers/gpu/drm/built-in.a
  AR      drivers/gpu/vga/built-in.a
  AR      drivers/gpu/built-in.a
  CC      lib/kasprintf.o
  CC      drivers/acpi/osi.o
  CC      drivers/acpi/acpica/exoparg1.o
  CC      lib/bitmap.o
  CC      drivers/tty/tty_ioctl.o
  CC      drivers/acpi/osl.o
  CC      drivers/acpi/acpica/exoparg2.o
  CC      lib/scatterlist.o
  CC      drivers/acpi/acpica/exoparg3.o
  CC      drivers/tty/tty_ldisc.o
  CC      lib/list_sort.o
  CC      drivers/acpi/acpica/exoparg6.o
  CC      drivers/base/power/sysfs.o
  CC      drivers/tty/tty_buffer.o
  CC      drivers/acpi/acpica/exprep.o
  CC      lib/uuid.o
  CC      drivers/base/power/generic_ops.o
  CC      lib/iov_iter.o
  CC      drivers/acpi/acpica/exregion.o
  CC      drivers/base/power/common.o
  CC      drivers/acpi/acpica/exresnte.o
  CC      drivers/tty/tty_port.o
  CC      drivers/acpi/acpica/exresolv.o
  CC      drivers/base/power/qos.o
  CC      drivers/acpi/acpica/exresop.o
  CC      drivers/tty/tty_mutex.o
  CC      drivers/acpi/acpica/exserial.o
  CC      drivers/base/power/runtime.o
  CC      drivers/tty/tty_ldsem.o
  CC      lib/clz_ctz.o
  CC      drivers/acpi/acpica/exstore.o
  CC      lib/bsearch.o
  CC      drivers/acpi/acpica/exstoren.o
  CC      drivers/tty/tty_baudrate.o
  CC      lib/find_bit.o
  CC      drivers/acpi/acpica/exstorob.o
  CC      drivers/base/power/wakeirq.o
  CC      lib/llist.o
  CC      drivers/tty/tty_jobctrl.o
  CC      drivers/acpi/acpica/exsystem.o
  CC      lib/lwq.o
  CC      lib/memweight.o
  CC      drivers/acpi/acpica/extrace.o
  CC      drivers/base/power/main.o
  CC      lib/kfifo.o
  CC      drivers/acpi/acpica/exutils.o
  CC      drivers/tty/n_null.o
  CC      drivers/acpi/acpica/hwacpi.o
  CC      drivers/tty/pty.o
  CC      lib/percpu-refcount.o
  CC      drivers/acpi/acpica/hwesleep.o
  CC      drivers/base/power/wakeup.o
  CC      drivers/acpi/acpica/hwgpe.o
  CC      lib/rhashtable.o
  AR      drivers/tty/built-in.a
  AR      drivers/block/built-in.a
  AR      drivers/misc/eeprom/built-in.a
  AR      drivers/misc/cb710/built-in.a
  AR      drivers/misc/ti-st/built-in.a
  AR      drivers/misc/lis3lv02d/built-in.a
  AR      drivers/misc/cardreader/built-in.a
  AR      drivers/misc/keba/built-in.a
  AR      drivers/misc/built-in.a
  AR      drivers/mfd/built-in.a
  CC      drivers/acpi/utils.o
  CC      drivers/acpi/acpica/hwregs.o
  CC      drivers/acpi/acpica/hwsleep.o
  CC      drivers/base/power/wakeup_stats.o
  CC      drivers/acpi/reboot.o
  CC      lib/base64.o
  CC      lib/once.o
  CC      drivers/acpi/acpica/hwvalid.o
  AR      drivers/base/power/built-in.a
  CC      drivers/base/firmware_loader/builtin/main.o
  CC      drivers/acpi/acpica/hwxface.o
  AR      drivers/base/test/built-in.a
  AR      drivers/nfc/built-in.a
  CC      drivers/acpi/nvs.o
  CC      lib/refcount.o
  AR      drivers/base/firmware_loader/builtin/built-in.a
  CC      drivers/base/firmware_loader/main.o
  CC      lib/rcuref.o
  CC      drivers/acpi/acpica/hwxfsleep.o
  CC      lib/usercopy.o
  CC      drivers/acpi/wakeup.o
  CC      drivers/acpi/acpica/nsaccess.o
  CC      lib/errseq.o
  CC      lib/bucket_locks.o
  CC      drivers/acpi/acpica/nsalloc.o
  AR      drivers/base/firmware_loader/built-in.a
  CC      drivers/base/component.o
  CC      drivers/acpi/sleep.o
  CC      lib/generic-radix-tree.o
  CC      drivers/acpi/acpica/nsarguments.o
  CC      lib/bitmap-str.o
  CC      drivers/acpi/acpica/nsconvert.o
  CC      drivers/base/core.o
  CC      drivers/base/bus.o
  CC      drivers/acpi/acpica/nsdump.o
  CC      drivers/acpi/acpica/nseval.o
  CC      lib/string_helpers.o
  CC      drivers/base/dd.o
  CC      drivers/acpi/acpica/nsinit.o
  CC      drivers/acpi/acpica/nsload.o
  CC      lib/hexdump.o
  CC      drivers/acpi/acpica/nsnames.o
  CC      lib/kstrtox.o
  CC      drivers/base/syscore.o
  CC      drivers/acpi/acpica/nsobject.o
  CC      lib/iomap.o
  CC      lib/iomap_copy.o
  AR      drivers/dax/hmem/built-in.a
  AR      drivers/dax/built-in.a
  CC      drivers/acpi/device_sysfs.o
  CC      drivers/acpi/acpica/nsparse.o
  CC      drivers/base/driver.o
  CC      drivers/acpi/acpica/nspredef.o
  AR      drivers/cxl/core/built-in.a
  AR      drivers/cxl/built-in.a
  CC      drivers/base/class.o
  CC      lib/devres.o
  CC      drivers/acpi/device_pm.o
  CC      drivers/acpi/acpica/nsprepkg.o
  CC      lib/bitrev.o
  CC      drivers/base/platform.o
  CC      drivers/acpi/acpica/nsrepair.o
  HOSTCC  lib/gen_crc32table
  CC      lib/genalloc.o
  AR      drivers/macintosh/built-in.a
  CC      drivers/base/cpu.o
  CC      drivers/acpi/acpica/nsrepair2.o
  CC      drivers/acpi/acpica/nssearch.o
  CC      lib/syscall.o
  CC      drivers/base/firmware.o
  CC      drivers/acpi/proc.o
  CC      drivers/acpi/acpica/nsutils.o
  CC      drivers/base/init.o
  CC      lib/errname.o
  CC      lib/strncpy_from_user.o
  CC      drivers/acpi/acpica/nswalk.o
  CC      drivers/acpi/bus.o
  CC      drivers/acpi/acpica/nsxfeval.o
  CC      drivers/base/map.o
  CC      lib/strnlen_user.o
  CC      drivers/acpi/acpica/nsxfname.o
  CC      drivers/base/devres.o
  CC      lib/stackdepot.o
  CC      drivers/acpi/glue.o
  CC      drivers/acpi/acpica/nsxfobj.o
  CC      drivers/base/attribute_container.o
  CC      drivers/acpi/acpica/psargs.o
  CC      drivers/acpi/scan.o
  CC      lib/sbitmap.o
  CC      drivers/base/transport_class.o
  CC      drivers/acpi/acpica/psloop.o
  CC      drivers/base/topology.o
  CC      drivers/acpi/acpica/psobject.o
  CC      lib/group_cpus.o
  CC      drivers/acpi/acpica/psopcode.o
  CC      drivers/base/container.o
  CC      lib/fw_table.o
  CC      drivers/acpi/mipi-disco-img.o
  CC      drivers/acpi/acpica/psopinfo.o
  CC      drivers/base/property.o
  AR      lib/lib.a
  GEN     lib/crc32table.h
  CC      lib/crc32.o
  CC      drivers/acpi/acpica/psparse.o
  CC      drivers/acpi/resource.o
  CC      drivers/acpi/acpica/psscope.o
  AR      lib/built-in.a
  AR      drivers/scsi/built-in.a
  CC      drivers/acpi/acpica/pstree.o
  CC      drivers/acpi/acpica/psutils.o
  CC      drivers/acpi/acpica/pswalk.o
  CC      drivers/base/cacheinfo.o
  CC      drivers/base/swnode.o
  CC      drivers/acpi/acpica/psxface.o
  AR      drivers/nvme/common/built-in.a
  AR      drivers/nvme/host/built-in.a
  AR      drivers/nvme/target/built-in.a
  AR      drivers/nvme/built-in.a
  CC      drivers/acpi/acpi_processor.o
  CC      drivers/acpi/acpica/rsaddr.o
  CC      drivers/base/devtmpfs.o
  CC      drivers/acpi/acpica/rscalc.o
  CC      drivers/acpi/acpica/rscreate.o
  CC      drivers/acpi/processor_core.o
  CC      drivers/acpi/acpica/rsdumpinfo.o
  AR      drivers/net/phy/qcom/built-in.a
  AR      drivers/net/phy/built-in.a
  AR      drivers/net/pse-pd/built-in.a
  CC      drivers/base/physical_location.o
  AR      drivers/net/mdio/built-in.a
  AR      drivers/net/pcs/built-in.a
  AR      drivers/net/built-in.a
  AR      drivers/firewire/built-in.a
  CC      drivers/acpi/acpica/rsinfo.o
  CC      drivers/acpi/acpica/rsio.o
  AR      drivers/cdrom/built-in.a
  CC      drivers/acpi/processor_pdc.o
  AR      drivers/auxdisplay/built-in.a
  AR      drivers/usb/phy/built-in.a
  AR      drivers/usb/built-in.a
  CC      drivers/acpi/ec.o
  AR      drivers/base/built-in.a
  CC      drivers/acpi/acpica/rsirq.o
  CC      drivers/acpi/acpi_apd.o
  CC      drivers/acpi/acpica/rslist.o
  CC      drivers/acpi/acpica/rsmemory.o
  CC      drivers/input/serio/serio.o
  CC      drivers/acpi/acpica/rsmisc.o
  CC      drivers/acpi/acpica/rsserial.o
  CC      drivers/input/keyboard/atkbd.o
  CC      drivers/acpi/acpica/rsutils.o
  CC      drivers/rtc/lib.o
  CC      drivers/input/serio/i8042.o
  CC      drivers/acpi/acpica/rsxface.o
  CC      drivers/rtc/rtc-mc146818-lib.o
  CC      drivers/acpi/acpica/tbdata.o
  AR      drivers/input/keyboard/built-in.a
  CC      drivers/input/mouse/psmouse-base.o
  AR      drivers/rtc/built-in.a
  CC      drivers/input/serio/serport.o
  CC      drivers/acpi/acpica/tbfadt.o
  CC      drivers/input/input.o
  CC      drivers/acpi/acpica/tbfind.o
  CC      drivers/input/serio/libps2.o
  CC      drivers/input/mouse/synaptics.o
  CC      drivers/acpi/acpica/tbinstal.o
  CC      drivers/acpi/acpica/tbprint.o
  AR      drivers/input/serio/built-in.a
  AR      drivers/i2c/algos/built-in.a
  AR      drivers/i2c/busses/built-in.a
  AR      drivers/i2c/muxes/built-in.a
  AR      drivers/i2c/built-in.a
  CC      drivers/acpi/acpi_platform.o
  CC      drivers/acpi/acpica/tbutils.o
  CC      drivers/input/input-compat.o
  CC      drivers/acpi/acpica/tbxface.o
  CC      drivers/input/mouse/focaltech.o
  AR      drivers/i3c/built-in.a
  CC      drivers/input/input-mt.o
  CC      drivers/acpi/acpica/tbxfload.o
  CC      drivers/acpi/acpica/tbxfroot.o
  CC      drivers/input/mouse/alps.o
  AR      drivers/media/i2c/built-in.a
  AR      drivers/media/tuners/built-in.a
  AR      drivers/media/rc/keymaps/built-in.a
  AR      drivers/media/rc/built-in.a
  CC      drivers/acpi/acpi_pnp.o
  AR      drivers/media/common/b2c2/built-in.a
  CC      drivers/acpi/acpica/utaddress.o
  AR      drivers/media/common/saa7146/built-in.a
  AR      drivers/media/common/siano/built-in.a
  AR      drivers/media/common/v4l2-tpg/built-in.a
  AR      drivers/media/common/videobuf2/built-in.a
  AR      drivers/media/common/built-in.a
  AR      drivers/media/platform/allegro-dvt/built-in.a
  AR      drivers/media/platform/amlogic/meson-ge2d/built-in.a
  AR      drivers/media/platform/amlogic/built-in.a
  AR      drivers/media/platform/amphion/built-in.a
  AR      drivers/media/platform/aspeed/built-in.a
  AR      drivers/media/platform/atmel/built-in.a
  AR      drivers/media/platform/broadcom/built-in.a
  AR      drivers/media/platform/cadence/built-in.a
  AR      drivers/media/platform/chips-media/coda/built-in.a
  AR      drivers/media/platform/chips-media/wave5/built-in.a
  AR      drivers/media/platform/chips-media/built-in.a
  AR      drivers/media/platform/imagination/built-in.a
  AR      drivers/media/platform/intel/built-in.a
  AR      drivers/media/platform/marvell/built-in.a
  AR      drivers/media/platform/mediatek/jpeg/built-in.a
  AR      drivers/media/platform/mediatek/mdp/built-in.a
  AR      drivers/media/platform/mediatek/vcodec/common/built-in.a
  AR      drivers/media/platform/mediatek/vcodec/encoder/built-in.a
  AR      drivers/media/platform/mediatek/vcodec/decoder/built-in.a
  AR      drivers/media/platform/mediatek/vcodec/built-in.a
  CC      drivers/input/mouse/byd.o
  CC      drivers/acpi/acpica/utalloc.o
  AR      drivers/media/platform/mediatek/vpu/built-in.a
  AR      drivers/media/platform/mediatek/mdp3/built-in.a
  AR      drivers/media/platform/mediatek/built-in.a
  AR      drivers/media/platform/microchip/built-in.a
  AR      drivers/media/platform/nuvoton/built-in.a
  AR      drivers/media/platform/nvidia/tegra-vde/built-in.a
  AR      drivers/media/platform/nvidia/built-in.a
  AR      drivers/media/platform/nxp/dw100/built-in.a
  AR      drivers/media/platform/nxp/imx-jpeg/built-in.a
  AR      drivers/media/platform/nxp/imx8-isi/built-in.a
  AR      drivers/media/platform/nxp/built-in.a
  AR      drivers/media/platform/qcom/camss/built-in.a
  AR      drivers/media/platform/qcom/venus/built-in.a
  AR      drivers/media/platform/qcom/built-in.a
  AR      drivers/media/platform/raspberrypi/pisp_be/built-in.a
  AR      drivers/media/platform/raspberrypi/built-in.a
  AR      drivers/media/platform/renesas/rcar-vin/built-in.a
  AR      drivers/media/platform/renesas/rzg2l-cru/built-in.a
  AR      drivers/media/platform/renesas/vsp1/built-in.a
  AR      drivers/media/platform/renesas/built-in.a
  AR      drivers/media/platform/rockchip/rga/built-in.a
  AR      drivers/media/platform/rockchip/rkisp1/built-in.a
  AR      drivers/media/platform/rockchip/built-in.a
  AR      drivers/media/platform/samsung/exynos-gsc/built-in.a
  AR      drivers/media/platform/samsung/exynos4-is/built-in.a
  AR      drivers/media/platform/samsung/s3c-camif/built-in.a
  AR      drivers/media/platform/samsung/s5p-g2d/built-in.a
  AR      drivers/media/platform/samsung/s5p-jpeg/built-in.a
  CC      drivers/acpi/acpica/utascii.o
  AR      drivers/media/platform/samsung/s5p-mfc/built-in.a
  AR      drivers/media/platform/samsung/built-in.a
  AR      drivers/media/platform/st/sti/bdisp/built-in.a
  AR      drivers/media/platform/st/sti/c8sectpfe/built-in.a
  AR      drivers/media/platform/st/sti/delta/built-in.a
  AR      drivers/media/platform/st/sti/hva/built-in.a
  AR      drivers/media/platform/st/stm32/built-in.a
  AR      drivers/media/platform/st/built-in.a
  AR      drivers/media/platform/sunxi/sun4i-csi/built-in.a
  AR      drivers/media/platform/sunxi/sun6i-csi/built-in.a
  AR      drivers/media/platform/sunxi/sun6i-mipi-csi2/built-in.a
  AR      drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/built-in.a
  AR      drivers/media/platform/sunxi/sun8i-di/built-in.a
  AR      drivers/media/platform/sunxi/sun8i-rotate/built-in.a
  AR      drivers/media/platform/sunxi/built-in.a
  AR      drivers/media/platform/ti/am437x/built-in.a
  AR      drivers/media/platform/ti/cal/built-in.a
  AR      drivers/media/platform/ti/vpe/built-in.a
  AR      drivers/media/platform/ti/davinci/built-in.a
  AR      drivers/ptp/built-in.a
  AR      drivers/media/platform/ti/j721e-csi2rx/built-in.a
  AR      drivers/media/pci/ttpci/built-in.a
  AR      drivers/media/platform/ti/omap/built-in.a
  AR      drivers/media/pci/b2c2/built-in.a
  AR      drivers/media/platform/ti/omap3isp/built-in.a
  AR      drivers/media/platform/ti/built-in.a
  AR      drivers/media/pci/pluto2/built-in.a
  AR      drivers/media/pci/dm1105/built-in.a
  AR      drivers/media/platform/verisilicon/built-in.a
  AR      drivers/media/pci/pt1/built-in.a
  AR      drivers/media/platform/via/built-in.a
  AR      drivers/media/pci/pt3/built-in.a
  AR      drivers/media/platform/xilinx/built-in.a
  AR      drivers/media/platform/built-in.a
  AR      drivers/media/pci/mantis/built-in.a
  CC      drivers/input/input-poller.o
  AR      drivers/media/pci/ngene/built-in.a
  AR      drivers/media/pci/ddbridge/built-in.a
  AR      drivers/media/pci/saa7146/built-in.a
  AR      drivers/media/pci/smipcie/built-in.a
  AR      drivers/media/pci/netup_unidvb/built-in.a
  AR      drivers/media/pci/intel/ipu3/built-in.a
  CC      drivers/acpi/acpica/utbuffer.o
  AR      drivers/media/pci/intel/ivsc/built-in.a
  AR      drivers/media/pci/intel/built-in.a
  AR      drivers/media/pci/built-in.a
  AR      drivers/media/usb/b2c2/built-in.a
  AR      drivers/media/usb/dvb-usb/built-in.a
  AR      drivers/media/usb/dvb-usb-v2/built-in.a
  AR      drivers/media/usb/s2255/built-in.a
  CC      drivers/input/mouse/logips2pp.o
  AR      drivers/media/usb/siano/built-in.a
  AR      drivers/media/usb/ttusb-budget/built-in.a
  AR      drivers/media/usb/ttusb-dec/built-in.a
  AR      drivers/media/usb/built-in.a
  AR      drivers/media/mmc/siano/built-in.a
  AR      drivers/media/mmc/built-in.a
  AR      drivers/media/firewire/built-in.a
  AR      drivers/media/spi/built-in.a
  AR      drivers/media/test-drivers/built-in.a
  AR      drivers/media/built-in.a
  CC      drivers/acpi/power.o
  CC      drivers/acpi/acpica/utcksum.o
  CC      drivers/input/mouse/lifebook.o
  CC      drivers/power/supply/power_supply_core.o
  CC      drivers/acpi/acpica/utcopy.o
  CC      drivers/input/ff-core.o
  CC      drivers/input/mouse/trackpoint.o
  CC      drivers/acpi/acpica/utexcep.o
  CC      drivers/power/supply/power_supply_sysfs.o
  CC      drivers/acpi/acpica/utdebug.o
  CC      drivers/power/supply/power_supply_hwmon.o
  CC      drivers/input/mouse/cypress_ps2.o
  CC      drivers/acpi/acpica/utdecode.o
  CC      drivers/hwmon/hwmon.o
  AR      drivers/power/supply/built-in.a
  AR      drivers/power/built-in.a
  CC      drivers/acpi/acpica/utdelete.o
  CC      drivers/input/touchscreen.o
  AR      drivers/input/mouse/built-in.a
  CC      drivers/acpi/event.o
  CC      drivers/acpi/acpica/uterror.o
  CC      drivers/input/ff-memless.o
  CC      drivers/acpi/acpica/uteval.o
  AR      drivers/hwmon/built-in.a
  AR      drivers/thermal/broadcom/built-in.a
  AR      drivers/thermal/renesas/built-in.a
  AR      drivers/thermal/samsung/built-in.a
  CC      drivers/thermal/intel/intel_tcc.o
  CC      drivers/acpi/acpica/utglobal.o
  AR      drivers/thermal/st/built-in.a
  CC      drivers/thermal/intel/x86_pkg_temp_thermal.o
  CC      drivers/input/vivaldi-fmap.o
  CC      drivers/thermal/intel/therm_throt.o
  CC      drivers/acpi/acpica/uthex.o
  AR      drivers/input/built-in.a
  CC      drivers/cpuidle/governors/ladder.o
  CC      drivers/acpi/acpica/utids.o
  AR      drivers/thermal/qcom/built-in.a
  CC      drivers/acpi/evged.o
  AR      drivers/cpuidle/governors/built-in.a
  CC      drivers/cpuidle/cpuidle.o
  CC      drivers/acpi/acpica/utinit.o
  CC      drivers/acpi/sysfs.o
  AR      drivers/thermal/intel/built-in.a
  AR      drivers/thermal/tegra/built-in.a
  AR      drivers/thermal/mediatek/built-in.a
  CC      drivers/thermal/thermal_core.o
  CC      drivers/acpi/acpica/utlock.o
  CC      drivers/acpi/property.o
  CC      drivers/acpi/acpica/utmath.o
  CC      drivers/cpuidle/driver.o
  CC      drivers/acpi/acpica/utmisc.o
  CC      drivers/thermal/thermal_sysfs.o
  CC      drivers/cpuidle/governor.o
  CC      drivers/acpi/acpica/utmutex.o
  CC      drivers/acpi/acpi_lpat.o
  CC      drivers/acpi/acpica/utnonansi.o
  CC      drivers/cpuidle/sysfs.o
  CC      drivers/thermal/thermal_trip.o
  CC      drivers/acpi/acpi_lpit.o
  CC      drivers/acpi/acpica/utobject.o
  CC      drivers/thermal/thermal_helpers.o
  CC      drivers/cpuidle/poll_state.o
  CC      drivers/acpi/ac.o
  CC      drivers/acpi/acpica/utosi.o
  AR      drivers/cpuidle/built-in.a
  AR      drivers/mmc/built-in.a
  AR      drivers/ufs/built-in.a
  AR      drivers/firmware/arm_ffa/built-in.a
  AR      drivers/firmware/arm_scmi/built-in.a
  AR      drivers/firmware/broadcom/built-in.a
  AR      drivers/firmware/cirrus/built-in.a
  AR      drivers/firmware/meson/built-in.a
  AR      drivers/firmware/microchip/built-in.a
  AR      drivers/firmware/efi/built-in.a
  AR      drivers/firmware/imx/built-in.a
  AR      drivers/firmware/psci/built-in.a
  CC      drivers/thermal/thermal_hwmon.o
  AR      drivers/firmware/qcom/built-in.a
  AR      drivers/firmware/smccc/built-in.a
  AR      drivers/firmware/tegra/built-in.a
  AR      drivers/firmware/xilinx/built-in.a
  CC      drivers/firmware/dmi_scan.o
  CC      drivers/acpi/acpica/utownerid.o
  CC      drivers/acpi/acpica/utpredef.o
  CC      drivers/thermal/gov_step_wise.o
  CC      drivers/firmware/dmi-id.o
  CC      drivers/acpi/acpica/utresdecode.o
  CC      drivers/acpi/acpica/utresrc.o
  CC      drivers/firmware/memmap.o
  CC      drivers/thermal/gov_user_space.o
  CC      drivers/clocksource/acpi_pm.o
  CC      drivers/acpi/acpica/utstate.o
  AR      drivers/thermal/built-in.a
  CC      drivers/clocksource/i8253.o
  AR      drivers/firmware/built-in.a
  CC      drivers/acpi/acpica/utstring.o
  CC      drivers/acpi/button.o
  CC      drivers/acpi/acpica/utstrsuppt.o
  AR      drivers/clocksource/built-in.a
  CC      drivers/acpi/fan_core.o
  CC      drivers/acpi/acpica/utstrtoul64.o
  CC      drivers/hid/hid-core.o
  CC      drivers/acpi/acpica/utxface.o
  CC      drivers/acpi/fan_attr.o
  AR      drivers/platform/x86/amd/built-in.a
  AR      drivers/platform/x86/intel/built-in.a
  AR      drivers/platform/x86/built-in.a
  AR      drivers/platform/surface/built-in.a
  AR      drivers/platform/built-in.a
  CC      drivers/acpi/acpica/utxfinit.o
  CC      drivers/evl/latmus.o
  CC      drivers/acpi/fan_hwmon.o
  CC      drivers/acpi/acpica/utxferror.o
  CC      drivers/hid/hid-input.o
  CC      drivers/acpi/acpica/utxfmutex.o
  CC      drivers/evl/hectic.o
  AR      drivers/perf/built-in.a
  AR      drivers/hwtracing/intel_th/built-in.a
  AR      drivers/android/built-in.a
  CC      drivers/acpi/processor_driver.o
  AR      drivers/acpi/acpica/built-in.a
  CC      drivers/hid/hid-quirks.o
  CC      drivers/acpi/processor_thermal.o
  CC      drivers/hid/hid-generic.o
  CC      drivers/acpi/processor_idle.o
  AR      drivers/evl/built-in.a
  CC      drivers/acpi/processor_throttling.o
  CC      drivers/hid/hid-a4tech.o
  CC      drivers/acpi/container.o
  CC      drivers/acpi/thermal_lib.o
  CC      drivers/acpi/thermal.o
  CC      drivers/hid/hid-belkin.o
  CC      drivers/acpi/acpi_memhotplug.o
  CC      drivers/hid/hid-cherry.o
  CC      drivers/acpi/battery.o
  CC      drivers/hid/hid-cypress.o
  CC      drivers/acpi/spcr.o
  CC      drivers/hid/hid-ezkey.o
  CC      drivers/hid/hid-ite.o
  CC      drivers/hid/hid-kensington.o
  AR      drivers/acpi/built-in.a
  CC      drivers/hid/hid-microsoft.o
  CC      drivers/hid/hid-monterey.o
  CC      drivers/hid/hid-redragon.o
  AR      drivers/hid/built-in.a
  AR      drivers/built-in.a
  AR      built-in.a
  AR      vmlinux.a
  LD      vmlinux.o
  OBJCOPY modules.builtin.modinfo
  GEN     modules.builtin
  MODPOST vmlinux.symvers
  UPD     include/generated/utsversion.h
  CC      init/version-timestamp.o
  KSYMS   .tmp_vmlinux0.kallsyms.S
  AS      .tmp_vmlinux0.kallsyms.o
  LD      .tmp_vmlinux1
  NM      .tmp_vmlinux1.syms
  KSYMS   .tmp_vmlinux1.kallsyms.S
  AS      .tmp_vmlinux1.kallsyms.o
  LD      .tmp_vmlinux2
  NM      .tmp_vmlinux2.syms
  KSYMS   .tmp_vmlinux2.kallsyms.S
  AS      .tmp_vmlinux2.kallsyms.o
  LD      vmlinux
  NM      System.map
  SORTTAB vmlinux
  RELOCS  arch/x86/boot/compressed/vmlinux.relocs
  RSTRIP  vmlinux
  CC      arch/x86/boot/a20.o
  AS      arch/x86/boot/bioscall.o
  CC      arch/x86/boot/cmdline.o
  AS      arch/x86/boot/copy.o
  HOSTCC  arch/x86/boot/mkcpustr
  CC      arch/x86/boot/cpuflags.o
  CC      arch/x86/boot/cpucheck.o
  CC      arch/x86/boot/early_serial_console.o
  CC      arch/x86/boot/edd.o
  CC      arch/x86/boot/main.o
  CC      arch/x86/boot/memory.o
  CC      arch/x86/boot/pm.o
  LDS     arch/x86/boot/compressed/vmlinux.lds
  AS      arch/x86/boot/compressed/kernel_info.o
  AS      arch/x86/boot/pmjump.o
  CC      arch/x86/boot/printf.o
  AS      arch/x86/boot/compressed/head_64.o
  CC      arch/x86/boot/regs.o
  VOFFSET arch/x86/boot/compressed/../voffset.h
  CC      arch/x86/boot/string.o
  CC      arch/x86/boot/compressed/string.o
  CC      arch/x86/boot/compressed/cmdline.o
  CC      arch/x86/boot/tty.o
  CC      arch/x86/boot/video.o
  CC      arch/x86/boot/compressed/error.o
  CC      arch/x86/boot/video-mode.o
  CC      arch/x86/boot/version.o
  OBJCOPY arch/x86/boot/compressed/vmlinux.bin
  CC      arch/x86/boot/video-vga.o
  HOSTCC  arch/x86/boot/compressed/mkpiggy
  CC      arch/x86/boot/video-vesa.o
  CC      arch/x86/boot/compressed/cpuflags.o
  CC      arch/x86/boot/video-bios.o
  HOSTCC  arch/x86/boot/tools/build
  CC      arch/x86/boot/compressed/early_serial_console.o
  CPUSTR  arch/x86/boot/cpustr.h
  CC      arch/x86/boot/cpu.o
  CC      arch/x86/boot/compressed/kaslr.o
  CC      arch/x86/boot/compressed/ident_map_64.o
  CC      arch/x86/boot/compressed/idt_64.o
  AS      arch/x86/boot/compressed/idt_handlers_64.o
  CC      arch/x86/boot/compressed/pgtable_64.o
  CC      arch/x86/boot/compressed/acpi.o
  CC      arch/x86/boot/compressed/misc.o
  GZIP    arch/x86/boot/compressed/vmlinux.bin.gz
  MKPIGGY arch/x86/boot/compressed/piggy.S
  AS      arch/x86/boot/compressed/piggy.o
  LD      arch/x86/boot/compressed/vmlinux
  ZOFFSET arch/x86/boot/zoffset.h
  OBJCOPY arch/x86/boot/vmlinux.bin
  AS      arch/x86/boot/header.o
  LD      arch/x86/boot/setup.elf
  OBJCOPY arch/x86/boot/setup.bin
  BUILD   arch/x86/boot/bzImage
Kernel: arch/x86/boot/bzImage is ready  (#1)
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
done
nick@nicklinux:~/linux-evl$ sudo update-grub2
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
done
nick@nicklinux:~/linux-evl$ cd ..
nick@nicklinux:~$ meson setup -Duapi=3D./linux-evl ./libevl_build ./libevl
Directory already configured.

Just run your build command (e.g. ninja) and Meson will regenerate as neces=
sary.
Run "meson setup --reconfigure to force Meson to regenerate.

If build failures persist, run "meson setup --wipe" to rebuild from scratch
using the same options as passed when configuring the build.
nick@nicklinux:~$ meson setup -Duapi=3D./linux-evl ./libevl_build ./libevl
The Meson build system
Version: 1.3.2
Source dir: /home/nick/libevl
Build dir: /home/nick/libevl_build
Build type: native build
Project name: libevl
Project version: 0.55
C compiler for the host machine: cc (gcc 13.3.0 "cc (Ubuntu 13.3.0-6ubuntu2=
~24.04) 13.3.0")
C linker for the host machine: cc ld.bfd 2.42
C++ compiler for the host machine: c++ (gcc 13.3.0 "c++ (Ubuntu 13.3.0-6ubu=
ntu2~24.04) 13.3.0")
C++ linker for the host machine: c++ ld.bfd 2.42
Host machine cpu family: x86_64
Host machine cpu: x86_64
Checking if "shadow" compiles: YES=20
Compiler for C supports arguments -pipe: YES=20
Compiler for C supports arguments -Wstrict-aliasing: YES=20
Compiler for C supports arguments -Wno-unused-parameter: YES=20
Compiler for C supports arguments -Wno-pedantic: YES=20
Compiler for C supports arguments -D_GNU_SOURCE: YES=20
Compiler for C supports arguments -U_FORTIFY_SOURCE: YES=20
Compiler for C supports arguments -Wshadow=3Dlocal: YES=20
Compiler for C supports arguments -Wstrict-prototypes: YES=20
Compiler for C supports arguments -Wmissing-prototypes: YES=20
Compiler for C++ supports arguments -pipe: YES=20
Compiler for C++ supports arguments -Wstrict-aliasing: YES=20
Compiler for C++ supports arguments -Wno-unused-parameter: YES=20
Compiler for C++ supports arguments -Wno-pedantic: YES=20
Compiler for C++ supports arguments -D_GNU_SOURCE: YES=20
Compiler for C++ supports arguments -U_FORTIFY_SOURCE: YES=20
Compiler for C++ supports arguments -Wshadow=3Dlocal: YES=20
Run-time dependency threads found: YES
Program post-install.sh found: YES (/bin/sh /home/nick/libevl/meson/post-in=
stall.sh)

libevl/include/meson.build:9:0: ERROR: Command `/bin/sh /home/nick/libevl/m=
eson/setup-uapi.sh` failed with status 1.

A full log can be found at /home/nick/libevl_build/meson-logs/meson-log.txt
nick@nicklinux:~$ cd libevl_build
nick@nicklinux:~/libevl_build$ meson setup -Duapi=3D~/linux-evl . ~/libevl
The Meson build system
Version: 1.3.2
Source dir: /home/nick/libevl
Build dir: /home/nick/libevl_build
Build type: native build
Project name: libevl
Project version: 0.55
C compiler for the host machine: cc (gcc 13.3.0 "cc (Ubuntu 13.3.0-6ubuntu2=
~24.04) 13.3.0")
C linker for the host machine: cc ld.bfd 2.42
C++ compiler for the host machine: c++ (gcc 13.3.0 "c++ (Ubuntu 13.3.0-6ubu=
ntu2~24.04) 13.3.0")
C++ linker for the host machine: c++ ld.bfd 2.42
Host machine cpu family: x86_64
Host machine cpu: x86_64
Checking if "shadow" compiles: YES=20
Compiler for C supports arguments -pipe: YES=20
Compiler for C supports arguments -Wstrict-aliasing: YES=20
Compiler for C supports arguments -Wno-unused-parameter: YES=20
Compiler for C supports arguments -Wno-pedantic: YES=20
Compiler for C supports arguments -D_GNU_SOURCE: YES=20
Compiler for C supports arguments -U_FORTIFY_SOURCE: YES=20
Compiler for C supports arguments -Wshadow=3Dlocal: YES=20
Compiler for C supports arguments -Wstrict-prototypes: YES=20
Compiler for C supports arguments -Wmissing-prototypes: YES=20
Compiler for C++ supports arguments -pipe: YES=20
Compiler for C++ supports arguments -Wstrict-aliasing: YES=20
Compiler for C++ supports arguments -Wno-unused-parameter: YES=20
Compiler for C++ supports arguments -Wno-pedantic: YES=20
Compiler for C++ supports arguments -D_GNU_SOURCE: YES=20
Compiler for C++ supports arguments -U_FORTIFY_SOURCE: YES=20
Compiler for C++ supports arguments -Wshadow=3Dlocal: YES=20
Run-time dependency threads found: YES
Program post-install.sh found: YES (/bin/sh /home/nick/libevl/meson/post-in=
stall.sh)
Program install-uapi.sh found: YES (/bin/sh /home/nick/libevl/meson/install=
-uapi.sh)
Program generate-git-stamp.sh found: YES (/bin/sh /home/nick/libevl/meson/g=
enerate-git-stamp.sh)
Found pkg-config: YES (/usr/bin/pkg-config) 1.8.1
Run-time dependency libbpf found: YES 1.3.0
Dependency libbpf found: YES 1.3.0 (cached)
Library m found: YES
Library atomic found: YES
Build targets in project: 99

libevl 0.55

  User defined options
    uapi: ~/linux-evl

Found ninja-1.11.1 at /usr/bin/ninja
Cleaning... 0 files.
nick@nicklinux:~/libevl_build$ meson compile
INFO: autodetecting backend as ninja
INFO: calculating backend command to run: /usr/bin/ninja
[222/222] Linking target tidbits/oob-net-icmp
nick@nicklinux:~/libevl_build$ ninja install
[1/2] Installing files.
Installing lib/libevl.so.6.2.0 to /usr/local/lib/x86_64-linux-gnu
Installation failed due to insufficient permissions.
Attempt to use /usr/bin/sudo to gain elevated privileges? [y/n] y
Installing lib/libevl.so.6.2.0 to /usr/local/lib/x86_64-linux-gnu
Installing lib/libevl.a to /usr/local/lib/x86_64-linux-gnu
Installing latmus/latmus to /usr/local/bin
Installing utils/evl to /usr/local/bin
Installing utils/evl-ps to /usr/local/libexec/evl
Installing utils/evl-check to /usr/local/libexec/evl
Installing utils/evl-net to /usr/local/libexec/evl
Installing tests/basic-xbuf to /usr/local/libexec/evl/tests
Installing tests/clock-timer-periodic to /usr/local/libexec/evl/tests
Installing tests/clone-fork-exec to /usr/local/libexec/evl/tests
Installing tests/detach-self to /usr/local/libexec/evl/tests
Installing tests/duplicate-element to /usr/local/libexec/evl/tests
Installing tests/element-visibility to /usr/local/libexec/evl/tests
Installing tests/fpu-preload to /usr/local/libexec/evl/tests
Installing tests/fpu-stress to /usr/local/libexec/evl/tests
Installing tests/heap-torture to /usr/local/libexec/evl/tests
Installing tests/hectic to /usr/local/libexec/evl/tests
Installing tests/mapfd to /usr/local/libexec/evl/tests
Installing tests/monitor-deadlock to /usr/local/libexec/evl/tests
Installing tests/monitor-deboost-stress to /usr/local/libexec/evl/tests
Installing tests/monitor-event to /usr/local/libexec/evl/tests
Installing tests/monitor-event-targeted to /usr/local/libexec/evl/tests
Installing tests/monitor-event-untrack to /usr/local/libexec/evl/tests
Installing tests/monitor-flags to /usr/local/libexec/evl/tests
Installing tests/monitor-flags-broadcast to /usr/local/libexec/evl/tests
Installing tests/monitor-flags-inband to /usr/local/libexec/evl/tests
Installing tests/monitor-pi to /usr/local/libexec/evl/tests
Installing tests/monitor-pi-deadlock to /usr/local/libexec/evl/tests
Installing tests/monitor-pi-deboost to /usr/local/libexec/evl/tests
Installing tests/monitor-pi-stress to /usr/local/libexec/evl/tests
Installing tests/monitor-pp-dynamic to /usr/local/libexec/evl/tests
Installing tests/monitor-pp-lazy to /usr/local/libexec/evl/tests
Installing tests/monitor-pp-lower to /usr/local/libexec/evl/tests
Installing tests/monitor-pp-nested to /usr/local/libexec/evl/tests
Installing tests/monitor-pp-pi to /usr/local/libexec/evl/tests
Installing tests/monitor-pp-raise to /usr/local/libexec/evl/tests
Installing tests/monitor-pp-tryenter to /usr/local/libexec/evl/tests
Installing tests/monitor-pp-weak to /usr/local/libexec/evl/tests
Installing tests/monitor-recursive to /usr/local/libexec/evl/tests
Installing tests/monitor-steal to /usr/local/libexec/evl/tests
Installing tests/monitor-trylock to /usr/local/libexec/evl/tests
Installing tests/monitor-wait-multiple to /usr/local/libexec/evl/tests
Installing tests/monitor-wait-requeue to /usr/local/libexec/evl/tests
Installing tests/observable-hm to /usr/local/libexec/evl/tests
Installing tests/observable-inband to /usr/local/libexec/evl/tests
Installing tests/observable-onchange to /usr/local/libexec/evl/tests
Installing tests/observable-oob to /usr/local/libexec/evl/tests
Installing tests/observable-race to /usr/local/libexec/evl/tests
Installing tests/observable-thread to /usr/local/libexec/evl/tests
Installing tests/observable-unicast to /usr/local/libexec/evl/tests
Installing tests/poll-close to /usr/local/libexec/evl/tests
Installing tests/poll-flags to /usr/local/libexec/evl/tests
Installing tests/poll-many to /usr/local/libexec/evl/tests
Installing tests/poll-multiple to /usr/local/libexec/evl/tests
Installing tests/poll-nested to /usr/local/libexec/evl/tests
Installing tests/poll-observable-inband to /usr/local/libexec/evl/tests
Installing tests/poll-observable-oob to /usr/local/libexec/evl/tests
Installing tests/poll-sem to /usr/local/libexec/evl/tests
Installing tests/poll-xbuf to /usr/local/libexec/evl/tests
Installing tests/proxy-echo to /usr/local/libexec/evl/tests
Installing tests/proxy-eventfd to /usr/local/libexec/evl/tests
Installing tests/proxy-pipe to /usr/local/libexec/evl/tests
Installing tests/proxy-poll to /usr/local/libexec/evl/tests
Installing tests/rwlock-read to /usr/local/libexec/evl/tests
Installing tests/rwlock-write to /usr/local/libexec/evl/tests
Installing tests/sched-quota-accuracy to /usr/local/libexec/evl/tests
Installing tests/sched-tp-accuracy to /usr/local/libexec/evl/tests
Installing tests/sched-tp-overrun to /usr/local/libexec/evl/tests
Installing tests/sem-close-unblock to /usr/local/libexec/evl/tests
Installing tests/sem-flush to /usr/local/libexec/evl/tests
Installing tests/sem-timedwait to /usr/local/libexec/evl/tests
Installing tests/sem-wait to /usr/local/libexec/evl/tests
Installing tests/simple-clone to /usr/local/libexec/evl/tests
Installing tests/stax-lock to /usr/local/libexec/evl/tests
Installing tests/stax-warn to /usr/local/libexec/evl/tests
Installing tests/thread-mode-bits to /usr/local/libexec/evl/tests
Installing tests/fault to /usr/local/libexec/evl/tests
Installing tests/ring-spray to /usr/local/libexec/evl/tests
Installing tidbits/oob-net-icmp to /usr/local/bin
Installing tidbits/oob-net-udp to /usr/local/bin
Installing tidbits/oob-spi to /usr/local/bin
Installing /home/nick/libevl/include/evl/atomic.h to /usr/local/include/evl
Installing /home/nick/libevl/include/evl/clock.h to /usr/local/include/evl
Installing /home/nick/libevl/include/evl/compat.h to /usr/local/include/evl
Installing /home/nick/libevl/include/evl/compiler.h to /usr/local/include/e=
vl
Installing /home/nick/libevl/include/evl/event.h to /usr/local/include/evl
Installing /home/nick/libevl/include/evl/evl.h to /usr/local/include/evl
Installing /home/nick/libevl/include/evl/flags.h to /usr/local/include/evl
Installing /home/nick/libevl/include/evl/heap.h to /usr/local/include/evl
Installing /home/nick/libevl/include/evl/list.h to /usr/local/include/evl
Installing /home/nick/libevl/include/evl/mutex.h to /usr/local/include/evl
Installing /home/nick/libevl/include/evl/observable.h to /usr/local/include=
/evl
Installing /home/nick/libevl/include/evl/poll.h to /usr/local/include/evl
Installing /home/nick/libevl/include/evl/proxy.h to /usr/local/include/evl
Installing /home/nick/libevl/include/evl/ring_ptr.h to /usr/local/include/e=
vl
Installing /home/nick/libevl/include/evl/rwlock.h to /usr/local/include/evl
Installing /home/nick/libevl/include/evl/sched.h to /usr/local/include/evl
Installing /home/nick/libevl/include/evl/sem.h to /usr/local/include/evl
Installing /home/nick/libevl/include/evl/syscall.h to /usr/local/include/ev=
l
Installing /home/nick/libevl/include/evl/sys.h to /usr/local/include/evl
Installing /home/nick/libevl/include/evl/thread.h to /usr/local/include/evl
Installing /home/nick/libevl/include/evl/timer.h to /usr/local/include/evl
Installing /home/nick/libevl/include/evl/xbuf.h to /usr/local/include/evl
Installing /home/nick/libevl/include/evl/net/socket.h to /usr/local/include=
/evl/net
Installing /home/nick/libevl/include/evl/net/device.h to /usr/local/include=
/evl/net
Installing /home/nick/libevl_build/meson-private/evl.pc to /usr/local/lib/x=
86_64-linux-gnu/pkgconfig
Installing /home/nick/libevl/utils/evl-gdb to /usr/local/libexec/evl
Installing /home/nick/libevl/utils/evl-help to /usr/local/libexec/evl
Installing /home/nick/libevl/utils/evl-start to /usr/local/libexec/evl
Installing /home/nick/libevl/utils/evl-stop to /usr/local/libexec/evl
Installing /home/nick/libevl/utils/evl-test to /usr/local/libexec/evl
Installing /home/nick/libevl/utils/evl-trace to /usr/local/libexec/evl
Installing /home/nick/libevl/utils/trace.evl to /usr/local/libexec/evl
Installing /home/nick/libevl/utils/trace.irq to /usr/local/libexec/evl
Installing /home/nick/libevl/utils/trace.timer to /usr/local/libexec/evl
Installing /home/nick/libevl/utils/kconf-checklist.evl to /usr/local/libexe=
c/evl
Installing symlink pointing to libevl.so.6.2.0 to /usr/local/lib/x86_64-lin=
ux-gnu/libevl.so.6
Installing symlink pointing to libevl.so.6 to /usr/local/lib/x86_64-linux-g=
nu/libevl.so
Running custom install script '/bin/sh /home/nick/libevl/meson/install-uapi=
.sh /home/nick/libevl_build/include include'
Running custom install script '/bin/sh /home/nick/libevl/meson/post-install=
.sh'
nick@nicklinux:~/libevl_build$ sudo vim  /etc/ld.so.conf.d/custom_libs.conf

[1]+  Stopped                 sudo vim /etc/ld.so.conf.d/custom_libs.conf
nick@nicklinux:~/libevl_build$=20
=20

Best Regards,
Nick Xie=20

-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>=20
Sent: Friday, August 1, 2025 5:06 AM
To: Xie, Nick <nick.xie@festo.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Error during libevl build and runtime settings failed

[You don't often get email from rpm@xenomai.org. Learn why this is importan=
t at https://aka.ms/LearnAboutSenderIdentification ]

CAUTION: This e-mail is from an external sender. Do not click links, open a=
ttachments or provide your password, unless you know the content is safe! I=
f unsure, report the e-mail using the Outlook button.


"Xie, Nick" <nick.xie@festo.com> writes:

> Dear developers,
>
> I am building EVL for my application. I came across some errors. Please s=
ee below.
> Am
> 1.    The EVL building was completed, but meson compile failed
> nick@nicklinux:~/libevl_build$ meson compile
> INFO: autodetecting backend as ninja
> INFO: calculating backend command to run: /usr/bin/ninja [11/222]=20
> Compiling C object lib/libevl.so.5.0.0.p/net.c.o
> FAILED: lib/libevl.so.5.0.0.p/net.c.o
> cc -Ilib/libevl.so.5.0.0.p -Ilib -I../libevl/lib -Iinclude=20
> -I../libevl/include -I../libevl/lib/arch/x86/include=20
> -fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch=
=20
> -Wextra -Wpedantic -Werror -std=3Dgnu11 -O2 -g -pipe -Wstrict-aliasing=20
> -Wno-unused-parameter -Wno-pedantic -D_GNU_SOURCE -U_FORTIFY_SOURCE=20
> -Wshadow=3Dlocal -Wstrict-prototypes -Wmissing-prototypes -fPIC -pthread=
=20
> '-DLIBVERSION=3D"0.51"' -MD -MQ lib/libevl.so.5.0.0.p/net.c.o -MF=20
> lib/libevl.so.5.0.0.p/net.c.o.d -o lib/libevl.so.5.0.0.p/net.c.o -c=20
> ../libevl/lib/net.c
> ../libevl/lib/net.c: In function 'evl_net_solicit':

> ../libevl/lib/net.c:48:24: error: incompatible types when assigning to ty=
pe 'struct __kernel_sockaddr_storage' from type 'struct sockaddr'
>    48 |         solicit.addr =3D *peer;
>       |                        ^
> [16/222] Compiling C object lib/libevl.so.5.0.0.p/heap.c.o
> ninja: build stopped: subcommand failed.
>

Please use 0.54, this bug was fixed in the meantime.

> ../libevl/tests/sched-quota-accuracy.c:213: FAILED:=20
> evl_control_sched(44, &p, &q, test_cpu) (=3DOperation not supported)
> sched-quota-accuracy: no kernel support
> ../libevl/tests/sched-tp-accuracy.c:222: FAILED: evl_control_sched(45,=20
> p, ((void *)0), test_cpu) (=3DOperation not supported)
> sched-tp-accuracy: no kernel support
> ../libevl/tests/sched-tp-overrun.c:220: FAILED: evl_control_sched(45,=20
> p, ((void *)0), test_cpu) (=3DOperation not supported)

You need to enable CONFIG_EVL_SCHED_QUOTA and CONFIG_EVL_SCHED_TP in the ke=
rnel configuration for these tests to proceed.

--
Philippe.
