Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0762EEE9F
	for <xenomai@lists.linux.dev>; Thu,  9 Jul 2026 05:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783573428; cv=fail; b=M8Qo/pH3O0Q7s6X1eJj4IQZoCiT0gjHpWcR4rpLMoFM/iclcoRauv50v+VNuLND+mp0AB8keimLsBgLm1hdfqJJuiYBwu6MpbTR8bPWyYWBHWE/Me2N85wrHwVXMS5G7oaTGvrf7SAkMXRXEVERsVyIfReALaPVPX7n25xRymgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783573428; c=relaxed/simple;
	bh=Yn+KG87bZnhmagnh3k5o9TW5l+CKMEOWonioRIunSfM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kntDSecjbGicWmZEy8x+5S382OQHYWS9qyOsKCIyRjP7u6AZLKV/X/sB7bee2URYeLkEO6pj7TVi/0YJgxiQjY5T2eS6+fzKnbWwsQ+rEHREO4kMkNHvhGM5C7fekO+AZnOeSXXuzU496qRBfDwp0Pi+Sd8FwPa9u3mp8S09g8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bXJ7z6lt; arc=fail smtp.client-ip=40.107.159.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bXJ7z6lt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BacACAnEaUHq4tB5B9J3m96ALHyE/rFgIv4SYe7CDnyUVidGWaK7lmyXLMbFUDHOUyT7gG5Tt3NNRfgC9USbZ/vCU5MqV8cuhyULqoKpr51NB7Ij1kTkbnwNKmBOvoT602QeTKEeqZdWwS4C+wAd6HsQFk5fjbZ5dN8AEZHmUfLS595WIJUqKS/bInFy8pnIb0LAzjyGDwN/WeOIlKH2Eb2+gjrnGFpEzao2VtCN6S4ur4o3q77AiYXBhmIPBw0TDc1hRGWXmkMKFQnxiI7bWotKqoAUPae3+uDwHsAWyVmzk6ZEmx2+zFz1I14OmaIUn9ytTwbiLpJDWKeSM7HaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNzz3gp61J2atze9Ycy9VHQIjRj2eVH/uYwtwWU9u60=;
 b=Cb1owRGt+yQs8X3wUDnnaTGfHpqXlKRBMDTZHchrMb9X0ICMoThXVDZmgnFeX9l+mDrI9sxryuSCgcPYWovTBCABXqkDqVy22Wa5ZkifS3r1Q0oxpnXbrfZBVrLy/l+nOTjoK5rkfRlY3ShB3u6ZN3R8sTYYkU2cnIdY8GWyV21KhDYJ6XTmzPDl96Tt3W3NOJAWn9xg5iP8hGE0QG9NtPCC/IQIqNSbm4sr45jDn9eiKtMbxAj3qTQI/iyJvGlA4C2wMJLkXsi+HjnM/PbSpQadOW58MQAWHLtyD5dfMmC2fLCsi2Fum223vC8TYR5YzKHpz3b5ZxejbQ22cp8tMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNzz3gp61J2atze9Ycy9VHQIjRj2eVH/uYwtwWU9u60=;
 b=bXJ7z6lttbKAn/+VETczDHS1haCsvbrjIIQ7KvN+62GWVhM8/y3HZDhHt8H52dzkn0JKsrOwYB7nHs0oLwMeEymjUYB8bY5JRBAfBTHSw8l7V2JjD4vFpsKBM50umTvmsEJbbZfx4WSgfQ84mWb7RXPzqkhhOCfTFRoKaprOWtZetNDfYX9yxy0Txj1Jfo9LB0iuN6rsnFEU7xQI96NiKB+CfAheFg0FIfiUW5Rm+j/hTqBjQt4zHdUs+vr8YGIulHxAgDCKmXK7DSo78lg90pVMjN+MuiHt3mX5+hhqhp4pLcY55P+e9bG4hXBzPHvkh832hmMnf83szkS9IoSsYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by VI0PR10MB8404.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:231::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 9 Jul
 2026 05:03:42 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 05:03:42 +0000
