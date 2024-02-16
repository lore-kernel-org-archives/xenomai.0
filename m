Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F576168B1
	for <xenomai@lists.linux.dev>; Fri, 16 Feb 2024 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069078; cv=fail; b=QLxyv3HzDj8LagViKon+QmyTDDUYi4NM9E0iHXBlvHK5i14Z5c/bBxPn/g/QxjdgIs+faFbuu7ku1phEGikRBdjaGs/nWiROVXDzWvOsQdCrYWImdv++ZAHHCs7KvKKHos8wIwbYRjHmOywyfjTuBpgkt8sJ/4iW52jXi90ir50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069078; c=relaxed/simple;
	bh=ra1MRcCNLucRJLSRPp6NjNIxX3QmCmioRFseJ9xlZK4=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=efc1v7qvYHiaX8Is459uQb8lOmv6iIzwatHojtXJ3+FxRH69se4Toq1mHlEj6vS/E+l5J5sKz/7UKg+IWGkLpoCwBy10qjP4Gwv+dD6He3MESwv3Wx4Y3/KBnH96xciHzGIahLa3RnW9Pi4LqC2KYVvjFWe11X78V0W0CI5dDyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qFYjJ0xY; arc=fail smtp.client-ip=40.107.21.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qFYjJ0xY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYfmPkN6DlS14em9QbijubUE89ziEvl6+qADugYWOTfSCvdIstfcVRjHGigeZ12RmUUULodxe+D7VCRJUNKYBbKAU1rYFhdDfoLUMgUrWL8SC4h4SUsZoJZ9ou3ewHi7szUonNrCtRghfGfhlzWy/NyVxgjhqUF3gp82grsnW3l7Dkw9it/pSNcQVIWRnh0NkheaiKf68QCmLLi4xTz5qFu+P4QTyiKzTEOTo9g2AxsEG28rHHdv3fdPA/hywb+zeNrY0za5L/MYXQXtRWG+vi20C8HzdNQXBxRN9VAv+9ZWp/+KUoA/mmWE3ty1Ta/jI/MlkOLPRQeTmVh0vo7HAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLU3JTQTMKzFDbgS+rIm0/a9KZVXEHRQRS0y/SnGNpc=;
 b=QZU2u14TBhpszE6NiURIzAlkBbehWFbDu3dpd11zwDuv8IyAfy4MIzUBmDk3IXpuXe/ORfifDuWr3Dx/1bHPdK2MqYmCy+4lDGzIjYZGiwTR7rvWmfJDP53nij/rLAUn4RrBO5tAZAwZNMEzzR45Xzp9SwHzXsejAyJVBLDdimhmmca3dIkW4eT5P6fyguV+OZrYz7xeX8k66cuELXaBeDMxqxc/IMh73nvnccF4BWfJXgRL8M33kcLH+Hu1iD8GrsbQbNnIkvg9e3PpA8gUSWvLGdsYGE3SnGa+JDlF5yahBjrdO8RwywFDUApCsDwWdNWeRBaK9f1RuYVRUHIKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLU3JTQTMKzFDbgS+rIm0/a9KZVXEHRQRS0y/SnGNpc=;
 b=qFYjJ0xYmdYB6I6HKufPj452tCg2exaykFnRYiH3+W4mb953AWJGsaKfr81nv+7qY2FfOCDd7JKD3H8mfN8oesIwZHd/p3vzAc/xck6HGcDk2q6TsUXU9sd4OBMoVFkF8juGUGvdO2dp2LOyUVpeKyQcP4GuEBUqaXZBIIyZyK8jXoDR1J96VHxRP4ZIp4XOVD9gKQPMdCcDJLTAI/tQayXy0Qb1TFRfBCJI/FlIeQiVn0qbBJNxV7l72Tey7PTgJaaEySe5AzjUjZB7YjlP7AshiiTq7iRwuBoOfMgd/6+XfE2vGFZdWY+xgFLLwktfuim2jhvXtCcsjjAPPmWoQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6717.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 07:37:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 07:37:51 +0000
