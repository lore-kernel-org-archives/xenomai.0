Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D99C3D5244
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778565073; cv=fail; b=F5037SBY59W/TpXL3i5MUrAImUp+vbvCytx+g+424k4Xc6vWJMftVd+N19r6SRVAh1DnJUINWpsxAwj4AgESQR1vfE6ZhQ+d2O4hmzd2oH2PAiBMInZNwb72zIv57UkZSTofYHPUVRKw4LsAw/AZRlxDOgyRMiW4KwschQmKwxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778565073; c=relaxed/simple;
	bh=S/L/IdRnWZVOwoJ9rBXmNNOxLlJhdapzyvTvHfPG1/w=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ezcD6DRUeRBaKF0PPlhBMPh5PvaYxPBYRBSCFkGtkrPpE4gezcTfHw7H5zZiBXfePla4DAS2PO0YN56WB13jRsnS1eYhSL7YdFmRGnSghivmljbbZ4gbCAu5Na4KU6QmLuvniv4wtIJp0A+cGSbJjW1IR1tMNkgKvPnh/3GqFTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZqWFU3/g; arc=fail smtp.client-ip=52.101.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZqWFU3/g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qG+pNkrZbFwJZA98OVhA3zLE504Kwl2V59/dMnYYKGW7kAcFr9/GYO8OYinXV1e49ykhpYd6Ng7tlCQAz/nHQWEGBPvGmbd2X0HFM6eHLCpdTVextkHKlVsBftOjkr3xif3KD0aTT2XkTjyiJDg4yr6Pk6XIrQLdUNKVXleXQFEpp7pZFLKh261qsEdjiNXtINpcYUHSfxTv4JwbWmDd4CXBz+wDW+Eg3CmQuJ/96iQr35JfQqR59hRddWCN+RT3TPyGAWhK5ap97OBZRFxR1SNW+Ebexym7dU/2lKXBZkCxbXVIezgiXC1p/OnpcE8TFGWSafnTZha1wxa/oOS+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieUMTu3Xlpw9pxGDZADJUK6bJUN0EZYWEYW3cKEh8Ck=;
 b=IKeJhpS2QZYE1g+F9v02tXqnzjl2KfiViahsFc1/Kz8dMD21WQ2Mfl/wZj3Bo21v2en7yP/LVFxMI51FL+PciRMZjaVJp9OjrkOdwD8DLe/E6gXr5R6NV9niSUcT7ftVeFNrMAVZYjPIgeycS3g/uovxsxnxME6v6FKqjH7h4kXodFHbJoS5n7FhQhmAm690oJ8a+zI/D2YdJHBj6o1yEy9C0rRYzyUM1yyd95KgrnBpCaYUJky6h26BLWNptcvfdT9/3UHfsVc5EkWR/MDdHeh48fsHm7ENrAOHRfc+wVNwn9qYiEM2O9E3eNt+7kkNwrMIz2+CwpAyJ8fP+t+FpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieUMTu3Xlpw9pxGDZADJUK6bJUN0EZYWEYW3cKEh8Ck=;
 b=ZqWFU3/gapjh3Sj64GdaL8VGVgyUKs+oUayHEHEiDGE4W/6HZ0UD592TYFTXhZU11fxIwGucppEla8MXBd7/+vOagDiIfjB7+RVyR2Z8r3ra6wugCwJ9K1stleg2/XhHGTLswVwqQvMxHAxlc9iUHsDEo40nTgP94CFOY6W+1RSMRSy31tkUfk5YkJpLy751eP5mvUYNBBhRSp3goPJGQ4C3FOW25rfN59Y3D/Fqp5qRfxjHVrVxe6umEWE3Uiz/Ae9Cz2AsKywUSX6JPb/xBADLzNpXbQmHVcYKAXH6FJOxL6ib+rlEWHNcooV9qho73lRP3SQ1lnvgw18Spt8VzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3813.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 05:50:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 05:50:50 +0000
