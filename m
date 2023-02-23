Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2117.outbound.protection.outlook.com [40.107.7.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E035258F
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 13:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExxRLMc5dD8obJbSAr4adqsJjJk9D6GI+Ijwu1r8UjvJW6pk+pmy05qh9db2vOTUWvLXI0xmk5JamvsOe47p1B1iHGMsERzI3fj2npblfLplat/qPTtRVgXikKPKJfAf0gl46yuggVAL+8FD5iXhlITkc4d6HQccuiUhhXWWtRKw5hC5I1Dqh4jQrMEz9Yzfd9JdUUY53XEZNJYIUZ/1/KFgWwIgI9k3+fAWemHbb5HbktW3sOKagPGW9GtQTEc6UYrFyq9QW4wiDIirpcKaeWYI99gCpgKMRXC0YBl8QgTvnueR0Kr+LTWqPSq6eVIjoe6EmKvI2zQk0WPyBayLuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8P4wwQ2ye8flExOZjZmL8vYbnbuJlmlKkyiSl1m7II=;
 b=H58qYYxiXEEtu3vclYc4RSqckYm65pDbND4aGxvvx5EFckk0+MLgc/HvpjgPit408LxbM/E+KmeF1ymoMYJyRGPOtyvMqgDnNeahhrYbafhmAln6Ol9K9vKrKzpAV9ZpI53pY+OQd6ZY4Y9JY2z4/a49ODGgzHyh2u9SbqkWzL1zSGcYDaB/hrzpOPSMSOu2IzF610YH2zPCYltlwORkNFsH6E3Fr87EYNd45kFDMYgqVR+io/bpFLK49hi899sKSvZnyD9L2Lcr36RCCtRmV5kFvkvc3ciWmeASwVZMGxHFncZdmS+0J+YprKWjli/amvy2kY4ulw3IHwfWd3xW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8P4wwQ2ye8flExOZjZmL8vYbnbuJlmlKkyiSl1m7II=;
 b=IoI35NctCpMcxLTdiTJh2a7WnRc7h3PP6IZ5jOvqc9ZNuZc9HK/kOKTMQ0unxEyoJ7kT/P/Tl5pAhyoAc/NdZPXU9dpMLY25PYbtZaw2HeSl8Uugnx2fR4KxhHSGM4HXfJdvZfPRguiFyRY8UjZpX2+VGnJoLO2Gx5THEjTXIh8=
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by PA4PR08MB5887.eurprd08.prod.outlook.com (2603:10a6:102:f2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 13:22:08 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::f60:da2a:818f:e6d3]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::f60:da2a:818f:e6d3%3]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 13:22:07 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
CC: Jan Kiszka <jan.kiszka@siemens.com>
Subject: problem while handling exceptions in oob stage
Thread-Topic: problem while handling exceptions in oob stage
Thread-Index: AdlHiSicop1W4d0MS2Gakd59UUNxuw==
Date: Thu, 23 Feb 2023 13:22:07 +0000
Message-ID:
 <VE1PR08MB49090AD3D9BB287AFBD16EEA92AB9@VE1PR08MB4909.eurprd08.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-Mentions: rpm@xenomai.org
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR08MB4909:EE_|PA4PR08MB5887:EE_
x-ms-office365-filtering-correlation-id: 0baff991-5ee1-4e5d-2208-08db15a0f679
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Il18cuAlz0RIafSLrvczvew0NNzMBdyeyrmsv1Kdi6d80IpOSLHczcp3Pd66fQ6asNlxeYwgp7BtDv5XEenbeSdHUkNSZ/PJyThUO77k0qhqCZR2Y50I59Zkh3OrZFc0TiSekdjCCu50x0wd3NeBj0ZeJbDRNcF4fUp2msJNyqyyYpjn9yPpGQxNCMb33aSjYReaEBBEw3xkEbWJq1OKbc1DG9SWE4eiDoY6AHYhqFUPA4kG5bHEWCb92UjPzro7ftGLo7rNWN+G7PuckT5XkZJclzV+UWfaySTS2FZEIJEIIk5QCzVbOuPgdqJVzZVhAWQGkAbL/P35V+2zwxiWeQvqvyQwaYbB1Hddt6YJtchZ6fduoTlTreffgMptB3yaeGNCf/9asFdXFA083i6B+rQ2AxSLC5MgJ9ZLqPaxGRC6DJ3TZkqvATTFNnXYvWdbQ9ybC9+vH073gFIgnrxmoLcUVbkaiQSyItRLygadTvZBNlhRDwVSIn5KWcNkV1nj1EFloG4IJkUYC+MPnYv2c4XqmR+m/x02ZxkIkU1s4do/u4PfD/Sib+axS9RrKbBLHCYNoC8All1lktk6vL9Fa2ib02LhYf8cfASCT/aBJmZOFf1+F3K3sgDI0uDbGqBi9fzzIdRxh2dJ0sit49Wr43WodnuelQzrE1m5Fiezh0iVYo/PjSmIljLQ+hMM+hsaIH4F5ZHtB8Tcs3xI1bOuEw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(39850400004)(376002)(366004)(451199018)(64756008)(66946007)(66556008)(66476007)(66446008)(110136005)(83380400001)(76116006)(8676002)(316002)(52536014)(8936002)(5660300002)(4326008)(41300700001)(6506007)(9686003)(26005)(186003)(478600001)(71200400001)(7696005)(38070700005)(33656002)(55016003)(86362001)(44832011)(2906002)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?G0yM+wPbsiaEKiYGQXIef5q0zNuNFD/35tnifo9qCFJPRYkcHv7tBqPFJzxG?=
 =?us-ascii?Q?RVmbvw2Y5LGGn8OlUq9rf3Z3ReNyI30YPeSt9YnX2SuiAdlRPNwTLLvVfZLM?=
 =?us-ascii?Q?yMzr3F7/YT20Qv/iHwX71S/py6N1Ubu++zeC4v8AGSLLctyanZuR/aI5ii+v?=
 =?us-ascii?Q?Hed8NdLOFDmjZakYOMCQ4D0cngYmjURYxL10FA0XXRRebnoKhlCfK09P9D/m?=
 =?us-ascii?Q?zePkR4DGZG1POoag88zagL59VXwCefC6N+rNk2B/UvGEsOtldha+Rf+b8bm8?=
 =?us-ascii?Q?SD3shaHGqFdB0YeVUsV2nWjum+NWEHJhli9/DoPUx8htE6sfysyNZUxvwBIZ?=
 =?us-ascii?Q?jdgDzn4j/8kcHkN8upcpT9XBD6u7RfToOAHCOvaftSAAI2//+RgqmhgOEUa7?=
 =?us-ascii?Q?im84IazK5FSym7oN9DnM//WWcrBN2Fn5V7zhCP9GPf4fqxGAO0OsQMLKY2dw?=
 =?us-ascii?Q?nvL/nr8X63H0NXEqTOte8820xIqZ1c0l/4QQF5lX3jb/g48VFE0cdSrFBvKb?=
 =?us-ascii?Q?MXLPZ01PhDAk8tbkIsyqWwvIfj8TkUGIauuivEH7UG5ji8cz1RXxAyLYs5Nv?=
 =?us-ascii?Q?tPbqfOWlGDaBkRYjlpybPjVv1gqEM6pZBFgHo1q3O6qcVK9tMFOedjKP1CZg?=
 =?us-ascii?Q?tIj+rykcPUzopaSl8bGpfueKku1E7qOWFhtLMkT3kF1+d+lIGYHUZ1hObr0/?=
 =?us-ascii?Q?SATJZSqmjB2AVahsY44CphTXKLgczOTTqj6nlpIJMFCRBBX95mmULZ0pP9ax?=
 =?us-ascii?Q?MKW16SthC9rbfBcBbEGSGQCKsvbZ/8B2/I+9DB3QiP9uBWVaewO723zsPD+m?=
 =?us-ascii?Q?l3191Gy5QFLQqysIh5qFuJ8zGVVVOvT9cY5KEQzKa2d5DsvWe2Zc88tpoD2R?=
 =?us-ascii?Q?454BdcT9Ajv8bzDtZg3UUgxZhJklJffraxTR2rV2LcZlmkCw6eigkDPAwnyJ?=
 =?us-ascii?Q?JtrPhaqKw5e8cI1X2pND8gosuQ6rx/G990soQz4Z1okpXDgWFSZXox4ypahS?=
 =?us-ascii?Q?SPlGMdjc1g1uQwcx5bCY50bbkXXjUeyHGjf7Hdd0oVZBQkPSQ9BU2PyKOMKv?=
 =?us-ascii?Q?xMNR0yz/CPcoZ5lUO1LbXSV85XJ0reIUOGZ/9wA/rMMRzjgUKHz3EVnhGTL8?=
 =?us-ascii?Q?hogNe3oZR28fKBhN/jRKCpAuqKjFdLDPjIQzuAwV0tLc0UTf/UWKsmD0uV2H?=
 =?us-ascii?Q?IORIIDvlJzrAMqO77pDrUTNfGXZthvBHlKuMeLJIy9nH+SQYHvLDrYRHCuv9?=
 =?us-ascii?Q?RTY0BStu0ZHZg3rNKzqVkgkRrJJq7bMAjbNvhShX0NWZvqVWJ+IjJ69SXMy3?=
 =?us-ascii?Q?58jRK4Yi3U0QH2gKi8rmzeR94W7eLd2bST0P14+rEuFw07tI8WDzEPJRQlZX?=
 =?us-ascii?Q?pIQHQalL2fCxnZWNxVzxvzRKKyUXGhbH1ubwJVOZcUeSQfqK3gfwvry12g2W?=
 =?us-ascii?Q?KzdFy8sFaEG2yaytpZKIfkagjWZYxX0uxdIzo3Hx/uLoeRENVIODyFlxGM+/?=
 =?us-ascii?Q?u1uIdpX8iyfru7HhCqpCUC+PlQtJFKP8Gfi5pRVMVBP/aBsvnOZux33S5ey2?=
 =?us-ascii?Q?ULPF/xyZBVFVwgNfoOXFu6uwXiXDqVW90NWNqTuhU/a0Gt+ZiL0zNUl0cCd6?=
 =?us-ascii?Q?pQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0baff991-5ee1-4e5d-2208-08db15a0f679
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 13:22:07.6672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9wOa85UIvlbry3Z3ejU71esRT7ragk/3/PZtpa4mAdRTXHVDSGWIXLsTlnx76G1n3IsO04ib2eN32uAk2nzn1qZAu+o1bSdgtjBaBqiUc7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5887

