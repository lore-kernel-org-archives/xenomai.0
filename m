Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7131819D093
	for <xenomai@lists.linux.dev>; Tue,  7 Jan 2025 22:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736290284; cv=fail; b=FjDuYID2YVA7C4n1CN7Kwr6OGTcyJq7erQjKYkZgTNrkEXgiZUYhRzuaBk1OkqGAFVX4zPf2p4/qSzSGCgBEX9SftUQXbi0EhHmuKkTk7VAeKsxGSFwrSGHUV4zU/GkTEaDvlvVNJC7EdAvYuqdT2CEe49nZFnBspX0b420NewI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736290284; c=relaxed/simple;
	bh=0MXqKUj7TccOfcodXe5egwYswqfTjF8PopKxunXNPdk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EZmL8bn/9d7SYDfRQ8yPsDqDUnJw87PFvdZOWG30A77agSxH/LeXpB/nba6vKq+j5zsPIG5VgSLFHBkFHlOtPdIxB3EqhOfR587FmeS8V56uSDxdC/ssS7BoDr9TnG55fRxB2UyK9wkSeBhs1IgpunIAnKRXXN9HbqQlw9qOMt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mts.com; spf=pass smtp.mailfrom=mts.com; dkim=pass (2048-bit key) header.d=mts.com header.i=@mts.com header.b=A1joYbx1; arc=fail smtp.client-ip=40.93.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mts.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mts.com header.i=@mts.com header.b="A1joYbx1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2+byAONucKs97km9M/gCWxSgPl5mhAMGsvwH3WV/gA0+X5j3PLkWSQHqQn/N5MV9uC3O8kN+Cp2zplDIhwXEvlpodTP0kGx05emUG168ojeyPns8qs4CoPZz9054GNWcGb10+I+1IOprlG3+480E/omz6a9tStI0XHXddnNgxJyt3zVrh8Es/Sk7G2wvQ7x3tVamRttw302V2LAoiT8jX1fduit2FOVKsdrbUkAo66cMinm03PfJkUm7Oq8dtYeitbIojymlAokSJzKTXVBqQ3eNTsfdhTct90PhXnWtpHxnYEuvLkM3BjkxHvl/ehrWNRZifGXWJy5C2QVvKl4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/F6P4F3sCgqexWe0OPlW9TcPzVYm3LXkQLvf1RrFVA4=;
 b=aLx4df0PCjJi5+h94CDP5FS57EBUQPNQQQ3SN6nolZZERhynVhJY1W93Ro+31WfQVBd7qtIRoYDepIWAdQElqCfFblehpkrtvLu7zaxsg5jaiC74ibQGswEFs0Gb7JPimgZdZ37IuNVjhPnuiHlh9bM79W8wj/YSPysq1OvBr6Qlz99FkfwNNAs4G+OigokmGV1X27Mk8lnAYb9JGJr6RHeYKDOfd6Ph/Bhx/C2mXv975CAdkCIPMWV9G16iCVz7C2oEcoOE4Q7HQMuJBcKC4TpLvEVb8Ac0OjHC9s3+avxr5tYinUcgkpB/3z6p6/gvtb4by/r1gAQrg0LoBqTbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mts.com; dmarc=pass action=none header.from=mts.com; dkim=pass
 header.d=mts.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mts.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/F6P4F3sCgqexWe0OPlW9TcPzVYm3LXkQLvf1RrFVA4=;
 b=A1joYbx1oZpTANkMc1A1D1drzpZB46/BUpaI0LZD8R0rtP0aq2WsJ9Tt8XMSos2EPJ+afs28ZPgiJv+9f0P5g0Lg7wGCzSvbPnqrmH+JEiKOMmq+Q6jNVlBk04PzHTamXC4pfYdlLQOeA+a0j7gruOy2Z2q+ggeO5T/GCsd6mJ44GmJVRtRRLEwZWsIefaqRaUmXa2FoPw7APx0oeYaJRbj5wpHpobnuJR7Twf8GIqO7GhxtESVx4Jj3P8MWKVBROYK+UW1aKWk1nkAtsMm9yZwdgjKXHPaLf7afqFTQPAqR0K4tm1rR0p10sZcKfahlr6csTToEakLRSu1k1LaEgg==
