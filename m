Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795787235;
	b=eTymHx7FQ+darFsKdVTlSoAl3S6wFPfyExR/UqZ8LeE/MQ36uTCdFwANqOt5vYd/89K0
	 Nfdi6N/1L9zv2C0oecarWR8z+TcwtUOK19Pgxviaj55IZUoSBwYm+B472QwJ/gowjuEpw
	 pnUCOCeZzDc+wB5odeuQCBL7ykN0s/CS3YCbJBKVZK/RdKMccAps/RyT0B2dgcQ4aV+cO
	 tbvrIYEdmLnQCaonMfPgKizlSGJE34Weu/4gwnKSzQVxmspJ4+OrSUds4tfhQWG7TbOkj
	 sejv5T0wtKqEAH1HJy+VSxY1ws0woAM21Y63lDfAijxqP9slW/oWeBYRRz9I3IvkmEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787235;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=2ZPgkqU8bmQ6uP6UBTnh4gUszhgJ6Tp1amOI8dklREw=;
	b=2+Tlibhx3m+61asVkK5wc/wNnB5uZhTh2zxfYXS66v/VusTk3Ma8SrWEdAz8CFa1o/lu
	 fAP7sI+xIqgWGWFkX7XV9sDNc9NfR8Z8VdXBN30/Ds8to1ddFW7QaKdrEv1bPiVEKnME8
	 b8oQpH5jCUkN1hB7A58FJgO6+GiWwjBJWAVXOSZKkJrYCfz0B02H7No3UNjvdx2I+mBub
	 P+KI1r8j/zpiT7Y+1W6G8yCFSrhbU9oJhO7DIMu4FGh8iT1luvxDKHBIbVK+O7gaxH8ZO
	 q5u8xqPuPOa9fzO4653AewqX70rZAKAlVO11U5HbVgz/Cea9Kw+HIr3dHf8QGHDmYpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b="vR3/dcz1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.66
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4AE606A321
	for <xenomai@lists.linux.dev>; Fri, 27 Nov 2026 13:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E4AE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=vR3/dcz1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmCOEjCDNIPdhwhSmSKQY550io/go8eVrYmad4msfgfZBectjsbrdQGmD4N5swEtbScaDuoPXu+3I9uM+CE/79QLgE9padNk2cmn8KBTm/iOmV7WRDDr6b54RVHYxuqUgLRgYsxomfYjg6RdZvu3a+KGQqcbilITlrUJOfPxEQ7cMpjnM90Q7aRSOdNJEgx5e3XfZAulGI5ZGaO9oglzS9tu8NbVE2JZZ7A0rckw4ZrRM2q1zj5WGkooM/1ZAFX8V5sxjzw1yyfvFac47LcAMlOBYV+/ilOeUm+BPa+L9/oLZNuC78rsh0oVPPKj1kwIUFddUehhR29BP1lBdjwvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZPgkqU8bmQ6uP6UBTnh4gUszhgJ6Tp1amOI8dklREw=;
 b=FrL7/WHoJWV6pWDU0p8w7xkrX5o/zLbNzVUtiYQkg7mgNrlPiHaK0ipMnq6LAf413xX7BEGulrfnQ7Im4HYsv0jiupL5vHZMJBHu9WML+/hlb+WjYVWxTmBnjQ1fmL603DMCn8W/ZVjRsTF0EXJqBUcWgNbGh+pajBrjycFjhz6Bs9bKGhMa5vb+RYepf9Pt4I3NzR8tebDRNd15LViPnmylg8kkzMGax7fQV+1RUZiHSiTZJ0jEytVVaqLZfmIQGrLmAQ3RKVRQo4avhoCwxWjCS28kbq1zniKAEjGN/OF7pImpRWzdoBsJCgyXV/QlXjMX5X8VZiVa9J9kDmGe1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZPgkqU8bmQ6uP6UBTnh4gUszhgJ6Tp1amOI8dklREw=;
 b=vR3/dcz1kzRyEpCHMbML/WI9Gja57zgjDZvKFxVDgiX4pp9mnEaR3K6OprsACONrKY0FukdYcML26mxZm1avtGtYMMuiWBXX2+OPsAgsO0sfbavPf4MkdNEIEP+xd88o87kKOzJadbXaK4CNqqds2Z7DXPZ9h+Tas0nEtcQWxO+Zm8A4+QX1WdwgQ+vV206zc8h8K+ajKKp1EMGkfJu+46fNjkJNaX1qrnOmfEEtWwRXj5rD3atg5kmza8Uim9UzIICb19cHS8iclUcUeoDqOcG5sfEC79i0YVSBlz8NLDTmkdg3rXGfj3QTAxALcMy793M+o/Q07TLRdBakRq6loA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PA3PR10MB9260.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Fri, 27 Nov
 2026 13:47:09 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0688.001; Fri, 27 Nov 2026
 13:47:09 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [RFC PATCH dovetail v2 5/7] rv: add oob_trap monitor
