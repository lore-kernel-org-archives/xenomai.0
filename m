Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013035.outbound.protection.outlook.com [52.101.83.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21543033F7
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681103; cv=fail; b=GtYwkH1NTUzGZ7VvsoOJxvdbZg0edX1zwyCnF+ECcbvPzfTVH697GwJn9G9R+PCrf4rvf5vq+boN0FMTktSLKzHkYYjvNrGkS8ZcC5hobFP7X7fyB8vQwJaB6ciTmvdAj9EHbGvzpgLfdMDvvNywz6JRnzpGxzC2u7V6EsujWv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681103; c=relaxed/simple;
	bh=kNh+p3fKBO8o57ut4cUK6TX+0nbHxJSPvFdFGMpw900=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KHtXnvL0CzkQpTAwqqsz3fyeKpf6fpmk1b+QgCDuMzuB3DG2fGySVuQrQ4Ork6dpYap8QX7a0+2ZKLAOyWh1WwrOohHiL0K+yytrovmx/bz+a/8WYIclDQSBFcaDUWbUwC3CZz8G82E9CMjQkL5vCXtzhOfr8h3VOrzlGDwp1rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=BGLTZpbR; arc=fail smtp.client-ip=52.101.83.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BGLTZpbR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTQa/oC/w88G9T5s4Y2bxqMSWU0icxiqaSG2uG9CUf/ZIJPoAfl9mPpBuYQ4S8kzpwgxUm6tbfliqRBVssmnFZWtcFiloAW3lYVT4hfoih819eneH4pshwJRIs9BJryXjg9b2o9GTVdtpLzfjXdIAGM+sEHV6hULrcgjl3rBkL6uaeR0DAV/2NAuP/7UWEt2M8vOY3T1XySm4EgnmzzEy4hGO2xpfiisvxU/Ai5Ac3MN5haTVJmdCyPG6Dt/xiI01/uINBIK+NYM3EqO1cREkLn2EObk8vo30zvfxRE6DofXKhwN1FAEGOggespOZzIueJ3Mcpmj+FxkvzJIuG81+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wzr6n4r0FpXnxXKSZNdDTKmRdLOg+5/PvFwlgd6AocU=;
 b=YImroLwge9bOde7pc7IFS9holFYPn4cxuEyB2UlBYnRe3uZq4uImuRLXOdJV4jiD1YllSFqIBeVdmZwtK9SNdwlQLdwImBt1BYyxAq/eBS7CseTqqnVhE3/DMFNNmXQAovqBd0w1EGqheeQtGsQzHebWp8vDbHSFi8dPuLBKnWVjaFr5quGmAamOYFU7s1DtojBI+1Xq5PkPaAsv3M9dacsPC1I7HaCX3DkRitzVxa84WrWUOupQ79TC9ZdOZFY+lVk0bqrp1c3Wyn3joTjdx/pzRWUVapOwzP1irtaZu3I05H9L1damun4SDQIVq1qqJJ+hfk4Yx2O3UrhlL3jpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wzr6n4r0FpXnxXKSZNdDTKmRdLOg+5/PvFwlgd6AocU=;
 b=BGLTZpbR416D8lryo2r5ZFLgMIKtdzmzILZRtvkg4spekFvEuRCSrJXPdlGzyxEBA9dsPUO2kB9nK0GVvMB8afjBXIR152FJVXmkIjHk+qYqbJv8idFQcedVqtbaIoHIHSiCAnDRFVikl/+i7z8JCJJc++IhaScDJdmXk7NauUkXfkaNohYE1pv9WuLIk0E+zjEWhev7fnxCkjftdjfvnG9oFfZSPtsqNkHbdzs72yhbSuYJAttI6scUWbTySiI0+qjZAXV5mDan5YeTZtu2wqDNSdAKUse7qZrQbROT8LIglaUmT4kOeg2bXyE86OMEqdgDhqp0jexghsV4+ooZMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9796.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:31c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 14:04:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.012; Wed, 13 May 2026
 14:04:58 +0000
Message-ID: <ad18a6c3-2040-40e1-b72f-23138e58f261@siemens.com>
Date: Wed, 13 May 2026 16:04:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add support for gcc 16
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
 <103292be-0400-410c-abea-f2c6408a7bb7@siemens.com>
 <699a6f2a7dfa0b0f33f4d330fdebd7b2bd0f7e72.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <699a6f2a7dfa0b0f33f4d330fdebd7b2bd0f7e72.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0029.namprd14.prod.outlook.com
 (2603:10b6:208:23e::34) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc04f34-a1ed-4dc8-d0cb-08deb0f89e12
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|3023799003|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	qvE/u8ycMQmTEqCsOtQVm1DgQmZ72fNIZ6y7KW+FbYY6lkTr5AmrfHd3XFRE7FYZ/kA8rL4kyo1xBT5f4yrUJE2kwfplfNWyLyFsFE65b7TsV54e8PGifUYuO4sMfEJwEP86StwSyz5HYz6HThjDifAgyOnoE6veYTAba1fMB5/95WGcQR/ijhzpIkV+wYNQ4mJvoPKxZFeGxCu0HuDU7G9xyrvcmnuoTx/bjVhcGq7bYgsRbetNW3slAGL2b3TP0WBI35zQlG6t++UPbq+mxu1Y9cdJ8Qdj1umwkds0erkEwGXMwCVY564PF8FxAZdm0+9lcctPEusItDwaXYJ1gkhG/htFolHPA33LpG1xRZsZxY2U7wsrUOVstdoH/YUMH9dVuvbzLbTbmZYJj8vZXvQiO9t9flq9mBeqIWiT3qLRMjJMG9jEAaDrcgVAUvKolTlIBvXS78YkjMlWwvPI5s/3aPHOvkVfw713rpQnIG3IuS6s84Fh+OuNHjn54QneJdDyJh5ETedT3SEsNcvZ3YYH9PvJDERhBzoGkEqhHmyiySPY8swvLaKYtSpsitQ0dfJQH6hoOZ3k8w42XKkDpCvnUW2DFXpaOkfZFLiULE9mHjnAU4yCyppX4YCblhM6MfGcd74RJ+MjavjWNNez/++texwM8VYFMUNYo3SGF2WHTS4QiFONQiUdtylacavm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(3023799003)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2hkY1RXMzRPT2NxQjhiMXJZWmtsb2RWNTJOUTdpOFE3aW9YZmdtU21xbnA1?=
 =?utf-8?B?dzZMQTlnU1ZJOENWdUMvTmJqUEFzMytOMEVvOHhwcHVTdTJ2Rkx0dmJUdjM0?=
 =?utf-8?B?U3h0WVJvY0JnSWVXSjlnK1ZkWlN1dFJZRWRqSnR0NHVidnkyd1hsYVF5c1dy?=
 =?utf-8?B?bFkzakp1a2ozS01HWFNEU3labVI0S3NpaFhVa2tjZVkvQVRtdXJBRkRVSHNO?=
 =?utf-8?B?bHRWR2VNWXdoOGJZOGZQSDZtY0R4ek9lSG9kL0hnSFpxdmkrZlJ2Z3ZHYjh0?=
 =?utf-8?B?UktZY3IwdFdMMERCQTBGRVkwcnVhTXdmNmFESHI4OCtYbVp0TmRwYnNHM1lz?=
 =?utf-8?B?UktYT0p5LzVUL1JSNFE5Rmh5OWF4SWt2d1ZlYUtyWW92a3U1Z2o5d2xpNDcv?=
 =?utf-8?B?NFZ2dUo5WCtmMEV3Smo1bVlJRWVmRVpNa1lCaXNzVnJqQXhUeWJROG82eDFs?=
 =?utf-8?B?dWFPYnJWM1FyRnNZRVRja1RjNUZSdUtadmJLSGY2eEI5SlFtYTRvT3p0dTJB?=
 =?utf-8?B?eVlBTlJma2hSeExkYXJIblljQlhTYStaZWNkS3FPZkFJa2cydExTTFhSYUNp?=
 =?utf-8?B?eVZJM3ZpUHlYbVpqTUJvZFpkNk9nTFJ2SW1NS1NHYVJXMTM0WnZud0grYmpU?=
 =?utf-8?B?K1I3cE5IZGxyWkVQNldLUy9zekFrV09aMjBsN25lRWpMWUJSWTMrbWtieEUx?=
 =?utf-8?B?d3d5NEY4ci90WXo3Q0w1aThSb0JmRlcvVC9vYUxwd3l0MXVBSnVFSGNUOGJ6?=
 =?utf-8?B?ZVV1VHFCNFR5Y3UzeVdHdjRneVNYUzJ0RlJMY05GNHZtMllYK01Ed0UwWjlX?=
 =?utf-8?B?L1l6ODZtSW1nVmE1NDBMT0ZqT0xramQzbm1VYXM4LzZoeDZ2bGhxb002RnJR?=
 =?utf-8?B?QXhBRHExODAvMHZNckJINTBOQUpybXBFOVRXTGNEYTgxOHM0UG13alYrOG84?=
 =?utf-8?B?RVYyMG1OWXE2RDVSVi90d1NJRElQMFdvakhXR2ZMS2xCekFKWFREOVVaOWRs?=
 =?utf-8?B?QzNEZ3o0ajhtQ205LzY2bzhQZjdELzVFYkpkaUpqd0Jza0RnU0t6bTUyMCtC?=
 =?utf-8?B?bjJpNHFxUUJXRDk5NWVleHc4THlwOFVETXE0Q0RETWhKQU5vWG1uMXFEWndy?=
 =?utf-8?B?T1lmVFcxNHBmTlBNWDQ2L3k0UGN4TzVYdTJhT3lPQW1jM1RMckpGMkkwMDlL?=
 =?utf-8?B?Q05haEplamUzNHMwaEFkRWwwMTB1L1A2Q0VvQUJXMXJucFI0TWFtNGRSU2l3?=
 =?utf-8?B?L2dNdGgwVUgvei8wZXVIdUNUQ3Zpa1VXaUUxbEtZUjRwZVFRaEhSYVlyLzJX?=
 =?utf-8?B?S09CY0kweFk2QUZPTnI3Z1FFdGQ1eXNGZ281TTZXM1dWNGRHU2QxZTR3ells?=
 =?utf-8?B?NTZiT1ZwQzlrMXBhcFhUdGNIM0dwckVqU09zUGRXUGI4cVRoR2lkYTZrVDZv?=
 =?utf-8?B?N3lFTERsOVNSYnVNNWQ5QW5WbFo2UU5RMmViMFJlZjlnSTNaQVJwdmNSY2pO?=
 =?utf-8?B?VWw4ZGRpaFJaUlVtRTBMWkRYbXQxSEFtVHI4TURYTnhRN09uRWdXSVJhZkFv?=
 =?utf-8?B?dStEd3AvODNadHdhMElGSGJnZzBzYU9IdlNna0hTN3dlMkhoR25XdHNHd3VH?=
 =?utf-8?B?MjRlMkx0K3RQL2F1S05OOElkQWE1a1orWkxlYUJ5Y0p1ancrZFRqMGFjb0N6?=
 =?utf-8?B?MDBna1JHVjZIdEVucGU0V2liOVBBZllnRDRrQncxYUZtQkVEcFlObnhpSXJm?=
 =?utf-8?B?WDFseTJ3MG55Uy9WZndGTmh1RE5aNC8zZEVMQXJzeExnNEtnaDlVa1IzSFNQ?=
 =?utf-8?B?NTFYUEpmYVVsbDRCb1JUMHphV3dYNFF2U3k5WHZ1US9PTXFGV2FneEFaY0FU?=
 =?utf-8?B?M3dHeFRNakVvV1lHSGdxOTRyRWVlc2crNnFBTzlBZGdjS2U1REFuYnZWYTZU?=
 =?utf-8?B?eWUvNWpwZFVxclIwT0VJN3VqdTluTjRWc2t6WUtTZGYwVS9IWkQrL2VGQTBp?=
 =?utf-8?B?ZTBWT1BNOXNkOUdUR3N5VjQwN1g1M05lZGhhQmxzMU45M0U5Vm5PTkZhVGlu?=
 =?utf-8?B?ak02Q2plNEQzK0tZTzdBUTJ0MDlJcjI1aHZlOUJvVlNmMXkzVkdCU3UvODdY?=
 =?utf-8?B?RkxlMzJzK0NmNGpUVGVXVEh2ZG5hT0hoSlNPQ1F1aEdPYmNNVE9YTU9FeUhV?=
 =?utf-8?B?WndnWjF5WTQwNlZoclZvWWg4WlRxUVFvOGk3YXoxUDRmWHI0ZE15d25Zenow?=
 =?utf-8?B?aGJZa1pzUENyblcwR01nenAxTytqSjNUbEd6NUVYQTlNNW1MY1hjZFNXZEhU?=
 =?utf-8?B?ZmpGSWRISWhmVSt4eXdvMVRlNEhobzUrVjY3RWtKWlErUUJ3cWkyTjBKRUZ5?=
 =?utf-8?Q?MX+VBrfMHGgQCJRM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc04f34-a1ed-4dc8-d0cb-08deb0f89e12
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:04:58.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Peh+TtL1K2BTDb4Nvcn2yaHMfLRy+EQ5sDCMpk72eYtqB57Frnu/7o9/mjOBpJuZ33XRjZMfCx7VpxV9IQYI3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9796

On 13.05.26 15:52, Florian Bezdeka wrote:
> On Wed, 2026-05-13 at 15:46 +0200, Jan Kiszka wrote:
>> On 13.05.26 14:50, Florian Bezdeka wrote:
>>> Hi all,
>>>
>>> Trying to compile the codebase with gcc 16 revealed some minor issues /
>>> compile failures. Fixing them up was quite easy, so here we go.
>>
>> Is this gcc 16 generically, or are distro decisions involved here?
>> Primarily out of curiosity, but also to consider reproduction - did you
>> use Fedora or Debian forky?
> 
> The build system triggering this issues was based on Fedora 44, which
> ships gcc 16.1.1 as default compiler. I'm not aware of any distro
> specific things here.

Maybe try out gcc-16 from forky as well, just to permit more precise
motivation description.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
