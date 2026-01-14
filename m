Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011047.outbound.protection.outlook.com [40.107.130.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E2837C0F0
	for <xenomai@lists.linux.dev>; Wed, 14 Jan 2026 08:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768378221; cv=fail; b=g1qToV5WhAOeqq2KkOgirR6uJl7yuNvCiVtSbpLRttkgmtm+wJm22p+pYqBFqsnl7f8pmYCqRmjL9e5e80UMn31xXtDZ1+nvnd7qBzCHfd9xgnBs5lUu9AvcmJYF2z/DqMRnj87K3Oi0yo0oyaWZrzzVtTY+Fsmv9/x6USp/hLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768378221; c=relaxed/simple;
	bh=xDgNcETDSNzadXysa9txIBJ45uK5ytNMslp71r9cBao=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DilbY4iXlYQypYUmpRlV4OIPpEf+aQQlsV27K9/2JyFUAl6m5XNUq3E63vQ89sWBpfRf/tZmAZuRVeVQ8ZuNhc1C8VMpHNK9mA0l9UPbY+P4+/aagEed4aAcW5kBekzzXHEzULw5x0rKT/BzUW5ROAAvUbYCCQx1G/B/XsdcKvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dRjZQGfQ; arc=fail smtp.client-ip=40.107.130.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dRjZQGfQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iM/w5cXN0CdvPLu2oTmKEpPFFGwTHrBrvugqeaORISlzM5PNs7F1IYQOFEojzii2pH3Fjrpj4EeEDQHduo4BUsn2xXn0kFtRZYonccKxnrAmDHtDzF5e82sgedJWEUwyvyREzIYEHQ/A6EARB7OqPSwCyYG0F6xDR/qMB3zdkb0p9cDwcThnELbC+JCiEy/qbALejAJuRl4nkbTyvVk2keC6z6X2Dpi2OpSDCYbNw4UEkaZFnLmAOWazDTsduvKECD+vZV7U6XfOwfsUSl2Kvsl6TVWuNJtHAlTZ1BsENGT3miE9301B3oX5WG6t8zQOI690hfS/+rlbAHUwZpBuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIBvWNS4PzeY1xPWetfEZvLSROw4Ls2jbIXd4fxKJPY=;
 b=PW6hzqFDZdixM+lHnja5yH0tHJG4gEDL52/5JU26+462Wnh7yipjSPEsOKdgGryOWwrxHWwMceAowLcO6szUw0QJ6WpdNIn+CqXcl8D0mpJFOr7x1FBroL7JwbKees/2BBQ1yks8ZuTJMEArn7LQhl4bxJVCOxy4PYRloHIRrZlR9xDehSmr4wLaqvYOQDaG0MGRfTIG0spWUJOU3ZQoTAJkqoGpLBWnk1C+W5t2OIk3ufmtK2QDmb33sQ6m6QX5KChAYs0yglZ4i3U4wsXOv2aOVhPkHPBwKRyjvSV7Btc9HKBRfw5v5Yn/El3uQHhTjcbKIQbuRQxoI/RUcW8QhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIBvWNS4PzeY1xPWetfEZvLSROw4Ls2jbIXd4fxKJPY=;
 b=dRjZQGfQ1D6GWGZ2GvfnQuH7iR7/7RYC8DSzpKnuTDS5vZXKbK7JEiGXnri8lkf+uIWfe48SnDjxDDySvMPmeR9FfpBOpXDRdrVHZDUrIE3Z9kOHdHaAvTQ1RwmA/8U+SiwMJDsGohJjHb0Kmmk1IsxpY36Qo+vhbl9zyORj5d3esFDDQnLsqd9HiW6FPhwrGSEXRLLN8ysK/TOWVaGLt++q1lSPqtcree/xAPflfLQ43zYRtEgEbYIglA0IxXWJQOhOqy1HiNZiYG+3rzt6Ga57fq8o2U0C9D2cXnz+aJ3XIo1nRglzneppeqC0/Q0VrxKVGNLvOHaTeB1z50HrrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3640.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:135::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 08:10:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 08:10:12 +0000
Message-ID: <00cd175a-59fe-4cdc-8446-bda6624c8817@siemens.com>
Date: Wed, 14 Jan 2026 09:10:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add vlan detection on RTNET receive path
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>,
 xenomai@lists.linux.dev
References: <131f-69668000-3-a70b1c0@235185828>
From: Jan Kiszka <jan.kiszka@siemens.com>
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
In-Reply-To: <131f-69668000-3-a70b1c0@235185828>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0010.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3640:EE_
X-MS-Office365-Filtering-Correlation-Id: f081298c-8d87-4593-dff4-08de53445778
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnRvTUFXWXk1L1JwZUszUzNhalNyM3JQT2hpdUVJVzVZeDQzU0JxVCtoZkV6?=
 =?utf-8?B?ZkNZbUUwTGFRWVhZVFJPZGtENFpXYlA3YmRYWGpTNlFYT3BIU2NveU9yWjMy?=
 =?utf-8?B?YU8yTzhMQWx2aXdudTNwSDJqTDIyRWlmaFY0QmNsQTVCU1VzM1NmaUUxbDZl?=
 =?utf-8?B?UkUzb2FuQWtKTjN5K2ZnNDVGQkdxZTZzazFIeDhyelIyM0sxbEFZZmJjQ2VJ?=
 =?utf-8?B?SWRBMjY5b1g5WnYvbzRqUlJlSWxxeWhOQXpkQnlSa3lUeEtzM3hRS2VHT25R?=
 =?utf-8?B?SmVlUkhLUzA3MGlONERickN1L0U3V09Xa0NzOWdWUmswK1FOREV1UjRJUmJR?=
 =?utf-8?B?L2E3U3FSTTNZdSt1YUs0REJvM29DcXNDdTBqV3gzRkQ0SVhTUEZqYnlodmh5?=
 =?utf-8?B?NVlPQnpHdiswckdDVG5SMXg4MThnWkhOVWh0ZFFFd1YxNGlvbVh6RU85UVNa?=
 =?utf-8?B?dys4clpBd21wNFNqY0k1c3BWa0gzRUh4OU1ic0ZLaVpkNmhoZXB1U0JxVUx3?=
 =?utf-8?B?UVluMy80MEd6dVhRZTNWUWg0VzhGT3NoTmlmYkw4SC95WW15N3ZFRGdFeDVL?=
 =?utf-8?B?YnRXMTRhRXBzbVZWbnRYSXl4Z3ZCSEs4MXZIeCtRSlk2T29HNjlvdDlINjJO?=
 =?utf-8?B?K1RpNkNZY0owb2NHOUE0eklhUXB6OUJuU2tXRkRHRWk2NTBmUDUwWmx3cGVr?=
 =?utf-8?B?NVQ0YmVNenJiNFdsQUpoUkJ0dmEzaGZtVlFWWHVsamVmNnluNnVCS2IvSVQw?=
 =?utf-8?B?Zk1hZ3ByVlRjRjU1SFlrQVIza3ptUG1xUTNkWkFpQjF3ZGtBMS9iWWs5Skth?=
 =?utf-8?B?VjZFbjc1c2N4UW9XUzJ4Ykp1c2hBQWt5SmlyMjVqL3RuY1pGVHkyYlVhMTdI?=
 =?utf-8?B?eU0yTUFpRmZvVW8rWkpMTmF3SzUxL2RNMklPV2xCQU5nNnRFd3orOUIzaklL?=
 =?utf-8?B?OEs5cHYxOUlJTzhrelRtbTVxNUE0RkVDeUliNTFxQkhBb29TYjNjdXk0Z0U5?=
 =?utf-8?B?OVBEdnBxRlB0NG9XRXpEc0RWTzBzMlNlU3FVWmhKL1Y0VW9od0JuMFJhVGJj?=
 =?utf-8?B?eXM3RzlQVUptTDVlVUJCcFR4NG12Y0J5QmFhUjNwbWhrSXRZQ1d4RWh2NjEz?=
 =?utf-8?B?cGkwNktvNzdDazZLUGR3UHh5YncvSW5YNDhZUGZTZ25lWmQ1ZktZTFk1bG9P?=
 =?utf-8?B?ZklGOHFST1AzSGlkNDd5YmNtY3NFVFJVWE1VVGxqdkZqN0hmSDRKcTdUL2xM?=
 =?utf-8?B?R0NhV0dNOHdKaUtGajE5NWU0TmYydDFKUVJKWE5FdXlxazhpL1AwS25zVmJi?=
 =?utf-8?B?amFoclF5WVB0TGdNNkxtZkJ5cDFoSllnOXlUZVBvenpEKzdNVk5XR2ZvWFVQ?=
 =?utf-8?B?ZVZJK1p4ek9XUlg4dkpDOVRMa1hXZ2hONkxBSDl0ZDN0ZE5sSEdOb0wzS1BD?=
 =?utf-8?B?d1BQQTlqUVZaNzlqdUxUdFFZbUU0T1ZzQ1QxdFNMNlFGVnhXWkhwaVU2NytN?=
 =?utf-8?B?RTd0VkMvY3diM1BnNXgwMmJwZkJwMDkzTkNNUTg1cEZrNEF0YXh1bk9PcDVC?=
 =?utf-8?B?aTRuVlh5TUpGbFViNGF3OHVPVit1VzZHcWEzS21ucEI0WUk2b2ZtUmNubEJO?=
 =?utf-8?B?RVF4anNtVUpOYUd6ZG5ackMyQjdxL1hmbytpVnFCNEE2akkzTDVETFpYSFM4?=
 =?utf-8?B?QXAxb2JJMkc2YjF6RThuTGxaSHNHRkdZdk5DMW1Kb2tHSzBMNWxHYlMxaDRC?=
 =?utf-8?B?dWVOOHFMUm51TzZSblk2b3MrTFFQMmZoMUhvVENoK1pyeSttZDVlSThMcDNv?=
 =?utf-8?B?QXFxVkZRRXcxdzNMNkxJWEJLMjVZTXFXd2JaREx6RHFQSS9oNEJXU01ac1BI?=
 =?utf-8?B?N2trLzNLa3V0aXZQT3RtVWpsSGZ1ZVJ6V09hd0k1aVhhVHJKZ1ZKeWxHcmlT?=
 =?utf-8?Q?4DEzeRgEX85s5CLuxYFHlQUDEx+vbwIh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFdGaU1ZM0hrM2Y4d2dYSDdnZTV1NXhpODhXUHlGMGpSc1lHT3VnWWJBaFVN?=
 =?utf-8?B?MkdWTStjb1M2dnF0cFhQbTA0SDhOUUp3L2tsK2ZCd2IzV1oxeGFqb1craVE4?=
 =?utf-8?B?Sm9DZEovelQyVHNFd2w0RkR5T1A0T2VPNFoyc2JYamJZWXBQUHRRUkROaEZP?=
 =?utf-8?B?enM0UkUrR0NMNXJIaGNySUtvZzZha3BrM0p6VWhjS0piRmJVUnJCNkd4ZXN2?=
 =?utf-8?B?MmJBMVF4VXFDS01BQmNQbjNiRnNCd0xzcWxtMnlScHE1Tld0VjNIT3VlZGVm?=
 =?utf-8?B?M3ByZkV1Mm1pdDhkcHQ5OHRYSHcvRUdINndwUE5iU0g3V25DSXdYUTZsd3Y4?=
 =?utf-8?B?eHFkS0VpYUkwQzdVZHkyNXVoa0RramRpU3AxTWpIdklDOFhkVHVHSk54Mk5Q?=
 =?utf-8?B?UmhTL012Nk1zSEdieDNCQldnU2NYWk40YUFzd0VjR2RNOXBYZjFmR1VQc1ZZ?=
 =?utf-8?B?RDh0WFJCWGJ1cUh5UHdlY29pMElBdFpjR2FubDJ3OFBuNlhBdm1IbSsxa2JQ?=
 =?utf-8?B?Wm0yZnpxR09ONlNsWGZFWlNHM3RKSjYvUnhyaGFlaTJObTBvbUpQQm5sUlAy?=
 =?utf-8?B?QWliSXN4dkRINWVWbmFJaXZHSVpBblpOZWRPY2tlOXJzeUdrMmVMUjMxd20y?=
 =?utf-8?B?NkRZSlJNS0s2Y0dZTStmT2lKZ1pEVFpBOU9tSlhjcUJuZThjM081b00xdHNs?=
 =?utf-8?B?QmdFZEE5TDFuOEFMRk1Deld5cXlCRmw2bmYrbVE1K1FlZUxtRDQ5UDluQ0M1?=
 =?utf-8?B?VE16bmxoMWp5RXFkWGJhVWhDS1ZFKzgyNlg0ZGRYOUo4bFZ4UVVQWG1EQTM1?=
 =?utf-8?B?Z3k2MkRyRmpKV0NxbzlMUG82RHIrRzVUS00wdHVvVklZQURkbkpBSGk4eHcx?=
 =?utf-8?B?Z2tKYk1BSGdwdFhJcHI2VXhhazdLd3RHR0lpQzBFWlBTcE5mV1lZb1owUytD?=
 =?utf-8?B?RUJjN0dKZTYwZFRSOHJPN0tGT0dPd1padlVMa29jaW5PWHMwRjlDdm5PTGpC?=
 =?utf-8?B?amp6MUtoSFI3N01Jam5ZNFp5N3pHNTFjMHg5a2QzTEdpQXpwOEdiOURsVi9K?=
 =?utf-8?B?WHBWenlWQTBNV3hKcm94c3NDYU1mRHQ1cHlTZGVqWlhaWENxQmkzbkw0S2hy?=
 =?utf-8?B?ZG9KRVoySFlBYVorZERpYzdTN21DUlhwRWNpQlVxazVxNi9WUlI0SXhPaWda?=
 =?utf-8?B?N2xCRGMrUTdycmNQNCtOZmRxSVBURVNtUFR2R29EUFRpV1F4ZDZWbzVyem1o?=
 =?utf-8?B?RkFBTXFoVU1NWHhwK3k5Wms3R0J5dWpydzdLWDA5Q0UxcU4wR1ZPcWd5WDZB?=
 =?utf-8?B?bWFQWUEzZVBCRW0rMjRPL3RTU3psNzN1bW84N2QxRnpOd3NHMXZ0OTdRK3Qw?=
 =?utf-8?B?dWwvOTcyUDdPR0dkaHZIeWxURVlaQ0dCUnlkYXNhN3ZRdlprdlYzL3BHZURh?=
 =?utf-8?B?THFjWlJIREhDRmx3UEtNczlGQUZndHBLblI2ZXVGeHdqZ3NNamcxOHJNbjg2?=
 =?utf-8?B?VmgyUnRjanVzdHpjaUs2T3YzcXAwWFZhbmVuMHBTN2hlbzhaMWdxUHFyMUd6?=
 =?utf-8?B?cnJLSFhJS2F3Umh3ZXBYaHlnOWorYnVKWTBINGpjOXdOcUkxek1KYlpUTTFQ?=
 =?utf-8?B?dGtMODA1cWRKMkthbkxzTGxjZktod3ZiR2lRRllRZjlGWEFHVzN2V1Vqb3Vv?=
 =?utf-8?B?VUtUWTZ2RTFGelJsVjhjQ2JoUW5XWlhLd3hNVnlINS9zVkJFT1lxbFE5dlpz?=
 =?utf-8?B?TE9iTEtreWd2dUU3UUI4amtMUjZPQ3FXeDFJQ1VSVDFkQ3FFUDBrNENvNXJw?=
 =?utf-8?B?MFBnNExWaTRpTEthbzEreXlxUzZwcUdpcWxNQUpieStUMkhHd3RyTEV5cjZY?=
 =?utf-8?B?WHYvUkQzOHRVSlBiVXMwZDkyMUhFU0JHSDJZcEVLYkdzQ2J3OE1oa3dCRDZn?=
 =?utf-8?B?T2cyOEM4VWJ1bnRITGRqL3R3cjRVNDMyMzU4QXdMbXJZeHJjK1RLOTlMOENs?=
 =?utf-8?B?dWIvTU0xK3U4N0xBWW1XdjZqTjR5TkFWdWxtaWtiU0UxU2VlOFl6WWEycElz?=
 =?utf-8?B?SFJtaDRkb2o3eXQ1VlcxaTI3anVvaTlkdGFQRm5obmc4eXJCWjV5WTZBeUEx?=
 =?utf-8?B?ZXNna2VVUTVpSDdxQXp2VGRnVzdla1o4YlJjNElJK0xNWG0xZmVSVWlPemFV?=
 =?utf-8?B?TUZqdWEzdGJ3UFUza24xSkZ3UGgwY1RoWWY3QTRTV2RMYmpVSXBsell5WWZt?=
 =?utf-8?B?RFRheUpRaVltNGkySkNMYmYzc3dPR1I3VTBic0NlRWN3eER1WWhVbFROWURS?=
 =?utf-8?B?dmhZWnpHTnJMMDhhYURzZEY2ZlhBYko4NjRzUVJNNGN0RzAwbTJ3Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f081298c-8d87-4593-dff4-08de53445778
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 08:10:12.7064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eou9eRj3jh/ZXh0Tj9cU4QfUspbWv8uQ2CSu8yAlY9fwIOh4bzXl/2l2pAb0mbj8E20NFMsgi8pNgjo1TkYKlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3640

On 13.01.26 18:25, François Legal wrote:
> This patch allows classifying the frame in the right protocol (skb->protocol) when receiving an ethernet frame with a VLAN tag.
> 
> This allows to make raw PF_PACKET sockets be transparent to VLAN tagging when filtering on ethertype.
> 
> |    MAC Dest @    |     MAC Src @     | EtherType | VLAN TPID | VLAN TCI | Payload |
> | 11:22:33:44:55:66 | FF:FF:FF:FF:FF:FF |     8100       |      0806     |    201B     |        ...    |
> 
> With this patch and  CONFIG_VLAN_8021Q set in kconfig, the packet above will be classified as ARP (skb->protocol = 0806)

We generally avoided to bind RTnet settings to regular network stack
configs, just to control them independently and avoid surprises on the
RTnet side when changing something on the Linux part.

> 
> The behaviour here is somewhat different from upstream as we dont strip the tag from the frame (for performance reason) as upstream does it and return the VLAN information as out of band (with recvmsg).
> 

So, what is the envisioned use case with RTnet? How does the RX-side
handling help when not doing anything special for TX? We should document
that as well.

Jan

> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
> --
> diff --git a/kernel/drivers/net/stack/eth.c b/kernel/drivers/net/stack/eth.c
> index 427687f..9b3ad94 100644
> --- a/kernel/drivers/net/stack/eth.c
> +++ b/kernel/drivers/net/stack/eth.c
> @@ -23,6 +23,9 @@
>  #include <linux/netdevice.h>
>  #include <linux/etherdevice.h>
>  #include <linux/skbuff.h>
> +#ifdef CONFIG_VLAN_8021Q
> +#include <linux/if_vlan.h>
> +#endif
>  
>  #include <rtdev.h>
>  #include <rtnet_internal.h>
> @@ -107,8 +110,18 @@
>  			skb->pkt_type = PACKET_OTHERHOST;
>  	}
>  
> -	if (ntohs(eth->h_proto) >= 1536)
> +	if (ntohs(eth->h_proto) >= 1536) {
> +#ifdef CONFIG_VLAN_8021Q
> +		if (eth->h_proto == htons (ETH_P_8021Q)) {
> +			struct vlan_hdr * vlan = (struct vlan_hdr *) (skb->data);
> +			return vlan->h_vlan_encapsulated_proto;
> +		} else {
> +			return eth->h_proto;
> +		}
> +#else
>  		return eth->h_proto;
> +#endif
> +	}
>  
>  	rawp = skb->data;
> 
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
