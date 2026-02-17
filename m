Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A4B36EA9E
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349778; cv=fail; b=CYuo1Pk4CmJNxGnwoxwQOmLV3dp8s4YSxsCHFAEW6itMvrtrdYVsZF+ljIntjJ7SgTZ+JMklqFrZ8c9ftgiMlu9lYUYMnkh9ZLC0mwXRSV8YTDSalO+AMvfG0SaidRkdM4ZUn15hXZKJ2B7WazGLLk1ifM9EIvUAmOHiwbBlfLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349778; c=relaxed/simple;
	bh=A0AbrTD3MGNO0ekHv6zYoiLNRG6JO9SgPt3OnCQzMJU=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=WfgaH0GhXcl9mp6lwgYFiD4lIQaa46HGz/UvH/50D/YjEWeR/13mpNAY5Ocd4dpxhucMg0Wk4keQRWqET6rhak5hQSS5mOYASA5OVA7rXvs/zJq6rOeTrXTwarQUd3nUxMlPyNoRzoEZsfHFgBTEgtEbVC1HH1haVfVm0Qsq7gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SVDjRqpB; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SVDjRqpB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciwHbWtolupHT7iv5Vq2vbMTzQQuiZg6qAKu8XOxb/skSEYY7aqEtBVO8JlEpqcbVCRXy1QHYkqrUMUOPPMHueEHcNBSHcUuWEKcn4Hl/Ocd982LXvPfSilFb6GLdBmbsFpFDOeE4TQenALDtcuaN2WKniGZINSQxOqTpDWDS9btV1eJpIORxMo/lmq0ysVZPRL8T+m11luB+ahp1BxRlaSob+HkWQ+IKcxH2hQE8DVr3QFoeuNaPRLJv2QZbsvZS4mm8i8CXjEx9ldrYA7HnAJzhqLgCJ3YopqLMeytCYcr+BN3CuAWkG+uW+0sfihRkDw59lekmMC8VCvjB5J/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1WIxGM2KkfUZa1rCb5uSW7Bks+RIW+m7j4q8174ulg=;
 b=x2srHILbIXUIcoPBoZr7KJLBcWGWQYYalypNQLVFblkL3ckgjSd3Nn6DYDeicJL9/tgiK0R6YkUJvkwhQKS2YmYhu4xccaK5pchLCiZN89SJLh975L66XfB6CjaMKfp5EDa5G+dfIGuPTdluwiGJ822KqjLgi3aeHUoskj0H3EhzRczACCJGGe2WhmzdL6JDOImIigKNN47pp01WpzqCaHeHsYFLxkkNreLrCaHPHKTFzy6DYn3isXzIGX/k7MCzQNcg0sIgZt7QVTBepLaPf4YOE2KORYqDY5rfkBsHGbfjf4G59Xprf2sD1EE5iZxtgQWGnXU7X4e8dERCLgTL5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1WIxGM2KkfUZa1rCb5uSW7Bks+RIW+m7j4q8174ulg=;
 b=SVDjRqpBV/FWBXLBSXOpvfb2szLQX4kwnaAsGVeE9Lgz95fRCArJkWy8CEQJEaCKidaiHoTcKV9XpER4N6vq8YBoYXNqE3BI7LuzYZTnUjHNbdw+uOopJIadp/Cg5dEySROKA0l/Wca3L0AB3gNp0S0h15ad4zLJYBvKmywIM52Jyox8vObqTkAzlbw1liFIY2QkfE0mPNkHfI4hq+uJYEXr7DyFuTBSIm6KF1pO2KE4zd/TEv/zRHgFbkdrMl3WDpKgeB0M2m/f5gioRhulx/kIbT636P/XxuNu0CfFy7kinEYzzyRCNFFwTnliCoYN67JmWkeUQol5e7AJ2ORE2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6054.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:535::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 17:36:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 17:36:13 +0000
