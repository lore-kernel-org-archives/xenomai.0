Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E62132804
	for <xenomai@lists.linux.dev>; Fri,  5 Jul 2024 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720162531; cv=fail; b=bjgyN0g+LdFkdPxLVD+it/YnObesTvTsM4qtPrLpcLkw28jXp9mfsIKxpUY6/omdL7bcqnkk55SxbY2pVJH7vdCOK4Lqc/zjvqkUsDWGoFSpOkVoC/jICNUsccrmAAbzYTIuIqL9lu3JMI3419HEB23LSoeFQgTqGhlQpOeOQig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720162531; c=relaxed/simple;
	bh=L6/Glyarbi4sKcg5ZrtC2pVxNqGbf8m+7z1BCjncIw0=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=fabtVXkoiw/jZ3s8nxIoOVrKe3jMfYzDEWyKYH9BXafBPoZrwyuPYJnNMOhLEDjRx1sA40KlsGXnFSIsrw4M9mczIEQZNJJ3P8yOXNpae3NWl+4Ip6Q4AI4tYRpJLWUGHus9ZAoAz2ebyxs+LlYrY1gsHCb/O+1x15Q3hl8SvV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RISpGjWg; arc=fail smtp.client-ip=40.107.105.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RISpGjWg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jar40EpEYZKviEbXBJajrR3PUHUU0pTDd6wVecjfHodaBLBhzP2XGV7ks6vhxB4KMXDE8NNIFvzXp0+H9DoDBfnw0c39CX+H0MRo4i5YyTHS4urJT3BT/KYarcORmMryDmSOzfTE3K4Rr3Si7xDdOkGt6n90VO8DYxZLmYYNy4mf8vJu9xSj+o2ueg/+Eyj/qgIRilq65VSyFEHe6EbPJLLLKu8zkWgCBxmSq174A2/4ND67C5OFSsjtgWgDYM3ltZCTQGIrxkWW6rpqlprSD1SFIPti6vi6HSVcZqskzQDaNbjMC5PgAi1ePGhGCi1c22jlrrkfOgxA7hnRfwoE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYioIS8K4pxbTmnQdTPy3S3LrHnRSqkP3XKpcVEFH2k=;
 b=SrWhlH5MNL+U3cyamJQS3bAmnyfI7KRYMYFhgEuPZEkZDg4R6aeE8nsTlLt+PLcK6k/rlRn+N6olcUKAo8ZB54q5qqQAKrKSyalfTX2LW32njxqOhYnx+yC+mdlCRowhEg8grNDXr3hdnHkeLPI0VvafU/StfRKGPxL26oo/dempijIx2ELZh/BnxMFh5nzW+fjTmjrDafDtCcwJUCAufTMQZH5Rf+owd7fi5WtiL5iA8KMB7mcG/EX0p8RDc4hjSwOTKQLDeuwNSxfLf6c7KEKDuhNlXfjLjSUGZWhZVABjelu/97R+DLUYC/a98YZVaPwPTHRSESexrduKI6h1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYioIS8K4pxbTmnQdTPy3S3LrHnRSqkP3XKpcVEFH2k=;
 b=RISpGjWgjcQdkI5z8sEK6rQXl6zr+RNWhIrtztLSUJlB/t+/n7uQQB4+L/Ksq18K9NLxmccnxj4j5v77NNXLD53UvbyS+sSUf6AyXdpnOJk3mf5XaXJFhYqhGD6A7qZZb0uBuQTvwnVoIGLC9Ul7TipvQQB9odBgvF7WO4zSllQoqupRe/m0LqEBA9G5zo4nbAJeEr/hF4ex9J9U/YyzPlgBcZojciXFLXdtEjQsrdDNd4AVgoVyDjUh1m/9QEd6NGr1Te4JJPtjFPjbyJFosbxqqisRXnL6ZkKPWlcYxoZpJ38iYKl/Gxx/kMzY4wx/A1je2ee0BxjFg1vakIgmMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8147.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:652::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 06:55:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 06:55:25 +0000
