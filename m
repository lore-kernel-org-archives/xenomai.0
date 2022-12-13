Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65172F2F
	for <xenomai@lists.linux.dev>; Tue, 13 Dec 2022 12:23:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqKqO68DqN8u1pxtV3P7oBvwT9usFqJ2c8JPdTpxaJ0nKgmWptY2avblRUcGYZtmxtx73XCDhFUP14gfjo/7dFWUTl87KfWWTeGsWRoZvpQ5r3k3j7NblHYqc2RKCl+Ex+EJGdcUVQvj0ETVXFRoNjzDOzTpdgYxpeBcZZXB6wA67G7ifC1M7MeVOOmFPzCibFx353YJ91p7vZn5N0EpujUWPuaMaVxTrtccVX8cOyy8ur3Hgeap9cSDI8MDBNcjiFGILdcHom/C5NEe+dguHyCgmWauo4jWI3lPaX7pIKepj2VFj1e3C9WXw4GOFTuoRYW7jPgPLlovKFvbnKa5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtZNrV2zQep2WMXsUx+PUR1/yacSuadU2uTnMk9IO3k=;
 b=E7/vik7PBT8jj5+Xnr3xJwPuCW1C438OE2PJww7FLXyTjlkEZ/SnUVF0YIUt3gfsP9uR1nEvtmfFOcq4aiJS7zcGvIKnsRGNcG9mwVHPsmjOV4OebbN9XhSvLcnMJ5kiGBgPPPButMed4SfPxHmk1ZbNY8xOeNBR0ApgrZq0CVGZeju405htgNx9QX2FklOfWtqwdJqVHN1Z313wm9/fqHolbLkjEUvrKAQ8Jz5cvredu4vvnlUleMkewX7S6dcq9wyr1wkX9Vzr6KFDJncAnd3Us1DGhw+a0YptCa0eVMweCdedxTnr/P9776omAIJ3S/dWqGqQqDDjdn4CubGvhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtZNrV2zQep2WMXsUx+PUR1/yacSuadU2uTnMk9IO3k=;
 b=bP8URR+Shy2B2UVXSCjsKDSHGYJWb6Hwlhir8R8HyhUlhxpUdWA5VdPcEjFw3g0eIGrf+MMzShOR5bX7cTnUUvQ2oBxQbmSt6DH9BO9gPEFL0bCqIL//CHiEEGnjU/+XOTVCx0hHF00BxcAIsny104TyN+EtYTNaGWhodbeqOC9U7YNH6hu8hhdtCU6zPm6/VpH1ilJSBgbf5X2F3a50RXwp/Kkayu2AKyHDZZxZWp55I7+nsCDC5OSNfy4jduvCsBgc5pIkXnP6s51PvSZHhtsrKwzvMDgILLZWpqcrrSHaxY3D3REO/jls4HmjeT6+5g+zuFkMYQ5q0H1/vd0/CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5192.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 12:23:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 12:23:03 +0000