Message-ID: <b1f70b67-b363-4b6c-a743-90ba6f21077c@siemens.com>
Date: Tue, 17 Feb 2026 18:36:12 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, February 18, 2026, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 14df4c43-70b2-4db7-5936-08de6e4b0bb4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3pya0ZTbkVhUmwvQjRkdTc4S1UyaDJzdWJkME9ybEdIWFBZYlBRUHBFUjYx?=
 =?utf-8?B?K2M5bmNnMWhjbkRYRG5kem9yc2xKdnpKd0c1VjhlVXh6MmgrS2c3d0dpY0s4?=
 =?utf-8?B?VXNvblBwWi9ZZzFYaGNBNkl1Q3VNNUErbVMrZzVTSk1ZY3FhU2hnSWdFeEZ5?=
 =?utf-8?B?OFBzb3dnRTB0OU9vT2J3a0VTUUU1SFhYZnp0Tm9McmRCUE1KZXhRREF2WE0r?=
 =?utf-8?B?cHRSRVFSZExXWWtVZmprSHl6YkFTOXh3aWtVdTBMbkV6MEEvUFdwdm5pcHN0?=
 =?utf-8?B?YnBVZDZLZlF0TUFpMkpBd3RJNkdlNFIvY3pCWG9jZExmMTVhdFVlZi8zMzV0?=
 =?utf-8?B?SWU2c3dGWGZjYmo1MnpkUXIvRGdaaTh0bXQzZVdRMmprOHlxMHd1RFhLbTBN?=
 =?utf-8?B?a1U4SEgzdUZCYksybHc4Rjlwa09uY3pkRjBNYlVGNFNneGlRZDFEelBzOW11?=
 =?utf-8?B?RWE2ZDVzMWVsZVgyMmlIRFF5OFhqaFcxNG5KK1k0aytEYWZCVGxkTnFJK0g2?=
 =?utf-8?B?RjMxdGgzc25WSkRzVUwxTEJ3c2drM2FTdEgyS0FGTE94RElNN09FWlM5cnRl?=
 =?utf-8?B?TUJjY3EvU1hXcTFacEhSU0hieHZIdHpVVkdjUXNRMWVEb01KZUZjWG5lNzB3?=
 =?utf-8?B?N1FSYlhSYlVZOGNVWGR0WFZ4cXJXUnM0bGhPdURFbGhlZSs5QjhFWEVpYlB0?=
 =?utf-8?B?ZEhSOUxaVEg2WEd5bllSbmcveDBSNkFBdHBFYkd3aElsRzZMczg0VHh3Uy9G?=
 =?utf-8?B?ZE5pVS9RT0ppbko3dm8zOFF0WFl0NlZsUEFwcHhEQmJRY2VUZnRXdjNXN0Ew?=
 =?utf-8?B?TzV6Vk5oby9KWFFFa2dsdzBKYjFyUklZREt6SlFMVk0vTGVtRS82cytqVUYy?=
 =?utf-8?B?N1hhMERNeGVnTlB2QmRIRFdSWEQzb1R1VXA1VDhiYlR2QVU1M21tNXBnQi93?=
 =?utf-8?B?a2d3SGRVSndtQ1NuR1ZlbU1uVERCZkZoNjhaOFdwMGZINkVKTm1peEE0V3NM?=
 =?utf-8?B?TUNDMXNpN0wwR05lR0NNTC95bTRzTGR3WkVmQUkwRC9DL3IvTi8rQnNhT2Mw?=
 =?utf-8?B?NXlVQktQYXVrQ2pVN3ZlcVluR3BzVFlmZVBwZ1NCaHJOQ1RsZk9UVENJdUJx?=
 =?utf-8?B?MGRIeUkzM25mQkFuU1BHYkhhcUswSWxhUUg0Z0xnK1ErKzkzbGpCaEZVVU12?=
 =?utf-8?B?aldMN0dOZFpuSXROS2piNHE4TGR1TUs2SEcvZ0hyeHQ2TkpJdkJMRjNwVTBN?=
 =?utf-8?B?VG52WjJCSERSalcrZVhwZm9GelpCOEFnSExOK1BydHI2VkU4UW9OSVZyRW9T?=
 =?utf-8?B?M3l5MEFld014bWJmL0g2Vk9rTGVTZ00yRXZxUEs5a0JINUIrSDdzdThnTGV3?=
 =?utf-8?B?Q3FxaVEyS3Jsend0ZlF1a21JKzVEbGRUYTY1ZlpQblV3OTJXOWE4WTlNSnVL?=
 =?utf-8?B?WXk5S0dHUnExc3F6NDZOSGRvUjJUR3ZtR3YvbVJGYytLaHo2bFRIOW15cDlG?=
 =?utf-8?B?YTdNYThzTXAzZ3NvSmo2aVRTcXgyQmpHVy8zOTBpUWVJSFdPZE1wYi9mSnR0?=
 =?utf-8?B?VW1wSlFFNGs0Z3RvOWxZMFlwaFlDS0ZjZWtpTVVVYTV0RGxGT250NVJ5TGsr?=
 =?utf-8?B?am8xcXNsaW5aS3JDYVp1cHlGK2JLalVVb0dCWGo0S1Zpb0RlU1NIbU1VelFz?=
 =?utf-8?B?R1BGM3laNVJmOE1Zd0xUUUMzNGgwcFQ3dEVHRFl1NU5scTMxenhkMk5zZXlG?=
 =?utf-8?B?UzdYaWVyNlZpaEFYZjUwQjhIbm5uYUIwcm5mRjg2empZdlNOMnhYT2dQRjA1?=
 =?utf-8?B?S3dHZnQzMTNBSjJjZnhmekhHQUphQkRaUTRFZzhvbjFUNjFHTTh3L1NZVnM2?=
 =?utf-8?B?YzByNlRJVjhPY1JWV0pRaHVaZ0dlZm42c2kxMlFaaXY1SWI2S0pjMzJWVUwr?=
 =?utf-8?B?MEpueFhPWDlQdGh5Vklvc25oaVRQZHNUSnBUQTRCSUNMUHNsWmduci9BMEMz?=
 =?utf-8?B?alByY2lIUkdaeExjRTZzTWNjOUJTU2VPYVNnRFZ0V1gwV0JVSG5sZ2w1RlZY?=
 =?utf-8?B?N1JCTXoralAwVGV1aXcvajZHcEc5bkN3V0NUS0NVaHg1VjFMNGVKMmYzSUhJ?=
 =?utf-8?Q?qDSI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0V1RnQxYkJuQmlkU09qUEY4ZnJrUFY1ejlackNycmgzeFlYV29Sa282bWox?=
 =?utf-8?B?ZG04cVZVYlhqKy9zLzI5cmxkK2QrUGhjNEoyTmxMdWNaVjhlWGpRMDB5Umxw?=
 =?utf-8?B?U3dXejJnNC82U1VmdTU2QXE4SnN0OFJyNnJOR3ZveWJjQi8vV0luazdac0dG?=
 =?utf-8?B?bWw0T0U2YWZDbjR5L3YxK1FsMXVOcTFJNGZ0WUNPSGsrZTc0V0hveEJiVzZD?=
 =?utf-8?B?SnBNUUlPOC9CTGRnci94WG1XSnNqSXBteGhVS3JLM0NCWlhpcWdjOXo3dmVv?=
 =?utf-8?B?dEV5SWQvWFFXWXJXdzYzWW1uSUV4YWJINlFWQWpwY0dQaUw1eTk2aWtMQ0Nt?=
 =?utf-8?B?Zlh1NHNpUkpMKzdsZXRxd2RwL255N0ZyS3dzQ3pYQldWSGZwL0pHdi90UDVC?=
 =?utf-8?B?REFJeXZhQ3hVN0xiNnNOTE8yZTBCQlhhbEwyRzVLTlQ5WWVTWkZ4b051amlG?=
 =?utf-8?B?UXJEWGoyenExbjhzSjdYaHNnQ2ZJczB3RWxLLytabUlGRXNjL2UxZFV5QzVX?=
 =?utf-8?B?cUZsMCsvYUlpbGVVU1EvRzFhYnNudmMzb09WN1liWU02K0Y3VDJPRnZabzB5?=
 =?utf-8?B?RXV6c3V2ZWhOOWZEbzN6OEludGl5YTVWVUxwWm4rV0JGbFFHNTdYZUdaYlhm?=
 =?utf-8?B?eFNlOHI1L2VSemxkbUdFVkU1VDJ2SnZFRWRZOGs0UW1DaTBtYzhVRDVjUTRo?=
 =?utf-8?B?S3E0SVBNUzdScDF3cExkMWx5TFVuUll2RlgrOGIvd0lLbVdaTURWeDUvMUNI?=
 =?utf-8?B?ZVZZZ20rZnhHL2JrcmFRZXlVRFRsU1BSb2JnNXZ6cmxDOVg5NGhuUkJIcXcr?=
 =?utf-8?B?ZEZ0blQrNnByZ29PaGI4SklGUVJ3OWwvamdhQ1c1QXB6UHFpL05Jc1dCdmY3?=
 =?utf-8?B?VmRoVmNpVVcyTm5IVGhCcHd2Q3NEait1UCtJSW5uZGhvUDBkWmNJdVRUeGZI?=
 =?utf-8?B?aDlwUU9ZM2tMUmllNERmWTRVRE91dzJDUDAvMURlR0tpbVU0UVVpaHpQR1c4?=
 =?utf-8?B?K0gyUXlNL2ZrVm13MVJhSjR0L0lUUVU0K1BjYTJpZFd1dWNDL1lwNGsvKzdU?=
 =?utf-8?B?dUpLazBOT3piUVk0M0V3cFZxcUVJdkNJbWdmZEV6Sktic2t3QnQ0bERxOTlF?=
 =?utf-8?B?VHUvSHZmclRGWnhBNmg1aEFRaXlzUUdHdWpqUFM1U2l6ZGpaYXZXZW1rQnRa?=
 =?utf-8?B?eHhPYVRUWG9GTFpUaXBVZUNEVmNSSEF6UE5DVTF5anF3Nlg1R2U5RHU5aHRH?=
 =?utf-8?B?SXBzWkZBUCtVOG82anByZlVCV3ptbzBXNVFXTDNUTGNFTGVGb20wOUNxZDhH?=
 =?utf-8?B?RGFxNnQxdGN0WFl3eW1LUWphV1BWeGtFb2ZjU1ZkYkpmY3ozTytUdGQ3KzFT?=
 =?utf-8?B?WHlnTHM5ZGpQMmRtOEJmeHpyU3Mzc2xFM2VPLytMZWVGdEhlVFhkL1BwR1dI?=
 =?utf-8?B?QnpYL0d4YkFRTmtZbmRhenAwNWRHNFdmZTBjM3ZkTTA3MTFiZ3pCV2lpbVBD?=
 =?utf-8?B?Y2RPTGdSMWpmQm1LMkZ0MUR0ekhzN2Zsb2RCOTdKdVppWm5rNys1ejRqdUxR?=
 =?utf-8?B?TkNhbHY2ZDMzSmR1V2U0cXBScVUwMlBZWVgvSDlQMEszNjVWcy9TSkozaFpr?=
 =?utf-8?B?WjVOOWt5UnkzelliWU83b2JtR1R5VVNIQlJSM2hsMzkvZEVZVm5lalIrL0lF?=
 =?utf-8?B?T21Sam5ZSUZpMW52dFhaN3JaTXV0ZGdnSkpaemQxMS81ZlA5YVNPMjhUekFI?=
 =?utf-8?B?QjYzNXpzTTJqR2NaSy9XVHFaY1RhQTFjbkRmb2E0YmV6OTlBQU5udTZLUjM1?=
 =?utf-8?B?YlR1TkFCVGU0Y1FqK2JLQWZKeFlFR0c1Uzd1UEJuQjNwUnFYNlFMaFBGeTZW?=
 =?utf-8?B?cGVWVTc5enZMdUhzSXdFNlNjU3dvbGY1aVc2bEpXNHlTU2d6UlAvZW0wcG5V?=
 =?utf-8?B?emV4cTBNamZOQlZtOTZxUENkRmxvanVVUWJCOUhYSkVpM2tXUk1GVllPdXdW?=
 =?utf-8?B?TzNRdFZNdXNhK2t4VnNOa1ZiQ3lnUC9FSjJBc0lvS1JuWWRUOW5zeGFxbm1m?=
 =?utf-8?B?UE1vREtVWFEyd0I0d2NIMTAxZmZhTTM5WlZTYXp0ZnZxUzVtMGcweUIwbUNm?=
 =?utf-8?B?SGxDMm85NlhGb3hwTWdkS3FFLysvTWNZTVBCbGdZaUpMRVdKb0tNRU8yYi9Q?=
 =?utf-8?B?WHZJYS9FSzh1SkkvSkMxYTZrL295dzRxdFh2ZDVkeXpqT2YrR1VvZmZSZko2?=
 =?utf-8?B?d2RtbkcweXlZWVVsbldQUDk0a3lUWlJNenVXTkFnQlRGd1JucUtibWRQY2h0?=
 =?utf-8?B?cGVDRm85UkV1M3U1MWlwd0pmVWFQdlpVenZ5bGxmbG5JRS9BdUJnbnJQWlZk?=
 =?utf-8?Q?ZX8BwuA5OwEk1kEY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14df4c43-70b2-4db7-5936-08de6e4b0bb4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:36:13.3066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Qc3SVTnRVa3JPL1oKAqRBkrTytbj4evCEJGag1hZrSpo6XjYdUmkkj3jKt6QearUBa6QQJ/OJUNXbfJki3eTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6054

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, February 18, 2026, UTC 7:30 AM
Paris, France CET 8:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Happy new year to our Chinese community at this chance!

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
