Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2078.outbound.protection.outlook.com [40.107.6.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7A013B780
	for <xenomai@lists.linux.dev>; Mon, 27 May 2024 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807426; cv=fail; b=kS4g70u3oGhtpNkqOzTNENl0TSde/Q5sB1qUNNqXODCMZazDfcmwhi5ati/ZTuRr9q7XkSBt2l9LSg7FTkZ0ZXFMMZe5q1PINmVsWioJzIc25zfBrfhZ3HI0JucciHxtiURCRL7CaFKgHby3dMQEj0WyxpvygCl0LRW/rsI9MN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807426; c=relaxed/simple;
	bh=vSgijIiXOYb/QTx6qDCWStdZksE/FmvE3XKGf0P05zM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ojn+qihZ6Q6xk5WVVE2lZjPANcCs9xes7W/jGT8m0ufUqq/nwfOg2+Adz3KL5024lfFydIxW3fw9E0tE3VZp/YU5ke7jVWjAPvvIW/8jFMQ4WeF5531JMI+ZSF+AA4VWvon9PDGi0iXfcoeqYVZvejM3Nu5cLHA6pGN9m9K4PJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=MOCzhwpg; arc=fail smtp.client-ip=40.107.6.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="MOCzhwpg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmQXymVaT1govfrxvlmaDfymtRcxKdg2eTbOjmF23YixlGnHUV1DuHI9IvoNUhecUNddxbrA3LadIqRGUkGjJAu3jqAcx26QzZ2zZCYHKe+vz75omykLmARqlNhZo/y+jl8WPYw3ofsHCxAANluf6WDn9kV12z1QKCKgzj0AjNF6oRrhE/zJS9hCZC0Lrbpx8uDCua9iWNes0KaZz3YsrQ6zhiEpyd6gjj5hJUzuybeWgi1ZsjmAjiykCBhQlc0pCT4HbQPiD1GsoZj/LtLjfcjL0/85Z5oDrtXbE6ntxhgjruqp1uClaLzgFts5lXnbRCO9ttXdyNJ7vphZu7urXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jmmInLIbzNQurCzx+nrOBVfIobGFwbBMU6Or1ug174=;
 b=mOvhywuyYn4etkZW133YNR7qYGqXGfV/K3Fm272c6JQ+E2xG/KnMRHClj7+99sKY1S2Jhy4k12VDR0ybtQtaq7SaKPjhm3SzqL9Ie8HJyjPXXFu5E1PuO3cyjbZm7qzO/sixi3I5tqwqYgi4NrYL6WZT7e9RybGaYHcvm2GuCdgtPbiKVXXlmrK81WABOPuCDoQGf+RZk3T+SghC7cZBN12jSb77r/XpPN2sI5ha+qZQ2U3fMs7pp6TN3TP2JpMt4PEnVsoWg2xyagvBveJ/cKQc9qngoiWa6ISHt42vCdjp32MUwVhFtFg3vVQxRwPwPD/v+IvG6XFcfGp5K7W/Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jmmInLIbzNQurCzx+nrOBVfIobGFwbBMU6Or1ug174=;
 b=MOCzhwpg4DV8I+xtWe6B2t8zKRuHDqdNasMjbK5iep5K9175NYexYhXoRizBajLwhBDrJmePPAI0hIpa+a7x/13LTysByFWgYk81psPZMim/Oz98M9WL6jjci9UQJU3XchMUTp9Q5HUCcBhiCInzSkn3Shu+wxwkIjiaVpmW+caozZtYFVNqZrAoNivBGZW1LlpoLy8KZ9UNS2inGuDIkc5MtIgsNg2P+HfGdc7C6lZmsvmZeOPS9aKC7OVDfT8JUqTBkWMacRJI1kCZugm4a74G8B0TxsVTSQbIqaoc8x9cSFXECdlafGcEGDpxK5FMeexSI8b24CJ915J1db8XGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8675.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 10:56:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 10:56:58 +0000
Message-ID: <fdfbe0c8-42c9-440b-bd16-0834cad46645@siemens.com>
Date: Mon, 27 May 2024 12:56:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] prepare-kernel.sh: Don't depend on bash
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240525115806.12101-1-richard@nod.at>
 <20240525115806.12101-9-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240525115806.12101-9-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0003.namprd05.prod.outlook.com (2603:10b6:610::16)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8675:EE_
