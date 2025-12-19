Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF53C2AD16
	for <xenomai@lists.linux.dev>; Fri, 19 Dec 2025 06:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766126974; cv=fail; b=urgcCSmjn229EOnt3rdrpxDKdrj4XccUppWSZDTgD+SVP7Y0iAsOCdeYt/b942T82MD09q8niRANErp0x0VAjRwOB8yOab5NcGr3vJMDTBjOJsx/6LXQwlN62ZOBAKarlUMm3BmFIa8/WUGOvTiobBye3sbXduiWJwYyF+mQmDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766126974; c=relaxed/simple;
	bh=90f9kPxFV6eaVJsxj3uRZUGUyUWrpaWvAYnlyfIxsz8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HN+wrn/9fnemtMa/Jx3169tlgWTLkJGqZRmJADgy+IGC+Dw/HAcrBAFLaZ/YulykggmVxN8YlDj/gWBXVtQysCOTZAd5ehAmX5tN7TKYdp4D/VSTEXu1tTUB3WzX2g27djzj/c8DJJk7lXnUb0lPFDvPu4qSHu5Ndv+E2xkAO1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cyAHPNx1; arc=fail smtp.client-ip=40.107.159.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cyAHPNx1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEb4mi031fe3DTXquzeeKP7t5EF8KICezIADgIedFP0/Np3aUKCyC8QpHi62Z04udt+mTi9SQ+yyrieOh3XF0AvG1qEtiBid8Rdm9ZeoGXlRvVtP/waqbzcNMUB8aKLNmFetD2dE1EgJXosae1sFlqZ5AHHVKCxYnY0NIF9B05eL8MHK1SgqJ9Fu0JtdYZkctUp2bblxQz8PdGnsGR69vIQbVoBfXIwgfyEToGkowBTlE3BZH1WywFwqtwJREp/h1MIcXKUQh0Y2RebhO0In0YdTxEiGG3FawEgLl0bhCWQgpJ8H85lO6yWyQe5uvmqCvTgGW40noCsQvXwDIpLapg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zB+tuYZn50C4A6lZ/HD+wPzKUdzZMsaD7O0+TVhpL4U=;
 b=u4JKgtmYbeCSOQ6rbXSjUv33HeB7dFgZSL1bJR6/KJjDmBSQnogVmgJ1E0dJvcMrCrWhcHly0LoxLqOMG9PMJycyAVbjHyJwZcG1f0DCjA16fAy/8Z20u927SqJKrOcJvUYSdGQr9rpJCg8av2YQZnxD2R3Plz4FcDEXdJl7W3/Wv0W3Jw9fSLrxErUcYAnO8GfclBLx45hTKxoHRYcTAUtvaTi4ZCRLzNCSIgWKYAYZioa35gWIG+3/GLYmS0zTRJzi3p7mkaWCYmJ/SGCop7Ygz3JQT/lp2DJbWHMfFdBCTUz1ERyXPmMPvkCMxihqYVY7fA3Z4i6ScXMrgwl1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB+tuYZn50C4A6lZ/HD+wPzKUdzZMsaD7O0+TVhpL4U=;
 b=cyAHPNx1HmVblXK4QUDdUol22Wnw3vBx/gSUs1yEhw1I64eGuinwM9gNjPOPBbYPWHZjLd+YLRH0Aet9dLITS5yyBCA50XjfbdcDejLxr0d6fa2Qj8zIkr5TDeDk8/VFqM3zbYedI9XirOYLvaZeINz9o58zYFC9YWGFOBH5Sstk0YOV81UwuXCIiXjLT0sxJL2mga54bAuofJpv8OYLJWyL/dS3eWerl6zuNhCbezTJMm98JfpS0Ymk0hbeO0Yy/lLAXBppEynG+L/gVA0fZPbXTrZ4ackzWh7nFYa7/zFDCVY8bSUnYk04hwp/GosUBVCY8PshgTHazHIEa8Xd5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:597::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 06:49:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 06:49:28 +0000
