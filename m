Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E54412BF3C
	for <xenomai@lists.linux.dev>; Tue,  6 Feb 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209798; cv=fail; b=T+J7S94e/D/unfRzvkTNlEMyHD324NmolKIxRIkf7LKtbkaQMB/xHtgbVpmXzPY9euuQwNSDXgqvJ1wiGt7DHGUSpVUw1pKxBZ/QXClOELLWVHWLcxV7Ulgn8+ECZ73ZdskMT0OwICkrKLC6EHSgqixMkKxZDrgM0CmhY0s1yqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209798; c=relaxed/simple;
	bh=v+NfJdG1tu2zPqCgw5DnlFDkzDGrciD48rHOLBmNxC8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QOd6QXE2/cPHRVdSKrf6Nyk8i5coBcLIoZrv/bbwdD4oK2f0zi/8dKp0+uZlxfFF/9a/p/SDpLK1Gk+05Ku6qEh/d+SAZVi3Xq7MItjRXk4eainacA0m1QuILxtVBCrkD5FljdjoWKKgpiUK76ramEDsLNn9fqRwEKVawg0nl+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dTQ1T/8G; arc=fail smtp.client-ip=40.107.8.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dTQ1T/8G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqMLzLXR27tDVmsqJ3OTxqAJIXrOJ5II1xOYCPtblNYziuOmcqY3QZNy1sfGZF7UxP4lcTX4t1aSCI4WXUfwwwOf0rasY6ZyqgxvhQH8+KXLUWNoFLoyJBRB54Srrp9wTvaOXnw9nTgGI4HuCLpIZX7kHVirAH4HrBjBKN85Ez57eT9DMn3SwIVu1BXrliwHVba4KOs66JIa2To3gqCzAtsOn9PlIOCkitEhUMbhbQL9wtWD7FBY2KY9HmdTOsEd3GDH4k5hWXC7rQjGl04B75KG+q7PyK19y9qlu9pFoIDqsS2jUHwq161GvPzZUPDkk5e7SEBRRZFnT5Ah/jHdwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn11NWyBHm/iCBUFJ8hqUeONdnTIezld6iSDr+2MLPQ=;
 b=SVWb4/qr1iZsQNLisoZdxGl4FZPkaHEo/IUX3J6McgkpKTEL8v+8XZVI9Qzy4vuKltH8b90dh1A8Wt1x3Nn6LKGZtmP+6dt6Mo5/uWXNtgsf3DgxrjhGWh2OAYUU7dWZ/6/VWk3bmVPJ836JrSzuUe5MpJ9jOPpDvsXhgqlnsKsJN22BAq+WYqBJNBo/Fo0WgYsxlvCX5q2S/fVYtvwVRjHmgqFjoF0nfANU7c+GVay7K9C2f27AzETSe3CCwkVvuDJOkju2oFBlqmiVVATFG6S3HwA8cgJkjrD1BkA1uun8Oh46ZN6t91LB7KOhpRqVpZI7tMGGJoV2KBosBZYsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn11NWyBHm/iCBUFJ8hqUeONdnTIezld6iSDr+2MLPQ=;
 b=dTQ1T/8G/rblM1VC5B0Kp0puPc1KA4CLlIrjICAzdcRJHn07Axf29PwVSLVWjMd1Ttp5hEKjSpdg+BITTZe/1oXZXJ8jy/LPRrO022etYB93esRf1Fme74vd0aI7F5irJ8FNQnh8S16eufuoJBkBryYtOOT2qam+vnvlRtDLXJbPTqcMKmhHlVXrod2M8TDTmD0Pt2+BfKMaJJ/H4gMS6RSZPhg7YhGL91o437QauypDlztpOIlHiuDPl9UFR4/b7TSoKy7PYg8HW44QcjzD8CyZymDyLWWpDKHBD7vczp4QNtUbzObljb4DMO9m5aDiAuOd6IdDA88hzmspMSUKbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8204.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:678::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 08:56:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 08:56:31 +0000
Message-ID: <b52d3a17-15b4-45d1-beb9-538f316010ed@siemens.com>
Date: Tue, 6 Feb 2024 09:56:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai 3 setup for BeagleBone Black
Content-Language: en-US
To: Richard Weinberger <richard.weinberger@gmail.com>,
 Mit Jothiravi <mit@mytra.ai>
