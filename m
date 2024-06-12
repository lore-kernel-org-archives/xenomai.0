Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2063.outbound.protection.outlook.com [40.107.6.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C6FA93B
	for <xenomai@lists.linux.dev>; Wed, 12 Jun 2024 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718188886; cv=fail; b=nX06XmsfZbNZcZMVdOnPiZdjBVp7uNV92n6fvnv7wMIVqgNtsxBBwe5kcMVBEChzYBgG9+DKTWSFKy5Jz1JQwWHTEDUhiCKWa8o9Z7bHxdJ/KxJTRp4quNO4YVrIKZjjrDPAP0+rbWQETAUQ5i8JMahj7wr4le/xTvHodBtg4JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718188886; c=relaxed/simple;
	bh=zjX7k6kgnI+2gQAp1/JDSleHY844zKXKbOWOxlAI0T0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UOtvjtzUg0GlLf+bUzm+J0zAIZHV+qbnye60akxND3qHBCiZ3t8lqZ8v7RoWRJwD1gH3O9F9sTOJpb8uI7/Q+6Qq+IlLBpZa1lHwBgYYwT9/nvTQZMui7pMsdxaJUvPXMre1XsHvpmelog90+c9cGI4S8D+dMEzc+rbNas2Y8xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JpMdXm+V; arc=fail smtp.client-ip=40.107.6.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JpMdXm+V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLYjxYP13SGtFLtgTTr8t8GyAl/15LePRes0FEw87FaUwpChPSLtJ+14ejop05KTSaXO/Q9gNWQShNU7TQhWsktjkodx62F02Y4UG9cBbRsyUF5CCn79xiXIF0iwqSsignW04t1rj9ZK85aMvf2ivkNzVPVx2hS8IhYpi9AEtMAWeaT8SS8RGkwKdvYZXTZyh4/YK6TbY1sKiEmFtVkEfCt2+3706h+zcBloa3tKS9oXYWU8zAzU1WSwSiFDXf8QK7Oc+J4E6EnYfKMKOenu9Rp8EgR8AkHV3mfihkdMIdPY1mnvxj6H7tG/EFuAzWYtzmVwUIAe4rY9e2unQhsn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R98D1ymfabrNallLC3mzU5gYMYk2Agjz1KicAoZPdWM=;
 b=cGPO3+psmny15ic1Q2NBOMlJROrAl9wATX7Vwq/4pAutai4thmMmDe5xQPL6wvSlExxSltYYJKiwW3zyOBGnq/sSv78BHEsHALMgY0lrY82tllCh6M890BucTcxq/wAZXLxvS7tkCIlfp0sFLjaD+5WmPtFNxjVgQLEu2I2sUVXCsOBtDLW/yAPxLmEMGa3BtKqlsc3ew9mdjT+LTRnP3g+/uOVhflxQfl97hZIfFaNmXPTIwGYquQ6dkFRVmGv5zopn2QR40lZGIyHROvFn3ZuogbwwAjT6mY6pbFCEZYf2GMBN8H5GM5BDVHpwLFhMWj3QDoe9TZWzBcT6Q92EuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R98D1ymfabrNallLC3mzU5gYMYk2Agjz1KicAoZPdWM=;
 b=JpMdXm+VdakHIUaymgmY37BSolE6P3Ovo0gTsgz1Ni6MB9SsuScza/76TC+FKWizs6g3MYJkoH+sDQtSaS+P3lq650bW5+/dAbeFnWl3ztCbygXjbTXX6CoHwp4XkLQy2X1S4jTusaUxZTL8odjTA1tBiqpRoYUdRWERjuZT4D/9mdHKzlXBNNG/Mtu3qpQ1PnIeeXP+3tKY/Yo0cXLjEiWF8PUS5IwUqnSLLN6XTzdit7zFUuzXksF9K92/B0zW60tKSJTTu41qT6+glokEEnroy0gc2F3wyLertWYZso6paLC3qEd97aillFSqXNkp2BqMMOLKUU4DMpbul0O18Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6846.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 10:41:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 10:41:18 +0000
Message-ID: <eb43f35c-dc27-4f10-98ec-c9c4971c0043@siemens.com>
Date: Wed, 12 Jun 2024 12:41:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Reminder: Xenomai community call on Wednesday, Jun 12, 2024, UTC
 7:00 AM
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D3E2C96C4F21DAEBE4F2212@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499C4BB71E159B3AB98D686F2332@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482613E8A9D78229EA71D07F2EC2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB74993A52AA247D08069980E4F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499EF7C4A0FD89D089B63A1F2C02@PH7PR11MB7499.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <PH7PR11MB7499EF7C4A0FD89D089B63A1F2C02@PH7PR11MB7499.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 3755f334-20b8-40ef-503b-08dc8acc315f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|1800799016|366008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWlGaFVvbitJTkZXOHdCWGl5L25zQUJVdHFpeUwvTDlrTEsyOW92NU5iQWZz?=
 =?utf-8?B?MXhoUFdVNm5pWkZPNXpsakwwYjJZdHl6Z3VrS0xXN1dLWVFvcW5XUUUwdVZu?=
 =?utf-8?B?MFZrOTdZZElQYmVpWDN0MzMreCtjVXJVVWl3dVVicGZyZG9WZ1Y1L3hvQzA5?=
 =?utf-8?B?T2k5SEJzRFU2TWtRM1I0L0kySHdXRlRodmYzQ2I2K1lYWXZ3Y0p0TjRoc2hQ?=
 =?utf-8?B?SmFORWVWQVVzTDBJYjVUUmhCR2ZndHJ3QmNtNnpSTWgyUVBjcEQ1Uy8rUU91?=
 =?utf-8?B?L2lleEFyUzRCNk1KMlh5Q0doaXVFYzRWWnQ4ZnphanRlV1F4MmhWaU80UHEw?=
 =?utf-8?B?dlYwNktVWDJNV2oyV0pnKzg2VDFFT0VZRFBSUmhwMU1EK2sveHdMRVl0Qk9y?=
 =?utf-8?B?VXJDaDZsdU16eTkvZkFvUmdhVmN2OEFEUDdaUERWU2taVWQxTGFxT0gzOHdV?=
 =?utf-8?B?N2Nidjk0WVd5R3VqcWNUYkZveEllRjNvaEpNRUZwaHlTdFpaREN1ZVBneDlz?=
 =?utf-8?B?U1VJUy9DZlNmTFBndmNmRFFJdGpEa05WM2c5SUJmU1doMnRSMHBQOUJVRVJk?=
 =?utf-8?B?WFIrN09vWlBuYk5GbU5tcUlVN3NiMUlPUUZNNXVhRWorK2tQWU1SSU1xMm83?=
 =?utf-8?B?ZUdTOUdkUHByeGR6NmNsWEd3ZDBCNE40aTYrQUswTS9jdTBUY1Eya3lGMzgr?=
 =?utf-8?B?YWNiMDBmTm41Wmd5N0ZGS1NybW9JdmZWYWh6MU5URWtlNm5hSHc5dm5EMXJ6?=
 =?utf-8?B?NFR1U0FZdVluSWI3UFRrU0xseVJqOTErbm5NK3hkQ1JLUEhjR0o0MEtFUWE1?=
 =?utf-8?B?REtEOXgrLzE2YVhvZ1Z1Z0o3NGVZemc2TkpDU0p4QVhQdDRmTFlLb29ZWFlC?=
 =?utf-8?B?Q2pMYlZBN1crT3VhQXp1K2w3aVRZOWNTZFhIUkozWVp4T2hQWEs4TDF2Rnpw?=
 =?utf-8?B?cXUza0NXQkcwbzVGRmE0UUUyU1RUN1VGUWJLNG51K0lLS1lJUVZGMFpXblFq?=
 =?utf-8?B?Qy90ZytnVU5ITkhFd09KMmxhN0dBVkp6UXBVcGtFZjJkNEZmMXp1OVpZUndK?=
 =?utf-8?B?cDZ6MWw5MzlpZXhSalJmMmlDNTlMN0dnRVdXTkVGT2FYUEdwUHRwaGw1WWM2?=
 =?utf-8?B?eHlXSUV2SVZxSHM3ZUV2VWhuc3ZnTmpHQkNZUUd6Z25nTnk1NkR3TXdOTzhh?=
 =?utf-8?B?M3ZTUFhEd0hQdW9Mdmg5THdrNGlOUFZ0NG1oa095UWNWVzZHSFVKYXg2b1ND?=
 =?utf-8?B?N3JzdUdWVyt0a3JoR1loZG01ODI0NUhEK1Q1TmdDVTlIMEo5NjI5aHdkcUF5?=
 =?utf-8?B?NjZ2bVZ6VXZBR3h1cHdVWVhsRlZUZ0RlRVhFeFZoTzRBUWl5aHVqa1c4M2tX?=
 =?utf-8?B?ZnNWbG8yc0s1UHl1djBFWVROL2lZQ1pHRnlzeVE4ayswVGJzNktqMVMweUUz?=
 =?utf-8?B?bk83bUhHdWZDWkl0VFMyRkpCWWJWcUlJQnVMSUlhbHVIbHNMRytBSmRXbVhl?=
 =?utf-8?B?azN1Y0QzTHdqblhvbUZ5aGRoT1AzdXVEMkJLSWR6bWZDK21BM2lkVlJnaTBH?=
 =?utf-8?B?aVRycHltbUE3elFOaHNEUU03NFNyekhGWWZqK2Fia2VFUXZJSFZ0aGY2YlZD?=
 =?utf-8?B?a213Wk9xZUp6eHJmbG1BM01pK01iS2VJUWhQc3l4NGRJNzF5V0FkWEk1ejZq?=
 =?utf-8?Q?8tBhFLot6EHMJk1ZgejC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230032)(376006)(1800799016)(366008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cC9MbWh1dVZWNWwwZHBpU3d4MkdUVjJtU3hUNmZZR3dYbGtaYzVJZ01pWHh1?=
 =?utf-8?B?NjFmeERCU0RUUUZ0aWlCZ3FSTXdNTTJqdnhOb1hUY0JVclRvWGdYUDZ0SHMv?=
 =?utf-8?B?Y1gySjg0N0E0UVd3SVZ5T0hUeWl4SHJ1WGkxSjJseUNudmdsVEoyS0lWSjdU?=
 =?utf-8?B?R0xxM3hydFp3UkVMd09VZU9JbVpTekQ5Tk90S04wbUo3L3BqYjRKVlN4VUY1?=
 =?utf-8?B?a0tiQU5LZXhhcjFzZ1RTYlZUMkRkVGdpbk9tdWhVTkluT1R6akdKZU9OMVdo?=
 =?utf-8?B?eXc5L3FKSDZBdWNXMURiYU5aSS9qcklQalkrQnJwaFlTS2dFLzFKSFQzVVRr?=
 =?utf-8?B?WTQrMnVNdzZqazRlNU9EN0hHbkgxVXhQSFRXVXJCL0tzSUF4Y3Zpb1d5SmlC?=
 =?utf-8?B?emZxMXI4cUlDM21wdzVhNVJMRi9uYXM1cEtyNnhMWDlsVWRQSFF1R3dBdTRE?=
 =?utf-8?B?ZXBKUjIwS2NTRGdiUzBQYUZKVTRZQk5tc09hWkxmbjdIcVY2SCsxbVhGalkr?=
 =?utf-8?B?dDU3dFNrNDN4REtTUnVuRWpabUkvSnovTWppMGZmbUZDZnNaZG9CMUE2MllN?=
 =?utf-8?B?Nk9OMFYrYXNEd1FiM0JGT1hCUXYxSnZDdDQyT25keEhiM3JJZW5QeDE2ckpG?=
 =?utf-8?B?Qjk2U2dlR3c1WE1ZM2lDVEE2b0JPdWVyYUNja2xwQzJSUnp1TjdOV3FFVXF4?=
 =?utf-8?B?aE5uOXg0SjdPYitrbXc4LzZKd0pydVFSNHVWSmc4YXVPWmg0S3pkaWtEelYv?=
 =?utf-8?B?enB1bmFVV00rTzdiVkVLbjNrMlZGUU1ybk9oVE9meEhGclNaV3M3aWFMdHB0?=
 =?utf-8?B?N3QraythOWFYM1R3WEFQdzhLTm9yUDl0bEQvQVU5OHgxWFRDeHFaenNNR2c1?=
 =?utf-8?B?WGx1bG1iUmc4UWk0U2xzMlZ2KzdYTU5mNmNadG1jZzY3b0FyUHBIeEZFMmdU?=
 =?utf-8?B?UnJQaW1lQ3NkdDIrbFB4SFJUNzdvanlzOXFqNDltQlNlcFd5U0ExQTF2YjlM?=
 =?utf-8?B?NDA4WnJEYmx0bFQvdmpNdmtTRUdQZFErNTBXWDRaNlY5dGxmWFlQLzRYK3Vl?=
 =?utf-8?B?V0d6QWR5VnpGRkE3MzB1Y1lnd3IxRElVem9DS1g3QTZCMTVxaHNrNERDSytG?=
 =?utf-8?B?Z1ZrYytxMUVUeGJYU0dPdjJaY3VTUk8yRldUVGxBTndlQmg1eE9Ob0pwZnps?=
 =?utf-8?B?MUpuaFZYNDBENDhEc3Q4YmI4T1hjai9uSGJHYUN5enBlTjlGU3lPSENzVVNy?=
 =?utf-8?B?RlpKRWtVeC9DMUxtWkpnYXgzZUI5NXhHeUJreE9YRkFHMXowSGhXN1gyK29V?=
 =?utf-8?B?Ry9oL0FPQWFJSi9VQm14VkhGY3hOOE42M3JFVzdGQngwbGRlZ3dSdDBQcXd5?=
 =?utf-8?B?UmFiMUx4TzZlam5sZTZZTllteVJDYWRTRkJBM21YeCtvWGZCS3lsWWpLMm9l?=
 =?utf-8?B?aEJ1alROTldZVzFQWW5XOGJ0MEtEaDRFbzFZcTBkQmJQVmxVdTRiMjBaeEtu?=
 =?utf-8?B?emtVNG5kcURoRG5nVUxhREM5UWFMeHU0NkJRZTVrUExxQXExNGFPOHF6UE1x?=
 =?utf-8?B?QTdsNVZPT1RPQzUxQ3Npa1QzQlJKbDhaSkJ3WlhKVEx1cTY5dUlMc3lzazVW?=
 =?utf-8?B?UHFXR2x4R2tNTEpEREpQK2VuMU5YUDhLSGJrcmtkeGJtLzJZbGFCUEhQUHhl?=
 =?utf-8?B?azgvSXVtMUJuek0yaWg3UGllUnB5NEFhYnlBZ1A5RW5pRTFqSVpjdFV6bCtE?=
 =?utf-8?B?SHB2c1dSTjJLaktVLytkQ21wakNMMzcwQzJSVVJmMmFBMENTTXlhNUtIUE12?=
 =?utf-8?B?U1p1Yzh6cW1xWkhoa2x4YUw3SkNzSHo2Z2Q1ZnorWmhtaHUrZWROVXhBekZM?=
 =?utf-8?B?UGVRM0I5NUV1U1VwRzVjNnlxL3laNldGMWhOanh3VlVQSmdJTGpwS0gxYWFJ?=
 =?utf-8?B?dGphbHRXdDhoZ3ZXVHhobm9HOW9PYmxCSFhjQlpva2lxaHg2cFgrVW1ML0Fj?=
 =?utf-8?B?UldXR2FMemM0N1owYXRKNm02Y2kwV2RDMURxZkxkaWdoSkQ1SlBpTDZFTk1M?=
 =?utf-8?B?MzBJZUppbHFWcXE4VlNEUWNvMEhJbi8zUW1tNFFtMnpQUjI5enp6OUVFSVRr?=
 =?utf-8?Q?BkurwtUtrOQOyenP8EX5Uxl/E?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3755f334-20b8-40ef-503b-08dc8acc315f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 10:41:18.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iheGNoQ91zYoTR7fL1IEIdG/6GB8Ynb8yZ8OWFnHmCuVS6+534koU0q+y5U3Ulxt7HbBL2Dbxwn02ATcVuZyQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6846

On 12.06.24 05:00, Chen, Hongzhan wrote:
> Topics may include but are not limited to upstream/downstream project 
> plans, status updates, and technical discussions. It's an open online 
> meeting that anyone can join and ask questions.
> 
> Time:
> Wednesday, Jun 12, 2024, UTC 7:00 AM
> Paris, France CEST 9:00 AM
> China CST 3:00 PM
> 
> Join Zoom Meeting 
> https://intel.zoom.us/j/91297279269?pwd=WmdwS0pDODRNMS9tQk54Y1dvbFlqUT09
> Or
> https://intel.zoom.us/wc/join/91297279269?wpk=wcpk52a9f96d989e7e20b628c2c36e48b68e
> 
> Meeting ID: 912 9727 9269
> Passcode: 367528
> 

Oh, hope you didn't wait for me (too long), but I thought I said last
time that I was blocked today.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

