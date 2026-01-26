Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392B32AAA1
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444799; cv=fail; b=M5JY/bvcTUHdms4H8XpheFBBIdDvXGoH0F9bsdmX21JqtyT7jF2lAd2mBjQwoeSSIoCtsulDBKKObmUAsFOLa4fsR0tJ97NRUippYRXMf1BEVp4bFa39rzbEJkrMtb9HsFEgFQ1naSxqEmCSm4hloR0xkPOLpAGIOgxlPwTSqMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444799; c=relaxed/simple;
	bh=hiTtLExAOPWGi0++zK1vcn8AggohYKDMaN4up9ll0ZI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qB+zsKqMOENV6FoS428Otr/N5Qq+PPdRNzU5X9v3ZUe07BWzswNn203S0iPjnbC0HTlPyd0Vlwio4FKewEn0qk+8p6QzdxmygifJEwi4ETu+6Q+gU/5NSnAhP5kY3ks/U7o8NNkg4vuRjlC9bJEjapqCNNyw75CJyfVyIsLy8BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XnqPphD6; arc=fail smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XnqPphD6"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 166D243BE7
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 16:26:35 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	by spool.mail.gandi.net (Postfix) with ESMTPS id A3B21560A70
	for <xenomai@xenomai.org>; Mon, 26 Jan 2026 17:26:34 +0100 (CET)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=XnqPphD6;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:c20f::7 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBWowlDRx+flGzVJChFgt870GXPM1pdtUtd86xLsuBt8SlFpNmauBSLKGDXliTbc9sdLQ9kxzoplpceRzg+oTeS56N+R5Y5AdFhw0wGxn3R6n0T2y/jZ1TBoj8lRvt9C9MdaknbjTIt0nMa0qVXH1u2x3xaCrQ12U4oSkc6urZMcAR3PIGI/sdLhgGiZr41MYEmopnMobRCCZagnReYPpq/GId58X9jolcnu2ZYQAGRTNwfY3ibNoHr1/A/zkf8Syc52PZdET1zPbplzHt28uoZ8RKtuwZqgDCBPKJ4wlhgwygQKa8PvRSYw9hfXZGLbc2JCjPjisoyrrx7x4rlKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ild1/A5t4SSoEcFOT32cDM7Of2y3kLs37Y0+nKgApIk=;
 b=TO15sWwrx/prlIusi8a6550yFSDmuncnWCsL7LImqq0BQBBBYu1K+RBlAzoDdTZiQGUFROHpFF/BDAkfzZykmGUek4TP07IGxxJWcDM5W5MEs9yfsZ8fzHLNMy7LeHQx5seBUsufaBXLtdxp8zPE6kpf28ID93Vg+sFZosPHp3z8kiLXv4jr0UuNfOIC4/C5knJOpKD3VVBz/Zdnfu9JphZb5KTpycPLh2lr6hBJs2NftB6pLtwKHYMGj1amxMu0r1Sal9/ZgDz8EveJzFZYRJfB3SbEof8xZtZTiDmKIasDqt+VyUWtztupYqbWluLHYg8YKQ8OPNCakG2QiYcp9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ild1/A5t4SSoEcFOT32cDM7Of2y3kLs37Y0+nKgApIk=;
 b=XnqPphD6g2808TXard9zXB1WSPEK1rBGYDa55HP/wqWFlB9NI18z6D1WteX53rv+ua6wCGIFhGP9PRQ7CBUsqEK5ud5AmT3AB22+uGDcQZVpHhEeDs6eEmwZr3gZfzOZcRj/H/X4i4FXizHEdqEP7geRZuwnyzRhbKF9gJwtf/Af8vnqScB/ih48vJDLEWLw6uCglfmyhDpCG3qq0rSKuiJR/WzLU+sGcPnLeCAKtechUIxDNwZ4oQHgEfIsYCw7N65zEovNy6QFC0gXiYz8tFZ8WsC7Lca9JgxFZMQ4nvgjNFcjl3PiLjrY0hhyfNO2gzK5+qyv42Cyic2w6BYCIA==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 16:26:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 16:26:33 +0000
