Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1931F12E0
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758299781; cv=fail; b=rBYjsx9xPDjLEv7UQsXFPE4tfT9ADP9P5GbF2BCqB+XoUSGiHA3vf8uVxV/RGoXRTaZLwi7QuArWcDS1QJij2Sw36hpH1yg0UoyFQaR2bnCSjm1X9PMH4ylPUfktOekeM07TMGBmp+7JmsKB5Eid5bDt5SDHd8Ra0VrDtW+qK2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758299781; c=relaxed/simple;
	bh=ZIBElh6XfzKS7nBD3Xz3/yBJNsr+KQSqvujpqD1Uexo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RThNxC91CpG61T7KCFS8ciezjAasLOR7O6RQPar2Bp7mf3Vn6bAPKnNDNm8QcSXzTSaU4+QH7etrAWaEwozzqcGJpXwscfG6kWso/t82udH1yBBD55RmCj+ooyEyQ1If6Im+mLAlPFewo1EYoJufxhHkY1bSmxsD+uoiENEvjpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com; spf=pass smtp.mailfrom=festo.com; dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b=wEbvaRtS; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=festo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b="wEbvaRtS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SReNNcfheGrHscdvInBkIpIr7wJFieyE32sJKWl/MOASFVLXESr463WipyMDoscXTzWeE+RWt8rLPLMXL+k1qRjS5TfElrEpkEW7y3+63h0gmQGgHnVJ5AMfqrbogQ+roFGIDNsFq0rTj9Ju6wuwFd3GzkI6yIh4drmlPBMvDO3XmHC2JxDbr/YYYsOTgaPaqzeroUaw18dR87Y+ULkQhkArL+d4ZKjobJaf5GzQgvLgixPRRV2LOalp8u0T7uqQ+dwJAc4JhADoSBjmJYqzkSKY3Igpt+2ycrw1EkTXrPj9xH2yubzhaV6j8k8qIe0AbBFcuh5UqKmXKuHeZ+CIPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEUTgya26Uu5bKs3rbKZhne2wK+47Y1cOez05iFT3JA=;
 b=QudualMtHBu1RKY8KGG4cB5WqiYK1S2DWSjQsF3ojknLS0orrmCVht3/ZJUj8IDwJ/5JxdKtT9M/h3m8gkx9VPl/jI/S2JwSLYruN1zas/5618n6Gr2Nk+Nl/9eIc7HbFCmCIcQsGY2g8hc68QKF3tmSeAdPsw2/u6wejRsuZPBxRu/MPLkrvO9RhEReWek7FanSZ5s1el4KdFUXN7VQfH9lKmTvE+6fDL/zfOsV4LugSkxKWCcO7rs4kpU+hdGiSsMXpEC8b1EHELp1HtVVXXtQUjcIpH95eqQ+UkHHP4r1ju48Krbn76OKvQT3ozcVIim+hbkPTB3IjZoo3ls/OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=festo.com; dmarc=pass action=none header.from=festo.com;
 dkim=pass header.d=festo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=festo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEUTgya26Uu5bKs3rbKZhne2wK+47Y1cOez05iFT3JA=;
 b=wEbvaRtS++9te7nDMGDAV9r9bgbDU9Yqz6ASpqXfu7GiCTTqqDExFpx3wr2u4SfKvU1ELQxQ/j35sqY1g1LJwt37aSg2qNgTUwpGD4hqABbqB2cEIn6ZxNJhbkrPC3oIpkJZF5gRKRKtnabkUr9Iopi8nwgntxzt2v0jFfTlcwI=
