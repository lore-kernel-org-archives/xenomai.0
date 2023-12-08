Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2068.outbound.protection.outlook.com [40.107.247.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBAD1E4A5
	for <xenomai@lists.linux.dev>; Fri,  8 Dec 2023 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="LwbRiMrq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyPc9IVeNvJm4WXoHpA3FxnOqU4rQTNRUVWLdMnbsC3ZumWST+CMdIBc1/2RO6Tj77XjJNiPXXSG+faEo8R5MCtrVNir4heXas+Z//bGOPkIkpgAeafQFIPJ9SSvxXArmXCI9LQTnKza26KNSde0Ozv+TF01pcNz9A9S34Lnzj5HrRcu4FcOVq+zCp5cE6KDSEmsP8fKbxmjFsKKF/iI6L8GVWWh4qd0fgrIaxhRYttl3cdjvpjyLH7RUahgfCwVMz9dWIMZFa4GijMWG6UPaBxO8tf5KaV4qyqfl1ah8DHCorE0s9szqIGsJkx5iovDjkaq7hQn3lqHf9/psDOyug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jt+4LECPWi/CzhthBwkcnBdLY9QwYFM3pgIVLW38vsU=;
 b=c3LKE+Oq+dklEDGn0hXnG377h1h1iMb0m49bcVSpkCismNu4NAumzG0jnqlWaB4C+moejQ/w82OgcPDU2DWE8FLJyJGtFT8zbvqqgfbJ8H4fyKckCYAIzcrHmWOQ/N4o3tj/DKXAz2NQTATkhyBTWHeELpWASyu0ma5FfhdVnzs8d8K8l9Ce+aFPfSDvYINcQTQxcCl7gf7SOY+VsM+r3OYdNmipJ47iV7ayiWS+dH8yTEahUH2JPxHQVwsfZSjR/lD2kW/5dLMVDlTHnzcMJ4cgTwJ9ArC9RJ8Ns8cT7tpHiAj842656W7uZW+MpHejfwFoPqhbruFSaQ00upKHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jt+4LECPWi/CzhthBwkcnBdLY9QwYFM3pgIVLW38vsU=;
 b=LwbRiMrq411KGmJ1Zkyd/NihjysLD/wK84bkRxe0+C/kkYuFPRS6HVK7HBoUFy03NWbFQcUZC9M3EQf+7X5W6P5GwRWtqMofymTdAVp6iOmJChUWfgf172VUtQYRwi3uNBxhsaFWLJnj4llCianJ3uvw4Uy11N3SQlzq/pyE8EQI//ByM39JaxF1DIa+s4503v5Cbq+ZZo1ovG8NIHth90j7ivTAPeCJ0kEsayjVMFILYqP+WIK4QzyyGnBBHObXb8GpE0U1KAqII3VafT46SD9hCJL3RIc4FvhVL6bJDm+QKg+/RLazbZ0WxJTdxpF1/LSPFr/rbfpZd2wLTVwakA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6718.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 15:06:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 15:06:19 +0000
Message-ID: <b58c34bc-57ff-4651-9976-8b25559b3f47@siemens.com>
Date: Fri, 8 Dec 2023 16:06:17 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: dovetail: lock guards break raw->hard spinlock alternatives
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0391.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: bf890ee4-8773-4792-ea3d-08dbf7ff3b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DysZaRsaB1ypVTSGBFvUDZKNMQaGtNk7r3z8F7X7ypN4JqEDUGUy+jfmHAGWpR05W4PUftDGS0NCCkyFP/nSd4qr/TNRYQn7NznMHYSJo6ZHCi55G4M3N6c8oml1Izqr6keikRMjijsNajRnYt0vm9aGtRnNI+YK9TDbS8cAWO8fGR7iRZ0Tx0W12Qv3l40CC336P8W/sMz44CvUggkFt8t/NwwJ1f0Zwh5mPNJP6e8OlghfTCAW4mndMPvXG/HRqCp/TTqf+6LIOzVIjRk0JovCh1+0F4U0PXIkvDn2AisN977LewMlI5vRAbG4Y8CvJKea6MrmxYielVrxd+BVnBTSwfATkSnpy9nrY6srbqH6Z8br4wZQ4LvO/uvNqRNIM/ZwMXaoZGZdxHp+WRgRWh48Z1AT8bF7CMzJJ2SQQvt5pTDj/WBlSWQ46eIyrhHJ9zSv6CXh1GRd/euPvEar6RYgcDklU9QJBTdMDy5ZsnW6K8f+y2isy7wpGaC+G0U4jK+FM4dptgnWzlzNCmtcgtDKRDyl5NpfYrLwF9dJyaxTvKW9CgtOl/JvncJfgbrEZjp2Qa2GLmUf/qKYIQp8MtD5RZiiK2rpjK1ilqqMR2UovSywM98xhJgLAkc/ZYbImZs8k48hGeApBUXjBVG+eQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(4744005)(8676002)(8936002)(5660300002)(31686004)(316002)(44832011)(82960400001)(966005)(31696002)(66556008)(66476007)(110136005)(38100700002)(66946007)(86362001)(6486002)(478600001)(6512007)(41300700001)(36756003)(6506007)(83380400001)(2616005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0VnQTFEbDFaMTFxcHJIQVk4VzFNQmdmRUZDN1kvWEN2djRHN0dUZTA1b3ls?=
 =?utf-8?B?SGNjLytmaXE5bUJRdFMzYzlhWDMyQm41Ukoyd3pCa3FRZUQ5OHFkclRIcDJL?=
 =?utf-8?B?dHc3bGc2NHhJakJtVGtPZERJRUZkR3hGZFo1bkl3NlpnSVdpSXZPYXc1SkVX?=
 =?utf-8?B?ZmliR0g2MmVIMzVSKzhLVGdZVUlUdm9xbHRqeDJvZ3dwUW4vcU5Bcmt2cFNJ?=
 =?utf-8?B?NlBkdklYeGNVbDhlZEZhSnl3ZmlEYjJXQXJSdGdwV3d2aDVVMGZmTjRMUC9t?=
 =?utf-8?B?emwyMm1lRmpRRmFRVER0RllkbDgxajZQVWZQSVMrZXRtaUhockJtckJaaU8z?=
 =?utf-8?B?SlI2dGg4cXFmWmtRWVkrTitHTFhKZForQWZJVEFYTm1CQVI5RnVLY3VXdEpQ?=
 =?utf-8?B?TTFNNmduN0xGOXA4K2M1cmtNSFFJRStXdzJwV05RU0NOU0VsbjNxbllaQ2pP?=
 =?utf-8?B?N1ZPTTdBWDQrZ2NZZ3VrbG1Mell5Vng2Y0hwOFQyMzZ1R0kzRmEzM1pQNHFM?=
 =?utf-8?B?MFhtSU1iTHFvWWozaU0xWmdSdUgxRWJKMnY3M1RJVnNzN2tLV1dXdVlqK3Iy?=
 =?utf-8?B?OTNFcGJoWDMyQmptSGtrZVVJNnJGRnZIL2FUVW42d0hwME9KSkFVRU9JenA5?=
 =?utf-8?B?WEZZV2VKNHhDdk0waUIrOFlVd3RFNjF2Rk5KaVZBODBSTG5EVU1ZemJ5ZWNm?=
 =?utf-8?B?YWJPTG9UMHRydWI2QjRFYlR1aTlXYmNKakVaZEVFbnJ3VHRaNEg1NzZwY0Ev?=
 =?utf-8?B?eSsrQWNaRTI5cCtqS3BlWXlwWmtiOUJhODFaSXVROWFsdUhNQkFFSU10TWFq?=
 =?utf-8?B?ci9veDlkLzY3N2ppQ0NOWHVVdjJpZklmWHcyQ1B3bjZTMlpQMi9TZ0RHWnVn?=
 =?utf-8?B?T0dvU2NrNVFhR0dYNGFiZ0R5WFVRTEc4NUpHY3VlNHRQeDhETFY1RHBXWll1?=
 =?utf-8?B?SnBpY1hKWlFZd2Y5d2dHL2JNRDl3Ri9jbG0zRWlyaGZ2eVFKd1hpNm01MHUr?=
 =?utf-8?B?Z1dZZkVSQ0E4b3RWekVYUXljSXByNzBBNWQzMkxQdXZXNWpnVkIxOHJCbGxN?=
 =?utf-8?B?aG5HU0ZoWVNFeDQ0ZGZiTW5MdGZTWEpYVFlYSTE3NGQvQy93SFZZN3JHU2Ew?=
 =?utf-8?B?VjVibGxzSnNuT1F4bGQyR1p0QzhIZTIxcksyWTB5NU53OUYxSHRuUWhjQmdE?=
 =?utf-8?B?bHdnbnJMWkFETXBVWVhWb1FJa1YyeWp6aFV3ZU02Nm1QM1BYQm83eFRYb2hh?=
 =?utf-8?B?WkJ5RldhV2xOQ21KMWxEQ1pkQ0c5TklDSWlDOHp1QlBqL25ubnBNZDZMK1hR?=
 =?utf-8?B?aUxoTkgyUnJWcFlzU3dLSStmUUVTTm10Y2E4Ym96aFJ6dFpWMnBNQ0wxK1Zp?=
 =?utf-8?B?RVhpZkdoeERqSkRWWExIRE5QQ0xyaHdOK0JDWHBHYTBSMWRwOWxhUDNNRVU5?=
 =?utf-8?B?OCtEREo0c2VzWFdsejBoS0JvQ1RQOVdza1FQaW5ReTIwVjI4b3F2MmJITXdP?=
 =?utf-8?B?Z2I4Y1ZOY25saTNVSGVsU2N6RXpIaGR3aVJybzZ2V1poMEJHdXdTdXdFejRp?=
 =?utf-8?B?UDdGS0s5akhsZFBWREZOaWVLL1lvNkV5SmZZbE4xWWkyZ1pzaVkxSHhmYS9Y?=
 =?utf-8?B?QWhnVGZDSW9ZdVRiMkFSUTlLY1Z3MnZ1eXRsWE1UOVhtVk9EVm8rcCtRd2RH?=
 =?utf-8?B?UVZwZDZzTFdIVjlMVEF1SHdBUmRMWHFGa1B4eC96WWRtZjJRbEdEUkJ1YU96?=
 =?utf-8?B?RHlMWjVINlNGbW04bzd6cUNac3R1ZmF5ZUwrTXpZMEwrSzBRNG1ITXBtWE5q?=
 =?utf-8?B?eHVMK0hZazlZczJmNGFHSVhqU3p6ZWFjQ1J0UmMvRnI3QS9pS1RHckh4UDln?=
 =?utf-8?B?VWVDbXpPbnAyQzdOY0ZEQnRtQ3k3akpLOTRJU3l0U21Jem5TRUxNMGl2K0dX?=
 =?utf-8?B?Zm1mZzk1dWRqNno4aEdqaGVEcTc5eW1iUy91WTFHNEh6TWVnL2hteVFMNEtH?=
 =?utf-8?B?aDY4U0I4R1JBNVV5RDdLS3loQWNMYmhWVENPWXJwenQrWGlyRU9nM0pPdnZY?=
 =?utf-8?B?aFlzOGxEYlNzbTRxM09kc0NLNG9kWFBCZ1g2SDRBK3paOFh4RG8wR2xTSVU5?=
 =?utf-8?B?cm5wVXJqS3EvNzQyalJ4d25rcU8vbFVycWdGUzczTG9sNCtZNU1ndlRYampx?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf890ee4-8773-4792-ea3d-08dbf7ff3b74
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 15:06:19.0293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eS1NKUt9IYpu6hWtWj4/1ZnB5TUTvHwFXcn4EFoL/80TWK09bbpxcBD0ZqKjqqseO+2mS6gZFpkoEclsKZBEyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6718

Hi Philippe,

as can be seen in our CI [1], there is a nasty problem coming with a
broader usage of the new cleanup infrastructure for spinlocks.
Statements like

guard(raw_spinlock_irqsave)(&some_lock);

will break because guard will select the raw_spinlock_irqsave version of
DEFINE_LOCK_GUARD_1, even if we provided there a hard_spinlock one a
well and some_lock is of hard_spinlock_t. I don't see a non-intrusive
way towards such guard usage except for also converting all those calls to

guard(hard_spinlock_irqsave)(&some_lock);

The problem is that guard() is not processing that appended
"(&some_lock)" argument directly, thus cannot be extended to take the
type alternatives of the lock into account.

Jan

[1] https://source.denx.de/Xenomai/xenomai/-/jobs/747854#L1309

-- 
Siemens AG, Technology
Linux Expert Center
