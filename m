Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C8910FE
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 06:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpGl0UdQliXR2IjAMzAep4wrJTK2BQ3sctGmcPv9iz3vKrOHA2ifmMqcqX0q5fLkNYThs8D/l8IqgPr793z6wqJnMILrUwlOTkox4kwSB68gteIOV1PBLaw0218tyTuMYMVPCLecSkISMyR6sM/7eE2BSKNz0zp9HpuD7D18+mzf9nNxvrwH+xsB8SejAfvd4jyJkl6DwE+4RHyfHvgUk2gY+xnETGITTYS5yzJxux38gmzL16RehFfXq98ADn7A/uteR2obwBe08Yau693qbldKEPdujTkYj0Incc7B38zkCEEIW1TC05VFBVQd5lpriNPg6DdN4e+XNjCuZshKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xD5WE3o7hdPhhgU2HFU2qQMvEiGmkJ67lF1y3yO5S8w=;
 b=GIyQDnp3ZOROcSsR6P9xx382SipME+y1v1zvz3qu7jSlQCqUC4V8jWE3/Zm9aO50aPa7WPrHCcadIs8MqdglaMW/k3FHlJNf50tUzHN11NSxBfi4VYDSdZB76QecBrapvVbCnjxR9KiUuaNzbqfH3/vKeU/fwzP3bdeJF64DTz+byTkISoi0ZGKUy4G1hswlrwk9MOiAucaFrHQx0EP49dhISMz4f7HTic3aro53w+rsGZOZTUrrNIxcCdvhMhv83sS6phwyLUwIpwcnF6h481rlYp9+pifh25i5kJzaqTogHVFSHSfT3FKGHzhlsCk68/Pjh8pdWB0cOEanXAHjRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xD5WE3o7hdPhhgU2HFU2qQMvEiGmkJ67lF1y3yO5S8w=;
 b=BDUniGylLDYhliaf7HRPlduUUfLBWxcmQziZ3k9ZtgameLcJnCk1L8uGUffHLKattZXW+dHvt5i2aI9XomDj0hE5JoSeJE5gWVAixBtMAliKbRJbQm0iHvS61Yk9JUXZoyieL6GYRMUPmpvpT1/Vq0w+TVRk0AlFrt35UUywE9KfSm6YuCxCao1G0wwfVkI0ObKmSubZP9w1M92Sup7Wieqbxzcjrzhi+OnXct7X+pk6JD2EbkR6DivLAVcfCz92kb3xII7FkUypYo1ttOppoRy7keW44TjDgTLQ2xy9ghRIqHEW43OK7SD1KeXyK3V8TDt/ZWNF2mJCRNm3aCDVVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7732.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:62b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 06:54:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:54:15 +0000
