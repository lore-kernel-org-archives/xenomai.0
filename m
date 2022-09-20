Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D216E1C14
	for <xenomai@lists.linux.dev>; Tue, 20 Sep 2022 13:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz5VWV8yo1Lp+NVyaYyX6UMPAnNJ3ttIri+EVUwOyzb15uzk2r8XmqYy+2LjpewopsYi+vaOfuqd4ycRT4Pc781slTdFoaU0w2SBY9S1d2xDrPSN/gMLP/sYG/qtfo1liehDwB7qa1j38B9zJdFPfyLj9In7XSswOEg3Ew0iwLsC/cxHbTKCdhaxD0U4IgLnGvVTqqUpRbdsNyr6V7Xsnxn8wMWGlCUWbGvGbInbsqAMeJjg1UIIFqDO2Xfu1FZIrwpoKNKO9w+NO6EbFuBFlkZQo0ppytk3vV8tKpkAqDBWvVN007cmMa3yMijGTyQnPDLySBeukiTFNNcF1OrIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yOBvp5C+FiaTdVtwr22BA9tapQ0Ua4MCLznSL4Xta8=;
 b=NX1ARjou9/P3Zin/VirX/KWoh0gmjZF7BlZQBiGKTVFlMPAXLZ7BSUa0e6WF9A60bZ/JYC/ScjUip6lScpunUxCTGkYGOT13tlvTrZiHqUmF90jDlbB1y7KAv8Idn+H7japj/1G/NihQlh2xMio8HycWazEiXBNpLPVw3Yuv36aaHJbP0GF7QAPeEHnvM0qXLBe6gorO0291ixJHqnU5BWbsTWQdNUOYGwt2h52hi0iG/A9hxnuCNPXPPMEVO8dc2lcCOZM4RUaf99xQUpewTCOn7I3f1tfBU6Dt0ju5q7iqhriVV4Ehxs2+jVCjAKSh8JdNkMC4L4aN2Y4juGkiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yOBvp5C+FiaTdVtwr22BA9tapQ0Ua4MCLznSL4Xta8=;
 b=VLKyy+js9zonxrYz8bSU8mBhWNIldhXQwbI+p35XH6n04wrtiMMDzhl/Z9XuDh5hS/2vByZa1Y/C/MCWrNVUhrPjwSTFRncK1KZMKbxm86kY/aZ88OQYoVx7lPYMcfL4B7vDCppewzDsA2yTYB90q5Irbm6hi/k63e7PYPTgaoVwNwuSVW55oSdUhF0eTsp7MW4tVVvRk4F31R8zmoW7IiSHMqbOVo7xJag6YnyHs6yGl9Ax24FFjP1NfudOT6RQQ5iCjEWof5mSTJOQ7ysBQkDU2I8KY3ziKYrB+beSwY0sjllCpi+6Xx0JxqBrp7tiZ8kO6ezVBf8MMYHXNhX+0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by GV1PR10MB6217.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:93::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Tue, 20 Sep
 2022 13:14:57 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b%7]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 13:14:57 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images] [PATCH v2 0/4] Enable compat tests
