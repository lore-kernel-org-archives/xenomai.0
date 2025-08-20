Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AA6243367
	for <xenomai@lists.linux.dev>; Wed, 20 Aug 2025 04:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755664200; cv=fail; b=S9sUhnD1UxIkwgLeJHJHapURyXDlsFftijZ3gOSgHN5aDA3NYWyZtWB2+kmNBF+t6fOKRV+HAoxVv3K9gCCG343vGS7sKHL0ETswpcXaDMINdEHMSagG6o8OzKwn9jogLEFIKwaCddM4zPxwMLGNBpQ/24zeUgGdg1WIc/D3+S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755664200; c=relaxed/simple;
	bh=1DrZzhRSm124A3YUO1Iz2YcCpqvGbmm60kJePSDnIlI=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=uTIouKxUsuh4dyuTmqYtzEev/T1yRWVmXCYOyerQHPovIC5iRqAZYeoA/FgA/e66uhUCihl964iXXodb8v9nF46u/7+QQzPYMDM/IfEZFTVISnZ6CEG5kOPvJLBb0Z3qvp8ZdmEi1A63ylNpXnbgupjgGGALetaD2G9mWSYBs28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=LsEE0ZcW; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="LsEE0ZcW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUa+BatTY3ddHnvAgm39fF/ytvV2M6CIdvB7wMF+yCUc+vCGJdTfwL1/1Ko5wStbT30YtgEBvjPpF3lpAaqA5GYKdoEdP8CEm04I57HOCKBnGSoRAq63cmAPYuKFAfVJZuekJ7p3mrXYGUdb+emE4mdrwSwQRJzGBwuGHQy5xVRt3LDu6VAs+OF8+YENO/u/M9h/cr+tSBVaYDQwIFa+f6i/0SCYZI6uaGLh9QIR7xks4kPp9CQB2k+16qR7R9tWdXcGbaRDl69gTTfKdXgGV+P5st3GIhtvO7rwlv7d71MYHS80OfG/BXyUhbOvT6MMBDXcyAssyMb+4duOWBxlIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTQk44jLAlf9QpmRfGnh/loM+RISOGYgI/8meSEIs50=;
 b=th30XTInoyFETYGvzr0SQhJavNUh1fETEf/OdIdqxDSY8MlV4Y4rHWcdPY0AJ3rTFrap12TNfnYVRH/oyobc/CouG7yiXmZz1EAkx3d4Yz0IRw1QbI9uP2L66eMeraPyJ/RfSirDwUCiaf1oG/VkNhMWc63Zx3ApwlmKT4KqrNHTt/Zmr+rfTkoU/b8b15I+jBBbArZxcDkQ5hFM4QdqFdJioWnnZPNghTQ3g3eBZoTfYkvWjPAdbe7wep5NNTP5gFh11mkLREhSFnNlC28KeDq2Zlf9DPy+cEjF+XVqncLEhQG71j3ofi+7dSDj5LNPm3c90C0r8c1f+XSpzzR50g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTQk44jLAlf9QpmRfGnh/loM+RISOGYgI/8meSEIs50=;
 b=LsEE0ZcW7OzF3IcpTX7CjUoj2SOjXAa89Vk64uSiwPJVM3jlCmiwEYyNWPYHiHhio5SST8i2+HZPZFEloJ7CoMJiZjeF0rJU3/LXfcKgsex9UQH+nbB5/KnKR4LElDPX0GuTttu4KNnnNa9b8v5SjH/JbnFrea6ZbmEIVr1Ycj7VSHNF6gCvEM3JkdqeogrUrtJy4fTzlvUt0CCEMiE9bfWFSBBWXMg6aV21Rd62HBizihHugqLs+JIhcEG3lcmxJtilqsiXA2/YFA5cyqP6wYnQmh7k8hts3jWrSjFKofZKbiox1ylO3DSOBGt/klvXJpjX8YpqvnKmsMSl8cRoDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3958.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:161::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 04:29:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.024; Wed, 20 Aug 2025
 04:29:55 +0000
