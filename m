Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8AC35DA42
	for <xenomai@lists.linux.dev>; Thu,  9 Jul 2026 17:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619791; cv=fail; b=rpX8TTVB6l+0zg/pFMD/jfQ9wTO59n96whT1ermm+t01Xj4vyIfsvK1nQJay4TnLX80LPSAeTz/a97I5IByRelRohXN7V5pBnPAQh/dGIdIlr3Tsbht3C1T9s5NnKMJMimsW6dfUkBdwxq24GEYNXAAmU4+F4VQfVrdafdfI5TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619791; c=relaxed/simple;
	bh=KMTncTG5ipVp2SHlaUgIlfq4wx/SVkFTM6/TT2kSQqs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B2ItEcmtjZcdn2VmlSF1jO0EK/EyBgiALgQR+4a0Fr71MuVm8YWqir3tpFAKLNSXbMzbF+4f0z/C3hA/m5xlV1IMn/5KsYs9HrvVKV3ZDFJHOIf1HbzvWxGuooX3f1XQ8XuiS5R5Kaajl2S2Njc/zq6xb7u5ZjGApZPvaPZ4oS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Nj8yhb4y; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Nj8yhb4y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaKNsEAaux9tFsEKXOt+TlEU7MHOT7GJh6UAqbKIcgXNQq3Nsggk/hsfFiEShvp9p2uhEqaq+uBYFFCoHoDELA4ArJpdgzJiJtPDuj/R4qn7UpZQaLXZU3Fbbtt23nyGXuJwmKFIaKYd2ep+lgS70rAQQb7dxnKWtofNDQ7Hdgn4tKC8OG9DSFbTikaQV+2ZQAJ206jz87Tymd5bnP2ywY0gloxF/0as+NdGLYTQllOCp1b45XTFPs6U8hTEr1vM16U85Pad20oBkPwrTOylPvv0waqMkIKq0QXrpiDHxXt5AjHWe5eZKC4fqfKW5+ylstvvA/pQVxaYj1wQJA5CJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJNYw1ouMHYx87Auu7Z87AtsmYuwcab8TiVM9tQ5GBY=;
 b=GCcprWj0Ofg/VkpxemB+E+ovI1bU3zzI2KMTsa/UUwWvPxQUo77lNlV3hemj+GhPtmYFPZVVef199Hc5vz0SwA2lfKQtjSKPF/WVMVARQkdYp3hJhdb9S96yAr9Vt8oithTwRu7DJdVF3csy0FCW2ACqxeXGrWU9Y+rQqN/JPMuw6kNR7KJ3L9Nqk8AtHrgrvQ+fPGbM5DeM+7WxFE7kQ136EZfOWrWrbI3LD3qddBWHyJXrGAZdyDHMEGXbHuX1NLwp7Q7aNS8OB+KQo7iRJGJMiiiT51ACX0SgsA1BhK84DnncnZq/z5B7nr3WHy/lR6V+lgC3X4wwY2RArra9yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJNYw1ouMHYx87Auu7Z87AtsmYuwcab8TiVM9tQ5GBY=;
 b=Nj8yhb4yBGFtyScH/TPCMWmLASxn3lASXyqbgeRGAo8gMtJq5dTPwVt/EsazR1hefPLADmDyDa0CEDjrlnbYoQStDLLbY81l8LXatm37kO0XN5HD6BYDEKVlfFLwsmOkMVvl9FPu2UK63lh11MbIUHVoR3m6FJ2lUAPPb0M9BfSlcQW5xfBoUXQ2dnNoYb2zlgKLKFPkvAXDqpD4pLHAM1aK16vLb6tbK6NXBqybOkqmlIYO6ms3lyWuKd+Due2jT+63ImmX9PknYE4A8EXs2M8MEILkJmuGlvnozhKAC3b8YNrGS0/mRD+YmUmrn+TmdS36Ab53TwB5FXLm/c+e7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU0PR10MB6728.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:400::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 17:56:26 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 17:56:26 +0000
