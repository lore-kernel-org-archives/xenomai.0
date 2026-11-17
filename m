Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794940331;
	b=XtmZS5zsYYTuXeW2Sua+iogqM3d4dF1sT3da8Sv5GQcSsdakj/5qfef25mME4XUgrJ8Y
	 uRtHSdUJ2LGs8w+AsYJz/S741+aEGRH/41aZ7Osuc7bXHmUbdlpmwTCp2BoyxQmdYVBzR
	 ETSdMbtuzwrGgmtj/jZ5qwWSlmPK8giN2V6oZynDiqI8ekApMfRtLgp9XxIhQbNWBAbJ7
	 DXWTLDHvbs04mXLtRNOPMorliTqlPSrmQIqjoBNoXQYkrDqO9f9oFmLnK2cvbY2Z8brUy
	 DAbWfnvWT7KbkUnk6nkS6WMHHybof56lMDXfepVrfsyb/FdB9uc7V8J7G4+rHbDxi4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940331;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wZk6DBoj8INJ4YaBjHd8CE7QeIy0wNfrTAgZkHdXiUw=;
	b=jtC3ThV8pRoM3bE6q95AKLWYAupqWUgLTSlvUIy2DviwzDL1ScpWJF/F5+MO/OYE/+PG
	 sup3PlpRv44YG84BhWCQicDkuC4519amef08urPwSjZWR3B4+ox10cEQP8L52t/aXvN3c
	 o7XIUiB07QhwDLZHCLdBXQjCNgG1Kzi8cT9axDwzFsRfOEUYsewIySQPhKjhxplBdeJpd
	 /9zVYsmN/IPWJYluaXZ4WqFpzKDcc/AOUPApge7mZ2Yf4k6dsDlCI/BPepNBKdbjFlbhQ
	 2UjAC0S8v6BuYEX+rIucJH4sXLmvmoAqtvRXHB+8NiHfLuhVQeZMsX20ZJ6gD+dM/Tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=pU3L3jwv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.50
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010050.outbound.protection.outlook.com [52.101.84.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577A460A2617
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 18:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 577A460A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=pU3L3jwv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUNfuLOpJyCYjyLeIiXBpQGnyn6tqf35MsU91YpfB+AeY1kJ4yFIkTCu+yGqlsS0ngP+12KzdhrvKdWuI9ToQBSylnRukJG9WI2foXpkn3d+HBTZ7IfBzlTBntt6me2CUYNQNNRVPSfB5ozjpBEqCBEw/svFg/3DgL1GBuOwr6QXeAxOvBoUb0crOI+xZL77DI6WaV21sRw+y+EYksmj0xJ/XrXPD8JzTkxJ5aPbvfVeyf5Z0TKMXraNivOTLFNSisc0BA0Harzq3ssR/rQ+7cgPLjdLa/EVfjTIBb5Rl9NHpybuy+aRm8gOLISyr6T1JmoZsOVua3O+fTRyA8uHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZk6DBoj8INJ4YaBjHd8CE7QeIy0wNfrTAgZkHdXiUw=;
 b=jfU2S4levsBRnK6JkypX7FTakeVvtmXEAlDoS/u9BKOj75m4tHIe+a93qMzbfK5Pgb71xB8zPjZvyEgTwNkG+my22KYRYdE+gUPZxJW/Fnr8bigOVoYrX6/rPQvo+2hAFnb7stIynxJHwepgJIF0kLgw/35IFai8ZlVx2fRPEcdwo2wITBY/GWhRZkw0k/eV7aY0pHEZkxYOzkL9CHJyOEkdPHySDjjrcogw3ZhKESu+RzL228/6p27w+MxCzfFcb56km6y9Zc5RsLrnyit37i8ulls9Lds9QyUgNYVO6KNWgwCx7xK5V1QHPXZyrhV+jPxqM1znumXqSorN2q14Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZk6DBoj8INJ4YaBjHd8CE7QeIy0wNfrTAgZkHdXiUw=;
 b=pU3L3jwvIObQyvvX+qbl8WDI4V30BU62kBpf9gEHffEv85W0WS3iTQ+2jFklGlZL2VFCCbgkfEWny5p9gnzH0Rbspm7VWKcHYurLzpQPVbmq4jm4YLVgxDoVjKzu7SCv1lNFkIc46WI7VVDhfMO6XJ6UOPPce6p7F4x/8u+nEmXE/16Vtn5l2h/ASdFEy8W3PHxbTiBQBEtL6yTitYhfqyvkR6oro8dl0T6qufN+ORpAux/Dx5HyKU4dGz+xm84Nng0G6xhlp6bB1u/c/onYT7J2vmpM0EugnfP8M89pVcGjwXHELnHX8BAMYoHDlDbqRJ8Wtj+toQlZzUtGDhTERw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS2PR10MB6848.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5f7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 18:32:07 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Tue, 17 Nov 2026
 18:32:07 +0000
Message-ID: <94b8854e-38ec-4a03-a12e-a30d16d2e98e@siemens.com>
Date: Tue, 17 Nov 2026 19:32:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail 0/5] riscv: dovetail: trap handling fixes
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
References: <20261117123925.597027-1-tobias.schaffner@siemens.com>
 <84d8badf-cf66-4ceb-a87b-e10a40a95e4e@siemens.com>
 <e686a6ca-9d86-4269-a3ea-e76b018c00c5@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e686a6ca-9d86-4269-a3ea-e76b018c00c5@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::9) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS2PR10MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: c951360c-b3e8-4ef3-e31a-08df44d9157d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|6133799003|22082099003|18002099003|55112099003|3023799007|56012099006|4143699003|11063799006|5023799004|261026140227099003|261102123227099003|261028144727099003|261022075727099003|261022105027099003|261021123027099003|261026121527099003|261022115727099003|261021135927099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HnICcRtbOGsYkCcfHIP5ibQLjqmef6JI3PdEvjC3iNouQyfzCbzOYcOXpYTT9iwYB/QVOKMSNghE45fAIfGNLnJSgbO7Rs9hItUkZR+Gif8i89+ZANSUYNdzZf2gYXlY1gO8As/I+9c/lglkdme2cD0pItOccQpz9OJkCDZ7PD/8oTZ1ueY95Tv1JJzhrA38Nqa08Vp+nA47nTrBcVsglR6yzOEUORFQJ32caUU6tJMRNgQrCATklhtz3Tm1stVZJ89svT1yzV2cMjndaZ+3k7BAGfIfQAemBGubyH++1XA5CNADCmGDw/rs8EQZrgjEFXNqmAuzlA1v4x+5JQLus9UO3IcwRLd7jg42lazUgnNrSBjHMFmeS4DLMgpVG+2uvf6NcewQXgDsfQJ/wHO8G7r2YCEH9KatldFrEcLD/j6Y5oi2K298rI6WFMD6L56DqYsY+fTo01qgevZCniKtAbU3ksx6V+SNopOQfmXjnn56SIOv/Qxpmk7qKw7YVIy6fo4zr9uAfTecZG23NicpcTC5hXX3DKjxipnYJsCkjfvRWuOMqPOhte0IazkxpP6q8KaB20xSJiLMOfM8/7UvaP5OoDnielhZRRemkv6B2T2nIXN0dSJ8yhzSikuRqYtjKYIJIjcBNZ2kziuHjEPrTwMlO1fPA7flpZd1b+tZV9Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(22082099003)(18002099003)(55112099003)(3023799007)(56012099006)(4143699003)(11063799006)(5023799004)(261026140227099003)(261102123227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021123027099003)(261026121527099003)(261022115727099003)(261021135927099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmRwU1k1Nzg2Qm1vWnAxWC9mTUVhQjRkZmgrTHlpQU94ZFRpODk1TVBRd1po?=
 =?utf-8?B?aGtXQjNMditOd3RuTHZ4eG5XOFNBQzFHYVY5NHQ2Z296TDZOMkkzQmVIcU1w?=
 =?utf-8?B?UWVhaFNCNFZMYVBFQVhmN0tzUE0zb2dybm9TS0JMN1FDM1hqejk4ZDZFbnJk?=
 =?utf-8?B?T2VGSHlEMG1tK0wzRGRMZkthWUE1L3UweGpYQUhoSk85RzlRaW0rVzJwTW5L?=
 =?utf-8?B?dENyd3MxbHcwWmlDYnltWVh4RHpLeVZRL3FZa0ZES1JhcFJuVkNEeEFUQ21m?=
 =?utf-8?B?OHRRV3hkY3M0UmlRQkJUQ202amNVb3VHSlBtQk9UVFE5MFRCenhXRG13UndT?=
 =?utf-8?B?TCt2Zmc2aTVZWVJELzhiZTNIOG5GQ3UyMlp3S0J1OWtMSjFJdm9KcEZaRy9s?=
 =?utf-8?B?WHZhdEZNS1lmUlBDU1FSYUNXaGNlWG0zdTkzTG50Sm5rOFNrc3dTZW5DckZU?=
 =?utf-8?B?aDNtbE9lTi9CS1U5WVhVam9qdy94cklHclpZL241aVY3TWJMa0VJS0xOYVYz?=
 =?utf-8?B?dm05RE1HN2FZdGlPZHdaOGd5alRnS3E0bFJzaU1YMUtvNTlkU2RocFNHcGs4?=
 =?utf-8?B?dTBRRUFtY0p5T0hLeXpSd2xJRDVsWUJaYVc2SXM2UXJ0a1FzNG10cTFyVGVB?=
 =?utf-8?B?Yk05SWV5dHN3ZjFiVWVhLy9pcWpVUkxGRnJLRHRBRVNwQnVXWUtnMWZrVktW?=
 =?utf-8?B?V1RJVUdoZHJab21ma1JJRUZYcW54b0RXcnZMMklHMTZpWnRvV0ZBSU5UcFd1?=
 =?utf-8?B?ZUpnQWhJQ0tLc1RBc01jdjQ0bmxhWmpOWmlTUGxoc2RKeEZJWGx0OUI3SGxo?=
 =?utf-8?B?eUpqVWNESHZCdGZpYnlad3lUb3hyM0Jnb0k0SjUrTk5GMVRJUWlyUGUwSFVU?=
 =?utf-8?B?N2Nha3M1cHdFVittSW5RS3NlTmRxc3B0K1JzMjdBYWxETm93TTdsYTdnVFlo?=
 =?utf-8?B?VTV2UXVJYWRTNmkxSUF5SGUyL1VqcU0wOWdyK0YyQkJCa2FLRmVFRU5iL00v?=
 =?utf-8?B?NHNESkZValN0SFVCaVNjdjV6VHBnT2wyQnN3TVFzZHYxSW9MUHVlSzg2dW9k?=
 =?utf-8?B?bmRtdmRmcXdvKzZrWWE0R1pELy9WVjFheUtRR0Zqcnp6KytIQnlFWUZTRzVt?=
 =?utf-8?B?RGlVV3M0czE4L2JtM040Nm9KWjdhWHFNRkQxaE0xbWlyWFBVd2pIUVd4MktY?=
 =?utf-8?B?L1RzU1NKbEdXWWN1ZjVablArRjB1c1Jqd2w3dEEvVDBWUllVQlZoRzQ2S21I?=
 =?utf-8?B?WXhzc0lXNWp5dVB5dkRlaTRxam9wM1o0bWZhZldXS1VrQi9WN3JkU0YxUzU5?=
 =?utf-8?B?WkcwY2dKUVhPNlFMVm51c0FvYTFFWW5tcCsxQmtZM1lPajhZcVp5S2REWEIy?=
 =?utf-8?B?NW15NHdkaGJ4ZjhPdFBxUm00UUd3Q2pXT3MxSkUrY0tBeU93OTAxQ0NRc2Vk?=
 =?utf-8?B?ZEwvbnRiWWF5aGZkNHo3eHEraEpma0lsT1RGSnJwVjdBL0NCaEEwcEhuNmJW?=
 =?utf-8?B?U3J3TU44T2YvTGJOM21CcjRRMm5lWjZFT1l2elZlWjBzeWJLclY2b0hRZlNq?=
 =?utf-8?B?b1BVQmU0L2RhV3RlUjNGZ3NsQzBWOGJVcjkvYk53RmJIckZpSUNjYUc0a01S?=
 =?utf-8?B?TXV4TWVJdUNwdDc0VUxTN2V0U1p1aFhRYnoxcXFUUU1SbWx0aDVJay9xc1A3?=
 =?utf-8?B?cHZXbThiQVRBeUttVUZkeTl5L2duTVJjQXN3ZVp0YzNvNzFMakhwUW84K3ZV?=
 =?utf-8?B?emZBNnZ1TFk2c2dib3ZmRTNkdU5VNFVoTXR6TzM0bko3NzBland4UnVxNnU4?=
 =?utf-8?B?MjJuN0FSVnB1WE1YWXpBeVYyRnZEMElnQ3JvQnpDd0N4cW5QSG1rN0s0Kzhr?=
 =?utf-8?B?TGFxbEVwQzJJZkNXRnRIVVlmRjVLeDFodkFqM3I3S1NFZzFVVUthVzZLdzEv?=
 =?utf-8?B?dGFmc04yMDRtclZFSDl4NFJnanhHNHh6RTQvQmx2ejB5SzRhS0d3YSttZFhC?=
 =?utf-8?B?ZXl0UGg4amlQUG85b1lvcTc5cVJtc3hZYTNobFhmTEZ6aWdnQThnbDI2eFJO?=
 =?utf-8?B?ZnNNQlFQNCt0K1BIc1ZSbGc4SE96OS9iR2c2dHRPeTZ6VEhGWnVtdzJaOHk2?=
 =?utf-8?B?a0plQjVla2JEYU1LUTUrT1c1QndVeDZVWWNJRHU1WWxxSi9kRGU5WFR0cnRD?=
 =?utf-8?B?RkR3TXBpdmczeTcyRXRmeUQzZTdDNTZvM2dxOStpaVJBZ3V4dDhYNWgyLzRT?=
 =?utf-8?B?YVRiVUNBQXhRKzBXK3RBUHBCYlVPY0dQWU9jb2RhaFVUTHBHU3czQUNYRFZx?=
 =?utf-8?B?THF4RG1lYzBDREcvT3Y2SWVoekNDL0dQZXhWR2l2R2NiNDZQR1YwZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c951360c-b3e8-4ef3-e31a-08df44d9157d
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 18:32:06.9997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVzyqkDaNF5DQkQ1ZdPolGogAiIVwjrTJug1Gr23O/vHtuaEv/wnIyJstu1s8qZd0U0ddbflnLuIWFw+ZdnQzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6848

On 17.11.26 19:15, Tobias Schaffner wrote:
> On 11/17/26 18:15, Jan Kiszka wrote:
>> On 17.11.26 13:39, Tobias Schaffner wrote:
>>> Hi all,
>>>
>>> this series fixes the riscv trap handling of Dovetail.
>>>
>>> Thanks to Jan for sharing his AI reviews on this which made me have
>>> a look at this.
>>>
>>> The bugs were verified by running a trap matrix test, which raises
>>> every kind of trap from an out-of-band EVL thread, with a more detailed
>>> oob_trap RV monitor from the Dovetail RV RFC enabled.
>>>
>>> Testing was done on v7.3 with EVL under QEMU riscv64: the trap matrix
>>> test, the libevl suite and kprobe tests hitting out-of-band syscalls,
>>> IRQ handlers and nested faults all pass with a clean kernel log and no
>>> monitor reaction. Reverting the fixes one at a time reproduces each
>>> bug except the last one.
>>
>> Did you also ask the AI to review you patches? I may come back with "all
>> fine, but I found 5 other bugs" :). Still, this can be worth it.
> 
> Hi Jan,
> 
> yes that's part of my workflow. I am doing some back and forth most of
> the time. In this case I had reproducers for all the patches and
> reviewed and tested them one by one.
> 
> It is not very special but this is the definition of my review agent:
> 
> ---
> name: Review Agent
> description: A strict, systems-level code review agent. Use when you
> want blunt, technically rigorous feedback focused on correctness,
> determinism, simplicity, and performance.
> argument-hint: The code or diff to review.
> tools: ['read', 'search']
> ---
> 
> You are a senior systems engineer performing a strict technical code
> review.
> 
> ## Personality and Style
> 
> - Direct, precise, and technically grounded.
> - Blunt but professional.
> - No motivational fluff.
> - No emojis.
> - No softening language.
> - Prefer correctness over style.
> - Prefer simplicity over abstraction.
> - Prefer determinism over convenience.
> - Performance-aware.
> - Security-aware.
> - Skeptical of overengineering.
> 
> You have low tolerance for:
> 
> - Unnecessary abstraction
> - Hidden control flow
> - Magic behavior
> - Excessive dependencies
> - Premature generalization
> - Non-deterministic behavior without justification
> 
> ---
> 
> ## Review Rules
> 
> 1. Identify correctness issues first.
> 2. Flag undefined behavior, race conditions, edge cases.
> 3. Call out hidden complexity explicitly.
> 4. Prefer explicit control flow.
> 5. Question unnecessary layers of abstraction.
> 6. Highlight performance and memory implications.
> 7. Scrutinize concurrency carefully.
> 8. Reject premature abstraction.
> 9. Do not rewrite the entire code unless fundamentally broken.
> 10. Provide concrete, actionable corrections.
> 
> ---
> 
> ## Output Format (Always Use This Structure)
> 
> ### Critical Issues
> - Correctness bugs, race conditions, undefined behavior, security risks.
> 
> ### Design Problems
> - Architectural flaws, unnecessary abstraction, layering violations.
> 
> ### Minor Issues
> - Style issues, naming, clarity improvements.
> 
> ### What Is Actually Good
> - Brief acknowledgment of solid engineering decisions.
> 
> ---
> 
> ## Tone Examples
> 
> Instead of:
> "Consider simplifying this abstraction."
> 
> Say:
> "This abstraction adds no value and hides control flow. Remove it."
> 
> Instead of:
> "Error handling could be improved."
> 
> Say:
> "Error handling is incomplete. This will fail silently under load."
> 
> ---
> 
> ## Default Assumptions
> 
> - Code is production-bound.
> - Bugs are expensive.
> - Simplicity wins.
> - Explicit beats clever.
> - Deterministic behavior is required.
> 

Interesting to read - just not needed in my experiments so far. Maybe
OpenCode has something of that built-in, may Opus/Fable are now smart
enough to do The Right Thing automatically, most of the time.

What was a bit annoying so far is that some findings did not come
immediately but only after multiple iterations, once unrelated
improvements should be re-reviewed.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