Message-ID: <32b32829-18eb-47a2-8c7b-77e6f6733070@siemens.com>
Date: Mon, 26 Jan 2026 17:26:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Allow changing CPU affinity of RT kernel tasks
To: Richard Weinberger <richard@sigma-star.at>,
 Richard Weinberger <richard@nod.at>, xenomai@xenomai.org,
 upstream+xenomai@sigma-star.at
References: <20260126125701.21000-1-richard@nod.at>
 <29de15c3-4d96-4194-9cbf-c362e9e83698@siemens.com>
 <3016173.h6DGQjDypG@nailgun>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <3016173.h6DGQjDypG@nailgun>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0051.eurprd04.prod.outlook.com
 (2603:10a6:802:2::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b5cf31-d3b0-4234-664b-08de5cf7aaee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHc0TnpPWjQrVkg1bmxpUVkzdHFId1AzOHJnQTRxYVorYStPclZudXhISnhC?=
 =?utf-8?B?dXBUUWNhTUZWWkFuS1I3VExXTzJtcUswWGdTQkwwQmNQN2oxMUNkalNEOE5n?=
 =?utf-8?B?Ym11Qyt2MzBGWkc5L3Fva2x4eTVYNVVBbC9oQnBJcVJmQndTRVMyUURTQkE3?=
 =?utf-8?B?WmxkWmNRcVZmb3ExNGhDOXdWUFpOQzk0MTRZU3RWdGozRXQxaHlJWTVtT3pC?=
 =?utf-8?B?YWhJT2FLZU0wUGpVdkE0dmZsYkFUUlVXcXZVR2g3ZFVmUVBMQ3FLTlh3QkpK?=
 =?utf-8?B?M3F3bU84aUFuOUZGbWc5M2ZFbnRuQlF6d1dEK0o4dTNNWHJNcDl3Ym9WU21q?=
 =?utf-8?B?alYydFIrREFFMXJwNkt1VVB2eGpjYllBT0JhaVlSenJpSnFXMVVJUnJxVk5y?=
 =?utf-8?B?NXFxNi9JSXJ6Y3JueGRlOFNmS2I4bG9VQTlmdXU3NEU0MmNVb0laZHh2YVNl?=
 =?utf-8?B?YWpiQmZ5bE1hRHZYaW9IbW9ZU0ZoVnVaK0RtZnVMUzRyazFldG9xUkc5dXhU?=
 =?utf-8?B?WnlmamFCOXFyck1OSVJ5SkZZdVliTGJpZmJZUDBPejRaRlJ6T1lNbE1UTHpO?=
 =?utf-8?B?TS9wdFZYSDRUQ1MyVTIwN1ZENURYNXVCTm9SYjZmUXltSnJyV2lmQy9IM0V2?=
 =?utf-8?B?QzZjNnJyWnBFTnA2b010aWZQN3pKWVRCSmc3WHV3S3hMTTNlKy94WldId1M3?=
 =?utf-8?B?OXA3T0FOOEhSMi9oUGFmLy9BNU1kZVgxVVRFSVhTRW5aZ1BydE5OaXd4S3Vk?=
 =?utf-8?B?cEpWQ3dBT1J1SlFobXRRREZxamZtWDR4eittRjgvUFZvQVA3MFZHMDIvVkFo?=
 =?utf-8?B?ellaVDlPajUxQUJPVEZQZkZPMjB3bHFOaHlUMVVrbjB2U0U4YTdJdTlCZlUv?=
 =?utf-8?B?QlpSZG5qVlNTM0dEbThZOFhjem9pVForRjhJREpzdnNYOGRoSVdyYVhYcHBM?=
 =?utf-8?B?Y1lFT3NtUjErK3dwemJOdHhMUUtTVzBncVJMa3RiR25nOGhpRldtc2tBMHc0?=
 =?utf-8?B?NEhNNGp5V1RSS3g2cllZenUrMkNKa21FTExMbHFwbjBoM28vMlJpL2FKYklt?=
 =?utf-8?B?aC9FbmxYMGM0cFdOajZJQy9rV0tZbzQ3TG95RDU2MXRDbFNtRTA5SFNRWEVL?=
 =?utf-8?B?N3o4VTBtLzF0ZlRIYkpzRzFiRGIyRVVkUEJIblNWU0JWQjdSN09RelQrSXRi?=
 =?utf-8?B?dDI2YWYwcDVRREw1T01EcEpwTGNPa1RNWlJJUnBoUEF6cFQzeEF5SGVwRVA3?=
 =?utf-8?B?ejE2WHdieUdwYU9PSmpMQjZEaUpKbWE3YzluVWo0OXd5Yldsc3BtTEZPZUY2?=
 =?utf-8?B?U1BpM1psSHpSSGZiNEJsRHk1dXZwdy8vUldoOG1ucjZzdVdtYlpubFMxQmQ5?=
 =?utf-8?B?S0MwYTJ3M3cyOGVRY0pzME9vZjBzRURFV3E1UVFGSXliUTJ3c1VFQlZUelZ6?=
 =?utf-8?B?cGM3TWJUaDBSZUNNaVVEZlV2SWNjK3VUYWswWnV4RU14blpjbFlscFVHS1Zt?=
 =?utf-8?B?bUZlcHdIWnBJVXlIU25XNmlKMC9TelBGcVFoWHBWMTNDWlJLSUMyN1hQNWRX?=
 =?utf-8?B?Y3prL1ovRVZ2aXdEemxXTU83U3RZUmVFUU5XNWlHTXJBbkpBSnVoakNOUHgw?=
 =?utf-8?B?d3pCNkM2VUZKVWFZbGpISFloMUpBVlgybjI4V1hWdVgvamZTQmJ5RjMzcUZJ?=
 =?utf-8?B?ZjFvZHhiRWlXbFYrTFlnaS9udkZvdXBidzJsMWpsSXJ4YVdya090RG50NGky?=
 =?utf-8?B?MlNseTFnNFNOa2JlcTRPcVlncm9pQWJEU0Z3M2pJR3ZoYlFRRlpndXZqUy9h?=
 =?utf-8?B?MEpzMkVDVnlYUk5nQXNqYUVnM1FvTER3K1FvQnd4d0ZWY3NaT0NpNDBtZVh1?=
 =?utf-8?B?T2NUS3FHRVRIMWRDTUNQQzJid1lITGhuY1FRZFowaFZjeHF6U0pCb3lJcjNX?=
 =?utf-8?B?a0F1Q2U4S3pSYVBERC9oSHl5dXFkMHVxTVBjdUZoajAwMjFGYTE5NmtIcGVE?=
 =?utf-8?B?enRHaC9LM082bG1aVGwxZXJBQWZNL2oxUkxSUTNDdGVtNkJ4TXZVR3JKeDRQ?=
 =?utf-8?B?ZTRVLzJUNjVtVWFPNlBxUmszSERNY0pqVnNVNGhsekJ5WFlnaWxsQ1c3Rmdm?=
 =?utf-8?Q?j6Wo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFBhcTRlc0xORmpVL3VscU1uWW1nc2g0R1lWVnloak8xWGM5VnMxdU9kZnpW?=
 =?utf-8?B?akUwd2lxYlpFWGlNSVRnYmx5Unp3NEwxQkhBNElxL0FQV0crVnMwWXFJbmFN?=
 =?utf-8?B?M1kyakcyd25BOEpXcDFqVCthZTMyUWNRQ1hUQ3dJY1JnYVNFcUhWZEtZaTd4?=
 =?utf-8?B?SHBvc2t3NkUvS2NhUFR1elQxaXJVa3YzZkQ0b1UwNXZUb3VONExiQWMra3Rh?=
 =?utf-8?B?YTNySzBkODA0VDFRd2V6NHR5YTNPQ0tyNHJFS1ZNMXVnYXlRRE16SDlUY0RL?=
 =?utf-8?B?YkE4SkRlQTQ0SU8ydFd3L3JDQ0pqSmZ0WjRDZnNtaVAyWGlocDlXU2ZTOWtG?=
 =?utf-8?B?N0dPVW9XSnQ2OWYzNGRHWjBwQXA1TFpXRzZQeERvYitzT0tic1ZoZ3Npbm1Y?=
 =?utf-8?B?Wk9DOWwzZTZaMzU4cGlxWDNDWm5aREhvaFExQnpVcTIzVXJhT0pOT2Z1VnNX?=
 =?utf-8?B?N1ZJcmVUdk16ZHZVc3I3cWNhSXc5OU1IZHllQWFGY3VmVzVaaVI3Rk9SandL?=
 =?utf-8?B?OHM4aTZLeXFyeEJpZjN6bUd4MzlGRHVMeklVRUx4bUlSY2hHaVFKYUhqSzhZ?=
 =?utf-8?B?STFlNk9kRFZVc1RPQ0RDdjZvZGhnT1dzT2dDWmsyTFJGUzM2eHBvRE43NmtZ?=
 =?utf-8?B?UHRIYVpDZytCVE9XWWh5cThFeDFVeHJtR2FXb2dmMTFaa250Z1AwL3BFMHhQ?=
 =?utf-8?B?M29qbWhMQWwxYlFnN2FXYTJPY1U3cVNWdVk0WjlubW5oOXFpTFBvZCtCWVBa?=
 =?utf-8?B?T0NNbk12cUpaa0V4VXBCWXIxM2lpNnZSeXBXZnc1YWhIdWYyQzRLeXgzZVRZ?=
 =?utf-8?B?ZXJZL3FPSnhUL1U1dTBuejZRd2g1NC93Snd0L1hvWlpEa2VoTE02RHdYU0Fk?=
 =?utf-8?B?b2JFdW8xWHoxWmEvUzBPZFd5WnkzMnlYdllSdWtEQXVPdHJQc1NVc0RKRk02?=
 =?utf-8?B?Y3JTRzVnbGVjOTgzOU1WaU5vREpQeHlOWHpGcDIyUFJTd3BPcnFjbHZPRVo5?=
 =?utf-8?B?M1I5T255OW9JdnBFTCtxYlVxcURjMDIybllIT3J4N21TM2F2MHZEVFlTR3ND?=
 =?utf-8?B?VFV6SER3SEE5cUNDNGJmbElTMXU4a2RGc1A3Rnh5Mk1YTjJtZngwU1M2dlNr?=
 =?utf-8?B?OXdiLzF2M0kwaWwzVTQvOVZSd3J3MzJVYXJBSWExOUxWTGw2Zld0ZEFtOUpW?=
 =?utf-8?B?YmszNk1mOW1BQTRQZjd5eVdnNWM5SkpjOU8vQzZjWkYrdVlDLzIrbk16WUVz?=
 =?utf-8?B?WFRCcjVmWmQ3SkRIWlNIQUdZVWp3b29QYVJUY3lCVnNuUEpYNzdJSzNMN0NX?=
 =?utf-8?B?cUV6UmV0eGtPT3FzYnVzNFMraUxaQTlVNG96SU9icDBmbUxyTWYzaWpqSWxZ?=
 =?utf-8?B?dlpCSC9LOGx3OG9yNXB2MzJsQWlZWERQS1ZhL2Y3R0RKTCthOXo4bFVHTkpz?=
 =?utf-8?B?eUQ3Yk5FZkg0NmlsaFpHSTR5TGJqajdUMzhPbVhVZHE4TDB0eklkb2FLeUYr?=
 =?utf-8?B?ZWlRUHluOVQ1WDRjTHQ3UU1zN0dHSGdRbzZ5RklNZHNLWHFlSnNOS3hKajEy?=
 =?utf-8?B?czBWVGhzZ1VZMFZ6djM5aXR3eWFIaW0wcHptYVRRQWMwVUVYbU1kMFVKVnE1?=
 =?utf-8?B?TGtiWWIvOEhnL2ZaREpqQmxKdUxydDlkVXdyMEp0RzRvUy9yOS9YSlFDTU5u?=
 =?utf-8?B?cFIzaTl0dXBqVkdWeHlubWJ1aDVVSW5ONjA3S3JqRGE2QUowRUkwRWk3cCtM?=
 =?utf-8?B?alVyeFZKWWxROEw1dTNnR2NibVJOSWUzNWR5dFhxcEkvZ3RUN25qeERjT0Z4?=
 =?utf-8?B?WDRQV1BiMk9oSFVpdXpuY05NZi8rbFNCQk9kYUYxdDJKNG84OGo1TkVoclp1?=
 =?utf-8?B?VVNoWC9ucjZBSU1tUjh4V05nTVV2N0cwSGVpdHBSQjdNYmdQT1h6andUQXlN?=
 =?utf-8?B?STJhdHNpakhoQmpwZE81WmxuVUZ3TjZzNGIzM3hOTjBjYk5uQU9mKytuRlhZ?=
 =?utf-8?B?NVZXcHlzZEZSQkdNZXNLVnJSS0dOMCt6YUozVkEyNlcrUkdNWHlJc2diTzRB?=
 =?utf-8?B?SVpPUnBDM2xCcmc1Z29UYnpRb0ZmNjg2TFcxTzFYQkJTNG05WE9lV01DSDJN?=
 =?utf-8?B?QzhZd1lTT2R4ZnJWdTNURDV5SmZ3UWc3cjZsbTdsUkxaaVVNUXIzMDlYUWlO?=
 =?utf-8?B?ZVFWV1JxdlVFdU93bGExRzlsVDRxckZuY1c5Znh5aHFha1RaaU44ekJMeXpX?=
 =?utf-8?B?L0NVS0xHcXlpcktsbVZLQkQxeXFONENlanYxNUhlRnZ1NC80Yk40RlVhY1Vy?=
 =?utf-8?B?S0VsLzQ5L2oxWElzQXZ0MHVISk1KV28vR1ljZk4vM0ZWdFQrcTdBVDdtOXc5?=
 =?utf-8?Q?vQxcYOHXAYNo1y2E=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b5cf31-d3b0-4234-664b-08de5cf7aaee
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 16:26:32.9494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0skPMTmu+SfMOIjDlrBqf4w4d5U1Lh04l0zaFVk0LOVP55nWueU1QE4Hi7emfZWAQU1f8s9COsY+uJnBsAhw0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7082
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffgfuffvfhfhjggtgfggsehtkeertddtvdejnecuhfhrohhmpeflrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnheptdekudfhvdelhfefvedvtdetheegfefhgfejjeehhfdugeegfeekgeejvdeiledtnecukfhppedvudejrdejtddrudejkedrvddufedpvdeitdefmedutdgrieemvddtsgemheekkeemmeduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvddufedphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdpqhhiugepudeiieffvdegfeeugfejpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv
X-GND-State: clean

On 26.01.26 16:11, Richard Weinberger wrote:
> On Montag, 26. Jänner 2026 15:28 'Jan Kiszka' via upstream wrote:
>> This is one issue with setting the affinity "from outside",
>> asynchronously. The other is that it will always imply a migration of
>> the kernel task, thus a phase of non-RT. If someone forgets about this
>> and sets the affinity at the wrong time, it can ruin RT workloads.
> 
> I assumed this is known and expected since changing the CPU affinity of userspace
> tasks as the same implications.
> 

Likely true. EINTR can be a topic with some calls there as well, and
some applications may just bail out (or because of trapping SIGDEBUG).

>> This tuning gap for RTDM task is rather old. I was already considering
>> to add an explicit affinity API to RTDM to set this from the driver.
>> That would allow to set the affinity early, right after task creation
>> and before the driver signals it is ready. Risk of such an interface is
>> that people start to hard-code the affinity into the drivers, rather
>> than making it configurable to userspace.
> 
> Well, the goal of my patch is improving the situation to match userspace
> semantics.
> People expect that sched_setaffinity() kinda works.

At least "taskset" (script-based tuning) - we do not have an API for
userspace to retrieve the PID of a RTDM task. Yeah, there is some truth
in this.

So we have the following issues still to consider when adding this
capability:

 - Driver supporting external tuning need to handle EINTR from
   relevant blocking calls - others will fail, and that is fine.

 - Affinity tuning by userspace should be done while the kernel thread
   is (still) "idle" - identifying this remains driver-specific. Maybe
   document this in rtdm_task_init?

 - Should we also provide a RTDM API that maps an RTDM task on
   set_cpus_allowed* or at least officially provide the task_struct for
   some rtdm_task_t? rtdm_task_t is opaque, xnthread_host_task is
   internal from RTDM-perspective.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
