Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E332E62F
	for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329311; cv=fail; b=IsY9AQMpgl+2ssGr6QmVeV/jvbl64CPIJLCzBOMiGOE9DLT3dPfXWLOFRehcOZoEPWVpTswLTnUiE5hlFu1FDvq8EnyfvMw/YSoEcX9IqV4biPk/J2JQxSKI5hTq8VyZGmwhrZ3UHl5pbO9uZA6VqziQ3C4GbIMpFiz0ZXdodDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329311; c=relaxed/simple;
	bh=heFmgviAcgS7UZQGU5HdlyK3TPasJ0LKQeOehsZItZ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nQqndAgPfqnhWmBUj4JihukI55S4ueAK/r479oQgO/PpXR9ygtxuFBskw+O5pT8hpvLxLMiSe/h5N4xBwDui4TB1C5xH5OIm36ye5PAcZ1nETCM4G4fSf585r20iGhRYgVrDhDvAYqPposMTq8lsmMbhMPNfOpv/g/UXo0NFD/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HUaM6AGH; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HUaM6AGH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HW1+6DhGvrrpYXbR5czvbQNGCD687Q8UXOLVrOcXbpaQBkxG3xr6pOQRRUU3AR5tZgvuflRwezjoSfP6OFbzOVVWWF2VT+uO6iF7lNbUkzwXfso/t4Q3X8hEu7X6NhDnjEVDLE4psuuIWkVegmT9QJ7/x2Ln87nqQc/5TCd05rbmzzbN7nhwzKzJU1mJg4Jw9PAD7TbmB8vw6vDEflalc+GksKWZ2gEiEQwdMaHK3aQPAmyGAJrJnUqe0WcVp9hRuPDB0vTnMUKFgJkc8IYBHcX56+T0tAHsU4MkdygnsFu7yeFnIWVdPUyGnLM2qZab/6/NV4FEhZ0ECLaRR6GBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9f6QS565hFj176oBtqR+aK6cG0PcXGXJFFZ4j0jAt2o=;
 b=HT59m8beR9uhUxYbQhY/csBjB76em5GglwaBwtjgCiCmvJtDz/RBtzRIcxrellAJ1UmUzpt7N9T+HNGw2ZNKs/rbWzFw6yqQupR1hSuhfnon/NXdpTpkvRnFH9+hNyXKHL4q+SZWRuLPhIZS7sTDCopplqS2r3jz6wnvirPJHo7qi5Dc4euE61OvH/y3W8V5RE+OuxencQEBRQ5CAKjvLIfW7AAJAY3aZ9oTgrQFmijsdgU71rRFuuMDcIHnaoP68TFomtoAYaQqsqOy8xYgLWyd5QQDNCUHWJFCWucpv3Zw7fBnOoiDUEx2cWOi2owXEhSi6BRHYvp9xhLfOjWhvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f6QS565hFj176oBtqR+aK6cG0PcXGXJFFZ4j0jAt2o=;
 b=HUaM6AGHJP0k2/WbJtmVBTpvCWpEz4/yHJTiik4fVIGbkbjf8jriHbkWLxMK2RVZzXcHxVIYe3dzs7P0eam0eSG+KMGaVDhnelkKVT6HhZvg8XRwAcCKgFDEH1IT/4ZZYQKHmUj59r8Tv/R6rK7ZxJWfwF9RyV/uYwqAeTwLv2vyoFauwkNLQasiDSpkJGiwcjkqgR2Sw0XgWC73vbF9aAnOUvLctsL1mlwCYlIKGAggeh/qnMkfSg8UV+NRAPVWm0V0t/D/zCWyc25NiwrBIR8KeaXbxlV0WH/g8PlMDvDwdtNGJbJybyfw2TAfEm05Dsn6FdgHJqswwO8ouPjong==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:172::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 15:28:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 15:28:20 +0000
Message-ID: <bb9ef3e8-b45e-42a8-a64d-8ead8f81980d@siemens.com>
Date: Tue, 25 Jun 2024 17:28:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] prepare-kernel.sh: Convert to tabs
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240624203341.6263-1-richard@nod.at>
 <20240624203341.6263-2-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240624203341.6263-2-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3923:EE_
