Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671C41C07C4
	for <xenomai@lists.linux.dev>; Tue, 24 Jun 2025 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750758410; cv=fail; b=lToCiPeyadUnAxuvWIoWNQP+2OjDwMI8Il8csOrKBiAbCCnWVnTpZK1jyQfTi6WeOHD2Ioc9ASus96M8n7OacfGstyvrNH6ifJpMAJFx6ekbriT6Bizne4VO3ZDi2KKa43CFzy/y2zEML1+jSoA7oSZXIYA6qQjbzaIYvvOsfNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750758410; c=relaxed/simple;
	bh=sx2W5trWiaY5PWpQpl0BVJbw0z1peAQwYc7KT1VedLE=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QcaFuqV3tEeosAvUh7vfBdrGy8aX8azsCOL9MYuGqyrFVX+ZYHdr7aodMo6OtN9L0IKfOLy4Ze/Ey/D8soNeLUQls2JTZPqG9JVSkthK0YTLcUPxmmT3anVNnMlot0VTWP/09y0vRbk6L4MncMWey1f9be/+gjDurcVQbsDrVck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Iwsi3l5i; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Iwsi3l5i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7ZWM+88PDQCMLH74aOUAPP2q+sCRFo1cITGI2acNTlZmNWth/1zehEaZ4pP9APNtQpF6RWVXXslM0aDGOltErPWAgT1ITtn0mkHecuAQ2xvfvZK984l5gXGAUsP+GBzM1GEOAPHw1DBJC0ToW0mcAU9Mujd4E2UdHRrO0dXXXEs3yqAQAAduIhUVYYpfwSvxu6FqBsogeyAa7vhkaQ17Cdwsn70MBksFtsdCavfCSgqQvOwmdRH0MlEsF/Zx67Fy0oOxe2Z2MizvdoB59ylm+OvpvJtDQb3/+kPNfQrV94180rq3kRVVI/KJSBaDy9iAq5MLOvzJUeoVHp04dYJog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yv5UZLB9rhZCNbhV6Ax8D08/TXcWV90PT6BRyV5Cfsg=;
 b=FlaKFNUucQ3wQ8w+sjcpp0Q2zijkLSq0Wwajo/0gdJl1nbT3zH6n+J2cOx6YWfvcTWnsAxOc3mu2kOID28sFJIqmMt6k/i02Jhus/BKYtdjlVACg/wMfs8rHEWZFhrGiQLWVufvc1NutWT+QuKiVpcl2wUhIjxLLHORpxIrmsWCd/7eqCHfjg4wP8Bh0BYd26BKJ65YRyffg1eXZsZSiBXLA+MWBvDguEV3ICRyNiWcNgZpnTu4/s9oAXpcD/gQLAZD9Bm5kk8bS6LNrWR3VTSEcOMcYB28Yhhd6ODjFRqvI7fGZj5Ol6O/5MlmkuCkVB+16R1mVmHaGe4D89tqyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yv5UZLB9rhZCNbhV6Ax8D08/TXcWV90PT6BRyV5Cfsg=;
 b=Iwsi3l5iNV7s8km28d5OITjQ9P7SVXZpOXJX4hxMreyRqmzOJHGyFM1DabeGw7MKko1rkomCDEODbgqx3VkFG0oPLzC6q/DU2E2rYfKjzvsx6G73FazT8QDAYNtE3H+FRdy8glnTs+F9VXwBP8ePOCHK0GzUEOeVIS+SkY6zDvdjNwMVsZ1TgYLZqDfZRTMGK8QfZhjnUcp6TbJ4dQIWEJJ3pR1iI3dErqTkC+/XREXDJjRGQyOz+gzcc6fQ3IGGTmVh9ZNYOM3R72Ws+YUFr00qiGxE90MLZpV0l0wEFiLKPnU+dcmjqHgkNssOnQ/8SJB5ONMupMgbbQ474GmRuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 09:46:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 09:46:44 +0000
