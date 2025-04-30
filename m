Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49A0B640
	for <xenomai@lists.linux.dev>; Wed, 30 Apr 2025 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024781; cv=fail; b=NUq4dln2/dBesWgzcGTjlL36iETbmOTEZYLKslDM2y27TLV9wUXKhngbxP3ppi/UlyeEuTlzrtMNOpdQ6JvAGhkYbvrgs5ItwzAS75ieIQlOmGHfG9MHV0C9+p/AotB9+mdEZdLIO/XSrCxaGJ4E+/lnNXsxqwukYZAGB91RsAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024781; c=relaxed/simple;
	bh=eWqcTZGMSpPMDG3//P9Y1aMnXtUlw4JvC0gZaMa4KV4=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NjZ6mmqqc/Pi2KFzCRXB58HEc5Pbs8gQ7VPO0prycbZ/pS9MqO0iMnODWgTfJSxCTqKS94saqmJzJzm9kQJ8a00ur2naSoQ3B9u2W+ckUUhfGEZOghpRuHzD7oRzIO49s6S5iHu5+yjIgZtXXFqr/Kee+JeJQYAzRluCiTvvqO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=oEvNStR6; arc=fail smtp.client-ip=40.107.21.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="oEvNStR6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LATLpWfxIyFaF+uiB9my5M55LQQ6PwJM7KruNxf0nRwT9NSYkI+Qv6iGBZuDiK3qVaEA4GxQ2LRJtbQ2mVCKHfBBpJJWK0k0z+WexrxAHSm6aXyuHSlxPslwQwV23zdd4A0lsWb4CNGPpM+dGanrnDOvaqj4m8pPzmP//hR47Rf2XwRH88WqokvOwV2ZMvi+7bohidPV4pVxrXROv/mqyk3fRDuR/UEg5jTjFuXdBLS+BauW9759V3kr33Klz+DLP9Jlhs3O9XgJOx2818JMs9fB9r5g5d9maIbAcGS4hou1Z172ZA/fDW65XFEVCQM++CY6tS8so5O8NoJlQ6pWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/qJtDpTLdOcsgNyoRvEC1iQsq85Y7s50XiBAfR1jbQ=;
 b=Gk9WwBRXE8/QQ4Du3dtZWqjmJkPo3GCzc6IqbJbCEbBS5z7Tm+Mxsl9KuO5HN1P9Obg4THsPDDjgG8i7LO2RYWqCC7CmqKNC+se2Kd1nMMqJrAdL4lUWYH4xH8R0JTFbPr0qVb/IBHoUOmAt0nE6DR5lHG9JSOzk/AokWOFh9HCZSBd7ZMdumhojQoWvR18TIyiqC/Tzd3MwWrB5tWurLswa+NDTjtvA0j8/XoALIw7kYdyhEP3Ua5qI5G/n9PXth28+PwlTo1TJ5gX1MagoO4Yx9wwPVXFemjasA8zvxMRUlVROsAElOQe3tweqlztJP3VdCHcd4LQEqYsJzXlv5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/qJtDpTLdOcsgNyoRvEC1iQsq85Y7s50XiBAfR1jbQ=;
 b=oEvNStR6Wwu8cN7tvZnwbC2TkpCelQejT5qN+wPL7bz/TIVAbdnFZRLSOiX7Pq08WWRDGeD1pQ99+zLXH459/DAfrjRh2U0XpLZGB7JFf2K2WRV6dGYKwEkLQuXhV8t/7kmio9NOak/0EnumCtvbvLdMq/IQtYXU8TRTUi9mUcqK00QhWFSEr3uD3396lNp+gVf/tu7Je2EyMj/fvDyOqFhb9ym86T9cJAXAVDd9ay/fIKwgiQIIIJnVI95g1o7D6tvJboPgEuRf/uj7Q0DHmzyb+mVdM74714MwOA8Zf0Pzxx3ti5EIv5ynBMxQptaKKC5zXwgSwgKhLurMW9h+GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8153.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 14:52:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 14:52:55 +0000