Message-ID: <e022936c-1056-4468-998c-e194a3c4a77f@siemens.com>
Date: Wed, 20 Aug 2025 06:29:54 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: Xenomai community call on Wednesday, August 20, 2025, UTC 7:30 AM
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3958:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1fba58-f26e-45bb-350c-08dddfa23679
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0NnZXNGeUlCcUtENmxXNVVDSzdjS0xYbSszdWtFZEJoY0RVNWNRWkFRS1dl?=
 =?utf-8?B?d0JQZzRwY0R4bDg4amdIQk1WSWVGTHVFMHVtMDZNNGlHd1F2RTVTOC8yY1NB?=
 =?utf-8?B?QWl0R2c4eWw3SkUvamxYdUN1QmtaT2hRQlJvWDNBcGpSL20vRmV3bkVSd0lV?=
 =?utf-8?B?UkdYNzE0ZE81QUZRODZMNmNSdnE4ZFN5MzVUV0VMZEdtNGRJVHVzZ1lyejdu?=
 =?utf-8?B?UmtyMnZyakJnS0dQalJ1eHJEeG5ISWh0STRvcTBraXduc2w0bVhzalFjazM1?=
 =?utf-8?B?eFowdlh1Tk1mK0ZpM25yUlhUUGhaQ2hvZ3FjR0I2RTF1NDA4RzBzYjM4S0pn?=
 =?utf-8?B?RGpoQTdsQ011ZEJnRk9TTFBxeUtDQndyNU5Za05FZXUyN2IrWDdLa3pCZVdI?=
 =?utf-8?B?NE5yM0srWEhMcjFSTWJSSkJOd0l4WVJsN1FzSW9ORTV0M09UaUZ5VG01NHlh?=
 =?utf-8?B?SVFBZFA4VDJxSzJoNHZEOFBSTStOWHRsNlk1TzF3dS85Sk9QMGhLQnVWRFdF?=
 =?utf-8?B?eGdlTVYzNDFmWGpWMHpkRm1rUzNaUCtFTkVWaWdwSUwxVzNCQ0xDMEw2THVl?=
 =?utf-8?B?ZzhyanpqcjJxS1NsTXBCbklONjZTd3kwOS9IS0ZQSGZWZklWOXU2QldPMzlj?=
 =?utf-8?B?YjRwNm9FQUoxVUt1amhrR2UwU2dta2MvcUViSC95S0ZEYVZGN3pFaHIzeWZt?=
 =?utf-8?B?NGN4a3BBMXBhQVZFcmV6bmxJdkkzbVZwV0ZlaEhMS1FCbnhDTDdpRkUxSzV0?=
 =?utf-8?B?OVQ4YUgzeWowc081Ykg2Q2p3eEo2M2x3OHdJQVh3Nm95enQyNHErY0ZGemIy?=
 =?utf-8?B?YXBsWU5oR1JGZis2VnNGNzVGZGRlK21qT2VqT0pxaTRlTTNIZWFnaUFpRk1z?=
 =?utf-8?B?RW1HRHhaZTg3dFZOSXNIOW9JMVgrK0FOdW44UVE0cEpDbnZtbDh1L0VNdHRN?=
 =?utf-8?B?a0lXZEdWaDVLN0l1UW82TnU1b1NuSGliREEzamhWN1JMemYzUnFiaU5lZnV2?=
 =?utf-8?B?T0szcWdhcnVPaEhhMlg4N1pFUmdaaTVvZ2pkU0NYRHZVR3BSTzROZEpNS0Mr?=
 =?utf-8?B?eGZNOFljOUFRVVRCZHNBUVBtVTAzZ010c1p3ckVVYk5TVzFHd0hKekRiZzh3?=
 =?utf-8?B?bHhFMkowS3lxZGFRNGlSVWJrZUF5MHdGbTN6bThZQndCbjFPSzlVU1J1NkZn?=
 =?utf-8?B?VlAvSURjaUxseDIwZjJOdUp3Uk8yVC9mdzdISVVEeHo5RW4rL05rQldScVJh?=
 =?utf-8?B?ZThoTjRDZ1NCRFlYYXg0emFIVXdwaU0xNUI0Z2RGZjJXMzJZaDBIVXpZbHht?=
 =?utf-8?B?dmlmVUdVcHdqQjNCY0QwM3crZ2FyNmYwWGtBaE92bXlMQmhxazFtSjQzaTVW?=
 =?utf-8?B?bTY1UHlFTTVuZlE4YzZzbTdsTDBTQ2VaYXFEUUd3VHEwR1VTTmJncVlnY1Z6?=
 =?utf-8?B?eGtuNDNESkJralVZVC9HWlBJZDhGVitKTzVqRlo4SXNiMzEwdjVkZHVTOFkz?=
 =?utf-8?B?ZUk5Z3kzNXVsTUVHcXlVYUpaK0RSZUVjakdoOE90VE1ESGF1cEE3Mkpub1Mr?=
 =?utf-8?B?c001WXB6eFB2dGh1ZEhyNXJQNW0xanN5V0N1eHNyTjJNWWgzZEpnRkU2ZmdU?=
 =?utf-8?B?L0dmVzBDb2puckN5dDBiQWZrQVhQbXE0aWRMSFEzV0ZNcmZrcHBTRks0cUpx?=
 =?utf-8?B?bHFTN3VNdzBVRFN4NVdxb01ldEpGSWFGQ2d3ZFlLaFo3S0RxNnNObVV1ZUY0?=
 =?utf-8?B?dDRvaGVYOXZMWjV3V2N1eEV5T2JQaExucGFjdnF1dVdLbUpmM0x4V2s5eVJu?=
 =?utf-8?B?S1oxNzNvaTVSOW1hV0RKdEp4alZscXFZYUg0ZXR5TjMyQzFxdkdRRFpLY2dQ?=
 =?utf-8?B?MUgzWm1rb0FQalQ2cTYyNnRlVG9oT1d4NHU2M1MyY3hPaE1VeWpOdlJ3bHhU?=
 =?utf-8?Q?ueAvd0AUwF8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW8wYVBscm42cmdUTkJ2UGFOM25CU3Y2bGRIUjZqZzV4SjdVbHg3VGVQZUIr?=
 =?utf-8?B?VzYvYmYwZ1ZiMXplbVlYa0JzN1ptc1lXenFQSWRWOWF6ZXQwbVRRT2I0ZFkz?=
 =?utf-8?B?U2Y3ZnI0cGVJWkRSZ1BRbUllQmJPQlUyWjRIT1pGS25RUy9yK2hGWlRwbjdv?=
 =?utf-8?B?djF3OUVKYXlhbWNLOFZHLzlLMHhySmFDdFY5SVFLVVJhYVlja2I2NHF0emRo?=
 =?utf-8?B?S3hvNGlOWThObmNzZEN5WmltWlZGTDRETC84UEVJTVlvaXdodSsrdUIzNkNk?=
 =?utf-8?B?SzRJc1ByK3Q1MkFLb2NYajd0TStGZkJhY0pKMWZGSnIxbDloRU9jWXh5Mi9h?=
 =?utf-8?B?REF0SlVTWHlzWDNPRUV0OWorOVNYaFRtQ1RzUjBuSFhBQXdDTmdYbUJ3OW5Q?=
 =?utf-8?B?eDc4anRiVkFuaXZ6ZmtncWw3Mk5ITEhOckRqUHZCS0kxSnV6VzVPbEZpaTYr?=
 =?utf-8?B?Nm1KdjRWWWt5eS9iRGtIeXRiMVp3aVdKaTdMY3cwbTFnRHRSaXNOK0hxNDdC?=
 =?utf-8?B?U1p6blZGb0ZmZUt3OHQ5MVFVN0VKbCtNOCtzc2tteExQYzlEZklMSzRxMG5V?=
 =?utf-8?B?SW9aSkU3MGVISHVEYXh6eG9EeWI4NmcrYmFzeTBZdHBudVJoRkpiOXhLV1JS?=
 =?utf-8?B?MjE3VjNKNFQ0dVp1NEI5aWcxMjhzSUJNUVp4a0lFbVl6dktpak9xTmpIYjQx?=
 =?utf-8?B?YVBNZTdBUHNTdk9wMGhEU2ZrWWcvM0ZvdEpyekxXNkI1TTg2aEJZd3NVc2tl?=
 =?utf-8?B?ekZOK0lscVM4SUhVVXZLQjJzaFVMbFEyN20yUCtKeUJtT05FaUdxYXIzMm9s?=
 =?utf-8?B?RFZEbks5QXJuN2pIWXVGaGE4dFVYbThscDd0eFZPTm84Q0wwc3J5QUtoSHlX?=
 =?utf-8?B?L29SemJ1ZnR0ME4vaHVBTG5lUjFpTU91VUI3TGY5Vm1zOGVJbjZaL3lwcHZ1?=
 =?utf-8?B?ZE91bktDTzNoUVVCdkVRTWh2U25aT00vQ0h4MGhXdkM4R3MxdVFkZjVFclBk?=
 =?utf-8?B?NWtwSkxWdXJ0cFJ6cGZsaVBENVNLa1NYQ0tYR1hEZlFIQjRScWZONHorSEdo?=
 =?utf-8?B?dkZ5SmhXWC85RU4zbTAzRkxYL2tSRlo4elpkc0FFVnhqOE9wd0xZaDIxdi9P?=
 =?utf-8?B?REVpUzYvNWhFcUlGbFVRR0Q3QmUxL3FlK3E0OWthTnducWRrdzVEQk5WaWFp?=
 =?utf-8?B?NTNaeThVMEh5MVBhMUhQeXNlZk0vWXlUWW5TNEk5bkVwcEd2T003cnZyQlBt?=
 =?utf-8?B?dWVRV1RlYkszSEF3eFJ3Q0VLZGVPWkQ2NGNoRStIM2NObjNEa0YydEQ2SVFT?=
 =?utf-8?B?RFpPSnNqSzNCbTkxSW1ISFFkV21lWWR4VUU4dXJiNWtqVEJqZDdCWENaRWFh?=
 =?utf-8?B?bXdHK3Q0UUxBOHFlWERiZzl2Yzh4eE51a2hqbVNzckM3RHd5SDJxbVVGOGg4?=
 =?utf-8?B?aS92Z2pIZ2Y4YVc4OE1naGo4cHVQSGNCa3YxREtsOCtIekxUNnoxVDBJRGZQ?=
 =?utf-8?B?aVR1NXFOWFI2TDVzbkpLaHVSd05EU3N5b0RzaVZiUFJKOER5Ym9UWnNoSzAz?=
 =?utf-8?B?TnVESDlTMlpHdmFUd2JxV3UvVCt1UUo0Y2d2TDh5UnlqbEZXcGk4a25DT0tZ?=
 =?utf-8?B?SFMyMHlqUm9EZHVDaHBJQW1YNDVGSXRtbmxXaWM1T3hMWFZTQWlFbTdJWnVn?=
 =?utf-8?B?R0F6OTNIVFRnZWI0c0J0WHZ2ZU10MXQxZjZLMVVVY2FqQmd3WmRIWGpyTm1t?=
 =?utf-8?B?N2laLzFtQ1ZCRXlpdTJrQnZ4bmppbEtORlBwbERHci90WHRZY2hXWDkxTFBL?=
 =?utf-8?B?VjBlVkZ4QlNyOFRWcnFoQnp1elRYQkpBK1RtTzBHR21XQlFVTk04Y2g1QThr?=
 =?utf-8?B?RlgyK0VjT3JiM2tYeXZHTnVVQTlpbGZFMnY1elNjdkdaTGhIekYxM2o1QzlQ?=
 =?utf-8?B?djhOaStRaTJPdjN5VWhlMG9Qdy9wMEQ3S1cwWEoyMHNGY2JCUGhkN0FHZzlx?=
 =?utf-8?B?dGg3MjNQdXNqbjJJR1pVYUZFUFBxaHVsN20zaUt5SFB3ZXZSMVpHSFdXSEQ1?=
 =?utf-8?B?SHZVT0VLNmpNUUpwMThDdUE2WGM3M08xWU5RODBWZ3UrTSs1ZDNyMytmODYv?=
 =?utf-8?B?TWNkM0pTcTcxZ3ZZS2tjNTdFRTc0aGtta2Q3ZWw4dFIxRVAwcTBEbXlXKzhx?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1fba58-f26e-45bb-350c-08dddfa23679
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 04:29:55.1490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJWlI4h2VGM7BfKUw4SSjWxnBpfso/2oejx9HMT8y3KpEX3fSh4HdFG2tLQf9yT4O1gb1vnPgbMFe4x4XtjVLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3958

Topics may include but are not limited to upstream/downstream project 
plans, status updates, and technical discussions. It's an open online 
meeting that anyone can join and ask questions (you may have to wait for 
the organizer to let you in).

Time:
Wednesday, August 20, 2025, UTC 7:30 AM
Paris, France CEST 9:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

