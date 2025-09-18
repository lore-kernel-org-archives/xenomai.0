Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7E24E4C3
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758232727; cv=fail; b=kM3IM/zfxOUcu3PQ9krZVQMfNDp39uoP12AkyNy+qplHd12U8ZwTRc4Dmq/WSbhGM60789D/iW5pVnd8BJOiAmrn08MBf6lag+tNFWMK4NlM8avy+B/fGkRlckrmYZ3iW+tIveWIBmF08Lt6QtXQERFHdQlxy0CFVTbAI/X78mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758232727; c=relaxed/simple;
	bh=ZPGP968U1cVhNyV+C3zIO39IbfFF9+LcI/B5v3H5Ju8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I+FmvpFzNxKqtdgFYWKhyDQ0hyHqbA4MM0/+kCkhhUOVPC5rXZ60e92gc7izz6k+59O+B+RcV/yWvtKKb4qME9LvaOXhILb9vy8uu4EDwEw/dW85xS84/6a4InuSUFhJv7ohbGvWkKVSpW8cEi9edxGbqoIZ1zwXhmMgDK5vq+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com; spf=pass smtp.mailfrom=festo.com; dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b=kTdV87zF; arc=fail smtp.client-ip=52.101.70.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=festo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b="kTdV87zF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqdkDeSlZvLmrcEatx8I8XoIBw9+OuO01BgyM2PjUpprTkj+RzOLyFJ8RWOtYhRzHmsl52yX1cG88kdUFm7zAnPgP73M9rMYVGORo2wxp8Fs7VLc2h0hpxvlLRpnTFpo3AEGkgOuftYjnfW+ka1so229d+jHfbEz69UL3g5W87MFLR7AMl20Jt84ccEUCmbHg4Z2hTewnkU4hkiphGGXCxY2w7VMvTbGFs3vNq8aYaLL6Lq8sY3Elk/kSWAiXdE38LEuRsksdeT2c+Ujv1K3yPng/V10BvoJsTjv4Xye1AMNfefcdDiVd7+a1IU5qHINYlKX4vHOT8+QesuIgDlUFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkQVNX0wqf+LeCAqM1JaWcSo/1lWGtY2iAShpSWNPLM=;
 b=AcILautyTrf8NhfuoE4OtzkmQqbqucyLxEY2DdOLtR+vcjhouE91SWxhXeTd5XcLJmi2PlgS+P0VZ+vosTpOt9OdOSL02Fugyft5b5MjYRTuIkfUdkF8O52JqR1HK/X1IxpVnn9IsgN+YaSJLggkzyHXdJoZvAxsRn293sY+E7fxa7nVMHPH7L/ThtVgd703UY2x3pw5n6wm13y3Z/XVqH5kMTptU95JBELYpKM+yhg0p4dBNWdHrcdlkQhYz7AXPH5NSMNPBOx8Adx3UaDZBMD5/1LNdifgniUZPJmfT5z+q5Jck5hxxrWtHBExl8QihMjVPn4qw0mmCTJu8OfXzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=festo.com; dmarc=pass action=none header.from=festo.com;
 dkim=pass header.d=festo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=festo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkQVNX0wqf+LeCAqM1JaWcSo/1lWGtY2iAShpSWNPLM=;
 b=kTdV87zFk3/fR0sWlJb4hMcDNALal82UOckP/okyjAot/dmvvDD/Ylm/w3heOI4F05RlT/0L0a0uUNA/Rbj1cKEYx6vVxZODVQ4TVcN3hiwDStE4Ea9XRM64tginWfAL7u2hqnXn306fA8KH6gtLVvm5IufM86mE+dN4DNGL8fY=
