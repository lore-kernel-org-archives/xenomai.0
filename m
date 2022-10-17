Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80078.outbound.protection.outlook.com [40.107.8.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FA7A40
	for <xenomai@lists.linux.dev>; Mon, 17 Oct 2022 06:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1X+qXE0hKhfKme3K3H1vHROjPDrVcCDdZpuVAZPE3+W14sCd9/qlga1qsptpld/iu/DNztRTczyP7yCo40ZptNbQiXho4QrGvuU908DNqeOor6D8HwK8AeBRIB4Z0Q1jqCWpwxiAGxIjoqRC5QeQJE860wg3Y2XwWSjT+NzsQPMNowZNoYoMpq8o+hXi+t2t7C4j/th4n7UNN4KARBuafY4rVUAttBVqlPPbH+ZLoYCzJ+UsuHR4gRFBeF9snzJiuxIs5v8WhBclD7FinMw+bGsgKt9H2G0/vamCvn1i8EKpP7cGWjdd9DKudHGAA1BPsF0zMe+IQAHABCcbCCxRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOc8yKORG4HQPcuLueNdtdZRQNUo6hD+O8FhY7jp7pA=;
 b=XSyzkoBMxVR4O+ntwVMX/CBBVcCjfrPh8yjkn8YW8UkbeFMp4ZwJv+jgXCeyC5mVZp/KCfIr5XXIIMkF/oy4gzzEoCGDw9Z0Jof2Wh5BQDxkD4R28NTf/THwtOdnC6LAKzCvQJodRK1JUL4Hb6/e4Xx9/8lLuKrhFEx0fekKKzTqZkfBFgYmp2ONqyW6vMm8RhYy8mRmu5vI/JfDTfFJaU03O8SasaFWXbPV3eqBoKOMXA13j2Io+0TgRHHi65bAaEr65TkopGUKyr8GCeoSKn6fVmgsL6GDckw27sW0MxFBUfLsp04/KrUFlKwaS0VCNj1vHpopCdwgR9AtbE5zag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=sigmatek.at smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOc8yKORG4HQPcuLueNdtdZRQNUo6hD+O8FhY7jp7pA=;
 b=LjxMF6FMwJA9rbfmCE2ZRIYOks4s7XXXkF+rjhZvCy/UpeNmObn4+DGkPd7T9CPslWb4PENk52+m92RmJE9aa/pdxtKJXZlOjVaPVSxRJJqvQs/EZk6KVe7RJUNZro3U2JeEnKVphKbDoUctr3166jY0M3nkmsn/GpsUS5ztvBhFSJ+nOk//Ya+UDLXr9PwK1TjqO4Xfz4JXT1tuVfUHoyzBD0dcePwXD/+LnArLvtyp65ho1aqG3jPHNDhC9XvCiArvcg5lqG0yrOa55wXNhC6/1pELkc6XCXt8nr54cRsHCE7qYzEGIB4ee1AA0YRaXoSz8EEYhiHVMpSyjeIenQ==
Received: from DUZPR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::13) by PA4PR10MB5562.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:273::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 06:43:16 +0000
Received: from DB5EUR01FT060.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:46b:cafe::8c) by DUZPR01CA0025.outlook.office365.com
 (2603:10a6:10:46b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Mon, 17 Oct 2022 06:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT060.mail.protection.outlook.com (10.152.5.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 06:43:16 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 17 Oct 2022 08:43:16 +0200
Received: from [139.22.133.53] (139.22.133.53) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Mon, 17 Oct 2022 08:43:14 +0200
Message-ID: <2a77f463-177e-b88d-673e-d4cfa12cdd25@siemens.com>
Date: Mon, 17 Oct 2022 08:43:13 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] fix oob_trap_unwind call in SME handler
Content-Language: en-US
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Philippe Gerum
	<rpm@xenomai.org>
References: <20221017062827.2589013-1-johannes.kirchmair@sigmatek.at>
 <VE1PR08MB4909F06FC4CA8F02081EF97E92299@VE1PR08MB4909.eurprd08.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <VE1PR08MB4909F06FC4CA8F02081EF97E92299@VE1PR08MB4909.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.133.53]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.254800-8.000000
