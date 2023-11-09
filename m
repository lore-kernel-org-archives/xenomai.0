Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2085.outbound.protection.outlook.com [40.107.241.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB76E1A594
	for <xenomai@lists.linux.dev>; Thu,  9 Nov 2023 11:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CEx1ERV4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTkOtmyLiRQaKzIsjPJFmExbrgyGVdY4ZOkvVgwFpWTIC1LgaUqOUc7svf69izxyBNKWpEEi3JQmL1NuTzSN/MuudMSd79J7/mYl99+llfFUQ9GT4KKaJZtV5zMlgUHiSYPw1N+kjDfaKWMTa4U/rGeJ3dAjmNfwCv+jRtv307e52WdKy8KcUPOZPqAvKZzcl1wtYCNLNCBUPUE6o1XwGg7ZTxInQi0DSCYLkZBDoS6xLq4b3s2qCMXBBTdFwLqX5v7+8ydgjCvNfzF156tK2VqXTOWhPKd2Py2tDmVzWQ3Yb+cuZLkW+z6lOIii/gWVty4NgVqXkti8pVtbEd3GSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VS6sAwS2zN6VJARayHooJzlbd9H9ICdCfkI+JS2GInU=;
 b=Nn0K8lF/q0mQuv5v6hEPc2+REncrB83ItmDT8xGyIW72I1pDYN+uwovf8OCUFzdpid2nRonwBBFxxwaiE/DvRgDNyzeUPutrpg+3/fBT2VmySTOtUgm2+gW8aeSfoFfzjM6saUN+cKWQpgP/RPq0D8oa7zsbmhfVBM5fct5m4WMkxUyYd4vT7yR1Mqmy0peJCmWHSCwKlsHCXKnlMvcR0NS+slt+3LxUpl64GaiO5jBF6vrVcn8FM2RbOGpuqLv3C1WLVq4kjSwJCBoYlsjGOU1ZG0OQPPdXUOtlz6xOxzAFx57BAdlqVdKl45Zv/7dlZFnLenfPBABVWuIpZreLUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VS6sAwS2zN6VJARayHooJzlbd9H9ICdCfkI+JS2GInU=;
 b=CEx1ERV4pLV28ivBTmLdoA5hSomaypKnUb5JFjitEaDHzLdTXnkYgkibD/RUAzj+zVbBPE4GglXcreiZfGEV2Rt+vkr6vCDofOPLO3HjOrJ6ie7wqUMh5lKCPYYk30MI1Fdcqw2hgjTm001Zup+fbybjBKuuIpHlnwVenKK6qG53unjD0AF78N9gItLMUZFxuFbPLGNIs4LUzO7JhNDxiAJ8yok4xjkM9J1HUX2caKecduegJOM1JOHV6ER5eHfQKemxXDuCX9UWphQ2Hk/5Q+uCm11Qeu25kFRIDumTfuQwv+eVnzdnut2WJssKi/JgxeGxUtKivTSvzRi+DEUEIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3865.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:42::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 11:22:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 11:22:18 +0000
Message-ID: <bf9d4965-6f5e-4862-a24e-9c1748bf9496@siemens.com>
Date: Thu, 9 Nov 2023 12:22:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Watchpoints not being handled correctly on arm it seems
Content-Language: en-US
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>,
 xenomai@lists.linux.dev
References: <10236-654bbe80-5-7a7a9700@161802062>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <10236-654bbe80-5-7a7a9700@161802062>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3865:EE_
X-MS-Office365-Filtering-Correlation-Id: c73b78e1-34e2-4ac5-6de2-08dbe1162269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l9kJcGenNYK1e0sZAplcmLXYMALguJd+ApKjd4sKGWke1mHQ9iwIrNJu98SUd7DuDwdv9BH4Dtwa6WhNcqjvz7pk0fucjqiSpdJFTg0t/HZYa3b5RSPuT7GIUfiQ3vx/UEsLWoJOFWzWF4NSF9Rv08M1NKmtNQnQjeWn7n6tkPjljBhiSRSSm649iZwtLAhPlV39gMLp0mBT8JB6ipwwpx6xFlb7Oz3MYBfKTJEZdG68/YwEVhDQ7Ac3fWmQdVN/Ef/oGmQJrpjw4yk9D4xcuWMwDytalCQBsVJW85P3tlv40zOu83XtXIH0QyCdKSwm0VWy0LKwOJPNcJqPtXq4l4d+tLCsx/KsZqaiTHF8T7HMzzyGzlr+TIgbPViFViaxoYcXN0WfIMBSL5hOKHNtZ4/CaXbVQYote7sbkdd6VKQPUZEVSHjSwrHEJNsDOq6SEWaJnDmsxlNniYyI9uWKxrJ0SSz4JCSkFnaNGWKo2ao2ULI6gMHQ5vmcu1NlWdxiXNzEl8S35Wboe05vPsAsG5vKdIU7J7kOR5feZllggm87FZ5YHfDcADwtyRb/S1ZPMpJXg8b5Tjaz5ogplwPDGCoPdYNpR2Nln66lytdaAmN4IHlPzkpybt3OSFDXHV6l3vC7ZUK0MgZsBqL/DRYQ9Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(136003)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(86362001)(2616005)(66574015)(6506007)(26005)(316002)(66946007)(66556008)(66476007)(44832011)(83380400001)(6512007)(6486002)(31686004)(8676002)(478600001)(8936002)(53546011)(41300700001)(4744005)(38100700002)(5660300002)(82960400001)(31696002)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3RKaVJFTkJxZnZ3NWlGWGQzODgyS2pLQ083VUxIUXBDbGQySlVVYXR2dG03?=
 =?utf-8?B?VzhwdFVJMCtRazR5SHNSMm9URVFFR2NrZlJvd0s3OHp3UHkwajBmYnkrc0xR?=
 =?utf-8?B?b29NQis0SWtHTEJTUzQzN05SNG52d0JzN2tFRk1rVTlnb0RGaFdZUDdUWjA1?=
 =?utf-8?B?cC9wNWpQRExDRmxtc1hmQXNKTG1Cc2hiMHh0NVRlYnY3RzVXcloxNS85Q0o0?=
 =?utf-8?B?ajFVZWlrWm83WlJkaTlab3RETXRFU01BYm5vcnB1MzZjRlJWTTByZU9KSS9E?=
 =?utf-8?B?eFJCWTRVUFdUdmVZYnBZbEhyM2trV1UxQytRa1pZcFVGVCt3Ni96NUs5UHJN?=
 =?utf-8?B?Szl3L1hESVo2TjVQRFcyTTVRYThNL1dTLzNES3ZNTW5aeER3ZkdmZkk4Titp?=
 =?utf-8?B?dytNQ0txVEx1cmxiQm80RGtVTUs3ek1aeHIwcHhYNTFtOW0zaXoyQjduVHF5?=
 =?utf-8?B?bDRUdnl0MVI0L2hwZUFwak1tc3lXdTZpTEJZNGxlbGM5NDJOdDJxTjAvdVJQ?=
 =?utf-8?B?TXV5MldGcUFGQ1o3WHZNS2o0QVJ0QnF4Q2MzQWtNR2YxQjgra2cxSGMrVGl2?=
 =?utf-8?B?TDBqWHpIN1dLdGhBek1sRFJ3TWNIcUxFdW9zMEJjd0JwQ21LNldZRzBsc3RO?=
 =?utf-8?B?WklQVXVXZlBmS2hxYWJyb0dDYVI2RmdwU2kyRy9xU21GUlZ1SEZTNyt3bWxI?=
 =?utf-8?B?T0FnQk1mYkhmczZzQ0FNT1Q2dkRFRlpMRUMvcWE1VUdSZGJpTTYwbzVPb2lL?=
 =?utf-8?B?ZkxXWEt2UyszTnByRmZmaWhJVEFhV0FQb0ZjTEJpOTh4YmZNTEVyZlFabS9z?=
 =?utf-8?B?Q0djTXNlb1NKcG1zRVZ5bEV0dVNudGJYSkswRFN2alQ1VlA3VEh5YmxsdldP?=
 =?utf-8?B?WVI5NnJkTzhES0grZENjRzRJcm9ncE9EMXdLU3l1dXNRcGc4R2pwZksrSUJZ?=
 =?utf-8?B?eEJ0K1cyY09HYWM5R0pDR0IrS0tDdzkycGlXK29hY0lKUTlRaGhpYUU4dCtr?=
 =?utf-8?B?NjRFL2IxbU9KL2VOWm1UZnRXa2xXcXdJV1BjQnhMck5ucDlacDU4cUN1a3Y2?=
 =?utf-8?B?b3Jzczgybk5EcG40blNsOFhQNGd4M2JUbWIzMTZyUjc2MjkrT1Y2VnpySzlx?=
 =?utf-8?B?TnNWdUozUHhEM3UxNGtuQTVCWkxrYjN5MUdCby9ndEdDT2tEWUlDVUxGNFdP?=
 =?utf-8?B?UnI5NHdSVVVSa2U5WUlnVmpUNVFyUHh0UHBnMkdieHlnVUFTYjMwQ0JlUUFH?=
 =?utf-8?B?ZExWaHdhNHNUK1pUVHJFeWpkd2FtTGFLODBNWS9MWGVoYUx4UndoZnlEd29C?=
 =?utf-8?B?MTAzOVBSY3dtbDZNaXNGREpIbmk1WDUxZ1NMV2dJaTlESVRORHgzR29PQWdo?=
 =?utf-8?B?Zmp4QStQR3lMNnJ5SDNIbFV5cktXcEpWQUNIQ2xLZXpmSWc3MldKM0VpM0hh?=
 =?utf-8?B?cERYSHJOOWR4Tkd0TXBvL3cycHVBUXR2aGVmTTU3ZHBPZHl3ODBjbTJxMnh0?=
 =?utf-8?B?TnZESVhPdkZUcmw0RW92T0dvTG5KWXlPa3VrTDRIU1ZsRmR4NUhHTitwaWY0?=
 =?utf-8?B?dXpacUZveGdPS0U3Q3U2bGNGUjRmNnNadi9Udk5HTitxRFM3Yzc0RXpPNnFh?=
 =?utf-8?B?V3ZoaXR0eld5VWZWZTdHQTNxdkdmVkZ2SERCOEZGZE1nMllSZnpWZEhCV3Yw?=
 =?utf-8?B?YzRaL2tabno1UWRoV1VWUDQxNHBJVUNnK1k0MFc1aEZ2RFFaZWF6NWNnNEZi?=
 =?utf-8?B?Rkt6ajVPMFpGT1NxSDNXZUYrWlZtYzcyUStjVEY5bngvQ0NmSXB5alJESWhJ?=
 =?utf-8?B?TjVkWnN6cWtDUkxobFp3cWVyRy9NZGpKQk5EbVkwWUl2TERROWpFTGd3S3Rt?=
 =?utf-8?B?TDVlWDVQeTZtUDRIV3haMmFndm9FVUd1ZGs5RHJXZHVVVC9aL1h2ZHI2VDll?=
 =?utf-8?B?Y0V4OU5oTnMyOFJqL0pCTUhEV0M3Um9Hc1kxTkdSdW1qRGd1UDZLcEFEeVFy?=
 =?utf-8?B?aHFsOWFVVEdtTVdTSXRwREc5aUNTdGdoQmVPeUt3YkFhcGN0YmkyakNqbzlB?=
 =?utf-8?B?ckx5Y2dMbWdZRXJGbTBHVEtITFV4RUZPeExkVzd6MDNDai9TU2JMaGdrb0Fz?=
 =?utf-8?B?YW92eFUxZEdqbXRkVTRJUkd2REJpVDhWWllaZW9sUWlZTnN3YitBOWNkT281?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73b78e1-34e2-4ac5-6de2-08dbe1162269
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 11:22:18.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHzFfuK72wjY/iD1G+5941cCmP1F/N9l36DVU3uuLCBeR4n7D68khAtvBIll6aRkvuHKRrMeh6YQx0x/ZRF7wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3865

On 08.11.23 17:58, François Legal wrote:
> Hello,
> 
> Working with xenomai 3.2.3 with linux 5.4 on Zynq7000.
> 
> While debugging my application, with GDB, if a watchpoint hits when in a xenomai RT thread, the machine hangs.
> If I connect the JTAG probe, I get core 1 halted with message "Synchronous Watchpoint", with PC being on the instruction that should have trigged the watchpoint. From that point, I can never get GDB or the app to continue. I can (using the JTAG debugger) hit continue, but it seems the app stays hung (even kill -9 does not terminate it and I have to reboot the target.
> 
> Can anybody help ?

Do you see the same issue with 5.10 or newer (Dovetail patch series), or
with 4.19 (SLTS-based I-pipe)?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

