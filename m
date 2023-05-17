Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2052.outbound.protection.outlook.com [40.107.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F09C156CA
	for <xenomai@lists.linux.dev>; Wed, 17 May 2023 09:35:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5fvznXqmN2OY4KsOadQ15ACHJ8RjV3hE4ZXMdhRRdWYKrK/eiHyrLiyTLgmsNWOJClg4LVYjYONhiQR5AN7Jp6hY5EU7qJLeKB2q0BpKPCnbAIaKFYjShXX+N/gZJm7EE9wzYN7N6KfBiBzSiRSb/pHMAYuAUm2ly5wI1XDeNzOHJy3PueY0/KaLguTzoF6vgHpIwl70XHNjHnSMP0tg1Cth1FLIiLlbOIDBwDQs52J+WzNjxHdZX0BhR+n4lSUNOT4kn1J1yDMq9Lg57kfQ7QR+aUO5WGiTsECPpuX3MTjefx6NSXlQnlvA30bZyikfIbH8lfQrUuJCDO0hm2sjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prKESvHTy/LIzPx0cxjyoKS1W3nl/fOzRmjF+t4J4Js=;
 b=OXFp7VQTXXqSdfLGLDFEuzsNihm1n3RoicX5T5VTMH4zBvUDusPE7VrLpfPY3/zulXXoZ1XOAnnRAwgPr26T4JH5SeM/myQZhGefAO0MMI2mw6uKUwEN+tw3NDp3Kh+qSOLwcf+8xTiKImiUDFVvTfX4a4fFpmbD9mPeKHsUDizNNcRGYlif/TtK2rSJPUqzA/DuELzyBT4XQBnbTN6YS6A2jNJt1AUrvV6eTUDX4OeRwwKnGyUGJrtgHuCYd4MI5IR4utIhcZlHUC5PyV2seGpU35DW/q/qrD9MEkmloZZPk0+H6dk7Gd4lzXFo/uBhtB7wiNvMteZODmdE5fPbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prKESvHTy/LIzPx0cxjyoKS1W3nl/fOzRmjF+t4J4Js=;
 b=Dstezq5UDwvUUHt3tupdMkzFI4vpIPNQTkJYkeAaERLlMtjX9EvoZygCWU2Y9vequYXCqy+G4O/8bTetmll1OdKyyL8M/hhurBy6ndiab32k8O4LUIkq56oCcBIczzn7nWAmrnYMo2UaAzjw1cR3z8LUKHIbRiOlhWUO1qNMVH0r2agag+/9Z+9dZljqUWef+vCCk4Bnfpf597tsXu9Hs0fSGrM0WXEKDzCsOGjEhjwWf1X345eHckltDEY/GMQX1Wti+1Ln5DDNaPRnV1lqI3HzNgX6erp7hipVygCWbxN15Y3hikqdpupri2qJBL9uFnzfMYNXfQGlCjNEhOFhUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5726.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:313::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 09:35:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 09:35:24 +0000
Message-ID: <fb32757d-4cbe-246c-fc33-f702dec535e5@siemens.com>
Date: Wed, 17 May 2023 11:35:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 0/11] Revive alchemy, pSOS and VxWorks tests
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev,
 richard@nod.at
