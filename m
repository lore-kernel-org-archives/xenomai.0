Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953861E87C
	for <xenomai@lists.linux.dev>; Tue, 21 May 2024 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303187; cv=fail; b=uZo65cu/xQOz8s+Wdzzxqotnj+0omzCZq4jW1x1qV9GlRQxKwex5lUBMTjVVsRUVc4E5bJrLkRtDUQx/oD02T36SvwRjNBrCwrtVHtNHtOJHucYCHfk7qA7GO2S5ugimcyA3Gs1JOxsI3QjJErZQzUdN6rv1bgC9qTQnEvkqF+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303187; c=relaxed/simple;
	bh=HT8uGhRW19bqgvkg73mp1UzRj4ParUMRrQ94DHK7ce0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SkD/uilmUQ8bivee8IYWUsFVIpFK6kDOA8k72RaCsxUcR5frmYjRK1Ef5uUR6ZUKW64yxEYgeFH5MAmHdxUBryyFxAt0szN1lvIqWVkAymADwrkokpWkmi05LMAcdlPpl/xCqRtbloj57T2voNe8i6GIkxfXRJYUbA5DULEqdEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PlrFcqH1; arc=fail smtp.client-ip=40.107.8.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PlrFcqH1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnRZi4+D/7fYHjbP1bEUMSFYqQbLesASIlBX6C2zkPCfzz+Qqyu//EvxL2UisD7kydF2CxViSyMGtH/KUrJdnA0JCcSF+M2fzZeSchNhOpH2x0tAIgz1F2qI4aen7nn6dwTOsRalvjnrueHdXgCYK1wS93jrg81I+VKCRmwhwUv18NhwOfWVeGU5lX0XzRKroDqFH2/82GawWDLdm2eih1hqLg5N9KCBAN9/fuiPs5f6seJmVTa66Sw+yRk7CnplRm9R2TgyiYLyuou1HrWNWd4jfZZ3rlaJa24ybGxVdOP6hLhSf0jQIAsl0tYM1rxzZ5iNGvNk7biKNJGOMgV+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/8KbCuwUbjMQfqey8WULrtFTRmT7JPcuSGK24E5RMA=;
 b=iQu40tvKwVbEEQlLLquOhuLGlMPmIujeYTTLzl+OQsogv77M05SJE6mSlOxwu67yM7bcIaCGMzczC5WGm2+ZS+XJRuQV84TfxajkgtFyj0zEr0qNa4n+P6D/JcJThIfpa5vdos6hGng+SBGAyRVrAs3P592o7u+Y+4LbKduaeQKoF8a9O09utnJDfCFIRE/rR1jsQJuyuyV93qpJOWAX3Kx8/fxBfe8QYJ4jwfXu2kJ2hwXxJxKRaMsUB2Th5gCyvnRZFUewGVBGQ7CYwwUSW9EF/4jG7sW9Kc8dHqSiK0hrT2aodk8nPBwPw1vV4ukbGaMwrlZklIZN1tajBoDzjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/8KbCuwUbjMQfqey8WULrtFTRmT7JPcuSGK24E5RMA=;
 b=PlrFcqH17TVR34SIkkLceA5rV55hVQtpD6iDFU3BMsINdgTK+2Ec+zc5K2PcHoofi7E0TY697rQkPipVXy0DA37rdS0kPLr11XpSysr2wbIoFqyEuErzS/l3Wgz1YTktqUONqQg+qtjac7NO2IcBUXdaMypKSYSUTp6SPgp6FD3MuDSDIoDLVtXaxusEVoyaBcYIPxd68mcspvkPJOnWlICgbvoeSmFDAXPnwEBliXCM12B6uQ0OzBDV8vYx2CW3wlRbTPDzNqjAFL8lIBt2G0jeAxyy11q0cB0qUKrIn+vfXn+KXzQSonrM+EyJTn3f4GNlrLQGq0eEP3jdCrnGSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5518.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:23c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 14:53:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 14:53:01 +0000