Hello,

we encountered a problem, while handling invalid opcode exception in oob st=
age.=20
Our fixup code works fine if we execute ud2 instruction the first time.
Upon second execution of ud2, we encounter the problem that our fixup code =
is not reached.

The problem is that the first time entering the kernel, mark_trap_entry_raw=
 is called and in a subsequent call the _TLF_OOBTRAP flag is set.
But because we do not switch to inband stage, we do not call mark_trap_exit=
_raw and the _TLF_OOBTRAP flag is not cleared.

The second time we enter the kernel on execution of ud2,  we encounter (aga=
in) the following code:

static __always_inline void oob_trap_notify(unsigned int exception,
                                         struct pt_regs *regs)
{
         if (running_oob() && !test_thread_local_flags(_TLF_OOBTRAP))
                 __oob_trap_notify(exception, regs);
}

Because _TLF_OOBTRAP is set and because we are still oob, we just leave the=
 kernel without calling __oob_trap_notify and subsequently our clean up cod=
e.
This results in re-execution of the same ud2 again and again.

I fixed it for me in the following way:

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -414,8 +414,9 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
                handle_invalid_op(regs);
                instrumentation_end();
                irqentry_exit(regs, state);
-               mark_trap_exit_raw(X86_TRAP_UD, regs);
        }
+
+       mark_trap_exit_raw(X86_TRAP_UD, regs);
 }

I am not sure it this is a valid way to fix this issue.
If it is, I could work up a patch next week that addresses all the places w=
here this problem could trigger.

What do you think?

@Philippe Gerum
Thanks for including the possibility to handle exceptions in oob stage. Act=
ually noticed only at start of the year that you did it a while ago. I'm so=
rry for not testing it so for so long.

Best regards
Johannes
