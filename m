Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A87B35297
	for <xenomai@lists.linux.dev>; Fri,  5 Jan 2024 21:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JrupAwU/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0GRypqdtCjC8Edh8ISNoXtO8l0CjEtkS7CDstbHt3HK91krfYaFw85atJeasefuFHBiqZ5H73TZsDKlqVIzLEnA0+Vkc84G8NHJMUWKw9SoCHzWuqeupP3oczdZOnfCeaCtOuYTnR8B5xq5dIxHs/ELuE0WR8n6151n2mVVQf4tbviP/DkzQPdkxFPqQsp900ty9C0JBJ/ggD06yRZVGsECEYDfO3f1fRj2iRdnkRQFSwjXKYP4QySZPP4Px5U/BrX7NhYDjjyc+HJmS7a8d9N6v5CKEwV7om3vR3t1QJhrbQuhLnWkmVMdSqw75NnwKGhgmL/QgniTke1zul7itA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lcg/eLMDVjd5nXKD3A+0LOpTI+bUlTGd6NKuEjvCl28=;
 b=nhmcs0R5miPge8RXuW7tayFmIM2/dB+2zwlGk8xCFLUTWBS3mQ24MAsM31IWr00lF4m1uXLedfaTOyFmcrZOLijva5MT/xzOb0Od8uNWBSNN5aF1ucV65lluR0sGiWhk9zU3utbPxAyQ0+CcjHLaCTjB24wuRDg970USnFBM6kkuMsLnwb9H2yqr9T4VG5t9r3Dl46sAOBtj0RLyURi7/uzzyqv+kB5V5RHj2YDLW3AaB6QKXlnZpErrtxOp0Mk2PGjKNNGVWkmc4Dk2kzz/kY1DFKjpugnCkAY3/vdE5UxIqupIhE4/oPxjF+G62ZVj0Nin2vetd6AYdkGWUbZeZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lcg/eLMDVjd5nXKD3A+0LOpTI+bUlTGd6NKuEjvCl28=;
 b=JrupAwU/pNtZa7SOTxbdO/X0m4jbWRn9DA8DsG37WL7sWho2Sckw+DZNXai87E1oJvcYWa8WLKcYhj7yCnRr7ZiCbKOj5K+1Xv3Qa7NZShgqQzfDKFYHngbtz0v3aBmssxh3yMs5Dreo0gdyVuOhtNviL+ttcyAT/yh7NY3nE9zqTrH0C4mGr88fddtq4uGUXfrF6HjpIjKBEG5y0mdLFbHImMmUt9gYfzyDVg+qdj/jXfuMM7AXCGfn0aL1kenTUFHRIH6ywT9QvErZ1orrh5IHs7frlgm0Vz69uAECAG3gn5GoLUkgTSeet05hkisBavcmxwCoyvRKIftecypAXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5987.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 21:14:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 21:14:26 +0000
