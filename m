Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D21301702
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769073320; cv=fail; b=mvDxnwnJwrx3f36juOJ60MdDuBxNTjIo6YZpu8ab23y84YavjsfbgoGfFiXP5La7Ur5UYpX+tflB/9wzIXa/143Gs6fdnqXNPVTSNFEBM5yo3RsE2h40pFx3PnWuXzIubmaRz0Osu4EiyBtHfM/lv5unfvwMh5Ywcdbf4O55uFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769073320; c=relaxed/simple;
	bh=nnRbPfVhmDYxFGNx+YOS8vMwr5t/UnZYNk0LEouaiTM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=maQuBbpGNXU6RNdmxx6tmEQgDhlsHtP8x1w7I9OC3ED45QvnXqIFjVs48FgRRUlTjobHEcPLrLDfLQYJWFDLAcD663b+TVNzoHRze6R4adCbr2GEJtR0opC2ygL3kxWCeFKovaaRALk9SchD14mjz2f1oYE5RSJHerXzGBkuF/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xC6Sfzof; arc=fail smtp.client-ip=52.101.65.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xC6Sfzof"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bg6/mH23fGIe1CnlgDpJrxeNiDw2AJmN952zAB8FRe+XH5ZGhrs/HqwWIyDBFMvm3N8ep3vN3pV2avHeuEGqYBjfy0u0N9bIYO8hmyWo3bRyZCh7hCExA2WkFIOcj8SWLO28nN01H0iF6eZUBaks1dHAMJeuth/1BXyy5yahtrm2kGw1s2in2N8Tl1I/4ppGeK2Wiwvh+aNZZ1kc56B57hMbEgE0knYDSSo/jgxa/XEwOlPtz3kTScuBSP9u2NeMsf9qetkdkj809CDruuUq4GZm7p6eMOjkwmQWLTlJvuVJbIlUu9K86/NNVCL2GKpqCBPSpWHGp1TizCOqMpai/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujWAvSRGH0sGhWFT7IveKBVMGopiTqz8gy4rGfq9G5o=;
 b=vPFIzpYWHJI0mh80NyKnr9lJTb2RsN1NG2wdYhBaL7ZfTwiFZl/57j5+fVXvuEriDrlTQPabr8tB6fqwHn1BhWkYPGV+qzalRs1Qeyn5ezO1D/ZfGXN0O93ZntKiYEJXz7CZFBWiFbUciw28i/hciFrrQ4G8jxrtv4XPeTSMkaEDuPAVYgvo0eMvLMlCdhq4o9FDsBV7wEn25sHdnax3kmFZKsu6S0hdWfuGu7YtC7KjXijgDsHXAfL9JQJW/pABj0ZANXNAZBxij/DgzhT4zxkKRT8IFJm9pKWIHYUcQwo5q4I8OSauY4Pv1z4OPjjz1f7LmgElz0wYM3NOPleD9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujWAvSRGH0sGhWFT7IveKBVMGopiTqz8gy4rGfq9G5o=;
 b=xC6SfzofbOv6yeduJyqCUIOygARxMDd6W7TuizV9o14cU4VIRduuIbo8LcI7AIsMNQyynVuLPtOvGokAl6j4xitUFakzDd+UDKiysnM2WKO48ujh5GsA/NRWkWAw1hQtuEx8J6PdKwrkQenpgi3PHnoOuaLedn1S/nikCKuzYIK35W/l4KUyl480iStwssp0ByFUtfo1dWSgzboJ5RUKDjktiHg+MLECeqPaAFK0Fywp2MnHi6sL2XQ0EJKHToNH2mApxRiBYR3tQZECnAcwZvBkCTd1AGPZxWnMKhqq7qjYBaLslnq129qjIXRjXzP5WPt3BPBZcL173qi6Ky77yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5777.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 09:15:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 09:15:09 +0000
