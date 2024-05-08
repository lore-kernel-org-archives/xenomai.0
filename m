Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3A215E90
	for <xenomai@lists.linux.dev>; Wed,  8 May 2024 05:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715145588; cv=fail; b=BMYHKAV78cvAGp/ktqOS5DL9jdB+p9lVhRYnJXeu84/ng5pcXcUn7ngmJ9Z4utu7+1BkHPRl1TueBOUCHZdfrpImd0NbAKkco8aH9o5Gos/3jfwtdYtdBs/Ge+C7UggsWt7io8YVYs5vhenRfe7MmNE0fZ6/NZ37w5MKqBgTdA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715145588; c=relaxed/simple;
	bh=NuGvigZ6G8ru1zvl0IlC2TT5VCMe6v5MWxykG0T450Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LC+Q/WOS4hpLlJY+4YdZJwlqpWcTUcceUYT5FKee0298jFtu72tt1ETagLWUpvaEutNrCo1yA/bb38DzKbL6mWLUKsopn+fs9I7S/y8+1QD7cDcaK86smpzv2W3ZpwjizcIPKkQrDuZPuOLrYHa2gYdLl7BamtsVLcNySVbgvRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ytaf6/jV; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ytaf6/jV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZ43mXWje7++4KBD84SJo2f3LnKAf7+poIl9WqGr1Jt0wqsRUwiOfQZGelW4HD9brYZ7Qocc6lcxGNBQ9nfShhPl2dxubjGZQDrnWt/9V02HUGMROTH103BbO+ZxOGETgy9fBIak/EnRiD7wNvp89utXK5kLzX/uFqWx2STsrXoHhr8OcU+vYJ34dp1sGla4DfkdVSDunstsJ6/bCowBU6aIjJdhN96nLaFxVP/NYRS7LiO9zP/F+neJyMj6IT/TorJZQXtGW9bV+RD+N5/coKPNrElmrVmFh2s85U4l7BJB6JxFAWzlml9LjnkptKL0GfZ482x/1VADrwIr1SZBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MmuD1dRjtYFDCtEg8pUipNZiDFqdHgKbKiNh0SrODc=;
 b=S+q19EaIhNhr18VwO9UILOK6Jl5PK3HbJoHEV9fYQXjCBVn5YMHdnsMKDpuqNWupjdUBynWPYp0uEKS3E32/1YNYif6gAYq9tme5vQr350kHOWLQQ1toHNk9YA9tzMkmeUu4sFNuwjUpk8dGszD5oW79afrLBvhCoo2MIkMuB+dCrbOyA8yznZAGoQSKk6AbmTLZ2kKqEKwI1Ac+mejH1QYyJDqOytmWFAqIBoJL9HU0qG+XaBZN6fL324MB1n934FPmBkF3g60wtP98s0mtfogK6TuRYUpSNk2saGMrNiscvoHIlMbSauNoAwCeusMNTCBahKXJcTy22QN0ZoafYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MmuD1dRjtYFDCtEg8pUipNZiDFqdHgKbKiNh0SrODc=;
 b=ytaf6/jV5j9vNlFS1ODkm7y6tLnT4lpcdDk2521XDD86o9G5PQabU25q6kbGH2wH6bfCxNzOo3MIuhb2RMFfPhmN4gXNu+kHIGFIIAXkrMRIJ7djPgJKffxkbI3wKTXVynLb+Kals///krfg28utlnQcQOHJB9fbQPk+ba7Am5w43COPU+S8IGQp1jAYQNqXkX8BgSC4JMtwFcDr1+7bokmMj0PD8WBdG4blk53Z8ne+rjL2e0RK8YAaYn1PKojEp9i4AWCtjw6bAW/jUOrf8K7GelATncYO4OAEBzaOsp7E0p/h0YAYAZXMWuE+mNhEGegaQOk77xF+dUylVSOC5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 05:19:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 05:19:40 +0000
Message-ID: <cba926b9-8877-4b2e-9bf9-475d94c2e76f@siemens.com>
Date: Wed, 8 May 2024 07:19:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Reminder: Xenomai community call on Wednesday, Mar 20, 2024, UTC
 7:00 AM