Cc: xenomai@lists.linux.dev
References: <CALB5Fwj5g-feayCXagd+rYhq2Wkwu0cgixZssDJs5A_WAmNuQQ@mail.gmail.com>
 <CAFLxGvw--ieUV9v6WKLyvwBKntmcSbt+3jZV-cdhbX_VB73_hw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAFLxGvw--ieUV9v6WKLyvwBKntmcSbt+3jZV-cdhbX_VB73_hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0287.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: de028d3f-985e-4449-b91b-08dc26f18338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QpdvhRyLHTD4L+IOQaBjPdlbL20givD9EmOV7DMZQ8OZBeToenh+yE4TymacKiC1kR7zotrVIshsBeeePluwDCtiDaDOAHfxJBcw68FouAy3hA1+j7ZZfe7SebUpB1BM+hc1eZ1q1EDk6C/1Q5U8QV2FdXQ5lGwa54kiW3s0fIZR6Wui6hpwKXwxM2W31POgXEPoHGKmrOAJ51afZ7m5ubFmz6TeeGiUUYOxEwRDFjnyLlDNJ/hYz9qjHN41aBeNYj7uEkuOGYMY3AdLn/r0vGs9gXKRMKYdHTL3y49kVlI+gOmWIvjWf6m2NMKbH7iDVsZq5cRueIjo8FuVA+F5iWxGeU1vruv1QWjmn0aOoQi7vPn7JAY13lFxUAqE97pge6DtyXWjD+oR7OTag9NxP2v0ZWKYqUvu4SB7ltLOYadLFpaaLTGH1+DgH0QpxbLHYOdqkWLTZR+cwsFBT0cOIFoTSBz7ZM2pH/Zaem6n5h5FQVzKXBKDvR5iXZc5sJwZuvR5/1d0+um01MSEKkXDPipvHonFnBGeIbNTy/7XQRlO0UCSduTAML9hMaQaWpXx8MIvPn3nFjiM3YSCyM/5izMuMfNF8RyM6woDVCjQmjGBXboGvx8Q5TojzI6LZhyUOArZ5tX3p4dmy6nX2REBFg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(38100700002)(82960400001)(6506007)(53546011)(6666004)(83380400001)(86362001)(26005)(31696002)(41300700001)(2616005)(8936002)(36756003)(4326008)(8676002)(6512007)(478600001)(2906002)(966005)(6486002)(4744005)(5660300002)(66556008)(66476007)(316002)(66946007)(44832011)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjZzNHA2clR2Q1FWbkJaU2licVJWREJpNWdQQktsMUVYOU9mU1RhSU1rNGIv?=
 =?utf-8?B?dU9JWlZReklFWjBtYUZWQ1VPRVBtZGhlYTdpN0hTNEg0eXMzcjFVdTB1Q0JW?=
 =?utf-8?B?UDJIRmdyREUwWXJvRW11TTA4bCtkcWprZkVRRU9ZTE9oRGZXZWN4R2gvc2gx?=
 =?utf-8?B?bWxpd3hnN1ZLbjg0VnM1UVV6U2ZmU2lialBxVzlPbTFta09MMG1OajFNalA1?=
 =?utf-8?B?MFBMTGpsWkd0dTBoK3FJU2NZdWhqeHpkc2JORlZEUlhRbS9tSnhvcmRhWlZj?=
 =?utf-8?B?ZzhiYjhDS2FCWU15NUFNaU85aEdyN2RCeXJub1ZFWkFhYXh6REdVcUlCdURJ?=
 =?utf-8?B?ZUtmVk9xZS9kM3l2NzYvd1FETWlTTXBZODZEdUdWampuQTJwNGxZL3g4WEpX?=
 =?utf-8?B?NGdhV2hYQkx5cWMra0hzajgvYXJOYzBFK0pmSk83cjVmSEhFL0FmcVl5WUk1?=
 =?utf-8?B?UjBSV3J1cWNaVklvbGZsUlgxZXpXN1N5enIxUk9GRy9jSXhLWS9NOUwrOTBD?=
 =?utf-8?B?MkRUSHk1U2QzV2VsSDlWZmsrQ2FaUS9vQW41cW9aN3JRUUVLd002T3JvcXlt?=
 =?utf-8?B?Y2hqZFRqNzVINzc1TVdEQURrM2Uwa29YK0FPajF5S1k3SFJrTjliYUpJRmZL?=
 =?utf-8?B?dXVkbDlrcmlIQVJqemMvT3NqcDI0VWU5bDlHUjBXM3NDcTFOcjYwUC8wYjdq?=
 =?utf-8?B?MFBtMmxWcUJqWWhmNEJaVFlUeHAvc2QyVjNiTjQwTm5zNUxpK0Qvc0wvTlVU?=
 =?utf-8?B?N2NQNFk4MnJFa2Z0ajVjb1RpenczUXRMRUFTQS9vRHdZaC9pMFpwV0YzTUgz?=
 =?utf-8?B?WFhqWlU2SEx5NEt6SFppQkxRajhMc05KUy9JcGlxcSs3SURsZ24wWXN1a1Qr?=
 =?utf-8?B?WkZ2TEUwdllqSk9aWUxHZlRSODRQdTBqa2lyNWlwdjY2eDQ4UFZ3ZGtvd2pO?=
 =?utf-8?B?WE5DVHRnQU00S1pWTlN1WG9YTGRRNEpZWEkwWXl5dzFrZkFpZlR1cGpOTDlh?=
 =?utf-8?B?bGMxdFF4ME1CRkZHRlBBeGRoVmhKclhMWEdnUkxDT09wc2wySnQ3RjNteW55?=
 =?utf-8?B?eHovT2RsM2FBZFQ1YmlLSTNDWXkwMThsVTI0WlJrMXJTWEtjSk4vaEJtKzdU?=
 =?utf-8?B?emMwRU43TzJ1SndQM2tKbFBjT2hseGZ6a0IyY2FTYURzMy9TUjdzSmJZN1NW?=
 =?utf-8?B?YXRCeDM5aXA3eUpxSkxPTC81OURlcHVVVFB1L0Y3a1dUTm14N2xhL1hqWG1z?=
 =?utf-8?B?U1ZUSVhZRUZDNlB4dmU2d3RSVkJkakF0NVRUdytuQ3FVblpzOFp2TThtTWQ4?=
 =?utf-8?B?cmx1UkgwSXRnVUYwM2JTemtZOWx3aUJkODNRaVc5TTB0MDdORXY1MkRVU2Jw?=
 =?utf-8?B?MWFHaVRPY0k5NXdXWGlKNnI4c0ZwZnFQcTNiZlVXb2pYTUUxWjJsYmI0WXZw?=
 =?utf-8?B?SnJ4cmp5S3k5Q0hsdGVhWmlFTGpTZldFcEJneWxNaXlreGxFS3hkdDZYMW85?=
 =?utf-8?B?dWpyc25qenE4eENpT0RCeTVpZCtoU3ozcTJSQXNoZDBXcjN6TndsWDlxNlQr?=
 =?utf-8?B?UjhvbWIrVDNYUUxiVVJQK1U0TWVnNjIrWEdyMDlFOHpwdzJYUXhEYnRBRTdw?=
 =?utf-8?B?SllkTTF5SGRZazNDUitGQlV1bldxQlc4cUpPN3psVUUrenNTM1pleTRxVkFJ?=
 =?utf-8?B?eWN3UmFrSlA1QmlFSU04SlJRUEt6ellmK1BsZlpKZmF0NXV0VVBOK3BqaExN?=
 =?utf-8?B?UHFSNkhRT3M2WG9ackswTFF5alJUUS9yMk1LY3MrM0g2bWJLYlBsaHBxMXFR?=
 =?utf-8?B?SXRHczZpTU9yckxyWUxRZjl5ZjBicVViWktGVjIzUncvRkxFRVlsbVFEa2k4?=
 =?utf-8?B?T1pOeTlXTmhCeTZkeGh4dHNoTFVwVThVc1U4K1p3MmNiZ0lVb3VZTGtCVVRq?=
 =?utf-8?B?aUVqZ0xPN1YveHVSdC9uQ1EzaXlNUUlOWVJSUzcrMWo1d1VMYkZrVk1KQWRV?=
 =?utf-8?B?QzFqdVhEN3dhWHZXVFg4TG53K05ud1dxOEZDeWFxVkJXS0JCc1oyYWhySVRJ?=
 =?utf-8?B?MFJWUWEwWWxGL3k5emhBdDRqV3ZxN2FVNTBza1VBOEZGRlpCWHhwUHZJNGNq?=
 =?utf-8?B?VG45aXo3SHRJTzVNUXRUZVFtT3UzNSt4M2FPc1JLYVpsTWdvZG5kK0FUalNE?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de028d3f-985e-4449-b91b-08dc26f18338
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 08:56:31.1136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMN+N4AnMHA1a67o+MV3JMVBzaY4UuLzJjcEoUhKlXHyudPS8apTcq4o8xkElu2NTaVMZpYyWK7ugO2CZBTReA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8204

On 06.02.24 08:25, Richard Weinberger wrote:
> On Tue, Feb 6, 2024 at 12:25 AM Mit Jothiravi <mit@mytra.ai> wrote:
>> I would like to run the `configure` script to specify the single-core
>> processor using the following command: `./configure --enable-smp`, but
>> the script does not exist in the Xenomai 3.1.x stable branch:
>> https://source.denx.de/Xenomai/xenomai/-/tree/stable/v3.1.x?ref_type=heads.
> 
> You need to generate the configure file first.
> e.g. autoreconf -sif
> 

FWIW, there is a pre-integration in xenomai-images for that board in
case a cross-check is needed.

>> In addition, the self-contained source tarballs outlined in the README
>> -> http://xenomai.org/downloads/xenomai/, returns a 404 Page Not Found
>> error.
> 
> I fear the new website causes irritations.
> Jan?

Yeah, someone needs to update the README, aligning it to the website. We
have stopped providing a static download area and fully rely on gitlab
for that now.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

