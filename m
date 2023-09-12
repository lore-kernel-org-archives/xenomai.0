Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13FE7F0
	for <xenomai@lists.linux.dev>; Tue, 12 Sep 2023 16:55:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCoCCM0QF/QEVlT6F4QxxYMg+LwYawnWEK8nEDIieviRGwwQUoI4co6flKaacP6pY0/0KdesFOjKMQk4a34ENQUaDXlIiVzdzncBWzby5oSAtaTFIICsB2SdB+IL1WChOKyFRxaKTCdEtW4eMculBEbmhcglHJhxJ7MptpSj3eYnUxoyy17iKrk96eImt1IFHr/M/xh6DDgn9kYNF9RqS0Pqv/pGiL/PvJvDIJLzfULuOBYbV/GrNXLEl1eD2VxE/5obTeuf989kLaV1lv7hkqaMgdUtv9YXNfw4dt8R/4d/mmnpdqROVDFGGoCNvjguTkC7qzD2DLsaRJzHW0FLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/pP56Sr8hJASXgP+sS6Vv1MTExMYkBsi2vaCbAhXbk=;
 b=XK5hPAuRjoNepUuh9jjRRAqEfo5h/iiy2LOHC+vnxSmrz9PMFp8KYUr8PhCkU33GPlhm9bAhOaiu4h4NIq+jxXw/Ow3aGCdEjXd4s8O9/0ImxYNGSA5eGPCVr0M9jSOGUDjDO9lbLsinKCE/IRRt8GLh+L6H5hn634uin8o1adUh7x1s0YyuYyzVaSrh+extFevS867qFQiFISzTuZSThYpsA9kxIqUmfFHe+2r+6WWZvHu91GTtsK5QC8rJLafq92+FV3zYjeJzN+mlkajA+pnpyp6EVEseFD/4MrFgec/CP4GqI0irZQIVos9CRGKRj7CmOAbWiu9twUffdJPD1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/pP56Sr8hJASXgP+sS6Vv1MTExMYkBsi2vaCbAhXbk=;
 b=KBg94IxH2hH2mPIPXw3mKhZeW1meuRkKO3wfNoNSsJeA61wc7I+nUIACiu/t/pNTXwOvGscsk2c3CPdn0cGYZNpWgEdRT6gY6UnStC4Nr4u3ssyb6qU1+SaXCRyduXeQlswbFSTfoAE5OWKX0CZbUgkfWbTtu8BgKTTq1NckRtJr7deiPXf7sEnn6y4G8Su/Mn9Zhuw6/WpTsR1aGRSLsvXhEZk2V7Ggo41+Zhf9aaZTKUeSp4cqfklZlX2GRvvE4Zm6WE1DzuSYKqkDDd1wJTRSBdb6fqEthUAmHhJl59j8BpC9wB74QqdN+4Qr4wAZVm8+xMQdhgU+l+OpggmsEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5773.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:310::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 16:55:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 16:55:28 +0000