Message-ID: <81ab4ff0-6eff-4944-83fe-336c965b9ed3@siemens.com>
Date: Tue, 21 May 2024 16:52:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rpi4: Add rpi4 (Raspberry Pi 4) as target platform
To: Yi Jiang <yi.jiang@siemens.com>, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
References: <20240521134841.21749-1-yi.jiang@siemens.com>
 <20240521134841.21749-2-yi.jiang@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240521134841.21749-2-yi.jiang@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5518:EE_
X-MS-Office365-Filtering-Correlation-Id: dc425ac4-bedf-4db8-c3a4-08dc79a5b64d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Snk0Znk3dUt1cjFmbHY2R0xvQkdkMnZ3eU9WNzRMbmtCYUt2b2NPQjdzck1P?=
 =?utf-8?B?cnVUU29hbGNtZGlWOWFyaGFoaXZrSWhydlVpQnRZMGpSZHBvMlNVZlJLSGdn?=
 =?utf-8?B?bEtXSXF5WmVqSzJzdCtpdEhXa21xQ1dvcVVpQ2FodlF1ZzFGOFYvVWkxaUp3?=
 =?utf-8?B?L2pybGVoK2VKeUY3WnhhNVhlWXF0SUo2SUVXbmlNY00ybFNVSlZUREQ0dFhN?=
 =?utf-8?B?dWM2N1A3VzREUmNYd0FtYTEzY1BJelhtMFpRUGUva3UvWk82d09jcXZPTVMx?=
 =?utf-8?B?Z0cwWSt0N01pdzFiV3lUbGE2MDZGMFBaT0VhSG9sUmdDWlZtZ3hBa3BmVDFG?=
 =?utf-8?B?Ym4yTkk4YXlrRUw1blJOTWlIQUV1REh0WkJxeE9jZE94c05Sa0ZXVE9xTGxU?=
 =?utf-8?B?amZYdCtkL3NVaGwrRkZjNWV4YjZCVUI1d2NxK3ZoZWhvYTFmVXBwTndhd2Iz?=
 =?utf-8?B?UGtwNlQvUGVrbkZXMVdLblpxRmZTL0NHbDJjQXJWaW05SUFXWHFnRHZMazdG?=
 =?utf-8?B?MEdxUFp1MXVMUXF5NGJIL2VoSVk3cVRvaGNHaWdLT0Fhczk3RzB5MnpqdlFS?=
 =?utf-8?B?bVpObWhQY0JRemVwQUJ2OTBGWUNrM2w3VjVoWEp2cEU0eG9XUE50TndHeGJE?=
 =?utf-8?B?NnFBUmcrNlhudmJkZjFIUEM3SFVMVFlLSllOZnA5YWhVa0tnTmQvREVqSVMw?=
 =?utf-8?B?TFQ1aTJMUXExaVAwa2xHQWFiT3M1NTh5bFJmYWpjN2Q3UFVPSERNc2xLZDF2?=
 =?utf-8?B?TDdFenprRnJ3V3hwdTFuR2VKWUdNNUJ6VkZrUlBsR0Jya25LKzJSZFdCWEQ3?=
 =?utf-8?B?eXdzdmRJdzFCNFBwTmM4cHFlTFI5d0dxWFRtd3FWRFRNNzVWYXNLYXNRUWsx?=
 =?utf-8?B?VDdtam95Vm0vVUlBL1FFd3BPQllaL0x4T3cyTFBuSGxZUkZiMnZMc3Rya1Bw?=
 =?utf-8?B?UW9lSjVMVVpRS3ExRjMvUXBIWVpQd0Q4ZnlvTjJHS3J5WjdncXQrV1ZKdW1Y?=
 =?utf-8?B?NjZIa2d0NnpnY2psRjVsSThVbjJldjBHRkpJSG1qVmlBN0ExTVpzaXZqclNG?=
 =?utf-8?B?OWpJaU5nMXJaYnVpNDg3T1J4U1pPRFQrK3E0bHN5TkEwR2d6N3ZkZnlmOXg1?=
 =?utf-8?B?c3VNM1h1WDd0VVBzNk55VlZvNDNFVnF2WVB6enBXc0JVSUV3YVE2RUtGNG9s?=
 =?utf-8?B?ZFBqZGhmeTFPaXl3NndZTmRsWGZrbVhLUnF3V0pzR2hGNDlFempyNlZEa2cx?=
 =?utf-8?B?bE1RdU1tWXBlT01ab1hBTFBwdFBjb2JrYWgzQWhEaW9kU1R1T1ZvK21FSmZV?=
 =?utf-8?B?RjB5RXBha0hxQU1sM0lweXhBK1llRUNXSTE5YVRjVm1WclRXL09kdVNnTWI5?=
 =?utf-8?B?blkzbHJQWkJOVkkvTDBTdkxPWjdYMmFLby9yeUdWNEF2OXljWjVqcGVwUVJo?=
 =?utf-8?B?d2xnT3VYVVZrdzVLdTBpSXJWZW1ydVdmWkpmVUk2MXBsMFlvRzYzejVYWk10?=
 =?utf-8?B?c3FBK3o2b2ViMkdJUU1TZzg4eVRGUkZiSmd3V1k4bEVhcTBBSEF3aWhORzVE?=
 =?utf-8?B?cVFmVXNlL1htc21qZFlUekxQTVFoemw3Yk92N3VTdnFyWEM5WDNQcjF2MzJl?=
 =?utf-8?B?R3ljcXpKbFBDS2hoVEc3Qy9WMXRwaXdTVWplN29BTlYweXhrU3F1RzVRek1Q?=
 =?utf-8?B?dXdiSERNN0lsRlhGR3JzUUhZd1pMc0NiaW1ETW90YjJ1Q0x1c1oxbDV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzB0STFoa09TNjl0d1dOQm5jZHZNTUlXVTIxRExQY2RJYzAxeUZwQWpIRzRM?=
 =?utf-8?B?VkVHbVVmTVQwa0JXZ25CSmtmRXBZQXJJL0tQcVBTV09LQ214UzgrdjhFMlJa?=
 =?utf-8?B?QVZCUWR1Y1krb1JyejFsSStZSDlnREt1TDhyc3hMWitTUmtoRW1FZmVobjBU?=
 =?utf-8?B?ZXJRK0dIVURqOVR6WlpCOCtuUEtaY0s1aFI5blhJRFBVQXJZRTh3WmhsaE5Q?=
 =?utf-8?B?alY2ZGxYUlFsZUlmbzhiYStmS3dZUjd4cGd0dUE0OGpOSEtmNFh6aGVGVGYr?=
 =?utf-8?B?SWRRcmc5bVdqaUlQSUtLU0RuOGUzcE1hWGdoR3N2cmJ1UjZzQkIyR2VoODRU?=
 =?utf-8?B?ckN2WFQ4U09HNFNHM01ySFA4TktjaVFmVk9MUDdKYmM4WExLNThXV0luTnQy?=
 =?utf-8?B?dG1oWHB5OGJrWVl2NHVtVmdINndWc0ZPODlieXVjVkMyaHYwY3V6bDVJZDU3?=
 =?utf-8?B?WTNlQ3MzK1ljSXBic0Q5Tm9jaEZUTjBkR0pOVHRKWHNESTJFTVE4MjBTRVU5?=
 =?utf-8?B?WFl4R1RNZUxFQVdzK1Bpb2I1M25sZCtIejhpenkwaGEwZ0RaTDJrODUzay9X?=
 =?utf-8?B?b0hMSG1oY2xZb3NIUndlTmI2U1AxaHZObzNsdmQ2MFpXelNEZWJqLzByQnN4?=
 =?utf-8?B?WjhBMFpNbjJaRW9ad0lIN3dlb1F0QlVwRVBSWnBjeFRUdmQ0azhiTGRXeXhR?=
 =?utf-8?B?YjlmMmNnb3QzZlhTZmhaVDhEMkd2dTM0S1V5a2JhT0w5Qys1QWhpMDkyY0RI?=
 =?utf-8?B?anZRcUhOV0FRc2VLRzc3SDE1MHpNTkl4UXBHZUJ0WnhPUVZSZ1AyM1c0V3JT?=
 =?utf-8?B?S1kzZTA3SFhBZ01wWGlkSFhBcFpHYmZkVy9UcVZPbTRPdkFOWlRTeDE1SStE?=
 =?utf-8?B?ajkvWmdkbHozUEpBK2tRZmx0ZmZRRWZYQlR6clNJSi9MWUhWemVod0kzNFJh?=
 =?utf-8?B?K0pOWHRXRmtxK09SZUcweU5wOXBKczcrZUFraDA1aVZRTGM2SVRIMm90UDl3?=
 =?utf-8?B?b3FhZ0g5L1RiQ3ljMjFpL3RLWnRzdVZJZGxPR211aWJQaHFIUFhCMnFhNnY3?=
 =?utf-8?B?Q2hVQ3JUMmhETU9nbi9USGtFL3ZKWmEzV1NxKzM2eUlsRGRWRkpoYjl4TGh4?=
 =?utf-8?B?VmwwcDBqelZXSjdXU0JqMSt6UmpDKzdDaHBsSTcvRTltWkltYWpzSWlRTmZT?=
 =?utf-8?B?VDl2bDdKWVNIN21QT3MzRW9LN1lXOXI3eit4SkZuTml5cGZFM3hCakROenVt?=
 =?utf-8?B?Nnk4RkNBY29jMVoyN1p6WWt0V0dlcVZObFVhRXhDWHozQ0w5SFpCWjdrM2lK?=
 =?utf-8?B?ZVlFYW03ekUxTnY0YXhoWndYZ1JJWmJDK1MralRNd3RVTTYyWk5oYjBZbi9H?=
 =?utf-8?B?RmcvY1RYbEpqd0hBdGdESXl4Vm82VStZc3RadXNJd1k2SmRNUU9KTXVRdGhI?=
 =?utf-8?B?YmVCMzVjTEdUYlk5R0pyODJyWW5JWmJhTjUveGgzOE4yZy9QRVlqYXhlRENY?=
 =?utf-8?B?RkU0V0hoYWRiWTlCRS9LRHRsMFJnMmZlY2JLSGZiQjhhcG8vU2ZDY01QMjVv?=
 =?utf-8?B?S0lKZEJlT1BlWGN1QUwwSUZHZ0N5OWlCRW5oTGMrVTIyVHB1dDVJYzhkSitM?=
 =?utf-8?B?d1g1ZTl2VGhWcXlpUzhjZEg1UFJIUXhkU0Y3bVBhZjgzZ01zNnBrYm1kekM2?=
 =?utf-8?B?SVBlcWZ3cStjMjd1UkxMT25PeGNzM1V5TFRMem0zejBXaTdaOXIzeWErSVRr?=
 =?utf-8?B?eUdNb0dZMytQbjdoMkJnSVprakc1ZHlGeHIyZWJxN2FtK0prSG82NnJZNWU5?=
 =?utf-8?B?WWxFQkdNanJpVlpJNVY1QzZVQWZpQjNhOW1xN0QwNDhLT2lxdk04ZW5UQS9t?=
 =?utf-8?B?eTRXMnBPdnYzTmo0MkFzdWpGN2ZTaUJDemlYQS81R3lEdEVlZEMzMmh0OUhH?=
 =?utf-8?B?cWJmM1NFSFh1b1IvTE5QVVFJZnR1UmRJUFc3SkdEa2dIUHJKTnI0SnJtVko5?=
 =?utf-8?B?U2w4RTgrb0pIR3hlcVR3WEVYYkRORWJBaytIVENsaHVTVGhHVzZqZzdrZmZp?=
 =?utf-8?B?ajBNaWVJUDVKamUySU03SldWZzdRU3J4a1ZOOW02eDJkRkpOOG1YeTRWRWVj?=
 =?utf-8?Q?Uz5d7QlzCHF20jTCP139IPfvm?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc425ac4-bedf-4db8-c3a4-08dc79a5b64d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 14:53:01.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MixF+tciLPJcaqb8uz0JY37bY2QyBPD1bSXjHxoTwq1gLveEjj4nXyQ0YjV8vxkgC4KH8AUNtWrEPPrqKUDT0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5518

