Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C1627FB37
	for <xenomai@lists.linux.dev>; Fri,  7 Nov 2025 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502420; cv=fail; b=llun/5rL0Hqr2XszcAe0tNiRR6X4tFFW4VZxt15CTz5S6tqEohFdY3HkbMt7GMETjjCwcjHnXWvgLicW20iSEpEM8d3M16CBioaTD8qSCx8dBR/a0GmvxVsN+Hky9wY/frB/jRsX+av1EHkOmsXkU43gD7s3DMZqBN8CGpbhrmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502420; c=relaxed/simple;
	bh=KpSHKyF1UX50KMLYH2AjVFYfVfoQYGb599AIkOkQG+U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dzD/fajeufXxJcTB6Y95hx1ZVu44c30cN5KyUH4fst8X9jE7JbgQje5Q+52m4zYTsgNB+BeYySzZCHUnQK61YNVoYK/k4MViSUXJIGYVW8oyV5OLKgVayki+yD2VZho7mRTEPE6ld6SRX+jB2F2+6hVVclyl7m35HXF/JJcpSTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=eNZwtHF5; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="eNZwtHF5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTgKaWqn2nX8YXM/EHQL+S1beu4bPFJhu+68zZQjkbhouwIXgjNLDNqTiY9t2qRjbs0UO5sF4S3bUuL2fZ5y80wCfygmGMlv3ax8hO013+XDkGabsrGTBSZePo6nQ/RW79nDRxZQuxn6We24xptzyKqkd8pfJBhenfBmbck6DFna3R5aLfEGJ0Nnl6s7x25hdJK63k0evl2BxB5zcBVdI5JpVIke/0CurLBZWz9oE076pdtm1tq/MGPau49LSJZeI8ZQXDb8/U3fn5t1sWfw/WOaass7KKi65Lp+r7mzTpzv++s+DdpwvxBBOoUHKe11V0hH5eZgqDUnlN6W8V7ZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3kB/RhG6xvhOjLujwdQ6R7lhNieN07D9cf9l1Sg/Ik=;
 b=uxQD8/UVNpGFgI7IXIjweRZhqMdpnNZbVhOXLXuMhoKwg0m6ESFV1somVwq5ifuMaXtnbPgExBNvKjmNKZRfgSaC+dqTQiLQWaXQMuSKotrgAkj9O8pihP9gX0UJcp7MyNWrMSBX7xzTQ6Msm3fv+zhW0ruwbaO+xvQgBbzSSdpsEw+Iq31WZOIjKRhiXqQxMyLneoaRT0lsSb69PFEuGY0ofJteUzbMdaI3Yrkb0tfSQ2B/lV4xTjJer60e9X7FdApW1H/Y5YkyLgdPd13tpA0a2QJhjuQjVKOBjFG1YYMPBt7bsdXcnb/13Qo6o7nbLaNpUK3FkGgQcMgJbbcgoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3kB/RhG6xvhOjLujwdQ6R7lhNieN07D9cf9l1Sg/Ik=;
 b=eNZwtHF5AOPmvwc4ruuUHHWzUtWT+mIROWRZi4HvUiZDMYVSkW3Xe/vteFXbCJrIyoyEJbHuEV2PoFrymquytYxVUn0XjolsELS4fGLqQIqwDa8Jm4oZ5sLfC/UFhIKwZi6f/10lqXa0Fz23TiN3lZ9mxfoAJXV2EtScFuWpfHa8/SYYbFhaCQSYD0DoiwqDLB3M29eQYP6Zu2ah9yuE5jCCL4yQA97wk2X9oeRUJ/tCDqEIivLMuvgIKuW25truABfueHfpyFYKp7G3BzebSejKaUijmnp1kF88qtpuUlINz4udT15keUzBeOdVv+jkXPTTTuhJf2VVPnpZL9L5IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AS8PR10MB6675.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:563::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Fri, 7 Nov
 2025 08:00:14 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9298.007; Fri, 7 Nov 2025
 08:00:14 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH RFC xenomai-images v2 0/2] Rework linux-xenomai debug configuration
