Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011032.outbound.protection.outlook.com [40.107.130.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44646385525
	for <xenomai@lists.linux.dev>; Mon, 20 Apr 2026 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776686989; cv=fail; b=iHRGV4bopo+fvnnmXQ1qWn3OTlahC1G2k0f9Rd+ueUZCguIx7v5C/DG7pGXTM40sNA3IBpgvgrrdnkxF3NRzUkQFCQ9SH58LdoG2BC7XTnlX05gaT5HVYsBN/3M6+SG1FmiW+fi4aZebeURQ87ZSHFq1eQDgEhURkfsyn9+SL9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776686989; c=relaxed/simple;
	bh=TSeUj8h238f/8mN7vVWzf6tcib8NK7B0AE7oEHIEnGc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=otCgD6SFX8tb0zP95aq+KSTtREoyabxm5VndsJY/k1npz8JYGY19fszwYZZ25Sc9NrZquzA+1zzHBjSZfgrPMUCW7HZBofNssRoZRdguplYOkx+e2AeF/+QQ8Bp/DtUwEZ5laUKF9rsjB6iNAISLYVOnKXGUvrEjhd2CnhKdX0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=psqzkd7t; arc=fail smtp.client-ip=40.107.130.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="psqzkd7t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9HuYHShFxI/KGFnNihkrJY6nyLGxnZn/gbGo7/ozb3K/6giG/cFxfPxrMJ/FNNx7jXQ4+dtUUP5PJvXcqggVuYKWu1J4Wrq6LBJqTghx/qvJ2gM3SurIiWJHuaJ5TuxTPP0IUL4jdInsbDtNQT92mnWXNNIn8yTo0MogdSdYsVzZjLpFVj+IUn5AQmN/NqFOdtuOtA9RXePMoiWzSUUfA1mhU+EScqON4lgRzk/HPl/GmnrXhbowPp2ptPkvqZU8BfQ5t86Wh0u56IyMUGAJP4aKjNdLIDPMIKd4SLkVlqxMYEOWawFjOJ7HMGqXFayYYlyqy47XGv8Qwr2+ZhUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27zoAi4V6n8tO/7u42mALkARWo4a0yqJdQP+X+zppvs=;
 b=FtI4GUJEXodWdRyPhEoJY32CNe9r5BAgAAhahjIULZUwHSVAhtnppQjGCoMZ0mLlOQTiqoVy4gFLjgWe9He2z1Wcpd0T/UN4POm6v4AP3yA0/KbN+JPrs8CxUqOzLz5vS/J0oL+i75LE0fBBieCK0omPEBQ79x+VXt6g2ulFUBpDWeBdg9c9y3gtix69rg9JUqBaI/Xie19xdPA/NTUEZlvh4QS5cLGkSkcNSxsOLNPJTi3pJWARhITtk0/nr6lZrfatANFSJTtKfU7voWxqqDlSV+ucNRRd+qrwriP6KW27HhFK7wgyxXz1QMPnSORGtPGCr5GQbTMdT7DNguRP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27zoAi4V6n8tO/7u42mALkARWo4a0yqJdQP+X+zppvs=;
 b=psqzkd7tq85GbAa+xjEuD9UjImashuMn7AuHGNEv0NMf+D12IcrZtGrmhFP0j80Bkxsk9HP2hT/dFWlZKnvMVqP27tiLirswlGFj9M86F5URa73OxVhvfvnJ/iUcILfoqwHeZr1j6aeiuunRYIGYDabFqy+e9nN3x9xe0JJUJKxcUqbfGcEMznbvYSmecLYTKm31LJSDb7Xz6bZS1NPxkFeYXtSWQeHoORGD1Yr9bClGzZgMyt1zTayFcsmIci61+sVYNppAYRP5scp/n0sJ3A0yMeWbthxxj3LY2BVHeeI/pVryixj94vD3HtXZ3n1v8+77ocRDgdqpjMjoBGiUSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7018.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 12:09:44 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 12:09:44 +0000
Message-ID: <2c20870d-12d6-4f7b-bf38-cb165360835d@siemens.com>
Date: Mon, 20 Apr 2026 14:09:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC xenomai-images 4/5] recipes-kernel: Move nfs boot
 configs to own snippet
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com, rpm@xenomai.org
References: <20260417205713.2290350-1-tobias.schaffner@siemens.com>
 <20260417205713.2290350-5-tobias.schaffner@siemens.com>
 <3885a21c-b57c-435c-be76-ea246dc588a4@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <3885a21c-b57c-435c-be76-ea246dc588a4@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::12) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 802471ac-126f-4997-3d7f-08de9ed5b59f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	6EL1YP2Mv27ZMgp4rCotGdE2l/Wk0JTXZmSGjFTjsBAIWjsfdi/jeMTDLUovwlxhjUiLLAm65bPYuBRIVXBYn5zT+51KC3U1sJjUe0H+aljbXXIpT8aWBkJaL0TWIzjRDZsK9NkbNwCyg5LAhyCo4mGKh8FNkxpJfAuidPnEcI/DAP4948czEqHKtBx1zQr7lgvhDJBWFsWvj643T4WMBUEmE6VcSicn3nLKS0ladqX7czsxNL0r2OtEjj/BMrozwsODN7CijEQm1SfeaU7/1xAPY+bzBOE/EvGrVr8wLSVz2KHYpTZ0eWxtISX/xFxb02Gt3/2PBYdz5WhYpE+89TUJP4CKQU0zy/3dtiIN5dMA8x9jElRbNoTbFCXbujLnevSaeQFMoaG3lzOtfgMpjktGM4hYt4uJPPWZTJeiM8fiEF1CThgttyy2uhct14Xkuzb67orIDpeewzZKz4bJ1Jv28ol6n4OrBHD9wgcedB12JU09wIeCn+vUCvlFJIlx03kXSyQ2LNVce1L6RpVOUp0ox4txuS7dvND8CzCves4A/sP/f8sTtaw4brfBctbnGsLcyQifvfoXaOhCkXuzXaAoC+JDtNfeXw6owRY7JuoXmmAtNvAMlszgUSPCAuhNaiYLLqUTXght+GaP5Vtp3l7FDJ8P/lMMuuyKUkX4lJY6A+m+vjO7ZzUkYAZLaac67eTBDD88gVKUB5NQ7ZP3op+CvKCLrUu/vCrZp/Pc4ko=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkpwRUQ2byt3R1ZpRTV1TGorcXh6SzdXU2lwY1FpeFJ0U2N5RG1ueWM3QWl4?=
 =?utf-8?B?VWJNUEovc2VQdytJeXBvMkFoY1c4bFdDNTF4MEczamVyVWVOVFlWS0UyWEw4?=
 =?utf-8?B?YzBTeElFcU9xUWZqSlhBU05iNEpCR2VsbStvdEhOczJOZjFqT2ZmUnlGZllK?=
 =?utf-8?B?eWd4dzNxQTR2eTU3TVUvNnoxaHVxNnZZSCtCSTIyOVpHL1BEbHdURzJncVZZ?=
 =?utf-8?B?NHFEUEpuZng3N1pzc240T2ZYWmZCYXI2cGxTWDN4WmoyaGdLSTBpRmxhZTQv?=
 =?utf-8?B?aU1XdjhWeEtzT3ZMaWNQVHIrNDNKZFg4VmFicDkzTDJDQkgxTWtLM1QvY1Jx?=
 =?utf-8?B?Sk9oSGlhbHFOcHJ2L3pGb3k3UGVFLzFlNU1uNHBKaTg1cWJHR3RBYzJaSERu?=
 =?utf-8?B?WDUwc0Q5bEdPMkNlb3FTdVN1eHVMUzVBL0NsQmVoSldPSFhDZ0dFOXpqT3lV?=
 =?utf-8?B?dUh2cWtFMDM3RVFNazVtL1BoRmwweE41QzRjYnVkckl4MnpZWFB0STVSMzY2?=
 =?utf-8?B?QWdBQkJORDJuTTNXdUNPeFN1M3gxRVpYaEF5N2FEekJWQS9EQ3NDSGNtQlBC?=
 =?utf-8?B?THlDY1BUUXZ3M09GK1pmKzdaWkFEM2pINFROZFEyZElRV28rV0V6UzlDOG1u?=
 =?utf-8?B?ZkpKVjRxbXdLRzI2R0RZWmNqK1B6c1VwU21aaUlFbWEyQkVPMlVQc3dMbEsv?=
 =?utf-8?B?YlFEN1F1dTFid0tzcFdwaDhxS1ZvUHhwVDQ0WXVuNzgwTGtqSTByN1VJK2sx?=
 =?utf-8?B?b281VnhRbFFUK3EySHhBZ2FIdHRTd3o0T00wZGErYUNGK0RiNEZqS3JDNy9K?=
 =?utf-8?B?TWZ6Zk9HZ1pMeWlxNTFYelYwVDN1OFlLZzVlTy9HQVJZcFM2MVUzcGE4NktB?=
 =?utf-8?B?WG9TQ3NxMFQzRFJheWpJMFQ3eFB4QnFOZU5HVGJZdU0wZWFQRGRHYVpiT0hC?=
 =?utf-8?B?dlI1Q3ByRWpBNkwzYURsOUdrU1h2NExpbEM2aFRqSFhTRjlFS04za2NWZG1Z?=
 =?utf-8?B?SGh0UzNIREIxWjVwZFh3aURVSTRBK25HTWpQS01HdnN5SUdLV0VXS0dpVktD?=
 =?utf-8?B?Qy9zUHQzOHF3OXJtelpLTndqeVMyZEtLYS82TEU1OHRUQTlzSzYzbkdLdzZt?=
 =?utf-8?B?SEI0WDJIQ2RSMTZTT1dLWmI3YjUxdS80ckgyR25pVHRqMmFuQXVUTS9mdGNF?=
 =?utf-8?B?TjJxSjU4UVV5ZUdRMnNBSG9jby8xMFY1TVFUcHB5My95dnN6TjUzcEhRYlE1?=
 =?utf-8?B?SW9TakNPVnVySkYwMFpqSE12c0RXczlYOWtSaGFvNDlsaGdpU2RhNzVIdnRx?=
 =?utf-8?B?eU82K3JydU9iclEvYnp0OWRReDQ3QnVtVkgxVFF6cVlHaklTVGZOT216cjF0?=
 =?utf-8?B?NWxnamtzZXFRa2RlZzNvL3VRUU9TcE82eU5JL2d0VDJyL20rY25ZUTIwNGdU?=
 =?utf-8?B?R2lOSkZNd2t3amovTUdWY0luU0hLK3F4MGZsRU5Pc0pIUWhGc3ZqcnFSWG9U?=
 =?utf-8?B?WXp1MVhNM3pOOEZ5ZWpjUUgxVU5YTitvTUwrTjQ1ZGQ1UUc1YmhYeUkvaXps?=
 =?utf-8?B?ZjJ1UWlBTVBtcEp0ajJPSGNnZm5OWGt0REhyck00MjJCeGVDMzBOYi9LYTN0?=
 =?utf-8?B?ZzJZTy8zSHlkRmFIdEhEMFAzQ3phTUMzdXplZ1dsZHE4ZFpiaVJHMlB1cG9K?=
 =?utf-8?B?OU5aUUVjV2h2VHhtL1Ywc0JpVVlrNVlnYjk2TDB3NE5xOWRmaUcwaWRMb3FM?=
 =?utf-8?B?Wnc5L05NR2lyVFZwZ2JKVnhPY1ZsUVBtZmNPTWMwemZqV25aMi9UU3p2Wjg3?=
 =?utf-8?B?SWQvMlRwK1pwbFJnV0I3Y1RnKytSUUt1b2RtQU5mc21UN3hZeCt0WngvV3ZB?=
 =?utf-8?B?M2hXZjY5RVV0amdQdVAzM1VBSFFhSWdJS1M2VFAvTzMrRHU1blp0dCs3WUFr?=
 =?utf-8?B?Y3VjeElCWUpCaTNCWVg2Q1c0dmMvbTBMUENaNHF0b0llRjZUbytSMUR6QW42?=
 =?utf-8?B?SGg0YjMxSkdSMkdTMUM4anZkVjlvUGtwRE1SelU3OVZ6Z0Z6VG1oUEpuQXp6?=
 =?utf-8?B?dnkrS25MWERvSllVcmkvd3hBRFZRaVAvSEtxeGpRc09OcnNRZjlwaTFtdXo0?=
 =?utf-8?B?N2NFQnUyZDA4cnd4VlVTTWJKN0pkcitDMkcvMG9VWWtYV0xEMkp3VWxqTHpk?=
 =?utf-8?B?TUdya25HWkViUTBpbGJ5a1dndUhiU21jcUVkdzFJVUZjaHV0NkF1UW8xOFha?=
 =?utf-8?B?aWVPQmUramtleVZ2R0w1azhxdmg3cUE0NmZTcDI4SGtzNUl5d0g2ZWQvMGRN?=
 =?utf-8?B?VkhkRW5wd0VTS2JqdmVpOE5Ra2REWmdTZEtrOWdqSnZRTzZXTDYxODNWNHJ6?=
 =?utf-8?Q?rZoS3Af8ZBixv0UM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802471ac-126f-4997-3d7f-08de9ed5b59f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:09:44.7565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+q2i0gzxjBdHEr/9AkfQTKNqTtfQW2FXgxkowPtjHveS9HwAD5n1iD3Y0UoPuRG3DRyLG7bSOapUH0yhyXe51K8Pkf/TA/QIOqmBvW0VEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7018

