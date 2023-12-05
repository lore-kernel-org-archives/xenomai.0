Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003271095C
	for <xenomai@lists.linux.dev>; Tue,  5 Dec 2023 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YzFt8r2f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhXFNdbk3XIFqi2CyHJMowo4B6P/AcI5SoYk/5wGkpGNk1MhkZfuWRT/mGLnKONX7Tu3UX1abqdXsCFEuCbP7Mjvc3GjLFRxi8tbr8IulnqwvSaK3mQDCVna7I6W97AGKzul053f5JNkq7GzZVFlf15PL/LmVio2zkFtpatqCXjaZqvDaFjZGIUz1BnnbGP60OKPeq2cEw572EMY4LoD4TgcYI9DP5eWS3VNObt9vRF2sTMi27Plhw86ZZ6EgqRR8bFILmJXZLd/aiwfD9ffmLP6wJTEFH/nIpWnnAXIR9fAjTTCbGjvGXalLdDTX3D2K66Q1Ky9DNVkoycVYlt0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QzAmPE54rvNTgWJzrQni7k0psbNrFsOPEgDL7j1I8s=;
 b=X2SXvnWgoMKizIUSlPIqf1sa50zZZluKqnNC5UvFCFm6c0229rp78cRguLjnGShKZBR3bJCe1zRCoOVwvc4FPkVWaGDdqRloVys4xQbbK5tmTH9rVLqH0NktJrcF7wxaeJsQ4UyLaNK9Qwz6uClysA0kqLyo35O5JE5nFAwjJAf/vRLGQRpLAqZ9DwRYdW3QrWRgG1rtGb/lHyci1Yd8Ys9xTtsXNiRoLh1kkqb+seKaGtmxzlJHWU2Aoo1/w9HgKWfZLrpBoLBSspL8GFtlY1pXeqFHvrayg3Zk3ixcZTw1L8B+BYdbF3OJ9O51eclxjnWFu3CgTCDoPA14Roilaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QzAmPE54rvNTgWJzrQni7k0psbNrFsOPEgDL7j1I8s=;
 b=YzFt8r2fz79+xVBOPoxh8NivF3z5BzMpFSeld2ggCpEkPymUtNLnSOfbQbe1t4gUbM8lgnT/sVtDGoVqEM3+PVkaog1s5f05GKM7BVCo0HcAu/0Bc5PKpn7BiNSC+dxFg16U4/tkSq3zOQiAYV3HXSqDRbdfWlfESZX3e9GDygfTBXYVfJkbo+QjwxzMt+hLJeg8aUrtaNzTOdcHOToyOWqiSTWaqVEFsPUi8e1Swe15MzjE6i3yLeIUvBP1bbejzRJGORZR0wGlWR+yPedW/Bp4+vG55wLm8yeU2ikOUbZ+wXI//7b8bestqVs/bdAjtj/ySan6QsIEvaG8c9foSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3672.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:134::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 06:40:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 06:40:37 +0000
Message-ID: <3718a82d-7421-49b0-8a4d-21b8886d2e8a@siemens.com>
Date: Tue, 5 Dec 2023 15:40:31 +0900
User-Agent: Mozilla Thunderbird
Subject: Re: Can xenomai-kernel boot on the second-generation hyper-v ?
Content-Language: en-US
To: "mars_liu2023@163.com" <mars_liu2023@163.com>,
 xenomai <xenomai@lists.linux.dev>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <420e5f7c.141a.18c2e864085.Coremail.mars_liu2023@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <420e5f7c.141a.18c2e864085.Coremail.mars_liu2023@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0166.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3672:EE_
