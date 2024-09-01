Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2058.outbound.protection.outlook.com [40.107.105.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8522433987
	for <xenomai@lists.linux.dev>; Sun,  1 Sep 2024 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725183248; cv=fail; b=AWbyOBe5x0HxYJOJeEgJcKfpyHN6tiHcxui/ia2He0nSojfNnxIPHDcKrEP7rWPGwhGtA3kL13rWd0EzAq+jTHF8Ar7nf112B6wJDvEuM9FIN4TtP8i+pIDiaF6H2d97iAtyh8RddFOQokqa7BYqJQIl9I5sKMBiqAhqzzB/IZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725183248; c=relaxed/simple;
	bh=YmlKeijztRIKz4+uOokF8sUs0N47v0idkXELTcC6Sqw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R+DomZpLoTjJ2SEVkAltT8Et7mQMrpABcGUSTulNcHOLQK3c/9zooHRYAU/ke/EfWWMMrVRtNF/jpC0uLXzHKAP6sNER0yLMdPAXwZtbo12w5++HE2eJUX/4aecn1xh5jCgnWr7p1iKpsjgxxPaapTJmJ6Cy4TxS6ehH/d0mseY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cPuQEEVq; arc=fail smtp.client-ip=40.107.105.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cPuQEEVq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/1RbardHRGzHYP6zUuXdF+9SdMwf+sc//2uCmMg1qy2BlG9q3epyEOrUMauyhlcHTxddLB2DTri4CjSh3tA4ANKogYIW4T/BaDtVUJpNN4NuxBgay+0kroFJGACBbkdrXV7le3U5fS+QWo81hwNTBnX4y9pJBywKanr4IjWTwx4RubsbnjJLmkFBB2sPeicTbJsMVJgDCeZSAVJhG9D5UmE2RLnTfMnJP9/O+3GTB8O2UOhxYLpg2AA4vYN4zBaSe3YUT/iso7keOr/X4RZLV576mlqh4W0QzagZf64ehd8PBpvD34F7mxoz2898D4pD+9P1oAh6AcAu4z06oCuhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rf/Jkgvx9+WCV5RlKOcEYAln687NU6JEJ0QFuKH5KXI=;
 b=LxY4FIsKh5nczEbqeooKUQFWQ6v5l4uPHssyaZsrhDN9rigcoIEEINMX9SwZ2H7k4AIXm/rv2KGAXYXVxTx/W1i5cjBKPBVLAeDIWx6agJrsyTr/vgmJxEoEh3H/ydevyETzMrQJqLeSinYDkpxIF3V3bEgqYXTRQiO5HmMu4+Vrw3GyTYaE51FNieRqyYTe7D6C0UowQ9Y80BOYzDTJSXft3WG2oSv5z8K3qdw3xZF6TINHzffTMXJ+/cGI0Ec5YsTpCJjQj0hO3YLyFQSh1nQ7zEYOyf4JH0w04l+SHJYCMT5G96M/iRZHyAJOjHfhx0MKLDr9lY4kqOxoESXukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rf/Jkgvx9+WCV5RlKOcEYAln687NU6JEJ0QFuKH5KXI=;
 b=cPuQEEVqpkjY3j4y+pFGK8ynuD0fuOFz57mekSwH4t6APmB9kPaB0UBIiqIcI81AIetHGNE1nRuSol6A0AEvN4vv7R/l+DDZ1K9Oww2uGDo/83+qJvP5vnLqCCuOorY4SdiWkXlObtqT2CAMZzJYQxLZpZezgvf6VqGh41aNycdxmVfK2O8mmxMBLgWNUSQR7RMYj6ynzyfgeSXSFtGh+gf1Q5JiiwOSIDY9svPUiIRNkter2SGHTmFQzFayq6QJrPgFikEp+P3G1esWfj34U6zE9+WwfcBm1rOv6rOKEEwDZMyLbLOs2SOkVbuYgajreI1zCnw9GnasW6+RlkYRXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU4PR10MB8447.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 09:34:00 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.7918.020; Sun, 1 Sep 2024
 09:34:00 +0000
Message-ID: <c463131b-3d77-472f-bc53-9acf6f160860@siemens.com>
Date: Sun, 1 Sep 2024 11:33:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2] ci: Enable sstate caching
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20240723140801.1247672-1-tobias.schaffner@siemens.com>
 <6239feef-9326-4ba9-a744-db774134b128@siemens.com>
 <aae26c91-4765-48d1-a02f-3f0e5b4521b6@siemens.com>
 <006108ec-7fcd-442d-8009-5d16118d87da@siemens.com>
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
In-Reply-To: <006108ec-7fcd-442d-8009-5d16118d87da@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::15) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU4PR10MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: f0cca300-ef7c-45c5-b6a3-08dcca6935c2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEtGNWpBVkhJS2x1ZFgyY3gzb3orcytHU3hBeGl6YTRCMnppNkg1THZYc1Ju?=
 =?utf-8?B?WU1NdHJSdFFPY3c0SE1IWS82N3I2VllVcUF3TmQ1ZzZONnJKRzNFZDAzS2hv?=
 =?utf-8?B?bnQ2Q25mZTBQZGxRcW5MQlpmNSsrUFpoOWM5QjlZVERiYVlVdFZJWWhOY3ZD?=
 =?utf-8?B?YVliRlN4ZWhMT0hPVThkMnd6QXBxYUNOeFRVZWVQeGJ4cDI0RitPNWF2WUxG?=
 =?utf-8?B?MjVjd0FrbFp5Zk5VUDlZd0IrUGZpeC91S3U1RHRmRElZTDRmcHZJSnBNMGlL?=
 =?utf-8?B?eC84a0VHKzViRXh0aTFOU3FTRlNTM01BdUFVNHBiQ251amZvbERMYjljS00z?=
 =?utf-8?B?UXNLQThYL2FMUkRGTkVHNnFCRjVId0ZBODlNa2xHQVVFRWxlNkhQNmMyQ0lS?=
 =?utf-8?B?WWlIYWU2dHZlOHNJYy90ZU1kRG5RZEFlSEFWQVN5c3hvMXF2UmZXMWZoTWZz?=
 =?utf-8?B?L1V2ZVUrRHhLMElsVWEyREZuZmJWanYyRTV1Qk9sZWRYeFgrQXFzeWJoMG44?=
 =?utf-8?B?YUdJSFBIOVJyM1JGbTlMK0UvSDRJb3J4NnRHaXNtWnpBaDJLd2xSaGVNSmRk?=
 =?utf-8?B?UVYwUUJRZUZ0UWpWOFFQbVgzb3UwM0NxU3hPWkppT3pucXAveW05dnVUZ1Ix?=
 =?utf-8?B?MzFmOGJUTC8wY3JvMHNERWNCN1daS0pyWlRsbFdKci9ZeHNJYTRPM05kbitI?=
 =?utf-8?B?RE9Zc1JXb2ZKSHpWVWF0YnpjdVBON1hZUUxVSHN5WmxMRWRjbFEwRWNOMmtj?=
 =?utf-8?B?UDJXUUluMWFScHJGMTV3b3pHL0o4cHVBL250bXlWNHFzMkh2UUh3ek5JQVAy?=
 =?utf-8?B?QjJkbmlrQ25WN2U2TENYRnh4aFVNbE9BUHY3TFVTNDJrL3c1dDdtNldZUlYy?=
 =?utf-8?B?dmJoZFBvelVJVGIvK2h2cmEvYXZEcVVONEFHYUExb1NxMFlFM2JFek1ob3gz?=
 =?utf-8?B?WG54SEJVajF4bnVLa0E3L0E4R01xRDlTTExZR05CamtFYkNCcmVFdHV0TEtl?=
 =?utf-8?B?dnI5R1BDdmRaY01EaUQ5aEdGWFZYbjZ1RFd3RlZ2QWRZUENIc2NCNEtsbTBE?=
 =?utf-8?B?OHlDdUZlN2lnOHNmTzRrSjlZdkdieTJ1QUwyc09Cci9qeEhHYXRSSCtva055?=
 =?utf-8?B?ZFhxTjQ3VGRDVmFuUkZ1STljV1BwVzROL0tTOHQyQlVXTm50VGFEZFdPZVVa?=
 =?utf-8?B?bXQxQm5SVmRMNGRpY1BuRzZzeG96ZkRNbkRCYmFmd2RmUU9pak12aUY4cFRl?=
 =?utf-8?B?emFzd0hBTkdBQlZyakZwVlZjeGNpTi9XYm0ycTFFRVR5aWo5aUpkWGhBVGtz?=
 =?utf-8?B?K2E4RGVPNUJjTEpqWUk1NUtzcy9oVE5TdU13MU9iSTFXeUVTajhIenEyWWd3?=
 =?utf-8?B?OS9QT3JUT2huTzkyYmlYWVlvTFRJTU5oVDQ1UnMzVEtRaWZPTWFlei9TRHMr?=
 =?utf-8?B?UitidW10V1BkSGxxb0xPZ3RHK2tRNk8rRlBQb2JwMUtpZjZJa1YzNU9pYVA2?=
 =?utf-8?B?RkJjZHhVT1FDSWRCMDdpcFV1djdIczYwemZGY1IxY2trTlR2RTNuUTEva2V5?=
 =?utf-8?B?WWhXQVNPdnFzVjFFZEF0VGNiZ0hkbHVJVk5mWjU2dkNqYjFqbHR0NE94dVlS?=
 =?utf-8?B?dk5wbzBKSDBMQnQ5V0tKWkMzV3k2YU1uZzQ0ZHBwL05aR3hpQjZ5cTNjclhX?=
 =?utf-8?B?T2ZGamlUejgxVW1ScHJsV1dzZ0F4dXBzc2VSWHREb0lYQW5BWmtTUzlONTB6?=
 =?utf-8?Q?AeeixRWJfxONu6IoTU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUlBRDl6ZzB1akdjS1FMMkJ0RDdla29nTDVpRmQ5amVYa0VHNHlGbmsyNGEx?=
 =?utf-8?B?cjZrMjNZc1VYalBuKzAzam9mbXZQOHJIa3pjSVJrT09QakVpNTUxLzYyNEN1?=
 =?utf-8?B?KzUrRHhid0JkbGJQdjlpVVdTL05rcDRVOVJjZW1aei9xNHhIMlRlUTgzVll5?=
 =?utf-8?B?ZXVMOWZpb1lNbzJCSzVxQkxQWnQ3UC9nNEZIZ1U1TjRudE1McW5XcUppNTRq?=
 =?utf-8?B?ZVdHUERMMFF4dDNvYVJkbnUrUmVhSzVFZEo3YTlIQ3lKa0NTZ0lDNDNIS3RI?=
 =?utf-8?B?NDU1SUwzMXpIZ0dqclBydTZxWVMydHNQc3J6VFBkT2NJN29IVUpNSW5FY0NN?=
 =?utf-8?B?QjY0OC9XSEhJSkF3Z01HbTEvSmdhOUoraXQzM1VWallxWTVOaVRlWXpCNC9H?=
 =?utf-8?B?YUw0MFZkWmd6U0R6V0RvUEp3MHJOUjliUVo2b3dnV1ZnYk94aFI3YjU0T1NF?=
 =?utf-8?B?bXBrZjVrb0JialBrSSs0QzJodW43dG1lekVQcEVwdEszV2Zvc1FsdVo3UkFr?=
 =?utf-8?B?U1ZCZjdrKzVwYmN6NC9nYkFSNWUzZ2NFdnhHWXN1RUVLZERkd0JDM1lRUm5Z?=
 =?utf-8?B?YThTeVhUb0hTYmJ0UjZwUzBKQ21RVnBnS050VUhLZ0ZlVnlhRTJKRmR1bGpI?=
 =?utf-8?B?dldqdE91c2pUOXBFeVI3bFZBSkNPWVh3aWNTTGFFb1JNbVB1d2NZRlpvbWhs?=
 =?utf-8?B?TG1MdG0zSDhGb3hlRU9rd0M2bVo5bWovR29NMWEyejJKeHBTTFdWUnR3N1VU?=
 =?utf-8?B?S3lWRWJjRXVObFFaN0JQejNpZGN4a0lRRzlmY0EyaTNjVVNobWZZVWx3ZHFk?=
 =?utf-8?B?cld5cFJSWld5RTdrSThGQVhLZVN2VEZnelZKb3J6YUtsZUVSWnUxWVpuaVYr?=
 =?utf-8?B?UlN2LzlCTHJqbWtTTVh4bWVyN0NHVzVJdUhzMG42V0hpcXRxRTl4dW9OQStT?=
 =?utf-8?B?STBwOW9JdWwyWE1uclRZWk9IcUpuVFVQNUN0aUJmVEYzVWNzVXJDb1VqaVN3?=
 =?utf-8?B?bkwrNk1FVFhXOHJwUXlaRVB4OGhnQyt4MjUxN3kveEFXMDJJYW93OFNsK25K?=
 =?utf-8?B?K2N6OW5HZ3lQc1I0Z0QvODg3TGlPcWdwb05uUlMxMVJXNkptVnUzTC8wWE1q?=
 =?utf-8?B?cFBHYUR1ZDBvTmxpczNEM1JOaVRZSlhmaC9vNXVtMGNEL3Yxb1hva1RQdSty?=
 =?utf-8?B?d3R3dUNXRXlVdG1UcW1XTEwxUHFlOHJ3Nm9SQUlSMUJUSVdzU2NxWUxBaytC?=
 =?utf-8?B?Y3ByY3E4VkhVOStUaW9WY3FlMnJzZ1FxUE52U0hvekpCbk9aRWlWMWtiaFVS?=
 =?utf-8?B?d0x2ajUvMkhWTUtXSCtaYnpUNXYvZnFUdGZoUURsVXRCMFVGaTdkUm91ZVZK?=
 =?utf-8?B?RVZaVTFYeDRZTmxSRS9FYWxvdXpoNktmdzNVck10RTFkZEIyUmxuTHNkTW9Q?=
 =?utf-8?B?cXRLRGJtZG5PQTBseERqQ0ZOQjFQK0MvVERJMDg2RFBubjFoVCtMSXltazFD?=
 =?utf-8?B?UElVS3k3WTRKc1lUU3U0Wlh3YkJWVlpwbmd5UytCYU1HNUhOcXJRcXpmOVdW?=
 =?utf-8?B?bHhsOWhmNFlyZlQ3MGZ0ZWxadmE2d21mZnZTcWtwYU1CNGFSL3BBdWRsVS9s?=
 =?utf-8?B?eWl1ai9YOFQzY01laWxpU2txY1NmWmNBVS9lRmtxVFZhMm14UVVoMlhVWFlN?=
 =?utf-8?B?OVRRWU1KQ2lCak81N3kzRkVKOEVHYTFkV2NwYnVoNWVKSWV1dUp4TlJWMVgy?=
 =?utf-8?B?NWJ2UUY3d1BKNXNZdHRUV0xidGx4NldhRkk0dElHQWRjTmIyWVVTc3g3TXh4?=
 =?utf-8?B?MUR1c3ZLanJVR1lRUHhkQWdsLy9yMkN2OU1QQWkrUThTdEo5dXpiQWQySDdT?=
 =?utf-8?B?NUJhNWpTSnFueG5pTGp6UTFDTk9uQ0FlOWlzM2hmaVFBMlI2ZEE3aDJpOW9L?=
 =?utf-8?B?OGpPQndseFNhMTNvSFBNaE1oK1o3NEwwdDd6WVdiYlVnOE1lYnF1Z3VoVkxZ?=
 =?utf-8?B?T3hCTnEwOXhGdmJyYlJ3cTNMSGVwUElERU9LcWovR3MwdGlmVzlGZHl1WE1z?=
 =?utf-8?B?dUovYWc4blE0dUliQldUcU5KeHpqUnIzMnhZMFQvaGFEWnJKZS8rb1BhRTl0?=
 =?utf-8?B?TDZHQkk2RkV6dXB5V3BvSVY5eWlSbGtyOW95VEVBbjZFM0FWanB1ZXVLdmhX?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cca300-ef7c-45c5-b6a3-08dcca6935c2
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 09:34:00.3336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Nel/RDbNgW4vRTxrVagTIPEqTPVvInkHrjHn6mvHchddeXkR7YtugWAoxcNhOSAGhrxN6VEI9ZtN52oVPbbOkhazgCyAQOdHM+kzKOUdMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8447


