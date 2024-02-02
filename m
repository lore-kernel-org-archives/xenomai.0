Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2066.outbound.protection.outlook.com [40.107.247.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D952E851
	for <xenomai@lists.linux.dev>; Fri,  2 Feb 2024 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870640; cv=fail; b=NniecoN+B2Z+AMJwljWbrnt0GarutdVQ00dBm7lT3uwtsi+VrJrs+78uADA/djM/RtwCKq/9KS2WhNhPHINGejkkKu6GZNZU0Q0dBTw7CoZtbDbe2RhTVldEPi9P0ntqwqjIpv7HDhngQb/QJc5gUdRWpqGxcCjGUU62w6aS2qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870640; c=relaxed/simple;
	bh=15kIs9XnBAuUaApCxCtSCAUOO1ZDXFns4hc9T/Y43Sg=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=gyakUVexv8OQtajsZbl8gGNsQNfnpAesZ+WmAYbDOLvFzHeLJoYshHmUgjF7nvh1YAvIFaLKXnw2cjCO+LDJHmQUDYZ8XXCcIBIdYJdSCnjn5HFkWjm1JI4hUUOnY9L3zgyTCge5j8qbc0w+Sa3+xcAVxLHQYqRSBMus4K1jmOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=GkId+YAd; arc=fail smtp.client-ip=40.107.247.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="GkId+YAd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMOFk9ntFmvKL9lfmSE8pEbHjL8Rsw4hcwjvJM1t8kZbLHMaxBzSUNLT97/IWPszwsNgG8450FMdg4ZVgAcd7JNgghG6l7U8dQu8rtXdJnJz3yPzAcYJDe0vfoZ7U0TSBftrzSdUoiETs1WouqC0kOgs5eAXmV0/TbVbn0+gZTsLrEYpcVsmEx7svqqmpkXtfQB/KLjAptYOicvwmts8Nht9hF6KxKzs7JytNjo0hM242pHtSGvPoZSS1BDdwPaHJGRMYNovX5EuHRXm7Ckm5cqQjkDHN5B9bk79CL1pKz+mPKrtp8T/N7l7HD+xo1KYCOE4TxMHX1Yfi9XMIO7nfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0jbrTZtQxxZWK8ZO4bj7brMZUKzL1oJESVfmYU9d54=;
 b=GU5T58vka6GrVXiHJwhog80s92Ck3t6A/sRylHjP/wDitMYWe3HLi4ZGudH/tQLUparvl0AUtnwAkd1BGWZzBW8HpEDpjPhFgWdprCSSoEM/KU7zJbSku/QQCVFxCzgycYVphtZPqziMh6DGMDe8PKtRmA5iRWlKaxyXpjwSHg3IbS9/DG56D/fLht17Ppy9nh0Uzy4vcfO9Su8rEQZKdOYmQu7B2L5IqebEo5UaRT1VEfdo5KS2rKJh9ASMNiFNmTXsQeH3MyXc4E8lWmvfO5FWlYjeHtWAAgxCcSqrVg9D/2B4p/E9X42mplDtAuJGyZXAyI4GnopqzuSVJPhn2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0jbrTZtQxxZWK8ZO4bj7brMZUKzL1oJESVfmYU9d54=;
 b=GkId+YAdkcNzhjcVUbLAfj0wJP0cnbpe0d+3MEKHLj9ORxXSd+WxEPlwiIG6rfm6hSuicjxiVcN4dcQQjYZqJ0n3oUPZ2r4++53Aasq1IHO/ddm+Aq5oHZ+6LaYphtS5oj/XYjd46CQFI4iZ2BwUIdkvIZ1ZfKFXOHLKsX9bCqQ90q1xoo8Sine/EDa/FGUnwOAZh5tFKg6V7b/tbeXmC8q7x/XJXNqIHZr9RHugdgOo4HJed5kzPaRXqYtZl6CDCXCyCUTR3PqUW0Otsz+fQSuJqFt4o4Fe9BSbeK5+g15MGOc3kdNxhc+01vXistXkymz5GKRJUtzzN401LKND1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6066.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 10:43:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 10:43:52 +0000
Message-ID: <c110556d-88a5-41bd-b820-f8a356cf0eb7@siemens.com>
Date: Fri, 2 Feb 2024 11:43:50 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] start-qemu: Direct qemu x86 outputs to
 virtual UART
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed72470-7df9-474e-0d92-08dc23dbd905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yv0ipkVsY4S685svN/reX/XaTqSAlyQ+Ny6LOg7XaJ1ZvDqVEuBRfgeawz58IrjkuSuMzAh5VduDmUZnEnjUrcqoP3tLQ82+5QHJxKNzfaAY4VOWMPRpBs+r/X3zhhB0HC+QKvsSrooj6q54qZdtNlajoc5dVh4QUA6X3TdmC2WUm5PthclmcVPHH3if2pe/n7JZDpe0rJR0qw5qL8ZEKMNz75YZt/D0uV/QndEbFeziAeR0VIqHOouyp5NFMjpesnu9TvLMJZWpzd/y4rcD9n4YuSldZR6dkAuDhr7UXq9thF7cuoZe0aeyYrLXIWjTwMgA90hyHtBorMmkBfk3c30L2ump8An5dA2VS6M99m6YPoLf0n1VifAY3bxz4OYqWiVuHFu3YUJhiVpK0NXM8+1r4R//OcUzbzrBU4julVDwc0qajFDn0yaeMdT531pRjL3c9SZwuKKpnuejjDk6PNnRUznp7gcBOHXxJ6P4SIHYfWjo+A7VIRqMIbLHiVvbJtYgH+I1DPjIAaKgfMbz9vTs3lYLD4e6CMVApjdyiD1otRLIAKRKIqz3WoxHWAuij/Gx7oD/ea/U+WAqG4oCnBNCguAZXnu/IIgH5BnLClawuVRGWU9LNeJ9CxRVkSzyEMGpfmOMpEikXZnBGXrzxQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(4744005)(5660300002)(2906002)(44832011)(8936002)(8676002)(316002)(6916009)(66946007)(66476007)(66556008)(31686004)(478600001)(6486002)(6512007)(26005)(6506007)(36756003)(2616005)(82960400001)(38100700002)(83380400001)(86362001)(31696002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHJBV242OU9FQ2IyZjg3NGVPV3VleG0yVUxMOVVDN1NXUHpLdEtyMzNaOUFm?=
 =?utf-8?B?NW5KNXR3bjUzRFhjSk5DR2oyRzliY2NOeXJEMit1K2ZmcUQ4Yy9uR3Z2SGpX?=
 =?utf-8?B?SStGQ1Y1Vm1MUjkwQlQ5UFQ5OXYzUkQ1by9EWktyazBqN2U3dGZYclRFMGk0?=
 =?utf-8?B?dGtGQmNLZVhsZGt6dnJrNVByTzJFMkRLeDBWdkxGczA1NXNDcG05WHY2R0FY?=
 =?utf-8?B?TWxiTlg2YVFtUXBITGJGZ1VseHBwYmlpaUdwQkpEMmJYb0MxNlJjSm1lMEFv?=
 =?utf-8?B?d1VWYTVEYnJLQ0pWYnVqK0FkNGMybDMxUWxKMDlQVWl4UUhMYk80Ym9qQTZ6?=
 =?utf-8?B?MEk0Y25ZemtUWmd3dDNIMUpIL0YzaDJrb0VlRWJHVURTNVo0bVdpMmZveHYr?=
 =?utf-8?B?elp5VERyRm5HemxNdTdMbHQ0VVpGd3haaVFjeWc2aWN0KzRXQ1l0Vk9zaHJD?=
 =?utf-8?B?VTFsZ0ZLbTJ5NW9tcEtJVll6UkhKTmFxREFwekRVV25VTG10V0I3a20yZHhS?=
 =?utf-8?B?TkxtYTcySGlHNHIySitQVHN1TWU0Q3RSb1NQWVJ4TXVFVytydzVjMjFvK25q?=
 =?utf-8?B?bWl2TzF1SmJ0b0VDbTZlR2lRK3JVQzV1NktjMlVHeWNKbk50THB5OHhFVnFl?=
 =?utf-8?B?QWROYkowY3FORkdZWXluY2hBV2RxZHRhMmZoWGg2Z1laME5XQkREZ2JvMWNk?=
 =?utf-8?B?RUcyZmx2UGg1UnpKR1YyS3pnWFJDUkRlYjg0UXJVc2xkVzFHbEduQmNsTW9W?=
 =?utf-8?B?OHBLVGlTT0FLamU1THp1OUMwZWtvRGtrbCtLcTA1ZDY1MkdFbXJKVlZqL2My?=
 =?utf-8?B?SEhxdjFRT3hRb0xKSW9ZL1REYjhDSkJRZjQyTXM0Wldmd2xYaFhWUlhza0E4?=
 =?utf-8?B?NE5IekpaVkFmcDRiVUVSRHRWQ0ZTMlZpeDNlbHJzaDk0T255TWRaV1U5Nmdk?=
 =?utf-8?B?REhBV25tK3VaaW56UTlyY2FUUVR0RlpKVlpWZGw1WFdpbGVqREN6UFh3RDVm?=
 =?utf-8?B?elN1TlBjR3FDdXlleXRDUGJDN2FNSU5sMzJEN3pyZ2t6cHNlTVliUXg0NDdP?=
 =?utf-8?B?enZETHd6ZGtxaitpWmtOTTdkUkxsd29SeW8xOFZoelBiQ0RKdkg2bXNwNDA3?=
 =?utf-8?B?bmhCZGJSOVF5V3QrZWU4clNVa2FBdjNNVjIzYjNUWU1NMjFNRStxejk1U2gz?=
 =?utf-8?B?bytzS3A4dkl6QkFaOUk3Z3ZYd2pSeVVLc2RKblhmY1owR2NLT01wSzMxQWJ4?=
 =?utf-8?B?b0J1d201Q09kWnZqVmZuVkJFVGNqRjRmdkN0djZCcHQ4aGNIZmxVYkZLTjVK?=
 =?utf-8?B?aDF5bmtYVkR2dTBGY01GUmg4RWZXZkNhRzNHQUhuZ2NUcTBuSTBZK3dvckFO?=
 =?utf-8?B?RWo0RVd1L2lHVUZpTFlYQ2hoYUVBY2VCcVdpUGwyRVU5TGd0YzMwdllwaEhT?=
 =?utf-8?B?S3Jxd0FjMmUwN3FIcWo1TFUzazRmUUpaSWJiRjRWS0ljcnpvZVJzdjlEOXhr?=
 =?utf-8?B?Ylhtc2t1NXJjYytaUWhaTXpTYnN0K1lZMkVkTGpwR2JMcEpjL0FnOFJTbHA4?=
 =?utf-8?B?VU1CaG83elp6c2NzUktqRi84aGYvY2poaEZDYXdIWlNZc1h6RlJhczhsdFha?=
 =?utf-8?B?Q2wvVHFqSWl3eHZad3BWRDY0cFRJSmp6bUVHY05vdjZUNUZMNEdlbE9SNmFK?=
 =?utf-8?B?R2JqaXJsNExJbnV3Z0xsdnhZN3VodDFxZElLTUdlKzZMWTA3MHR2WUlZY1dV?=
 =?utf-8?B?ME84UTMzT3E2aU5jRlpmZ21pdkVmSlVVcnR1QlZjQkpVbVdZOWhla250MWhL?=
 =?utf-8?B?d0plYU5xQzZSSHZ4aE9ScHdDSHdGNWZ2S21LbjRLY0NDWWpZcm9rYWZzWTFi?=
 =?utf-8?B?MmxFNVR2L1Z2a0J0M2NLSElRVHZhdU5rSWRkRklDd3ZPWDZHdjRUVGxtYmg4?=
 =?utf-8?B?VmpBckh5NllPbzk5a2lTZG5qTU5IbHJqN1NDUXhKSlZqRFdYMjBLb0FmRUNY?=
 =?utf-8?B?ZEl4anBoMTFmQXdPcmZUNkZYK00yQk5PQkp0azZFMU41ZjBoYWhPQXNiZmtM?=
 =?utf-8?B?azgzSlRJNzFTenE5bTE2OHp0ZHF3UXNVcG1OYW1qSVFnbzFqYkJIdkcvMnJz?=
 =?utf-8?B?MENHcDI4Mm9VelVrK1g2SHloTW5DVEVNTWlCUk5UV2hneGozcmNQN1ZVWnpz?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed72470-7df9-474e-0d92-08dc23dbd905
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 10:43:52.6611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVjNIjNKGmKwCE2Q05X1y4dB7hzbgbfFHyK/4fwISzlyLW1al8x0dpti4I35TdsNSUKtu0dndkjQDKcoxqU/7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6066

From: Jan Kiszka <jan.kiszka@siemens.com>

Aligns x86 with arm/arm64.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 751d20a..1be31cb 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -46,7 +46,7 @@ case "$arch" in
 			-device virtio-net-pci,netdev=net"
 		KERNEL_SUFFIX="vmlinuz"
 		KERNEL_CMDLINE=" \
-			root=/dev/sda rw vga=0x305"
+			root=/dev/sda rw vga=0x305 console=ttyS0"
 		;;
 	arm64|aarch64)
 		DISTRO_ARCH=arm64
-- 
2.35.3
