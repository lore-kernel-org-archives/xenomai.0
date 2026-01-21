Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011001.outbound.protection.outlook.com [52.101.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A48378D6D
	for <xenomai@lists.linux.dev>; Wed, 21 Jan 2026 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016343; cv=fail; b=rG2u0c0t3RDYhdgMYkqub7+GzGYLD3rFFSXf1CQYfcq+Jt9GHHPZRvqeZOrGjTk1GtTU+ksFJ1yPRvdp9hBdj5kDfnT9YL7EWgU7+usOpS7snpqjHLGucCksgwERKn2R70Li2fmZwjxV7w7Ef0TS6gqfmZrWL6vMQKQ7gyTaSRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016343; c=relaxed/simple;
	bh=+S9Y3S7HSNLkyLoehpYIspZ4jULNvaSKAfLcPk+H7XI=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=IhTkQksWDS/Iiswtxjx64LKsBnDC5D4X9+mu43ogppR7YZoHLlzSuegpWyBmr6HlGO3CaXduAXIIz3fntcxvv6BdqYTPMITtjUMOcOOYbMVDMdfIavjL/c1Uof2QFNohnUmdOeqvh2v8U7KmKOWnbYfTuoJz8YI+PzTBsrF0JUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UoK5M+FQ; arc=fail smtp.client-ip=52.101.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UoK5M+FQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svhrlsL1gA0UKlzUFNneUialnVqvO6I4SajUS0uK61XlKrQ8UQ7fyALvIdkDlAsBwACHeHYltkVE2DnqglB6/bean0xNAeS45+SYdoShJqDCMIs66UMEBXGcdRKY6WeJmVnNYMHfTuFXN9PUGWOPMrDVaiB1drnJKe2nJnJInrgkM9YW74Nx+vUfBVV76gY7B7QrnoQilULP8QxrR2dl0y0DrmAt5IFXLAjaNNO0Q/5R5nQ0VgNoxnYDNLUkhEqkRcdrwA4sj2LGlvkzDbnbtt9YJqFdp1bxqWDqoWtjJs+UhQBOn+KTEnpWebl06rG3jMY6mfubi9+B84xskWNG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/0EhtwVgYyglMdx8ThmOKhrwMseLOl/aLibA6PA52c=;
 b=vN7BcYwaotVoeWBIwQwK8wNKefF9OMyB9mMCGu+PUObekLXWmKaCuWpW/09G2vYqvq6SiBT/h68CDDQ7iYsEulMzXYwvfS9t+pudYQZzAgyHzu7OELkUB9kV1E6pNzVF4+h/DT0pUq6RC3bx0R7ZbNpJYke/Jfup9lF3w9CvwwC9eRd63JJ9OcZN92EyQMPF90VFIyZ7oOXG4jN52o3RqKLC/5i0QTdUZispQO2J1P9i3aZjRi0Awwj/ryinHaubFzq8PieL6HIIpGXrb6wfLSBCSYxbDvRTOFZJLR3urGaYZqzJ1WazgDJCPVZW0Wu1WqvNlyy4RCJ11VKVkYI3ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/0EhtwVgYyglMdx8ThmOKhrwMseLOl/aLibA6PA52c=;
 b=UoK5M+FQCH/mIRUJ40z43WpZCfoik8YahGQJs1Q3g+mPN468fGmPfuoVjbX18hbtNmpYexhSEz70gZQA7+DMKCfPsNfqcU7YZspeC4bAPMJKbhUfa45WU5AGmgJUQdK0rfiHKc15jpLdZKq6YTKdXU9XldxpUYxGUCXXewZ4EPDSkCx3WHc6wf6ehZtmmzeMu8GDHmlfVrpww168MoRVIt3WavKomAEKSoc+2iMHN5LFi0VTyUeh1tghLE6aTJTAVmC8qus9OQZM4XzyRWqUmU+PMcouhdzj3sa4577DZiHHHekGslLcHhpMXQ65S5AtTpgJynrZp074cVn3JV14LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB9158.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 17:25:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 17:25:30 +0000
Message-ID: <5c985c8f-b465-43b9-9504-a61fc50ca375@siemens.com>
Date: Wed, 21 Jan 2026 18:25:26 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] ci: Include cip-based branches
Content-Language: en-US
Cc: "Kowalsky, Clara (T CED SES-DE)" <clara.kowalsky@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0427.namprd03.prod.outlook.com
 (2603:10b6:610:10e::30) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: addb91b4-aafa-4853-3e24-08de59121376
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amloU2FVUTIvcUttNHp3MkgxZ1lLdlYzejhoTmVyYkJ6eG5yY2xRMStTMVQw?=
 =?utf-8?B?enFia0c0RDBMQXRrVjMvbG54WXpFcUEyWmdqMkJaNU9MR1NqY0xVcEdmUHZx?=
 =?utf-8?B?eHhFeSsrYWhLUnE0RTFGSktmQUNaQzV3UWJSVFo3SlFWRCszeThNYllnUnNY?=
 =?utf-8?B?bXB4aUhMa0JSTCtVMk5NTG9zaHF2Wi82SXhJY3RoYXdXUXVIT1lYSkZEWUNT?=
 =?utf-8?B?Z1hpODJ2OFFKaVVLYzdUUS9pb25jak51QWlhRTZ4UUEzSi9vQ1BnNzVEcWFH?=
 =?utf-8?B?NjNEV0ZINXpwZEFvQVdpdndOSGtRTTJHUjVwTytZYmdrcmEwM2NkOGE2ZFQ3?=
 =?utf-8?B?U2lDLzVEaHlkL3A1b2pNWkdVMnBqaVZNQjlXN3RaQ3FuZFFsc0M1NkxHTTNI?=
 =?utf-8?B?VHJEQVJQa0NuNURPM3BPcUU3TmNnYjNZRWs4eXE2aFUwb2Q0MXZUVXlNbVd6?=
 =?utf-8?B?QlpYYllIZHZLZ1d0YjRGZTUvTEFvUHp4UTcvT2czYUtTd0ViLzVOcWRuaXgr?=
 =?utf-8?B?M3B3S0U0bm1QbmgrblgxMjVGdFJodllRTDMwNlJUZFdJMDFYSkdQZmlOWWlS?=
 =?utf-8?B?UHBacmtTZk83T1JuZllHQnJGd28xVlVBZXJ6K01nZlpmRHhnL2U2UG11V1Mz?=
 =?utf-8?B?UFZDaE5RMWppS290ZDJaSGtlTk4waEpVSzNVcUtuVTE2Z0RzaWxtSTBYRmti?=
 =?utf-8?B?eHNSNHBPWW11NGJndG5VeUFWRjJ4UjV3a3pLSE1zV0NXV2QrblozU2g2NU84?=
 =?utf-8?B?TDBVTzh4Yjc2Q2U0UWszUisvTGVaNUNxMHhGcWlhZmMrQVREZGZ3TUhGTVUw?=
 =?utf-8?B?ODluUGZrZ05mdVpsUWNSa2YvS0c5Yks5RjNrYUpsYVNOSmxtUGpwaFFrb2pJ?=
 =?utf-8?B?N3hTUnNnN3RYQ1pSbVRUWWRRMEFuT1FoZ3RqR3hWaHcrK1BQdDlJV0I0d3FJ?=
 =?utf-8?B?SHBpRDBpdmkwK3BZV3JCdGVOVTFNVC9qVDBlT2swcEhYbEtwRUtKdktETUlN?=
 =?utf-8?B?dkl5WmwvU2tZeGc5OHB2WHBlYUlsRFE4VjZZUER0cGh0bjRGak5Sby9Ibm90?=
 =?utf-8?B?WkRMVlhldzRWUkRsTStHRFZnd050ZnVycFo2MTRWYTZ0czNEUUlUN3QyVUNp?=
 =?utf-8?B?UXFOR01uWW5hbG9YRFlJSTVXNjRXRHRhdS9TeUYwbG4wSWdiaDF1UUdSUXhX?=
 =?utf-8?B?ajFQMXVUOVh2VDNBUDByT0RlRFBXaTdSS2VUNDI0NmUra2NuMDhqc2FrTEYy?=
 =?utf-8?B?YWl6UjRYckE5SmNYOEhMci9jcmZFclJZd2RaL1h6Ymx1ZFMrekVTd0pRczlI?=
 =?utf-8?B?YjJ2UW1CSktDeE9ka1lpKyttMGViQ3UwNDBIbVNtNXY0SWhBSFNwYWpHM2FW?=
 =?utf-8?B?T2ZFc3hXakYzUVVFNjhYNzhJbWE3TWMwOFBSNXh5VjNUQUorM2xld001ZXJT?=
 =?utf-8?B?WGdkQ3pKc1RiSGxxeTkzblE1OEhRQitvNElWOW9kRlVoaFZNQTNNN1JISjh4?=
 =?utf-8?B?MFZJWjl0OUdHUWNVUCswVDFLVTlkVGJZS29TUk9kYWxTdkxlbmw0SldYeTBV?=
 =?utf-8?B?QTllY2tZdVdnT3BGQUh4MXVFWTlqaVNCL0x3QmNZV0ZvVTRFSUFJajhtdVpK?=
 =?utf-8?B?UzhrcE0xejJrUDhLTGZyK2lONmVhLzJBZzF4VEEzN3ZyL25BL0JmczZheU9o?=
 =?utf-8?B?ZW9NcG5xM2ZYL0NWbU5Oak80ZzlySTFCUUhEY3JmVC9CRS9iTDhiSjd5ZWNZ?=
 =?utf-8?B?QmsvWjVKT054WklTWndZam5JUVdRd2ErZ1lDam9rZTBYQ21YTEVkNmpMcTVU?=
 =?utf-8?B?WStncldPSHkzc0Q1L092T0dnNzNRSm94UUpzZlF4U2plbnRGdUErLy9qOUlt?=
 =?utf-8?B?VmtsQVptR3VRZlY5T0RxZVR0L2FhT1JLZWJ1bWFwSzJTZENTN0h4Y2toQTc5?=
 =?utf-8?B?aE9SRGNHYzNCK0Y1NnduYWtPdTd2bHd1TXYybloxMHBMd1ViSC9MR3cxQjBP?=
 =?utf-8?B?MzJBOUZ5OHdtdllxMnBLY1MzY3hsamxBU3pXTURTVDZFdndMTXZoY3JWeWpK?=
 =?utf-8?B?eTZsaTZFdlhlaGJFVkE5c21EUTY1NEZ5Sk55OXJWOFJraEVteWovNE5LL3dh?=
 =?utf-8?Q?H3PE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2VnR1M4aWlDalJacXVocFg5ZTVjSklvYnpDK1J5NjVpdmtpODZmS3ozbGx2?=
 =?utf-8?B?dmlWcEIySDczcFpOYTllOEhuQmV2MlYrelg2a1VGU0R3N3JUMThUUXUzQjJK?=
 =?utf-8?B?QUFLZVRKMlJkSndxcmxGZXp3SWpFenJ6VVRkdEFud0o3aHRGcXZDeS9iYVh6?=
 =?utf-8?B?M3BGaWlFQkhpTVRhMmhHc3o4ZmhEbFh2cGtPN2JxUFNaQUNueE9yVm40WHVT?=
 =?utf-8?B?d1ptKzRidVN2bmR2Y1Yyc3lTM2oxYUNCckN5bVNUL2k3Q2MveTJxUmlhME1k?=
 =?utf-8?B?bVA4Ykg5NGVDRENpQWQ1TitiSmErVmdwOTBjSnQ4cEQwUTV0emVoL0lsbmtH?=
 =?utf-8?B?U084RFJkRHNqSzh1NWk5bHB5U0N1MjFKOWpqdWY3aFBpRXNwdUc5VDk1K3dT?=
 =?utf-8?B?M3JCcjh2cFF6VmZiQVhOOWVscFc3NlNTWDU4dkttaTQ5Tm9JVy9lQXY5Lzk5?=
 =?utf-8?B?SnJqVmdvQkQyc2V4dFJzZWRUakl6SzdIRkw4Vk1id0pQYlkvUmdSTlJqTWVt?=
 =?utf-8?B?K0kwcUxhbGpPMkxQck9mRGtLZk9IOEV4eHkvTHR6UGtUSktZWGRJUDhvSkNw?=
 =?utf-8?B?eFZnT3pjeWZYOTYrTlhIcUxmbU9WMExQdnZMZXhabHdmT2U2MTFlTTQwL0p3?=
 =?utf-8?B?cjFaS0ZoS3lJSFRPMVFKdmhteXIzYU11UG9mV1BHOVNrL3p5SXBLeURuWDg5?=
 =?utf-8?B?dXVWNXU0dWlOcXYyVnYyRGJTY1QvNWsrK1k3WUEzeVRSeVBoYnhNckx5VlhP?=
 =?utf-8?B?TVFLd05MUlFYWnc4WDFaVDVrKzZEUVk5cFNHZ2ZNRFI4MUtqdjNQbUlHWHlv?=
 =?utf-8?B?TXlnRW1DKzhiQ2c0elNocUpaZ2FKbEs4eEljT1FrTk5seVowUXFCQXIzWG1X?=
 =?utf-8?B?NGlRaW5NZHhSdk83SktRYjZKZG13VTZBWmNXcXUzTktoaU5GRUE5WmJRT25h?=
 =?utf-8?B?aHhsVWdPWjlDL01IakFJWlBwbXh5TlNON1FpeENzOVJtckRkSDMrVFZCMVE0?=
 =?utf-8?B?bHFoSjFDZThBUFJtMDNVZFlsVmxFa1dLMGswb2lIWnpUOUlqSUZWcktJVWxL?=
 =?utf-8?B?U3A5dkZmSWdpQUZmVWw5TVVJM3RMVjFwU0FsZHFMUEdUSWhXOVFSQm1BeC9l?=
 =?utf-8?B?KzFHN21ySnlhRGhpcmRvaVc0R1hyVzRWMnRxbjMwOGNPbWhWQUlISUR6SWRw?=
 =?utf-8?B?dXlqWDR3UVE0WFZablJZUURlZ0M4dUZKRXJka3dlYzNPdzNzalNmcTFEbDl0?=
 =?utf-8?B?Z0ZaQXYwR21QSUQyL3h6UUZwQmtJVmtOQU1HdC9BU3RKYlk5TmNLSmx3SEZz?=
 =?utf-8?B?Z28ycllVS2NVdjA2bi82RDE2UktDZGtnN2xEYkYwRFFoQWQrcTZMVjAyeGtw?=
 =?utf-8?B?R3RQdE42ZnV5cXp3Y0Q1V2ZjeGVkd0ljME1qa1lCUGNDVzdIL0g5Z2pCSWlz?=
 =?utf-8?B?SjJzNTBWWGFZRVhDOHh3UFhyeitaTXJJalF1c1MrVEh0ZXEvS3Z6WloxcCt3?=
 =?utf-8?B?eEJ4SXhNUWRSOU5sTXVCdHBhclFGK0V2b0pJRWYwNlM3QVRlRnFkWWJ1dWRt?=
 =?utf-8?B?bGxUTUtIYjJoQlRsS01uZmJTNENoR2ovUVhDMDlSV1BSbEZKUkpJUGc3cmFq?=
 =?utf-8?B?YWIwS3N1M0l0RVBNWUo2Y2xkbFVoVXNTa3NLd0sxQlJsQlJLSTIrZ21kb3E2?=
 =?utf-8?B?Z2ZBQWZJbDB1RFhwTVgvalRTK2ZrMERXREh2S3F6ZGdUMER4SW05aTVJL3J2?=
 =?utf-8?B?QTNiTTFpSFpjcjg5R2tDMi9XcXVpRGQvZVBHRCtGbkFMbUJQRFRDWmFFTzVa?=
 =?utf-8?B?WG85R3NPaDRJYzd4QXRZRkxlQUdRRHVRWWMyR0JMbkVXOTF6TDBtWUYvUE9q?=
 =?utf-8?B?SkttUG1aRiszYnR1TlVIdjJydW5tUnVGdm1URzY3bzMvUkx0SzNaMTFCMkZl?=
 =?utf-8?B?cVNxMjVRZWQ3SVAzdGxnVTloTzRkWnRnOE5GZ29oWXdwT1VtcUh4Y2t0elcv?=
 =?utf-8?B?d2ltUzVmbzA4MWE2NkpWQW1SZzVHU1lTdnc5WFNTK3VodGRDNlI2ZTU2NVJP?=
 =?utf-8?B?aWxWYktvQ002UUNZd0xOeWQ5d2RIWjYrZVppNG1mT2VQeTE2OExJeEJPbzI2?=
 =?utf-8?B?aEVKK0d6S2xva1VlM3lRaGsrY21ZU3hZL0cva3N0bElmY2pVaENCVGJzTmxw?=
 =?utf-8?B?eGpkR2xFSGg3aHY5THg3d2xjYm1LanhDeHN0UVQ4emF5bnZ2ekwrcG9ISFZO?=
 =?utf-8?B?ODR4OFZXQ1hVU3I3cXFSU2ljMDFZRisvcXltNDhsNzlIM0JkMnJ1QmRvZnRs?=
 =?utf-8?B?S0dUZmYxZ2RkUU43WlZsYTZtaDFQS1RKYlZ1RFhFbS9LZ1FnbVoyZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: addb91b4-aafa-4853-3e24-08de59121376
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:25:30.6407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNJQ+Zs90cpUGGRoEC7JzxR48bdl09m+oX5fLJXR6YPqyzX1PEC3T+tduh3l2Nx04Ny5bg6AzfkzVuTmsIhDbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9158