Message-ID: <95f135cd-c4d4-4376-a72b-e301abf4dc8e@siemens.com>
Date: Thu, 9 Jul 2026 07:03:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] linux-xenomai: use the wip/evl-riscv
 branch for riscv
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20260708194021.1236842-1-tobias.schaffner@siemens.com>
 <8c6ada2a-b6d8-4665-b3ef-61774e919df9@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <8c6ada2a-b6d8-4665-b3ef-61774e919df9@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::8) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|VI0PR10MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b5dded9-3f7b-47d1-2fd0-08dedd77728c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|23010399003|1800799024|366016|18002099003|11063799006|22082099003|3023799007|4143699003|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	E2BQkJ3vB6bQf27S5pvkmNWN067EDyuK6G6AgX5U6a4zGq6XSlLtgpKVuo9dYbqMcpeHKiH6s08Ugj3ekYRBd2TRFIL7QD0MbOG8zCcE3c35YdfmgJ38FMWCuOF76d1K7wUz/dCcXSlB8ApgLFm4blXCmskj4wVQBbRuVioLuC5fZmHMhJ5GVMthpAjTZcjhJUfmp2UW3MK07bREjZiJDrA158pydEoTuxEP6+JC8a/fu+83KEoKF2lmxjzGa//NM0ER2dJ1iZloxZEyYaBBmPEpJfOYR9ZUmmhVAVEuQ9Fl/RjQinjjhnlyouSpA2jiKduw/wzjZwZrtOiBTGZ0OZQuK3+lcpkZD3R7SyrOfkeyV0dlKjxpt2pYqlSo3yXd1F00KMz6O3gRcBkiN/u3RR3WWeyANejqcKjL/uPKdVvo7hNg4pPdw2eFPLBTlncA9NR4bCODXx1B3v98/soAg1AOEGjpi5ojtZ/xM9lxLAyR3icxvynhwBghYv1pQhuYuWZaDPRyttGAO3of1UvXLJrjpvHgfUaHcnY0KpI9bKD58llg6x/tdptE5vCyi5sK2VAUaOXdAQk8nzVORfNEIlCMcnjGebg3xN4u5OqWipdVwibc43kWRu4y8KJbujjw9FXOe2M4r0oS9pDarkjZ8zJUNgF/73vNJc4ytWeiMlU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(23010399003)(1800799024)(366016)(18002099003)(11063799006)(22082099003)(3023799007)(4143699003)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0RRY0NjaGdEVGIrN3JSdUoxOVFKU2haeFQzRGI5cFh0VjNaNXpiNlZmVFJv?=
 =?utf-8?B?enYrWUZGZGVvVzYyTWgzcjRFSkRtT3JJVVFuUzBaMEt2bnlENWZ1L0ErQTVn?=
 =?utf-8?B?cEg3NWdya2dmL3phTFgxcmlJbGlncXU1b29BM2RHbExDVjJHOTdEVUIvdkRJ?=
 =?utf-8?B?VlB5UjBtWWowbkxFS0FlaXNlTTRGMzM2WkNyd3haUkFIUWZ2eXNuVlhEbGl4?=
 =?utf-8?B?VTJ6WFpiWjRzWk0ydHgyVnYvaXlLWlNUcDRWSEtydjN6ZHdiaDB1VnhNRFVx?=
 =?utf-8?B?OWNnYzJ1eFdtOW5ocW01SHluU1I1VHRmbFhoN1ZmL2VRMXpTNFRDamd6L3RW?=
 =?utf-8?B?bzBzM3FRY1puanJnN1YwZUhJd1Fmb2hTcFRHS3lvZnNSWHhJTmdiQmJ4VXRJ?=
 =?utf-8?B?bEUvSWp1OHRQdFVTK1NSOEVhdWg3RC82akhEaCswLzAyd1FQV3ZTVHdIN3Jy?=
 =?utf-8?B?Y1hIckU0NWkwcXQvdEFER3NCT2lDSzJqSTFLRHpyOHZQK2R6MzMvempkSUZZ?=
 =?utf-8?B?cDZyZTFoU1MzVXFSSkxQblA5RmErd3VaNVlpYlMzK1hsREY2Zk41RGQrSFg3?=
 =?utf-8?B?K2tBR01PQk5neDFBL3d4UzI4MFdWQUQrZjZkK254QktRclVGS1NGODNZcGxk?=
 =?utf-8?B?V2xlaVlEd25CaDVnYXBhZnRHVStVSDIwdE9rem5WeVNOUXBBWnE5NzRPKy9J?=
 =?utf-8?B?TnNtK2VlTURkWWdkYkVJRW92ancyckptL08vSGxxR2RjTzNZVUlUUC83aUVp?=
 =?utf-8?B?Wi9SRkxLUmM1VGlKenFLYzd0R0VRN1hPdlRJNjBmdTdBVW5VMkFiMXE1bWxX?=
 =?utf-8?B?SEFKQTl0VDBNQkFIWndPYUpBRWhTODZsK2tZRkQ5OXp2cllZUVFiOUszTkxJ?=
 =?utf-8?B?TGg2ZmZIc2RISEVJOGhpSWc4RUdHTWsyR1F3SmV3Z0FaQ2hxM3ZkZFVER0hD?=
 =?utf-8?B?REw5ZDQ1WmVodU1QTm5GZmpBQ0dadFgzTFZnT2orMzRndytlV2RaWnlmelR4?=
 =?utf-8?B?S1pFTUl4WWpiMTNhdzZJbWo2ZEp2NWlENkZqL3RYQXlYcEpHT0tERXVrSkE1?=
 =?utf-8?B?ckZERXRlU2xKelNFWk5ONnFOQU9ZVlNSOVRvZ205MU5EUVZtblI5cy9GU0JH?=
 =?utf-8?B?L0FZY0N2WS80TW54YWplQ1BLR3E2c3J4aEpvWGNNbkIxVGJQS09GZWNpUVZz?=
 =?utf-8?B?TGxKTnhFMk1ITDZ2aUQzOEorcFY1NkpuNjlKSjJoRm5DSnFHekxqeFhEcGN5?=
 =?utf-8?B?L2ZmNlNEWTJUdlFjTEJRSmJISzVRU011b1U0RHIzK3gvSFh2U0JLbjNOclk4?=
 =?utf-8?B?TTNGZkdDVGduM2R2K3Vud2JTaDJzZjZkTW42WEhib0pnZXdLeTRkc1lZY0JE?=
 =?utf-8?B?aUlyZ1JxTC9rRDFybjJPdUxhMDh6NXZrTnRNUXNqUTZyYTZFZHNSZWNiOSt1?=
 =?utf-8?B?NVdwZE1sdDcwVFJiRlpYTTRINlVUZUZJOFp3b1J2bzNtTGJiSit6TjcwZnpH?=
 =?utf-8?B?TVBBV1YrYlpLRVVhQlZ5aUQyNkp3M2VIWEpVazR5QkFOZ3N5YnRxblY5aFJ0?=
 =?utf-8?B?RTJYU2RYN2x1ZWh3UzFsNUtZTU0xS1hjRXRKZVdpTGtYcWhsdTBKa0dQTUF6?=
 =?utf-8?B?TWMzUThnRU9xamswdjYrL0R1bkU2VUt4TVoyREQ2VllVdVF5aTViSXFCdUxO?=
 =?utf-8?B?aXlqZ0hmWnBKdXFyRWVuT3BWakJtN05TMk1YODlaS21HV0cybmIybjBYSXVT?=
 =?utf-8?B?akp3S2NudDJMbDkreFgyeStvdEVYQTByL3RuK0dlc0Z1NnB2RjBsWXR0elFq?=
 =?utf-8?B?RnA5bWVYeFovdE9nWjh4cERwWVdCQjlOOEhabXZZU2U4NHJ1Y0ZEZHlsMDhN?=
 =?utf-8?B?L2gzOS8wYnZuSmprc1l5WlBPdWI0N1RoUDVqUzV5WnpsbCtpUWRQS2o3a1JN?=
 =?utf-8?B?YVpDZjF5c0pVU045Nm5odzFRYU1IcXQwMGs5ZVJNTDJySDY3QTFZOFJ1dzBF?=
 =?utf-8?B?T3ljMUNFK0J4QndNTm1RRVJiMUd2OEZ0cGoybGRMaWY2cVhKOXA0M00weHJI?=
 =?utf-8?B?bDhyQ3NiRW5zVnJsZ0FxUXNZbGx5b3dzdTNqY3NJSnBSTGl0NDg5RzQyQmkr?=
 =?utf-8?B?bXI0VXFDSVlGQlJWdGc5anYxNjJweXdoQ1JzRVB1NW5CNitZZkJDSVladkdT?=
 =?utf-8?B?MUQ0UDBucnZEc0QwT1pKeWhrMkMxeUZxUlI3Y3NyRUtDU2lqN2N4UDEwaWcy?=
 =?utf-8?B?TXdMSjFiUy90b0FrcFJCckp3WHNXZExKbW5GbE5ING1GWEtGdXZnZmpGVWll?=
 =?utf-8?B?NEJ2dHBNeEhWbjI1SkZXM0dPYXdhTmhkRXA2NkE5c1FWejZ0QTJwTFpDTTcx?=
 =?utf-8?Q?ym90oT0eK8GW4dZpXdGtteyrteghnP4J4SvbA8cPS12rb?=
