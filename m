Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80045.outbound.protection.outlook.com [40.107.8.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051C87E0
	for <xenomai@lists.linux.dev>; Mon, 20 Jun 2022 06:31:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0BxTmcuJDV5kEG1hWymMqV7sPE79dngdcnxl54ilu4CaTeRci03jWhSEXatfMR7Gq5qAqfC+DRT2aatUZsTEEWYjhjzqCVyeQa35N5aKoemVKKUJaV97wx1I3QJnUKq9yPZM1Sliz3qtAQ6LYQ6QS8Uf6VG0rN3DjD4BeUsp1baZJw6yho34GeL3SlEnhxM6gmrjavabLoSNnJPpzOyel3O4mLkwtV49KkvDxFqV8UMJkV27LAfFEviZZj4mF0cXe9VPSeDYwL4idkO4tyuQOOP3a+GmAtwno9WGEoPk2GI91q8zlqqrtofRHP7TefTpHXnNAz+9cb5e1SNvTSlWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2HMaxZldyZN/wzaE6ecDtgMXssZv3hYqkd5BSjavXM=;
 b=OxSEwcSbtqU4n9xcrrY+yR4+pslPXxDXisAaGX/En8nj12HIevlnU7ZZu7Hfw5j1rUsFOc0bbshzY9cH4DmMom3ZLHXntRm/y7UXUIqytPXQzxq/7Gz8/rW0+rM9pnG4YF8fr6uu5NA2NMuzz/1nowvZlMPsrOLLZL+Vf1/cl0KJq/sXXnoMoL6qy+4eJLBbeR3bhh/Cibbr2C+V0xdEHTTtcEIuhn3RWUjjHk704C1zmOTNLxWqi0DLMLSiKQUjL3THteuEfsUGtindpzlEIXkt1sa8xtyw3OshzvPDGIj41C5lzrtlMMJRpO6hOPK/4tNEvTJE5GlfB7K3/6jDCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=xenomai.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2HMaxZldyZN/wzaE6ecDtgMXssZv3hYqkd5BSjavXM=;
 b=E/ZMfGTnwLRyi3e+ckHgxJABQRS+vv429edRMPXi2Tlu5G2l1X4yf/peRBQVoaTmi0vdbCSGybTPsTzAe1rVDHSsE90z52DoLebLm7panxjjxtnWMrpwgXC4JKr0EL1QprTpYqwxc/Sy7KYHJggJnBqpGypXKr5iwoPol11qm3+mlinw/JJE1Ne69kxaggF+LqsDReZfhvQxrNbb8vs3BBigkIq5XZKPBn29LnZ+W4NqBJ+CQehEeyw80tMu1SvfGJs7FizkIgc3yuTSKTBhYmyhD2CHqumxd/Ee7lqobEK3Qgn4nlr97xwzeSAX4j6MLzRMDJzjcOqWiAZB4DBtQw==
Received: from SV0P279CA0051.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:13::20)
 by DU0PR10MB5558.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Mon, 20 Jun
 2022 06:31:27 +0000
Received: from HE1EUR01FT065.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:13:cafe::e1) by SV0P279CA0051.outlook.office365.com
 (2603:10a6:f10:13::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Mon, 20 Jun 2022 06:31:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT065.mail.protection.outlook.com (10.152.0.242) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 06:31:26 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 20 Jun 2022 08:31:26 +0200
Received: from [139.21.16.131] (139.21.16.131) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 20 Jun 2022 08:31:26 +0200
Message-ID: <1cc628cb-69a9-6dd2-8a23-fe6125a7fe1e@siemens.com>
Date: Mon, 20 Jun 2022 08:31:25 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Mailing list enabled
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, <xenomai@lists.linux.dev>
References: <875yky6idl.fsf@xenomai.org>
 <30615b27-e696-2000-b484-e6433379fa2a@siemens.com>
In-Reply-To: <30615b27-e696-2000-b484-e6433379fa2a@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.16.131]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--12.555200-8.000000
X-TMASE-MatchedRID: vIFHZ/uiyj93J2rmPVmIKlWhtF5d47grPg9yfk4YC0Yo7b5tLxYZrUhM
	UByBUHErW+83mz7I3jHldxgef1KPBur0n5nmCu6G3pvuyKOE8lAMIQP85zkv2/bta0OAYFzyTLZ
	B6U/YaPo1EH4lNzIZSH3kR6l0wGIGwpGJd9opianLLeDfTUXm/TN1VvnSogA62fov7TwhL8nNCi
	BItkSKf4DpStszePepmrP2GhhgQH8r59u/gzv5MLUzq8RBkJuGSSOWVJeuO1A5f9Xw/xqKXZwhk
	tVkBBrQxq9PbUOwsP9QSFbL1bvQASAHAopEd76vUfbdbfTOFILhHecn8WQHHy1vk6vtcLIj/L6c
	GQZumZTWjLqRU7akAQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.555200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 4C1A48460FB557BABFB869E8D58EFF8612298289903BB6E090E62AB50B38A0592000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0be87a1f-4ef4-4c1b-424f-08da52868101
