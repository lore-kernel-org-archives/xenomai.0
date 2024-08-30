Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B96192D69
	for <xenomai@lists.linux.dev>; Fri, 30 Aug 2024 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023596; cv=fail; b=C2KkqqKr8UbKLek1M9dwvS6nZ28xY++F+BoUma5eMBCpwFUgfRF5tpMFkGhxoZNDlZlr87m5d8UlonqTG5Lg5oSm/T4WohgRTEvWIwu0KRgeK3F3nR3GxhVy7baqDooWj8+Xse34BHZYljmzWYwCk9ymEBvV5aAdzav1ktYbvYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023596; c=relaxed/simple;
	bh=Dw2fhxEwbogSKrQ/E/vUeHag3H5AXViKrEKjTNzxF10=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I/KAxhO3jovy/8FURM29Y6XwNGYiAq5DtadZHPggg6CrXLd68b2hbET53+Kj3sU38dPU/bquQoSjzW/h6eNxGqPQxTCKqzJkgvYJUxxX61Gg3Nqbidzi8WSRRgkqYCr4RTIF+XnN68rIJQPjx8fUSxX7MWO/2YqHcgu8Iqd5zkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nCVhmTxL; arc=fail smtp.client-ip=40.107.20.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nCVhmTxL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAM+W3U7/2as21hFlP1nuSSlPBuhRTjbgUxH7CwXSRyotRU62fKjjFT1hz+MZnWN/mQpo0uS5gsU2dJoalXLHtzsgdQWCL7GOUEiTGSS+jf+rfMqKriMOVLT/JrEo3kxthE8E/2qLeVV+jmI/izhDgyq+ujGRF7cENFgd/PtYFnYnxkdDSjx45yx8+q/ZrY42TI+zS/n8EtLMlIjxCDZVsvjfEueiS8HQ8ySRAwL9hKaosjxYmCuMAdg0hua5VllCnXjKDVedw2PfRk0dwC34g1qh/gn2UNy86g2Xn1rwFBVFNwsd1+eQKMagAaoUqt5bpDzyVTChCoo/pf11GlJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuowcrDleeaRL5qmtjyE8r5hUhoQFOVZpYvc+ppDvR4=;
 b=J6LFORvpSoYm9oG7FTOSNdvOt//el2slqApih13NhfRtsEFCuOTHY1wyUKcm5I5Ac/HeOTKl/4T1IL4jH1iRUCvOobKdWu3HiwQd1kuA8zqPU7Amt0SEXOO+cGtQ9z/8SgqRTH8spgBeva2bGNq05YqI3Waq1GMO3Z8UnwB9NboUlBXnY2f8QzPK51SuWCtZPd0KcFj2eEAAoWmEyAW3hltc0XfssghWQ/n+54MNk3/77vTuuSZqLP4sS1mZuTD1kqRdzDoF6riNV4c7LoeVg1jGjdwQ6PKTEfDXCK1Sp34naDID7Wjvst7vA9OJUU3GjX15P0bkwmZPXZhmdLn7zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuowcrDleeaRL5qmtjyE8r5hUhoQFOVZpYvc+ppDvR4=;
 b=nCVhmTxLViWgnFtdNrbb22rV3cHNW9UAaOtUi7/nh+zotgxBlXycjihpAMHKH9qoaUzIthbT5JnXHt3RDB2756mGDEih22CEPQKUJCTJeKKv3zGK3SRwwr/8bh/x6qWa8TKuDFFE6Nu0agT2489LJXvjc4u/vUBMGfnXXSIYEOnCXps6i0nELSe0F2fjhxzJGZFB7IQARPOE/d8X+RlHVJRJNXwQ26qgRHGHD0QyBTh+JfDHWXT6cDYS96RTUougiUrnhUrOaTULQg2OCotUDOaT69pZWM8ASLT7Bb2RYMCOJOyg5+y6tZkxQCm2eImljKb3AtkG2fpbIYvLGOw/EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6370.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Fri, 30 Aug
 2024 13:13:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 13:13:09 +0000