X-MS-Exchange-AntiSpam-MessageData-1: jRn9NOhh8NqzcqLpbu5ywvtYgLUwX3fCx/w=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5dded9-3f7b-47d1-2fd0-08dedd77728c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:03:42.7307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLiwG6o4cdFtWGBmvvjx4NB7PXDnlbI6LPucCQG1TXmQ/MPyhvjbQcC78CunFTOZHU7fzOvKblxRpvB4zMAxVmlb1UAsQMPE0r+NpsoxtZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8404

On 7/8/26 23:26, Jan Kiszka wrote:
> On 08.07.26 21:40, Tobias Schaffner wrote:
>> The wip/flo/v7.1-evl-rebase+riscv branch was a temporary branch
>> for integration of the riscv patches into 7.1.
>>
>> Switch back to wip/evl-riscv which should generally hold the
>> current riscv patch set ontop of the latest next.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>   recipes-kernel/linux/linux-xenomai-4_latest.bb | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
>> index 48499ca..a542e80 100644
>> --- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
>> +++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
>> @@ -34,7 +34,7 @@ GIT_BRANCH = "${@ \
>>       'v6.12.y-cip-evl-rebase' if is_kernel(d, '6.12') \
>>       else 'v6.18.y-evl-rebase' if is_kernel(d, '6.18') \
>>       else d.getVar('LATEST_KERNEL_BRANCH') }"
>> -GIT_BRANCH:riscv64 = "wip/flo/v7.1-evl-rebase+riscv"
>> +GIT_BRANCH:riscv64 = "wip/evl-riscv"
>>   
> 
> This branch became stale, that's why I switched (535ce20bf0e8). You just
> updated it to 7.1, but its baseline is again outdated.

Florian updates the Dovetail branches and after that these changes have
to be rebased into the evl branches and I again have to rebase or
cherry-pick my dovetail and evl patches on top of that.

What is your expectation here? There are three different parts and at
least two people involved and I do not have something like a automatic
pipeline.

I am still trying my best to keep the dovetail, evl and libevl branches
up to date.

> Jan
> 
>>   SRC_URI += "git://gitlab.com/Xenomai/xenomai4/linux-evl.git;protocol=https;branch=${GIT_BRANCH}"
>>   SRCREV = "${AUTOREV}"
> 

