Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012001.outbound.protection.outlook.com [52.101.66.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE01233CEA7
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591318; cv=fail; b=jMLc2U7pdqS9+1mOkweNBn3D6Xbl3CX1XvzKhogsUkvav0PdaVgUyD6eBzw8ro+LKkMO1oqETla59bjwNCnp/W5E0H2M5tUfXCMtkrs7Czkg4t7g+pO3lYLxV4XSrw5U88OxkY9nvTBLXbvNtzHqvE5YPSjV23k1fN8jEQ8Xx8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591318; c=relaxed/simple;
	bh=q1eiUq+zDCQWL8RzecZ92I45cPw6U9DoDrllNccvf0M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WYHAtHzR0aW1ZOnbKluVXnfO/qmHjXv2dJizInmO1wB46sOurBKnMxtd07MDpBvxYGnF+hIE1JE8+I6h5Fxitj0OHOjzlIMM819vyCWm043N5cV/4fVqerkMliheUVuH9aL2zw+p7HbGdk+eB4wdUVu+dPo/aNmgo1xgud5Xvo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=MJNXI1JI; arc=fail smtp.client-ip=52.101.66.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="MJNXI1JI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRCl6/D1htqy95ep0jTv939iQIDs3Mpd+wlBcO2ythiSXz4+1iRjtTh4DkOhI9g5c179olz79Lr4sxgG2D52o0Fdv8FRby9ltZlBDAbsG5JFhFnI5ZuD/nT2LjBwf+ryF5q1EK2kgL+RVt64960q+xZN3XzmvQgeW26DYgrpi9Jj/ZZFVgP03AhBgUwDAIsj10frPPcH1/lOHrwt1YX0eBayPNtNESPJgLF3whIUVNe/cmgE0VieuymKshvrRxv62b0BzQzXbiltuR9Iu03nF1xK/TsZFL1g74TnVpCNrxEDyFJ46zdEVjY6RrT9A83KwyOxWoymj+K6/uZpCY5kyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bj9RzVTP53cuw08iFFMpIzgouiQmtJR1fVwdSPp9fNg=;
 b=LvJAfgafLD3InFiCv5vircFdkDLlwv4x+RvmI6UB/uiQNE0E58prIZ+hUVMfON4xB5LLn6VuzF1TBZOmd/bZDkQ0ecqQkMinr5A6rzYBnZsq+q5dSwxl9dt9i3FtcCXlKn+Zgzm3NeCT94QaELj7VJaGYhzGfdeFfvEGeKDtdR2A+3Bcq4CXix+k0B5DlbdwKuE7yhDnb/sQcy1aiPs8uWYCALeOoIKp7dWH3CVYTbZxcVkdunpawQX3FG6HEXxzfnPYdNrY1FryTa1RUsFaCsh0QEHCQdX0dnlXprwAfVpKHsV1NY9q6P9FdrCHQmQ+Lj2NczZfj8/8WrUsDatfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bj9RzVTP53cuw08iFFMpIzgouiQmtJR1fVwdSPp9fNg=;
 b=MJNXI1JI80OKD8Rb8kpu+rxicogMC+xIcpU63jBCGocOZJ2+BOBJNVCkO7q9khExxQ02ZPXXiFiF7zXHyI9E/6haxlQyvMTlDyLhvlvApbDweyaArtpKmYBrrmt/GtU0fQM0qOgBVmZETo6Wzs0uKa3iDg6zk25Vx8CUN2h5NzLND2PSpZo1yO+6oBXL69z5R05urLJGdyxKtV/z2fi5P2YfcY4bCrHSc5KD0c2EdG7eFu4/DJOioBqEGnV4n1I+OqKeaKAkNICTlkdequ1com1ctvxYwlN6MSrXJoOjZZWIr0y+omtlqeRrUzqLAwEmulyMRSqUJN24MqNqkffiVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9799.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 13:08:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 13:08:33 +0000
Message-ID: <dfb6996f-1afc-4526-8b47-5972bccb2c39@siemens.com>
Date: Tue, 12 May 2026 15:08:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add build time guard to detect off_t mismatch
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, xenomai <xenomai@lists.linux.dev>
References: <20260507122357.2463483-1-richard@nod.at>
 <945cb32c-88ea-41fa-8223-f3d1e639e9d9@siemens.com>
 <1863085876.2350.1778157171370.JavaMail.zimbra@nod.at>
 <3997a44b-0ce4-46b1-a0a2-9ddbed951b5c@siemens.com>
 <955375516.2805.1778158548523.JavaMail.zimbra@nod.at>
 <84f6c3a9-b764-4774-b048-eb8e0c7fdc99@siemens.com>
 <472857942.3063.1778163004494.JavaMail.zimbra@nod.at>
 <2961c9be-b80f-438e-95b6-a2339f14d738@siemens.com>
 <CAFLxGvzYXjy3kkZMSiOqFbHgWTOaBccg3oBtVDKbyB97fedfGw@mail.gmail.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvzYXjy3kkZMSiOqFbHgWTOaBccg3oBtVDKbyB97fedfGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:208:236::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9799:EE_
X-MS-Office365-Filtering-Correlation-Id: f640f0ad-db22-4d1f-c46b-08deb02791c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003|11063799003|55112099003;
X-Microsoft-Antispam-Message-Info:
	HlvZObxe3uKfqj9GTWso0foFbOqmZfJvej+WFVRVNvy/+GIp5LgHEP8WfSgAtKeN/VdkuIWD8wCfKo51z3anXmH04p5fiiCXpFiK11vIQgxL5lF4N9JnRupB+In56ixcwHW+E3BeRfZz0rYWYN5e3FV2jYs68wONt5IRcR6koug/uOQs0Gsm8rRD+rz3pSG4ymX7S0WmOKo1kruySR1NgGT1wu941lrz8RUh2qYiiquWBTSeb7rz1zTVrnmv4eW1nXwFNe/uS3sbSINWcMcNXzm68G87bycnUvMxrrFszEI9bAfeHKvWsCJkhpBsm9uW6fNofIZ/glInl7urIDhD7/kFbTKYplPBskWWV0MlyvET/GY4NJHgyoA1O/PGFaKHiFqJ22UOyAHzabeBlzZuSi2abx1bl5C6EG2rf6mhBKjwKuR5uyUpSwSVjxIxHXIgmkE/MyZrvzbRki0rcG7nNjAfq0g8brGJadO4Eb+R0FEmqh7E45azMoNeovIsMgzUMAeFF4zEitL3Fq87mSAzxhnvnyGk/Z8SGvAOePPLVjYtbc14zMiZT6kuGvU81N/BCjEWy4fSo2fvUmaq6m/rlZDW836BFeGNd4i8B8avRAp0OxeLnGO1KlsB3llrhd69Gi/NSHtIB0lhfRFH5vBdQ35mKu8Hb/6o08sRW3NC1e7FCzyvdRc47ojiGM7OzOqw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(11063799003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmRyQVBRdU0xU3dJZVRCbXpnUE43amtpOHVtZkJ4bDNyaVNvVWQrVTFlZGJH?=
 =?utf-8?B?NTlyQTZnU0FtYjNUSHY4WHhkSzZQczd3QjZpVXF2blJNaDBoZE5PN25rOUdm?=
 =?utf-8?B?NlR1SGRyT01qeTQ5dzBsaG1ZV0YyUktMTjJYRkxyd3RkdExRdi9jT0owVDNI?=
 =?utf-8?B?Zzd1MW1xN1lwcEk0ZnF4SlZwUGZ4T1dNbUdVTmI1THJSL2RCc0JDMUphMXcv?=
 =?utf-8?B?dDRMR09YSkJIRDdlbThXdWVVZHhPOEZnTzh0ank5c1haWnRjSVVjWTJSRGMr?=
 =?utf-8?B?bStxcVRVMG94b2xkc2VzVkd1YVY3N1RMNjlEdk5wdHIvdXROKzA3czBwWU5j?=
 =?utf-8?B?a3ZYQ1gxS09INnBrcGxsajlld3hvUmFCSW9IemZXMGR0SXJmOC8vb0J0OWtE?=
 =?utf-8?B?TUJ0bkNMY2hDc2xZVG9ZVXVIYVI4TEtHMVNhRnkrUzRmTVpsV3Nia250d3JJ?=
 =?utf-8?B?R2VkNkxQS3owUjBzZXBHT3Qzd2tFVWNTS2pReS9LbXpYRFJUeFdMVHUrcDU4?=
 =?utf-8?B?Z3REWHd3NU4xbWZ5Y3VhV1k1YTJwekVwbEFFWFFCK1pZK0RScG5JN1paVXYx?=
 =?utf-8?B?UFJ2blM0c013KzZyWWN0VTlnZ2Q0M3ZmQmdkVmNRcFNTZitVaUx6Y1dFU01M?=
 =?utf-8?B?MXFieExsVE1UUzZYT21xOXp4Z2Zyd0Y4YVhmQjViZTB0NWFVaXRvaVQvTm40?=
 =?utf-8?B?V3FRaDIxQTg1NWdEN0RzRnZ3eWdObVVIdmZLRUUzQzV3OC95cWcvSStKYW5K?=
 =?utf-8?B?QnNmTjJIQVlqNjlpblZuaFVKZEVWT2VGdlhMT0FIbEV5TWIwc2llenRwekY2?=
 =?utf-8?B?Q0l4c3pGQVpyQXlWWEEzd1ZTanFBbGVHUmhsOHhHQVYyMVBFTUxWblRud1FD?=
 =?utf-8?B?OW82MGZGbG5hditiQmdsaGpsMTNhUzFzT2d5cTUwYUg3V3M5MVVDQ1JBSkhF?=
 =?utf-8?B?V3hFVkNZaDhkYWhIRjdFNEF1N1A3aktZNlVnRVVieElERi80QU9QTHNmT1dT?=
 =?utf-8?B?VFRTcnBzUVd5R3VvOGZ1MHZCMzNyVjFCVU1ESFJMbnF4SHdrKy90WXo0Z3lE?=
 =?utf-8?B?amV1R1VTWDNKV0tZQWhSakwyQUFrTTRnWmQ2QVByUlJoMTkxWjB5RjB5WEYz?=
 =?utf-8?B?K2s0Um85eTVRYkdNaTV5dnc4R2w2QlEwUGNIaXJMS2s1d2piZW9DRFJHUis5?=
 =?utf-8?B?V2oyTnZVRGpFYnRtS0J0eVhtMmdaM2VjK2d4VVVjVk1BMGpMVk5qT0w2SjU2?=
 =?utf-8?B?d0IrTW5HMHZQMXpycmlCZjhWRjRYWCtibVkybm14SzRxOXhOQUlreUp4bEcw?=
 =?utf-8?B?OVdZbnFpTzZWSFRIdHhUVWtwM2lkWTZVZTJ1TGhocmpwZXFtQ2NwaW9MNDVQ?=
 =?utf-8?B?aUUrd2lWeXB3L3FseHhoQlRtVUJVTWFVS0t0cG93NUQ1OXNkTmFBWXZHVEJ5?=
 =?utf-8?B?SDF5bzZsTXh6SjNMWjJjL1pMaHdxU0t4U05tYUNSUHJZNHlMZjB6cml6eEp2?=
 =?utf-8?B?aGdYUS95N3BxYVUzTWtzRUswR0xuSXBLaHdSZkdMMldDYWpzL1YyNUFLTHc5?=
 =?utf-8?B?TS84bVlHNllTaVhNb0NadWRNT0p4dGwvUzhpaGpUZkhhdy90aEtHclhGN0Nz?=
 =?utf-8?B?Z1YwbGtOams0OTV3eGlEYnpER3JxcWpQNkExUXRMZ1dSMzRaeTRQeWRjaGY2?=
 =?utf-8?B?TGxHSFJTUGNpelNGZEhHRFQzZHJhYTNzT3lXVW55UXdrbWdyaEJ5VTdBbVBX?=
 =?utf-8?B?Q0Z4ay9JY3d4VjZnL2ZuemxpdDcveGU3NU1tWnFFY05wUS9sWTRjWXFhR2I3?=
 =?utf-8?B?UU5kR0pJTmlDNzJnNWh0VlFZc0VEeC92Y3d4elkyK1BnNDNtazBPK3lxVUR0?=
 =?utf-8?B?M1RFdEw5Nk5KcUpZZldYVCt2ejJEaUR0VGlvRXIyOVlGMitMa0ZJaUVRYVlP?=
 =?utf-8?B?MXBFSDMvWlVXWll2THkzK21jdzEzQ0RHMEJsTTlXKzRsd1RFOEM3TE5OZWYz?=
 =?utf-8?B?ZCtVbGhPWlBqaDZCUElmZU1SeStjRlNOZjc2elE0T2dXcVR5bnN0QzRGS3Bo?=
 =?utf-8?B?cDdRSTJueXdlKzNCTndDc1F2MTV6N0J1c0dvbnQvWnN1ME1nRG02TnJlUnBY?=
 =?utf-8?B?VDZtQTFhREFJK1BtN1BmL3JSZWdscXFCbytuanJ2Wm00aElCdGlvVzQ2L05U?=
 =?utf-8?B?ZUxNTXdSbXlPR09mVTJEOXlFUGg5Qk5nY1dXSU1NSC9CWDd5Mm1LMnUyd1Ey?=
 =?utf-8?B?YkN4TVU4akZndHlobjB2QS9GdXp0SVdpNEZ4bnRFbnN2Rys2b3o4UHZ4Mld2?=
 =?utf-8?B?eDZTTnB1c1IvMUQ1anFPdFZZMUF5L0kyRmRDK3NtODVjL3I3TE9jQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f640f0ad-db22-4d1f-c46b-08deb02791c0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:08:33.0759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETpk9Ug5oq7jaGVifyBN1pOzPN8/CoI1R54KFHwIvB8HnL5pWn7ouFnkTXsBptI/+YVEpr5f8vgxdvhtsbl97g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9799

On 12.05.26 15:01, Richard Weinberger wrote:
> On Thu, May 7, 2026 at 4:22 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> OK, given that Xenomai intercepts the mmap path, we could argue that
>> this is also stable relevant.
>>
>> Can you confirm that this issue is truly gone in next, whatever mode you
>> choose on both sides?
> 
> Still had no chance to build or run tests with Xenomai next on my ARM boards.
> But I had a look at the code.
> 
> I think it's still broken, at least for the following scenario:
> - 32 bit application built with  _FILE_OFFSET_BITS=64
> - 32 bit libcobalt without
> - application calls mmap() using __RT(mmap), so __cobalt_mmap() in libcobalt
> - off_t differs in size ass seen by caller and callee

A 32-bit app built with _FILE_OFFSET_BITS=64 is supposed to call mmap64
(as symbol). In you scenario above, it should run into an unresolvable
symbol error.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