Message-ID: <0db954e2-1217-4028-bc04-7111ddbbe68d@siemens.com>
Date: Fri, 30 Aug 2024 15:13:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] testsuite/smokey/posix-mutex: Fix race-condition
To: "Scheler, Fabian" <Fabian.Scheler@siemens.com>, xenomai@lists.linux.dev
References: <20240830111952.26651-1-Fabian.Scheler@siemens.com>
 <4c253f1d-7a32-4113-b016-400cf1f7e045@siemens.com>
 <98e1c485-a314-46c6-bbe8-348870857a9d@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <98e1c485-a314-46c6-bbe8-348870857a9d@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 91624a72-037d-4103-619c-08dcc8f57e51
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkhiSFMxN1NLbWNiRHBLeGFkZVVacDdRekhoTnpUNzJqdlN4dVRyazJLQUFy?=
 =?utf-8?B?b1p2eEdYTnkycEpxSzBPRUhmbmlpbmxhank2SVZvcmlZYkZ3TU1UR1MveS93?=
 =?utf-8?B?L3VPRm10bHp2M01MdmRhY05ZNFZRTTNSeVEyVkNRRTJHYktMRXJ4WndEYTd0?=
 =?utf-8?B?OG9CWjJ0OFAwRVZOUmFSdFl1RXhiMjNWRi8ybGwxaS9mdWxCT2pROXRzN2lj?=
 =?utf-8?B?V21WNGFVS2E1MzZ0UmQ5OVJ4bE1IbXgrSjNXS04zTTI3cXhIcTQyMHpaWHV2?=
 =?utf-8?B?bEVVL09Jb3FVUEhidTk2eFZGbENiR1Y1eUhpbHF5TG1MM2ZpTllLeTJJSGRh?=
 =?utf-8?B?UnFwTGYwT203YnczZEJ4ZUJiK09XaE4yWWlYWjRzemduVFRuVmxQK0RHZi96?=
 =?utf-8?B?QjIyS2JFeTZ0MEdTZW9GVXVPTExxVGJVTStLUVZOUHlTUTVPQmI1KzJscWw0?=
 =?utf-8?B?SXlYNWQ3RmhGNm1RZUU4OGhhYktlNDg0QUVZeWtBYnpYeXdpejFyaDN4aTlD?=
 =?utf-8?B?K2d6UXJaR25ja3FEa3c1YWd1OGlZeXJhRzArM2FVcGtpem4zNjlnQVNVZjM0?=
 =?utf-8?B?ZEE5bC9KS2VQVWRueEtycjlMNC9FM2ZWbnpSbS9yVzdaSzZHLzI3aGNReEM1?=
 =?utf-8?B?UGhEMXhOR01IQmNUS3U4RUthTjBuM3BkaUN0cjhtQVNVL2tsOUFoT3R5MGN0?=
 =?utf-8?B?OWZabnRxSVBiT1F0UFB5MDJRbjkzNjAwUlBzUlYremYzUnJjc0VtN2QyWkFH?=
 =?utf-8?B?azdZU0oxWkI1eFlpK1BPVWdtalJhampaOGRpOGpYUGtHRGNBekpoU0wzc1VH?=
 =?utf-8?B?Q0F3enowVUFiMW9tdEkvcmxiaFFqNnlVandOTzV3ckNKV1hzc3NkdEYzSFBw?=
 =?utf-8?B?S0ZHSjBrZUpIemlmdUhNSmlrV0VDcGw0TXRlWEhwSnJONEtUNEJ3M3RPODFr?=
 =?utf-8?B?Mkx3SlZMc3JsYVdBVVRCOTBWVXd3UkJhZGNoZUU5ZWg2VW1mTG9KMkJFODdE?=
 =?utf-8?B?Q25DcWFnWmIxUXNPRlF0cGhla3JhV2Y1R1AvZVVsbklGRzZWNXo0M2ZicVFH?=
 =?utf-8?B?ZHZMcElLK0Y4dXA4ZkhLMkE3VGVadDJFSnF4WU5CWG1ZalphWnRpaGdGc0h1?=
 =?utf-8?B?eTRwMWc3bjZwRUZUbHhwSmlLclorYzFRMUtWTFp6V1FVdUNhZW0zd1dHQmNY?=
 =?utf-8?B?Z0NRYTdPL2R1VlVzYUZEZjBpRGlYbTJ0T1E0QWtNSXB2aUlPYm5oek9Nd0tv?=
 =?utf-8?B?M2hIUEVxbmNjaEs0UjlwV0x5djRuUFVPb1E3ZkQrQTNDdzJVVk1jUjM1Zmx3?=
 =?utf-8?B?NkpxVlNmbEFsV1ZLZm5uQUl0MktTK2llRlY0MzVha3kraXVVTURWWlMvSy8w?=
 =?utf-8?B?aVVUYytCVTdRVlNtY3J5aDRqVVEwNzdabGRuV0g3UzgvWmo4djU2dTZTaXlH?=
 =?utf-8?B?N1RzY1UvRnFZM0c3U0RVOVhDSVhDbjdMdVBwNFc2d25kaEZnaGx1MjNYemFY?=
 =?utf-8?B?SXg2QStSVnJlT3REWTZvUWVnYld0eTdUWmU1U2IxYVZtTjVISG1ZR1JWYTFC?=
 =?utf-8?B?ZFhIYThlQngzRWNaaEY2Q1hTVVM3RjVjYkh6OENTNzloZDJwZUlhTEI5R0g0?=
 =?utf-8?B?NGM4WW1CdWFHRjRKRGY1Z2o4dHl3Y05LckI0NndEUHdJdGJkNFFtL3QwQTNP?=
 =?utf-8?B?M0VrclFJUlhSSFpyRklUUFV4eHhUeVRTQlJkR0Q3UnNXNHlzbm1ESk83ODQz?=
 =?utf-8?Q?v+pubO2nqjbE5DgRTk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlcrY2NBY2d4T2ZpNjJzUHZSR0cxaGE3VXl5bmZVcloyd2hETEM2SjhtTEUr?=
 =?utf-8?B?RDJjSFRBWWZuK01vZ2pjYW8zbFk2THZvdy80cHduQUNrTE5oVXRPaUtlOEIr?=
 =?utf-8?B?N3lhd2RvaU1lVnNkZ1F6Z0VTYStzVklGQWVQOW9jVTlDa1dQakN3aURxbkUr?=
 =?utf-8?B?blF5bGZYZHEwRDJqM1M0enVUZlRGZnl4REdXYmVDYzlOdmdCbEM5TjlKMkFS?=
 =?utf-8?B?eGV2c2xybDBJSXNOSU02RU96eCtBb0ptZzBZVVlNRm5pU3pScWdQZlVBdDZa?=
 =?utf-8?B?dnJzd1lyTUUxZVp1cG5VVVgwNTZHWTYxRVVLa0plako3SWpyQ0ZGRHdjVWth?=
 =?utf-8?B?cE1pbmgra3E3bUtOZHdMa1Z0ZGJScUM0RlE4Q2E2dHZhQzQybFhpdENuOU1B?=
 =?utf-8?B?NlpJSUVpbWRFMWNVYWMzcmMzeWxRU3A0cFVSNElibDRBdUoxVS9SZHZpcTZP?=
 =?utf-8?B?TTMzV1JtSFZRYkprODRVNGhDMllIdmdleVd0SHMvVVdxbENFYkNlcWQyVTMr?=
 =?utf-8?B?M3ZCK09jWnQyc2pzWm1CZ2x1RmdOY1J2ZGt3WEFBL3NGUWxnSVl4YlJ1SkNJ?=
 =?utf-8?B?WWx1aEI1MnA0TDJTUUVPNXZaMUc0OWpnUlBTQU5VQ2pGai9GbWhveU1YNHN2?=
 =?utf-8?B?VXNUVkZIU3JRNmJocjAwaW5pZzBHeVM5Z0dtdk1NQ3JubkplQWkrSExuSEVE?=
 =?utf-8?B?aDN3MWt1YWRLVHNRL0tpNFlnSUZ1NHZXTkRSK1Z4NjI0eWF2amh5UHdGS3B4?=
 =?utf-8?B?VzQwS25xSVhVMHlJemhybVk1RURMcktZUzZmaUlOQktRTDhCQXZSUXdTNnRl?=
 =?utf-8?B?VldTK0ZEMFhnajlpUkJkVGRWbk1tUk5uQ2Q5czdOOHlSSHJzNGVwdElYMEs1?=
 =?utf-8?B?UE5WNkhFV0E0VmEwM1JVOFcwRVZYeXVNR0VobUZZRWJXYVlqSVBhaEJDUXo5?=
 =?utf-8?B?MGhVRVp6Yk84bmFScy8xbTVuQnpRemZrWlVqbGMvS2o5dkZHNGEyVXZRYk16?=
 =?utf-8?B?MmJxMlN0STdTSEF5eVZlWE92TnRjOGlaQklVQ2tRWUpVbERyLy8vRTc5dloz?=
 =?utf-8?B?MHRZNktqWU1EcFBCR3RZMExRUUVzb25IdHRRY0c5NGpjNXZVSXJYWXkxTVhm?=
 =?utf-8?B?QndOdFpjR1BIT29ST3phMGViMTQ5cGNWVDk0ODVHUHpMY0dMKzF6UXZMUVVM?=
 =?utf-8?B?QmU1RXdUQVdkZTE1SzJLWHFmWVIrM1lLazVpS0FEN25LT3J1L3dhZC9kMjhC?=
 =?utf-8?B?NDJZdW9TeTVBNWUzRTBQQXo2Yy83TWFOZDRsbzFsbVlaWUVXa2I1WkRCMlAy?=
 =?utf-8?B?RUxURlRSN2xldTJlQ0VYMEd5RnR5TFc5dEs0WTRjQzZVVlhhT1pnVFJKbWNJ?=
 =?utf-8?B?VVprV20zc0YydTdPTkFxQUZIWGZtN2ZGTmNOc1czQWJtalJYbnpiRHZSSzNT?=
 =?utf-8?B?TDA4cW9BM2tZYVVlMzBnYjdYVFNxWGExMDZWZ05DWTRZVWxVZzRiRXNjSEp1?=
 =?utf-8?B?Z2pxZ2grcVVRL252eUExYmVKaytuMFVpVURJSm0wZi9nNjg3Tmg2S0dYNzF3?=
 =?utf-8?B?VUF5UFU1ZXQySTNwVjUzZFNjVW5kSlJaRnI0RTB6UnlRbFZsdVdrVmJIUUN3?=
 =?utf-8?B?Y0J5R252N0hPeDBiK1Z1dnRMYW9Scy9sVkdZYzkrRTdjM29yNDlkSUZNbStp?=
 =?utf-8?B?MWx6ZHJZSnJlSHNaNThSS0duRTd6dVpqREtnWnhNNzNFMjJmTHJoanFrVEhh?=
 =?utf-8?B?RDJ5YkpjcFQyaERGVHVYems2L2VkcHR0ZEdwUTgzcHlTQnhtWllCSXpUZFdS?=
 =?utf-8?B?VTRnMGJxdzBGdkVVRXdEMXl5NDdzdG52QW5MNGxRWlpWOFo5TUcrZk05SkJ1?=
 =?utf-8?B?MFlXS2ZtdFhBOG0zcGpkUk5pU0pvQ2d1MFZsZXRQZEpDTngycnJiNUFLUVFX?=
 =?utf-8?B?dHNzTXJEQWNyZXhqTDIyMlQzeGRubzJNVmMxN0hFTkxXYXdCZzFYMWJsemdi?=
 =?utf-8?B?KzhvRitYUElid3VGdEcvRkV1SEozRGZnQ0NwUzNHcXZxN01pN2hDODZHM1Nh?=
 =?utf-8?B?YnF1aHBKaHhobDJrTVcra0VER3NiVXZaUEdTSU9hQ2JpZ2JBbURYdjcyaVNL?=
 =?utf-8?B?T2FiZFBMbHRCb05vYVh1SjNPem12ekJFRFlnTHI4SVUxQzU3RzA0aFMwSXRH?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91624a72-037d-4103-619c-08dcc8f57e51
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 13:13:09.2491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TCWFxlniRo6CLiIsQOx2je4eRjJpqEPA2d5IkVmWtl8NTU6w3aq8r7FF/bKMfi4xgUPdGRY6XG/AVexFeLURaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6370

