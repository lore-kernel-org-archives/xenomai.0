Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF9116416
	for <xenomai@lists.linux.dev>; Thu, 19 Oct 2023 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WnshdZRv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZbleIIB9ZVtrJiAD3U4vxL/jGNZnfjm+ydw0aRodBv1/m6WPnhhQvCxasGys1KAfAooYWI8tATvJOpvwIwajjRBMR42QDPqXuz8kslFfDYg9oN3/h+SYdz9DQYUamrJqRid3XbnHnyo21oYBDnuWfzNp799or+fJCozvc7QKCOXaUpsZrb/qCDhUaGogFWWezihga7F/qlXOSlAgdqul+K9cvUFvdbQjYyw7EGTiURBjeAfcmhVzCXRXkEoZx2BTy9Si342AqaHFiCfL9X+4wiRH6I7Lnsdu9Rax1x27lDWocwdh4wVXdm4Thkxk7J3PbkPUcSnLh9OOmOOu1KvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tursquvcdxhDYVAUAa8v2ecYk8yUNaRyHfFbjE9EAgM=;
 b=T12KoOyhFey7SwdZTkSb6ySLiKd56N/pbfbgPAzjKtoljzJMOzxcQdhjaN3EtZqger0HXBcqeqVLS59T4sqnBSRabl/BZ4NxCrOpPmdaBkOZiyrSRToAwnv5mhdUJXhmwllTc+SwdyUR+T6AEAg+9Pr/9+yGTaWLWpYcqskmp562e40Q1e0WJljWfIg0WlFIobD7654WkLXdVnGa6Nq6ga6RFjnqEEpuLbNfgeG4hmmacFROsfKLffICwVcOXPTsipbkYwoPwm5KPJ44YyANF1+ukC9fMbmSW2RgOH3Jd8sc12QLWGhMuMFBCowFEOLUCTnYvlWB3B7OpuqLiFQdkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tursquvcdxhDYVAUAa8v2ecYk8yUNaRyHfFbjE9EAgM=;
 b=WnshdZRvaRbGOzGUC8XyllZBmo8eL5JfVYrD0k9Atpw/Pnm5QrFJuVdQiVoJWxtn5e9T1apABbl601rPX+HgwFERVoje8FKsh8xcdzVpxr8H46x3BenSQ/lW0jFuzhxo/0gGydWxkfdhyf3Pvb//m/ez5qVVPl6nVVAkE6dfeY537z60AnVhe/UNIsJbDeMKflbhZIenh9X4KUVApg8vf20oC7jb1R5cM+ktODGm76J1ASJHNO64+FaRfQMKY+DT1QpMeSjsbLNZOczXAw85bqp6t+/ypJPU90JWwb1aMgBd60io6Ap645+X122QcZkOjmf0GX99mUH9GVFhbIi8Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 09:04:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 09:04:04 +0000
Message-ID: <cf30fc77-0095-40bc-8fd9-a5c908dfb7ce@siemens.com>
Date: Thu, 19 Oct 2023 11:04:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Cobalt kernel parameters
Content-Language: en-US
To: Prasanna Kannan <prasanna.kannan@ipg-automotive.com>,
 xenomai@lists.linux.dev