Message-ID: <c2aa1b49-dffb-4e3f-943d-797ce27932a4@siemens.com>
Date: Thu, 9 Jul 2026 19:56:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH website v1 0/5] doc: refresh Cobalt installation guide
To: guang_feng_wang@163.com, rpm@xenomai.org, florian.bezdeka@siemens.com
Cc: xenomai@lists.linux.dev
References: <cover.1782585785.git.guang_feng_wang@163.com>
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
In-Reply-To: <cover.1782585785.git.guang_feng_wang@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P250CA0030.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::35) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: a22e9df3-5bfd-4b55-1154-08dedde36549
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|6133799003|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	gfpbZmf+vfn7R+hyvMk+8wFYaUFQJ+4h0DZPp+5Ia3gBbHZ29Ov4MsUM/EvyLVPY4FdtZwvXOeVxWt+YvjvkNonWMvlg20Z90PcSOnyx//lcYLnqjSz1Wc5667wRKxXFYudrZJvqVqh+whz/DJ8pgr6rysAOp8a+F7hsFqFDb5dKKI38CcAwy7zRuwXQDhoSyZxvHHS25kEuUF9gVhbaj3zH8vm2siST+nPipxbNksEUo8viQHFHsWKKn+AERzCFiDOEAaXPsb+hDedQ0XcFt2e1e5izebJdnQfmByjGgjSmw8f8ILGyuMA1hMFVLCrgiJg2FAKABzHmb6jAm4DtcIgVEuAWe53haT2F//JY8Xz2CntpbV175pFEa7PmlFCrU56yZNuxQIGDYG9CrWCZE83PBafmedR1M9ZHE5RPXd42bTVxQ+L8gCRXIrRKJRnhPdK8CX+H7LN+YQpzHiJxLpVOoeqY9OGaL3C8pz1zqy5WWLtbWGSNO3Wvkb6280YKJZ13A5BynjblKFcvwx7A8c4G7I0LF/TeV+qxw0nWjMp5urfxuwkOG/Np8ZImqc/IFEceiP6MODRKbz+HjlyOfdi0fY5/DFOCHQjmvx6OuNYqozRWdlNfFECLsikWeagwVCUJzSFfQILn57gfrM74JGZ6bSXLeB1Ka425Dj21xoo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUxXSDg3dFBzQU1kelFQOGx6enAydm1paUxIMnVPMk1rNTBSbGpXdzJ3dTJI?=
 =?utf-8?B?M1B6Z3N1Nmt5aHJoZzI5c1JzcUtscndkbjMwUXNNOEM0RThIWHR0Q2tRWmpR?=
 =?utf-8?B?QUVFUXJyclF1RnF4cWJPY05jc0huZVB4QzBSUTZIajBXRXdQNzdLOVpPWUpi?=
 =?utf-8?B?UmNvMWRDWHNpb2xzbzZiMTBVNmJ0ajBBbkhEMjRuREJFZHZNSHczZXoxZlE0?=
 =?utf-8?B?Mld1YnhOOFloSXg5aFhZWW1TbkRGWGVMR21LUDk4cXlHMTZwdXlFWlM0akZR?=
 =?utf-8?B?Qyt4bGNoMzVqeTBxZUUrSWVKY1JXOHcxUzZHOU5GdHZ1NjUwZTBFQ0RrcDQv?=
 =?utf-8?B?ckJ0bUZZWFgxdEZlZFF6WWpHNE9ZN2RmOGZHYnRPQ21YOTdzRUxsakFUaHBI?=
 =?utf-8?B?OTBERUZsVnFIckFYY2RjYUx0V2h0YWdHV2NhcCtMTUdQNkw3VENXZ1lQdlpy?=
 =?utf-8?B?TkMzK242eXhId2pVR1FrbC9xTHFjSnJEQ292QXdQSDhocDFOVU5rTXpBaGJr?=
 =?utf-8?B?M1ZBV1pYbmFIVVVqUG9OT01VNnQzZHdNZ1BsVUh0ak5Sc2pUL010UTlHV1h0?=
 =?utf-8?B?bHJPSEc2Sm9GM2llWS9ybzYzd0ovL0NJUDlEMWFROCtwMW1ObVdqM1lKUkpO?=
 =?utf-8?B?Qmk0NUxpYnBLMVNDUW9oTUdSY01FMmgwM2hZZ2MrTmJkMkRPallybjMxREpq?=
 =?utf-8?B?TitQOVBaaGp1MVZldlNUbzFLM2szVCs4bGtsbUl5SG5nVXpoaUoxYTRSS20x?=
 =?utf-8?B?SUZYbkVUTklPSTljM0tVZ3dtQzdvV2k2VFNFTUExdDVQaXB4ZTBPZFhkTHc4?=
 =?utf-8?B?NEZzT3NOLzBmRTVzN3FFYVZNY2FoSFJFU2VDY2FIUnJmazI4L20xMERSYkVM?=
 =?utf-8?B?b3NsY1Zacm9IYTJNQ21IZitTS0V3Wk1pVzI0UmVvbXIrM0dQSUhSZjZGL3NW?=
 =?utf-8?B?eXFwenFMWVA4Mndla2s0elF5azNWdU5PdGM4R3pYRzZKR0VjSCtwRDVNZUhL?=
 =?utf-8?B?dUY2dzI1dldTRjR3cERWdllZbDVpa0VkWG9tWE9na1g1SmJueEl2bDVZbSt1?=
 =?utf-8?B?MytqcndVQzBFODZxZ0ozZWFTRWRwamx1UXZMcGdDMElZOTg3TDkreDhkM3lX?=
 =?utf-8?B?ZHE3c2FDTFo5ZUhxWGVxWURKY2xTQ29RU1I4eVcwYjV0YnUzWDhJZmFCbzZH?=
 =?utf-8?B?dUwxT21acFRqdFBYT29CMGZTb3B0WllhUnprcVp4YnlrNDJVcTgvMTBBSnQy?=
 =?utf-8?B?dEVXdWJNNjdkUnd3dit1b1pOWk1oSlZHMFhwTUd0MkFkTzlwdlBTY0JURWtl?=
 =?utf-8?B?aHhnV3dLVzdsM0hWSXV4TlBJOFo4dVdXaC9Uc1RVL2t6SEhhK0tTMitXVUhh?=
 =?utf-8?B?NDRsTmxZRzJVQmpqMmNQZTFrNjFYRjlEL1publNUcE9UbW5xakxhVzNoUHhH?=
 =?utf-8?B?T2N3cWt0UWdXNjRzbnZzQ1JjeVl5aUtzbXVKTm1CUlYxT1FZR0I1TWltckxt?=
 =?utf-8?B?bFZ4YUhQVmhqbXhvdGdnTGtIa2o3S1hoeEpFeDNobEt3WERHTnhESTNnQmlh?=
 =?utf-8?B?Y1RseWx2R2F2bER2LzVmWXE1bEhEMi9hK1krdHpGS2kzVjhMRFpMZFg3MWJM?=
 =?utf-8?B?Wkp6OUZsaTB1eUVCS3o3ZVhnRFlvckhqTGRtQjI3VXFXdStBY01GckJjbGJm?=
 =?utf-8?B?dUxJZlpaNldwNW9OeFRJeDJGcFpHMytWYzhycnNzTUpNMVR3Q005K2Z6aXNS?=
 =?utf-8?B?bFRvSFkyS2dZOFE3REpXVUgxZUdzNXVrMS9jZjNpWE91cHVuT3NvNXVEQUhB?=
 =?utf-8?B?c0Y4YXVmUVRhZlEyMzNtRUVGUTZMQ2hIVVVGY1ZRRWFEYmsva0FpNlZJNGxp?=
 =?utf-8?B?RzZPZ3JGamtnaWk1NjRETzd3U2JNaGtJNXg5ZkxsOFVRbWUwZkpidkFVZ1NT?=
 =?utf-8?B?MjlvWnBFcjFkcGd6SHFKMzZwN01OeFk1UlNaU2ZVc00rTWs2OGgzVk9BZUJC?=
 =?utf-8?B?R2J1RldSRTFXMFNNYmlybWoycHhCZzFvbXNGQmNMUWRYYncvYkw3cEpNSHNl?=
 =?utf-8?B?b05nYWdvQlJuOVZ5RjVDZ3JENHFwVTA5cmtOaHVpZHp0M2RaRTNvQytGNU14?=
 =?utf-8?B?OFh6WWpCaWhrZkI5VnRKOC9BY2dza3VFZTFyeVdZSTZXcHl3MDhKNWZidXVh?=
 =?utf-8?B?TWhES081ZzJ3akR4dHdmbE1kdU1pYncvS1VtZUdrZ3JmN1F3UmhibnlOdE9X?=
 =?utf-8?B?T1pIMzF3YkhJS0w2YUhtdmMxMThCV0ZhUG5NdXFPcU1ubXVML1hjVUNHYkM5?=
 =?utf-8?B?UWxEV2dtTkJWTnlTNFp2QzFaUFZSTlhKQjJsZmZQRENPcjY4WGh2RjdBRnBx?=
 =?utf-8?Q?SgExZnFzKZ0lUcQE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22e9df3-5bfd-4b55-1154-08dedde36549
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 17:56:26.2003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XS+qd00X3GkePIW4GsGrS37+SqkEKPtTGG9+EJVqQWwlg2OzDA+FXCiuJ7P9rOcV82jiMS+364OSdFAWxZaNaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6728

On 28.06.26 06:50, guang_feng_wang@163.com wrote:
> From: guang feng wang <guang_feng_wang@163.com>
> 
> Hi,
> 
> This series updates a few stale I-pipe-era references in the Xenomai 3
> installation guide, mainly around the Cobalt setup path.
> 
> The page already documents Dovetail as a Cobalt-specific requirement,
> but a few examples still refer to legacy I-pipe references.
> 
> The changes are limited to the following patches:
> 
> guang feng wang (5):
>   doc: replace legacy I-pipe usage with Dovetail
>   doc: update stale Cobalt kernel preparation example
>   doc: mark old PowerPC and ARM build examples as historical
>   doc: generalize ARM64 Cobalt build notes
>   doc: update Cobalt boot log
> 
>  content/installation/_index.md | 39 ++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 

Thanks, applied - except for patch 3. Maybe we can resolve that finding
even better.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
