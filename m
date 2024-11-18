Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67A7149C7B
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.232
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920360; cv=fail; b=W4svAi0u/Ar17qz+0jWuiWtA1G796SHYkY5I6WMz0VOX1TKxjBIOaszot/QSzkefNAsiryc7urOO9pmKBrVviQeLrHa8hqj6g5praFWZtwO1zD4/Gmv9DfxCx/fYxeETsQmWoy6ZQJUsK6mZj7Cg12CDTGupK7szW+RLp6RBgnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920360; c=relaxed/simple;
	bh=NHsEUgub6fsHpa9Z/ednvVs3YQg9Rx8BKk9c4VjHzvk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uOJZkjVHkk0weSdTSSPEGMPPKq7YXiJ66VO3B4tv7fWkSiEEPG/V+ibblB+YyMbqbcvbJ5FBURPi9RD6Tk2EPqE2BOw9HYXQYg8IK1YGG8dvZbNFRL8hTcLxv53HPhDku9cexZ3bwYEGgGZum6b8I8HLk7W1UuMPVyncKaznaQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Nqsi0SK7; arc=fail smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Nqsi0SK7"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id B9B9B200004
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 08:59:15 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20619.outbound.protection.outlook.com [IPv6:2a01:111:f403:2612::619])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 00BD4740038
	for <xenomai@xenomai.org>; Mon, 18 Nov 2024 08:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1rCafQOo1/A3ZdPCp6Tz6wCnSv1lF3T9HzTNFBa0r6qy+cjB8Jnobx/KlG4sMdGbiKrowWCaP5ePffiMgJNhsgv6e8cQIoVI/+n+q9kSqy8QEFN/GTakbDpJhriOH8/3Yqzi/OUv8UrZa1m4awwFE9pK4gXCDfXBmCcKTz8f+w9YVkguHsz20otaZQW8+ujP95KTSXIhJpELSMbB2ehrhXqpfi7acoFG9ysF5MTDR87sBpLaK8Jmy9o360VOjql0b7Oan+1oLDPGY6QhceYxluMVjtXe2tYjRAnjczhtTWq52ihD1iRVax45EBRE4RAG8bUAJHHazUvWzT6LiZUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWYg44/gNqJlqFKgwDC+rtyzuSEKtp6gL9KW8sVgchA=;
 b=F+W5l2AemPndnaP5pLP9dlu7ewq3UxR3bJl9CmlWoZnWg44HoKOTLb6Obd3QA9xsQyfOxyJ/F1O/Oig5Zk2O0awCqZAiAvzme8nJazcw5iSsGHI+cdzsSsZDnTa12aCylXHCv44ZJgKxtK2OTSy3pC9NcFoMaPn6gNvB9TYGFgLt++sGUns8Fibl/cScdeHDhyDMVidisHo9XYjRuP2c+7MODJt/7R86mOKmBq9JDH8TNn8BmZD5sE0f8Lz5AhsZBHTxyMWZXd/8Sx2WmLG+FmYbqXnVEX7E3cRht9Zn1WDdCoF8wU4uHPEepbxGPSHrNOwNtjl2D7x2H7dPhxLNNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWYg44/gNqJlqFKgwDC+rtyzuSEKtp6gL9KW8sVgchA=;
 b=Nqsi0SK7daucwldRKu68vT3IthD5OBnHELHD4yOyFj+TD+l9XeWESfoj27cvl4AOZd3uhKrscVt9II8imTnzBTtPjsSUHH+/6kavlOrZO76EdF9WLCe+OdsmXNdGfQEkKYWaTPV3lkBYVxa8UwU+KIk3PxnI4IMMUQT7eZ72mInx0DcgiiBb+18bsxz25glfwfrYeO9g8ozgHLL3v8iEIeWaqKptb7NEYS3agvg56e7LEGqdW9ebIa+SWRzc/t8aD7tRnp2/QnOG+tOYDzwECmE5L7QxDinSmJGVvD7bns9eRhWvIhxe7nTb66u9qED0Act0GB6gLeZRr8gqskaxKw==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8080.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:652::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.11; Mon, 18 Nov
 2024 08:59:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8182.011; Mon, 18 Nov 2024
 08:59:13 +0000
Message-ID: <96f016c4-665b-4a6f-929e-ba7c3c37cb73@siemens.com>
Date: Mon, 18 Nov 2024 09:59:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Using Xenomai in Medical Devices
To: Andrew <andrew.penner@protonmail.com>,
 "xenomai@xenomai.org" <xenomai@xenomai.org>