References: <2047000542.27707045.1697689065162.JavaMail.zimbra@ipg-automotive.com>
 <917e42af-545c-4439-bac4-78d1f9548931@siemens.com>
 <617630177.28605403.1697705869664.JavaMail.zimbra@ipg-automotive.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <617630177.28605403.1697705869664.JavaMail.zimbra@ipg-automotive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e9bc72-ebfa-40c2-1e96-08dbd082583e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MgplG7/N5xoV/Q8wnO3ImV9xXGm4gZLVcPAdjSvpXv/sJ+EyUQPhBaYljCcKS9R4CWNRsX8ANLPeDOfDgS7kblxP3svSHP1cYcEFcTYsuRxVWJ6dz1VqnTCMdOmJ+uXAH189qlGlHaNhqeC+v1rVjQs5yqmb/WRrXpduTRINn8wPcNudnwCU4hqqoNhK/qiCAkhH+ex53dfIBNlNM8Add1jhqGP94nari3mWa1MjtglFcQsKUqzeR5ldPO1YOCzsPs2lm799pN+O3+Z3zzShVqZBUQGV8Z8t54LMs0KpwaL1iqsfTN2PjzI6S3LdAygHrMGMJ1/HRn5SLJiUn/EDzfoG5OLMoKAvmGuYK62dfmvDHFj3ix5BmAMknpojG7amCm6Skl/Egh4el9WVUCUGCUk64F+MuK4Vgk78oOYIIUpZAbI/Pi41FYzIFDXsFuO1I9hZSbASxr0/20Zms3koidRRTOy0LOoqIKsHq8pA0i1ePYeDZDT1MULwHGKoFQkbHH7J6/cci25PftNvb8Z3KAZejhYUQrqix4fuEn2OnR5xAVWdp16oB0clc6Tzi9xc8Zq8rBrAP6rYL1e2EJ2sQeam0EXSZWamFKSr6KyKEPQaUx0txoi+FEeRX/Ew7lyQPWUzlydDVCXlk9QqVbCeaw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(36756003)(6486002)(478600001)(316002)(2616005)(41300700001)(53546011)(6506007)(44832011)(66574015)(66556008)(26005)(66946007)(8676002)(6512007)(7116003)(8936002)(31696002)(86362001)(2906002)(5660300002)(38100700002)(82960400001)(3480700007)(83380400001)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2xzUzFYQW92QkVTaWlRRlpDOHBUTXB4dVJZbWhCcUNjL1QwZjRsOVhrT1dw?=
 =?utf-8?B?OVB6QnhaZElvQ0taaHJvKyt6emJtcjBncnFZOWI5N3NvcW5UTGdaVStjUHNY?=
 =?utf-8?B?KzJLS1Z6dnlxZnQzbk5jamxrNHpYdGRqSlBuRGllUldPeUJNdG5MVkhmY2ZZ?=
 =?utf-8?B?T29pY2JHTzFnaWdyTkxMa25KbkhJK3hyN0ZkQU1zcFRrSmVQZm44WWFxNDVw?=
 =?utf-8?B?RDVRbm5YV1dHaGJjVEIyRjRLbkQ0aTd5QXNWMkxpSzh4MituNE12S1JadnFF?=
 =?utf-8?B?SUZwbmRUeHJqR2ExQWtUcG5ycGVNMkZRL2paR25vdTlpMk9oQWNOMUJxalJy?=
 =?utf-8?B?UVlTV0NZUEROa3BTUndoaWYzWHBPSytFRlNWWE5aTEhOUEVVMzB3TklkVmRJ?=
 =?utf-8?B?enpDZjdKdkJSeHVvOXhZREpDR2JQZFVEeE5Bak5jbE8rRkJYWk9MT1ZSUHN0?=
 =?utf-8?B?cWJZWmZ0YnJBREdNU2o3TGpyY3laNkNJcW1nRzkrSk5hazZ0V21scno5SlZJ?=
 =?utf-8?B?b1VsWnlEQnBVcUM1cUI5NmpRalgwcXprRkNwd2hNTnkzNlBaNEVjZVQ5UWNF?=
 =?utf-8?B?QUxKVWFQemQ4WS9OV0IyTzYzb3NZTDhmNnF5N3pMOFRRUGorWUYyTkpFcTYx?=
 =?utf-8?B?OElUSHdpdXljYUZlMWoxbFN4RXlSQjlLU2U2VitBYlkyYjF3VWNVUHRVQ2hI?=
 =?utf-8?B?NmdzUTgrRDVpaWI4UlJvUDZFUjN2WnlpcHJrcExMekFpYkxiQThrNmRkUDVP?=
 =?utf-8?B?d3dUYW1kczJJOE5KelF0QWlJclU5VDVuY1FXR0NEcEc1TTJxTDV1aTVMdDcy?=
 =?utf-8?B?bk9jZjgxUCthV2lJOWpkSHdERUFkemZqSUxHK2lKdDZ4MUt6T1pvUjA3bDNn?=
 =?utf-8?B?RHhYbkxyeCs4UWtKYnhwZzZTL2NsZUxmOXRnMVhKdGZIa1JZeW5yQ2MwazFB?=
 =?utf-8?B?RVhxVFJJanl6S1pxZlF3K2Zyb0J2Z2NiTGVSMitPcVdmdS9HTjJPeXVwVkEv?=
 =?utf-8?B?a3Z1R05oZWdpVmhMbEMycXBDT3R2dHVSamdkME9OL092THFsYXg2aU5EaWpI?=
 =?utf-8?B?RXpXS2lta053MXN0anRmOVhaRGV3c1NUUE1YZklLN3pUbmtjVzBEbnExRklD?=
 =?utf-8?B?M1czTmMvWFhNRVlKMVF6Ukk1WFNTWGhrUXZtVWpPSlpKblcxT3lFS2xPdkNM?=
 =?utf-8?B?Y3JydE12Q0dla01HaGZWd2hLbzJXcFFpZnFRaUZjTVp0azhyNHdGTFF0cVh0?=
 =?utf-8?B?NkhDaXdkT3ovY1lpc3d4K3J6MTRyaWpXNmVZdEFzWUdGWk1EaGE2VTdyVm51?=
 =?utf-8?B?UFFsbzMyM1ZleUFSZmFQN1FOUXlFQUFOT3J4WGxkaERoNmo3azhPeEJhR2kw?=
 =?utf-8?B?SlAveWlvT0Fkd2ZXazNieTFyMktwQ3V3V01TMUlEWUxZVFVFQ3JxTVhELzV5?=
 =?utf-8?B?bEFYaTFmM3RkNVh5cmp2OXRzN2U3TFN0Tkk1bVl0ZFlCZy82OVF3eVplS3pB?=
 =?utf-8?B?SVEvbW9vMjlabXM2Nkw5VDJkNGNIRXRKYTd0NEVoMzFyYUY0ajJqcGNlT1Vh?=
 =?utf-8?B?Y0Q0eS9veFBmVk4zbXF6SFhlNkhhbktQRW1obFhPTkJYOVNGTlp6cVNaTTQ3?=
 =?utf-8?B?ZGdXZjJtb1BZK1lsT2c4eVBqSzVrN1pNRTB1YzR3YXBoR1A3d2cyTmFOQ1Ey?=
 =?utf-8?B?YXZDaW5Qa2R6eU0vcGthRVJvL0JGb2xhQlJnd1dNdFpPNWRlNGIzRkE5ZGxF?=
 =?utf-8?B?QzRxZXRWT2RhampsYmlUOUkzSXpldTRQUGhrSUxJM1ZrNTI2ZTk4V3RDVVBi?=
 =?utf-8?B?RncvV0ZHWkVOVXAyT2t1dXh3VURuaVhEVk43eVNCeVRHTGJHK1JvSTN6NjYy?=
 =?utf-8?B?ZlpZdFdiVldTVm5PVDZWNVZyRGd4Yjg5aTB4cnhXOTMxamlkVlQwV2lPcjkz?=
 =?utf-8?B?L3EwMnVxU2gvWWFSU1ZzeTJVSW8rR280T3d2TXphbzZCZlJkVXJSMEg0RWNP?=
 =?utf-8?B?bTBrUG9IVkVYZ1FJQmJGRnFTUlIvblhROVU2NGlTUDN5K2pPNk13UUJlaXRH?=
 =?utf-8?B?S0p1MnpucS9pcGY0elFCTFh5YmpjZi9wNmpybWFpeUc0VndpZ1NPdEl2d1la?=
 =?utf-8?B?cWsvVER0THp0d0RhNUg0NFpWVEhGK1d1WUo1OWdPNGFhbkhYYkJyTkNrcklB?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e9bc72-ebfa-40c2-1e96-08dbd082583e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 09:04:04.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IYZzAH6sf5rGihmKM9xh/uOlrbogOWnKSxNthOwi+MkPdP3pNGTJn1mzzTV8X3Pl410l9FHSbUu4cpSL57/Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6082