X-MS-Office365-Filtering-Correlation-Id: 60478db1-6d59-423a-bf8e-08dc7e3bbb1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWlKTzNRWHM4a0d6VUE0OWlER1pWYnJUcEFWV0x6OW1MbUhYWDlnV3NpSWdW?=
 =?utf-8?B?Mms3M1JoM2xSRW9VUWNvUWd1WGJEVGxqL1I5VDFHbk5MTDlQK1VJVGZ2NnVx?=
 =?utf-8?B?U0lxRUlDYVZtWmdRd1ZuaDVqNU5Ta1d0cXR0VzlveW5Yck4vb3NtSVZyYmx1?=
 =?utf-8?B?VmJRNzFOeGtPb0I5ZlA4RUpZcG0vUjJUQWtKWjAzMUlPUXJoemVYeFVtN0V1?=
 =?utf-8?B?a0lSdE9tQlltWjFmTFhDSzRLbEN3UXRLUTdPWVRzZk5Cc2tQQ001RS9yYUFu?=
 =?utf-8?B?M290ZVNJUEIvUkxqVi9tNUcvQlN5bGF0WE5uRk5BWllweFRvYU9wbEpIR1Rx?=
 =?utf-8?B?WGdnTTFXZ2dnNHNlUWR2UWpOSE9TZGhma01ENEtuVmZ4cVpWQnI4ck90MUhT?=
 =?utf-8?B?Zi9nTVF5MUhKcWowODlTR2sxWGJNQjdBQjJ0eXUrQWFqK0ZKUnFLZzNkUGxK?=
 =?utf-8?B?ai81UDcrL2s4cGV6aWpjMThQMGdTc3lFdUhGcU9pMGNONW1pOVM1Q2F2VVBY?=
 =?utf-8?B?czk4dExzdWEzSHVhRnRQVENFMHdBcENkZTdrK2h1SHFzanpuSW9ERnJEb2dY?=
 =?utf-8?B?VFhSZFRrZ0ZYODNGb001WnR6VytXcVZBZmt6MXdBRC9NSmptM2VlWHA5cVNO?=
 =?utf-8?B?TzEwNzArUXpoQmpYNVR5ZFp1VUJuUTdzZElLS1pSU3dFQkFOcGxlTWY0K0FG?=
 =?utf-8?B?SXVJNnFEM2syVDdJVmhETnVYSGxRZDlZZzRIRTYxUVhDejNsTWFDbnVtV2Q1?=
 =?utf-8?B?Y0FXTFlYZTFzRFI0R1dyRnNJYjEwWGQ3bS9WOHRUdTVRN093RVJWd29jeHJN?=
 =?utf-8?B?MFY2QmRiSGYrWm5TMFFmWjljYm1jSUxqQm1DTzJtSTdubm9uR1RGOC9iNVRU?=
 =?utf-8?B?L3F4b0crc29VN1Zhd2hmRTdPUStDTDIreWkrdytKU0cwWHhPbmNNN0hVTmJ5?=
 =?utf-8?B?NmxJNWxrM3l1anVaN1dRdzRoclczcUl3c0h5cXp2dnFZdm9UWGYxSEFSaG9v?=
 =?utf-8?B?V0VtRitXQlZvTDJBelpMQ0gwdEFnMWFMdGdGYkNMSzRvU0RWdmMySVpTeEZa?=
 =?utf-8?B?MU0xM2xRRW5UK3ozTWpLQ3BPNnZyYmxLU2pnQlNkbC9taXdVYmx2Q3JjYkFI?=
 =?utf-8?B?ajE4TkxuaEc2Y2liaUYrYnkvWC96YUE1WTJDY2NmaTBRTHBKbWN0cXV0b3ZU?=
 =?utf-8?B?QlFyYXd3K0h1QTkyV0dleERidVh3T295MXA3cDVSajAyWm4rNzJDNFRUbVZy?=
 =?utf-8?B?dkNGRkdXcGZmY1ZIaW9waFJKL2JZNlJ0MzBSSEQ5RzZCbHVBb253eE9TK01L?=
 =?utf-8?B?S2RmWSt1MzFGOFlVeXpONGxza1V2TFFxSVJjbDZlYTMzNm15Y2VPdTduUXVo?=
 =?utf-8?B?a2p2K2R1Y0poMEVOcSszeExXaEVNVE5jWEpTeEJ0VHl3MjREdG1hL3RwWUM5?=
 =?utf-8?B?VDFhdm1xcW1FVVJBdldWU09pMzV2L3o2NHhpcEhwSlJ2RS9BRkNqZmY3UEto?=
 =?utf-8?B?akUzQ3Y4cXVSSG1SVEtQUFVQZ25yR0VFWCs5SmVCWk1MT3l0ZjlWRC91NHRP?=
 =?utf-8?B?b09NMUNYRWNmRTF1cHBkWXdBeEk5Ti9pbDh5SVpYclJJcFdLSy9IN1d4T2tV?=
 =?utf-8?B?RHh1OFF1QTJpZ1Q0T0Zsbk9kampnNytTN0xsMkhMUmtuaTlmUS84RHc1d1R3?=
 =?utf-8?B?aXNnK0dNaXNOU25WVytNeDdIZVM5L0JMb1Mwc1F5bmNyNkk4eG5rWGlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWZ3NzJjV2wvalp4VHJSMGExZ1lEY1JJdmhFeTMxYmd1c3dTNWo1RE14emky?=
 =?utf-8?B?aXdyQ2llc2FGZkV5RklaaEp0UVdSaTJuZlIvblFwK3pHeVhRQ1FEWkM1Yk55?=
 =?utf-8?B?czl1dTFxR2s2Qk5MaER6b3lRc0dxQ0huUjVRNEdlWFdJc3VWbUFNOE1pQ3Jq?=
 =?utf-8?B?NXY0NEVldDFWN2xucHprcURCMm9EWDU1N3FNeVYzTjlPcVo5TE9rMDUzSnQ2?=
 =?utf-8?B?dkdObmRFTitTa0V4Rzk4L09jaFduK2VKVnM3cFhhbW5VY0NVVi9zNDVNTVIw?=
 =?utf-8?B?c1Q2MGdFc2FyMW42MVlveFBpajMxaEE5WVVJRTI3YkpqZ0FianF0ZzgvKzB6?=
 =?utf-8?B?UHNrZStDaG5kRHYzb09tRVpseXNzbDhKMFdMRDdqVkwwNmlCc2lkY1crUnNt?=
 =?utf-8?B?MkowMjdwT2QzSklXYWorOXd5ZGw3WlZWc1lHTy93YnpkTmc3MlU5MlFLMmxI?=
 =?utf-8?B?VXd5b0FxT3FqbExlVjdRQk5QeVM0R3E0ZjRMQWNKSWxYYTVFMnBhY0VMdmZ2?=
 =?utf-8?B?SVpESTEwci94VWt2OGpYUHVxOWozM0p3QWlzRmZiT2ZVd041YXBvWlNGaGkx?=
 =?utf-8?B?cE9HMUJYWHlKMkNMdGdOLzdjZE42M1lZaG8rcmVRbTZLczBDc2M2OEJtOHk4?=
 =?utf-8?B?aFB5Y2d4OGpyWmZWZElmN3VCTjhlcE9saC9GU0h6Q0loRWxCVGlhcHdQMkRs?=
 =?utf-8?B?aFdpOWFKaXMzc0FvUHJvdE9xMURHSjRMekFQMFVSSkxLN3lHbjNHQnBKYlVE?=
 =?utf-8?B?VVBzL0ZSSmRpSjNjd3UrRDNvWU5CNmdFdHkxNHVKYkthV1V3U211TFJ3UGd6?=
 =?utf-8?B?K2FwS2l0eER2aS90NUYvbnBheDI5V2lma0huWDhrY1FFMis2S3NCcjhTWXMw?=
 =?utf-8?B?SDVtTG1XbUxTbDhoeWoxU0F2RmVzTzdkNnIwVGRhWjVUQ2FwWHZ5TnJmK2RN?=
 =?utf-8?B?SzlUZG9lQkF3TTlWem5OV3pPcUgzcFZ1Mmc0M29XQXlYaUIvRW1LYnpjZmVU?=
 =?utf-8?B?MWl3Mi9wbzNEMWJUcm95SUJZK08wd1ZObXptbjV2UldQVUNEam1BdWU3SFRX?=
 =?utf-8?B?VFhQSkxoSlJ1LzFCNFRvcHQwTjZFaFpHaWR6b0NiSlVoc1o0dTFOaDY1RG1O?=
 =?utf-8?B?ckV4amJENkZUVGJLdDI4T1kxMmRubStyTHpaZk5ZL1Z6elQ1WVZrODRMZDQ2?=
 =?utf-8?B?RnpuZTdZbURGclNLS1FZalJWMXFhWlFjS013YzkvTDNTamRDanIwbnJsZVo3?=
 =?utf-8?B?Ri9HMHZpdi84TkdWNTZpMnhteFoxTlBpbnNTU0VpNXNvcUFSdE4vQ0NZNW1u?=
 =?utf-8?B?RExSREdsWHdSdDZBcndFRTJHeGhLdS95YThrUGQ1WWFBVWtIbjJ6emo5R3Ux?=
 =?utf-8?B?dmhkeFJhMktPdnhtOHBla3orQlovVDZNS0twL1VtUWMrR2JNMExpbFg0Q2hR?=
 =?utf-8?B?MHBRTmk3eUJaWHVoVmlOQis0dkN1TzllTThFZ3FRL2JXNjA2ZDJFN0IvZ2th?=
 =?utf-8?B?UUh3elU4cU9pZ0Y1WE9nR0MwdkkxY1RmV0w5N0d3UXNJS3NRZm9SazNiQ3NJ?=
 =?utf-8?B?VjdyS2Y2Yy9rcTRWQnpkMStTRExuR29vS1F2RFVVK01pcUV4eGNOYWFLejhN?=
 =?utf-8?B?TWo2czllbVJNdW41ZnpuZHVXcDkzTndlVm9iTFRSendKWVlpN1k2bGFpc0FS?=
 =?utf-8?B?clU1dnV3ZHZMRGJDSGd5RnpsNG94cW01enI5NlNDOUYzYVlKdW50VmxsNUpU?=
 =?utf-8?B?cVI0b2RUS2xBTFFEaGFocDF1TC8rZUY5YVJsM3VKdDdHTmVuOWlDY1g1cU91?=
 =?utf-8?B?Y1JodWk0Sll3TnNzeVJ5UlFQQlNDTnlWaHRYRHFFdm1XcDBYVFZUZkhlb05P?=
 =?utf-8?B?YVlVWGh6L1l6bmlCa1gvS21OQThiU243R2R2YW95NkhFNTZKeEl1WGJneHVY?=
 =?utf-8?B?d2N5aGNEYlpBVUFaQUFXZFljVnlhdnUwd3YwR1JVd0M4RWprMFRYOGhOOTVP?=
 =?utf-8?B?MHJsZVdVYWdtUEtpT0Z6bkV4TXRnTDNRM21nOEpTODByWVZYYkF6d2FrVWJU?=
 =?utf-8?B?em8rUHhHVmh4VzZpbTRKaWowS2JsMjVVSmxKNmxzSk9CT2YrVHNBd2c0L0V0?=
 =?utf-8?B?TGEwTzZlSHFTMlFPeDRBTkhVeDNkQ0g1OTluOWcrSGwyWklTZ2ZXQUVSSlpG?=
 =?utf-8?B?Tnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60478db1-6d59-423a-bf8e-08dc7e3bbb1f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 10:56:58.9390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aROLdswEQE1XHsuGSX57VXDQzrdddxhulRcqn1dgVgKqnEGr2R7gsb0BzcH97FFC2JnTmYcVoxTzPcDbLrMCbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8675

