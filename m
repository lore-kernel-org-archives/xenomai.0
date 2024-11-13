Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2053.outbound.protection.outlook.com [40.107.249.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5BF70823
	for <xenomai@lists.linux.dev>; Wed, 13 Nov 2024 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510937; cv=fail; b=KyQ7Hb6bRAkE6KTAdwWyHAQnfOai72VoRMcBpNNAfi+vIY+BM/qxbjzduJC3mJ66wp85iQJuPbeFGAl0VjdQwtUc71Gpd+En4/Gwx0MfEfKfT5kOjEJGh+K0oULL9xhYtLI5x8n1A1pdP7zy8qGvIuiHona4ujco0++p2j8RJ0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510937; c=relaxed/simple;
	bh=56iHiZtk7SsoOGak2yT6a+etdDuSq3Di5oNKcAs6tjI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MYRBVgngJM+2YCddPeyAsumZbFpGO043QI++bP3h8Lquf1wvPvl9rAlAc28+nQEi0vqfMDHVt5RmA8h+0hU9KxyMx6JJelowVUDGimYHxRLz4sgh0KQsjpiZ++zFgz8cpdx2n6QDUMPXWccIr8Oab0VYV2wzseHM412iWPZabPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nHrcfdxk; arc=fail smtp.client-ip=40.107.249.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nHrcfdxk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wbzb5CnxZv8ZH7jZHVkx/CCFMTn8IuaRCUnZZJg2hf7AdERGHu+7Ugm43dZ7P6nvUidKa0YcT68YSu3q/6Wch8rwzgCPBGJQ7TkZbPzzz0u8xn6sT0idsg+xLcJTK/qZUb0A7MrnY+cxiygWxzXShBrjx/mxBzSknCmpz6aC7pbxmiaZgO/pNUIdea0E+LTuzTKKsjekqx8//DiVNKuqJbWUyhPb6yUFfUcWFnRDL8QoVu5vIoCgVvhYhk1sU65XZazyFHDynP7LHVriLEQq7K1H6WQl6ALUycwW09I+00GJH4UiPbyP47pE144PYxBWgiSRUTndlHbgGBvX72JMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cc53f8/ZFlAmaMQ8jUYBON96nq8SvdeZyF8eLelqbw=;
 b=FhTcaLYysH3PtBkbhNXt+d3hbHl6R7s2UU9ZkvYi1iznH3CR4r1cYxE/r1vOj0Dgr6qm+ep58VkuVRanxGz/81OqKlRQxFwrvXQiEd81w0Bvc74lB6k5Vp5Rj1qzKoaGeYLxybfsSZ6BBk2qaj5VIidhkAehVpsgSx85Bl7bse+5FCLH+suyE1hn6tsV164lcopp7HYj1ohSR+aPi7JOKhjkxbGnjEUcVQ3drwIUfDnB/Ik0MwqS4+FeMbn7CLg5SDgafwoxT36lrp7sJpn+FZBY+Y2yo6QOVYNJZroyyx5PT7+ZtF4sbWlQ46zsmSZjBbiWXbzsnVgMqZ00ae9HRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cc53f8/ZFlAmaMQ8jUYBON96nq8SvdeZyF8eLelqbw=;
 b=nHrcfdxkKj3angD7XxJm/kc9W08bpTDDLBDV4P02abArbtT4JGqMVdPGjmZm4fA2OkFMSRgvrIh+Wfpqj8eQd1OW170B6WU40ZIv+8dT6g9dCzurqTf1OstNw9zFS1b9EBuKbLRpU8uS7Qn9UNUzUXKhZWne7WD88mMSRvda3P+Ct3FE+6rIC9N46pQONAx/qi0DNzCZ7qGs7Y/uK42Y5rP99ApQ9C8+j9/W29LEGYJO1EDLNgL9ayjCghM3IdQsMe/JElUtIMSp7mNaipZSCrc52+sr/N7rr/u+jNuDhNLwVTUdJN8EIRUg8FCg77XKMdu7GvB8uuZwc9zbTRWGmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7048.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:594::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15; Wed, 13 Nov
 2024 15:15:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 15:15:30 +0000
Message-ID: <9aca3f2a-0d07-49cc-9f0d-905b3185d6f1@siemens.com>
Date: Wed, 13 Nov 2024 16:15:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 1/2] ci: Add scheduled job to build
 lavacli container
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <cover.1731508393.git.jan.kiszka@siemens.com>
 <f1e1d2111b007f20009485359b45482d09934429.1731508393.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <f1e1d2111b007f20009485359b45482d09934429.1731508393.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::26) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 19697ca5-de08-48ce-55f6-08dd03f602f4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3FhTW1pRGVIbEhBVTFtSC9FQTJqWVIvakhpRkQ5d1NrR3hLeHczbHhwL2dm?=
 =?utf-8?B?MEdOdlpZMTNJc0xBOWk4ak05Nk5kYzJaWDZSaFliekg2Lzd5Q25MTXBEQ011?=
 =?utf-8?B?ZEYxMVovRHdSV0Fib3hUSDhYV2I3ZHNaeWZpdmxISnliVUp1ZGJmb2pjVS9U?=
 =?utf-8?B?WmdRTzhCUC9icTl0WldHc21iR3BQYmJFK2tNTWZGMFNrOFc3c3BsWE83UWVF?=
 =?utf-8?B?RUNCaDBScTVScStnVVhOeWVweWE4cmlRb1Q2VE05cDM1MGRwRUt3N201Vm1Z?=
 =?utf-8?B?Vk8wMXRlajkxMFVJRjVWekFPS0Z4Tlc0OFNaUTFLZDU2enZEaWRMblFYNDVQ?=
 =?utf-8?B?UVQ2SzlZTXYrN00vNmE3YXowZ1pkcmhPa28zWEQ5UTVDWWVOYk1veGNaL2hv?=
 =?utf-8?B?VkpRWUpaT2RZNjJyTGg3dHBTdkg2enkxK1lzRkVybkRTQU5FVjJubVJzbUVt?=
 =?utf-8?B?RnRHalNQVVJYN1JGNUlUSEZHRXZNd0ZsVFRKamY4b2ZwdGVsMTZiYng3cW11?=
 =?utf-8?B?Z3VwWVFoVWg5ZDM2K3MvQXhYVlV6amlTTnFtMEI0T1BxMTJqRFF5dUhSakU2?=
 =?utf-8?B?c2x5Y29TL0ZGSkRPU3BPUlZmTUZvcXd1U1BrTm1WTE1aaUdCVFB4d0IyblVw?=
 =?utf-8?B?UmdMdDBib3dmZ2hzUHk1dmhjTkRCRkJCa1NjUTlyMHpmY29oaWIxN2VybzdC?=
 =?utf-8?B?S1FvZnNDbVNLMUlsamQ1MklQd2VZdVF5U1dMblhPbWMwaUFHMFR5RGVtS0Rl?=
 =?utf-8?B?c3k0bTB0SDFwbEU2QjZKcDZhTVBsQnhtRy9DQkxMVmx6M3dCQmkrY0hHSHVm?=
 =?utf-8?B?ZzMrNG56Nnh1TkhPc05RRm9EYlI1Qk43N05hYW0zYW9NSEtSYXJvaTFSaC9l?=
 =?utf-8?B?M2VUWlNKQjJsU0pHcDhRQ21ESHpUbnB2NTZ5MERIQ01JbG5qNWtVYy9oc29I?=
 =?utf-8?B?N0o3V1ZVNitLWkFYQU9RVnNrcGxIeUN6RDFJWVp6VUdkRCtrRzlkUW5OVWxE?=
 =?utf-8?B?U0RBUXZHdCtCbmIyZWVzR1pPZ2gwTjFCZ0M5Y1RacFI5c3pJM0t1KzJ3bDg4?=
 =?utf-8?B?VUVPS2VkaHBGdlVBYVZFbXZoYkRkQVJ3eVNDSmpkcE1OK3dHcXY5RDdUNUFM?=
 =?utf-8?B?L09nMGdYZmNSckczUVUyUDJSTFdmc1JsOG80QVRyaXRyVVY5Q1FVOTR5TWti?=
 =?utf-8?B?VmFoWGxlMSt1MG1OUVJyQXd2ZGk0eldTMWlmSi9lUWphSG45U0ZSWmwxZ3Zj?=
 =?utf-8?B?ZERNbUJSUFdTNjBRMDBrVlk5azNvdmowMEk3cDBXdkR0MzhkZnMweWRTTnEw?=
 =?utf-8?B?OFFVME8rWWZmSWs2c0ovL1AwekhoUm11L3Q2cGxVbzlmVkVlU1F0dUNKb2Fi?=
 =?utf-8?B?QjdoUVZqeFlQRldSUlU4TG96WXkvYVpwSFNOWWwwd0lLb21UYlNDVVZkN2lR?=
 =?utf-8?B?QkZsdHJicm5OQ2M4ODhlM2tJOVhlenlXUmR0L1QvSGF0VXo3VmFYQmcwRjY2?=
 =?utf-8?B?V1RWdk9ZSTRJR28ycHFoSFN2aEpIRnZ4Q1BTVkhvV1dXbHBoL3A0WlVlcjl3?=
 =?utf-8?B?Yzg0b1EyNExtRjJETTF2VklnaHUyVWNMRW9nbkNob3JqeUlGRWRuaDlKZWpm?=
 =?utf-8?B?UHhlU3BSNXJVeHhYY0RzTUNzam11Z3Y5RE16bHFCT3NuTUFkdldPbDFJTFNr?=
 =?utf-8?Q?QyLpMG5GJIe0UkfDu+WQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDZqcE5lMlFqeFRpRXhFYjRmcVBjVlBuRWpndHpvSTFrenNGZk1qSHJBRlhW?=
 =?utf-8?B?STZwUnZMSjVaRnRuUk9lTE1RUmc2OE1VVEZnNGwwejBocy9VbDdhMXU2dUdV?=
 =?utf-8?B?S1R2bVhibEJNQ0Y5QU05QVp3Rm5JNmtodVNhc1F0T2YwUUpKRExLbGdnaVls?=
 =?utf-8?B?eW9uQmFHKzNSR0dIalBFTG9Sd0p5SThVTWJaY2p6WG96dVhhdkY5OGJqVVZV?=
 =?utf-8?B?dkgrUkNnb3pncExZU0plN3B3clRMK1l5VWc2T0lNcjAxRHRtdW9pWnJWWlZq?=
 =?utf-8?B?ZGVieDU1dUJHRW8vWFlLN1g4STRPajIvSFZjTVVEV2hCY2JDbXBSVG9mOC9O?=
 =?utf-8?B?LzlhS1Jyd3BnKzNXc3IycVdGdnRjK3diQlhSTmJrZ1ZRb04xNjJJeUtsakJT?=
 =?utf-8?B?eWs2U2FqSm53cTc5NlZmeTJxd1lGcC95WlY3ekgvbXZpaEpFeUZka292aDJJ?=
 =?utf-8?B?OVM2YXpSdFRqckY2UmdMSXdaSXBHMUNienBuTGhrVk9YYmRPVXViMklsa3FH?=
 =?utf-8?B?d3BLclZZVHJFQStwUlU5bmZhVmtDd0VEWlR3TU0rVWJPaUVRam1uZW9ZYmtV?=
 =?utf-8?B?bW8rYjNGaytscENPeEdaTmxrdmZ2WUVuU2V2aUt1SWY1UXJSaEsvSDZvcXA5?=
 =?utf-8?B?YXhRazlEWUhGN0Y3RXRxTFNVSElLWmw5MnVpQmpBOTFobENmemN1ejkzQmw5?=
 =?utf-8?B?NnVHQ3oxNHpESy93QkJlRGhEaGlycTF6cnFSTklJNlVMV04rYW1BK2wrMUtO?=
 =?utf-8?B?MHE3LzBRd0hvN2hkV3NZVHdncnFjU2FCYnE5N0ZtMHcrZ2JORkk0Y3lvL1A1?=
 =?utf-8?B?aHV1NFY1ODdXenNVRnh4cVlrM21sc2lOZ1duWE1ySmlwSUxyaWllcEI0MWYz?=
 =?utf-8?B?cVJBeStYUWE1YnFBU2M2RFVEMkozU2ZzM1dDbUJGN011Q3ByVUJwb3lZVUlJ?=
 =?utf-8?B?ajh4aXRZUjRmQUNWZ3NSa2RrdWZTdGt6dXNoTXQvekdVN1ByM2lQWmswNWdB?=
 =?utf-8?B?Umx1WVBhaVFFRW9RcXdSN3g0dllJRjk5Z09uaG1ZdktIK2lxcStXa0pjTkZh?=
 =?utf-8?B?N2RUb0RvRzROejdtcTJUbE9XeE5zRG9CY1VoWUhqSS9pdzBLKy9GWEYzTzA1?=
 =?utf-8?B?R1ExQkZxS2dKM1BObUlveGJodjFzV1F2VmZWZjlsaGJwbjZPQTZDMURDMHVX?=
 =?utf-8?B?TGpWVGlDdlc0NVF1TUFxaWhKNklEbEZiRlFza1JMOEZDVDYxY2ZDNHpDdVhL?=
 =?utf-8?B?OWFVVUI2Y3BvbWV6M1hoZXdBOHp3ZDlKcCtzbGVMZjNlUUo5cUdZTERUaC9M?=
 =?utf-8?B?M2NQRFRMeWJSMVkxN3liMnZTR3pnaDRDRC9WSTVjVlV1b3hzdmJEbVI3UXox?=
 =?utf-8?B?K3VDeWdsOVlCbHNETzl4RVV6bGlqK2hIVUliUzBBNGVsUUd4U25CV3BZL2Zw?=
 =?utf-8?B?ZXFDRkp4V2Rjc3RtbEh5akZPSG5XbHNod29MRWdoWVhBNHFGRGhJcG9xenZv?=
 =?utf-8?B?cnRTTlVEL2NFR2tUa3FtT3I5ZGFVU2FKamFLSk03SmxtY29GSDFPQ083enI5?=
 =?utf-8?B?QkJHUnZ2eEJNcUE0cVR1dzcxYWQ4THN6bEFmcnhCaE1sVHBsUTN2c3RlV3Jw?=
 =?utf-8?B?LzVDNnFRclh3RitJZTdtWllxUllrZUNoR3RhbWg2SVk5UHRiVU9UcndDNjZM?=
 =?utf-8?B?MHorbmRqWDJvUnVoRVJxMUpMeTY4NlBxNlZ5d3poRHRYQ3NRTm5HRVBGQVF5?=
 =?utf-8?B?QjhqeS9uQlVhd1VXRFdNcFREUTNMVmVObnFZWkpoL2FLWVllY01hZ3VVZFNv?=
 =?utf-8?B?UE5qR0pobUFHMmoxYVBDZzMzbk9KcTBnSTk4cUt0RHoxbEs0VHFyRE13Ly9p?=
 =?utf-8?B?QjkvVjUxUEowZk14VmlFNW1ZZnBMUUZ1SUJQclBCYUF3MGQ4dWdwS3F6ZnJk?=
 =?utf-8?B?VFFSSnZLNENtd3hsMVRpVnhIZVJVczZTV2xsQVpEZ1NCb2xuME1DSWZrdjFV?=
 =?utf-8?B?bzhIUkF6azFOUEZEN2NDc3lSYXk0VHQ5bWFQcGNoa0FqVHVFWmZOUUtOYVZl?=
 =?utf-8?B?WE4vZFZ0eDBJeGVlQWJhUE5BUjhpbE8xWDIwQjFrVS9LLzdJL3RnQ3BwRGJQ?=
 =?utf-8?B?RUJCVkVxU3JPWWtCdjlCdUZMZ1RsUFNlL09mUHRoUjZ1OWRmZTRNb0hRQmtH?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19697ca5-de08-48ce-55f6-08dd03f602f4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 15:15:30.4033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9u/DmNT3RyaIrv3kGxGT6mLjLe0zT0Ybw248zfFZGg5DNUIUul32/38M3jVWxMtELiqDBGvsBO33zewL949T6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7048