On 19.10.23 10:57, Prasanna Kannan wrote:
> Thanks for explanation. 
> Does Xenomai 3.2 sync with the Linux clock only on start or is there a possiblity to also force the sync during run-time?

Xenomai uses that clock source all the time, no need for sync'ing. Be
aware, though, that changes to CLOCK_REALTIME will now also affect
Xenomai tasks & timers.

Jan

> 
> Best Regards
> Prasanna
> ----- Ursprüngliche Mail -----
> Von: Jan Kiszka &lt;jan.kiszka@siemens.com&gt;
> An: Prasanna Kannan &lt;prasanna.kannan@ipg-automotive.com&gt;, xenomai@lists.linux.dev
> Gesendet: Thu, 19 Oct 2023 06:43:40 +0200 (CEST)
> Betreff: Re: Cobalt kernel parameters
> 
> On 19.10.23 06:17, Prasanna Kannan wrote:
> &gt; Hello,
> &gt; 
> &gt; I’m currently using Xenomai 3.2.2, and here passing the kernel parameter “xenomai.clockfreq” doesn’t seem to have any effect.
> &gt; In Xenomai 3.1 I was able to successfully use this parameters. Is this parameter still valid with Xenomai 3.2.2, 
> &gt; if not are there any suitable alternatives?
> &gt; In the past I also used to check the clockfreq registered by Xenomai using /sys/module/xenomai/parameters/clockfreq. 
> &gt; Somehow this is also missing in 3.2.2. I am thankful for any pointers here.
> &gt; 
> 
> This parameter was obsoleted by the switch to dovetail kernel patches:
> Xenomai is now using Linux and its vdso as clock source. This also means
> there is no longer a need to calibrate some hardware clock itself in
> Xenomai, therefore also no clockfreq parameter anymore.
> 
> Jan
> 

-- 
Siemens AG, Technology
Linux Expert Center

