Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ED75464B
	for <xenomai@lists.linux.dev>; Fri, 20 Sep 2024 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726819137; cv=fail; b=DxSUt3F+mpmKEnTlOFEnpUbib8zzuFw+Jv0dt/jYdCZvdJhdA1GXvnD1sEuJ0KsLIkmpcSOWDwGGqBksIdH6O6AdJEbZ7qwV4tgKm7WfqjTLdtEhXX1HnnUkf4PbmaoUsKaVGpYkXrACy6ydKqKLiHfJ7uMYhQsy907eMAUq7io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726819137; c=relaxed/simple;
	bh=0ZtPPkcBfiomsLV6uso6vwVlGHCTEFiSw79QbakOnP4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d1FDgmEvhMAkNYGX0FrVvQtBDJPeoaszwkXhVzuFMIqgHBRSlX1emlgV5CT/+CuroSod86aPgCzHD6m97vCDpb+MCliv6rtohV0NoYq1oPIDp1WsSFjXPlkyHVaBoXn6wcuNZG+NMWnWyN3MPfzxw/6koc7Tk+AgkoMgjx69zsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cgPT7FVM; arc=fail smtp.client-ip=40.107.20.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cgPT7FVM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyO3WYjcGR4UBK6mkmq6XtjuT4Ff/LpjR1Au0P7flj3tWutVBe/leX5hISE2CBKg7VRc+WU5orqMXZxU/Rgzmk+amQI9I2W7lEfp37+tcID378ddWLjUKlfJc8KuxXB1tYX0ovEPvtWFc1cmSg1t1v64absimOWfUoPknErIpgUbKndcx85NX8FC1GZGd3u/5AwIeYRlG2sSgFnjNFyy6k4CYyZZ0z5RwRgwVPqxG9PzQ7RrHz4NPTVF4kdzpNAnx+DnRTx3iOSeie1vKifFltlmCJvKZz5boo8fyP58h2+gOlVqslSLq6vZu/DmzOVOAbeFd+tPXeelHgM0GZiEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09I2Ih0x+Iyg3dWDM8iEhBHldeGj0aRMRxAmCkUDO1E=;
 b=K6u84tSlyYRZQH0eOvnJPtFa4wsAvRYOD3i9DaDdQHWeGtCOqziQMoeaEW12fb3fAsONblr8JiJENg+q7rXhvRGwin/mz69OwOPFMAK+dDoLLxDDTyaUA8FseUQrszZ4ZpbHezxH6zI8Go5Smxy8Y8rX7GD5C8vSOtfjdsokAtghvvTWxkXXYhpOWe9gVtEQiI9lSLrog8T4q5BILidvj+EFMtdu/3oLkr6qpt+be2i/pYkHjcPduD7Q4tqlUlM+FEWSB7+OuCUaZOqmSI/6hMQDH9tpEp621yI8/mNk9fXtVY2WZPZBl+lZZHNXkiauXHmOeFWxqUOQ+TurBqqbAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09I2Ih0x+Iyg3dWDM8iEhBHldeGj0aRMRxAmCkUDO1E=;
 b=cgPT7FVMZaj+qh5YrXOuRliKvJ6AOtdQLlHOC9vcOjykX7iOMY0leSHWlie/xSORNGQTitrQ89Hpna+vTnHkxVCFSp9X77uP9P54tX4SIkRhnsQZmYB8ZuPb3fRMoqAVPHv4+r4lN9f9AbGDGIo3r+twF7FvpmwGrteIJzo/bi3fXHAOwLAkqq1ao3g4wU5lVQCNOBgKjVhhJVJ24nUs7wPvbnrCgXSiJibu/v6cr2hdymQevrT4swdmxtkbP08Lhf/uQno3sj332XZLErwVn1RSQUdtrf8iiYaMi8NoYs5MGIkKe+zuVVP0aJCER8Kbd3DaEenQbIxwTdJkqe7iMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9030.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:237::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 07:58:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 07:58:51 +0000
Message-ID: <46532234-69a4-448b-9fc5-a04ac47fba0c@siemens.com>
Date: Fri, 20 Sep 2024 09:58:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cobalt: Move relax related lostage_wakeup work from
 stack to thread