X-MS-Office365-Filtering-Correlation-Id: 3542cf81-a1ad-4f2e-6c25-08dc952b71d6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzI0MHBQM0xROVk1Y3hnWWZxRzlWK25FOWpCMzcxeDdrbHZRNUR5MzVVaFNJ?=
 =?utf-8?B?NHYyZGZyNGZZVTZQN1o3eHlIZU5ud1JlY3N1NjhBRDY2dWVyZEg5N1hjZ3B1?=
 =?utf-8?B?aXVseUNDUmhVdkZrZTFuTHp0RFJMb0YzTzZRSnREWmlRVnhZTDFPV2ZHd2JM?=
 =?utf-8?B?cU9CZWJGN2hBNk9GNk8vL0gwTVNRN3c4N1hOWlp4cVRmUngwc1dvNmVETUR5?=
 =?utf-8?B?bUI5M2VPZDdlWmY1MEpnNU1HVVhjVC96MytLM1hEeTE2encxVkdXWExzamZP?=
 =?utf-8?B?bHByazNCeTVlcUlZVGZvSmQrd1JVZ21Xa0ZzZk5MZXFvZ3ExVUlEeVlTb3Rz?=
 =?utf-8?B?YjVRdnorRWdJSDg2bmNjRUZoK1JOK0hsdmdQVEtxSGRLQ1hjWkQzMFJ4ZTFM?=
 =?utf-8?B?Ylg2MEgxZjd2V280MFdQV0hJa3pMRXNtWXRZTU03N2l4UGdhWSthTmFTK0VX?=
 =?utf-8?B?Y2JCVGJ2VVZrTUVyL05LSjExWXhBazF4clhBczdHZ1FpWnhLRWp4LzJRa2Zn?=
 =?utf-8?B?VGo3RCt2bWxpd0Q3YlViSVUrVGdHTXdmNXBnRUhCcnNBY29NQjVjbDNRYXB6?=
 =?utf-8?B?a3N3bzBSYVpFMjhYYlZRODhsWVdOL1B2OThzam5rUy9LTXlHSFJId0laTXFw?=
 =?utf-8?B?NXlpZnZSN3A1bEwwdHRBRTJGQTQ0MFE5RU94dkw2SGd5YlB2S1dVMm9CR1VW?=
 =?utf-8?B?SnNYMWJxMy9ra3hBYTdWR3pNU09tNk9VUVlzYmhabit3TnBvakJwRUlVQnEr?=
 =?utf-8?B?WE5NR2hUVUdhcFVLMVV6QktXTlllWU1NamdNZnZ5SEVCK1Q1Q3ZJZXhSVVBS?=
 =?utf-8?B?bVhENitUcERxTy81WHkzZ1dDWXFjUytTL0o0WVBGYnAvR0drb0drdy9rcG50?=
 =?utf-8?B?UVRVeDdWdGhrUTF3UG1Mek9GaG9lVTlSOXJ3Z1IwY0VFdEIzT3A0dDNLaVpj?=
 =?utf-8?B?Qk8wcW5lS0FETnVJL3JHWWZVUjVBY3BwL1p0dTFNNTJrSWxCNkltSXFHNDk3?=
 =?utf-8?B?anNtZ2F0MW00cWRGMkR3eFZ2NFQ4NzhWMzRDZTJVNlhQVU13VXpBOHFtenZV?=
 =?utf-8?B?anVzL3J2QU5paFhjdkFFMWY2VUpOOUtHakg0dU9PYWdwZ2RIeEZwSkR5ZVJh?=
 =?utf-8?B?c0NkYUVmdmVKMmF6TVV4OEVlTFZCSTJtcGFDczZXQmQ3N01qK0g5TlJ0VVl4?=
 =?utf-8?B?K2hIazJtSDYyWGFBUGlIaXRZMHpwSFZMVU40YzBsdEtQMTgvUnpONTh2WmYz?=
 =?utf-8?B?eG5kYjZNSXlrM3NZU1p2ZmIycTdvcWlRRE9BWGtac3AvOFYyRm5DbTJBbHdO?=
 =?utf-8?B?SWx2T3NTR3VaTDk4QjlzVUVhMlNEd0V3aFJZMGJabmRCTlArVm1yWkdub0lR?=
 =?utf-8?B?RmxNVFo4cEFNS2trMnViSkNqcXUzWEQ3VmZ3MlZPcEI0VTFFMDdnMTFlRE9L?=
 =?utf-8?B?V25zUWdSUk5NdmFKTGZjZEJXWnA1SStjRVhVWHBVL3pITitPZkR6VFRUOTNB?=
 =?utf-8?B?bGc4Zzk3bmhzeFNXVHVNRjU0bVBuNHdXMGwySDZLc1VqbWdUdUtaeUwvdmZq?=
 =?utf-8?B?WWFrbzJDUXdLc2NZS0hwTUdGcUkvUnF4MU15NDFvN0lXR3BvSW5zUG1aTU9D?=
 =?utf-8?B?Njh1MU5CeXBzRTIrZGtDR25YZEFMUWpTN0FaTXQxMFgwaWFnbmdSekZNSmFE?=
 =?utf-8?B?R1BOUytiWllRNGo5ZEw3dEFUbTJJdFNVL3B6YXFocDBsZmhOclNlTEFtY1Jv?=
 =?utf-8?B?Qzg1ZGs2MHBiTUtacm0xc0JyL2xiY3JxYXUrYjRSSGtHTm82b2xMOU0xTDE2?=
 =?utf-8?B?Vnkwd1ZmQ2t4dm4zSjZ1Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXovVE5XR1FDUC8xZTI2MHRXRmMxMVoxTEZycUhvbHI5RmgwSHhzd1VIUGxN?=
 =?utf-8?B?cTJQUFhZSWxveWRmZlhHT3p6WHJLNHcreXlleVMyYjdIdzR2aFVhM3NlRGdC?=
 =?utf-8?B?ei81ODN1Smg3RDdvcGVycjM3ODN0ODViNWRUZXBFbW9MSkkzZ3hZcERObVhS?=
 =?utf-8?B?VlU5eEdFUEpQOW45MjdnTzZjNXF1SS9uRTlOR2p3K0RlYmQxQk54blF0Sjhy?=
 =?utf-8?B?WEpBRGlRVEorbUFEOW1tQXhtS0ZRc1hGR3RybDRwY0M5blFiZXkxNlhwMGRp?=
 =?utf-8?B?U0pLTjlFWTFYODlteERNUUxFVys1MkJoTVRJb1NSb1piaU4zOFJjUENJVHo4?=
 =?utf-8?B?MkpSdklFUlV1ZFlGMnBLWXhHVWhDSXYxbUh2OXAvS2xNbGVLRU5kUEVRWC9O?=
 =?utf-8?B?Slh2dG9VVmRUWXh6eVpMSDkraFNKcnNsdTdzZ0YrNnExTFJ5VEUvUlBZMzZL?=
 =?utf-8?B?RkxVTnMxSWVMaU5OcndmcW5lelR0UmVIU0FFL2s2RFA2c1JQRmRJWWxta0E0?=
 =?utf-8?B?OTJxVUFHT0NrSi9JYXBNUGtVRFYyYXBBSFBoT1hBZVFZNzRPaWxHWFc5Q0VK?=
 =?utf-8?B?c1VDejBRTGVxSVFyVENaZFdMdjFUYXdPV2dCQ0xzM29wYjJmWm9Idk1UOEph?=
 =?utf-8?B?aHF2N3VvRjJRTm1xdVNrNGtkYXpLTFVIV2owWS9lSDhwY1BWcEZOUU90dFFR?=
 =?utf-8?B?YmkxY1JuL3lnMGlTaWdGTUM3NWs4amkrLy9JT1AxK1lqdVhRb0xoamswOXAw?=
 =?utf-8?B?dlVsdm9IM25xN0F3enZzWXdSc0h6dWsvUHh3MlAxek5LdStTNUZWYSsyd3lD?=
 =?utf-8?B?RWFFcDJleUtaYTRsUDcvYXJUN3lhTUplZjlja0VoaTVrOEJkcVllcEQ5TEtO?=
 =?utf-8?B?dzdLd3hNaklhVDE0SGFwVjZybXdvbkwwK0l6aEsxRVlBRy83SkIxUitvSVB0?=
 =?utf-8?B?aDhqQ3FRNVA3QURvYk5Na1dxL3d2MkxrOXhLOFhzRFd0OU9NTk1oaW5BK0ww?=
 =?utf-8?B?RlJWend1SGZyeHFWSlJMdmJjVnRpZjZ4U2ZDNmdOc0YxSmY0UWd0TUJvbE94?=
 =?utf-8?B?dkZEUUdjZjBpMlJGRVlpNi9DOHJLNzh3Nko2NTlwM05BWnFsc0VXVEM0UVVm?=
 =?utf-8?B?akQzUmt3L3p4YnZOZFhoN0tzZy9TUWRJV0ZFVFVtc3RMVnJwcis2YVd3WHZ2?=
 =?utf-8?B?VzZaK2M5MEJRMGNuZFBaL0FFcm5vT1k3QjIrbktTa0xwV0ZJbWR1TGllSlhN?=
 =?utf-8?B?MnMzU1l5RE1LM011SE5kblNaNlhQVVlGWWc2YU1PWHozSTRLZGRiZWlVcW1Q?=
 =?utf-8?B?dXliT01KR094TTJvZ3lQOE5TbDdUakJvdzExaFpNMms4SFVHVXgxTGpNd012?=
 =?utf-8?B?M0xZNXlFc21KWGFSRE05TWM3b1BTbzM5Q1I2b25NVXpOTjc5ajJ6RjcxVm9o?=
 =?utf-8?B?Z3Bma3p6SWlRNFdIUjk0MWVVYXM3OE9yWjhQenZHUWp1SWhneUpqdlpLSGJl?=
 =?utf-8?B?akY3SFFnWi9WNTJ2STFzOFQ4elhzK2VrZXZyTVJ6OHo4STVtL0ZVVWhka2sx?=
 =?utf-8?B?d3RnTG9XbGJWUHk3aTNQdzBueTEwRTlKek1oVDJGaG1IUzlJcnJpNFFvUkFo?=
 =?utf-8?B?czZCZVJuYXpjNllKM1NHSDRkY1dMRzI4OTlUUE81UUV0S3E1Ujc5d1J3L1k4?=
 =?utf-8?B?RkVDR01pL3MwZzVIYms5SzRJeThVb3BEa0pEVVNieDJFUW9WMFBlakltUGpL?=
 =?utf-8?B?d0pIWDcwaTZxdUFoQWNjNDV3SjVHSmZlZ3h6d0MrV0Z2WjNsSWpoWGoxRi9N?=
 =?utf-8?B?a2NwQU5BWUpjOURaWTlNYSsyKzd0ZzdVdnJLTDhxVVY3Ymkvamp0enVxeU1E?=
 =?utf-8?B?NVUwV0VYaGJsVW5YSVhXVy9zQ00zWlVDTnVnK29PMHZGNDRncVpZeEVRUmFF?=
 =?utf-8?B?dG1QZ2tFYWVQaEtkZzUyNFJkSm1ZOHh1c2ZkNi9LY0g0aUtCdEFuNWtubU5U?=
 =?utf-8?B?SUV4WW1JYkwxajU0c1loQXFLeUlvMXhyb0tMRGdDZHdmbDkyQytpTXVuTThY?=
 =?utf-8?B?OCtiM2wwc254OG1Janl1VktBZm83a2o3QVRSTXdXRnhySTJKbWZVQlBmQUVF?=
 =?utf-8?B?UDNvNDFLTWFrdjNxWGlQS0xRS2Vhamx6YXA4NDBqcEU4OERwSURMNjZyOGl4?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3542cf81-a1ad-4f2e-6c25-08dc952b71d6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 15:28:20.7068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UK4uxBs2eXLCNaBSvmpQYQcMdqORJ9r8P15bXynr+Muwes2gRiQhtarU4o3M/LHaqCq6UAdLZ1P2dispapT5Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3923