Received: from AS8PR03MB10056.eurprd03.prod.outlook.com (2603:10a6:20b:63d::7)
 by VI1PR03MB6622.eurprd03.prod.outlook.com (2603:10a6:800:17f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 16:36:14 +0000
Received: from AS8PR03MB10056.eurprd03.prod.outlook.com
 ([fe80::5350:1f43:188a:6db5]) by AS8PR03MB10056.eurprd03.prod.outlook.com
 ([fe80::5350:1f43:188a:6db5%3]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 16:36:14 +0000
From: "Xie, Nick" <nick.xie@festo.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Error during libevl build and runtime settings failed
Thread-Topic: Error during libevl build and runtime settings failed
Thread-Index:
 AdvhNCsPSr13v8uwQHKA1c0dN9vzhQhJ1t/wAAMSmAAAFusnuwfrxy3QAAfyhxgAKuLKwABgKnAqAQl7ioAAEisLgAAVEMvg
Date: Fri, 19 Sep 2025 16:36:14 +0000
Message-ID:
 <AS8PR03MB10056194CE9C24DCF7863A7478B11A@AS8PR03MB10056.eurprd03.prod.outlook.com>
References:
 <AM5PR03MB2882F5ED2ADBA37FAA9562608B7DA@AM5PR03MB2882.eurprd03.prod.outlook.com>
 <AM5PR03MB2882F38E95A99A0760C60D1F8B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
 <AM5PR03MB2882726DD078E29EB76589518B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
 <878qk3za1e.fsf@xenomai.org>
 <AS8PR03MB10056F9D6FBDE93A148E03F5A8B0EA@AS8PR03MB10056.eurprd03.prod.outlook.com>
 <878qimxczv.fsf@xenomai.org>
 <AS8PR03MB100561B2E374D4680213E55DD8B09A@AS8PR03MB10056.eurprd03.prod.outlook.com>
 <87plbuz9ib.fsf@xenomai.org>
 <AS8PR03MB100560006594FE9480F592EB98B16A@AS8PR03MB10056.eurprd03.prod.outlook.com>
 <08e34367-c342-48a9-91f2-09e00779d870@siemens.com>
In-Reply-To: <08e34367-c342-48a9-91f2-09e00779d870@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_ActionId=960f4394-bee2-46d5-bc5b-a850714e7326;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_ContentBits=0;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Enabled=true;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Method=Standard;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Name=Internal;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_SetDate=2025-09-19T16:21:33Z;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_SiteId=a1ae89fb-21b9-40bf-9d82-a10ae85a2407;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=festo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB10056:EE_|VI1PR03MB6622:EE_
x-ms-office365-filtering-correlation-id: 9dbeae86-00e1-4c67-a83f-08ddf79aa627
x-ms-reactions: disallow
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0an783LVrAszYYOJigGxE+JYkU18/8c6Gah0r4MjUk4sU6cOeMJI/kNBulqf?=
 =?us-ascii?Q?tHmxK++sPTJUnr2AHLuUU+ZC0px65T34yg/tbrOJKM1G8N3s8PgMQm4aqILM?=
 =?us-ascii?Q?91mmu29rOynTE1k+yfefV/cMmo2zCMWyN6PqHJ//2215P2omb4JqTSuwOXRz?=
 =?us-ascii?Q?uDjPtXShjeN7NAnhAnH9H8rzyCkpQSTuVVMK3eiwRrZQmZ06kt0ktkELr//L?=
 =?us-ascii?Q?WXMYFy02GFNeBbSJAsc6PssN+aFmDEsebSNQ0XaqNL0uexf0JLnv+HC4HQ6L?=
 =?us-ascii?Q?jJEOMkGzKdaimO7xVN+4Ux63rD+jgd6hVOJkoW9r0yUo5koIlxO1M4OULkat?=
 =?us-ascii?Q?dinnLs7XyFmcGBEPBVLo0KYQ3pqZAyGbch09NO/7jC1sbspYGNRWHWH5HIIl?=
 =?us-ascii?Q?7AK7XvTV/Ejf3LNVFbzvo9eDSPHMec6caOwYNV76vo+z/+miGQREyHomLtOx?=
 =?us-ascii?Q?3AuDeoWC7/nc0WN35ieLhlJkLxMPOc2qmAivgO14dRqYwfw4yeGvJjos5YMq?=
 =?us-ascii?Q?OPr/s6bY6asLToJX5C3dWp+Wc7HPjG4QN3DmCnV7c+yvifJlcEZ5prtDayKk?=
 =?us-ascii?Q?FeOFc92md8vq+J+EyVZwcT6tJu1I5HOpKxn+q4fom3ezt1Fzv5XBAcOWrXNf?=
 =?us-ascii?Q?AdkV4QMzBFfz1KdOalvUc+sEkdVx2IecCEqk738Ojz5kqqgIIhUgd7s62LYR?=
 =?us-ascii?Q?w9M0w5675KFNav4zLhyhWT0KtDncozqpnigYI22JMrQfCBziBgYnB2BdTQRD?=
 =?us-ascii?Q?BBpOD1HZDVspyYUPJOmCQ34d8YwXxMMwlvu/0A7N2Dw7KaUgPmHUCtG6CPLT?=
 =?us-ascii?Q?/0qeqhCm5If4dIwVm6w2yFspZ20zV//mqUasGzle9GN6zPmFCVOUCQ98qjk0?=
 =?us-ascii?Q?FdKVoCGxVwVLC8didAaIv6MeX4Qyu0h/J1zywDbnST2jQwuXtckEZiT1otCy?=
 =?us-ascii?Q?ltKpI1zdCcYrW+/z0X1aocQjI091LbTZ3BAeN3UutNi5qfn7q0DGRCZSek7b?=
 =?us-ascii?Q?N8LNBc92F/Z17PflqL7WHJ5wJGn09ePZG9vwNyH19+Fe+SXl261POZfgWSYH?=
 =?us-ascii?Q?UNPkOe23OTimwhsSLx4E+n9ajfr0Ejey3pVhzQF5JqUtTaV4S9gOigQ4xRm0?=
 =?us-ascii?Q?l8n2g9pyOjy5eQnvVKoIZj/CF/wxeYvZgkCk5dtISeOQSXf41D4MQCcqZxUC?=
 =?us-ascii?Q?s4qmtbq/9lThyBJ3pwc6gNYxwr4oxJaYIJ9gYy9mBMdQh7MINnZ4qPgT+TKD?=
 =?us-ascii?Q?CEeLwX4wqKcGWH765nxafXF3lsIYmo3mpfZIHUAa3e1w+p44nEfwbS/BGLLb?=
 =?us-ascii?Q?PwtGswvPU5aD7MHkYZOONJF1U111tJcJekGtvk07M1L6kj4VWBzmf7f6XSYT?=
 =?us-ascii?Q?Svr9QHigmo4ABy6+bdtEw8/M0utBHY1BjF1pvADPujYCutO8gk54KWCzE8Og?=
 =?us-ascii?Q?oYxqb+K0QYw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB10056.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mNVMuPBo3QIBT0TY+i8n5YlW/zwvj9LZjm0ZyFi7Mi/MOUdDsCr1a3A7RjC0?=
 =?us-ascii?Q?xlP2g/3HI+4xoBivkmCfCo2iTLeXXWJDVDnYiw4ehao/Fz5UJarsbRrw+N7K?=
 =?us-ascii?Q?1VQwGWiYSvEc4G1SY2R5i8hAwh5HNkfVEaAMF1TNosgT3RG7p6zGEKDhDQnS?=
 =?us-ascii?Q?968KwnoCXrQvSmz1AyIC1SP24w8T6/MQhcF3WH7GFVMV0j1oRQ7bAoxgi5IQ?=
 =?us-ascii?Q?1eAJ2eMJoLBXNx8+LYfVO9HSKkbB7EI4JMWwUuD0HzjhrBo3UiyUqseYOZPU?=
 =?us-ascii?Q?JWJ0hcugPE4wlowJi7A1k23ima+8TMxKFKwoGZgOfr4CXk3Q4SWrcKs/CO9b?=
 =?us-ascii?Q?oOPZHoBlCpb6JPSQouA5QuNYuAqJk4ZBDkgJSdqzCyw8a/sabSgIJbJReXGA?=
 =?us-ascii?Q?Mhymga83mDsHtoInMVAa80FsqzSLWtJBune+klvtUevH1tjJ0gzaFtetTzN2?=
 =?us-ascii?Q?YSjytx5wE5McIaZnxTKQV3Bzspe6Us1lGZWh4aFsaX5CAPFAyKZks8sEQMBL?=
 =?us-ascii?Q?JsgTZOVLkiSCoXW1vw4w4wCqVjTtgcOA6TNhknImRjQs3khUYU+PwzokU2F+?=
 =?us-ascii?Q?XESkNbVv95JT5eAFv2pH+HjkyQMEDHoSC+pNIgGEU82CJuKLtzuZHzAzqf5V?=
 =?us-ascii?Q?erqLy9ArF0OI4mNEMhfySwoBXEhQ2hnZrHG4LwnG6f5RvaLAQmhs7mEZaf2e?=
 =?us-ascii?Q?czbEC48oslJa4HJoq7HrOZ4aNu0sTUiYq1eH3KJjJw/wj+4y8IdKa9CiQx9J?=
 =?us-ascii?Q?MGRAFxVd6bjiPG6vaP4D/W/hr7rOgsPlBT8ERDtrsLzrv/ekAz73ESpx0HL6?=
 =?us-ascii?Q?HfdxjtfEGQnuK68Kq0fu2CYr7RzXcmQTodO2qAEGOzvHUGctF1weJEnt+fxU?=
 =?us-ascii?Q?AKApI47n0XRp3A/RZWz/opbGqXESMyJZMQ5iwVyUZtFQfqi8h/SmDvQ9lQ8E?=
 =?us-ascii?Q?1vLlCxFR4sKGWBsFBkZF9Uf81ZTpfBxMsp7wC86bIJkhSJbYKGLb4k4O5gVd?=
 =?us-ascii?Q?eB4PLSLsRnNIqMQSotfe4n7y1yH06st8h6XgRqEVCQL5dZTtcBCXbIyOp+CI?=
 =?us-ascii?Q?yDSd3GTPBuoahnotDf4ryJhUvFMKTr273I+hfvIb4/o/ejYFDuoWJuOcM+Zx?=
 =?us-ascii?Q?U4PhwO186uOlp2JoblI3Rg/sAAoAHm52DEt+lPo0MoRsAzDa7VmQGfRSd8pp?=
 =?us-ascii?Q?BTVtN1Dl/I91T9sgdyRym3MUIXbA7kcQNXc/zMsQTdxKIi4Z8Ut4TE0S2vHl?=
 =?us-ascii?Q?aFUDNW5lP+yo7Ggl4VDjDpc5FqDTx68DJl/rom3owFJ5mJ04dpV2meS4IM6s?=
 =?us-ascii?Q?xeS5ob9+7EXyehPVSdB3VxTvkFKhAHO+q0zxK2CxqyJPsGgp/VARgSxC6TJy?=
 =?us-ascii?Q?okF3CX/CY4wYDPVQYhiKppHFeqeUpzCKQlu9qWza/2LohOAPqZ1wN2fAgnMQ?=
 =?us-ascii?Q?ufI/kM0ViNfEzHHzBAn6p36Tv1ly4nqqCLLTI9nucB/3jV8N0cWpy1XOa2Ft?=
 =?us-ascii?Q?VSaWyif82fYQercrqcaz2W/11ovJ7uUjFgpvriKtk/QMlwnaJ8Lm1dF27oup?=
 =?us-ascii?Q?qXTjn+NWos5MZDnE+o4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbeae86-00e1-4c67-a83f-08ddf79aa627
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 16:36:14.0746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a1ae89fb-21b9-40bf-9d82-a10ae85a2407
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yUt4S11t1RDZtkgHJ8JYswSeFlhGEJLQdp3VTcfRAjQX800LbXCFETBFSvBhMESAeTIifw5sPYmIN3l6gEgfkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6622

Hi Jan and Philippe,

Thank you for your quick respond. Appreciate it. I didn't notice the error =
was generate in early stage. I have fixed that. I have built the kernel suc=
cessfully and install libevl 5.5 without error, but there is error when I r=
an the evl test. Do you have any idea? Thank you in advance.


nick2@Xenomai22:~$ uname -a
Linux Xenomai22 6.12.30+ #1 SMP PREEMPT_DYNAMIC EVL Fri Sep 19 07:59:54 PDT=
 2025 x86_64 x86_64 x86_64 GNU/Linux
nick2@Xenomai22:~$ sudo evl test
[sudo] password for nick2:
basic-xbuf: OK
../libevl/tests/clock-timer-periodic.c:43: FAILED: ticks =3D=3D 1 (=3Dfalse=
)
** clock-timer-periodic: BROKEN

Best Regards,
Nick Xie

-----Original Message-----
From: Jan Kiszka <jan.kiszka@siemens.com>
Sent: Friday, September 19, 2025 2:18 AM
To: Xie, Nick <nick.xie@festo.com>; Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Subject: Re: Error during libevl build and runtime settings failed

CAUTION: This e-mail is from an external sender. Do not click links, open a=
ttachments or provide your password, unless you know the content is safe! I=
f unsure, report the e-mail using the Outlook button.


On 18.09.25 23:58, Xie, Nick wrote:
> Hi Philippe,
>
> Thank you for your suggestion. After some investigation, my previous erro=
r is caused by I download evl as tar.gz(it is missing the hidden git folder=
), because my network was not stable. I used git clone to download this tim=
e on a virtualbox (it is easier to output the kernel console in serial)and =
find out the config file is the problem.
> I was followed the link(https://kernelnewbies.org/KernelBuild) from xenom=
ai.org. As it suggests using "make defconfig" which will generate new .conf=
ig file, overwrite one I copy from the current kernel. I used "make olddefc=
onfig" instead to fill in the config and it built successful on my linux PC=
 and I can start the kernel and the evl test correctly. I will continue tes=
ting tomorrow. But there is a problem with another test on my virtual machi=
ne using virtualbox. I followed the same steps and the error was showed bel=
ow during make. If I used "make defconfig", the make will be successful but=
 there will be a problem on boot. Do you have any idea? Please advise.
>
>   CC      kernel/tsacct.o
>   CC      kernel/tracepoint.o
>   CC      kernel/latencytop.o
>   CC      kernel/irq_work.o
>   CC      kernel/dovetail.o
>   CC      kernel/static_call.o
>   CC      kernel/static_call_inline.o
>   CC      kernel/user-return-notifier.o
>   CC      kernel/padata.o
>   CC      kernel/jump_label.o
>   CC      kernel/context_tracking.o
>   CC      kernel/iomem.o
>   CC      kernel/rseq.o
>   CC      kernel/watch_queue.o
>   CHK     kernel/kheaders_data.tar.xz
>   GEN     kernel/kheaders_data.tar.xz
>   AR      kernel/built-in.a
>   CC [M]  kernel/kheaders.o
> make[1]: *** [/home/nick2/linux-evl/Makefile:1949: .] Error 2
> make: *** [Makefile:224: __sub-make] Error 2

You always need to look at the first sign of an error, not the last one.

FWIW, xenomai-images is capable of generating full images also with evl (ag=
ain - changes in next branch only), for qemu or real x86 hardware.

Jan

--
Siemens AG, Foundational Technologies
Linux Expert Center