To: Richard Weinberger <richard.weinberger@gmail.com>,
 "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D3E2C96C4F21DAEBE4F2212@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499C4BB71E159B3AB98D686F2332@PH7PR11MB7499.namprd11.prod.outlook.com>
 <CAFLxGvxLRSpn34e5OWxV6Z=_oioHiyG1macowe8BSQ8qVcsKKw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <CAFLxGvxLRSpn34e5OWxV6Z=_oioHiyG1macowe8BSQ8qVcsKKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: c21c41ef-5aeb-4bfd-db6a-08dc6f1e7682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c09MdG0wNGo2U2lCUnFzcTF2OFhkd2oreHpLWVA0cFByaE5GSjRQZzVweno4?=
 =?utf-8?B?c0p2Sm45NUlaaG56QTExT3FqN0xETExldUk4eXhkUEFtTWgzc1JaMzNRcFA2?=
 =?utf-8?B?WFlzWXNnM0pNS05nb0xyYjk5eFE4WXQ4WWR5UWUvTVNsZmU3emRKYVFsQmI0?=
 =?utf-8?B?bEtWaWI5LzZNa2U0d3EyelBmUExDM005UktuYmd1S0F0SjJFaXdUYSszQzZa?=
 =?utf-8?B?SURNUHRMOUpqQklwbFVWcDJPbSsvbnJqTTg5S3prVDVKbDFpdWlrSGlCSUtj?=
 =?utf-8?B?Y3l4U1JuSzF2S2VvYmV0SnYxZFk0aHhqem1qMUM2T0xkeHZsOUJHVVlLRWpY?=
 =?utf-8?B?c3AxRkxZVzltcm8wWmRhZ3lQRDBocDVaM0pUbDcvQ2gxVmVqVnBndlpPU20z?=
 =?utf-8?B?SzdCUmxtSFlCREN4MlZ0MXkvOTl2c2tOQkVrbStwS0hnN3VmKzhKbEg1akJy?=
 =?utf-8?B?MzRIS2o3dmVzc0VSTk5GZFRQQWdZU004MEVVVkVDNHdKN2hLL01Ccy9QWnlU?=
 =?utf-8?B?bUoySklPT0t6empJMGFVa1FLREIrbXppT1Roa3hDbVdvN2UwYXAyaTM5clhx?=
 =?utf-8?B?L0F5REtBT3R1MldKaTNJM056UlhHSXhjWW1zWFdwQWlYM3JmREZQeWNiUXpR?=
 =?utf-8?B?ODg5M1BNSjZ0VUdqVmV1YVdNbFRGcWZaM04xOTc3UjA0SzJTQklNQnk0N2tD?=
 =?utf-8?B?Y29nbUZCeDRla1dSVjNUaHI2VmZtL1o5MXM0NVhvdDZEWDBiOWkrUnVpcklI?=
 =?utf-8?B?NXdWZm1jcXNtOU1JaDNVNGkyMXpLaWFwYU1BZUdsaEV0OGRsU0VlRE1Sbm9V?=
 =?utf-8?B?Vjc5NEtYbERYdm1ZSXlkTmh0cVZrU000TjJ3dEtxd0t0QnVVc3hyd3J4RUFz?=
 =?utf-8?B?Nll6QlVQQ0Y2MGN5WUNXOGZPY3hHaEV5ekZ0Ynh4TnZoZExkekx0V0dEa0gv?=
 =?utf-8?B?QmorSHRSdmhBWEkwajZhUHowYU5JclNCa0lha09LUHpES3M3S2k0KzZDUzlV?=
 =?utf-8?B?Sng0ZnJ6R1p6QWZGUW1mTUVicmZqN3FXMUhXQ1FpRDBFWTQyOGw3d0RCVXpX?=
 =?utf-8?B?SEgxbXJ5TlY4V0U3Z1VXRlVNNWUzYmdhWHVlZzFGT1ZKRHBzUWlXdnZrMjNk?=
 =?utf-8?B?b3YrcUFwM1l6OXRlaUdYWHg5L3g4VnJLaWYrY0pIOE5ZVWVqWUtzY05tNnN0?=
 =?utf-8?B?ZW9FYWNKcjRYT0I5ZVZTb2tnb0gzcGFsWGxRSlhvU2hGTEVGcGJMSlg0UzFX?=
 =?utf-8?B?UGlGangwbFQ0am1sM3A4cUFDRkRyVDYwKzNWMWZZcVRBYzQ5WlNSMUFqRW9T?=
 =?utf-8?B?Tms5dUtDem8yNWJiMUlScU9TRkMydWdPZzNaMmtiRGluVit5UTRKaFpxb1Nu?=
 =?utf-8?B?M1UvVVN0WUllSGozMzFCR3NmRTBNbS9XUE1uQ1lKanQycDhDbWdBSnlYd2dF?=
 =?utf-8?B?YUlVaTI2UjJISDVUL2hXUlB6blJaM01VRG1MYnZGQ1FwcXhXNTIzT2kybmdW?=
 =?utf-8?B?SUxWcnNFTUJyd0pXYWhTMTYrUlJpamEvQzFxY0RvNW9sNmplZXJUVWwyc0U5?=
 =?utf-8?B?M2dkcUVnQThRUGtsb0dYR0pzVG9STW1kUE0zTzVUUTB2eFZJb3R1UW9SQ0Ja?=
 =?utf-8?B?TjVIcTJ3VWNZQjhaZFB2bU9SS3drTmxkVi9yeDEvWTJrRnE2Rzc2SEtIV2Rh?=
 =?utf-8?B?Vm8wZXg5dVZmYzhLdEZ1aFlwdkNFQlhyS29rYXZrV05VbWdNbE0vWnVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlVxb1E2b3B3UGFKYmp2TjFpWTBGTUlhUlMzSy94NVJ4cDE4OVB1eUx2anM3?=
 =?utf-8?B?bENaa0ZCNFR5c0VyVWNkWFE2bzlOVVZLaFRBQk1yb2NiYmtCM21jcWJtV3c4?=
 =?utf-8?B?RjdxZFhSdllDcUJ2NzhWZ2thSDBGV0sxSml2QXh6SlJWeldJRnp1VEVxT0Yr?=
 =?utf-8?B?NUx1ZkNHZW1oZjlWVk5uRHVRU1lNdDJEME9DRFVTZ2x2UXdRVTNYZlo2RDBx?=
 =?utf-8?B?bllkRDl5dVZSOXpURVo3QUFUWGdGQXpJb0I4dk03RmpHQzNuNWRYVmoxdXB3?=
 =?utf-8?B?SDdRK1o1VTBRNWxodmVseVVKQXV4cU9FZ3RYcnMrcVVKdTB1c0xBRHArc0lJ?=
 =?utf-8?B?dGV0UHVSZFR0dEhZR0c3aFJuV0xVeHRMblNidmo5Rnk5eHE5SE1YS0JjaXdE?=
 =?utf-8?B?K0FoRkpnWDRiVGo1cTV4eGVtalBFcnJyNVBlN0RLUTlIcjhBS1JoL0tXbllB?=
 =?utf-8?B?NzlQREo0ajJ2QnlPZ1IvUEdsRDZtdkJyZzlCK0NacmRUbCsyNlhqQmJKSStP?=
 =?utf-8?B?bEV3aFRYY1orUXlabmt1YTloSitHdnloakFVSHBqdkFoRGh6YnNxZDlxb0dS?=
 =?utf-8?B?K3I0UzVEZng5aG5mVnl0RTYxUG5SZUI2UXJ3OFF0SmE2NjVoTHVQR00zMjEz?=
 =?utf-8?B?eWFUSWVCTkV2UGZjd2lCVzUxVDFTckJ6Rm5qQlFGelllVk03MnhSRnpCMnFC?=
 =?utf-8?B?bHh2OTh2WGdPSXRKdDB4dHVoYjJLUjlUQlg0SisxaTd5Z2ppbkhkb1RXdUly?=
 =?utf-8?B?MDZKdnl5SzNIYVJ0M09CZ24wUnd4YmprRVFCVU5EZkEyN2RLZldMbkRqelVZ?=
 =?utf-8?B?RWdGcndvdzRkOVoySExUeTBuYm1Ha2kwQzAvZnI3Zy9DSGlYZkc2VXpnNSs4?=
 =?utf-8?B?amFERjBDUWxpZ2J1S0hBcE9LUzZHRTU0ZEpQV05hcXJ4ZSsrVkdESWFwcFJH?=
 =?utf-8?B?NDROWmtvU0E4a0lPTTN2S1RKMGR2MkovdXEzUG9od2p5NzJPNWdSWkc1RDBC?=
 =?utf-8?B?ZlgrNUhDYUhmd0M0UEdNSHl3dE9rOGhDVVI5WnlPaHhtQXNpck45MktFNm9B?=
 =?utf-8?B?K0FheXFmc2ZCY3F3Y1B2c29aV3pOZnZqNFBxb2YrUlFjbDh2SUJ1WW84ZFRO?=
 =?utf-8?B?cnNmd0oxU0FCWng4QTZFQms1aE1ZcnVIWE5jS0crVjBOVlR4c2RKV3hEUmlF?=
 =?utf-8?B?ZEZRNVNocHFUS2Q4cnRORjRXcDY5dnplbG1wdC9QWk9BT3VrZ3VRc0hDdFY2?=
 =?utf-8?B?Y1lMRTkzVndyMjM0Mk8yZ3JFUmRsQk5CUHV6TDV2UHJobmtScklZbFY1YWZT?=
 =?utf-8?B?QkVBZk54YWZUcHk0RzhsV0huSXEwTENZKzBxSjEvQ1dNclpHRlB3WERrS1Q5?=
 =?utf-8?B?VWVWOTNzaTNvLzkwc0g4WmVSUDN3akdITXlLNFczb3hwZVc4aTNGc28rSklT?=
 =?utf-8?B?cndGVGgvODdlZ2c4aXRPQWZRRmxNdHErUkJjcHlCdzJ0cEVocnE4ZWNLMGpC?=
 =?utf-8?B?UHZySnBKVU9sQWltWFFUTE5mTVlYc0lzQXhEdnpydTJKbGc5SlJEY1VQVlVP?=
 =?utf-8?B?bURhTzhjenQwNW1oRUhJTUlHK0N2MGd2TXFZZC9QbG16Y2dDN0swZFNyMEp2?=
 =?utf-8?B?K1MwRUIxTkUxOFpZOWc4Vy8zM2R6ZERCQkFmZkpuQktmaXZnNThxUEdFRmNM?=
 =?utf-8?B?aml2by9YbVo1cGo3SExpTkRtb0NqK0YwdHl3a2kwV3lic2VFUDZldjBnMnBK?=
 =?utf-8?B?ajZ3Q1N5SnBJV3lWaWpIbkpSV3FWa0VabGQxYlRuY0lzYUxBd2pMZEZkbEVO?=
 =?utf-8?B?bUtHQnFsbWkrMElZY0ZrSlo1UkVnSFMrVHlNVkhiWFM0c2ZjQWdUaW5DSTNR?=
 =?utf-8?B?YlNPSFd0STMrSFBramdUU0ZucE9DNDFObFZqazhyWnNRQ1B4L1hOUE96TFlG?=
 =?utf-8?B?Z0dRcnkrTjl1NVJUQWNsOEw5Rno5dXlCWGdDOWZHc0JlOGI0Y3c4ZlpMVzF1?=
 =?utf-8?B?aE5iQ2hQRi9wV1MzK0J3bVhTaklNVnVrb2JqNzNsbWNxMjMxTEVsdUJnWld1?=
 =?utf-8?B?WHpNTkNBZkdzQ3FBV0FUNktPcjhPaUEwYUU0ZVRmSzMzb3hWcTZoMkJnS2l6?=
 =?utf-8?B?VDlZNDRqekh5TndlSno0R2o1WXg1VkhVT0x3cDJCQzZxdHNXWVowSHk4S0J0?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21c41ef-5aeb-4bfd-db6a-08dc6f1e7682
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 05:19:40.8975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ow09j9mBHcHoQBbuD1UyFUw2bFP4YKucQflHt2/ty/MdVjYvnDC6JJhnv9Vz2Am5Cnefj4JsqQRl4A8pVXhB6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6524

On 07.05.24 23:10, Richard Weinberger wrote:
> On Wed, Mar 20, 2024 at 3:41 AM Chen, Hongzhan <hongzhan.chen@intel.com> wrote:
>>
>> Topics may include but are not limited to upstream/downstream project
>> plans, status updates, and technical discussions. It's an open online
>> meeting that anyone can join and ask questions.
>>
>> Time:
>> Wednesday, Mar 6, 2024, UTC 7:00 AM
>> Paris, France CEST 8:00 AM
>> China CST 3:00 PM
> 
> It's been a while. When is the next community call?
> 

Next week if I read my calendar correctly.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

