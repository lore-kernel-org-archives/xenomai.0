Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F59C383A2
	for <xenomai@lists.linux.dev>; Thu, 27 Mar 2025 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743055889; cv=fail; b=UBTY+9GulHsOynG+IYTKXfPPg4V6b6w11reaoR+RA16VfvZj4yGdcfd9RSZKFRKdHCejP6B0OVVTjYhib/yumxUAH3w5q9qjAodXlbBvuTtDSYCalRwLY9uthyknX6OfzGnooWpIOn9YVAYSFjR+Vp3iN744dJoIyQjCGCjoYmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743055889; c=relaxed/simple;
	bh=PToj/FPHflEtDmf4C7UQlp8Bbzi/MSgHr4v7X8SBD/k=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k/SKYCU6WGUzySpEgi+vB41u/qlDDgOjztUGIeeufB4IsjggDNVHp7v9VZbkvNTQmsj2bRu7qDM4GeZwhGJGNMrsyehD9BtrE+hoe/TPb9hP9IokYqSWX0xYKwkEDDfwY1Kwrymz8j4wYu764xrDmifxnaNwLkbAskoMqLJccOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KhIpW7PV; arc=fail smtp.client-ip=40.107.241.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KhIpW7PV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNIPNY7eiuU1YFYUg4X65BkMcARkEN/c77vn+dpGFs+m6wQfvUidIyTQJtOnIxAaitFZ1is8rSpCsGz4dHaQ7s8G3nUPRuT1UeWOPGUkJQiFCjH7Wval3eq34sQ09qziULuAPeasufVPQb6URmVycVK/HwhzGEhZq4DvtySo11X1ehBijW2l/ZoBPcxPmmiQ0LOFIvYlziJEDZngzLz/Vg8hrG0kSE9Q1/8tmukoO2R4d6Exw2Sq6HgIRvjUAvClNUuxRMP9prMw6VsAjgl+S7JPSHUKsWGdZMjTpzvW9oNQoqvm6MbtoyAtYe+qFH1866HVH6hMCP36Eil3wnCTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ds8hyxtT4eqffFymBKX1P0J6+7beBL1smzTUAsQw4Ho=;
 b=a/8361e3pxRWT+ex2S/Z8BODYyH8qvWO93Jd9KxGwT+/Baa6fw6KynrIit0/hpJ08h6ilGEjSrlje3sCq7n59xKP0PC3D/L7oT4enqPiO+xMFvl76xJw1e/+qzKCUQQh4P9CdWvCzTCgkyOeG8aJ1T3rVQq+igBjiLZ5X4YKPM/BlWRkIrBeurMnVMg9ZElyqfbRWPHEmotcQ3zWVKoDYZfMMsCWMqaEhdnP+6RxcT5harbCIA6SVYYTp6bJcUnJGCnCIgqUfk12vOB8jMAYAz+zwucgOOSsgW3K3dkEqOG5YtGipXEP/oPCbIwS01MIENTtkmwYZMNvYKqVn5IYXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ds8hyxtT4eqffFymBKX1P0J6+7beBL1smzTUAsQw4Ho=;
 b=KhIpW7PVo/cGT95uJJxl7wyN/wXBTP1lIgMYo3sR7GLy1GggCGVGvcwBA0jJbzU93YJBq3dfMAAYdcyXbQdtilEF2QVsPfJAwEobxJM8D53kdPJT73eQlVAElO5TRk4cJqhqfBx6UZsFsF4tmU2WalB2h0XNyWuIXox/ho1xpBCl9o+g0cmezMI1AGN1LYFP8KPX+S3GjIYln0hlPnh4ZWAhiwMf7qLOLQVQ5TyaQq72jepGOBaVkFf0qvO8YDB1fZ6T8tdqjpDbPNzvZ7mU9QkVhrJO9KtOjCc9EbhQ22q+BCKOceH7IBTn3Ue0dce+rl3SPjqfOGXGAPWZnfKCtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:239::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 06:11:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 06:11:24 +0000