Message-ID: <1b0c2a07-3075-eb01-7971-1697e70ceab5@siemens.com>
Date: Tue, 13 Dec 2022 13:22:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: Kernel source dovetail 1, 2, or 3?
Content-Language: en-US
To: "Auel, Kendall" <Kendall.Auel@3DSystems.Com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <MW3PR12MB44602042D800C782C18AC8D3C2E39@MW3PR12MB4460.namprd12.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MW3PR12MB44602042D800C782C18AC8D3C2E39@MW3PR12MB4460.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:610:53::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: 01645036-9484-468c-d8c0-08dadd04c7d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9p6tIdGwhIKO7I2gTnb0/JROkhn58YUCSakkauMHT0U+djnKeOofM1A/qaEmupeL7Cv9eD5zyVBpeSRK6IVb83P1DdSIvR7B2xJyxcirryM4qeAuEkOSwkq2ZZ7MGdM5Pb4iqS7UmwzwrCU6QyiR8bbgP88IZlg8roP3SITN5N8JBiF3wUf2QKkG7hPAD5I9jD50/E/I1KRXOwTbuk9N6KWBJMA/UlHPNZzaTAd5MHq8ofz27lm3zvQZjvk7l8NHJ+gvz0voIpk6dmv3cO8lhiel3+/LER2Y04DZe6a/E4aNKMSl7a/MAh2TqmqXmGLgHgMMVdN1AP1IzESDpM4P5k6I3MFAr0fhKAcgKGQTPAqsy7M83XC+DzsydX1A6dTc3PwXyj+Y9yV+WbezsME4BHHbLDxkhgl7oOHDCFAXsoODXJnogW/pJlsBFL2JYtiQoY4pGww0En1yxCq8Mt/5Oa0vYOYhWJ9JMsgymCTI/W5PUggfFIYFeMyOfyLNuiqKy0/6dLZgbKpB0+O7kvdnBbFFLledJVpIw5LbURR/N7ACl9SAWsDdh3IMrLtqCvdJ92yMR2EvuR61MqAouzER1ujddLGCWbY0Tx80+uGo7Hu4a2RzCuPZPaw6INEM4fZQHvyD+rSxKzDQ8hssiWEV30Da1jvJjCaqCt4X48wzyrztxSZz7+e9TnZRginLHzGh01s1jmmGKCsxK1gGwO9Ot5ajL/3ETJgkXhXWKM5xKJ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199015)(31686004)(82960400001)(5660300002)(6506007)(26005)(6666004)(86362001)(31696002)(2906002)(41300700001)(44832011)(36756003)(8936002)(66556008)(8676002)(66946007)(110136005)(316002)(66476007)(38100700002)(478600001)(186003)(83380400001)(6486002)(53546011)(6512007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUtlY1lkU2ZmSi9oVG5vK3BFeDdMaGtTNTNudUpSdTdQTy9STlJSbmhybzQy?=
 =?utf-8?B?K3F6OEdHa0JSMDRpemNCNlVBa1RzR1dlcnhnWVZMQWhCZzlVUVQ4NUFMQkhj?=
 =?utf-8?B?cUlJaFUwK2VZdEoxMkV1OXFTYStFeGs0aHdnVE5wMkU1K2x6bG10ODR2YXd2?=
 =?utf-8?B?QVZEeHhUMDBLNy83c0J2d2NZQzBBY3dqT3BIdFNvZ3BDYXJuR3ZtejBoMUxF?=
 =?utf-8?B?YWQwZW1uNkhEOEVWenFYekluRk9TV2laYWpwWmNaQlVFYmJBYkxCVDAvQ0pG?=
 =?utf-8?B?NlBYSm1nUEFxOTFkNFpWeHFaTzNOWDl2YjFWUTJYNGNNd1pqeDlIUURva2U0?=
 =?utf-8?B?QWdENVdCZStEditZWEluV1BlalFBcjhtRUhmWkttNDdTc3kxZUZZcEpVdzd0?=
 =?utf-8?B?TVdoODJNYkxYa0FRZ0VnNTNPWVQrUE5MVC8wV0UzT1ROSHVsM3FGVE9TY3gy?=
 =?utf-8?B?RGxIOFNFMUwxVjRaNDRLekZWQStSWHR1Z2RJOU9mMHZzalhxa0cwbWcwSmNJ?=
 =?utf-8?B?ZnkvTmVVWTBoRXhDb3hhWlhkOEhROWt6YWNVQldxVXdXQmljZmNjeWtFSCtS?=
 =?utf-8?B?WXJMNVVabFpqWGV5enBSOUcxc2xIQXNMWmFOZW5zcEFIQWVlUWlaUWVJNmFh?=
 =?utf-8?B?c3hnRlllc1RmWXZPMVAyakdjdnZ1dVZQVFhxSGZUcFhYbEVSaEt5eGNIVXhx?=
 =?utf-8?B?NDJxbU56RzgyekoveXQwNm9iNUQvMDYwOERVQjNkNVhXQWxPRG84eU80KytN?=
 =?utf-8?B?ZXpTVXl6NDBqSC9QbkVjOVN3b3BQOTJUREU1ajhqVUo1cmErbDhTaEdCc3Zz?=
 =?utf-8?B?cm1mZkFoekZvTDQvcnpkcHVMalFoTElpYlhHM3d5ZTNUVWRQMktrWHovenQ1?=
 =?utf-8?B?TkFVN1g1MXN2NmJHbnhMcWVYeGpuc0ZzRXBPeFhtTXA2THBKR0xQa0JrNU1R?=
 =?utf-8?B?TTFmTXZHNTdlVm0xQ1FXYm9qUUE0MmlSbzFKVENZaXkzb0RxYS9HQ3ptVjdK?=
 =?utf-8?B?STFDM1BlTmpxNTAybXhUak8rSFR1UkFRTUZXa2tHTEM0NFZ1SWF2bmdoZHdh?=
 =?utf-8?B?d1p1eUx4ZjFpNUR5dVNGUFdUSUZRVDl3Q0N0aHdzVGwvWXZ6QVhIZ3B5TVhP?=
 =?utf-8?B?VlJnelA1ZmZzSDN3S0RWY2F0OUFjSHlXcTE0MU1selJBaHRybTdYV0lBNHhn?=
 =?utf-8?B?VjlsMzh5dFVreTNaRkpwY2llTzU2d3U0Sm13VE9GcmVibDhGRkpHeGFmNnpZ?=
 =?utf-8?B?OW5mdktFZ1MramtWUkhGbktsZzdXU0MvY3pzdGZnOHlvSFVTUHprQ0pCcVdi?=
 =?utf-8?B?dzEzaXBmSDV6d1BqREw4TkkzWGx2bys1THozdHdxeDJ5REVlZDByZmRZSEJJ?=
 =?utf-8?B?QURlTUZWVXZKRGF2K3dYMkpKK2hWNStSaVQ2alBsMkJDYXlmU2kzTTF0RFhK?=
 =?utf-8?B?ckE1QlBXY1Vmblc4Z2VERUhEQUJsQmFOVmNXN3FOSVlGWHdWTDlCWGxWSWVt?=
 =?utf-8?B?a0pRYWZzMWVIN3I1c0F0aUc4N3VHa05CNER6N2RyL3VzczBrbVBPWWRBV0Zt?=
 =?utf-8?B?c2VsWUpLVGpUMHlQaEh6N0hleHVObVlQTkdmNHNtSW54MGZpWk4wdmxSWjRD?=
 =?utf-8?B?bWFtNmtKb0cxbWxNcjBXZzZDMmdDaE5HTGw1amU5azl0RkZsdXUxaEU1Vnpq?=
 =?utf-8?B?WllpNUdxNTVvdXVrMXBWZHExc0p1MXR1UGxWQmFvOU45YmZlbzhmeXRIcW9I?=
 =?utf-8?B?WHVVYytsTlNOSUVsYm14SE1GS3hCTG13MExDSGhCa2trbmxKV1pHd2lKNEFm?=
 =?utf-8?B?dWwvTUdsWWd1Y0FHZEVES3luU3NnZlJoemFuVGM3SGVsbWR2V3BtSE4vVGNH?=
 =?utf-8?B?anZlRTZmYlFRdmRQcXJVNk9CVTViZkl0VCs4SHR4VUk4TlZ2TnZ1Yi9FUy81?=
 =?utf-8?B?WnJRdXd6ZWI5dDdJU2VtWU0yam1ZRVB2dWRJdDZGWGdCREtkUFZaV3dnbkJa?=
 =?utf-8?B?OXVkNktkK1poRjFoMGRESVNtRm9KMmNYd0tMWDhoSFArU3dZdVNXalp0WHFB?=
 =?utf-8?B?RmMrckZFVHhmU1ZkZjJpVjJlWGwwVkpPZ2p1Vm10bjJSLzRDMW9rY3N4d1pm?=
 =?utf-8?B?dzhHVEFNenkwUk9RV1NyczA1NmJlSEZNUjdHNnlsczlLbnpFVzA3RGxpeG1C?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01645036-9484-468c-d8c0-08dadd04c7d5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 12:23:03.0665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3wr7DfB+QIIpleFXOpNRUGBhy1CVEKgFSDENiSjnjRzywgLd8Q0UVJicE7qZovjZVvuk//GH1K3lMl8yBW4DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5192

On 13.12.22 03:26, Auel, Kendall wrote:
> The linux-dovetail git repository has tags such as v5.15.77-dovetail3, v5.10.153-dovetail2, etc.
> 
> I'm building a kernel to use with our Xenomai 3.2.2 (Cobalt) drivers and userspace libraries (Ubuntu 20.04). Is there a preference for dovetail 1, 2, or 3? Or should I simple get the most recent tag - in this case, the v5.15.77-dovetail3? Also, is there any reason I might prefer a rebase tag over any other?

Higher means better - except when we have a regression ;)

> 
> I searched through the documentation on line, and through the email history, but I don't see anything explaining the various tag and branch names.

Maybe someone should update our wiki again in this regard, yeah:

 - v5.15.y-dovetail: merging LTS branch for kernel 5.15
 - v5.15.y-dovetail-rebase: rebasing LTS branch for kernel 5.15
 - v5.15.77-dovetail3: 3rd dovetail release for kernel 5.15.77 using the
   merging branch v5.15.y-dovetail (next in this series would be, say,
   v5.15.79-dovetail1 again)
 - v5.15.77-dovetail3-rebase: 3rd dovetail release for kernel 5.15.77
   using the rebasing branch v5.15.y-dovetail-rebase, bit-wise identical
   to v5.15.77-dovetail3

HTH,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

