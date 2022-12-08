Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2040.outbound.protection.outlook.com [40.107.104.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5F32F5A
	for <xenomai@lists.linux.dev>; Thu,  8 Dec 2022 14:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giyyy1rXpz7V9ezGbCxTDUgpgKWH6Z5eAkoz7b8zruFzXpOqIrbAtpPnCoCaLHHkvFFImJtHpFWmD/o4bnXHjOUa1qnz42HklF0CjNKB2pss4xzD5V+3iY95Gjf7komdxKCnakuKSZMKL4LDCMnUHkf79DcRuh/rD6/4ztnfP1FZhT3Ru1vlCgVEX2aNHA2JyRJ/YgMdruANL50MMEAmvGQmu2P05GY+pmhwq8L04ymE6WJsc8pFpmT+97V6I6KXwCQGWRDWj4VZ2aOiWaDZ0/ouHb6xCozJ2Mf1z50s/a6MQfUnxInsjHSPbtN9ehpzJHtNN9J+TriAQnjExSLE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GkAnZzpfw+oWCje1iCHia0cuy6V5mrvksZ2rNKxt1U=;
 b=lwKUzYy4xnBenD65MfkLe5I05OBUX8q314T6HiVe1jFlACwrVPWGUL2nZRv6Zqngj0hfy+YTXVQ4F0WwcxpTga+oFWzVGmVYBlE0E4Pic01nJOU4OWXH+xcf/ST5BUknfRIgqrB/zeOQHM2lW0FkAdTPxPvwmKeLcAyOQtxHGm9hMdY5SfLEB2y4g/iUbj5zvTBa7TiOfdO5SlyY0RLQO1NZAcZ8I6sdrelH9pNrySwDNQpN6SzuPvk2xQU1C12gLRogWe7G+GyRLOhQuFPdFi5NjtNqoWs2/cssMB7oSPjxr0Reb09ZnlioQ+nliY4/vkgd78cc3XpaFcEoN3gGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GkAnZzpfw+oWCje1iCHia0cuy6V5mrvksZ2rNKxt1U=;
 b=tIQY9C+eB2XbT/827QRjbbKZW7mvq4/AbgC6Ram8I/BQFIMy/Y/GSR84hYYHxmVsh+80wz86ZiHjNdoKkn8eSau/ZP4trdDKKl6NYFyP7oOZaQeoZXuQgjNqsY3xspatvcObfZwY82aCVaaGQFdw96fnb1N0FiJPN9XmvJ3c2tMITPuX6hZ8VtN2ijbfil+enL41o7rHCKMx7tTGUFAhWWEFGoNa6t9ykzL4YiyY3zYSjaeh1hiWhCgcRBJT5krZSbDVpIpwKN5Jg3/ASpyZbYkv+X2qWLGW6EEChFcyuKBW57zv8OsHK7juaoRdDlHG370qc1a3tPEDDncU13SMug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7254.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:619::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 14:03:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 14:03:50 +0000
Message-ID: <9d31cfa3-f419-bf80-19e0-e6e138026078@siemens.com>
Date: Thu, 8 Dec 2022 15:03:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/3] switchtest: test multiple secondary switch cases
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: "T. Schaffner" <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20221205152104.3555474-1-tobias.schaffner@siemens.com>
 <20221205152104.3555474-3-tobias.schaffner@siemens.com>
 <9aa8fee9-0700-6568-76d0-ef13e38ba87f@siemens.com>