Message-ID: <32ec5e8d-c8ff-4bf0-9718-2d61340812d7@siemens.com>
Date: Fri, 5 Jul 2024 08:55:22 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: Retirement of stable 3.1.x, warning call for 3.0.x
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ef1ecf-67a1-4e0b-7d5a-08dc9cbf729b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTAzVENpTmlkYTg1Tm1ScitHWGxYR1R3b3JlOFgzSnhHTWRxYnpFc29VQ1hE?=
 =?utf-8?B?VUJ0VGVJWTVnNy8zTHZrRE1oNWZVYUpDNjZtbUlyeXJYZVI4SWxjenp1QUJl?=
 =?utf-8?B?MjE5cDJXUHZxSURGWnpqdDYzSkRHOU83MHJGVVJubzZuR2wzUnJJNkVZRERa?=
 =?utf-8?B?bFRXOFI1SFRqTkpQcE9STDBzUkZvQkFTbUVLdG1WQUxsQXJDeFAvaTFGcGhq?=
 =?utf-8?B?aytPUkNJMFB5ZXdCcjZ1R3h1MFAwUE5YWDZ0T3ZMd0xkVHJMWWYxaHVFL3Ay?=
 =?utf-8?B?ZXJpMG53RFphMVZXcVFRYmQxQkVIYldrTC9vbW9PaFdTS3I2d3RSaHNLbjcw?=
 =?utf-8?B?bFFkNU5XZkUrc1lGY2lIYzJ2TzNGNzVSRXRaQXpYL1pOak1uS05YcDBTam81?=
 =?utf-8?B?c3Z4Q0k2ZWtvZjExaVg2ajFZUkkvaDkzcHE5RmZEdDRTaDVwTW8rRldNY2Q0?=
 =?utf-8?B?RlU3aStzVmpsM0dpVTVQYlVIVVhNQ3lGcXlRUnR2VWFsdzdWdkg4dVQvaDRk?=
 =?utf-8?B?VkVNcFMvUGpodm1FeS9uUzlmVkxzeWgyM1JVM05jRjFsZTcvMzVPSjZ2OTZT?=
 =?utf-8?B?U21wVXJvRVJkYkJqL3VMQmZtajdQTlpTakRtb1BFbllXbURrUmNuQk56dE1C?=
 =?utf-8?B?d2Fqd2Y3QU9pemcra2FJOWdOM0xXRmlrYnFTYVhIV3hhNlZISldETDczMlRT?=
 =?utf-8?B?dmVrcDRRY1RwUVB2WlFINGxnY1U1QjE2Y1N2MmsyUHlFZ3dkSmUvWGx0MDIy?=
 =?utf-8?B?OTMvZ0xQanpIY2NBcmRtT2VZNFhaK3JvQTkrZkIxdEliZ3hXTnlUbEovVlhR?=
 =?utf-8?B?a2hYbkxHZUVYMk5LbUhLRXJ5WjBVcXVxa3hvamVKYXJaTlk3bUdFME01dmhp?=
 =?utf-8?B?OGl4Wk1KZXBhb3ZjNEQrR3F0SUVINndQRFVWaThYZ2taN3ZlcGFlbTNnK0Mx?=
 =?utf-8?B?cWEvOWUrT3VVUWlsOW4wSU0wZnlobC83NHQ5Mmd1M0Yxc2tnRXNPS2tuRFRo?=
 =?utf-8?B?UnNxdTA1dGxzQkZUdmhPOGhWcjhVay9JL2xubjJkQnpoRlIyNXZDRGRVazVQ?=
 =?utf-8?B?dlhNVVdMbWFXNUs4cldDbnlvazJzMGhMVi8zZW5QWDViSE1MQnVMamExclZu?=
 =?utf-8?B?UWhqdi92SVpGR2IxUjdOVlVyVkJBVE00MlFPMTBicWlpMzBMeStzc21GdjBt?=
 =?utf-8?B?dmNIKytkdlNFK3ZCYkQ0M1VRMmsrcVVyMExYalBUNk1tZjNROHZkL2hsOFBR?=
 =?utf-8?B?MWNPcUgxQ2tldkVpZTk1cHVYSzFoc2hML1liWW9kdURRN0EvZkh5VGwzZWVV?=
 =?utf-8?B?cmFRYkpNdWl4QmhZZkUrdXYvTVVFWDhWUjRxV0F6Ulc4T3NFNW5JckI3cXRu?=
 =?utf-8?B?UEIyMnFwYUUrQ2tiR2s1dmJaTm05anRiV1prNW9WTDhyN1lvWCtmelJXaGZH?=
 =?utf-8?B?aTZFK05vaFBoekJHNmpuMTdqNUw2MkFxWFRKVzZiRjBHVG0xZk9iemhDbEFR?=
 =?utf-8?B?QzJyRW9saWhnVHpHNm1Ybm9MbzZWb0kycmdyelpCUURjN0NYdUdrdXlDeC85?=
 =?utf-8?B?NlkrYVNDTTlzL3hBczN1Vm1xZzVsQUhGOXR2cEFlbmNFSXBKM0I3bVQvenE5?=
 =?utf-8?B?UXRSdWc0WkVqSllXYSt5R01xeFZxcVVDcFlqczhuS2JtamQ4bmgzY2JpRURl?=
 =?utf-8?B?MCt1eXFjUkEzQisycmlhR25IZjNTNkwxcmJWQURwbDZRdEp6TDd4M01BVDRI?=
 =?utf-8?B?NGZMbzJvMmNuczl2WU45VCtFYjIrc3NsdTJkQlVRbkRkTVpCbTRrKy82b2Zo?=
 =?utf-8?B?ZGhQcVVQUGdPL25qS0gwQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXBETHA3ejNwWmJ0Y0R3RzQxQ2dFRm4vNkt6U3lCU1ZxVzZiMTgxeFJhTzVI?=
 =?utf-8?B?cm9DTzd2MFdFUWhTSnhiL1AzY1lEblUySVdMWjhTV3dmUU1WekRLYXhDVWhn?=
 =?utf-8?B?cU8zQlhCb2gzR25VY3FwNE1DWWtsbDhJd3NSZ1ZUU081Sk5uODdEVVpDQXdl?=
 =?utf-8?B?RGlkd3NGRnJWYjVuN2I4MXdmZkRKMm1peU13VGZyeDMwV1d5YWhuYllsRkQy?=
 =?utf-8?B?MndSbW5SYkZrZkpwazJlbnJ1NnFpWStCYmJjSnVtLy9zdGQ4YWR3U0hyZ1N1?=
 =?utf-8?B?Z2xCNGVMU2Q0bEtyaThtZUl2V2k2RTRHQkVPeUJ0WGlnTlpHVVNKQ2cxYmtC?=
 =?utf-8?B?ZEs4d0ZYalNZcDZPSW1ncTQ3WmFheTFVQ2daeHhSV015NjN1ZGp3QjZkLzJO?=
 =?utf-8?B?SjAvVFA5SEFQNWFXTkt6NnJpdHQxcS9IMjZjM3dEdXdlMGxkNUVNU1dzUDEx?=
 =?utf-8?B?TnpsaWtwaHpKSmdBdUtqV0FMdXZqdGtPdVFzMTBQclQ3L2JXaWdubThZTFhE?=
 =?utf-8?B?MHhtSEpEOHh6SFhyK0RXL0FINmZpOEZtd1RxVHd5ajVRUkp6RlJTVU9jaDdM?=
 =?utf-8?B?cWV2ZWNiSklqTTdnUHVHMnFpRGFRMkpEaE9YaWVndFJOVGZjT0JyOEEzaUl2?=
 =?utf-8?B?aVFzODZJRVp4eTVRZGZqajRoZTBpcXVvOWwrQlFreGZiMTRVOTBzU1E2R3JL?=
 =?utf-8?B?TC9ENXlUcjFMSnlKRyttRXFRa1A4Q20rZk9YVEJ0Y0YrS25aRUl0S24wMU9F?=
 =?utf-8?B?RGI5UmtEZnE1dCtTR2FIdXd2WFNHSmFxN2tqMGpNMHRGUjk2a0xSWEJ1b3l5?=
 =?utf-8?B?ekRGYjF4WXlmWkhSTjAxblN3aFV1ZFZybnZiRkpVQmdVdlNUeWNUb3ZoN1JZ?=
 =?utf-8?B?cVpzV2FIWjRnajdHeVB5T3g2MXB0aGI1bzJWWnlQVnVvUTdKNCswSU95OEJu?=
 =?utf-8?B?SGR5RStucE5pa0pvdXNLU295SmZVYVJCSjk2TFFRMkRLWVJySFVwWHlLVGJp?=
 =?utf-8?B?bE9zSjdsS1F3ZWhHTzR3SG1kWXg0Rzd3YkE0TVJHSzZHSjM2QWZRZGNRQk1o?=
 =?utf-8?B?V0lLMHBUbnArbjZwRFBFNkVDNEJvbXR3OEs3V1hVVXRXM0lzS1JvUWlrSGtC?=
 =?utf-8?B?bFdBKzQrV1p1YnYxYVJmSGZUdEh4N1VMQjQ1MlF6ZXQ2VXZjWXdWdUkyNnZE?=
 =?utf-8?B?M3Z3djJ3bGZFSVFGK1huQU5FVlJ2eWpIUWpTNzZBZmhjZjh2WnQxaGJWUm5W?=
 =?utf-8?B?V2xXeFRzb2F5ZmtHZ2hkMDRJYzFJV0U5Y04yaVRvOWRMNFMyUHVraDRRYTdn?=
 =?utf-8?B?Z2lVM3k5NDJoNmE1NmtJdEhoNmlSWGQ1R0src1RaenFhVEJQSDV1VmRJK05u?=
 =?utf-8?B?MThYdU9rL0tCSUhyNUxMcDBIdG40NlFLUElpUVh1Q2J2NXZHbTRrNXRNTnky?=
 =?utf-8?B?cUdobFdlNXhRT2NIb3NPaHJHQzI1VEdIcmhPb1pLNDM0Rm5HTXg2RHBUdXRG?=
 =?utf-8?B?ZkptL1FhY2VjUWE4a01SMUFFU3lIWDUxbXJIVlFqVmppcENGeWQ5WGNNWFo1?=
 =?utf-8?B?RWlreEdRRVV0Z2oyVTh0M3FlVE1jUUxlME55bHliTlpZeWJZTU5ZeGFWQ1ZV?=
 =?utf-8?B?L2FHVGRsaUNkWld1OCs3VC84MUoxT2RRMEVyM0plVUFqZE81NEtkUmhmdS9K?=
 =?utf-8?B?WnNMVEdJQU9ZVTRnenZDS1Fuc280VU9JRnMvbWkrdHl0Z2VKM29oWkI2UVU0?=
 =?utf-8?B?NTBhT3A0cGQrc3l3c3h3NnNIQlZETEE0aEdralpQNHIvSk1HL3dxRjRPbGpF?=
 =?utf-8?B?Nm9hR3p2KzBUd01nT3ZuenRlbThWWVh5NTVMV1Jia0tCbDMzcW5ZWlJpempk?=
 =?utf-8?B?TXVuak9ZMHphd0lkRnVMODQ4WnRUL2hVcUxGUWkyZXYyaGozRG11RzByS0Zu?=
 =?utf-8?B?WmdldEVKSTBoUlg1dWQ5ZTZ6VW9OdWFVeHN3NUNkckZYSC80azMxNUdaemh6?=
 =?utf-8?B?Y1dmYk81UmRyV1Z5YlJuM2Jqc3NTTnhsbjczdHZ5TlhhaE01SFN6WXYwUmFa?=
 =?utf-8?B?VWVSQTlHRXRQWFdCendiNDI5ODZQN0o0ZEVxcnVjYkFWcjM1WTAxRkxBSjFz?=
 =?utf-8?B?NkZiK0QvTXduMnpBdG92dWNNTFIzT0JYUUlqckthN2srV3o5QnU4TVJIcm9S?=
 =?utf-8?B?VVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ef1ecf-67a1-4e0b-7d5a-08dc9cbf729b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 06:55:25.5939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJw/xYqHEaeoGQPHVxALl5T1DNPjnPFXtO/cmRk31JE+p4AY235M+HrhC+cDj7K6xbMM5rntUp9e9RJAm8efrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8147

Hi all,

around the upcoming 3.3 release, I want (and need) to reduce the set of
actively tested stable trees. Soon I will do some final releases for
stable/v3.1.x and then remove it from the test CI. If you are using that
tree, I strongly recommend to schedule a major update.

In case you are bound to the 4.19 kernel, by now the only supported
kernel with 3.1.x, a natural choice would be 3.2.x which also still
supports that kernel. But more recommended would be renovating the
kernel as well at this chance.

The 3.0 series will remaining formally supported, actually only because
I have an active user on it and need to keep the test pipeline working
for updating the 4.4 kernel from time to time. However, once that user
moves forward and I hear no other voices, 3.0.x is the next to retire.
Be warned!

Any concerns about this plan should be brought forward NOW, ideally
backed with support proposals for the aging trees and pipelines.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