Message-ID: <cf01659d-e800-4e97-8246-a4418cf6f4e0@siemens.com>
Date: Fri, 5 Jan 2024 22:14:24 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: xeno-test for libevl?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d6b066-7242-4cca-57d1-08dc0e334c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wf7tyT13566rGm5fpdNCEelPjcZy5hIEwT7CU4m/8csBh8MzRv+VnUwSrYvxbQQAH8mw7JAuYTY4HTCcbrG+jTq4NB8k3RhMZDt+SoaM0ZCFulQCI/+Wf3bnhlkK1amMF16P8rPy8hBlX+u06UFGckq1vYdMyiEnFQY8EkFcBokI9P/RW6iQLHdLSHw4ikt5yZLw5THnxjzKWCGLEcyLOrQ9T+9DVFSNc2f0Xnwdj1KohAix4PVOpf2Vl/DVqQ4T1DOe+KlCRlSW1/c2XEghO9XsVgxrMxM6LxVBaCFosMV2mLrTRJqAVHJVFnFWN8EM/DJJf5T8RcLZYCmn0NZw5D7FiIGa3oASEaiq5LR8gLhT2oYwtBAM9cTcEkBM4qLXp/5WnbirYIXFGNCslTPtyfvQ9VIfrK48ZymHVZXGAANfrUl47lYxJ/XmY7AhpVBqV1fV5mZxR4JK8wHOu9RIy8KTqILydd+M98XcrMskO97Fyxn04nbE3AzLqGOymdVZlk9aKpVuFEec/U8RF2rQR3GJNb2Afs1yL8iky+7XCZGikGlpbQdtjdfU5bm54N8oZZlLh8YlDwm9b3kmvd8ckI1N2jdo/C+d3DkYJRX+aKIaLyMcvrfgeBsMq+1FoH7XfNS6T6kRAYkaKWqkykL4HA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(4744005)(38100700002)(2906002)(3480700007)(6486002)(2616005)(26005)(66946007)(66476007)(66556008)(41300700001)(31696002)(86362001)(31686004)(36756003)(82960400001)(5660300002)(4326008)(316002)(6916009)(6506007)(6512007)(44832011)(83380400001)(478600001)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmE3Q0ZUamxIeG9qaHBIeTZnZVNTSzhDZVJzenZKNUxCS0VIUnoweDhudXB1?=
 =?utf-8?B?WktlcWxXd1BMYzYySWRxV0VSQ0JKQXJ5dWtBaUdEbGsyNkEwbWNaZno2NXcy?=
 =?utf-8?B?c0F5OE9ydkpZL0hXeWRkclhxcHN3K3V2bzdpNkp0dHZycXFEY3p4TVV1RUtO?=
 =?utf-8?B?d1Rqa1oycWo1blRnVXZpckFvU1RnNlFwOWo2RWRhdEZob200YU1qL2ZaUTEz?=
 =?utf-8?B?bUdUQnRXM2dYNWplZkFpZk9YeTArdkNIWFlsV1hFSXZENTZoSnlHeTdVSmtN?=
 =?utf-8?B?enBCZTJCTDRrN3JWVllDVng0UkNlZjNvWVJYSmVxL0ZMUzRkTXlsUmhhNWRs?=
 =?utf-8?B?QUpqa0pYTXRHbUNjUXczaDAwQkVxL0hqdlhSZkEyTngvY0FwRlZzT0VjRXBK?=
 =?utf-8?B?WHRHaHJXcmtLcXdrdWdmejF5eXJIR1FXOE9lVnhsZjdkN3JWektleFQ0SmFN?=
 =?utf-8?B?ODgzVENBaElUS2xTbk5naTJ4R0xjZzZuZHZTS0xncFpiOTVOWHpqZTZTTUF3?=
 =?utf-8?B?SGF5NHUwdzVZeG1xL2dHZCt6Y1gzNkdtTVFnSjlVNHlQMW1CVVNIRkNITUZV?=
 =?utf-8?B?aVcxekpZTWs3YVFYZkhyU1BTYWYvNTRWRVE5YWtyL0xtM1dzYmdibDIycXhp?=
 =?utf-8?B?YTdDNk9pSm84UDNMZlBwQ0E5SVl2anVmZG1CcTBoOGd1Z2t6cGRNMThjSnoz?=
 =?utf-8?B?d3kzNTlTcUpZT0daL1I4c0d5R3c5eUZjMGZzWmN5Y0tsUVpnUnY1dmVNWHcr?=
 =?utf-8?B?R2pzNVVSOEtPVFQ3akNnL244ajlNNmorZGZrZFBUUXg5cnVYUWw4U2Q5eEVH?=
 =?utf-8?B?MlBLOWtyV3pSczFYU3R4QThuYnNESmpUUFozK3UvcjA3Z3VHS2Jua0diTUZq?=
 =?utf-8?B?aXB2ajRaWmxqQmxnUFBRQkxwRHdTdVdBWEg3MkszVjF0RE9vV3o5MkVibVYz?=
 =?utf-8?B?WFVHOCtUQXBxZ28xb0s0ZkdaakVIc0NvbU5zTnJtajlnaVAyTkxrZVl4Z3Bt?=
 =?utf-8?B?VGx0QVY0VWduZXlnbUQ0a3ZkMWt6ZTA5am4wTFh3V3dnWjdtOHN5bjU0dTRw?=
 =?utf-8?B?ODJYVHB4OTFrR3A0dmNFcndBdFBPRDNXTTY2anhmdkIrTS9leU05Mm10alpi?=
 =?utf-8?B?NmM2MkRkb0l2TnJCKzllcEdXUWpiTDRvblJxYm9FSC80NTJFL3dsSEpVUU43?=
 =?utf-8?B?cXRYUjFPbkVSVUtLN0xUM2ZSM2dkNC9GcDZ1U2xPRlYydnc0d2wzS28ySG94?=
 =?utf-8?B?bmdsdHZtVnZQS0ZQc2ZkK3IrVTNvVFpBaHZpeSt2QUxTUnV4SjdOK1B0eHNh?=
 =?utf-8?B?TU1FQk54L0pDRW9uT3VWSmZEcXJ2VXp2cjVEQ2IrazBFSlBuanZnSmlNaW9E?=
 =?utf-8?B?NlR4TlVTMDNwQllRaFBSZEdPYVk1RjN2Wlh6NFB3aHB2RW9iOTFtb3V4ZnV4?=
 =?utf-8?B?SjZyYlNveUJOckZXY3h3NllmMFVRUEJxUTRxOUFiSmtEWXRnQ2JtalpHMnR2?=
 =?utf-8?B?MUlYNEIvQmZaWVRETEY5YjQ4b3JkSjlYeFBZZGdGRXExb2VLZmR5YlAybU9x?=
 =?utf-8?B?T0s5M2l4cWFMaUhhWk5QUGNVdmMwcEt2anpLSUpkT3lqNEg2SDNWK0YyWUV2?=
 =?utf-8?B?R2lLODB1UnRlRys1TzRyK0RtMXR3eVFJMjBlK3pINlRDa091VVNJVUpGSG9t?=
 =?utf-8?B?RkpwZCthcjlpU1VuQUx0aTRaZXJST0ViZ1o2RWN0Wk5ycTAwYy83NnAyNE4v?=
 =?utf-8?B?ZDF3RFJLUDhLZEpyaHp3OEMxeFd3V1VOR0p5V0J2NWdMMkR1T1h6MnYyMkwy?=
 =?utf-8?B?cFNGMlgwL0V6NlB3ckZPOHczNmFrNmZpRFhJK3lDOGZNYjdGa2RIaWRUSkEw?=
 =?utf-8?B?bDhpRDRLWmZoTDNOaGhFSUVMWmNFdmMybFJ6ejdkZE9vLzNSMU54VUNGNTcr?=
 =?utf-8?B?ZGd2R0N4OVgwQ3hQalZnR05wMzhiVlhBVnBWaTVRZHlscWJzcVYxYkJsTHdP?=
 =?utf-8?B?RWhTcjVEa3c5M2R6N1lMb2xqU05EU2tOVldoQldkN3g2bkJsbktBOWYxSXE1?=
 =?utf-8?B?ZUZnR2EzRTBBaWRIcndUSjRHT3h5Rm5mcE9pVk15UEhCT2diVEVsWkptRmFp?=
 =?utf-8?B?Q2lKVVB4WFpia1l0Z0JER25WQ0NEQm1xdnR5TE1GL0xJelVyRlZIanp1b0o1?=
 =?utf-8?B?ZGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d6b066-7242-4cca-57d1-08dc0e334c0e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 21:14:26.2957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+I4kHWfiYg/h8jw0gu3K05Oc8NRESRJ7n5N0E4fYI4U27CvTN9K3yqcj0CCiKWvyjDa/MKAPQ6zymksXk1SOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5987

Hi Philippe,

while trying to hook-up evl with the lava tests, I noticed that libevl
is missing some equivalent to xeno-test. There are the individual pieces
like latmus, hectic, evl test, but no load scripts and no coordinator
for automated testing - or am I missing something?

Jan

-- 
Siemens AG, Technology
Linux Expert Center
