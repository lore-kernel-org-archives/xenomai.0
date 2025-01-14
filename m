Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1141FBCBD
	for <xenomai@lists.linux.dev>; Tue, 14 Jan 2025 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879190; cv=fail; b=GPzwQYObx1vn9XWqz+6XkXX565PO2dKLX1Yj0LCCYLQrmYjX6G3uFV0g2Fskt2jNe4Uo0WgrtpNonO7OKVWcZ1r00Rt3F+r+4Fy3HFcUoB6eNvqRHqogcLbsPMJgZnGlGBvBCl7kD+g2QUXCmcg/1KvqRj1ccafRO1BQjduQGdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879190; c=relaxed/simple;
	bh=r2Ygj+QZLB6LMZA62+G0IUwuSf5JP2CInzY3wQnivag=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dEOeD6Kx8X5k9jnb9UoQqwbzNyiibfXrV8+K2uY98TizSOZBe9ocGPPy4kT+VMP3nPwhGd/wy4PbjGosMddgWrIXpopIoFIkhWHqftZnAz1vpr1DP2eFzPseKlOWpLZ6LshmB+HTmHsl0+tVz9ovOm4w2Cf3Vsgxa7Q3mrKFq6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Oin0pG3w; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Oin0pG3w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwBUeDz9gJwiyshGUPuJ3pBIDtRGFU/rxy/J/DotAZscG3gYT77przLNTU0Dd7xUKqepza6a4r0IK8vUq/bgg3BZDudZn8GQi+S7E3IXYgYlHZSRgNimvKLEeEQXh2x+1eFV6RuoOfVAxlpVzqfYl6c3xf7rOpvMe6fMIqAcInToAkpd3F2wjJai5x3MmCPO8WxAxFAi3pvoxWWUVpu7SQ/kojHD7mw0bDLUFR/1K6UHY0Vvtk0OnVPzhTgpR3Pr8RqyFX16MwjFTLaMesQ06hvduUa/40dPMXQ88JZnmeEDTdFVcG+VksSXsV4mNWn5ogRwEwIKtPfDonNc7BROMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ge4gQozAW6N4Wn59kPWzUpfh1aMy305WRDeCcO83qVI=;
 b=Tvn56M/bA4w8msbUoYMuryCh7ZwlfEH+AaRCAstJoZNzhTWcvZRKoSemBcB2euttDOukNzXAFVixURAYrB44qCOEzF2P9yUQJWETDDDu7BIloh1kGzqJC4xdukvhHxhnZa7/4aukqK/kWVrFnSXYlxARIuzRFdWRQw0GzAA4TsnhHj443qjOit0VyMhg6jFJi10E8ROT2mMpkEz8N5SVPk2e94Tz6nFqj5y7RqIOo1Z+U/BIy+BLNAufl3CgVrqrNR7lWwJxqTWxMdYGQPm54ioGioyqVHraQyse+6hi6/aQdNnOqOPvWRonjzTqm/uAZ1wR8jlZcJKxN8sOHZTwlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ge4gQozAW6N4Wn59kPWzUpfh1aMy305WRDeCcO83qVI=;
 b=Oin0pG3wdPIG7eNKDcv6tEKBUpndtpJsqgqgZeaQk0kCsQUSvzhIzeV59CbbOUCTB5+1zMJ9Q2OkOxJnZS9FlMrTUGijUrOTyV6wwQRZI5ac7h09j7cjnn9Kncx15C0L0xaoM6eGZi7O4ZzSxMaB3rMSy4JtbMr+YZAV3k+ROgC6cmod/ff1icRhpwPmC5JwmPiSgJtsvGE5o47KR/4Z655W1vA1xmevt39tOFBsVZvdmOgJWcmlJKa/Umq/Wn7N8AcL04PQEhznzjM7W0KL366TN/6aVwVyTwF9wP35DHQxjDF9liaA1IiN+7rgquspuJXU2WzDHPR7q4gIVq/3FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8473.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:442::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.11; Tue, 14 Jan
 2025 18:26:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8356.010; Tue, 14 Jan 2025
 18:26:24 +0000
Message-ID: <cb0b5150-74fa-4a94-b985-43aa8e15084f@siemens.com>
Date: Tue, 14 Jan 2025 19:26:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Where can I find the documents of building and runing Xenomai3
 app?
