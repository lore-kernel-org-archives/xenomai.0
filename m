Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9400E36BCDE
	for <xenomai@lists.linux.dev>; Mon,  1 Jun 2026 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315000; cv=fail; b=OA8QwgMcBiaAXosYNXWpOtKL9qqvibTVBvvj1EFXchp+tq5HTEOGlcmsSMms2J92BH2vwjocDThz/Csw/fTefhVysuFWflFH72YLH+Vig3chqOP8RueqTzjuyw+Pn+wPhmniYFzL+02saEFlvr+hmUX0goVd/j/3L1Y0pEzv+5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315000; c=relaxed/simple;
	bh=LJdowkmFB6lu8cCyynUjQSsCQawPlKDqnKPS4K9HOuk=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mA0vJqWzsxGI5PDZDnHb6peVgXNDl4Ur5Cu9ibmgGQZF/trRr6QaRh7tgPYNcLimKfM83Y/5juVvFHioQCXoKPuYolpN/9Kbud96EfR8tsHq3LvKqflK9I7MZEKE0yCfRxtPjNdxlf7E/cxnJv0AQ8WUjrQ3YptBHEYevUXC7rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Q4S5Jb8I; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Q4S5Jb8I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRpxprko1yu3OOB6yZR53odo+VxbvlcezcDEDfFZyvq4urusGXDJodKRNqvVXNMkd1q+9dOPoL7VtEOxG0zl2KnDnQlpyPSrOVKHl7gjkGhVQLT8WrMpoDwA7x3LvoURIAyjW9VqSBKhwQ4FrkhKYVB40JidozPdEST9a+scwYtY5+zKZrrGYHL3AxOxuoD5EACqZbaBMwPGN4OAVhGotifLhzS8QukLP8yurOmC2cl9PG48fNNYgWN5PHYNb55Y7LKFXZKFNiQ4msZ+04U7BCOVfiExwJiGqlLXiJnSY9cLc83pirrThXk+ejtau6amo40Fiy52QDzdTmY5rDM3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dszkbONOBnsmcFmsQevkcKu7yl4CPvV/wEaDCg2Rg5g=;
 b=HhfXG5qXi0KEm6gdB8nVQ8tLFB4GfjypkULwi+Difr592nCES3rC0aMw8CPgJV/GQaOkIQHlTdfyS+RkT93YKlyWfV1OOfhyPvTfYBe0XApgFlwmOr1+W2oT0mxL6MGGBYQDAzlVe9ttnfQi/+aszKAWhHZpadwF++TzOmLr3D2RKg3Z0WODsyJGW+gsOiL/Z0CnOT9P9VT22+O2sttLQKH8MvTx3lXh3/eQv4PomvMdLY0HzVQZQGT8wOD4HdBUhb/FYg88hzc5kFZYiFK8GwY1aFkpqbJD+5JNmNYku17f4/XfvVquFRiDyiLYAFg2akGBnj7cemAueCXPlUN7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dszkbONOBnsmcFmsQevkcKu7yl4CPvV/wEaDCg2Rg5g=;
 b=Q4S5Jb8IMR3zRl3qv90PIVKW3+BCY63XGe7QvvkrjwSNr9igce+JYpI+beGxPAf823bzZ2+o8kwMzz6kGP/JgARdNGW87IMKiO2b/w0ofFmHM8aZFdBTwYE/Jn1rbUvtsvbx3Lu8vIsmF2GqzsKvnii7kastv9m7ycIPQ199zLeD5f9ztLHHts6e32egZvxY/QYw8N968+9hfG5kncL9FA5PqOFWPs8S3ZDUsnixs6mpknVMQgC9cXdYhZ4Dvrtx5PG+EE84yKFuBHBKtLCEfQqBvsk7/BpjsCNeuI0wzzhjz5lyNEJ5WK6xdmajsl9/77su17ucw7eVaQkWCwkP6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by FRZPR10MB9889.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 11:56:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 11:56:36 +0000