X-MS-Office365-Filtering-Correlation-Id: 1149b0f5-ad2a-41a8-6705-08dbf55d16f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	okXdzym0Gae8tqFDfQ/edZBYhzhZmE97ZM13X1pbqIRlG5OW+l/oexOYg97V3jDqf57QfOXyRcLQ2IdimIEc0TTi8V1clsfMb6RvH3zml1Bq72Os80ys4hxtpLpdUU+WnS1Jx7JCim3lH+g5RJl1aKe670Jk32OydH+c9j1W3vCwq0ARUqO9kTGzy/HCpgKjbU+YPCvzkVZDtEDu8a/EcV/JCxk/w+jHua/9A5ccM62CojV5iqJYgt008/fCiav1z6k433S1uipgyoZMiofnOHGCHzi/e2WfiQR2f2tRNWxjo88a9LBeFqakm2F3caZ1PexVj5QhCw5tE5EdAOOfdvt4zoQIguprcxlV8S3dxRdZPgutYjiRa3FiRIPqzMhMDdpwGRU2r/BXMoyVrOVECZbuTIQ4EM663PLNcvcPoycVYoL/oIFreAiJ42s2n1935UR4kPfkddhfxqew3MHZ+COyWcYuYQMZNW99F6Gr9lRSHJ8DrAxID346RGHX5q8lPf9CASsFVzaWQ+EtPbqS50Y67W3QF5G2/I6b1eWN3+slKgJfG93V7fNQV+amwylo5vXoZWRv7V99ZpJOeKlmRu7AV03BjrVgpmFkCnbSPehoN9TtW6nJPlf/VQgf6tGG14IjYZZuNeVpWv+mY391Jg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(5660300002)(38100700002)(2906002)(44832011)(31696002)(86362001)(36756003)(82960400001)(41300700001)(6486002)(2616005)(26005)(6666004)(53546011)(6506007)(478600001)(6512007)(8936002)(8676002)(66946007)(66556008)(66476007)(110136005)(6636002)(83380400001)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXkySzR3YjdqaCtaeGdxWVBmaWpoZU1BWUcvRiswLzV0eG1LSWF2WDFOM3BY?=
 =?utf-8?B?UW5DUEIrY1FjSGlqbFJPRDI0RGxMbzMzSk1mWUowS1hDUmtxbFJNZjVSZVBC?=
 =?utf-8?B?MmdjZjlPY3dWVG5tVnQ0dkprN2pLSDBmaTd0VEttZDdCVnhpVHVnTVREd2pl?=
 =?utf-8?B?a1hwdndURmVCL0NmQWxxbzZFS09xNTJtc0Nza0dCSU5CNEk0ZTlYRVJOL3ZR?=
 =?utf-8?B?RHhGdjB2VWhtS2hMODdoL3ovUkNnNkRBMDFUYjlqNm9MOXFZY1Z5QkpXUGZ3?=
 =?utf-8?B?Sk9zWmZWV01pTzJKVXE5ZnlXdkpRenZlQU9Xb0VvelJ3L0FoSkJ5c2c3SWhU?=
 =?utf-8?B?U3g5S0ZUbW1XMWFpd3AyZ2ZRd1dsMElpRWZyVGN6emFzSk9zYWdEUkxjUzVv?=
 =?utf-8?B?dzV4Z1ZNUE5JRktUd1lUdGROc2RRZEJRSW5lSUJiMmhuMjBCd3ErVVowNzRa?=
 =?utf-8?B?cnlMZWs4Z3JrR2VSLzBTaFk4d282ZWxCQ2dQTW51dkFGSEUwUVV5SmNRVWhS?=
 =?utf-8?B?bU0xOWRIWERacWc5Z3lnT1ZhT0N6OFdydXhUUjNZTklRMzJXOHRFWVRjdlRM?=
 =?utf-8?B?OFhKRmo3YTEzRTNKLy82SjNwYUNRM2x4UnNEa3NpWXhPdnRZck1ZazYvdjl6?=
 =?utf-8?B?ekx1K0gwdVhmWFVvMmh3Y1N0RTdBVWhiNFp4QjN4dDdyS05DZXBqVTJRT1V6?=
 =?utf-8?B?bHJ6WDg2ZXhIWkd1U3RZUVZpeFlyZUY2VWljV1VrRnZjRy9vY2ZKQ3NFNFFK?=
 =?utf-8?B?eUd6bUVEY1VWVG96UDdKNVZxekViZU5SVFZSUnV0ZmdiOG5aYldaMG5DMWQz?=
 =?utf-8?B?UGJQNmRRaXpabTE3VkhMVDlQWVZwbzZ1bjArRmhtaXNRSTFRTmhja05VRDRP?=
 =?utf-8?B?N1E4RUtDdUlZazhvekFZajRwK3U2VXdFVG5vSVJhWXJpMVdsSFhWV0FuazQ4?=
 =?utf-8?B?eHB3MHEzUjVaUHVYK3J4T1M3MTZ3aGs5Wk1tUzhmcHRTeWk5N01UNm1DSmEz?=
 =?utf-8?B?VTJUVWhJYWgvSzBoWHhCaGM1TnRPVmtCZk5kWVJzUHE0REdHZGhqTzhjeWFL?=
 =?utf-8?B?WFhZcXRkZkZmdWZ2UUJETDlpOXJka2ZuMTRrYzVDaXZNUmI3c1BZcWRGb1E4?=
 =?utf-8?B?bVdzWk5EMnRobnYvM2N0ZC93ZkZFY2ZpRVNjWFhkalNkOERsejZoNG4rNE81?=
 =?utf-8?B?OHc4NWpMdkcvKzQ3ZkkzZ0R0OSt4WDFwUUVSQmJ4NGRkcjFnd1dRRkdGZzlJ?=
 =?utf-8?B?VnBsSm1NWjVOekNDUzRGOU5CNmp0QjN5L3BGbm82RnFKM2FRc1ZBbmxZTjdh?=
 =?utf-8?B?NWRTL3RleTVpKzhBczYyU1dEV3ZxVmUyTi9BRWIyMXZoNXVtOVZGL0VNQnFR?=
 =?utf-8?B?MVdtaVRBaS9CVlBWMW9oUDdSMnhhbm54b0FwV3BjVzdrV2dJZFhIMWMySnNO?=
 =?utf-8?B?RkRZeGdRNld4ZFkydTBFM0I1R2pEeXBUa2hhT1NFZ3dKRUl3UjQwR3JabEIy?=
 =?utf-8?B?U0xlS3NvM2pCeHNOcGV6ck9hK3R4Z3ZvTlBnL1MyVFJNTEdHSnRobmR6b3Qv?=
 =?utf-8?B?KzNYdXhOb01SZDZDVjZCUVlHRVd6anNLakc5OVhsQ2tRMEpveVN4MUI3RG9q?=
 =?utf-8?B?OWdxWWV0VkJtK3hRbnJwbDBYUEJKSkI5QmxwSDRrejdUOXoxMm1tbzVjbmhq?=
 =?utf-8?B?Mm5FZTVBMHo5bnhhOGJDYXdybzNxdmJqWDhNNnlnMEx0aUFycnNlYjFCRklZ?=
 =?utf-8?B?RTE2N1dYcWtIVEZ1dk1Zc3BnUFc0UXJsY0pJYVFrNTh4aE9kZUxmZzd3WjZ6?=
 =?utf-8?B?LzZpYi82L2dDUitZZzlVSGp5c1NKRVd6YTZQcVdUZlZPU2dtWmZFV1VIVHdB?=
 =?utf-8?B?NE9hYi95czNxRFpzeHN4b3VlcDlZZVd1MUd2N082NE5mK25Ka3hZZjhhQXhY?=
 =?utf-8?B?azlJbXNqZE1uLytaWmJlSnhkem42WlM0ckpNcVNvZUpiMjhTcm00eHBYOXJQ?=
 =?utf-8?B?TDB3bnMxNGdaVFRZMTRlak9sUXA2NjlSNkc1Z0h3R3hPYXRReGY0alV0c0JT?=
 =?utf-8?B?ampZZUI2cEcvSnkrQkQxc2V2ZjhrSHhjaWt5NFp0aERLcGNCc0YvNlVLUTMv?=
 =?utf-8?Q?MxQEgRu6/wApf/a6OmqB2j2eu?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1149b0f5-ad2a-41a8-6705-08dbf55d16f4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 06:40:37.5161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yW3ktcqjHtAt/x7hdSKHiE0xKnontSvjxBA1JulaOCV3TP1pCMGVZMpcpELrA391BWXfft07li79HMIZx3AEcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3672

On 03.12.23 15:13, mars_liu2023@163.com wrote:
> Hi xenomai,
> 
> I tried to learn the Xenomai kernel on  Hyper-V，and appear some problems.
> xeno-kernel can't boot on the hyper-v ,so i did the following .
> I saw such a message in other mails in the community that "prevent CONFIG_HYPER from being built if interrupt pipeline is enabled",so i disabled CONFIG_HYPER for  boot xeno_kernel(version :5.10.180-xenomai.3.2.2)  on hyper-v .
> it can work well on the fist-generation hyper-v,but it's boot failed on the second-generation hyper-v.
> This is also the  case when disabled CONFIG_HYPER on normal linux kernel.
> Did i do something wrong ? it seems linux (vesrion 5.10.180) disabled CONFIG_HYPER can't work on the second-generation hyper-v.
> Is xeno-kernel(dovetail) not allowed to work on the second-generation hyper-v? if not ,how do i do it ?
> thanks for any reply.

I vaguely recall some very unfortunate internal dependencies of Hyper-V
device drivers support on CPU paravirt features, at least Kconfig-wise,
but I don't recall all details. Florian, do you?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

