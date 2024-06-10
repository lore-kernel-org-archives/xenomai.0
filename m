Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2067.outbound.protection.outlook.com [40.107.8.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78FE1E492
	for <xenomai@lists.linux.dev>; Mon, 10 Jun 2024 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718054221; cv=fail; b=brWZic9jaIHlgGUl86jwnG/y94d52SHiTaE49ocfxZd3imuQDWwW5i2xJG+JpzlVvmv1b05vygWJyhp9UGNz00eYk+okzjkGC710lW0p6UjMIoPGgdxuv4KUEMfwywL++n7hzyQjwsQPcTCOwZ13FUFseZRl4kiQHn3oj+dDTv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718054221; c=relaxed/simple;
	bh=j8rrYsfKKz6lZDRz9tdT9UL8TWn2h514rFtkciD4uv0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bGVL0bZkujBAC5wWc41T7Tdce0wt5Il0tjG+pgwOcULx7+BvbMGz9A4bZ6Jx3t4mzcYh5gWXTTk3dQ3y9ukd3Ypr2+78yJgQCU2Twaxlz9K5HbthAvsOdqa7YC3+edEdYeIdrubiCKvwFAT/hV1ei7ducME2lHjQ6cUL+hL8c6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YqMqhTcj; arc=fail smtp.client-ip=40.107.8.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YqMqhTcj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHvXWXsV1dotIpCPAk89VuF5fVoW+sSRz1YNGXT10wGsJA5Ic9z1nQowpE0o5ydh+mNgPB2JCViIisgdQkpxQ/i4lNUc1CB0HdFw7Mv4oewDl36nRPAARhIfqNczh94ZQeVA1KsVyQcNZsoCS4i0iBHuweZ1tiFozIfPuMDRd0EB082A0clOlZIEFF0+ZKyIzXHhMEeY2aB5JdYxuZnllrxHeMXVSLxjLtyfJR+AojJF16LbKwjfYRt/Dvb6y/JsUTK3fBG5JaUf/dBEy0kElvpn26zgzg9xEfbaFb01OshA7Ssk/kzf2ikviGZieXlWPOqFc38Ljz9uuhZNYs6Ppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpKgcGITkB2+HqAL8yPgeiu9KzwL1QqOT68PKQhijrY=;
 b=P60kRrtsfKkuoAZqhtZOwTFRzwAswlAVPjrA8U2aei/Z/N6rg3wj0Y6m7Tj5tuIs3yo2CcSvBCYADSz2fLDJ6AdRb6EIR561exIEf0EAXK3/3cJhPDiItSmdN8FtMYAbuWjwa6xAzXesb+GT/CCdYUss/uFoHYuGEFHaWebT5qojx4StzlKjj/AlTKABGZs/6+qCp1m/04vqmfMhLoC8nGtafYfaH/D4RUxOuYNfo3BZJ5t6vnkApML1W5sWe4Ufgd2ynYxKNccZ9eaR2FRGUbWkoTw+9CmkD8NG1cj1iYRgAY5rH2DFEA/+f25e+SiZcBoJWE+CkDn1PTocEosqXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpKgcGITkB2+HqAL8yPgeiu9KzwL1QqOT68PKQhijrY=;
 b=YqMqhTcjgtzQZEv1vILiD1To08qrtTbWy5/+LJJUIopLYY/WQRQXT4doqp16OCBALIsOptIMQM9vLrs0KAZeYdH1U2Mv8UKYBWsjWpyiYV7hNR9/TOEacrqiB/LlJlFlVF8HOgHhQoLtdymx9ThStZJFa2hlS81skeLMWrpbiXcLeDtp4TQ7xVwPhpMMt63fs3mc7KdZ/DKKfYiuV3pA5C+DiuabSGp0Pm3xiPAmxOIeuW5D6/QQ28u0e76V3WSiKQyLSf2IbAfCmbYVb9IOJ781K4uZ01nwc1VOW4RUUuDdpM5OtQ80FDVUIo2ajfu9eIA0HQXzLnKRn8KLqCOsag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7199.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 21:16:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 21:16:54 +0000
Message-ID: <9c69a0a9-8307-4cf4-804b-1ba49353bb52@siemens.com>
Date: Mon, 10 Jun 2024 23:16:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC dovetail 6.9 v2 2/2] KVM: x86: dovetail: Allow
 kvm_wait() to be called from any context
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <20240531-flo-fix-kvm-guest-for-6-9-v2-0-5534fcae4eb5@siemens.com>
 <20240531-flo-fix-kvm-guest-for-6-9-v2-2-5534fcae4eb5@siemens.com>
 <73b55cbb-0d7d-4552-9102-cc7c16e5834c@siemens.com>
 <f57d19d9549525a94e1c22d0d9b520150afda04f.camel@siemens.com>
 <dc350628-f444-41e4-93e8-b9724046b5a0@siemens.com>
 <5c4192f8-067d-4a92-9ea2-ac5e77ff65bf@siemens.com>
 <fe10e88839a636a104fa1fedbe75e424664763e1.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <fe10e88839a636a104fa1fedbe75e424664763e1.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: ec782670-6c57-49a8-1104-08dc8992a726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3ZTckIraERGM294SUtYU1lwRERVUjJHM2UxVDNBZlNpYXQyR3NDaUxCRXo2?=
 =?utf-8?B?b3dlc0lncFdLMWdsSEV6SDA3QUdqQzNNSVpMdjB6eGFGTTRCL2FORnBJK09K?=
 =?utf-8?B?ZmpQcHd3ekxGVFV1NnRXeEcwaEZwK2J1Q3Q0bGI3OGM5YVViaVRPZC9PZ1NP?=
 =?utf-8?B?WGpzZmtDakhXV21NT3RpSndtWnA0Y2w0QlV3dnJ4dDJRaGUxb1JxVWlMVGJw?=
 =?utf-8?B?LzN1dE9oNjFFV0JZWmpRb0JaUVgxUzlVUXBZVVJjdTJKVFdBNHVlVEdQRS84?=
 =?utf-8?B?aXl6R0orRkRvQUxzNzNkek5ER3JLcldJV3RmQldQNlBiS0M0K0FQWDBHdDgz?=
 =?utf-8?B?TCtxaDZoT0dnWWZDNldZaTUrVGpzN01OUXlBWDBYKzVNdGpIRUNwK3RCRDAy?=
 =?utf-8?B?NGtrZkU4UnBXTGpaaFo0Z2E2dHF5NW1wVFI3L2RDbXJwUU5pMUNJcUJRdTZh?=
 =?utf-8?B?TU15NmoxTmZxNGlqRHdCd0p2eDZYZW96WTJRQTNTUkJaUFFxYndJUzlidWg4?=
 =?utf-8?B?MXhHSXlWamQvZDZ2MUh0VEphcGNPODNkYXErd0VuSnl6Z09pcURBL0k2UGpZ?=
 =?utf-8?B?MGVNeW9Bd0hyOEJ3ZEJHYXMwK05oQUxJTzdKSXBZTEVKNlZjUEFSOVFtOHFl?=
 =?utf-8?B?dXBkODNVRlhUM3d4WmhMWmhKUVhVRVJsQ0Z2SGp1MTFrcXVJK2tBdlQvWm9Z?=
 =?utf-8?B?S0NWZkNwbTZPa1d0SERKWGtZdWdBeFExZHRyUGlGbVcvWXcvWVh2bks5WXlU?=
 =?utf-8?B?MVc3ckxsYXk5QTRzTys4bWN2VUZWWWJIM3pRRWF1VHgyMEhOUERzZmVTYUNL?=
 =?utf-8?B?ck5rTUMzdVRmSXZSVzdpWUplbEVzdEowUTkrTEJtSlRpZVV4VWJiWUNjUFRZ?=
 =?utf-8?B?TytlOWNKdkE4RTVRVXZSeDdGZDFyS0lpL003N2MyamIvSEVKL05ycG9pTUdq?=
 =?utf-8?B?TkRGczB3YlNlMUhDZ0tLVWhNRStTNkVxVWJSYklqMlo0N1RKU3BlS1REdUhl?=
 =?utf-8?B?RjFWbjlBZTZzRlhKT1B4SzNrMzRKOGZLc2E0dW9HakJBUldLaE1XOWw1MXZX?=
 =?utf-8?B?NkNBeWlyY3Y2c2VCbGtBZGVFMDY4T1hTWGRqaFpGQ21lK2dMeWhONVFxM3BQ?=
 =?utf-8?B?cXFwUWVNZ3k4WG1CdWhyR3loNmNZaWNreVVTV25PSXNJUlVxWVF4R01tR2ZH?=
 =?utf-8?B?WGtYNlY3TUFhV044cFJ4WHF3NjdSQk14WGlkbjdjM0thSC9rbnJPajdlVjVw?=
 =?utf-8?B?TERUY2hUa1BsQThxaEtWdlVtUThaRGExMnh4MU50MlJVQmtoYmFWOGJVM1l4?=
 =?utf-8?B?bFZmYWM4aWtNOXNna3pNQzdZcjZKQ1dzKzc5RWw4cE9icm1IanQyNDgvVlhM?=
 =?utf-8?B?cVkzcGdXQmFjdVVZRDF0SVVhQS9PMGxJbytJRVB5cFM1MCtQcWwxQ0luYWE5?=
 =?utf-8?B?bmEvdE40eFlodGpuYUhLM2xxZGVRa2d0QkxTdjJ4VVNpVjNUeWJkQkgwd0VJ?=
 =?utf-8?B?U0JTdzRXOUQ5elp1THdHRVJoNGx4Tks4dnNlQ0JiL1BMOEsxUTZIM0hOS0h0?=
 =?utf-8?B?dmFwbGJ3WjV1ZUFuTXlwSEJUeHcybXhSdkQ1YnkzU0RtcEVZQjZBNXpGUThL?=
 =?utf-8?B?TWNpMjhwNS9iSFVETXBSTGZYU1ArMzRJb3h1bXIxd0haWG42cXNMbW1Oc0VH?=
 =?utf-8?B?VURyOVM2SlRZdDBsZ0xDVHVPYUNKZGZNdDEwdnFyY1NiSHQ1UWVrbVpJRWx0?=
 =?utf-8?Q?1Z9E1omLfkkSfNkxolhLKf3rOI2B8IT3vrxlNnl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZndVYmhwUmk4UFkxODhUQ053Y1pKOFFzcTlkQWppbkJaNkRtMDlmaVM1bGpz?=
 =?utf-8?B?L0FhVURQTytrSE0vUWx5YjF2VFVJNkVLckxkanR1MGVHdW9jZnFScVBxYVBE?=
 =?utf-8?B?NEp2TngvbnNKOFlHNW1zbEJjTjRLWjl0cE9mR2RjdW0yTjhnY0srM0RyRnFr?=
 =?utf-8?B?YXIxYXhEQXpFNHVFa1U1cDdtaXMzb0d2SE1QM2RnU2diYWloQVcxUWxIMnUw?=
 =?utf-8?B?YjdKQU1oU21yTzhzdHlUSHJvZTIvMk9YMUJRNy9QVEZFTUhaSGs5dUdXL2Fk?=
 =?utf-8?B?QUFJQ3piNDV6TU9raCtBeDEvRGEvSjhWY0hZR3NQZzZDcktyOHRJMi9qOHlm?=
 =?utf-8?B?T0V0aFh0T1NQMWs4S1hJREc3L3VldFA4bWU2UVlYVDhvV0djQWE5djFRRGVI?=
 =?utf-8?B?TkNWTi9CQjNUWXlNUUQ2MXFpTFI1bEg0NVNXajRCN1g4NUljeVUwM3lkMG1P?=
 =?utf-8?B?Sk9OMUw3UlZDUXh2YS9ETXNhL25ibWV2TzZ1TWd0bnJ5NXNSaXQ3bnJHSjJD?=
 =?utf-8?B?TzY4WDF4ZmkrblBNQldaS1Rvb2pwcVdJUHpsZTJWZHQ2NGF4ekg5WjVucjVr?=
 =?utf-8?B?VzY5TWU0SkZvcTZnUjJkS1ZDSnBZVmpHU1dENHZGTlgzM05nL1pkd3hCaEdk?=
 =?utf-8?B?aldQS0dnb2szOUtLd0dhZ3RaVkFkSy9LbnZ2ZWcwZFBLR0t4NzV2NStXRW5k?=
 =?utf-8?B?SkJRd0kvQTlnV0FCdmZDSWpIVCs2Mi9sL1ZweDJzbURXM3diSGsrN29OZkhq?=
 =?utf-8?B?M2VuVWxwNXdtTlJ4T05uejhWN1p3N0V0a0w0d0ZOOFRpVlVYTkhQempKVmgv?=
 =?utf-8?B?YVJyZzJmWHI4OWE1K1ZoSHNsNXpSNXprK0szeWZpRHRUVHJNd05HVUs3WmJm?=
 =?utf-8?B?ZzJXalpTRVd2clhHa0YvUDVXZHBuNldNTWVyUkdkZUJXTjJ2Mm85QVA3MTJz?=
 =?utf-8?B?cW1kbHk0enNPbEQyL0I3UUxPRmZYWFhoY2JiVVgzUzlPUFhJcFBZMVViS2FI?=
 =?utf-8?B?eEo1RmdUb3J0OWJiZzE5YWpTY2hTVzVUT08vRWhHbnVITlZHRzhLWXJOQUlT?=
 =?utf-8?B?Ylp2eDg4UlhkVlJUOEI0UzZHdDNIYkp1bGZzMjBkU2UyUFVxc1Nxb0Q1blNH?=
 =?utf-8?B?ZVlJUEoySEhScEtJQkdrYUFxMS9DczIwT0UrUzNQa052VWhOWVd1Rk90eGVK?=
 =?utf-8?B?TGY1cmZCYitNWnZKdy85YVVmcEZ3VVh0UExzekppYm1aaGJlVGhOUVA0ZW9O?=
 =?utf-8?B?UXdVYkJneXNYTjBHWDBtYXIwczMyQnZoeWIvdzFCK096KzIxWC9IN2wwcHVz?=
 =?utf-8?B?VEx1N2JHL2lkS3RGb2cyQlhVSTRJWUJJZVpQakVxUzBMUVA3RHhnNDl0eXUr?=
 =?utf-8?B?dFV5UFA5L3VRVEY0RmUxNTdLU3g5WUNpQlkrWUt4d25ZOU1NV3l5NkNrNWNs?=
 =?utf-8?B?dEVUQktPMTZpaUk0ZU40SHczajBkbzdISGFnc0J4bVJTWEFJSmZZTnhhVGZv?=
 =?utf-8?B?MlhYRWRDWmMwczFNM0dIYlJNbko3SFBuT3NncWVPb21JZnB3bVVhTGVkR2p4?=
 =?utf-8?B?cFY5MzJYbXFSZjNMczBJdmY5MHhKMThYY1dHZm4wRk1DK2ZmaVFvcFlBYVd2?=
 =?utf-8?B?MW93dGViMEJ1aUxLTGJjcUhEVjEwVzJOazAwOXhVUVBSOVBHRVJnNG45YitF?=
 =?utf-8?B?TVZhYjFPeTlMbUhHYXBGNWZXdTN2TlhTeFJmRjR2LzgxNzMvY0dRQUlEZjhK?=
 =?utf-8?B?N3VIWHhoNmQwNXU5RW14VEl6NmpuS1c5eGVhbXJoc3hZNGhIOHNzc09UbnYv?=
 =?utf-8?B?T3g5QnpYUE9QWHJqakQ2eVVxVXFFeDJqNjk1ZWd2endqbFEvR2xPQVpoUEFz?=
 =?utf-8?B?bzU3RWdQM2tuRXV1clBzREpKS01qRnFLSVNXbFg2VENGZnp0UitDbUp6WjFm?=
 =?utf-8?B?MFpDTzlJemx1Zlk4SU9tckNmL2ZuVHF2Vk5la1NUOFE3cW5wclp4UHBsVGdC?=
 =?utf-8?B?YytRZDBXTGlmWmFuQld0SjFEVkpUUjluQjBGZnFXWU0zSCtSOWpQR0Z0MlN0?=
 =?utf-8?B?Ti9hZldySlVGUWJ4TFZZM2t5N1BBT0ZyakppY3FkckhLOEJINlVqcGxzcGtL?=
 =?utf-8?B?S05hQnJ2Q05HRkxUMDQ0QVRwUCtoaDBlVVJsYjh0b0FNdS9zOFVFSCszREpj?=
 =?utf-8?B?YTNaV3Rya05kcHZtTXpROGNoSUdmL2N0aS9Pak5mK0dweHF3dGUyekkyTG4y?=
 =?utf-8?B?WlQvTGRMUmFIdXg2Vzkydks0TTBnPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec782670-6c57-49a8-1104-08dc8992a726
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 21:16:54.3922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IjDRKXslIztL/iwssfST+Z1LvEfAhfrHYUHYTidOUOxg6nshRpZULGltXrhyw0J9ktaqZnyVGMCoqxfjf5doA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7199

