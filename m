Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2084.outbound.protection.outlook.com [40.107.247.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D3315A2
	for <xenomai@lists.linux.dev>; Sun, 30 Apr 2023 09:22:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RihmMaa03XA1H8PngiWd4i9mQV3A70rGfH9yNWBHJZC4M+hcDnZJ9oa9ST/wGtMjKg+o28XA+fs7sxuJ0icXzK7Jv7sGelknQPB4ZnXU5sVbAypWPEog0uQmhGu5DBh4T6XGDJau2jC+r9qo7BdwjDYHmQd9eXlhgy9hzBIYhu+9L/A0Ser2Tedc3OjKL+a57lSUXElb4ylz8V9IDqxrAZzrD6Q+bcLLdJ8tUuBgS62+HpVvSb76tcCxAQl9Q0APgU9n+VYiFrGOkakOHgdEO5XXm2UuGGgrb8styMGA8cn2LbHbZMFUltgBP1dwihu/athQS1GCzVRi27rGP3trwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/yijuGLg7n+r3Khih/Y0TnpjQt+/UFpp38BFEjXb9M=;
 b=YyVPcW8MgcCBcQEGHmyH3490zCFHPJDTkprFUtlPEvBidk4fv57eVVdJ83RBJIOnmvhifBL4YoRk0//mBeXQscfpAwRQsByG/xB8MbIIiMQpVf32yRRChpnsaXV/Gu/ttdiEq0zrxEVwxqTUXHBIaHQVM0ookbJAeGqzIvLKB2HLsSe0QlZIfroHc+sWxvXV+6hWeQ6Clu15ZSR7TXLszN4iwO1GkxK5icRQ9C22T8FjoFlETepiRWJAFWenZdBg0JhcxJZFA1TAl+XnyFoSTjgfvspVdCsISz7hxdDyI+l/KK5FTVX2j5R0/bIvCjXnWH0NbU+Qn+8TuYqOlwsOow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/yijuGLg7n+r3Khih/Y0TnpjQt+/UFpp38BFEjXb9M=;
 b=aYU70PI1vWmD66nsTC+KDRUU2Dlm2kYuTi8L7YvjM4VWZtqaS4DNSrps7nR8GScB9n1hjcVYW3uIdAKviNBf+xQPq5hbWTrVWt7ibTlvvxlkrNfQjgQvOZnPR6cPVLi6FpYlwneHgIdPMPTOKSsfX+x6zlb0dzWlisLTeJicG1mDsOS5duFJaSbCCbEZ93agFmbqoAzBVNAnchvZ5m9tE1TkjZzfrVkMRToTnn4BRIeBVVlpqAFMVhsbd7/MDQ0iLXPEjipvcqsFQQVVefNevLCYjbJBLqf6Zue39ygosZS7kbCHbnkH49OrqTV0re3qAO0hi2ElfmjwbAebwEj06Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5603.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.28; Sun, 30 Apr
 2023 09:22:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.025; Sun, 30 Apr 2023
 09:22:13 +0000
Message-ID: <309787e1-da5d-20b8-c6e1-255ef962edb2@siemens.com>
Date: Sun, 30 Apr 2023 11:22:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/2] debian: Move testsuite (smokey) into a separate
 package
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230426-florian-debianization-extract-testsuite-v1-0-0a957cde7b74@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230426-florian-debianization-extract-testsuite-v1-0-0a957cde7b74@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0067.eurprd03.prod.outlook.com (2603:10a6:208::44)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 16746944-ce8a-4ad3-fce9-08db495c620c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zxVbp1oomFYQjxsnaQrbce2aALQ+c9RxfUokdhBkfXdTUrlDvMyEk57dgz4ywdYl/vMV5343qMj2tn2OUrCrdkiAbPvC95MQ2si6emy5wGPoWjP9a7Jl5NWB62mRbjId9assZL2zXaSwrVS5dmrqmWir633mPXHzjYdBjNfjpZ9XgaZqCz8XvMKW6/4KNCc0Mwuptu7kN0D4rk7lV78sbBt06ZYfFb1G9vxkA061S0wzLTtHeug6sEV+5SrFIpRkvhkXEo2iUEDTp/zBW8FMkd9JU52epLhqiqO3Px3QPb/VRebfaL+qpNH/yEgTO6q3RkNjkAtfic5NsamLNTFxEGQD9a28Dbq29voSc1C+xmHIAbN9IlGzco7V6YX3EKtW1IzRFDf0T8GgEOoocs2IoGIRhRo1UfXcYja13FyJ7yOzDtrGVyynWuxt6fPsf/tUCELRbQSZop1jJGh2SB+MXs0W9Ty8NKkUmMAaaCYlUYzNDUqAb29Eo+EIk4WsiBKxvVFx2qacKGb0op6GOYKZWGtyvbmh+M5KiQHGYNop3QTH+JxkNhAvYtoBHA/TNvx9SuogerCrPvPt//9jWoq+DQuBk7jOFegTpIIB9u2Vf0P7kyhPSarnMT9c0rfz6w/qgXumnKCfL2bT5BD6RZ7E2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(2906002)(478600001)(186003)(2616005)(36756003)(44832011)(6666004)(6486002)(41300700001)(316002)(82960400001)(6506007)(6512007)(53546011)(38100700002)(26005)(31686004)(83380400001)(66556008)(66946007)(66476007)(31696002)(5660300002)(86362001)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXhmNmxMTGxJbzVXTm1HdUtqeVd1ZnFQNmR2U2RpeTBQSENMODAxNnAydTVC?=
 =?utf-8?B?N0F6NW8waXhMQ3FFVERpMzBMMGJ4ZDBVaUtoRkVIUjFtbWl2ME1zT1ZpNUpE?=
 =?utf-8?B?dnhuQ2F4L2FOWXpvZmZ3TUVRNDlocjRjajVpdDFVNEpIb0o4VDZCWHVWRm83?=
 =?utf-8?B?OWRjS3k3Z3VFbkgvREJTK1dSUDQyaE9teWZBcmJ0NWR4dGQ1U0x0KzZvQjdr?=
 =?utf-8?B?RVpiNkJKdDZUUWpoME8yV3N2eHpCNThhQnBEenhiaVZNMFA4Z0dVRERqNDJr?=
 =?utf-8?B?dE9xSmFLMFVZZjZBZVdmbXlFTGR6NW1KMXhQSVBzQzkwbzRJVlVPa3FHd21u?=
 =?utf-8?B?dFFxSnBtbEtuaGEwbmZ1K2VpKzN5Q3ZvSzBnejBvd2dVem9BWlFIMHU4VkRu?=
 =?utf-8?B?Y2xSWUpkZ244ZXdDdlFOK1UwczZQd2xJUURSbWlLdzNrOU93Mlllc1Y1NDg5?=
 =?utf-8?B?WEtOanNObW51a1FtTklFWWQ5UFhnNmdvRlhnMUdiZ0RjZXdLbWlVMmE1Y3ZX?=
 =?utf-8?B?VkxTeFZ4N1puTXdGaHRzQU9TN3RwOU5JN2RYWW1IR0crRDViWDdrMzVaN2c0?=
 =?utf-8?B?cHJudkgrc3V3SllQRWNNMGdRbTU0N0hIK3lscVRmYkNKbFVudVJPZk5TNmZp?=
 =?utf-8?B?UjlEcXRKQ3JEL2Ivdk1CWnhUTTdXZXFZYVBEZ25Bb0tpMENqUHlrVllmT1dr?=
 =?utf-8?B?bm1Yd1F2S09jTVczZU9IWElBbTNrZlFlanNOdU81ajNZVHhWeUVmM0tPVkdR?=
 =?utf-8?B?Z3VtcW5nWndBMUVwQkwxVW0zTWRHTG5KYndicUxHYmxqRXY0OTQ2OXI0VUhR?=
 =?utf-8?B?VUEvRDN6czlYUU5ZVkE2SE8ydTZ0emM0bitzWGxrdThvMFB6eG1oVmZyTlNV?=
 =?utf-8?B?VGVKR1B6MS9QaDYrenZ5Y2pyRGh1TmZzb3BMWkQva004RU9wTklpYXV5RHFJ?=
 =?utf-8?B?QWFnL3lXbFgyN1V1SFpiUDQvNTJEaFBzS1VUZGNKYjF0Z0JMOWgrMndWdTRR?=
 =?utf-8?B?VzBlbDd6OS9XdjlVY1NVNkdWS2pNZFF5UW9TZHZuM0s3VXVzODM3VzlLNUcr?=
 =?utf-8?B?QitHNVRaV1dWT1BqRWpvdXdLMlcyRmhHYWFmREQvdFd3cU9Cakl1NnZXbUMr?=
 =?utf-8?B?aWtYMnEvc1lXcTlSRUxhc0lZYnFYREpnWWhiTnhzME8vb0JLcnU3K3lwZlp0?=
 =?utf-8?B?aEE2OVplaGZaZkpTZnY0cnhmV0UydTNvTnM1aExvUENFYndoQ0NOT1k3Mk1H?=
 =?utf-8?B?Y1UyYXRGanhEaXY3Sk96emw4M24zblRFOVZaMFFnQ0FFYWtyWDRNNjE4N2lE?=
 =?utf-8?B?YmVUbW9BNDJVSlR1VWovZEpOTWtFREN4QlhyeHM3U0Nad0FFYndoZDNkckRZ?=
 =?utf-8?B?aUxlNy8zK25pQmFNODBOdHFhd2FqNUcrcFpueFdqUzAwaEtRc09PcEJZb1hH?=
 =?utf-8?B?bVdJczVISVh1andnTHZRREhRdVNNV2Z6cGp1RnNrSjJXeXNueE80ejRRNEFO?=
 =?utf-8?B?UWpmaDBQZU5YbUhzM3ZiRXQ3TVlsdEhhMzRmVTZBdEYvTzE4QmF5SkxTOVhC?=
 =?utf-8?B?dm5vMFJ6SzNWbDFNOVNDN1hsUGFuOC9DYm1URnEvWkNsV1hBaTU0NDJkYThy?=
 =?utf-8?B?dFM3VkFWNVpBR2lMMHN0bEh5MFExQnNUclFtYWZIaHIyN2tMcXh5bkxUZmww?=
 =?utf-8?B?ZUdkeDRQMllVUTl5QUFxT212eWtVcG9nNUZHYVA3ekRJOWZBaUpiVzZSVnUz?=
 =?utf-8?B?LzJ3NG1nTjlMOEJXNW10dzJXbXJQVmFjeHBoTTV6eng1VGNWcThlZzBUUFBQ?=
 =?utf-8?B?RzFlcGsyU2ducUJkdU1RQlduRDFnUU5aQWcxM0hINUpqZnBHcGpXTUdFM3Ro?=
 =?utf-8?B?S2dQT1FHN1JYSW5wZVBVWDRRT2FTZ3UzZlUrNUx5YXF0MXJ3UzZDdUNyYnN2?=
 =?utf-8?B?dlNESlZ5TFZRUVJlQVdzd2VESU5jaENMT3pHVDIzQ2J4RkxRTDFOY0RLcE9J?=
 =?utf-8?B?bWZjeVBYMjhzR1liQzdHR2hLR0c4ckNPOHFlTnFleHJZcHlDblNYNno0aXVk?=
 =?utf-8?B?eHBkUjZiQk96WWx5elNHeCszclhvS0c1WGN4OEJYOHJwNEl5TzlINmtIRWov?=
 =?utf-8?Q?ppDDT9zySOlHOKB4koBCIrCX6?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16746944-ce8a-4ad3-fce9-08db495c620c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2023 09:22:13.5332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wIRsJ66EqiCgWmd4I8i1rhvItUawbM5D+KVYeBCgCbRJAnpeaTmLKQvXco12zCr25ZlMWP/DRtJNKTyAadseQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5603

