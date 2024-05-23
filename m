Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949D7433C4
	for <xenomai@lists.linux.dev>; Thu, 23 May 2024 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716473814; cv=fail; b=hHXsNOgaUL2ZilnpMWacxRzleAwWRTLOM4IBCMkrO2mfBjJJ+YlL556n6Kw/qOmUfhC6/toveF8Gf4QWHTIkFmHdF3bXD85GqCwbNgqufsYGldFCp+uBpIs4Gh2b0XjlfLuwfkIcAKcHqZ7VkyhZGrYnd4xr78sVkaqsYT8p+no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716473814; c=relaxed/simple;
	bh=VBvqLTqwsq5SvACRrVn1KxeLRp9RxNHyjAQeIe/Fs/A=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BdJXgtP5Zd4I9KSMs5NJ1XElMciHdJrZOa9GSMHOwZSBU3Yu5EpqnllNOta59/1geqlBTUeTQq+Vc4pDs2+0w7iLB2h5lU/dFN3792mtO+Jrn4kISINK0wk8xPHPaYbRMsfZnWgkiAc5DzGFJ86IpfC8qEyBaEDFUYGm86+9yDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jGThxv7p; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jGThxv7p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pb8WI/kvZSo5KI+++HA10I3hkrPM9tM6LJY1gTODVup5KsonnQf88YQ7kbvFRkMn73bc3m3VF75Q6Tc7AKFGhFHdDSrks6emngj3lO0LBDaXJutaJ6fPcpM2U0O2PXTcUPUT04LNmb77qU7e+wqAnpDuZKc5+dqoEMFDOp3h2X+zpMo49shbUKUk7qP/KwUrmvjY7HZcWS1DZ+L+DQPEn3JWInT98sVKH3M+eLBx4H+taF8fw9lVVmANLJYON3otrn4J7eUzfSFNqvanXSSLv3NfI0g92aRfa1YvQDrQyPr69+zREWWfLOVTCwova5pKLn+MltLJNXJItLXKVS51wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6JdpB0reCtXpmMqF3/8R2mr9FSaot0uZ5motHSKkdU=;
 b=SkyO8QISmUALaVr4bXEW8WMlgMSY/TvI5NNV8fRRmWiaQtzGvkUutnMGZLiV4LcRw4QkJ1yWNs+tCuAEFBzXOxflSlDA/SdpByEBedhXcz/tBNYm54wZi8Q4FuSxR3XfsbB7xcCaSGFuI2hnvKAi2Qbw5wbpmXxpW8SUyOLJzFTi4xeL592V62msPY/1D0jvwazM5F5xPztcBvOHLT0gUszl3jiaXzuJl7IZJ+0wsiNSCrM47CS2DvYQtQnaS9bScJCqOv9lcv/KSIHwkRDeZycuJib46PRR/CCTfL9dk4S0B2FruWCnj/jY3QwwkZuMxNs0Sj97pkHxuYasqhqduQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6JdpB0reCtXpmMqF3/8R2mr9FSaot0uZ5motHSKkdU=;
 b=jGThxv7ph6jnDOhZNU77VM8nUzPj95X1AGurldUcPAmp8FSzNL8qQHaSWamymtWWrKh+OtHHC0TkAcEf7V3JjZIM6zUH0Ym7rImoLaZ89tqhblcmgouGe9iSFXVjMad8Wzfl3yI8O0dCOBKOKE3oUnNTfqV3o4gO0uUyiaNfuimTs79nhqdWwkD2RK2LHFhN3f5JTHhcMNztG4nXL2XVZCGfkIiwAX+OG9DsnPlMRnZFmQUttJiRDfatPqNIUELFWBzyZQLPVbeus2dKJ0nBnPyvEU3+02mafnDsfGyrAElLDAZuaIGpBuSIpFXmXjiem9XVhN3ezX2RnQOOZjjDgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8919.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:442::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 14:16:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 14:16:49 +0000
