Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F247E
	for <xenomai@lists.linux.dev>; Thu,  4 May 2023 14:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bp/SCse7rlpXYbRMAujvENZ/I3LXiDCqN0qrxx0H5TnUTLlmjEmCQzAK4RPIWppg9YuHZXVPl1sVp9ET77ekeydPANeHCej0Lmdhw7lZ+veAseJcL1Skc+xaVzoYsga3gmCtnCAi1TB3ZNfHwCPFNls5zp9HwFiDOHfP11sasQPY+BQYs9G/tMi9Iiokf95CTl2GxEfax+av2Lj7dcHLeMgD+kgEgVokBx+recF5i7SiVdJGX/VxgfC3LHt3pSZhRWFOjYCIk7YH9C7xFWWphwD5tH0J7dbd14+izKhsly+e5/yvbTp9iBSO+WsYpG1ciUe4Q2bv5eRyD+eox4dU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/X1NDTaYPCi2FgGKkTDf1/VjHpRqqBT+3SDnoKPsBJw=;
 b=Uts3SLRWjySWOcPDARelh04r9TnxgUgeq93STRKDKWvejHbUt309nQxayTNntpL89G9rTedYSlBrRVZHnLvQkc0vsOM3kZDfRIuwAYoxOIOraXJ7B3ukOlaMghj+JTO+CZEQwP3010YP/84T0atTlWVKVp8t86P2KNlMfyKkRSGnF57Ex9vbMKjJIqbBMg7r+LsKccYtGeLzwUFBO47/cg/cQfIIQwOw8AZUOWZdept6+eNNzIuEJwfWft39fmCNk9Tf088k0YKZ16pX+s7XUIc6UuGLNp1Fm0EKKQhemW+1tntBbnkrL1Sxxp24uuCxhGQLijtaeEXL5qTtDnS2+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/X1NDTaYPCi2FgGKkTDf1/VjHpRqqBT+3SDnoKPsBJw=;
 b=X11Ty1gxs64Z/3WeSvKOqM+ZoSTemsoH/KQnYldFnyIZJE/iU+s1hvyWNBOOdwlgsqAUS3lq/lZ8qTk+X4VIjIdkhMa3fvIdIAcnAa9XFBLEwXHK7xSuT8OmDw9zFoAwUXhjwrw6K/lc7t83G0yb1J4DEqMvyaTrbA+kn5xDRCwrsGfTwB5KIaF3+bI28lDBfVLymg29FRhLZ7JIozaPrefI0HJmLgTeBVXdvfixdbYhsRXtwF09+QCMW82zibP84RQtSA01hFs5cfpcC7lVncsxxuwtzGLSGTmp3/03Jj5cDkNRxGpCspalkGUEqBXX4aVI8W+FyQN6KqYHTgYhkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6219.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:91::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 14:17:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.036; Thu, 4 May 2023
 14:17:47 +0000
Message-ID: <9a48d273-5ebd-f557-7941-8532b7ec4b67@siemens.com>
Date: Thu, 4 May 2023 16:17:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Question about a freeze under Xenomai 3.2.1
Content-Language: en-US
To: Julien Aube <julien.aube@smile.fr>, xenomai@lists.linux.dev,
 Philippe Gerum <rpm@xenomai.org>