On 27.04.23 16:32, Florian Bezdeka wrote:
> Moving the testsuite into its own package allows to minimize the xenomai
> footprint on production systems. Previously the testsuite was part of the 
> xenomai-runtime package which had some limitations. For example the gdb
> dependency was skipped to keep production systems clean.
> 
> With that series applied the xenomai-images build for next/master will
> fail. Necessary patches will follow soon and need to be applied in
> lockstep with this series.
> 
> Note: I'm now using b4 to keep track of patch series versioning, cover
> letter creation and sending out patches. Especially the layout/content
> of the cover letter is now slightly different. Let me know if there is a
> problem somewhere.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (2):
>       lib/boilerplate: Do not remove $(DESTDIR)$(libdir)/xenomai on uninstall
>       debian: Extract xenomai tests into separate package (xenomai-testsuite)
> 
>  debian/control                   | 18 +++++++++++++++---
>  debian/libxenomai-dev.install    |  1 +
>  debian/rules                     |  2 --
>  debian/xenomai-runtime.install   |  8 ++++++--
>  debian/xenomai-testsuite.install |  2 ++
>  lib/boilerplate/init/Makefile.am |  2 +-
>  6 files changed, 25 insertions(+), 8 deletions(-)
> ---
> base-commit: f06a2e785900ba0d5da170636b2abf2364eacc15
> change-id: 20230426-florian-debianization-extract-testsuite-9cc05e26b270
> 
> Best regards,

Thanks, applied.

Jan
-- 
Siemens AG, Technology
Competence Center Embedded Linux

