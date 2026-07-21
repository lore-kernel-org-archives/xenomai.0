Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013035.outbound.protection.outlook.com [40.107.162.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D1C37B3FE
	for <xenomai@lists.linux.dev>; Tue, 21 Jul 2026 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630253; cv=fail; b=gndlx2zsKYX9JpESjgLQxajNzg9lnWyQ+ceP1bvD5RlDY+aMTV3Twty/UupGpn68E4/WReh6/leJq7KDONXmvteQAceGQ9l5ic9qbf2OHP0ylpVQ9Rq7AQpel6oNqK3f9CQHBWwOCYnLo5LkeEzlkPiemL0koc2YEI59j+ZWBSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630253; c=relaxed/simple;
	bh=caO3bl6oYPQ3GcUDrT8tVGmLXpy8a+0Y8LpqvikIgBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h62YxY7ziCSWKstGyao7i0ZfFWwVjGTjg0ehvf5AAHqIcT1/WQoaHP2mu6/ApH4JCww3sDWlykM57um2nSjD1oQ7xKaOKns3EGhKr7P+aV0MX095PJdEV9a7jIK8nz/xNFrVqjTglbk6P85RrDw7HAY51cVvviCxo5P3faBBcC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NN1vOJaC; arc=fail smtp.client-ip=40.107.162.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NN1vOJaC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFKeOeyYoYKG93tUxQU1p+GXRoQN+cho7hMzwkjtQGf5Bf51yDrJlt4Gndb8tacsL+taEsCWNMLXgdG6ZH9SRxF7mXbFRAZWDkhjPMPt8mt8h1239hmJUayxAdHd5u8z9ZRL5sPl/k0c2YiZaxkPGTBiZpMwR5egF4Z8bJ8UZbSAiEym57+6xwlWJ60UAjstZH4LnDdK4jN6iMFke+shx5gITwT7uObalaKwqcbtHiwuNkqahY3w0/6Hs90mlm50OrvBWGVibqdtfJVZfM2I8Tf3VcRyiTp/HiM3xE8W0UBuoz2FIJMpR1AxJPe/c1SoFyDdmAz6ohnHSkpcqa4sDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrvXQKr2IrHc+r9wL8bXcp9jRcfipIm8VBhTojotl2o=;
 b=NWS8lej36HUtmRYUXK72Hh1gaMpH/DJZ3dIJCY4TZm7ce00Q2kpBcNuP3NkssdwT1LdUigx4mALoLiBVNh0TVfblSR9TVwGEae5+YrqMYIs4rKWipcp+ya0/woEX3lBDDTZKzL3HHRD8nguiGss3al3quF4VaLTPk9QQ50upHB19jnyUogAbiDfzpfL5+glTFidNK9x8h80g6K3wYp0wt8aAZPwGsPYlBK6YYyoQg1Ow6/u2ZmmwSI8BohNyhbzIg8VqA6dXV8kLgvdanpHhDVEURYwoxHtt0oU2/+tkQqmfR5F28GThSvTEh98uQJUruqK/om6FdnHqzV1qmygONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrvXQKr2IrHc+r9wL8bXcp9jRcfipIm8VBhTojotl2o=;
 b=NN1vOJaCZAjkz/Q/9jpx0LCLwFftgTt2yE2RtYEhtXpObcAdddZvg5MSTDOlQDnUb1P1YjbmMqW86AN2oK8r619xlNd2wjQwZG3C19PXA7P86HouwDVa/YASC2jIkQdekUqh2XGnDovrPlPnQldMiUmawhmOhA7+GOOxhBhBuiPm79Pn+2md7acSP0EZHmwwdq55SoA4Zeg3JaszNl7MvfYhb/ZxvVKVRnimEdGPaa/gsW7ddgPHbR5hP/sRGXWqRuOH6axD7wZIKUtoGCRsM+aF//21DwATh0bA46xYHrKxL6mDQsFG//bnunmYEJdcK7YBJyvppmQ8qGw8Zcd+Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3326.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:139::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 10:37:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 10:37:27 +0000
Message-ID: <ab53bde9-f1eb-4a03-b545-78501a25cd1b@siemens.com>
Date: Tue, 21 Jul 2026 12:37:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] libevl: Add debian package config
To: Hannes Diethelm <hannes.diethelm@gmail.com>, xenomai@lists.linux.dev,
 rpm@xenomai.org
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <20260717205820.8359-1-hannes.diethelm@gmail.com>
 <60f4470e-cdb7-40a7-a73a-9bb6d4a10ebd@siemens.com>
 <2d7c3324-28f6-444e-a8a0-a028368804b6@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <2d7c3324-28f6-444e-a8a0-a028368804b6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0366.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3326:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f83b73-f51f-4fef-3673-08dee7140f49
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|55112099003|18002099003|56012099006|11063799006|4143699003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	GNELKenF6St8dFToUSDKDuhIT2J8QOF28BY/vOrz1P/u88LUeUexWf26TxyihK6GddFGQjEBAvwXtDRk1rLMj4PDuXV0xjV0rhYhV9pNwXaQI3jKmHCLsoMBbJNzefusJFjQEKGtOS9E0P5Rzmb2QRZuQyvOFsedy/KZp9HpWjlrmrq0b4Ym+tIVt46a4vvn89gRIGkOD1045kOwuKx3hHHFihJRaLRwgdWM4W+e84WOT0t6qeHJ/GbxrZj2iRVfw6tGj4dYmIOkVy5o3cEwvbd09yhsI3G3Fk6HAycV2UPJVZxupPsWJcHxOOOYxUiKbERbRANUlzVLdBauOboXNqodzIvoq+3QX1LzWpgUv8hjVKc35P4Pp8cf5m+GQz+kq4FxgND/eDJCfTIvboiXXR9GUptcdNssOREkpJqdOJEPw/nvShJcPmyBUQysnNdBZ/K3RhymhgZgFz8mqLJi+DzyZqLzvfUOawJVmxFdxA/GvITGFoXopbrABIJKwfb3XKoU5AiyteM5hP6Iyns7F1Hs9GBxSxCNfxuezZgpzEuaZR5G0CV2jqrPUyyajYrS4Uaz5ipQLln9OwdJqO/whqeLtQVVYFmR3GQX9wkWzKNQ4M47iz4wWqqym7FAWm2kmDxexDnEQ4R6HdueG/G8d6ZF0Vl9uZJGoswWRRHH4yY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(55112099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzJJWnhNaUlVZFl4RThvaTliWGkwcThONzRFb0puZjlFaDZXQVJiQ2gxUUV1?=
 =?utf-8?B?UmJVbFdDTWRTU2VNN082ZE53Q2dJczJqYk8wa3BkU2haRXh6MnlqUllxdEZn?=
 =?utf-8?B?OVVlT081aHJxUzFwL0wzUUtUS3ROT2J4VFkwUmwvR3dTdmNXZTJrY2gzVW9B?=
 =?utf-8?B?OVR3OXhtcVpJSnhwbThOSFhwRFk4OEdGTTZ1dkljRmdZckVKejhuWTM3bkhi?=
 =?utf-8?B?bEFlbXhpUHE4aFVyT1RmL056dHNlMXBiM0xRQnJCcERvR0Y4R1FlUHJqaFds?=
 =?utf-8?B?LzFlS3JYL1RuL0dzRnQzODAwM1kvZUk5WThnSEFPa2N5bUdnMTFoUVhraGF3?=
 =?utf-8?B?Mnp4dFU3UFY5RnVDVkJQak5PVUtzQW4vZ1I0QnNxb0tIODRuN1l2ZFVYb2Q4?=
 =?utf-8?B?eklGVFZEWmJPcnFSSitsajJ4VzB5ekNWakV4aHdObXhkRllNcEphZVp4OG1x?=
 =?utf-8?B?bEwxdk40MngrY3JVeDVtWHJocEVBYVZhZCtoQmJPRVRBbU1QbDdMNGJZQVBK?=
 =?utf-8?B?Z0VvMzRLcmxoM0xXbkdiQlFLVkNodFRhV2VJVTUzU29PYVM2T0FRQjRFRStP?=
 =?utf-8?B?TXd1STFkZi9qd3F5SXF2RFB2ZDNsR3ZWejVLZmFMbUZyVFpCNWJpblpvSUt2?=
 =?utf-8?B?eWNWYjhwdWJmbjB2VE5sMmh5RGxiZ0lkTVFmWkJxbnNSNDVHai9oOXM3bjda?=
 =?utf-8?B?QjFCTjBjS21Nb3djNkhRNHNMdjVka1NxV0lmcEJLeFQ3a0Nob09PRGdGL0dS?=
 =?utf-8?B?SnV4N1JpZ2RmaVl3VUUrKzliVzJKMDdGQlBFZXduQVh5TTZZUDJiZUwrbUdB?=
 =?utf-8?B?eitNVXdyQ3lJdGNHaHhTM0syS1ZXelZ3U2RvdzBidDFEK2hQdHpEV2liczV6?=
 =?utf-8?B?aTAwRndTL3pxSmFYeDF4UEwydFVyM0ZWSTdxUE5rV2RHdU1YeWVZRjFPRlVu?=
 =?utf-8?B?Qks4aDFNMDRGVHA0UlZSZGY1d2w0Z05xUlF6U3pwclpoZHlwdWZvZUd1RTEy?=
 =?utf-8?B?VmZKYmlSZm96VkdoNG9Dd0kyKzJPS0dZQ3JudTJ1YjlUSmlSb3NoaU1SY201?=
 =?utf-8?B?dnhFeCtZRTBuLzk2Ym1WaStsSmRlV0NGRWhXRXZWd25yeUNnVEFHWXFxanVt?=
 =?utf-8?B?MTdtUERsU3k4TW5pYVZEZlNJaWNoM2kyQy8rU05SWnlxMzZ1WU1pM1FrNmlS?=
 =?utf-8?B?bWIwb1c5dllBV0V4ZU8rQldMTEIwMHFidHcxL0p4T1pISys4d0xyTjVBT0NX?=
 =?utf-8?B?WVNwdWNuY0NYblMrUmlqOU5uMHA1akZwM0VwQkx2WnFzSXpNWlpNZWRWMWJl?=
 =?utf-8?B?am9PZnRZNm95VVhJMlJLTi82bmpQd09JaEZvRklLdnZzWHB0MEs5Y1hXVG40?=
 =?utf-8?B?dHh0aFZ3bkRNOHQvQ2dkaU5YbGg5bFp3cUlHVU1wOXJzVk55NDg5Qit6ZG81?=
 =?utf-8?B?T3k3b01FaHNoa2p4YTZ2SmRXS0dzVklONHY0Qm1EODRidUtzS0lRTEdSLy85?=
 =?utf-8?B?TTFmbXQrcFVOb1hRd0h5UXNqTHdGU3Q5TWoxMGMyZmZZMlpMRnlPVC9Lb1lK?=
 =?utf-8?B?aytOZk95WFNhc21ZRDUxT09vaENLeFc5N2pLQ0IrWnlXN2o4U2NjdDk0Q255?=
 =?utf-8?B?c3ZWRjczY1F3THB6K1QwdDBBYlB5NjlxRjV0cll3MDNEcEN6M3BaK0lLQUZh?=
 =?utf-8?B?UDNjalYxYUpMdjhYSDhjK3ZyaGNNSmdQbWUreVcxM0YzakM5b0FmN3U0SE54?=
 =?utf-8?B?WE16enNkbU5maXpuWmpVYWx2NWJsb0tzYmlUQTdHM2lGWVkvUFdFeGpqQkYw?=
 =?utf-8?B?eHk4a3ppNkxKemhQWFZqcHFrYTVGTEdZUXB1RHhLWk1ITHNKampHUndHdy9j?=
 =?utf-8?B?N21rd09KK3NvNWxsbzNyMlhqRWJaUXQ1a1hUVkdWSnViQmI0UHczYnc3cnlP?=
 =?utf-8?B?bHR0emNpYzRKSlZXSHJzY202UTYrNEZhdnFRK1N1NlhjOEZGdUNYb0dUYWhE?=
 =?utf-8?B?cDJKdjRXRXYrYmZsVEY2VTJoTldaQXR2YW05TU92cnprL3FzYWFBM05XRTlC?=
 =?utf-8?B?M3AwME9zWHcrcSt0MkFNWEIzb1FHU2s3K21sMkFJTUM1cTRoN2owcVRnWXE1?=
 =?utf-8?B?WmxUckNBZ0Ivdks5VkY3cU5MckJzSDljQ215TWZydDdPWlRFTUFqUy9Namto?=
 =?utf-8?B?TUE5cXczdTBGamlVM2xranpBeGxCQytpOVJWd0dhbHRSa1NPL29aSXdyQmUv?=
 =?utf-8?B?VStxSGNjMnJGRjNWbm9FZ29nem1hMzMvUW5MemdpSFEyb0V1OHRiNEpWSHZL?=
 =?utf-8?B?SGpRVGozUHRqMEZRZlBva3E0UnAwTk9ZcFZMYzlmZkVCRDM4L0toQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f83b73-f51f-4fef-3673-08dee7140f49
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 10:37:27.6653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WwrjPg+w2ftPdklybtXd1ksTstPvBCvkyPXCAG8Vxy054E/5fEKFiU7Mg9e+qHjtyff20NuZ9AvKi+6aZL2gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3326

On 21.07.26 00:22, Hannes Diethelm wrote:
> Am 20.07.26 um 16:30 schrieb Jan Kiszka:
>> Hi Hannes,
>>
>> thanks for carrying this over.
> 
> Thanks for all the feedback.
> 
>>
>> On 17.07.26 22:58, Hannes Diethelm wrote:
>>> This patch adds a debian package config that allows to build a deb's
>>> using dpkg-buildpackage -b -uc.
>>>
>>> The packages are libevl / libevl-test similar to[1]. However, latmus
>>> is placed in libevl. One might not need the tests but still want to
>>> use latmus.
>>
>> For the purpose of tuning the core, or what is the reasoning here?
> 
> Yes exactly. One might need latmus but won't care about the tests.
> 
> Based on the comment from Florian, it would probably make more sense to
> create more packages:
> 
> - libevl (only library)
> - libevl-bin (evl / latmus / oob-* tidbits)
> - libevl-test (tests)
> - libevl-dev (headers / libevl.a)
> 

Alternatively, maybe there is a way to split off the tuning feature from
latmus tool, like we have with autotune in xenomai3.

>>
>>>
>>> Additionally, libevl installs /usr/lib/udev/rules.d/90-libevl.rules
>>> which sets all evl
>>> device files to group evl, g+rw. libevl.postinst adds this group and
>>> triggers an udev reload.
>>>
>>> This allows to use libevl without root. However, using SCHED_FIFO still
>>> needs either root or setcap cap_sys_nice+ep and possibly some other
>>> tweaks.
>>> Some tests and my application work with cap_sys_nice+ep. However, for
>>> example latmus fails
>>> due to unknown reasons. The debian packages sets no capabilities but
>>> this could be added
>>> if desired.
>>>
>>> Caveats:
>>>
>>> The test ptrace-sync fails with <timeout waiting for gdb>. dh_strip -
>>> Xptrace-sync from[1]
>>> does not help and it is not needed: When libevl-test-dbgsym is
>>> installed, the symbols are
>>> available but the test still fails. With dh_strip -Xptrace-sync, the
>>> symbols are not found:
>>> warning: could not find '.gnu_debugaltlink' file for /usr/libexec/
>>> evl/tests/ptrace-sync
>>
>> But the package built by xenomai-images does not have this problem and
>> runs the ptrace test successfully. Already dug into the key differences?
> 
> Not yet. Might be just a different gdb version or path issue. I am using
> Debian Trixie.
> 
> Is there a way to download this images? I've seen there is a way to
> build them locally, i can also try this.
> 

We do not ship pre-built images, you would have to build your own image
here.

>>
>>>
>>> If linux-evl is also built and installed as a debian package, linux-
>>> libc-dev can not be
>>> installed due to /usr/include/evl/*-abi.h are both installed by
>>> libevl and linux-libc-dev
>>> from the kernel build. However, installing linux-libc-dev from debian
>>> trixie works fine.
>>
>> This looks wrong: The kernel is providing us with a different UAPI, thus
>> also needs to deliver an alternative linux-libc-dev package. It should
>> be the role of libevl to deliver those headers as it has no knowledge
>> about the actual kernel in use here. That's why xenomai-images is
>> generating a new linux-libc-dev and is not relying on libevl here.
>>
> 
> Yes, Philippe sent me the hint with the -Dinstall-uapi=false switch,
> thanks.
> 
> One remaining issue is the versioning / dependency's. For now, to keep
> it simple, I just used the libevl tag
> as the version. And it doesn't recommend a xenomai4 kernel.
> 
> For now, the packages are:
> libevl_59_amd64.deb
> libevl-test_59_amd64.deb dep libevl >= 59
> linux-image-6.12.90-cip24-xenomai4-r59_6.12.90-3_amd64.deb (Withouth
> PREEMT_RT)
> linux-image-6.12.90-cip24-xenomai4-r59-rt_6.12.90-3_amd64.deb (With
> PREEMT_RT)
> 
> I am working here [1] on creating Debian xenomai4 packages for linuxcnc.
> Not perfect but does the job. It's still WIP
> but a few people got this already working without knowledge how to build
> kernels.
> I did not yet push the latest version and I have to change from pushing
> the binary's to github releases.
> 
> With the uapi installed with linux-libc-dev, libevl has to depend on the
> right linux-libc-dev.
> 
> Version 59 is not really correct. The kernel has EVL ABI 45. Libevl has
> API 36, needs API >= 45.
> For kernel dependency's, the ABI version is important, right?
> 
> For libevl, it could be either the API = 36 / dso_version = 8.0.0 /
> version = 0.59.
> 
> Variant with API/ABI as version:
> - libevl 36 recommends linux-image-xenomai4 >= 45 or linux-image-
> xenomai4-rt >= 45
> - libevl-bin 36 dep libevl >= 36
> - libevl-test 36 dep libevl >= 36
> - libevl-dev 36 dep libevl >= 36 linux-libc-dev >= 1:45
> 
> Dependency packages, needed to convert the ABI versioning into kernel
> versioning:
> - linux-image-xenomai4 45 dep linux-image-6.12.90-cip24-xenomai4-45 or
> other kernel versions
> - linux-image-xenomai4-rt 45 dep linux-image-6.12.90-cip24-xenomai4-
> rt-45 or other kernel versions
> - linux-libc-dev 1:45 dep linux-libc-dev-xenomai4-45
> 
> Kernel packages:
> - linux-image-6.12.90-cip24-xenomai4-45 6.12.90
> - linux-image-6.12.90-cip24-xenomai4-rt-45 6.12.90
> - linux-libc-dev-xenomai4-45 6.12.90
> 
> To create a linux-libc-dev-xenomai4-45 package, I would have to add a
> patch for linux-evl, the standard
> kernel debian package system doesn't support custom names for linux-
> libc-dev. But this should be not to
> complicated.
> 
> It's the first Debian package I am working on that's not only for me. I
> have to read a bit more in the
> doc's how this dependency's are normally created properly.
> 
> Also linux-libc-dev 1:45 is a bit dirty: Using the epoch to replace the
> standard linux-libc-dev by a dependency
> package that will not be replaced by the latest stock one. It should
> work tough.
> 
> Alternatives:
> -Install the abi with libevl
> -Create a linux-libc-dev-xenomai4 package from linux-evl and depend on
> that / remove the evl headers from linux-libc-dev
>  so linux-libc-dev stock can be installed together with linux-libc-dev-
> xenomai4. I compared the content, most evl related files
>  are new, only fnctl.h has
>  #define O_OOB        010000000000
>  added. However, I don't see any usage in libevl. So this should work.
> -Leave the dependency's on the kernel packages away and solve this by
> documentation
>  However, you would have to place a hold on linux-libc-dev so it doesn't
> get replaced as soon as your OS has a newer kernel.
> 
> Do you have other ideas how to solve the version / dependency's / linux-
> libc-dev issue?
> 
> For now I named the kernel packages -xenomai4 but I am thinking about
> changing to -evl or xenomai-evl. What is more appropriate?

The topic is complicated because neither Debian nor other packaging
systems I know allow to express this two-dimensional version dependency
(>= ABI version X, latest kernel Y). If you encode the ABI into the
package version as well, you are folding that version matrix into a
single version number (>= abi-X-kernel-Y, or >= kernel-Y-ABI-X) - none
is perfect.

If your target audience for those packages primarily consists of
beginners, it will be best to model it via a lock-step between libevl
and some kernel package that carries a specific ABI version in its name
(linux-image-evlX_kernel-ver-Y etc.). This implies creating a
linux-libc-dev flavor as well (linux-libc-dev-evlX or so). That package
should carry Provides:, Conflicts:, and Replaces: for linux-libc-dev in
its metadata.

We side-step all these issues in xenomai-images by generating and
installing a set of custom packages in a curated environment where
upstream will not be able to replace the self-build xenomai packages
(preferences are set accordingly for local repo with those packages).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