Message-ID: <582f231a-3e17-4b4a-804e-7f43ebda3c48@siemens.com>
Date: Thu, 27 Mar 2025 07:11:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai 3 and Linux Dovetail Compatibility Table
To: Yann Le Chevoir <yann.lechevoir@cae.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <DB9PR09MB60325FCC7AEFE1880D9698EF81A62@DB9PR09MB6032.eurprd09.prod.outlook.com>
 <DB9PR09MB6032B14E3FA653EB1FD4BDEC81A62@DB9PR09MB6032.eurprd09.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <DB9PR09MB6032B14E3FA653EB1FD4BDEC81A62@DB9PR09MB6032.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c37ff5-883b-4da3-a1cb-08dd6cf63391
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXFyaitpS2dKNWFzWDRwMFpsbUlKbkx3a05vc0ZrMDdIMS9zMWhqMlVLT0Iz?=
 =?utf-8?B?SFp6L29sVmx0a3VFOG9HTVZTVjJxSXFnT2luVnFsZGU2NEU5TCtYeDFLYUta?=
 =?utf-8?B?UG1qcEdCVTV3OEVqTllmb3h0M0hDbVRzRDJZSWpqN3ZKdkZ3aXU3eDg2Y0NN?=
 =?utf-8?B?RU5kajNFTWJzRXZXWGQ3Z3lYT3NtUzdiY1pkYTliMTQ2emxMZkdqVyt1d1Fp?=
 =?utf-8?B?WDlsaEpVQXhLVWZFT0lYTXM1eGJOaWlzSUNOMDRWSnJVZXRBRjc3di9iaDJm?=
 =?utf-8?B?L0p6OVNKV2NuMFBHdUVPcEpNOWNVaEp2cndTa2F4TkhLREIvdmJuRTd5WElU?=
 =?utf-8?B?ZzlxdUk0RmFNQldXc2t5SDBhbUpDLytOOFhLenNJSXFGWWlQRSt0YkdOdUw0?=
 =?utf-8?B?YWlhT1dLQkNheXBJQVZPNm5qZzF2b1JDQWw1RHdkYmJxZEV3ZHlZa25TWEkw?=
 =?utf-8?B?MnpQeENqT0dsYzNJRkN3NFBBZGNBc0lrekNoUDF2eXJJNGFtek81MVhac0F6?=
 =?utf-8?B?bjErZlg4MmxrUlhYN0xjY1ZCSmxvdXdVZjZUak1LTENlckRyaUhlcVIzZnJj?=
 =?utf-8?B?Nk5VVmtwNlhZSVdHek9CUkNrT0x1RmNwNmwvUUp4Q3JWMHN0eGVOZDZUUVkw?=
 =?utf-8?B?L3dJamQweENiNytUVTJjM0RMNWlGLzFmMnUwSHJVWEJpbk9ZQ0pYcGdjVWpv?=
 =?utf-8?B?WEo5cWNaYjZOY1R3U3VuUmZUTW5MVEo4blE2Nmk3VDJWclVlazEyamRoQWxs?=
 =?utf-8?B?TmlQUkNrOFVzcmRWRk5sbFkxRjhHeWNuUm5OeHNua2JFRlVoSk4xWGY2TzZ1?=
 =?utf-8?B?WThNY0duUFBBWk40UHNJbWtPVkxUbnUzclhMSitmaHhqcEtNQnp3bmpPUk85?=
 =?utf-8?B?TG16N1ZzN20xT1V3QnBYNnNveklLMVJVSjJPa0RlM2p2MzdCaDlVTmhvNlE2?=
 =?utf-8?B?V2pjOWpnY3JRMWg1Y3MrT3lLR0FnUjVSVVpST04vTHllRXMyeWRJaE1Rb3Vn?=
 =?utf-8?B?T2dwZlBsT1pGL2RoOGlkOFhQb0pBTldaQlpWaURueFJzZ2N5RERnWjJzVFlK?=
 =?utf-8?B?Nm95ckhPb0p3cGozcnhnYXZEZFVCZDBVWGZsR3ZuSDhpTjNtWEd5ZGtGM044?=
 =?utf-8?B?ZDFKNWkwdmNsbmMrWWZvVUxBSjZPU0UyK3hpenBlQXJTeW1YYTNJR2pqVWlL?=
 =?utf-8?B?emZtdWRnOHk2Q1B4blMxTFZ4Ym1nS3pZcWhCOGxCMFRoNHRSRk1IR3RGZlJG?=
 =?utf-8?B?emlkcnUxUmF1TlVnZG43bmFEUmFENndRNnhkTWJRcy90U3h5UXQyMk5KNkd0?=
 =?utf-8?B?ZmxmTThBR1pMc2lpNUlYamR4Y2NWOCtxM20rVUk1SkN1RDR4TWhHUlgzeXB3?=
 =?utf-8?B?ZkdqOUhlTmVsSmhIdUVaQkF3eGNYVDZJWUNYSDR3TjM5YVpuRDZveDFoQ25V?=
 =?utf-8?B?a080SWt1U244VmloQzFQYmRKSGhhOW1lSVg0MnBzRVlzUk51bTlFWEFFSm8z?=
 =?utf-8?B?Sng2N01hRmEwMG05TlBYaFh4MDg2dnhqeDlrb2NHY2Q2L3N1bkV1R0xkS2NV?=
 =?utf-8?B?OTNnelBaMUU3SHMreVdHTGFMZFNaa2VtZmloZ0JnZWgwdytuOGV4LzFwZXh3?=
 =?utf-8?B?WjFqcjIrNlhEVEtBNGp4ZWtLL2ZEWC9MZHVESm9pTkVqMVh6OHRWQU9EMkVO?=
 =?utf-8?B?TUFoVVhKWFVLY0k3bzV3OVZpQWkrY09ORjBwZkVZNGhFaGJORUk2REUvRHFr?=
 =?utf-8?B?UUlHam9FS3RrVHBHSUlsYmZHRWRabVIxNDVTbSttN2xNMXd0M2xFVGw4cVp1?=
 =?utf-8?B?MEFNRGRZc0UycHcxOEhtUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0g5UFRGVEpaU255TjBWTlFIbTdybUZTOWc0aEN4eDk3Zjl5SmxLTElVaHNX?=
 =?utf-8?B?NWFpVWVVeFd3R0dqeXBTaHBJei9MNTk2MEwxaXUyRC81SDRyRHNTTnRVckFM?=
 =?utf-8?B?YWk4dE1mdmhSdDdwOGtPc2JhRXQ1USttK0lTTDJOV00zeUpXSlpYWmd2ck5Y?=
 =?utf-8?B?cUI4VzhEbW8yR0syc3dXekNLQnVadFIyVUdSanZDS3R5UTR1Qm9IQU5ORzFk?=
 =?utf-8?B?Y0FYMk14VmN4UFJLQXVMbTgvenZSUzg2WXl0VG9abDdrL1pNS2laekZYV3Qr?=
 =?utf-8?B?ckVxZ1ZaQ2E2T2lOR0o3N2VnWWNDdEZBV0ZOQTVyRTM4cDk4SGRrdFROdmlR?=
 =?utf-8?B?a1gxSG5Eek05em9YQ0xkWmlxTXJRcFR4ZC81NWhDMnhYN0Y1b0p2blROQ0NS?=
 =?utf-8?B?QXJ6NTZESlJXdHMwM1FxT3hkOFdKY3orbWhtZXZncUlQOUEzVzlQOHhHU0lj?=
 =?utf-8?B?V0dsNzU1VGVJT3ZIbGNyVVhGS08yL2FuNCt1djlZdnhlQXlFMEdXOUE1RCtC?=
 =?utf-8?B?cW42d1h5VzhKancrejJ3cHJyM2RSR1MwMU82Tm1jRGg0S1JCSWRDZFlVWFV6?=
 =?utf-8?B?Ynd5Y3FGeFZJTFJPaUdybW5mRThnb091NTNITWRnYUVhaTk2N1MvQzUzdHZx?=
 =?utf-8?B?Q25rYjZ1NENqaGxDUUJ6ckdyeGVOQjBDR2tsOWlSN1RqMWhvR1JOM1JwUFFy?=
 =?utf-8?B?YnE5NDJTTlVrTUhKUDBIaEhrZjF0dndjdG4ydWZPNGt4S2MzcWc0WkhId3dJ?=
 =?utf-8?B?RmI0TXE1SGtwcXNraUlpV0o1MFJ5Y1d5WllJRlRkUG5zYk9TQUpkbk1XTGM3?=
 =?utf-8?B?S3pUNXdicmZsU25hRCtBcmoxRkk1bWQzYWhicTVTVUlEQ3pzUmNQTFhLSDd3?=
 =?utf-8?B?QjZZM3l4TGo0a3FmTUR1T1RvSFhLdTVFN25kMEZDeUYvRGVvU3pCRTVCR0NT?=
 =?utf-8?B?NVRJTkF6SzlEMFdHWnpONHAwNWR3VWs5TVlYdXhHOUdtWm9NNjNQVGozVUxG?=
 =?utf-8?B?TzZFMlZlNXgzT0hjNW5UQ0N0ak5RM1hSZlpXTGZWcFlxQjVMN0NXUzhmS1R0?=
 =?utf-8?B?dGZMNWJpaGRFY3dXcmF3NTNMN0JOTFg3MmtXQ053cWlZK2hyeEU1NVFDdUJQ?=
 =?utf-8?B?RnhyZGFDM3RrYnpXQ0xTK294alNVaytBNzU1VHpBRjFPTHVheFgySWlic2ly?=
 =?utf-8?B?KytKWUEwV2ZjSzBPWGkyV215eHZBRThBSis2MFNSNHBXeWRzSUhueU92SlFB?=
 =?utf-8?B?aDgxaFZVRFBjS1pSdFF1b0g2ZWxIUS9xbnBONFBFb0VHTW1XZmhiKzI3ZCtG?=
 =?utf-8?B?NjhFcUJRdjdveDZydHdGQzNDRWRaODZSUXdUSm1xU2hwLzd0L2FCaU9rRi9P?=
 =?utf-8?B?eXIwTkxTL3owM2Z3cHdkZ3VxVmNtUmtzUWtpdC9VWVpPZkszbVlJd095Nkd6?=
 =?utf-8?B?WGc1WXM4a0RCRC9XU3gxTVNKSE93K09JTytiWHFhQTllcFhLeVNpQjJiVGI4?=
 =?utf-8?B?ZFhBR0FHK2t2QS9yaUk0U3ZRakJPd04xWTU1alpZQXE1TURTRFVEcDl5L2VF?=
 =?utf-8?B?bDA2M3hud2pkQ3lrcm9xNWRpSjlhVjZmWVd1UkpCQlBpbWFZcFhuNE9KQkJa?=
 =?utf-8?B?azlBS0padUpFQUl2Z2Z2dmlBV3B1VzFlWkl3aHA3VHFCY2ZtQVVDWmxFQm44?=
 =?utf-8?B?V2dLWHpqVEpTdkRINGt0TnhyVTZnWUlnaUkweVpXY0d1UU5hYlBuTU4zejBF?=
 =?utf-8?B?VjZkMkgveWdSdTNNS0NtRVk1elNDN0xtNFJIL0NFd1lpOVp2by9NN29Mdm4y?=
 =?utf-8?B?N2lUc3NoUXBQdXZERUpnakRXNldBZ2tkK3AwUWdDcFI0clFzM2piYkxQdUgz?=
 =?utf-8?B?cHN6OFBBNiszd3F3cDNRV0hWK25NU0VuRTZkNnNXa081VXhSVGkzdTF1dVJz?=
 =?utf-8?B?KzMvdHZtM1dFeEZMVTdzMGR3cFY4eWh5ZkJ2MzU2dTBiZDY5WWF1ZWo0RFVQ?=
 =?utf-8?B?ZjFTT3JMUDBRWVpGYkNUVGlVM1VBNkYweUpkdkoxSDZsc2tmMHRyUlgzMUdR?=
 =?utf-8?B?d2YxQUE0ZFd3d1JIYWdZVVYrckVnZ3lvOEFONUExbDJPc1c1MkR0MndObG9V?=
 =?utf-8?Q?G0Rg/Wq/x0jhSqL28bbtkMXgp?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c37ff5-883b-4da3-a1cb-08dd6cf63391
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 06:11:24.0565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcnqXNdItCNYfLzTWBCm68QDvTCfR4uYGOxKBT9avyFj8N42uRCVH/aPe/9ONz3oJoiCOxn+df10v4rR9CdsoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8524

