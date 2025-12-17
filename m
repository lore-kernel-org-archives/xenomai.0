Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71282271448
	for <xenomai@lists.linux.dev>; Wed, 17 Dec 2025 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765986972; cv=fail; b=ch2WNE1Dh1xpRSooF/jYvbXgaQM4BGefc7WjufWGx1MY4eEUGz8So8HLK8xxFC/zwI6Cd3dR/ZFFqn1WnI5VsbvgzumOs99BlfjYThJ/m/I150a+ZE3OClgraPD6+t91XDVEJUd1b2zK4xuGgB9Cqg63QehwB5a7z272AMJm4iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765986972; c=relaxed/simple;
	bh=Jewg+IeV3gwY5OXO+rx1gLa0YOAJoNbBVRm70bb59kU=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=L2FTAE8/Z8HKQzeEDRv5PhStnrUlhEFWxtXF+Mmg0mSTGixaOXa9/+y+rZC66XOl0jtZW+jpczfbDu6Ej+GNjdTsmcNU9W5Bf7Aud/1SldmchKGN3fzQk38B3PJ1Us94ou3jHOWn44HueOqpxckWApc3zNNH1wCSasVulig3tdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=eBpYU7vY; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="eBpYU7vY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRShgiNSssJRSVZWxaq5xc0DF0m7vJG//2yiRa1cDTkyelHV5ASXVneLab4SJylK3v4cXVAwQCps14taUJiVsL4MRzmqhLai1/rnbAunDREdt42HwMXjCTYFTVsFTxYSP8oCXOeqOH1Kr9VQodWL4+YvK6Lm0scdzbP96AG7Ge3xkdVoDnEbw4GOgrN6W1qtbRDPHTe3ILvyL1vgiElFvAoK/hWAD5eQXkIz7heShdo0FNRGW5T7BFE+BRCHbsyubgBuJu1AviFDZQ015cYpCJbVOn4T65qUkeylP77Hyrg0vw3+uVxFBCaetpbrlNEuFH7IEcVMmM9iNpnnRV02EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJGo5whki06pyPm52SmPQh8ijRyquZi+O4LLilg+P2g=;
 b=ybE80vxSeRj8x1byqNiX2Lcc9eAtgRwNFKOXJNup9PjxJ5ud+FhjpqrifnzxtlQ/AemOuuBGwwh8pvOMy/r3sBBE+3dXnusaSKWg2+lg7rQleNkfin6DsuRJSQsKUXIGh2RZbP3WdUkApRwUGblVjylCuggLw7ZajDEs5A5nRCU3Dq/7uqklpkYZC2hYw05r6xNDfzB4DBfHbIIB4Ul2umMWglJvZpQU60YSpO4Xxa6gs6sw7jGmhZEfzkLMPIctIz5922em7RSHyeFL5vJMnyhx7XrHV/+p0VJ0YaYbnb3FtQcZGMvjTL27QPrPd4rgnZUe3TWY7Jb1XSl6pVOUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJGo5whki06pyPm52SmPQh8ijRyquZi+O4LLilg+P2g=;
 b=eBpYU7vYEIyJFMzT7km0f67feGFeckAqgFXYmAm3JlTuEbQVQMinX0DD5GfWVk1CknWJKi1LpT0g3eVi6ehXOXWEkRTvfLS274b/zCSxRe36blO4YyCrwqhcE5rHJ0mYlviAVZ00CibaRJ95dymKYcxXMMHGJ7iOzjB3mNX8c66FyLI+zNtFcoM/QW4rOyrZYaj1+lV6rRDsEuCFw8Qe4Xj5gCFtU7+PjN/0TN0n235EkbQraOOePzOLDLx2/6hqfCzbb/x2Dhad4K7Ra0HX2wLSIVu5o3tOF4qT+ouVTqwOo3GoIT0/kBcV0SOY9LakA/tnQacPc8vneCJEvlU0BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9399.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5f1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:23:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 13:23:25 +0000
