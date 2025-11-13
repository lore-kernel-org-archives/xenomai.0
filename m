Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A64B34D3AF
	for <xenomai@lists.linux.dev>; Thu, 13 Nov 2025 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035823; cv=fail; b=MtWJOd5yyNSmOCyi2Jr8dl8Ijiko7/yt+nzPeqlVr2SekXW9bph0+s2C2OmhIewtsW/eO1wDrlFamuG9hI6OyUx0b3md1VfJXUBbFYSsZZzGQG9oS7+GTV6j9x+3yas3q7KvkQpRON0sJ9mdWz2Xy7YiyjNRxrZu0dPnSgTT7HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035823; c=relaxed/simple;
	bh=HLaWrd348J9wiKUCHvHI/qmzbQtEPo0ry992lAhpy5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rF/qGVUSDC1wm+JgSzWxZYVRou0HHhslprTGbmaBocV3yJtfWQXOjcn8EQnuVd7dNMT1lS99/FkM3Jthwct0AXv91noUPzjyY4ywj/gPvIUuiN+6j5Taf8QFnGOc/IRpgoTlr0/L1b/GReDq6U6mvlcp/eR+ezRJCzqaHVwe2Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xPapvgfI; arc=fail smtp.client-ip=52.101.66.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xPapvgfI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yS9uR8BwvmAYPlWIHefbOeagHKwH+uAbmtkW5+vFN/QL9ValzJYpxqIIbtkMwNN3BXFi/OtgG7IeAGTIIc7eCP4tSuCTcIYikWyHcj+/VMnqg3PpK0gkuOonxmSSB/UBjzDiIDqJfuQetWpagnDy8De71wjnTC+3vkjrzGeHb/WCHJSQr1xzUojidfNUNpiXBxL11OrbN6OqtqSyvNDXW9uEBYizYOM9iYHs8gAEjZgrsODfhE09LhkXZyGEEfDQ0LVJv2f+ZzJIdtx3Z7AqxKyVX7AmtDWCepik6jWfgEZogIixWZI7o+T/hU/3ILEtO02G/E8TfcMjI4Qfe84VXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQHYrTopBbIZQ731pmDrFWAbbpOPWD/d4cGp3YGJwEo=;
 b=JHFQK6f3caV/cNt0mYql9OLRfr4nW7UfgMuVwg8FvAl1eIQ4m9DmJn8JP2/0gBHSTjySFcC2RnTSLKp9t0qjnuZM0zVGkzG44xKmfBDN/iD8EeCZZAl/VZoDPSxyAzOgEkNjMt5rlDUdTvW9WBHfddBG4HPn6a1ifO9OMKJUZ2LwLfurlsrRbNcbaIWh00z7dGVadNT3DoUIyMgzc8TbGqedotNgiogXzH0tnt/xLKOc1+NnBM7hgh1TwwLgcJGlBldFGUvXSy0Eb9/uMrPCmp2a8x85V5WbSLZf0wDFNW5SEi0fHfzGFBYWeuelAWumURMDeR9tghdt0ZiIXU/2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQHYrTopBbIZQ731pmDrFWAbbpOPWD/d4cGp3YGJwEo=;
 b=xPapvgfIgC+0BLAJXmxSEGtMQgfUXVruWxZ0iFJU5ee8DwuVf7GYWWsU4SnXkA3CnNPtjJPUzZi8gDFRGqUBlIKB55N2MWelVbC70C5Bu5OSuFgxe0DqhaUHEjWg3gLeA8ax3PZ0edAncV+9tbnT7y8EL/8N/3n5mSmV9+6+UAO4U15cDQrhNywo5QkXkgqfx9Gv5ppx3qicgM7PWTTAJD6Sywy90WpVV1Ma7UBqvxhhtp9dvCbcrrAaMHiR1DcbWN5viyXx4L0CU3xdIG/SfNYc4+zRgJ1ixsmvEPMaNGLyYTPdrgQObvk3K59m0rI79qZNhkBVQZWmvctUuXedDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AS8PR10MB7859.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:633::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Thu, 13 Nov
 2025 12:10:17 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 12:10:17 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	shannmu <shanmu1901@gmail.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v3 1/8] riscv: fix interrupt enable/disable order in native_irq_sync()
