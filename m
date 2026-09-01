Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B7E389106
	for <xenomai@lists.linux.dev>; Tue,  1 Sep 2026 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282222; cv=fail; b=LzCtl/ILzuRVVROkptNmYqtlhXhAeetDZ5ziyO20Bouf4nsG7AjkCRSrcEef5Xn4aWLxCVPwSDPYHmmVjl0pxqMPyWw+s0qqv06g/K82ZKTJnoe2Val816Gryakh1RN1ZWJ0GKl2AQdjV1beMWcRpzN3IpoIhPI+/LBfldNiIWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282222; c=relaxed/simple;
	bh=wEnS9NvccLzKTltuHnObbn8mrBiPsJdQv8FDhGXk1OA=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=BRDDTNV3HbVtDxIieRhhFO5dlrjPikDFKKMeQ0ntRWHaEfi/KpqLBYOfHCkZazGr6CntwAIDKrB5+vnrV+N+5ZokavND6mqAstc02Itc48ix8RF9yPqf2IlK8Cfb7XVIxAoHBRqG2JD+Cwl0FOWPv7x2iSw4dKXi06lcEGLtvPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=crCczyEp; arc=fail smtp.client-ip=52.101.70.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="crCczyEp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsctWaI7DovixCgkxD7nYfZVIU4zlSyQbr7CTPjy4v+drhO0reb4e/jsYzO8jmwV1abdLhJ5OBRaFLH4Y/68wNpOE+Sn3EjfFeg99v30gKFf/0M48EcrAs1eUCWkjd+Cg66nQ9ISzHwAbDGj+RUENUpFptoKN+OIqIyf2LstzIf7gARsINPZgiHyLJDYX+G3b29bQo/FiWAINJvuEjgzLomuf6sEDc0C40st6XwgNaIxLrgkbO82TosRs4x38T/2Y1M4N9tnAcqtoC00nc2M61lUA4KAfi2emUEhZB0aV2dHfhzo+ry0uobJ7cDeN1lsF3y0D/HHKL098l74X1uCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEnS9NvccLzKTltuHnObbn8mrBiPsJdQv8FDhGXk1OA=;
 b=eAGj0LGhHB13C5vIra2JG8DtfM4tAGMSAr08qwv27iDOCuQyhPyRwedH0Ld6jGjmBfkcqN92omQZwuCZrG4mOHN5V+aDPxeyPSyC4T5F1DRSOg90I2pZ5B52VZJKMG1j0r0sXKA9UBxsNOuJknFjif6Bpxf08lrvPJGaWfXa0jSfKRCgd4Hx+KnTRPwGd3Oz2WG83aU5JK+o6+wVdQbO0qXljW8is/4XkzkD6RgECtFnqPP5WjqRPFOL/ds2OjQJE8kkxWwXLm75F8cW0vDzqD3Z0JCCO/wjXFZirvMjGRYj2Kv5HM/DLBaxrp+V5UNw1pAARKqsJiRgjyzZHriXqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEnS9NvccLzKTltuHnObbn8mrBiPsJdQv8FDhGXk1OA=;
 b=crCczyEpBnKYxlUcslgvlNUlVeTjAJZTLQWFskOJeYAdKD2s+v+Z5EGyhQ4wxGi/x3BjtKLdPUPwzmtjWRARw0oKJovf4+Mdr0fbYV6oMKD9zFdQCLShqOlq4CLgKdXV9eKORqayZ90Ex2fBm9Q8kAanThElK1UQm1PKAffbluhsWoyCPwFvdbV3ploP8i5+iJfWH7vqX91+gKS/sEQA2K3DAIQmwRepMnlOvlyB1HiuurMUx9elO8Uzh+QGV/HphbUkMJyvfi1LJ9vcYfjuyKxqd1Z9fpKOnSZ1K9Dc4f0QnzbStRpiRshUKMkRP92rOATFxRfznM48L6nQgMrYog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7550.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:59e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 17:03:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 17:03:38 +0000
