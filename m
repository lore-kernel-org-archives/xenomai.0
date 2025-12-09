Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011053.outbound.protection.outlook.com [52.101.65.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755F72F6167
	for <xenomai@lists.linux.dev>; Tue,  9 Dec 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765304686; cv=fail; b=hHB2gCQyVDvBcm4UfeXJ7ndj3XTkBAxfMMUnlG7ou/lTyBeVUYj0QJsgZAUZyDd7RXW1GwghArTCN0Yqbs8RfEPHxefBJOhe0M6or+shDkm24qHSwhuHRoGyuZp0ViLEUpFmeHDiwT2289jiFUW0aM2qAwta0tuIq6TfeLO1CTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765304686; c=relaxed/simple;
	bh=XdBM0xtkITDOkFDKHvNYZ5rGStBTQ6fr0El6hhSAwco=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=WkLj4kqglX9RIZ3JCF2pHCqEb//K1iJutF4M5/dk0fFSR46l4I5A2LieJssPpFdKHNXDwq8fdklRuax86pbHxq7hFzYvTT1aXhOkZkfayW6KZ1HXPhbyQJAO2PgTA5eGjmBt57+8HlDleYfgNiY9Hj/InztlJiW67j2KGxhWO/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gfBs4MPs; arc=fail smtp.client-ip=52.101.65.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gfBs4MPs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrFDKUixrhS/ozgNAfe12MvfWFNFv4FgX7IonW0Pfp1rfKbP6Fb7GoEBdcAR0Wn+xNhQ2q4qzWYQbZfyUy4aYKn/RULx3uhgQPRnW5AAU2XR9DL8mbw8lpuS1sw3aUn7ByGcLRGP3NdrlrXEPXXOnYC721ejZDwgZWxJRy/2ZKJxkLtt85P7wGFWMUW3hAx2bhLXXbQg273SA2sJ3o6DqctiPSOq6H9rqlw866EVm5AmyMq0h7V9yYVe5gbIvq4DaEOQn2CMtCK2jPA7VoKdLwJe0vbZ6M444hZkxiUqWmw8r5UG8kD7W9Hw1p9swegkcYplLfAeonfiPK4QmS54pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYDxuZd+HMBfN+rhpZSfpk9HGsgTE8YcUSCZOOWwls8=;
 b=cwphhUzAZqJqlccuaxnuhmmlI6mQDHIgXVN/jgb0eYAWdkrsrmc7MmsYJzKLa8I7oLwtq1jK3qnDJemciQnaVkNGJ7dWot9TiZP8rlnpp3fUh2yeWNzj6NElStSRWPb/P9KlqqhwWCyC/XdckZDjlQtMgzbYcVzuwtt9hZUnzDxjYjyBsxNKL4XQJ+BC7C/y6UY6X3AAjZsvGMmrgmgi9+BWQmZppAZu7WHCVcfYqtv6b3Ajr/QD2CcmibrBjwB1nnVTQme6rgTt2fMJIfCkWgurodznyesrKRuu0ik9gkfHyitm3PTjCWOjjFPijDBSZ364rVU/TcZvEdrBDw4aFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYDxuZd+HMBfN+rhpZSfpk9HGsgTE8YcUSCZOOWwls8=;
 b=gfBs4MPs0CI34lUr/xlq4CnaQkNL8tjXkXgM1qbLMDi32qc3eWbg8OQmTgUVrTnlUzQtbNNXMyQST16iWl4ch57y6+moDm1Ud4XSoIPgpNFN3OCr1Nfd4iWIYXsU0BTJU3KcGZQXT02vpHx5HWdE9cHias4oiNv7BmPQjlHmH/SFCX/rljHEKhr2+Exht86O6d2sNoe+/XFDPPCHJFygMH3+2s++uLlAa5lPHco0ER+rIcO42Jw4/M93S4nXvK5sjU0AGK6aGyTEhvyJqo3D4M5cUoCz8CiILudxScivrOEWmpMSgRZfSSzbi27qLxrH35hQihX9lp4hLUDKAXcMlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5719.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 18:24:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 18:24:40 +0000
Message-ID: <8148a2df-87f1-492f-9028-ae4edbefac52@siemens.com>
Date: Tue, 9 Dec 2025 19:24:38 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, December 10, 2025, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
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
X-ClientProxiedBy: FR4P281CA0409.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd4d38a-999d-423f-d1aa-08de37503775
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnpXTVlxRVhEdGRoamFkRGtNRDVWK2xhYm9SK3F3WVpaODc0bzhTZHFwbUdJ?=
 =?utf-8?B?Ti9NSWk4bEZvZTN6dnBpc3FodG10WEg2eE5obUpGSnAxQW0vcVN2ejFtdFd3?=
 =?utf-8?B?ZW90QllBNHN6cXN3dlRuOThXWUZJa0xobVdnbmJGVlNrSE0yUHhkcnNReUEy?=
 =?utf-8?B?RDJPVHpHbi8yV3JZQWVubG43ZWpWd0ZHc2RaeEZMVThPeGp3bGhtNCtlNmZZ?=
 =?utf-8?B?ZXRHQUNIZzA4a1ZNTmN6ZjJoU1BvTG0zcE9SNmYvT0xjL3loaDBacllWREdQ?=
 =?utf-8?B?amF1czJhMXlObGxDT2NkRko2RnFvUUZEd2pBSVBNQ1RIS0Y1S3ZQYWN5VWda?=
 =?utf-8?B?UEtzYk4yZFNTbDJBaXUyZjY1WnFtc0k1QlRXTEtEa0o1NnRiYjBVQVQyK1gv?=
 =?utf-8?B?QVhwLzJWRWU1YThxR3I4aStGNVAzRXc5U1UwZGtZRXI4aXZQZGZVY1pRSjdD?=
 =?utf-8?B?RWhvZnhpS0FTeHMrUFd0ajVSU3cxSGRZOGt6VGRaNjlWRmxsa1daeEd6MjhY?=
 =?utf-8?B?cmFQRUcyUTF1U0tYeXdHWlIzL3k1VXlwUTJaQlVQWWFzcTMwWXRsQmxZVnF2?=
 =?utf-8?B?U3Nlb1pDckJSek5Cak0zT2FvT2s2WlBPK0RwOGFCbE5QVEt5b1dnWWk0dVFo?=
 =?utf-8?B?TzcwU0M4UXB1aEYxR2VwNGE2RnloTm1OdkhDZHo0VVliUy9SRkdqcDdvUS9l?=
 =?utf-8?B?c1Jpc1ByRUhCREdicG05L2IxVlI0b25XcjA4T3RWUm4zVXljcjJpOTAycS9x?=
 =?utf-8?B?eFBScjNiN1gzNGk5cHo0R1FjcnF2RTJNcnVLVkdMZWJYdVpmVnIwbEFQUXBU?=
 =?utf-8?B?dXhvMTNIV2U2QXg5YVVhQ1dycUE2ZS8wNUNseW1SSWZLOVMwZUEzd0NIVVZ1?=
 =?utf-8?B?alhGKzRKMkNJSUsrOGF5OTZ2SVpwNkJXRzRtUysvWjlCVEpzSG1Xa0RCY1pF?=
 =?utf-8?B?a09uRmRxeWg3MGtZOTFPNS9VNGxsaWNOR0t6Ymg5Z1hrMCtXTUNZbEdMcmdU?=
 =?utf-8?B?bVhES0ZRdWZJUEZJS2tIcWRmM1l6UWl1Q3puVFVFUEJkdGQzdE9uUklENDZO?=
 =?utf-8?B?MzVlakRzKyt0VUFGWVIySkoyZ1h5dGpYZE5WL1FCclhldnBUZjdHcjRqRnkv?=
 =?utf-8?B?eGNZcEc0OXdEd29OKzNWVUtyRnZzd2wxRytOOGJNZjFmaisyRFJLZ2lQVHpp?=
 =?utf-8?B?MkUrR2sxbG1weGhLZ2lZd1RMVC91a0ZKa0NSbW5qUk9CekVZTFZkUFRjQStz?=
 =?utf-8?B?dnVsdm9YRERIQnN2TWNMQ1cyTnNWc0grdXlaTFNSYnBTSlloQTZMaHJrZHpW?=
 =?utf-8?B?dDFCTFVJa3BVbXNUQXgyUVFvOEpVQ3VkZEd5M2d5YWI2c3RpSVRRdU1nVFM5?=
 =?utf-8?B?b2owN1NvSWRjUkVrSWlBWS85OFFBdVpOK3E3bnV5L1R3czFjcnUxTURSUUxj?=
 =?utf-8?B?RkhOT1FmZzZCQXdZeTU0L0lNeStjZ1NNNEprVU9EYkhGUzlwdWtWS3V3YlJq?=
 =?utf-8?B?ZU1WV2tPWUZrdEp6eS8vY0tHKzREWmQwSjR2REUyT1owNXppUUw5djZVTHBw?=
 =?utf-8?B?d29OaS9mcEoyQkZPY3VHNnFVQVhVNU1tVzJDVmdtbitVNXVPWFBCalYwTEpM?=
 =?utf-8?B?Z1MwOVY1aEtPc3REcHp0SDAxNzNSVGtWZFdrdlNUNlVlMWZZNVhERDJQbE45?=
 =?utf-8?B?d0VGWXFhTGY1S1c3bzB0T1ZsVXdUK0ZaSWZ6ZUUzL1B0dlNJV1lpVkxiZ3Bs?=
 =?utf-8?B?NmRjOFh5cnNTZEpoM0RMSWdFZ0F6VDUxSmhOYUIvVnVCK0hNd2lkSExkdUdN?=
 =?utf-8?B?aTQwSWFKL1UwUnZNNjA0T0pNekRBVHNWemV1bTIxY1Z6ZHdVK3lCclRyRjBz?=
 =?utf-8?B?dDh0dCtSNERDRzlGVmZuUUF5Tmg1aHhUeFU2aytJM0hlMlM0ak1jMklka3RF?=
 =?utf-8?Q?S4xDoQOxV0TIHrebPO3tQBcJRJttPNOl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Njc1cHFkTDNqOXNjM2NLd1pHdFd2S0pNL1djejZaalpyM2RGeHRUSXVCeG5z?=
 =?utf-8?B?VmFJUWF4UzUrMVo0cEFEVjhLdG5DK3NDcENVbGo3clRXUzJXdms4b3NWOUk1?=
 =?utf-8?B?WVBuOGtCR1hPdVpWTGN6ajVxWHVTS2ZYYjh0UGYrYjNqK0VMaXIzMnhjdVB1?=
 =?utf-8?B?c1MvMFlWV2RueXY1cE1oTGNoY0JmOUh5M0U0cnh2MDRKRk9keW9MZ3VKOWVi?=
 =?utf-8?B?cGVCd1p4YjVzVE1lbWp3djVobUFHaHpaWFdyUWVkSVVaVWlVUzB2VjF2MnRp?=
 =?utf-8?B?bzcveVdlMUg0YndKaFFPN2o4K0pYQmtSckJUSXgvMGwxMFpSTE5FRXR3TXdC?=
 =?utf-8?B?aWtZNG9jZ0greGFWWlhSd1FTbzJNUkRyelRBSkZqRklRNndhZjJFQUtqZStL?=
 =?utf-8?B?ZGhNeE16Zys3c2o1ZXBTQWwzTmJGdFNmYjk2d3ZtVFQrSTJSUjVFMCsrbGV0?=
 =?utf-8?B?bUdxWldKbVVHbzNqMEk1Sk9OMkFQMlRwcE96WEl3QmdqeW5hc1dUS0I5eWl2?=
 =?utf-8?B?V3I3TzJZWVFBQmZzMGxYbnVXcUxIZVN0dC9jODMzc0ZxMWZKTGlTaWlsZFFM?=
 =?utf-8?B?SjEvOVdoWFRWTlhMb01wZ0NzRDMwYy90ek0rTUFWcFZCLzBQM3YvUFJoMlhH?=
 =?utf-8?B?NkpnTzFvYm1peVRMd0t4N1pZTkExUHY5U3RwdlV5U2tkYkk1aVhrL2IvYWl1?=
 =?utf-8?B?UUxBblE3SlQ1dVFJT0IwZVRiMTN6cUora3Z4QmpYYkN6TDhUWVV1aDB5bG9R?=
 =?utf-8?B?THVUS0I4M09BeUxYTy9FSjNYVjJvajVBenM5dHh2ODU2TGtacTIvb250STJs?=
 =?utf-8?B?WDJTZlRQVEhobTJjblFvSDRFTlBua3k5WGJmTHJJRklqSnZudnc5QlBUZnFG?=
 =?utf-8?B?YXp3Vld4Q3cyUFBoZEdlbnJJTmVEYytVcTVTeHBCWnRPak9WZE1RU3VBQlFY?=
 =?utf-8?B?UFBPNE8wVi80UEJ6V2dDSitjZzB4bGo0ZW5vOHIvWTZ4elZ2Ukw5NDRjMTF3?=
 =?utf-8?B?WnpBcVRtOC9JNzJZRTQrYzlDKzRBNTdxd2xSUFV2Q3lVS2dkdG1xSnEyaHlJ?=
 =?utf-8?B?bEtZK041SEtCYlJmZHo0aXRxeXBNRk9NSVF2S3VFeWkwMWlsRjV3NlVicU0y?=
 =?utf-8?B?RUdpeUMrbHUxMzdEV21Yc3c3a3ZYTFg1SWIwenBvUDRVWm5YbkVmUDZFQnJ3?=
 =?utf-8?B?Q0JzbGNLWERNVW9EVW1sM2Y2ZTFDVjh4VjdsSE50QzNmRkN5VGk2c3V2UlhP?=
 =?utf-8?B?d0xuSE1GcDIyeW1zbjlIcnBMTEFVYWFpUU9KOHhlNklTSXhwOTloajlqeDM1?=
 =?utf-8?B?eXViNmdsaTJzU1lqV2pZQUFKVU1UUG5yVUZONXZoN0tReVFjU0xOREp1WjJB?=
 =?utf-8?B?TG5uWHFQRTZCcHFlV1JPbE8xYkI4VnJ2WFBXby9ac1dRUmtxcWtFcUtwTXdl?=
 =?utf-8?B?RTA5SFp6RHRGZE5rdy9Nak5NTW5mdW5VczQzVU5CUkJYQnpJd3lMZ3NJb0xT?=
 =?utf-8?B?clZPUk03dFozMnh0Ymx1b0EyNXZZV2N0NWZtUGJUMGUrZVUwcGNyTmN1Y2ZI?=
 =?utf-8?B?TU9rbmNJWUVZNkxFZUpsd1p3UEVPTlMxRXkwc2NUbmtjWUV5RC9jdS91MXMr?=
 =?utf-8?B?elpnSFNmWXFjdTcvODZlT3hOeXVLZ2srWVRMWnNmNnFTNUp5WlluMTA1ZjdL?=
 =?utf-8?B?dTN4dnNIRjlodjRndjJ0Y2xSUFU3d08rWFRLQUdkUnhjdEErUXJJcDQrZk51?=
 =?utf-8?B?SmVpNURFUzByMnpJK3pOOVk3MmRJR2NzU0lacXNSNU5kdkp0ZzUyUlpOUkl4?=
 =?utf-8?B?aTQ0eXBEMnplS1BzaG9aczNabWdldUNEb2paOVR0U0lYS21HVUU0N0JGOW8r?=
 =?utf-8?B?RVoxY05aQ1o2ZXh5MkJVNkJXQjFEMjZMSmc1L3g1KzM2L2Q3ZkZYSzdUQ3I4?=
 =?utf-8?B?eHJkRmVqK2tCRlY2Z1pmNmdLZldSU1RrVVpUYjJabTZabyt2bFoyOVZwMW5i?=
 =?utf-8?B?WmdkS25kRDJBOXB5NU5DVW1YNUwrdWJiNnU3R3RUTW1KcVJCNERDS1RVblRP?=
 =?utf-8?B?THRJanI2YVovaGhZMkZCUmpZTFBYNm1WSURyM2pqek85a09tUzF2U21ZVFRj?=
 =?utf-8?B?Qm8wOUFlNkVlV0dPYUtKTlRlSXZUM2wrR05iTVd1QmtnUmgwc3c5MkRvL05q?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd4d38a-999d-423f-d1aa-08de37503775
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 18:24:40.1994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsA2/2Xd1uPg6pmmquJVd1XmdWuy9ZrXen/5hyd+fVnFAUM4hgBK7dEXGmQCVajrAORKgSa7DM0gLUUrxyG6ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5719

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, December 10, 2025, UTC 7:30 AM
Paris, France CET 8:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
