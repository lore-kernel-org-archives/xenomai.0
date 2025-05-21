Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010069.outbound.protection.outlook.com [52.101.69.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF357DF58
	for <xenomai@lists.linux.dev>; Wed, 21 May 2025 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747845987; cv=fail; b=STHwLyMOjyuU1PIAKBwXm3zcrHvG8pQQPT0o5kHePmSq7i2kjCfFZkOT0G68PPMD0pcRQRxRoJ+CIcLk5Q4kHzn4EByHETeVnjuTlM7CkbQoojSTb+8lv31NGmna/AIdh00/fu95cJdIB6alr9dXDW5x9muDMS/aeWxqWhf5qQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747845987; c=relaxed/simple;
	bh=2uQQmT9ysgYSLS1/9jHxZlStyxdQ/oD8g+Ts1QH2NbU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gvESVHR11uVfzrIb2SVZ3rN7sJh9a+mecUVv7jGtIXiklr8GDrDKUFJHFzJFLn7LuFYxBWyzDnDP9BefR3+f38bqtS7O4TLC2tyVbRsJtvP+ksfclgefDKOp2RSPfzV7a6VHHqRP+wNnwxiLfyClH0/0v2Gq+HhE4sRsfv9I0L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xCnj5LtL; arc=fail smtp.client-ip=52.101.69.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xCnj5LtL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EN8GRj3JoLDwP54eNYcOpMp6WFgofe8lgg5yt0o98RFDsd+aCChhGnCSrORNSxL4YH0xkhhtnuIlyOAnTVRKX4HXGLKxmg8zS083UsveHLSHEjN7qkLw9sY+oibGLas3ZWqUY6kww+J6hw976EEVs/VDVeoOR/HUvuKKcJoQN+S1rJvIoRhPEuCmSuWlEHug2r2MJuDMxer5qoW1VKx+gzAWczxgwO7KV9Bfl/SAkZ9mcjKEBDsHJhaFGOLxCnkGyu9wTLD5LqxMJ9K7Fsk5QyZL2lEIrUtIT0ARYlulsvkkJ0aNy5dZ+EDj6KcgRWReOr7AG2OoIWEm75nGi+rVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LcwBLV0jek1eF0NB+7j+cA3mxMV2b7Cd9rTtYakzAI=;
 b=osONbl+E/uMKsdcAcHK224Yg7+uea55218tlHjWBGZ2vCVVUdgH9ORrMbA6AJgjSwzCTFR5s/4CAeLKqYY0nTOitXy+mLc0hhy9oyesmh/XgHq0sE2zka57iUGsMHv5ksMdhJhoQNpJ8n5arcUcf7CwW57adtUabFvoOLFj7wAnUMOf1QpJ/2++urcko3tcFaS/BLBsNHZ4D5vsU1gV7de70G3redPxj4GuS2vypdvJWrNPvAP48JXklmoJtpwcEOMje7nJdw9or6gNwuahYtO2JSxS+KcXd3KRG++Nr4u030NHuhSjer5es0smBdLRb43VHnkKELvfonKEGqjgNTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LcwBLV0jek1eF0NB+7j+cA3mxMV2b7Cd9rTtYakzAI=;
 b=xCnj5LtLpi9sbxEZYbx3RZjeG7HXMuulF/bc0NNJIojVZULrZl1wBP12nHETXSenCJiN2voJzc+94U489kRCAXdpLX5vT5zT36PT0dQN+8f6pug+0M7crBzZeI2FL/3Lbo1ZwSY6T1J++1SVszJMwIhuVVrc6n1tCLIZPODHtdGlanNzEuijRBWHHVk4uyGID6dDavIwQTc3KwDKavRpfd03ea/3mbb11Kvw5y/U32+ZzoCSMeaeVX9E5P41Dx5SpJ+VdA3Oo3cHofzbyDdOFs1otsc3yqjiQAmWCdwl7bMTAXAmmy1VrIKctIJVkJprseUDZLEtD4EapH4nRYC91w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4097.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 16:46:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 16:46:15 +0000
Message-ID: <8fde5f54-1807-4259-96d7-20d5c2be95cd@siemens.com>
Date: Wed, 21 May 2025 18:46:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Feedback on https://v3.xenomai.org/tips/porting-posix/
To: Haiyang He <aspirestro@163.com>, Jan Kiszka <jan.kiszka@web.de>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <a985855.ac8e.196f35cfd11.Coremail.aspirestro@163.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
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
In-Reply-To: <a985855.ac8e.196f35cfd11.Coremail.aspirestro@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0276.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: a1bd44eb-c420-4ed1-333a-08dd9887008f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVBJMkNxaHhkOFdoU040OExTYUxWSTJhZk9UcEw2S2pIdkdoL3dIMFpVbktE?=
 =?utf-8?B?bWI4ZzllcnN0N0dUWVBSSDAxZndsS3JJTkp1cWFta1BvcncxcHBLZmlRQUpE?=
 =?utf-8?B?VFVBNitDczBzVmREOTRjZTV4WVhvVzU1ZWRFVmlCT3pLYVRZMThQa3ZqUUhD?=
 =?utf-8?B?SnhPNFprQXA0YWZ6MmExbnlMdStzSUhwOFAvZ1NGTGI3eVI1QVZRREh3UFU2?=
 =?utf-8?B?UEV3T09kUUtFWk5Hd1Zkb3VOR0dMQXRYeDBnZDRwSXRZd3FjNkZWUG8zVVNh?=
 =?utf-8?B?Wm9URTVaYlN4NERZbVh5emIyZi9vZ0h0MFRjcmsraHp3ZjZXT3JuOHZYZHFk?=
 =?utf-8?B?REdQZFliOTk4NjN5WUdIdUIvYm1kL3FpdUdRVkZGYXlyRm1OWktFZzZzWG9X?=
 =?utf-8?B?cEJCVEJ3U1NieDdQNUtkRVZHbE5RQ2xidC9qZkZ6RXpOMEhZUkN6dGZZNytZ?=
 =?utf-8?B?K0cyWVVZQVhzaFdIMzNlbDJjcXMwU3BvdnNXdSsrU2IzVUwxUWdSQjBLUEVK?=
 =?utf-8?B?c0NueDQvVmNVTUpvbWs1WExURzYyN2FiZXk2UCtzTVNFQjhpV0ROdHl0Uzdr?=
 =?utf-8?B?allWbXBERjVJdzgrd3ZZaGtxV3JvbVlhcmwzK21UVTZWNTJWNklJNjhaUkZ4?=
 =?utf-8?B?NThrZmZ3Z2FHVkNIKzJTTjE5R1JIOUhXS1hEUDVTeUZ5cHFwTWRMQjdodEhj?=
 =?utf-8?B?V25wbklLc28wKzJlZHpCczU4dVI2ZFRzakVlVHp1c04wb2hlNTF1clhNWG9Q?=
 =?utf-8?B?MjYrb0Z6V0g5ck05enMxR20wZGFJUVZJNmZiRnJ0Rkg4UWd6TEg0ZEJNQWcz?=
 =?utf-8?B?QTJhOUN5SGlaeHJtVmtWQ1p6RDBWVEN0ekpXTTViNitxbjlHOFZRSXM3R2lS?=
 =?utf-8?B?dXlDK2tJNUJSeHArVjUzSWNac2l0QmM5VStkeXJOWUZmamlUaEd3WEQ0OGdh?=
 =?utf-8?B?RUZJUi9iVHlWU0NhMEdwR2lTL21md3JXUFVWM2xmRzk4clVITUQ5eXgrUENo?=
 =?utf-8?B?ZXMzb2NWQ3ZTNWtRY2ZVbmJ3T1AvZmNUa3FwOUppUnA0VTJ0SkhlTjBTTUFi?=
 =?utf-8?B?ZlByeDhGbnZNZjFaSVI2UTcvbGlkekVYZUNYWmR3U05uT3dkdGJLVis0Nit3?=
 =?utf-8?B?SHJ4NlI1aVRwSjlWZVdGYXdNK1JLUW5tdS9PUml2d2t4aDE4b0FrdCtkT0dK?=
 =?utf-8?B?Yzh5YXFyemVXMjhBNU03eVpEZTVSbkU3aW52blVzRlZYdFEzMXJuRE1hZm13?=
 =?utf-8?B?TEU0RmdJcEVxYWVkOFluWDU0QW1yYWVOQUhSWTQ3Mzk4eXUxMkNERzByNUZ2?=
 =?utf-8?B?L0Z1bjVuUFlVbzFvbnJnMjFnamhQd2liczRNVGNRV296eGl1MFc3NkVHWUR5?=
 =?utf-8?B?TUVwRVY2RCtZbFdrejVRb1ZFUXR5ck1leEt4K0RPa0Zrd1A1b1dKQmkxdlBy?=
 =?utf-8?B?SGJ2ZURWR3lYbEszbnpNRzFNUk1xTnZ6WDM2QTFjTk9aSzlCV1lqTC9BQUNW?=
 =?utf-8?B?M0RKQzE0bjgzZXNuYnNrVXhOckZOOVNUQUV3WUhHSkdHNDFrWnY0N1BOaS8x?=
 =?utf-8?B?SlRIS3Jpbnk3c1JmWHhSNkpINmh1UGU4VHU5Y2ZLTDVjcmErVk4zSm1iNCtO?=
 =?utf-8?B?cUcySG5RQ2kyREF3K0R3cDBNZ1habzY5UWJjdDRpN3FpZ0g2Z0U5WWhxSjZC?=
 =?utf-8?B?ekZZOU1DYlg4blF0NVVGUVhBVk1tUFpldHZwZlIxdWg4dVJkVWoveXVGWTNi?=
 =?utf-8?B?aEF5RlRHd0JJMUV4MDVldWNRZXAxb3IvbG8zN1pady83UUl2Z1hKb1RXMjYx?=
 =?utf-8?Q?fOKT5RqMi/t94mJjmigtf5t2b4Kgei95lJU8c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlNmR2JKeWVFcEJtSSs3OUlqZWZyQUs2dU1Wa2dGOGozakV5WThvVytMSlV3?=
 =?utf-8?B?OE5ZV1NSeVArVytIdzRxRHJoaGI2ZWNHblRmcnlEdko1UEdLOEdVVStJcHRl?=
 =?utf-8?B?MnBONENJUEZXYXJDMi9RRWJlcGlJWE9XeXJucHR5Tjd2MmcrQThQbHZzRWhv?=
 =?utf-8?B?UEh3N3NPS09Ra1U1WldNbExLNjU2ZEcvT2tUS2lHYnJJeUxoVWsrY3ptelI0?=
 =?utf-8?B?eFV4Kzk3WnBGWFhuRW83Q1FSZ1BnanY1WHBMVGdKVnFOTmhvZ3JScENyT3dn?=
 =?utf-8?B?UnFEREx1RHZlTldxdXUra05QNUpMNlRSRDI1dXltK0xFd21ndm5uTlYyNHFY?=
 =?utf-8?B?R0pQcDMwckEzSzFUb1pHNVQ3MytlVG9NNFZHeGhoQk14RVZYNW4xZ0I0Njdl?=
 =?utf-8?B?ZUg3a09SS3hYc3g3QXZBNWc1dGtxcVBYVmxvWkRia3hGanltWjlqRGxkT29O?=
 =?utf-8?B?MmMxanRCcllyVzNZMzRNN1JFTmhES0NWYlVZdC92TjhJTms2TWNoTlRGOWU2?=
 =?utf-8?B?NUIvc1QzbHBBcFNiYmtRSDh2aHRTTm1uMzBWMXhNVWQ2T2hxdzhyS2ZncnNo?=
 =?utf-8?B?VGRuMEViK3g3OEFTRDFzTFVDRURCcDE2RnZCbU0wYWhVT0xOU3VsbzZnd0cz?=
 =?utf-8?B?aEtiVXlTaHFaT1l3dUxacG12eDd2U29ackJRcUpEdHVkejZOV2UyTmhjQzlt?=
 =?utf-8?B?Q1FuRmpGZEp1N1NXdUF1Y21mMmREZnFlMDFCSHpxNTkzV3htNXI0TytRd25C?=
 =?utf-8?B?eFViR1lZbGZ0VTc4SjViYWJPcERSWmo0Mmc1RGdsVG9Ta05WQ0Jnb3VPaUYw?=
 =?utf-8?B?aE81M0ZYbmxGRkJIbnFSS0d5MDlkbkpuVHp0ODl6OEVKNlUwQ0VITjNTLzhl?=
 =?utf-8?B?dGRpcFNwNlR1VlI1ZDRoZkZ2RllJOCtqcVpTdDcxakI1dmkvektlMVlnTXBN?=
 =?utf-8?B?ak5nVHRndEE0NnA3YzBLWEYvRkttUHVhcVNaNG85MzNvaEh5U2tiSFB4QVV6?=
 =?utf-8?B?Q09YRTlNYVB5OGYvMXlTL0JDMkljbUtCMy9SUWNidzZSWWhNSGtyaVJYSGpk?=
 =?utf-8?B?OHdpcTQ4cVFTQVU1TWo5R3h0bU4xcXNnYTg1M3QrWHVyZ1YrRWJFbkFtR3Bm?=
 =?utf-8?B?WHFxN2Z5RTFERm9pRGNLaTZmSW9XSDlQS2RZVm81bS9aY3ZoMlR4WXR1MGNP?=
 =?utf-8?B?MkxtcUdoWnN0amVqOEpTSjFRVzkzSzlMYXRaeFg1UzJLZDNuMHlSS1pIVmE0?=
 =?utf-8?B?dlVsVzZrZ0R4YVJnQ1lNZ1JwSDZBRU5RUENHTGZVSWM0RThXazRuL3FZWVov?=
 =?utf-8?B?bGpPT1RCZWF2VEtnLzdUZnhwT2hBcW5aWTVLNTRlbEZ0dW4vR2hJY1U5WHlY?=
 =?utf-8?B?YXRIb3Y4WGQwZCszZmVDc2x1c0hXaDhiN1JwMVNyNDdEc3JDdzc0V1gyVGNV?=
 =?utf-8?B?bWdyYUZvYUVselRpU0hLaVFvZEI0OGFMbEEzb1R5dEhraVpnUWJ1WUNXMGF0?=
 =?utf-8?B?M21aZE5NazZyb1lHazBFN2hxSkNvcHJXVUtpamt4dXFXL2txZTdFb2Vpdy92?=
 =?utf-8?B?bENpaUxrd1BSVW9zVEt2UHpFTU5mZ2JhVDl5c2cvb3BwaWhZNjY1TjZWT0ps?=
 =?utf-8?B?N3lNRkV2TDhGNXRhSzFOYWVyWlFoY0U0V3N1Y1pvMm9XRDcyclh2Qld4dktE?=
 =?utf-8?B?cHFtMS9ZNHJZWWtOby9mcHFhMldhZTdvTi91dVF6YmJtZWF6Tmk2ZWg3bG1W?=
 =?utf-8?B?WWdDZVVFaUJaeGlyZkwxYmZLc3N0M21XTDI0empEcytsK1Z1STgzNmE3aWk4?=
 =?utf-8?B?V3dLb1cxZElPWkViU3F6UmZrV3lOdHJSc01JeU9peGp5ajVQdVNvaXN6UXBT?=
 =?utf-8?B?enFlaDlKbGxib1VwTXJOamVhaXJqWUJVaktIVFZ0RXB2VFBYalZRUmk0eFQv?=
 =?utf-8?B?NXptaVdWNGtRL2p6N0dCRUNTWHh2SmpSTHh6aXYxMU1mTFpPZGxhMDY1R2l6?=
 =?utf-8?B?WWZBbW9yMnRaVXpGbSs3Q1RHdU1tSm8rQXBHbW9xbWtrWkVQUTVmelBreGIx?=
 =?utf-8?B?TmgyU2QwVzFqY0Uzc2ZKbXVXZ3k5T2UxeGpkYU1HTU5nWGVSM0dCcHJGcEJ5?=
 =?utf-8?Q?UYqwtpcL/ayjIypFKvU6u4pqj?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bd44eb-c420-4ed1-333a-08dd9887008f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 16:46:15.6392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SI3ujblBwPYBLYL2MEBX8axjAAiTG57ohiMmKSoQ2sZklFKTH2gKDXSVM3XPh98KuElGBcObUPrAD8NUDGPwqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4097

On 21.05.25 17:01, Haiyang He wrote:
> 
> Dear Xenomai Project Team,
> 
> I recently visited tips/porting-posix page and was reading through the content.
> 
> Some content on the webpage may not be consistent with the Xenomai source codes.
> 
> 1. "For more information try wrap-link.sh –help."
> 
> wrap-link.sh does not support "-help" arg,and report:
> 
> wrap-link.sh: 212: -help: not found
> 

Ouch - but that should be simple to add, given that we already have this
when you don't specify any arguments.

> 2. "Xenomai compilation flags define a preprocessor macro (__XENO__) which allows you to know whether or not you are compiling the application for Xenomai."
> 
> The output of "xeno-config --cflags --skin=posix" does not contain macro (__XENO__).
> 
> $ DESTDIR=`pwd` usr/xenomai/bin/xeno-config --cflags --skin=posix
> -I/root/xenomai/xenomai-v3.2.4-install/usr/xenomai/include/cobalt -I/root/xenomai/xenomai-v3.2.4-install/usr/xenomai/include -march=armv8-a -D_GNU_SOURCE -D_REENTRANT -fasynchronous-unwind-tables -D__COBALT__ -D__COBALT_WRAP__
> 

bd0a6612d3d47aae3d53a52857b138d557735807 -> we should update that
description accordingly. After 15 years.

> 3. "To get your application threads to be really considered as real-time threads by Xenomai scheduler, you will have to get them to use the real-time scheduling policy (called SCHED_FIFO). "
> 
> I check the cobalt_sched_policy_param() function, sched_class is xnsched_class_rt for both SCHED_FIFO and SCHED_RR.
> 

Right, there are even more: SCHED_TP, SCHED_QUOTA, SCHED_SPORADIC,
SCHED_WEAK. It seems those classes are only documented in Kconfig right
now...

Happy to take patches, for the low-hanging fruits (first two), but only
for that latter one where we first need to find a good spot to drop the
information.

And many thanks again for finding and reporting these inconsistencies!

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
