Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011049.outbound.protection.outlook.com [40.107.130.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6147A3A5E9E
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 05:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778650566; cv=fail; b=noL1N3WUiLncU4BwD34E5vvm8YSAlzQUim/3RsIXWEcoTYwUsZkp6aPuA80SsO8lwujkwp5S649lCkswBcgRrSo6Fw4sdj1s+a91M53k58PzldfF8Y2DFtrasMu3NqTO84WVzH5JgyfffBk2Q8lCvKRl8xLkCD5j77J1HEMhats=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778650566; c=relaxed/simple;
	bh=yPKCpi9Jg8wWfWGC2DrsvBhGyLoqO1OHNVdRRBUvW5k=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gptuL7HURMoesef5DN1Cmqf215Joc+u5oDQXagDIQiKI2e8H8vb5o+LiUnqnphZEP1PeD4ey7UxkhSjcGrSiTgDLOgnsrDbTZ3MEod8zn8Kpe3afolPQGJxZRNxYzm38N/P2VDikkbCDatS7X5JYc3DmBEgxH04sOJGuhwk1FW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=exaB+JsO; arc=fail smtp.client-ip=40.107.130.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="exaB+JsO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKiL8TGgmS0QsSNT7QUgBexoX2Caiq7Qy8CELw7+P/Fa4x+V0T5Q0xqRU1I2ObxqR9VfRAjZLsV6VnBfSu5/2pqDlq188zylVu5CWzATKNUh1sK8scCy8PGcNkdtVsAHyX6JtQLlfNf/N/wZZBM/vyfSg7shNVwbZrjmpP8ezgfZrcYFlOBgGjGKDsqrvhUzfUZKDTBEqFzCGpXJPen/1i+CE8e5RYYCfZbNgoJEE/HYEfaO8U0x0tVjhEqlcAbbv932mmPm6y99myilQpxbXUqZdAhDZqEgRnoGp/ZMA4n5SRcaTrShoZVI5WNC0E+b2Fku4Lq9HXThot70EXD2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU0Zka1CXAWz2GWaaNtkSqgW9ogv3eiXkyKPC/v1tNY=;
 b=Oz3XGZoMTEpK8miqmYca/YuZgg/WRYSB8Ewgy+AQPz78dT2mvgYSsajmMB8mxDNf+dCXGvpWxgP8tmMKzd2xqkL+W0Wp/uUBTvzDtR21MGP5NoXRuGz2dnkMDoLG+zUD1ROHn+BwCRXnAEQfcxa1kFsCbx31OhFL2X014hwdItZsHq5vrv1f1+k5SisisRQdd/aW/7JpYPvuW0r00zA2b+y4VEtEgFAcc6P4Us4jy0i1xh9wFAiJyOzDDOOKAJ8AlEWelTzuVeMor1euGeXpxbReHHLy/HA6yRjNoPbkGBlL+lbyMpwWxxn/3KT/gLWlhgGenjdEA+wabXjn4RAIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU0Zka1CXAWz2GWaaNtkSqgW9ogv3eiXkyKPC/v1tNY=;
 b=exaB+JsOH/SRe1vJmdeiUzCsKm2xT3uThgOUbtUTLg7u+r0AxSec+VTiaUWCztrhSpZRoDG18Zt2F8ysUvn3KuHOkmBP1jvN3+cdt9Rrb+Xia64nP3tszMSDf2H6u4NOwChwGZKwyT03jp07kT1WIkyJmxYLNhIsnPAsbKrjroodXBVyf/PHnnqmxIiovjjqe2mL8TGhbb+Mnbq9ecYbM2q0WxISHWGSiL226Xv6Xx0OE6XNZKLcVA0wkYYdVZnqjuKP1UsUw6bw3QlXMzSYqVBO+jgDRJvTA0RNVwazgZmw7q88bhhZ0gPNhRIK0etMEVrIMNbxMsLYNkJ+dYPxcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5192.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 05:36:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.012; Wed, 13 May 2026
 05:36:01 +0000
Message-ID: <e7e975fa-9879-43d1-9f28-60507e1563be@siemens.com>
Date: Wed, 13 May 2026 07:36:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Getting time in realtime kernel driver
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>,
 xenomai <xenomai@lists.linux.dev>
References: <131f-6a035380-221-a70b1c0@235187577>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <131f-6a035380-221-a70b1c0@235187577>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0237.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c5a5f72-67b8-414c-54fe-08deb0b18448
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|11063799003|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	SEp9Lrn77CEiCTFLu8ROGE4pL0KfPPQdZNHj/lrRK61G6dFgklzUsLdhP7r9erU9c0XKrVNdrbZp9vo6lmcqkap8m5rDRObVIqe1vPLvHasCIxRJ+AlQnXGq8gHtp74QFteXkWq/Rh4jyAZt3zN3l2nmVQ+PIqW48ly+SvP3kpQ6d9yoFKGWBqs1uc033y5jWIDBcHHj8cqzNT7NOSXRZexO4wMzsvRbfxRVcWdJMoYYvyqG9QH+JiC0IoIZP/F0tThqqr+boS5a/ReO0xseWaqXXxLNP4aL4qm8x9hYE2yQnmgavHZdUyWkLIIaLTJcbIb8BEQ9OqgD/KqtYd/XrWgb1srUh/IHg+UTiDQ9s+Yg1cycGWM+glm4XajfkUrp8/FjTOwkmZ7+dRhY0/ygUHvOzLA+cDVAx1dwT+Kn9m79UnB7bI7FKCB0SaN7eg73WlErjv9ES2m78b44ccHszaQ47JstC7tZ5a4n4EOHqNYc0jTo71uvsrLhLmUwSE1fHbz1fqjmXWdb/1SgYMxhj2w2aqL6hWtAfe2D2ubO0LxMoTNga0aiOgQK+do7nL8tXv/OaRe8eBy5X04t3h2W5w8zR8JPrUxCktL2qCKaXTpzn1cB50cPgvQDTq+i3t4vwdNjZlrv1mlKlsAExz9fn+RVt0voM2PIeVzkG1zAC/9WaVxwTWLwLMH98TtUFfvX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEpPUFozMkZCRTdzc0pIQ3dBSWdZSkZWd2F2RjZiazNqdmZza1NteEFya0hp?=
 =?utf-8?B?VU1JQlZ2Snd2dEJ5S2VXMDAxWnRGN1AvbjNYdEQwTjRORGZoY29Ndk5lWjB4?=
 =?utf-8?B?bXIvMk53VWRxekZqMmFMa3kwSVNnNjljUlFvWm9SRUtja0ZTUTJDTUhmZWJL?=
 =?utf-8?B?c291TUxYTDVvanp4Q3k4QXpQUkxPSHRBTHpjdXpXYVdKNHhlS1puM090OGdz?=
 =?utf-8?B?NXlIa3BlSFVsbkpoQU4xVkI0cUR0ejNhUUNwSkVnNGpPMzBPVDc0bjlSdThq?=
 =?utf-8?B?WDQ0TUk4ZEwvMXN1cTFhY2h4Y1hmdnJ0ckpvMGVONWZZdFR1ODY4V0Z5V3Zv?=
 =?utf-8?B?K3hxMzNkMTBZUmNKQnlwWXg2RnJ5dkRhNXJoZk1GWWhwLzVOeUxwanhSVXFs?=
 =?utf-8?B?aEVkMmc5emZKL3dlSW9wZ05QMEw5YWZtRmZHWFlWd1pWYmViTCt0YUdZRGJv?=
 =?utf-8?B?RTBTYXlyZzZnSVJ1WmxlcUxKOW04akwrYytIVkUzNkpYTExHSUFKa05LTC9Y?=
 =?utf-8?B?Y1dKVC9UOGJjL0dCdXZyYkRKbmxqZ01XZlpGWEtRazBLenIyU21vMmZlU245?=
 =?utf-8?B?L1dDRnpzUG4ySEI2eFJLVGd4TisxTkJpWWNUdUorNXY4NExucGFnQW9pb2dM?=
 =?utf-8?B?RFczYTYzMkFWMW9ManRKbkxId1lVMk4wOGlPN0N4d20yZ0tCWE9GVElwR2JQ?=
 =?utf-8?B?a0d5RDJuNWd3V0FoUlh3QTduenQxeFVBcnpzQnlncGhlSXdqMG9Xa1kyb1dL?=
 =?utf-8?B?SXZBVktPSUhsRVZwL0wzQ1lSWDU3QXdkWUdQeVRDV1h6ak55djloVHMwbWJY?=
 =?utf-8?B?RjZ0UWFnUHpoOS9GYTZKSDhTSzllaDhuOHBWOXdyV1dZcGNFY3lpdFJzL2FH?=
 =?utf-8?B?WG5sOVBLWnAveWJhRkhRYjIvOEhJWEVBcFA5dlRlVTgwS1hoRmxtcVJZS043?=
 =?utf-8?B?SVI1MmdJeTZGRHNwalRPekh2NHJ5ejU2OGtOU2NjY0dLZHRKUUxpUVgrdUh4?=
 =?utf-8?B?dmtKdnR1SlFQSi9LbmE2K2xGb2NPMVZRTDdNS3hwcGgwQ0JBNDJ1RW9UMG1K?=
 =?utf-8?B?ZldVSG9jT0NBdVZzVzQzTjhRSkFIK041bENWRkprMHlzQlVLK1R1WnpiYW1G?=
 =?utf-8?B?U0VEZUlZWGJsWU1BMGVVUElFTmV0T2FvaXAvaC9SOWtVNjFzemdRMU9DWHd0?=
 =?utf-8?B?Zms3MFlLQ1pTU1dHeUVKWWFCRm1jcWdvOWgyM09tY0J1bXhzejZPMW1oV2hU?=
 =?utf-8?B?aG1FbmJlcUwxeTErRlluamUyQkZ6MjVKRlV6UTArWlliUU5Ebi9zb1BITm9k?=
 =?utf-8?B?Rm5Va2FqZTNUdEorTnhzdnFPOExRaHkwM1RvUGxXT3pzN1d1S2NINW1MV1NY?=
 =?utf-8?B?RXh6Wmw5NWJYN0d0c2pwZEVoSnV0VnVvZTZhM3pXU0VCYk5vNVBDeHRyRk1E?=
 =?utf-8?B?RVJrRjBGSUl1b2xVbUJzT1oza05NZW9kUkliNWRMdkt5SkNpUUlRaCtwRHBv?=
 =?utf-8?B?b1EzZlgxY3JwU1o1UjdxSFB4T2xoSkhkcU9HQ0IvSW5Xb3kzTzd0VXFNSUpM?=
 =?utf-8?B?M2Fxbk5hMHUwTlFOU0lZYUUzNjhXN2NDTkIxVVZnKzhiMTJrOXpYWFJIUlEy?=
 =?utf-8?B?cUd6RFpZT0Y0YzdDR2swR21va202YjhQS001d3VpYnBUYzlXQW9yenVUMVFN?=
 =?utf-8?B?SCt4MGJndEszeDBMd3RpVmVVM3Q4dUUyeXFqY2NwVkMyLzlTSXlLTmIrWXUy?=
 =?utf-8?B?K1l5S08vRVkyZEkzUmV2b2MyQXkwMHB6azFXTEp5TGo0Z1VlTUxBZnhxNUZU?=
 =?utf-8?B?OWxBOW1sQlgrNGkxWGlNT29ZdVgrRmMwSTg3cHIyYldQZlQ2MXJUSEZPc25r?=
 =?utf-8?B?TGllSVgyaDJDRWp0MDRkd0ozem83OVRESGNXQ3pDb3NnR0xSaWxnRXVqUW1Z?=
 =?utf-8?B?cFhVSDJGK3Vrb3UwU1plYUlPcDJOY1B6djlUZDJlUGJRQVp0TFRJOW91ZU9o?=
 =?utf-8?B?SlZzbURHS0RKaG5XUk82c1ZhSlFiVzVCcEYxL3pUOGVVYVh4R3NFZCtVNnpa?=
 =?utf-8?B?MU0vYTY3WWthQnVPdmJXdWw5b1llUTl5MmJSOGRHWnBKRE1rQWtTaURYditi?=
 =?utf-8?B?M0E1eDRpRzduVzdNSlRzenE0UXpNWjNwSFp6Ulc1TkVNR0U3T1JqbE5kT3Nk?=
 =?utf-8?B?RTZBOU1TWGVBc3BCRDM5eGxmemZVdnptNmR6Rkt3bkUxZlNqSEhyYjJqd1Q0?=
 =?utf-8?B?cUw4OHgwajBud0ZyQ0cvSGJwWStsdFdOYVBJM29pQlc3MEVJaEZaQVJlTUh1?=
 =?utf-8?B?M2l4MEhBYnhLTWpIdDBZODlUK3NmZmtHTlY3dytpSW9KdXlNZ2s1UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5a5f72-67b8-414c-54fe-08deb0b18448
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:36:01.0219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kBjvsE5SPtcTvqdGfepu3ZQ3MvddOUMEUgprF+4cVIfM5vgxjEg+2+zzGGqSLLPui92OAVbuf7ReFuJ9vPwZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5192

On 12.05.26 18:20, François Legal wrote:
> Hello,
> 
> I think I already asked about the same question some time ago, but I think I did not get a working answer, so here I am again.
> 
> On xenomai 3.2 + Ipipe (linux 5.4), I need to be able to get in a RT driver the current linux wall clock (impacted from NTP or PTP).
> I found out I get the correct value with ktime_get_real_ts64. Was willing to use __ktime_get_real_seconds but this one is not precise enought for my application.
> 
> So my question is : is it safe to use ktime_get_real_ts64 from within an RT driver ioctl function, and if not, which API in xenomai gives the exact same time as this one ?
> 

Nope, it's not safe, neither under legacy I-pipe (your kernel is dead
BTW) nor latest dovetail. Userspace access to the wallclock was hardened
for out-of-band accesses, but in-kernel had no use case, thus was never
considered.

For userland, the easiest answer is moving to a dovetail kernel and then
using CLOCK_REALTIME. Over I-pipe, we had to model this via a separate
clock named CLOCK_HOST_REALTIME.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