Date: Fri, 27 Nov 2026 14:47:23 +0100
Message-ID: <558cbd5e839fb1afa392872588a6392eba65c2b1.1795786695.git.tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1795786695.git.tobias.schaffner@siemens.com>
References: <cover.1795786695.git.tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::14) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PA3PR10MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: ceed3629-114e-4d8c-d08b-08df4c8cee6a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|1800799024|366016|22082099003|6133799003|55112099003|18002099003|3023799007|261021123027099003|56012099006|261021121427099003|261022105027099003|11063799006|261026121527099003|261028144727099003|261022075727099003|261026140227099003|261009223027099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	1ZfYKI8HvWlpOpP38GGJ57T9S9oudrEPqX4X0gAl8fn0SnT7Qo2x6KfaOk6wT1WJ6ExU0msz/2bblmHFegn+7SIpszNR3mXHFS2pMPD6sKf8O3MHrCdmAolgtLNOa/iYL9bxyp05cayCgxW8Ra2KzI8xB+LMOsQeTMTBTEEGVTYNOp/oIqE/1/oe5g/sMw3PRH3tyelDwYmmCerrW85KjJKE2o+WKGLSAMyVbepODibvYPK0MmjbkGluNYAIzB2cp6GcDI4ev+SL48Ue/OV5jl0skTPBdgHr6ykdvmJm5mMGFq48vMgF59OUziq7Z6bQrDo6qYb4lwKMOm1D33R6uwo+MiJOX9Y8lTT3hCnRDhkUGUZW3o+aQz2/KFIleFU8zCdl505/9ZXQZA8F1H5AK5pxwIBNrMm3NbAfBzjkClr0RtDgxlQz4UZEruDIEpQSygAOevCxA1LI/cIHmNZHL4zrUCYtdcbTlrI1t1++qmzLeR/X7P+OS6HVJIQJx2FfQqPiamDaU3/AjIRJbUYFGkWlSu4t9MQKS9gJVNjVeOhBleI9V/s5Aim3trWKPjtBRkCvcWYJoL/6YH7/8pL+DubFKAGMywFwylg7mqW5R2hzunyPsMYCSGuVb49sqW6i4sAOPnkWbsWWuXXUJy8Su26QcDy1AApQh55XIyfsYMA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(366016)(22082099003)(6133799003)(55112099003)(18002099003)(3023799007)(261021123027099003)(56012099006)(261021121427099003)(261022105027099003)(11063799006)(261026121527099003)(261028144727099003)(261022075727099003)(261026140227099003)(261009223027099003)(10067099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fKdEIRUs32+3qJDhF4UOcsJoIfEDc6Lv8a7sgRRDCDAjgoIkeyU1b17SSo2t?=
 =?us-ascii?Q?KpAslPCHZE/M/WaFdl+lPPBRixYTbvf+8+2eKvwqOpCoOqxY7ESXHy5DhpyM?=
 =?us-ascii?Q?3Fca3gMCdFgWGY4Rw6sa4oeovJ4MsSRTkcBhNCfhvv6iGv9+wkkhnBnoIPYX?=
 =?us-ascii?Q?0hk87vVvUtBiiTwYtoE1IuoeUFAZRPjD7FyTxyq9E/7XNysV2AI3kjl+u0+N?=
 =?us-ascii?Q?DvHds+1Da1P05tqymySvLLGwLyidMSz3Mj/JVHhzGWVHk7OxhpImSLWkBOyo?=
 =?us-ascii?Q?U2PXascE/C/26yUo3PD4MKLctuLeQ1e58NkbdivnkGSU3zTTl9MN1GlKPL1K?=
 =?us-ascii?Q?RzXASFFrXG4KTYBdv9kK/8Z+mfwzFNz7M/Hc1llcHf6/4mdDalovofc8/kQD?=
 =?us-ascii?Q?zWSCOkrNFsWNU+MD2oRhlVhOtSRHHcE1Vpj+mDzTqQf5BCll+YflniVZuMiU?=
 =?us-ascii?Q?rZqveMQ9FOaYTm+uGNJ6u00feY4hZ9UvAmpyMiBfApdjZk/FdpiwjPJrDGTH?=
 =?us-ascii?Q?eCCiA6L2AEqV3uWJpbnEXCD54of5anBUPazeqIKUhVNOe+L0f7YF+JbuNFad?=
 =?us-ascii?Q?JtGrkpkVMgR1CnbbD4F8+PaTJTgt2xKf2VOkqUGt2fK7LYkttVeulkZy1KaF?=
 =?us-ascii?Q?RNuXMp92pxF/g4HJGKaFe72BMaA0yJrYR6lBpBTXnrViEKebI9BT942PhUOQ?=
 =?us-ascii?Q?jJtfWGLCRrmIWM7EvEVoYopwM4GJxK4BTJX/VOwyDb2L8bfYI+IdjitJYQjR?=
 =?us-ascii?Q?rpTNfWAIjFYqaLgolK3229dOkRFbPWKJA90ar2qnftLcOg7eR5QeZKYklSz3?=
 =?us-ascii?Q?AyglK4teu1WQfhrahFahOblryowJJPLDBgSeJJUCgK7tOX8M8pXvTUK5MEKN?=
 =?us-ascii?Q?7thohOIUtP99cH6jFgN75zT6Lhv0x5YxLHzNMNx+a994gg0IDL25I3D0nQV2?=
 =?us-ascii?Q?MbjvBtXzg8uKHU7zpgpdAsG5jzSfI3JgP5okkxrBk+dm3kTG2GKa3qF0S82R?=
 =?us-ascii?Q?jHSK9GAqyKwwPPwciH7xFQfsTJTGnoeMZxipcPo4EOoPe0l6/+SBRC5uR6DG?=
 =?us-ascii?Q?+dS297kV60VlsW7/DZLkWyQVQ740e33utTfuVhguwQT5mD/cJ4LzsWlMOAAa?=
 =?us-ascii?Q?7Ky9EAFMvigohS1omR1XHMLVDrRETxMNy2GbMHCqTfwecjRzad1MMWgw3n4J?=
 =?us-ascii?Q?lxASmd8e3cpOE2LUYZ2Pv8t/J+hCzZ5wWAXA/WPiHjh4C8rUQbZZMIyj39VB?=
 =?us-ascii?Q?LLEoX/q7fFsuXewryHqz7JsfwlgixeSW3Wc+RDrsHB24zmPht+4qGtRLeetd?=
 =?us-ascii?Q?eWMNiYBeKupVAewx2vAMyq8b0BE8orakDeS35zh0IxYEP8IDQvSNNQuNzKXN?=
 =?us-ascii?Q?iQAHkpyUz2QyN/UsyoSSGOYPZJnqxjLantYChq5lGJvx/cCvoceczvY9liwx?=
 =?us-ascii?Q?GSiwwwrAibqPgsvPZ2XZ/7qSWHNdFKvPJsGBdGJG5vjsC032sYT/ue8sm/ms?=
 =?us-ascii?Q?cZpOcuT7K3GFXs7kUKb1qfKYDs8qr7JFT9hktZCfbhBOysPCAEoLzXz+IR2I?=
 =?us-ascii?Q?dAmInDNZ/QcKC9GT5rPB1W8Q2YFQCdc/KWoZgaj8BaGyw/Y9FVOkjisQ6jlO?=
 =?us-ascii?Q?h2UexF8D8st2IEkLEZg7m9NRiuofd61h/xuplDginOMuhvvFDtoSi+noyfvT?=
 =?us-ascii?Q?AY/wekil/0zJJ3/kvn6G3XClXFdmphUnSzaYAhOnw08BIf3GwZY+kpaWOYy5?=
 =?us-ascii?Q?BIlyyYd+BfFkzywryGaxQmomfjIZW5COrdZjy6b8biFH40mAX6H9UgR942qB?=
X-MS-Exchange-AntiSpam-MessageData-1: KfPSSkDrQhltGofLRU3UfR9/2KWluTiHl3I=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceed3629-114e-4d8c-d08b-08df4c8cee6a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:47:09.0026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+xu3cSS1DFXCk3n+Gr/9CB+ZPlwKqgdyWKBj/z8mqET+6cWAk1/A417fOnnirzf/YR+pqBZhfLjUJQTs2Bt9RjfklTdVJq0DNjlfZ9OOQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9260

A trap handler missing oob_trap_unwind() leaves _TLF_OOBTRAP set and the
companion core is no longer notified about traps of that task.

Add a monitor checking that every out-of-band trap is unwound for the same
trap, by number and frame, before the task resumes out-of-band.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 Documentation/trace/rv/monitor_dovetail.rst   |  26 ++++
 kernel/trace/rv/Kconfig                       |   1 +
 kernel/trace/rv/Makefile                      |   1 +
 kernel/trace/rv/monitors/oob_trap/Kconfig     |  14 ++
 kernel/trace/rv/monitors/oob_trap/oob_trap.c  | 144 ++++++++++++++++++
 kernel/trace/rv/monitors/oob_trap/oob_trap.h  |  61 ++++++++
 .../rv/monitors/oob_trap/oob_trap_trace.h     |  19 +++
 kernel/trace/rv/rv_trace.h                    |   1 +
 tools/verification/models/oob_trap.dot        |  14 ++
 9 files changed, 281 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/oob_trap/Kconfig
 create mode 100644 kernel/trace/rv/monitors/oob_trap/oob_trap.c
 create mode 100644 kernel/trace/rv/monitors/oob_trap/oob_trap.h
 create mode 100644 kernel/trace/rv/monitors/oob_trap/oob_trap_trace.h
 create mode 100644 tools/verification/models/oob_trap.dot

diff --git a/Documentation/trace/rv/monitor_dovetail.rst b/Documentation/trace/rv/monitor_dovetail.rst
index e46cd0ab0b8d..e660b5c9a1ea 100644
--- a/Documentation/trace/rv/monitor_dovetail.rst
+++ b/Documentation/trace/rv/monitor_dovetail.rst
@@ -27,6 +27,8 @@ dovetail_leave_inband_tp    oob     after a successful switch; oob stage
                                     stalled, hard IRQs off, the core may hold
                                     its runqueue lock
 dovetail_leave_oob_tp       oob     before the switch to in-band, in the core
+dovetail_trap_notify_tp     oob     hard IRQs off, before the core is notified
+dovetail_trap_unwind_tp     either  hard IRQs off, before the core is notified
 ==========================  ======  ============================================
 
 Monitor offstage
@@ -48,6 +50,29 @@ the companion core demoted the task would::
 ``sched_in`` is a ``sched_switch`` to the task, ``signal_self`` a
 ``signal_generate`` by the task for itself.
 
+Monitor oob_trap
+++++++++++++++++
+
+Every out-of-band trap notification is unwound for the same trap before the
+task goes out-of-band again. A handler missing the unwind leaves
+``_TLF_OOBTRAP`` set, and the companion core is no longer told about the
+traps of that task::
+
+                  trap_notify; reset(same_trap)
+          +-------+   ------------------------>   +---------+
+          | idle  |                               | trapped |
+          +-------+   <------------------------   +---------+
+           |     ^    trap_unwind; same_trap == 1
+           +-----+
+         leave_inband
+
+A trap is identified by its number and register frame, so an unwind with the
+wrong number, and the unwind of a trap nested in the in-band handling of
+another one, are reported too. A leak is only seen once the task goes
+out-of-band again. Traps taken in NMI context are ignored. The model uses no
+clock, so the hybrid automaton core arms no timer and is safe on the
+out-of-band stage.
+
 Usage
 -----
 
@@ -59,6 +84,7 @@ Usage
   # cat enabled_monitors
   dovetail
   dovetail:offstage
+  dovetail:oob_trap
 
 Violations are reported by the selected reactor and as ``error_*`` events in
 ``events/rv``. The models are in ``tools/verification/models/``.
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 3f43cdfcbb32..d7207d7e9892 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -86,6 +86,7 @@ source "kernel/trace/rv/monitors/nomiss/Kconfig"
 
 source "kernel/trace/rv/monitors/dovetail/Kconfig"
 source "kernel/trace/rv/monitors/offstage/Kconfig"
+source "kernel/trace/rv/monitors/oob_trap/Kconfig"
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index a684b0c9af2f..c5848be60f5b 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
 obj-$(CONFIG_RV_MON_DOVETAIL) += monitors/dovetail/dovetail.o
 obj-$(CONFIG_RV_MON_OFFSTAGE) += monitors/offstage/offstage.o
+obj-$(CONFIG_RV_MON_OOB_TRAP) += monitors/oob_trap/oob_trap.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/oob_trap/Kconfig b/kernel/trace/rv/monitors/oob_trap/Kconfig
new file mode 100644
index 000000000000..7a1709d3a8f3
--- /dev/null
+++ b/kernel/trace/rv/monitors/oob_trap/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_OOB_TRAP
+	depends on RV
+	depends on RV_MON_DOVETAIL
+	default y
+	select HA_MON_EVENTS_ID
+	bool "oob_trap monitor"
+	help
+	  Per-task monitor checking that every out-of-band trap notification
+	  is unwound for the same trap before the task goes out-of-band again.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_dovetail.rst
diff --git a/kernel/trace/rv/monitors/oob_trap/oob_trap.c b/kernel/trace/rv/monitors/oob_trap/oob_trap.c
new file mode 100644
index 000000000000..47e7ddd95aa1
--- /dev/null
+++ b/kernel/trace/rv/monitors/oob_trap/oob_trap.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * oob_trap: out-of-band trap notifications are balanced.
+ *
+ * Copyright (C) 2026 Siemens AG
+ * Author: Tobias Schaffner <tobias.schaffner@siemens.com>
+ */
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "oob_trap"
+
+#include <trace/events/dovetail.h>
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+#include <monitors/dovetail/dovetail.h>
+
+#define RV_MON_TYPE RV_MON_PER_TASK
+#include "oob_trap.h"
+#include <rv/ha_monitor.h>
+
+/*
+ * Both trap tracepoints fire with hard IRQs off, and NMIs are ignored. A trap
+ * is identified by its number and frame; on 64-bit, kernel addresses share
+ * their top byte.
+ */
+static DEFINE_PER_CPU(u64, oob_trap_key);
+
+static u64 oob_trap_key_of(unsigned int trapnr, struct pt_regs *regs)
+{
+	return ((u64)trapnr << 56) ^ (unsigned long)regs;
+}
+
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_oob_trap env, u64 time_ns)
+{
+	if (env == same_trap_oob_trap)
+		return READ_ONCE(ha_mon->env_store[env]) == __this_cpu_read(oob_trap_key);
+	return ENV_INVALID_VALUE;
+}
+
+static void ha_reset_env(struct ha_monitor *ha_mon, enum envs_oob_trap env, u64 time_ns)
+{
+	if (env == same_trap_oob_trap)
+		WRITE_ONCE(ha_mon->env_store[env], __this_cpu_read(oob_trap_key));
+}
+
+static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
+				    enum states curr_state, enum events event,
+				    enum states next_state, u64 time_ns)
+{
+	bool res = true;
+
+	if (curr_state == idle_oob_trap && event == trap_notify_oob_trap)
+		ha_reset_env(ha_mon, same_trap_oob_trap, time_ns);
+	else if (curr_state == trapped_oob_trap && event == trap_unwind_oob_trap)
+		res = ha_monitor_env_invalid(ha_mon, same_trap_oob_trap) ||
+		      ha_get_env(ha_mon, same_trap_oob_trap, time_ns) == 1ull;
+	return res;
+}
+
+static bool ha_verify_constraint(struct ha_monitor *ha_mon,
+				 enum states curr_state, enum events event,
+				 enum states next_state, u64 time_ns)
+{
+	return ha_verify_guards(ha_mon, curr_state, event, next_state, time_ns);
+}
+
+static void handle_trap_notify(void *data, unsigned int trapnr, struct pt_regs *regs)
+{
+	if (in_nmi())
+		return;
+	__this_cpu_write(oob_trap_key, oob_trap_key_of(trapnr, regs));
+	da_handle_start_run_event(current, trap_notify_oob_trap);
+}
+
+static void handle_trap_unwind(void *data, unsigned int trapnr, struct pt_regs *regs)
+{
+	if (in_nmi())
+		return;
+	__this_cpu_write(oob_trap_key, oob_trap_key_of(trapnr, regs));
+	da_handle_event(current, trap_unwind_oob_trap);
+}
+
+static void handle_leave_inband(void *data, struct task_struct *p)
+{
+	da_handle_start_run_event(p, leave_inband_oob_trap);
+}
+
+static int enable_oob_trap(void)
+{
+	int retval;
+
+	retval = ha_monitor_init();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("oob_trap", dovetail_trap_notify_tp, handle_trap_notify);
+	rv_attach_trace_probe("oob_trap", dovetail_trap_unwind_tp, handle_trap_unwind);
+	rv_attach_trace_probe("oob_trap", dovetail_leave_inband_tp, handle_leave_inband);
+
+	return 0;
+}
+
+static void disable_oob_trap(void)
+{
+	rv_this.enabled = 0;
+
+	rv_detach_trace_probe("oob_trap", dovetail_trap_notify_tp, handle_trap_notify);
+	rv_detach_trace_probe("oob_trap", dovetail_trap_unwind_tp, handle_trap_unwind);
+	rv_detach_trace_probe("oob_trap", dovetail_leave_inband_tp, handle_leave_inband);
+
+	ha_monitor_destroy();
+}
+
+static struct rv_monitor rv_this = {
+	.name = "oob_trap",
+	.description = "out-of-band trap notifications are balanced",
+	.enable = enable_oob_trap,
+	.disable = disable_oob_trap,
+	.reset = da_monitor_reset_all,
+	.enabled = 0,
+};
+
+static int __init register_oob_trap(void)
+{
+	return rv_register_monitor(&rv_this, &rv_dovetail);
+}
+
+static void __exit unregister_oob_trap(void)
+{
+	rv_unregister_monitor(&rv_this);
+}
+
+module_init(register_oob_trap);
+module_exit(unregister_oob_trap);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tobias Schaffner <tobias.schaffner@siemens.com>");
+MODULE_DESCRIPTION("oob_trap: out-of-band trap notifications are balanced");
diff --git a/kernel/trace/rv/monitors/oob_trap/oob_trap.h b/kernel/trace/rv/monitors/oob_trap/oob_trap.h
new file mode 100644
index 000000000000..7d73dc10560f
--- /dev/null
+++ b/kernel/trace/rv/monitors/oob_trap/oob_trap.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of oob_trap automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#define MONITOR_NAME oob_trap
+
+enum states_oob_trap {
+	idle_oob_trap,
+	trapped_oob_trap,
+	state_max_oob_trap,
+};
+
+#define INVALID_STATE state_max_oob_trap
+
+enum events_oob_trap {
+	leave_inband_oob_trap,
+	trap_notify_oob_trap,
+	trap_unwind_oob_trap,
+	event_max_oob_trap,
+};
+
+enum envs_oob_trap {
+	same_trap_oob_trap,
+	env_max_oob_trap,
+	env_max_stored_oob_trap = env_max_oob_trap,
+};
+
+_Static_assert(env_max_stored_oob_trap <= MAX_HA_ENV_LEN, "Not enough slots");
+
+struct automaton_oob_trap {
+	char *state_names[state_max_oob_trap];
+	char *event_names[event_max_oob_trap];
+	char *env_names[env_max_oob_trap];
+	unsigned char function[state_max_oob_trap][event_max_oob_trap];
+	unsigned char initial_state;
+	bool final_states[state_max_oob_trap];
+};
+
+static const struct automaton_oob_trap automaton_oob_trap = {
+	.state_names = {
+		"idle",
+		"trapped",
+	},
+	.event_names = {
+		"leave_inband",
+		"trap_notify",
+		"trap_unwind",
+	},
+	.env_names = {
+		"same_trap",
+	},
+	.function = {
+		{          idle_oob_trap,       trapped_oob_trap,          INVALID_STATE },
+		{          INVALID_STATE,          INVALID_STATE,          idle_oob_trap },
+	},
+	.initial_state = idle_oob_trap,
+	.final_states = { 1, 0 },
+};
diff --git a/kernel/trace/rv/monitors/oob_trap/oob_trap_trace.h b/kernel/trace/rv/monitors/oob_trap/oob_trap_trace.h
new file mode 100644
index 000000000000..fcb2f5bc6965
--- /dev/null
+++ b/kernel/trace/rv/monitors/oob_trap/oob_trap_trace.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_OOB_TRAP
+DEFINE_EVENT(event_da_monitor_id, event_oob_trap,
+	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(id, state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor_id, error_oob_trap,
+	     TP_PROTO(int id, char *state, char *event),
+	     TP_ARGS(id, state, event));
+
+DEFINE_EVENT(error_env_da_monitor_id, error_env_oob_trap,
+	     TP_PROTO(int id, char *state, char *event, char *env),
+	     TP_ARGS(id, state, event, env));
+#endif /* CONFIG_RV_MON_OOB_TRAP */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 9bda8ef3b96f..bcd7ee424e89 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -190,6 +190,7 @@ DECLARE_EVENT_CLASS(error_env_da_monitor_id,
 
 #include <monitors/stall/stall_trace.h>
 #include <monitors/nomiss/nomiss_trace.h>
+#include <monitors/oob_trap/oob_trap_trace.h>
 // Add new monitors based on CONFIG_HA_MON_EVENTS_ID here
 
 #endif
diff --git a/tools/verification/models/oob_trap.dot b/tools/verification/models/oob_trap.dot
new file mode 100644
index 000000000000..97ef5c3b9431
--- /dev/null
+++ b/tools/verification/models/oob_trap.dot
@@ -0,0 +1,14 @@
+digraph state_automaton {
+	{node [shape = plaintext, style=invis, label=""] "__init_idle"};
+	{node [shape = ellipse] "idle"};
+	{node [shape = plaintext] "trapped"};
+	"__init_idle" -> "idle";
+	"idle" [label = "idle", color = green3];
+	"idle" -> "trapped" [ label = "trap_notify;reset(same_trap)" ];
+	"trapped" -> "idle" [ label = "trap_unwind;same_trap == 1" ];
+	"idle" -> "idle" [ label = "leave_inband" ];
+	{ rank = min ;
+		"__init_idle";
+		"idle";
+	}
+}
-- 
2.53.0

