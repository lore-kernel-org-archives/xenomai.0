Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2048.outbound.protection.outlook.com [40.107.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F4A6E611
	for <xenomai@lists.linux.dev>; Tue, 28 May 2024 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716888872; cv=fail; b=gD1FbPhn2LVxeBObRM2+dpGBKREJLJBWan6peMHfC8cjBRM3yuOsRtmT022HbSSXk39NvV1tofkeeZtGkrRVmDJO1QEZSBbOvWr4BXkOwo6485d1BZqJwsDmr2bSd2AhHUEEWHMhGKwJeGwdlKgNKpS3pr5Q2VvackAB8ioBlOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716888872; c=relaxed/simple;
	bh=VhU1X4uMUXkVAcld1UMlPEQvs/edZkHRK/G6GTY8UEU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=STdtrl9gwi4XlaAcHxHoou5uBDfvXbT1QIzCZ1JGbTeEKIOpn4uNPasQVAe9OZEzfJE1zFN+10OgzhxRCUjOZAfzBOuMhxEwo/tMkO0BF+yxXyIDGy0+a83p+xB7oPAAI0VrqWWBPPhDnJDfbetklLTycuIUwABSkWlDY7CL9Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=n9m41JW+; arc=fail smtp.client-ip=40.107.6.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="n9m41JW+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iopae71pWEoo+s6j076E/CxLnW/ur1x0TfX4PFN8QMU/GTXsMOytASQmJEHyiDCeXoa6YWAX/XtQJbvqEd9Cym70DJdIQk/XHv5MXvFnbaLnqhRcbm9lN4Ci2djxa7ZgA4E/HT+O2+qEbl0xSAMDUb/JDh0tDoKeD3wLt3U4/2z1bKpomc2KavsaISv6c22HK37Vc72ByIFFtoxWhmstDIsh+koxyuMjZ8vtI6psw3SJ5VqKZ810tSqcmgE1IkU01QvaCYQW5ddbOk4DaDpc74382AbDWyWvfAH6GD4eG1ei0NMKvQi50rRg6DsSvO8dY5rrH45aX1Pu1ZU4say4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZBLrlqtbWzELeuWuMIV+4TlB+mD0urybzvDMS8QyH8=;
 b=VUTn82kdCTxssVul8B2YfLdtzC6Qsif+e2noNbXw6lk0O3AUnGrfodGBsKrupRC7Lcxu5catG2/sVTzgoTy4QWcxMxAlQ6yU3Gfiit2ydEfPWQbmlojtTxWkGFKXU6OGKWaYpA9lggltUQ2eqTTQtaHEUwkQhF/S3da/DdjvhQZSy1wQInPEgnsvueOMXh1DPJRVhI+fAFQO59uuyi/eOsNerCUa6JWx3HazgbtHLK7sgBk2LqYQln4WZzx7A/OELp5T+7ZJwyHyFllmPVYdP9KdczLqwe30vlHJrPaJAXQV1YZItiXC8SNFKqpr2EO0uMfE1AI5Zz5dOtltA7kzdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZBLrlqtbWzELeuWuMIV+4TlB+mD0urybzvDMS8QyH8=;
 b=n9m41JW+roiZY3iBS0lj0veu0s78+rmwkIzeGZ9iC3xaxPk7F/WxLlChVNYyw9vmsLeQZTQT6IXQY8ZvENAdJYYVvUPWVkiCxjdoa+rhVKmbIIhr588/PJMkeQrVO1DW7jJbEGSMdq7mHArZ+CQCllWtvZEGDapZ0OtTx0jW3sZuujkjH7fa4jSxIu0fWBFkcv537RiKBacyK2LcJkVjVwEUeIuQgbeAee1tXifG2BX21zsH27Q0B3hpCKp1TRqD5qSyTjEClu/kP4fFwdRfBCPvwsZ8EP4VJexL1o/M71K/v1KV7+nlxWwoqXl+aTj/1eiDnBUIpNcaOocpBLsFSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8385.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 09:34:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 09:34:27 +0000
Message-ID: <b22f524c-f1b3-4981-bb67-6f936b14e507@siemens.com>
Date: Tue, 28 May 2024 11:34:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] xnthread_set_periodic: Improve period adjusting
 support
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
 xenomai@lists.linux.dev