Date: Fri,  7 Nov 2025 09:00:03 +0100
Message-ID: <20251107080005.1272435-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0367.namprd03.prod.outlook.com
 (2603:10b6:610:119::24) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AS8PR10MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: 918ec028-eb7a-4c1c-20f0-08de1dd3ac58
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U294VHorM1MvbEx5MnVFTURlYmEvRk90TWFLbzlzS1Q1Zk03QkJTNTFDYW5R?=
 =?utf-8?B?aHVaSGNtNVo5RWViS0Y2VnZZa1pQV3ZSN1c1SUxncFJEK1JuVmhxNmNHaDF3?=
 =?utf-8?B?OStoSnJRMC9NR2dPNTlrdG50SlNSUnhseXJnVFE4cjgvUjBuSlJlMkZLTmFM?=
 =?utf-8?B?WnJkVUtTL2NzZ3JsQUMwbDg5cFZDdFpETkd0anl6ckdoRnRGdTNBeUw5SlZq?=
 =?utf-8?B?eWVrS1d6SndxNjlteGhWSEQyZHA1ampYS0JudnVkQkJPYjBLTWpFd01YR0hV?=
 =?utf-8?B?Z0lWcXJycFFNR0dYdElQb1dDMWx0UkFCbjVFU3gxbllYbGI2dTRqTldkeTRC?=
 =?utf-8?B?SXh4ZHh2cThPajBXZlZoVGc5RUVOeFR3WGIrSW5wWEJWcmJERFdpZHh4U0RD?=
 =?utf-8?B?MlVHK3dlOEJkdTgzNWhYdE1xd09hcGVMcWw5VTlNL2NGK1dDcXZqNjdhR0Zq?=
 =?utf-8?B?SDQzVVZKMzZZVXFrZThER1BoSHBHWVcyeTRPakdTbDFYNWM3N3hRYUZVSlg1?=
 =?utf-8?B?L2xUbk55bWZ2MEg4cmVXemJ1VjhpU2xMMU0vZlp6TkhXazJ2MFNqN2FrOGdH?=
 =?utf-8?B?N1lsdG1iVzk5OFcvM0ovbU9JdjJKV09pMnRmZGhJSGZncGdRajk5YXBNQkJL?=
 =?utf-8?B?UjY4c0sweW1XWTNPRTdrNy9Tdk5weTJzUnNxTGpZTE5WNnJZbzFtMXZTdjA3?=
 =?utf-8?B?N0JWV21RcUFPd2U2ZnJxREZ3SGVpRW03S1lxdElYOE03VW54bEttZmdHZlpo?=
 =?utf-8?B?SDBJcjdLUzFBMjdWckl3Q3R6VTZ4eXFqQnVka2RSRFdKUEtCZGRpQlJkY1gr?=
 =?utf-8?B?R0gweDloVFFxODJTT2lLMk5uMTc3TE9TT2VCQ3pjeEJFS0ZQR2xHR3Vvdjhp?=
 =?utf-8?B?WG9haWpYYXZzb0hYOGlXVlBRV1Y3Ukt4WEpxUUZDK0NTUWRxMWdwbnlvSW12?=
 =?utf-8?B?V1drZk5CNnk4UTlEOFlTbXBsbXFwVEkrUHhqdXdJVG1SZVBUSWhld0hqaFNu?=
 =?utf-8?B?ejF6ZTA5YjY5OXJ0YjNJaWdabWZjclZCc091NHJjdWI0RkQ1REVlZCtkSGpO?=
 =?utf-8?B?MGE4NlJzaHB4ZzJ0NW9YZUFLRDVVSW5SQU9LaVQwWEt2dmpJRVFLdGpzWHk2?=
 =?utf-8?B?alBZS0ZmMmM0aHFia2JLZ2pRUENhenMyWlFJbzVyODhvQ0ZkS3RmUXpDeFBN?=
 =?utf-8?B?d01qeHN2OUNlZ1p4SVVIb3NrdytRdm1nYm40OUswbElxVjlDbUgzeHVOaFFv?=
 =?utf-8?B?bkl0dW83TU5lWnFrN3l3ZUJLZFZnWnhVd09OdWl4cysxTVdEdGVvYmtVL2Zs?=
 =?utf-8?B?SjF0ejkwUmxIRytKVE0yajhGTjNkZnU5NDh4Vk9DNHlPSlRsRjBzdXQwSm1Q?=
 =?utf-8?B?cnVsWk9aWEw1cytJTWN6aFBVbUxMMEpxS2FCN0pCcmUxNURMWGdXUUNhL3pG?=
 =?utf-8?B?NndVb2xJVFJHaEd6S0Z0ZEt4dHE3Rkx3Vkh4bWxYVnlnMExKc0hDK0VKekFw?=
 =?utf-8?B?amRQeC9SdWVCbzJwWndyaFdTeDJVQTU4dVdVd1RKYy9zQWxJS2NMMThKbVhF?=
 =?utf-8?B?c0JSKzZBSmZNL2ZQNDRuZHE5UnloRFB4TnFVbURmRy9CMW9GVTd1N085RVJL?=
 =?utf-8?B?Z2FlaVAreHVMNUg3bWhLa1hmS2s5MmNubGwxMzZwSm1GeXFubUNjVGJ0QzZD?=
 =?utf-8?B?NTE0NzdNVlpPalAyVnZYR3ZWRmN3cUcwZTVxdFdwS2dvZU1JTkhmbG9Va0Jl?=
 =?utf-8?B?bytpSHJSbHJWalhvZStWdCtHVzE4NVRJZnMzQno4ODh3VG1udlRNZXgrU0hF?=
 =?utf-8?B?RjFVWTBNYm1FZjFNS0M4K3lxRWhyWGhkVTJ1eE0wdC9uRmxmSXN6RlpkcWpT?=
 =?utf-8?B?SEN1K0Z2aUZZYzJPSTY3dDF5QlVTZmJTWW1HZW1TU3p2cnd5L2xWN2E0Q0VD?=
 =?utf-8?Q?nhgLxdlnp1zXBlOXjhzcYRb5753XFBww?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjlMcktSQyszSjM4cDh3SUtkMVU1U3dnaXQ1c0FwbmNQdU1UZ0JjMXpTVW5O?=
 =?utf-8?B?RkF4WEl0WWh6R3luOWVSanFBa1VQOTdMcFFUNW9VWXVlTnBkMEs2VWlIUXpy?=
 =?utf-8?B?ajl2cjY4MXhueisySmxUaFpIVVJCUnJ5blF2THRQYWQ3TlR1MkRHMHpyRHVo?=
 =?utf-8?B?NDBTZzBhRWZreUdaRmtnTVdwblViR0xhNnVCcURPR1RPbm5zeFpkd0RFV2ta?=
 =?utf-8?B?QzljdXVOOVY4KzJ6UzRuYm9LaVJNTmMwVUVDZHhuS09sQmhKemNQc2w1MzZJ?=
 =?utf-8?B?WE5WSjh0eUZ1cG4xQVZBa1F3bERjMXREMk00emNFb1lSTkdZVzZKcFk5YjQ3?=
 =?utf-8?B?N0RoQVJBL0VvUzRYSjJ1NWowQm9VZHVEVktZL0s2S0ZJV2ZScWFEdjJ1d2ll?=
 =?utf-8?B?N0ppS0wzVmY4SXFoTmhjczZRZ2FUOGRncTJEVDdERzVYLzBkd3NQYzhKTHdw?=
 =?utf-8?B?Sk5GWWI2MkVZS3V4eDJ0K2Y4Vk56enZ2TFVZeDdaVzZIQjF1d1ovOE5nQkhT?=
 =?utf-8?B?b0k3cyttNXQ0bVRlTTIyVS9WTEFtQVhkemhBM1RCWlVpcTF6YlVoWlJIcWtJ?=
 =?utf-8?B?SnJZYndyaGNoOFErL1h0blR3aEhYb3hPeDFhUXl5ZWNjQ3NPY1c3MjljZGo2?=
 =?utf-8?B?Uk00eEN0ZWJWWC9VVGNlckh3RU80Z1NtMWQzVnYzenRBbnFlbC9rUXlwSG9l?=
 =?utf-8?B?cVpNMjE3S09QandBQ3BRays1OXZ5WWxVMUtWRW5VVkNSOUsvWWEvMk9odzlh?=
 =?utf-8?B?ak1ZWGlJUGYxQmY4RWJVanFmQkhFSWFwbDIrb1ZTbzRubjRNZDN6MncrWGtT?=
 =?utf-8?B?NFBzRHlKS0kwU0lLVHhUenNvSTVEZjlFN0g0dVhPRlFqUm5FeVN2bktBN0ZP?=
 =?utf-8?B?eWJRbFZaWmJuYnYxdk5zTTFPWXZnR3dqamQyMWtjaDJKSVY2Mk5xb2ZNaUwr?=
 =?utf-8?B?blZqcm11R1lCbjk2Wkd1YVJPRVZlUG4vclc1NnU5REFUa2d5a2Z5anRHVWt3?=
 =?utf-8?B?NFRiV2ZRRUM1Q05lZzg2ZU0zWmt2Y293Z3ZqS1JwMkhLbWxqR0VkTk1BWm1m?=
 =?utf-8?B?M09DZFhDMzRrb2NJSmZEbjVnNS9NK0hGbU9FVGVsanJCcXlOVUlwR3QxNFZ0?=
 =?utf-8?B?blkwLytQcDhVakhORENqckRlZjJzcWVrWUJ3WVVMSnN2RHErOEdJSk1Yc0dp?=
 =?utf-8?B?SHJFTXFZdWpWdmxDdWFiQnc4dXI4dzZoVDExNU0xM3VET1FVZitQclhFRUI0?=
 =?utf-8?B?ZUc0ZmkrdU1sbG1mM0YrM2Z1eSsyNUFZTGI1WjY0bzI4ZVNEN0Y1b3pZOWMw?=
 =?utf-8?B?VDZaZ1JjN3FYWEs4WWlEQ0x0M0JWcmpNcW1DUGpMSWEvSmdQVG1TME42eVhZ?=
 =?utf-8?B?bW9pOEgrOE80UURzdDlJMXc3RmcvVXR5a0JmaUVmaWJ6elZBUjBSN1VjcnQ1?=
 =?utf-8?B?V240U1ZXUk50UGtpYm5STUJTOXRtVzVmV3l4OTRxYlhjbXdMM2NCWnFzOURU?=
 =?utf-8?B?Wms4MmMvTmp3KzJWMWlSdTFuZ0FndTliZWpodmg1MGp1Y3Q3Qi9zOGVhSC90?=
 =?utf-8?B?TklNSmxTWXAwREtDRUFnaTNWT01GWlRoU0p5U1JRM25pTStZTFJ6Ym5QaEhM?=
 =?utf-8?B?YzdWQ0pjakRZWjhtOVdQOTcyUUM0Y1p6SVQ4MXl4Mmd1ekk2ejFua0Y4WGhp?=
 =?utf-8?B?eTBZcVVuMExZNktLNTJlaWo4aHRneEowR3BpR1ZSVW9kVlNDTnhqbHVYS29Z?=
 =?utf-8?B?SVJEM2tJVkhWQ2x2QlZiZ1dlck1rQ2pOSC90R1owNnVIdDRQN0ZYRHZobVg0?=
 =?utf-8?B?VENxdUdLSFJlNVNsTXFGOUJGdU55Wlh1UzhVZXFxR0VlRXQ2Vzl6aW5NcTAr?=
 =?utf-8?B?b1ZoUHpQdEpybkhONkdqWUJGYW5KMGg2SFp6RzJCSjNVYnZSTkNCS3RQM3RK?=
 =?utf-8?B?MXpuMER5alpLQW8vSjBMZ1Bwcm5HT1NwU0xIKzgxVFBQcTQwOHJSSTRWYzRZ?=
 =?utf-8?B?MGtURUI3ZTl3bVYxUENkdVc4RW1xTFNyWDNwbzBQTnpkdmxJYVdNUlZrR1lm?=
 =?utf-8?B?dFB6UWQ5bFNGN0RGdnVJaGk5aHJ4VE1xWFlYdTRuSTZYek5SR1ZFNGRpNGw5?=
 =?utf-8?B?OTJHSXZRYmN2SzVhbFg0cDBXeUFGS09yS1BXWktNRDNtaFgzZ1hPaHZsTFBy?=
 =?utf-8?Q?zY7OKlM3O9vtf2VFNW1/DZo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918ec028-eb7a-4c1c-20f0-08de1dd3ac58
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 08:00:12.7082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOI764mbeS4Ca0IVXsDZwckgiMC7Bfj/UKcUn5hyxou0hReknh4oLXNjMocBbIBXfqnOzi0XIni14tzyXLvXaZWWK0uw0AUE/DNf0iYtPxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6675

