Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013029.outbound.protection.outlook.com [52.101.83.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56F02FFDCB
	for <xenomai@lists.linux.dev>; Wed,  6 May 2026 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778063194; cv=fail; b=DH81yAgHKInklIy6tIaPsCSiH0SoapEWMSy0qrFe8PY786BDdocnid1ToP3Ny7fvqwz6JEVgfALZKUgbx8D3z56iGtHJT/J+gR+VSfezqd8LjjWFJ8TX6+YAE3/GWMFIpBK3ljit6eJykMADa10q4kkXkjMy9Y5EyDXk1/hy4Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778063194; c=relaxed/simple;
	bh=gkWuAZGAATxKHOKFFnekKTLmtp0Ffogz/8l6Zqh3kdY=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=uRwsocy+hEenZIjf0L8Eda9MyszgPKXZyNq8dPPkswYAgJAc3WCbe99027WXvJ/qO5h0vTbZ2TldpJIe1yXimtI4ar//oyjZgXgNQxxnL6OtjpXPQ7cyhjOiZxHFAXeeTtqm/9noB4JX7Tczey/jG8yaXl9aNg8B6+6LImjePRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zi6YZASb; arc=fail smtp.client-ip=52.101.83.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zi6YZASb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cns//b5ohu7f3f/rPUPsCp4AlBf1ZjBV1T4f3FF4Q/gHWYgzkYSgPBWld/4I6QRzX32IrDElcQRMkh3OBKxM0kXVhg2S+t/2xbekaRGLvpNQ3yxX3lPuE8XE/LuHjdHrw0GYNMoYy9uvH+SVvu+WaSdeb3h6AmujmhY2zYxpFtdip7riFkgom1z3Pp4gwmu3YAl7W6XO33l1GJHdbRQccI9r2pIZZ0SD+pvGg9L7asi7AXyxSXpcrCpXckwtwp8to/Imk+JmfTCPCK//CvyasiFITMPqecusbuiD/m5/JS39KhEQVOIFcltMC6SlLxLU7qaaxRLfAZhHsI6i7pSOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIP3lajKpRdNOMiHGOwMwcvFgH71ekRYwdpb096IT5U=;
 b=LtXkM9ZLrE6JMsXrKi29jOFx3dnXkKLcO2n/QQruhgU5KOJEHdEg/V2OyXqvP+jrnhE+Bdhir08C7L8SbkiyPeBn9GWUiMqnZq7VFTIuutIcxk8KrkOR7ssp2b1jbueUQszuvvBEHS05dfxkDUsCwiZqAiC3wys9O09t2RpD92kpeVDcPffGkSC1paK9VuHJxeq01VpMa4QFIWhgQP1vhIOTH6OBEj2FvcL+2fXk2QoT+wHalodMN8iQipncKR3j2UgRd5r9ZXMmnboB7laHve0FZ2l2+XEJAhSGqFDlgLkeKdzZzOmMsXzMR7SUnThZzqPBlufbAzdPrvGhWTedHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIP3lajKpRdNOMiHGOwMwcvFgH71ekRYwdpb096IT5U=;
 b=zi6YZASbu0fOAiONNfoKDCaX4nu2yFQKaaY9v7n1TUAv6TT4YdG2QlTv2WrdCrBfTckNzYz2Z5cgCbo4edhuhR77lD+JdqWXvLJbxO2CAQp03IGBoIVslolf8G0rDPNtG6xcyrmSqmNRTr7LMegrFzQg/vTW/I6kFZGF7jjiBtYBlbEv7l16nOfFgrQLuw0Yvb0eWPbadWb3Xhu6gBffnD62UWqYikCRzCgm+4cH6TYcajRXwI8CXt+QRsKMV/Px+xkgoq0O+hB98TnMN7jEAhE48RLvMSFytxPdOR6IS1n/+Bk1jsFQhMfrkZHqQUdKYQUb02uY3XkJY7g5MPMyKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8218.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:683::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 10:26:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 10:26:29 +0000
Message-ID: <f5c42b11-56c8-4a87-be41-e1b73172425e@siemens.com>
Date: Wed, 6 May 2026 12:26:18 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] testsuite/smokey/alchemytests: Relax mq-2 test over VM
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
X-ClientProxiedBy: PR1P264CA0046.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d0984a-a0ec-42fd-8a80-08deab59eeb1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	pVdJyoEJz6In3rtNjsJLg+hJEGme8GVd4z1nJfPMkD5Wo0D3qXlbuXmh8ytKZnpQyqLnvrs8/e20YxodfhcT8KMpjrgiXokVKNCWvhzmJGnGX5uVG5QjrLYEzlDmLXuDJhGqa9Kf9E9G4ZcSgPq1KG7ApQy97nbpQOCTCgwqZxZf9x07xY4Ob7tP0OhZgSjlpAfsGCpYygVfoogUmaHb1Hlslqky4O9t3Ob2wDeUGOX30Run/mlhGIEnJP3CkCF8SZ41BonP5rzOZpuUhAmAfnYeFL/euUhnLDuXV/KMCe02sBDMDND2A5ZA4X0bJF82r5OUdS27NQsKXSl8mMZ/ONR88OEKbd1mWUtkkbAIWndJW5qY7F4K0nX3naELyx3ILMjZI7yEQ1YtFhqQC4+fdTEazIjPZzKkCr+yWtYHfh2NIWwJAOcjQu9BpuONk2FRZaRv1tsmL26p+tIvT9RapGvM/xeuMHIu6tQVivAyiwYp8+tr8wAX9Mj6/ypqe5P4FniD/8CwAnGakGkz9f8BWIK0ipG77WMuoBCjXtFzYa1q/NO25uAZeX0DSeQatRSnQ4mdN/6RbNRomdNHwk9dGCfwOdx453t4vRgwK6EQ6GhlsOnYVJlAdcR3zJkXM6BruiSumqLZy2YqLgGJh41LHoONRAKZHMMoTyp1a9ubb8mnVXm16Kn7TLlk82j15i6y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1g3MXNzSE42SlU1KzRJMU9sdU1FNVNWSXY4TC9tL1FSenVvNjRMNEpWRUxo?=
 =?utf-8?B?V284L3lKYUkzYXdVV0U2MG5hUUlCTVAxV1JyRTRJQ0JKQzNGdG5VYUZ6RTFD?=
 =?utf-8?B?Z2xtNndIQ0VHUGxwUFVNUXFXaEt2d21oczRvUVRzNGl2QnNjdmtpTTdNejNn?=
 =?utf-8?B?U2ZCWG91azUydDAxcjJFekU1WVQzT25jUjg1UGpYa3phRUZYQWhQL3ZoU0ts?=
 =?utf-8?B?eDdMdVNCUG5MbU05cW5MSm16ekh5eklLK0EvNitrRmRWc0lzNlByc3pOWVZR?=
 =?utf-8?B?V2J2SXFsVXlUUE9BUUhWcC9nbGlOM2VtVUpBckl3VVlVc2xwNXMrcDZBYjAy?=
 =?utf-8?B?QWYxS3BtYWNPQVg5dDRIdkh1NVNRYnJkZE9tcFpvUTBvU3VJMTFHWUN2NXJr?=
 =?utf-8?B?NDliTUVRcGZLNEhhS1FJQWtzVkJITm16MVdDYVFqeW5BQ3oyS2J1M0ZjSDNB?=
 =?utf-8?B?WXZkWUlidnk0OXRad1RtakNZQ0RDUUZFaEw2d2x4WDNEcWlNRUlJaE5VcVov?=
 =?utf-8?B?SmR4SCthalVudy9waVFiVUQxSENJaWh0KzZHcWxVYmFTa1lWa1dNMXlrcC9D?=
 =?utf-8?B?dlVKZzJ0WWI4bitsZ0o1OE5OVEpWY2VZR2lkREp4bGRNMjVXTWdsaFlEWWdt?=
 =?utf-8?B?MXlFYk56Z2V1WVZvNjZacHQ1V0xnZEl0d3pRbWNpbGNjQ1JFZ3dURlNoY1Fh?=
 =?utf-8?B?ZmRGbDVXc01pZjBMbzgxeTN5L1BLVXoxbys4NVl1dy9FeEw4QWNtTzI2NWkz?=
 =?utf-8?B?MHhwYk1UdnU1eTBBOWVOUWUwSmM1azJzMnE4ei9QVTZqVEt6Znp5bG5rSDFL?=
 =?utf-8?B?L0p2eVVweTN6T3d6eitjbnNPYklTZ1k2aE9JZCsvck0wUldlZ1Rrc08wck9m?=
 =?utf-8?B?RXdxQWE1ZHp4SU1Kenk0ekxUakdyTE5RL3BYZDdreVlDZkRKWExmak1zdkZz?=
 =?utf-8?B?VFFSczlOV3RIYkVDSkV2NERuZHNkM1dSK0hRSVlaUXMxa09naEo5OExKWU5n?=
 =?utf-8?B?OCtGTHViUUc1MHR3amZ3RHVpaGFPRUNsS2NobFpzVGtTVkIxMlA4R21SbjB0?=
 =?utf-8?B?eXMyTzBYNWl2TFVHeXoxc0ZSYWF1cXVGS2loVnU0QjdIY2lHd2g5dlFqOEk3?=
 =?utf-8?B?SHRpeEhZWTg5VHBORWE3eE96bEp1WVBacXhjQVg1TTJWd0M5SWlPTjJ3R0Zl?=
 =?utf-8?B?WmF3akFGNDlMazJDUWx5RzB5TmJkUno3NHlYU2NZR1Q4OUtIVEhlaVZUd3Zj?=
 =?utf-8?B?OWtjaW9JazRQNmhHYXRlYlVVSkR2VE9xbC9lRnJwOGZCOGs1RXpqdHo1M04v?=
 =?utf-8?B?K1dxQ3BXN21vOEVMbEREd1d0KzdndndRKzMwTElzazJYZjlhS3VjS29VK3FJ?=
 =?utf-8?B?eVBYcVVZRDlEeG9pTkhCUkpOalpHVStpbDgyMVRSZndYdUlIVFhtR0VKREhM?=
 =?utf-8?B?ZnBEUnBnRXlTMlB3QkJPNEsyOVlkT05WMFZhLzlIL1B3NXloWHV4NUNDUlFB?=
 =?utf-8?B?QndtbVM5RlhvUWkrVlBwQytRbUxZZ0hmWTZlbVNhaGdnRkhaUTJScjNzM0NG?=
 =?utf-8?B?bGdhVWtXb0gvOUZQTlZHLzdoa2hIK245bjg5ZEVZYng3ejVHZ3hMR3dKWDIz?=
 =?utf-8?B?M1NZYVZjRkNWMkVEZkk1U0pXc21jQzR5UUlIRWxqWUlEaGU4Y2t3VllUczdZ?=
 =?utf-8?B?TC9FalNyMmlvbVFXRW9pNXp0d2p1UCtyTXlyUFF0WGx4cXdUN2MyWm5yYnc5?=
 =?utf-8?B?eTBUUTFNK2cvSlNpRW5tcVdkWmorVzRQWHkxY3dzUmNDcFJ6TTNmaHZ3RlhR?=
 =?utf-8?B?QTNPUWJPNGJsdEk5NEVOYk5DNVpEaU05aTRvVFJWTFpxNHhLbDVoNUh6eFVS?=
 =?utf-8?B?MnNPRHpQbnMrTkQycW1JdXdhaWZlenUxaXpuMlZYSjhFbzE0angyMjdHeXd3?=
 =?utf-8?B?RHRGLytjQUwvbVJlbE9udmhRbmFwRll3VjB5N25VbitYd01OYWtUWmgvS0dr?=
 =?utf-8?B?TUxlS0dsREFZS0JGRzB6SzNLb254Z2pqM3RLcVRGTWFBNW05NG1TMUJ6VlZ6?=
 =?utf-8?B?SGl4ckpESFdOeWdyVXdFSVZPcjBYTFlvaDA3ZXNESXZqYXpGZTMra1p3VkRi?=
 =?utf-8?B?M0ttbXpES1lFVVVKOGtXZnFKKzVUTERyUmp2ekVjWG0vZ1JMMDBHbFEzblZj?=
 =?utf-8?B?cnlPZXcyQkhVUlFCV255dWtGVmUzTGtERG9DUmZHVzhqUHU1ekY2Y3c0dm9N?=
 =?utf-8?B?RTVjVnNpMXYwNFAvQ2UxSTdKZndvVUdNMDVIdXdsZnA5WWN2ajBEZktZRzNt?=
 =?utf-8?B?T3NRNHhvazBWaFB0UmYzY2l1ay8ycDVLMWt4eEtHRm4rZi8yQ3B5MUlIcDRV?=
 =?utf-8?Q?T4UYdVTT84UslJ1A=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d0984a-a0ec-42fd-8a80-08deab59eeb1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 10:26:28.7042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aD7Y5A8t5I0ZBjkhkUJN1HF7lUxtuZW3+cjF//CbiE3UQhTlsft8C8xGA+WM0AJVh8291GkYLgPh/9QFz7qCrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8218