Cc: richard@nod.at, lorenz@sigma-star.at
References: <20240528070432.6669-1-david.oberhollenzer@sigma-star.at>
 <20240528070432.6669-2-david.oberhollenzer@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240528070432.6669-2-david.oberhollenzer@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8385:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a9ce0b-2b5e-4609-0a1e-08dc7ef95e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHEydHNGYkJVc3dSZFpRMllwNUZ3Tm9YRWxmeFpPSmJBQ2loSDY1TGhZUUlq?=
 =?utf-8?B?YVdqeHRzOW0rRVZFTTkwNW5PcjgvZ1cyNnpJbHRyMkZjc0p5ZFdXcnRnbDhV?=
 =?utf-8?B?aWlDeTlQTUFGbjJUdndBWURQMkJSUEJPbGxNN3ZoTmdlT0oyaER6dnd1TUJE?=
 =?utf-8?B?cjJTR0dZR0gyamNvRndTSnIwN2ZjZTJ5VGZPeTR2bU1yb2RTT3Q4cDcxRW5C?=
 =?utf-8?B?L2JrNVV6N29WWHBsc0k1SnBTQXBHUjJaY0dYVjJVelVPemIzWUNqU0xSd0VZ?=
 =?utf-8?B?VThxTVFKYjB3d2VId3lvUE5NaDRMeVdYbVNyK2NaaEJ1eGVlc1VMQTc5eVVT?=
 =?utf-8?B?a2M4Nk90Mzg4a2tZbkpHakdpUEZ0Rm5abTRwWWx5ekJwUFJrRU1SdUMyb2pY?=
 =?utf-8?B?a21QaUxDTWEvZEpSVHlLZFVIaVdwYkE2Z2pXQTFUVDZxekp0ODBOMDRRVkJk?=
 =?utf-8?B?TUpVUFo0OW54ZlNvaGY1NGtWT2NwU3dtNCtaZUNlL2xhdm4wWmtnRmxBUkVZ?=
 =?utf-8?B?dWpqWUZFSCtWekxoOUJ2elUxc0MxSldWc1JGcWwzRnFmUXFkOUVsaFFMUUFr?=
 =?utf-8?B?enBtaW5laVRCSnA2VklWTkJ0bjFKeXZ2Z1ZnR1NGYWRubFE1Wk1vVHo1bHln?=
 =?utf-8?B?a2VFamJLejV1cEJFZDViYlRyaWJKbE1vbHVTa1lXbXZlVmRBTndLQ29TUTBL?=
 =?utf-8?B?RXp4R2pESEtRYnBHQk1vNWVsdExvY1hpUUlvM1ptcy9jdm9KcEJEd3g0aXVp?=
 =?utf-8?B?eGVVUVpsanBLcy94NERxeEx6N2JQbEkxOGhLQWNKK2RQQlZ0TzI0ZW1kbDN4?=
 =?utf-8?B?b2pvYWJsbEcvWEhMUTl0azdTU3ZoQzlBSEtEMkxGZUdPbS9CUW8rVnlaVmk0?=
 =?utf-8?B?NjEvdVNVZDhDMnFuOTZMTU4yQjkyUXVmcGYwZUh2bWxORFQ3S3UvUnZuNFZk?=
 =?utf-8?B?emVGejFkbGw1R0pHYTBGQWx3UDBFamg1dUNzTEdQZmdjbGxYaHNGNGFNbUZN?=
 =?utf-8?B?Y21lc2tSTE1IM1YwQnYvNUNPT2dLM2tRSVN1SGhvcHBPZzF0K0VCbGJ1NVgv?=
 =?utf-8?B?MldBb3N6dVNmSkNYclRVc1JSRVhKNEVzdWZpcSt3QndIbjBNNkZsd3RRUUl3?=
 =?utf-8?B?OEMwUXZBZmV2Q2RNUk1XcDhqSmtyVGZ0V085VVJXdHdRVTlhYXlSMTErMzJW?=
 =?utf-8?B?ZlVleGN4bXZwZmlxRnJlQnhUbkJYVUl3YUJJeERCNGJpL0NRZ3NjNC9FK2sv?=
 =?utf-8?B?Q01aQXdESVp5dWpOYlBxSVRpeFJzQnhvb2FwRTJ1cXpOMUFVd0FFSWhzbDJa?=
 =?utf-8?B?VzY1RXZpbHZndlM1QUxJUEMyS3pGekVVUFpPYWVkbzhMMGpCb0dFVzkzdUF1?=
 =?utf-8?B?TWU2ejI5b1FrZkZ3Q2JzbHZ2QTc2dGVsSzY0Y25VcjNDaUR5c2lKQm5zdXFa?=
 =?utf-8?B?QTdlZHJjcm44U0FnNWVONmRCOFFJN3ZDN3B5NEIxbWZsYVFUTEt4R1dScFU4?=
 =?utf-8?B?Ylp5cmRIdGJMN01nNmtCb0tOaU9nL2ZRRTdhK0crdFdQYnJ5bkxlNmphaXEz?=
 =?utf-8?B?VEVPbHYzVURqb3ZLcUhROHg3eGVzRHc3NzN1ajNqQVl3VFJPempwSlFQU1RJ?=
 =?utf-8?B?M1FSMlFGNnBrTHRWUTBON0JNTzA5dTBkMTNua0ZkU3FuaDNRLzJUejFNRGdE?=
 =?utf-8?B?WjZOMGpkSzd0VzgwMTBOWUttcXMycVR6R0k0elQwTHdOaVBTaHd5TWNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUhDK01qSWVFeXFYTEQxbjNoMEp4Q1g5Y0U5REdJV1BKUFB2bTA3UEtUTzZw?=
 =?utf-8?B?YzlTTUhsRzZwOU0yUnF2Z1FiUDc3WUtIRFMxc1B2SmcyUTMwMnphd3NCblFZ?=
 =?utf-8?B?RkR4QjZOckN4RkVwaGJMUHV2VHNQYmc3ZFh5RXFCQ1hqNkg0UjFweXBtcjB0?=
 =?utf-8?B?VkU4eUhiNTJ2eXlXSktuMzl3REhXeTd3NnNaa3VpZURWeFp1NFRrcVNJSiti?=
 =?utf-8?B?dUttZjdlb21oSW94L2FOOGJqUFpxL05OVHZtNVkyU0h2MDRQNXdycG9OWXp0?=
 =?utf-8?B?ZWF1RjMwYk1UamNrTGRQaGJjNDhSSmlnSndVbThkWWM4M3g4cTBSd0RCWSsy?=
 =?utf-8?B?Wkp5QUxZRVNHSXpHN1VmTHA1MWNlL0VyZVN5VWhTQjZETjBUWFVwR2VtMVZm?=
 =?utf-8?B?dnh0cmI1bi9rYXFwN1B2bjdXbnp2TVNzSWd4aWZFSG5TNzhxMlFKVXRXbVl1?=
 =?utf-8?B?UDR2MlcrQkVjVzJqMUtqQXJQbEd6V0dENjBJY1pCUVAyMDlwQnZyZ2Q1d2NC?=
 =?utf-8?B?UldrUCtaazdaY0UwYlRjaE5YZldLN3FPQnlNa2hBZ2hKVjFiUVdxandlY01C?=
 =?utf-8?B?eHpZZnB5NmdheWE0a3FINUt3bmFiQzVKQnBsNGJJNXFUWHdVM2dsUXZRK09u?=
 =?utf-8?B?QW1YMnV6YkU4d2orQ2ZMU29UczRiMjY4ekJoWVJEdUhCU2Roejd3WWlHTkdH?=
 =?utf-8?B?QjBXVWpXT2pOK3VMczdJZ0hBUE1ZNVJtckJVVTM2aXlzNnNHWWF6Rzg5S2xj?=
 =?utf-8?B?dHpsMm10OU5JWERNeHBBUWRURktESWpNQjdjb1UwRUNWcXdzQ0NkUFA2NzRQ?=
 =?utf-8?B?eDlocGswc29pM3pscVpuQmE2blFQbXhFNVJiVlhJSnNyQnRxOS94cDZ1N1dF?=
 =?utf-8?B?VmxPdVJpMlJLYXR4bU5sUzFocHZUdWExWS9pNC9DYkhLb2pObjFKMGR4bTFr?=
 =?utf-8?B?NDVtdGZVL21MT1NLcUIwSWRSMWVDeWp2dkN0UHVWM3hNKzVicWV3VGhZdk1V?=
 =?utf-8?B?MWh1ZFkxTG9Ed2ZJamZJdlZvU0RSemR5ZCs4cHBTYlkzTW9GZjNYbEE3RUxP?=
 =?utf-8?B?Y0w4aXU5NEhxYWsxYmtMTHhOVHZKS0xtNWdON2d5RU1DTHlEencwYndkajM4?=
 =?utf-8?B?dnF2NkFLa1ljcC9jbHlISExxRW5zdGtJaTJXMTYrcXpwOGtvMGZob2FYQXAw?=
 =?utf-8?B?a054QzhFSFp6Y1l6bkNJQWdhT0NYRTNQekgwUjEzdGdRc2xSNWhFSGx4SXhC?=
 =?utf-8?B?bXZ6aHlQbFR0OTJEYzFPNDJFQ0l6cmNYM1dZUW1UQUIzS2dLdVRZcFI0bVlC?=
 =?utf-8?B?UUQrSnY5cWptZ1lvbTVGM0JHWTZrR3U4RkNtS3htMGlGR25GR2FpbWxYekhG?=
 =?utf-8?B?Tmhsd3ZReFFoYjFiTTIzTVFHQVR5enRyZWUwQnZydFhxWEI2a2RHR0hzV0Fx?=
 =?utf-8?B?NXZoTExYUzR2TTRYd2dTVDhQSXF3MDVaZE4yOU5QQjBJRXdNZy90WmRSV05n?=
 =?utf-8?B?bjQzUXZuQS9JbUl4TUZ4cS9lbk5rUmtVUWpQMkhscUptMkh6d1l0a3dqQmx5?=
 =?utf-8?B?NndxdVVFQThHNkNVMHhOdlZmMHpBb2Q2d1dudEJMTjZIY29kQzkrMFhiR0xS?=
 =?utf-8?B?V1hmQ0NIVWo1OHBUSXZLUko4anQ1WUIxYUozalJzSE5BN0diSXZ0MkN0TER2?=
 =?utf-8?B?aHZDZ3RlUERiL29zRjRPRUlHcnR0Z1EwdjFQOTBaZElmMCtZSkZDTG13UlNK?=
 =?utf-8?B?RWVrNXNqZ0NNeUhwMkVQdFd2QzlhS2FvR253cVliakFOOU5HUUxOem8wbENT?=
 =?utf-8?B?VEpQdGIyUDhJbFNELzNkYi9Fc1dZcENqZVcrbWVTQ09zbUU5V1NHNVVtazcy?=
 =?utf-8?B?TmNac3V0VXVMSExCa0ZMN1hpUW93cGJZKy95TldncGx6a3JybkFxVW9kZ2Jr?=
 =?utf-8?B?elZzaHpwR3B3ZVJTbUlPemxYMXlrQUZaYTdEV1JJMEtBbmsyb01mNTdMekJi?=
 =?utf-8?B?ZWp1cUYvZFN5b2J5THBKVHVwZ1JPdHlra1RiRm9GUkFDN3lPVnYyYkYwckYz?=
 =?utf-8?B?OTg3VCtqYW14WGUvZnEwNDEzdTJUaHVMR2g2VmRKanBUUi90M0dZeVF3T2hR?=
 =?utf-8?B?N2ZMNVRYMUplYm9BSXZteS85bEtLZEY0T0RPdWd0Ry9vZzgyWUVKcW1Ya2ho?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a9ce0b-2b5e-4609-0a1e-08dc7ef95e14
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 09:34:27.0947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfzCgkVJN0VpXER5cwqwYDx7kDFt09m8lRmrBacSFJ120AEckNRDtb7HeGkngTGSPk5RzdsaynUqH+I8AFiELQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8385