Date: Tue, 20 Sep 2022 15:14:50 +0200
Message-Id: <20220920131454.121225-1-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0129.eurprd04.prod.outlook.com
 (2603:10a6:20b:127::14) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|GV1PR10MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f58952-fb52-46a2-9562-08da9b0a1dc2
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5Y6zTdSaKO5y64yjmWp2fvLwbBfjPTStiRLkyAy+t/JXJzjtyhG8cw1J/ipkDS7LtcP5HPCVegcU7VF6tnVtniyNyw2H15FHhJnQ64EKhFrdDZJpBpAR6HDQfsd0xDkB7OzlbFzMIaL8Zi+sYGnvqSzUOek8bxOg/txP3wXB7xgIQnJzavw3PCrBPNcbvxJOgUIpZXqUCb5cz1z+RNK00YfTB0IYXDCn7wzpL8rDPlzskt91PHJpGXZ8OFpjbtSnCoFHtNI8SLHDO62pWTSESGH8B7HwPnJ25HeTYk3Vis92KNFZYuomtgTm3akzZjL7+LCn4Gs/qK1fpBUaGL5uIqlYUL836+mACLfXFEBzftAW9ZvjbWaaadDTsUys66AaWd7i5GynG9eq91VxZhNCnkRa/DJFNCVlWIbucupbySMaLhhYtdsAzD6C5gPpA5q/VomPhH+k3gKmcbVMU42IgsGHCqUsl3/Woud+jOF3w/ePYVmBq1MeyGo6YkHcoG0H7MFduC6NGxLV5+wuJP0upaMk0TBS6NXBqVmkL+qkDGFZH2QTLxjlu++Ip6riZKOt84yTCaCe0CGeVoZRKzRYXBFu7njuBHUCJc5XgcdOUoZbRMTCr8dQTGAbvsjpcgYwS+OpR2I5hLpRkLSu0YS6+/O7hprLh/zlgc3ZuD0kvJ9Kxg266YnboVBCpqnVbfoRlFgkt669KCcbE2YjWQWf+BtTeZaG0l/WeepcvuSp+lI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199015)(66476007)(66946007)(5660300002)(66556008)(8676002)(4326008)(86362001)(6916009)(316002)(82960400001)(38100700002)(8936002)(83380400001)(107886003)(41300700001)(6486002)(6506007)(966005)(478600001)(2616005)(186003)(1076003)(6512007)(6666004)(36756003)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UGZig85Us5KBqYbXKiiCDzACoW4sAhSJAQ4a2SYuvnebRlyzfjdEGsidhFLj?=
 =?us-ascii?Q?ikjAoI77ENZhjLGnD8nRG8CVNrACBjL3GFp8S47OsoINrgI3+T2fcogwkHjL?=
 =?us-ascii?Q?LVNolWQtJjDfZxjbm4F0jcwoG27K1Le2Dj5fSmCZhBQJBnvw9tYh3y3nu6Tk?=
 =?us-ascii?Q?SzSAXzzbK1O2jFGgfmdttHhsbt00bhaqobFLhAwF6AaDiN3Epx9LRV3iJqnz?=
 =?us-ascii?Q?wmU3hhqs76ACmTefbJ8UBO4VTpS+ZU05k0tbP5SHZKSDxAdyd5WGL86Bu/vr?=
 =?us-ascii?Q?FG9O63t5EvXrcO53QQsgMWmG60M8TNHGPK0sR9Ck8d6PuN2Z6EqgCs1xCsmb?=
 =?us-ascii?Q?GqcFmf1/teHHYEZieFghRTtPlQNs1nnvu4eOHtwa6GGhOQqUv/f5eAYnm1K2?=
 =?us-ascii?Q?gbDOS8crJX3Bah7H6cpJC5J0sTd/3cA8vuDyKbTL5bEdstP16EDpyNq7EwBH?=
 =?us-ascii?Q?YP2gGxqCpDoEqic6LppcbymsF/TjQt/rsmdOmUoCqam4dLYwg9bHxpzi4EMi?=
 =?us-ascii?Q?HtkAADIIUpSsywveVVQpGZjxNC4OTgNLM1JIw/gNvf9aGaffN+xs+cO9GEHh?=
 =?us-ascii?Q?cONg3rvwY1NRLcwnpQUicWIdU1dLL4alPVhyw2C+tQtqx3jqzToFt/ABPldU?=
 =?us-ascii?Q?OTNLd3YLW1P1/qUgoCpc6/jQ9ys6jpEMfVa6+k0IbUjaYQjGIMwO/OAtHpVa?=
 =?us-ascii?Q?JM0x94zTTbLUlEfNHNOVJsoa4b344STmHhIQNihaU3D1GEL8CAznY4NszWr/?=
 =?us-ascii?Q?sMz0QYYKuVypwB7meVrTSZLOHGM0gut7akpR3S/PFQQj+ZuLxtTJBxj3Vswd?=
 =?us-ascii?Q?i7o/FsYHRgQvRxw3nrpIHBCdYTCuxCbPbwhST1MMod+3Dcme7CAOC9Y+Kbmz?=
 =?us-ascii?Q?wv18YApceKZKgNNk+xX3Pu4L6Xtc1ZCXREvSBbguxDtCLgGq44j9xQsJ9QcA?=
 =?us-ascii?Q?UUnzlkqLab4APwajbjQBAsoB1iSYiowtI3LDfe29cWI6GVYECw2SCpQ/gQ4+?=
 =?us-ascii?Q?INlA1pw1XhHTJfShsaOPLsWaLYzjBUAzpbqRmVd1fcrgolLJ0nrL/rpB45eQ?=
 =?us-ascii?Q?kziukpWYeDU95KTcSKyI98lGKqFAAVkvrALDupRQExOcp5YRx4q8Nwb6Ukwa?=
 =?us-ascii?Q?Ke5xppqQOOJsKTpez2vVq2kBnJY5Mx2I3V/WrooMvReY9vp8ybatKwpYzEz0?=
 =?us-ascii?Q?oe5tuRaijuEpBuWqI5j+KCl9U6osIwL2TNewbtRqMoanSxOnNPc0U4b8O8Oa?=
 =?us-ascii?Q?CkskW1wALtIyZgasbNQe3FNFqdFzw6ZR0OeBS0U7+/B5+POMcDcw9udVOufx?=
 =?us-ascii?Q?JjHGb9EntyZ3XPcwIBph/QKX8aLExHeQNxrsOIpHxGd3HtZ7mpNke0CQqLSc?=
 =?us-ascii?Q?haBMiwIx8qDA6l8xPjFU6GRj8rczdcEfKf5dT4vwcZXYv/qxWiaR3CHUwE+0?=
 =?us-ascii?Q?WgXFD/OM07h2h8TghasTBsVUBp9cnj99ooAUTTHwXQUDBSAdKJkyWh4G9kcJ?=
 =?us-ascii?Q?6FDhGLoXenCdM41DsuUpu4Wa3oxqzBQ2sku+RDa9aCTSVnT5KWOVuy51g4zw?=
 =?us-ascii?Q?aaAkmm01ou6lwHkbnfGZ6HKh/uHjYQzZmCTSK0V9ZNmZCraLo/Ks4Dm9515u?=
 =?us-ascii?Q?B6tKbIdDA+eOmPKk/GZc2hg7VaXsYTa7BzHtCYjiCldgoobUmmqmSJWFf/1c?=
 =?us-ascii?Q?XTdjJw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f58952-fb52-46a2-9562-08da9b0a1dc2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 13:14:57.9022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Wxf1UZwvlKL9l089RofZwmWuFnbwIkKUR+J/v5vJgfLkoLaNGcYLdNUcWmaGr95Hahp5+9Ger6gdl3YRtT+N861gYoDmkjDW6i+NrkWVl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6217

Changes in v2:
  - Updated patch 3: Folded next-compat runs into the next "stage"
                     (review comment)
  - Added patch 4: kconfig (addressing review comment)
  
Hi all,

this series adds the build and test jobs for compat testing on x86. 

To get the tests green the previously submitted series targeting the 
Xenomai project itself has to be applied.

With both series applied 
https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/21 should be
resolved now.

Best regards,
Florian

Florian Bezdeka (4):
  linux-xenomai: Update kernel from 5.15.9 to 5.15.57
  kas: Add option file for enabling compat builds
  ci: Add compat enabled build and testing for x86
  kconfig: Add compat build option

 Kconfig                                    |  8 ++++
 ci/xenomai_next.yml                        |  1 +
 ci/xenomai_next_compat.yml                 | 47 ++++++++++++++++++++++
 opt-compat.yml                             | 17 ++++++++
 recipes-kernel/linux/linux-xenomai_5.15.bb |  4 +-
 recipes-xenomai/xenomai/xenomai.inc        |  2 +
 6 files changed, 77 insertions(+), 2 deletions(-)
 create mode 100644 ci/xenomai_next_compat.yml
 create mode 100644 opt-compat.yml

-- 
2.37.3