Message-ID: <8991b5d9-74a7-4089-9390-4937b119e010@siemens.com>
Date: Wed, 30 Apr 2025 16:52:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][Dovetail] fix IRQ forwarding to the in-band stage
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@lists.linux.dev,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <87plgtg3r9.fsf@xenomai.org>
 <645bc7bc-9c4d-475c-9596-2f5813e23689@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <645bc7bc-9c4d-475c-9596-2f5813e23689@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: ca8c5786-0196-4533-f462-08dd87f6b07d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGtIT3JQUysxMCt0OWthWnBDNCsxak45NUVERVo0U0M0aUQvc3JFOFAybW4v?=
 =?utf-8?B?Qnc4YTkyZGZuNjYxak1KTUdYTHFKdHI1ZlR3WmhicFN0WEZQdFl1QjJXTXR6?=
 =?utf-8?B?dFRvTW1IOVdoUURraGhFSDFZWUdRSWV2MitvbEhCZWVkVmNMMDZPeFVVd3dl?=
 =?utf-8?B?L1RvOGRtbGdJeXN6bzQ3VmRqTndrRi8yYnlXL1RoWEw2NFgzS2ExTXRDRVJr?=
 =?utf-8?B?Yisrci9reDJnckVlRUpFWlcrVk1SaEtBVkkyV013bEZVRFg3VTdPYnUvNE9t?=
 =?utf-8?B?cjMvVjcrazdvM3FWRGFlZlI3cWpoR0xaK3JoR2dZcTlEb3VRckdoVDFhTDky?=
 =?utf-8?B?ZzZSOENPTzVmZGZncUtSNjRqYVB3cHpBdUhUVjJpNHh4dXZQWk5ZNlFLenVW?=
 =?utf-8?B?R0tnckR3TzBja01pdHpaQ0hweCtFS08xSjNJdWhqczkydW5tdk5qVU0zRXVL?=
 =?utf-8?B?RWNNMGxlbW82cXNueThhY0VlVnNtN0R5SHVUcTNBd3FCbGs0cVlDelk2eTRG?=
 =?utf-8?B?TWFzN1NGS1lPQnJ3VUpDSW1RMisxU3ZFWThFU0hIMGpPMmNGaVdMZHh4elFi?=
 =?utf-8?B?UjJtTFFseFJYMjJFWXhxaHEyc0JzZENTMFA5ejBQTUJyMEpUNmYrSDdGUlor?=
 =?utf-8?B?REVXN2EwSWt4Y3hmRlB1em5RSjhBVlora0Z4WFd2djRNNDc3a25hVENXdGFh?=
 =?utf-8?B?MjFXOTlNWEhpbWxBaWJQazJIUWFaMTJpbGxXSkZyNTZsOHNreGM0cmZ6bE0y?=
 =?utf-8?B?dWFYcTBWVTNxVUFIMjdFN0RtSHdONkNGYXlHRVoyaTkrbzR0S09FQ0tTY2xi?=
 =?utf-8?B?S0R5eUk0UE1ldkZYTDZVdGU1SHozbGtXSGpYQ0RzZXY2T0JMdXFMNnFJbTlZ?=
 =?utf-8?B?M1NRazVSN1cvOURZZ0dnTXBhTkFBVkRsNDhyVTZNYjA3NzdsQm5WVm1FWSsx?=
 =?utf-8?B?bnQwTGlyZjlQYktuSm9XVmQ0V2tjZzdUNDREcGVrV3hsMkl0WXpGckNkc3NT?=
 =?utf-8?B?V3V6MnpXS21qZ2ZYZHlFajN1Tks5L3lENEliNUF6aVNEOUdqc3AwRUsyaTE1?=
 =?utf-8?B?T2wvYSt6cXRaL2pqSENCeG5GNTRSdmNTM29FZy9zNkFMZjRVSWRTY0NBSGNn?=
 =?utf-8?B?bTY0NDNBVnlGeWpHQjZ2QzRSVjVEcG1HdEtSL3BoNFVtdE4vMndqTmM4U1lK?=
 =?utf-8?B?aTFNUUhoaUhpaFcydHlkWkZaQ2dXMFU2SXRDR21wYnRmbGFjWXVLWnI5QUtR?=
 =?utf-8?B?QXZlaVpXV3RlSDJwNGs2QWZyTnU2c1l0N1VnSEVSMC9SNmp6ZFZqcEtpYkE0?=
 =?utf-8?B?dFpYSDZJeTZ0MUwxK0hVb0p5bXNiR3ZZdHpaZjJKdHZZNEI1L1AyMFhMOElM?=
 =?utf-8?B?SUY3YkhLVG9UUG1qTjI3YVRJOThBVFZOWW5jSzBkcGFITnBQNWJ2ZWFEd1hO?=
 =?utf-8?B?WUhLbm9xYkNmMjZyWVZQUkpFQ2xReHkycFRZdnhUMW1JZG1GaW5zaUZZc0pw?=
 =?utf-8?B?V1BTeFByWlJMbFRsbEVvakFUS0pTYmhON3NVbnhudXBpcS85QlN5aHgydFpU?=
 =?utf-8?B?RDJleFI2eXIzeE5xejlVb2ZkQ01DUTZQNGIrd20rYUl3R2YyajM4WTFTcmFR?=
 =?utf-8?B?dC8vdjFWcEtqNTgrODZjcHNvWVpLOWNkL2hSTEdVYzlmRHRsUDRsK2YyTjNH?=
 =?utf-8?B?K1Q0T2VCakU3RE1xRVhSUEtRTndlUWtiZ1NCK2FySHNhS1lxNFJGZkFJUDlO?=
 =?utf-8?B?VUVla0hnV0pBS0V6Y0p1b2FaOWd3UDJQeVlxY3o1Nk52UGVWcE1BYXhCR21m?=
 =?utf-8?Q?+gVDqJrGigi/kGu0g+fOTgtjh7RwgukiXtlZ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXk0WU9oR01IR09zdmsrZE9tcTUzQ1UvVXU5TGVHNSs0UUdhT3RkTk5YZ3g1?=
 =?utf-8?B?Q2J0ZDlDVzk3WWRlVVpQOXo3RDNoRk42M0NQQ25DS3B6R0tCSXk1NWhpQks0?=
 =?utf-8?B?Slc3ZTg2Vmh1bEtCTHBHeXo3OXlFSEU4SGNlWi9ibHJRZWxvZnVIc1Jnd0Fp?=
 =?utf-8?B?S21yRWw3d1ZwTDZjR24yd2h3bUpuM2tkUUV6b29laWFETUoxSytmYmZLV0JI?=
 =?utf-8?B?Z3Ira3E5amliY0V5UkxGMjk1Rm5McTNmYXdrSlhvVzdJb0lsQmh1OWFOazRR?=
 =?utf-8?B?dE9UVjh3cU12YnM4S3UxbWJBb3hmV05DbEszVyt4UW53SmZqSlVlUjBWNGJK?=
 =?utf-8?B?NDRvVDlocVJ5L3BhaHpaMTU4c3FydFNMMS9ZRHpiMnRhSFBsQ3Fjam0rYTNh?=
 =?utf-8?B?S0F3c2x2a25sTjBPR2taUDljOUpyczhXMDhHNkZKSElsRjJpajMrdjc3aGhw?=
 =?utf-8?B?cGZ6TFpFNDBhWklNcmFaS3p6R3NzMXNoYjgwTkRkWnpRSkNDbzltVElyUWNU?=
 =?utf-8?B?eVArN0RsWXhFWnJyNEpNMHRBUlZhWGwwcGk4MTFDVUpJNUUvS1pjemdSbEVn?=
 =?utf-8?B?UlpHU0RBeHhTUE03Z2N6ajI5UnZraEdsNUNIVlBnd3VVVk9YN2RQNlpEZUpn?=
 =?utf-8?B?RVAyNkVEQXo1cDJTaW56Rmsyd3g2VWs0cVM3aDZRcUhMQnExSmIrU3laL2xI?=
 =?utf-8?B?a1VWMjlQRTFsV2tJb3pwSUErQVJTT2E0d2EyN2ptK21IUUE2cmQrQTR4Zlp3?=
 =?utf-8?B?M05RMjZLOVYrU0o4K3ZIRStKZnJiSmlwYm85ZjNOMGJid21jWU5yVTVNcXVG?=
 =?utf-8?B?Nmlsd0xNelA4eHNUbzFwNDVubWltT0xpZlJsekoyMTRSdHowcGh6SVgwSlk4?=
 =?utf-8?B?ZG53KzNNNTYzNU1hYXR1M29RZ2VOeWgzRW41Um1JMC9RRUpUMS80aDJKL1dL?=
 =?utf-8?B?UUxiNzUrd2EzQ29oNXhyMzVkNXR6bHhJajJWK3FJT0NiNG9wQUtHZUFpV3pi?=
 =?utf-8?B?a2FSQWhaOXRFS0RrdndUZWxZUDNxWTBiR0ZhL2xvcXhQOW9PUnFKcmpxa2xy?=
 =?utf-8?B?ay9xcXhxcnNpY3J1YWhDNDhQSDdPUWI5aUNQSW5VakdVMDZyelIwbSt0aXRr?=
 =?utf-8?B?Ykh5TGVUVEdhUjkzSE9ic0xIalk4YjBBNktaazkxemYwSXRpdnIzcnJhMzdQ?=
 =?utf-8?B?Y0xpVG5hOHpDdDY3bU5EWGtSMVpENVkvb3oyeEZoMHE4SjgzejR2eGZ4U1A1?=
 =?utf-8?B?NUQ2M3I1NnNjWDhPVlhHTzdtMllZNGcxU3dLMk9LMDJ5cXFudUpEZWZHanNR?=
 =?utf-8?B?YWtoREc4c3JpSjVPbDNxR29BSkFYM2xlL2M0Qll4aHhGNnpNS01sK2FENkRH?=
 =?utf-8?B?aTAwbEFSbFNiNWlNN2hPL0dURytjeC8vRk5MRXJyT2JVRHdQMFpxd1lPbk1q?=
 =?utf-8?B?eDBJeUVFRXBXRU5ueFZWak9WT01xQWF5MzA0SFk4ajlNN1RUY0pTSWI5MWp0?=
 =?utf-8?B?cmdHTlIrcUEwV1JzektQL0VaemFTTXBaK0VQajdzZ3Uybmo0NTMxUWZOL0lu?=
 =?utf-8?B?OTFDY1loWStScTl4a1orbENBYWJ1SGcvdnh4VXhuc0xqWkUxUXdvemdvOVlC?=
 =?utf-8?B?c0pEV2gvcVloVm9ZT1FLVEg5QUxHUHNxT0VTNFlDdVJZdkhrR3JFL0IxTEhK?=
 =?utf-8?B?VVdGZTB5TEtLMXR6bjlVZkVzeGZKNFlVWGV0WWhCMnRvbWFCVnJ0YlBQRXNP?=
 =?utf-8?B?VWhCNEc2a2UrdzF4emFiNFRETTh0cE5xSFIwZVlYUkVIemZRYjFxZ2FrRkx6?=
 =?utf-8?B?b2oxYzFmMnFINkhML0FxUVowdWZIY2hEUk94ZFdPaTVvTytQKzFidDVWTURR?=
 =?utf-8?B?NkNEWnhrQnJHOVhqUmcwY0J5Ni9TdHpmSlRwVFRMcG5FK1d4bFZFSHZqZEVX?=
 =?utf-8?B?ZUdnZGFtZHo5RnpaaFkrelVUR0Z6ZTh0V016ck9hcWtYVUZUZnBuUWxwQTRq?=
 =?utf-8?B?MHdnSDdKSEh3WDBTL2JiRVowa0YzQXBDcUFYRGNhaXJlZlNjQ3c4TVcrQm9F?=
 =?utf-8?B?ZytaVkFaanBWV3AyeWZ3STZZSFpOQSsrYXZOUWZ4eTFDNkhRTzZjWktiS1B4?=
 =?utf-8?B?cVRJVDh2dkZtRlpabEtZSnlRNlBaSlpLV2hKRWx6bnFpWStUMTFKV1pXMW9k?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8c5786-0196-4533-f462-08dd87f6b07d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 14:52:55.0460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xOYOC+6N0e+UN2TZzO7laSc/a53om1lDJyWaREg1pGwsMDFs9qGrEBl+5DQn3HwcOqNR+XLUK8CTTf0Q4Myq1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8153

On 30.04.25 16:14, Jan Kiszka wrote:
> On 30.04.25 15:47, Philippe Gerum wrote:
>>
>> Could some (preferably several) people check the patch below for
>> non-regression specifically on x86 with stacked irqchips? I ran into
>> an issue with interrupt forwarding while working on the xenomai4
>> netstack which that patch addresses. So far, so good here, but we need
>> more eyeballs and tests for this patch on a tricky and critical piece of
>> code.
>>
>> This patch is against the Dovetail tree for 6.1.y-cip, also available
>> from [1].
> 
> Does it apply to more trees than 6.1? We could push that through
> smoke-testing CI, but I suppose we also need "real" workload.
> 

Seems it applies from 6.14 down to to 5.10. So, here is the CI run (for
stable kernels):

https://source.denx.de/Xenomai/xenomai-images/-/pipelines/26015

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
