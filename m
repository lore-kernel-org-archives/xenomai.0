Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011069.outbound.protection.outlook.com [52.101.70.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB52531A54E
	for <xenomai@lists.linux.dev>; Wed, 10 Sep 2025 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507584; cv=fail; b=IYOLeEzIcStClT5tSQk1Zu+BoDe1JnotC6xJKgKqzi+OfoyHQvbb1fKOFY0yQwInkG3O50qG0lyrpOuo/QZFNRnJBcMAZvMoIB8PoQ3kMLDPP//DgsAiiCS4MCNoISV77RkBR5YqCAn+rndwOuuNrFlhdhUbvS8kep/fNlJplwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507584; c=relaxed/simple;
	bh=bV4tNSTfFQuyYx2De4kZB64EjH7YoH4i4tuKVli6acQ=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=c1M4gbFMCOu8XwQGBjfmHpiMrfZIvAoZhh9BBuNbucClVQ93uitcTm+Q0ZwFv0Lm7WahsfTcVC0O4oT+qaiYJ2q8HuNv8yepDNiWD/K8QY83Ge7D3vE3eEqdINuYfxB1hhz/1zLhNnKInrr3w25SE2gzDFGh067IlVhNb7rLadA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=z18ZnaQf; arc=fail smtp.client-ip=52.101.70.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="z18ZnaQf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDnEKMFrnAxADjftSLyC+StfuwBlk5abBhq5ssbAfQ/XZ6HGfHIXPLy2pOBDlLm98WDJh2VTSY1+Xg2Og/5J2X63AXWNV8fyETRHHq7P1brWyUosPnTZ8dL0JcbP08mOwr93cgVSLwq2eh75mkiLuX+IxUR5tP2Wk3+4GWPsLOZk6/ufQ3h5h6oHTq3PEc0kSAqW3yH86ij+M1xKTscE1+egrgPFU0KBBWCJzFfAOzqWga5/2GODJ1mOnfFAxs+E/r8pHkPL/pEbOP711pBwZ2qXNNZIcCQ+S+7ReOQDoAHy58XmCBVVltZG0l9fGD0o69ECwAAAZAotu2/+dreKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0p/DSyeAWl07IBWnUqgY8aFy6pFuDtrSB7XHjVh5We8=;
 b=aVIX03J5vf79KSFcmHt+SZDOCN2Glzk0G3Kv9z4m7/Qkd1NoQmMuV4I0C5vEHHL2+T2ei289QE3dIUnoBwGnpj0MCPFM0K/0PFAhBigW0fOWHO5/iFvbSh9H6OEjbtVB6usWBnUIOruyTfuY/Fdd9jOZeUCTmWm3xkzzc09fu6zD8gNRT+SKOltVBjE30WgXQ+Mtv00jVJQfAO/yMnbBky7LbVy/jSgZ+y2l/N6x5DiBA/M4qhHQjMgbPWmFTz8s+DKFILAg2ImT4KVPBWBWnbniSoA+FmNzYLdJemRSpLy+MsCtXRaLr6NAd7IjB4cSSLlkL1LH8pwIpSsVrcJzYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0p/DSyeAWl07IBWnUqgY8aFy6pFuDtrSB7XHjVh5We8=;
 b=z18ZnaQfMTgj2s5pRnYRQhzHSBRQPsVNxyxmdbkvNi5rqRBsLrV1xQT200Z9mr7s8x3cZcVWwwRpNbQKaY27+kxz5UNfrDuGmGKwCtfl+nnP61CYlYwO5WkSpFM5K/oy11IdRFUVSYw3NBftfCUyIwcTEw3NTDcQe+tGb4vSKNKSXnbS+FCr5sB5p4rRdqCgBcHSjanEHLeNjZv3w4lyH5gAUTNg/X+o6VujD48aRNtQfda/HRBm6PrcSuNmrtSb6MRF1EuQER3wmfbV5hFj2pV0R3xdSfOj+a5RZ54yiik++eN5proeevAhWO5luS6PcosAhif9o9k05aIB/M27HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7205.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 12:32:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 12:32:57 +0000
Message-ID: <0b07213a-d4d6-415a-9179-b9a632a78aac@siemens.com>
Date: Wed, 10 Sep 2025 14:32:56 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH libevl] utils: net: Add missing initialization of query_type
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
Cc: "Schaffner, Tobias (T CED SES-DE)" <tobias.schaffner@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0269.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: eda64d5e-11ef-425c-42d5-08ddf0662c37
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXJFajdMYkZHcGFqc2FJeExKRzFJVnhoVHlFU1pQTTliQWJvMlBEVTd4bE55?=
 =?utf-8?B?M1Uveld5M0lJcVN2b1JNN3p2blo3bDJtZXFPSFBlay9hMlRpTWVPTmQ4U3ky?=
 =?utf-8?B?b1BlNk9la2E1bC83c2hDRm1ZRWVCWUdIZ2t4QWpBQU0rU04vSTZ2T3ZSUDFu?=
 =?utf-8?B?Vi9XL29BNTBTc0V4OSt4WW45c0lGdk1MTzFpKzFRbEU3bDh4cHI1MzYxamRU?=
 =?utf-8?B?cGdDLytCcHZZRVJjNHFpSXNPcFZEZkRHOXJpT1NpRjZjS2VqcTVtd05sck5U?=
 =?utf-8?B?V3pnNlQwUVFFS1ZFWDMrWExiQm5YeitmNXJodTNXU3IyQTFXRG1QUXJJdVBm?=
 =?utf-8?B?SXo0dTgxelMyV1ZPYzVaODdtYk5TajE5ZXlDMElaVlJPUFIwWFBWM2NaK0Vx?=
 =?utf-8?B?djlRTkJ5MHcwdGZILy9JRHdPRmNCUGVVZVB2aTlSdnNweG45K1VPNmpROXYz?=
 =?utf-8?B?NTBUbWZHYTJLb1NCdkpOb3M3QVNaOXRxL2gxK0gwU0ErcHJPZ2cyZmdBeW9P?=
 =?utf-8?B?YWNaeWpKUCs2NG1EakhlSElLekp5N2MxTDdCcmpUNzhaL1BlZ05STVAySnhB?=
 =?utf-8?B?TE1QallUaUFMczBVK0lITnpDSXh1QllTRFBJMjlYWVVWVGEzYWpReVJOWC8z?=
 =?utf-8?B?YWVtM3plMG1oOGlVS0xnYzRuWkZ1VDVUaWQ4SksyZWpWUkpTMWhObzhibkwr?=
 =?utf-8?B?ZGZzMVNvcCt5aDhmekNsdHpsa0Q1MlJQYnJ4VGppSUk4N3hteW1KK1RYdW1q?=
 =?utf-8?B?ZWtmaHpQdmZkOHRVdFo3SGdIL0xWOUZPZUp2MkVIVmJqcFc5L2FRaCtJam5T?=
 =?utf-8?B?Y0Y3RTd4Nm53NU4wQStQY1RPeEtWNjNxbExYaXdYWWRTdnpJSDRKTS8vd1dL?=
 =?utf-8?B?UXQ2aEZYM2h6QStDM2JNQTdWRnoxUTBiVnBmMXN2eVlHTnErSzJzWjNmbjhP?=
 =?utf-8?B?cEhSWGx4L0ZtRjhLaGhTcjNIdlg5ZTFsdlFxd2YwL0R0UDF5eTNOU1N0a0Ir?=
 =?utf-8?B?TlljWG96cmV4dUk3QXBwQUxiYmMzenZ1Vkd3WndqOWFKK3RRSWFFTzBFd2h3?=
 =?utf-8?B?eFkxSEhPb0RyR05wYmtINXo2bm9NdGdMSEQrL3NQMnk0NVI5QithOVBucmc0?=
 =?utf-8?B?dDRjOTZXTWhGanFYOHBEdzlVV3c2ckZScHVUMmRzSUFJbUxxbzJEcjlkRFFS?=
 =?utf-8?B?Zk9JWUM2eDQyOG4wTmJZbU1NY2h6UVZHc1hUKzRsbHRpaDhiT1BxSTEycysy?=
 =?utf-8?B?Y1kwY0ZWQ1ZkSERMY1pvVW16WllLdmhybk91YndwWnNBSXVNWkt6UDhJUFN0?=
 =?utf-8?B?NUZWbXFhSkFJai90MG1BN3VYQVQ1NHJYeCtDSzZnOTlVSXdrREg4d3FzNThn?=
 =?utf-8?B?Z0JJUGU3WGxjS1lhb0cvNHJJUXRXcDBPVGVkSVU5MGpScnplZWE0b1Jqd2Nt?=
 =?utf-8?B?R2MzYVIxMFcrQUwwSTBHd0pzcDBMS1k3akoybUNwYVYybHB5QUJOMGtxVFFz?=
 =?utf-8?B?a1JnYWNnc25sL3BKK3Rod0FXaFVmdERDOWFOWThwUGZuWGhPZUZHQ0tZdlBj?=
 =?utf-8?B?ckhjbWdPa1U2SFdCU3czL1o3VVdGS3FwdTM0d2J0TVhJdXVuV3lsbFVWMklk?=
 =?utf-8?B?NTAvM0VRbmhuUlNnd0VwWU9YMHJiT3hyNVNjTHo0citSSW55WkZEWTFRM0Rn?=
 =?utf-8?B?N1JOUTBVZmdRb0syOXpEdHVMZmxxam1EcG1JeVIweUFOQ2FxTkhuTmlBeFd2?=
 =?utf-8?B?UGFZSjdGYVBvQ1NnU1M0R0w4VStXSUtrVkw5TXRtMEdQZGdRM3MvQ0RTZUZh?=
 =?utf-8?B?UzFxaklsM0hGNUc3NEkyVmkzQ0t5aTJ2Uk9pMkRpVFdjR0oxemlkQzZ6bEhz?=
 =?utf-8?B?V3R0VnJUWFVVc1J4OUtkQjlaUVVYRVhlcmJxQUZtMXFIQU5NdW1Oa0p0M0dO?=
 =?utf-8?Q?i4N9veCzr0o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkpITHlEZlVhaEYyOHl5ZERUNkdNeVYyNWdrOE1kZ2RPVlZOcW0vYzlQdWU4?=
 =?utf-8?B?a0hkZ2lLRnE2bjMyYkFyeFN3WVE5N1hZQXRsL3BjNlpFdVg1bngveDZGek9z?=
 =?utf-8?B?Q3p2d1Z1eU40eU85QmV5dlgxNzd5WmF0ZlNFZVhyUUxsVEc3VlJhbTB0VUpY?=
 =?utf-8?B?TzNyQjd6ZTlDclVaaC9kdi9sdDV4T0QxMS9US0xrQko1ZUlabHU0Y0JUcHE5?=
 =?utf-8?B?cFdtOGozSTNGMW9yYmhLT1ltOUhwc0tSMHNDd0tKUUIvWGFkNCtYUkYwcEtr?=
 =?utf-8?B?VDhTRlduMlYzSkdFY25vbUJ6bHFlSFc3QlJSVU5Da3Zsak9ha0dEcktLaUwr?=
 =?utf-8?B?U1FKQzVlKy8yTWx4ZTBRUTExOVl4Rk5yYTRBc0dJR0g2cEIwZjNuanQ1azNH?=
 =?utf-8?B?WlB3b1JKWUVaa2Ftd3VjczVXa1FObkI2NW43dkMxcVcxeDVnaGdnVmljREJX?=
 =?utf-8?B?NkNIR2NnYnM5NjVrOVZidnl2RUlOOURNQm5ZZXhqejF3TEFJTE5Ydnh4NVVF?=
 =?utf-8?B?T3J3NElEb09DUC9DaTdHNHlUclpoUm1TbitPN2tGZC83bGZpQ2F6a1dHdmZJ?=
 =?utf-8?B?Z2NQclRibktMbWp4aHlWS2tjdmJ5dVFEMTlSWXc2ZUc2KzdkMFdPNVVldXUx?=
 =?utf-8?B?R2s2UEJSenVSd04zUnBGQzRTNmlxQnFPYysydXBkeFE4OGNud3dzQSthOG0z?=
 =?utf-8?B?d1dkUldONGxWM1QxdlIzVGpzcTBDcDRUaXgvanZzT0tjdjJiSU9CTjlLV0Nv?=
 =?utf-8?B?S2dPaEEweTdaZVdiNytWUWpFK3RDNjVER0hlTzVoTWMwQWwzVGE3aHZjS2JY?=
 =?utf-8?B?bUNZZWlyeWFhdmU0ajEwcDN2L01IUGs4QWF0bS9ZN3FULzg0VDV6Zzlkc2Vx?=
 =?utf-8?B?bFc1OGo3eTFSWEJSbmZoRDZEcU5NTis4MmtBY2JzbWZrVkRBaWJET1NnUGln?=
 =?utf-8?B?NXpFVFBjMEVFdzk1NkdoQThURkc0Zit6dmlRbURiY0U2NThwMDZacUs0alda?=
 =?utf-8?B?MXVzcHBzTG1XR2NBMnpOV1psZ2FnZjZsajR1MG01bmFrK1dUR2g4WGZlMy8z?=
 =?utf-8?B?ejVaZExkZjdpZlh2MFR2RjFPTHVvMTBvZFh4WWdzYXJZYjZhZW12b3N5Sjc4?=
 =?utf-8?B?UlVGTUxwVFpnc1JPRDh1RE43NWU1N3RPSlNoTUFBVVVOaG92M1l3cys4Qk52?=
 =?utf-8?B?VDN4UWhtTGZyem9iNVhJYUJYWS9MaUlUcTNzV2dkWFBVaGFQTmMxQVVaaGxs?=
 =?utf-8?B?YlF3bWlnTjc2RUV2b0pvYnFZWmtBbzZjcWdmRFBqQ2ZYbzN1QjI2NCtnRU1O?=
 =?utf-8?B?ZTE5V29HQ1lEREJMVUtiVTFjVFBUWXphYTJuREVpNWJFdnhtVzl4WmlLRnlJ?=
 =?utf-8?B?RlZGaXFvRWZBQVcrS3lGelNoMnVFbmFkYWNEZ00rZ0FjMjRyWk4raklJcUhQ?=
 =?utf-8?B?eitja2VlTW5Dd082R0srcmh5WFRMYnd4SlF5ZDRIeEFqK3lEMWJndzlVK1Js?=
 =?utf-8?B?SmRBZW9PQ2x4ZXNFMzErR090K2JxMzh5VHE3VVB0M1UxZlo3dExrYWhjcUp5?=
 =?utf-8?B?M0N0NzlGUW4rMGV0TkpnRUhPWGVCN0tnS21sOFE1aGdyV0FQMXhhNVFEeWFx?=
 =?utf-8?B?Z3J2QXpjZTdkbkJCRTE5c2VoUmh0cWNMVDFRKzg2UTFkRGp4aktzQXhBZjUx?=
 =?utf-8?B?RndidWhPb2FRL25hKzVYU2dhWG5NYkdLaG05aVZPZ3NLLzJkbFA2TXdMNUIw?=
 =?utf-8?B?dnhRSFU4MytmYXNaSTMxTEdkeTFFby9FQVJROVlwbDBmOG9NUWpQQkhBQlJm?=
 =?utf-8?B?VTFGRWJvZmIvaWlQM09DQ1IwcjFJc012MGlCMWhkRzhQaDR3QjRhVDF2c1JV?=
 =?utf-8?B?c3Q4cTdSM3AvNGxMOVVxU0hmZnRZNGdBTXQzcFlTNnBFUU05Y2F1Q0xoYi94?=
 =?utf-8?B?WFZPcG10ekhQR0FYWW43SHU3a0F0M1Y0NE1lVENBNXhWb01ENHFmVTVrYmZs?=
 =?utf-8?B?NkQwMHEzODRkS1YyQk11Q2ZmeVRoU0taRjhJa2VGZkh6WVdid3FqRkZMM3BI?=
 =?utf-8?B?OTZOa25qam1IOC8vR3pkdzRVKzgxSGlJNW1KR2ZuZkdINkVITis3bFJWUWVX?=
 =?utf-8?B?WWtPMjdBK2IrRWxQeDNuY2lnVmpUMTgzN1AvZGNCS2xGYXp5blkzS1RlaFJj?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda64d5e-11ef-425c-42d5-08ddf0662c37
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 12:32:57.7473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1KIl8P3Xj56xjxYmWya0ooNRSWSFz5pMcVYEZMmHbdweVkBSCwphSh1v20yi0LHaB9XzbUiyBpQCBbUU4Zcxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7205