Message-ID: <411e79a0-cabf-4d86-bed0-12e0b9546c1f@siemens.com>
Date: Tue, 12 May 2026 07:50:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Spurious task resume due to SIGSHADOW
To: Richard Weinberger <richard.weinberger@gmail.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <CAFLxGvw_cRpJbBKg2YG9_oi5Bv_DU39OB41nPyJcq7hv7hK6YQ@mail.gmail.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvw_cRpJbBKg2YG9_oi5Bv_DU39OB41nPyJcq7hv7hK6YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3813:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c34a45-3c75-41cb-9f8b-08deafea6be6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XxSbYnzdD5vICK+nZKG+o929BECiyDKumPCgDsX74ZJ7hcKbNzpov2TIs98mjzYzmpdQsUWQF2EJlWrow/kPNkq4wke8/f4ufbTkQ06LUn9ompd9GL16Kt1T9CH+m4ILovFOJP9HrTgUpNAR4frKqgShQ+2lhLJjSkX7Pc74X0c+zFyDpkA+FSmAIJWJiEblRrHL0/3c2PH04pHFtdUv70ufhZNuqjY3Uz8zL/fLHo0Z8XIAh62QB+WN6p3gBP4+ezqauP7xrGNlEJx9lR7vuL9evkC8OeE5ox5uJacRiiBVO4/nZLuUB2QZR20BRDh61Kp5y7eqd6jFbM7fSUCeMcTB848Cj2+sJFNYLdOssJYZIpu4vvwGEJf/XObRx5n7JDFloL5+37UlgDS/usZwzBlQCXwXqdND7ahG5Dt/U69vtxzVQD/VD4vl0P61RYlN9ROX69pDqWH6gQllaOnd96nKu3sqoI0PfNMY6hMeVlsybbQRJZM0XphBzKKNwWHRk/UzZY6RwAM/5lbiJuNlFOjbjVsNmg7xIWJH5Ni2RS9qUcKvwZDwsEMUvp9ra72iZt9/Pz3ivcrK1Exnpky2FUasn67AMDy/wGQrLuxNjToYpcDICG3julrxzt6uSV1lJ5dQukAXxIYEQfjFX1fEHbWYBaG53dIdfbmuaoIyYa/61W+k5V9vl2lGLeFkj7eb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(56012099003)(11063799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUM3L3JKZ1hHcVdWcTE5VlZnVjV2ZzF6a0UyR2c5MzBDa3UzWWRlMW9GSlA0?=
 =?utf-8?B?R0lRWnRUS1Yxd2RsQ2QxTzl5RXVwNHA2Vk5SaEYyRHpUNDd3TkJxZ2txUXVZ?=
 =?utf-8?B?a0xlRkVTNkFlTUtNVFRrMytVQ0dpWFNwcFArbU9vK2Z0NkMxRElSMDVyVkpG?=
 =?utf-8?B?MXRtL3NXSlc1ZlMrVndqMk1tdVVWQmRxR0RTTkVud0xFYmFDaSs0UjQ1eVd3?=
 =?utf-8?B?UGpIUmhWVVlaQVRVeEEzMXF3K2FkbHpSK29VRkNDaWJ1dkFlaGYzb1VlUllr?=
 =?utf-8?B?UlplaUpiMVI4TWdsTGkxVmFWeXRnczBRdFV5dFYvTXRvcE03R0RwSDFWZys0?=
 =?utf-8?B?UEVBUS90L05FT0JiVklENXAwUEFhSjI2QXJPQVFSM2ROaThtU2tXTlZZeDVu?=
 =?utf-8?B?NVpqM1pMaWhNcG5oeUR5cGJLVXRqS1M0R0EvTUxaeE5kbzlmRTlEQUJoQVBa?=
 =?utf-8?B?ZHNtNkpEekFOeDZvdktBS3NPMCtzY21Sdy9kSEJmam5Sa01pd3hRWktLT0VY?=
 =?utf-8?B?UTBRYjAxaEt3V3djdWVvbVZhclNyLzZZMDBSTm5zK0dzVTg4U3NMaVNBYW1X?=
 =?utf-8?B?UGE2NGVEMCt3VXV6L3l2cVAvRlRSYzh6U2Q4YzZ4VW1yZXdUYmtGTEErK2NS?=
 =?utf-8?B?WXZWQTR2LzNTTTRsenVYVzE1TFp5Nzk0azQxc05jUGtLS0JmdmxabkNPMzIz?=
 =?utf-8?B?Z3VsZXozWmVDNmNDUkpsV2pPclNyeXdIbGZ2eVFQcERCVTJPSmczTVhUNFBR?=
 =?utf-8?B?bmpoSHl6NXdXakYwSmNMTU5mOUpXRU1NYXZkb29XYlAzK1lXUnlFRzRlZWNw?=
 =?utf-8?B?QzVzNGVTMFJodmZXSXZhODdRZU1hZjM1Sldxd1B0Sjh3V294dnNlWXhqWlRy?=
 =?utf-8?B?a3NRZWNWUGljd3FpSkZnVVAvZjNydnYwM0JpaGZkQ0NIVjV1WU93TTVETWo4?=
 =?utf-8?B?MUNJSUZkMjNic1RoNDNBMEo0NGNlcnR0WXFOcjUrcVl1dUdsd1UyVGN2aEpL?=
 =?utf-8?B?SFBpS2J6Q1VWSytVM0c0dzhnK0NLdGhhOS9ZWUhLVDZ1OW5wZGlqSWxNZmZt?=
 =?utf-8?B?Zjdsck02MHEwdURMaWlPWnBhaENjK1ZQcG1yZGp6NzNlRk9hczUvRUd4Z1B1?=
 =?utf-8?B?S25zRVpvd3A0aENaa3pSem5ISytXQ0pBTFltVDkzMVpvWFovT2hMM3N4OTNV?=
 =?utf-8?B?MnZMU1JJVmFUbFpMdmVwakxvR0ZtYUwrRUZqOUtHcWdDZG9rSnZaczlSZGFh?=
 =?utf-8?B?MVI2ajBkemkxT21ESWI5YW52ZU5YZ2pXb3doeFRlRnYrVkR5R2dPM3RsdVFu?=
 =?utf-8?B?czBDZy84ZEtGei9lSFBlSFhwcmwvZ2dQSWVFM3RtM1JjSmxzT1lqTlB4UjVr?=
 =?utf-8?B?YjluTllNZlVsOHlPNTllZTlwK1hSYWRqaE5XK1JLd0FDR1NrL3FUMkphTGFr?=
 =?utf-8?B?K3hMMGt5L3hpY1dhYlNpWGE2NUR4Zjhqd2NjcEw3RllscHVsNnNmRDJFd2Nk?=
 =?utf-8?B?d2ZOY0NCVkZOMFJPMXBWSERIN0pyOFhzOTE0Nk1LZDNCY213dm5kUEhiVFc4?=
 =?utf-8?B?MWI0UHFDVHc4Sm1jdDViYk1PSnZvRHJoKy8yN1FjaVppU29IOGdPdmlGQ3Zi?=
 =?utf-8?B?SDZ1WUprdXNGRHlORUZZUkU4dzZ1NEY3cmU4Mnp2YzBJa1B0Q1BEMHdJblZr?=
 =?utf-8?B?T2lnL05LN25DY2dFeDZsWUNBL3h3QjBSZit5SFFrcHlYdHhvNDlxLzUvaUw1?=
 =?utf-8?B?RmxQNHlBT3J3eDkyR3VVaFozQ0ttczdNVnJpMHN2YlRkMVZjTzlBWXE1YzNF?=
 =?utf-8?B?TlBucjFCOE84djUyTVNWVW5MTVhMWUlPNnl1K000b3orRGN2U0U2WithWnNZ?=
 =?utf-8?B?VWlvMTF1dmtHeFZlNUUzc0tOYVNvcUEzZGdTNVlISE9INjBmYlBkOWJWb1R5?=
 =?utf-8?B?a2NVdnJ4SFFIZ2dSVUUxM08zQk01YjNvbzZvSlRWR2xJZ1l0Y3FWNWw2RjNn?=
 =?utf-8?B?WmNjb3MwNTN0SGtiVFA3S0pDajlKNkpYYTV1Uk1XV3JWdDNwMGtnL1NBODBZ?=
 =?utf-8?B?Ung2TkJ4ZEJ5V3ZaMFRERVhUc1VoYzVyeXJQY3VlUWR2b1pPYkxQUzNJMUdN?=
 =?utf-8?B?bmREK0VTQmY3Nm10UkU3MnEzbktqbVAzWGI0SFNWSUxqTTdnUXpKN1JSMExB?=
 =?utf-8?B?bjdZOC9YSE5IckE5RDVOaEI1enQzeFBTUFRYZGljYkpHMGZYUHhaeE40dldh?=
 =?utf-8?B?ZTdQaE9Bb0tZaThXQm94NURHd0dGd3d2dTVLcVBtKzFhNko3MVNqUEU4V0xm?=
 =?utf-8?B?RDhYVngwQ29MV1l0N1dSYUxLOXQ1U1h1VEFQZnlFeDhoL3ViNUc2UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c34a45-3c75-41cb-9f8b-08deafea6be6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 05:50:50.2701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXaod6bIAyI6IX1leq3U+fZcZNobpijHe+osASqziQASKhfpcLlXlxL0N4qKF8I6ucITG4rhB8BB7BKtULtFcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3813

On 11.05.26 23:49, Richard Weinberger wrote:
> I'm currently debugging an issue on a very old Xenomai system, while
> reading the source I noticed that the very same issue could also exist
> on recent Xenomai releases.
> 
> What I see is the following:
> - A task gets suspended and unblocked using rt_task_suspend() and
> rt_task_unblock()

This is intentionally rt_task_unblock instead of rt_task_resume?

Because:

"A nesting count is maintained so that rt_task_suspend() and
rt_task_resume() must be used in pairs."

> - In some cases it happens that the task resumes to execute
> - It resumes because a Linux signal is pending, being SIGSHADOW
> 
> Since SIGSHADOW is internally used to suspend a task, this alerted me.
> So, I suspect the following issue:
> When xnthread_suspend() fires SIGSHADOW using
> __xnthread_signal(thread, SIGSHADOW, SIGSHADOW_ACTION_HARDEN); nothing
> seems to prevent the case where the target task enters the primary
> domain right before it sees SIGSHADOW. In the next step
> do_sigwake_event() causes it to resume instead of sleeping.
> 
> Hmm?
> 

Traces to confirm this theory would be good. But it could indeed be
problematic that the target state (__THREAD_S_SUSPENDED) is only tracked
in userspace where the scheduler has no access to while waking a task.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