On 30.08.24 15:47, Jan Kiszka wrote:
> On 30.08.24 15:44, Jan Kiszka wrote:
>> On 07.08.24 23:52, Jan Kiszka wrote:
>>> On 23.07.24 16:08, Tobias Schaffner wrote:
>>>> Enable isar sstate caching to an aws s3 bucket by using the
>>>> SSTATE_MIRRORS environment variable.
>>>>
>>>> The isar-sstate script is used to upload, analyze and clean the remote
>>>> sstate cache on every build.
>>>>
>>>> Cached artifacts will be cleaned every 14 days. This can be overwritten
>>>> by setting SSTATE_MAX_AGE.
>>>>
>>>> Credentials have to be injected using the AWS_ACCESS_KEY_ID and
>>>> AWS_SECRET_ACCESS_KEY environment variables. This is already done for
>>>> download caching.
>>>>
>>>> Currently the size of the cache is ~20G in size but I expect this to
>>>> rise to a multiple as soon as this is used in productive environment.
>>>> Keep an eye on the output of isar-sstate info.
>>>>
>>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>>> ---
>>>>   ci/gitlab-ci-base.yml | 47 ++++++++++++++++++++++++++++++++++++-------
>>>>   opt-ci.yml            |  4 ++++
>>>>   2 files changed, 44 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
>>>> index 1dc05a8..f5009e3 100644
>>>> --- a/ci/gitlab-ci-base.yml
>>>> +++ b/ci/gitlab-ci-base.yml
>>>> @@ -24,12 +24,39 @@ variables:
>>>>     TEST_RUNTIME_SECONDS: 300
>>>>     TEST_MAXIMUM_LATENCY: 0
>>>>     TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
>>>> +  SSTATE_LOCATION: "s3://xenomai-images-artifacts/sstate"
>>>> +  SSTATE_MIRRORS: "file://.* ${SSTATE_LOCATION}/PATH;downloadfilename=PATH"
>>>> +  SSTATE_MAX_AGE: 14d
>>>>   
>>>>   default:
>>>>     image: ghcr.io/siemens/kas/kas-isar:4.4
>>>>   
>>>> +.sstate-prepare:
>>>> +  script:
>>>> +    - kas checkout kas.yml
>>>> +    - echo "=== Prepare for sstate at ${SSTATE_LOCATION} ==="
>>>> +    - ./isar/scripts/isar-sstate clean "${SSTATE_LOCATION}" --max-age "${SSTATE_MAX_AGE}"
>>>> +    - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
>>>> +
>>>> +.sstate-analyze:
>>>> +  script:
>>>> +    - echo "=== Analyze sstate differences with remote ${SSTATE_LOCATION} ==="
>>>> +    - ./isar/scripts/isar-sstate analyze "build/sstate-cache" "${SSTATE_LOCATION}"
>>>> +    - echo "=== Check for cacheability issues in build/sstate-cache ==="
>>>> +    - ./isar/scripts/isar-sstate lint "build/sstate-cache"
>>>> +          --sources-dir "${CI_PROJECT_DIR}"
>>>> +          --build-dir   "${CI_PROJECT_DIR}/build"
>>>> +          --pedantic
>>>> +          --exit-code 0
>>>> +
>>>> +.sstate-upload:
>>>> +  script:
>>>> +    - echo "=== Upload sstate artifacts to ${SSTATE_LOCATION} ==="
>>>> +    - ./isar/scripts/isar-sstate upload "build/sstate-cache" "${SSTATE_LOCATION}"
>>>> +    - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
>>>> +
>>>>   .common-config:
>>>> -  before_script:
>>>> +  script:
>>>>       - if [ -n "$ALT_DNS_SERVER" ]; then
>>>>             sudo sh -c "echo 'nameserver $ALT_DNS_SERVER' > /etc/resolv.conf";
>>>>         fi
>>>> @@ -40,17 +67,22 @@ default:
>>>>         fi
>>>>   
>>>>   .build:
>>>> -  extends: .common-config
>>>>     stage: build
>>>> +  before_script:
>>>> +    - !reference [.common-config, script]
>>>> +    - !reference [.sstate-prepare, script]
>>>>     script:
>>>>       - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml"
>>>>       - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml
>>>> -    - du -sh build/downloads/deb build/downloads/git build/downloads
>>>> +    - du -ah -d1 build/downloads
>>>>       - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
>>>> +  after_script:
>>>> +    - !reference [.sstate-analyze, script]
>>>> +    - !reference [.sstate-upload, script]
>>>>     cache:
>>>> -    key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
>>>> -    paths:
>>>> -      - build/downloads
>>>> +    - key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
>>>> +      paths:
>>>> +        - build/downloads
>>>
>>> Strictly spoken, this chance is not needed because we only have a single
>>> cache entry. Anyway.
>>>
>>>>   
>>>>   .build-qemu:
>>>>     extends: .build
>>>> @@ -59,8 +91,9 @@ default:
>>>>       - if: '$ALL_QEMU_JOBS == "true"'
>>>>   
>>>>   .test:
>>>> -  extends: .common-config
>>>>     stage: test
>>>> +  before_script:
>>>> +    - !reference [.common-config, script]
>>>>     script:
>>>>       - scripts/install-lavacli.sh
>>>>       - scripts/run-lava-tests.sh ${TARGET}
>>>> diff --git a/opt-ci.yml b/opt-ci.yml
>>>> index 01d5c07..e1466a0 100644
>>>> --- a/opt-ci.yml
>>>> +++ b/opt-ci.yml
>>>> @@ -23,3 +23,7 @@ local_conf_header:
>>>>       IMAGE_INSTALL:remove = "sshd-regen-keys"
>>>>       IMAGE_INSTALL:remove = "expand-on-first-boot"
>>>>       IMAGE_FSTYPES = "${@ 'ext4.gz' if d.getVar('MACHINE', True).startswith('qemu') else 'tar.gz' }"
>>>> +
>>>> +env:
>>>> +  AWS_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID}
>>>> +  AWS_SECRET_ACCESS_KEY: ${AWS_SECRET_ACCESS_KEY}
>>>
>>> Thanks, applied. Let's see how it will behave.
>>>
>>> Jan
>>>
>>
>> Only saw now:
>>
>> 2024-08-30 13:22:20 - INFO     - WARNING: xenomai-stable-3.0.x-r0 do_dpkg_build: Export of 'AWS_ACCESS_KEY_ID=[MASKED]' detected, please migrate to templates
>> 2024-08-30 13:22:20 - INFO     - WARNING: xenomai-stable-3.0.x-r0 do_dpkg_build: Export of 'AWS_SECRET_ACCESS_KEY=[MASKED]' detected, please migrate to templates
>>
>> (e.g. https://source.denx.de/Xenomai/xenomai-images/-/jobs/894592)
>>
>> Is that an isar issue (but we are not that old), or are we rather doing
>> something wrong here with the export?
>>
> 
> We are we exporting these into the kas env, to bitback? They are only
> relevant for the deployment script, and that runs outside of bitback.

Bitbake needs them to be able to access the remote sstate mirror.

Best,
Tobias

> Jan
> 