From: Jan Kiszka <jan.kiszka@siemens.com>

VM environment may delay or reorder the execution of tasks, so relax the
checks.

Part of #52.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/alchemytests/mq-2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testsuite/smokey/alchemytests/mq-2.c b/testsuite/smokey/alchemytests/mq-2.c
index a389e46db0..09b26b2135 100644
--- a/testsuite/smokey/alchemytests/mq-2.c
+++ b/testsuite/smokey/alchemytests/mq-2.c
@@ -7,6 +7,7 @@
 #include <alchemy/queue.h>
 
 static struct traceobj trobj;
+static bool on_vm;
 
 static int tseq[] = {
 	3, 4, 5, 6,
@@ -87,9 +88,10 @@ static void main_task(void *arg)
 
 	ret = rt_queue_inquire(&q, &info);
 	traceobj_check(&trobj, ret, 0);
-	traceobj_assert(&trobj, info.nmessages == 0);
+	traceobj_assert(&trobj, info.nmessages == 0 || on_vm);
 
-	traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
+	if (info.nmessages == 0)
+		traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
 
 	traceobj_exit(&trobj);
 }
@@ -99,6 +101,8 @@ int main(int argc, char *const argv[])
 	RT_TASK t_main;
 	int ret;
 
+	on_vm = argc > 1 && strcmp(argv[1], "--vm") == 0;
+
 	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
 
 	ret = rt_task_spawn(&t_main, "main_task", 0,  50, 0, main_task, NULL);
-- 
2.47.3