On 24.06.24 22:33, Richard Weinberger wrote:
> Currently the script used a mix of spaces of various lengths and tabs.
> Let's use tabs everywhere.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  scripts/prepare-kernel.sh | 510 +++++++++++++++++++-------------------
>  1 file changed, 253 insertions(+), 257 deletions(-)
> 
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index faf3e7235..9299aaa97 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -29,112 +29,110 @@ patch_architecture_filter="b"
>  linux_tree=.
>  
>  patch_copytempfile() {
> -    file="$1"
> -    if ! test -f "$temp_tree/$file"; then
> -        subdir=`dirname "$file"`
> -        mkdir -p "$temp_tree/$subdir"
> -        cp "$linux_tree/$file" "$temp_tree/$file"
> -    fi
> +	file="$1"
> +	if ! test -f "$temp_tree/$file"; then
> +		subdir=`dirname "$file"`
> +		mkdir -p "$temp_tree/$subdir"
> +		cp "$linux_tree/$file" "$temp_tree/$file"
> +	fi
>  }
>  
>  check_filter() {
> -    if test "$patch_kernelversion_specific" != "$patch_kernelversion_filter" \
> -        -a "$patch_architecture_specific" != "$patch_architecture_filter"; then
> -        echo ok
> -    elif test -e "$temp_tree/$1"; then
> -        echo "$me: inconsistent multiple changes to $1 in Linux kernel tree" >&2
> -	echo error
> -    else
> -        echo ignore
> -    fi
> +	if test "$patch_kernelversion_specific" != "$patch_kernelversion_filter" \
> +		-a "$patch_architecture_specific" != "$patch_architecture_filter"; then
> +		echo ok
> +	elif test -e "$temp_tree/$1"; then
> +		echo "$me: inconsistent multiple changes to $1 in Linux kernel tree" >&2
> +		echo error
> +	else
> +		echo ignore
> +	fi
>  }
>  
>  patch_append() {
> -    file="$1"
> -    if test "x$output_patch" = "x"; then
> -	if test -L "$linux_tree/$file" ; then
> -	    mv "$linux_tree/$file" "$linux_tree/$file.orig"
> -	    cp "$linux_tree/$file.orig" "$linux_tree/$file"
> +	file="$1"
> +	if test "x$output_patch" = "x"; then
> +		if test -L "$linux_tree/$file" ; then
> +			mv "$linux_tree/$file" "$linux_tree/$file.orig"
> +			cp "$linux_tree/$file.orig" "$linux_tree/$file"
> +		fi
> +		chmod +w "$linux_tree/$file"
> +		cat >> "$linux_tree/$file"
> +	else
> +		if test `check_filter $file` = "ok"; then
> +			patch_copytempfile "$file"
> +			cat >> "$temp_tree/$file"
> +		fi
>  	fi
> -	chmod +w "$linux_tree/$file"
> -        cat >> "$linux_tree/$file"
> -    else
> -        if test `check_filter $file` = "ok"; then
> -            patch_copytempfile "$file"
> -            cat >> "$temp_tree/$file"
> -        fi
> -    fi
>  }
>  
>  patch_link() {
> -    recursive="$1"         # "r" or "n"
> -    link_file="$2"         # "m", "n" or some file (basename) from $target_dir
> -    target_dir="$3"
> -    link_dir="$4"
> -
> -    (
> -        if test \! \( x$link_file = xm -o x$link_file = xn \); then
> -	   find_clean_opt="-name $link_file"
> -	   find_link_opt=$find_clean_opt
> +	recursive="$1"		   # "r" or "n"
> +	link_file="$2"		   # "m", "n" or some file (basename) from $target_dir
> +	target_dir="$3"
> +	link_dir="$4"
> +
> +	(
> +	if test \! \( x$link_file = xm -o x$link_file = xn \); then
> +		find_clean_opt="-name $link_file"
> +		find_link_opt=$find_clean_opt
>  	else
> -           link_makefiles_opt=""
> -           if test x$link_file = xm; then
> -              link_makefiles_opt="-name Makefile -o"
> -           fi
> -           if test x$recursive = xr; then
> -	       recursive_opt="-mindepth 1"
> -	       dir_opt="-type d -o"
> -           else
> -	       recursive_opt="-maxdepth 1"
> -	       dir_opt=""
> -           fi
> -	   find_clean_opt="$recursive_opt \( $dir_opt $link_makefiles_opt -name Kconfig -o -name '*.[chS]' -o -name '*.sh' \)"
> -	   find_link_opt="$recursive_opt \( $link_makefiles_opt -name Kconfig -o -name '*.[chS]' -o -name '*.sh' \)"
> +		link_makefiles_opt=""
> +		if test x$link_file = xm; then
> +			link_makefiles_opt="-name Makefile -o"
> +		fi
> +		if test x$recursive = xr; then
> +			recursive_opt="-mindepth 1"
> +			dir_opt="-type d -o"
> +		else
> +			recursive_opt="-maxdepth 1"
> +			dir_opt=""
> +		fi
> +		find_clean_opt="$recursive_opt \( $dir_opt $link_makefiles_opt -name Kconfig -o -name '*.[chS]' -o -name '*.sh' \)"
> +		find_link_opt="$recursive_opt \( $link_makefiles_opt -name Kconfig -o -name '*.[chS]' -o -name '*.sh' \)"
>  	fi
>  
> -        if test "x$output_patch" = "x" -a -e $linux_tree/$link_dir; then
> -            cd $linux_tree/$link_dir &&
> -	    eval find . $find_clean_opt |
> -	    while read f; do
> -                if test -L $f -a ! -e $xenomai_root/$target_dir/$f; then rm -Rf $f; fi
> -            done
> -        fi
> -
> -        cd $xenomai_root/$target_dir &&
> -        eval find . $find_link_opt |
> -        while read f; do
> -            f=`echo $f | cut -d/ -f2-`
> -            d=`dirname $f`
> -            if test "x$output_patch" = "x"; then
> -                mkdir -p $linux_tree/$link_dir/$d
> -                if test x$forcelink = x1 -o \
> -		   ! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
> -		then
> -                    ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
> -                fi
> -            else
> -                if test `check_filter $link_dir/$f` = "ok"; then
> -                    if test -e $linux_tree/$link_dir/$f; then
> -                        echo "$me: warning: $link_dir/$f already present in Linux kernel tree, output patch might be defective" >&2
> -                    fi
> -                    mkdir -p $temp_tree/$link_dir/$d
> -                    cp $xenomai_root/$target_dir/$f $temp_tree/$link_dir/$f
> -                fi
> -            fi
> -        done
> -    )
> +	if test "x$output_patch" = "x" -a -e $linux_tree/$link_dir; then
> +		cd $linux_tree/$link_dir && eval find . $find_clean_opt | while read f; do
> +			if test -L $f -a ! -e $xenomai_root/$target_dir/$f; then rm -Rf $f; fi
> +		done
> +	fi
> +
> +	cd $xenomai_root/$target_dir &&
> +	eval find . $find_link_opt |
> +	while read f; do
> +		f=`echo $f | cut -d/ -f2-`
> +		d=`dirname $f`
> +		if test "x$output_patch" = "x"; then
> +			mkdir -p $linux_tree/$link_dir/$d
> +			if test x$forcelink = x1 -o \
> +				! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
> +			then
> +				ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
> +			fi
> +		else
> +			if test `check_filter $link_dir/$f` = "ok"; then
> +				if test -e $linux_tree/$link_dir/$f; then
> +					echo "$me: warning: $link_dir/$f already present in Linux kernel tree, output patch might be defective" >&2
> +				fi
> +				mkdir -p $temp_tree/$link_dir/$d
> +				cp $xenomai_root/$target_dir/$f $temp_tree/$link_dir/$f
> +			fi
> +		fi
> +	done
> +	)
>  }
>  
>  generate_patch() {
> -    (
> -    cd "$temp_tree"
> -    find . -type f |
> -    while read f; do
> -        diff -Naurd "$linux_tree/$f" "$f" |
> -        sed -e "s,^--- ${linux_tree}/\.\(/.*\)$,--- linux\1," \
> -            -e "s,^+++ \.\(/.*\)$,+++ linux-patched\1,"
> -    done
> -    )
> +	(
> +	cd "$temp_tree"
> +	find . -type f |
> +	while read f; do
> +		diff -Naurd "$linux_tree/$f" "$f" |
> +		sed -e "s,^--- ${linux_tree}/\.\(/.*\)$,--- linux\1," \
> +			-e "s,^+++ \.\(/.*\)$,+++ linux-patched\1,"
> +	done
> +	)
>  }
>  
>  
> @@ -142,49 +140,49 @@ usage='usage: prepare-kernel --linux=<linux-tree> [--dovetail=<dovetail-patch>]
>  me=`basename $0`
>  
>  while test $# -gt 0; do
> -    case "$1" in
> -    --linux=*)
> -	linux_tree=`echo $1|sed -e 's,^--linux=\\(.*\\)$,\\1,g'`
> -	linux_tree=`eval "echo $linux_tree"`
> +	case "$1" in
> +	--linux=*)
> +		linux_tree=`echo $1|sed -e 's,^--linux=\\(.*\\)$,\\1,g'`
> +		linux_tree=`eval "echo $linux_tree"`
>  	;;
> -    --dovetail=*)
> -	pipeline_patch=`echo $1|sed -e 's,^--dovetail=\\(.*\\)$,\\1,g'`
> -	pipeline_patch=`eval "echo $pipeline_patch"`
> -	probe_header=include/linux/dovetail.h
> -	arch_probe_header=include/asm/dovetail.h
> +	--dovetail=*)
> +		pipeline_patch=`echo $1|sed -e 's,^--dovetail=\\(.*\\)$,\\1,g'`
> +		pipeline_patch=`eval "echo $pipeline_patch"`
> +		probe_header=include/linux/dovetail.h
> +		arch_probe_header=include/asm/dovetail.h
>  	;;
> -    --arch=*)
> -	linux_arch=`echo $1|sed -e 's,^--arch=\\(.*\\)$,\\1,g'`
> +	--arch=*)
> +		linux_arch=`echo $1|sed -e 's,^--arch=\\(.*\\)$,\\1,g'`
>  	;;
> -    --outpatch=*)
> -	output_patch=`echo $1|sed -e 's,^--outpatch=\\(.*\\)$,\\1,g'`
> +	--outpatch=*)
> +		output_patch=`echo $1|sed -e 's,^--outpatch=\\(.*\\)$,\\1,g'`
>  	;;
> -    --filterkvers=*)
> -        patch_kernelversion_filter=`echo $1|sed -e 's,^--filterkvers=\\(.*\\)$,\\1,g'`
> -        ;;
> -    --filterarch=*)
> -        patch_architecture_filter=`echo $1|sed -e 's,^--filterarch=\\(.*\\)$,\\1,g'`
> -        ;;
> -    --forcelink)
> -        forcelink=1
> -        ;;
> -    --default)
> -        usedefault=1
> -        ;;
> -    --verbose)
> -	verbose=1
> +	--filterkvers=*)
> +		patch_kernelversion_filter=`echo $1|sed -e 's,^--filterkvers=\\(.*\\)$,\\1,g'`
> +		;;
> +	--filterarch=*)
> +		patch_architecture_filter=`echo $1|sed -e 's,^--filterarch=\\(.*\\)$,\\1,g'`
> +		;;
> +	--forcelink)
> +		forcelink=1
> +		;;
> +	--default)
> +		usedefault=1
> +		;;
> +	--verbose)
> +		verbose=1
>  	;;
> -    --help)
> -	echo "$usage"
> -	exit 0
> +	--help)
> +		echo "$usage"
> +		exit 0
>  	;;
> -    *)
> -	echo "$me: unknown flag: $1" >&2
> -	echo "$usage" >&2
> -	exit 1
> +	*)
> +		echo "$me: unknown flag: $1" >&2
> +		echo "$usage" >&2
> +		exit 1
>  	;;
> -    esac
> -    shift
> +	esac
> +	shift
>  done
>  
>  # Infere the location of the Xenomai source tree from
> @@ -199,87 +197,86 @@ xenomai_root=`cd $xenomai_root && pwd`
>  default_linux_tree=/lib/modules/`uname -r`/source
>  
>  while test x$linux_tree = x; do
> -   if test x$usedefault = x; then
> -      echo -n "Linux tree [default $default_linux_tree]: "
> -      read linux_tree
> -   fi
> -   if test x$linux_tree = x; then
> -      linux_tree=$default_linux_tree
> -   fi
> -   if test \! -x "$linux_tree"; then
> -      echo "$me: cannot access Linux tree in $linux_tree"
> -      linux_tree=
> -      usedefault=
> -      default_linux_tree=/usr/src
> -   else
> -      break
> -   fi
> +	if test x$usedefault = x; then
> +		echo -n "Linux tree [default $default_linux_tree]: "
> +		read linux_tree
> +	fi
> +	if test x$linux_tree = x; then
> +		linux_tree=$default_linux_tree
> +	fi
> +	if test \! -x "$linux_tree"; then
> +		echo "$me: cannot access Linux tree in $linux_tree"
> +		linux_tree=
> +		usedefault=
> +		default_linux_tree=/usr/src
> +	else
> +		break
> +	fi
>  done
>  
>  linux_tree=`cd $linux_tree && pwd`
>  
>  if test \! -r $linux_tree/Makefile; then
> -   echo "$me: $linux_tree is not a valid Linux kernel tree" >&2
> -   exit 2
> +	echo "$me: $linux_tree is not a valid Linux kernel tree" >&2
> +	exit 2
>  fi
>  
>  # Create an empty output patch file, and initialize the temporary tree.
>  if test "x$output_patch" != "x"; then
> +	temp_tree=`mktemp -d prepare-kernel-XXX --tmpdir`
> +	if [ $? -ne 0 ]; then
> +		echo Temporary directory could not be created.
> +		exit 1
> +	fi
>  
> -    temp_tree=`mktemp -d prepare-kernel-XXX --tmpdir`
> -    if [ $? -ne 0 ]; then
> -	echo Temporary directory could not be created.
> -	exit 1
> -    fi
> -
> -    patchdir=`dirname $output_patch`
> -    patchdir=`cd $patchdir && pwd`
> -    output_patch=$patchdir/`basename $output_patch`
> -    echo > "$output_patch"
> +	patchdir=`dirname $output_patch`
> +	patchdir=`cd $patchdir && pwd`
> +	output_patch=$patchdir/`basename $output_patch`
> +	echo > "$output_patch"
>  
>  fi
>  
>  # Infer the default architecture if unspecified.
>  
>  if test x$linux_arch = x; then
> -   build_arch=`$xenomai_root/config/config.guess`
> -   default_linux_arch=`echo $build_arch|cut -f1 -d-`
> +	build_arch=`$xenomai_root/config/config.guess`
> +	default_linux_arch=`echo $build_arch|cut -f1 -d-`
>  fi
>  
>  while : ; do
> -   if test x$linux_arch = x; then
> -      if test x$usedefault = x; then
> -         echo -n "Target architecture [default $default_linux_arch]: "
> -         read linux_arch
> -      fi
> -      if test "x$linux_arch" = x; then
> -         linux_arch=$default_linux_arch
> -      fi
> -   fi
> -   case "$linux_arch" in
> -   x86*|i*86|amd*)
> -      linux_arch=x86
> -      ;;
> -   arm)
> -      linux_arch=arm
> -      ;;
> -   arm64|aarch64)
> -      linux_arch=arm64
> -      ;;
> -   *)
> -      echo "$me: unsupported architecture: $linux_arch" >&2
> -      linux_arch=
> -      usedefault=
> -      ;;
> -   esac
> -   if test \! x$linux_arch = x; then
> -      break
> -   fi
> +	if test x$linux_arch = x; then
> +		if test x$usedefault = x; then
> +			echo -n "Target architecture [default $default_linux_arch]: "
> +			read linux_arch
> +		fi
> +		if test "x$linux_arch" = x; then
> +			linux_arch=$default_linux_arch
> +		fi
> +	fi
> +	case "$linux_arch" in
> +		x86*|i*86|amd*)
> +		linux_arch=x86
> +	;;
> +	arm)
> +		linux_arch=arm
> +	;;
> +	arm64|aarch64)
> +		linux_arch=arm64
> +	;;
> +	*)
> +		echo "$me: unsupported architecture: $linux_arch" >&2
> +		linux_arch=
> +		usedefault=
> +	;;
> +	esac
> +	if test \! x$linux_arch = x; then
> +		break
> +	fi
>  done
>  
> -foo=`grep '^KERNELSRC    := ' $linux_tree/Makefile | cut -d= -f2`
> +foo=`grep '^KERNELSRC	 := ' $linux_tree/Makefile | cut -d= -f2`
>  if [ ! -z $foo ] ; then
> -    linux_tree=$foo
> +	linux_tree=$foo
>  fi
>  unset foo
>  
> @@ -291,101 +288,100 @@ eval linux_`grep '^VERSION =' $linux_tree/Makefile | sed -e 's, ,,g'`
>  linux_version="$linux_VERSION.$linux_PATCHLEVEL.$linux_SUBLEVEL"
>  
>  if test x$verbose = x1; then
> -echo "Preparing kernel $linux_version$linux_EXTRAVERSION in $linux_tree..."
> +	echo "Preparing kernel $linux_version$linux_EXTRAVERSION in $linux_tree..."
>  fi
>  
>  if test -r $linux_tree/$probe_header; then
> -    if test x$verbose = x1; then
> -       echo "IRQ pipeline found - bypassing patch."
> -    fi
> +	if test x$verbose = x1; then
> +		echo "IRQ pipeline found - bypassing patch."
> +	fi
>  else
> -   if test x$verbose = x1; then
> -      echo "$me: no IRQ pipeline support found." >&2
> -   fi
> -   while test x$pipeline_patch = x; do
> -      echo -n "IRQ pipeline patch: "
> -      read pipeline_patch
> -      if test \! -r "$pipeline_patch" -o x$pipeline_patch = x; then
> -         echo "$me: cannot read IRQ pipeline support from $pipeline_patch" >&2
> -         pipeline_patch=
> -      fi
> -   done
> -   patchdir=`dirname $pipeline_patch`;
> -   patchdir=`cd $patchdir && pwd`
> -   pipeline_patch=$patchdir/`basename $pipeline_patch`
> -   curdir=$PWD
> -   cd $linux_tree && patch --dry-run -p1 -f < $pipeline_patch || {
> -        cd $curdir;
> -        echo "$me: Unable to patch kernel $linux_version$linux_EXTRAVERSION with `basename $pipeline_patch`." >&2
> -        exit 2;
> -   }
> -   patch -p1 -f -s < $pipeline_patch
> -   cd $curdir
> +	if test x$verbose = x1; then
> +		echo "$me: no IRQ pipeline support found." >&2
> +	fi
> +	while test x$pipeline_patch = x; do
> +		echo -n "IRQ pipeline patch: "
> +		read pipeline_patch
> +		if test \! -r "$pipeline_patch" -o x$pipeline_patch = x; then
> +			echo "$me: cannot read IRQ pipeline support from $pipeline_patch" >&2
> +			pipeline_patch=
> +		fi
> +	done
> +	patchdir=`dirname $pipeline_patch`;
> +	patchdir=`cd $patchdir && pwd`
> +	pipeline_patch=$patchdir/`basename $pipeline_patch`
> +	curdir=$PWD
> +	cd $linux_tree && patch --dry-run -p1 -f < $pipeline_patch || {
> +		cd $curdir;
> +		echo "$me: Unable to patch kernel $linux_version$linux_EXTRAVERSION with `basename $pipeline_patch`." >&2
> +		exit 2;
> +	}
> +	patch -p1 -f -s < $pipeline_patch
> +	cd $curdir
>  fi
>  
>  if test \! -r $linux_tree/arch/$linux_arch/$arch_probe_header; then
> -   echo "$me: $linux_tree has no IRQ pipeline support for $linux_arch" >&2
> -   exit 2
> +	echo "$me: $linux_tree has no IRQ pipeline support for $linux_arch" >&2
> +	exit 2
>  fi
>  
>  if test x$verbose = x1; then
> -   echo "IRQ pipeline installed."
> +	echo "IRQ pipeline installed."
>  fi
>  
>  patch_kernelversion_specific="y"
>  
>  case $linux_VERSION.$linux_PATCHLEVEL in
>  
> -    2.*)
> +	2.*)
>  
> -    echo "$me: Unsupported kernel version $linux_VERSION.$linux_PATCHLEVEL.x" >&2
> -    exit 2
> -    ;;
> +	echo "$me: Unsupported kernel version $linux_VERSION.$linux_PATCHLEVEL.x" >&2
> +	exit 2
> +	;;
>  
> -    *)
> +	*)
>  
> -    patch_architecture_specific="y"
> +	patch_architecture_specific="y"
>  
> -    if ! grep -q XENOMAI $linux_tree/init/Kconfig; then
> -	version_stamp=`cat $xenomai_root/config/version-code`
> -	version_major=`expr $version_stamp : '\([[0-9]]*\)' || true`
> -	version_minor=`expr $version_stamp : '[[0-9]]*\.\([[0-9]*]*\)' || true`
> -	revision_level=`expr $version_stamp : '[[0-9]]*\.[[0-9]*]*\.\([[0-9]*]*\)' || true`
> +	if ! grep -q XENOMAI $linux_tree/init/Kconfig; then
> +		version_stamp=`cat $xenomai_root/config/version-code`
> +		version_major=`expr $version_stamp : '\([[0-9]]*\)' || true`
> +		version_minor=`expr $version_stamp : '[[0-9]]*\.\([[0-9]*]*\)' || true`
> +		revision_level=`expr $version_stamp : '[[0-9]]*\.[[0-9]*]*\.\([[0-9]*]*\)' || true`
>  	if [ -z "$revision_level" ]; then
> -	    revision_level=0
> +		revision_level=0
>  	fi
>  	version_string=`cat $xenomai_root/config/version-label`
>  	sed -e "s,@VERSION_MAJOR@,$version_major,g" \
> -	    -e "s,@VERSION_MINOR@,$version_minor,g" \
> -	    -e "s,@REVISION_LEVEL@,$revision_level,g" \
> -	    -e "s,@VERSION_STRING@,$version_string,g" \
> -	    -e "s,@SRCARCH@,$linux_arch,g" \
> -	    $xenomai_root/scripts/Kconfig.frag |
> -            patch_append init/Kconfig
> -    fi
> +		-e "s,@VERSION_MINOR@,$version_minor,g" \
> +		-e "s,@REVISION_LEVEL@,$revision_level,g" \
> +		-e "s,@VERSION_STRING@,$version_string,g" \
> +		-e "s,@SRCARCH@,$linux_arch,g" \
> +		$xenomai_root/scripts/Kconfig.frag |
> +		patch_append init/Kconfig
> +	fi

This leaves the two if-blocks improperly indented behind (noticed
because the next patch fails to cover it properly as well).

I'm trying to fix up while merging.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