References: <20220413215819.22954-1-richard@nod.at>
 <20230406103341.2914-1-aaron@sigma-star.at>
 <8ee4086e-580d-3d15-cade-4d983c86e402@siemens.com>
 <20230517073014.ygkkfjuxd3lzksr6@mail>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230517073014.ygkkfjuxd3lzksr6@mail>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::35) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4fb079-b6c8-4c09-3880-08db56ba0a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SfeIvq6VoFcymUwoqGs7P7jVClOT8dSMhyD8oU7ScRTMeHe4gaPUEdfRoYsoR2KSGvmwVV6PqkDVEj4cxnntqlJLDCrQ1B8RI7pGflZ+ajFbFsO0HVKsFDP6BHXfc29lOkuHvYzlORFBey4pfxLKDLt1as0ID2BD9XsWZkjaEORG0QWmqanOVcmZmLU33xzlZttrD/rwhHdqXz3sMVCtusYhWTlqL9tykU6VPg1eRz0Oo6OYCnrIKkQS8LIP2WwA1Ru1ZXPpszKpN93jp8JgTWsw5FgmRqlTyX+aY/XsUppX6seg9ORvnRWLxT6Jtyy/CQTy7Y6sP1aIvZxRww47mWb22tnfyYtB7EV4bFQG9GeU7YTOi1RGJpGkl+maWZJXVPW/IU0b2q/qA+VqSSqh6LtIGUY9cBHMMt0embvxKOsD+rKG606sPNJEIQnljIMz4laQN4AoUHmSTfKPDb8L55UaR1+rm32woVaYAexNOMvx5tjE6XXASdDtCBxTlnHJWbRMnCEzbPJg6lUvJ+wfZNjjteTqCxd6O3uV/mz9NjqXKIESQ1l8VPNEUS1a9XVBgAfTCzsV42tiilOneBY3R/B0GQnwgYYu4t1abnd+tptkeLdTUETCAiWXOoKCeQiV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(41300700001)(6486002)(6666004)(31696002)(2616005)(86362001)(83380400001)(6506007)(53546011)(26005)(44832011)(36756003)(186003)(4744005)(2906002)(82960400001)(6512007)(38100700002)(966005)(5660300002)(8676002)(8936002)(66946007)(66556008)(66476007)(316002)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTEvdEMrZzlJdC9DZHArZC8wbjRDT0FCRkwyTE1KUUNvRzZ2RFd5SGxNRFF3?=
 =?utf-8?B?S080ZXVOUUZHbFh6TnRFeEt0QWZ4VERRdUNvNnd3RCs2d2Q0VThlYmI0Um9U?=
 =?utf-8?B?b3g1NFY4YitUQUJZWExNQm5Nd3N6aFFTRDcwZXB5cHV5WU1nWm1FRlA1UFcx?=
 =?utf-8?B?RUVReEpOMnViWCtCZlJPQ1dxUVhWQkZBVEZGRTR6dFBRSXdyMnBLREljRjF0?=
 =?utf-8?B?MzNpUTNTMEQyQTQ4b2pvU0E3RFZSLy9qUENlL1pWcDZTMFdTM0wvTm5VU1Vz?=
 =?utf-8?B?MDdMY3NEQzRqc2NQUkZqK1NTdWROQTdSRE9mcEJNUzdNamliVWpxN2xLd1ZQ?=
 =?utf-8?B?aUg0dW1jY1dSemcrR0w0UnFWWU8zaFl6RDlmWWxCUllKdExYTUhsVlhRMGNU?=
 =?utf-8?B?ZmZLRjUyZEVVcnpDeTBEN051SUpZOXdsRXpBdmM0ZzJUZ2g0TnRkc0F5bkdK?=
 =?utf-8?B?RisvNE1MalNxamFjY2hQVGI4c0RpY2l4ZzVHWEk0VmR5dG5FZnVVeGNZekhI?=
 =?utf-8?B?dGlCOUluY1ZUWUhERXl4YWxvNlpOa0xEMGgvSmtrNVd2TEJoL3MrOWFzSWlR?=
 =?utf-8?B?c0hSalZ4djIyOHNOb1NyMm1ZZ1RHdTFwWnJUNTNDZUEvY1FLeHlRVXBDcXUx?=
 =?utf-8?B?K3EydUcrU05kRmVUc1FBRlZjWjZTMk5xbE0zL3lTNjRoODRNV2dzU0FGK2Zj?=
 =?utf-8?B?akNzSEYwekFsQStWcSt3cld0aFp1Y1VEeGRMa2tvckwrSXpBMDlOV1pKejhR?=
 =?utf-8?B?QjcxT3RRYnBVSzBGaWdJKzdwQ2doRzVNcEl5NzRVbnVuMjMwZ1JXdGJyakhC?=
 =?utf-8?B?MUZxMmhlL1lEKytndG9HT041dFJmZXZNQ1VtWTNQT3pIc3MxUmlSOHMxSzNy?=
 =?utf-8?B?c0NmRjVaVmRZYUEwdFQwMkI4dTl1RzRBcXlBN2x4OGxJMVFXbUNPMEplTk94?=
 =?utf-8?B?TVp0RTliMHJyNGJvTTN1OG1WWWtpOVhUMkd0R0owTHZwRTU3U213Tmx6NWhz?=
 =?utf-8?B?MXowaW54VW5nR1V4SGpCRW9XV3RVYjAzY0wvZDV4UkhlL1JnaGhON3pGZ3RM?=
 =?utf-8?B?R1pzODUvL3ZQRVROcVc3ODcwNDQ4TnVNT3lvcTM5WVJ2Ykpqai9DSk5DVFR5?=
 =?utf-8?B?VG5vNDRGWkJ1YTVwTlRxSHgvMXQvbkdUN21Na2tPVi9OMFErUVVPbGRMdHRR?=
 =?utf-8?B?bFBMVHBBZk9IZHdMTkhFTmxMY2NCeTVGTTJXSHFWQUttTm00c1FVbzBDaXho?=
 =?utf-8?B?Q1RDeXBFOG1mblYzRGp6Yk1wd2pUZXZMWkhVcUg1a1hrSVhlTzZSRUo5SHVj?=
 =?utf-8?B?T01VV2xiM2JxbDlKVUc0enNsbllNSjJKRUdzemVrN1R1SHZMN1lDWWVJSXFw?=
 =?utf-8?B?VFprS3BGYlZUOS9CTHF0S3o0WVB3UHVLc2FYcnYyVk1tWFhPOWIwRU1jenNZ?=
 =?utf-8?B?TEVYQ0J2WmVZQjhjeUhTZUJXZElRbnhzNmlZVUZaU2l4Yk96RVBiTnVjR2ZE?=
 =?utf-8?B?MENjemZLNSt6WFh6dnhNMXI4MTMvdG43VUV5YmZzZ1I4bW5Xb2xxcU9HTWdS?=
 =?utf-8?B?VU1RQzFFSUpVRUxXNXFXdjFOZzdVM2hGRkxvVU80RXlzQm5PdzFiS1AyOE1K?=
 =?utf-8?B?U1RPblQ5bDJCWXdEUHdCNzdmblJZYy9pL2VCQ3BOZG0yZEU4UnlCK3liUXhh?=
 =?utf-8?B?bTFrQU51VDlySlNaMXhMQ1ZJTzczck5QWDVZeStSbzRDTVlqei9jcC9xM2N0?=
 =?utf-8?B?K29PZVIrYXIzTHZQeXZIdzNKaDY3bzBtcmFqYlRWcnMya09DcW1LNW90bTBO?=
 =?utf-8?B?T3F5VjBhdEl2dm9HN2d1NmpWb2gvZVQ4Q3NwK0ZPVFNqSGdUSUsvRlkzNE4w?=
 =?utf-8?B?MnMrTmExd1JxU1NEUnVKRmJaYnphVjdvcDZ5V0IzeE10ckVsSm1wU3BYYWlE?=
 =?utf-8?B?RTM1UDZiQStlc05kYW90Zm1KUGVZTXd2dncrS2dVVlpkMzAwVTNrazBJc2J6?=
 =?utf-8?B?UDFlNHZVTGQxVWliRExpM1RVOHlwOXEwM3RveHdnd2pWTlhhc01OWXl5NzdN?=
 =?utf-8?B?amlZUEVva3VLWVRTZWFQQW10cEpwVjM5end5K1pGcGxnTVdwdzhZQlVkTkZh?=
 =?utf-8?B?aWdNZnlsRzZ3TlU3ck15T1FwOXFEdnBJWlhKQmJrczFnMGluaVQzK2I1eGU5?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4fb079-b6c8-4c09-3880-08db56ba0a7e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 09:35:24.5636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWulVskq80EBzR/i1H0gymn7rLYEOUQsB0A18NpqvYvgNtN2WHBoZp2D/nYqSLp/CVK6V6b3SfZUkCCwTNxNYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5726

On 17.05.23 09:30, Aaron Marcher wrote:
> Hi Jan,
> 
> I tried integrating the tests into the smokey framework like other ones
> in the repository. However, the linked tests never show up when listing
> using `smokey -l`.
> 
> I made sure to place them in the `testsuite/smokey` directory, correctly
> link them into the testsuite like the other tests and call
> `smokey_test_plugin()` along with a run function spawning the tests.
> 
> Do you have any hints for me what to watch out for when integrating the
> tests so that they correctly show up?
> 

Hard to say without seeing the changes. When looking for past patterns,
check e.g.
https://source.denx.de/Xenomai/xenomai/-/commit/78e4d58be37f8a498a03993f74251af57f11c1b7

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