Message-ID: <56c4c74c-d971-4cd3-88b4-0cf1ef50c4f4@siemens.com>
Date: Tue, 12 Sep 2023 22:25:15 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "Wang, Rick Y" <rick.y.wang@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [Call for Participation] Xenomai Community Meet-Up in Wuxi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:610:b1::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c89999-c1c5-4f61-7551-08dbb3b110d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z+HiK+TMAS6V9bFgTZ8/KzwPi0kZDf3bKr1/N97sD0OLIHvEIosiN80+BMllUyKJ5pAzQ9U0GX00iIwPq38sGutAM/iomr0P2TaHHIayMO7pZCMfv8F+RbmldGyINXxuiEn0jKnLBK4o4NqolayA5WDwWYmGocVSoM/OBxRacTqMIu3xht/Zo24mlzg2jADjBE1zmLLDjkrAASirjJAJ0u8naKkiLNr1064IyTRP2GMReqSTntFGlspQ5pisW7cf4YhNK16pFbm93nFOcbTn+swh7MCb/ApRMJFHT/4hawoGhsLTsDhMLnBkpjuX9gAFY4KQiVF5VZOQ1Oe+VpqFBJy9bXtg5awnmPJDAsTWTtZ3zcyFWW63oHHfwpvrVvR8D9c4cW8JyDBaW6Y/ul0dRLwRB9MhDauqGlT2sBRRT4lzMf8oXTyphUGDBb6Hxr9rTWYX6GrfwSOwkTAQmZtuG1I+V+Y29UL6ddnfmRswqiGIig7yHtPmrz8R7iJAH5qJRgH2Tdb7yUNEshztrnRtsnWHVt3/wg8r/YxsD0f/WYLN0Bc64uoQEOMtoj/JtRn28oZl5WJx9rJBnOaAgJ2hBPMEkN5Ttk5ism+XtEDVv8oLC5EOzTTdDagCIrQpNr2xmCMGj5uOjmAoNR5/LeMrxA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199024)(186009)(1800799009)(38100700002)(26005)(2616005)(2906002)(6666004)(478600001)(6512007)(44832011)(6506007)(6486002)(31686004)(83380400001)(6916009)(316002)(54906003)(36756003)(41300700001)(31696002)(8936002)(8676002)(66574015)(66556008)(66476007)(82960400001)(86362001)(4326008)(66946007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTB0MWRpcy9RUzhNWHFjT1lra0JsMnVEWVlpZjBBb1VaNnB6SS9GRUtvd3Rz?=
 =?utf-8?B?SklRZm0wQlc0MXRpR0J4U1cwVVpnazN5TDk0eEdKeWFrVGlhbzA2aHNhVFQr?=
 =?utf-8?B?UmJNUmJjKzRvNzV0ZGJJeUNzSzZ5VFY2V1EyMGRoMExocHhFUXQ5YmhJQWV1?=
 =?utf-8?B?bjgvS0tTNGZHTEtETlVLQUczOUNQVERRYUpQVm41ZEJDbDBYakVXR1BmNzhI?=
 =?utf-8?B?R0ZHWk82aHpnSHIzUElPUUNZRG5oQU53bzkveGZhVWNGTW52QjV6UEI0SEEz?=
 =?utf-8?B?Nm1DRllYRS9DUm05cEhVQStMKyt4ZitxTlZ0Y3VTQ0tLMWxNR1M0dE1RRnZH?=
 =?utf-8?B?QmtQVlhaL2dEamtLZ2pKWTR4SHNNenpDblF3THBLTVpMazJjS1UrRzREMmJC?=
 =?utf-8?B?czJVeWJmTG1WQ29UWldhWVJMVVRjbTRsemlGTDI4OEUwSGE2SEtXMFNzY3Az?=
 =?utf-8?B?UjViMDRIaDhYNkxVcElQeVhUNHB2dlFZOTVOYTc5KzNtYmorMFlJUXorSXpz?=
 =?utf-8?B?bkZyalE1UWswQkhlWDlJbmZzczQwSmJyRzlnejgvVWtZSmpqMW5BT3JMTkgr?=
 =?utf-8?B?RXp2V0FwNkNlSUR1NUJPcmd6OFFFU3c3VHBrTGRxSmNrWDRodzhhamNrWFll?=
 =?utf-8?B?eDlTeERVMmdjS2t0c01DeXVSdklOa01vNVBPWFJwQ0xIOG11OGdTbkM3Skh1?=
 =?utf-8?B?b3ZOdHNJWVZ2Wno5bXp3cGc0TTNKSkhUUWJUMW00NUVTdjBrNXRnUXErUnlv?=
 =?utf-8?B?RTM0YVJDOWNVMUJHMDZnNW5ZVmtGaklORE82OEtrQ0JPd1VpR2N0NmduSTBk?=
 =?utf-8?B?TlpHUE12VDJtQmF0TmdrNGs4T1o5dnY0M2lOQkpnaWNLZncyYnRjRnFUSkxm?=
 =?utf-8?B?R2h1cHgzQ2c5a1FkUGRodUJaYXlrTWFKTHZwSmR4eTlHdlBmd3EwVnFUSFhk?=
 =?utf-8?B?SjMxSk5EWURRNHh2Wkd1UldjQnl6aWlZN3FRSUE1SkkzZ0EyMlpOcHRqN3da?=
 =?utf-8?B?MHp0cnllVS9yKy95eldkV1JKTnJWTHVBZTltTkIvSGt6MjF5U3hrR3F3M1JV?=
 =?utf-8?B?VFV5bXdVdEorU01WbllhY1EreXlaNGpwT2d1R1BmM1BUWlF4cVMrS3kzR1VC?=
 =?utf-8?B?L3l0WUhhdFN6M0pWRlVPOFJVZ3RNSFZrZ1JzVjgxK290bWpWNzJqOVg5cXBa?=
 =?utf-8?B?cUJ3UFZkNks1TkU0OERjd2RIVzJRY3FQd0hsa1pYM1EzYTVpTkh0dzQ0dWlD?=
 =?utf-8?B?QzFBMUJqaXpDbGZLcGZwR3BwRGFycm1qZ0p1UTdpd2JwZkdqTlVJbFVBeFh1?=
 =?utf-8?B?MXFFQnRsVWoyUFdLemxBU1Rha2JnVElUS0c0Z0EyRXRZa3JQbVNjQmdSdS9K?=
 =?utf-8?B?ZHdha1p0NWRiZGZab2lMbWFTSHZRZFJ2SDI0bDVxUnEyaEhnV1d6UisrdlVk?=
 =?utf-8?B?QmJOTmhVTGFzUXViWlI3QVRrQnVtZUZqS0ViaVAyZWNIR0RJK2JHQWM2TEV0?=
 =?utf-8?B?YWtYSEU0a0xmdkxwZkhsYU9MeFp0YTNTTXlKaTBnWElZKzMxQk5KOFNtVmwv?=
 =?utf-8?B?RFg3ZVlnL2prWVRoTzkyNU5hVXRiVFIyOHhtWENBYjFrK0FqOWpTVU84ZWkw?=
 =?utf-8?B?T2M5SUoxTHE1eC9vbXhPQTZlLzhkczF3bnhKMVdRSHhqc09CTVdWMjRpRVM2?=
 =?utf-8?B?U0h3WVYwaDJlTFNhanM4TVhscEk4Q3A5UTJZckdOZjMrQ3o3Q0NsTWNVY0dE?=
 =?utf-8?B?Z29YdXlya0E2Yk1ER3BPb0d3NVBJZ1l4QjRMWGdOS25EMHBleTFVVndydXdR?=
 =?utf-8?B?RzdmN2VNV3lsSHdLeG9CTWROVG5wMnc2K21ma3NUU3VQY0diVXM4MHpGdW9J?=
 =?utf-8?B?MHRmeXozbGU4OHRYKzVGbjIvTXVycnd4VnNoU01lcnpDa3BzRnRqbTVOUUhj?=
 =?utf-8?B?YkpuRi9lZmg4a2M5NTFzMVo4cFBLZ2NGTEladDJhNW1YZDMyam8raXp0SUpp?=
 =?utf-8?B?bjU2THNMdHRWZHBtdU9XSTMrL0xUT0VHQThPTU02M1AwMW80K2FIL0pxUEZQ?=
 =?utf-8?B?KytpMURFdG5rR3pOUGh6KzlYRGg1OSt5ZFR6UEJNcTJ6bFR1K3lVZ0czNWE5?=
 =?utf-8?B?ZmRUTFptTXRoR05sbElPL2NiNklTR3l2VWF1OEpzeVR6TEhqdHF2bm5CNXdx?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c89999-c1c5-4f61-7551-08dbb3b110d8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 16:55:27.9584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCTayxjRKE7Gag+dXSgJ+OPIwdbC4r03P+/FK6nY3VA7AvbxDPd+Okm9JCUsgc36VqCnRMIrvX5V0qS/0WjOjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5773

The Xenomai community is planning to hold an in-person meet-up with
presentations and live discussions on November 30th in Wuxi, China.
Attendance will be free for everyone, just a registration will be needed
because we have limited capacity. More details will follow.

Xenomai社区正计划举行一次面对面的聚会演讲和现场讨论，
计划于11月30日在中国无锡举行。每个人只需注册即可免费参加。
由于能力所限，更多细节将随后公布。

Sessions will be live-translated and also recorded to share them
afterwards. One session will be given by the Xenomai maintainer on
the latest news and plans of the project. We will furthermore have a 
slot with Q&A and open discussions. Beyond that, we are looking for 
talks from the community, in Chinese or English:

- How are you using Xenomai?
- Are you working on ports or extensions of it?
- Do you have best practices to share?
- What do you expect from Xenomai in the future?

会议将进行现场翻译和录音，以便之后分享。
其中一项日程将由Xenomai维护者提供项目的最新消息和计划。
之后还会提供问答和公开讨论环节。
除此之外，我们也在寻找来自社区的演讲，内容中英均可:

- 你是如何使用Xenomai的?
- 你们在做移植或者扩展吗?
- 有最佳实践可以分享吗?
- 你对Xenomai未来有什么期待?

Please send your proposals consisting of a title and short abstract to
jan.kiszka@siemens.com and hongzhan.chen@intel.com.

请将您的提案，包括标题和简短摘要发送到
jan.kiszka@siemens.com和hongzhan.chen@intel.com。

Important dates:

- CFP closes:            Sunday, October 8, 2023
- CFP notifications:     Wednesday, October 11, 2023
- Schedule announcement: Friday, October 13, 2023
- Event:                 Thursday, November 30, 2023

重要日期:

- 提案征集截止：2023年10月8日星期日
- 提案结果通知：2023年10月11日星期三
- 日程公告:    2023年10月13日星期五
- 活动:        2023年11月30日，星期四

Looking forward to seeing you at the meet-up!
期待与您相见！

Jan, Hongzhan, Rick