On 26.03.25 21:47, Yann Le Chevoir wrote:
> Hello everyone,
> 
> We previously discussed when I installed Xenomai 3.0.9 on an imx6q with Linux 4.9 + I-Pipe.
> It's working well!
> 
> I am now trying to migrate this work to our imx8 with Linux 6.6.23 + Dovetail + Xenomai 3.2.6 (?).
> I also plan to try Xenomai 4 after becoming familiar with the latest Xenomai 3.
> 
> At first glance, I find it difficult to determine which versions are supposed to work together.
> Did I miss a compatibility table somewhere?
> 

The only table we have are our CI and image configurations, see e.g
https://source.denx.de/Xenomai/xenomai-images.

> After successfully preparing the kernel linux-dovetail-v6.6.23-dovetail2 + Xenomai 3.2.6 (using the tarball associated with the tag),
> I encountered a redefinition issue with DEFINE_SEMAPHORE in rtcan_dev.c, which does not compile,
> along with other compilation issues when fixing this one.

You need 3.3 for kernels > 6.1.

> 
> Should I try Xenomai 3.3? 
> Any other recommendations for this migration?

Unless your hardware (and some unfortunate vendor kernel) puts
constraints on you, always start with latest stable version. That is
3.3, and that is 6.12. 6.6 is no longer maintained as dovetail series.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
