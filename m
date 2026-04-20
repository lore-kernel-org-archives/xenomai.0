Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013058.outbound.protection.outlook.com [40.107.162.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2071626B2AD
	for <xenomai@lists.linux.dev>; Mon, 20 Apr 2026 05:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776663947; cv=fail; b=p0cYH0MQidRsRt700lpV2fHwmf8cLTichmGEg/guAWZYZd+gvMKzcNncc/Hy0Y7WnLpOoSV2lyzuwZHvnEow9Fk5j/vjBetG+MBudlv5JwgKsrHCuF8NRLRb+A5gvHbVlAVaAEOlFgJaJivducmCuRQre/tdJosFW11Q1A4GlT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776663947; c=relaxed/simple;
	bh=j4tNE+jL6zZXJtWpinyez5YzibYzUAWUaVJC/wvm510=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IXB0mwQkgYh8YV+QSxjffVTX6tJES8BYmnAO4IXIDcM7iP9xz2Vbv7IB5odXYY7f3m6b5RIBVi+VmsLavnZY9VtQk9bcETCnNo5eMwL9yqZ4bpP9hD1z913skvkE0fpzarKIunbeXhBi6Zn/hmewM4XYEfoYFZVD4D7eTqVRs9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=OfVTtUdN; arc=fail smtp.client-ip=40.107.162.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="OfVTtUdN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5LjHK3buhLWZmL8UoZo6XGayVSn8JmdOyI8N4c/ts98i58IMa72bFzk3StxJa0HAeIGKMDUAHyvrTjHHwvu32VAFzFeo6OjPdlOEtNC+VDDVXfoWBQZgbMlKoDVDiKmrurtQASCET5ilZH3WVC3xIlvlom49WiSECoN1Tb1IYKqjZLvs0diJoOtml8PVaF0R/fLxxNbMEvUheY38vY1o/Jj3VcnW76gJNeRyy/wdfLNx8STooDkWRmR1twA2vwttTYHopgv6lIifw+b3ubVL8bavDahQQo2GWSnl+d3tcy4pYhdUbDRbYKjsv6XANUyQKpWepF5YFVyZXms83OsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sb2WlRbpYZYaKqA27wrawRahVWhuR/s9qoocvCYY8eg=;
 b=SSDk8AxUhcKLOiBrg2yfCfnn/LfVZBklPLYp9j5kDvUz+sB06ENveB9aYfKmb6O3CnxLSCPuwM3fnuv5Vl+hZq4grUc225D/i8Axt1d04a1oVV+RLW6g7u/79cm+1i03GEGUWbk5C4FvgLtM+SHG8M2hRHZXRfhhfDwuCzin9HvtfhZBoU2kCEN8rRXast9gIOAn2ng1vCX8ik51TeieIPlYTXvZnXUNl5VYxYTrgKvafxqqNdNSxyZ6juWl8aJbu8g6whpP8AE4+jK7Fxtpn0alE9CBbJGi9kxHiSkV2JDW6axp7kodtMhqftB5eGDh3R02LiMZRm76FTXzHYcd5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sb2WlRbpYZYaKqA27wrawRahVWhuR/s9qoocvCYY8eg=;
 b=OfVTtUdNYZTB7Qg9gENY9YDl1UWQNAopZCv0QwW6v7azEtMNd6KkHDQHgip61qKhDsOnOAkq4LSoRo+axHpkg4uvVq8Ea8ErjCjAK5jxxCSnDG8FGVRODQIDYb5rktauGAqpqD5hTCIgMme9yoqUD8hKhYQwZhWvINe3Sf/yRHDFMXetUmSHnRFrJDScTTHllaBiQlOBowa99QKLw+ZqDmeMmum/ts3YK91fb8kMYKGRQ8Lkv3FPyOjqPPOOGhpul9soXgVHNBMhHT3dqGsW0PNSUmpwC6ywV17iGyyaMjh7oupfUSkz14e3V4hH+QPobjRJCjPhMLz789Vsj04GPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7125.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 05:45:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 05:45:42 +0000
Message-ID: <3885a21c-b57c-435c-be76-ea246dc588a4@siemens.com>
Date: Mon, 20 Apr 2026 07:45:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC xenomai-images 4/5] recipes-kernel: Move nfs boot
 configs to own snippet
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com, rpm@xenomai.org
References: <20260417205713.2290350-1-tobias.schaffner@siemens.com>
 <20260417205713.2290350-5-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260417205713.2290350-5-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 857f4ba3-65e5-4a86-6505-08de9ea00f7f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rHrpF4Kcn3zXnnYviCfpYiN9R8ETl/jtjvF13tHerVzAlGPyYnThprYjqPsWAUcRAh0bPSmjabc+WBuYfOdZ3TcqtSCzbmLOjw78NS0tPJ7I/+NH2LhP6xtksuhQdBBWVpZEiZx4nRmi0W3NooAV/fhAy2U3/6ZPmXxEHHinBdo3Hx0k7vmcadbTS7e2gR603ruiveTlqvKAC18sWxYE4W2mGbGbalU/Aoii1fU3jdKGip98RFI0NKxNY3ueDpyeYmejmpiOx8KIPsrYayR6FHnXRZQFykid4BhHCt7cvaUw/nmNWYnAFJoZXhWwK3Wy4WQR9aHdjD8SSjbRF9Fua9N7pVF3PEPHlfR2pG7dhS+fIBwZEV7cTsjjkp2CBelMFTI4LB34vfJ95KCBUQQtAuqzH+Fpay7/iPBzjU2ohnfDA7H3tKe7qdz8A1R3FnjSThOGW5ow21v9dr8CfDwCjt3duIT1noA7vplweIbCp8ceYHd47efIRUyC6I18Husf4whW6AH8WmnZ2QQhekJ+EEqdRwdNRWAzVyhV9rpaIUKd7nADvvL/yBvWEwvO0j8LzZCsHcZDM7bquPpUORLq2r96l12HYfEJvA1lg3iNtKXvqtTaHvYTryGqVGGDBJtSRqWl6coKbGUvV3bGmsvN7OKHePVpHetvHSZVTUB9G0Pi9VIp+TzLvl7WZv+AY8g8YZKvF78OBkDg2pFTTOKmLeept/YM5Ro9LbRNyBcZvhY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVlRWU00T0tGajBvbDJzUW9lZVVLQkxOd1lOcEcxbnI0a0JMSGRVa09KRU1F?=
 =?utf-8?B?am1hNFF0MWJEM216UWNvUE5CZ1NUR1kvMHdXa1FRSTBrSXVEVmdKeEJVZnl0?=
 =?utf-8?B?ZSsxek5PUkpvcHF3a2hveG9WTVdGNFdzOWMzVTNCN2VieUJtckZsSm5lSXVR?=
 =?utf-8?B?US9HM2UrcVZIdW53VmVQeEFYaUdSSCtuVkEyN1N5bWJXclJDUXFwYS9ad2lN?=
 =?utf-8?B?NzVRallmMDJGVzU3N1FaSS9QRmpNZ2RueG5hdUxsVUJqUGhISWhlNkJzaVVZ?=
 =?utf-8?B?eGxtN0M0RXlJU3E0bC9TWG5tOW9FK25PS1FmLzRkbkltWDQ1dE9yc2w0bkQz?=
 =?utf-8?B?a2tBYlQyS1pOTkpnSS8zNDFFNWV5SzVUZHBJdnpUNXJrUUhURzVOZGJLdGNp?=
 =?utf-8?B?T3AyZnRvdjlzajl2Rk9pOFZXaHI4ZHVZMUVBRFRIbXd5amY2L2M1NGYxb1Nm?=
 =?utf-8?B?bTdjQ3JrU25CL0J5Vm0yNTkxT3kxeUh5UloyVzY4TUtSV3Rmc1BISHlzL2dU?=
 =?utf-8?B?VFJnS3dIM2JQWTFKQUV5dU5NR2hPOGJ6TXZtUGFtV2g3SlFHZkZjQmQxclpp?=
 =?utf-8?B?MlpKMnJKRnc5Slh3ZGV2RmFEbTJSbEN0MWFjMDFTMmY4QkZOcWFtcWxKRXNJ?=
 =?utf-8?B?cnhkWGVIT3E3ZjVTOEs0ZXpiTzV4bUdNeTNXWCswTHp6c21xVUw3aGkyOWZ0?=
 =?utf-8?B?bEtZV1F6RDRUdWVzOFpENEF0MGYvaWZ3YmlyZzVIYks2YWQxYTVSQmpNcGw3?=
 =?utf-8?B?Y011UURRMktwbm5aOUlyQW02Y0dOUG5sTVFic1dBbFZzVVRQeSt2N0RwczJo?=
 =?utf-8?B?Rkx4KzFnQWNnSlBGNXVPRzdjRlNONFpOMnZXUVVwTEVNN0pnVWpEbnIxYXJw?=
 =?utf-8?B?blYyTUNRRVNtdkQraHZ4QVUwUWhxVHJIcmJCNU1icm9PNGtRdTFVUEM5VEc2?=
 =?utf-8?B?Q2ZjTk9QekRWTTNWYVJWU1VhTm5aWkRyaEhXZ1c4TXUxMC9GTGJvVHBFNG84?=
 =?utf-8?B?aDBnWUJCVlhLenRRMGpCc0xFcFpSWGdraUF1c2YyVEE5MVZJSlNlaUM1SmYr?=
 =?utf-8?B?U1lha0U0aFZHUjR4ME4wMm5xQjNjeTluNURjOENieEJFQVgwQ1ZSNDJWNUNn?=
 =?utf-8?B?dEhqQkZpekJKbDFOVERiNnlhZlhmZUVvaWNrOFJtZXlOd1RDendTenB2Z3dn?=
 =?utf-8?B?eUhhbklKWDlRY2JLcXVtVlY1aWhONUJuYWlrZjhWUFZJS2k3TUVFOUlWNWVx?=
 =?utf-8?B?Y2duenpXMTJRWEhNY3dkREVzd2VNWUVjVVlzam0vTWJyQjJ0L3hLeWZtRmRh?=
 =?utf-8?B?TG1FQ05RZkpBeW9qMStwS0JOQXNUcDI3VDAxOXlDQXZKa2phaVk0cVdSU2FL?=
 =?utf-8?B?TXVTNHBBL2hvUFh5VmUvTm4rT05UbXR6TTVFOFcvNThtVnF3MHgwM0pCQnpR?=
 =?utf-8?B?TnhvZ29QcU5LTlBEaGNuR2NMT09WdVhkNXRrc2RtSHBOYXBmMVVoc0x1SVlv?=
 =?utf-8?B?ZXdwVFBVWndzRUVOSGtWT2NLb2NZN0ZkeHNMblBJa1NSdmszSFJBUmJKWXdG?=
 =?utf-8?B?bmNSQU16SE9qUDRFSnB2TU8xYlZqSk5ZMXdESUxQR2hJOHQwWHhOTG1xbmln?=
 =?utf-8?B?TGtDMFREMzQ1NTQwVHlUbmtBbmFWd2czcUNJZEJhS3l5cjBsUlFtTDUxcE9m?=
 =?utf-8?B?MjRFcXpycGJYZlZlcmpnWDIrbnNoM0FkeVFETjh1a0g0VlJISEtZUHpWUXZu?=
 =?utf-8?B?dnB1aWlPZHk5N1JSbXdZb1NSTHdMSk13SFBNWUtqUjJjaFRQSUl5K1l1bXB2?=
 =?utf-8?B?NWxxTnN2RWZNNXZQUkpJWXUwVHQ1LzJqQVUwRHJnNU9Nbm4vLzYrVmlzUFFz?=
 =?utf-8?B?YlBqTXdneGdtTEVZRFpSMU9Fc0pXSDBFUXl4U0dqNVhiR1ZMck85TkMzVHpW?=
 =?utf-8?B?b01jZjE4OU1QcXVHcE1Cc1daWkdBc2ZQbkpRWmk1RTU3blBvbExKYWtRVTF6?=
 =?utf-8?B?cElkcGtUWlhVMnZTVkU4Vk11Vnc1cDVjMEw5MEM4TTJMamduK2dCdFEyNTlI?=
 =?utf-8?B?aVlvUGFVMUNvVXNSTjV4N1pydzFkcVY1MkxhajJ6Zlc1OGsrS0hVYnNhQzNm?=
 =?utf-8?B?MmpwZHpuajRQNGNVWDljMmYwWE1JVU9qbkVid2NPUEZhL09Xb2FhdHNDbkpz?=
 =?utf-8?B?eTVSbTlQcTNDYjA0UFJQbm1jTldzd0hoR0YrbnM5NHpQZE5nSEg3dUlmT0Jm?=
 =?utf-8?B?RmpxWm0vbVc5Tjc4cDZIVXgzeXhseHJHbFpUZTVPQ3dXOWRWdzFhc1ZibS9J?=
 =?utf-8?B?V2dtelRNaUZSanlTRXk4M3VvUlJCVU9HMWVRTlRlaTl1T2lwdHdHZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857f4ba3-65e5-4a86-6505-08de9ea00f7f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 05:45:42.7803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpIgOhFJ66w8pQzyv2tBgzzE2jvW+Z1ddGs9BTgDk78oywY8T54ZRYQX2lu9GISEbyFriITB4aei+WpUfTGVGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7125