Hi Jan,

On 4/20/26 07:45, Jan Kiszka wrote:
> On 17.04.26 22:57, Tobias Schaffner wrote:
>> Move the kernel config switches that are needed for nfs boot to its own
>> snippet. This way they do not have to be maintained individually and are
>> also enabled for riscv.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>   recipes-kernel/linux/files/amd64_defconfig | 6 ------
>>   recipes-kernel/linux/files/arm64_defconfig | 6 ------
>>   recipes-kernel/linux/files/armhf_defconfig | 6 ------
>>   recipes-kernel/linux/files/nfs.cfg         | 6 ++++++
>>   recipes-kernel/linux/linux-xenomai.inc     | 1 +
>>   5 files changed, 7 insertions(+), 18 deletions(-)
>>   create mode 100644 recipes-kernel/linux/files/nfs.cfg
>>
>> diff --git a/recipes-kernel/linux/files/amd64_defconfig b/recipes-kernel/linux/files/amd64_defconfig
>> index 590a1d5..d46064e 100644
>> --- a/recipes-kernel/linux/files/amd64_defconfig
>> +++ b/recipes-kernel/linux/files/amd64_defconfig
>> @@ -1040,8 +1040,6 @@ CONFIG_IP_ADVANCED_ROUTER=y
>>   CONFIG_IP_MULTIPLE_TABLES=y
>>   CONFIG_IP_ROUTE_MULTIPATH=y
>>   CONFIG_IP_ROUTE_VERBOSE=y
>> -CONFIG_IP_PNP=y
>> -CONFIG_IP_PNP_DHCP=y
>>   CONFIG_IP_PNP_BOOTP=y
>>   CONFIG_IP_PNP_RARP=y
>>   # CONFIG_NET_IPIP is not set
>> @@ -3664,14 +3662,10 @@ CONFIG_PSTORE_ZLIB_COMPRESS=y
>>   # CONFIG_SYSV_FS is not set
>>   # CONFIG_UFS_FS is not set
>>   CONFIG_NETWORK_FILESYSTEMS=y
>> -CONFIG_NFS_FS=y
>>   CONFIG_NFS_V2=y
>> -CONFIG_NFS_V3=y
>>   CONFIG_NFS_V3_ACL=y
>> -CONFIG_NFS_V4=y
>>   CONFIG_NFS_V4_1=y
>>   CONFIG_NFS_V4_2=y
>> -CONFIG_ROOT_NFS=y
>>   CONFIG_NFS_ACL_SUPPORT=y
>>   CONFIG_NFS_COMMON=y
>>   # CONFIG_NFSD is not set
>> diff --git a/recipes-kernel/linux/files/arm64_defconfig b/recipes-kernel/linux/files/arm64_defconfig
>> index 1dc8b69..84802a3 100644
>> --- a/recipes-kernel/linux/files/arm64_defconfig
>> +++ b/recipes-kernel/linux/files/arm64_defconfig
>> @@ -981,8 +981,6 @@ CONFIG_XFRM=y
>>   CONFIG_INET=y
>>   CONFIG_IP_MULTICAST=y
>>   # CONFIG_IP_ADVANCED_ROUTER is not set
>> -CONFIG_IP_PNP=y
>> -CONFIG_IP_PNP_DHCP=y
>>   CONFIG_IP_PNP_BOOTP=y
>>   # CONFIG_IP_PNP_RARP is not set
>>   # CONFIG_NET_IPIP is not set
>> @@ -5768,11 +5766,8 @@ CONFIG_PSTORE_ZLIB_COMPRESS=y
>>   # CONFIG_SYSV_FS is not set
>>   # CONFIG_UFS_FS is not set
>>   CONFIG_NETWORK_FILESYSTEMS=y
>> -CONFIG_NFS_FS=y
>>   CONFIG_NFS_V2=y
>> -CONFIG_NFS_V3=y
>>   # CONFIG_NFS_V3_ACL is not set
>> -CONFIG_NFS_V4=y
>>   # CONFIG_NFS_SWAP is not set
>>   CONFIG_NFS_V4_1=y
>>   CONFIG_NFS_V4_2=y
>> @@ -5781,7 +5776,6 @@ CONFIG_PNFS_FLEXFILE_LAYOUT=m
>>   CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
>>   # CONFIG_NFS_V4_1_MIGRATION is not set
>>   CONFIG_NFS_V4_SECURITY_LABEL=y
>> -CONFIG_ROOT_NFS=y
>>   # CONFIG_NFS_USE_LEGACY_DNS is not set
>>   CONFIG_NFS_USE_KERNEL_DNS=y
>>   # CONFIG_NFSD is not set
>> diff --git a/recipes-kernel/linux/files/armhf_defconfig b/recipes-kernel/linux/files/armhf_defconfig
>> index ff8908d..c8b46e1 100644
>> --- a/recipes-kernel/linux/files/armhf_defconfig
>> +++ b/recipes-kernel/linux/files/armhf_defconfig
>> @@ -1250,8 +1250,6 @@ CONFIG_XFRM_IPCOMP=m
>>   CONFIG_INET=y
>>   # CONFIG_IP_MULTICAST is not set
>>   # CONFIG_IP_ADVANCED_ROUTER is not set
>> -CONFIG_IP_PNP=y
>> -CONFIG_IP_PNP_DHCP=y
>>   CONFIG_IP_PNP_BOOTP=y
>>   CONFIG_IP_PNP_RARP=y
>>   # CONFIG_NET_IPIP is not set
>> @@ -6723,14 +6721,10 @@ CONFIG_PSTORE_RAM=y
>>   # CONFIG_SYSV_FS is not set
>>   # CONFIG_UFS_FS is not set
>>   CONFIG_NETWORK_FILESYSTEMS=y
>> -CONFIG_NFS_FS=y
>>   CONFIG_NFS_V2=y
>> -CONFIG_NFS_V3=y
>>   CONFIG_NFS_V3_ACL=y
>> -CONFIG_NFS_V4=y
>>   # CONFIG_NFS_SWAP is not set
>>   # CONFIG_NFS_V4_1 is not set
>> -CONFIG_ROOT_NFS=y
>>   # CONFIG_NFS_USE_LEGACY_DNS is not set
>>   CONFIG_NFS_USE_KERNEL_DNS=y
>>   # CONFIG_NFSD is not set
>> diff --git a/recipes-kernel/linux/files/nfs.cfg b/recipes-kernel/linux/files/nfs.cfg
>> new file mode 100644
>> index 0000000..23d9357
>> --- /dev/null
>> +++ b/recipes-kernel/linux/files/nfs.cfg
>> @@ -0,0 +1,6 @@
>> +CONFIG_NFS_FS=y
>> +CONFIG_NFS_V3=y
>> +CONFIG_NFS_V4=y
>> +CONFIG_ROOT_NFS=y
>> +CONFIG_IP_PNP=y
>> +CONFIG_IP_PNP_DHCP=y
>> diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
>> index db0abb6..a07811d 100644
>> --- a/recipes-kernel/linux/linux-xenomai.inc
>> +++ b/recipes-kernel/linux/linux-xenomai.inc
>> @@ -22,5 +22,6 @@ XENOMAI_DEBUG ?= "0"
>>   
>>   SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
>>   SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
>> +SRC_URI += "file://nfs.cfg"
>>   
>>   S = "${WORKDIR}/git"
> 
> I assume you checked all configs for being identical before & after, right?

Yes. But this case is way simpler compared to the opt-(no)debug case as 
we always apply that snippet and the switches are all enable for the 
other architectures.

> 
> Jan
> 