From: Jan Kiszka <jan.kiszka@siemens.com>

Fixes

In function ‘query_oob_port’,
    inlined from ‘main’ at ../utils/evl-net.c:483:3:
../utils/evl-net.c:157:24: error: ‘query_type’ may be used uninitialized [-Werror=maybe-uninitialized]
  157 |         if (!which || !*which) {
      |                        ^~~~~~
../utils/evl-net.c: In function ‘main’:
../utils/evl-net.c:371:18: note: ‘query_type’ was declared here
  371 |                 *query_type, *vlan_list = NULL;
      |                  ^~~~~~~~~~

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

We are missing CI for Xenomai 4 to catch such simple issues. Tobias 
suggested to add at least a build pipeline to xenomai-images, until we 
finally have automated on-device tests. Looking into that, also to keep 
xenomai-images itself up-to-date with evl (we had recipe issues on top).

 utils/evl-net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/evl-net.c b/utils/evl-net.c
index b45fa60..b1d06a1 100644
--- a/utils/evl-net.c
+++ b/utils/evl-net.c
@@ -368,7 +368,7 @@ static void bad_usage(const char *arg0)
 int main(int argc, char *argv[])
 {
 	const char *netif = NULL, *modpath = NULL, *ipaddr = NULL,
-		*query_type, *vlan_list = NULL;
+		*query_type = NULL, *vlan_list = NULL;
 	bool set_filter = false, solicit = false, permanent = false,
 		enable = false, disable = false, query = false,
 		allow_routing = false, set_vlans = false,
-- 
2.51.0
