Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013062.outbound.protection.outlook.com [52.101.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B92021D3C0
	for <xenomai@lists.linux.dev>; Sun, 21 Sep 2025 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758489979; cv=fail; b=hZCOYY36E0N1V0aAI8LWiEZxJauLj5faoecizU7XUrfoMiw586v+3UUpbGEFuzyjtDf3DWGaECB4tKKELlBgfGgC+d1ktiJYRblOPX2ZRQ5DlDdFDbNph05s5w+/5FlTgrKf9Fi1HYrSP7alcIzS838/LCjoqXc5AYotd/mmGHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758489979; c=relaxed/simple;
	bh=EGNyo0J2MoEXOyHX/NkB90NLHEYadaL4Sd2u+1OoC1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cis8c7s1MidWkq27RrzMFvrm2NJsEnS+vxUeS7LBhCondwVAXM0jkR4sdTQU2wXAv18MVk+PElwDwUsmsgVAmQuZll5ZPlUe82MoF6Nq1C7qKCTkgog/q/c857VfvDjtqcmVBgiKuCKWIITtmgGIJW6dOFQAy7ZPjJlCheMOOlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com; spf=pass smtp.mailfrom=festo.com; dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b=QB/jRiSk; arc=fail smtp.client-ip=52.101.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=festo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b="QB/jRiSk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wli2tjRT8FFsV+E8a6zN5Fn2xAWyJWJs5KywVCYAFEmGL64WRmuV4ptqiS+pT7Rwn7qnyiWfG7g/j5EM9dvKoLr5PgMplZsslu/JNGslghGE8oQmhcHxrOQ0MKVljVY7jQKnwLz1LqFCLiR7YLqM7a5GmrMpw8ojzFXYkWKOUOK7BwQu5i/L+dq/YfdlCzgFdZRo0wq3vB0cykxYXDRMKZPesfTzWZ+hKGU86ofb95ARF/ATSBI/9uspD/S2KPtYhRsF2G2b2dp6k3hZuvfbdu0zUW8EwkgLJQiJw+gFnxlASS0OF7XnJWM+PiT33jX1uG27hXkAY2c4aTfRnD/MeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbxVdVDpyn5Vnv6COsc1Qwdj9ngtWUTSnq8tciDkKaQ=;
 b=gpAIOyrLhpvWQx6TIGHIAPRaVcGzA9AwJdV/d0K8jFxynY4BLAU55V5bx4pnWR/F9Gg/ahtVfFyFvjkx0upwZy13DfvLWIyVHR6cilG+Xd/evtAqf8picP6FSK/t0vByv2vrhS6DnZT8q8ZzVDC9qoGetZcDzZkX6eZs+rFwHpDHXAkvmsqb4M2iUDfJomzf4uYYxQL5MLOsC1kDEtDEaQM9P+PgBGqMZukyBgbbYHERio1aSqJdroygpNURPIsKhuBj+AcaU9eiOVmnDmdLJS9c3rVKx3UCwNq2QVa8lmGonRw0SR97qKV6tcowROeGbowa/2h2j3CUy+gv5pi8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=festo.com; dmarc=pass action=none header.from=festo.com;
 dkim=pass header.d=festo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=festo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbxVdVDpyn5Vnv6COsc1Qwdj9ngtWUTSnq8tciDkKaQ=;
 b=QB/jRiSkIEbvQ63zVZAqo+IzpRFQzYPQontrFYX3qvJ1Ij4KuwFr+jdBDhE7606b4T5Ps1P5piFq4BNRWS7hqqgWOZLdWcKqJTtz2qxCTE46K+NJhxpVh5s1YTqCpidF0PSXxpDfDrVNIvW7+zDhLYjxE9wKF+Cw9xlGDBd+5IY=
Received: from AS8PR03MB10056.eurprd03.prod.outlook.com (2603:10a6:20b:63d::7)
 by PAXPR03MB7713.eurprd03.prod.outlook.com (2603:10a6:102:205::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Sun, 21 Sep
 2025 21:26:08 +0000
Received: from AS8PR03MB10056.eurprd03.prod.outlook.com
 ([fe80::5350:1f43:188a:6db5]) by AS8PR03MB10056.eurprd03.prod.outlook.com
 ([fe80::5350:1f43:188a:6db5%3]) with mapi id 15.20.9137.017; Sun, 21 Sep 2025
 21:26:08 +0000
From: "Xie, Nick" <nick.xie@festo.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Error during libevl build and runtime settings failed
Thread-Topic: Error during libevl build and runtime settings failed
Thread-Index:
 AdvhNCsPSr13v8uwQHKA1c0dN9vzhQhJ1t/wAAMSmAAAFusnuwfrxy3QAAfyhxgAKuLKwABgKnAqAQl7ioAAEisLgAAVEMvgAG5y25A=
Date: Sun, 21 Sep 2025 21:26:07 +0000
Message-ID:
 <AS8PR03MB10056E8AC01A0C90B520575328B13A@AS8PR03MB10056.eurprd03.prod.outlook.com>
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
 <AS8PR03MB10056194CE9C24DCF7863A7478B11A@AS8PR03MB10056.eurprd03.prod.outlook.com>
In-Reply-To:
 <AS8PR03MB10056194CE9C24DCF7863A7478B11A@AS8PR03MB10056.eurprd03.prod.outlook.com>
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
x-ms-traffictypediagnostic: AS8PR03MB10056:EE_|PAXPR03MB7713:EE_
x-ms-office365-filtering-correlation-id: a33bcd27-50a6-477d-31ff-08ddf9557a96
x-ms-reactions: disallow
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IhS0hZNOWJYs4f+IoO+T1B/2JdJR5X5sCF2Rp1nh8k/91gTQlGVNKKf7mjbk?=
 =?us-ascii?Q?1MPzKoIMudhSwNLTQd9H+isYkldr5508N9tdJFJ/mQWlVU/ElmMEk7nKVa5O?=
 =?us-ascii?Q?Hn+46pLK3AoOlbXrih5N4igpqmAzm+a7De/CO2N2PoHc5CGKsFWrnfkHjTc7?=
 =?us-ascii?Q?VtusDX5OwnWAprBWDpuxpbVTdVO3ZftnQk74B6OVrrw8CUMhzwGnERs7zjPi?=
 =?us-ascii?Q?bitQ+X8fIjBwBaj3XtIAiZhNOKTqutiGEDrbqVsvricU2Y0JtvUeJjssEs7m?=
 =?us-ascii?Q?4nKzsJwQ6fNwSiVyEsuIW0jU/l5cqVNR4jCaqFtG20dGF2j4KhOuexfPpz7Y?=
 =?us-ascii?Q?Zr1TUpmUq+LGP8KNxrFiDo7/CJSlwPerivJN1Y/hbADUHnm//jocrAw0n35U?=
 =?us-ascii?Q?EQFBmNJnqvkBGSRmhVKXJsQeFNEb9S5uydcBJ7TLq99UO4gAgnqYDXI/+wTI?=
 =?us-ascii?Q?L2Po6MSIZNdlO4SaLjO1RRTr8UMNl0iKj57gJIZ/s/9/DxF3G1unutPbZq74?=
 =?us-ascii?Q?KkqDcu2OkrFg/ATbuCzAA081xqfRWkIOT7dirVVI66QsaDkDorNa2KJ2ijek?=
 =?us-ascii?Q?qkqFLodihSYN7dClQPket/S201HEMLKdcMlsmBxWSHw2wMKhCXwsLQ6sqV2v?=
 =?us-ascii?Q?tocUTSvfsWUTLuYxtFumZR7OPO8zjHx5MoYI+tOKEp3t2+CxaPQcNJ3LLcq1?=
 =?us-ascii?Q?KyiAB0bHGzr9T7U6yaaPZ7KTcrEF56EL21mdoz1QliBwqhe58r+7iTzLoDmY?=
 =?us-ascii?Q?xccdhl6VDegrKXYtTwscdLWQxoklHRFg0DueHCCd8nL6elpcN4vnigGtRBZp?=
 =?us-ascii?Q?S3vTdn+0Hi2mIN99afANNJ7swEbsssvkxclMe9MCej7rbC0Dwt+GpuSuR6oQ?=
 =?us-ascii?Q?a81lQOG/bVvD9KBGPbjqQamHABQUsK3BPRj6bQH9h41sY1i1fes5jNqEI8f3?=
 =?us-ascii?Q?PPpUG9OKtexRk7ggenpzYpT+GvnBsCSHse5pfT2HBimiZ/FnfGLrbkZJb+f7?=
 =?us-ascii?Q?AguYJZEp8cN4+H7E6cDCdbZxt1V8ryHCfWa6UK6BDiRzby9UVvw7bzgLT309?=
 =?us-ascii?Q?43KCYb7y1/V1nIIojF6ZXmKErFeMCn4QUSDG0QokUMPYvWgp7/oMeDX9l0Ob?=
 =?us-ascii?Q?osofWtA09sI7gm+wPHaYg/oSJvUOgmE91bLGI8vwVUzI34/wG9R44YteKzwL?=
 =?us-ascii?Q?inJWTdNMIcTB2CH/hPRvInTYo4dubZl/0Gwhp+rfPDLtz79+V2u+m+tz/wD1?=
 =?us-ascii?Q?oX92Bv3UDLwCVpjba55rTucchP/TF2ZWbautYaYV5wtFfDyAdyWKkw1w4gGK?=
 =?us-ascii?Q?7AjDlcXLYKYKqO1rzLNtjX+8RMWj3U2BGfcKA3gRI2i4xw9rAglwB6FdKTjy?=
 =?us-ascii?Q?5KP5zeBigO4TLAPR/eQcodOJSsQzYrN2vFlT3cM6ChobqsE2DRAVM1OhoAgH?=
 =?us-ascii?Q?aHEWdmXxOFI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB10056.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hnP4g5k8Nz4su2a2bCBYAczkkf1GmAyo63djAsgfg2AwSASdxEUsxx2G4Hab?=
 =?us-ascii?Q?QAKSyr99oiubIJBS184uR0IUN4gE5n3xEYenUuAnizMnXYgfwdNN/zGUpvDk?=
 =?us-ascii?Q?6ZKfkOEZdMO2q7OPrEPWji11YFpzGXqQJcQc889F21RzzQDbYlvitzo339c0?=
 =?us-ascii?Q?li9RvwqJ8Kwj2nanmc0qqX4KutAk5ILZJ3O6hZCraK7hIYbSHXeYXOt0RTlk?=
 =?us-ascii?Q?JSYoUqYz1/uGu9Y4FlzVt/Z4ozKMEg+fthkGzeQtmrZOS9EnDpoYDhYalUO+?=
 =?us-ascii?Q?JoUSB9aP0Ba86woSfGCWzQnS2VTG0geizOveEIYfBNjGKYpWT/FVEkeVaU+H?=
 =?us-ascii?Q?/xD2gRAhG3mSk7Z0T1HtrbG4EGoa0U1bGW4bfV4aAYUxOQfwik/AJlJW3JR9?=
 =?us-ascii?Q?MWxKUu24XcmdCa+G7H0jOA00gguJt0rVc7OXY/s+etIJU9B7nISf6jr8XPQa?=
 =?us-ascii?Q?2eoaBHgHZceEzIsJweEpzhsVYAwqZnl4+4HeBgmJYYDQGxuEw2/BtP9AQRmc?=
 =?us-ascii?Q?41HvgW80vt2omP7fJqvT1yajGx3GUj8iKe64qD0R+5DLPZAwmguwSILELFRq?=
 =?us-ascii?Q?eh/VEIunBa/ouLPJw41FZgJ+tgJfSdL910FwxuUKGS22VKR4y8AlOJxLfgUl?=
 =?us-ascii?Q?8cNLZ2EnpoSwjQzKMK+uzjAqrT5HTfQhzuc5A+zTUIzu4aJapuFFW2M7BZNZ?=
 =?us-ascii?Q?Gs7+SM4LE7phi/SCGzkXpsB69AoNvdLVC1se9galFQY2krETKH+3INtPa6nA?=
 =?us-ascii?Q?9sttihNzpapkmpe9OmxghsglkzkAYQr2//HWApA0foNAdPIJ3MsSLDWUwdIc?=
 =?us-ascii?Q?j0pTUxI/cuxv08LPvMqRtBz0V6LzMHmuRYcqSPmzLZmvx6Xjmb1f6UWI1fUI?=
 =?us-ascii?Q?Qc+FnfH8xoUTGgnUGj/RSsV2rB7yIdU/IxVJ2fQYPFpG7HRdRzDQ1MRzQb5V?=
 =?us-ascii?Q?HGprgLN8VXzlb+q9KZVcDYKI0CoCJlPH5B680Fc0/+Nnb59oHB7N+alKQo1a?=
 =?us-ascii?Q?PVDtHK1T0aC9piKvDPpPUy8WWbUCkrqKBUT0j6ov0UuAhTikrj1IUNcfhcwQ?=
 =?us-ascii?Q?dRPw1iHAUhSq7yCvYxB7f6tTZpRCcgd4WcCfzyXuIRjsGhL8+BRof1BdEXzq?=
 =?us-ascii?Q?RIeHeJE2ClEmGNqKxYmNuyiUHr1qrfRQnbwFVreeXw5M7yuUF7GWapoCG6cP?=
 =?us-ascii?Q?RikmN7G3MFrJxMnCbnlTMZOllbkdWh5cbU7tLqjGmdoya+IfyXyDxQ+UsJWs?=
 =?us-ascii?Q?0ajvxcMCN/C7A8UWSOwwriQ4CaqiHYnoi4j3JiRF/Bo83TVPcO3zAcTHBSKg?=
 =?us-ascii?Q?X4B+U9v0r4WjDKgu/Ss5PektdOs+EsTlLYTgkViA0xr+y9DCgq9I1sZo5fzQ?=
 =?us-ascii?Q?erbmqfNaGvaM4gt5ZSvdGBJrf0GCAeVJ0kEQmzk989IQo9Z+yLg4OVDk3knc?=
 =?us-ascii?Q?r/z96ugTOjJr6AZgjpeK1s3usyC0h5XDkhsV/gXCviT+4C9KKNghNuRekduY?=
 =?us-ascii?Q?1JdImoWiBl90mZcN2mZE1KzzRyIi1VkLOZkUCIzdcv4SJnYlrKmOVqjSTJu8?=
 =?us-ascii?Q?i5/9CyZcj21JBQCssWQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a33bcd27-50a6-477d-31ff-08ddf9557a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2025 21:26:08.0633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a1ae89fb-21b9-40bf-9d82-a10ae85a2407
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rD2tPAJLsqt9LBMGbOUX3qF9PsluZWxjoFcKuozTHqNw7CEeoPlrQes4x14zBBCxk0LeVPkWFoDxFaaKStagfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7713

Hi Jan and Philippe,

I resolved the issue from last email. I thought it was caused by virtualbox=
. I used Vmware workstation to ran the installation again. The problem went=
 away. Please see the evl and latency test result below. The actual Linux m=
achine was running much better than the virtual machine, but I were still s=
eeing about 200us latency. Xenomai's latency could tune to <30us. Is it tur=
e? I have a few questions below. Please advise. Thank you in advance.

1. Should I run Xenomai in virtual machine? Does it affect the performance.
2. How can I improve the latency? (I am going to use it to build a EtherCat=
 master) Is there any hardware requirement?

Both machine are Ubuntu24
1. Machine one 4-core Ubuntu
ick@nicklinux:~$ sudo evl test
[sudo] password for nick:
basic-xbuf: OK
clock-timer-periodic: OK
clone-fork-exec: OK
detach-self: OK
duplicate-element: OK
element-visibility: OK
fault: OK
fpu-preload: OK
fpu-stress: OK
heap-torture: OK
hectic: OK
mapfd: OK
monitor-deadlock: OK
monitor-deboost-stress: OK
monitor-event: OK
monitor-event-targeted: OK
monitor-event-untrack: OK
monitor-flags: OK
monitor-flags-broadcast: OK
monitor-flags-inband: OK
monitor-pi: OK
monitor-pi-deadlock: OK
monitor-pi-deboost: OK
monitor-pi-stress: OK
monitor-pp-dynamic: OK
monitor-pp-lazy: OK
monitor-pp-lower: OK
monitor-pp-nested: OK
monitor-pp-pi: OK
monitor-pp-raise: OK
monitor-pp-tryenter: OK
monitor-pp-weak: OK
monitor-recursive: OK
monitor-steal: OK
monitor-trylock: OK
monitor-wait-multiple: OK
monitor-wait-requeue: OK
observable-hm: OK
observable-inband: OK
observable-onchange: OK
observable-oob: OK
observable-race: OK
observable-thread: OK
observable-unicast: OK
poll-close: OK
poll-flags: OK
poll-many: OK
poll-multiple: OK
poll-nested: OK
poll-observable-inband: OK
poll-observable-oob: OK
poll-sem: OK
poll-xbuf: OK
proxy-echo: OK
proxy-eventfd: OK
proxy-pipe: OK
proxy-poll: OK
ring-spray: OK
rwlock-read: OK
rwlock-write: OK
../libevl/tests/sched-quota-accuracy.c:213: FAILED: evl_control_sched(44, &=
p, &q, test_cpu) (=3DOperation not supported)
sched-quota-accuracy: no kernel support
../libevl/tests/sched-tp-accuracy.c:222: FAILED: evl_control_sched(45, p, (=
(void *)0), test_cpu) (=3DOperation not supported)
sched-tp-accuracy: no kernel support
../libevl/tests/sched-tp-overrun.c:220: FAILED: evl_control_sched(45, p, ((=
void *)0), test_cpu) (=3DOperation not supported)
sched-tp-overrun: no kernel support
sem-close-unblock: OK
sem-flush: OK
sem-timedwait: OK
sem-wait: OK
simple-clone: OK
stax-lock: OK
stax-warn: OK
thread-mode-bits: OK

sudo latmus -m
warming up on CPU0 (not isolated)...
RTT|  00:00:01  (user, 1000 us period, priority 98, CPU0-noisol)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|      0.479|     11.304|     73.482|       0|     0|      0.479|     73=
.482
RTD|      2.134|     66.364|    167.666|       0|     0|      0.479|    167=
.666
RTD|      2.679|     70.065|    164.169|       0|     0|      0.479|    167=
.666
RTD|      2.486|     61.561|    127.858|       0|     0|      0.479|    167=
.666
RTD|      4.370|     62.240|     76.170|       0|     0|      0.479|    167=
.666
RTD|      4.220|     82.704|    193.732|       0|     0|      0.479|    193=
.732
RTD|      0.180|     99.642|    202.283|       0|     0|      0.180|    202=
.283
RTD|      4.316|     98.797|    207.727|       0|     0|      0.180|    207=
.727
RTD|      7.103|     63.529|     78.923|       0|     0|      0.180|    207=
.727
RTD|      4.281|     76.397|    194.532|       0|     0|      0.180|    207=
.727
RTD|      1.636|     65.308|    187.265|       0|     0|      0.180|    207=
.727
RTD|      2.314|     67.532|    192.044|       0|     0|      0.180|    207=
.727
RTD|      4.585|     63.799|    153.583|       0|     0|      0.180|    207=
.727
RTD|      1.563|     63.780|    120.452|       0|     0|      0.180|    207=
.727
RTD|      3.757|     63.276|    123.750|       0|     0|      0.180|    207=
.727
RTD|      3.794|     62.681|    120.261|       0|     0|      0.180|    207=
.727
RTD|     -0.022|     80.300|    209.774|       0|     0|     -0.022|    209=
.774
RTD|      1.381|     63.559|    161.354|       0|     0|     -0.022|    209=
.774
RTD|      5.056|     63.004|     75.401|       0|     0|     -0.022|    209=
.774
RTD|      2.896|     61.048|     74.324|       0|     0|     -0.022|    209=
.774
RTD|      1.338|     61.750|    187.294|       0|     0|     -0.022|    209=
.774
RTT|  00:00:22  (user, 1000 us period, priority 98, CPU0-noisol)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|      0.512|      7.897|     70.633|       0|     0|     -0.022|    209=
.774

2. Machine 2 Virtual Ubuntu using Vmware 8 cores

nick@nickvm:~$ sudo evl test
[sudo] password for nick:
basic-xbuf: OK
clock-timer-periodic: OK
clone-fork-exec: OK
detach-self: OK
duplicate-element: OK
element-visibility: OK
fault: OK
fpu-preload: OK
fpu-stress: OK
heap-torture: OK
hectic: OK
mapfd: OK
monitor-deadlock: OK
monitor-deboost-stress: OK
monitor-event: OK
monitor-event-targeted: OK
monitor-event-untrack: OK
monitor-flags: OK
monitor-flags-broadcast: OK
monitor-flags-inband: OK
monitor-pi: OK
monitor-pi-deadlock: OK
monitor-pi-deboost: OK
monitor-pi-stress: OK
monitor-pp-dynamic: OK
monitor-pp-lazy: OK
monitor-pp-lower: OK
monitor-pp-nested: OK
monitor-pp-pi: OK
monitor-pp-raise: OK
monitor-pp-tryenter: OK
monitor-pp-weak: OK
monitor-recursive: OK
monitor-steal: OK
monitor-trylock: OK
monitor-wait-multiple: OK
monitor-wait-requeue: OK
observable-hm: OK
observable-inband: OK
observable-onchange: OK
observable-oob: OK
observable-race: OK
observable-thread: OK
observable-unicast: OK
poll-close: OK
poll-flags: OK
poll-many: OK
poll-multiple: OK
poll-nested: OK
poll-observable-inband: OK
poll-observable-oob: OK
poll-sem: OK
poll-xbuf: OK
proxy-echo: OK
proxy-eventfd: OK
proxy-pipe: OK
proxy-poll: OK
ring-spray: OK
rwlock-read: OK
rwlock-write: OK
sched-quota-accuracy: 80.8%
sched-tp-accuracy: OK
sched-tp-overrun: OK
sem-close-unblock: OK
sem-flush: OK
sem-timedwait: OK
sem-wait: OK
simple-clone: OK
stax-lock: OK
stax-warn: OK
thread-mode-bits: OK
nick@nickvm:~$ sudo latmus -P 10
warming up on CPU0 (not isolated)...
RTT|  00:00:01  (user, 1000 us period, priority 10, CPU0-noisol)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|   -929.993|    174.488|   2600.458|       5|     0|   -929.993|   2600=
.458
RTD|     18.963|    297.375|    983.319|       5|     0|   -929.993|   2600=
.458
RTD|     19.865|    298.184|   2808.978|       7|     0|   -929.993|   2808=
.978
RTD|   -979.453|    -19.014|   1014.285|       8|     0|   -979.453|   2808=
.978
RTD|   -911.677|      7.487|   1587.974|      10|     0|   -979.453|   2808=
.978
RTD|   -979.476|   -677.605|    -52.038|      10|     0|   -979.476|   2808=
.978
RTD|   -918.623|     95.344|   2168.010|      12|     0|   -979.476|   2808=
.978
RTD|     84.914|    365.212|    963.395|      12|     0|   -979.476|   2808=
.978
RTD|   -919.064|    -66.003|   1421.899|      14|     0|   -979.476|   2808=
.978
RTD|   -930.611|     71.721|    754.604|      14|     0|   -979.476|   2808=
.978
RTD|     63.837|    359.260|   2245.524|      16|     0|   -979.476|   2808=
.978
RTD|   -910.610|    181.606|   1004.474|      17|     0|   -979.476|   2808=
.978
^C---|-----------|-----------|-----------|--------|------|-----------------=
------
RTS|   -979.476|     92.452|   2808.978|      18|     0|      00:00:12/00:0=
0:12
nick@nickvm:~$ sudo latmus -P 99
warming up on CPU0 (not isolated)...
RTT|  00:00:01  (user, 1000 us period, priority 99, CPU0-noisol)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst
RTD|     68.162|    391.712|   1611.035|       2|     0|     68.162|   1611=
.035
RTD|   -912.291|   -475.666|   1010.092|       3|     0|   -912.291|   1611=
.035
RTD|   -918.423|    119.871|   1937.203|       4|     0|   -918.423|   1937=
.203
RTD|     60.344|    387.485|    903.844|       4|     0|   -918.423|   1937=
.203
RTD|     76.729|    388.215|    980.691|       4|     0|   -918.423|   1937=
.203
RTD|     71.667|    379.802|   1528.251|       5|     0|   -918.423|   1937=
.203
RTD|     64.122|    391.833|   1084.815|       6|     0|   -918.423|   1937=
.203
RTD|   -923.345|   -162.983|   1046.850|       8|     0|   -923.345|   1937=
.203
RTD|     56.628|    402.514|   1140.448|       9|     0|   -923.345|   1937=
.203
RTD|   -911.562|    231.340|   1141.412|      11|     0|   -923.345|   1937=
.203
RTD|   -928.371|   -361.258|    869.662|      11|     0|   -928.371|   1937=
.203
RTD|     71.141|    396.117|    976.691|      11|     0|   -928.371|   1937=
.203
RTD|     63.273|    393.677|    946.488|      11|     0|   -928.371|   1937=
.203
RTD|     70.335|    401.533|    942.252|      11|     0|   -928.371|   1937=
.203
RTD|     71.243|    395.450|    857.735|      11|     0|   -928.371|   1937=
.203
RTD|     66.630|    401.924|   1087.476|      12|     0|   -928.371|   1937=
.203
RTD|     68.832|    396.441|   2199.416|      14|     0|   -928.371|   2199=
.416
RTD|     83.153|    388.793|   1171.043|      15|     0|   -928.371|   2199=
.416
RTD|     76.944|    406.898|   1074.956|      16|     0|   -928.371|   2199=
.416
RTD|     71.327|    394.167|    986.145|      16|     0|   -928.371|   2199=
.416
RTD|   -944.379|    -77.007|   1662.945|      18|     0|   -944.379|   2199=
.416

Best Regards,
Nick Xie

-----Original Message-----
From: Xie, Nick
Sent: Friday, September 19, 2025 12:36 PM
To: 'Jan Kiszka' <jan.kiszka@siemens.com>; Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Subject: RE: Error during libevl build and runtime settings failed

Hi Jan and Philippe,

Thank you for your quick respond. Appreciate it. I didn't notice the error =
was generate in early stage. I have fixed that. I have built the kernel suc=
cessfully and install libevl 5.5 without error, but there is error when I r=
an the evl test. Do you have any idea? Thank you in advance.


nick2@Xenomai22:~$ uname -a
Linux Xenomai22 6.12.30+ #1 SMP PREEMPT_DYNAMIC EVL Fri Sep 19 07:59:54 PDT=
 2025 x86_64 x86_64 x86_64 GNU/Linux nick2@Xenomai22:~$ sudo evl test [sudo=
] password for nick2:
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