On 25.05.24 13:57, Richard Weinberger wrote:
> - type -p is not POSIX, so use realpath(1), I think it is safe
> to assume this tool.
> 
> - echo -n is also not POSIX, but if some echo command does not support
> omitting the trailing newline, so what...
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  scripts/prepare-kernel.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index 3c13d471f..f7aca804f 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -1,4 +1,4 @@
> -#! /bin/bash
> +#!/bin/sh
>  set -e
>  
>  unset CDPATH
> @@ -210,7 +210,7 @@ done
>  # Infere the location of the Xenomai source tree from
>  # the path of the current script.
>  
> -script_path=`type -p $0`
> +script_path=`realpath $0`
>  xenomai_root=`dirname $script_path`/..
>  xenomai_root=`cd $xenomai_root && pwd`
>  
> @@ -220,6 +220,7 @@ default_linux_tree=/lib/modules/`uname -r`/source
>  
>  while test x$linux_tree = x; do
>  	if test x$usedefault = x; then
> +		# shellcheck disable=SC3037
>  		echo -n "Linux tree [default $default_linux_tree]: "

Better use printf instead.

>  		read linux_tree
>  	fi
> @@ -318,6 +319,7 @@ else
>  		echo "$me: no IRQ pipeline support found." >&2
>  	fi
>  	while test x$pipeline_patch = x; do
> +		# shellcheck disable=SC3037
>  		echo -n "IRQ pipeline patch: "
>  		read pipeline_patch
>  		if test \! -r "$pipeline_patch" -o x$pipeline_patch = x; then

Jan

-- 
Siemens AG, Technology
Linux Expert Center