Message-ID: <bbded65d-a4df-1570-26f3-fab45bc71d1e@siemens.com>
Date: Wed, 5 Jul 2023 08:54:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 00/12] y2038: Add time64_t support to scheduler and thread
 APIs
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d6a02b-4b0e-41ba-97c0-08db7d24a59f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+sZiIw/+LzmWiXgqX2dx+P6mLXRYLK3/EzvDuuGhNSWZbJmpS4rbSBqMT0I4o7yc82u6igHBOXm1NGO7AbMdjiqPgno3Md8bDkZUTqs6eZlx6eXoGU1YiSxnBH26vesWUvwckwbW0MtGLj/MgmS8JzrEsPaTtwYVW6QWtLjFEptvsQ3mB2RcLoFovCDsac7hBp3v6PI5DPrtx1bvp0NA+WgrhcUglA+BBZOKSMKJ6RwFghKGf0YC82yagnzZ8WSo5RZBrXyzPLsjijND5a60dwOPsoR/NCJFo1TWx2b7ycqIUryyxtK+oFw+LOPMNYhaW9AvT6G2QCD2Vd9st1tMViXWM/ZNlm8tI993ZNxkgm+EkrhA71OJ+t/0YHynI/mW74FXMFELpXkT5NdlvR8+41xM/c5lSh9I5k3045ESAO/2F1WJZB50C5b8JqEtAhfLYrzcX6PYR0lGp9jYi0ckdqZb9iYuFoaWTEhmD+W1A9MpX4xmLIDz4Emthk61kArAou4YWaxFZOSVfGAv3xDIIGD+B7FqT5xxBJhx0erZFTfztc8OBg1kVp8xY37CdlQkaEvbtMAW8rxNqG2AtkkYnlnnO0Px1oB3NJsv66tOlVDrSQzUxJwxIyqYcDF7TwoGldq9UCp0Vse/NKYAtGN7AA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(2616005)(82960400001)(66476007)(38100700002)(66946007)(66556008)(186003)(86362001)(36756003)(6486002)(31696002)(6512007)(6506007)(26005)(478600001)(53546011)(8936002)(8676002)(4744005)(44832011)(5660300002)(31686004)(41300700001)(316002)(2906002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW5yRVoyUk01THdUYVIyeElFRnRhQlVDZ0RLVmYrWkZrUVpka24xQ1Bzc3Fv?=
 =?utf-8?B?V2NoUWdCdXBNZTM2S25xbW5vTnRiSS83emI5OVQrSEEzRGcxVEgyRysrNG1S?=
 =?utf-8?B?TUh6SDl0TW16Qk5rOVUzeUd6NFlqaHlJMWE1eTVUeDJvdUVSTXhYWTFHWGxC?=
 =?utf-8?B?SHlSZUcrdkRqUVpraUJ4Mmgxd25jYXQ1d2tuRkVkQWN6cGxoQlVvUTJ2VExi?=
 =?utf-8?B?NjhrQUhISER2UndsU1h4TkQvVlpKRnIrRmUwL3YxSCt6VjI1ZUhUclNtZzZR?=
 =?utf-8?B?QVlJSnN6MXUvMURWTEp0VjB2Z1U5MnlqU08zWGw1azZScU1TNDhrR0lQVjJI?=
 =?utf-8?B?NE4xWGh2d29hVlU5VSs2RVFCdGl1bThhUU1Ya2tPVENCeWM3TEQ2b1UxNlVi?=
 =?utf-8?B?QnNMOHVaSTV1d1pPWFpaQ2l1MVZHN2xYZDBvUWpqM1M4T1FqRjF4TGM1Tldl?=
 =?utf-8?B?WHJNc0RDd25LNFdBSERPbWxpUWovZUQ0dlJsY1YySUNWaTZ3VGdrMjFza3Az?=
 =?utf-8?B?RWdRRTFYQjNScVBYWmtXN0RRR2xKb0t6aENSQTZqd3ZYVWZ5WUwyTlAzK3Va?=
 =?utf-8?B?Q3BUT0JGcUUvOFgxUENkMG1IRVIrdXBrQnMrTFU3b0ZCanJiS1N3U1pJQzY5?=
 =?utf-8?B?R3YzbitiZURza0l5R2dGYTFLajN0ODUwdlJDeEVnVS8zdWtJTDkzNXVYL0Zz?=
 =?utf-8?B?S05LUEJ0dTRMMy9takkvMllNbkZwRW5kWmhCUEFIR1FadzdRZHpqRkxuTHJP?=
 =?utf-8?B?RnI2NTBlS0plajhwQUkyMk9lTXJqUDIvbHlqQWhKQ0FMNzg2THZDS05oT0lG?=
 =?utf-8?B?aUdSc2dPMFdTck5BL2JHVTAxWEZqc3dZbUs3MTNLdkE4SG1RUWJKRWRXTU8x?=
 =?utf-8?B?ZlhZMzZIdGZ5S2d6TVprTkZ1QnlVa0dvNFBaYjhYTTh6Q3htTkwvSnJHZ0Zh?=
 =?utf-8?B?R2tmSDJranpXRFF0bUIrWGdWUWVoamNneGVvWndIMmdIVkpNWHFpc1ZwMURG?=
 =?utf-8?B?SDVudk5IVzVobUpiZEdTOWQralh2VEZ6bm53azlQWUk1NnJvc3Z6R2JITk96?=
 =?utf-8?B?N2F5NUNIenlhOGpFRTNlMG9GcHRRdEpYLytaclUzSU8xSXhCaStyeFRUekZZ?=
 =?utf-8?B?c1VyTndtUnR5VVhyZVcvdU1yWVlDVUNEUkNqc2FmdjdjbkltSWVONU9PckVq?=
 =?utf-8?B?UDVwZmRueGZYbS9lZFRNWVd2WXdIakdlZC9GTXBOTmZkcXhRd0Q0NTJTMC9y?=
 =?utf-8?B?cHRYL2U0RmRMMGYrbUFBSmFmck5JbnU5L3hCbEpLQnlBYjM0TXNFRk5iaWVR?=
 =?utf-8?B?cmMxc29sZ3pDbWNGbmVJOXNCSThZV0JrVHV0NytrQnhIOXczL2JPKzNidXFL?=
 =?utf-8?B?b2VYSXZIZTNMcys0dWp1eVlDQy9NWmw5YW9tckhSRkRSQklKYUs2ZWpFL0JE?=
 =?utf-8?B?NkJXamdqMzNzTUN6eUc2a1J1TDlia05zTFlGeVhoTFlsTmNNcGxjeVExb1dB?=
 =?utf-8?B?a0pBakNiRW90ODloOVZVVlQyUFpWeWtKcmRRbDlSRGtkVXQ3NlFVeXlhOUwv?=
 =?utf-8?B?ZXlwVTJQNVBxOXdyRDlZdG9NbmlsM1BLQjlkRC85dHUxTFFna2FTeDJyeVVt?=
 =?utf-8?B?b2gzRTJFUnBWYjRvaUZJaVRjY1VqS3Z5UndycFhTQXIrbUVFbWt6MFh6N1ZF?=
 =?utf-8?B?UVVsU0xzVFZwVlJvZ25FK3NWY1Zua3F5UFpoMTR4WENEc1ZWcmdmbGQza0sz?=
 =?utf-8?B?aitJc1R1R2ViVUtQb2pza0pvY3NkQURta2ZYdHBOWmV6bWYrZkFDQjQyU2RH?=
 =?utf-8?B?Wk5lNVpwZU9wSjNQd0ZhcGg5TERSZmd3UVludHNBUnRPMzFab2MrVWlhajVM?=
 =?utf-8?B?VUlOcHlxajJlWE1HcWk4c0JSbjJTS0E4eHRYK0RZamNuSnJqV0gzdkRqRjIy?=
 =?utf-8?B?ZEduWklvTGtXUFRtbmVFM2ZjL04xTnVUbTBqMzRzUWNuZ3RhU0I5eHE1SlRO?=
 =?utf-8?B?NThUVm0zdFFITVA5UzZBZzh5ZmVkWnJKUFc3clJZNlNoQ2pzNmQwcmZkazQ5?=
 =?utf-8?B?Z1FkdWRUTU9iZlhZc2czdXd2cy9DdjVMcUk0K1d2YzMyUE1EY1JCQzBCUnVH?=
 =?utf-8?B?VzBxeUNkV1hhQ1N3RndyTEhJMjNMVUt6c1RmSmptS0lGTXA3RmEvWFBsQndx?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d6a02b-4b0e-41ba-97c0-08db7d24a59f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:54:15.5233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsIDhg4i+ibqporJuwivztGN9P5nwMrBuv8FFSHUkot50lhOBmFoHtj85fAc5M6CHqYItto3Q4wSndlLkkhUIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7732

On 05.07.23 08:38, Florian Bezdeka wrote:
> Hi all,
> 
> this is hopefully the last preparation series necessary to turn on
> time64_t support (a.k.a. y2038 support). 
> 
> With this series applied the Xenomai specific APIs around scheduler and
> thread APIs will support time64_t when requested. The final "turn on by
> default" switch will be part of the final y2038 series (which is hopefully
> the next one).
> 
> The remaining stuff can be found in my y2038 queue at [1].
> The Xenomai hackerspace wiki is up to date and represents the current
> state of the y2038 work. See [2].

Which of the fixes from patch 8 onward should be merged first so that
the problems with the in-tree tests are addressed first?

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