Message-ID: <374bb689-fa91-4a61-81ba-04c8897eb4ba@siemens.com>
Date: Fri, 19 Dec 2025 07:49:27 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] alchemy/task: Match thread handle on task lookup as well
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Mauro S <mau.salvi@yahoo.com>
References: <48004331-648a-4f38-b8ac-49f415c18016@siemens.com>
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
In-Reply-To: <48004331-648a-4f38-b8ac-49f415c18016@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: b05434c0-ea85-4800-754a-08de3ecac19d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d09rNXUzbFp6bFZBVWNxdVRlcUZmMDNTeWRxQ1VyekFKRnE4dUsxN2VXT0Z1?=
 =?utf-8?B?VUk2VnR3RmE2d2RhMWlvd1hPbTlhNkJLbVNHLzJ2ZTVHTXVTeVFxYXRyOUZz?=
 =?utf-8?B?aWxHZW5kRFNZVTRvcFhTTEZvN1BVZFNKMzJudmJwZ2FJV3Zyeml0b0d0UW1Q?=
 =?utf-8?B?ZkpqWG05NDNzK24vVGxFR3VLSklZN3ZMdEdaK01haTF6cEE1bURsS2xQYWM5?=
 =?utf-8?B?dGkvUjJEUHVJbWM2dzFNMm96VFVMeG15czJjMWlvalhyYXVKSTNKSFA5dVlp?=
 =?utf-8?B?MVF0dW9rclVLV1BrM2hja1lEOXNZb09YeXdCUDVlM3N6Y1UvZjhLcFhlUzJx?=
 =?utf-8?B?NVRBWEgzZXgzMUZ4UDk5VS9Dbk12aGVRZlpRbjlPVVVrVVdEZThDc3p1cFhZ?=
 =?utf-8?B?czhubzAvemo4bjB3aks2WHpzdXJKYU5qVkVZTDhrMVFtOSt0ZWp4cXFEaDJz?=
 =?utf-8?B?d0NMbUxLbExocmluUy9PYkQ3aTZka2Z4SzdFeDU5MldVcy9sL2dzY1NRWlhR?=
 =?utf-8?B?ZVFzRXo0OUMwS3dyWVI0Y050RHhIaTNiaEFhY1Zlc1lMY3p2Z0doOVJpSHkx?=
 =?utf-8?B?UHVKY1BTbmpDZzZ1bVRWbS9jWXl5bVFjTWc2VVFKRDdRRmxiRHJ0UVpEQnU3?=
 =?utf-8?B?bFB2NUR4Y25VQUdJNStiYnhDU0gxT3ZreTRhcUtZYitxOHQ4UEVtSU92U3RP?=
 =?utf-8?B?cHVsTXN3SS9YOWFyNjgzYVdVTlhjRElYb054a0JPZ1NwL3VkMm1lcW8wR1B0?=
 =?utf-8?B?enBWeEZueUd1VHVkUWRFY2NYSk0vVENCdHNsTjBQbnoxaHZzZ20vYTVTTlBU?=
 =?utf-8?B?QXhRUkZsZ3p4ZnMza2haSEk0N0kxQlM3RWE3bFVhK1FBUzR5NTQ3OXdPc1Js?=
 =?utf-8?B?QWd5SGNoNmt2emhHMXRqWEVZQ3JTNTJsRHRxeDI2cWJXZlVtYzBYYmV3MGhY?=
 =?utf-8?B?WjQ4QVVnbWVoS0hvN3JrcndMdGRybEFrM0ZzZmVrMWtDODR2aldKQlJVUm56?=
 =?utf-8?B?eHhRQW1FdCtUVy96b2JzNGxmMEVRWGp2c3lhaE45aitiaTNtOG5oTngvSXox?=
 =?utf-8?B?cFh4Sm5BNU9jY3NFZEdybklFRm9XOW8ycGhvcnFMTVhiYjdDWUNCUGJyb0Zt?=
 =?utf-8?B?azNUWmh4Y0JEN2VBRVpTV29TTTlwczBOalBpaUhuZU45L3h3VU13ZWRWWFVJ?=
 =?utf-8?B?M28wRDJWRzlKSVFEeFZpYmhpZys0MzZQTHFZWWxOYmptdXMxelV0RnBDZ3RR?=
 =?utf-8?B?NGdrNzJDVmc3bUIzdXgwbmFUTkYxcStHeGtRQXVUb0ZOcm9ZTGhnTjdZSW5K?=
 =?utf-8?B?aHB2QlVKYjBjaURMa0N2ZjdBN2xzOFVUZEJ6Qk9yT0RONklyQWMyd3ljN3RL?=
 =?utf-8?B?bTZGbmZDbDluWUp4RktENEZScDJQaHNMcmRianhzVk5NODVsM1Y5YTc5MC93?=
 =?utf-8?B?WFVrUkRveHZ2OXhzTzg4eHV4NEhRT0hpN3J5U1BSV2pXQWdoMlpjaFEyZ1Ry?=
 =?utf-8?B?RnJxYnVrZWd5VWhYVHlqeitBZjlOMEI0SmdGaU1FTjc0Sm53cVVJdUtYOFdm?=
 =?utf-8?B?VlMzVWJKYjNVWXcrTTRkcWpLQnVzclcvNTdaSUR2aFZZWGNrU0d0aW5qcGN0?=
 =?utf-8?B?NmVYRlhvNlRLZG9vRElFZVZpcWsxcHo5b3FWdDhwZC9IZGRtek5mQXY1MEsy?=
 =?utf-8?B?dlJ2NjVKSWwyQjdqN3ZjcHVrRnNDaEFDbFJUQ1lxUDdwalVnSjRDNVlnVS83?=
 =?utf-8?B?cWUrNVlGU0R0Rk02Q0lPV29SVWJqWTJtWXhPejZpQ3BCcjdmNUY5STN0ODFB?=
 =?utf-8?B?eHpHTXoxYU5LZ0o0aUgwU2ttY2M0U2djWEtGRmdFbjZWcTVIWkZxVHZLMldn?=
 =?utf-8?B?MENDODFqamNJU24yMk1nQVQyT2RGY0s4VmhEU1d0eUJhbVpFbGZuTG1tbG95?=
 =?utf-8?Q?wBZvs44QLhZwPHpWI5uZ+qASx4F/yb9k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1NIa1ZLWENXbGtsSGlvY2dLbS9rMFNvTTBUSUFUbzJDeERZSW9BVFRuL1hh?=
 =?utf-8?B?L3ZacmNiRk5CYTBLRUd6MHRGVzgyZktWSFFub2t4aFZrTDd2M1BkYUlHbTVr?=
 =?utf-8?B?bEUxMk9oZzdjWXR6cWlGd285TldZMnNOWmttTkROQ1NkdldneDlTN0NnQW9r?=
 =?utf-8?B?RHJRQkZsNWJPUWxkMmV6ZjFlMGp5SUJTSnlpb3NxbUlVSndUbVdWVWZSQytu?=
 =?utf-8?B?eTBJUUZvZHZHUUJxT3NVZGJRVW9pbGVSamk5MGFmYW1sM2F1aVhpU3llSmxI?=
 =?utf-8?B?dk1ZNDV5N0R2V2w5SnVqUmxURE8yWWszYktHMjA2NFZIN0JIbXdMWGdROEFi?=
 =?utf-8?B?L2UybDZ6OG1xNmh6QWlHZFZuS0hnOEJuY08yMnVqaXhVZDNJM29ncEQ1WWdB?=
 =?utf-8?B?cityTFRIMGFEMGtOZXN3djFJcVRoVjA4RXBpMjVrNUNOWkhPZWt5WWg5TUZj?=
 =?utf-8?B?aU9NM3pxVndnbEs2QnhuYkphVSs3czYxSWszQjdxemFFOTk5VlZEeC9RaVll?=
 =?utf-8?B?RWlwVHdmbXkvYkh3RE9UR3c2aW5kVW96a2swdkJiNUdsQ1NscFVNdkFDUlFr?=
 =?utf-8?B?VWpVa1duV1oyQ2lPTG12N2IyTU0yeHRVSDdWYU5SZHB5ZXlVMDViSUhQZVYx?=
 =?utf-8?B?dW51empEUDZxZ3ZLSUxkeUU3NzBqZFgvb0hTTU9jS1phQlZNK1E4Y29ERmtp?=
 =?utf-8?B?R1d4dHp1b24rN2NkMjN6V0ZwNktpN1RMRTk3aTRaV3RySCtCa3ZQK1ZaZEdG?=
 =?utf-8?B?ZzJ1QnF4Z0Q0VVRZS2xvaEJDTXRzTXowelB0dlIwYTN0M1VqTHRzRFVMTGpJ?=
 =?utf-8?B?Zys0enBvRnN5NnZvMG5XTUk1emcvckVqb0RrYm5kYjFYYkoxS1cvYVVBeW50?=
 =?utf-8?B?M3NrdzBKWVVCM2svM0QwMFVHZGwzWG9NRFZNZTB6NC9DRVp1K3o2bmRDSjhP?=
 =?utf-8?B?QlFscEV3OXhJZDZwTllQaW9xaUVVMFRVc09TdjB4ejdMN3VvSElKdkZNVk5w?=
 =?utf-8?B?TXRvM1pXcmdlZEpBYlc3ekNPaVZIbFpYaGFVL1BpeWcrS2Z5Y0VabHQ5VldU?=
 =?utf-8?B?WkMrRDdTNTJ0TmNybUFUbzQvQ1ZQdFFlOXdNTGVQM2Qxc0JoNlNZVXZseEdT?=
 =?utf-8?B?MkVhMXpIM2NRckR3YW5BV0MvN0RRdjZpL01yRjFaNFRSWCttaDdoOW9kM0xZ?=
 =?utf-8?B?VUdLQ1hVUlRia0pFVi9lSVBhQ1JSb3JQakZMVVFoQjNSQ1o4VlIyLzBqcG9z?=
 =?utf-8?B?SmtibEx3UzkzMmFwb0JjZmVjaXcxanlZZ3JnSUpzekdLbytoWjQ2MWlkekEw?=
 =?utf-8?B?SjdIY3Y4OVd2aG1Rc3BYcEpOSWJYSzJPY1hBc0RaU3NhVlBKMHdXcG41Z2lG?=
 =?utf-8?B?WjU0enErd1FYSXFMbjZsVFhlNnN1TkFBNFBVNWtES1Nod24vOUx3K1FPS2lu?=
 =?utf-8?B?VndZeFI2bVJ4SVk3S01FZkVQYm1JM2RXM3hpaXMvTGZaSC8vZmlSczd4QjNN?=
 =?utf-8?B?UEdqcVpUMkNWaXlLRnZaZDVlSlBENmQwa1ZCMjFLQUxWMHpoQmZSRlkzU29t?=
 =?utf-8?B?Nk1mbTRRaUltRlUrWFZHRzBXRVk4UjcxcWZ3ejlmaWsxQWRXcDRERmVGTVht?=
 =?utf-8?B?WVVLSkJZMkd4RHJnRVNYY3Z1SlFDdkdYcWlpTlBaRGRMVkdOZkNNSGNwMnp1?=
 =?utf-8?B?VE55cytXNS91Ym0rNWlpREsyQjRzNDFEOTUwNWdNQjFYeWxXQlpyTHVKSnVD?=
 =?utf-8?B?NURFdVh3M3JCVThTN3F4V2xkaEFUMkFKdVJWRzFYanRTNTVTWnRsVTRUUytH?=
 =?utf-8?B?VHFKRkQ0ZGxJVnkwcjJjajhPYmNma0Zjc0E4Rk1vOTlLTTRLMlJDYnRLZWNS?=
 =?utf-8?B?OGtiWTNXUzNqMy8vN0NmWUx2MXBkeWxqc1ZpK3dhSlkyYUVUNEtmSHZkTlNL?=
 =?utf-8?B?T252bkVmc0VOeHdhVEZuc0tWQmxyYmc3KzlvNkQrRE0xUWQxNlF3TUdUTFVo?=
 =?utf-8?B?N0loeTZPNUU1ay9FeGtYL1lFdFB6Y3l2dFMvRW83SGtXdlAxLzg2eE9NdnI1?=
 =?utf-8?B?U1ljVzRhY2dzUm9hYnB1Yy9qRFVNTENsNjJaQ3EyajRLa3ZxcXByMW1BZTY0?=
 =?utf-8?B?RUU4NEphQkN2Z0tPeVkxaURLNjNVTWVrUzFXRy9MT2NFWWVBbDRxM0ZYaDRh?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05434c0-ea85-4800-754a-08de3ecac19d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 06:49:28.6720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lvt2UJQ0+cqPOA55brT7YzT/AISmK0ZMRZaTashkbuCDmRuDLIls0DNfZkAxf6iy1iC+xnCAvEgaw/877D6tdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7045

From: Jan Kiszka <jan.kiszka@siemens.com>

This can catch stale task objects, namely when the original thread
already terminated, its task handle was finalized and dropped from the
registry but then reused by a new task object. The new one would
normally get a new thread handle as well, allowing us to detect the
stale of the original task object.

We just need to take into account the remote tasks or tasks currently in
the process of being bound do not have a valid thread handle.

Suggested-by: Mauro S <mau.salvi@yahoo.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/alchemy/task.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/alchemy/task.c b/lib/alchemy/task.c
index 67f199ec24..df5a6da76a 100644
--- a/lib/alchemy/task.c
+++ b/lib/alchemy/task.c
@@ -104,7 +104,8 @@ static struct alchemy_task *find_alchemy_task(RT_TASK *task, int *err_r)
 	if (bad_pointer(tcb))
 		goto bad_handle;
 
-	if (threadobj_get_magic(&tcb->thobj) == task_magic)
+	if (threadobj_get_magic(&tcb->thobj) == task_magic &&
+	    (task->thread == tcb->thobj.ptid || task->thread == 0))
 		return tcb;
 bad_handle:
 	*err_r = -EINVAL;
-- 
2.51.0