Message-ID: <5a165aa5-b50d-43d0-bc2e-a9f831604557@siemens.com>
Date: Thu, 23 May 2024 16:16:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rpi4: Add rpi4 (Raspberry Pi 4) as target platform
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 "Jiang, Yi (T CED OES-DE)" <yi.jiang@siemens.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <20240521134841.21749-1-yi.jiang@siemens.com>
 <20240521134841.21749-2-yi.jiang@siemens.com>
 <81ab4ff0-6eff-4944-83fe-336c965b9ed3@siemens.com>
 <dafbc406f9f93c4a77d3e95fcd5f5d8fa2f792c5.camel@siemens.com>
 <92eb843ac00112e48b460f6b87e4c615dc8fb943.camel@siemens.com>
 <82b54361348112dc220d25db6c12f284898ddd2d.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <82b54361348112dc220d25db6c12f284898ddd2d.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: fffcbb23-ccd0-4b79-2586-08dc7b32fc30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFdUQWprQnRveXg0Qkt3NVRteGRxdVVsejh2U2M0cUNwMlZrenlWa25lRVBU?=
 =?utf-8?B?NGs0REF4Ni9BTmkzcCtKcmlhalBtaW9qRWY1L21mWFhMb3J3UlhLY2o5TnNj?=
 =?utf-8?B?bEdscGJvVlBhZHFXV09xZ2lDNHhJTGhwdGc3SmppZnBKOVRSa0JWYUxHdGcw?=
 =?utf-8?B?SGlpNlh3Y25TMjQ1b2dMWDZaTDEybjZlNEV2RTgwcjJJVFc4RUZ4NWI1QnEv?=
 =?utf-8?B?MlUxZWJ6WEFXRis1V0ZsczI2NmVrQnJtVWpWUGJIQVY5UGdlbG84OFBsc3Rt?=
 =?utf-8?B?c3g5TGY0UDYvUmxjeEhjQ096TEMwSm94S0JEZUNGWEpBKzhjNjYzOXpGZnc0?=
 =?utf-8?B?czZ4VEJrMXdTRVBRRXc4REdHL2xsdDV5SGpKL2FSVWsyVnFUTERZSEk3YVQ1?=
 =?utf-8?B?d0hmRm0wbjNoZmFPQmV2ZlVJeXRvZG43bXYvS3QyRmp5K0diL0ZCNDRadVFN?=
 =?utf-8?B?RkhoUWQ4SUV0K25IRTN0Y0t1anM3SDQ5ZEVRT0YyZzNZZWk4YWs2T2pta1dJ?=
 =?utf-8?B?YUk4MmtyL1gycExuaVZOTzFsWUxWbWl2TDB5MFM3VlpkdjcvZ3dXaHVZTjZU?=
 =?utf-8?B?Zks2WEl6MnhHSlZqUlBJd0FwVHZiN1JXWXg1OTJiaDJnUklFejkza3FoVkw3?=
 =?utf-8?B?a2F0NzJOQnNua3Qya2l1TXRQSGN0VGYvNGVYZFpFVnRhTDRRbGxOYU4yUE9j?=
 =?utf-8?B?L3l1L3o2aENZNk9mSmRFT0xVblppdU85VmpDaHBUZmV4OTd6WG9tUlp4QnhY?=
 =?utf-8?B?bmxlVGpPS0tuUFFZVUd4cS9rTXJoUGk4WnZBTnRFSllDeC9mTTQ5TnpQVEda?=
 =?utf-8?B?TjRSa0huYmlMaVozMENXdU8zdUNkN0NNb2ZROVQwL1pSNTdKaWVSOXM1Y2No?=
 =?utf-8?B?c3ErTWRIamxQQXdYQkwraWlmV0RIVURxRDNXTi9NY0hsenJzNTFLQXFXZU13?=
 =?utf-8?B?RDVNaGVtQm1RVnF6UzZYblhPVXNGaVNyandwd0VpTjJrTXphMmpyMkp1WVB6?=
 =?utf-8?B?OVBJYUxiaTQzUEsyeXFyd1dkbk44TzcxQ1dOMThHcllkMjRQcjRLWVhwdTFS?=
 =?utf-8?B?ZVljL09TUUUxaWx5ZjZHV3JQUGd6d3NHUS9hQ3NpcFllemthT3BoeDRYY09p?=
 =?utf-8?B?aWY5UFhkRWFvb2w4aVhObGRFVDRJSHVSQ1BQU1E1eXI1U2xWVUs3dlE1emow?=
 =?utf-8?B?NG92ZkRJZDJ4NmdMS3ZjU0RtejhCZTNlSUhyUFpxUlhHWXJ6cjFSN0prcG9V?=
 =?utf-8?B?Y1RqVk10RWF5b2daK3BxaXVPeWhPK0RnUkx3M3FXQktyTW1tcEhMQkxUenAr?=
 =?utf-8?B?SVVKMmp0RVpDSmtNVml5UkhDcDlmakQxemY0cUtHTUQ0bVBCNzIxa0pGdlZK?=
 =?utf-8?B?Z2VacEdpdktGNHlEL3lzRU1ndmFzYWRFSDVoWHVqbWZCUzcwTndjOGZWYTFj?=
 =?utf-8?B?d3E2KysyekgrK1YvcWlVa2Rnd1p2cEFodlFxbmxGRWgwanUwYkFjNmJmSnFU?=
 =?utf-8?B?RFJTVHo0Zjg2ZzkwUW1VQjNMeXZibVJkMWNiaDFaN2FXUXBaM1dUV1IwSVhO?=
 =?utf-8?B?T2J1TVYzTWIvcE4xZVhOZ1UyeEIrRkgwdG52QllvekVZTDVYL25qRGpuTHdW?=
 =?utf-8?B?a0VDeXhPdlB4TUZJWkNJaXppTTBRZEVhTkpWbzYrV21YRFF1WFJNUCsyYXJZ?=
 =?utf-8?B?SUs5bjdWS2UzUmtNSEVhcjY1ZURUM3BVVmJMNk8zUWs2U2lRNDRCY2FBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFpNblV4K003b1RJVURzeU5hRzVnYjAzRVRGOFg4WVJlRlJWRHBkVzZWYmlp?=
 =?utf-8?B?OE9qU3V6NXRGcmJjWFZYckIvQytaUXRxQ1ZQeUY2NHVrb1BPeXVYRFlmcUYz?=
 =?utf-8?B?WGhRVGtWSDIveWF3K0tWdTRBOFNTSEJqNE9HbFBTRWhZZGc1Mm1rZ2w1Q1B1?=
 =?utf-8?B?cS9BQXhNTUVjQU9iMmd2c0ZQais5QzV2UkhEV1lPc3JKMERNb0R1MWpqZU1m?=
 =?utf-8?B?VHBwdjNNV1dEQUVzWWdjMmtVeDViNTlSTGUvVEhnR3JlaDZBaGZrNm5BYUJW?=
 =?utf-8?B?TVJkUW1EbjFWUTBMMFVWejg1OXFVNjRNc3RpaXZjTEJrK2pIN0l2WDZsVW9Y?=
 =?utf-8?B?eTBKY2Q1d1VKRmpLM2h4OG5GN2pXOVlRZ21TUk40U2hDV0VRZ0pUcFUzdFRX?=
 =?utf-8?B?OWNTRkZzU2ZiZ1BzTTVGdWFCQmQxQ2lTYmhxNURyWndVb2ZOZm4yTXhIOE5v?=
 =?utf-8?B?R3QxMkJxNk9pa0IzQWd6ZFlUbDlPUXJhYlpaVTgyY1ZHSGZBdlFLeGFmNjd5?=
 =?utf-8?B?SW82d2wrNzlqbG5JTzZIZ3ZXRGNXS3FOcmRUa1ZvbGpyTDlRWGRZL1g1bnZw?=
 =?utf-8?B?U1dleVYybmRTTWoyaHNqcVVWQjdxTEtUZ1Y0bDNwUlR3SjY2WElVN1JmeklM?=
 =?utf-8?B?NkorVDNqWmxWS0NHcjdmZXBPbnhGWkhSMkpvcEZEYnVqSDlMNk1oRXZHMlM3?=
 =?utf-8?B?YTNRMzVBSGE3RUdRZ2g2MU1TRHdSNlhENE81K00xSkVhY2JNYnN0Y3V2ZG9O?=
 =?utf-8?B?WmNBblhuTmJKcDhjNG9lOGVrQ1ZZQ1krOTlGLytRaUZSVnRLMzdCNnd6ajB0?=
 =?utf-8?B?ZDV6VTN0SUQ1RVpwRVhvbWw5WGV3MEZ3U2Q2dEtjZ2lpYjFudSs5c2pPYi85?=
 =?utf-8?B?WDFLZFlkeitJV2ZLeFFpNmx0a3JUc2o1TnRyWlNSU1BzU1MvVTJWYy9ia2ta?=
 =?utf-8?B?eUhsWEttZm9tR3pKZW11RFlmelNUeUZMYU5nUWFFS0JBMW5kMjZrNGJsRk9n?=
 =?utf-8?B?YWpkanUrMHREZTlIOVFLS2xWZTRBV2hadXpJN1ltUFAwSmhGK1NhRVdvTDd1?=
 =?utf-8?B?TVM2dGNxSGowdkJxdTY5dXAzVmQ3cU9IOE1xQ3hxeU9TemF5OGxUZmcwWndq?=
 =?utf-8?B?K3VJZ0E0aENjMm9IUXB5MGU2UzNvMW54Z2ZNbHhkR1VPTU9UWmdmL3JuQ3k4?=
 =?utf-8?B?NjlDZVhuR1RzdE5ib2Q0YmNOdHpLQzdOY3R4UkRnVFA2ODZXQXpzbURxVnl4?=
 =?utf-8?B?VkVKMFlWL2dKMGd2SHlOQXVNa0Yxc0UyOTBadld1K05VMU9VM2xVMkROMmV4?=
 =?utf-8?B?RDNNQThyTEd5S21OWVRCQVc0em84Q0dxQ3c3YVlCQzBYUUFqMWZCUFRJUEhr?=
 =?utf-8?B?VDBKZ2JKUWkzdU5zaVcvMlhRclF6TDJ3TmgydXcxNVJ2SFpybjBsNDMvSENj?=
 =?utf-8?B?ZFRvWUp1aWdWajZ2d0VHaktkWklVWFVPRXJ5L0VhckQ2bnp2Y1JyM3k3NVJX?=
 =?utf-8?B?MDNsckMzMVV2eUVMMXBHcW1LVUpkWFo1dW45SVR3SExTTUJ6RVVSMVdHelR0?=
 =?utf-8?B?aHRrZEh6Vk94S0tMdllIRGUzOVU4TnlUcTlBcVVWMWV3c0tmampXYmtYRHVz?=
 =?utf-8?B?bC9aa1ZCbm93QkRlREVVVzBFVEZjcDl5dUltUE5XcWxoZnBLWEpUS3dDZ0t4?=
 =?utf-8?B?S09jSmRyMklJMlJrTE9TbDBXdE5rZ2tVVFd3K0tUREFMMXZjQWpneWQvV0N0?=
 =?utf-8?B?VnZNcjlqa0hDS3JSUlB0dGNwbmV6ck5DZi90andNT3NobDgrRDZSbFEzVkZv?=
 =?utf-8?B?czZROElkVE91ZUJIMjFZM3pONUZRVU14UGxpc3FTN0F2L01NaGx2Z0RnZXNu?=
 =?utf-8?B?U2hnRmZRWWZ3N0V3Y3M2dVJKamp2VENmTHg1T05lSTJQdzlsMEh2Q3V0SG1t?=
 =?utf-8?B?bUtMWjN0TkNSMUREWmNjZEQxZ01oUGJFUG1NZjhjV3ZnUG84dnI4S1pURk5N?=
 =?utf-8?B?cDlBaDBDYXdHV3UxcUIxZ3pFSXVVZDVvdWdiSjBwYVQ3TldZTmlMUkxEVVZO?=
 =?utf-8?B?c3FJSjhyWjF5cTlZZWE1TmtzZFpNeVFMeENTS1h2SDZtazUyaFpmdCtBS3c3?=
 =?utf-8?B?aFBSRWFHZk8xN2dLdjE1Z3AxNVNjMVJUQ1BkYUlVRVlWTXppNklkZS9KSmZ2?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffcbb23-ccd0-4b79-2586-08dc7b32fc30
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 14:16:49.1094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqmGwQDu+iXwKm6+tNUn9/+Px7GsP9sT5WM24RJD6ZSOdHL9g4JprkNPl+so8PjgbLYrNqnyt0VHT/sidmKMfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8919

On 23.05.24 10:46, Florian Bezdeka wrote:
> On Wed, 2024-05-22 at 12:35 +0000, Jiang, Yi (T CED OES-DE) wrote:
>>> Confused.
>>>
>>> - My original patch did not touch the arm64 defconfig.
>>>   So I'm still listed as author ("From:" inside the body) but the
>>> patch
>>>   content is different.
>>>
>>
>> Yes, we do not need to keep rpi4.cfg any more, because the original
>> content of rpi4.cfg has been merged to arm64_defconfig.
> 
> If that really works (especially for the older ipipe kernels for
> tersting xenomai stable branches) the patch needs some reworking.
> 

We don't support older than 5.10 with the RPi, thus also no I-pipe.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

