Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013015.outbound.protection.outlook.com [52.101.72.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673936F91B
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524733; cv=fail; b=lj+QAQ/gNcrzE/QsS/S7f695Bv/krdM3bhYZ1zPB937tRjuPBAiSDrRo5BsjwbYW1chvZnmQElQ3H1mZQjPsjfbP/L+HCsuVtkXfO5f18oV5EeCRJn/B4mUJie0qrVmiodS2VavOH1WUHQdxdRqbF7FJjiUh1b/Qe2enRABvloE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524733; c=relaxed/simple;
	bh=aZmC//YZ6N15j97RqItxnlyFnK+PgQa6V8VnnwdzLkg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IhgI7oFRlM0JjYns382Up58L7qgv/F+QAvIP0NY5E2XIxS80duSmy2e4lkJW2jzJT/Vbck0fi9kk3BAQZeXWMfASZ+Na6+8azN8J6s8lAehd1dwslhfqbx374StC/09FAoeA6YH+3t0k+pRflApm2ZHT6fOhULSr/342rU1AgAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ME1ceSyJ; arc=fail smtp.client-ip=52.101.72.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ME1ceSyJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eu4pjPB2jFZMTATDLP9QsmktHyO/Ultz9Yjr7s2E1C5ZTgsHkBYiib18c84Ahzsa5EAu8S5oS60P3Vq5R05N5kxvj1rzerDb8JO4SnLlIamuVUIu1rDHvXqp4Ou6Gevv//VDJ93M5yLXTIi7CF3weY5uM6LWbSag2yN+Vu5EVYG/S2VSuNOsQ/jcYqWGDaAMKYU1URCOsXC54WJ0gCPZbnlv2WQfJiCWqoZaaKUsu2lQpbhbrYDRMY3VF9A3XizG5b20K44fW+D4qa665HWgsSjs9KRtNzVg35B9yBYQjg2joHHbWdf1bI0E0+nuZDJljXnO3rwLUPT91xHmQl3w3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7cLkT6lucV4x2fJ+8tK249vOualzk8Pf1lOAINzx/M=;
 b=P2jrIh9CcDF2gBEULWSYtWQPV5sq1e3CweQ7IB4MtCE05JgpWvMUoszqvaoU91zFmR7GsDTo5lIToCbk+GQoD34pKLVrHzJn/MJsJxIQT9zxno4fyE2DvelnkCvi5qIP/gqupFEJ6pRIYKh4LcClGs/d+OHXT5Sy6TIr3PpzHc+BBZxP4vmNnvtuc6Ac3v8sCg6rTO4qcFnSktrEiiwSXBbeaoh+p+a3VE7eXj7VqaH6jSqga/tw6YJuA2yTaSzI/ZOppLI8NVa1zgnQZ2s9SRTIq0RwLld6nYBtXYdJjrAYYfsAtb97sskTBlWmiuk8UPAH50RWR7Jy7Q0w+8KCzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7cLkT6lucV4x2fJ+8tK249vOualzk8Pf1lOAINzx/M=;
 b=ME1ceSyJSXYTLIA2KCuL855pv1s+Td61/Ono0ZgijyKcEuFkwxtl6GzCXEK2inEC4oB0dVNcfe943XcoIEf35uW0RAKO3QSeIgaT5oZ2VHpIyqClv5xXPb4UPvak8TgyRjJ2UZh20WzGT803ugSkNs1x5isnHG1c8SXwjiYYGPOoSg98v6FLtBWaIn1oj8dO1UFeeaxkPngAQWVkRi4oGQ5i04RyL06vUC8o5lvUAm9T9D3mdYYPzv0XEV+IvpyDek8+YYVPX6K0TI6l9Jrn2XTpabp0G3wLm6ArOuoM8Z25VAneF7bR8oTLNN4XNUaY26WaE8UE/flWwal6Og8QUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5420.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 15:32:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 15:32:08 +0000
Message-ID: <bd695b7d-fb94-4f2a-8ed2-d02d87ac9217@siemens.com>
Date: Wed, 8 Jul 2026 17:32:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-evl 0/2] Add RISC-V support to EVL
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20251010101130.3758633-1-tobias.schaffner@siemens.com>
 <837969b0d849fb716bc712df566bde246c5ffc41.camel@siemens.com>
 <40c1b8c7-ffb9-4f13-801f-cdcaeeda5ce2@siemens.com>
 <e27b6011-a7f8-4be2-995c-2515f74e87b9@siemens.com>
 <4906b6de-86bf-4c44-8f7a-4486aebf3c58@siemens.com>
 <bd2c18af-c93e-43fb-81ef-14cdd31a8bba@siemens.com>
 <87zf01lv1z.fsf@xenomai.org>
 <a72d61e20ebd3c5279b1f80f2a7d5225eb8fdb08.camel@siemens.com>
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
In-Reply-To: <a72d61e20ebd3c5279b1f80f2a7d5225eb8fdb08.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5420:EE_
X-MS-Office365-Filtering-Correlation-Id: 02cc0522-8855-4791-8fa3-08dedd061285
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|55112099003|22082099003|18002099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	h+yegHr0eI58K8CQKF2zjoIhLqLwkk5opkNi8Oam3ixjOtMH4aJRQhO2gGZ8ZdRDByAYyMHCTdPgtb9AOZmOWpbCVG2bAZytgC+fQd1H0WEIbdXaz64hHI/Fqh8Zg7v6KlFe7EuyyB4czkh0m8aA+enPOAMGMmjVFo/99DD3ba69R+x8v5xDcltt5oTyEmz19DdRUTxzaceOOr8fY8o9u7P67MtELU9JIQEsCpk9PqL0xqO+63Y+4wfrikSoO6jmeYOrY3hx42zVLjcV5GHGZ8tGyUXuwjb6i7xuHIlEpeTuZqHruMtKJF+p67Fjict44RklcbKXil/OQ0DCV+AIVty6s3Se8I8DlVsLNKNz6vnItkSfOwsk09pcB1xsbx2jSw4l/ZRkloRGF4LZzeUH5vSArDjMghSEDj0/BZWG4wuVlT9i4HVQRBVkm6rCm+PKkk2saL6BckTyIQcYProaXng2C2avE5ijks21qAs9MwDu+LQ+kLrZ1mryybtBOUHVRX8mSeKvJ3NQVvKArOT2oXT629yObd40FGhU+1SIYMmcqv1jWRVBlxVrRrcy/yAEQKwKiVcjgEULmyMrneVP8wiUMrfsY+ZWxyKsAbdUo+gckyi8QgBqdWpchCw/aLfY1MKuIi32YsW60nfB/2v2bRHaqIX2ZgGWFdDcLsivzyQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(55112099003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enZNTllmc3JjbEF3Q2pyQ0o5ZTdzRkxpU2ppMjU1RjJZT0t3ZEhvdmFXYmNp?=
 =?utf-8?B?Mm5vMHN4QzFPRldNMXhkeFh1b1l6cWdIUVg4R01FVG9TZjNrWW13WlhrdHRZ?=
 =?utf-8?B?TDNTcDRlU1JRUTYveXl1NHhpY1dTWW9UY3ZydEpEeXU4clNBZm93QVZUTzFP?=
 =?utf-8?B?b1o5djVtTVQ3MWJpQ0owZUFodXZTZ3ZGR29JSTVvT205cklNb2xjTEg2ak1o?=
 =?utf-8?B?T25BNzZvTXI3TnBURlhxVzk3TVdVWEdobHpuY3RBSTZ5bCtPQnVOZzZwTHcy?=
 =?utf-8?B?ZGJzRGdpUk9aalpmQjVHSElvUFhXM2NiQk13cEJ0YWQzMEkvclRYYldFcFhD?=
 =?utf-8?B?S0c0d3pxd24xaXNxeTdYMVFNRyt2UFM0SmNrMHJ0VXNEMTVFcENGam9PUXMw?=
 =?utf-8?B?TGlOSGk0Y3I3MTRQbTAzekd4WnFoQzR4eWhlRCtZZFI1UjMzVVBsb2duY3JR?=
 =?utf-8?B?NUFOZFpZV3lWVk9uTUsvNVZ1Z29NWDFobEplWmw1SzBtY0FDUEJERkx3WnNS?=
 =?utf-8?B?cXdSODgyVjBpZ3NmYit1eGlQZXV4TjFRWXcwNDZOZ0tBNHArMFM4VlpyYVVX?=
 =?utf-8?B?amhiUExiUE41UHFYUTlsVFBKVjFMb1E5K2VxVStXc0lFSWs0Sjc1T0JJL3U3?=
 =?utf-8?B?ZHRnT1plWm54TEVEc1pUeHJ6azRUWTkzNEN4RFRMaE9RM3Z1Wk9KNE00aEFl?=
 =?utf-8?B?Ukt2a1AvQnN6Z1RpUWZUVnBURHpudDZvTHVsK1VJeWZqU1FHZGhDUXN5V3BF?=
 =?utf-8?B?OWdlMEF1alMvTzdyRnFKRXFEaHo5N0VQSEgxZ2VHT2xmWjNNN2NLaFE1a0h2?=
 =?utf-8?B?enQ2ZWQzM1NPYjJlcjI2aSs2eGtFSHpsbHg2alhXd3dlVTh1VUplUVQrVWlw?=
 =?utf-8?B?c3hEeEh2SklQN01XUTkwRllZeUxSYXJBb1oyRnJudTk5bi9rS2hQR2RGTnEv?=
 =?utf-8?B?ZEFwL1RzN1dyTkk3eDYwMnBUbDBNb2NFejJzYWI2OTNTSGZhbmpMZTlMWGRo?=
 =?utf-8?B?aXVUSWxXeVNQbVRad3NES0dPZ1BoOVFML1oyUFM3blFmb0h3RDAzNkErNmZ1?=
 =?utf-8?B?eGlzMWpESWdOVXdPVlR2bDJsYi85RkxjalpwdmdwYm85VzArWmhEMlMwa1hw?=
 =?utf-8?B?UkFVTFROVHh0Ti9LVjcrUm9TYmpVNzVoR21jS0w2SE0vRXo5V0lVcHAxeXc4?=
 =?utf-8?B?M1JncXBzQk1ta3pKQSsxQlMzK3h4b3o4VG5CQU5xUUFWMWx3VllvQk9iRkpP?=
 =?utf-8?B?LzhmRjJqeGxjT2hRN2hwR2RRdUtxVzE0UDQzdld4VW1NZG96aGphVmdNUlM4?=
 =?utf-8?B?cHhBdWNsSzY1ZDlMMkdNMks1WVlLdVJVclBSOWNqS3NTMUcvZU5KcEh6bFpN?=
 =?utf-8?B?Y1NkYmFOTVBuMFlkREtpWHNEY2c0LzV1akhsc09GOFlaQnFYc2kzUGpDNXBQ?=
 =?utf-8?B?dTlDR1J5TFFwY1JKSnlYbFZ6Vmk1QWt3QjZKd1NiMncwSklCYjZnS25PcXMv?=
 =?utf-8?B?QzdZMG1HaFNoeVFvbHZWM25hcnNVY0VKVm92NkU5RXVCVVR2V0M4TkZmNHJ0?=
 =?utf-8?B?MTk4QUxxUUNHejVqUnJCWWJpeWNHMW96QzdheEJTam9WTzJQOEp0SDJWcC9V?=
 =?utf-8?B?SktEVnRKOW1VZ29FdVQ5R21YSjFWUmhKdXJyMWUvMXJSQVh4RWpiQ3kzc3Iw?=
 =?utf-8?B?ZmtNUFZENERRWTg3ek9mdFZ5KzIzUytaZkxQUGZjc25qckpqVlgrNmpqVURq?=
 =?utf-8?B?TGJocTBoeERJWC9sOGlBYzZBdFVBa2RnMG1vWmJGV0lVSFluM2lXZnNXZVdi?=
 =?utf-8?B?UlV4ZGpDSVdRTlVNdmkrQm95c1hBMCtxOHgvcy9oQVREVUplWFo1YWtSbm9x?=
 =?utf-8?B?REJRUmxIM1NzRm9tSk1yWnUyWUY0WjJSQUtiQ05IM2pYcnhiQ1h2SVNUR3Bu?=
 =?utf-8?B?ZFgzNjZYdDBVWHlrVmM0TGtsdHpBNU9lcko1Qmxwc1dwS1dCa2MzUS84d3dT?=
 =?utf-8?B?Ti9BWWk5bTcrczlJR0t0bUthUnFnK2Fpdk9DTW5jWmRPZnB1emx1bGxoMzVu?=
 =?utf-8?B?MWlZYkJYRWxlSUNkMFJtQ2tneHJPZm9YdWlaYXFpWG5NTExHREZTYmJ3UDRB?=
 =?utf-8?B?NEYxVWxjTHo5bExST01pbWdLcFVJUUcvK0doajJ0RHVjZ0pzVE94TlU3emRY?=
 =?utf-8?B?RkRhZCt4anI5bmZPMUVmVEU4ME9xSllWSHc0TnU2eTd1S1JOL1FaMEJnK0or?=
 =?utf-8?B?Q2EzWmc1Q1MraDVjRVllS2VQOWRKQlUrV0RmeCtrWFdOUFo5ajdqTFYyZmpC?=
 =?utf-8?B?d0JldVRsbkZWK29OWVd6QjZSaHFFUzJRajAvOGU4WUJEMm5wQ2F5Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cc0522-8855-4791-8fa3-08dedd061285
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 15:32:08.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hvil6E5zNC6D3/PlWcsCl+Jqksk7VOSRMO//BMPbVqtI4SgBJTg1nIKLgWB1Z6oU4zX0FyIpI44r+YbNen53fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5420

On 08.07.26 11:51, Florian Bezdeka wrote:
> On Wed, 2026-07-08 at 10:55 +0200, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> On 08.07.26 08:26, Tobias Schaffner wrote:
>>>>
>>>>
>>>> On 7/8/26 08:07, Jan Kiszka wrote:
>>>>> On 08.07.26 07:17, Tobias Schaffner wrote:
>>>>>> On 7/8/26 00:30, Florian Bezdeka wrote:
>>>>>>> On Fri, 2025-10-10 at 12:10 +0200, Tobias Schaffner wrote:
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> this series introduces an initial EVL port for RISC-V.
>>>>>>>>
>>>>>>>> While some tests are still failing, I’d like to share this early
>>>>>>>> version with the community to gather feedback, reviews, and hopefully
>>>>>>>> some assistance in refining the port.
>>>>>>>>
>>>>>>>> The patches have been tested in combination with the Dovetail RISC-V
>>>>>>>> port on top of v6.12-evl1-rebase.
>>>>>>>>
>>>>>>>> Looking forward to your feedback and suggestions.
>>>>>>>>
>>>>>>>
>>>>>>> I tried to apply this series today, and run into the following issues
>>>>>>> reported by my tooling.
>>>>>>>
>>>>>>> Patch 1 is fine, patch 2 has some checkpatch findings.
>>>>>>>
>>>>>>> A couple of debatable warnings like:
>>>>>>>
>>>>>>> WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
>>>>>>> #58: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:2:
>>>>>>> + * SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>>>>>>>
>>>>>>> WARNING: unnecessary whitespace before a quoted newline
>>>>>>> #95: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:34:
>>>>>>> +
>>>>>>>
>>>>>>> In addition to a serious one:
>>>>>>>
>>>>>>> ERROR: Missing Signed-off-by: line by nominal patch author 'shannmu
>>>>>>> <shanmu1901@gmail.com>'
>>>>>>
>>>>>> I did not get any responses from this email anymore. I can try to reach
>>>>>> out to him one last time, but what do we do about it if he will not
>>>>>> reply?
>>>>>>
>>>>>
>>>>> If I read that patch correctly, it's majority is taken from the
>>>>> corresponding Xenomai 3 logic. How much is unique contribution, how much
>>>>> was your work, Tobias?
>>>>
>>>> I added the evl_set_fpregs/evl_check_fpregs content which is a
>>>> translation from what Gilles Chanteperdrix
>>>> <gilles.chanteperdrix@xenomai.org> did for the x86 and arm architectures
>>>> with some isa enablement bits added.
>>>>
>>>> This should be the initial version by shanmu where I added this on top:
>>>> https://github.com/shannmu/linux/blob/xenomai4/wip/dovetail-riscv/
>>>> evl_port/arch/riscv/include/asm/evl/fptest.h
>>>>
>>>
>>> At least for this patch, I think it would be fair to claim authorship
>>> for the final one and only refer to shanmu as provider of a baseline.
>>>
>>
>> Agreed.  This is a trivial adaptation of the pre-existing
>> arch/arm*/include/asm/evl/fptest.h, which is in and of itself
>> boilerplate code.
>>
> 
> We had a short chat about this topic in the Xenomai community call
> today. To avoid further delay of the dovetail 7.1 release we decided
> that we will move out the risc-v series again.
> 

As you already removed wip/flo/v7.1-evl-rebase+riscv (which broke
xenomai-images CI, unfortunately), where will be the new transitional
branch in the meantime?

Jan

> Tobias will use the time to clarify a couple of those co-author and
> signed-off topics. Each series (dovetail, evl, libevl) seems to have
> those issues.
> 
> We will have to wait for a reply for some time, but we hope to address
> those issues within the 7.2 cycle.
> 
> Evl and Dovetail v7.1-rebase branches should be up to date now.
> 
> Florian

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
