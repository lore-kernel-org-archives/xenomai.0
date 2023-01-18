Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2071.outbound.protection.outlook.com [40.107.241.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8233C2D
	for <xenomai@lists.linux.dev>; Wed, 18 Jan 2023 17:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFY+96T+C3UgEotzO3EK7f3W7v6oMQ6lEao9HoiR8WQ9IFUA/5Lci5Wr6kJ3qeuTfK2Gih7fCUe+Nmt2N80JPsklI4eHKP1Lj1wtkuc04KrdHpmGxY2QwfI9XI2BVAFlRPvbKvMWLHVC+2rDUJy9doW5hUGAMNOulRux1J8iZakN1VZVvCiWf+ZpfeOFVxrHpm8fLjbIDGSIFEAluCW/H0sQ8laNEoNIuE4SSulBZgMDw/ggHgEy+T+iiLhHGkkVrjDoRoA6gfVbdUdYy9DhwkkdaZQ703RcxZnfvX0RRQHmK0JNCd6kseono9N0/OCCTVNsR9ozdU2ieQV1nqKgMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlqEGQG4bfmZPhz137WC0CEDS2tgNvj1OU/o0fwANYw=;
 b=LI1CgRkUmcl8z577sq0UQVmWkBtCJ8MKTL/XgtIXUbLzPmcqI+U+lJ0xXmkWkq3z6cQk67jChwz9dERTJDW1vhTbJe/djtXnjKDD2/P/MM8wzwgCbWTcZ3thqiCawTaeeYy/vNociBcMI2bs6LBvOxjnDv7ZLskHh9MfGYU2T4ye0zOFP4ZYmh0aWPCvOPpEJRd03Uk41zM+eydxqmRF7QQll4LAQmgeM4u0SiA/xhjGM8HQspKeyEHmAZkNhidEwBOoENOsiX36TWLWsFBOftv6KYBA68dWhFhHhOB9CIeg3RuOuF0FckUiKCswQx2JalcC7uCW8I1Nd5w9sS+dkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlqEGQG4bfmZPhz137WC0CEDS2tgNvj1OU/o0fwANYw=;
 b=J7UFwZf5uxj1m0FSoi1eZ9ISG+ZkGrvPUHLog5CB2IwbzW4dkexLsI4kz8qASPdDMXZ/ZGMk5KCni381o9LPf32Qtze8AINSiSe8FKSl0tNJKxvn9aokuCnZRm5utPxWrfzQEJUxNCvbPAM7hLi4cYlUiEvZYKhVvdxDm+o0roN7ZHegQKNZCeMAe+3G5E5lZU158i1K/hNiVB6baaGvabZwor2oWxKD2B2kZ85kPCOgmcOUrihQRq7eCxu0FXG9ZSu7PTVlcsOm45tY2FvzQHdxFVK1deZ1ChFJenYNM7IOIhT/WsGCa+DpUtziQZ360+UTgs5x4VpVTM8SVhdBgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7757.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:630::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 18 Jan
 2023 17:43:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Wed, 18 Jan 2023
 17:43:48 +0000
Message-ID: <2893142d-70c7-eb2b-89ad-f2a7154f5eed@siemens.com>
Date: Wed, 18 Jan 2023 18:43:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] testsuite: dpdk: Add l2fwd example which is based on
 DPDK.