In-Reply-To: <9aa8fee9-0700-6568-76d0-ef13e38ba87f@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:610:38::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6990c8-7234-407e-fcc1-08dad9250808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZjB7i610MLD/ZLipLcpqMTMWtD/19eX7VMd0l/yN4TR4XjCGVTcIkMfFYp77p+jUafkSiJ1o2wM6ZGP8vovoWINs+hLKJ1d+n28ezIsYRsuTiuKuzU6tALJL0J73CuGXZ/4T/vN0VVWDADjuz2XBft4l8bKu+OyKfywh1uyzhQhoPoGEvJL/tUdBi7ztiwb575U4oWoihmq/qgOi5dJObTcTB9VUjAhjWKM4f3WOUSLV6tJadCXuyxIkk6syqanleWEwFvA636HnS2PuZYH65JRfl3PDMR4pLZiae21nEEkeOueFvq6LEwhzkz4A2Fm6AwDEScinNIiNhqPX2qwZnaAOSf1xMntAuw9Ft/cNhil19jWmVzv3BHPGta6HIhI9j6ICG0DvgVlMrQ0vldRhkizgm175uk9XL19vSDLrrUz6lb/AeyOJ/EPDgc+84CcaPwivK57/bTm1Mv/RO9EsWiJ7cj1jXLRKdOzV9UOBnGH5951NH99NLyhaEO/UTC4eNQrk66amBuB/h3CqMP5P2hTXqUFZhIPO0lt5HyzGTBq7kBztKPHeitQmiGONrjrow2/9slEBE66GmfwPnpIcYtIyv2U2hH7KmgenEZwmudbzR5mJ8P8AbUqdtojz339fzg4m3mYUCBMkCprCVVn5ldedaqcmehbX1mmmwioXoP8Cdu0p2bkV0NHsPEU4kV8ORtb9Qa1Hw4dtBBke8g/1TPZ9z1HxXFDoT8PZWBGLhNw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199015)(6486002)(44832011)(31696002)(86362001)(82960400001)(8936002)(2906002)(5660300002)(41300700001)(4744005)(4326008)(107886003)(6666004)(186003)(53546011)(26005)(6506007)(6512007)(478600001)(2616005)(66946007)(38100700002)(66556008)(8676002)(66476007)(316002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0J5NnpUZUE4eGh5ZVQySWNNMmxpRU8xY094ZVJSdTluT3BMMXVaamZGczdw?=
 =?utf-8?B?YXRDVk5BNldoZmJsTS9GU0FDMDlPMnZxd3ZlWGV6ZkVJMGNON0tjS2RLM0Zw?=
 =?utf-8?B?WGgwNm5kanZwZXhqL3NpR1dYbEtvVm81R3orc0tIeXBhOTVYT2UwdkhUNHd5?=
 =?utf-8?B?NS8yVzZBdHVhaFVBcG51STFjSVN1YU5yQWFQYnVYWWdTbEorMXRSSndacXR3?=
 =?utf-8?B?bUNhYWY1Y0h4U3k1Y0hweVVLczA4b2RhR0FTOGlqcFN6M2ZRS2hwbGx4UTRM?=
 =?utf-8?B?czdVMnNlZUdGUWlkZ0JBM1V1TDZwZVB4dTVRaTRIMUJTYW54Tk5NMnBNNFVl?=
 =?utf-8?B?SWlWTitTOERUaEFkRjgzTlhjSjJPMnRhY0REQlRvWnQxdXZlcmY3Vi8ybzZ5?=
 =?utf-8?B?aExHTEVYSnhXWjVGMG5nWVQwUE41UitQS2tHZEdJdmV2ajB5Rm9ycVQ4aENv?=
 =?utf-8?B?WGdrZVIveGdKZUZlMFlqcVFZaHVUaTBKaXhXRnFJSzl5OFo4K1RWcGhJSzJV?=
 =?utf-8?B?K3hnejBiZlVLcE1LNzFFTHQvQmsvdUhnY3ZweDh6RzVyU3F2cVZIclI0OXhW?=
 =?utf-8?B?bE1rWGVNQ1ZUbnNRaktiQWpld05tQmxvblhnVFVIazhqb0xCTnlrb0VyT1hq?=
 =?utf-8?B?cUg3KzM0Y2V1bWF4eUdFOUJsOGtOQWlkRXk2OHJIWk5CQi9WYXJCUk1wZGUz?=
 =?utf-8?B?OXJnd2ErbnBJdkFOZHVNa3RPcThRSWc3Z0M5Snc1azk5YU5oWENTbTVkd2Er?=
 =?utf-8?B?OHVEZi8vU1dGbjFQSDhwZUlIMzQ5aXd2YngyZG1pSDdsS0ZrdnJLM0FyTDFa?=
 =?utf-8?B?bFhJNm5tOU93UXpCYXYxZTBJSFBOZDVRYzR6TTdkS2FoQUszek9kc2NQRWhL?=
 =?utf-8?B?eXpNVkx3QWtsdXJIZUo5cEhYanhkNERLWnlGVjBwZVpRTkRpUEgxbnlIWndZ?=
 =?utf-8?B?VlgwQ0VETTI4Q0Z2VVdPQ3VpN3lxU3VBa2kvRC9iNHkzYXVxVE96cm5nMkhh?=
 =?utf-8?B?ME5SeUVjMWg3U3dMUXNXazNIMlMyRUVPVitRakhnSHEzY2cwRGdVYnBSNi9r?=
 =?utf-8?B?aTNtZ1VIT0ZTMGh5WWt2U2tUcnIyVnpxb0QwSHVqa2Nqb1lPbHlYWTYxc3dl?=
 =?utf-8?B?SFVDOTBmUzNMYnk2UzM1RExQdDBaWGxxWjdUK2tkRGdoRTByRGVTUW1taG9i?=
 =?utf-8?B?ZjNXcHI0MUZ5eE1CZ25xOWpsd3NtK2l2SElCTXBGZXlLalFMOGRHckN1RnBa?=
 =?utf-8?B?aFpwb2F5S1VGUktSSlN5S2pxaWlUUnQ4QnFBOFIrQXYrNmt1MDJ0WWE0Umhp?=
 =?utf-8?B?U2JzUU1jbHlZWDc5MW9vbUtSVUhQMG10T2dtS2I2SjJBTDlZMzdCVUZRbHpE?=
 =?utf-8?B?Z25xTG1WbkQvZVlFeVptOVdENUx5MnRlSjZUQkVkREYvcGVtVWdlMGZkdWlz?=
 =?utf-8?B?Um5EK3ZOWG1Qd0hhdXNsMWtxdFBGeVk5SCsrWEZmeGVScmhHeHVhUGxIeE9F?=
 =?utf-8?B?N0dIWU4zTUNlcFBUNHNjUTB4Z0hWbGJISHJ5YXBXSkN0RUVFYVFTRmk2T3d1?=
 =?utf-8?B?OXlBcUhsNWZYSHpLRU4zQmVTRWg3dnBOMXo3d1VKT1VpUDJBZjhhMXVqSE9a?=
 =?utf-8?B?OTU2c1orOXg5QTRZdndmQ3NXRlFUT0Nxd2cwU3UwWnBFVEtPcEMwT3k4bjRI?=
 =?utf-8?B?emZaNjlQeWRqMXRpaFdNWnMzelhocnNBUVJtZVdBK3V5MEJkTkRwWGs5Qi9i?=
 =?utf-8?B?UDZXZ2tINVZDaWFVdmYwREliTG1JeUdXVXJmK2xVUlFsQjBDVVo1Uk9wK01j?=
 =?utf-8?B?MzdPN3VCdHhhcU5EZWdUTjFwcUVGdnoxUWplTHZ5eHBwcGR4RFRrZ0ZYQnlu?=
 =?utf-8?B?UVJYaGhPcEtqVFlRR002aERqYWc4TUpwMDR3QnNVSEZKaVdIb2RtcnQ3c25M?=
 =?utf-8?B?cFNZMmdGS21na0hNUCswanZnYTdSL2hGejRMeHh2dTkrTEd4ZVBjNlZxYnZ6?=
 =?utf-8?B?UUEwN2tIWG9VVnE0WkEwMURFRFdadi9xdThiSTgzMlRTaEk5VmRsT3QxVThB?=
 =?utf-8?B?MDUxZWpKY2VPUEpzbDdCNU02akd6YkM2Zm1OS2p4a3lEN211V1QvTDh0RzEz?=
 =?utf-8?B?NWlQRnJPb0FPaGhITXhieEdEb2dMTERxSTlmbGhwMzg2a0tEN0tzZjkxeklr?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6990c8-7234-407e-fcc1-08dad9250808
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 14:03:50.0670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nZ+FgIhhCdL/U0jGYMoQDDysd/y91oA2klg0VjE+glikXp4fODIaC1FteF9XM5aA+h8z0HD6LIvENEWKjyCqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7254

On 08.12.22 14:53, Jan Kiszka wrote:
> On 05.12.22 16:21, T. Schaffner wrote:
>> From: Tobias Schaffner <tobias.schaffner@siemens.com>
>>
>> Switches to secondary mode do not only occur when a relax is explicitly
>> called via the cobalt api but also e.g. when a linux syscall is called in
>> primary mode.
>>

Oh, and what does this change contribute /wrt enhancing test coverage?
The reasoning here is not yet clear.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