Message-ID: <1287a388-b132-439c-bde7-b281c3a947d5@siemens.com>
Date: Mon, 1 Jun 2026 13:56:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] kas/ci: Fix bitbake variable referencing
 themselves
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev,
 "Schaffner, Tobias (T CED SES-DE)" <tobias.schaffner@siemens.com>
References: <20260601103549.785345-1-florian.bezdeka@siemens.com>
 <572b4724-25a2-4966-a55d-6a7aa3195c86@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <572b4724-25a2-4966-a55d-6a7aa3195c86@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|FRZPR10MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c4d05f-3272-4ace-9334-08debfd4d4db
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|18002099003|22082099003|56012099006|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	j1IyvZTHJSHu4QfNBM1sFkwq0Xd8UBCburVmOQOp2RW8H7hI61KAtdV6pr1xvUSpufGs3qC390H81vBWDQmdBo8o4K8HZ5z7+E9Ku5hVbGTEJe6aZDepD9TZy861YNEFIX0vk/XI/cQqNJhMT2XzyLklvYFo4GenSA1sGxTXwq7pFSSftAO39Xz9U/n/r+9oe98SK7SuOnIzCFQjTsrT3TyQhkUvDSxAobPSVjTuLWhMS4sN7VIQkLBtI/0BNcKVMSWRa6mt2eosQuaPd5xwWove8HTcFFA0wo7CHmQzLhefAzPxYTpvc7CmqdvayeWwpxgazinARhU84jcczJoheBgDnMnwOiPERUtRtNzqse+AUXwWTWaTBZ2buEMDLFGkt/kb/qfJwfQtyM7uiCKn0mde0KUzxj5pMXmaTdrR9LvPCsvJJTrGuTDBbBVPzyV+cYTffwPqnTdvHQFsZaxMsjDOOOR/1VfQ6STALFqTHJAy26ei8Z1IFCbsEb7d9H637LsAsAQvkF0Z2iM/OH9szmUP+AMzDfKGWaLq5aU3wd40Xl26JdmX97Gj7uGe6XKC9ZySgErBwzHCpsR7sPSuTyFc43LtCurFbdeQJI2zm5SF31tmbvW4kc9CEyNWY1wt2YgLdpRqb+VpQb77RXTpJdwwMIZziNNaIVlUUx0CBkHySdsjVhgUHvRxmbtpHXv3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajQ1UDF5UXhQY3M1MWwyVUNwWE5BUXVBK3VBMGErMlJ6bFFrZTJFN0dZem5h?=
 =?utf-8?B?cDI3RCtsSUJINXZieHN5K3pvL3hRTy9TaWlmT0dPeit3KzJPb0VoYTZIM0s0?=
 =?utf-8?B?RzZlTnlUZndoRW1oTDFvZWhDZEZLUEZKaWI2dmRaWTFCZklMY3diRnRCbDJW?=
 =?utf-8?B?VjBja2lSZTMwTWNhSDdsSFdTQTl0UDEzdHlnZUQxd0FIK2VPQ0FrMEpDVjZv?=
 =?utf-8?B?TzR3MHdhWGtkRTg4YWRLTVB4YVVvODZKOXp2RmJCb3A3SGhJY3Y3RUlNei9E?=
 =?utf-8?B?Y214TkYzeEMvaklJLzBXUm5uSzJjNlZheWU3MVJ5dnYxSU9GcDVrZElNcG04?=
 =?utf-8?B?YjJvbmR0cTVvVUxudkFwZkRzS2Z1ZE9JcUxENTNIdXRyMUNETVZrOHlnZUJF?=
 =?utf-8?B?UzFkeWNCY2Vqc3l1Nm81WWc1L2pNUDFmTkZiS3d6ckdndGprRGZXK0hEZ2tC?=
 =?utf-8?B?Y1J2U0xvQVFCa1lRNG9JTGxqRThZUHIxQUZIeTJxTEFLdUtZTTJ3cHFtbFJm?=
 =?utf-8?B?NU81UEZzbjRBM0ZPQ0Y1T0xMa0JWakhBbW9BMGlEZFZLZytGMEZwTWJycS9O?=
 =?utf-8?B?U0NwYlFKMHBqQ0NTdEppbXZ6NWpxdTMzMTZ5NGcvbGlEaFJyaWUwc0JWVXNU?=
 =?utf-8?B?OHFvTUE2MGtua2pFaG5odFFsMThESGhWbHpCUEJxZ1dJMHlqQWhGMGFKL2FU?=
 =?utf-8?B?WVZ1UlErdndJS2ppQWMrSnM3VU9sUjBDQzVnSWpJcFZuOVlIME11QUZiVlJD?=
 =?utf-8?B?b0lZNGp3MlhCUFFPMkFaeUhYUEl1TjdqdS93UFVhQVlBK0VwUmFxTXpRZEJK?=
 =?utf-8?B?d2tJRGR2TjdNWFIzb1N5cmlneG9ndmNWcmZhMXFjKzI4bWhXUVlrcUhhY1Zv?=
 =?utf-8?B?VFFtRlVSSEZLSEVIRUNnL1V4UVY5dFY0ZjZUWnRLK1JwTWMrdm9rdkZoMEls?=
 =?utf-8?B?WXZoZHlBUkluaXFYUGRlWTRUb1poVjFXblYrSjJhSWNRdEFCUVUyd0xLeFNK?=
 =?utf-8?B?T25JK0JJMkI3cmozeGdwcksvWm5KZ3NyOGdsUm1HN3JUaURSTTY2dUhBaTh1?=
 =?utf-8?B?ZkhRYTRib04zUUJOQUcvQUNVcXFRTUtuZWtZVzJkelI5cFo4dk43a1FRSTRL?=
 =?utf-8?B?WWlaQUc0YjdoM241YS95c0VZOU1tdjJRSDA5OWYyUmhpUGJack9vT0ZZWW1O?=
 =?utf-8?B?TWFaeGhnc2k4alZXSkIyQy9ZbmdoeDJ2S2R5SzFNMHEyR2xObHE1TjdmNmF0?=
 =?utf-8?B?ZDZ6WDd4cWJ6K0tOQVdORDUwR3hMYmNER0Eva2R0V2cyeXEvU3NQcEJqNHE1?=
 =?utf-8?B?LzRnUFVsRzliUHBrUmUrMlBuaVpUcnhVTHZIU1B3b3dsVlJGUzRVK1RQd1F6?=
 =?utf-8?B?dDc2bnBFVlVSTzVTVy9sTGpWb1N3NDUwekZtUlU2OTJHUUl4RXVnRGNPaEcz?=
 =?utf-8?B?SWE3NDQwQXhXaWRzSlZNUTB1S1dXbVNJNmk0TTc1NTRpVnI5SFFhYlpQTG82?=
 =?utf-8?B?N1J4NmhyVGQ2NmNFcWptek1XZExIT3ZUZmpjeEVqc0NwbVgvOTF5ajJQL1hj?=
 =?utf-8?B?ZFdReENwWjhuNXpLZWlEY2Y1bkI0RkFxRUJkNEgwN1F5TWhBWmF2c1FNUkc1?=
 =?utf-8?B?bjJvTEs3R3N6TWV1bEtUdmt2TnZEWWZpUTRCdTBNcHpwS0dKZi9wK095RTBQ?=
 =?utf-8?B?VVFtQ3krdDdHazMwT3ZFNmlrL0RLSWNtMWoyRkJqcVJiL1h0S1JMQ05yVXpM?=
 =?utf-8?B?NXpkTHVWV203RlRTcXcrbXBQY0I4TXFSUTh4c0Jhb3BiQ1Mya09QQVVHQldS?=
 =?utf-8?B?VFNYUTZUcG5FZlYzUHorQmxLdnBNUlRONDFXQkdkM3hqZG1GTC82UXNjSEh0?=
 =?utf-8?B?REVYS0xtWUJ3a2JHNGdPTjFtb3U0ZW9Xd1F5bG9xZ0l4U0NuRWpUMjh3SjRa?=
 =?utf-8?B?UWZqZ0wvSThCdzI4b1RDU2xVa3FsRUxvVmtHYUVJZldMazNaMnJXcWlvMWQw?=
 =?utf-8?B?cXFsdlBJc2pOanU0ZytaOWduMEZ4WDIwZWxRbkZCcFRWbUVmOGtnaEIwS2kr?=
 =?utf-8?B?RUZTZDAvVFRGWkVhUWlSOVdwZk9YN0xoRDJSTmRQUmNCRG1yYzNzVXhDQzc0?=
 =?utf-8?B?M0p5Wk82K1I2Mk5hR0JGaXVSRDA2MnhVcTNnV2hTdkNkbmFlbFRFL2FzTWRo?=
 =?utf-8?B?WmxJRVRFY2tUcTdidE8vMDFadW5iMkQ2QTVIRlNUeDZTZEU3Y09ncm9Qa1RL?=
 =?utf-8?B?SitoOXN5dVcyVGFERVQ1T3g5S2p1VTNrTHdva0JrSTA5SW42NmRXNEVlc2Yx?=
 =?utf-8?B?TVNPY0hHejBtcmRmejdlWXFiRXJYK1VkZXhPNFFjRFZXOUtSOTU4dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c4d05f-3272-4ace-9334-08debfd4d4db
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:56:35.9912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdKvKFLqsiG8g2eF15BZ5vqWkh7s1ro8gW4eyMdH5MwSLAeQQovHG3LI+0MEnQV6DsC1q3EG71eRkpDlgRtzAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR10MB9889