X-TMASE-MatchedRID: rRgX50UcFf45QaOxwNGfvo9bHfxDWoibs6hFnoyjhkZZi33TPYUKl35L
	mbb/xUuaMRfB5CFTtOan+DtAMiWC3SGPFt6jk3A0B6HXHfeOF616bMYbioM9qWvOwg12ikVScuF
	RT+prg4ZjjMm9SMavFW5bGzF5RLbqnVGdm/iKvgfdHzL0WnmYkswrDggcQ6d1AZ0lncqeHqFGI9
	Mwxz8yaVbDmwy31ULEie3MY7Xv0phGO66u731D0o9CL1e45ag4tnhhhEriYwduXgIqq6mQyvRU+
	9PTPHSYhz0lzsrxmqajxYyRBa/qJQPTK4qtAgwIPO9KPUEX8ztWdFebWIc3VsRB0bsfrpPIfiAq
	rjYtFiRSvIghTdqygp7YEwPWISqoQ82tWJibrgXwfvegM+C9/37cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.254800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 8655DDEC734F5748C21FB31CE36264F9ACA28836A681075C8D25A4D218EC7FDA2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT060:EE_|PA4PR10MB5562:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f94e81-b5e1-4463-adfe-08dab00adf17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C+HAB9s1l+dOLKKMkrN3D0oaw58SHwJSfNtR3ekdV9k1czikMPAJKYCWf6IP9L1L3Le/nlPesF8daPvGow9dqFv/cxVCNeKxGGxG0PHL1DMzS/b9q4NBggOXvCzPvnQftshgqzANgsrz/QwsETCH/6R5j6mDAXiVIUTiGiBeRmqmZttvHrxD1Szk3MLJygOnw/Yr+hoyzz+Q5xDbvUelpLf4kHSgb9ssGoGmGpWILESfJhXXbqGb3oQZ7YVFwg1KF/z+quhBs43/7d2eLjSLypnivSInxEbLgVgJ2wAKjzJ/kATpD4fHVjdH+5SKp6kDNHrdjYvMglUnhMoAC42nvytP0pI95yu5rui7KObkgTUY/znJ1zlMNXdRMVXVpuRhg6TEeRthMD1AFLafQVROv7k2Cefp2rxz81CMzd6Vwjl84WEBPGEGuQHyWux0Fs0rNd8xsJz/UFbD3bnedAxGH8g52ULQL8Y6sxma60YZ9MgAeqOONB5c1LDgfA1ztqEv3JhJPRd0uDwzZT4Ww7wD7wCF4F3iYfhXge6x0BGfeojmC3vq1ytIvgMzoKcYpgj4XNg5HE3osbbD8r9jvtEvEVetvMOcALm0dcwosL+IpDCAXCGEWSTYoKL31g2/R9uftSp1Z6VsIORYVi8U+DL1EfkoJSVhEyaF9WsEXFHKlucQd+r6z5NhZxekcO+g6WLnw+Z+82LBjHEhc4CN2y+1fzBwhX7LJ3jYLxemfVPdkmyl9tyVVAN+R0LTnCfInhkxOdLql8ZnVi9lQvOYMHKZfsXqLdeLuMoVO9k9CS9P8rBrUFjKWIm9u2vQP1WiSwcTIs6izvhExEl9ADeEoJX4UH4Wte8pZknlWso5qqvXiOxHXLESx2bm+pzMsDLYLr8uxJ8PJju0Xxla6gou7Td0l0PXF5WrMbc3bREScUuJYDw=
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(36756003)(31696002)(86362001)(31686004)(81166007)(82960400001)(356005)(2906002)(336012)(16526019)(40460700003)(40480700001)(5660300002)(44832011)(53546011)(956004)(2616005)(186003)(36860700001)(47076005)(26005)(83380400001)(34020700004)(16576012)(6706004)(966005)(478600001)(316002)(8936002)(82310400005)(110136005)(70206006)(70586007)(8676002)(41300700001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 06:43:16.4625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f94e81-b5e1-4463-adfe-08dab00adf17
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT060.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5562

On 17.10.22 08:29, Johannes Kirchmair wrote:
> Hello,
> 
> I stumbled upon the fact that in the SME handler the calls for oob_trap_notify and oob_trap_unwind do not match.
> The fist has ARM64_TRAP_SME, the second ARM64_TRAP_SVE as an argument.
> 
> I am not 100% sure if this is a problem. But I think it should be fixed.
> 
> This patch is for https://source.denx.de/Xenomai/linux-dovetail v5.19-dovetail-rebase

Are LTS versions affected as well?

Thanks,
Jan

> 
> Best regards 
> Johannes
>> -----Original Message-----
>> From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
>> Sent: Montag, 17. Oktober 2022 08:28
>> To: xenomai@lists.linux.dev
>> Cc: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
>> Subject: [PATCH] fix oob_trap_unwind call in SME handler
>>
>> Signed-off-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
>> ---
>>  arch/arm64/kernel/fpsimd.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> index 72e5cb8e99116..be2e3ca8ce877 100644
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -1542,7 +1542,7 @@ void do_sme_acc(unsigned long esr, struct pt_regs
>> *regs)
>>
>>  	put_cpu_fpsimd_context(flags);
>>  out:
>> -	oob_trap_unwind(ARM64_TRAP_SVE, regs);
>> +	oob_trap_unwind(ARM64_TRAP_SME, regs);
>>  }
>>
>>  /*
>> --
>> 2.25.1
> 
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