References: <5a8afa1e-d6d7-df9f-2895-6832ffa9673f@smile.fr>
 <189dee91-923f-131a-ccae-0afcccd06107@siemens.com>
 <7dfbe0c0-161f-0977-4332-75575f1a17ce@smile.fr>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <7dfbe0c0-161f-0977-4332-75575f1a17ce@smile.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 449db77a-2632-4c7e-7748-08db4caa5636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DXE2nJefGllkI4DDtoejnQs9ud4Z/7CXaC63F1RrOgpLD/HMCdEEnKH4gG/Bn/oLTSQaZ0MCxQglXSn9Wkqx2PF4rNmXWPdOQ1//A004F8HsxuaF18aVFHiXcJGcE97+yKpA3Y6MCw8dvAb4+m5QaUYV3uqJUPnEoZp11iCZ/qY+TNjpIH+jdSW4oFlIYKWUUPAfXRJNHPjU9+qcd0Sp2gLvcWm/RLmRXkM4mxYvUBWEudSl/Dd7tDJMzQah8kO5Tp1Pe8XzQPisQw9SS0efkQbnZ10Od0kuM6YvADKUowkyC+YG5TdyDUjC7/Md0eCbDOvZR/5p5GyR6QzwoxpUDN4oIcCsqrBFEFJzc7HjbZDjUmIE/RXBqb95xKfloSSxTe729Ix8rxj/rvz/Ph7KpQ3BGE0mIjJoA9I0dieiXBF+syXB1rMCN9+80utCSAE7poDnR9f084wtZhwqQbPXSVc46nzFWXFbk7KRQSGFHixYdmuCu/4BVtXTgofgsUDtVJPplOrdUk8I7Q+gJKR9rPgKPPj5C8Xhyoci0PFUyrdrlZSF9sTkFM0H1SZJZb4vHEugfbPLy1cU4btGeVuj7iTFA1wV/gS2b2jxlyaihxOkAPDp3VhNxdwB2+ag4ZHNy+s9rig0zGS+DkRxZ9+VJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(2906002)(38100700002)(66574015)(82960400001)(26005)(186003)(83380400001)(2616005)(6512007)(6506007)(53546011)(36756003)(8676002)(8936002)(44832011)(6486002)(110136005)(31696002)(6666004)(86362001)(316002)(41300700001)(66476007)(478600001)(5660300002)(66946007)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Um1NRWpSRWFjck4zaHJPcVNJUGpEMmloZFEza20vRTRYZFk0YVN2bDdzbE5V?=
 =?utf-8?B?WjRPcXhtamNBY3pJeDZOT3BLcFpYYldSUU1PT0I0NmV1ZGxLb0dobzdVYkdF?=
 =?utf-8?B?WEIxcjhpNEFPWllhSUdHR1VCKy9UcVlFU2VFeTBlTStKVG9ZSnlXb1kwbTJL?=
 =?utf-8?B?aS9CTytvVHhQaEV0T0E5ZkJYMDZvRExWcjN2Vk9TaE0xZDVibGhLbHNReGc1?=
 =?utf-8?B?ZmRzeU5zK1RIU0srUnZkK0JyVmtUMUpNOGQwTHVwRDE5aVZjL1pjM2hUY2ll?=
 =?utf-8?B?NmRMWGthR0FpcWFGb2RzaVVRMVpScElpSGJuV0srT20zRFFtN1FSeTVsNFJU?=
 =?utf-8?B?TVAvSUdWU3VNMFEwZDdYOFVhSXJPUkxxY1Q1YUJ4alFTM2k5Tk1Qem9GS0Yy?=
 =?utf-8?B?eGloMEVkQjJ6aStRUVJ0M0k1YVZDYW96dnRwY1g5b0RZM1ZMc1psVzVyM0g4?=
 =?utf-8?B?SDk2VWRtZ0hHcWdnMXlLUGlhOWY5SUNod0RUOXJMajZkUmZ3UXBGSTRQaHo0?=
 =?utf-8?B?K3M2c2haUlpSVGN0ZWwxYWhOTWJzVmF2YzJsazZvTDQxTkhpMG5FZ05nUFlH?=
 =?utf-8?B?ZHlRZzcvRmVIMGovUm9jNlFpeHRoMHkxb2p4R3ZiOWlDQko4dHYwYWxyUmFz?=
 =?utf-8?B?NTkzQnZxcTZjTmdQMTdvTzJsSTJDY2N3RDJFMnRHeXRKVW91RFVoN3lJODgx?=
 =?utf-8?B?Y3pSZXNCS2VNelpOR3RXZlF1NlQwQTZLUkJLbWVlaklPSjNkbUk4MCtkWGhy?=
 =?utf-8?B?Y0l5eVQxVVZPelovaDY5b1JoT1VhVnpDb1dZWHltVUo3c043RHNvdmFuTXF1?=
 =?utf-8?B?c2E1NXUxdUltaGRqUWlQSFQycFpnSTlUUCtKOU5zMHg4M1FraGl5OFJSc2hl?=
 =?utf-8?B?RGlBRGJOVEdYS1hYcXBrUTN1T3ArbTVzZ09GN0RKNkZYRytNc3RqZ05Fc2ZK?=
 =?utf-8?B?YjNadlJyWHEzWURrTDBJYkx0QnpiVWkra0hGMmlja2pSOERlQi8xRVlsRVNz?=
 =?utf-8?B?Ky9RSWNFR2ZpT01KRDVMV0NFU3gvZXY2aHBDWjA3UnZyNXZSR0d4ZURCRklQ?=
 =?utf-8?B?ai9TWnlrRi9LUGNXMlQxUlhualljQkxwaXVqMWJ2SGhNTXJ2cVAwRlNnT0ZD?=
 =?utf-8?B?b2hyVFc2cDVOQWdoV09rSTNFWHdiY2pYWXZFT0JCRmFodi9MNjFYSmlnb0Fo?=
 =?utf-8?B?TWJOcVEvbHhqdmRKSEdrcHh3MU5xZSt6NzZkOW5INitKK2U4UjJ1WDd6QW4r?=
 =?utf-8?B?cHM5QmdGZE5GR2VRbVRYQm0vV08vckR3ZVRkOUlKdXk1djl1by9QaHVOWC9q?=
 =?utf-8?B?MmtxU2VZaGFaV21pbW1SS1NSS1pYdklBM3kwaW5xRFJWWnAzakpVcW1Rc25W?=
 =?utf-8?B?YXFkWkV1T3ZBQkpTVlJMb3ExSE90elUzc0V2cEtxMmtib3FuUDRHdnNlNWNv?=
 =?utf-8?B?bW5LSUlwRnViSStZLzV4OFRGMm1yL005VGIrQ3R2NWtIOHhuS1dBdDd6WElL?=
 =?utf-8?B?RFk4VTJyaTRyNExsNEtndndHSUJOK0E2N3Z5dTVBdW9raWVGVWhnMWd1bVE2?=
 =?utf-8?B?RkF2VXZ2Y3R3ZEhld1NSTkQyeWY2ZG8rZVdtUERveWZNUURIUjZnWC9RRjFC?=
 =?utf-8?B?cGRWdzJuSy9wVXpkKzNRM3U5K2g3T0dSSjdFbGExSmN2OWR2ayt5eE5ZdWNL?=
 =?utf-8?B?VEpOS244UWZTMTREQk5FSXBNSXN4UHJ1MmpHR1lJVFplMlZrV0NVcy9xNmhG?=
 =?utf-8?B?R3g0OExPRTJlRUVyaHJBSWVXOFM4Nnp3NFBETnVRV3Rhc3Z4c0hDUWtRRXN6?=
 =?utf-8?B?UEdsQkFoamNEKzljSm9sUTJvOS9GOC9HS1g1TGY3YXRqcXA2d05aQlpGd0ZN?=
 =?utf-8?B?VHVqeFd4eHI5SmJxK0hycVRpNFhheGxMQlRudFU4S0REeDBlcTlyUE5xMDZE?=
 =?utf-8?B?ajB0dkcwM0RXc3NzTjExcFRTVHppUUpVdlA4MWF0WGZDZmNodXlXMWV4SzJK?=
 =?utf-8?B?R2o3RDlDVWtEMDFuMHppeWJqTFJudXdTalplcDJGQnRaZ1hXNVdHMStZVFJH?=
 =?utf-8?B?ekpHbFgzSEwrUVlGYjNHblRjL0w2SThwNytvcHdBUlE5RnoybDdmRnVQbjRV?=
 =?utf-8?Q?tQwCfIwWI5qsclTULHBfhxaxW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449db77a-2632-4c7e-7748-08db4caa5636
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:17:47.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7UVzGMc1nzAouRC0jYn0bYTZu0swyyhObM3qFuULreYI5f4kxyVWikl+wNRL/Q1ZtigsP9+O4x+WYKLlPX6Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6219