On 01.06.26 13:53, Jan Kiszka wrote:
> On 01.06.26 12:35, Florian Bezdeka wrote:
>> When trying to run a local kas build using the kas/opt/ci.yaml option
>> file the following bitbake error occurred as the following two bitbake
>> variables were referencing themselves:
>>
>> Variables:
>>   - AWS_ACCESS_KEY_ID
>>   - AWS_SECRET_ACCESS_KEY
>>
>> Error:
>> bb.data_smart.ExpansionError: Failure expanding variable
>> AWS_ACCESS_KEY_ID, expression was ${AWS_ACCESS_KEY_ID} which triggered
>> exception
>> Exception: variable AWS_ACCESS_KEY_ID references itself!
>> The variable dependency chain for the failure is: AWS_ACCESS_KEY_ID
>>
>> The problem only exists for local builds as the gitlab project
>> configuration defines such variables.
>>
>> We can avoid the bitbake error by stopping forwaring the variables to
>> bitbake. We don't need those variables inside the build environment.
>> The only user is located in the deploy_to_aws.sh script, which is
>> executed on gitlab CI level.
>>
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>>  kas/opt/ci.yaml | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/kas/opt/ci.yaml b/kas/opt/ci.yaml
>> index e1466a0..01d5c07 100644
>> --- a/kas/opt/ci.yaml
>> +++ b/kas/opt/ci.yaml
>> @@ -23,7 +23,3 @@ local_conf_header:
>>      IMAGE_INSTALL:remove = "sshd-regen-keys"
>>      IMAGE_INSTALL:remove = "expand-on-first-boot"
>>      IMAGE_FSTYPES = "${@ 'ext4.gz' if d.getVar('MACHINE', True).startswith('qemu') else 'tar.gz' }"
>> -
>> -env:
>> -  AWS_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID}
>> -  AWS_SECRET_ACCESS_KEY: ${AWS_SECRET_ACCESS_KEY}
> 
> Check the introducing commit 0e027423275a why those two are probably
> needed for bitbake as well.
> 

That said, maybe setting those to empty is already enough because kas
will then pick up their value from the calling env - if set. In any
case, please validate any new proposal accordingly.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