References: <giN3vearN1y6Zs5xQuBxzIuE9sPhO-y12RSvKKFYPIZnLJJW7dN1vmlmEpLBDuSVKuk8qYA3O_I--946KsBwJRceRx2BKlYxkHLaAJic_Ww=@protonmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <giN3vearN1y6Zs5xQuBxzIuE9sPhO-y12RSvKKFYPIZnLJJW7dN1vmlmEpLBDuSVKuk8qYA3O_I--946KsBwJRceRx2BKlYxkHLaAJic_Ww=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0021.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d36df1-56d2-4e4c-6e81-08dd07af463f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFNvdENPVnRZYzV0RlRxTlo4Y2x3MWFTeVMyZ04xR200ZGd1SHdzL3dMMWNO?=
 =?utf-8?B?QjhZTWhUNjdHencrTXNQU2Z2bnljZzdkdWxZem1jVWdITXFPTnpKQ2JoajdF?=
 =?utf-8?B?UVhpNXQrcFFBeHJhZU8wa0NMZGo3L3FYTVI5WHcwMUl1WjhRc0g2VkttTjJP?=
 =?utf-8?B?NkNhMlVCQnBtTWdSd09SVHJaM0UycDhTaHRSWk9PR2JHTTFidWJjRXg5MzVz?=
 =?utf-8?B?elV5ZnQya1J3WDF1QWZ2S1JDZ0lkQjhhV041UjdhNzJ1TFF4NFY3OWdnTVUy?=
 =?utf-8?B?RlBVcmoyb09XSXhZYjAxN1N1eW4rbUhTemR1akxiQjhpYTc0UHlRT2w3VDZ1?=
 =?utf-8?B?R3JGZVVUc2ErbzF5OFJweFhMZFVpdDMwY2wrVENwQWYyZTF4dUN3aXFyNEtV?=
 =?utf-8?B?R1lvUFo5Z3J4cGljR1drQWNxR1ZMVDVRcTZWMVZGWHpzV3BZMm1KWGUyd1BV?=
 =?utf-8?B?S1lzOEhOb1Q3Yi9EdkhDbHFDMUJXYXVqUFUvRit6aWhHamdTakZPOXo5dHJC?=
 =?utf-8?B?S2VCMlVFN0puTloyb0xBMGI5VFZuM3E0OHNnekR1QlpVUzY2ZG1KOHpxQkI3?=
 =?utf-8?B?bHN3VW9KRXlTUlZrOEtFUlM2bGZGZTlIbU03bW14cnR6dGIyb09GTk14K2Nu?=
 =?utf-8?B?QUFKMkhFZCtjNjJRekVHNVhRQ1ZicTlTVHN2YU9aL1JFZnpYWXl6MjJVQWVo?=
 =?utf-8?B?NU1FZUkzVzFmUzFhaDBRb2MzNllvU2pTVzMyUzVNQ0x6a3NMUlR2T0g1YTVP?=
 =?utf-8?B?cmRMWWRqN0pGRHhOcVAwaGFmaEhRYjJycTJ4VzVqQk8wTGQ1RS9zTWE0U0Fs?=
 =?utf-8?B?aThXaFB3ZDZ2dEhuKzFzdDFZY3FNc3lSZTlwUjlSMkV3em9uMXk0OUdyOFdk?=
 =?utf-8?B?cmlpOFBKOEJDZlIwUGxZdjFSK3AzcUdOSE0xTnMrclh0QWJRVEdVV1M0N1h1?=
 =?utf-8?B?ZC9XNUFqTTZ2WldYVVRIY09xOFlQcVU4YlM3VFkvVWV6V3N0TGJJRXJ0bFhW?=
 =?utf-8?B?YnNMbG9sZ0lCWStUaFI0Z3g3ODlEb0xrckt2RFlLZ0dFZlltaDFyeGYzTjJF?=
 =?utf-8?B?cjdURVJsRWxYdjhYQzhvZ2hFTC9VQS9SdStqai9LUEsxbmVhMkU0OFVyNjJa?=
 =?utf-8?B?KzVNenVneUhHTXBHVXhTcm5tWG5PY3VVcE55RGtQdXF4eHcvNGtZY2VnSFlV?=
 =?utf-8?B?UlY0OVdYekIyZHAyclc1clpBQkZRQjBEN0NXcUNGQkRWMjNNY200bkFBRWhn?=
 =?utf-8?B?a3F5Y0xROVJEdU5RWG1xc3A0N1Fxb3dwaWdsQVVSTmUxd0FuZkVqSnZTeCtG?=
 =?utf-8?B?Q29uRUlLeDlIUGQyMFJTSXBaRFByVDVqcllGQkNKNHIwSUVzRlZPcjljdTh5?=
 =?utf-8?B?R01RNVIwSlNrWjFqY0xEY0o0eTBEaFRMVjl6Q0VYMzUxZERLdXFNTFk2bHB4?=
 =?utf-8?B?cmVHOTRaY1U1V3d2S05tY2NJdXNHdk5WdXBnRDdQV2EzaWR3VmZFdmVMM1FI?=
 =?utf-8?B?WTVNSjVmbHpNNWwyNkM0cmoveVFFdXJrSkZrcDlGYmRwRGdrZmRWVS8rZ1VR?=
 =?utf-8?B?cjJmSTZlRVVJQlMrWDBvVjY5S2ZLR1dQYSs3dU1NSEo3Q29oWkxZQ1dSU3dn?=
 =?utf-8?B?ajA1dmFTZXlpUWRNTElGVmxQWUVlREtpQVZ4NFBhZjZWYzFxQjFDUzRpMEMr?=
 =?utf-8?Q?F7xOMgi0ogxigAE1Hh1v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHc2M3g4UmpQK0tQcHNlUC9vOFB2d3VCQVViK2xnRFpGbllDOGpPMzlnZmd5?=
 =?utf-8?B?U1hGTmpwR1Azb3dJOG1NK3gydFZSNjNxYzIzaTJ0RC9lM1QrYWF5ZzlhcVI1?=
 =?utf-8?B?NDBKTGpxNzF4Um1RYnQ3Qm9LeUZXaFJxZmtENkhCd3c3clQ3MHhaVEhzcDNS?=
 =?utf-8?B?bGFnWHZZMVF5eG5SeXNpVk1saHlEOUViRGpKR0VQWnp3Y2NQdGZCcnd1NkRa?=
 =?utf-8?B?NWZiWjloT2N3ZFNiZllFWHFOMGZjdmxHZngvWjBOYnErY1FNdFhUUG52MGNy?=
 =?utf-8?B?a1dkM3haSkJrQ3Vmejl2RG1KbVlvcXVnbHN1STRGWXlDbnBwSTdmT0NHMXo3?=
 =?utf-8?B?TG5lNEtZcGQ0a2tmd0dCOGpRcXhNRlp5L2Rua3Q5RXlSOVBwdFVseGVpeFRm?=
 =?utf-8?B?TmZCZENjOUNGMklGTkc2ZEdrT3ZCZTNoazNtK3QxWHBaL2lTYmhLRzl6cU9N?=
 =?utf-8?B?L1h6ZWNheUZHb01kS0Z5NUtsaUVENjluc28wSktRZXVEVWFxK28wTGZ3U1dH?=
 =?utf-8?B?WndUbXpOdDNNcGxQa1lZblNXQmZsb0ozbEw2N2hudjdPc25SRVBRVGRnN0pG?=
 =?utf-8?B?U0JUaHZQb3VSVUZvNTBTaXZoUy9tUlJWelNpOFN6N2RXOHNaZG9ma1VCR21n?=
 =?utf-8?B?d0k0Y2h2UnkvVWFMYmJ3YXdlK0FURVFaSXpHQk1QQ0lHc2huOFh4UmVTTERn?=
 =?utf-8?B?MUxwYzNuV2F3TWdJME1YVjZ2UlR6cXNtYUZEcStkQ1BMY1lMckduR0tkZGJu?=
 =?utf-8?B?Z0wyTHlWczR6WVlOYjNuWkhWOHJEZjZZZzdZZEJpUWUrYUh4NWFQSlREQjlH?=
 =?utf-8?B?TWdGbFJKY1pxalBnWGxSdVg4SlJzZTRrZ3d3YURFT2FhWW1sTjBzckp6STNq?=
 =?utf-8?B?WDBaWllTZlcrMElSK1BlMUF0QVJaNEJOSnZJRUtUM2FsYXlZN0Z3eGwxclBQ?=
 =?utf-8?B?OVJzanJZU1pFMlZxb1pQSUF1L0xiVmVlMEJSa2FlNFlpbVBqbjN6SlBFakpm?=
 =?utf-8?B?cXdvSzdNc0JaMENXVkoyUlQ4SmtGMTBKcWhFd3lTaGN3TEhaRStpN0FCSDVx?=
 =?utf-8?B?NDNQUXRLckFBWWk2ZXk2WWxRb08vUmQrTEl0eTdFYlBsd3BKL1VSTWpGVitr?=
 =?utf-8?B?RDBwUEUzT2JzMkRRM2xVbnpWU2xhOTh6K2IvVUJMSUc3c1BtcU9iK2d2TXFD?=
 =?utf-8?B?UnVyUlNkT0xSRGRNbG44L0xNYnIwRjlhcmtyUkhqUVBYZmtvZ0R0Z0ZBUWxr?=
 =?utf-8?B?b1dzUTZUYkJ3VG1zaEE3YVhTU3BvbVJ2L1cwUGlwQ0RmSkVxOHUzdmVpbWE2?=
 =?utf-8?B?WnduVWpJc1NlNDNyWXU1UHRNaDIxK0NoM29JRC9hczU4OFo0TWsvaE9IK3VM?=
 =?utf-8?B?YWFrRjlhSDBzTi9JQko5ZWM5QlNGZjIzcG5xanVscDlsSFNBekJsdkVSZity?=
 =?utf-8?B?Q1dzSVRNcy9TRDdpdHRHRWlhTUEreG5IRXpwYlBXaTh2ekFSdGRYNGFibzhZ?=
 =?utf-8?B?ZWd2MEUwZVhRRE9ZYmtvSkoxTHBsYU5zZWV5RFBpbWlWVmc2VzNrbTEvRFF5?=
 =?utf-8?B?VWJGL1k2aEsvaDUrNXpPczBTK1NqUjRGQ041aU8ydlBaWWhwaDVxZm4yTHAr?=
 =?utf-8?B?bGRrR0poRVdPUGd5cjkzWFVwNU9ZTmwyVFplR1ptVEFDOXh2QmFXM0VjTGRa?=
 =?utf-8?B?cWlDRGpOK1FmVlFTSjJhTE14dmxyODdYVmtDSVd0SVZMemZ3VW44VXo5a2tz?=
 =?utf-8?B?M3QvZWMrVUEycmJlNGhJcHMzc2ttOHptM2hZeVpPem1mTzRsN0c4enlvVEJn?=
 =?utf-8?B?RFQ1dHJNUllwSWQrNXViUWE3NDNBaTZKd0l4Y2NZbjZhRGhFM2lvbHRYY1U3?=
 =?utf-8?B?Q2JQM3UzU3JQd3FhNXY1T3JLVE4xTmI0bnRqSUpONU9UMWhVcEVSdmhhYmtR?=
 =?utf-8?B?MnFwNGtxTk9MenhZZzc3NkJNZDZKNDc2TTY2d3o0UHJBbDd1VWVSRVluYlJZ?=
 =?utf-8?B?RnZhYjV2eWZaNExOQkR1YkZYSkNrenIwSFJSalR4ZGRUc3Rsc2d2dUtpNlRs?=
 =?utf-8?B?MTVUelVCVFFoUStGNS80N1VzUXhVRTBvZVE2aXk1blNPeVZRYmg4QTMyR3Yr?=
 =?utf-8?Q?NlhRVVIbJiidkqmYJDcJysCLv?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d36df1-56d2-4e4c-6e81-08dd07af463f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 08:59:13.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/ATrcIwwZf92D2NXxgg7TFvNH5xO+GRzXEwE0XH3KfgzoighkGKV31tNCzDJmfmTGR7G56uoAot3nn4aTTRYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8080
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=Nqsi0SK7;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:2612::619) smtp.mailfrom=jan.kiszka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1")

On 18.11.24 08:45, Andrew wrote:
> Hi,
> 
> I am looking into RTOS for medical devices. Since I am fond of the Xenomai project, I thought I would check if there are any know use cases where it has been used in existing medical devices (name of the device along with the 'yes, absolutely' would help me convince others.)
> 

It is being used in these:
https://www.siemens-healthineers.com/magnetic-resonance-imaging

And that now for a long while:
https://web.archive.org/web/20101019161720/http://denx.de/en/pub/News/Xum2009AbstractsAndPresentations/Linux-Xenomai_for_Magnetic_Resonance_Scanners.pdf
(so long that we lost that page, but there is fortunately still the archive)

Jan

-- 
Siemens AG, Technology
Linux Expert Center