Received: from AS8PR03MB10056.eurprd03.prod.outlook.com (2603:10a6:20b:63d::7)
 by AS8PR03MB9722.eurprd03.prod.outlook.com (2603:10a6:20b:61e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 21:58:41 +0000
Received: from AS8PR03MB10056.eurprd03.prod.outlook.com
 ([fe80::5350:1f43:188a:6db5]) by AS8PR03MB10056.eurprd03.prod.outlook.com
 ([fe80::5350:1f43:188a:6db5%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 21:58:41 +0000
From: "Xie, Nick" <nick.xie@festo.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Error during libevl build and runtime settings failed
Thread-Topic: Error during libevl build and runtime settings failed
Thread-Index:
 AdvhNCsPSr13v8uwQHKA1c0dN9vzhQhJ1t/wAAMSmAAAFusnuwfrxy3QAAfyhxgAKuLKwABgKnAqAQl7ioA=
Date: Thu, 18 Sep 2025 21:58:41 +0000
Message-ID:
 <AS8PR03MB100560006594FE9480F592EB98B16A@AS8PR03MB10056.eurprd03.prod.outlook.com>
References:
 <AM5PR03MB2882F5ED2ADBA37FAA9562608B7DA@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<AM5PR03MB2882F38E95A99A0760C60D1F8B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<AM5PR03MB2882726DD078E29EB76589518B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<878qk3za1e.fsf@xenomai.org>
	<AS8PR03MB10056F9D6FBDE93A148E03F5A8B0EA@AS8PR03MB10056.eurprd03.prod.outlook.com>
	<878qimxczv.fsf@xenomai.org>
	<AS8PR03MB100561B2E374D4680213E55DD8B09A@AS8PR03MB10056.eurprd03.prod.outlook.com>
 <87plbuz9ib.fsf@xenomai.org>
In-Reply-To: <87plbuz9ib.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_ActionId=684d6ab7-47a9-4857-968e-06e07015d3a3;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_ContentBits=0;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Enabled=true;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Method=Standard;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Name=Internal;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_SetDate=2025-09-18T21:38:10Z;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_SiteId=a1ae89fb-21b9-40bf-9d82-a10ae85a2407;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=festo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB10056:EE_|AS8PR03MB9722:EE_
x-ms-office365-filtering-correlation-id: 8381eca2-83a6-4f63-1814-08ddf6fe8797
x-ms-reactions: disallow
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZNtMzIainp8h0sAUDTY3zHqMAiE/h+S7KisdvRLmGfwgTxOcDzWkTtDSDKFj?=
 =?us-ascii?Q?uhZVPpKfAomwRnMI/pDgpF1cSAQnPtLmzTtRHPm8YLcEI55nwTnqVl1OJLIu?=
 =?us-ascii?Q?PIyBsjbo9lLOYcA7eclLYLiD1M8sLQ5I8HF+A6FoLHKuE/AUhDd/hIi9usfS?=
 =?us-ascii?Q?Okg6WSy96smdlWWhEzdM7Ga/Fsr0+LhVA65GE0KGXF1QLTvdGSSnpxrh5D7h?=
 =?us-ascii?Q?gLuwQdkPUVwpTMcRM7xzz9XM8sjntQFN+vz6ZgDntfL6lp4+U6NzsXTNgs25?=
 =?us-ascii?Q?hixeLAX/m2A5LUZ3DVG0qsFU8fm1sUqqKpj27HkTOuuyEJJYgo1EtEK0jaZQ?=
 =?us-ascii?Q?hhZEK8KLHn1sVq4Hcv9tu08ic2Nx/6fQX4qVUUwOJlt7uAc/cyD+8WKt+PVu?=
 =?us-ascii?Q?oDx0IH4gP1337wSPPgey6DcFnkXIpR9qVvfj1yqADvHPt0nVfHgjRpuD+xpY?=
 =?us-ascii?Q?uWWHwunSRyS8PJ+q2EYnGxh2gZmI8EEjBOa3H+gcQcZEmrrJ5k85hywzf5b7?=
 =?us-ascii?Q?K9i4yRuRMw9WIsJ2k86/rv3PvEaverskc2Qo3tShkmBmn7pBo5Z0C3Nzpean?=
 =?us-ascii?Q?lQQ8ZMt71u/AnKxBh4oRARUoSgSe05mv2oqNsNDiGsqFrCv+eSmAXnOUq/tb?=
 =?us-ascii?Q?N3UQNyKKEuNupWTk29YRg6CuD3P7rYrGsKV6eg9FuV/RmyJkrdg60576eiO7?=
 =?us-ascii?Q?CvbKlEsnU41Ci8jWVkUmG4GSvTfrA9m/396pA7gYHlMyVr7q2K2CjkD/fjpu?=
 =?us-ascii?Q?dimCr96rK1G1V5VJitTtEHb+cpGiK4kk3DICA7RyIWULphJUYvjNcweft3ml?=
 =?us-ascii?Q?czxjdLc4kmx4lCE1Ek0vHZy+ACX4jfhTdIp9m+lRtg4ccTAMR9CdPzo2cvUo?=
 =?us-ascii?Q?8epF5JBj4oAE349k6bd5e9xPhY9R5S5iv6wO3V4zwNUun9rBN/pCXCXr32+2?=
 =?us-ascii?Q?s1bxUh+29QQtpM17f4LKN4mgfz8ZBpeJYpyXyRHehLO8QpxgtCu2mi6T4pX9?=
 =?us-ascii?Q?+YNjz+BoqmC1u+vwD3ezt3/U7VplSps0ygMmGBlagtrpV+EryNstwtKri2B+?=
 =?us-ascii?Q?LH0e0t/4AgWl8gZxQLs612VcKs58ITeervouphTWKpyziXZoZrwlsU1qACr+?=
 =?us-ascii?Q?6MvKygFmrAM/vT3PhcCvwLrEYHkGWN3Rzu2YoOa4di9dHTCicFrvUKCH9ohS?=
 =?us-ascii?Q?wVXgBsSoXesmRaNHytmD/Saj1fegAPBxBmzDJXw08MEpvQZPswbSgDBnazI8?=
 =?us-ascii?Q?rdBau/GeZsIwuJPX9aOciiVk1QU5+iakWj+K5pCVajWw64rZh4hT8Ohj4tUY?=
 =?us-ascii?Q?tneLbZvoZNe3NzKpaDC8e12orhPOrbDZgKcFDv1glLqhU5M4Qwd7Px/xSq87?=
 =?us-ascii?Q?VKFa0w8aXdboYxK8yKPn05tE2QvEHRc97k2oZDNdh+8kjIwo2/gcCcJ9aQ0b?=
 =?us-ascii?Q?7upQtOJpTFY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB10056.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tvAt5L5O1bxVV+5mRAJz1AYC9Wph2DNjJOZ8JpKzNqY3rkKvaSCovLK18Yvv?=
 =?us-ascii?Q?rd7yxj4gURJqrRQifwuJaZkOZmIdjBDCuhGFPkivyy2JGMC5gzjOSEAVzsS4?=
 =?us-ascii?Q?rQg8b24VW5nIPxi0j7pykhY2pKdewBWilB/UeQpe9yKhTENclbKv2/Frc/oX?=
 =?us-ascii?Q?nVOKImd2pJ6jYJTa8kq/CDYXWhk4vDLAT76pgX3mGlWIikIhGjpazlQ1LJZb?=
 =?us-ascii?Q?IoUl8oMUfTf6HF73Kv8M8VrD0dS2AyfGsNBUidCtbkUCw28J6NftVCAQsNh0?=
 =?us-ascii?Q?fFbrKnT2UjYPPxZXrE3nRbKiN2FwOa6/7vFFZexEt8vQk8Au0gylEb8pipBY?=
 =?us-ascii?Q?VSkuCQsECGDeHs9ERdEqxEb9p4ASGDBXMniqOqxhgzHPSEDVFuZV8X5pU/0q?=
 =?us-ascii?Q?iLNlWpG8A/lB4mIPgpIutzjE3dqWCMXKbKiU+fC648wH4iT/O5EwKaiqi7W/?=
 =?us-ascii?Q?rHVt/KjSh/F6QZEFFBqmyAis6svcpv185fYrwsxuYE7euk+uk6x6r+Wvwree?=
 =?us-ascii?Q?iWnaEcT1oB/qwgMGfTbN7isnJUgvPOfAp55aoFbo1lya4GE26j6QMtaZk7tm?=
 =?us-ascii?Q?J4pDn8bSopAYTodFiJm5TW7NXeUuHYfwQq6snibQB0O9yYzb0YzwhBTApbTK?=
 =?us-ascii?Q?LJv1uVAcoxLuDzNOvhv+wr2fWAuPX1EhvhpFTn+whOZBQAPriSmczOb1PqZC?=
 =?us-ascii?Q?bqXBLunaRFHSemlmG2+e/kepNoJzrkGvFxdBieNRdZXJ8mJ2f2iEuadYMV/A?=
 =?us-ascii?Q?cUh7Lt4es6MD7fMkID4jWgNusEkdsmLAtEsQSlKyvtNStTmiRKs6nAKRVHpL?=
 =?us-ascii?Q?OtsROc5ps2iI+hLyKxNB97gp0E1tGne1QjkZi6rgICW2dULh6XqHLjeP9zg4?=
 =?us-ascii?Q?Nk5d2aQ09kg3YGTTZQQunQ/EB/6f5GtlRnk35SmEiq4cZ+CEBdEkJY5Sr91r?=
 =?us-ascii?Q?ZM3xosBJC7GIWF7yqCVGiV+by+z8lC+FEAyiAbB0XwFIcypwV8gzBrMnzSsF?=
 =?us-ascii?Q?78CFhASIAiTC6HdbMZFFwBdOtUH1xSOkcoX0bjbj4l+gfmSwpttJuQ6uFvFw?=
 =?us-ascii?Q?lGIeL1WkWekvcLwQ1m6BO4YzbsCsgzIYlJ6zb6NHFvirImQq8tWM9MmDiC2r?=
 =?us-ascii?Q?Wu1KDsmQGU4SHfM3luCXJfueqPFjHBf+1/pVsqPurrx0Iduz2PVfl1+e4kJC?=
 =?us-ascii?Q?F6TW3nfpSy+ePoEqWHuNC8ELWrUuofkUt8V3A8VdrhLPwueZ+miA4fIAcgUZ?=
 =?us-ascii?Q?SS2sQ4MKpv6kk3MZenwCGN1/FLLvEfFDar/pp8Q5ZD4MQj0kL/n9SBKtxPn6?=
 =?us-ascii?Q?dqSt6YU1/Cre3CSngYRVi15955yV9icWzzA0fTiZ3H6xfO0L0i41Nz6pWBFE?=
 =?us-ascii?Q?0VAPAzD68AG+9GMHa72vKMOQKoJgnpozYX9Qrx1RUCnWD5GSihZqNSxKPDQm?=
 =?us-ascii?Q?EmlV/oNjJbJX72RqtW/CLZuNpOr3sUEgr5fpAtTWgLqCA4JchdRDaihdxxgS?=
 =?us-ascii?Q?1jOmRv/11bnFLmb/wUOs4LsrzAY+zLKleT6vCt76jj41WfYoJ5mmus++2nVk?=
 =?us-ascii?Q?v2my5ECwF5j2C2W5vVU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8381eca2-83a6-4f63-1814-08ddf6fe8797
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 21:58:41.2644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a1ae89fb-21b9-40bf-9d82-a10ae85a2407
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9VfkwAsXfmR1Ds9lCu9LqprhpRLCf+CZWBEVKGYgM1kr58b1iTW479Mn/We2jTsdCBloUQmPuN6HLUSm7Yivow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9722

Hi Philippe,

Thank you for your suggestion. After some investigation, my previous error =
is caused by I download evl as tar.gz(it is missing the hidden git folder),=
 because my network was not stable. I used git clone to download this time =
on a virtualbox (it is easier to output the kernel console in serial)and fi=
nd out the config file is the problem.=20
I was followed the link(https://kernelnewbies.org/KernelBuild) from xenomai=
.org. As it suggests using "make defconfig" which will generate new .config=
 file, overwrite one I copy from the current kernel. I used "make olddefcon=
fig" instead to fill in the config and it built successful on my linux PC a=
nd I can start the kernel and the evl test correctly. I will continue testi=
ng tomorrow. But there is a problem with another test on my virtual machine=
 using virtualbox. I followed the same steps and the error was showed below=
 during make. If I used "make defconfig", the make will be successful but t=
here will be a problem on boot. Do you have any idea? Please advise.=20

  CC      kernel/tsacct.o
  CC      kernel/tracepoint.o
  CC      kernel/latencytop.o
  CC      kernel/irq_work.o
  CC      kernel/dovetail.o
  CC      kernel/static_call.o
  CC      kernel/static_call_inline.o
  CC      kernel/user-return-notifier.o
  CC      kernel/padata.o
  CC      kernel/jump_label.o
  CC      kernel/context_tracking.o
  CC      kernel/iomem.o
  CC      kernel/rseq.o
  CC      kernel/watch_queue.o
  CHK     kernel/kheaders_data.tar.xz
  GEN     kernel/kheaders_data.tar.xz
  AR      kernel/built-in.a
  CC [M]  kernel/kheaders.o
make[1]: *** [/home/nick2/linux-evl/Makefile:1949: .] Error 2
make: *** [Makefile:224: __sub-make] Error 2

Best Regards,
Nick Xie=20

-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>=20
Sent: Saturday, September 13, 2025 10:56 AM
To: Xie, Nick <nick.xie@festo.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Error during libevl build and runtime settings failed

CAUTION: This e-mail is from an external sender. Do not click links, open a=
ttachments or provide your password, unless you know the content is safe! I=
f unsure, report the e-mail using the Outlook button.


"Xie, Nick" <nick.xie@festo.com> writes:

> Hi Philippe,
>
> Thank you for your response. I tried to enable the console output in grub=
 setup, but nothing is showed and it stuck at the same place.
>
> You mentioned booting over a ramdisk inherited from some=20
> distro-specific boot setup builder is discouraged. It reminded me that=20
> the first time I run " sudo make modules_install install ". It failed=20
> and reported as below. I have to enable "support initial ramdisk/ramfs=20
> compressed using gzip and zstd option under general setup" to get the=20
> install done. This is very different from my previous build. I have=20
> never need to do this. I would redo everything from the beginning and=20
> see any different. Is 6.12 the correct version I can use with new=20
> libevl? Do you have other through? Please advise.
>

6.12 is the latest LTS supported by evl, so yes, this may be a good choice =
in your case. The grub installation issues you are seeing are not related t=
o evl which has no influence on the aspects you mentioned, you would have t=
he same with a plain stock linux kernel. You may want to refer to other onl=
ine resources explaining how to build and install a mainline kernel in plac=
e of the one shipped by your linux distro.

In the early stage of bringing up your target system, you may want to disab=
le CONFIG_EVL, CONFIG_DOVETAIL and CONFIG_IRQ_PIPELINE options in your Kcon=
fig, until you get a v6.12 kernel properly booting your box, in order to ru=
le out any issue with evl.

Once this kernel boots with a working console in order to get the informati=
on you need to progress, then you could enable these options back one by on=
e in reverse order, discussing on this mailing list any issue observed whil=
e doing so.

--
Philippe.