Message-ID: <1fc64942-a41a-44b1-8ae0-84918bbdb2f9@siemens.com>
Date: Thu, 22 Jan 2026 10:15:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Meet & greet at FOSDEM
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <dce6da1a-7ebc-4d5e-af4a-bf55142a95cd@siemens.com>
 <CAFc1U0vYDM0sS_BvNh7VHH=j9aFkfteabawTctkae6wwQmx+CA@mail.gmail.com>
 <bf3e7a23-0b43-4974-9037-a49438aaad06@siemens.com>
 <CAFc1U0ss+iMGZx0_GJ83B0nDOmt+zYbt_m3ORpK1uydpHYi5_A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFc1U0ss+iMGZx0_GJ83B0nDOmt+zYbt_m3ORpK1uydpHYi5_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0343.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: 55af783f-5f3f-4691-1207-08de5996bd37
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlRzR3NlWG9FV3JRb0drbHBCb3E1a2lJRmxNVHVPNXpJbnRKYUdWOWhzQit1?=
 =?utf-8?B?clJRQzJOSmtaZlROSDVDSVdFd1BqbUl6RFBubHFIcFdCR3JWaG5UenV0Z2Fu?=
 =?utf-8?B?MTYxRXFiKzF2RDJlQTR1SVdyaVVzeXRZNUVWZ09QcHJpY1dvKzNpOTdoRG5N?=
 =?utf-8?B?TjBuaVZTdll6R29nY2gxTFZya3htdnc3MUpXWG4xQzlZSnppM29EOThRNHNw?=
 =?utf-8?B?eFVraHA2YU5nVUU4bWhyc21FOVdnY3ZtR1lVYWpMQjNyakJEVDZrMzBiZ0ht?=
 =?utf-8?B?TStTTGZzUWtOQlhUMG5JRU9GNDJmY1pBN29hUDh4ZXZMYXFJS3RINVFrOVVM?=
 =?utf-8?B?aTFKRU9mTzFXdWo4Z2F4UnRVaWZTQk9tTWZCZzlZYmFkSkcwQlgxbTlDOTFK?=
 =?utf-8?B?SXhVVXhKWlJDQ3VONGY0SG40SUN5NWZvOGZIV1V5RVBvU1p5NmZVZDB4ZjV1?=
 =?utf-8?B?L01xdTNvRVhYb09uR0hGUUZPVVdSS3JNc2NXeC9Sc0U4Rk12Zlo3VFZQZlBR?=
 =?utf-8?B?Tm5EV2o1L1kzeGc0TEorcGE5MjJkV0MyTng2cDZDUE9iRnV6R3lTNDI5Nkpr?=
 =?utf-8?B?NWxjSThNWFdpVGFrK0U3aG1NVm9mRFJwZ3p4N2w2S21GUm5BWkdDYjcvaGY1?=
 =?utf-8?B?V29NOUoweTV0eUl2ajcrKzJmNWZhK0JVeEw3T0xHZkRKZVB6K2ZTOWFXZ0pm?=
 =?utf-8?B?QjE5OVJ1U25zeHF6alFKK3ZFNmVHNEVLOUIzOG5LSnZlY1JpUWR3NHNVWmJB?=
 =?utf-8?B?dnlCOUNDMkVOejBOTGZTaTV2VjZ5dmgyWTJZNlQ4L1pmVS9xcnJlc0pWZVJV?=
 =?utf-8?B?M1craWhFQzRyYjZ3MEJRaGw2YlNucmpTTnQxSEJ5QWF3OElqcmN0U1FBaENi?=
 =?utf-8?B?QXFqcVcveG9FeVNUbTYrRDRoNDVWU1lRbUhWc2t2TzJ4MDN3c0JENVNGK01H?=
 =?utf-8?B?RGJuYmdDZGRTU2YwN2luZ0ZrTjhpS2k3aks2dzB5a3IvNTVuNmhIcXc1NS9C?=
 =?utf-8?B?UzVWeEFIMXU4bTZSNWlCNjlTZENsWTVsN0NIdVY5Z3hJbzRzdzFQWmZTNnZ3?=
 =?utf-8?B?bXRFekVrSVBJcGt0eFJqWHhsZnFiOGdjMzJqSkFVdmVpbFVQNHBjZkdlQmhk?=
 =?utf-8?B?Um94N2JOckVCWmpvayt1THlhTGpNaXRRelRKOGVHT2NncmwyUDVDT3hCMGRP?=
 =?utf-8?B?NHZaVjNXUndkWEJyaDlLOU1HcEVIQjJFTDFINGVtSWp5N2M1V1h3R1I2QzJ1?=
 =?utf-8?B?TTBkVDFtdGU0YXBzWFFETHdNOENsWFBkcXBJem5nUzdUcWMxSGlCS1VrSVRC?=
 =?utf-8?B?T3N0QkZXRGludUYrYmdYM3ROUzU2Y0l1Nks0OFRhSHh1TkErT3BGakJrTWg5?=
 =?utf-8?B?dXd2OEZ0OXM3dG9TZlN6L0JVRTNYZkJlTG5SbTg2aWpBMHZpa21CRUZIaU1T?=
 =?utf-8?B?RjBNNW85eWdGTUlKelpYNkNJUnMrOWUrd2dFZ1dQcjJnRE5wdnZzZEtpTFRm?=
 =?utf-8?B?bzBxb2JsWGVIV3hFOFBsdktBemx6TnZKbEVVWkRVVVk0c1Q1a3ZiZ0FlL1NR?=
 =?utf-8?B?Vy9VS292LzFBYURodlFobG1ZMnNUc1VOa2RQNHAwZkIvK2NaZjRCRUZXVERw?=
 =?utf-8?B?UUg3eTVUcW1KSHorejNlWEtwQVZIYkFZZnJDeElzVE1DOURORHpIbk4yRzFT?=
 =?utf-8?B?aW9UQlJ6ekJsekl3T2lVSXJwODVkWkhCMWNnc3hvK0dBZFFSNmd1ajAvSjAx?=
 =?utf-8?B?d05iVTEyQ2N5Zno3RURhZG9RSjRJNzVRSllPWlZkT2p2cVZvL1pnZmdpSXJB?=
 =?utf-8?B?Z014REluR2RwSkpZOTRSWkplcWhlb1U2STlvbStjcGNjaTJXdEMwTFAxeGZt?=
 =?utf-8?B?ZTkzbDlYNXB4eTJuTTJRdU15cUJwQjZnUWcrR0RDQVRUYS9pWTJjSC9aUEJl?=
 =?utf-8?B?dzNQakR4WTIwMU9jZDV6aE1XckpQMk9kQ1grUHNJbHRValRtNzc1WjdWRERM?=
 =?utf-8?B?UjZIbGVlYWN1WlpJS054VUhlbHlPSGpWemxiSlJxMzd0bGxBQnlrK1FDM0Q5?=
 =?utf-8?Q?WLbgbW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enBnT1dmOHNHNGo0VTVtVTc2YjZmNi9Jd01KOXcyZGU1RWkxY2VldHJVMVFK?=
 =?utf-8?B?cEJkNUw2UzdLN3RjS1ptT2JNbXBpU1VQcHBqWFd3YUdCcUVDaW1uTjZOeHpk?=
 =?utf-8?B?M1VZaEhoK2pibC9CUVRpUkFBQ21NaWpiRHpwc3V1VDgxY0RXekpodkF0Nld1?=
 =?utf-8?B?UzlJSVdXMEpLejNqbHptVmhac1hLZFJiTzUyUjErcjRFbGt0VFRuUGgwNlZR?=
 =?utf-8?B?TEdia0JzeEJFbEZVT1Q5TVVqWjZQVkhUdkNmQXhnMXNnVXVXMHhMVFcrdjdM?=
 =?utf-8?B?c0YxQWtlZTg3a3poajhQR2VBcWtDYzlTYnE5Qzl1K0tWUVQ1K2tPUlI3MGZv?=
 =?utf-8?B?d1lydW5yeUU2QjJrbHhvajlKdU9oNHdWZlNGOGVxb1BhcGs3dkRUQ1BMRy9Q?=
 =?utf-8?B?cUJLOFBKMDZtL3U2WlpWYzU4VTZZM0hncXliMVFRUDdzR0x0S2RPK3VsZDcy?=
 =?utf-8?B?U0JPTDVJcEdrVTBrVXNTWDZXYkNtZFZXd0VPcVd2Tis3TXV0QVltZmF3MEdC?=
 =?utf-8?B?VFpoMXFuTnRDNnJPZUtVZ09HMzhwWTVDNEhQM2xLU2N0RXljOVZsK3N2UmlR?=
 =?utf-8?B?Tlh5WDQyYmV2YjhhZGNKRlA5TEttL0JsSm1vQUNwY2lLdVBlbllwR1Q5OGdG?=
 =?utf-8?B?NG5DbEVGTHBtM3plemFyZkg3UkhYWVRZSzZXS05qZmptbXYyRE5MelNlR1BI?=
 =?utf-8?B?N2ZudmJIMVd1MUFmd0JpZ0tzU3pXSlQ2MVBLVVQyWEVINjNxM0l6STJPaDNi?=
 =?utf-8?B?ZHJXQ2lXU2ZiU1loYmx4UUx2SW5BR0g2eEtuVGhRS21oaVpUNlpjbWp1MHJu?=
 =?utf-8?B?K09YUUpsdFZsWWpFZCtPQlhUV2I0dzhJdWw2c0NmMDVEUDdHa3BrR2xhZy8w?=
 =?utf-8?B?QXZGdzVBUVVzczZBLzVIYzNmY3NmRzd0T1F2RDlsTFZ1aE1DMnd2K2tIN2N0?=
 =?utf-8?B?UXo4ejd5cDZGRkhRajQrMWVaZk1wM0JiWGQ3Y0hYcXNQY08zYmZlTmg2V2RR?=
 =?utf-8?B?cjN4UjZoVEw1QWtrd3dpczljN000ejlnM2xWSFlySkZuTnd4MzBzSmRMSE5s?=
 =?utf-8?B?QWFjc2hEcGVvM1lPOUx3aWh0cDVHN1lTZEFGajBFUnpLZm9CQ2R3aDArT0hk?=
 =?utf-8?B?SzhFeVRmSnUvTHB5cU5hc3g1VnJXZUhuVk1Bb3lqZGkrWHJRU2xDRjl0YnBI?=
 =?utf-8?B?OHZEMmlUeHRwYUh5aDVHcTZjTi9BYTJGbTVBeEM5TDFaYS93bVBhVjF1TmQv?=
 =?utf-8?B?TU4vTWJkdTduNi9hQWhzSzNGMTBoNjE2Y09hTFk1QWtLaDNzSjNxbzduaW5Z?=
 =?utf-8?B?TmQxMFpVUkhGYjFVRkcvRE94Z3JYT2Z1cWV0VkZ0VFpoaklISm02V0JRMEUr?=
 =?utf-8?B?UnlYYUJ3T2YzR0dkY1FLc0tmTU51V09NcWFqa2x5VjdZQTg5WVF5OXVOVTY3?=
 =?utf-8?B?cWtCUUFtVHZsYVFXOVg5aE1vTm9mMDhvVWdDaHZ6aWJBN2NZTTQ3TnYvSExH?=
 =?utf-8?B?aFc1NU9waHRYVEMyL3RsNVJZSUpEZUF4V3ZsNGhXZDRDWkxuOW95V2VSQTJC?=
 =?utf-8?B?aVNlRndtRi82ZEliUmhCRlYvY3FOclFJejY5WUgzUzF2S3BlLzNuVHVGQVdZ?=
 =?utf-8?B?dDJpd2lKL2NDUGFtRlZlSUw3Y2ZvVzFCeGRWOUU5OUVXYWVTWnJsSUdiSEcr?=
 =?utf-8?B?MEFkM0tpMGE4aWdkUWJsQzc2OElwT09Fc2dKZHVJS1o1dDJzNlM5dkN1WVBy?=
 =?utf-8?B?c05ZU24xbStWb0xxWG1odVFBUTMyc1FWNHhuVXR4T1dNSHNnNStnb1JqY0lC?=
 =?utf-8?B?cWs4cEVYYkNLUmJoNmhuUVFza043dkx5dURJYUpCbGRHcWcwTW5pdTg4bUps?=
 =?utf-8?B?V2x4VkpvZHh1YWhBUEN4cURqTjVGcXlFTWNLcXEraUIzRXdTVzlQenZVN3Uz?=
 =?utf-8?B?NE9VMnozemV0a0ZjL2FudFdrazBIK2FtZHdTQjJQSXBHSHBJcGJKUXNOdTQv?=
 =?utf-8?B?cWxmQXhzR1R1ZzN2VFRLK1dYbi9wbnBQdTVQY293aWJlMG42Q2tDWElKcTNk?=
 =?utf-8?B?Z0MzQlRwWW9HR0pwdGhEZW5kUzhXZUE5QWNiQUJYN0FEU3hVQ2xXSm94NzZQ?=
 =?utf-8?B?RTc2SzBSNld5TGpOQlFaRHd3WHA0SGFXQUNSNzRRYW5YMnVTc1RQZUtjUDho?=
 =?utf-8?B?ek5EZ0tuaURvTS9lazErUzJ2NUtnb2lKaWNER3VrSmU3c2srZFpkWDlJeHRX?=
 =?utf-8?B?T09PWWJUNm9kbkxobnI3dUU4OTV2aEg5aVBLQkovQVZxQVUyVXlhVW1vZ09Y?=
 =?utf-8?B?ZjVwd2hlK09ibjlEVHNsYXhwM01ZRUZzOWducVNsbFBsRkN6NFl0QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55af783f-5f3f-4691-1207-08de5996bd37
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 09:15:09.0252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvBbRX3PqK+vygNcUmlEagYF2p2bW4Eo1hbmnW2wtYmzHMAzOFvKCH7lZtUnb33YpFP+TxDDPxzXlnjqVSCn4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5777