Content-Language: en-US
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@lists.linux.dev
References: <20230118130506.30418-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230118130506.30418-1-hongzhan.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c791a3-b56c-4ccc-f87c-08daf97b8e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Up7Pkq1KSNZAtUb0zw4rttSxhW9he7XTW70mnV4X6BvkVHSPvLWym/T/at21PHKaZvzDXUytNyCut0cGsE27rGe2H/dde/e9rxNZ9AU17gWYKhlzFvTu/wfap2PaoB1lez/Sj+oK+41+XPmCQ7wc01EZMKSIFIENq9SiFbBiwDx7nk2h/vEiTdrlB8JUS44Yw2rKWJk+bjyw+RRgMvh/yvImxeoFk7dy9lRIgpcDL3/AGahEbwQzgV/BB4hC3OpqOg6xfSOQCc1Zvg+NqNvzlk/iUO1ZOJTCkZrbbzFlJQD+YtTBIpOhnZj4TI30ECtJgonpjmGZ6xS7xO1hlUYs0cgF7nUf8maGQXGs6pL57Abs1S909gcN9Mv1q1HBpFP0ZP1LDGY2k31nr3qM0AErHX/i5LE9QuGpo6qi1W9ZdtATAxDLRO4bBCw3WzDW1L8NTvH0WBH/XKOPFT6m0xtFNFV3hYttg5fcKXcAbD34LAtc2pV1RxnDeG4hSxchvvwd42NpDer7FyhtphiaG7HBvj5Op22kVZeJMFb2dGFoSAJtaTL3OAaS6gG/Uni6nR8lEM16pOv3eLiylbnBfnZWrx2BU0qfb2Q/UCNJ6rtYWy3v9lsiuSw77EISxSwjb+/6F44gGaEKHNOOSm8ZxoMK+PB7l3lwmHu5eDrJH/sNU60Tp3eCt2PmlpBAGTO2uGfv1Y0efMPcfz5V3bFuQb1xeOBYWGiWaHzBSMEg/UNhdKs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199015)(31686004)(36756003)(44832011)(2906002)(31696002)(86362001)(38100700002)(4744005)(41300700001)(5660300002)(8936002)(83380400001)(82960400001)(66556008)(186003)(6506007)(478600001)(316002)(66946007)(8676002)(53546011)(66476007)(2616005)(6512007)(6666004)(26005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck0yeWtpM3grd2czNk9OSFNOUHB2WUp4cjVuUEtHemQweW9nRG1aVFFGMFFV?=
 =?utf-8?B?eXJJcmNVTXMxS1hscnVXY2dsM1Znc29HVnJlVXBvTzU2ZGFQMGVUWHJMNzRG?=
 =?utf-8?B?d2tvaVRPKzY2ajhlamYrNis3NlI1c0VYZ0pPOTlvRitPWHExQ0R0L1VtZ1Rt?=
 =?utf-8?B?Q0N0VWRoQzhFOGlzVmU5QjJ2ckhBMkNmR3ZxUEF1dUIvNFNYQUdlc1c2L3V6?=
 =?utf-8?B?czN1emgzNWVndk9QVGJwV2g2dTM2VWlsc01ZSTRaa3AwWVRVM1E0cmJzS0Z6?=
 =?utf-8?B?S0FhNFpMR21xK2k3ZFNCWlVHSGRoN05mYUxqNHdUYVNYWUhIODFrQmVVVk9W?=
 =?utf-8?B?NXRza0hjNGFuMkxrN1lPK1djWmNRcXVXRmcycWdJM3M3R0VrQ05tV0szRjh5?=
 =?utf-8?B?QTNML3NFV1Yza2p2ZStiY2R6REZSMnZPSy9sY0VVWHFxUDJSUitzaU9TYlBF?=
 =?utf-8?B?ckxFN1UxN0dXWW92MjllSFBmbHpWSVR5VW5Ub3FsaVY0T1Boa0FZTmZHdFVK?=
 =?utf-8?B?THRMenN5UFQwVXo3ckV1clhrVmMxaDgwVkNEc0R4ZmNwSUNEVWhvZjFMMVg3?=
 =?utf-8?B?ZXNISlljQ1lYWnhxY0FKalQvZE9KRjFwbENVU2lrVTJSaExNZG9ralNtSkQ0?=
 =?utf-8?B?UmNUM0IrTm9teE5SL3BjYU5NcVRLUnlnQnlDWi9oQk9UdlZOT0NDcWhHYjlV?=
 =?utf-8?B?aGFOanFIUUoyNGt6a241THpQVEZvWkhzMHFTdnMySnl3Z1hHZFMybytkdmQ5?=
 =?utf-8?B?NllrdnUvT0UzNUVDMEpaU3JOeU9jYTVlZm5KUzRENDZFTkZCMWlucDlFNE9i?=
 =?utf-8?B?WXZORU1NdkRIZjZTWWpEUUp3OFJiSEZ0UGpGbHk0QmdHdFluOEdZVlJFakpu?=
 =?utf-8?B?ekxKQ2kvOVZPRzErdWFLdkl3SEVWNFdTcjlqTUNYaFh5Rmh5ODBTMnZmMTR6?=
 =?utf-8?B?L1E1YUlaMjNiNDJaTlIzYVFaQ2dOd3dDYzFrQWFIWW9ORFNFalpIdzFtdVU3?=
 =?utf-8?B?Q3ZwWkJ1REhQd3d1bXMvVEVEc2t0cEdwbWdrZ0N6K1k5V0pva1FFNUI3MGdt?=
 =?utf-8?B?c3E0TzZrWFgxclY1bWh5YUhQeXpnc3V3bzBzajE5S2xtTm16NXVOemZaazQx?=
 =?utf-8?B?NjJ5b2lYcWhJRlNqeUxvUW9BVzIyWFFKbUxHOEpHdDE3bnRjdC84ZG04cTgw?=
 =?utf-8?B?VU1CblJjOVc3NHFtNkVNU2ZEWDFQQktqakpYelczeG84MEh4b3FSb2xVdDg4?=
 =?utf-8?B?QjgwZ2dtQ0lzbTdvWjVJK1ZWUmgzUWpPaU8yNjZyT20ydCsrVWpnSHJjdkZH?=
 =?utf-8?B?RXM0U1Zwb3h3MldYcy9EVjdydUpaM3ZacU14NjNsU2NyNDM3VUpJZWR0cE1N?=
 =?utf-8?B?NThpVUxocUk4TGx6eWRQaXo5REJYNVRERllZUU9FSGFNK3l1aU5lTmxPNzFr?=
 =?utf-8?B?UHBwU0Roem1USFdVOWl4MS8wN1dUMGhBeTBYYzV1c1ZVQzEzN25CYkdYRFBF?=
 =?utf-8?B?ZkozY0ZjZ0FKTUJzcE01NHFJMGJ0MER0UUhoSHhGeG5KNGZWWFhPTHBwdGtz?=
 =?utf-8?B?MjFaMnNMUEVRM2JqMzlvdmFLM0pvYndISHZvTTFiV2JQZjdHdFpBendhOXZk?=
 =?utf-8?B?UC9wOWtwVTdOV3VOTUR2WTFDbGh2OEk5WERSYUZaa3BTLzNDN1RMcEVtWEJk?=
 =?utf-8?B?OCtFdzNLME56clB4MXk3ckZ3MFRjYUFHb0c1TlRvTUloVWVsQS9ldU10RDlW?=
 =?utf-8?B?Si9VRndIcmFzSVREUWJaNllUekdLVnprdFFlUlZ1aDlkdm14eEYrUXJUd0ky?=
 =?utf-8?B?ci94aVFLSndkbkJJcktrS252Z0pKQTJqUWJEVE9ZMWdRT3pPckk4VEVKcnQ2?=
 =?utf-8?B?VFl5SnhXMFBBSDExbTNQeUZIcmg1SFdmSFd6aGZ4R0UxQjNwUzV6clRZd3JY?=
 =?utf-8?B?ckZiZHJJVWZkVS9uNE91Z085K3A5OFJpUEpQVWlHV1ZENjFvSWJOZUdqTWRN?=
 =?utf-8?B?VEhCaHpQMWExOC9jK3NUZFQ5T1M4ems5a0dwSVA1SVBxK053VnF6bFowTzly?=
 =?utf-8?B?UUtFVHRjMnRieVNaNlp6SzJOMWVBNHZPUTNVQ0dHTXpXa0tVWDlLbU1DUW42?=
 =?utf-8?B?L2hXbjBBNXV5V0hZKzlQeE9BdVRsd1lqZnNWUGw4VXlmeUsyUlp0Ny83bUhZ?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c791a3-b56c-4ccc-f87c-08daf97b8e2a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 17:43:48.9070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9METNqd/thgPNkXoHGIHyLirwNVgjdIW7Bm+q+7HWkVJljShmyhDKjY2tUOwDofyxJdsE0hfzaJsPmaH1dMpwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7757

On 18.01.23 14:05, Hongzhan Chen wrote:
> The L2 Forwarding sample application(l2fwd) is a simple
> example of packet processing using the Data Plane
> Development Kit (DPDK).

Can you elaborate a bit on the envisioned use cases here and go more
into details in the accompanied documentation? The latter only describes
the "how", not at all the "why" (or "which use cases"). Some words on
the threading model (or limitations of it) would surely be good as well
("how can I integrate this pattern into a real application?").

Regarding the patch itself, you should go over it again and eliminate
debugging left-overs as well as unrelated changes (there is one at least
in testsuite/Makefile.am). The way of the integration looks fine to me
in principle.

BTW, what prevents the usage of the VFIO driver so far?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