X-MS-TrafficTypeDiagnostic: DU0PR10MB5558:EE_
X-Microsoft-Antispam-PRVS:
	<DU0PR10MB555840B1EC775D9C7590CE2195B09@DU0PR10MB5558.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	948Nf/W41S7YHN/zlzuoG1Ub3+KvJene/38xpRozjRUWtTFXU9G4V9HunW/u49BBT9QJjpFb20KNzRn25B8NLhWctK0a55VfbJ3Bf3MgZYy/1xpyBJjII/CGgwHBfXoen/MwTqeIA+2GBVHQRsGtKBshBUOqoYVrAb3jQSUGqtZXZE/Y3Uzv3ltiuGrwZWLUMsJQbowNbZTQyRTJ/6awyUid9lJHT2phfxaq3eASLQQflO3apjg65WDVe/FI/HisAqstN9qoZaZnOj/vwKhV/IgudvKdzdRy54UF0gQguan4mq9JO9m6DHtpKwbw1kMojw5UZdvbyOUpQULFN6r2YWYkKXSZdBxQlv07uXdVlwRGjNBVzmXHPf0NOLUU9v5hZPmr/K/D3SkUd+DDjzlAy0JXbGYYjJeYaowg1r761ipPeIeqYBcPfEuYs192uctMwquGpIv6+TCe2gexkp2VZs0onp80AsmK1rXTbYVZ+OmA1iYfPnjnJp88TlnhaDT0JbjznyVOo+MRnnYTGeSvbz5fqgzxAtmTIWTZCPFtnm1GURJToON3QSBds1v8vCu7U+LRVc0+LeAfuGeCPiAlUdIIPdDvLcQuZBsR+0sY/OCeYwNAJpyoLVhftov+EywI12prhBJMANf0ea1PkpNtqo6a09mY/3HuymmIGES/bohATzmbcONbiT16X4gBNZQ7rBubI5KPQudEbkuztlAiRx+Zu8+Mq/ETr1mgcb1BvdKAN+rvrAEy7rZV3Sh0ZjRYowA3talvvIJ6LeVoaNxqD8nTL5mCsZ/tXk7pnoE+uL4V3zS6ktuL+jLPr2L77wTmjVpy0lA/FKhseV8B8fMYZg==
X-Forefront-Antispam-Report:
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(70586007)(36756003)(3480700007)(31696002)(31686004)(86362001)(8676002)(53546011)(8936002)(498600001)(36860700001)(82960400001)(16526019)(7116003)(40460700003)(70206006)(6706004)(83380400001)(110136005)(4744005)(44832011)(186003)(956004)(2616005)(81166007)(316002)(82310400005)(336012)(2906002)(47076005)(16576012)(26005)(5660300002)(356005)(3940600001)(223123001)(130980200001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 06:31:26.9003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be87a1f-4ef4-4c1b-424f-08da52868101
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT065.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5558

On 20.06.22 08:13, Jan Kiszka wrote:
> On 18.06.22 18:11, Philippe Gerum wrote:
>>
>> The mailing list rehosting process is complete, welcome back.
>>
>> Unlike I previously announced, it looks like keeping xenomai@xenomai.org
>> available for posting to this list via mail forwarding is not going to
>> be possible. So please switch to xenomai@lists.linux.dev for this
>> purpose, the information on the website has been updated accordingly.
> 
> Fairly inconvenient. What prevents this?
> 
> Did you already updated the ipipe release script accordingly? Just
> pushed a 5.4 release, and it seems the announcement is not making it.
> 

Just appeared, all fine again.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
