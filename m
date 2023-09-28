Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2073.outbound.protection.outlook.com [40.107.249.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE2C13AFB
	for <xenomai@lists.linux.dev>; Thu, 28 Sep 2023 16:25:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZ0jyKDsfD/JfbZv5kiQAN1yKbaEUO13vT2az93+4W3aIGY4axB/FPG4LJ5UMFsrfU7X2rnE7w1sTpMQHvLKiesiMXutawdMVCE+n+YcZLcBdfswBXwOTt1hqfrI1kwtNZBjZ/a//qdWEk1hqNvOdC1FlxjO+i6fLAANOOjrVTf3SS450TpgozBJ9vmeYlqlymvNlHbcohgDEanubnip2wyIGHL04FK7sk69jo+bUDk4OuiMdvP2idVxhWn1AIrIwdZT8C7uVeFdM2EuYY8/FlrZOqF8Znt0WLjfiXwCfSyQAHEpzMxGwPnYGvdmyKXLY9yxF5uI4AJrKk1baxVATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPyWeLLhQ0UPJEUS1BsN6h9yBem56fBfyoYDzeIQKSs=;
 b=SSyh246nVFDspYJdEB71r85gEYwSRfZ0xpv0RQshhJUp24Khmk/Xq30k0G6q9+u6hySYyIlCXfOE7MdHBgv9bekMMMFxZu+3jg7m//IlBYDrFmBRCqJcMdw7KwgErYXcYlU91or1HM8s0Re3ZbKtY8LQQOsZaW2dzSyUTEmef0CPqpY4DOc3qQg0Wg9Uwx7yL/SHPnbVN/EvX2rQlmUGH9hHeJOd5b464SoCH8tAx0YK2K+4oPL6YYlWkCUov1qZBaXahJvJjHz1dMCC6/n2dexzvXmjHTjN4jOpQzHqpbheNQvQ6UUbZLa5jIq88HK66Lndg5sKh3sRE793Ye2vng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPyWeLLhQ0UPJEUS1BsN6h9yBem56fBfyoYDzeIQKSs=;
 b=ijhQRbc9RTjWMqH+ii6W/tjUlXU9F+AeFKH7wtLGBJPmskODD/awkZ41LjBV83cpraKjuAVisZuvy+9ZOB5etAYJ1Wn6jLKvZrlVfYkOF4J9S5M7uWVMeUAQY5olV7EQajBJEmt/dBVCGAdq+ZGzwY5RjaR9Np18e8U+gJUcZmVkstd7X3RkcyHEWSMLt9H/SpbFj5WKwFZNRzVEuVFNn2ZddzkCFlBHZkyGAlkjXfNpqxPoZzc8VK/m+Q3YVmh7CCgBpS6mO3Zj20Da91lmNU3+hIHYCwCTWJH+fDZ89U59GO1tsXLZFBEBAgI7wM7dCG7P+fW805trxlQ0gPL+ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6228.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Thu, 28 Sep
 2023 16:25:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 16:25:19 +0000
Message-ID: <e21e5064-061b-422c-be02-74aa08d26719@siemens.com>
Date: Thu, 28 Sep 2023 18:25:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] y2038: Finalize and enable y2038 support
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 4442be78-2daa-4588-e141-08dbc03f819e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KlktstAKEY0OVgNAhbm4Im8JFjnZc5RbjFfYOrRIigr1u+hLm6tuf06FXaH47CtYxFulbntIj9eEclcBYhQTtX7ZHeceOOf9+8i1VUXZDrd9NLkpHA3EomGcWdii4I2yAmKAzyDF+a6vfcfJgCU7fGXYSl1zMLUzs7280NUJ2ScaT0/eucM59REQW3A8dSeeyQRDDUTXASmFZjILtNbRIrj9Iv3FciX3Yiwk9xeGGecgh8ti39JYc7oH3EgFRcmCvsEfkAwIga5dO6AuKKDC2+Bw4UsVpRVo46IelXBoLl/LS9djSaTY6wOr+uLwHa3HH8vllkHF90aFEH91jioM3eVmkweCnmLeT6xwZlMLoVnyfMB+cuIPdgArcdSe+uHeWNMk5FpTXV/henaKQT/eu4awEuq7UZtBYdgiqxF5NQ0IBH3AEZzK7TZ8D8+x4SsvCl6mGkQXrnBpOCL7fjmGQdG8yh9OCVgu4i9GbAOjL8mU4qHltPAXVAnWkxJhmngRkLcMIxcyqsInnOkH6FjAZqH2W99E7SETUuJd4vbNofEQu9kW6UknOU1l3UxDisLp1Ilx6K8yUkmoXZQRbQVDZsCVv1eyZNQDOWC6tagORMpGXvlooczI7eDefGqI2g22yVeHHTd9aBEDELbeVPLyYw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(316002)(2906002)(41300700001)(4744005)(66476007)(66556008)(66946007)(31686004)(8676002)(8936002)(44832011)(6512007)(478600001)(6666004)(26005)(6486002)(5660300002)(38100700002)(6506007)(53546011)(2616005)(82960400001)(86362001)(83380400001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STNyampncHo4WHBNWHFyQU5jYkswZlNUbVVGU3ZWOU16VmJJOE5SMHVVSEZK?=
 =?utf-8?B?bDcyenEwWEQ0KzJVcmNnck9nZFo5OWUyejhvZjIwaTBwR3JVeDFEVWlTY0FT?=
 =?utf-8?B?ZlNKMFlwOERlTTZpVXJ4Z0t5UnFSTTV4L3FoT2lxKzlMS3drc09HeDdCTnR5?=
 =?utf-8?B?SUVSOHppVmhVcVM3dEVoTUlNV1pFRURmQnZoaU90eG9DdUlWTjNUZFBIY1o1?=
 =?utf-8?B?a003RVIzem9FRmljWlY2RVVqOHk5TldweHhWTXVlK081amZjWkRBekw2SFlN?=
 =?utf-8?B?ODZ3NTN0NHNvczJhQjZramt0aWtYc0M5SHc0MjVDTnRReW5WM2k4VFUrMXBz?=
 =?utf-8?B?Tm1EaWZZcW5WejVxUnVtbzNheExtMjhyeDlNMk94QUZsQXorN0JXWXczcW13?=
 =?utf-8?B?bGNtY2Y1eE82SUQ1RWJkUjB1Wm5ZVUJMOWYrRU93S3RhcXlPZWVPaHlRWGhF?=
 =?utf-8?B?NkUzTGhCcFhMazAvTzY4dlA3MFEwUGhWeXRCbDZ0ajlhaGJFVEIvZzVpMnIr?=
 =?utf-8?B?YzEyNzZ4M0pwNmJuencxUHprOUtBQm9WbmsyOS8vUUE0NThBaUFRdWpHOVU3?=
 =?utf-8?B?KzJyMHB4V1piT2J6RjdhVEVFVjVqTEE1NzJ6UFpQZE5TOE12ZWRJMTFvUmpE?=
 =?utf-8?B?eXhURVk2YVVqazZ4S0VXMEFHd2NZSUZqUm03OCtmYlhrNE85THhNaElGUzhw?=
 =?utf-8?B?T2VZekZUK1dLUlY0NVoyZndxTzlaRWtBbmlnRVkwWDgxMzNJbmxLM3hzaTg5?=
 =?utf-8?B?dmZaU1Eyc0sxQWtoRGs2QmVqOEZxblJFTmVoUW1wMm9vbmpocmZibGFzNldP?=
 =?utf-8?B?NVdzcDVFUzZqeTlNN3BpWDBTSVFBZlVlQkZjcU9oT3NBNDZ6VlVac01xak9R?=
 =?utf-8?B?NEZVOFBwSzZ6NnMyQ0R2d0c4YlVaMFpveFZGdzhlNzIwZ1Z3cStGMklybEpB?=
 =?utf-8?B?a3RmbWZ4QzhHMTM0VHF0SW43UHkwVXRndE50RzdWeGpkNGFIYkdqZkU4MlAz?=
 =?utf-8?B?b0NyVCtLTlNqT1RDMmxXQkk2WThlQm1kQisxMEJzaXBEd3ZjeTFJaTQzdUw1?=
 =?utf-8?B?RGlJa0NzQWZxV1l6aVorM0NhU0dWajU2MmU1VW1ubXl3akQwWVdQbFVuTjds?=
 =?utf-8?B?c3pvVkMwQ0lXMjAvZElLdWNlT3lhVE15VHVDekZpTU9zR2oxVVFpOGdJMEJY?=
 =?utf-8?B?WHhkcXlTNDBsSExodmlHM0tUcFFBMnFOb1NxUjF1Qy9pQ2JRRVpSdFZOZzI5?=
 =?utf-8?B?aEVnYlJOOHl1VThJbWl2K2h0aGlVa1hYRWZDa2l4Z1A3V2dFS3VrWC9SMmZs?=
 =?utf-8?B?ZGZUMzNDTmtjcUI5dUNHNnhaeU9IWlhBejZPb0FEV2RObjAyVEgvNVpFYXBN?=
 =?utf-8?B?Wms5UCtTT1J0SmJVdFJYNTV4VTFsbDFESVdtZ3RvL254UWJxVElhMVR4ZDBV?=
 =?utf-8?B?WnZoQ3d4NGhNV2cwYVZ0eGRVbUdsbkswRlpWU0dEZ2ZlN3loMy9tcHI4aUhm?=
 =?utf-8?B?LzMvMzdhWXdCQTF6NzZWOHp6SVZkdjh3L3A4Q1N1OUNqenN6bVM2NDdibnlE?=
 =?utf-8?B?ZmJFYzl6UVpvdFNmelN5K3pKaFo0RDZPTEpLN2I1Q2hSNnpxU2QrZDE3RldI?=
 =?utf-8?B?YzFsalZjU1lrcmFNVG9JY2xOMGJLVEI4OC9HQnhCTkg1bENjRnRJbXkrUE9a?=
 =?utf-8?B?VGNISVdnbW1DUzBlcGUzLzQwdDRBRUc2ZkJPUW81OVlNdDg0WTE3ci90MDAz?=
 =?utf-8?B?R3h4bzNYMkhrUG42VWJIenI3elF0RmxxeE0xRmdPYTBDNlNQVjhscGVocFkv?=
 =?utf-8?B?WkwzaTNCZlJSanVYOVB3b1k4azBnUnp4L0tEQkUxU09QR0dHdi9RQ0RvVGxJ?=
 =?utf-8?B?TFBhYlF1c1hZeXVENXpGbzUyWmZzUUJnWlhjRmZkSjlQWmVrK1RaQjU2TkRs?=
 =?utf-8?B?bHpKeWxzdWc1alB4RkdFL0lGQlJXcjZ5dVpxVWJJV0ZoUzlTTjkvcFIvRjY1?=
 =?utf-8?B?ZXdGOXRoYnhnVTNGTG5vOXp0Y21uL1h6TjJSVTJyV0NIaWU1UGFQbGNmekcx?=
 =?utf-8?B?NHMwL1pjOHdDUlJNVDVuRmpRK2pXeUhXZHFoeGU0VlR3dlNXVTluckVHRDl2?=
 =?utf-8?B?a1BNcW5Yd2VzL0cxMVB6d0UvYW42Rll5R1RpNkFFdC9zNDBkUnZMdFBkNVMx?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4442be78-2daa-4588-e141-08dbc03f819e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:25:19.5815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2yZlZRvkXi7oV5+NNBGCFlm55wKEmijyamZbtvr33KeXapTqYy4uOYpgDB9orC3Es00Nl0q0bJ611k18UAc8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6228

On 27.09.23 15:50, Florian Bezdeka wrote:
> Hi all,
>     
> this is the final y2038 related patch series. With this series applied
> y2038 support will be enabled by default for all affected
> builds/architectures.
> 
> There is a kill switch (--disable-y2038) available in case unexpected
> problems come up after merge but that is not expected. The y2038 queue
> was regularly tested over the last two years now.
>     
> Short summary:
>   - Implement y2038 safe ioctls around SO_RCVTIMEO and SO_SNDTIMEO
>   - Enable additional function wrapping
>   - Fix some smokey tests (reading of reference clocks)
> 
> Fingers crossed, seems the y2038 issue is solved now.
> 

Thanks, this is sure a major step forward!

How confident are your that all these now possible combinations are
still tested? Our CI will run with y2038 enabled, right? How is the
disabled case tested, at least build-wise? Or the case "unsupported by OS"?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