On 04.05.23 15:33, Julien Aube wrote:
> Hello,
> 
> Le 03/05/2023 à 16:57, Jan Kiszka a écrit :
>> Well, 3.2.3 would also work with 5.15.y.
> 
> 
> Thanks. Following this comment I tried the kernel
> 5.15.109-dovetail1-rebased on all the following tests.
> I just had to update a few unrelated things like the DTS.
> 
> The behaviour with 5.15 is exactly the same.
> 
> 
>> First of all, can you reproduce the issue when disabling Xenomai? And
>> when also disabling dovetail? And when using the corresponding LTS
>> kernel as is?
> 
> 
> Here is what I have tested:
> 
> * LTS kernel (5.10.177 & 5.15.109) : works
> * Dovetail kernel (5.10.177-dovetail1 & 5.15.109-dovetail1-rebase)  /
> xenomai 3.2.1
>     * with CONFIG_DOVETAIL=n + CONFIG_SMP=y : works
>     * with CONFIG_DOVETAIL=y + CONFIG_XENOMAI=n + CONFIG_SMP=y : works
>     * with CONFIG_DOVETAIL=y + CONFIG_XENOMAI=y + CONFIG_SMP=n : works
>     * with CONFIG_DOVETAIL=y + CONFIG_XENOMAI=y + CONFIG_SMP=y : fails
> 
> As an additional test, I tried with CONFIG_SMP=y but nr_cpus=1 on the
> cmdline.
> In this configuration the failure still happens.
> 
> 
> => For me there is a problem specific to the SMP behaviour, since the
> tests are working fine in the non SMP case.
> It might be that I do not understand the full extend of the SMP vs
> xenomai setting though.
> 
> As a sidenote I've added all I the debug flags I could think of.
> Unfortunaly I can't use KDB since my serial console (usb-based on
> motherboard) does not translate a break correctly and I cannot fall into
> kdb.
> 

Is there any own driver involved, or can you reproduce the issue without
it as well?

I'm furthermore no longer sure if the Zynq 7030 is officially / fully
supported by dovetail. Maybe Philippe can comment on that.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