Message-ID: <601496d9-bf1b-4f24-939a-471d9c355d83@siemens.com>
Date: Wed, 17 Dec 2025 14:23:25 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: Retiring ipipe-5.4, collecting ipipe-4.19 users
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ef42ef-c8f5-461d-7bd1-08de3d6f75ae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1FoRkhvKzJGdXhMNjNkbDNBL2NZM1Q1MXB3ZE94cThpVmtra3pUbFZHRXg3?=
 =?utf-8?B?WW5WbytOQ0QwRFlDUGF1UC8vVG56SHlQZkRiS3JvUWIvZUk4eVF4eE5GeFdT?=
 =?utf-8?B?S05FWnBPVldGWTRjWFBtdTJGN2tGNFlDcmRoMitJWGZqTE9jREJ6U1pUeEFH?=
 =?utf-8?B?YVB5b1FKZEdBSy9HemhTQzdHZDNqWkhMWmhVYXorQUJtRi85N0xMa3ZJZkxw?=
 =?utf-8?B?NHBjTmhuR1pwS25FZ3Rja0lldTcwOFdNRVhjQlh1N3ltS0o2N1FsSHNpWUVq?=
 =?utf-8?B?MU9sKzR6VGZLWU1KY1l0UWdPSFMrNE0yRTVOVWEzaDBjemJ3bXhhUDlIUyt6?=
 =?utf-8?B?YjJRL05VVWVqWEhaSmNuOHFGQ1VhVlJ5ZU92aUVKZGZiTmRudmhWUW9MREY5?=
 =?utf-8?B?b2tWZmc2ODd0cmd0aW9oSHBSRGJSM3lxbkU4d1VQbmRhWVRUKytORE55WWdh?=
 =?utf-8?B?WWphZFBOYTROS3BPbEZFQ0FMQXcwb3hQY0traDFEajU5bnNXVXZKcFY0N2lS?=
 =?utf-8?B?VE9TWFVQRFFBdGluZlQreVhyV2s3aXBLUG83elRQYzE0TnpHbEJSeHRXSkVv?=
 =?utf-8?B?MkN5bFVXR04zU0VyekFabmdPRlQ1OURORDJWRTFDK2wvZmU1S0tGcTJHT1JG?=
 =?utf-8?B?SWdmMmI5cFYvb0FlRjgxcE4rMysvTHA0T0d3eUZuUjh5UFBwdkVORjUvTndZ?=
 =?utf-8?B?YWZoTDFwYjJ2cnhNdENhL2dwZ1VLcGNVVkhIVzVJYUlOQU1rbkMyNFhxa2hj?=
 =?utf-8?B?MStad3FHYWxESWhPQmVDNUZYSU1IQWh1ZmQwQk5SazBuNTA5U1lINHlsSHJX?=
 =?utf-8?B?aWJ1aTN0Lzh3YWs5SDRZUUlUVkdOdnIwbVg2a1lRK0gwZHVMUnlWSUNhcUxs?=
 =?utf-8?B?TUNmUE4vR25KR3FrQTgveTBQaGlCZFh1VmpTd1pWUHdkUUNsa2hMODcvUzV1?=
 =?utf-8?B?bWpsMXlZTGZCV0FzZmtBdGJBRmNPSjNScXpMdkY1MU5ZUEVlbE4xRnRrWGlv?=
 =?utf-8?B?QnhzTVRvcHF5U0Z2ZW1XMENCL2k5Z1d6OUt2NTZ2NGp1U3NCclBMZ295ZWxM?=
 =?utf-8?B?aG9nQVJudmhmRkFQdU11UDlrV3JFMHJjeGlCSCt5N3VVZEJWUU8zM0dSVEhi?=
 =?utf-8?B?Mnlmc2V3bkQrRTFxNmFtL2h0TUJJTDE0K2RKelY3Sk5Hc2E2dTJJTitxVm10?=
 =?utf-8?B?K21QaktJNjhtNW5OcEkvaWRSTTZBZnpzVWVsUnYyRTRudjlGK2NyQ2huY1kw?=
 =?utf-8?B?cmJudDNkQkJsVWpXcHkwNlAzYnhuVkdFcVc4aG9Lbm15TGhrRGVhY0p2R0F6?=
 =?utf-8?B?emFrYm15Ny9QeGd5YjNQWkg2dE5oWkVlbjNXKytCd3lMNWhyYWdvNklvMWcz?=
 =?utf-8?B?RVpaMUVrR2JNYm5Ma2hSUzVTTXBXRzFXcjRtMkhPaExDNzN0cUZuRHU1WFB0?=
 =?utf-8?B?ZmladVgzZE9lSTdCbjRMZUdXb1dDMnQ2bkc5N3poTUtUOEJJTEYrUytSSEVj?=
 =?utf-8?B?Uy9FN0hCTVcvOGFWYk9mMlFBVEUrRXQ0QnV6djBpRDBCc0VRZnZnYmlxSm5M?=
 =?utf-8?B?SDZYLzgwaDgvUE04S2hmQStxSklDd0ZBOXFCVUNMQ1RnVW5UWWRYcWdtQkMy?=
 =?utf-8?B?K2ZDL1duRm5oT0k3N0pjMmJxMTVvdUVTYzZrRDVqcWN2V0ZqdjdwMWtiM2Yx?=
 =?utf-8?B?WVBDRkd3Q2pyYmxjU2RxQyt1Q0JlMmFYSE1YYkNiMkpNUWFDTEc1dGtOU3pQ?=
 =?utf-8?B?RzZjaVltSmFmc3duMXo5TmxUK1lxV2FkQi9pU0RpM1JtUVhBLzFVNmxLNVlr?=
 =?utf-8?B?NXV0bURRd2VJT0hZY3NPOWp6RnFwR1grL1NFcEloU2lRdlIvQkQwT3lWWWlD?=
 =?utf-8?B?dUs0ZDJseDg1WURmK0wwZ0VYWFpZcHZCZHVKM2lvV1pTYU04S1FOU0NMRnM5?=
 =?utf-8?Q?r+NYYv3xDxcffTecUGPF3cOMmVqHUtin?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cW9LekM2NVJNQ3RFWDhiZE90TkNEWGxPK0RiUGNSYXJXVjlpTmxLaVdJR3Bi?=
 =?utf-8?B?OUVoOGQvRXhMM0Z4V3VPTk5RMTh5ejdhRmRxNkNKTXppWWxSTlJMQ00xaFNw?=
 =?utf-8?B?NlhleURHd2E5MjRaaEgzbXcrd2VlQ3lHMFBPNytXVFdIakNMMGg3SXBWaytt?=
 =?utf-8?B?RXBmSzVvTnVaQmtDTERQTllvK2p3OGlwUVdXYnZwbFpKQnMxUzhJSnVkSnRn?=
 =?utf-8?B?VUVHeXlOZG5QT0Y1WjVRM01LZHhJNUkyaDFZWDlvZDVBYjdOaTE0SUdtS2JS?=
 =?utf-8?B?azhPTnE4cWN1MkpGcXUzaUVlOWZFbWhSVmFqMWlCUmpsNjZMZTRKWWd5d25C?=
 =?utf-8?B?VmdsaC9QV1BUemZkMUMvZGV1NjFTLzBjZnBsb0RUR0xlTk1tY0dzTHBFWVQw?=
 =?utf-8?B?ZnpLbnBTaHhJcmUrQUhnc1draThXSWFpTERFT3g4bjVDeXhKWWYzKzNHK0x2?=
 =?utf-8?B?SlhlWFl1Q0pnOU40TzFKT2tpN21NMWZEVFUxT0l6UlY1c1dIU2x3QXJyY2wr?=
 =?utf-8?B?M3p4OEQ1WHdndGFIOHd4V21uQjlMc0dtazFZS2lzR0ZQRjgzeENUZjVweVhz?=
 =?utf-8?B?ZENzWTF0WlpsYmU4em8rYXZVa0ZoaHFuMG5ZUkFzSHpHdmZ3UXhVUlZzNmM2?=
 =?utf-8?B?V1Z5Q0xHak1MTDhXWlRyS2lSc1hPWm9Sb0xma0tOZS8rVXBBcHdsZUFpOGw1?=
 =?utf-8?B?MVRQVWJwM1psVGpEWWErZ0htTC95eHhBQ1ZDNlJhU2lseFNBeXZnaStlNUVS?=
 =?utf-8?B?Ti9vbzNtcnJrMmRHYVh5NXdNa2tnOG9NYVlFdldMZDE5NHhSTUxrc3dVWEtO?=
 =?utf-8?B?K0FrSzdXb3gwSlpDZmRidnhFa3dTTTZWMnBrMXp6V3RySjVsK2FLYXBFTVFs?=
 =?utf-8?B?WE1zQmJOQVpmODd3SzBOY3BGU3pIQVMrRmN6Z2N3ZklvWCtqV1g5b29Kb2Zk?=
 =?utf-8?B?TkpVNkUxbnNVN2p1azNVOGZjOWx2aDlKK0ROdWZZclRYb3RFSlNEeDMyb2Js?=
 =?utf-8?B?SmQ1L29pbWZkUHovR2xXdTZNem96eWhmZjJZY3AxZTI1QnREQW91bmVoN1hM?=
 =?utf-8?B?SGpCU29FbmpTS2JlNVU5QVp0bnhPZFJKcmM4ZHNNMUdvNC9qZFdDZVg2Qm5Y?=
 =?utf-8?B?dHhkWjNtSGttT2UrR01XMFROeVlmaFE2QTRnbGs0VGlpdHNEQ1JjRmx0R2Za?=
 =?utf-8?B?ZnB2WkRuSmV4OUZ4SndLNUpyZGpCWmlSQ1pqVFdtY3QwWXBFbmtoQWNVbEtq?=
 =?utf-8?B?NUc3YVhhdUZvN1JGZEpzeWJZbDlXN2lIazJXNGxqNytBNmoyd2VkcTNqOXRZ?=
 =?utf-8?B?bXhqN1VFT2ZPbG11WWJna0tuSnVON1lJRzhWZjNXV2tjYVlnSmkxMElTdW8r?=
 =?utf-8?B?cEc4UWJER0Fwb3JJWGY1SExmMWhwcXZCRFFvNVdPYVFkdCsyTTVrdFpvTXhH?=
 =?utf-8?B?R2xwWHJXQk9Ma3ZqQUNjRk9IS2hvaHZIVFdQSEJVa2JUQzNLVlp6ZkdDRGxt?=
 =?utf-8?B?YXY2d0N0MHFzS2d4eDJOU0laS3JtSlUwL1ZweUJJNW43d2JobERGMWlvUVMr?=
 =?utf-8?B?Y0VucXg3S0NXNDZoU1JUckdiL2c3UFVwWEJwM2grczRyMkVlaU56TUlZc0xF?=
 =?utf-8?B?MjRnM1MrRzYxM09MWllXWUpUT0lPMDlLbTkzbklRMTJtNFYwTjdlYUFUb2xN?=
 =?utf-8?B?STJXYjd6cGFIODNMMVFVVm1BZ2Z3WWhUNjlxTHdlSXQzQ3RudHBpL25Xa1JJ?=
 =?utf-8?B?WnBmc084UjVTWmNLbWE4ZXV5Mk5FWUxKNmdXN2dLbFhZN3A2QnJDY3NLdkpy?=
 =?utf-8?B?NFpjQ2g4b3djbVUrbklISGU1bjlTRVlvR2ZxcmJ0QVZZYlBjZXJoU2hLUnFh?=
 =?utf-8?B?bHFNNVBCNjRsT3dmVjcvTWdGdFlTbmhlekxJcWdUTWhJVnJSaDlQTjdaVnFV?=
 =?utf-8?B?Z25HUU50Vjhra1dNVFBzN0hKZWFzNDIyQ0ViK0lMbzV1MkQ1M2ZOY3REdHVM?=
 =?utf-8?B?WkYyYmtzSjhld2hFeCtKaXZScUhKYkR6bVh0NVFxaHVkcU93cENETHRLTmp4?=
 =?utf-8?B?MjVZQ0ltd3AxTTZ0VkxKY2hlM1F6VzNiQk11UERVMHlmSFQ5NU55MEpLeDho?=
 =?utf-8?B?TUwxYkFLUGJ4andzcnhab0ZJblFsR09UZk0yN29nQ2MrclY5azkwRGNUbE81?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ef42ef-c8f5-461d-7bd1-08de3d6f75ae
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:23:25.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loNW508q6vyJZB+S+qN4bC+xMs4kzI49vCxSbD3U2R5o81939nKNMt58QNhkM4NeKV4/QTnKWznznOtesmfBzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9399

Hi all,

as you may have seen, the last stable release for the 5.4 kernel has
been issued as 5.4.302 two weeks ago. As upstream maintenance ended, I
will also stop looking after this tree via the old I-pipe patch. That
means ipipe-core-5.4.299-x86-18 was the last patch for this tree. If you
are still on this kernel, please migrate to longer maintained dovetail
kernel now.

With this, ipipe-x86-4.19.y-cip is the last I-pipe based kernel under
maintenance at this point. As my own users moved away from it, I would
like to hear if there are community users out there still requiring it.
Please speak up NOW, or I will close the maintenance of this branch as well.

Note that once the last I-pipe kernel is stopped, also Xenomai 3.1.x
will finally go into retirement (no more regular stable backports, no
more CI testing).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

