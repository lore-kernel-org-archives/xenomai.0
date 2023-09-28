Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6360913AFB
	for <xenomai@lists.linux.dev>; Thu, 28 Sep 2023 17:00:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TW8gcepGq2j7GuAYkxN6BlrZ/8NVwmt08mbTzLY3dROynJzuOnxEFZYEkozBrhZ+1QJ59ej5cp+yg9yT7i1KWL4GzSZVCBropuP9jfucddDfdnG4/IMRe33c/cHaZ3QeuUgFeARXmUqeNPilOhFGBakbe+qj+enLFTmI/PQepMegmiKgKBxo8ytUMMZbYAdy3l5STTgZQDmrm6ZagCwFxdQXDUpoi0k0v0sJ+6vV+LDA5UABoztDkvnx3fw+MEGrvk0pobH1MghFfpPdeZf1OKFcNJ+VGI95VRUYo2V95f/ZiSfbf6vshS6qXAYE/jaYwzm4r4T6SXWdFqshF1E06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utfJeparX3H2O+MYWJvqFhxh8C3aL/3kIpYyY/6p964=;
 b=AJawJonPIWFpxjJAtDWMdUzf2M1L6qTLIXFWyIztPaqqHRlriz2avjRlU/91SGkLWf2c7/6/rvJqQEZT7pHjaaLPEi8jpVvAyy7beXEkcDIJYu16DtkJ/090SKwiVQs0wiMfSs+TXUYK6nGCjpi4+yZZjvhbXdi+21O7PT2kmMZhUadx7tiRlFsuQguR3TKzkREWQ5bdv1fe2kL38OsCi+doORkl9NStleRMXx6sLPygv7EjQzxOwt5348YCi+FrHE1HmHi+4WtpwURHQMZsWGCJ0nBkrOubJ8eF2zk5qSRPga8goEJJ9M0xEUr2uyi5vj8PtaEYlsf6PqlwFb1a5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utfJeparX3H2O+MYWJvqFhxh8C3aL/3kIpYyY/6p964=;
 b=LgHij21VZQ2ggX4AKXHqs8ZDrF/hZ33QOaFFVgZXJvaUPLuqRqRHnCaFlSblnNslFRW84O441aJnTSm/2RwstKtyyxFr0mw4tI7kXAjjgBFQ4oq0UKpwyRpqT30BeybhfLQEq9VhY8Voc8MS4vChhyfnb3fOxF8xriqIpcYC40uGaDDbh62gsVQqyO5z5NBqWUxs/7YlwXU+3zaP1vxLoI6Qu38gR1F1khcYycqLstWGScg2cv9qq9m+qRIFBbcVt87tqKzI25LY6xXbgum4CTv2rgQR87m4d95TM425DfbucVbf6pb680UtH8pIywOgF5Ejl9jexVKTHbCFQFt7hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7696.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.23; Thu, 28 Sep
 2023 17:00:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 17:00:49 +0000