On 22.01.26 06:13, Pierre FICHEUX wrote:
> What about a drink/dinner on saturday after the conference ?
> 

I will attend the LF reception, and I think that is already over-booked.
Colleagues of mine and I will arrive on Friday, though. We could
organize a meetup on that evening.

Jan

> 
> Le mer. 21 janv. 2026 à 14:43, Jan Kiszka <jan.kiszka@siemens.com> a écrit :
>>
>> On 21.01.26 13:40, Pierre FICHEUX wrote:
>>> Hi Jan,
>>>
>>> Did you plan a time for an (informal) meeting ?
>>>
>>
>> Depends a bit on the amount of feedback. But we could also just define a
>> slot to meet e.g. on Saturday, 14:00. I just do not have a good idea for
>> a local yet, one that is easy to describe and find.
>>
>> Jan
>>
>>> Le mer. 21 janv. 2026 à 08:48, Jan Kiszka <jan.kiszka@siemens.com
>>> <mailto:jan.kiszka@siemens.com>> a écrit :
>>>
>>>     Hi all,
>>>
>>>     in case you run around at FOSDEM next-but-one weekend and feel like
>>>     chatting about Xenomai a bit, just drop a note, I will be there as well.
>>>     I'm always curious to learn about use cases I haven't heard before, just
>>>     like I'm happy to exchange thoughts on how to evolve the project
>>>     further.
>>>
>>>     Jan
>>>
>>>     --
>>>     Siemens AG, Foundational Technologies
>>>     Linux Expert Center
>>>
>>>
>>>
>>>
>>> --
>>>
>>> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr <mailto:pierre.ficheux@smile.fr>
>>>                              http://www.smile.fr <http://www.smile.fr/>
>>>                              https://smile.eu/fr/offres/embarque-iot <https://smile.eu/fr/offres/embarque-iot>
>>> I would love to change the world, but they won't give me the source code
>>>
>>
>> --
>> Siemens AG, Foundational Technologies
>> Linux Expert Center
> 
> 
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