On 28.05.24 09:01, David Oberhollenzer wrote:
> Currently, when a periodic task invokes xnthread_set_periodic() multiple
> times, the timer is reset each time. Consequently, the period drifts
> because the elapsed time is not taken into consideration.
> 
> To improve the situation, this patch alters the behavior when idate
> is XN_INFINITE, to keep the current timeout value and alter the period
> only after the current period expires.
> 
> Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
> ---
>  kernel/cobalt/thread.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index cf3b4dbb0..de97b7e70 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -1273,9 +1273,10 @@ EXPORT_SYMBOL_GPL(xnthread_unblock);
>   * point, expressed in nanoseconds. The affected thread will be
>   * delayed by the first call to xnthread_wait_period() until this
>   * point is reached. If @a idate is equal to XN_INFINITE, the first
> - * release point is set to @a period nanoseconds after the current
> - * date. In the latter case, @a timeout_mode is not considered and can
> - * have any valid value.
> + * release point is set to the end of the current period, or to
> + * @a period nanoseconds after the current date, if thread was not
> + * periodic before. For XN_INFINITE, @a timeout_mode is not considered
> + * and can have any valid value.
>   *
>   * @param timeout_mode The mode of the @a idate parameter. It can
>   * either be set to XN_ABSOLUTE or XN_REALTIME with @a idate different
> @@ -1336,9 +1337,14 @@ int xnthread_set_periodic(struct xnthread *thread, xnticks_t idate,
>  
>  	xntimer_set_affinity(&thread->ptimer, thread->sched);
>  
> -	if (idate == XN_INFINITE)
> -		xntimer_start(&thread->ptimer, period, period, XN_RELATIVE);
> -	else {
> +	if (idate == XN_INFINITE) {
> +		xnticks_t start = period;
> +
> +		if (xntimer_running_p(&thread->ptimer))
> +			start = __xntimer_get_timeout(&thread->ptimer);
> +
> +		xntimer_start(&thread->ptimer, start, period, XN_RELATIVE);

Doesn't that mean that we skip over the next tick and fire only after
that one + the new period?

| ........|...........|.................|
last      now         next              actual
tick                  old tick          next tick
                      (start)           (start+period)

> +	} else {
>  		if (timeout_mode == XN_REALTIME)
>  			idate -= xnclock_get_offset(xntimer_clock(&thread->ptimer));
>  		else if (timeout_mode != XN_ABSOLUTE) {

Jan

-- 
Siemens AG, Technology
Linux Expert Center