Hi all,

this RFC proposes to unify and simplify the way debug kernel options
are handled across all architectures. I initially started this work
while looking for a suitable place to add the EVL and RISC-V debugging
options. Until now, we have used an inverted approach with a
common-nodbg snippet to disable most debug options that are otherwise
enabled through the per-architecture default configurations.

The series is divided into two patches:

The first patch removes the inversion while keeping the resulting
debug configuration unchanged. Applying the new debug configuration
to the updated defconfig and running ‘make oldconfig’ produces an
identical resulting configuration compared to the previous defconfig
across all supported architectures and kernel versions. For the
non-debug build, several leftover debug switches have been disabled.

The second patch unifies the debug configurations of the different
architectures into a single shared configuration. At this stage,
this results in more debug options being enabled than before, which
we can refine incrementally.

I’m looking for input on what could be trimmed down from the unified
configuration and if a unified debug config snippet is even desired.
As Jan already pointed out, the Nouveau driver is a good candidate
for removal. Since testing all kernel versions and architectures is
time-consuming, consolidating the configuration first will simplify
this process going forward.

Feedback and suggestions on further reductions or cleanups are very
welcome.

Best,
Tobias

Changes since v1:
 * Use correct naming schema for arch specific debug configs in first
   patch

Tobias Schaffner (2):
  linux-xenomai: Add arch specific debug kernel configuration snippets
  linux-xenomai: Consolidate debug-configurations

 recipes-kernel/linux/files/amd64_defconfig  | 313 +++++-----
 recipes-kernel/linux/files/arm64_defconfig  | 149 ++---
 recipes-kernel/linux/files/armhf_defconfig  | 164 +++---
 recipes-kernel/linux/files/common_debug.cfg | 606 ++++++++++++++++++++
 recipes-kernel/linux/files/common_nodbg.cfg |   9 -
 recipes-kernel/linux/linux-xenomai.inc      |   2 +-
 6 files changed, 921 insertions(+), 322 deletions(-)
 create mode 100644 recipes-kernel/linux/files/common_debug.cfg
 delete mode 100644 recipes-kernel/linux/files/common_nodbg.cfg

-- 
2.43.0