Received: from MN2PR04MB6255.namprd04.prod.outlook.com (2603:10b6:208:d5::11)
 by CO6PR04MB7553.namprd04.prod.outlook.com (2603:10b6:303:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 22:51:10 +0000
Received: from MN2PR04MB6255.namprd04.prod.outlook.com
 ([fe80::a3da:79ff:4eae:2040]) by MN2PR04MB6255.namprd04.prod.outlook.com
 ([fe80::a3da:79ff:4eae:2040%3]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 22:51:10 +0000
From: "Rosenow, James" <jim.rosenow@mts.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Relax tracing not working for me
Thread-Topic: Relax tracing not working for me
Thread-Index: AdthVp/pSYw8A5rtQ5GCNa1Z0i9TVg==
Date: Tue, 7 Jan 2025 22:51:10 +0000
Message-ID:
 <MN2PR04MB6255403DD160D9EDA3319AA5E2112@MN2PR04MB6255.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mts.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6255:EE_|CO6PR04MB7553:EE_
x-ms-office365-filtering-correlation-id: 02571486-b3c8-4137-ebca-08dd2f6dc7ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?T6bNUiKfGbLo5zbbDMqeI6weuX2+J7zamoOillLkaDtuxwf6bFF46JeDig4Y?=
 =?us-ascii?Q?V6+P8PUE13rarW/I0d5wLRBoLvdprDlrqQyKkcgiUz9TTcttp3uFBSMfo4hC?=
 =?us-ascii?Q?SsSMh6Mk17TZE+yAPcoZQo1/yJZBWBavHzO6RzB9GvoHovmEjl+XDa7X8Arr?=
 =?us-ascii?Q?dxVKJN0zh5r3g2GbtwN2E+TFbxognXNl03l6mtvqQvXHtPIMLigbaE90gk77?=
 =?us-ascii?Q?Tk01cq+cI5GcNqTEYwoHZTO4HbEHc1C/SeQid1Tg2jbidq+HbT9me3CBiVut?=
 =?us-ascii?Q?V12pWHWPtNnzXNDgB06dXKiCjEOXo/YIY91yCwDbWdKCkkvWIg5cQNYy7HVG?=
 =?us-ascii?Q?hEQeeGsU5DHa/ZGuZPaXpkOAZCyxWNOBe80r4wp0G0vsUv+7sA7avMeWectr?=
 =?us-ascii?Q?mHjMaTNCCs2qaX99CkbR2Vzn46xfgAMki8o6A1sJL2r6LdLDxxrz9tHH1Xp1?=
 =?us-ascii?Q?pPg6OvsxxOQg72YAf/nvFUDb5d7dsxqLl3uYR/chGhSdSquZx0EhOZkFdUy3?=
 =?us-ascii?Q?tBAZEJXRtfPzud9ZKQXhTYx+OOj8cknLbB5U/pypiKWYOyGgu2J1mv+g3MF3?=
 =?us-ascii?Q?mq3F0vjbUpBMQn0ANT52CY7MwWCJvj4M/ODSnCp2MSZnZJBtTlrhklzSrw5n?=
 =?us-ascii?Q?A/PtnGO8mFaI1gW7J7MqsZqjuV12Z5ZWgjAcBueBuw2r4HXMwjaTvnbvP6pE?=
 =?us-ascii?Q?yyIIX8j0iwknztNfJZ4xUzqDCn8+2B1Vn/AYsYSJzpTa2UzjVbo8rLRH4lMz?=
 =?us-ascii?Q?HpF1b3Hl2X1RLT4TMW9c9yAMXJCnYw2TG4GGhkPvR+rEui4+45oNsNdv83Uy?=
 =?us-ascii?Q?X1u7BDi/oHZ6ZLKrESQy0tmwIT2I4BoFEsPR+srB2LQtQ9vlaVzcmrNa7/Bw?=
 =?us-ascii?Q?cUdL9EGsizhtVdWlpg0LAzVpduR4Np01iGmGwQkgRxwYN0BROJugpoVsLZf/?=
 =?us-ascii?Q?1j/0mIvDuMlhZ1NXbahBXYqSbwJ7CFlNyqqnAuG631gCipqcnM43nDcDJw6w?=
 =?us-ascii?Q?wfpaqcLGjnAPi8xgFn4+wjXqZHy2TAyU81YguoHnNe+Xpf5ML8s6z3SwMsH6?=
 =?us-ascii?Q?rzKgw8xtUrQbGWcz05wmBT658dRZulKpEUzrVLI6vVl6KAuJSKOI9XKXyoSJ?=
 =?us-ascii?Q?miq4uavpAGuf2KbhvROwtCRQSP5TiEfI+39Z2IVAMxritiuqKTBAKR8ogbzH?=
 =?us-ascii?Q?WUpW9IW5UsX1DO+FoTSFzbQH/+m5x5MSrN2MvVTfytFGblh1kmsWkbyyhaVR?=
 =?us-ascii?Q?8C8K9+RsZ/Z6MAHsLZIZ/wXfJEyN/Q2kjaFVRY0NW7sIRlS1BpXzuFVeQB+V?=
 =?us-ascii?Q?hXTQcl4clgQrIs3w6X1nr3aKSVXJc5N+zCt+aG4Btpakk8ptf83sfk/nZhJe?=
 =?us-ascii?Q?UUGCGf4E2BGLF7tj3SeMt53h1m/LQktHyxtH982HcLJYRETruQzv54mNxR8E?=
 =?us-ascii?Q?UuIj/dwX5rwcZnamW9rPKM7vwj9PQQ5o?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6255.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rS0EH6k52Al4Pqs+jjxs2iLZsiVa4tUGDyVqsNe5Zad2cwti0ISIOJD33kQe?=
 =?us-ascii?Q?XCDb7jidexJRS6uB5VBfSCbOa+QxAetMUcmqjCzYGYDy+Pb1C3ChuDUyxswr?=
 =?us-ascii?Q?KheRwHe+K/9PSnzaOyhK3K2Y7lzzyaavLp+6xDkDxy6L5MoQpK7tmlEf1Gpu?=
 =?us-ascii?Q?Sxeyw4DOfRVaWd0oxkWf/3B4cb6fCWgGIWoYXbT6a23UCdLKteFspHli3kzK?=
 =?us-ascii?Q?G5J7Uz24bmICuSfT3pu+20VxdYdoYDe35GTKTQtWt8/H1nrWScnE7xJ+pXXm?=
 =?us-ascii?Q?ropIbynBQxpGHpigQ+dAlQM2oHMiT7g+d1xhFLShF+Hr9aYz+bAFUIPVJ4Mb?=
 =?us-ascii?Q?54mIPfBhLZaq0tMzmMhe7L7UkRDDzAztOufqwspnSESIzid1s/tlPt1ij0Ei?=
 =?us-ascii?Q?YMP+1a/alcinDKpK/HlGoIuJ+5OFriGYinbjKGa1vJpvy+UvCVDMbSXrcQCx?=
 =?us-ascii?Q?IpE4JI5h0ejwG/9Fu6sVtUGfvZBdWk7f9Xy433nJ7jAzOoO33oOyJRJHqgAD?=
 =?us-ascii?Q?gTl2XQ3iBEO3gJxoARi8P/3VgIsrdr1dACLk6Jqjg1rz3G4mCOJJKpU1ePnL?=
 =?us-ascii?Q?++43MOQUo2QOO/qym7J8Ijx/1Iod3vB6+wj/sqF6FLVFc5HBoWsMAWThitsh?=
 =?us-ascii?Q?yJhr/4HRIM5wJlJb7vlNyQVfFxysew+AZMvdfYyDYB8RGErJrsnD99lfn72e?=
 =?us-ascii?Q?50/skvdw/tw22VC9N695uZS8m2zrOf7AavDFqURZ1CsABgzBEz/XN5bZ48V4?=
 =?us-ascii?Q?wp3OoxG5IVnHIdzwmKAoDzpqUEVPC4Shnbj5uZOKllyZapw89ejkO7f8sDlG?=
 =?us-ascii?Q?lrnVRLHmFabiQbSzzMbhYvMzgU+hkZh/qxLzuLYX45XNKwn8whuKjFcuZ+6a?=
 =?us-ascii?Q?fqUewrpzkNYIDcr7blHIvV44z+Eih8m2s2iU5nXOlLd6bG5N1ADYdzDaCWG2?=
 =?us-ascii?Q?DN86tgxCh+htdj/OAsW9C9H7mUwBCq2S+vrpRVjv8AUNKhRxCosZcjlrVgrc?=
 =?us-ascii?Q?idVOsvfrmDwBPVJeVhm0GB8XAPrS361hSsQYUTgIgJS+T6p2ct6TTrKLX9WW?=
 =?us-ascii?Q?Y8Wk54PlhxoUiwW6mqRwDoR714MTrFS2OI9Bxs13buL/NYoqCvBa4rJgbntO?=
 =?us-ascii?Q?bIx75B1btnM7uveSgbuSfm69KR2525izSetv1nAZh/aqJ1DdyEr2clhToMlu?=
 =?us-ascii?Q?tGDFwsjZly2G32BTXHt4oyR0l/+XlfxXTuMzm5OpuGrM6BPEl9WRcA7ZyYno?=
 =?us-ascii?Q?WljkXaPZ1iSfrGgDKu8nosL7UMCYI0b2H3d5K4MaF8t6FkjJxJDd6x2hf9A/?=
 =?us-ascii?Q?w6J37rpKDHbhfhzR/v7QL8lm1NYchjUg+zNqmupvACvvczPZGUcHZZ4qgoJZ?=
 =?us-ascii?Q?v56aRhLWdZ8QuBL4+X43KEB44WkVgNN8dIHRx/RJTLlPPwTfPIgo4XXL484h?=
 =?us-ascii?Q?ViZ23RvqvCB+f59t+U8gSe49SbmaYl+/FsKDwZlohd8XQfHxieo73YljuGrT?=
 =?us-ascii?Q?H0eBX5cxBVy8GdiuEzCY110tFm59HrYzxTylkJF6Xft4vrX7C+Na3CmlC9tl?=
 =?us-ascii?Q?UlhWtt7NAyJkl6NPeg/iCUbVVt11eUmGJJ8F7iNe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: mts.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6255.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02571486-b3c8-4137-ebca-08dd2f6dc7ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 22:51:10.4122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7fa3ed9f-fff9-4884-a6e2-8dd98886b775
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i8vV6UhBW0iMKAkl4p8tpIlFMO/q2+7/uByUqP0BM2GYHyzBd+OG0tGpHSbv3ImbnoHpvz+1E4H/+07oDcz1Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7553

I am using Xenomai v3.2.1 on 5.15.57-dovetail and I have selected the follo=
wing kernel configuration option.

.config - Linux/x86 5.15.57 Kernel Configuration
 Xenomai/cobalt > Debug support
[*]   Trace relax requests

When I run my application, I am getting MSW's on one of my real-time tasks,=
 i.e. seqTask-00 (below).

Every 10.0s: cat /proc/xenomai/sched/stat                                 t=
est: Tue Jan  7 16:32:14 2025
CPU  PID    MSW        CSW        XSC        PF    STAT       %CPU  NAME
  0  0      0          3526511    0          0     00018000   99.8  [ROOT/0=
]
  1  0      0          22166547   0          0     00018000   98.7  [ROOT/1=
]
  2  0      0          6          0          0     00018000  100.0  [ROOT/2=
]
  3  0      0          0          0          0     00018000  100.0  [ROOT/3=
]
  4  0      0          12         0          0     00018000  100.0  [ROOT/4=
]
  5  0      0          0          0          0     00018000  100.0  [ROOT/5=
]
  0  311    0          2          0          0     00000042    0.0  [rtnet-=
stack]
  0  312    0          2          0          0     00020042    0.0  [rtnet-=
rtpc]
  0  34201  8          8          54         0     000480c0    0.0  coops_t=
arget_main
  0  34203  714420     714421     1429756    0     000480c0    0.2  userCyc=
le
  1  34204  2          2          571184     0     000480c0    0.0  clockIn=
terrupt
  1  34205  1          571183     1356559    0     00048042    0.4  dispatc=
h
  1  34206  571182     1142364    713982     0     00048042    0.5  seqTask=
-00
  1  34207  1          285594     356993     0     00048042    0.3  seqTask=
-01
  1  34208  1          142798     180963     0     00048042    0.1  seqTask=
-02
  1  34209  1          2          3          0     00048042    0.0  seqTask=
-03
  1  34210  1          2          3          0     00048042    0.0  seqTask=
-04

This is an iterative task that is executing at 2000Hz, I get 1 additional M=
SW for each run iteration.  As you can see there are many MSW's.  Shouldn't=
 the trace buffer be full of these relaxations?  If I cat the buffer, I see=
 nothing.

test@test:~$ cat /proc/xenomai/debug/relax
test@test:~$

What am I doing wrong?

Thanks and regards,
Jim Rosenow
MTS Systems Corporation