To: JerryJun <jerryjun123@163.com>
Cc: xenomai@lists.linux.dev, Florian Bezdeka <florian.bezdeka@siemens.com>
References: <cover.1725016413.git.jan.kiszka@siemens.com>
 <95ccd795ec5db6c2d4d867b0f29fae964cffcf82.1725016413.git.jan.kiszka@siemens.com>
 <cd1d4b2.302.1920cbd5314.Coremail.jerryjun123@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <cd1d4b2.302.1920cbd5314.Coremail.jerryjun123@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0220.eurprd08.prod.outlook.com
 (2603:10a6:802:15::29) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8d5c56-dfea-4729-ff9d-08dcd94a10ae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3k1NEp3Ym1RL3JIeVptUkhuMlNsMG53TmtGZksyWENZNzd6aFd4V3BvWGZZ?=
 =?utf-8?B?b045MG1ma0x2RFovNzZkdWxpTWZPa2pqZmdWekpWeTEwcXl4cUJXV3ZVTURo?=
 =?utf-8?B?MUpUWVFEVldPdmxJdk1nNFhTZmRKU3FBYzEzRlByajRsekJuWmdEYXJETHQ0?=
 =?utf-8?B?UjJnTDMvcmMrWFdmcGlDQ1BaaHRvQnFZbUFnY3AyZThYWmQwL1QxK0RwSFVY?=
 =?utf-8?B?N0hITmg2V21FZ1FydlE2M1ZRMWEvMG83ekw4bmJJUWQ4eE5GRnJUeDkzQ2dB?=
 =?utf-8?B?ZXJSeWRhd2VRejlVRWROWXF1dEtMM1E5Qk1HSDV2a3RNaXJXZlFRNzBmOE9P?=
 =?utf-8?B?aHNmcXMxak5QaytmL2F5YmVnQkV4VUZOTnFTVklCVFIxSU8xNGJobEZuZHFp?=
 =?utf-8?B?anAzQ0d3QUx4SjVWVWNlOXBUVTJsRHdadTJvOHplM29PNFo5K0M0NS9IQnlZ?=
 =?utf-8?B?dzdqWC9TVUZxajUrYzJEQmRvMVc1OUFHT0UwTzh5QlNHdUdGMkJZK3A4TnlY?=
 =?utf-8?B?WE96TU00RzlEQUVXbmVIL1BRUVFiZkZQUE56NFdKSDJBLytTU3FpbG9HN2tX?=
 =?utf-8?B?SUlwQW1GZE12dFJ6dEJjRWY2RDQ0aDIyaEpXeVVuSVJuSGs5c3pqR3puQUVE?=
 =?utf-8?B?WlorR1J2U003T2pUTllESm5wdGhYRzlTTll4WTNMTEVCOVZsV0dJeHhzSzhm?=
 =?utf-8?B?Zk8xZGNaek1mQ0kvdjVUSTFOeWVmSHlmVHNxdXFQOEthS1ovWjVUWEJuaWlw?=
 =?utf-8?B?aWF4cm5aMXl3NHNUUll5a1FtTEtvOEFMbENYU2JFeHhMNDFFRjNWdFRmNTdF?=
 =?utf-8?B?amhpQkE4L3drbTNyM0VYbEJvRlFKUFI2THVhYS9UbnJqdlV2RU53Q3BRQzdq?=
 =?utf-8?B?OXNoa01KT2VjVC9NSzNObWpMNzR6R281MG1UTHlzRnp0SnNpZVdMMVpyWkNl?=
 =?utf-8?B?NHdleW1jd3VWajNVckIydUZRSmFnVDhyTUtaWW14U1FBUjhTT0RmeVZidnF3?=
 =?utf-8?B?OXR1V1dNZHI1eThHRk1JN21YNGU3OXk3Vmc3SC9GZGhrTDZIQytBUVpSa1Nv?=
 =?utf-8?B?Um56U2hwcmpONk1NdnJrR3JlN01iVzlnUmJHR01PRUJDOGF1YUNjT1FKekoz?=
 =?utf-8?B?dFc0b051T29MMjg0eXFIejNGUDFGMXlzU0ZENzJ6djVmRDNvR0RFRlB0Y1RD?=
 =?utf-8?B?eTJ4ZEZaTUxJT1NZazJYQ0ZrSG9aYUZ5bmZjVys2U0xKV04rSzBpZ3Rmd3ky?=
 =?utf-8?B?OEJ1TDVacGp2a2k3enpWd0xEeWZIdjVEcmxPdlRJbVBNckNVZ3ozWWlPSDVo?=
 =?utf-8?B?b29nRFU5bE9WR2pnOVZ1MHl4MkY0ZDF6TThCSmJyalNGQk8yVlBDL1ZaVWJs?=
 =?utf-8?B?bkp6ZW8rYzJKZGpJN1FDVmZzT25ZaTc2SzQrSTN1c3IwZGF0NVl2VzNJUG0v?=
 =?utf-8?B?U1QxWmxCMnkwbFFKUkk0WjFDTzhmWWNSVlM3NytyWTdEVWNVMEJRZk9wOC93?=
 =?utf-8?B?UTYxbUk2OGR0Sk5UMUlhdU5LdVBoUElQc1JhU2tJR2FTOWtrZy9pakNXUjlh?=
 =?utf-8?B?TkVZNDZoUFBiN0xUaXZDY3BGZmpEa2YyeEVJQjVCcFltVjQ1NUhZT0UzY2dG?=
 =?utf-8?B?VW14Y3MxdGVMQTJNR0czT001VzQxQnNWOGZBSXdDZW1jZ3p1Y2ZYME00TWtj?=
 =?utf-8?B?Ly9zRER5REx2RW5aalFjSFlHZzlaMXBUdWtqUTdGOXNCaXNBN0IzTVBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3Y4K1ZLcmRoMjlWVCtRNmhNaUU2VXNDUmJiZ0NCQWtGVnE0S1hRNGNUanVP?=
 =?utf-8?B?RjJtV0pXWTViSnBNaXVqUEZORWJRWkdJVmUvV0RkUHBTYk16TUU4TkRYSmNl?=
 =?utf-8?B?a0VKTzFFVjlkZmVQcllLU1ExZWg4eTdncjRldjdVYnRydm4xMnZBWnZnR1pG?=
 =?utf-8?B?U041aW1yamx5QTdXRTlnSENrb2RjRG1BTlI5T1VwUHAzTUMzazlFQ2Z5eFg3?=
 =?utf-8?B?bDBQMmF0MFd1OW52WHJoSXBFWGMrLzF0MHp1RUFMQVdGZkhXcFhBamxxT2ky?=
 =?utf-8?B?ZDkwZ0VOS1pZdTRUNUZwVWtFK05JNXpISkE5a0p3aWN1bDZUN0F5REY0K3pF?=
 =?utf-8?B?c1lEcnNvSkhJMjc4NDhhSFFoVXAvNjNvQUNEN0YvdkZjMDBHL1piNWtCUkFD?=
 =?utf-8?B?dTJGekRHZ2EydTdCTU5JTlIreERHLzkvckRZeWNESHBNendwY05JSi9zdXNa?=
 =?utf-8?B?anVYakxCQ0ZRY1JXZXYvU2Y1ZmNFWFdkS0pmcHZyTmtYazluZmlFK1JsSUdU?=
 =?utf-8?B?aG9iVjg4dEEvMkZNMnpwcnNlZmpOZkQramlPRzlCNHBKL2FkYnpqdjgzQUIz?=
 =?utf-8?B?bnBwZENKR0htMnlkZGozcjJ3ZkhubHEwZU4wK0Z2M0Jyb0pWcnU5emxzZzJC?=
 =?utf-8?B?QWlmbFovbWVZSVZLQlEzdTV3THJxYmZhV3FPTmNQOHJIUVZtUndVMyt3ZElj?=
 =?utf-8?B?K2R5Q1pIKy9LeTdQWG9YdWNpREJpUzBVSjl3WE04SkVWT1JaVy9HTmttUS80?=
 =?utf-8?B?VE1lcitQcDFGQmRJbEdqbTZPUnF4SGF3RmZxS20wNnNYWGVQNWRnTENiUFJI?=
 =?utf-8?B?dzJQVHdCMitWY1N2SEUxUDhpU2pMVTUyWks5REF3eHNJK2ZFbEtGb3cvR3hP?=
 =?utf-8?B?OVpDcGhKOTJLSDl4eTlqVWQ3WlVCb1hEb0xvdGlBSmxBb1AvdGdpakhBY2ZZ?=
 =?utf-8?B?SEREMHRiMWx2YkJpai8yTDYzQ2Y2SFVzRW11ZDF6Ync5WDl5Yk84L2FsQlQw?=
 =?utf-8?B?MittQThnR2NmOXRRRE5ENGFaWHY1cmlRWHdaSXNFOXNvak1zRHZKV1NzTFFo?=
 =?utf-8?B?SzZCeEF4aHU3RHQ4bGJOSmE0MDV6ZzVCc3I2TDZWb0tBS1dhRStLbW1JNExh?=
 =?utf-8?B?WkdxRW40YnZxbUR1aTBSeVNJdWhPVjFPSXZuTC9SVGsyK1B2UFdaTWFTWDVX?=
 =?utf-8?B?eHZBL0l3aTZwUlgwdUgzNlgyR2tSaFluNHpKUkd0TDVobzJ6aHV4b0llY1JY?=
 =?utf-8?B?ZVRCK01mQ3lqc1crMWVqMXhaSmpWUDY0aXFmaVJBSlgxY0FzQi9pMTNnNGhB?=
 =?utf-8?B?a0xYSGN4STdYTFU1OHlaUDJXQ1lIU0F1anFWcUUvVVN3c0JrR0ptQnNNNFdL?=
 =?utf-8?B?M09OWi9JMCtwU1FyZkRrczc5V2xsYkhKVFJDcXlrWFJKOVRaRzQ5RFhzUGRo?=
 =?utf-8?B?blB0MCtGaVcxSi9HWmxVZThwTU8wOTU4YUdxcXVGeU5vUGpJY0NVMDF4WW9p?=
 =?utf-8?B?Mk9ENncyR0EweTgrOTFmM2xqVk5rQWxseXZLb0dpK1RuSXVGWnpwRmk0amJE?=
 =?utf-8?B?WjErZWtQcy9jMVh1UytZRWhUM012U1VaMHkxblBsOFJHRTVBblRwNXlsWEFs?=
 =?utf-8?B?UU9pRkhVRmVIQkJXdUNPM2EwSjh6MlZ5cDJyTGoxdGwwdEVHYlNMNlN2OWhJ?=
 =?utf-8?B?WDhveFlkMHlNd1pkMFc3TjN6UXIxVW5uZ2hvMmFDcVloR1BySG9RckU0Titw?=
 =?utf-8?B?N3hWQUx1b0dBV292SllLbVpaUVFMckJjczVvbWR0RHE4UVF1bkUrSlM2OS9W?=
 =?utf-8?B?YlpINnRaR3R1blVGQmU0eHdjN21ZZ3cyVkFLaDF0SjZKdEJmOTQ4eUtBem9y?=
 =?utf-8?B?dVZuNnlyMXFiM2J1cndsa3pzdTNuYkM2NDNyc01wVGo1eE04d05vbEd5NFk2?=
 =?utf-8?B?RDhHSmU0cFB1Tm10eTc0VFQrTVhZcWpQYWVZcU5OWDZCMnhPUnJZQ3JSS1VV?=
 =?utf-8?B?NlE4akVJMWZwZU5wdzVNOXYwMkM5T3V0czN0OHg5bTVrYXhpL2MwUHMrMlB5?=
 =?utf-8?B?UjMxZjdDS1BVd0J1b3RobysrK1pQYWppV3NLai9lcCt1MFZQYW9Oa1RwN0ho?=
 =?utf-8?Q?A0yb7dk5CGzXDtf8y59Dm5NAS?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8d5c56-dfea-4729-ff9d-08dcd94a10ae
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 07:58:51.2299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIz7TButMuifFhQ88dGUwlqNJ/TcHYP/WtpDfb4wr/QxOqvYxn/V6qTu6XkWNey0mQJ8mNpbI1qx23I6xRFJGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9030