From: Jan Kiszka <jan.kiszka@siemens.com>

If a dovetail branch is based on the CIP kernel, it carries an
additional "-cip". Account for that.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/ci-dovetail.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ci/ci-dovetail.yml b/ci/ci-dovetail.yml
index 2049e9c..8332aa4 100644
--- a/ci/ci-dovetail.yml
+++ b/ci/ci-dovetail.yml
@@ -23,14 +23,14 @@ set-vars:
   image: debian:trixie-slim
   script:
     - |
-      KERNEL_VERSION=$(echo "$CI_COMMIT_BRANCH" | sed -nE 's/^v([0-9]+\.[0-9]+)(\.y)?-dovetail-rebase$/\1/p' || echo "unknown")
+      KERNEL_VERSION=$(echo "$CI_COMMIT_BRANCH" | sed -nE 's/^v([0-9]+\.[0-9]+)(\.y)?(-cip)?-dovetail-rebase$/\1/p' || echo "unknown")
       echo "KERNEL_VERSION: $KERNEL_VERSION"
       { echo "KERNEL_VERSION=$KERNEL_VERSION"; } > vars.env
   artifacts:
     reports:
       dotenv: vars.env
   rules:
-    - if: '$CI_COMMIT_BRANCH =~ /^v(5\.(10|15)|6\.(1|12))(\.y)?-dovetail-rebase$/'
+    - if: '$CI_COMMIT_BRANCH =~ /^v(5\.(10|15)|6\.(1|12))(\.y)?(-cip)?-dovetail-rebase$/'
 
 trigger-xenomai-images:
   stage: trigger_xenomai_images
@@ -46,4 +46,4 @@ trigger-xenomai-images:
     KERNEL_VERSION_WITH_QEMU: $KERNEL_VERSION
     ONLY_RUN: xenomai-3/dovetail
   rules:
-    - if: '$CI_COMMIT_BRANCH =~ /^v(5\.(10|15)|6\.(1|12))(\.y)?-dovetail-rebase$/'
+    - if: '$CI_COMMIT_BRANCH =~ /^v(5\.(10|15)|6\.(1|12))(\.y)?(-cip)?-dovetail-rebase$/'
-- 
2.51.0
