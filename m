Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2084.outbound.protection.outlook.com [40.107.249.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1654153800
	for <xenomai@lists.linux.dev>; Tue, 23 Jul 2024 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743639; cv=fail; b=MeZhUWU0E/7y8gAV8xPyGI6yR+S9T00EwGXJziU/N3MHZy6ogMMlYHaNYA1lYl3M/L3TM7OAlzGdc6SpuV0qrbaDyJYdAfqm4ibraxDLY0H00l3fvNgMxpOn5Uirw1ypsyB48verPZ/Vis5Rmkz4kU7SBQ29UXZz8fiSS8lN+cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743639; c=relaxed/simple;
	bh=JrMM1LGy/BOmpmSwBhzfaplyPtXvBHZQ4A5r9rYLD0g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sK2Q5oSgYq9EZvPX7IsnlUkjfaMmNV9S+LZFBd1ceAo0nvwCCN6B6h6nSBl5LGE2/fhsz7a79TyuOiUb3jMwPjj82XbZr8q4ews2wf1I+I7ZmIqhck7lRWzHr6EtMf373EvsCDNHwqC3AgXY0zGO2Jsuw3DrJwhhP79MccflX88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Ki6OhbQ4; arc=fail smtp.client-ip=40.107.249.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Ki6OhbQ4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDc09SmHHpJg/La3fh5yl9gYBvQhlNyX0EURyPXIWxhJ/sKlQuDCWF/+L0MBNCkGwy97xu23os+juGHSk72woR3xMW02CE64WApwIOdnMybAezYzlZHlS2N0fMJCwOWUCaDpgE0Co4+UWwq6rcvqh6atb4mt2ktM1cHJna36HUmWXYuWkKDE/55TFH2pSrh9D6VduRBYnyDhjalzpEHgNaMSvFestjMIsArwl9/FYqd21LpwEhQCrp4gUGvsmYeD5LYA3OdYaYqOe/hdkQSCFTNE+vkPa+veXsqagxDSd0MsuYZoA4nMROieyzDGEMDra6llLr7+B+actLlhIEkZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiYu1ElL5aYuddjNyq5HrSAYCGPzFnPVwNrOVHHhIco=;
 b=jlugny8HxCPAynWZjZzt6LBLjOdQWHT8pcgixtV57tO7ngVuZEg72wrL6L27eoTfJlZimju723TB1dBipq/BQH/ipuO9WfUQ2/Jz3alXCcOOcKFXzuIRv+uGn+kxnkI0/R2bVwCNwIA/AA4Myffurl57NEACXz6zwXcJMF9spXlE3rKvMbg7VApgfm+FJgq2ZsMC56fOUSY2nih6+c5AeFSz1Q5hm3gUyByTiKNWzAXNNMNuqEUnhHlUV7q3t0qUh9gdGEDLx7MMmVidIejO72f/9QfufpQrAI6iR+O2VBIpini0hhzIqvRS3g/p7lf2uGW5yYd6sO2jFsckFjK3jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiYu1ElL5aYuddjNyq5HrSAYCGPzFnPVwNrOVHHhIco=;
 b=Ki6OhbQ404thCKHYOxvuZnhvp5ctvAcwie+12H6zoJQD727cBNLwnbdcXXli+vJ0nk2OcqMPbk3oaUMtldDfL4hnMnt38y5d05FRGFEwnNlajFJkrFOuHsFmfFLX5ra9bzZXGrg2DD+14TQHPeG5LQiUUB5R085AG7xr74mxkCkYZZMwxg8A6Ek7H3YM4hsDjedvVOYGuecFkHJXjjgewdqT289+1KyMBLndSdRcclnzOnXhRtAcE9is0bZvQbg0cbmAh/d9S30qvXOidvJm2P2MlP+dg2A4E5100ZS7bMzJApMZeJzjMFHdpnTkQcJEX1Wp2sSRcEDeLBbdIiAwNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by PA4PR10MB5514.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 23 Jul
 2024 14:07:13 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7762.027; Tue, 23 Jul 2024
 14:07:12 +0000
Message-ID: <d75355f9-f485-44cb-a228-378e5e3e5457@siemens.com>
Date: Tue, 23 Jul 2024 16:07:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [xenomai-images] ci: Enable sstate caching
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com
References: <20240722111114.1080113-1-tobias.schaffner@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <20240722111114.1080113-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0330.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::8) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|PA4PR10MB5514:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a529aa-cda4-44b5-8d31-08dcab20bf82
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWJ3dzk0ZktNT0JvamxaVzlPaU5QS25lZC9SUUJ2WEVDYVRlNDQyVkJrY1RJ?=
 =?utf-8?B?WjJ0ZCt6YlVRb0JNclFUdWVvOFdxMVVMYVZIL1lzVWs0b2hSaUdwRE1oZGcy?=
 =?utf-8?B?QnJ6bGhhM0RUYnZqbHEvcXpqN2k2dGVBd1puYmI0U3M5ZkpDenRvVzdaaUsv?=
 =?utf-8?B?NnlrYk9FOTFBMlYwTzdvbHFsOTQ1UTc5WU10aC9mcHNVV21xOFM5REZTeGlt?=
 =?utf-8?B?dlBZaHd1SWdxOHZyUEpXOXZYSDhzWllqY0NXRmZYazB0TXhSbXptUGZWUnRB?=
 =?utf-8?B?bFFGQlp6ZngyVDVXa1Z2Mk9YTlIzZG9XK0ZMWWluWk5lc2s2NENEbDBQNlRQ?=
 =?utf-8?B?MUFreXZGTldJajY3SmhiTTNydVZFWEdrMjlCdHhuNmZkSGorczFqMWhGcklF?=
 =?utf-8?B?eU9Jbi9PTm16K25RaTMxaWl6Mk5CblFBbC9lWk9zTHUySU5jSDYvRVVqQnhu?=
 =?utf-8?B?T09LVXlxMUlUTCtxQXFyK0wrSlJNMUhTS3lRMUs0cHVGMStJbHIyTEF6NGNG?=
 =?utf-8?B?aUlCdkN6dWN4cGJRVFhteEZxZnMxMjFyUzJnVWx1dTIrSWNYdEVDN3JxME5s?=
 =?utf-8?B?TU1LL0JBSE1LRWhmazR1Q3BxS2VCY3hpWWZ3MFV4ZUZrQ1ppU214WW9nblhV?=
 =?utf-8?B?bm5VTVo3UmMyeTQvTUlDZVpXZjhqYU9xK0NFcDE0UStrOXVHTm9vczZvcjJQ?=
 =?utf-8?B?K2lhbUF2RmdRU3UrY0ttUm1scFJSZllxSmdVaWZBVHlWSkJtVXI1MjRCVkE4?=
 =?utf-8?B?dTdkN3Q1cnp4UWNoSkc0ZzZWWG04bHVjNWc5anAya0JzS1VtYlhWWFp3TlJp?=
 =?utf-8?B?NVhzVm1TSGkyb0V1R0xXcWFNTndkYk9KY3hPcWZNYkFsKzI0Rm9ua3lGZ2Nn?=
 =?utf-8?B?OWRRSkMyVG1OZFBQRTE0VzI5Qjc3U0ExdXlnbEhlYXA2Y3pVV1NQZWV5ckpM?=
 =?utf-8?B?dDBmMDVpUGZwbTJ6THJ1MmJRRDRPU1dkdzJJZEZDMEJiUTJlN2QyZm1nS2Qr?=
 =?utf-8?B?R2hRZkxOREg0YkVrdlVXSE9yT2NuSnhWeW8vZ0NCWmVLZlVpVWRtTFZSRGlR?=
 =?utf-8?B?UTgvZ1FaRFRzMjdsSURGMFV4ODdReHA2WThVekFLU01QUCszV1doTkY2Z2Nu?=
 =?utf-8?B?aTJGa3BTS1I5aXBuOGNucjJaaStCbnVleTdpSGtpSVlkT0FORXpNOWt2bHlt?=
 =?utf-8?B?bHJJenRtSmI2MU52aGVLcnppR2FFR0dGeTRTKzB2OXJZcGhUY21Pb0tmREFo?=
 =?utf-8?B?ZUROM2p3S01GRXBXZ1JjSkhaL0ZqNGRsNmNYQ3VDeUVuckVvWmloaGMyaWxi?=
 =?utf-8?B?RzNzWTcxK1NZdTdKdHZ5Mk01RHFmR1czTkxXQmN3WUUyMDF5RG04YlFUSlRz?=
 =?utf-8?B?NjRiNGRXTThhVXBoYmlvQ2pYMzczZThNcmg0VUpNdkROYk9ZZzVadVFNK00x?=
 =?utf-8?B?VG1TSlE4TmZHTFM1Q25xN3hQL2dGWmVkUkRZU1J0L3dhRzFvY0VCOXlQcHIv?=
 =?utf-8?B?NFYzWVZlMDBqODdoK1ZUSUpMRTh0SU1VM2pyYnJ5NUlxRTBXdys3eTh4Q1hG?=
 =?utf-8?B?MXpmeHdCa1FQOC9GQWRPUWNBS3Q4b0NVWktkeGt3ZVhZNGw5Mnd0M3BKdkFk?=
 =?utf-8?B?dGluUndlbEZ3S1VSS3dXY1VZNElsM0pQeUNyOEhJUEJXVlVBbytBV3RNT1pM?=
 =?utf-8?B?d1pWTUtZMERxSWFHR2lUN1d3YUVJQlhWUUxWVnNoMjdIbW1pMXd1VnRRS052?=
 =?utf-8?Q?TiEyLTJoZEclkV7oIA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2g1Ym41NnhDVFJZbGtuazZ0SkNDWW04d1dSV0V1VjVXMFduWjFCa3hpT2Ez?=
 =?utf-8?B?aTRtbmp0ZVUxZkFvZi9XY3psVTF1YU52WERpQVNpQk53WklXTEozVzZFalRv?=
 =?utf-8?B?eWxGUkR3UkRXZmQ0VzJwM09IdXRFazZIRnQxbDhKNHFkbWpKUTJ4ZzkvcDN2?=
 =?utf-8?B?blNCWFZBT2U1TFBHcFBQK0tyQng1SmFTR1BEejY2dXlhQjBrSW0vS0pvaUFu?=
 =?utf-8?B?aTR1djdSc2R1K0xSdWh0RmNBT2NEL0swT1pCOUhTYi9EejJ0ZVJkeXZCL0JJ?=
 =?utf-8?B?SWNSdXVrWmhiQ1ptV1NVYlRPVmZOcWVUWEt0OVNTN0lNSS9QUlA0MHVISTRF?=
 =?utf-8?B?UFlkOHp0SmtVUlVtR01RTTlabFk0eGxhdUcyUURWZVFTenNDSW96UzlzZTJi?=
 =?utf-8?B?RFhqMzduQTI5NjNOSlQ5N0V1QTg1U1ZqSkVkeElIQ1Y5em5TY0RDUDBkUS9k?=
 =?utf-8?B?MW1jMy82NktFYmJkd28wTjh2UUJEOU9PL2E2Y2htUkdjV1JLcFE0Wi9pbXFt?=
 =?utf-8?B?NzcrOGVDdDZVU2p2dG1WTTdhKy84NGZadVBTSzBNUnFpc1lWRmM1dmNIN0N4?=
 =?utf-8?B?VmUyRFJlYis5NjlTVitVUVN3a2lMU2E5WlZ0ZHlkZjFxZGxXNnB2eW5qdWpR?=
 =?utf-8?B?UG1LYllvZzJGcmZ5UGNDK0s0KzhkTUtxYjllcmVES2tLNjhGK045c29KWnp5?=
 =?utf-8?B?Z3h6S3pzSXNkSTRGcmRVNDBGd2lHcG8xSFVRTTJzaDVxS3J0L1U1dDk2Q3ZU?=
 =?utf-8?B?bzVxQ1FhMmVZdlpiY245ekI0UUFmczh6djRZUzRwMnBOYTJHdG9FN0g5VGlL?=
 =?utf-8?B?UEhiekNpN1o1ako0bk5kUytiVm5IU1d6K3RsRjNpNUMvdk5USUw3T1Q5bGRK?=
 =?utf-8?B?RGNlQzhUa2gzekt6Y2NwM0RnbzkzL09GMGs1N1E0M3hqS21qQmJCdE5vT0xz?=
 =?utf-8?B?UG43VU93dC80RTk0OE9ndFlEL0xtelpSalpyNmZqOUlZcjhTY0JISjVRT1U5?=
 =?utf-8?B?VlRqU3MwbHpZeHVLQUtZQUdXSHdUd0UrR0M3V3NXODRTMmtXa1Rpa3hBcFVp?=
 =?utf-8?B?VjkrdytmZDUwdlVlcWJubWlBQnVqSVdFL0RNRkxHT3VacHFJMjhTWnhNdmJB?=
 =?utf-8?B?SFhSOFhFOHVpVUxhbm1GUXZuTG9KWDI5QllxNDE1dXdKWDJMNmJXMlJkYUtD?=
 =?utf-8?B?WnlTUDJ6ZDZXMmdCT00xQTA5ZTRnTTN4Y1h6WGhiemhQemJOd3JnRXI1MFRP?=
 =?utf-8?B?QXBTdDQ1Y1hGOGY3OUo3M2t2bmdQR1NBV1l2UEhQMG5Udi94YzM1MjNjb2h6?=
 =?utf-8?B?MlpIbEpqLzdhbFNJQVlmZFV2TkE5N2FmMjUyZnkyNDRsSUFkUUVBQjVZWkVB?=
 =?utf-8?B?MXo5c0NtYURWVnhrMlR5ZWgvRVpKUmErWFQya1ZEMisvQ2xZYk9RM0NHS09x?=
 =?utf-8?B?ZGQzcmt6TDgzM1Z4WWk1QkpSSkVGVksxMGpKbnkrSjdkS1dEWHZ5OHhRMWVW?=
 =?utf-8?B?RHJCemRsamFsY1E1dTVqenBsVE9uL3p2RGRCaG1ZNEErOTVHNURZSW9uOXFK?=
 =?utf-8?B?S3VyYkhMTFN1ZGdLWXZiOXFhcFM3WVhkeTJyQ2h6bTZUNE10L1NYTXFhQjRo?=
 =?utf-8?B?clVDRjhkS3hrQ0dPTFBXTWM1TUoxb2UxeUZIS0doQWFQUXNEZEZzRFJqQW80?=
 =?utf-8?B?QkRESjhZd0RtbVVTNVJqSmpJUTFCRHRQNkg1bjBWaE1pbXpqS0dSOHVEeElu?=
 =?utf-8?B?WDlNK1YvemZjRHFvbXRYYktVV0tvTWp1S3hKOEZFckN6emgwRXFFTGxaNGRj?=
 =?utf-8?B?dmwzSEhNY1dtZnNHRSt4NnF5RVJsc2FvalVTQm5kajVBdmF2aDMxVlg2dTNk?=
 =?utf-8?B?Z3lSR212UlMyUUQrb08vVmcxYUVMWkdqQXRsQnhyUTVTTjFoRDhTK2s3SGx1?=
 =?utf-8?B?SFhSVDBaSjNWd2NVYlBtZUMrVWFLY3E2dDBiQlh4Nk1nTEJ1bTlSWGxqOVdv?=
 =?utf-8?B?Z1BpQVpjKzNhbi9yQTd0S2M1N0dVQjlCaHgvditpTGFGV3QyM0hmWXl4ZWh5?=
 =?utf-8?B?ZzRnbndRWE5DeHppa2xsQXAycHRUd3o3a0RjSG9MMnlvSnhNcmpUWVY2aDN6?=
 =?utf-8?B?cktSWUJrVEhOSTA4VjJGeDdKOFV2a1laSm5kVmdFL1RyeFJhUU9raGZuNk0x?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a529aa-cda4-44b5-8d31-08dcab20bf82
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 14:07:12.1538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I09TFLc5KrcBj3rXP0QWNpWDrDhjLcmIycbb2GmnznxVx/EiNwsqI8KD7et68hcYkp+DnLiB+J8zacFKP7ntnr8JowdcZ0JNAdWg7jPwOs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5514

