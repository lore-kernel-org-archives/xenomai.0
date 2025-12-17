Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514193A1E87
	for <xenomai@lists.linux.dev>; Thu, 18 Dec 2025 01:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766019810; cv=fail; b=EdoO/GqNssW6GkEx1jEzygJBw5I4vrN2Y/dK7XU1S5gCVE7dnEjktIq32UX7vc8JtQTOdzjsIsrsv/b2bsi5Zlk2FLClFvJk0SNwd8WN0L2IBhk7YDV0pzUB9vXeSeckCE5IF3ze2NyAOIX5to0roiPqz8eL4zEYrCOPzO9TEyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766019810; c=relaxed/simple;
	bh=IxHGwu2QOPa0KNjL2um6X2tRkmAYANrilwMIsycbcAM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uau9r3I0radQnf6eTGJP51XgqSI99JgF7h70VXEGQPtxzqbR9LBU9vCZm5sBF9cw9CT/rr5FdEEg/v6xRsX6IXF4brXhqj4mZCKefhH9a93Cfmob7W8yrOy2bKC/wM10WA4kJmamV7wDRwsc+Zyx+6vfcBL3gwH+HMEvaAQgZJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XflQCHC/; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XflQCHC/"
Received: from VI1PR10MB3184.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12f::14)
 by DB9PR10MB5860.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:397::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 18:30:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJgH61/BxeI4GcWehKug9yIFEeMrp1mCPw5A7wIYXjGI7OZbXWTNfajj03MA9ltsm2HA0OMkNFnTe6rzRCQRu9HLdtJKAisAGVTdem1b+Rjk6rFKHYgYDx0QJLWaPaOqKQEzUBBPG7OFbvh8KNFjYO8efuZOBzas3vP3x5sRdTG3JRACWLkkQVpqCyUWhVSn089KGq0X/ZVn7sOoaq0h9FZ6rC1sp/hxErGJ1m9Nuf4ETkRksBsfuM+zouia1FDlcjV1SopPkZJ7sFwsMDWssdNeEVQNYKJumKUYW/DrHqpIcdsSRyGuD+zB0yB19b6rlcWFl3eQcVd4f3F2Yb9F0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaMoH1Nfn2K2bAUYgUBQ5KNo8tCePwPPiuQqqolgX1M=;
 b=fFL2BxRQuy+igWdqLP/vV1WA4Dlqh1mcktr++/rIRpDpOW1q9w2Wrn1YfTx3hSK+04C26GFAVBFKA0bywpWFxEAaUoAhLmkkSKZujmiLPO6ZgYCoNA9eTrs/UPceCMQ3HNeC+Z0+bSwglzO5hzjkmgFMlSUdVa1b/34o91YWO5iGgkuwraMHXV1JVD8rkG0IRJeOK1sY7t8zkxBULsD3/yUn/PRZeYdNUk6K8SDzQllfwIv10xhjWEd31w62Kpuc6L8IPy43XNnRU2yTyvzo2zNv+kJRK8jGMFATdXLsPvYBtGfVXLtT4TOenjTaYVVaxRXFvBp5Vtx4EqeWif+QVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaMoH1Nfn2K2bAUYgUBQ5KNo8tCePwPPiuQqqolgX1M=;
 b=XflQCHC/EbFzMfshoXSsnuls5V+sabN8x2BrOEuFveb2EoMp/XsW3JafPL36YYGKJgewOMbiTWTcNPIVTm9TZE1c34dYhCZcSOgIySKToinKvR0J4+VCSkrifONrXeT12BIL4ISZ4I+bWWzImWfgzgqmMHu6zv8mLf8C/jzfkmb+RLva3I2kCjkjxQCm7SUNG/kD4K1BXV5LhfATg0dsBUvhSFRjuhUC4F7zN1D8yn3AlxcyiBH518jRnsHCl2xSjICOaaeZ6PdMQaLQwKbcm7RQUjyfVufDg3IyN8JS7cKJvS21kizWQUCrEVglCNShwtgvgt+mQz9gBkD8B4tMgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3184.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 12:31:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 12:31:57 +0000