Message-ID: <b734099b-3e87-475b-b51b-21b914b0ddbe@siemens.com>
Date: Tue, 24 Jun 2025 11:46:43 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [NEW URL] Xenomai community call on Wednesday, June 25, 2025, UTC
 7:30 AM
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499D816A0B79C85EF7CD712F2D62@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499161719AD2EC0D1651C48F2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482106CBDA92B4A595D7363F2AA2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB7499B238FF2BECBDD784752AF2B82@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D39A66B3EC8E9431E6F28E2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499BDD1032C1C09D4107EE7F29C2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E15D2AD5555818A6E5C4F2462@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993258CAA8CDDA598B287DF2542@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E32BB1968236810DF6B3F25A2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993347DB8F72364025EFEBF2282@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E7C229D3943554AE31B6F23E2@PH7PR11MB7499.namprd11.prod.outlook.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <PH7PR11MB7499E7C229D3943554AE31B6F23E2@PH7PR11MB7499.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: f4fc19d9-4a38-4a92-0805-08ddb304075d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0tLSno1MXZWNU9ZVnJuN20vZUxaM3RvYWlNRnBqVUdaUlBWanc4RzM3SnNR?=
 =?utf-8?B?cEdxRlpHSXNLc29aVXlkVFl4a3lXUTRZM3dFQWVSVHRIbGcyRURZVG82RWx0?=
 =?utf-8?B?aHBqM2ZCanJBWitiRlJwbFhnUWlmSEtwSDFQLzNGeWJQOU80SnBhVEIyZTZ5?=
 =?utf-8?B?Q0lZWFRtanhpZklaVkZua2NPYVc4aEVXVDZVWWowcnVKdm1QKzBpajVHeW1u?=
 =?utf-8?B?UnJJbW4xRW9LVU5LUXN2eWNpWW0wL0FtcCtsbzcrQ0VBMnNpaG9NRGx0UEJq?=
 =?utf-8?B?S1BMVzZDb1ZMT1RnbW0yUUxMN0tLbUNjZFdmeE42QnVpZnptdUlTdml0a3la?=
 =?utf-8?B?aVlGWDN3dlZFdHJGVnE5bCsxMkduRmdmV01WZWNYK3YrWXZ3SUdEMXhsSWw3?=
 =?utf-8?B?a1BzZG1Demx2ZDA3MkNjUlhUeW96QzVBcVBmeXc5b25EYlN5dWFmV04yNk02?=
 =?utf-8?B?N21sZmthbS9DcUpGNldqcS9TV0lWNjllN1hrY01HRFF1T1ZUWVFnbUMrdkt4?=
 =?utf-8?B?R2xQZExBdGdFcHAxb3FBbGZNMnB1MktHQXphQnFiVU9qbit0b3liRExzUkNa?=
 =?utf-8?B?OXA1aDBuSlRXOHlaMGdZUTc4WU5uVTgzVkVQRTZ5bGhBVlArRGFCblkyWkJT?=
 =?utf-8?B?bm9YRVJWNUZGRlFFRDJMaWt6T1pRK2huRE5tdHhoeWI1MWxtV2QvNWhNdDNx?=
 =?utf-8?B?VlBhaUZ1SW5XWG5NUmxRUkYxcHI3TDg4cGNEM3dHT3MveDFoVzZtWlhvc2Iw?=
 =?utf-8?B?TUZtSUNrOVJzZGhVMVhINVdQMEdGYXV6N05LNlZuSTZ1RTRadmcvOVpHMlA2?=
 =?utf-8?B?SHFWZithcWVuV1puN1BQMy85ZG9MZjZyTWJHVjRoOFIxaElON3Fyamwwd0or?=
 =?utf-8?B?VFBEUDZjOUhEdlNBcmhvcjVMTnpMU1pTU1pnQnR3MVBQajZHNDFiZ2dkT25L?=
 =?utf-8?B?QnhRMnZHMEkxUVQrdFFuSW9EbU9wM2o3ZWhvT0RNaHdFeWJUWlZQZXg0VDVl?=
 =?utf-8?B?SUxjZmh0ZEM0Z0xqRnZRQitlMGViaGpucmx5UWxacFk5WFhsWWlhSGZKZkgw?=
 =?utf-8?B?aGp1b2kzSXlEMFdGV1prTUZBc09EMFhZeFRDbTJIMXJEMVpKaEZNNU44aGNn?=
 =?utf-8?B?NkpZUitWT2Z2R1VHT0VIM0lNazlVTE1MVmpXZkpKcWJSRGNEODc1d2FnUnlE?=
 =?utf-8?B?OUxBZko5U0dUZGduYWxFb2t4eWZoaTJ2WCtqQ0FrdVBYTVNzVStQSk9ZSitD?=
 =?utf-8?B?OGZZVm5vL1R3MDRhaTgyTUdDdlBhWGdIaUdMc3FEdzZFaHZOeGVUVnM4bVlj?=
 =?utf-8?B?T2RsQkttazZRa1lGVDk2TDZJYXRYVE9JL2tDV21YL2RhU3AzYVpmWXo5SzJF?=
 =?utf-8?B?MllhSVVaM1QwdWdJY3h3WXNac2tha1V6SnR5MlBTZXJWNkhneXRQQ0NXY0l2?=
 =?utf-8?B?VlhocVZjWU4ybUhJQmFnUWZaUkhrL0lTSU56UWViS1JOYzJsSVdIU0M0Q3p4?=
 =?utf-8?B?RmpDRER4aENxeG1UdGJRYU5BZ1d5VktsS2Zyem5FU1psLzZGMHRTbHJDTDV4?=
 =?utf-8?B?eVZnaEJlMlBFUnlZdFgyeXdtZndUTWZJOHdJTUdCZTQ5L09scEp6NkV4T1hQ?=
 =?utf-8?B?SjBVR1htczJ0YlRhVW5oeGZhaTF6OFJZMUc2N0xvajlKUHVDQUordTh5Sm1U?=
 =?utf-8?B?YUxSU2p3TVFYNitYWFB1THJxemVzclVCWkdkYjUvWTFIczRIbmRTdFVMS0hG?=
 =?utf-8?B?dFNURnNTMmNTbmswTXMzZlBQWFZObnRPYzBRbC9pcHJSNUFtN3lPWXJUNHZQ?=
 =?utf-8?B?bzV1em1IVktCSEVlcHhTWm1Fc3lHTnRnL0dyT1lQNFdJakhweURjSlFjUkxY?=
 =?utf-8?B?NzdFK0FJaW83ZzlTd0I3V0lMenBsOGdYRU9Bd3JWV1UxWTBseUMwaFRFZWFM?=
 =?utf-8?Q?nGF9Lu+RskM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REhYQlZ5SzRMdWlPbGUzNHlvZ3dpYVRhSjBMOGxPVWwvcDlLY0FPSHlNd3VG?=
 =?utf-8?B?S3V4OGtzTGlvSjB4bGUvd0hheHpYSVVXU3lZN3gwanU1UEJaVENwbVRONXhi?=
 =?utf-8?B?aW5mOW10WVQwcEcvendoZWVPR3Vnc2s4S1VYc2Jrdmx1NHNKbTJRWXFSTTl1?=
 =?utf-8?B?TDVmaWkwVThrcFNleldaNVBSQVNJcVd5bWtWa25hS1cvODYybkJQc0w0NDlq?=
 =?utf-8?B?WFFXZWZab1FMSmx4K0trQXJZSU9iQXl4b09tZnd0YWo3Y2wvNlQrb2ZSSnpP?=
 =?utf-8?B?V1l2bDdacFdSRUNKQTY4RDZwbzFDNVNpZ0NzYmVZY2RrRHRYNWRmSit3OHoy?=
 =?utf-8?B?V3I3WGRsd3hBMDN1ZFRINUtTYlExMTVOajRzQXFCM0Y1WTRLbkNraDdpYlA4?=
 =?utf-8?B?RDh6SmRYNVhiRTVCUmxzMVZEcUQ2UFFESm5yQ25xbUI1N1ZiQ2FjWURsQVNa?=
 =?utf-8?B?Mkc3bXJUVFgxWk5KbFZ5NWpnR1FCT2NTRWw5YVZleWNOTjQ5RVN4YzZONURr?=
 =?utf-8?B?Q2FwMHppN2V6SzBOd2trdm5LOVllU0FPbjFISyt3RXYwWnRJU0ZFc2RKWGdS?=
 =?utf-8?B?cmgzV2txOGNuVWtFbG40b3J2eGpLRmo1STB2cHBvZWppUWZaK0VZbjNHTjBX?=
 =?utf-8?B?ZkJRd3NuUXpQYWF5NTNUZjZ2cWlodi9rVHFuWFVVa3kxRnFDeitXVHpvYnhj?=
 =?utf-8?B?MUprM3ZHaExQMldZenV2NUhmWTZ2Z1BJLzQ3SGROSG9uSEQzdjR2UnFFZUUx?=
 =?utf-8?B?UGZ2MFNyV3ZYWHNZc2Z4eU9yVWgvWi9pN3FTYnR1bUQrQ2Z2NFhmOUVWU3Bh?=
 =?utf-8?B?ejB5aHBiUDBnRVF4QmEvQkx0M0FWQXY1TUQ2a3FmWU9vMTYyeEF0TnY0aXdl?=
 =?utf-8?B?NEJxSUdWSHUzcmUvdDhyTW80YVV2Mjdad3lxOVk4VmtFSzRxODQ3TjIrSGhw?=
 =?utf-8?B?V0IyRXRYVnhEajFGUUd1MVZ1SmF2K0orSERZeUpPR0xPOTUyZFc5b2srZVdx?=
 =?utf-8?B?K09IS1NQN1J3Tnk5eVVmdEVVUFd2L0hKdmlZakpKbm1RZFlpTGovSGpKN28z?=
 =?utf-8?B?RGY1TmFkQ2RsRVhmSm94SnlwdGUwYU4vYkttYW4rQ3JJSWVrc1NubjJiazR4?=
 =?utf-8?B?c0tLRGhFMVZRNzlKRktKOHdsbkN3UEk4V1NXOUNDbkhuNk4rb2x2a1ZpV2hL?=
 =?utf-8?B?cGtIeHVRQ1lPNUdBUmVlUnhxV0FiK1cwUW80T3dhZUcydmNFWUZzamxaK21m?=
 =?utf-8?B?ZXBSTEdwR3ovbmM2ei9RMVNLV0FySVUvSlRZYjRGUmExMGdQZnJ1MDFuUncw?=
 =?utf-8?B?blcvMjJ6OGg2MzJicFhralVyaU1XcmFHcHAvNm1oWmw4ZDRYSGJsK1pDWE1u?=
 =?utf-8?B?OXRxeHdrYW5PdW13cEN2aGU3enJCWm9hU25kaHVzb1hpSC9uRUJCN0tqbHJM?=
 =?utf-8?B?MFZzUkZZMkZZajRjYnZrdkZJbGcvNVJuY2o3NWZpTElZdXFhd0tEQXRsUzRW?=
 =?utf-8?B?SjRwckI0cUhvclpnWlVNVUpOTGtBUko3SWZ1QVI2UXcyc2JoM1RMQkJmMUVt?=
 =?utf-8?B?VEtweHVoME9ZMERNbHZuaVNkVy9vVlg3Q3BzTVJpUGhqb2sxSzBNQ3FPT2hu?=
 =?utf-8?B?bkM0bnIza3JvcTkxSGxRcFlHQ0dLVWljdVpIeXpMelZ4eU1iODNCRnRHays5?=
 =?utf-8?B?dkNOY3ZCR09Vc29EZmlkUVkwcEJhbE1ZY0xKTWU0SjlUL1o0ZUFWN3lSSHl1?=
 =?utf-8?B?bDE0cFVSVnlkOXkxbzhoVE5EOXFVcjlxNmQ1RmhlR3Y5ckt4SEVVMlFsZXln?=
 =?utf-8?B?eGlraXlNTmt6bnRZbHoxb3RqQlJ5WTc5VEVRdlZ3NHVjVDB5NHdnanhRWXV6?=
 =?utf-8?B?bC9xY3pUaGZ5N0lTK0FnV2s4LzBweit4YktHTnNRSkFNRWxGQnluTWlwOFJY?=
 =?utf-8?B?RWtNV1BDd0FXaGUwOHZWVHgzOW1aYWxJM3NxK0diYjBXWGM4Nkg5aXpveEI2?=
 =?utf-8?B?NkEwblVlVFJOUlZjYk96c3VuVkxKQjErNlh2c1pBdi9DT0xFRnJpVlNCL1pQ?=
 =?utf-8?B?ZkxRa2RCU1lIaStGdk5OR1R3MlBIdHArOXZYSHpBV2x4NmpNTmtrcHNOUytV?=
 =?utf-8?Q?/7Ja7wbIsfZ7wQjI3iEfZDBiD?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fc19d9-4a38-4a92-0805-08ddb304075d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 09:46:44.3811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuIjISPpyUMpacKsr3sLG8vcJ0lfodukLWetR2OVdaX3uXZkVsUr6H4DTiqG3za/K7sKIihl/mAZOSG2JU+JCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8140

Topics may include but are not limited to upstream/downstream project 
plans, status updates, and technical discussions. It's an open online 
meeting that anyone can join and ask questions (you may have to wait for 
the organizer to let you in).

Time:
Wednesday, June 25, 2025, UTC 7:30 AM
Paris, France CEST 9:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Please note that Hongzhan will unfortunately no longer be able to host 
the Zoom call. We will therefore try via Teams tomorrow but can discuss 
alternatives as needed.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