On 22.07.24 13:11, Tobias Schaffner wrote:
> Enable isar sstate caching to an aws s3 bucket by using the
> SSTATE_MIRRORS environment variable.
> 
> The isar-sstate script is used to upload, analyze and clean the remote
> sstate cache on every build.
> 
> Cached artifacts will be cleaned every 14 days. This can be overwritten
> by setting SSTATE_MAX_AGE.
> 
> Credentials have to be injected using the AWS_ACCESS_KEY_ID and
> AWS_SECRET_ACCESS_KEY environment variables. This is already done for
> download caching.
> 
> Currently the size of the cache is ~20G in size but I expect this to
> rise to a multiple as soon as this is used in productive environment.
> Keep an eye on the output of isar-sstate info.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>   ci/gitlab-ci-base.yml | 47 ++++++++++++++++++++++++++++++++++++-------
>   kas.yml               |  2 ++
>   2 files changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
> index 1dc05a8..f5009e3 100644
> --- a/ci/gitlab-ci-base.yml
> +++ b/ci/gitlab-ci-base.yml
> @@ -24,12 +24,39 @@ variables:
>     TEST_RUNTIME_SECONDS: 300
>     TEST_MAXIMUM_LATENCY: 0
>     TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
> +  SSTATE_LOCATION: "s3://xenomai-images-artifacts/sstate"
> +  SSTATE_MIRRORS: "file://.* ${SSTATE_LOCATION}/PATH;downloadfilename=PATH"
> +  SSTATE_MAX_AGE: 14d
>   
>   default:
>     image: ghcr.io/siemens/kas/kas-isar:4.4
>   
> +.sstate-prepare:
> +  script:
> +    - kas checkout kas.yml
> +    - echo "=== Prepare for sstate at ${SSTATE_LOCATION} ==="
> +    - ./isar/scripts/isar-sstate clean "${SSTATE_LOCATION}" --max-age "${SSTATE_MAX_AGE}"
> +    - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
> +
> +.sstate-analyze:
> +  script:
> +    - echo "=== Analyze sstate differences with remote ${SSTATE_LOCATION} ==="
> +    - ./isar/scripts/isar-sstate analyze "build/sstate-cache" "${SSTATE_LOCATION}"
> +    - echo "=== Check for cacheability issues in build/sstate-cache ==="
> +    - ./isar/scripts/isar-sstate lint "build/sstate-cache"
> +          --sources-dir "${CI_PROJECT_DIR}"
> +          --build-dir   "${CI_PROJECT_DIR}/build"
> +          --pedantic
> +          --exit-code 0
> +
> +.sstate-upload:
> +  script:
> +    - echo "=== Upload sstate artifacts to ${SSTATE_LOCATION} ==="
> +    - ./isar/scripts/isar-sstate upload "build/sstate-cache" "${SSTATE_LOCATION}"
> +    - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
> +
>   .common-config:
> -  before_script:
> +  script:
>       - if [ -n "$ALT_DNS_SERVER" ]; then
>             sudo sh -c "echo 'nameserver $ALT_DNS_SERVER' > /etc/resolv.conf";
>         fi
> @@ -40,17 +67,22 @@ default:
>         fi
>   
>   .build:
> -  extends: .common-config
>     stage: build
> +  before_script:
> +    - !reference [.common-config, script]
> +    - !reference [.sstate-prepare, script]
>     script:
>       - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml"
>       - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml
> -    - du -sh build/downloads/deb build/downloads/git build/downloads
> +    - du -ah -d1 build/downloads
>       - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
> +  after_script:
> +    - !reference [.sstate-analyze, script]
> +    - !reference [.sstate-upload, script]
>     cache:
> -    key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
> -    paths:
> -      - build/downloads
> +    - key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
> +      paths:
> +        - build/downloads
>   
>   .build-qemu:
>     extends: .build
> @@ -59,8 +91,9 @@ default:
>       - if: '$ALL_QEMU_JOBS == "true"'
>   
>   .test:
> -  extends: .common-config
>     stage: test
> +  before_script:
> +    - !reference [.common-config, script]
>     script:
>       - scripts/install-lavacli.sh
>       - scripts/run-lava-tests.sh ${TARGET}
> diff --git a/kas.yml b/kas.yml
> index c0cce41..8bfea21 100644
> --- a/kas.yml
> +++ b/kas.yml
> @@ -42,3 +42,5 @@ local_conf_header:
>   
>   env:
>     DISTRO_APT_PREMIRRORS: ""
> +  AWS_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID}
> +  AWS_SECRET_ACCESS_KEY: ${AWS_SECRET_ACCESS_KEY}

I will send a v2 that moves the AWS env variables to opt-ci.yml.

While using the environment variables works for now I will send a patch 
to the kas mailing list that addresses correct handling of the 
environment variables by creating an aws credential file.