On 13.11.24 15:33, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> We want to switch to self-built Debian containers with lavacli
> pre-installed. That will speed-up the start of test jobs and avoid the
> manual installation of lavacli in each of them. To keep that container
> up to date, prepare a pipeline job that will be scheduled once a month
> to perform a build and deployment to gitlab.com (source.denx.de lacks
> a container registry).
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .gitlab-ci.yml        | 14 +++++++++++++-
>  ci/Dockerfile.lavacli | 17 +++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
>  create mode 100644 ci/Dockerfile.lavacli
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index b8945bc..37d2a6d 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -15,6 +15,7 @@ variables:
>  
>  stages:
>    - parent
> +  - build
>  
>  .parent:
>    stage: parent
> @@ -56,4 +57,15 @@ xenomai-3/next-long-term:
>      include:
>        - local: '/ci/xenomai_3_next_long_term.yml'
>    rules:
> -  - if: $CI_PIPELINE_SOURCE == "schedule"
> +    - if: '$CI_PIPELINE_SOURCE == "schedule" && $ONLY_RUN == $CI_JOB_NAME'
> +
> +lavacli-container:
> +  image: quay.io/buildah/stable
> +  stage: build
> +  before_script:
> +    - buildah login -u "$CONTAINER_DEPLOY_TOKEN_USER" --password $CONTAINER_DEPLOY_TOKEN_PWD $CONTAINER_REGISTRY
> +  script:
> +    - buildah build -f ci/Dockerfile.lavacli -t $CONTAINER_REGISTRY/xenomai/xenomai-lava-container/lavacli .
> +    - buildah push $CONTAINER_REGISTRY/xenomai/xenomai-lava-container/lavacli
> +  rules:
> +    - if: '$CI_PIPELINE_SOURCE == "schedule" && $ONLY_RUN == $CI_JOB_NAME'
> diff --git a/ci/Dockerfile.lavacli b/ci/Dockerfile.lavacli
> new file mode 100644
> index 0000000..5d5725b
> --- /dev/null
> +++ b/ci/Dockerfile.lavacli
> @@ -0,0 +1,17 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +FROM debian:stable
> +
> +ARG DEBIAN_FRONTEND=noninteractive
> +
> +RUN apt-get update && \
> +    apt-get install -y sudo gettext-base jq xmlstarlet lavacli

We also needed curl - added in next now.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