Message-ID: <e5aa7c08-bfd5-481f-9f5b-2767ff7027fa@siemens.com>
Date: Fri, 16 Feb 2024 08:37:49 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: To-do: Resolve sporadic test case failures
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0277.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ec94d9-9921-4711-6a49-08dc2ec22e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ESfI9o7E0GfXc/f38nu98knDRkii7YaMfAvevsLiCL4i/UR4rsuFNixVRIqCcwBggs/2fbprgIAnZ3hUBFrVvT21wcBdujWMWB9cod/qZU0+0ma1aw0wrl3oSZtk4lEzpu7BTmaw72ParB7qNegLtEstBXAZBwai0nzaUQaKQgtRSilKvz279f9bCJuyyHlYBCRXBKYZDDjVAh1LZ103db694fwAsEqhuthRhisIMnaGMQOjKlzZj/TWJAXTdSrsgdoTWUIFIAz8u1FWB1ZOITY58WCRM2/ksjfDZe5zBQtm0lGic42Z8ygQ0WZj6Gr8xkFDANJXx8FylV59bjthKT6q9ZoRsYZJBNmwUx5TSQmTs1/GDD0Kc0Xj1xPhlFgIgC61vUsKI39rbLWpO9UBuNRd6ODOZvuKx9zmUdJ14VDApCjP9bkQhuMcc28ARZ16po+est+cV8Hi7ZgSTOvBmYQCY4Q8fT1dK9C+n2xhSNQ/Oh+Jic5HanrpNt8F0TwO8xwNCEWF27cwWMHRzu+mSb2NQQkNsmiQNrZ2d3j3lXw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(4744005)(44832011)(31686004)(2906002)(5660300002)(26005)(8936002)(8676002)(478600001)(6916009)(316002)(41300700001)(66556008)(66476007)(66946007)(6506007)(6486002)(966005)(2616005)(6512007)(31696002)(86362001)(82960400001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1dEYWlIV1NudU8zWUhseTBvT2d5eGE4TDZUdng1TnV2bUVwQXczZnhCbUkx?=
 =?utf-8?B?VUlyZ0g2SzJnR2ExM3l4SzZ2RW81UllhNURYS0p4akFYVGtOdHVMemozWFFL?=
 =?utf-8?B?alcwU3NBS1VNWXBITTZHMXJrREFxNlN0SlBDejR6UGYraVY2L0tMY1VJMmlD?=
 =?utf-8?B?dk9DY09CQ0JiRk5sYk15QXlQZnhXNVU0bjU2QmNNdVQrVGZZZzEyTEtoYWRN?=
 =?utf-8?B?amNSNUtlNmRQUEIzYnMwOVJXK29mN1J3SFMxcW5FbnFMZWp2Nzlmc1AyOGN4?=
 =?utf-8?B?SXZaWTJwa3dNcm95TzFUb3ZjWWx4YVpiV3VGbGs2MDZzbmZsbFFnMnI1UHZk?=
 =?utf-8?B?djFWNVhORzVRcTVxcUdKU0dHYzNGeU5LaHFGKzRnMWVsbVlibFBIaVU0VVpC?=
 =?utf-8?B?WDRxNnR1d0JqTXlVTHhrYUFsZTRIdjNacE4xcVFJdkhwRE5qck9UVWMxWXBX?=
 =?utf-8?B?WEpzSDBpQ2xqR2pIRVFCaEpzcEdiU2hncys2bWthYWZzNXVXekh6b0VibGVT?=
 =?utf-8?B?OUZpbVNOSlpwNGUwNEYwKzVNMVJNcTJrdzdyZ1VvL1NvYVRTZE1pMERUR2ZQ?=
 =?utf-8?B?RzFWdzAvVWFBblpCelFnTm1yZllmVTkybWJHTk5ERDhhZjE2NFBoZmdqUkg1?=
 =?utf-8?B?bVJWd1E0L0FQTU1XM0QzcUtnK01kQUdVSzlCWWIyQUVUeGpXSCthQmp3V3Q3?=
 =?utf-8?B?QmZkanpvQnhQUURTR2dwWmFiU0pMNVhJdlBVTWV6d2VjZDVNcUdEL2xOSm16?=
 =?utf-8?B?aGxsNFJMVUdvdG5jbTh4Qlp4YTdSY1RHYmN0UHNSTm9QaE5MRm5vMVlUa2xG?=
 =?utf-8?B?M1lXLzdGWjExLzVEV2txZ2t1eENTWFdVV0grUDlPekhXbWgvMDZwS2tpZFN3?=
 =?utf-8?B?VjNCZzQ1VnNnaWpjc0VEVFc5SGtpb2JBbW1yRW0rU1ViSnh1NitLL3l6UG5N?=
 =?utf-8?B?QkRqSXlrTy8zNTN6a1lOR3l6TGlPT2ppYk5WRUtZRlVxYXdybFJ1VmIzTVl5?=
 =?utf-8?B?NE5RenpKQkk1ZEVlOGxScU9PdTlwb3Qwcnhwc2J3SUdKcTlUV3FxM0dKalF6?=
 =?utf-8?B?OG1BREhCZkJjMVo1eE95REZnWS9DZ1djU0lPY2dLa1VKRjVNQ2l6bHlnYWFo?=
 =?utf-8?B?L3JtSmFKT0RlYnVVekZzU3F0bXRtOXpUTDJUOU9MSzR1dnZpczc0cm5waFVO?=
 =?utf-8?B?VExId2ZBVWU1OEtNNms2Q0RxTEpsOVBVaGlUR2YwdERHREN3UjlSUXlFaTFn?=
 =?utf-8?B?T3hncDFKSWhZRGd0VFd5K3JhU3ZSeStqUEhOQmI2TXJRWkcycnZORjBwYkcz?=
 =?utf-8?B?Q2xmM3d6c0JmMXZCL1hPRDRwdnFxUW9KTU5WVkEvVkt2RU5oQmxubVhOT1Rs?=
 =?utf-8?B?TmluMU1LNVNHL2pvY2ZFS2NWMVQ3N3YybVcreVpTNVE0NVJadVE2Nk1ZditM?=
 =?utf-8?B?SjFmMlIrWjVJaWNSZnduSXZ3Q2RpeklYTU1QamhLZDJmeXNMOFIyTy9qb3J0?=
 =?utf-8?B?T1hvR2FqYXQ1WXVBODB5NlNSRm9kMkNoa1FTTXdlZzQvZmoyTW5USHJFK1N0?=
 =?utf-8?B?NUpNcjhHUnNGZmJxL0VpVEd4VElqMks1TnUxVWlaQkVmbkFZZFhHTkZWaUNu?=
 =?utf-8?B?YVFHZUs2dTZtRFkyYkpBOUNRczVpaHBEbzZadjBDNkdEMzJmNHJRdTcvbzJo?=
 =?utf-8?B?VWdra2Fqc0FzalRGQ0I4OXRBZFI3MFp0eSs4SEE2T2pWZGQ2V0dBNGlHMkM0?=
 =?utf-8?B?U2dkTlFCRVNya2ZaYU9qZHRsSEtidzlVM0NId3RJVDkySCs5dmJFUEJxeGpP?=
 =?utf-8?B?aXZ2QUZsUWdSVHIyQWJqWGpFUXl2V3BoOHQyNjF0TmJxZFU0OXBjNXU0QnVE?=
 =?utf-8?B?YjM5Zm8yellxK0NmdlZNTWE3dms2UWlvK0I2aWEwMHpseDJBYVZucktkWkdB?=
 =?utf-8?B?SDVUaW1KSjB4REhmTjBMdnZJdVJ6RHI0d0E1cHB1SnI4ZW92Q0swa2FvdmRj?=
 =?utf-8?B?WFYrZzk1aHVDZ0I1MS9SZTNKY2VaKzZURWsrMlZLL25ZWC94SEJXeEdDOEFG?=
 =?utf-8?B?UXZMRWo3dlBLeVhBSmFZSS85K3N2YzZ1emtSRDNRN1BqYXBlTTZHYUN2eXRI?=
 =?utf-8?B?NS96SzJKMUxUeFYvcktvR0cySThBQUtzejVTQkFlMUhYOHBvSHFoeXRrUm9s?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ec94d9-9921-4711-6a49-08dc2ec22e7a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 07:37:51.8975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqv3Q7gd+ujlYP8xmiLgGO7SnyzDobQumN+UVk/W5/8in3/9EPvDb9beZ3LNSk23ZhBHm8abjzee8AwYVb8cJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6717

Hi all,

if someone is looking for a way to help our QA, please have a look at
the sporadic problems we see in QEMU tests with alchemytests_heap1
[1][2] and sometimes also vxworkstests [2].

Thanks in advance!
Jan

[1] https://source.denx.de/Xenomai/xenomai-images/-/jobs/785165
[2] https://source.denx.de/Xenomai/xenomai-images/-/jobs/785103

-- 
Siemens AG, Technology
Linux Expert Center
