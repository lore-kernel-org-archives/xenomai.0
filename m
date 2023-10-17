Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDF542BF2
	for <xenomai@lists.linux.dev>; Tue, 17 Oct 2023 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gNlxtxWA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qs2kA+8jCSWdpXRX0X+6Dul9s7qLp93OuEYsy0FpFJwmQfzCHAbmK9U4V0J1bV6FXLmkg0SkQTe3pyBHVswZputUxBMOBrEHL7n351qiRl69Ub6R0JajMKMp6zRVCg3f2Mnnrb9713qVojiIGUB2SYktGwA4QF/sPlj1MSW2F589cWbwdmCfevOBlWWxKILpUg+qyDCvgduAaDUIPJLgopvSd0oMipDoph1+TrerbZG1scgpgTZT6r5d76NrbUpiTXRwmkFyVVJjTobsGX2qOUv9htIy5bei2P2LoOGLsi9OcpJJZZtX061HO+vMvKpXRuu3D4LdzKbPke5cDevHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7wmQd8xm2XaLzn8L1rfVs77DFMx/jRfS4ynuAlg1Ag=;
 b=Z5ktLJIzDKoHNcdyVqmPUkoIGzIXxdVmsREvbCVw2wtuoon5okFWVmsyVcdAV51IESSCSKwEgiKYxiXMwvEyoC4JdO7iHZoVDrgm4H5MNUrY+9PXVxeUhLbgpMwNiEWgSECo2fLI0yF7r1wfJPcam8xIf74LvazRwFVQdYIVCeXSzaMh4bDULF3iuZR4MHXLP0GTenVM9l2NpL5d+CcD6mYTxNv6maBRCOY0Ou0Lj4+XQ1/cDPr1aOLVyart7eXGNl03HwsIE3i9n2z3U5YHFUr3dUYrlgNlNfwgIdipBP98UH9Ija7WRnUTm0iYtZt17zRlkKVGaVPcbdE01lFZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7wmQd8xm2XaLzn8L1rfVs77DFMx/jRfS4ynuAlg1Ag=;
 b=gNlxtxWAJJWNTrS3w6E/3jLdA2aC2QDPAX+CQ7oZvWH0NLvnFcMZrNlJwWjL6Jr3NqK3uULNH9asz9ZUXkYnQGWd/wdxkNFKoFEhnTQMoBAVmhGeTEvAAtypKPX7DzqXrZ5cWmYLW5ObN0BtnjLr2UxByBLYnWvSrGbUVOm9upJqHPjzxK0vY/LyQ43Sn2r83tBJOokbhrwhq4+SktV/Uj5n0n0CvAEmgNWbCKwIJSC56Cf4D6Mnc/q40fsYz7M7eqeRuK8nV5bTIG/xf/iQbhLGKXK4KnAM52ZyZar4IG8zkId8wkLJ1X6x59UbUa/beuXETeckFO35fjWIDd71xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7417.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:301::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 12:36:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 12:36:17 +0000