On 30.08.24 15:11, Scheler, Fabian wrote:
> Am 30.08.2024 um 13:24 schrieb Jan Kiszka:
>> On 30.08.24 13:19, Fabian.Scheler@siemens.com wrote:
>>> From: Fabian Scheler <Fabian.Scheler@siemens.com>
>>>
>>> In the testcase pi_nesting_contend_multicore the thread low may be
>>> unblocked to
>>> early preventing the thread medium from running until the end of the
>>> testcase,
>>> making the testcase fail, as the thread medium is expected to run
>>> before the
>>> thread low exits.
>>>
>>> This is fixed by ensuring that all threads are properly setup within the
>>> init-phase of the testcase, by additional instances of smokey_barrier
>>> used to
>>> signal that a particular thread has been started during the
>>> init-phase of the
>>> testcase.
>>>
>>> Signed-off-by: Fabian Scheler <Fabian.Scheler@siemens.com>
>>> ---
>>>   testsuite/smokey/posix-mutex/posix-mutex.c | 54 ++++++++++++++++++++--
>>>   1 file changed, 50 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/testsuite/smokey/posix-mutex/posix-mutex.c
>>> b/testsuite/smokey/posix-mutex/posix-mutex.c
>>> index 5cca0d2a1..249fc6c06 100644
>>> --- a/testsuite/smokey/posix-mutex/posix-mutex.c
>>> +++ b/testsuite/smokey/posix-mutex/posix-mutex.c
>>> @@ -551,17 +551,20 @@ struct multicore_low_context {
>>>       struct smokey_barrier *locker1_barrier;
>>>       struct smokey_barrier *locker2_barrier;
>>>       struct smokey_barrier *medium_barrier;
>>> +    struct smokey_barrier *ready_barrier;
>>>       int *medium_flag;
>>>   };
>>>     struct multicore_mutex_locker_context {
>>>       pthread_mutex_t *mutex;
>>>       struct smokey_barrier *barrier;
>>> +    struct smokey_barrier *ready_barrier;
>>>   };
>>>     struct multicore_medium_context {
>>>       int *flag;
>>>       struct smokey_barrier *barrier;
>>> +    struct smokey_barrier *ready_barrier;
>>>   };
>>>     static void *pi_nesting_contend_multicore_low(void *arg)
>>> @@ -570,6 +573,8 @@ static void
>>> *pi_nesting_contend_multicore_low(void *arg)
>>>           (struct multicore_low_context *)arg;
>>>       int ret;
>>>   +    smokey_barrier_release(context->ready_barrier);
>>> +
>>>       if (!__T(ret, smokey_barrier_wait(context->low_barrier)))
>>>           return (void *)(long)ret;
>>>   @@ -604,6 +609,8 @@ static void
>>> *pi_nesting_contend_multicore_mutex_locker(void *arg)
>>>           (struct multicore_mutex_locker_context *)arg;
>>>       int ret;
>>>   +    smokey_barrier_release(context->ready_barrier);
>>> +
>>>       if (!__T(ret, smokey_barrier_wait(context->barrier)))
>>>           return (void *)(long)ret;
>>>   @@ -622,6 +629,8 @@ static void
>>> *pi_nesting_contend_multicore_medium(void *arg)
>>>           (struct multicore_medium_context *)arg;
>>>       int ret;
>>>   +    smokey_barrier_release(context->ready_barrier);
>>> +
>>>       if (!__T(ret, smokey_barrier_wait(context->barrier)))
>>>           return (void *)(long)ret;
>>>   @@ -687,9 +696,11 @@ static int
>>> pi_nesting_contend_multicore_getcpu(cpu_set_t *rt_cpus,
>>>   static int pi_nesting_contend_multicore(void)
>>>   {
>>>       struct multicore_mutex_locker_context locker1_args, locker2_args;
>>> -    int cpu, num_cpus, low_medium_cpu, locker1_cpu, locker2_cpu;
>>> -    struct smokey_barrier locker1_barrier, locker2_barrier;
>>> -    struct smokey_barrier low_barrier, medium_barrier;
>>> +    int ret, cpu, num_cpus, low_medium_cpu, locker1_cpu, locker2_cpu;
>>> +    struct smokey_barrier locker1_barrier, locker1_ready_barrier;
>>> +    struct smokey_barrier locker2_barrier, locker2_ready_barrier;
>>> +    struct smokey_barrier medium_barrier, medium_ready_barrier;
>>> +    struct smokey_barrier low_barrier, low_ready_barrier;
>>>       struct multicore_medium_context medium_args;
>>>       pthread_t low, locker1, locker2, medium;
>>>       struct multicore_low_context low_args;
>>> @@ -697,7 +708,6 @@ static int pi_nesting_contend_multicore(void)
>>>       cpu_set_t rt_cpus, online_cpus;
>>>       int medium_flag = 0;
>>>       void *status;
>>> -    int ret;
>>>         /* setup test */
>>>   @@ -718,18 +728,33 @@ static int pi_nesting_contend_multicore(void)
>>>       locker2_cpu = pi_nesting_contend_multicore_getcpu(
>>>           &rt_cpus, &online_cpus, num_cpus, locker1_cpu);
>>>   +    smokey_trace("low_medium_cpu: %d, locker1_cpu: %d,
>>> locker2_cpu: %d\n",
>>> +        low_medium_cpu, locker1_cpu, locker2_cpu);
>>> +
>>>       if (!__T(ret, smokey_barrier_init(&low_barrier)))
>>>           return ret;
>>>   +    if (!__T(ret, smokey_barrier_init(&low_ready_barrier)))
>>> +        return ret;
>>> +
>>>       if (!__T(ret, smokey_barrier_init(&locker1_barrier)))
>>>           return ret;
>>>   +    if (!__T(ret, smokey_barrier_init(&locker1_ready_barrier)))
>>> +        return ret;
>>> +
>>>       if (!__T(ret, smokey_barrier_init(&locker2_barrier)))
>>>           return ret;
>>>   +    if (!__T(ret, smokey_barrier_init(&locker2_ready_barrier)))
>>> +        return ret;
>>> +
>>>       if (!__T(ret, smokey_barrier_init(&medium_barrier)))
>>>           return ret;
>>>   +    if (!__T(ret, smokey_barrier_init(&medium_ready_barrier)))
>>> +        return ret;
>>> +
>>>       ret = do_init_mutex(&mutex1, PTHREAD_MUTEX_NORMAL,
>>>                   PTHREAD_PRIO_INHERIT);
>>>       if (ret)
>>> @@ -746,40 +771,56 @@ static int pi_nesting_contend_multicore(void)
>>>       low_args.locker1_barrier = &locker1_barrier;
>>>       low_args.locker2_barrier = &locker2_barrier;
>>>       low_args.medium_barrier = &medium_barrier;
>>> +    low_args.ready_barrier = &low_ready_barrier;
>>>       low_args.medium_flag = &medium_flag;
>>>         locker1_args.mutex = &mutex1;
>>>       locker1_args.barrier = &locker1_barrier;
>>> +    locker1_args.ready_barrier = &locker1_ready_barrier;
>>>         locker2_args.mutex = &mutex2;
>>>       locker2_args.barrier = &locker2_barrier;
>>> +    locker2_args.ready_barrier = &locker2_ready_barrier;
>>>         medium_args.barrier = &medium_barrier;
>>>       medium_args.flag = &medium_flag;
>>> +    medium_args.ready_barrier = &medium_ready_barrier;
>>>         if (!__T(ret, create_thread(
>>>                     &low, SCHED_FIFO, THREAD_PRIO_LOW, low_medium_cpu,
>>>                     pi_nesting_contend_multicore_low, &low_args)))
>>>           return ret;
>>>   +    if (!__T(ret, smokey_barrier_wait(&low_ready_barrier)))
>>> +        return ret;
>>> +
>>>       if (!__T(ret, create_thread(&locker1, SCHED_FIFO,
>>> THREAD_PRIO_HIGH,
>>>                       locker1_cpu,
>>>                       pi_nesting_contend_multicore_mutex_locker,
>>>                       &locker1_args)))
>>>           return ret;
>>>   +    if (!__T(ret, smokey_barrier_wait(&locker1_ready_barrier)))
>>> +        return ret;
>>> +
>>>       if (!__T(ret, create_thread(&locker2, SCHED_FIFO,
>>> THREAD_PRIO_VERY_HIGH,
>>>                       locker2_cpu,
>>>                       pi_nesting_contend_multicore_mutex_locker,
>>>                       &locker2_args)))
>>>           return ret;
>>>   +    if (!__T(ret, smokey_barrier_wait(&locker2_ready_barrier)))
>>> +        return ret;
>>> +
>>>       if (!__T(ret, create_thread(&medium, SCHED_FIFO,
>>> THREAD_PRIO_MEDIUM,
>>>                       low_medium_cpu,
>>>                       pi_nesting_contend_multicore_medium,
>>>                       &medium_args)))
>>>           return ret;
>>>   +    if (!__T(ret, smokey_barrier_wait(&medium_ready_barrier)))
>>> +        return ret;
>>> +
>>>       /* start test */
>>>         smokey_barrier_release(&low_barrier);
>>> @@ -813,6 +854,11 @@ static int pi_nesting_contend_multicore(void)
>>>       smokey_barrier_destroy(&locker2_barrier);
>>>       smokey_barrier_destroy(&medium_barrier);
>>>   +    smokey_barrier_destroy(&low_ready_barrier);
>>> +    smokey_barrier_destroy(&locker1_ready_barrier);
>>> +    smokey_barrier_destroy(&locker2_ready_barrier);
>>> +    smokey_barrier_destroy(&medium_ready_barrier);
>>> +
>>>       if (!__T(ret, pthread_mutex_destroy(&mutex1)))
>>>           return ret;
>>>       if (!__T(ret, pthread_mutex_destroy(&mutex2)))
>>
>> This was seen at least once in
>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/890675
>>
>> Were you able to enforce this issue locally (artificial delay etc) and
>> then validate the this patch?
> 
> Yes, I was able to reproduce this via qemu and was also able to validate
> the patch via qemu.
> 

Perfect.

Applied to next, thanks.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

