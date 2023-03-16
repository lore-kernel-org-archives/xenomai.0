Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B438B29A2
	for <xenomai@lists.linux.dev>; Thu, 16 Mar 2023 18:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ct+eqn0nU+3X0f+XtjcxHtIG59YJmWuU4d4fbMKZVqrHHrLD11gImwXDeu+fNxKV46vWBfYDEYFf74K7aIRxsUm2IfEcnsLIwXLB1DsSFWdbvniGQEM+vXEdOYSz3FXhEZmqO74C/oLnXQdGSTvXV3HoZZShRpM30Flx9+v4IFpsrNX7HGrZv1+yItqjAsUB/GaIzNceQ1CkOEAk4nrtN6GGrINquaiGFCCgNjAIJhpaOaqxiaueWsOzJhItRG/U1zLietTDs3m4pxUEaTufL7JHsCveauPZHlXf8oHLJUpnOgPNytFLXlAYL6lAR9j5Qbnt7lohG15PycSKxfOveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLxeJTxO5WOOGBkR899XCn9kFx3a+5Gc8Xw7Osyi5JM=;
 b=b+E+vgSld0F0f8aGZybfrwB2HMGmkwZ0+1lbaDA4XefjoapLxA2xrbP9F6NqVuz3qAvhUtBGfjVtrV/hd+/B5DJgJomONTh10KVEvRM2oNgUaTsj9KAo2UI6md84X28FeQKN/T4wGbpZzSHP5i1Za+IEKDsz0fKTqfr1n/zpTsOKoTiGkwkCKVrt1CbdLH3q8P8EDOyR26gdsl3Jj4HWe7Dp8xVSmiqp1mAPufLQKvhbgjCP5+kM4NB8PuiJ/YSH4QruDlx034Brz7WlizXTwMQp6A+ZWMHcGfns4na2GnH3VJtDHNHpp18t2Ktdn2Y3mDK+96d2IvrxTb8tDIRbSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLxeJTxO5WOOGBkR899XCn9kFx3a+5Gc8Xw7Osyi5JM=;
 b=nf6tpka66EALPt74xvT/LkJZs+kOl2N1cAuULquMWfyLFvg0Ns0VDEAkEpIOYXptZWCDo4JVyxOywbB++qzxHX0pdA0toRsDIaP3aL3YQf/I7692q17V3ybFwIFfLw7zCQ3d2xhgVHt7E7qLbJwYkTaaTRivOzoOU5rKUui2dceg79quuB01tLX2BzViqI3fV6khOjUvbo71NR5nlrFUdZqT0PAba3SZMXuAjKe1yM8o/s25iInhzWZv4vFZnvyK07s/I8viTUJwMakHCK7S/S+so7CaZz7hDEEvEYJfzPpqgBf6VDWgmB1R0A8lq0vIcuF9qSgLmmq5/eCSUDNr9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7010.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:305::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 18:43:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 18:43:20 +0000