Message-ID: <b349a125-28b7-4b1c-b02a-d87a115d28b1@siemens.com>
Date: Tue, 17 Oct 2023 14:36:15 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Missing v5.10.195-dovetail2-rebase?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ad58c5-e4e7-4071-e44b-08dbcf0da8be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nzXanidyK5iMAmt3Q+O8valJl+X0oH7JAMagWtTx8BGx1xGW1FEfpMfXKgY3J6WofI96fiFjNcIi9JEg4+9H+Aya4nV+4w7/VFAKrbXC4crk1En7uVBJk1YP8RQC6sTqmO+RxsxDCpAx23/hmHfGqj3hQdaBBBhlM1uQbEAZeCWBetGXeJfJ/thLRMI7jGw/dRiwEtxfB+/BLdJXoFpaAnjanw2ExIs9CyFbSllbDygT+g+6RnyAu5dgpzsGbwcns51+2kZtA18HWArObbc/7H4ebcd/Lt7ooOeF6F20OmROa5ziXHKreazRPQLDmVjNozb2rapY14TMBdl++f9ttcQITo5YjrZpULHV1pGIDDWUgu5Tv4UaKnooWVTj0NI3iWgxz+L5PE8yd0k3C3cYC/EYZ4BUYOtenR2pJMMr+Jiu0HtYdk+oAmHVhgm3zGtvaEbq24fg17egmU57oeQ/3Eyum0d3Z5Su4lb3ujnix/QhMigIar9HnPiXrHyL5Z/MEcFVbXMv0lsYRJyEvx8U+e2thIgofLvbgQrPKZk6vCyz4ypthWbVRqSznpP4195KFesAEA0CUymjkoGWMzo58r6cBgQX4UfwHw6r3CHwDDtPJCwpavyWAvzpbfkb5/OqRjRAmQ0hoMjImbnuX4NyeA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(83380400001)(82960400001)(2616005)(316002)(6916009)(66556008)(66476007)(44832011)(8676002)(4326008)(8936002)(38100700002)(26005)(6512007)(6506007)(6486002)(36756003)(558084003)(2906002)(31696002)(86362001)(5660300002)(66946007)(41300700001)(31686004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2hwUU1ZNXA0aytUL0hwK2tMZnFMU0lBNE0vajBJQTJBVjQxNFRrblM0TCs2?=
 =?utf-8?B?dTVwSDArQWlQT0h0d2VGM1U5MnY0SUQxYW5samM0YUxHdFFSbjI1K3d4aTZp?=
 =?utf-8?B?K0t5SktyOXQxa2VnRzVUM1Nwbktja3h2Tk1xd0JoM3pPQkU5OUw2UjgyeUln?=
 =?utf-8?B?V2xUVDJ3Y013M0c5WVc1cnFrc01mbmtKQ0FTN1pUVzlGeC9HSW5LWGd4eEtl?=
 =?utf-8?B?UVI1elVtbm56ZUVxd2NVbnlVMFU5VlN2cjB6NFZ2bi95TVYvSytzUEIyZEo2?=
 =?utf-8?B?Zk9GTlNoZ3FjS1BQQkhPS1NhSmU4bkRmdjRHRGZVN1FCWi90SitHd3oyVTYy?=
 =?utf-8?B?SmJQYUlJZTVuMzE4a1U2TjhxSXBVZ0dYd1BneE43eVdYT2VUUGdHY1VDWkxm?=
 =?utf-8?B?cTBOcDRSNW4wQUYvSk02ZCtpL3pXdGFFNWFmdEtZNEVsKzFYTmJvWUdRZDRx?=
 =?utf-8?B?K3VsbW5pVU1TTVJzZytKQ1pYVjdaR0MwdGtwQlE4blpjalBKSnZieER1akZ1?=
 =?utf-8?B?V2dDV3gvZHExWmd1M3JIMlF6OVR2YldJeW5NMnFvdTVNTTQrV3dQdUxwWmtD?=
 =?utf-8?B?QUU2MG5OWlZKSUsxdGRRTGk2S0Z2Q1hLNmoya2JFOEljOHZrMFFrTzJmNFBQ?=
 =?utf-8?B?UWVVcEZsVkZ5VFVNN3JBRUZEbmtHa24yblU3YjlOeStYY2Mwa2duOTIvczFz?=
 =?utf-8?B?S0dBOFBBSllMOUxlT2VtMGxraENSc3JJZk56SUdnaUI0cEQvMDRxU1VqOTIr?=
 =?utf-8?B?N21Id250QlVkdm5yTnNhM0svYXE3eWtXazBKMStSRjdOVUdIamNxQVZUZ2pC?=
 =?utf-8?B?bnNHaTlMMmFQRDZTODc3dUllT3Z5Q0xUall0ODBVTGlldXNoTStuTnpvbUow?=
 =?utf-8?B?ZzFnaDk2aWFlQVIzdHRPQkQ4L3kvTFZJbFNqVHRBZFIxbDA1RmhmMjU4SVRX?=
 =?utf-8?B?bjFnK0dPV0lPUStjeG5hNkZoV0hJbGxxTEVWUHoyOGxxV1JQK3Z2VWdCTGFz?=
 =?utf-8?B?WkkxcWdWaVMyMjV0R3hpWjlnY0hnc1dycE1paThlU3VxYXVkTGk1N25oL0Nn?=
 =?utf-8?B?VEJLeC80Vm05eGFqMlJhSTEyRTR5WG5Yb2dMZ2NwK1BVMDZ3T2t1RXFCYnUr?=
 =?utf-8?B?MEgzVkJqTUFidS94TEZscUthQy9WdjNCbmJHRy9QQ3Fzdkk1QjY1c2hFMFNN?=
 =?utf-8?B?OUlnY0JnMElEd2VVcUxpUWgwemtXcnJHM3lFNHl6VWlyallJZmFWWUpxaklE?=
 =?utf-8?B?NXdDT0N5aUZ0dWVQUkR3UlZRSGdTUkNZM1dYZjVXdDBiTVNselduVVpUaG5w?=
 =?utf-8?B?WXI0enh5bEh2dkhiTHNmTFpNL0JHZW5FempxN1AwSVZKMVlOVjJrU3dWTHl5?=
 =?utf-8?B?ckNZY0NRSDdhcitTYTl2dVdOV0ZVY2tJNGpwVW1XRXZWdDVtZmZNOFlBQ2sr?=
 =?utf-8?B?ZjVBMGd2dGdEQVdtWnQwVDlnMHdlVUVuclR1TEdDUkFEc29LWmtyYzc2MWs3?=
 =?utf-8?B?QVM1ZDhTb1ZqdEpnZEJOVHJIVWFkcHVFay9pZkZyVHZsUWxBTWZBT1NyZG5K?=
 =?utf-8?B?SzNReGRWckxLYjZJR0UzaTBtWU9IUXRtUjlkZWlUeEFtTTZDalhqOStvVW1G?=
 =?utf-8?B?SEpaREFRb1ZKclhmejR0RFlaTEtiVi9BbW8wZkFza1BHUFNXZlljU24xMkFF?=
 =?utf-8?B?VlQxYjZ2MndGZGc5SmttTVBzMTBINWRXUDVqWDJPdk5qdGJoanVCQ3laK2RR?=
 =?utf-8?B?M1hKM2VybjZsQ3ROTnEzMnpsY3gvKzU2VlljK3dkUGQvWHowSUhsenZBSFI1?=
 =?utf-8?B?MWw2bE51M09JTlpHNi83amlUd3djc0VQWmF4aDFJbndTMDFSQ2RsVjhIZWVt?=
 =?utf-8?B?VmlxeWpmMDJVeEN5TUpxcFpCZVAwUkJEem1IT2FqTEZGR2NnTWlrdm1aNWxV?=
 =?utf-8?B?NUZFY3oxSnVJUFEwMW0xQkFiUXBERWJZM3FNOWZKMjFZVVUrT052YzVjNnZG?=
 =?utf-8?B?Uit3MUMrcnZCNkxLWEN5WFlOSkdBL2FDQldWdjZJa0xTa3dHREw1YlRnQXdB?=
 =?utf-8?B?YTVvQW05anV3K2pHdVZqM2lRM1VHaktzdUljbmlrcGxoN2Y2eEtiMnpnOFhG?=
 =?utf-8?B?TFUrQnpMNlBKQ1pYcGY0UXZYcTNDNDJQek5JSjQ1akE2dkVpTXlaVUhEK3VT?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ad58c5-e4e7-4071-e44b-08dbcf0da8be
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 12:36:17.6933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILh4ZqS7wwpJr/O0kY4oSVLZhtjGe1uLpkjW2aYGJrd2UafumxgVYY+g11ig3+HxbpSNeiYDuvuGt0HMYOpXcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7417

Hi Philippe,

I've seen you tagged "genirq: irq_pipeline: do not request IPI on
uniprocessor" via v5.15.129-dovetail2-rebase and
v6.1.54-dovetail2-rebase, but there is no tag on the 5.10 side -
intentionally?

Jan

-- 
Siemens AG, Technology
Linux Expert Center
