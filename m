Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013016.outbound.protection.outlook.com [40.107.159.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7A11607A4
	for <xenomai@lists.linux.dev>; Fri,  1 Aug 2025 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058631; cv=fail; b=sgytTURGsu69wW3JOcR/l+CXN2CI6ATULOHkXiMijdFeRR2qZKwi9Ezh1LT9J0Y/syIoNTTneOmLlEHSbuuu3qhbsbLSSRgtiYunsakEp7PjSN97cpyBtQ3YmKLgO8NlnapofjVhaWUrnhs59vDfC94zL6suCsFEWNRiuNB6fao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058631; c=relaxed/simple;
	bh=7Yd41Fwcz7Khv6Q+x9Jfywm8t791odZ9Eou8yRaQekM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hCwFOsMSBbWsbuvCOfEhk1RgJU5fAo2/29AnWgAEkm4ttf+6YAWOWLyFNRLm06Zdzgc0fo0t/FwaaE4SOkCH5y7dMalcEZCeor65F8FTxW4XkCH3xXzr04rlb55FQc7uh0uWmyEsM9G4266FpTk87dAjaZ9Wy632VEoA4jsptVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com; spf=pass smtp.mailfrom=festo.com; dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b=p7j4LY1k; arc=fail smtp.client-ip=40.107.159.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=festo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b="p7j4LY1k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nf0ZCAL8pR6vE8Fj50Lz7MUb/8J/IfxTkkWAgjpGqILw9AhgKVYKYJCCepHcYItEkMRAgg+P1boep69kyHyTg+ceF2rmbIMBdn4WQujVZFL6/r/Cy+S6E75jWd9jjfvZAHgzexAx9eyA8SNejoe5UHscyxvavVhmxg4JJK7GKZXjg4xyoZUsuXAH6Szx+OwjaodgICF2J5SzQlOKPrkAYEKUHxuh9Cd84dtwYWX/K5FLutV+hMtWNXkIJKst92rPdP44R3Q2V8mXD3bQdDzhhKyW9OJG9/LzlEEVOB95QXVsrHSNNCn7b6tx8tgyY97QQ5M8XXkad6YE+NzYlwWMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VAfacxkvUWalMXPjSwZ9upSuR7ex+Dlkm42XuSlspY=;
 b=JN5R7C1eZrsysbnSarxpJjCC2v8DAwyGn5OWLfbiCGlGxwVa4z23XLKge6Cek4kJ/nMleZIf0M7F+BXzms4tc9WYvn2NLhnsPOgV5TDMkGwGyBg4de9rS/eHrmmF4eUgblSkqMRO26nSUFFqgqsbQM/z7gTDZfFWCa/Fz9QWlneVsb6jM7GMldecIlodMyPmf0gI6+OZK12TUynEVN8X6Y0iD7ncQzW5jbpvCqmpmbNNSauq1f/OYG7WQxDTVeNBsPpO+oBgwwxI9lSsO90N+DwHdFhFA5YRX3gB7QCxkZi4tx21R6olukdf2ajNTxI+IXTgiXNDN281Tu4hNc8YIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=festo.com; dmarc=pass action=none header.from=festo.com;
 dkim=pass header.d=festo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=festo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VAfacxkvUWalMXPjSwZ9upSuR7ex+Dlkm42XuSlspY=;
 b=p7j4LY1kqc3ZPLaB9C4rsp39e2OTG7wcY6BlKR7lS+RPc/b3aEzWmoqhgqlqnB3eTo86c12hJyC3Dr1skt8mh18C4tMZE1AvAOfM5W8WqOl4nHbq4a+6t49z5zvYgNOCncDQnlsE2xr5z8mneZgrWNvjBGpHuHU4IAsQQffLKI0=
Received: from AM5PR03MB2882.eurprd03.prod.outlook.com (2603:10a6:206:18::24)
 by AS2PR03MB9765.eurprd03.prod.outlook.com (2603:10a6:20b:60e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Fri, 1 Aug
 2025 14:30:24 +0000
Received: from AM5PR03MB2882.eurprd03.prod.outlook.com
 ([fe80::b0f0:d40a:9a12:ba47]) by AM5PR03MB2882.eurprd03.prod.outlook.com
 ([fe80::b0f0:d40a:9a12:ba47%4]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 14:30:24 +0000
From: "Xie, Nick" <nick.xie@festo.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Error during libevl build and runtime settings failed
Thread-Topic: Error during libevl build and runtime settings failed
Thread-Index: AdvhNCsPSr13v8uwQHKA1c0dN9vzhQhJ1t/wAAMSmAAAFusnuwAK9Rog
Date: Fri, 1 Aug 2025 14:30:24 +0000
Message-ID:
 <AM5PR03MB28822B3215D9F909FD7BD0818B26A@AM5PR03MB2882.eurprd03.prod.outlook.com>
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
 MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_ActionId=c4ca83c8-999c-49ab-8414-8685d2c1cadc;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_ContentBits=0;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Enabled=true;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Method=Standard;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Name=Internal;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_SetDate=2025-08-01T14:19:40Z;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_SiteId=a1ae89fb-21b9-40bf-9d82-a10ae85a2407;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=festo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR03MB2882:EE_|AS2PR03MB9765:EE_
x-ms-office365-filtering-correlation-id: 603c5b40-7597-4c96-e885-08ddd107f40e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?01LD2HJrmVm2AJcAZfT5+OvJH3BW8S42Ij2eZ0CSgH5YjnDM+5owgBfc7HnX?=
 =?us-ascii?Q?PDaeQk2f1SrnZ52T1Zf+XA1NthW32U1td2GTBkc7TgG56M27GfoTdPGc7ofd?=
 =?us-ascii?Q?7eCwBYXRAmoxWHpS0os6dK15OQAW0okQ/Sy7HiGKm/4jqKuD3FGk9zrrNbqo?=
 =?us-ascii?Q?MVMxpghDO5W1M6Zea6w3+i5QSqV1oUySRG475HFu07owUrGmATkR49A0XWnS?=
 =?us-ascii?Q?m2Q83FLun+aYxW2SToC1IbfZ+FJVWysBAAHe2Kj90uZ08HCH7rt3IAVKyivc?=
 =?us-ascii?Q?vxocEiECOeRq/Q0WfxzO80dKlXcNkXw0P4vehEbUqxvF83T8qPC2O/OxcBYd?=
 =?us-ascii?Q?rdkx6S6AWenPaitjjLX/hGEweF0u9VYZkZyfcJgUfFj/BqRQXrEgd1pa4697?=
 =?us-ascii?Q?Q4NCJs2QiS+kaw8mZ3KGchUOE/QW3CPL0IdnHHucOniR6ayNJ5SaUz3THXLu?=
 =?us-ascii?Q?805uIehjvB2IQgUei6pKDTzZO+Qykc2bwrg3rgD3UsozMmLEwpZu++LyEFn1?=
 =?us-ascii?Q?f4lCsZRMvDh2eMDz9h0cDlH3Qv6aX9+LWHEKstB+b4od6CyYVluMorllCKFx?=
 =?us-ascii?Q?gatu5WZPhtRWKPMi/dSDf+M5a4GpzqTfOoJZui2d9yB4JEsXnOzPCiOH3kHq?=
 =?us-ascii?Q?gpy4gJDo9Ybs0uju6zYBnoLmZtFeCUOVB6M0DuS/oE9nVaBMtxD+5cAxulRG?=
 =?us-ascii?Q?apCwERTKwoIG7h6ant//kcCmOCQHjWitZJGSJt5b7wFeUNkOtFTcVuBfdrGg?=
 =?us-ascii?Q?QmIdiZeETeK0t+wX6DDRyThq8LkqYExgA/zN72jQLQ2CpVJp5hWpI/RejUU1?=
 =?us-ascii?Q?WoU/zJFEfdYckws5bCHPT+6YIpHQzRebOCucghhUQCCueAknIUxTq31VDOFD?=
 =?us-ascii?Q?trPGJH+oO+bQR/SYWvJmwyMG9n2bRG6qu+aIvKhJIPKP0/PIUNOr53PZDJJu?=
 =?us-ascii?Q?RuaEtOacP4nikaC04JYIVqOlY3Gd9o3lgSfPPYYRRbcSpMaTTIzb7pHfdPLN?=
 =?us-ascii?Q?QOgUOMOVqOt9TrgVdDDMpIbzCZNqtt3sCHG47h9HJVwLyITj5UGJqf4dk1A1?=
 =?us-ascii?Q?ldYl8uFrrFKXbWp3OTHAYEkXBpGwK20URIjdzFo5Fnt5Xk2ziQrKjHxVS7Zj?=
 =?us-ascii?Q?iTAYJTN+kmhhgQ7mQ5fNjtJ1IynwKGmBbZGiE0bKSFEM5tSeLAKop4mWkuyT?=
 =?us-ascii?Q?FmW39C0qO9faRKt4af1dy/IiHj4ZBjnyIl4dH3SmY3wArJuEWFZSEj7zIWEJ?=
 =?us-ascii?Q?EaAQ7ZptpRbjHQl1Ez2U40A9N0cOvc6ESdfvcg8P01RSd0T537QCRy2D1qAB?=
 =?us-ascii?Q?lpgIiqqxk94u4SvzTTkcXRv47Sb+AypCw4tijn4BkDGhA333YVvhzg8a+Mke?=
 =?us-ascii?Q?j2RBD3nANbD+LY5Z1coi0jL5iycDovmWLMMTW1R5N8C5eaS5Kr/OynBl/B3h?=
 =?us-ascii?Q?N3VMnj2aMXfAveAHF10YsafZiCUeWOlAYLzjeF/cJ79dMDu8Qn+t1Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR03MB2882.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?R0E8VgUeOPiy2f+PbQG1Z4VTtQw81GpdeHzqfOfpIKR6sAxIcDHB64FF0VD7?=
 =?us-ascii?Q?G2gppMg3/P8mzJFLPdAy/v51oTN3ztiUVcmFZmfzpdRcfjL/nqlK5Exe/9+y?=
 =?us-ascii?Q?wfxWdv82P5R74PxbKuiPlXSSnxIcIwqLNs9mtdEYX0B49mjR/02kXdzfnbgW?=
 =?us-ascii?Q?X51IbI0NNpkcR2UMxmONgwwbfciV0dVnyf8F1KHXFkDw8t3L9HK19AWT2O8l?=
 =?us-ascii?Q?/FHj43/O+1hgjRCp8Ne24dR/nbX7Jpdk5c8j7W71fG269acG01M0yHF0tpCe?=
 =?us-ascii?Q?3RWACPiIm/m4l5ct9A+zsCirnxpuBp9I4F/cpiLTWh5wDW2H7RF0OA7JTwnB?=
 =?us-ascii?Q?7sPccFekAMYGcgZyrJo9usEE7kFLbqcUBPi6yOiDQOCCeuMjR9Jasw5vgy8B?=
 =?us-ascii?Q?O2p9kVUpQaoWW7r/vr+pYFtRh2neFtbX6SFfqL+ipq8dtBbqYgLbhIyD/z8v?=
 =?us-ascii?Q?uqHMSnJi0rBc0iRagj8/NCkMvaEXaz1WSgCgXjNopBKcCn7PXhf1LAbXTJ8l?=
 =?us-ascii?Q?48utxxUOQa7E18H5Kdoqp5g1xxAiCrQokynye+hh5kPPE7Nzu6ou8Ud5z8br?=
 =?us-ascii?Q?5gMOkXUb0D75WDcKFugHJavnt03lvuO6gjNZ9c2Qd9O9CzeQlGP5AumnP0Ze?=
 =?us-ascii?Q?/KwmclchqZAJpd5R5KtUnCrqZ+utCYm4IExgxMjJKSrE//i451zPip8yuUaL?=
 =?us-ascii?Q?Xa8fnlx/9T7Nd7rOA4oy18cTcfdFPGcrNTVTrfv8jGvsCewhd8vpOUIGpVpT?=
 =?us-ascii?Q?Mdv188VtA3ce8YCotRpDe0WPnce+VGCPzqMS1YmO6oWJDzVGZ/9ZI+qZbfMF?=
 =?us-ascii?Q?3UOTXm2S2zGKS3nLelrfEjYOej4rVkzVIkXtaJGGeIIdUiMM/0X02B9FcOUX?=
 =?us-ascii?Q?2fsjdp4iIn4G8wwnIanyP93iY467AXJdR7DRfDLI0/CqFNMvRRXfOhFDsHLZ?=
 =?us-ascii?Q?v2o5Pa5pBt/eyiPW58x+zm7se7mvF9Vqri8DQmsrIDePQrMyq2fXwDJxKfwm?=
 =?us-ascii?Q?rFxbJzqN7hC32bWY55nZ6g6A6F4D+B5M2ldMvhnLXU2Z6RqG8gTitW55/GVd?=
 =?us-ascii?Q?tJZlPXcBP9WaEBkAde3qvp9/T9bH+BKbIoG4cfMRHW1KPiugVr8A4DwXKpSo?=
 =?us-ascii?Q?CLG4NilDPYADJtOCfzJ65n7AbuTd2NApX14+Mv7QFIIeL0E4XnD7K875Sp/m?=
 =?us-ascii?Q?u+ubDh1UgGaLL+XHj4qVyVtSqNoxsUQpysNd+FtX8eyFSPNaxWLoYZNGWhah?=
 =?us-ascii?Q?AL3rRl4fKqBGAXBbjPHv3ByXL8uRON4qHAw6mDtS0VFsbd78q3KkKF3TCaAM?=
 =?us-ascii?Q?8HKEADHiNY4exFad2g35RATPyJ4lavOW5sZTFSeOTCM66VdUkmiL+uk54FoR?=
 =?us-ascii?Q?4RcL/uJWngiBdRCFlvp+H2VEqVkrOq+mi9xXBOjTjWBV67NNIc8qypUWfN2V?=
 =?us-ascii?Q?UxrPCd9rKQijchhLiGtQ4xni5/ZGjbkG3ubx8XbpCiHFeZg/2T9kqxIi2yRe?=
 =?us-ascii?Q?hh2U20xB+ADT7Lfqh4g/kbyz/D7yAt+4ShJiUIb3sK9GVN/Xh4tE/U2c8NHF?=
 =?us-ascii?Q?9+wpfSj66lnV/KiJBGE=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM5PR03MB2882.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603c5b40-7597-4c96-e885-08ddd107f40e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 14:30:24.5642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a1ae89fb-21b9-40bf-9d82-a10ae85a2407
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGS/AY0PEkxaBxzlenzk/cPq70gMbk74P7DK05Lq+xcj5VOWac9vYWSDHyjiGf7Ts4NUoh33VQ2TyuFpVCPb9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9765

Hi Philippe,

Thank you for your response. My main question is below.
Runtime settings failed
nick@nicklinux:~$ sudo latmus -t
=3D=3D latmus is now tuning the core timer, period=3D1000 microseconds (may=
 take a while) irq gravity...latmus: tuning setup failed (irq): Invalid arg=
ument nick@nicklinux:~$ sudo /usr/local/libexec/evl/evl-start no EVL core i=
n kernel.

Does it mean my installation and build is not complete? How can I check whe=
ther my xenomai is running correctly?=20

Thank you in advance.

Best Regards,
Nick Xie

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