On 17.04.26 22:57, Tobias Schaffner wrote:
> Move the kernel config switches that are needed for nfs boot to its own
> snippet. This way they do not have to be maintained individually and are
> also enabled for riscv.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  recipes-kernel/linux/files/amd64_defconfig | 6 ------
>  recipes-kernel/linux/files/arm64_defconfig | 6 ------
>  recipes-kernel/linux/files/armhf_defconfig | 6 ------
>  recipes-kernel/linux/files/nfs.cfg         | 6 ++++++
>  recipes-kernel/linux/linux-xenomai.inc     | 1 +
>  5 files changed, 7 insertions(+), 18 deletions(-)
>  create mode 100644 recipes-kernel/linux/files/nfs.cfg
> 
> diff --git a/recipes-kernel/linux/files/amd64_defconfig b/recipes-kernel/linux/files/amd64_defconfig
> index 590a1d5..d46064e 100644
> --- a/recipes-kernel/linux/files/amd64_defconfig
> +++ b/recipes-kernel/linux/files/amd64_defconfig
> @@ -1040,8 +1040,6 @@ CONFIG_IP_ADVANCED_ROUTER=y
>  CONFIG_IP_MULTIPLE_TABLES=y
>  CONFIG_IP_ROUTE_MULTIPATH=y
>  CONFIG_IP_ROUTE_VERBOSE=y
> -CONFIG_IP_PNP=y
> -CONFIG_IP_PNP_DHCP=y
>  CONFIG_IP_PNP_BOOTP=y
>  CONFIG_IP_PNP_RARP=y
>  # CONFIG_NET_IPIP is not set
> @@ -3664,14 +3662,10 @@ CONFIG_PSTORE_ZLIB_COMPRESS=y
>  # CONFIG_SYSV_FS is not set
>  # CONFIG_UFS_FS is not set
>  CONFIG_NETWORK_FILESYSTEMS=y
> -CONFIG_NFS_FS=y
>  CONFIG_NFS_V2=y
> -CONFIG_NFS_V3=y
>  CONFIG_NFS_V3_ACL=y
> -CONFIG_NFS_V4=y
>  CONFIG_NFS_V4_1=y
>  CONFIG_NFS_V4_2=y
> -CONFIG_ROOT_NFS=y
>  CONFIG_NFS_ACL_SUPPORT=y
>  CONFIG_NFS_COMMON=y
>  # CONFIG_NFSD is not set
> diff --git a/recipes-kernel/linux/files/arm64_defconfig b/recipes-kernel/linux/files/arm64_defconfig
> index 1dc8b69..84802a3 100644
> --- a/recipes-kernel/linux/files/arm64_defconfig
> +++ b/recipes-kernel/linux/files/arm64_defconfig
> @@ -981,8 +981,6 @@ CONFIG_XFRM=y
>  CONFIG_INET=y
>  CONFIG_IP_MULTICAST=y
>  # CONFIG_IP_ADVANCED_ROUTER is not set
> -CONFIG_IP_PNP=y
> -CONFIG_IP_PNP_DHCP=y
>  CONFIG_IP_PNP_BOOTP=y
>  # CONFIG_IP_PNP_RARP is not set
>  # CONFIG_NET_IPIP is not set
> @@ -5768,11 +5766,8 @@ CONFIG_PSTORE_ZLIB_COMPRESS=y
>  # CONFIG_SYSV_FS is not set
>  # CONFIG_UFS_FS is not set
>  CONFIG_NETWORK_FILESYSTEMS=y
> -CONFIG_NFS_FS=y
>  CONFIG_NFS_V2=y
> -CONFIG_NFS_V3=y
>  # CONFIG_NFS_V3_ACL is not set
> -CONFIG_NFS_V4=y
>  # CONFIG_NFS_SWAP is not set
>  CONFIG_NFS_V4_1=y
>  CONFIG_NFS_V4_2=y
> @@ -5781,7 +5776,6 @@ CONFIG_PNFS_FLEXFILE_LAYOUT=m
>  CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
>  # CONFIG_NFS_V4_1_MIGRATION is not set
>  CONFIG_NFS_V4_SECURITY_LABEL=y
> -CONFIG_ROOT_NFS=y
>  # CONFIG_NFS_USE_LEGACY_DNS is not set
>  CONFIG_NFS_USE_KERNEL_DNS=y
>  # CONFIG_NFSD is not set
> diff --git a/recipes-kernel/linux/files/armhf_defconfig b/recipes-kernel/linux/files/armhf_defconfig
> index ff8908d..c8b46e1 100644
> --- a/recipes-kernel/linux/files/armhf_defconfig
> +++ b/recipes-kernel/linux/files/armhf_defconfig
> @@ -1250,8 +1250,6 @@ CONFIG_XFRM_IPCOMP=m
>  CONFIG_INET=y
>  # CONFIG_IP_MULTICAST is not set
>  # CONFIG_IP_ADVANCED_ROUTER is not set
> -CONFIG_IP_PNP=y
> -CONFIG_IP_PNP_DHCP=y
>  CONFIG_IP_PNP_BOOTP=y
>  CONFIG_IP_PNP_RARP=y
>  # CONFIG_NET_IPIP is not set
> @@ -6723,14 +6721,10 @@ CONFIG_PSTORE_RAM=y
>  # CONFIG_SYSV_FS is not set
>  # CONFIG_UFS_FS is not set
>  CONFIG_NETWORK_FILESYSTEMS=y
> -CONFIG_NFS_FS=y
>  CONFIG_NFS_V2=y
> -CONFIG_NFS_V3=y
>  CONFIG_NFS_V3_ACL=y
> -CONFIG_NFS_V4=y
>  # CONFIG_NFS_SWAP is not set
>  # CONFIG_NFS_V4_1 is not set
> -CONFIG_ROOT_NFS=y
>  # CONFIG_NFS_USE_LEGACY_DNS is not set
>  CONFIG_NFS_USE_KERNEL_DNS=y
>  # CONFIG_NFSD is not set
> diff --git a/recipes-kernel/linux/files/nfs.cfg b/recipes-kernel/linux/files/nfs.cfg
> new file mode 100644
> index 0000000..23d9357
> --- /dev/null
> +++ b/recipes-kernel/linux/files/nfs.cfg
> @@ -0,0 +1,6 @@
> +CONFIG_NFS_FS=y
> +CONFIG_NFS_V3=y
> +CONFIG_NFS_V4=y
> +CONFIG_ROOT_NFS=y
> +CONFIG_IP_PNP=y
> +CONFIG_IP_PNP_DHCP=y
> diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
> index db0abb6..a07811d 100644
> --- a/recipes-kernel/linux/linux-xenomai.inc
> +++ b/recipes-kernel/linux/linux-xenomai.inc
> @@ -22,5 +22,6 @@ XENOMAI_DEBUG ?= "0"
>  
>  SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
>  SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
> +SRC_URI += "file://nfs.cfg"
>  
>  S = "${WORKDIR}/git"

I assume you checked all configs for being identical before & after, right?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