To: luis@eichitek.com, xenomai@lists.linux.dev
References: <1548af45202ceea5b29e3bfd6f762db0@eichitek.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1548af45202ceea5b29e3bfd6f762db0@eichitek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0390.namprd03.prod.outlook.com
 (2603:10b6:610:119::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: ede659e4-32bd-421f-2d19-08dd34c8f3d1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Si9acnVpZHlKZlVXbjcvLy9veUFVNXdBVVAxNmRuNGluWk5nZ2NuK3VhdFAx?=
 =?utf-8?B?VGtVRzZyM09Ya2huRzV4bVVWcmMxOGpKeG9OV1NSbWlKeU1qV2VaQnNkMExH?=
 =?utf-8?B?Z1ZNbitsb3BjNExWM2QwdUN4U2x6VzFVS2p2LzVOTngwcXNBSGc3eFJPOGZl?=
 =?utf-8?B?cW1nK2ZVUzJwNGRwUFVWbkVwK3dDdExUTFB4eVdjc05yaEhPdGhTc01IZ3ow?=
 =?utf-8?B?Z0lHZ1pTZm1GN0Vrb21tYjI5cHJMZGVaUTF3VUkzaEtkdmtqL09aalZYQnB1?=
 =?utf-8?B?SGxXUk9hSVJaL2lvQzVwYTBOcXhwUUNKZXlieEtMWnJHQ3FhODk3SzRJNnV4?=
 =?utf-8?B?b3NLNUY1RDhKRUx0TXl1cHNoSDY1KzhDYlFPZGpJQkJFa2x2NGp4aWp4aWZs?=
 =?utf-8?B?bHp4NjFsaFVhTVFja1MzdXI3NWYrQzJWK3Z6aUJsdmlFMHA5SGdWNktsellx?=
 =?utf-8?B?aWVtdnU3ZWdiSnFBOVBZVlhGaUJZalFlaWUvL2o5NVZUbEtvU3FwUGhZelhK?=
 =?utf-8?B?UWJTcGNlZkxpM2Q1Z1d2b3NMV0Nzd0dTaUk1Y1EyWjFqaGFwK0xzUVRVNlJV?=
 =?utf-8?B?MEtKVVlFYWJLZnY0Q1MvVUFmc2xHbzJWRVUvR2MzYTBlSU95UE83R0pldkZG?=
 =?utf-8?B?c1Z1VzZBanZZdUV5bVM5UUpWa3UwR3NDR0hMbU1nTXoxc3hwY21XNkZHb3Zp?=
 =?utf-8?B?aVBOejR3MlRYZ1V5aDl1MFhiQWRYc25LVTNkK1BCOFY4RXB6UU9RcmpKNjNL?=
 =?utf-8?B?R28rT3lVU0V3bkFkKys0MWFyMXplLzRMSVF2Q2RPYmxHZGR0ZnlOU3VNTEZF?=
 =?utf-8?B?bjljTFJDcHMwRjNiQU5zQnhJMzBWOWMyK2prR0R5Qml2V1k3bG9DNkVTZTlY?=
 =?utf-8?B?Zmp6MHRHeVVLdTc1NjMxYjltT1p3UG9iZTdSRlhUWnFubEUvSFFxYVNoSlBV?=
 =?utf-8?B?MnBWUE81RFdxSjAyVjd2UzBzUWhSdVVDc0JoTFMySVFZeUdUamlveDkxVmFo?=
 =?utf-8?B?RHVUYmRRM1JHTzY1bnZ5MGVqQXR1WnNVVTk2Rk5FUS84dDhtYUtEUXJZc2Q0?=
 =?utf-8?B?amJXWGdIZHVhVHRpMUFWL1JESUF3V01sMlN4N2p1OXFwSktVN0llVVl4QXg2?=
 =?utf-8?B?ejNvUEZYSFJNbm5FMXFDZlhhcWxVTmVaUWMwM2RmdjVMcHpmN3Jvc1pxZWgv?=
 =?utf-8?B?L1MvZkJ0amVaaGZlRnVqU0lsRVJCZmdLcnBYSUs5WDgyRllmMDY0aWJjVHhN?=
 =?utf-8?B?QmJtK0lWWi8wWEVqY2h1RHlqUmZqb0VxSHdoT1R5Um51dXBCeStVOGZ5c0Vl?=
 =?utf-8?B?ZTE2amUrUllaNG14VzdkeTVha0l0elovb241RVBFTnQ1TWE0WXVWdmxHRjhL?=
 =?utf-8?B?MDQyS1FDYjRISlVQZDBLWWRJSDlFUVM2MThUclBNVFMxU0pHektRamtEUFpW?=
 =?utf-8?B?MUJDQW0yTFFxcHErdWVNT0tQMFhGWmx5cVQ0NHovZmRpRU05YjJPS0JWZjRs?=
 =?utf-8?B?bmxBdFYxQ25OTW1EVXl0bmh3SVRaYUhnd00xd2E3M250QVFGVFYyamhxd3Vw?=
 =?utf-8?B?K0ZSNkRDNmQvOWlSTGE0Q0JPOVo0eS82bFZPcXUzczQwS1Nya0QzcVg0Qk80?=
 =?utf-8?B?UTIzKzFiWVVrRm96dGxNT3RCMXIydmpLYWFHWHZmLzZGRFF0QXZhVy9YVnZY?=
 =?utf-8?B?Q21uRUhzejIwa3pZdzFzcFpNTHNSTjVDSXR0QUhtZ0hGdDd4am9BYlBKZ3Z3?=
 =?utf-8?B?dVdyU013dHdiYktNdk9WRmhLcWlWL05TTXJtb2JkWjIveVA0ZDFYbE9uMzM1?=
 =?utf-8?B?UVJobFREQUVUc2lyaS91QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzVUdU1jV3gxR1d0N1NmNWhLT1FPdHZnbndvTWVFKzJvSkw2MjQxTFNhNUdz?=
 =?utf-8?B?MEg0RkJjVzJHWC9OQlExa2RPUERXTVRaTzlUYngvQytaVmZmcTlaaVJvTWMx?=
 =?utf-8?B?bHFHbDdkMkUyR2JTR1c2WXpMOXFjTzNPbUNvUitmRlljYll1ZXZlL20zOFA3?=
 =?utf-8?B?YjB3TGR6MmZ3UDQ1R1Y5bWVDb0FxaE96aEhBRGN1a3NJSmduTDNPVWozUVpk?=
 =?utf-8?B?K0NZRUdNdXQwMW9rTkhISmhDTkZOOWJMWmREQS9PTGQxUVBMSnJseXhCV2k0?=
 =?utf-8?B?RnhRN2JDSVBuVG9xeEk5OXcxU0VhMjdMT05sWVBacU1sMEZnWUY1K0Jwdi9j?=
 =?utf-8?B?RUZFSTdEZ1BCcEIxSXRYSkI0eXoyTiszSEk1amlqWlErVUpJZC9YYTJoRHg3?=
 =?utf-8?B?QU1WUlMvVlJ5K1ZtU2s5cEdQOFFuMmVSakhMYXdBaE1rd09MRjI0Qzl4UWly?=
 =?utf-8?B?RUR2UHAwSVBXTUpnK21vSjFZcU9BM1Z0cUM2ZDhFYTJ4M2Z2VW8xc2ZmaWdD?=
 =?utf-8?B?Y2xjNk5aakpUVkFmTTBnMC9rWGtibnJ1VXpNUTdNUXhXQ1F5d1Q2Vno4QTNZ?=
 =?utf-8?B?anlhUS9XcWhQSlg0S2NOQjRYWlI1REZVUmo2b2h5Yjg3ZlFXWWNxbmxvazRM?=
 =?utf-8?B?YjFGdDkwRGtnMEhCUi9hRExBbkdCYzJvTVBBQTU4WmN1cDhJQmE5L05IcVhu?=
 =?utf-8?B?SExLaWpaWHFmQ3FHejRBTjRCb1ppWDRnUWczZ0U2SWJndXlaSjd5djZUQktV?=
 =?utf-8?B?RlFPOEtHRElrQmF3MUlhSUV6Q3lyNDFOU0gxR1ZWYXlZMHVOUFd0U1hOVzFj?=
 =?utf-8?B?TUlXOERCbjlhNldFalp2TmliZG1LaHhIcVAxZnJzSU9CS3hoYVJaLy9JN3Jt?=
 =?utf-8?B?aC9SSE9aSVpiMkpFZk9kS2Mrd3FTa1p3cGNsekJjSFlKbmh0Wm5WQUpzNU54?=
 =?utf-8?B?UmwyaHlNSHFmYmcvemZ2SEJWWVpmUnE4UlQrbzhaVXk2d0NXaXFaN1Ridzhh?=
 =?utf-8?B?UEFIbU9vWFFsclE3cHZvbnlPTnJ5bE1POWVINERrT09oNGhnWGgrckFSSm9L?=
 =?utf-8?B?UUsvdGRaVDc2a25JQWNrYUFtWHRTWmRkWWMzMG0rZ2R6VHFlMGRGL2RJSHlp?=
 =?utf-8?B?NmI4aE0xMTJNamRtYjhuNTVlZURZVjRNTnl6ZFV5ekx5QnNxK3J5dmVBZSsx?=
 =?utf-8?B?cFhhWjJsTXhyZ3JTanNSU0UyQlg1UDMzVWEvTVNxdmhYUGNDNGxpYTMwOVF4?=
 =?utf-8?B?VkZFMk1yOWppQUFhaGdpdllSc0FvdkFzZWQ1MDFtM25PbTZEemdGSDQxQkp2?=
 =?utf-8?B?Q09kUFh2Rlp6eXhGQUZKN0djcmtCc2c0Q00xU1IzdFhld0tsQ1JMTlZiNHBN?=
 =?utf-8?B?U3VYMDI4TlNVUW83T2NMY0ZldHVYdE12dHpkNmNxUUp1WDlGbUs2bDJkWFNH?=
 =?utf-8?B?b0lxZDFnTUlmbGZmS0RRQUhCS3FsYmNhRVlsRFJ4SSt6QlVDK3dlRThleTU2?=
 =?utf-8?B?enUxNkRPeGsvQ01sOHprOElmQ21iNVFoNGJzYWQyMjF1d1FXVjJ5aE13eDNw?=
 =?utf-8?B?Rks4WE1IU01WNWRDcU9GeTRyM01OSUF1WFd0d0t1TTZnWEFCaXRoT3JTNFdG?=
 =?utf-8?B?cjAwOVRTYi9jWDNPVnJpZVlXNGVlMGZsQUc3ZFBWQXJyUDkxNmVhR3FrZ0o5?=
 =?utf-8?B?UFoxTExEQ005NFNJckQybGRiSm54bHhiTDNtSWYwQm5PNGFGTXdqeG5DeHow?=
 =?utf-8?B?ZFVHMHpWSTJrd1hDOTFCeDhUR3hYdi9UNTA2V0ZmUDlZRVhVVVliMURoMjRS?=
 =?utf-8?B?VXlyS29QNVdwR0JvRzc3L1h4U2YzOVluc2czSkloOTRKYzdzemFBNnlQbG5p?=
 =?utf-8?B?R2RXOWlsUTI1L1lVaEdHOTB4SlhWZDlIMG9YbW0xRFBQaWdjTG5rOVdnZng3?=
 =?utf-8?B?U3l2Q2RlK2J2Qk9sVXQ0bktvNTdwWmFwNlFmeTAxZU1ON2tRRFY2L25oNHlq?=
 =?utf-8?B?KzFPQmxQbVBpeUNqdWVBZU1iWVFOZzdjMFNvRHppdzd4QTBZY0JqaHlZTUpt?=
 =?utf-8?B?RnB6SjBvZTgzcHBwU0xMTkxUalBpa1Irc3NjTFB3Sk5ET3laZndCc09qdGNs?=
 =?utf-8?B?eFNlWStZZG4rVFZLeDdpaVR2S2RPV2kvZzdnbXF4c1c3eDM4TXVHcjdCVFdR?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede659e4-32bd-421f-2d19-08dd34c8f3d1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 18:26:24.7460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Oxiafyyh6W2WGaVTgaBCKGgF0O3hLMnlys4+ZWo11l4XVPVNcM4KhU/atXm48CqABXsonKVTb8k20Tvk5dMVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8473

On 14.01.25 14:25, luis@eichitek.com wrote:
> Hi all,
>     As title, in the source code of Xenomai 3.x (for example v3.2.6),
> there is a manual called "Installing Xenomai 3.x", which has Section 8
> "Building and Running Xenomai 3 Applications". There are two links in
> Section 8, called <building-applications-with-xenomai-3.x/> and
> <running-applications-with-xenomai-3.x/>. Where can I find these two
> documents?
> 

Good catch! Those should be

https://v3.xenomai.org/application/#x3-building-app
https://v3.xenomai.org/application/#x3-running-app

Patching...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