Message-ID: <11477b0a-0aaf-60cb-3a6b-0a8b47414a7f@siemens.com>
Date: Thu, 16 Mar 2023 19:43:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Dovetail 5.10.y sync
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3c7157-55f8-43d0-5b49-08db264e5004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AVSaBaTxDhShy9ClSojwcrv+vnVujtn2431UZ8nat0S5Mv3r02oHASE3BQgaTynWpGYItsBnb5GtJI+nP8PKMafkAywlmVvC+laecpUrD1Ij4BFqK7GsJhZQJE33MsU4hec7z+K+3+9xlrnANDjBQW16dLnuaC4VTY3DoagUaltGugpjgYNzTXVXqGP+P2uqV3HdPXDcn5UP2rXwmHJLW8kJvCvnEoOofFPPIwxp4r//wGd1fexF4k2bXKdhTc8NgfRdTwvhoqEHpHEYC7pPKM3P0WLUyASCdXSjx1lT8y/NR6toCqWIakQUCQNRW+k8kRCNHKv2ryfwCT/RDY73o8iczveYf4IkTeX2W9sUqxDJ0DJNgqY8gd/Dn6eXeHeKVf94QyiJO3u7P+uQIb19RjOcP+blJXkshRmSMWv+uFIqbwt99IIXHwH8Ay+gNkGWbC1LoZmxIvC+ULsFWpDUC4Zfo081hcVVWON1U9PUfEw4fLm3QkxjpQLUnwXlbzFNLWYAp7dupgmeZ7BdcW1NtkvddjKaXRawrUkGHVUw/egVNJHrWjOKf2dyCi3fhb7/wpGvHuCTTuo5+1d8OJwEtBFcfHDo+ZaXgpUm1bjKlOo3rHYicn4aRUmcAA/Q0suB/HqeF20QxD+eQT84CDJcZ6Oyyro8q+l4KVMT4fT9yQDQxJlvgjoiHuCe98dQ4WGFcnBwRd7V9oL0ja0pc4V/ro7V9MYh/dl4kd7i54V0yh0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199018)(8936002)(44832011)(7116003)(4744005)(5660300002)(41300700001)(8676002)(31696002)(36756003)(86362001)(38100700002)(2906002)(82960400001)(2616005)(31686004)(6506007)(6512007)(478600001)(6486002)(966005)(186003)(26005)(66556008)(66476007)(316002)(110136005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVVVTTBZZHo1YVRuK01Zbmpzb2hPNGtrbVNrTnJUbUtia3dPa0cybzd2RE1w?=
 =?utf-8?B?YUU2SFpuVjR4eklERG52TCtTMlFtYmp6ZUg5RkxHOExaUHZMK1hMYXpWeGoz?=
 =?utf-8?B?QlJnQ1VPNHhPWCt0bW9LRUh5K0xBN2FQWHI1QVN5QlZVY2xyalVSV0MwMGFG?=
 =?utf-8?B?M2VPSWdHcmxtVjMrNHB1bXlVdjd3OHVtOWQ4UXJHYk93SEVoWmllVUgyOExO?=
 =?utf-8?B?dlJIbWNxVVBTQ1R3QkZyYVZQSkM5OWtiUjBzc2dHcURNdDZKMzNIVkgyOW1I?=
 =?utf-8?B?MlkzSVZwNTJMM1YwMWdwa0dMSWgwVzBoMUVCYnNxdi8wVDJYYnVtQjNGVlgr?=
 =?utf-8?B?emxlSDFlR0p2NUdNUUFpM3VrRm1oRTN5Nm94SFNpSEZLOWc5aTNZcGpGZUw0?=
 =?utf-8?B?NWZqekpMWTRWWWEwRmErOGNaWnFhYndtWjBONEZMeFhNbDhHS3lkSEJxVmJQ?=
 =?utf-8?B?cDBNYnkxbGwvN256MmVibHhpMC9aa2RQSlV0bjVSdTUrOHZib29ISVBoam5K?=
 =?utf-8?B?RmhGVFpOM1czZzUzZXE5TVJRNkh2NmIrR0lyZjltRFpFdUJ5dEh0TU1la3Zx?=
 =?utf-8?B?b1ppUmdPRFE2eStTLzJLazJZbGNYUXJYdEtJWEFtV1BOeFlZSG8vd3JrcWJR?=
 =?utf-8?B?a3c0dlJvVEJ1US9qTmo4VHc1Nk5oRnFTTUJIeW1RQkNpRHhneStXVE9BNjBT?=
 =?utf-8?B?Q0NHMDNGbzFuWVpBMndTWnNnNEZJY1QxUDdRUHZGcWlLOEowcWNQUXllL05V?=
 =?utf-8?B?OE1UdFhjejAxcllWcm1jU3ZsQ0NCTytHcHRzOElTNjl2VTR0L0ErWTNEL1BB?=
 =?utf-8?B?aGlERE11cUg0ZFhSZTU5OHBiUjhaNENGcVZpd0hwanM1ZjNkOEhRY3pvVUVo?=
 =?utf-8?B?MDlKMVZCTlpvU1RmVTZrbzRzOTZSYXVwVFJNd3AzVVRkdlFhaWVSaEw0b2RZ?=
 =?utf-8?B?Wk5BdHFVaFdvc1RJbFFSQ1BzNXB5enFFMEdwUXpkTEdmZlUvamRFOUdqRmR0?=
 =?utf-8?B?NVhnZ3JtWmVySlNEQWd4dUpXMXdHV3pOWUtuUDVnSXdRckRUbGx4MHgybXJj?=
 =?utf-8?B?YnBlRmVRU3F2Y1N6bFR6d0Z5SkNjbHBiYXVaVHBpMGdPVU9OaEU1b0t2cDJs?=
 =?utf-8?B?aTNjdzlqQWVGZTl2dUJGNi9jVy81VUtEanRjbDhjS2JGbU1KZ0doZUJONDAz?=
 =?utf-8?B?bWV5WTNQWUlnYkQ5bU41WjdlaUd1TnFxeG41WjY3OTBFYWVLZEFEU2hWbUNZ?=
 =?utf-8?B?dkJyYS9icHl5T0lXUTVsSUl2RXR6bjVzNllBVHdhYWtFcnpwOW1zS2tFUk9u?=
 =?utf-8?B?MUV2SThSR3NJaFdLVjQyeGR0WGRiMGkzU3UxRTJpSVpVMDZTdjhLYm1VQ204?=
 =?utf-8?B?RE94RDhmaGx1L2NKTTNyZmdPZ1lOUHpJQmYvdElhekg0djRnZ0grTlJBR1Rm?=
 =?utf-8?B?OC9WRjdCbGoyemZ1TzRuZmdEblpuMGVtTUZWQ3NUTllBTzRSUzVqNHBuVDdE?=
 =?utf-8?B?TVI2Mll4Y2xIZ1NWbm9DVFBiRnVqRXhpZHlRems2N1N0YUh1dldRV1dEeDQ1?=
 =?utf-8?B?K0FIZlg4LzBjVFhyTW9FNlo4am11TEkyODRuS2kvSHhYRXVLZWR1UEo4SnlS?=
 =?utf-8?B?RGJyOXYyTDdlN0xwMStsbVFETm11TTVFWGs4MUROdFVWbE5iSENEVmNCdVV3?=
 =?utf-8?B?YTN2SXNrRWhXRmNFOGlKRUlOazFQSXhzRnJHMEFxSGFrMUpYRkVkdzJyY1g4?=
 =?utf-8?B?OWd2cUczRXBuY2cwbXo1NUdGQWNzNUF0MUJFZFNiTGkwQTFJYkxwUTBLQ2wy?=
 =?utf-8?B?eU9BdVhGQ2lsNUZmWWV2LzhyU0crZHZvVjlyYUw0Z3BtSU5hT1JaRDJOblUr?=
 =?utf-8?B?cVRlRmlxY0R5SnRPQ2Z1cWprekNIVVJuUGgyTnRnYmoyWEcyNFpnVlR6ZFo5?=
 =?utf-8?B?SWZpWUJDbEx3ZTFLeVN3YWZSMUJMd25mYlVseVNHaEk5YnRycTR2L3Z4Njd0?=
 =?utf-8?B?R3dHaTRIOTlRbkZNWk10dWdnLzQzS2dpMGhrd3pNUXUwakRKYnRYemZObitV?=
 =?utf-8?B?ZU5DVkJOcnRhSUdaVkhhWk9lZ0lWV1lWUGptWDBFbVdFclhnZjdoTUNXNTZp?=
 =?utf-8?B?YU5HTjBndGE3YnlzNitFMzdueFZRSGR0SnNycGhZUlBhVmxwRDI3RUJMd2Y0?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3c7157-55f8-43d0-5b49-08db264e5004
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 18:43:19.7636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNtW+h1UMyVoJIBmH47PxtBxZhdyWsf19DDBpzJAANiR/oHEKYUMY0rNKv7a+tixZIRO/h8Z8Wq9CoYhRkpkDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7010

Hi Philippe,

currently aligning v5.10.y-dovetail to ...-rebase, and I'm left now with 
this merge delta:

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 8dd10391ca37..02e0b86e4da7 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -799,7 +799,8 @@ SYM_CODE_START_LOCAL(ret_to_user)
 	bl	trace_hardirqs_off
 #endif
 	ldr	x19, [tsk, #TSK_TI_FLAGS]
-	and	x2, x19, #_TIF_WORK_MASK
+	mov	x2, #_TIF_WORK_MASK
+	and	x2, x19, x2
 	cbnz	x2, work_pending
 finish_ret_to_user:
 	user_enter_irqoff

Any reason for this change, implemented in [1]?

Jan

[1] https://source.denx.de/Xenomai/linux-dovetail/-/commit/7f1078a34e#2803808927dc5f1a93c4d4a6e56f1e7671d53c01_754_780

-- 
Siemens AG, Technology
Competence Center Embedded Linux
