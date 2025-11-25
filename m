Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013064.outbound.protection.outlook.com [52.101.83.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA7D325739
	for <xenomai@lists.linux.dev>; Tue, 25 Nov 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081210; cv=fail; b=TeerhTBEWwaAojYuePtqdihRSFBlsZhMTNnEkRJJ59lcW3ZSBxoew4BbZsh5lh7bg1VZbuQmpsayLzNNr5gQsRL1VBFshgDYjJ8fm3fnkwAF/FktN7mphCUnE6AlUZpjFFFrxLrARAtjyaqIVwdLrmi7ghgNPtemL+/lx8vQyM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081210; c=relaxed/simple;
	bh=yzBKq/W8fNFefHZUtboOITm6L6hULsev3IwKYu4X8Bk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OvBi0B9pMy9cprsjj/vTgJ9t5KoCHhbGQtpHPpJ7gX7u0iZcMQqWr67yFo7EhjPdXdLooaRAy79MSlR6b89mI0w3wDBqR6HK2iwiEpuccpd8gtuUBytiMcRIkfcBh37Hac9op+r3ZJQdfPyB4xHf2FlsfuUpHTG1jbQVFcQNdy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=h8YmgolJ; arc=fail smtp.client-ip=52.101.83.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="h8YmgolJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRsX1+jbBzUh794epWGXlexjXr6awU13TclDR8NXuVpkmroxbHZhBcYLEOUpNwjigWDn9DzY4vnhHt5LxRzj+G6Br/oYpgTQu2bvWQaPtwkbRG7TbJlP84qbpHzCsMcdGdLMe/ocFuz1MW6yvBGAycaxesNSP34wLaXNvfOsZfS+M+DxKnaV+U4wGtysc0Zj8Ks9FjnBE07uQyJUZo+oYab3mt1T1Sv0ELno2yKnTNVHO0+SRyYMtWqOBFG11ix/DCu9w32+e/KI3Qw0FkesozFxxGwoQsMoi+YtqFi5aj4ScdIn4ONoHsPIsyeRtFkCsDaccd65cBuMG/RUblPchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mfYTOx7WUH9Bi6DNJU9ntoh4N+JY9EVWs9rn9Ycx9I=;
 b=SfuwhPFAzAXjoWgIbZ8/0gu74oORqLhe7grIUMEDFt9V1SGNmN9DkreOyMx0H+a+u6FUU1MfILiOQCv1a9QcSh/zgG/YwovlSagwMn+8dEdVX6ZdY+UaiZLTgKyqb7DLCNHaYICoH/Kz1KZTWW4ZzcYox6NMSY0gPQk/M8DHehpukH3kMEZUuzCf0h2oiihH/006Nj04tc+NBgvypeXgWhz8iAZXiDGPK/oUNiG2KRSWeVLDgdSFeOVvAXcTWyURBFq0kV7R14M/1w4a4P8d8DjxIOT0jeocm37A/wtAAFVitbQyNuEyKmaWUIoJQzV5jgNfj9BnbnAkGCE6QJz14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mfYTOx7WUH9Bi6DNJU9ntoh4N+JY9EVWs9rn9Ycx9I=;
 b=h8YmgolJgWPlyO6re1/0xLUfPMXMCCv02KO9zlU8XLGu8QACZdSFgbvZneYEiHqm+kgJt50KZ+LtBJqmXy93jZanYzhQbHWR8RCwSOMu7l1N4bHRIsrKSb5qBjI8McyJczYd269oLjTC9whIRQSlydGO4RK7atj3W/ub+y+hyZaTEtGhVCAx2drXfgBmE4fyGBq+jlg//r2ENz/7nbyXOhVyyYgKarYMZBQJmGt1BKCNbsLqU+Ygutiocu7pGSJXnfrh81FMt176AZ55OZ96jyEji54LvLJvsjGI5m8z4CFMOkMcwABDpBzvCJh5cby50VZ6X23sUZaq7V4mkHNbDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6444.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:80::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 14:33:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 14:33:23 +0000
Message-ID: <348b1bfc-8f0b-4e97-a100-999928f67ab5@siemens.com>
Date: Tue, 25 Nov 2025 15:33:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: rt_task_resume() resumes a wrong task
To: Mauro S <mau.salvi@yahoo.com>, xenomai@lists.linux.dev
References: <144fcdcd-0944-4971-80fb-80ee7e72cb83.ref@yahoo.com>
 <144fcdcd-0944-4971-80fb-80ee7e72cb83@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <144fcdcd-0944-4971-80fb-80ee7e72cb83@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cdb0c20-3581-4baa-d656-08de2c2f96b7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZU5SdjJ2bUFMSjlZL0FhejVvbkx0TVF3YnBtMnJEWFQ3ZE1kaVQwQjhqMUVz?=
 =?utf-8?B?bWxQeVJ5NjFaNmU2RW9GQ0xmZ0xSOUtKM2wvYzRIYUxZTDl5dGcvZDVneitr?=
 =?utf-8?B?ano4NXB3WEEwRHlBWlgyS2Y5Zis2Q1ZWck5RUjljUWt5WktycEJscHVkZTli?=
 =?utf-8?B?alhFTEtnVG9RUHNuY3lncE5aZkl1Z2xGQXpocU9CbEgzaDZ4WGoyT29SRndF?=
 =?utf-8?B?TFdLSUYrU3I4OVprNHBoTWVGVFdFK0poWVhQTXVDVHdlYS9NOCtLQXh0bmVl?=
 =?utf-8?B?UThRUUF6K0srMXd4NGMvWThZcWZZRlJIeFNtZlhSQ001YzNJVVltRURuTkhL?=
 =?utf-8?B?NmN4Rm9SUSt4N1d2eUduMDgyL1VaVzNkRHZDT0cwK3NiUFhTUUFZM1QvaTVW?=
 =?utf-8?B?enFxdWF2cXVMRVVzSkR6ellidUxxRDBqbUhJVEpGRllTMnJjRkFlNnJMZHpu?=
 =?utf-8?B?SEhhWGlZTjBzY3VSTzRFdXRQS3dTRTlNYkVtM1B3MDE4QUc5WHlFYzIrWkRa?=
 =?utf-8?B?VHRFOVZiVkNZd2R4dHhNVnJQTDNTUFFBaWhwM3N1Y3lJN2x6UXNXTC95bHJW?=
 =?utf-8?B?QmlpR0tUNDFmT1NPSHJUdDBvU2loNUVhZHNKdEp1MnR2dmpiZlo4Ulo5NkJB?=
 =?utf-8?B?MWxiN0FJazhxMGtKQStGSHNsSW5iVksvaTY2S1ZDdTgzVTlSRFRZeW54dUpP?=
 =?utf-8?B?VlUzRmxmUnd5YjBFNktXeTF2Sis3TmQrWHpOck1qcHR4clNKbmhJYlF0bzBQ?=
 =?utf-8?B?U1JRUlUxbW04R1RKbC9iRTFSOVZETkxZTXpCait6SkE2eGxiOFVvZklhOWZV?=
 =?utf-8?B?Z1RRdEg1c3RJanA1aWdLTlpuOVBmVkRkSyt1M0RGRWJCS0x0ZHZXZ1Ixc05B?=
 =?utf-8?B?aEdyQWNxNWlIa3ZNUk1aZWRBUXZrTHBZR002QkxXbmJ4QmNOS1ErVC95QVFq?=
 =?utf-8?B?QmZyTk1yVlp5VElJdldNTEt3dllJZzVldHh4MFovZmNRa24xS0g1YnUwZWtk?=
 =?utf-8?B?bmlkSWd3ZFI0dFYwcHVyNnM3c3J5L3ltcnpLQ002U3JlL0JOaEdTc2tNbGls?=
 =?utf-8?B?WW1CWWNMMVZvdXp0T25uVllvOFpXWlJGZFN3SkdZT0FXeFU3WkcwZ0NveVds?=
 =?utf-8?B?YWJlTU1OYUxHd09wZGkwNVpBcVNoOHZUK092MHRlLzZVZUl1R1hwVTBETzl6?=
 =?utf-8?B?cnBCSDNkQjhSQUd1M0VTeU8vazhGV20rTzNYQ3RLQ2FRRFNxekkybWNVd3Nk?=
 =?utf-8?B?NUM3dHltTVBLa3RKc2I2NHM5Z3hxTEVkSTVjM3FYc2szMm1GeWNWU2VjYk9o?=
 =?utf-8?B?cUJsd0xieGVPYzhyY0xOWEFWczcyVVgzOGJFQ3lwUW5WZzNpMDZWNHl1cWxO?=
 =?utf-8?B?Z01WY0pyS2VsSVBhNzJlWkcvdFdTRC9hUm1YQTdpeExMVmY4NklKcDZoT3Mx?=
 =?utf-8?B?c1JRY0oxMmt6OWo2K1RBb0IzNW0vUExRZ0Z5T0hmdEJVemFoSDlOYU1DOWV1?=
 =?utf-8?B?akFKQ2JxT3JTZHFuNkRWcWtobnd0OTNUYm12dnFaVnhLK1doVGZhNGdsOW5C?=
 =?utf-8?B?bGREc1BFM21SWEpkZDFoYTgyTVFuTzk0OUlSTWE3UzM0eVNCY1ZQeStaK0ww?=
 =?utf-8?B?UUxid0JmZnQ2SjFXYWM0NkpwMEp4MnF1bHluZU9QNzVKVW1adzQwbHhCazd5?=
 =?utf-8?B?cG5kbkIrVkRWdDYrK2ZiZWNLNGc5L0w0UDU1QkZaSUE5U2NmN0JQK0xEOFFo?=
 =?utf-8?B?enVwK3kxbVRqRU1PeWdNWmg4SVgwdnRVUUZWQUR0ckxJMWtnRzQ2NHFnZkdE?=
 =?utf-8?B?L01ua2pHRGdHZ2xnOVFsR2xQbTgxYlNxN3YwV1lwUFJROVVHamthTUlTZXJr?=
 =?utf-8?B?a2lqTHh3SVpqZXZLcktqd3NaeWRMZDJJb0RSbDQxTitkNFVBY0dpbzNWU0FG?=
 =?utf-8?Q?95YDL8m5bgYWzZj2y6DriGGPuxslpCQD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE5XSzdCVCs5bU5aMmVDMDg3NHU0cVMzVW9kRmVRakhQQ0plbEZ2R20yNlYr?=
 =?utf-8?B?eFk5U0l2RXd5VTd4VDlZczBXMUJLaHBpRTJVUlU2S2xXbmVXMDdFKzJkYkpl?=
 =?utf-8?B?V0lOQUMzVHd2Z2pVZUtxMFErQ2tBaVdiSSs0alhBWERmekZkN0ttMUcrcHJk?=
 =?utf-8?B?MmVpQTFobHlMekpsUm9qUlNCN3pLQklYMWNwZ29uNHNHVXVjeEFVK0I2NlA1?=
 =?utf-8?B?SzJSZXp2SmdPb2NyeFozQzJHeGl3bVgwRUczbjVMSnZ0RnVhdDdvV0tDQ1Nq?=
 =?utf-8?B?K0FxdW1yMXpkOFRvbXdURGtZZDQweHpzaWtwUHBBSTIvZERkb29LNlVpTlFv?=
 =?utf-8?B?aUkxSDY2VzVCSS9JMVpDbG41Ym1nUWJQTW9SSXRlNVJZNnZualZPMWplS3Nj?=
 =?utf-8?B?RUhhMnFzOTl3ME1JOXdveWFpSWUyejNMUUF4Y2ovUlhEeEo2RDNrMlVFVE1X?=
 =?utf-8?B?OTM0TFJMaklxaGVZQjNOUGlocVJ4RURXNHJ6Qm90dVRFVlYvVGxDbDMzZGYv?=
 =?utf-8?B?MXZKeXdST3M0NW40YUI4RnRncE5XTzlKcUVNWGNQUERncmF5THh1MkV3NnVo?=
 =?utf-8?B?WWthU3lLaFpERWZrUW56Nzdjb2VNcFJrTDhxeHB0dU9WeTFGVURlRXJmZE9R?=
 =?utf-8?B?YzJZdWFoZS9GdEtYeGxhc0drc2tQMGRsRCtlbE1rS25ZWkJ3UEdZRVkrdFJN?=
 =?utf-8?B?WGQ1cjVQY1VnSzN4L201VnZmS3lNNFhxUnBGL3EzaEo0SXdlSkdvVUJoU3Qw?=
 =?utf-8?B?VGZ4Q0FJdEdWOVdieTk0UkVaYmJ3cWwyMkdQOHBRNTkwdGkvcDd6bm5PTkZv?=
 =?utf-8?B?OGx3SmN1YkNOamo0MUJpMWhvWTdiUzBwTlNEczU5bkF2dTZVdzZDOVV5Y3dE?=
 =?utf-8?B?SXNPRE5qRmhtZjJyVHhKRmFlNHNZZEYxbnRiZHBNSmhmYXU4dTgwWnZ1RWQv?=
 =?utf-8?B?VTJwSWkzNng1TzNLOWRBYjdKTDlnejhYNjN3dzBWYXJWa0NDRUYrZ3pFT1Rs?=
 =?utf-8?B?WU0xeDVlSGkrWkNyZTBRR1B3blRDTVMvR1Z3bXg2aVN2eTg0dkVqR2FCT0xm?=
 =?utf-8?B?Z1grNXE5ekdRejRJcTQreTd0Z3FJaFdBSVExSjlvby9MY2QyeDZ4QnROeS8r?=
 =?utf-8?B?UFFqV3U3bk1jTXErUC9na3E2cXJNQUtBbXZEU3BLRk9TL3hUVnRQT1k0YkZp?=
 =?utf-8?B?TFdPZU52ZWFXb2FZUjNpWEJndUxEU0VXYy9kS2hIUCtZWEgzMmo0SFlCTXN2?=
 =?utf-8?B?NTI1RVBWanQ5MnRtSUxkQ2xuN2hvOUo2MDZROEdNaElHMjQ0Y1ZMS3pkcXFl?=
 =?utf-8?B?Y09KVllkQW50TFRHRkpuNHlPTDV3THRqWVIweWNtRHhoU0lqclNWOHBXWUdS?=
 =?utf-8?B?UUN6K3M0c05YVnI5UjMwZGhySUczcnFNZWZ4Q24zRUVQYVJOcUFlSW1DSzhT?=
 =?utf-8?B?YTRVS05NNU5NcXNsZEh4TTRoMWZ1VzA3UlR1SVp4K1V3cjZ1NUxHT2FWd0xF?=
 =?utf-8?B?amtCU0ZlVjhUdGNLZEF1TE5rRGhrcFh3SVVEeFVFRlJGVnpCaUUvU2luUjly?=
 =?utf-8?B?eG9HelA2RHBpMGM5ajduTUtaMFZTRWIwNjQxSHRYbVFHb2JRUXhvS3o2QUJj?=
 =?utf-8?B?UjN0WTNKTHNETkhQZmxqUWJMMVJoVU9DSVJwdDQ4b2xHWXc0ZVVKT3JWcmJP?=
 =?utf-8?B?U05WY00wS1BraHFkRXVGY3FOL3lnZEcvR3lrWXVJZzN3a2tnZFhuQXRlQVpz?=
 =?utf-8?B?ZHVLMkh3ZC9MQ3kxV1p6c1NXb1BkNGlzVm5oekg4Z2NrOEFNRU5HZzhXRmtU?=
 =?utf-8?B?QkdFZDJiQWRJRUZzM1REd2o3bEJuQTFkU2x4WXlOUVF1aDhzSFBuUS9rdXVi?=
 =?utf-8?B?S2FxaHR3dmxvdjBBVnlVc0RMUjBEL0l1alNIZXZJMHVhWUQ1L0E1UzFNWXhI?=
 =?utf-8?B?RzNGQi9IMHRxajh0TUppZ3hkbW1mZXYzMnVaMHlsUU96c3I2SVlPQ1psSU1I?=
 =?utf-8?B?MlBwNTQ0NnJhRVV2NnkzLy9kYlZPTUlYVjd4TFhKdVJoWmI3NW5tanU4dmdW?=
 =?utf-8?B?OXdZK245NTV4UHQ3VGlFOFpGMHZVQ2ZkaENuZW9JNXJyeDB2czltSGJmWXEv?=
 =?utf-8?B?ZlZubkZYc1dqVjhrVEFWS2kwREM2SHNELzZudUpEUnBFaGU1V1BFS2ppMC82?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdb0c20-3581-4baa-d656-08de2c2f96b7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 14:33:23.8752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgcaAbEarULoSrZ3WA/qTC+6uW9gihONxsk5qCE7ssIz3BuyOaknhxD4Ez6RwzZeIrcO+0WDn5gWksmZ1v3bmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6444

On 25.11.25 13:23, Mauro S wrote:
> Hi all,
> 
> Not sure if I found an obscure corner case or I'm doing something nasty.
> 
> I'm using Xenomai 3.2.8 on an Intel Atom system with Linux 5.4.299.
> Target image and toolchain generated by Yocto.
> 
> Please find attached test case code.
> Program is very simple: the main task starts a bunch of joinable tasks
> that immediately suspend theirselves. After starting tasks, the main
> task resumes all tasks. They do a small sleep and then terminates.
> Terminated tasks are joined by another task, that was launched at the
> beginning of the program execution.
> Subsequently, main task continues to recreate, restart and resume joined
> tasks, on and on, until a CTRL+C is issued.
> 
> What I observe is that, when calling rt_task_resume(), the wrong task is
> resumed.
> Please see the attached log. In this log I'm printing the .handle
> and .thread data in RT_TASK function as hexadecimal.
> At row 19 you can see that Task1 (that has .handle value fc1c9, the same
> of the terminated but not yet joined task 0) has been resumed when the
> rt_task_resume() was called on Task0. Task0 has been terminated its
> execution, but has NOT been joined yet: if I'm not wrong its resources
> should not be usable until join is done (at least this is what I
> understand by documentation). I expect that calling rt_task_resume() on
> a terminated-but-not-yet-joined joinable task should return an error,
> not resume another task. Am I wrong?
> 
> I know that is some of a stressful test: in fact if I call the
> rt_task_resume() only if task is not terminated (checking also the
> executed flag adding "&& TaskList[i].executed == 0" into the if) the
> problem obviously does not happen, but as I said I expect an error
> instead of a wrong resume.
> 
> Launching the attached code, you should be able to reproduce the problem
> on your side. When the test detects a wrong resume, program terminates
> automatically.
> 

Can you rule out data races on the shared TaskList structure? Seems both
your sub-tasks and the main one are accessing it, and that possibly
concurrently and/or unordered. Or does this also trigger in a uni-core
setup?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