Message-ID: <e9573efd-0e55-43fe-a341-da42acf06bf8@siemens.com>
Date: Wed, 17 Dec 2025 13:31:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: rt_task_resume() resumes a wrong task
To: Mauro S <mau.salvi@yahoo.com>
Cc: xenomai@lists.linux.dev
References: <144fcdcd-0944-4971-80fb-80ee7e72cb83.ref@yahoo.com>
 <144fcdcd-0944-4971-80fb-80ee7e72cb83@yahoo.com>
 <348b1bfc-8f0b-4e97-a100-999928f67ab5@siemens.com>
 <172ca47c-acb1-45cc-8e2c-3282c17354f5@yahoo.com>
 <90450dcc-6293-4835-8f75-788090a867ba@siemens.com>
 <348cb4d0-b82a-49e0-881d-fe75ee134964@yahoo.com>
 <d2569de3-405f-4305-a05a-be104160d1a8@yahoo.com>
 <75ab33ce-0a98-4154-add6-9e8fa989b4eb@siemens.com>
 <651094df-88c8-4998-b389-28a6086704e9@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <651094df-88c8-4998-b389-28a6086704e9@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
 AS4PR10MB6181:EE_|VI1PR10MB3184:EE_|DB9PR10MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e19f39-70ec-4aab-42d1-08de3d6844f3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RCt0dVJYdEhIZUdMakJnVFNVbzBHbGhLQkVLYTBSeklVNG9pbUZJMEdqMkcz?=
 =?utf-8?B?Q2RsM0VoaTdtZitESGdpQllHSHZKVmJ5bEJIcGVKRkdkbnRTSmRGdmJTQkF6?=
 =?utf-8?B?WG41MEJ3WWNtMndTZGJ5cjIyeHZ1Um5YSlJvem95VWFOUFdsdTJXYWNzblJQ?=
 =?utf-8?B?NzcremZZaDRORDFWVGNoNEp6RmFscWVyeGFpNUlxUmFpM1NUenNrM3gzSjAz?=
 =?utf-8?B?M0FqZnM4SndIOXlWMGNPbGphalp2YVJyejBtdko5TDVLUDVsSDhxeC9PUmpv?=
 =?utf-8?B?Zmh0UjI2N3QwY2NaMjRmaUs2UWI1a3FscXlpR2NKdnVYaUdkd3R4VnZ2cXNB?=
 =?utf-8?B?L1VONktveEkwd3A4ZzBKamlPL3JiRTkxM1JMVWhRL0FkQ2dsQkRGVTlFM3FS?=
 =?utf-8?B?SGZianc2MENSSURKejVkRmQyaFpiNThOdE92bWpOdDA5V1NkOHppd1hxQkVk?=
 =?utf-8?B?ZkZnV0Z0RE5JanRva3duQVZJT2M0U05lWUQ4aFBSQjBmVjhMOFNKTjBMNEZU?=
 =?utf-8?B?anZOem1ZQU5SYWRIYXNqUzZKZWNEVitodjQ0UXR1WTJ5NlJVc3lVaE9BS2NN?=
 =?utf-8?B?MVFYQVpTZndaVnhRUVg3WVl5S3VMSUtNZGhIS3VjM0NDZUtKNmhuT0Z6OXI3?=
 =?utf-8?B?Y2hkZjZWb0hSbENsdi9TTlRTaGtWZzArUG50bWZlRURXcDN6bE5aQXdTMVBF?=
 =?utf-8?B?Z01sQ3J3Zjk3SnZGeGIyMGJvZTNUWXFHSEMwL3ZCVVAxdklhV0dJQXcwb0tB?=
 =?utf-8?B?R1VVT1BKb1IxWktEWTMyOWdMaVVqWlg4YlF2U3BNL0srdzIyNHdlL1hZc245?=
 =?utf-8?B?T05VUGt6VFgrbXdSRTY4Zjd1RGVaR0pXd3ZIdUFNTFhkQ3VQNXFEVXdHVWc5?=
 =?utf-8?B?TEgwb1RDMEtxUURGbUR1ZXV5aEI0MDQrZXREcFNsU3NoSkhKaCtLQnNGL3VN?=
 =?utf-8?B?eEpNTG1ENXhRMmpaekRpY1FaSVZyaGlON3h6R2FUSk13VjVDTWJ2T0tZcE1U?=
 =?utf-8?B?a0p1OGtvcVdQakJYVkZ1bXdtU1ZtT2F0S24rV0dTdlRmdTE3NFFjNGJ5Ris0?=
 =?utf-8?B?NTBCbkFhTnJNWWJyZThVL1YyT0lqQy8rcGhrbWV0TytPdXc5L0tSYzBNem9W?=
 =?utf-8?B?UlArYnpjS0tQd1d5UzIwTFNHYVF3dEUxVWxzd3E3MURpNFRYajhoeHNwWTBQ?=
 =?utf-8?B?WDltSUUrUm9DT0pkdkVMZXl2eFJLc2ZkMTVZL2NsVjNYa2kxRE5YZ0NBVDA1?=
 =?utf-8?B?ZXhTYUtMak95RjNaRnI4a1RvU0pZMldiWlZzUURKZnlMM2dNUXZPdGQyNHY0?=
 =?utf-8?B?NVljRUR0TGx3SjE4ZFZZSHFXZTF1L1FoMlZRMkY1WGpEWW53SXdzeVAxSXNl?=
 =?utf-8?B?SmJjU3NYMk94UWYrUFFEWDlSNXdmZk55ZGRYdjViT1hpMzZNMnQ5Tm1rUGV0?=
 =?utf-8?B?RmdiSnZOeWUyS3V1MEZ2b2xMN2ZlWGY4SWlDNnVoY0dlK3BqaXZpNWRlZ2FO?=
 =?utf-8?B?TFV2K1RXTzhSTW03UDdjZGt4czdUZUlyWDRkRVdIam9Yd1k0blNmMEdsZXEx?=
 =?utf-8?B?dU1vS0ZEcWdzQnZZZjI1cXlKZ1BlZzNTQVhIZ2ZSTm1XMFZpMDJnRHZBeGx4?=
 =?utf-8?B?VG9uc3JMaS9RR0JiYnR1TWdJNkZFS0ppa2l3MEFVRE5EbytJcnpOcXdnY1ZU?=
 =?utf-8?B?OHZTYUhhNSt5Ymw0RmRQNGF5b2ZidkFrZUVKTTVNNXJheE03elpXV0dCa0Ry?=
 =?utf-8?B?THMrVnlpbVhOaXZlZFZwam9UeXJUdWNGK3pVcUNyLzRpNUxhb3pza2dVcmMr?=
 =?utf-8?B?bGlFUWMwemRtQnVzUHJGSkMzcWw5SDU1ZHd6Y3dvZElROWdMUUcvc1ovN1ZK?=
 =?utf-8?B?SWNTUHoyT0ZrRlE2M285d1RuS3lGWTRGbmlWcjVOSXBoclBqSjBnK1crZlp0?=
 =?utf-8?Q?oT3uIHcY+v1/apmLHKYwlw73i3yBuw+m?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SUlBeWpqcWZsMERIUk5ZQndnLzl0U2tXNnhUNjFCMUtBMURBZmhtMFRaWFk2?=
 =?utf-8?B?V1pHNUJ2bTB5bUNUWXJvVHRwdGQxbjAveStWT29GQmwxdmZIWUtranpkQkN1?=
 =?utf-8?B?U2Fzc2JFeHZ6SG9OSGsyU2hYdDl6WnZFYjVDMmVGc090RnFIKzJyaHFheFBT?=
 =?utf-8?B?N1BtQlcxVyt2NG5rVGFGNktPWGNPTnlGUUNZZ2R1ZDZHVXlHOG1VN1hpL1lV?=
 =?utf-8?B?dDhxRUNnRkhidTg2UzZZc2JEcGVXWm5FUStwRktFNjBMaGFMN3VTTjhRenZW?=
 =?utf-8?B?ZlFXT0pZVExKZk1BdEE2VXZrSEROQXpFM3BITU95US9qRkhTeDl2MS8xWTVm?=
 =?utf-8?B?MjMycjRZZzNhcC8yS3RCMjRpTFYzcFZpRGJFalBHVEd3ZDRpMTVBci8wcFBo?=
 =?utf-8?B?clNza1FqUG1zTEUwNmlqcWZBa2hrR3BsWFg3V3lBNzBOYnpnTmhLdlE4Zk4z?=
 =?utf-8?B?M3k5Sk9INDN3T092NzhpbzRVcm1JT1hVa3JyOXZaamd4MEhJOHc0RkkrU1Q5?=
 =?utf-8?B?V0pkd0VYYkczZUNIZDlSOGxrZFppdUY4aXArNUFOL1hlLzRGTnd0ZkJHcklm?=
 =?utf-8?B?K2F2QmpQWkVSQ3pxbFcrOURyVHE4ZXZXNmcvZXdZU3l5WWlYU1l1VW1MajZi?=
 =?utf-8?B?ZFJ1bm10UFVEMit4VTBLMXJVWmE3TDFOZ1BneFdTSlE3emRzQ0M1MFhib3F2?=
 =?utf-8?B?bXFYdUZNYkk1RzBhNTZvTDZCazVXd3VQL0FUMjdDWG5HMjdOL08reXZ2RHBI?=
 =?utf-8?B?czkxNWlQNUZhRlZMVWFDU0dDQmpYSHhrUmRpQ1RvWTJOVXhQZHA4WDRoSXFW?=
 =?utf-8?B?a1RHcUtRczNra09zMHJvZ0tzTmMrWk41WDB5eVdPRGdrRnlZcUNlK2NucFY4?=
 =?utf-8?B?QVlvNDN2QmlIODRxSWhTV0k0ZWlUUVMyMWRjd2daVGh3SWdKOGYvc0Q5SGl5?=
 =?utf-8?B?aE5wQTlRc1NLcGJVUTBSOXpZWTZPQWtsb04raGhvTW1JT2NZL3ZmYmxDTklh?=
 =?utf-8?B?OWVmQXU2RkU3eEtWUHYxTm9nMkF2ejBqZU1wVTlXdGpSdFBrbCszNnlIU3lX?=
 =?utf-8?B?VnJGaTVuN2RaSy9uYzFJb1Rub2V5OU9uUlkvcG8vK3A5RjlRUC8wbEZwL1M2?=
 =?utf-8?B?bTJBSUhzSEpET2JKcElVMnc4QktMeVRmTXBIcU1iWUtVWmpmUndPbEFaVVlo?=
 =?utf-8?B?amQvdExRNThTd1BCWkNoMDk5SWd6OXUrcnR6TnR2bmRIaVBmMHpsM0UydmFF?=
 =?utf-8?B?NkR6b0xDOVlIMHh3bE42MUpNeWRHYUtxZ3pXbDlYaFlqZ3RwNGN0UFVYaFRj?=
 =?utf-8?B?NGF6TEVmR3hFUXR0M0MrdzJJZUdFTXJMNk5VcGR0akRrTEhLSGltaFVGWG5C?=
 =?utf-8?B?dTdZaFArSm1VV2VpeFFRY0JxQ1FoWm1lMUx6cHZ4SFZHd2FGRjBaU055TktV?=
 =?utf-8?B?QmxZTzB2VVVxejVjS0ExbWRtRXlwaWQyRU1VSU5oM1lmT3FoUGtSSngyUkVa?=
 =?utf-8?B?OGpYTVI3TW1WQ01YRzFTV1prdnJQMmd2d3Y1YnVIZXBJMWEwSndGZUhqVE00?=
 =?utf-8?B?TkszZHVOVi9hYW9RekE0Y3M1MG81T0VubGpTZWNGUW9HY3ZOVmJHODZ1SWx0?=
 =?utf-8?B?L2p5VTJjMXdRL3ZjQ2tNcUF1K2JHY3Roa3IzQUQvSmsvT29mekYvNzFaaUNI?=
 =?utf-8?B?enpXd1BUMDVtSDVrdllqRWtMcTJUSVpjMHBUbU55MkQxY3d4SUNwYS83c0Z2?=
 =?utf-8?B?ZU5ZZloya21jM0RLaHlHUUk0SVk5bVo0a0JTRE5JdzlaVVhZZXUydlN6NkhS?=
 =?utf-8?B?YmxaU1NQQVp2b25zYjFNRG5YZFNtQ29iMlB5OHRDaktyYjlydGNwSXFjbm4z?=
 =?utf-8?B?SFpqQmdVdnNpVGwrS2xEcXVBVkNxZ1NwTjdOMFlFb1luKzFaMDRuR09mWkRJ?=
 =?utf-8?B?bVRLNFNtTXFncFRiVk5OZ2VhQ3gramFxMVZ3N1oySzcwSmlCcEk3ckhTa0U4?=
 =?utf-8?B?Vnk0bzI1VDd6SEE0ZmdJMFdrUSszbjRTNmNQLzNvN0IvaXBleVFBU0g5Q3NN?=
 =?utf-8?B?R2RoblMva0YySjBZbG5vQ1ZNejkycVVqOWlkWTJIT2s4dHhYTXhVb3luSEdi?=
 =?utf-8?B?UTMwTnEzeWJEamFveUNSa0c3aDZ1ZjRrby9JdHI2bzZaY2JDazZiODV3d1dV?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e19f39-70ec-4aab-42d1-08de3d6844f3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 12:31:57.7224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZhm0rvKykVGCBCiM9FZHPXjIMITp6t7KhryD/240esu/XtQIyjFd6NdV226EBsKhlyMKu233godOOvcnxADAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3184