Message-ID: <2917745e-2440-4ba8-9045-82300cf49828@siemens.com>
Date: Thu, 28 Sep 2023 19:00:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] y2038: kernel/drivers: Implement SO_RCVTIMEO_NEW
 and SO_SNDTIMEO_NEW
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
 <20230809-florian-y2038-2-v2-1-05f710464d83@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230809-florian-y2038-2-v2-1-05f710464d83@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: a13d4b21-bec5-47af-8333-08dbc04476ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QrI97loO9MUzhOo7xcJTgLx8ZrVjCF5h+iYsGR+OiEdEcPUftPCGForszRihWy49biQQN2s76iOsSOvTgxelnpzo5pMWiTnMvL+cVS9v9auhBflbm1IXzrAA5BHFjqoPSZoDSkJjLxsj6TcdA97VI96if9mPQZdFzVE8B0aRUKyEyJLv/W3LG6qULi2p8J215zpZrO5rDPGf4UPDWPSn4uYRcMaKBmSNfplHx8GFJuF8cyEsAbIc4Z2ISzkO45323T6inlALueUT0Kj8gWNNRCYoA2ek4FeDZX8cR+b6YboDDkrm5W/3St2+DOC90xdy8cjYFccpEVySW212iTy/74ogPKKJyeY/zN6kASbX3TOhUjbFyD7S9xcN4QJDIsWm6u0N1sMduVxU9VYPTK/g819l0iJojxC7zhyPl0qg86n1YzBAEy8CCYEj2ih5SmFK9XzeCBatA/b6WoZWWDkX8/Qe5hAEwe+kTEmMaH4oFJnIdfhl3uPa7jKEDc0Dg5gOnicn8wEuxNxc7SGJs6IGoAydfYSbqMYlv1qaDLNJIE1L2UreLWHYrg3ebP0yUxBD6U9Ov19Zttwhsnvfea5546ojTTHm7ZBvsiuUkfAKuDct78621Ydc7ZLT1UmNFl5AkzlEcD13vbaHyZ3kpzRQrQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82960400001)(38100700002)(66899024)(31696002)(86362001)(36756003)(478600001)(6506007)(6486002)(8676002)(53546011)(44832011)(31686004)(6512007)(41300700001)(2906002)(66476007)(316002)(2616005)(66556008)(66946007)(30864003)(8936002)(5660300002)(26005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1crREVrZ2dxZmY2RHZjaHpQVEthVmM1RXFWWlFRWDF6azRKcUJSVjRmWEk0?=
 =?utf-8?B?czhEZlE1Ti9aeEJ4OE5pSU9hRytkVTVQSTNONFpKMDY3d3hJL2p3WmJFQlpH?=
 =?utf-8?B?SFBBUmR1VnFiSlZmc1Y3YW5aeFRPT09UN3NnZ0JZZytUYUlRSzhGb0s4WlRX?=
 =?utf-8?B?RlZ5blFaNnBORmRKM28vUmdLb0ViMGJoM2RONnBXUmhYdytkMDArSnN3TUdp?=
 =?utf-8?B?aGRVV09uK2kvWnY2dktZQWplMDRkZEF5UFJzYkcwNHh6YTQ1N3dBanpRMlVh?=
 =?utf-8?B?c1luRyticWN6bWlmdzlPVURsVWNqWVdweTNWQXJ4cTBvdmhHcUc2Nk5OSktX?=
 =?utf-8?B?RXhkRHFlalpLRitwYnZKTXl1MFR3OU1HS1I5K3FzamhYNGc0TzhPRkZQQlU0?=
 =?utf-8?B?RlZzaDA5VklNUEZ6RHdpaGErWE9pK2VLd3Q2WWJaZi9lcEN0VGErb2d6VmZW?=
 =?utf-8?B?UGF6aTVoaWtxaFdVZnIvbm5KWGlydDZHV0ZsUmcyWUFNWnRYeDR5THZORUVL?=
 =?utf-8?B?enBGbmJqNzV0eGpLOFdJT1FLUFZRM0ZkMk15bXNERkdKSDM1RjdMTnE2ZnJT?=
 =?utf-8?B?ejNVKy9LckJLOUw5MEo5alljT0pPaklOMk1nTlVYMkNUTWRRVDkzZERueDFa?=
 =?utf-8?B?ZkxYOWhhT2JnWjhnRjcxRGFvZmxqVFVKQTlYOHFOOGVOeHVSbndaSlZ2UVV6?=
 =?utf-8?B?RXVVQzVDNzJEcjBRdmtFOEhiN2NaTWp3WCt5d1liZjcxT1VZMjZhNUZYeldI?=
 =?utf-8?B?TG42d1UwaWREUXNZYnMvaE5IU2dEcEtPcGtJTUdJdkpPTnloUU0rWm84QUhp?=
 =?utf-8?B?QkQxc1VXelgrRE5CUXhad0pHWDdEek1LOVZnQXdVV2d1QVFXSlR4OFdBcXVS?=
 =?utf-8?B?NTMzUUJRTW1hYThyOXdzckZWWDlZMW5KY3hnYjdWOG1jV2lMT3V6eDA3K0N6?=
 =?utf-8?B?RkdvbE5lOUg5WVR5Um1CKzQ2OHI0YzBjRW5rZE9yRTJCdVl6S29xL3ltcjZk?=
 =?utf-8?B?M1NkSXQvbjN3azdoanpGM1Zqdm1lU0JyK1h2Z25ad1ZibzV2ZmVwcW4ycHZS?=
 =?utf-8?B?UndTa1RoQUQ4bXUrTTFmQnkvZWoyK0RWOTdNQ2w3Vy9ZaDNVNkVnbUF3YmpE?=
 =?utf-8?B?VUxBT29jYkJ1ckIxeGtBZEwybUkzZkdpMW9kVUszNW56aWI2VlNaUFlPVTJn?=
 =?utf-8?B?MXRSUWhzMGtOdGFoS2dLcVBFTXVreG5KeXk2b1RxRWszcGptQldsOVc0MmNm?=
 =?utf-8?B?ejUrZnBpT0JZa0ZVRzMvR0QzOWEwQVk0MFUzZTFjK05yY2lNSWxoek9aL0xa?=
 =?utf-8?B?UmpDWHF0YTA0cmFDbjVtZW1oV3ZaVGlHbnVJdXNvN2dXSkFJdHZBZzF2ZXpv?=
 =?utf-8?B?d1E4M0pNd2NyZUsrdHFyY01Gbnl6OVh0MzZHTmNyY1Zlb1RrcTZ1UmgzL3Ar?=
 =?utf-8?B?L0RUc3B4V3c3YjBQTWsxVEdQZmNLQmNKNW5NQmxYSUwrSEowQzZoRm1OczQr?=
 =?utf-8?B?QkdXdzRTbWhWY1poczYzeUFhWkNnVDh2cmZRZG1JRytVTXh6Z0h2Vmtvanht?=
 =?utf-8?B?ZCtrYmtGS2IrUHdCYjdQQUNNM2xkMnFVOTUrQjFXQWdveTJqMDl2R0ZlWTg4?=
 =?utf-8?B?ZWxhSkRxeEt0VzdBdFZIQ1o4blJqSUVaWGE2MEZVUWx2RWZZNnAxT09xWjJm?=
 =?utf-8?B?ZkNiMnc4T0JJckJvZGYvcjJEK2xESjNOUWVBalVKbElVSVRQTkxITmExZk42?=
 =?utf-8?B?SE9PVElWTEtlakpiYXNaT3NYdkNIOGhGd2luRWJpUVh0a0xTM1NFMFVYNUFh?=
 =?utf-8?B?elhsQ1hySWlPM2VXU0tCcnZsMkpYZG1GZkxGODVnUW14U2NRNWo0Qi9XOHpG?=
 =?utf-8?B?Y29UOExBSmNnTUJod29hV0xmekhucmxmTHpJbGh6ZlV2MmR6VFpJSnUzYnZq?=
 =?utf-8?B?QnJsM3c1MkJuenQ3RVVjTGtWTm1YZkZVNEQwNHY4TjBHK0RmZFhaWGt0eDdu?=
 =?utf-8?B?L3Q0bUhHd3FvcTBsMWloUFFCYmFBY2s0RlFkajFBR29Qbmd5NC8vSEdHWlhI?=
 =?utf-8?B?NEZqVVE3L0oyeEt0SjRNbzlaQ2tnVVQrSUxoUE9pMWRIVXFidDZvU09mZEhY?=
 =?utf-8?B?TEFYbUdWdmdrWjUrU3o3Z25zcUw5elFSU1c4bmpvazJCdVdDcXZybVRqNE9X?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13d4b21-bec5-47af-8333-08dbc04476ed
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 17:00:49.0712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pf5bwvl5Y47S21FLI7Yyxtq3yYiSTpGNOd0S4Pgak/tal1z2dVfEyA2oudJ56LvnVRSygykTJUb0Y+cuwWIrZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7696

On 27.09.23 15:50, Florian Bezdeka wrote:
> When requesting y2038 support from recent glibc versions SO_RCVTIMEO and
> SO_SNDTIMEO will be auto-converted to the _NEW variants to make clear
> that we have to deal with a different (now y2038 safe) ABI.
> 
> Implementing SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW where necessary.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/drivers/ipc/bufp.c               | 34 +++++++++++++++++++++++++++++++++
>  kernel/drivers/ipc/iddp.c               | 34 +++++++++++++++++++++++++++++++++
>  kernel/drivers/ipc/internal.h           | 27 ++++++++++++++++++++++++++
>  kernel/drivers/ipc/rtipc.c              | 29 ++++++++++++++++++++++++++++
>  kernel/drivers/ipc/xddp.c               | 18 +++++++++++++++++
>  kernel/drivers/net/stack/ipv4/tcp/tcp.c | 31 ++++++++++++++++++++++++++++++
>  6 files changed, 173 insertions(+)
> 
> diff --git a/kernel/drivers/ipc/bufp.c b/kernel/drivers/ipc/bufp.c
> index 565409dd6..f1936d846 100644
> --- a/kernel/drivers/ipc/bufp.c
> +++ b/kernel/drivers/ipc/bufp.c
> @@ -824,6 +824,7 @@ static int __bufp_setsockopt(struct bufp_socket *sk,
>  			     void *arg)
>  {
>  	struct _rtdm_setsockopt_args sopt;
> +	struct __kernel_sock_timeval stv;
>  	struct rtipc_port_label plabel;
>  	struct __kernel_old_timeval tv;
>  	rtdm_lockctx_t s;
> @@ -844,6 +845,14 @@ static int __bufp_setsockopt(struct bufp_socket *sk,
>  			sk->rx_timeout = rtipc_timeval_to_ns(&tv);
>  			break;
>  
> +		case SO_RCVTIMEO_NEW:
> +			ret = rtipc_get_sock_timeval(fd, &stv, sopt.optval,
> +						     sopt.optlen);
> +			if (ret)
> +				return ret;
> +			sk->rx_timeout = rtipc_sock_timeval_to_ns(&stv);
> +			break;
> +
>  		case SO_SNDTIMEO_OLD:
>  			ret = rtipc_get_timeval(fd, &tv, sopt.optval, sopt.optlen);
>  			if (ret)
> @@ -851,6 +860,14 @@ static int __bufp_setsockopt(struct bufp_socket *sk,
>  			sk->tx_timeout = rtipc_timeval_to_ns(&tv);
>  			break;
>  
> +		case SO_SNDTIMEO_NEW:
> +			ret = rtipc_get_sock_timeval(fd, &stv, sopt.optval,
> +						     sopt.optlen);
> +			if (ret)
> +				return ret;
> +			sk->tx_timeout = rtipc_sock_timeval_to_ns(&stv);
> +			break;
> +
>  		default:
>  			ret = -EINVAL;
>  		}
> @@ -913,6 +930,7 @@ static int __bufp_getsockopt(struct bufp_socket *sk,
>  			     void *arg)
>  {
>  	struct _rtdm_getsockopt_args sopt;
> +	struct __kernel_sock_timeval stv;
>  	struct rtipc_port_label plabel;
>  	struct __kernel_old_timeval tv;
>  	rtdm_lockctx_t s;
> @@ -936,6 +954,14 @@ static int __bufp_getsockopt(struct bufp_socket *sk,
>  				return ret;
>  			break;
>  
> +		case SO_RCVTIMEO_NEW:
> +			rtipc_ns_to_sock_timeval(&stv, sk->rx_timeout);
> +			ret = rtipc_put_sock_timeval(fd, sopt.optval, &stv,
> +						     len);
> +			if (ret)
> +				return ret;
> +			break;
> +
>  		case SO_SNDTIMEO_OLD:
>  			rtipc_ns_to_timeval(&tv, sk->tx_timeout);
>  			ret = rtipc_put_timeval(fd, sopt.optval, &tv, len);
> @@ -943,6 +969,14 @@ static int __bufp_getsockopt(struct bufp_socket *sk,
>  				return ret;
>  			break;
>  
> +		case SO_SNDTIMEO_NEW:
> +			rtipc_ns_to_sock_timeval(&stv, sk->tx_timeout);
> +			ret = rtipc_put_sock_timeval(fd, sopt.optval, &stv,
> +						     len);
> +			if (ret)
> +				return ret;
> +			break;
> +
>  		default:
>  			ret = -EINVAL;
>  		}
> diff --git a/kernel/drivers/ipc/iddp.c b/kernel/drivers/ipc/iddp.c
> index 05d019339..e4893a378 100644
> --- a/kernel/drivers/ipc/iddp.c
> +++ b/kernel/drivers/ipc/iddp.c
> @@ -704,6 +704,7 @@ static int __iddp_setsockopt(struct iddp_socket *sk,
>  			     void *arg)
>  {
>  	struct _rtdm_setsockopt_args sopt;
> +	struct __kernel_sock_timeval stv;
>  	struct rtipc_port_label plabel;
>  	struct __kernel_old_timeval tv;
>  	rtdm_lockctx_t s;
> @@ -724,6 +725,14 @@ static int __iddp_setsockopt(struct iddp_socket *sk,
>  			sk->rx_timeout = rtipc_timeval_to_ns(&tv);
>  			break;
>  
> +		case SO_RCVTIMEO_NEW:
> +			ret = rtipc_get_sock_timeval(fd, &stv, sopt.optval,
> +						     sopt.optlen);
> +			if (ret)
> +				return ret;
> +			sk->rx_timeout = rtipc_sock_timeval_to_ns(&stv);
> +			break;
> +
>  		case SO_SNDTIMEO_OLD:
>  			ret = rtipc_get_timeval(fd, &tv, sopt.optval, sopt.optlen);
>  			if (ret)
> @@ -731,6 +740,14 @@ static int __iddp_setsockopt(struct iddp_socket *sk,
>  			sk->tx_timeout = rtipc_timeval_to_ns(&tv);
>  			break;
>  
> +		case SO_SNDTIMEO_NEW:
> +			ret = rtipc_get_sock_timeval(fd, &stv, sopt.optval,
> +						     sopt.optlen);
> +			if (ret)
> +				return ret;
> +			sk->tx_timeout = rtipc_sock_timeval_to_ns(&stv);
> +			break;
> +
>  		default:
>  			ret = -EINVAL;
>  		}
> @@ -793,6 +810,7 @@ static int __iddp_getsockopt(struct iddp_socket *sk,
>  			     void *arg)
>  {
>  	struct _rtdm_getsockopt_args sopt;
> +	struct __kernel_sock_timeval stv;
>  	struct rtipc_port_label plabel;
>  	struct __kernel_old_timeval tv;
>  	rtdm_lockctx_t s;
> @@ -817,6 +835,14 @@ static int __iddp_getsockopt(struct iddp_socket *sk,
>  				return ret;
>  			break;
>  
> +		case SO_RCVTIMEO_NEW:
> +			rtipc_ns_to_sock_timeval(&stv, sk->rx_timeout);
> +			ret = rtipc_put_sock_timeval(fd, sopt.optval, &stv,
> +						     len);
> +			if (ret)
> +				return ret;
> +			break;
> +
>  		case SO_SNDTIMEO_OLD:
>  			rtipc_ns_to_timeval(&tv, sk->tx_timeout);
>  			ret = rtipc_put_timeval(fd, sopt.optval, &tv, len);
> @@ -824,6 +850,14 @@ static int __iddp_getsockopt(struct iddp_socket *sk,
>  				return ret;
>  			break;
>  
> +		case SO_SNDTIMEO_NEW:
> +			rtipc_ns_to_sock_timeval(&stv, sk->tx_timeout);
> +			ret = rtipc_put_sock_timeval(fd, sopt.optval, &stv,
> +						     len);
> +			if (ret)
> +				return ret;
> +			break;
> +
>  		default:
>  			ret = -EINVAL;
>  		}
> diff --git a/kernel/drivers/ipc/internal.h b/kernel/drivers/ipc/internal.h
> index 919a5d978..f29ba2204 100644
> --- a/kernel/drivers/ipc/internal.h
> +++ b/kernel/drivers/ipc/internal.h
> @@ -76,6 +76,17 @@ static inline nanosecs_rel_t rtipc_timeval_to_ns(const struct __kernel_old_timev
>  	return ns;
>  }
>  
> +static inline nanosecs_rel_t
> +rtipc_sock_timeval_to_ns(const struct __kernel_sock_timeval *tv)
> +{
> +	nanosecs_rel_t ns = tv->tv_usec * 1000;
> +
> +	if (tv->tv_sec)
> +		ns += (nanosecs_rel_t)tv->tv_sec * 1000000000UL;
> +
> +	return ns;
> +}
> +
>  static inline void rtipc_ns_to_timeval(struct __kernel_old_timeval *tv, nanosecs_rel_t ns)
>  {
>  	unsigned long nsecs;
> @@ -84,6 +95,15 @@ static inline void rtipc_ns_to_timeval(struct __kernel_old_timeval *tv, nanosecs
>  	tv->tv_usec = nsecs / 1000;
>  }
>  
> +static inline void rtipc_ns_to_sock_timeval(struct __kernel_sock_timeval *tv,
> +					    nanosecs_rel_t ns)
> +{
> +	unsigned long nsecs;
> +
> +	tv->tv_sec = xnclock_divrem_billion(ns, &nsecs);
> +	tv->tv_usec = nsecs / 1000;
> +}
> +
>  int rtipc_get_sockaddr(struct rtdm_fd *fd,
>  		       struct sockaddr_ipc **saddrp,
>  		       const void *arg);
> @@ -105,9 +125,16 @@ int rtipc_get_sockoptin(struct rtdm_fd *fd,
>  int rtipc_get_timeval(struct rtdm_fd *fd, struct __kernel_old_timeval *tv,
>  		      const void *arg, size_t arglen);
>  
> +int rtipc_get_sock_timeval(struct rtdm_fd *fd, struct __kernel_sock_timeval *tv,
> +			   const void *arg, size_t arglen);
> +
>  int rtipc_put_timeval(struct rtdm_fd *fd, void *arg,
>  		      const struct __kernel_old_timeval *tv, size_t arglen);
>  
> +int rtipc_put_sock_timeval(struct rtdm_fd *fd, void *arg,
> +			   const struct __kernel_sock_timeval *tv,
> +			   size_t arglen);
> +
>  int rtipc_get_length(struct rtdm_fd *fd, size_t *lenp,
>  		     const void *arg, size_t arglen);
>  
> diff --git a/kernel/drivers/ipc/rtipc.c b/kernel/drivers/ipc/rtipc.c
> index 211b496ec..66176adad 100644
> --- a/kernel/drivers/ipc/rtipc.c
> +++ b/kernel/drivers/ipc/rtipc.c
> @@ -290,6 +290,20 @@ int rtipc_get_timeval(struct rtdm_fd *fd, struct __kernel_old_timeval *tv,
>  	return rtdm_safe_copy_from_user(fd, tv, arg, sizeof(*tv));
>  }
>  
> +int rtipc_get_sock_timeval(struct rtdm_fd *fd, struct __kernel_sock_timeval *tv,
> +			   const void *arg, size_t arglen)
> +{
> +	if (arglen != sizeof(*tv))
> +		return -EINVAL;
> +
> +	if (!rtdm_fd_is_user(fd)) {
> +		*tv = *(struct __kernel_sock_timeval *)arg;
> +		return 0;
> +	}
> +
> +	return rtdm_safe_copy_from_user(fd, tv, arg, sizeof(*tv));
> +}
> +
>  int rtipc_put_timeval(struct rtdm_fd *fd, void *arg,
>  		      const struct __kernel_old_timeval *tv, size_t arglen)
>  {
> @@ -312,6 +326,21 @@ int rtipc_put_timeval(struct rtdm_fd *fd, void *arg,
>  	return rtdm_safe_copy_to_user(fd, arg, tv, sizeof(*tv));
>  }
>  
> +int rtipc_put_sock_timeval(struct rtdm_fd *fd, void *arg,
> +			   const struct __kernel_sock_timeval *tv,
> +			   size_t arglen)
> +{
> +	if (arglen != sizeof(*tv))
> +		return -EINVAL;
> +
> +	if (!rtdm_fd_is_user(fd)) {
> +		*(struct __kernel_sock_timeval *)arg = *tv;
> +		return 0;
> +	}
> +
> +	return rtdm_safe_copy_to_user(fd, arg, tv, sizeof(*tv));
> +}
> +
>  int rtipc_get_length(struct rtdm_fd *fd, size_t *lenp,
>  		     const void *arg, size_t arglen)
>  {
> diff --git a/kernel/drivers/ipc/xddp.c b/kernel/drivers/ipc/xddp.c
> index 2ca0da5fd..8f1b2ece7 100644
> --- a/kernel/drivers/ipc/xddp.c
> +++ b/kernel/drivers/ipc/xddp.c
> @@ -859,6 +859,7 @@ static int __xddp_setsockopt(struct xddp_socket *sk,
>  {
>  	int (*monitor)(struct rtdm_fd *fd, int event, long arg);
>  	struct _rtdm_setsockopt_args sopt;
> +	struct __kernel_sock_timeval stv;
>  	struct rtipc_port_label plabel;
>  	struct __kernel_old_timeval tv;
>  	rtdm_lockctx_t s;
> @@ -879,6 +880,14 @@ static int __xddp_setsockopt(struct xddp_socket *sk,
>  			sk->timeout = rtipc_timeval_to_ns(&tv);
>  			break;
>  
> +		case SO_RCVTIMEO_NEW:
> +			ret = rtipc_get_sock_timeval(fd, &stv, sopt.optval,
> +						     sopt.optlen);
> +			if (ret)
> +				return ret;
> +
> +			sk->timeout = rtipc_sock_timeval_to_ns(&stv);
> +			break;
>  		default:
>  			ret = -EINVAL;
>  		}
> @@ -965,6 +974,7 @@ static int __xddp_getsockopt(struct xddp_socket *sk,
>  			     void *arg)
>  {
>  	struct _rtdm_getsockopt_args sopt;
> +	struct __kernel_sock_timeval stv;
>  	struct rtipc_port_label plabel;
>  	struct __kernel_old_timeval tv;
>  	rtdm_lockctx_t s;
> @@ -988,6 +998,14 @@ static int __xddp_getsockopt(struct xddp_socket *sk,
>  				return ret;
>  			break;
>  
> +		case SO_RCVTIMEO_NEW:
> +			rtipc_ns_to_sock_timeval(&stv, sk->timeout);
> +			ret = rtipc_put_sock_timeval(fd, sopt.optval, &stv,
> +						     len);
> +			if (ret)
> +				return ret;
> +			break;
> +
>  		default:
>  			ret = -EINVAL;
>  		}
> diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> index 71628ba03..5bd114530 100644
> --- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> +++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
> @@ -1743,6 +1743,7 @@ static int rt_tcp_setsockopt(struct rtdm_fd *fd, struct tcp_socket *ts,
>  			     socklen_t optlen)
>  {
>  	/* uint64_t val; */
> +	struct __kernel_sock_timeval stv;
>  	struct __kernel_old_timeval tv;
>  	rtdm_lockctx_t context;
>  
> @@ -1793,6 +1794,36 @@ static int rt_tcp_setsockopt(struct rtdm_fd *fd, struct tcp_socket *ts,
>  
>  		return 0;
>  
> +	case SO_SNDTIMEO_NEW:
> +		if (optlen < sizeof(stv))
> +			return -EINVAL;
> +		if (rtdm_copy_from_user(fd, &stv, optval, sizeof(stv)))
> +			return -EFAULT;
> +		if (stv.tv_usec < 0 || stv.tv_usec >= 1000000)

(u64)tv_usec >= 1000000

But you are using a preexisting pattern, we can optimize on top.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

