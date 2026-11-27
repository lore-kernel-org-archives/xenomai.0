Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795787235;
	b=OWNveZKxenQi8apiR3GM+y7tmoWJGAIj36InQsoMBl6yaNQRWTa2W3/i2Jl8CPmv3eFD
	 itchs310aQ6KfBGXTdeXudWXJaIUK2X+ptJeP4w5mDq9YEHlwTrd33vi6Fc3HAT+NoR0o
	 w13ps1N58xpJcIGXxne8ZNyRV0taeKFR/G4m2EPPlGDPuTU24rX7FjXTGHmBFwHaLWete
	 i+QaWuZXxS//d3bSBMeyxQ3REz2feXrCQBIRZxB5ErrRp2djIdBTBG4dklEMQ8hiUSNJh
	 Yd4Y5EU3f6XA1p3a/bxn68Cjb9HNSr7HOnvXHJ532FAJzzRHwTadJKpTeRzsNIkGmFA==
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
	bh=0x5nwG2+mRQJQz/GXZTNbP0CxNFnF+V2VcBzNx3Akwk=;
	b=GojgZ6JHgb22rIMRYZq3qYQbviXcbwfGz+jng6fVxIcCwOBbYATWNy2LCwXR1wzRxy18
	 a5uHu6sMehyD17r7+S9cpx3gx9Qixa58msCEbrIPk4KcjpFTmP/it+5KN2jCb+s6/boi7
	 pWxncJIlY5ugPcDGo25hqVmQKI+iMYRO1y9csxLEkL1IVCcgJvsZd0V+fJUJ6M0VX3k5i
	 I7mD3Pj4U/AI8NLOvD9Ea5pB0cEkGEEycUKL9wetZ1FxQdgwKqCaIMmUiAmRXImwKjl3z
	 Slqiol7Y6/nOiFd943MsgHDh5WHgruk+hFQcTo8eHdmOOlNHs8BKUM61MF65K05h67w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ngZT6Lwt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.66
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C15606A324
	for <xenomai@lists.linux.dev>; Fri, 27 Nov 2026 13:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60C15606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ngZT6Lwt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lrurq0qOBvPRq27cQA8EALA806MTDDoh76zrteOi8OhJjYPm3ACpsk/KkEjzsk7jKWEKVhYMPoDN143Vn2dEVldHORb253s21PqI//L1DsH6BjWEES6i7PBOUw2p9Ex9C/xSW/hZsDBcSQqgnIpAU9GdJMljy+1dajV+sDPksLshFEq0m6WkoQSShHPmSbYmgCUKDEHriFBonFTlBW863QNn6EtEV751pwQSCrLHKRPkMaQUuQG74fzOlD3H0n6qy5qAw0gWxISCwfwqtVoNqdxiadQf+L3rqmjX9plOQijS2RI3Yjk5OxQvSniwCt7glyOkRfwCwVestNPiIoYAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0x5nwG2+mRQJQz/GXZTNbP0CxNFnF+V2VcBzNx3Akwk=;
 b=BvR+x4ZhvQNAUoZ15hT8DZqcljWnsWiYAcFGLeMN08d7xH53nCkt3cHnHCMdTXjRTJrpf1yvfmJGb0p6FtcxP/eX+Or58ieHxOL/Ww9bs4Kbr3hu+O96W9JnJgoadRL7HSx/kOoeA8j5jooj06iPv8GShPdlDMjWxtGuK9CIhwXgwnLba9atpc5py//c0I6JSwJ3/YVu0OduAW192Z+XRj8fCL4LGTXfm46RCvp/HtGMpyCnAfy324k8sFMeMadORJ4G9YB8pClK6b+mo9ldJPupLIU2zFgO0vvzM+nR/K6pHKiNzfEZqu8VazoLxrsKR3XkHdjbYJqzwz3owq+7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0x5nwG2+mRQJQz/GXZTNbP0CxNFnF+V2VcBzNx3Akwk=;
 b=ngZT6LwtSK1WwFX4lgBEDXkvea7QU62glMK2ePypvlL7GytXe2mB2XVZKcZuy8ttJa3zsnyzD+T+xBQ7aprX9Zd9vSwZJz/vc4e3eyCszpqtf078NGJgqVC8SycBMVPHOh0QPXBJGQbot5ZuSCUFQ2Rxcc7ns+9XH5dOXOJOq+/2VXzoTtKrY9r9Sb+sSpUM613eOxwtHJh7Dw7phZFu3jjIZERFAbeKfaGyVhur7ryXG0XMr2bWLBkxBbPF2o13eQHPAqABsVd7zQWA1Tv7dR+S6D+PqZJdoWO/OIkWw+fG6Pz3B5ieThnjglDaCEtWlvrC6Jcnyna2tvydHmKaJQ==
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
Subject: [RFC PATCH dovetail v2 6/7] dovetail: trace signal notifications and out-of-band returns
Date: Fri, 27 Nov 2026 14:47:24 +0100
Message-ID: <c3260d300cf40effc9ad20c328186e4a452110ff.1795786695.git.tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: b146d796-1f52-4b92-4789-08df4c8ceea7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|1800799024|366016|22082099003|55112099003|18002099003|261021123027099003|56012099006|261021121427099003|261022105027099003|11063799006|261026121527099003|261028144727099003|261026140227099003|261009223027099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	kqH8qZsRzkNTkd++0DMQbw34OvRKLoJbZa6adT+JhXO4WxxlvGBI2PnFvcTNi2ko9laWTa9D+q5pIt57Kjlj0CWprEjOM4Z6iU3hfdWgLDFAeNBIEYA/4a2JORPVvlHWfRgWEr7F7wjWo0Ikl6CJxY1u+WcmX42xFPUo3nmLD8LZP2yXKBFulg+JuuwnyAeIfvZey7ct+AcUTJhiw5eqLkDUaLt0ews3mEc7lggLsQim9975haiwmgBpoPTAQp0liauQkTX+954vb48ZhZ4e7XCXBDset9RGcINwW1LiMm+JywpE/21dehDgQ4ZsrmuIT0UuBZJ1ia8EiFPu29pZh0KoEjulv3/JeBCGMrpKSr5IV+5NVEJdg72uUppSr8A0RQv6hIGlYfOj+bgTXPudGff5XTtsdo0StjTzYnGOy4U0FHNEpkAvW4Y/ejT+DqCo4E5ccejWzhB/nlZlS/HdmyKY3oqdnPZeW/8t14J9+nMS0YJLo5FxyhO3luLw+HeXI40yLOl6SOpBmDoCJ/uMDO1zK+Wc+8gREonzoc22fZN8S6ZlIwvkoeo8rQbW3OBNYDDiRA7jesYm5A7+EF5gjCKoytBnFzSC/8kQPhEbD0mpNpPhIgaskpSuNXn0uHD/VgHLN5RduWQ0EwvUoQEwAp/dDGRI0GF8y2RkgyRsfcY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(366016)(22082099003)(55112099003)(18002099003)(261021123027099003)(56012099006)(261021121427099003)(261022105027099003)(11063799006)(261026121527099003)(261028144727099003)(261026140227099003)(261009223027099003)(10067099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GzNntbZ7vEjKW1m5XAXcklISXDPtZ3dqpD5ruD3YDWuNqChKfo7+2H6Eo3IL?=
 =?us-ascii?Q?hMbuKUvVVgRb1s0RBq7hPzTiQljCoyuxD0ijijkWLreJ9cKy9fZJPwt4o0US?=
 =?us-ascii?Q?eIRN5g7wuWTj9W4YQiWSaksdd9zkEHKvxY5Vtee08eFF1lsKodRanyHIZlS/?=
 =?us-ascii?Q?xns98MD8JeNoinRb9FJbM9Vx6Otm09xowXKKfM2xerUlXQ7+EASshIksCCxr?=
 =?us-ascii?Q?jzeYbDEaLwhAJP4JIBtGl9aRLdo3V+N7R1rnR8uhjr12RJMXnQ8OuLzVSIZq?=
 =?us-ascii?Q?wv9DzARH5h+YeFaVP6cssVWWqEwTqgakJWC3JydkX2N29nIWBb3PrLahDTrA?=
 =?us-ascii?Q?8VXVD+JsKypGUDlRseguBidQr5nngpvLuECek/ajw1f5I9HXlv+K5ixSeNzP?=
 =?us-ascii?Q?hlBZQWodlhl6g6etMBPtUzhgIeoYUjzIyfLV3Gar5TZ0HRg658FW2B77VxJ3?=
 =?us-ascii?Q?nQAC0aNvPtAQ42cjscNOARuyiMJJGtOBcDi+AWZpeyqHcQiuAgqaLqcTcE6z?=
 =?us-ascii?Q?jg5ejTmWVgoBn7eDVBL07l76iC+EXLsJz68DiPMW7kF16gggZwzh5tKE+Q9N?=
 =?us-ascii?Q?IQjkZvBswn3FCVkOr0wNgmcUFjrouArvq5AqQp9YIqdRcPxVCsRmqeM6n36j?=
 =?us-ascii?Q?la4DAArx61sqk+LtkMYdoe49+a9jfWdQAqDAvZUGq2CPDTtdRfin7dQ6I9NQ?=
 =?us-ascii?Q?7EHGwxxOVuuY5KYcWOtk82WmXZ/g1GbmgNe+QBPhZ/GWAO/OMH5nn+MahZY1?=
 =?us-ascii?Q?q+FuNG6nSX9p8klGJjKRyxehy+PcVv3YjlPsTcoW9Zo5BneDEeuPpzhebINX?=
 =?us-ascii?Q?x9pbWnJMz4L/BzMUKT/ac/svCKGW+E/tpQt+JPHonnS9uy16lecexbIwSofH?=
 =?us-ascii?Q?vXa93TIgR9tvLAKGUFB/SGgRWMdfrSu3bGT3IUT8HfchH1kALwOfq88HjiFT?=
 =?us-ascii?Q?pMa+fE8uNMnvpNzyZjnnYdhAY3q1oCLiDaur5ABHbBjiEC4mg66D59SkOdLM?=
 =?us-ascii?Q?0b2/W/DXSS9A7u0CB/7U13aEnoc8HQGYkv9S6vU1SerYYQ+En/qYIp3xOYqu?=
 =?us-ascii?Q?Z/oB6uUdK1rTbLl2Htd5zTXC3+yTyohA8Nod0Pn/meNP9rz1J5vJJBOYu1sv?=
 =?us-ascii?Q?R/ztrSrjD3BkYLyx3fclvFAfiHOrc1mIicCTWaokCoxI9c8rZzLHE1MH/Owa?=
 =?us-ascii?Q?ozp7tWd4aRlaYNJRDab49ktYF+ofCxhOyqG34aKuGO1emxlo089heRIakcLY?=
 =?us-ascii?Q?w36KxTIwymcM1o3I2bH1nP8Z8b2poerxC7RclkBPomR0DMJ6y6yLfK5j2l3q?=
 =?us-ascii?Q?+4yuMMpvTwyXK6so5STMFcYqU6xZlNRwGzYhvt4Vj9gfl7lcVe17u6AOlE6G?=
 =?us-ascii?Q?B7bn1TR7UZgTn8rMMFiM4w7K7nxL35vaTjAULF1yQ3t1HbP0BmDBpzCuc5WY?=
 =?us-ascii?Q?d27MDSblFiGFX6NQHIcX+dk+CBmKpmWoHoy+Szf2rpeyKB0GUHo0psvoq6xm?=
 =?us-ascii?Q?j661bJV9p6kQza8MaXHG3jzwZLbyXp8YFNterzOT4yYfMv9Lf+YpKLjJ2ILp?=
 =?us-ascii?Q?QFYfOEgYg6tGYRZdgvPXS9sJTK5ujlmH5t/dJThNi+k0pG0Uv6aVghTg8gx2?=
 =?us-ascii?Q?hAwpSITSPrN+6trWzY3uiFD10qgslF9TikW02PotlZyKHjC1eObv5DzE/EfY?=
 =?us-ascii?Q?7Jy9qFqVdGlTqAmCC9T4TosZhqhb2ubyL5XSToR0Qv2Dft+lZNflOjWyLeDr?=
 =?us-ascii?Q?W88bERgMhEO/x/HVlbpNIM0DvHW7Uau5Zv6XplAcePtY8WREmufW/zeJOYZF?=
X-MS-Exchange-AntiSpam-MessageData-1: 3W7ugmaEm9cO6VPreik7K0YqXCBEEXzT3Qg=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b146d796-1f52-4b92-4789-08df4c8ceea7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:47:09.4438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfXxtPDhU+vMgwtBYApDR7E3d1pbYXoizSyW3pCu2Hb2UTKyGf+ih242HnvKq/o55pCatsUFNc1c7nfjpkXzBBkX62jGjXgKBYtWEcSa8uc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9260

Add a tracepoint for the signal notification to the companion core, fired
once the core handled it, and one in dovetail_oob_exit_to_user(), for use
by the oob_signal RV monitor.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 include/linux/dovetail.h        | 8 +++++++-
 include/trace/events/dovetail.h | 8 ++++++++
 kernel/dovetail.c               | 6 ++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/dovetail.h b/include/linux/dovetail.h
index 3c079e5bf373..6e1333956a3c 100644
--- a/include/linux/dovetail.h
+++ b/include/linux/dovetail.h
@@ -85,10 +85,16 @@ void inband_event_notify(enum inband_event_type,
 
 void inband_clock_was_set(void);
 
+DECLARE_TRACEPOINT(dovetail_signal_notify_tp);
+void __trace_dovetail_signal_notify(struct task_struct *p);
+
 static inline void inband_signal_notify(struct task_struct *p)
 {
-	if (test_ti_local_flags(task_thread_info(p), _TLF_DOVETAIL))
+	if (test_ti_local_flags(task_thread_info(p), _TLF_DOVETAIL)) {
 		inband_event_notify(INBAND_TASK_SIGNAL, p);
+		if (tracepoint_enabled(dovetail_signal_notify_tp))
+			__trace_dovetail_signal_notify(p);
+	}
 }
 
 static inline void inband_migration_notify(struct task_struct *p, int cpu)
diff --git a/include/trace/events/dovetail.h b/include/trace/events/dovetail.h
index 86d6405e84f5..6ac5a7fed420 100644
--- a/include/trace/events/dovetail.h
+++ b/include/trace/events/dovetail.h
@@ -26,6 +26,14 @@ DECLARE_TRACE(dovetail_trap_unwind,
 	TP_PROTO(unsigned int trapnr, struct pt_regs *regs),
 	TP_ARGS(trapnr, regs));
 
+DECLARE_TRACE(dovetail_oob_return,
+	TP_PROTO(struct task_struct *p),
+	TP_ARGS(p));
+
+DECLARE_TRACE(dovetail_signal_notify,
+	TP_PROTO(struct task_struct *p),
+	TP_ARGS(p));
+
 #endif /* _TRACE_DOVETAIL_H */
 
 /* This part must be outside protection */
diff --git a/kernel/dovetail.c b/kernel/dovetail.c
index 0f7dae3beeda..93fd35828ca5 100644
--- a/kernel/dovetail.c
+++ b/kernel/dovetail.c
@@ -20,6 +20,11 @@ void __trace_dovetail_leave_oob(void)
 	trace_dovetail_leave_oob_tp(current);
 }
 
+void __trace_dovetail_signal_notify(struct task_struct *p)
+{
+	trace_dovetail_signal_notify_tp(p);
+}
+
 static bool dovetail_enabled;
 
 void __weak arch_inband_task_init(struct task_struct *p)
@@ -110,6 +115,7 @@ void dovetail_call_mayday(struct pt_regs *regs)
 /* Returning to user mode on the out-of-band stage. */
 void dovetail_oob_exit_to_user(struct pt_regs *regs)
 {
+	trace_dovetail_oob_return_tp(current);
 	if (test_thread_flag(TIF_MAYDAY))
 		dovetail_call_mayday(regs);
 }
-- 
2.53.0