X-OriginatorOrg: siemens.com

On 17.12.25 09:42, Mauro S wrote:
> On 12/17/25 07:59, Jan Kiszka wrote:
>> On 02.12.25 09:56, Mauro S wrote:
>>>
>>>
>>> On 11/26/25 12:50, Mauro S wrote:
>>>> On 11/25/25 17:51, Jan Kiszka wrote:
>>>>> On 25.11.25 16:10, Mauro S wrote:
>>>>>>
>>>>>>
>>>>>> On 11/25/25 15:33, Jan Kiszka wrote:
>>>>>>> On 25.11.25 13:23, Mauro S wrote:
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> Not sure if I found an obscure corner case or I'm doing something
>>>>>>>> nasty.
>>>>>>>>
>>>>>>>> I'm using Xenomai 3.2.8 on an Intel Atom system with Linux 5.4.299.
>>>>>>>> Target image and toolchain generated by Yocto.
>>>>>>>>
>>>>>>>> Please find attached test case code.
>>>>>>>> Program is very simple: the main task starts a bunch of joinable
>>>>>>>> tasks
>>>>>>>> that immediately suspend theirselves. After starting tasks, the
>>>>>>>> main
>>>>>>>> task resumes all tasks. They do a small sleep and then terminates.
>>>>>>>> Terminated tasks are joined by another task, that was launched
>>>>>>>> at the
>>>>>>>> beginning of the program execution.
>>>>>>>> Subsequently, main task continues to recreate, restart and resume
>>>>>>>> joined
>>>>>>>> tasks, on and on, until a CTRL+C is issued.
>>>>>>>>
>>>>>>>> What I observe is that, when calling rt_task_resume(), the wrong
>>>>>>>> task is
>>>>>>>> resumed.
>>>>>>>> Please see the attached log. In this log I'm printing the .handle
>>>>>>>> and .thread data in RT_TASK function as hexadecimal.
>>>>>>>> At row 19 you can see that Task1 (that has .handle value fc1c9,
>>>>>>>> the same
>>>>>>>> of the terminated but not yet joined task 0) has been resumed when
>>>>>>>> the
>>>>>>>> rt_task_resume() was called on Task0. Task0 has been terminated its
>>>>>>>> execution, but has NOT been joined yet: if I'm not wrong its
>>>>>>>> resources
>>>>>>>> should not be usable until join is done (at least this is what I
>>>>>>>> understand by documentation). I expect that calling
>>>>>>>> rt_task_resume() on
>>>>>>>> a terminated-but-not-yet-joined joinable task should return an
>>>>>>>> error,
>>>>>>>> not resume another task. Am I wrong?
>>>>>>>>
>>>>>>>> I know that is some of a stressful test: in fact if I call the
>>>>>>>> rt_task_resume() only if task is not terminated (checking also the
>>>>>>>> executed flag adding "&& TaskList[i].executed == 0" into the if)
>>>>>>>> the
>>>>>>>> problem obviously does not happen, but as I said I expect an error
>>>>>>>> instead of a wrong resume.
>>>>>>>>
>>>>>>>> Launching the attached code, you should be able to reproduce the
>>>>>>>> problem
>>>>>>>> on your side. When the test detects a wrong resume, program
>>>>>>>> terminates
>>>>>>>> automatically.
>>>>>>>>
>>>>>>>
>>>>>>> Can you rule out data races on the shared TaskList structure? Seems
>>>>>>> both
>>>>>>> your sub-tasks and the main one are accessing it, and that possibly
>>>>>>> concurrently and/or unordered. Or does this also trigger in a
>>>>>>> uni-core
>>>>>>> setup?
>>>>>>>
>>>>>>> Jan
>>>>>>>
>>>>>>
>>>>>> Hi Jan,
>>>>>>
>>>>>> attached the modified code: each access to a TaskList element is now
>>>>>> protected with a semaphore (one semaphore each element).
>>>>>> Strange behavior happens anyway.
>>>>>>
>>>>>
>>>>> ...would have been too easy. Ok, will try the other day if I can
>>>>> reproduce and maybe even understand.
>>>>>
>>>>
>>>> Hi Jan,
>>>>
>>>> sorry, I should me more verbose in my response.
>>>> First of all: no pressure, take your time.
>>>>
>>>> Then, a more deep explanation.
>>>> I added semaphores to avoid possible concurrent access on TaskList
>>>> elements, but I already verified that code should access them in an
>>>> ordered way without concurrency, thanks to "joined", "started" and
>>>> "exited" flags.
>>>> In detail, TaskList elements are accessed:
>>>>
>>>> - by main task
>>>>     - under task creation, writing task handler and "joined" flag: this
>>>> happens only if task was joined before
>>>>     - to resume task, reading some elements ("started", "joined" and
>>>> task handler) and writing "resumed" flag before resuming the task.
>>>> Here, "started" must be 1 and "joined" must be 0, this can happen only
>>>> after task creation and start
>>>>
>>>> - by sub-tasks ourselves: during their execution. Variables written:
>>>> "started" (at the beginning of the task) and "exited" (just before
>>>> termination, after task is resumed and did its sleep). Also, verifies
>>>> "resumed" flag when got resumed, to check if resume request was for it
>>>>
>>>> - by join task: this happens only if task is "started", "exited" and
>>>> not "joined". This can happen only after a complete subtask execution
>>>> task resets all flags and sets "joined" to 1
>>>>
>>>> Printf sequence seems to confirm that execution order is OK.
>>>>
>>>>
>>>>> If you would like to understand a bit more already, you could catch an
>>>>> event trace (trace-cmd record -e "cobalt*" -e "sched*" -e
>>>>> "signal*") and
>>>>> study the task interaction (trace-cmd report / kernelshark).
>>>>>
>>>>
>>>> I'll do the setup to trace events (I don't have trace-cmd on target, I
>>>> need to setup a qemu image with it).
>>>>
>>>> Thanks in advance, regards
>>>>
>>>> Mauro
>>>>
>>>>> Jan
>>>>>
>>>>
>>> Hi Jan,
>>>
>>> I made a sequential version of the test application: instead of having a
>>> join task, join call was done by the main task, one subtask at time.
>>> With this code, tasks does not access concurrently to variables.
>>> Problem happens also with this code.
>>>
>>
>> Starting to look into this:
>>
> 
> Great, thank you!
> 
>>> STARTED TASK Task0 (82a9eab0-829636c0)
>>> TASK Task0 RUNNING (self: 82a9eab0-829636c0  ext: 82a9eab0-829636c0)
>>> STARTED TASK Task1 (82a9e2b0-829526c0)
>>> TASK Task1 RUNNING (self: 82a9e2b0-829526c0  ext: 82a9e2b0-829526c0)
>>> RESUMING TASK Task0 (82a9eab0-829636c0)
>>> RESUMED TASK Task0 (self: 82a9eab0-829636c0  ext: 82a9eab0-829636c0)
>>> RESUMING TASK Task1 (82a9e2b0-829526c0)
>>> RESUMED TASK Task1 (self: 82a9e2b0-829526c0  ext: 82a9e2b0-829526c0)
>>> TASK Task1 EXITED (self: 82a9e2b0-829526c0  ext: 82a9e2b0-829526c0)
>>> TASK Task0 EXITED (self: 82a9eab0-829636c0  ext: 82a9eab0-829636c0)
>>> JOINED TASK Task1 (82a9e2b0-829526c0)
>>> STARTED TASK Task1 (82a9eab0-829526c0)
>>> TASK Task1 RUNNING (self: 82a9eab0-829526c0  ext: 82a9eab0-829526c0)
>>
>> So far so good.
>>
>>> RESUMING TASK Task0 (82a9eab0-829636c0)
>>
>> And here you are resuming a task that is in waiting-to-be-joined state,
>> right? That is an application bug, but one may expect it to be either
>> ignored, only affect that Task0 negatively, or even throwing an error
>> back to the caller.
>>
> 
> Yes, exactly: task is ended yet, then should be joined and not resumed,
> but I would expect that the resume command was ignored and/or an error
> was returned.
> 
>>> RESUMED TASK Task1 (self: 82a9eab0-829526c0  ext: 82a9eab0-829526c0)
>>> ERROR: RESUMED TASK Task1 (self: 82a9eab0-829526c0  ext:
>>> 82a9eab0-829526c0) HAS NOT BEEN ASKED TO RESUME
>>
>> Instead, we see that spurious wakeup of task1. Let me debug into this...
>>
> 
> Thumbs up!

Ok, here is the catch: The task handle that was used for task0 is freed,
even before someone joined that task. And task1 handle was freed as well
before you call CreateAndStartFn(1) again. Now your task1 will get the
handle of previous task0, and when you try to use that stale handle for
resuming task0, alchemy looks up the new task1 instead - and resumes that.

I looked a bit into whether we could delay the handle deregistration
after the joining, but that would be a hairy operation, likely also
affecting libcopperplate. Given all that, I think we are safer off
living with this "specialty", rather than risking instability in the
cleanup path to handle the application error a bit nicer.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
