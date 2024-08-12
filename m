Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2080.outbound.protection.outlook.com [40.107.247.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B9F187353
	for <xenomai@lists.linux.dev>; Mon, 12 Aug 2024 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479226; cv=fail; b=asTdUH62AawoBePCuK+I9U/K8/I/+ff7/Nv7ZLQAmOk6hQxzp3c0hxy4U2CkzF22syd+/raULKiwgvAxD4YrVMOQb6GrS1qBr7LXMm2plof2xzH1NpUK9bc+BHC2sHRNzQRsDj8wLLPH5XWYVWeMaHJHSvsBQO7Mxz3IwpGr734=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479226; c=relaxed/simple;
	bh=Trc8jU1oIx8Olbehm/4usW4VfL4Xtpx2wj5HosUYkVw=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aHledGa9Oxxa/Eqmp1wYpFkZXvZsdUMajnvVIYKgemtGjlFj7UFgHuPqJrMNtR/N0wkgeWeXQSTDumpQHrC+yle3gg62WsNqEsjAlw6H1hsw+2hF4m1JQROZVHskGhXN5IAVKL/W/NBFCIWw2751cdDmyj+Bv4NDS6yCejdkd30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dQVwNrND; arc=fail smtp.client-ip=40.107.247.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dQVwNrND"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pohlcfESMakJWJysWbU3kl8xCEUUXrc5yvkCp2t7vyH2I4AYXUlPpmUXul3PMCYaZXem1mxaV3z7HWL54c5EHsRDjRfH6emBAwMfFCRLRd7jxMYqKSAjSaiDBb4AN32x9q1WaSdgBn1h1KyrKhWyzOu65WSDwa9Wkl1UFtNuSQHJKYIWq1K5ENogenBdGOUG5bUxSqSJTYQJ8plY4D1ONB2G19nL4VrO+jylXJuBCtco3CpBPsp4etHeUAqhO0FsRj3nqrX/l8F5B84soAfAXYVXSDGRdFyYjSoRsT7kJDD+fSSZAYZtxZ8c+/CLVs6ISmmqThxv8wcDi+FFeaInsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qosJcW/46Xf4OQ8xpnAHNpnj+pKzR1SohhOMDMuc7w8=;
 b=dSYd3hMrUZizvjQ5D1jX/w6z306FxQZSNgP56itbkv928kEQxWJ03uj4AI0dv3f1KcW8Bx+vx8PuUAbJB0ARzyVDpOjcmUXMNOvJlUPX/z4iTv/EQjvNclL7Xc/WF/n3fk8NqNMCd4/PVG2ruw7twXJGLYcLpbXO2tynsrZVRb4NhyI3NWDeXNKJpPKMqPCFvCqAEF0Z6SDVQhOUXSKzg9nclZOUSU4gJZY36n1QHpXj5kGyhnRxRlk+/olXsMRAR9F00CtWx2keYJ/Ubxo3irIefJmz+GF0gkqTiMsIdeuRrVkzKNGJJAveN35GUVH28kq9vBXvfRpPUCMmBi/ryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qosJcW/46Xf4OQ8xpnAHNpnj+pKzR1SohhOMDMuc7w8=;
 b=dQVwNrNDhhO6eqCxFd5lVh0AKfNDU8IDNk9RSlNMoLhD02iIUF0jbJ79z3aRUc4L7CPX4JGVwp6i2h/ssVxuJCpAPhsiAjHTgsJ8YolXrtWudntGb/oDv+2vXoYUU8RvPWBXwKeQcFJ+5NtkeaO/Dfku+Z635t51uG3Hd+47jalgnDANpqzwaDYVp/vfKzqnt7KVRD+0TvTKvExcwzY4zcBBu+r+YrTdJKJsc894d3A8DfJsdkKmoCmZRK9/H0IiF1YkvqG3AfmRrIIEL/HHrYUDGlPUZr9ek3WvyLMB3JMZvRw3RIYBQkqaHbjcJv2TEwccgE2XJUMpseiGMkiwsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3152.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 16:13:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 16:13:38 +0000
Message-ID: <be38db04-d897-472a-af1f-3987e2691d18@siemens.com>
Date: Mon, 12 Aug 2024 18:13:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Xenomai 3.3-rc2 available
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
References: <a125733d-8b6a-4bae-8b82-48d909bf12e3@siemens.com>
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
In-Reply-To: <a125733d-8b6a-4bae-8b82-48d909bf12e3@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3152:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e5f52e-e998-4ec1-4263-08dcbae9b9c1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm53NVJaUzlkeUplUHdjREdIeGtPYUlSMmg3Ukgrcm1nbEhLeVA3TmJobUVJ?=
 =?utf-8?B?Q3NaOXp2enhta3cvWUsySFRkR1Vib3RPRWNydFlickdkN0x1UFZKM0xLY2xO?=
 =?utf-8?B?eUpjZ1hxUXZRTGVhRWRsWkxHMU1la0tJeXNpazlOZnM4eWc3TU9mNXBhdjhD?=
 =?utf-8?B?bk4xOUJKS0JkaEgySzZ6TjFsbG9oaGdxV0FxMGEzVzdZUWJJOFMraUZHYlIz?=
 =?utf-8?B?Q0hoOHYramIzYXQ2THdBMlArb2syRitNL2t4eVl2a25SUGYwV0tJN1EyRTQ0?=
 =?utf-8?B?R25oQnc0eitFK0taV2VJcXltSWFBSjB0d2habkEvMERqU2pCTmo4VFdFYWxU?=
 =?utf-8?B?QkdYODBsTGtHSUhSN01yVDl1RTVCeVI1VENxVGFBV3ZITXVBK1F4ZXBoWXNL?=
 =?utf-8?B?ZTNCUmRlSzA4MzJOMllIMDJzTWovM20xTFZXUG1KUk4vMG96QW9iM2ZYRFZS?=
 =?utf-8?B?TzhGbEY5VS9Ramk2M2VJbW5GcHlVaXpzUHZ5N2thVFE2eE5oVlpKeCtGN2N5?=
 =?utf-8?B?bjNkNzlzcnZNOC9LTzlXKytVdlN6V3ZoNkV0NE81ZmxWUUVrWnlMZk5yOEtX?=
 =?utf-8?B?RHpuMHVWaVpRRDFFd1loWFF6QkVPNlE0UTBNOTFDRis0Y2FYM1h3QUpIeFgr?=
 =?utf-8?B?akhCcDBUZTdtako2RThOSWptMWZrYXorLzVCUTJpNHpuM1BQRlFCakY0U0p5?=
 =?utf-8?B?MFp0Z0JEMDBMV1c5MnJxak1WQnIwSVp1WjVIOEQ4OGY4b1BrR21DdElRVTg2?=
 =?utf-8?B?NmEzZEg0aTJhaHI2UDg0S3FFQXd1QUdCU3hzbHdvWDJWbDFURU5NaXBJaTNp?=
 =?utf-8?B?Vy9vaFpVbk5EU3JIQ0h0N2NkSllpNjlRTmtqZWk4ZVRNOGx0N3BmdVEvRzNn?=
 =?utf-8?B?cGJNZkVRVHNmaXZYSWl2amhIS2pnZXdJK0FYQmpsN0t4UHNpZHd0MFB0OEtr?=
 =?utf-8?B?dVRKVUdzN3o3bTduaWVXbC9lY2FYaldzNEtyUk9yR3Y3OGp3cFBEQ2dZODRT?=
 =?utf-8?B?amVlalQ0a2dENXdVMXk0NUFWbllQMXdYcHE5aWF1NVdnTG5kNWR1T2Nxd3Zh?=
 =?utf-8?B?clpCbDNNS3A1MmhoL0FTNGpzVVN3dTNiUkNCaUJHSjNSV1A2RjZ6QlJQWWpk?=
 =?utf-8?B?akMydnorbFNzYUE1NWlzdXBUaUNBeTZubllyNk1jZENKVjBtVkwxclVDMjFm?=
 =?utf-8?B?YnB4U1cwTTFvM3laUVNHZlEycWUyNXI5eDhRSHc1dEdrWnJzaWFXLzM1K2lD?=
 =?utf-8?B?WVlqTnVzaXZMSzM4WDYrd2VZdmRPMG4zRUpiVW1QRHp6ODZWUytReGZ4MnpP?=
 =?utf-8?B?OTdtRXRYcHl3SVBZdWlPWkh1Mnh3Y0NFcTNBY0xnWjEyMUVXTkxkVDFFM0Rv?=
 =?utf-8?B?b2h4VTFVSVpTRUZQNmFHRENnR1F6aCsrWmI4MEp2VVBDWEMxZzlYYzhwbHNi?=
 =?utf-8?B?YXJqQVVtNHpKY1U2U2xndDQvZzFCWU1jSXBUQnlza2tQM3dnZ1ZuWTBqYXh5?=
 =?utf-8?B?QnlEUm9DZWJ3QTViOTFxTzVQUmRHSW94LyswOEs0c3RoZERTNWx3RkVxd0RP?=
 =?utf-8?B?WDJScTV6c2NWVFhUWGlGUnRGU244S3V0NHl2bDQvZ29mcXlMZWNXQy9FTS9C?=
 =?utf-8?B?aGxudDVBdDN0Vk8zN3RpNVlFQ3RiajM3TnlidTJzOUtNaEViY1UxZ2NZM3BO?=
 =?utf-8?B?YzBRYmFtZTBYSytMRjZtRE5peTl6ODlnV05sdzJRRDZlT0Q4NmxrR2VzMHpw?=
 =?utf-8?Q?xYfOfPq0QSzdQ+mnUs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWlhRmZROWtMcnJoeG5WZE54NXU1dHY4TldRcDdTa0dHVjlvMjVzYWkyWTND?=
 =?utf-8?B?ajc0VGJydmduTVVyVzA3MlppbStjS2FEd2JGTmxoTjVOVjdLWHVjVHR1Q1d5?=
 =?utf-8?B?V3JPaWhpSUpZYUVmR0R5ZkIvR1p6S1RGYmZreTYwWGxjM28xQXU5MkVFSWVL?=
 =?utf-8?B?dmhlM2VycnQvd3VSZ0FXVDR0WlpnMDN5elBvM3l1NVEwcDBDU25kMlhkQTJ3?=
 =?utf-8?B?cWhBbDZnQTlBL0RPbHg2V3gwVU5sQ2hRT2J2Zmx4Zmt4WGNoTkhLejVTeG9R?=
 =?utf-8?B?YVRua0NhZEZWUEVLQUFtVmFHR08vb2FqKy9KMGVPRDhvbE8wTXdhTitwR0RT?=
 =?utf-8?B?a29OV0EvbE1IYlhVcXNYMDlVUzRmQjBNb29Ld3phMDlDbjBJdkdBTFE2THZK?=
 =?utf-8?B?QmNmdWRsY2p2c0FGUGlaR05QdHFKQnZydytXM0dEeTdkb2FpVWE4eFFNUSt3?=
 =?utf-8?B?S0tZNm5mNzNGQkE5UGZyRkt2TmFqUDhoUnlQMGRvM1VSMGNUY2oxemVoME9q?=
 =?utf-8?B?ZkhJOWNVU1NhNVZpOXNmVEN0RXBXWW5rSERpWEp0akFZLzBKZzdJQVUvVXNG?=
 =?utf-8?B?NmZTRS9DWSs2UStmdE5xYXhtL0g5akhtOFMrUGF6bHlFME1vdlNrK3FIYnRU?=
 =?utf-8?B?YjQ3RExIN2toZXBCVUlLRzlQckhqOENpVUJSdGhKMmxMbVRUcHE2U2ZBMnZG?=
 =?utf-8?B?MU1qY1FmeHhxVWRLUHJ2cDVRTzJNR2tQd2FkczdTUW1zSG9udVZxMENUNEtZ?=
 =?utf-8?B?Y0FpdEt5ZVgwdVFHWDFadUx2N241aHBOcWI3dFRVdU5QTUx5bXAva2JJMFB3?=
 =?utf-8?B?WnM0ZXBhdWV4YWdpanYva3R3MlFTRG41TnV0eVBya3EwajFpTitBU3M3MVZ5?=
 =?utf-8?B?VytoWFFqZkVvU0pONjl0OFlvS2llTXF6QkFlVHUySGFxUUVrUTI1T0Nuamhi?=
 =?utf-8?B?bUw4QWNVN01ERFp4U3FnZHBndXYwWnpHREthY1dUU3NQVTcrbFNzRFowVWRn?=
 =?utf-8?B?VnhGdWR3dXJZSnB4RHRNTFpwaFU5bm14c2dtNHh5cElQeEdheHJmem9HbWtz?=
 =?utf-8?B?aFgwSzlkMExNV0taejd3b25rekxBcC9Fc0laTmJaL0Z4YytMeS9PZlFQdkdP?=
 =?utf-8?B?M0xHY3JMRXpUc093WnJXbUZnNit1ckI3TFVOd2J5VXNUQU4yUnhnMGF0Qmoz?=
 =?utf-8?B?dkFNZEtnc2ZmR0xZSE5sK1pUSXdRZXZTcEJjOW5kVjUrellLQ2tTeW50aVNs?=
 =?utf-8?B?aTk1MUw4L0ozTmFjQzNDOExlWmEramN3dDZvb0VJNkpDZFVvRGxET0tnaHJI?=
 =?utf-8?B?cVBvMWplN1Y3YTFjVzZsYXNOVjZVZEQ2dlNKWU5DVlVncEpJa2Z6ZEV5UGVl?=
 =?utf-8?B?dFFMZS9aL2QvM1FGYkNlQ3ovdUVtTUEvZ01oaHJnalE5Q2dCS3Jucy9nalRW?=
 =?utf-8?B?ZWd0aDJ6WXkxOEE3RU84dHZvUnVzdmxKTHQ3RnVVNUZuUWxFVjJQMU9RRXJL?=
 =?utf-8?B?VE4zL0RaOHVxY0NhU3I1ZnV6K0lvdlJST2lsYXc5NHpBMkxqcU1RZUFlNXZT?=
 =?utf-8?B?ak1RTjdYMmhUdFkwdUllY3ltVUJ4b2xqSTlmYTh3MjJwcnd0cDJ2Y0pEVXhW?=
 =?utf-8?B?bUd6TVQvenlhS1NpeU5LWndFY1dNTlZ0S0NiaFVhNS9YZWwzQUlpeEJhSDdC?=
 =?utf-8?B?L0pSZUZyay9lcmNtN242NWFib3FqanplaVVYQllQSFhXZFE4b2dmamkxSURm?=
 =?utf-8?B?VlRDd0RIK2NBUTFkdlZPSU5aTUtFQ2Q2SDFTREJGOTZhWGFWRGtHcWtQL0V5?=
 =?utf-8?B?NGx5MG56WjV0dlJYOGxGaU9KdlJZS3A4R0Z6MU5ERWxjd1NIb1NjWFE0azBu?=
 =?utf-8?B?OW9qMnBKQ3E5a2dBY0ZxVkhKMWk4cjRmcTFaNXBDekR2U0t3QnFJMWdXSG5T?=
 =?utf-8?B?Y1luT043VjBWb2pWRDlLQnNNcU1EV0FMTGl0RVQrMFZHbi9HN2U1MCtPd1Ex?=
 =?utf-8?B?SXJGTjdKa2ErRWtXazBQV1pYWU9DUEtncWtqZHJEQjY3ZDE4K0FqU3hzSU5z?=
 =?utf-8?B?dWNlcUxNOTZBdnVlNWVpTCs0SGRzUUc4ZFFHWkFkRllpbzlDdFJvQ3VSdGM0?=
 =?utf-8?Q?kbnbi+HpLcd9y8Hw+IEDqWZ5y?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e5f52e-e998-4ec1-4263-08dcbae9b9c1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 16:13:38.7342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLz9IDxRChkTjSvRnMylHJKuYt539F0DtuDGFaEw0B9/HEoWY9rw5J5YDZQz9wSve25QG79kf7VRN+YC22E5YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3152

On 19.07.24 19:22, Jan Kiszka wrote:
> Hi all,
> 
> there has been a larger set of changes after rc1, so I decided to add an 
> rc2 on top.
> 
> https://source.denx.de/Xenomai/xenomai/-/archive/v3.3-rc2/xenomai-v3.3-rc2.tar.bz2
> https://gitlab.denx.de/Xenomai/xenomai/commits/v3.3-rc2
> 
> This primarily brings support for kernel up 6.10 and fixes / cleans up 
> printk, also by removing the rtdm_printk wrapper. Please continue to 
> test and report back!
> 

Brief update on the pending issues:

 - "NX-protected page" [1]:
   We seem to have a race during task shutdown, at least for alchemy.
   Reproducing works (not yet tried myself, though), should be
   understood before the release.

 - "Process stuck in cobalt_monitor_enter" [2]:
   Not yet reproducible in reference environments, may also be limted to
   I-pipe. Would not be a release-blocker at this stage (due to I-pipe
   relationship which is history in 3.3), but further investigations are
   ongoing.

 - Thread stuck in IDDP sendto() [3]:
   Partially understood that sendto makes no progress if receivers dies.
   All nothing new as it seems, but maybe the behaviour could also be
   optimized by returning an error instead. To be clarified if this is
   still a 3.3 topic.

 - "af_packet.c: 32-bit compat support" [4]:
   Waiting for v2. Would be nice to have for the release, but not a
   must-have.

In general, we still look good.

Jan

[1] https://lore.kernel.org/xenomai/770b1e4bc42cfa1ba5f4f37cc854956f3e78bb60.camel@siemens.com/T/#t
[2] https://lore.kernel.org/xenomai/46a1ceb0-0684-4bb8-bcd3-5f71456c2d10@siemens.com/T/#t
[3] https://lore.kernel.org/xenomai/CAFLxGvwm3qCk4e2d-Mf7bZGgcnfX8Eyd2yvEGpMf_tydw2H0-A@mail.gmail.com/T/#t
[4] https://lore.kernel.org/xenomai/517f6696-a485-4bc2-9db5-6f2b3daa3f32@siemens.com/T/#t

-- 
Siemens AG, Technology
Linux Expert Center