Message-ID: <9daa8586-6434-418b-8866-e3b230ee49cd@siemens.com>
Date: Tue, 1 Sep 2026 19:03:35 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, September 2, 2026, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0003.namprd19.prod.outlook.com
 (2603:10b6:610:4d::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 63934b44-ba3f-4c57-c151-08df084af78a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|10067099003|4133799003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	XqvvA9Dh6X2/SIqzY4zh6mr/YvvDB8JiBwhD0+hD58Po81uAroekaAKrk+Fm5gVyqWa1sO6+cQ2Tf6gzfCnlwxGrYAw5i35Y7Nuw60svkGsmeDtxYdZqoR5cAUhiceY7z+dCFu+3VMu5cv8sR4g41JFULCgrJUe94G70HHuqhF0kImn2MEpXS//yRxyjsq37frZBI1J2fmrd7eR8aO2JtNrO6CD6Mm86ddEgdIarvhnp7nqoLfVE0FwyHDFZMGHRNOJymISkbeG1DRi9i5pFqVuzF0GzNhCcfNGqtuuUJzfBLSx3P4xE3kZ6R+/K17n25oQ/4BUbtwGAA5Euog2AvE4eNDv4NVl+ttXk4QBXOeHrx90VKLO9dgBoitbv/vqB4Ejn8IMSiydEO3XwUL9QbTZ8bXyI8VYesVYjJhZE1Rc0MToxC3dUubIiuh7Bg670iGXjwTOOjkA09pi7OjJyyt6uWEsd0zwzMqfaO3JzVnNGcyCH/PtDNUWB2Rjr50iaknD+k/PiLNHA7IjbJJnrZOHgKARgtH3Ox38I6ItMi+s/upvTOyOXF9mHuqLZpyFWefXQPjyrHxUfATF53RdG+FNxrmdX9lGeon7ofzLR0f75UUXbMrxOyIDzf2qOCQnSIv2JYtHBvA+J8zu+5DjmSijxLGgOnnOLwKY2QDAJCqU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(4133799003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3EwMkxPQkQzUWxTbFJEaW1vWDhXRjRwLzJRR1NaOTc1SzBkNkdpS1dxVVV0?=
 =?utf-8?B?SWMxbGtxRkJLMU5pU1UrdDM3MTRiWTNGbFMyYjFtUVRpaHRHbmV3Rk1udmd6?=
 =?utf-8?B?WEFwVytvUzBtQVh6bitHZTdsdmVXaS9RV25SZ1EySU9RLzhSOU5NbnNaNEFR?=
 =?utf-8?B?NEcrbGNDdTFhbXF0cnI0YUJTbUFmZDRxTGJBci81RHhkYitFdDVWWlhhRWVT?=
 =?utf-8?B?dnJFUUc1REN5VzBtS2EyUmNhdkdJeE5iYWw4NW53K0VydHdGdStWSG1kcVJ6?=
 =?utf-8?B?cjNpQkR3b0E3eEVHYjNOZ2RvdCtBK0d5eFBNT2hCM2dMVE54M05BWWJFcXI5?=
 =?utf-8?B?VDZ5bm1VQ0YwTTRRTHhoeUh0b2t4Y3Via2hhSUdyUTdxMnlkZHJDa0dnQ3B0?=
 =?utf-8?B?WWoxUVRZeS94V0g0UWdWLzlKRlRib3gwdTRNSDFkaDdjUDk3OEp2cGtCcytF?=
 =?utf-8?B?ZTlhWUhrUnIySW5YTGsxRnFGYXllTERxUVNkZU9adlRDcDJIYlh4dSs0SjJ3?=
 =?utf-8?B?QVdKV3p1U1NZYnZ3TE9qVzM1TVk0MWZqMWVBL20xeHBwTHdqUWU1dFY0YTZp?=
 =?utf-8?B?SkgramdaQWxMcmhNTlM3L3BaMGlHWmxlUWJ1cis1QlJZM2U4YjJIU0NwSlQv?=
 =?utf-8?B?dHJoR2dmV1F6YjE2Zkk2Qi9DWVB6ZTdDeDJLRTgxWVh3Y1U1TUlrMVNPSnJv?=
 =?utf-8?B?K3I2b2pRczA3Y3Z2TkZFVFlpZ0h2K0pNYlhFaGhVTVhvUGVYRnpqU3JHNk1O?=
 =?utf-8?B?NXBmSjJKUzNqdVh3eVg2Tk9KYXdPUWF1a1NGbEJJU3JPampIR2tuazlvVS94?=
 =?utf-8?B?NE5CMGpnZG1pNDhOeDlvR1R0TnRQYUhyZEszK0FLRGdqbHVsWEkwYitOTjRt?=
 =?utf-8?B?NlNQb1hFdURtaFZ1SjVDb3lYVzFVS1FzYzB6TWxFazc1dEZEc1hWMXFTMzE0?=
 =?utf-8?B?R3hIUis5QWJIVTlrMTVrcm5jMUFVZEt6cm1RZzZNQ0VSY2R2bmM3WUptS01w?=
 =?utf-8?B?V3hEd29jMFdKQ3lsc1RtM0NXTXY4S2NIQkhFNE5XS3RNeEQ4WWVGZDhtaVVJ?=
 =?utf-8?B?MDd2bVFNcW41eG5tdXVjdnM4R3NLNzFMS0Z1ZkMxcXlNK0ZETUN4UG9rU05M?=
 =?utf-8?B?Z1FnaE1EcXR5amt4LzRkTWpyMThmVGNlQXpXQm1Nc0lQekVHTUtRaFVMQ1hT?=
 =?utf-8?B?dldMQkxNOGYzNUIwdHlzOUhqMDJrOTA2SjBxNURlTlJmVEV4U05SQkhRQkNB?=
 =?utf-8?B?a2N1MXFrVEtmSThmZ1RHSWhvNmp0Wi83dDBzTkt2Znhlb1FQeCtOSitXS0RW?=
 =?utf-8?B?N0V6WjJ1NjFudGI4NVFnMG1JMUtvU3lUT3RMaEVCM2NqdkI4aklweVhETFJy?=
 =?utf-8?B?ZDUxbDU3L1hUR1JqNSsrRko1bVJXMDJMNmVJa1VQY2hmMUlZV2FLZ3NHc0ZB?=
 =?utf-8?B?ZFdKelVsd0UxdlVtYmRYZWtLdjJ4czUyMCsvSW9LUExNMWNOelZHbFA5alJM?=
 =?utf-8?B?UHdJUVdKOE5ob1UvcGRDRjlMNzF4enZ2OWJMUTl3UzB1Z0RaYnlFWUZNeStP?=
 =?utf-8?B?MnlzUXR1UEJXTlI2a2JML054YTVvYUsyeUVDQ0dLNlJuWm9FbTlIMDNsTkhX?=
 =?utf-8?B?QkpTbEt3QnRxdENnTHBXZXBkaUhQaURSOWtPRWZXcFZEREdRaWdwbVg3UTkr?=
 =?utf-8?B?b3hKS1IvMEJTVFJFMUt1QnBZSTJoZVdnNnFoNXQ2MnR0NCtQai90WGpaTllk?=
 =?utf-8?B?ZkVkM3dhNUo3dTlHUk9rekUxUDRwdU51aG5Md2hnSk02ZUs0dHN4K2owQ3RT?=
 =?utf-8?B?a0NUQ0VHS0VsSWhTSzBxWWNKWERXZGdmWGJSTExrUjY2RVk1S3k1WitCb1Qz?=
 =?utf-8?B?SnlzbmdBbXpKaGdueEUycVFMRE1FR3VGTXU5RlBpNzFoOXdUZTcwY2F5eUZP?=
 =?utf-8?B?cXR6UCs1Q3hoaXlNdjI2V1V1YWRPejRNTFovV0QvZE5waC92WVN2L1RBUnJC?=
 =?utf-8?B?YytjV293SDBNYmhqd1hBQ2oyMjFrUTgxcW52Mk1WM1EwMjNrSkEzZ1ZDcFYy?=
 =?utf-8?B?YjdQcXQya3k0RGNlVkxkUE9KNk5WNXZWMEtKdjFWYy9KS0JtbmxtUVdpRHVY?=
 =?utf-8?B?SHRuMDJ1RU5KVnlMSzRVOEIwV3VsaG5EM081S2s5QlhXUHRRaFJhZnpIZUMy?=
 =?utf-8?B?ZVM1V24xdEVLWWZybll6dm41R0V0UzJ1dlQ0b0hvK3IxMGozS3BhQWN3cFZH?=
 =?utf-8?B?SGh6ZE1qaWtabjBLN01zbGRXVndOaU1KeDNDcVJNQ0owejN5T3JzbFowcC9V?=
 =?utf-8?B?RWphUUMxdDZ6aCt3eFRiSGlTbHBjV1Q0aE1DSVFleVE1eGFHVGxJUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63934b44-ba3f-4c57-c151-08df084af78a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 17:03:38.5991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HToDCeRF0Z8Ws8EphtvmuFbccVidoGcWeP0uAbQL+Gu9DjJ6wpxSPQBeA8zkfwOxJT/zc7RlxbNziBY3jRfhhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7550

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, September 2, 2026, UTC 7:30 AM
Paris, France CEST 9:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan
