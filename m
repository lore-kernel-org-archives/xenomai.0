Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF89A23
	for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292743; cv=fail; b=ECyUvUwwsr23pfqLjXPLBrQswyjvGvCDlL6AV2Dn2taTQrsjL6ZoOZmVwUmhFHFYtlP31n4SgApMqgbtAwdzbXbJwn8VPS46agMUl6zxV2Nv6O/P5ZH0/c3R8513PC9xjpIxcuHUU5MA+mMVbvUDlOn0Y30c9T0qPbeSPX71lTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292743; c=relaxed/simple;
	bh=4CuvPvlts00UwE2cYUbIx3N/7RuK6gfLikyS72Nu6vs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qf6HYMmU+R9hxOEAAxl7BvzqSSw5/J+icXqvRyeqIO8AQ5lRZDcZkeHiwq9Ph2Nnt1HZ/uqPGN6Vm8cZuoueLGfxR0BOE/BzwsyYIThyZLkwrLbDzVARTKUgkvBtG3opQe9+QapI2nWXjaM9U7gUsDR/u/QEWwrtbogi4dwAmrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=isY0OC5Y; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="isY0OC5Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhEW+dgIBh/ZpEDZnYmRTGSkSUuFgOBpADKXcF9PDXyQQEXeHTJxzFooLonha9Q8a7hNuG3xdsFPhrzeg/z46iEDvGV05lp5ixjldrlO2W5/ilH1dzrICxdg6vwOPK4e8Tqgpf1tl/icFbUqE1tE1WlHKx9RHNwj+Ya10eBZDMun0oIm9FqrJ4yQ38tv45PIIcefvdBAJmWgXIeuxSqvyqU1Fr99YTjc6FeUpoo0apOmBx0a/VDqd3rhtT0NwBoOnKlsBzoDOpeFR/D+QfjGwt54kJpMjiF68GR5irtMUyooCK4ztMNOB1SdsRRoL9QENrPoojefMkMeQOjtaoIikQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/q7v37KBZQ8WEDfaUHrbLqGMRcmNRhZ0zGuZVVdkYY=;
 b=SA/DpNpNK+mnMN3svGVQGs7j1Zlta31OHjhr3zTX2c1rvtfRTHEEifwTpSJk97wAnx1rznw6bvlEiuj8zoSTPKaneE7IBYx3ztu4DQfzlfFEe9g99P9WbQEeCuhRNWy02NLQsGPotMdCOJN37K6JXJQRfk6X2X+t7PfGZrgW27+XrZqVxqMjdIJ4290/YSzxPDSkuzQrE+Kr+9AgA4gbcv+7FIJNTXYEn/TDdoRTMYI0KzhCPtoZFq7UmkF4HENNOib3pJMnaAe+FwsfXTpIMiONVN6cmTHS2DMR5cTRMjq0T8IJAHJNwoxsvwRr3B1GIiTZgjzf3cKV7DVmJZoq8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/q7v37KBZQ8WEDfaUHrbLqGMRcmNRhZ0zGuZVVdkYY=;
 b=isY0OC5Yp5tdsp4oyF0GBZ5WeM9v2yuaapPmjk/FeoJDliwzEcyVGcNG38WdKpY0TQEsmrFHnfhg0svoJvTL+hRXhhWTiRCeIqVlSQdkXQ1kIhvhiZHjqarIpLAfuGkNM4gQE6pdviruwJ8CVZ5+fVXSWIg+bVl4EOxI5BR0Da+A+mXTN+TNznp3eyshz6eChvJbhZTBEKycuGse+2C8QmTj1AGkCuyUhppiD6SgbJcKoNj5TMEUly1Y2SKYikqobrho8HDQQSfIpk3FYKswMIJrnZ1fb81jJoJF2JVdOv0COd8pA3dnuHzfg7VYWWXSTMpg5/EqRVdkSfBOSHlMWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5547.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 15:32:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 15:32:18 +0000
Message-ID: <fb5efca7-cba3-4115-86be-0b719c5a74b4@siemens.com>
Date: Thu, 13 Jun 2024 17:32:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [libevl][PATCH 1/4] Copy dohell from Xenomai 3
To: Philippe Gerum <rpm@xenomai.org>,
 Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
 <20240613134557.4013044-2-tobias.schaffner@siemens.com>
 <87frtgrker.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87frtgrker.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5547:EE_
X-MS-Office365-Filtering-Correlation-Id: a041d59c-a8b2-40ba-cf48-08dc8bbe02ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVBWSW1QWXpwbEhGR0pndk96RXlyQWhvK3FUYXA0WHYreGxuT1c4RjB5Z3lI?=
 =?utf-8?B?dWVSZ25icHRGK0RpNkZIRWxPY3FFSndKOGxsaWd3MHNlOHlRdVJtWmdkY1dN?=
 =?utf-8?B?WExadlRieVV2QTgvYzR4dEJ3elVFOFJSSWFlSStlZEZqMkQzcmc4ZnVjcDFZ?=
 =?utf-8?B?SDh6TjhnK3Nub1A5NXpKVkF5M244OC9ZMTZuL3B4UzJzdWFBZGdxM2psWlZV?=
 =?utf-8?B?d21GOWhjK3lNZ1pQYXhub1R3OVJ0QnM5MGc4NncvVkJRbHlTT2prTWFiY1Ro?=
 =?utf-8?B?U2Q1OWJvVE1ZdDVZajJ0YllJRDIra2tYZWhMRytGeFNQWjlsTnFCSlcrbWNh?=
 =?utf-8?B?dnc4VTVldDNEOVB4RE1KNm5vTWhTMGZ6ME9VeGg3RWp5WVNjbmRiSGNKbjJa?=
 =?utf-8?B?TGFvSTJOLzhabTZ3VjJMMnJaSSs1MlJEd3NCbU5xSmRZVzZxNkh4eWt1a1Yx?=
 =?utf-8?B?UVd2OGY2bGR0WXhUTENRUHRLWGcyeWlLTGtFaVJmQk1aaCsvV0hTV1htcXN6?=
 =?utf-8?B?QjEzRHNPeDBVUWVwT25CeEJRNS9HZWNJeUdsVlpOTDZsRGJiS21zeXpTeWEw?=
 =?utf-8?B?SEFVN0pMU2xEa1lLK1lEMU5aUWJvaU1uV3JiaUVRamNYZnVYb0VnTHB5a2pW?=
 =?utf-8?B?OFlOQWpxbUl0MFl1cVpLUjV1dERrRXc0SW9GaGtNd0JGbVUzcUxNeHkzNldz?=
 =?utf-8?B?dEs0aks4VkNlUFF0QVJQdGxDWmQ3WFNRL3hoK0VETmVuLzM2SGNGY0RpWU5U?=
 =?utf-8?B?TWM0aFQxWnFDSmo4blhwdmxLNS96ejVWSm96bGRYU1pFb05tSE9OMENGbnVq?=
 =?utf-8?B?a01Ta1o4U1Q5RldKYzdmY2NDS3ZsSGVPdE1LTThJamVVUE9Yd2J5VnRHcUlG?=
 =?utf-8?B?UkF6UHF5MTgrY0lyTEgxTm5saFdhV3lXVzVWczNJTWI2K0JBQW16QjdHOG9k?=
 =?utf-8?B?SStxUGtoRG0wZG9xaTBSWmk3M3ArOWFSWWhOajZzNVA3ckxjTzdqL1o4Q25O?=
 =?utf-8?B?QnlZRnkzbnNBemZZV0plTGF5bUlnTW5FSS93REkyM3hhajF0UzJ1MmJmSnpJ?=
 =?utf-8?B?N0pyMTBBRjg5Q0FEaDFaYy9VbFRyNFZDNktvdytyNnJRb0FlZjhlV25YdWsy?=
 =?utf-8?B?amo3aUFOSmFWc2VxNVFKY1pGanlVOWhleUdwSUdDbHBIcjFmclRHRE9zcWZ5?=
 =?utf-8?B?UkY0Z2xJSThsWFB5bXBXai95YWYyOWJzaVQyUW1LaGFxbmd4bUN1eVJ4MFBX?=
 =?utf-8?B?L3FtUlNnaVdoSDVxREZTZ3hUV1lUV1pFODV3TVdiOXd5cXFKM25vNlpmZ1ZS?=
 =?utf-8?B?YmRGaG1KRFM4RU51MXVvNlFaR1liSDBNWW5CUGR0N1pmSmVzaUZNdXcxVUtz?=
 =?utf-8?B?N2lHSlFSUzNWRy95aUpjRWpselhnK0luYTd0QXJTc0FNQktTT2UySlFOemYw?=
 =?utf-8?B?ZUsraEFWa1hrUDFBbjM2eWppUDR6VkYxU3Q4M0J3ME0vRnZTU3F2Y1Q5WndE?=
 =?utf-8?B?LzVTQWFyNE9ZYStuRm5Vam1PU2dsYXdibkE4VExQckxxelJCVXNCQTlXbFd4?=
 =?utf-8?B?dzROVkdrMTVrWWVxR1h6aGhicHJYTWRqQ3B4TVBlYzg0dTd6a0hWUk0wUzFw?=
 =?utf-8?B?Ukk4anlJQS9jK0RNV01qcjVwT0V1ZmVlb2ttVjcwanQxNXU1bFp3LzJaK09Z?=
 =?utf-8?B?bzc0L1NRdzBvUlFsbjFGdVNXRUtlR1R5RmVrZE9QTEhqeTNqSVFYSU52MTJW?=
 =?utf-8?Q?v24/sZ3L9WI+H5SKLCW1P8sbhgJXvfDcX8Kgf3j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djZUTTk3bkFud0RtOGlXV0tXQU1YaGFNbXJlbmRPQUM4aHZGQ1NmbWY3USsz?=
 =?utf-8?B?aGFNTnJ4dlJ3TXhlVVpRU3RWV2R3TGl2cm1JWFIxeXh2U0tMSG84a3NjWUJD?=
 =?utf-8?B?dFF3ZHRVL0RqNTNCUkxUOXNtZWZNQSt1cm4yVUhzVmtmTW9ia0NwUitnNlpt?=
 =?utf-8?B?Z0h2RmZQVnZSdTgzQWtwTzFhVnNKU1locHFXZ0FFTjdtbzJOMnBjNkVLcjNI?=
 =?utf-8?B?dVFnRUdoSlhtQlg0SmZ6aXlnNFcwc2Z2MjJpY1prTW0vZjJaN2FBYjhiM0Zh?=
 =?utf-8?B?eUl0dFZUSzAyNU04b21YNFArclpTNVdNc0FsZ05WMmNJUEVlc3g2cFRtSTgx?=
 =?utf-8?B?ZU0xU0wzTjJscXlrQldEMklXM0U0bEgway9rbDdDVEJ3T3R4TFY1RHE1Z2xI?=
 =?utf-8?B?WVlBaTRIelgzZ3QxcEdzdThtRHdham1sdE05Z05rT2o5Z0ZXTjE1VlljNm9B?=
 =?utf-8?B?UmhMTHJaSFBSUzd1UWRXR25GL3B1MERnUVNHcXBLV21yRHNsem9la1A5eFUr?=
 =?utf-8?B?NlBZeTlCNjJJZlZFaks4eWNuTUVmVnZsUTFQVmtvNHVXdi85cU4rc3l6NVBu?=
 =?utf-8?B?S2ZDaDlCVWp2b1UwZm80dU9odElFL2tMclc5anB2NXJQOStaRGVIUVNZMHM5?=
 =?utf-8?B?SWZxSHpaSUwwSGlZa1lhb1JEeGdjeEE5ZUltajcxUGllekhpMGpoSEt0cmRh?=
 =?utf-8?B?OUlVbnJFN1hHeHpIdmlleUtBSGVoVDdoK01ZQ2JEbXhrTHhiYW5mZW9sc0dV?=
 =?utf-8?B?QURYRzBvZ2JZZW1lL09ES0dJci9nTXVqWlBrK1dUSjZLNVJQQlJoZU9MYldC?=
 =?utf-8?B?NVZwOHF4U2NialV4ekt4d04rSnUzY1owY2ZBRkJ5KzEzU2hveWJENm1DRkpK?=
 =?utf-8?B?bnhmcVdDdVRNcCtsK3RTTlBpa2FaY1VwUS9UMFNHY0Z2WnFDQnRhM2FLazlI?=
 =?utf-8?B?OXBFcVg4OXU1TVFZdTE4VStnYWtBNkRzMjlGUWp1dWJqWlVDY0UwRXlOOEM1?=
 =?utf-8?B?TExObC9xcGlEaFE5MW1rUW1CaThDTjhIT2ZQSDlocTQ5dGhyNlJMYWlVZXlK?=
 =?utf-8?B?eHQ2Wkx2cFZsSTh6NmJDN1RLVGZWT2l1TTJnWk5MeWxNZXVNcTFvZjh2MVJh?=
 =?utf-8?B?Qzg5NVdVUndvYm1lbDJjakVHajhZVVZwbVZ0NVBDZC85NC9PNkR4dE1YMS9u?=
 =?utf-8?B?QUM3ZFVFODY5bjZYTXZZdy9hNkVVQzlyMENwL3dZRHdzOFVIejloR09yZDFz?=
 =?utf-8?B?ck52L3cwWStyblRkMFV1UlVLc1VjZzczSmRPTEt4dk9WMyt3eC8zMXZtelU3?=
 =?utf-8?B?VHJwYkl4ZzJ1cGhEZHJ3dU9IVjlRUitvUXUyRzBudk9Ic0VCeS9Mb3Fla01y?=
 =?utf-8?B?a1NzLzBSZHFWeVVOR0ZvOVVOc1UyTk5jQU4zb3lmc2E0b0lTRDZnQ0VuNm5l?=
 =?utf-8?B?UXZ1SEU3VmZlZHNhU2l4OURTdXF1MzlSSWpERTgxNnRlQ1paU1pXOURCckpL?=
 =?utf-8?B?WlJEa1hUanBTbE13Tk9jeUdpdzB6RzhlMFo5dmU1RXhkYjJDNjRQSndwMG10?=
 =?utf-8?B?ZEFVS24xMUQ0L1VNMkpmV2VHT3gxWVhBZDRxZk5aYmRLd3hMbjhmelNQMyti?=
 =?utf-8?B?NGo4MkJYRlErTGlYam83UFBsWlQvSlRFQWZSNjdSSlpsRkRxMkhPRm9ndDM3?=
 =?utf-8?B?SjJGWFFJc0tUUGpGWExVSnIwdHdhUnZ4Qm1GbWZCU1BoWk92QnFPaldJa2Vk?=
 =?utf-8?B?SUt4RWtWU01NY3NHQmFhenIwSFVENWxIZUY2aUJ0MHJsa2VzYTV0OVplVEtp?=
 =?utf-8?B?c0lOM3ZXOERtL3p6MUJsSHZxbEpac1V3RTljQkVJbTVKQVN0ZmRrMVZITDcw?=
 =?utf-8?B?SzZBMWZQbm5qbTRnbHlHQ2lHeEdPRmljbjlGRVM1eGloVHFhaXZsSXg1cE9H?=
 =?utf-8?B?TVNqOXhwYnNOUVQ3UEIzMHFseXdWWlBGUys5SXdyRlZ1NTJkMlE4VGVwek9Z?=
 =?utf-8?B?MUovSFdrK1IyZTdBR3owcW56OHNYTzZvWnZnYlZLVjlYa1V1cUx3bUxWRmo5?=
 =?utf-8?B?eWlUMEFKVmc2NFhveUpxQVoxQzY0SmhlVmJlS1hrSm5yQVN2TENXaEZMUmds?=
 =?utf-8?Q?MCqOsEtAAJjXiAxD1UFfs6YuS?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a041d59c-a8b2-40ba-cf48-08dc8bbe02ab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 15:32:18.5514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSdK3OHcbon8daQoy5qpbr08FYT4Kua/GvnQzG09MZZnfAeDmjNbBErx+rCa58RKwN/t3zvkuMt/fEqJIED/VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5547

On 13.06.24 16:23, Philippe Gerum wrote:
> 
> Tobias Schaffner <tobias.schaffner@siemens.com> writes:
> 
>> Dohell is used as the default load generator in Xenomai 3. Add it to
>> libevl to be able to stress the system while testing evl.
>>
> 
> dohell is obsolete. Let's move to stress-ng or something alike for x4.
> 

See my comment on patch 3: If you can name a configuration of stress-ng
that stresses a co-kernel more than what dohell does, we can take it.
Otherwise, I would strongly recommend to not do less hell over here.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