On 20.09.24 02:03, JerryJun wrote:
> 
>   hi Jan， the issue reported in [1] has seemly not been solved in ipipe.  Will this issue still be maintained on ipipe? 
>     the test case is available from Florian Bezdeka ([-- Attachment #2: xenomai-alchemy-app.tar.gz --]).
>     linux kernel: 4.19.89
>     xenomai: 3.2.4 + patch[1/3] 
>     
>     [1] https://lore.kernel.org/xenomai/770b1e4bc42cfa1ba5f4f37cc854956f3e78bb60.camel@siemens.com/T/#t
>     

Sorry, that fix is still only on master (upcoming 3.3), not yet in
stable trees. It's still not expected to be I-pipe/dovetail-dependent.

Let me recover a bit more from yesterday's Preempt RT merge party, then
I will close that gap.

Jan

> [   98.182433] general protection fault: 0000 [#1] PREEMPT SMP NOPTI
> [   98.182453] CPU: 1 PID: 69131 Comm: rt-task-20 Kdump: loaded Not tainted 4.19.89-ipipe-9-xenomai-3.2.4-proc-20240909 #12
> [   98.182475] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/29/2019
> [   98.182496] I-pipe domain: Linux
> [   98.182507] RIP: 0010:xnsynch_sleep_on+0x15d/0x250
> [   98.182517] Code: 30 12 00 00 3b 78 e8 7f 07 eb 4a 39 78 e8 7d 45 48 8b 86 50 12 00 00 48 8d b0 b8 ed ff ff 48 39 c8 75 e8 48 8b 86 48 12 00 00 <4c> 89 40 08 49 89 86 48 12 00 00 49 89 8e 50 12 00 00 4c 89 86 48
> [   98.182552] RSP: 0018:ffffc90006327e30 EFLAGS: 00010046
> [   98.182564] RAX: dead000000000100 RBX: 000000000005f3e0 RCX: ffffc900012d2a88
> [   98.182577] RDX: 0000000000000000 RSI: ffffc900012d1840 RDI: 0000000000001032
> [   98.182591] RBP: 0000000000000001 R08: ffffc900012d2a88 R09: ffffc900012d2a78
> [   98.182605] R10: 0000000000000000 R11: 0000000000000000 R12: ffffc900012d3708
> [   98.182620] R13: 0000000000000003 R14: ffffc900012d1840 R15: 0000000000000000
> [   98.182634] FS:  00007f888c3bb700(0000) GS:ffff888133d00000(0000) knlGS:0000000000000000
> [   98.182650] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   98.182661] CR2: 000055738facc000 CR3: 000000012ad44005 CR4: 00000000001606e0
> [   98.182698] Call Trace:
> [   98.182708]  __cobalt_cond_wait_prologue+0x26d/0x850
> [   98.182720]  ? handle_root_syscall+0xd3/0x310
> [   98.182730]  ? __cobalt_cond_wait_prologue+0x850/0x850
> [   98.182741]  CoBaLt_cond_wait_prologue+0x1d/0x20
> [   98.182751]  handle_head_syscall+0x106/0x3b0
> [   98.182762]  ipipe_handle_syscall+0x66/0xc0
> [   98.182772]  do_syscall_64+0x22/0x170
> [   98.182782]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   98.182793] RIP: 0033:0x7f888d29575b
> [   98.182801] Code: 8b 73 04 49 89 dc e8 54 f0 ff ff 48 8b 6c 24 10 b9 23 00 00 10 48 8d 54 24 44 45 31 c0 45 31 d2 48 89 de 89 c8 48 89 ef 0f 05 <8b> 7c 24 2c 31 f6 49 89 c5 89 c3 e8 25 f0 ff ff 4c 89 ff e8 7d e9
> [   98.182837] RSP: 002b:00007f888c3bab60 EFLAGS: 00000246 ORIG_RAX: 0000000010000023
> [   98.182852] RAX: ffffffffffffffda RBX: 00007f888c56e6e0 RCX: 00007f888d29575b
> [   98.183195] RDX: 00007f888c3baba4 RSI: 00007f888c56e6e0 RDI: 00007f888c56e7f8
> [   98.183530] RBP: 00007f888c56e7f8 R08: 0000000000000000 R09: 00007f888c56e6d0
> [   98.183854] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f888c56e6e0
> [   98.184182] R13: 00007f888c3bad80 R14: 0000000000000001 R15: 00007f888c3babb0
> [   98.184500] Modules linked in: fuse nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT xt_tcpudp ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c arc4 ecb md4 sha512_ssse3 sha512_generic cmac nls_utf8 cifs ccm dns_resolver fscache ip_set nf_tables nfnetlink ip6table_filter ip6_tables iptable_filter vmwgfx sg ttm drm_kms_helper drm fb_sys_fops syscopyarea sysfillrect sysimgblt serio_raw snd_pcsp snd_pcm snd_timer snd crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc evdev aesni_intel aes_x86_64 crypto_simd cryptd glue_helper soundcore ac button binfmt_misc sunrpc
> [   98.187446]  ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 fscrypto sd_mod ata_generic ata_piix crc32c_intel mptspi mptscsih mptbase scsi_transport_spi libata scsi_mod e1000 psmouse i2c_piix4
> 
> 
> 
> At 2024-08-30 19:13:31, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> We cannot rely on the lostage_wakeup work being scheduled only
>> synchronously over the CPU of the relaxing thread. It thread might have
>> a CPU migration and other wakeup events pending and resume on different
>> CPU. As the lostage_wakeup work is currently on the stack, it can become
>> corrupt when xnthread_relax leaves earlier on the new CPU than the work
>> was processed on the old one - ugly crashes ahead as seen in [1].
>>
>> Analogously to the signal wakeups, move the relax work into the xnthread
>> structure to avoid such corruptions. We intentionally refrain from
>> using irq_work_sync in the relaxation exit path to avoid starting to
>> wait a CPU that is already busy again with a lengthy RT task.
>>
>> [1] https://lore.kernel.org/xenomai/770b1e4bc42cfa1ba5f4f37cc854956f3e78bb60.camel@siemens.com/T/#t
>>
>> Reported-by: JerryJun <jerryjun123@163.com>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> include/cobalt/kernel/thread.h |  6 ++++++
>> kernel/cobalt/thread.c         | 15 +++++----------
>> 2 files changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
>> index 7f9a37d29a..22ed61168c 100644
>> --- a/include/cobalt/kernel/thread.h
>> +++ b/include/cobalt/kernel/thread.h
>> @@ -64,6 +64,11 @@ struct lostage_signal {
>> 	int signo, sigval;
>> };
>>
>> +struct lostage_wakeup {
>> +	struct pipeline_inband_work inband_work; /* Must be first. */
>> +	struct task_struct *task;
>> +};
>> +
>> struct xnthread_init_attr {
>> 	struct xnthread_personality *personality;
>> 	cpumask_t affinity;
>> @@ -214,6 +219,7 @@ struct xnthread {
>> 	u32 proghash;		/* Hash value for exe_path */
>> #endif
>> 	struct lostage_signal sigarray[XNTHREAD_MAX_SIGNALS];
>> +	struct lostage_wakeup relax_work;
>> };
>>
>> static inline int xnthread_get_state(const struct xnthread *thread)
>> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
>> index 8738fadfce..7dffb081bd 100644
>> --- a/kernel/cobalt/thread.c
>> +++ b/kernel/cobalt/thread.c
>> @@ -1974,11 +1974,6 @@ int xnthread_harden(void)
>> }
>> EXPORT_SYMBOL_GPL(xnthread_harden);
>>
>> -struct lostage_wakeup {
>> -	struct pipeline_inband_work inband_work; /* Must be first. */
>> -	struct task_struct *task;
>> -};
>> -
>> static void lostage_task_wakeup(struct pipeline_inband_work *inband_work)
>> {
>> 	struct lostage_wakeup *rq;
>> @@ -2052,10 +2047,6 @@ void __xnthread_propagate_schedparam(struct xnthread *curr)
>> void xnthread_relax(int notify, int reason)
>> {
>> 	struct task_struct *p = current;
>> -	struct lostage_wakeup wakework = {
>> -		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(lostage_task_wakeup),
>> -		.task = p,
>> -	};
>> 	struct xnthread *thread = xnthread_current();
>> 	int cpu __maybe_unused, suspension;
>> 	kernel_siginfo_t si;
>> @@ -2069,6 +2060,10 @@ void xnthread_relax(int notify, int reason)
>> 	 */
>> 	trace_cobalt_shadow_gorelax(reason);
>>
>> +	thread->relax_work.inband_work = (struct pipeline_inband_work)
>> +		PIPELINE_INBAND_WORK_INITIALIZER(lostage_task_wakeup);
>> +	thread->relax_work.task = p;
>> +
>> 	/*
>> 	 * If you intend to change the following interrupt-free
>> 	 * sequence, /first/ make sure to check the special handling
>> @@ -2081,7 +2076,7 @@ void xnthread_relax(int notify, int reason)
>> 	 */
>> 	splmax();
>> 	trace_cobalt_lostage_request("wakeup", p);
>> -	pipeline_post_inband_work(&wakework);
>> +	pipeline_post_inband_work(&thread->relax_work);
>> 	/*
>> 	 * Grab the nklock to synchronize the Linux task state
>> 	 * manipulation with handle_sigwake_event. This lock will be
>> -- 
>> 2.43.0

-- 
Siemens AG, Technology
Linux Expert Center

