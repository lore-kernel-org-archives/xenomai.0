Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2048.outbound.protection.outlook.com [40.107.13.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406991FCB
	for <xenomai@lists.linux.dev>; Fri, 15 Sep 2023 06:32:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJF8xqgmEe6gl9/H7m+/gh1Uva3l6xGS6vW+qUvUIENovEYu8pSmgU3SPfm5pCUnnoKYkcWpMEf0+tvHhozpqYnImtI7iyeZoV1HpbjGpDmWNkUcFqJGvIAU1xC2AzXk7tBnHE1GqcjNhYg0g0Ny7uxfKxKbeNPRzkVqH75XxXAfvTJK5/iOY80Q1rxC6Luz/lJMYdZx7H33iXj62vqpA+aB/TdkBZXBL6vSbaGycWEZWt/eaesZOqWkVS8vezPTX/3h/0E1UJE8geSl7i6mqlv5q+3lL56zdo/lruJCwzY7T9CyyP0f6oGDSvngMIlLp5P9KRYG0XJPnvq0j9nhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTIBF7TGlAYZ9k2Kf8NDrDR8kzN5Lhyit3eLt0kq+j8=;
 b=m/BTbsY6/KcS5XEYcwf3SPwSAusFT9jwsG4Emnr6AVetzZ3wem6mnxqXeZQOWliZpzs6Og6bknwWjD6kWnYcK+c9IhDbwWo77LKr32S2g021O1YDTe9vECqA/qkFYEyuP66+WD4QTwKbU5KON4/+QSBMF9IqRgRd6DNvXrR38hzZvRBTpoGHTmgwB0IK/vH+N1yOq2vjfvNNtUocwyuaqcso2gJc7JK9GeYb48dR2GFuGXyzKLHEQn6v7XR29/6ukOL8+XWXrbhJEnnAsWOF3eyWH1qA//4v9MdPLI7XedThGe0xNgMvnD87FdjJbN0nBpK01jwv4aRIVFJFWhXYgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTIBF7TGlAYZ9k2Kf8NDrDR8kzN5Lhyit3eLt0kq+j8=;
 b=xFV69yNGweThdIsq1+Qv9XaKMB48+pCidlFusxRT/Zo4QR6rFTS9khNbH7d5E3P1id1JsiJDghrrpkFOoFbq0V9iCoA+QPSDbqTHQtjG+MLwMApw23hxadYuH0mDBaAwLVPRhVCqwYlPfZ624Z69GFNZrpNttnn9njnhhgB0RYCy7NW/whHr28rrfG9Xognlz2qA4F0/L/hu27cwVqi8sG/H1BBI3kevdRf5F+3bHArP86sCGYwwtYbQBF76oB1eZWSV7RjRWjdacVcMmF0UwkjQTKxRYgE8MJnA+JIpUc9mVoIYx+y+LpHJvGXFC3NJgr4RUlFxekCDvqDjDOlHzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6355.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 06:32:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 06:32:54 +0000
Message-ID: <dcdfa1d8-5ac2-4d6b-b059-e8cb37e522ff@siemens.com>
Date: Fri, 15 Sep 2023 12:02:46 +0530
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.2.4 released
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d793090-b31d-4a96-fa67-08dbb5b59770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e93RZhBXvmm/LWMES4ZYJQVAYFnZ0V/Cc0V/qcAARCmgwaqDDV2bqeknppmVk/Smw3opW4P13Dx1mU6ggZ+G9WXQYIM9x5VuqqDQxrVCWkYrntl9Qjq/cN6gh9IFDZCtrx7HN9NX7h2fVufnA197aigz6kI6x8qucVeT0tvjWjo00AxG54M1xgfmkppLl7a8l6OC2FFct57sq8O7qxUlWB5RF3/h6rsw6lkWkZ9zR0oVP2Xc454AI3GZtHrnQxZg1QxBnwkUn3MwOLqmsqYUB6lDI7/fllNEg0Lu4LheGo9CST5BIKc8vGEvGgbnWrqrr9mDNa1NAoc8RidB/lchz143AwxUk4Vt+E6prOr8uJjGQ9KOeG2uF5tE9rk6i8Cr4xllo4Rq6JFp695mTMDx89+Ur94yj+oNe/C399tWZsRcBFhkqz6XqPNVnLz8e1aLB5PW76Rbx8IUqPNyDfln02ybMgf4vzXEj6X/xOrOT1WQROmITPMt/77QQ4nlBbzUZ/os+mbgB4aydJ5VVwFztciIuIeHp5hYVrSqKt0z+MJIUkO475v+AwLQR3TUq/HI228k2twrAH5cuSlg0V4AnpiniF+cxPkg8inHBRkJXuha6zy1tgYqMfk6wsrc+gQplr2wr7p8T+WtFkrnY85n1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39860400002)(1800799009)(186009)(451199024)(83380400001)(6512007)(26005)(2616005)(41300700001)(6916009)(316002)(66946007)(5660300002)(8936002)(8676002)(6666004)(6486002)(6506007)(478600001)(44832011)(966005)(2906002)(66556008)(66476007)(86362001)(31696002)(36756003)(38100700002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SERJMzJ6bU9yZ0luWlNwZTFKYnVkeWF6Y1E1dTRyRk1DRlowOFNFZGl3eTBi?=
 =?utf-8?B?VkF3SWE0clgrUldIbWxTRXFwMUVTbVpIUzhDZzVzQVlJaGpQVWlTeVBremVM?=
 =?utf-8?B?WkJoUWVpU1BmTTA4ZWVHQWRpZk83N0pLS3pSa0dONzYvVnBHQkM5RlBnOFI2?=
 =?utf-8?B?M2dxRHVKSUpIL2xibjFabnB2U1ZJRFZ5SzlMZnNOM05DR2dhQnU2Wi8xSjdF?=
 =?utf-8?B?RGdTU0ZISEUzUVN1QkFUZlRSUDVyZHIvL2hBeFoxbjBXUFNaVmN0cXNpTkN4?=
 =?utf-8?B?NmRZbCtiVENzdFEzSEFOdENwS01LOXR2K0gva2Z5UmxDdUhVc2NpU1RFeFUx?=
 =?utf-8?B?dkQxVGJBTi9uRmtIa3NRMUMzYlZQUXJOSzFUWFM2aHZmSEQwQnpzK0pmSjZI?=
 =?utf-8?B?eVF5VE9nRVRMUy9jZVBPL1ZmcTN5ZVlranVNSDRraTNwRHZhbDZnMGtoMlJq?=
 =?utf-8?B?OUI1T0RpN2Zzck84cnh6YVNENS9pOFJob21FTFFsejZaczNhWFNKNTV5R2Vz?=
 =?utf-8?B?SEVOY2xScG5tNVpPcmw3b3ErRnQ5VjY4bGVUMFluYUo2WGRlWGlrSElyeTFv?=
 =?utf-8?B?SGRUa2RyMnhYc3hkSmRUalpWWFFYVmQ0WHN3ZkhxTGFudWJoTWxjWmk3akdL?=
 =?utf-8?B?bXFOSWtEOWVtSkFGUHk3bTZVcEo3TG54QW4xTjdpUG9EeGp5N0Y2MFBxcis2?=
 =?utf-8?B?ZkRDUGRxZHpqZ1VLVnZsdUQ4VWF6Q1A1YWI5c2lla1hRVFFGQ3ZvZndJY0lv?=
 =?utf-8?B?MzhzMGJZRjFmN1ZQU3dhTEVjZU9mWm9MOTUzQnAxVUpKOHc5dmpodW96MUo4?=
 =?utf-8?B?SlJwR2VDWWV0OGdvRkZESzJJdjIvQlViNUdjQjEzY1Q0OXZSVUliQUFHT2k4?=
 =?utf-8?B?ZGRwRC9zaURYMzNQUFRhK01QRHFrdWFONHJXSFdCTTgrUnhLeThUOWpYcnpq?=
 =?utf-8?B?OXlmdkFIWElFTGM5eWtRbVJqc09jNUJwSythNC9hcGRBd2ZZVHZtMWdrbDQv?=
 =?utf-8?B?RTdRTjFzVU95ZHlDNXdwcjB5MG9mQVhqbFhoeS9yb0tqVW9ka0tyckVGVDRw?=
 =?utf-8?B?TFdVaVJJZ1l6V1VyV2hmUm4zWlpWOTUyTlFoaVNmNjdPek9OMkdVeVJ4TDZD?=
 =?utf-8?B?OGNiZzJEUFNaejZiV3VCZkdkdHo1TmtOUEx4djJIT0VxeWd0RnhyNmdsc0l1?=
 =?utf-8?B?cVhUckhoOE5KdXp1TjZmeWNYVXNNKzgyalhDZXh6bmxYMEFCaTcwQ3FHcnRw?=
 =?utf-8?B?SFI4bHFiZHFYMU5vdE1saXlic25QOVhVclhPUlZLQ1U1akVZRHVYVUp4Q0hD?=
 =?utf-8?B?MmdDd1NOOVVIMnJ6alNwaENPYWF5Z2tEcjVFSFJkdFpyalRnNzU2UlZVVnh2?=
 =?utf-8?B?b056QUdTYzQ5R2FjWThEaE5SVTdoamNYOUV2endVOU5KNGJKcHcxUW8zN2ox?=
 =?utf-8?B?RGl4R0lUK204REtObG5iNlZrOW1TU1NGRENMSEZuWGFoUk9SYWVGS2REOUhu?=
 =?utf-8?B?SGxaNWZ0cmJYekRNUHpnbmNXYzhMd09Tekw0MUJnSjg1bURxNUlUd1hKcFZW?=
 =?utf-8?B?b2ZlbndnNlpQY042SVRtVXp1T2RsSFE3dDdzN0FuaEpKU081b2RGNnh3enJU?=
 =?utf-8?B?Um5aVlFMS2pBNEFsNktSSG9FY2pBb1BDZndXRnFET3ZnQ0IyMHQ3ZGNRTnY5?=
 =?utf-8?B?WnRQTEFRV3ppMEpnSXFtZkppS2VVZUpJYVgzR3hCQXBSTFN4MGRGRUNZRmlk?=
 =?utf-8?B?WGt2bmpkSXA1aWJzUU9oK1BvRjlObStJa0NqN1pWelkzNkVVa1l6NENMWnlQ?=
 =?utf-8?B?bUIrWVZNWTI5eHlXTEdCOVlqYVBNYkEzNE12bXlKMS8yeCt2Y1lDTFVxd2RJ?=
 =?utf-8?B?UjNNL2ZTa09vM3FFbElYVjQzcDJKc1ZtZjJHSUlVZDdzdks2TkNGUmczdEcv?=
 =?utf-8?B?dVdTTnhNd3YzYjhBSlNHeUV2YmhyRk5KLzRZMHp3RThMODhTSmZWQmZUVnhs?=
 =?utf-8?B?ZVVpWXlUVmx0REJkZHFVbGhkUHRQNXlsaVR5REZQeVlqNHl1a3hCKzJad3BH?=
 =?utf-8?B?ZEJCeG5iTy90VnptRDNrZkZ6ZDJTU3BWL0hJMXJjaGE5N0tXUXRWQzdab2N6?=
 =?utf-8?B?Wk52VWdqVHJnM2JYRHBYQjFVNEpkRDJQWEx6UTV2UnlnRjlQMEt0RUtnL2k2?=
 =?utf-8?B?Q3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d793090-b31d-4a96-fa67-08dbb5b59770
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 06:32:53.9998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpuE9U86/0BuZS5yctiKhvXz48yU9eI16YWminbRQXnlEE6JUw00VrR7PUwgNK0M4lJ5nwpd6A5fQAOJJq0a0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6355

While the initial plan to expand kernel version support for Xenomai 3
was to come up with 3.3 more quickly, this is now delayed for too long
and will take a bit more. Therefore, thanks to Florian's effort, we now
have backported the needed bits to enable also 3.2.x up to kernel 6.1.
And that's the heart of this release.

Download: https://source.denx.de/Xenomai/xenomai/-/archive/v3.2.4/xenomai-v3.2.4.tar.bz2

Changes since 3.2.3:

Dario Binacchi (1):
      lib/smokey: add smokey_{modprobe,rmmod} helpers

Florian Bezdeka (7):
      drivers/net: Switch to dev_addr_set and eth_hw_addr_set
      drivers/spi: Convert to GPIO descriptor API
      drivers/spi: Switch to spi_controller API
      cobalt/pipe: Allow building with kernels up to 6.1
      cobalt/x86: Allow building with kernels up to 6.1
      lib/boilerplate: Do not remove $(DESTDIR)$(libdir)/xenomai on uninstall
      testsuite/smokey: Fix unconditional unloads of the xeno_rtdmtest module

Jan Kiszka (16):
      Account for switch to pde_data in 5.17
      Use linux/stddef.h instead of toolchain header
      drivers/serial/16550A: Account for privatized defines in 5.17
      drivers: Convert pci_set_*dma_mask to DMA API
      drivers: Convert pci_alloc/free_consistent to DMA API
      drivers: Convert pci_map/unmap_single/page to DMA API
      drivers: Convert pci_dma_sync_single_for_cpu/device to DMA API
      cobalt: Resolve cast-function-type warnings
      drivers/net/experimental/e1000: Use fallthrough
      drivers/spi: Account for dropped return value of spi_driver.remove
      drivers/testing/heapcheck: Replace prandom_u32 with custom implementation
      drivers/net/pcnet32: Adjust for kernel 6.1
      drivers/net/freescale: Drop NAPI traces
      drivers/net/freescale: Convert direct dev_addr access
      ci: Lift build tests from 5.15 to 6.1
      config: Bump version number

Jan

-- 
Siemens AG, Technology
Linux Expert Center
