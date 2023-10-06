Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2041.outbound.protection.outlook.com [40.107.7.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D620B22
	for <xenomai@lists.linux.dev>; Fri,  6 Oct 2023 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CsBB4wDC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPR1XP/8wcUoRT9ojnioc8tCw0IntS9fKIfuOUcBMA4RerY3FB9wxwrs15dXGPAOZAXYnNeH5gNbqagW1S8ylk/YcN7T1wZWqbnWUWsEIZwmj4oIQgXdOx3DkVotASGH4vaMtqIKdHQMVJaM0OpqXD6ehAxT3vwL2eBydGj1AunFJG7BcW3sDJ/6k3wk/wGkQaP5r1MTKYnAo+FK8+zP/slXsX1epYFiU7Wp18y2h7aK72dbvhUuoYlo8ZsLIJQVA9NulJCVlZUxRpiXO28K4xPdxBBhT7GjG0f7XPDhfojD1w6fgf+X63FhxZVYX5SX1lVMd4AykkPckGqCvh7MNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSwHziibVUaxxW7twlbLZ0jgr+tE79B9/DiU+xhzRqQ=;
 b=mLP5N8dyO6pd0RI1b0vQYgbqJz2O/aB3cOOrAQ1qzfaxXyXTplN565jkhyYDS83ojOOKGPFQY49A0IwVyaROM0t3GPcI2Sj6+lLas/6kH1XX6Jr7YJz8OQEXK8W0WUs+4PTl8EYl5i23W06Dre5nWn+0bQGSQBylRkMsV9Zs71K9OCFk4YxVw3J5XCFKcNf2r26vSgLWC4EbXakFM9pffEVKTngHu4coEdLwx58D6sQm16boIcRDbyPHqNtHERIJmbl64I+yJM8/41g5Dl9Mxbp5ilHYLOqWpEBsbkL1KItX9vklU3ulKljAX5i/tY0Wqdujm5ba+eG7lcw8GSmE1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSwHziibVUaxxW7twlbLZ0jgr+tE79B9/DiU+xhzRqQ=;
 b=CsBB4wDCTK2yMfu6PM5FG7jNjgaw74pXLVHiMnB9zQFoRNd+57As61sUBLRoZ6qmeYdSYW4xSHzLGrd94JT7AkHPPIokEVnUoInnot76xxULeaQDebROHyKhMQN5embIc2A0/fnCg4L6Hvkf++aeCXv0BrDTgYDXsZq4WzDuS04yO7aNWJak4ERx9tRI9y1riCg0y3t9u4En3K/8qjZa5jrS+kyXbF3tM175u82vqHG0p5/+hP0bLrDonkh9h20yyYBavTHe1myH+Mat0hHXibY+VCSqNfobTx2CDtUYPEIyeWTqptzAngYYmLoO8rSWqFdxppiVqHHczQiVdpO59g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3904.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Fri, 6 Oct
 2023 16:50:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 16:50:55 +0000
Message-ID: <91c0fafe-7c43-4555-9004-fbe5eb43605a@siemens.com>
Date: Fri, 6 Oct 2023 18:50:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Use Debian bookworm for CI build jobs
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20231005-flo-ci-to-bookworm-v1-0-c0455488879a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231005-flo-ci-to-bookworm-v1-0-c0455488879a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:610:b1::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3904:EE_
X-MS-Office365-Filtering-Correlation-Id: bb39dc62-8078-4d12-d0da-08dbc68c687b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZTDStAZuDpDVHB/U2Iu2uo4Ozi3xU3UP+XQ62i58MtZOtMXhFttYXJesDwgrZl63TfBcYZ0BxKVaw8F4bIkOFcrWZs052c0STxAad5/OB+aMPf4Pijy8IEpHtOho9eCdrCxfDnryGlLFWzQa7RHTEAk8Mha1NtjE8X+zDcXAWu+fy7/HK1whw4i5SriTw0cbo5FP2+TSG2U0wLfFU4yOlpP3GlNuRYFVywM8UmArIUrhiDRgXpa45ZEHbXmjxP9hGzgY3f76oJCA804lRLAUf381kurXI9e5lUdDRXT//c2brDQB9pgfSctKcFgnYUToLnK4E8fG/H0wPLoUUVRs3nQkwSjz/1spb8TnfdL4aojIh6sy3c5hYTaYri45lqkfQ4f9SaVYEEnGIyZPbmUpOXMKLSg8XDdUcIC//i5eMdwYTp2whBLnXWF5VKDJ1akGbVAEtmMfZpqAiqhd6ZGNF25fV3mi99gBTgL6Jqf0igCeK5pbSFyTgEtd4zJOaln/Kmzx1HVu4uStzUK54pXYA6mEmCS5Okub0PjinaRJsMx80fBDbFtUueMZcsfi8Mhs5nYoulaUJQ4FuJop8rJqZWwWgasE0Zd8PFJlP1r+VuFdkh/yiheM4G+UR2NpbwvBiOU5rMQ9GzX3prXZGksR4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(31686004)(8936002)(41300700001)(83380400001)(316002)(8676002)(31696002)(5660300002)(82960400001)(6506007)(86362001)(36756003)(38100700002)(44832011)(478600001)(6486002)(6666004)(26005)(53546011)(66476007)(2906002)(6512007)(2616005)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWtoRFVteXE4THJmMmdhT1ZFYkdzM0g2djdsWUFSUHBNQi96VXJpZGNza2dY?=
 =?utf-8?B?K0pKNjRKVnFNSXhRMjVlWFBzc2F0NTZPejlUL0t4K1JwUGlIcUhmY09KV1Bv?=
 =?utf-8?B?RzhwYU84QkMwUXMrZUxUOTAwMEVZTEtCSG5EaXFlZVpaQnowYnJqbnVqUkZj?=
 =?utf-8?B?blhjUlliSXN4VnVBczFRZEV0dW9oZmp6anJiMDBFR2tvL3VuZ3dVM3E4Ty9u?=
 =?utf-8?B?UHlNK3c3NmhXSlRyQ0psV1BRL1lvMFYrcUszeUNEdXJ2TDhMR2I0eDIxRUkr?=
 =?utf-8?B?eG91QzZNeDNRL1lBKy80b0p5RDZiL25VUDRFNTRDN3JzNkRGbitJVmYvdXBm?=
 =?utf-8?B?S3o5MDdLVWluTk1BUm44SnZ6aHc0L2JOZFFSV3NyOWY0RFJuakNCb1cvTFYy?=
 =?utf-8?B?Z3ljZU9oNU5vS2d2OFpubGxVK0NoZUJLOGhRMkxCUm9Vb3U3VzVkNDVNYW5B?=
 =?utf-8?B?WmFmYnpMdlBkelB5TTJuOTNYSTFnMStGejVCMkt4S2IvUEpjQW5aalhaMmcx?=
 =?utf-8?B?MUYrVVJPbmR5eUdHYnNiNUVhZVNBZkwwbzh1U21kd0daSUY0M054YlR6RGY5?=
 =?utf-8?B?NlZubTFTNERPN0dkU0J3aUhqN01ub21VcDNqa2pJWWZOSnJzSWpkTEpHMWRm?=
 =?utf-8?B?SnFHNEs1bXQ5Vjc2WUhMOVY4enV0MnpxT1QvRkwvVE94SVdNZzJOS05mZ04r?=
 =?utf-8?B?VERrbUppTnVBNFFQSGJpZzRvVzBoUERLWFM3STBQdTFKQVVwbFpuSE43eFhK?=
 =?utf-8?B?SzdnY3pMSWs0OVErM09FTkMvaWdjTUdZZno5ZE9OWnU5Q3o1Nkd5Wloyamsx?=
 =?utf-8?B?Tm9rcTFKQmh4MDhZeGpvUWtVSldmOXdrVCtXYXFvOFZTd1ZBQlNhSnBHZWJi?=
 =?utf-8?B?VWQvbm4yNUZlZ2p5dE5oZWtIbTBkQWdBZllBMkpEZGFlaitJQmUvU0lPOElK?=
 =?utf-8?B?cEV4bWM4ci9SQnVoRXZZT1B0OUFNd0g2dklvTDFWL2dWZzB3dHJoelUrb2xC?=
 =?utf-8?B?ZFZNdlRiU3VYZXVzMURrZzE5Ui83dkJBRUxuNkZQSzJsWUNyMjNkMmlvZXBV?=
 =?utf-8?B?V1dyZDRUWWV6eGtxVmkrZ2pnQVY2bGVFOE4va3hOTW4wK1l0QWtWVWNUdWov?=
 =?utf-8?B?c2c1NDQwUDIrN2ZWejdpZlF6cXQ3OUkwV0ZqY0RzK2d3ZzFFOThLTk12dXFm?=
 =?utf-8?B?dlRPNXdpTWdET1dXUDlWTzdpUi9PaGJ0T3pKdUJuNDNZYy84Qjl6VnNYRmVs?=
 =?utf-8?B?TnV1OC83dUJaclpjMkFBdTN6RVVTS2RxWVFsWjJOM0VuM1FkZFU4NDhkaW1N?=
 =?utf-8?B?Y3VJZjJSOVM3QzVkUS8ycUpuaWUremVmMlJVUlVQSVN3d3FocEx4ajhqZU5O?=
 =?utf-8?B?dWRwZXRFbjhmR2V5djF4SVNsV2VMdm5KcWducm45SFpCeTJLYWMxd05abVZB?=
 =?utf-8?B?YUlUdTlSZWt2aDJlakJUWVRPUEM4bVhqOER2a1JJNWVCazQwR1MzZGZaME03?=
 =?utf-8?B?ZVNPK1FCc3hCR01oNzVEaUZHb01TRVJjd2o1UEV4dXJPRDZxZEdNL3ZWamx6?=
 =?utf-8?B?OEhaY1MwT05TemZXV0ZtS2d5SnpsaThqSHZkN2VUeDY1K3VBTE0yY0IwTGho?=
 =?utf-8?B?YzlhOGRlVEJWM20zQnJwWjZuL0tIczRZUW9KRTYxTWkrckhoUXNUS3NkZFVW?=
 =?utf-8?B?MG5sS0U2N01ueVpLWkJvQVRUcHhUazJJVzBYa0NUMmdFR09XTFdBRGcrU0Qz?=
 =?utf-8?B?UzE1SWo1R0doRm1oYUhvUEYrZ2R5OGRZOUpDTmZLRk9PT0drRXA2b2ROYnNt?=
 =?utf-8?B?aXA3Rlo5Tkd6MFlCYU1xcWw0cDU0SmYzS0VJOUE4V1BZMm9mQU0xSXhXbXcz?=
 =?utf-8?B?Qlg1aU5Na1o4Z0pqbCtsSmM4Rm0vcUlNejJXM2h4TE9rRWhVNzl0QUZmQ2RG?=
 =?utf-8?B?M3RQMTcwOVYwcGZaS1ljeGY3WVBTUldLVTJ4V2QxaXlwS2o1ZDVHMHJKTW1O?=
 =?utf-8?B?NmFqMmFqRnI0RUpDMGZNb2lPbzFLdnJjczhRYWJnNml0bnU2ZzNlczBoamxF?=
 =?utf-8?B?U252NWhlV1RHOVJYZlp4ZlZGb1BOR2RWRHQrRkVlc0tyYWw5TTN2dUFxK2w4?=
 =?utf-8?B?WVMrVzhUaE4wSlQzcHNCclc3cmVUZExtVHA2ZGVid1psYURxSnpvVjUrSkt4?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb39dc62-8078-4d12-d0da-08dbc68c687b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 16:50:55.6004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5QVckAbz6eX8juzNd6XT4JvL/kFUVYGBlgbrQJQLkXSOy+Ab0EyeQATUths6hoJ9d89XUi4Ofgj7S0iJVOGiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3904

On 05.10.23 10:50, Florian Bezdeka wrote:
> Hi all,
> 
> Disclaimer: This series is completely untested. I have no infrastructure
> at hand to test modifications to .gitlab-ci.yml. The Xenomai
> hackerspace hosted on gitlab.com is unable to execute CI jobs
> (currently).
> 
> The series does two things:
>   - Move from Debian bullseye to Debian bookworm for all build jobs
>   - Add one more build job to still cover building against libc versions 
>     that do not provide y2038 support for 32 bit applications.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (2):
>       ci: Switch to Debian bookworm
>       ci: Add build test for older glibc where y2038 support is not available
> 
>  .gitlab-ci.yml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> ---
> base-commit: aaea684b95331336f0a04b9d15f8f24552e64d7d
> change-id: 20231005-flo-ci-to-bookworm-9d7672d6f642
> 
> Best regards,

Thanks, applied. Means, it's being tested now...

Jan

-- 
Siemens AG, Technology
Linux Expert Center