Date: Thu, 13 Nov 2025 13:09:56 +0100
Message-ID: <20251113121003.416012-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113121003.416012-1-tobias.schaffner@siemens.com>
References: <20251113121003.416012-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:610:118::10) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AS8PR10MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: e908948f-116d-436b-9143-08de22ad9ba8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZiTVVExyPe8yPXW7sYwqGPpqoplLqeEU7Grjiy42DLes3AKzp8mvlVi95fc9?=
 =?us-ascii?Q?tbuH/+bFyHhf7EuLLbFjuV1mND0eTta/m+gvdB73xnMkkeN6YfV6yNHp2q0d?=
 =?us-ascii?Q?jd7ElpDRGMeYLUc6aeRKa2XgMPInkN/0C2XiN5yEioyb0rZUqiaxiW3Pdhcm?=
 =?us-ascii?Q?KL9FbLgC8JWsFxjCpmEsxKGjvfalQzdC/hL2b9v1Me6yL86NAST1TIhYASgp?=
 =?us-ascii?Q?1AHVJg1+qOe1Rc3DkFS4pWGcYkAOCtVHA6aR7yZBK9DYqsJhFnicW2EOzJmm?=
 =?us-ascii?Q?mawSfdvbSW/GWdE//7Xw2rHY6/iSHiu2OKQtckXaTKYBrx0+P9x6j7I6C+wr?=
 =?us-ascii?Q?z6sVT+qWkS+CrZSBxh8qiLCKDIaOpmYHK1h2Iu/QMxXrjn2yuZ/UQsjyDIgw?=
 =?us-ascii?Q?suVk8jT5REfS4FprCGm9zcq5AMl1tufRPXMU8WQo1UA1EfetiQAd5rFUXtFO?=
 =?us-ascii?Q?dSfFJX+DGBCqwSwOx1eJ5Pq3AY8rEin/VpghwKXgzFxFFhsdTbqsRdViVoQm?=
 =?us-ascii?Q?ZxkDTa0Boo+uC9JBPk9PO7DUS27aBhQcPrTfIHxBglU48TUmSy6cNw/Sa4v5?=
 =?us-ascii?Q?8+qKE/CY1N0OYk/jgN7Qcf3mQ/8VJjSaqK2cG92FnKenVrMkkGEpy5SoSW12?=
 =?us-ascii?Q?qeysQn5qjxxht44gdiZYvCzDBfgYXadVTH/vCFIQIwNtjmyQVbreG3B3UHdA?=
 =?us-ascii?Q?WKM8Mox0aDEGBhf/QPPDOFr5pBfGRacqOZ/R4R/y/XX7x07LmCfFj4TehsOI?=
 =?us-ascii?Q?yfFWLIzncbm/xye7jPlzfAZUhdgpWpEe05BS4vEjotMYx17KYmANilk2ACeB?=
 =?us-ascii?Q?T8CDbBEY8XIHcNAa/ARNtBvZobBViC1sWK0R5ujT/L9sGjXkzxC/2oOsXWUm?=
 =?us-ascii?Q?muHP5NJJbxXZ6IOjzd4hVxsxFZeUiHh+evCMUMo8CsoJcf94ybBkucICf7E7?=
 =?us-ascii?Q?LmaM8zt56SG8Aa94PBsrPgRiTsCrkvraSMwdnYcy2ShgFt3dCo0GAosfDFqi?=
 =?us-ascii?Q?WHD/SOXmfdSD2E4bkGFky+YP1ZIzimr/vHvRWFqeb9rz8JT9GX2QXzPO0vgY?=
 =?us-ascii?Q?CbuCW9NWb9XbBmvC/ugagDsQ4kZDT6w9NiU0meG9j2/NuYHJQ9Mqthf6GVzi?=
 =?us-ascii?Q?uHXt062sFfym3NFQc9xi+73uSbIvxbZoKVFcFRnVCyoeByWYqTPLOSgkjWK5?=
 =?us-ascii?Q?Yd4zsbAzk6aHJ5M4pDUv25v5Y6/K1FvFSaLbvTahaqitcpK32Qvm9hS5i7fC?=
 =?us-ascii?Q?n3lBwiT2ViDVM31S8dYL5n4YIDwOS7cgGXAyvNbb79lkH97YDJed4dHbaeH1?=
 =?us-ascii?Q?hPoqVvwexeBDUiJZRTg4noxwcGfWMHK5QEMO4JGbHvYhmqmJSTYXzXRbK/Hn?=
 =?us-ascii?Q?x845nc6q52H6Gd4+4ASbb9Ivg5nVhTPlYCEPBVO5fIy0ExxDIuMpkAuSG02U?=
 =?us-ascii?Q?aUqs6Xj0i8O7kwz6ngmfB7bCLYMGjjVJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cs2DKUi39j3Ap3aftpYzyu6mf2GujRU6N7qEzC0Mk6GQGAroDHq+uZKQ+E2W?=
 =?us-ascii?Q?AedP71s7L6nClN+5f68WCfb2/mbYtduq3kYJ10Wk/cZaRsLgh6KmcjLdzVDZ?=
 =?us-ascii?Q?wG6u32C9N/NxiuGxyGvmX02YwOh0MUCuxN6G0mDlKovVgTOkVxDu0c5ig1yB?=
 =?us-ascii?Q?skWO/JyOPGWcVY5ws32eTPJlUdteihZ2oKPPez3P00Ego8qXzTEbs+qLFW4M?=
 =?us-ascii?Q?skJM1oHldbLDrifoEAaSOF4EO5us7xU/qqLHPEoTU11bG9fj09n90H4fjZhe?=
 =?us-ascii?Q?tSVkC7U/7iN0icbYxeihx4Ilq6PolSNxNGHLDZpJFI3WRvqQL3g71i0DgOrK?=
 =?us-ascii?Q?j4XhaZu0D5qwVdvVHggjoeuOuoVwwsIErRcfUnfxMRKNGgwFhABHNM5kaJd2?=
 =?us-ascii?Q?vSHIMz7dqsowhmqDWjxHyl3kLnqt42oBe/5+nuzJUlP6jTjz4EowABfhzggS?=
 =?us-ascii?Q?phN5VbeaGbvb5TLgAL4r7iR89mPO4q/GISFW2izlwWyC+nTIGndLxsUCb0SR?=
 =?us-ascii?Q?nJE+HNDmdPNuKiiYG7+EHA4ZmHTD32rb25E4YWK+uzjNYV1tuft9H/NRoxbL?=
 =?us-ascii?Q?1s7WMwAysM9bWR9+nZRLaFZPMfvF5+ufPnz/hvr8ZxtLFtKsKyNosX/nlf8O?=
 =?us-ascii?Q?PEhzv6LDSsJ/RtvQvKa+Io1zLukhZoi4pXICau8TJYf9+YWltSxYaXFht4ZV?=
 =?us-ascii?Q?+amZpK9GNtN17soM8X7OjiNsyCgu4ooIWCphf6MfwLuRwEE8bYRz8T60Lzxj?=
 =?us-ascii?Q?x3tEhmAMK5hSWAp0ClecH/NMzwAFaUTKKoo6JkQnugW9Qiwo4H/wUzMlkYin?=
 =?us-ascii?Q?k+3sxHSPiBWVF2dDfYLHPxMjoQauAOUAV/uIjJyoiT0H2Rw15VqmGHpQvCHu?=
 =?us-ascii?Q?Sd9SV/tlYupXYh35aqoVdRsF0jg1ABi+09+y6RGlz+kPn7y3rrE6dzHInGH2?=
 =?us-ascii?Q?3zUiv/sdhbgyuTDPprxos/Y63rMmRBswJ2mAxzLLVU/d0nJ10Mr/YnVtR1Vd?=
 =?us-ascii?Q?cV58lQIDpqbe6xqeT8+WORmzBrAb3sdQ+O8awF/meoKLz8mm3r0EKcFwJRja?=
 =?us-ascii?Q?Z7O45Go+MyjUtvaw2FfHiNZSGjEfSwSSn6GO8ETDXne2dwVAIfZSIAsbkLSY?=
 =?us-ascii?Q?78U+Nyg66p5mkJ4/FNh4G9993pQZXl4btwXcXspgD/uWyEOimJCrif4yZfoo?=
 =?us-ascii?Q?3HtQv8FdKXyL2lPBnxTSR1xywIHJ4rHbT3XEqMYq8MOj0m//STFuRQWz1Mvm?=
 =?us-ascii?Q?rgfch7mzuI5ei/mJbEiopG4IDPDlkeOSXVAhrb5p3oSGp2J8hmtbkGs5QKq4?=
 =?us-ascii?Q?y4riHxYy+N9NQwDFSVLqMTmviRCMtA4P1xWinjLQBHSwpBOSSBLOrwaeVOLK?=
 =?us-ascii?Q?R9bdDk4NB9S6Gn/DBLZ51tuKLBRe5vhKpiuIPoPwpDJUjAsB8WLs7QmaySPe?=
 =?us-ascii?Q?6tBfWrDeC9DSTEQo3aJxjeL8lPkn0P+5dVtffxHzJ4PNFh8F3vfa5tc0xscK?=
 =?us-ascii?Q?yE3dlarcNIqSWl/DMzNb+VslHmgQBm4agXHE/NsFLFi9BQaZdKDFYEz/2O22?=
 =?us-ascii?Q?vKvKa1rG6G8+nRgN1HsBXOXxZBi8bfC8y0ZBsfjy0LmiaKfupB07YNNkIBRy?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e908948f-116d-436b-9143-08de22ad9ba8
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 12:10:17.2238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bAWhF1FxnYp3IHiNKDUItDNL0lHOB74X3HVjZBBceoiViXjJ/RR8eyeXKIvRXDYKvtC++9HPVV4euHW1qRkTGomglX/OMjtg2jHV0pp61M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7859

From: shannmu <shanmu1901@gmail.com>

Correct the sequence by enabling interrupts first, issuing the memory
barrier, and then disabling them to ensure proper synchronization.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/include/asm/irqflags.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index 839aaadfc036..d488b316735a 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -55,9 +55,9 @@ static inline void native_irq_restore(unsigned long flags)
 
 static inline void native_irq_sync(void)
 {
-	native_irq_disable();
-	asm volatile("nop" : : : "memory");
 	native_irq_enable();
+	asm volatile("nop" : : : "memory");
+	native_irq_disable();
 }
 
 #endif /* _ASM_RISCV_IRQFLAGS_H */
-- 
2.43.0