On 21.05.24 15:48, Yi Jiang wrote:
> From: Florian Bezdeka <florian.bezdeka@siemens.com>
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> Signed-off-by: Yi Jiang <yi.jiang@siemens.com>
> ---
>  board-rpi4.yml                                | 15 +++++++++
>  conf/machine/rpi4.conf                        | 32 +++++++++++++++++++
>  .../customizations/files/primary.network      |  2 +-
>  recipes-kernel/linux/files/arm64_defconfig    | 10 ++++--
>  recipes-kernel/linux/files/rpi4.cfg           | 20 ++++++++++++
>  .../linux/linux-xenomai-3-dovetail.inc        |  1 +
>  .../linux/linux-xenomai-3_latest.bb           |  1 +
>  wic/rpi4.wks                                  | 17 ++++++++++
>  8 files changed, 94 insertions(+), 4 deletions(-)
>  create mode 100644 board-rpi4.yml
>  create mode 100644 conf/machine/rpi4.conf
>  create mode 100644 recipes-kernel/linux/files/rpi4.cfg
>  create mode 100644 wic/rpi4.wks
> 
> diff --git a/board-rpi4.yml b/board-rpi4.yml
> new file mode 100644
> index 0000000..debff7a
> --- /dev/null
> +++ b/board-rpi4.yml
> @@ -0,0 +1,15 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Florian Bezdeka <florian.bezdeka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +machine: rpi4
> diff --git a/conf/machine/rpi4.conf b/conf/machine/rpi4.conf
> new file mode 100644
> index 0000000..3c0607e
> --- /dev/null
> +++ b/conf/machine/rpi4.conf
> @@ -0,0 +1,32 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Florian Bezdeka <florian.bezdeka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +DISTRO_ARCH = "arm64"
> +
> +IMAGE_FSTYPES ?= "wic"
> +IMAGER_BUILD_DEPS = "rpi-firmware linux-image-${KERNEL_NAME}"
> +IMAGER_INSTALL += "${IMAGER_BUILD_DEPS}"
> +
> +IMAGE_BOOT_FILES = " \
> +    /usr/lib/rpi-firmware/bootcode.bin;bootcode.bin \
> +    /usr/lib/rpi-firmware/cmdline.txt;cmdline.txt \
> +    /usr/lib/rpi-firmware/config.txt;config.txt \
> +    /usr/lib/rpi-firmware/fixup4.dat;fixup4.dat \
> +    /usr/lib/rpi-firmware/fixup4x.dat;fixup4x.dat \
> +    /usr/lib/rpi-firmware/start4.elf;start4.elf \
> +    /usr/lib/rpi-firmware/start4x.elf;start4x.elf \
> +    /usr/lib/rpi-firmware/overlays/*;overlays/ \
> +    /usr/lib/linux-image-*/broadcom/bcm2711-rpi-4-b.dtb \
> +    /usr/lib/linux-image-*/overlays/*;overlays/ \
> +    ${IMAGE_ROOTFS}/vmlinuz;kernel8.img \
> +    "
> +
> +IMAGE_PREINSTALL:append = " firmware-brcm80211"
> diff --git a/recipes-core/customizations/files/primary.network b/recipes-core/customizations/files/primary.network
> index c517d10..2343386 100644
> --- a/recipes-core/customizations/files/primary.network
> +++ b/recipes-core/customizations/files/primary.network
> @@ -1,5 +1,5 @@
>  [Match]
> -Name=eth0 enp2s0 enp3s0
> +Name=eth0 enp2s0 enp3s0 end0
>  
>  [Network]
>  DHCP=yes
> diff --git a/recipes-kernel/linux/files/arm64_defconfig b/recipes-kernel/linux/files/arm64_defconfig
> index 9bacb82..94f7b5b 100644
> --- a/recipes-kernel/linux/files/arm64_defconfig
> +++ b/recipes-kernel/linux/files/arm64_defconfig
> @@ -603,6 +603,7 @@ CONFIG_FREEZER=y
>  # CONFIG_ARCH_ACTIONS is not set
>  CONFIG_ARCH_SUNXI=y
>  CONFIG_ARCH_ALPINE=y
> +CONFIG_ARCH_BCM=y
>  CONFIG_ARCH_BCM2835=y
>  CONFIG_ARCH_BCM_IPROC=y
>  CONFIG_ARCH_BERLIN=y
> @@ -704,6 +705,7 @@ CONFIG_PCIE_IPROC_MSI=y
>  # CONFIG_PCI_HOST_THUNDER_ECAM is not set
>  CONFIG_PCIE_ROCKCHIP=m
>  # CONFIG_PCIE_MEDIATEK is not set
> +CONFIG_PCIE_BRCMSTB=y
>  
>  #
>  # PCI Endpoint
> @@ -1552,7 +1554,7 @@ CONFIG_OF_MDIO=y
>  CONFIG_OF_PCI=y
>  CONFIG_OF_PCI_IRQ=y
>  CONFIG_OF_RESERVED_MEM=y
> -# CONFIG_OF_OVERLAY is not set
> +CONFIG_OF_OVERLAY=y
>  CONFIG_OF_NUMA=y
>  # CONFIG_PARPORT is not set
>  CONFIG_PNP=y
> @@ -1949,7 +1951,7 @@ CONFIG_MACB_USE_HWSTAMP=y
>  # CONFIG_MACB_PCI is not set
>  CONFIG_NET_VENDOR_BROADCOM=y
>  # CONFIG_B44 is not set
> -# CONFIG_BCMGENET is not set
> + CONFIG_BCMGENET=y
>  # CONFIG_BNX2 is not set
>  # CONFIG_CNIC is not set
>  # CONFIG_TIGON3 is not set
> @@ -2640,7 +2642,7 @@ CONFIG_I2C_ALGOBIT=y
>  #
>  # I2C system bus drivers (mostly embedded / system-on-chip)
>  #
> -CONFIG_I2C_BCM2835=m
> +CONFIG_I2C_BCM2835=y
>  CONFIG_I2C_BCM_IPROC=y
>  CONFIG_I2C_BRCMSTB=y
>  # CONFIG_I2C_CADENCE is not set
> @@ -2880,6 +2882,7 @@ CONFIG_GPIO_GENERIC=y
>  # CONFIG_GPIO_ALTERA is not set
>  # CONFIG_GPIO_AMDPT is not set
>  # CONFIG_GPIO_AXP209 is not set
> +CONFIG_GPIO_BCM_XGS_IPROC=y
>  CONFIG_GPIO_BRCMSTB=y
>  CONFIG_GPIO_DWAPB=y
>  # CONFIG_GPIO_EXAR is not set
> @@ -5473,6 +5476,7 @@ CONFIG_PHY_MESON_GXL_USB2=y
>  # CONFIG_BCM_KONA_USB2_PHY is not set
>  # CONFIG_PHY_BCM_NS_USB2 is not set
>  # CONFIG_PHY_BCM_NS_USB3 is not set
> +CONFIG_PHY_BCM_SR_USB=y
>  CONFIG_PHY_NS2_PCIE=y
>  CONFIG_PHY_NS2_USB_DRD=y
>  CONFIG_PHY_BRCM_SATA=y