On 10.06.24 09:58, Florian Bezdeka wrote:
> On Mon, 2024-06-10 at 07:43 +0200, Jan Kiszka wrote:
>> On 10.06.24 06:21, Jan Kiszka wrote:
>>> On 09.06.24 13:44, Florian Bezdeka wrote:
>>>> On Sat, 2024-06-08 at 07:31 +0200, Jan Kiszka wrote:
>>>>> On 08.06.24 01:04, Florian Bezdeka wrote:
>>>>>> kvm_wait() unconditionally enabled HW interrupts when called from
>>>>>> pipeline entry code. That broke the PV (paravirtualized) spinlock
>>>>>> implementation.
>>>>>>
>>>>>> When running with CONFIG_IRQ_PIPELINE enabled we always call
>>>>>> safe_halt() to allow HW IRQs to be handled.
>>>>>>
>>>>>> The !CONFIG_IRQ_PIPELINE part is now re-synced with the version of
>>>>>> Linux.
>>>>>>
>>>>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>>> ---
>>>>>>  arch/x86/kernel/kvm.c | 59 +++++++++++++++++++++++++++++++++++++++++++++------
>>>>>>  1 file changed, 53 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>>>>>> index 655b1cf8c9ab..3180a26cdfe1 100644
>>>>>> --- a/arch/x86/kernel/kvm.c
>>>>>> +++ b/arch/x86/kernel/kvm.c
>>>>>> @@ -1059,22 +1059,69 @@ static void kvm_wait(u8 *ptr, u8 val)
>>>>>>  	 * for irq enabled case to avoid hang when lock info is overwritten
>>>>>>  	 * in irq spinlock slowpath and no spurious interrupt occur to save us.
>>>>>>  	 */
>>>>>> +
>>>>>> +#ifdef CONFIG_IRQ_PIPELINE
>>>>>> +	unsigned long flags;
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * We always use safe_halt() to be interruptable by HW IRQs.
>>>>>
>>>>> Nope, see below.
>>>>>
>>>>>> +	 *
>>>>>> +	 * HW IRQs off:
>>>>>
>>>>> Let's stick with the nomenclature "hard" instead of "hw".
>>>>>
>>>>>> +	 *
>>>>>> +	 * Wake up on next HW IRQ or by a vCPU kick triggered by the current
>>>>>> +	 * lock owner.
>>>>>> +	 */
>>>>>> +	if (hard_irqs_disabled()) {
>>>>>> +		if (READ_ONCE(*ptr) == val) {
>>>>>> +			safe_halt(); // enables HW IRQs
>>>>>> +			hard_local_irq_disable();
>>>>>
>>>>> Just halt() - if we entered this with hard irqs off, we cannot assume
>>>>> that it is fine to take an IRQ before returning. The kernel doesn't do
>>>>> that either for Linux IRQs.
>>>>
>>>> ACK.
>>>>
>>>>>
>>>>>> +		}
>>>>>> +		return;
>>>>>> +	}
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * HW IRQs on:
>>>>>> +	 *
>>>>>> +	 * If inband IRQs are disabled the LOCKDEP state is already correct.
>>>>>> +	 * We can disable/enable HW IRQs without further bookkeeping.
>>>>>> +	 * = Linux IRQ context
>>>>>> +	 *
>>>>>> +	 * If inband IRQs are enabled we have to inform tracing / LOCKDEP
>>>>>> +	 * infrastructure about the HW IRQ disable/enable event.
>>>>>> +	 * = Task context
>>>>>> +	 */
>>>>>>  	if (irqs_disabled()) {
>>>>>> -		hard_local_irq_disable();
>>>>>> +		flags = hard_local_irq_save();
>>>>>
>>>>> Why this? We have tested that state above and know it for sure. Just
>>>>> keep hard_local_irq_disable().
>>>>
>>>> Paranoia and to clearly express that we try to restore the state to the
>>>> state that was observed on function entry. As hard IRQs are/were on the
>>>> result of irqs_disabled() might be outdated. (I think that would be a
>>>> Dovetail BUG(), but paranoia...)
>>>>
>>>> No strong feelings here. I can change this if this is preferred on
>>>> other ends.
>>>>
>>>>>
>>>>>>  
>>>>>>  		if (READ_ONCE(*ptr) == val)
>>>>>> -			halt();
>>>>>> +			safe_halt(); // enables HW IRQs
>>>>>
>>>>> Yep, this is needed to avoid delaying hard irqs while waiting for the
>>>>> Linux lock-holder.
>>>>>
>>>>>>  
>>>>>> -		hard_local_irq_enable();
>>>>>> +		hard_local_irq_restore(flags);
>>>>>>  	} else {
>>>>>> -		local_irq_disable_full();
>>>>>> +		local_irq_save_full(flags);
>>>>>
>>>>> See above.
>>>>>
>>>>>> +
>>>>>> +		if (READ_ONCE(*ptr) == val) {
>>>>>> +			safe_halt(); // enables HW IRQs
>>>>>> +			hard_local_irq_disable(); // fix HW state for LOCKDEP
>>>>>> +		}
>>>>>> +
>>>>>> +		local_irq_restore_full(flags);
>>>>>
>>>>> How about this instead?
>>>>>
>>>>> if (READ_ONCE(*ptr) == val) {
>>>>> 	safe_halt(); /* enables hard irqs */
>>>>> 	local_irq_disable();
>>>>
>>>> Confused. I think you mean local_irq_enable(), right? Otherwise we
>>>> would jump back with hard IRQs on (again), but inband IRQs disabled.
>>>>
>>>
>>> Yes, enable. The goal is to avoid that hard-irq back and forth.
>>>
>>
>> Actually, there is no need for this dance at all. Just translate the
>> Linux version of the "irqs on" branch to dovetail:
>>
>> 	hard_local_irq_disable();
>>
>> 	/* safe_halt() will enable IRQ */
>> 	if (READ_ONCE(*ptr) == val)
>> 		native_safe_halt();
>> 	else
>> 		hard_local_irq_enable();
>>
>> There is no reason to touch the Linux IRQ mask. It's open on entry, and
>> we can take any type of IRQ while waiting.
> 
> Correct, but we would miss this hard IRQ disable event in the tracing
> infrastructure. Is that OK?

Not sure if hard irqs are actually traced. I thought they aren't with
the given functions. If they are, you are right.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