With all those changes to our shared arm64 defconfig, why do we still
need the rpi4.cfg below?

> diff --git a/recipes-kernel/linux/files/rpi4.cfg b/recipes-kernel/linux/files/rpi4.cfg
> new file mode 100644
> index 0000000..9d77279
> --- /dev/null
> +++ b/recipes-kernel/linux/files/rpi4.cfg
> @@ -0,0 +1,20 @@
> +#CONFIG_ARCH_BCM=y
> +#CONFIG_ARCH_BCM2835=y
> +#CONFIG_BCM2835_MBOX=y
> +#CONFIG_RASPBERRYPI_FIRMWARE=y
> +#CONFIG_OF_OVERLAY=y
> +#CONFIG_SERIAL_8250_BCM2835AUX=y
> +#CONFIG_MMC_BCM2835=y
> +#CONFIG_MMC_SDHCI_IPROC=y
> +#CONFIG_MMC_SDHCI_BRCMSTB=y
> +#CONFIG_I2C_BCM2835=y
> +#CONFIG_PHY_BCM_SR_USB=y
> +#CONFIG_PWM_BCM_IPROC=y
> +#CONFIG_PWM_BCM2835=m
> +#CONFIG_DMA_BCM2835=m
> +#CONFIG_SPI_BCM2835=m
> +#CONFIG_GPIO_BRCMSTB=y
> +#CONFIG_GPIO_BCM_XGS_IPROC=y
> +#CONFIG_BCM2835_WDT=y
> +#CONFIG_PCIE_BRCMSTB=y
> +#CONFIG_BCMGENET=y
> diff --git a/recipes-kernel/linux/linux-xenomai-3-dovetail.inc b/recipes-kernel/linux/linux-xenomai-3-dovetail.inc
> index a8612ba..36000dd 100644
> --- a/recipes-kernel/linux/linux-xenomai-3-dovetail.inc
> +++ b/recipes-kernel/linux/linux-xenomai-3-dovetail.inc
> @@ -12,5 +12,6 @@
>  require recipes-kernel/linux/linux-xenomai-3.inc
>  
>  SRC_URI += "git://source.denx.de/xenomai/linux-dovetail.git;protocol=https;nobranch=1"
> +SRC_URI:append:rpi4 = " file://rpi4.cfg"
>  
>  PV ?= "${@d.getVar('SRCREV').strip('-')[0].lstrip('v')}+"
> diff --git a/recipes-kernel/linux/linux-xenomai-3_latest.bb b/recipes-kernel/linux/linux-xenomai-3_latest.bb
> index c65c28d..5908c59 100644
> --- a/recipes-kernel/linux/linux-xenomai-3_latest.bb
> +++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
> @@ -80,3 +80,4 @@ SRC_URI += "${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
>  SRCREV = "${AUTOREV}"
>  
>  SRC_URI:append:beagle-bone-black = " ${@ 'file://bbb_4.4.cfg' if is_xeno_3_0(d) else '' }"
> +SRC_URI:append:rpi4 = " file://rpi4.cfg"
> diff --git a/wic/rpi4.wks b/wic/rpi4.wks
> new file mode 100644
> index 0000000..22eeb87
> --- /dev/null
> +++ b/wic/rpi4.wks
> @@ -0,0 +1,17 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Florian Bezdeka <florian.bezdeka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +part --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 128 --overhead-factor 1 --extra-space 0
> +
> +part / --source rootfs --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active
> +
> +# silence wic
> +bootloader

Rest of this looks good.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center

