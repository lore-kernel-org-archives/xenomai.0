Received: from mx0a-001f5801.pphosted.com (mx0a-001f5801.pphosted.com [148.163.157.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F80BA5D
	for <xenomai@lists.linux.dev>; Tue, 15 Nov 2022 17:05:54 +0000 (UTC)
Received: from pps.filterd (m0090334.ppops.net [127.0.0.1])
	by mx0a-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AF6TUH8015582;
	Tue, 15 Nov 2022 09:05:47 -0800
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02lp0152.outbound.protection.office365.us [23.103.199.152])
	by mx0a-001f5801.pphosted.com (PPS) with ESMTPS id 3kt8kaftqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Nov 2022 09:05:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=oVU2+BWXYrtZ1iJqwKDHTTmUZ/Y4fOkc7yFR4OKM2TYXbZUb/YydfCq+XcRIAZSSWDn/vv6wVBqB5GRc6+UP4ewBqd7O8qLGrwZp7sK8W7+Vc7kY8RwpNOFDSJVAjo1731kvGL2iKL2updKvTW2v6Q5/otBQlMwQHh2vHnwgWChYYB8/gQTqxh9IODiQCxLHojm3q1dSFqdGotuzedQiR+ZmrxwIMBAkn13hLcl4DoUlLfK1GdV7hqrzE+eAmjvpzh+tYyFjAUytOWu67EoANciie81PmWqHdUes9z0nZWzLPlMtG/vX5euluYb4mA4QByoMzFb/nuyGoQUDtQbNGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtMJSM2pPz07bwF0X1OHBzzonLh9UffNUEAbozwtf5s=;
 b=oY3J4OVaHmplZxuXUjrMze2ollvOe+WNff9jakSG+QqngxQt4NOHnJLcubiOXAT9weg9tEGv0R3qbirIKHql/BxDShB49dAEMQXoedsezJCuc/yw+lXWmTwCJNiWdX/IbwW4/YBnZEc27ZnPRpnEiytEZxw6rN9jlZX8U2Gzn1qJmnkTbH6pgQSLN8mlnMN9odQ0rVeWP/IiTwrPhZXM8xlcRpb9Wl6SY0rB0Stb2ofOSmDSjn8mXDaCfNBUi6diLVFOLdgYOKdQ3KoaMoXSmc1a+SvNV0FOD5SSw+2upHkp7gPiwBacYnpBkhILRBawG8rIen3313BAj+9L9s6qhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtMJSM2pPz07bwF0X1OHBzzonLh9UffNUEAbozwtf5s=;
 b=fXNbyZO1GtqVFdvl/cKHEakbu9rSACleos9WRgtc0xfdREwFaL+ZuAYcZG/B3cfjgZ44Jx4Yn03GQAytHX91M+i/qB5EV6es5HtvKznieIeDapyXqXZIs9woJpjZgDhB/9RgtazCcHDS7EsCvoJbAm2Bqt8/5UAtGKp9kNwFYeUaEE7miQNcNPkMkTkFexNTd+RxqxBzghp711uLQ7IK4pusEWt44EnQK3s8LwQeXgNBV3q+QOvCVsKVcd5V6t6XMKoB/XevrgWw6605QRwugqVkUr19Vjw8IcnsAVfv4nFD9iYvnNanOGcaUKnZR3g7kKTe8IcjEfL6nUuBvg9G4w==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1553.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Tue, 15 Nov
 2022 17:05:45 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725%6]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 17:05:44 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
        Bryan Butler
	<Bryan.Butler@kratosdefense.com>,
        Shawn McManus
	<shawn.mcmanus@kratosdefense.com>
Subject: RE: [External] - Re: EVL Memory
Thread-Topic: [External] - Re: EVL Memory
Thread-Index: 
 Adjz0yff24VAOdNORJO8c3TjB/9lSwAgymPQAAE3ZMAAARoBAABtP6rQAH6X0oAAFuqKwAAYlRuAAA/9EKA=
Date: Tue, 15 Nov 2022 17:05:44 +0000
Message-ID: 
 <PH1P110MB10500F942C9666D27F48E154E2049@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10508DD9688B7D0E82AB30CDE23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050307D7FC58A2B99A40094E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <877d04dm52.fsf@xenomai.org>
 <PH1P110MB1050221E0BC34BD641127901E2009@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87leodn9kv.fsf@xenomai.org>
 <PH1P110MB105002FA12DD4C10060A7B59E2059@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87zgcs4ma1.fsf@xenomai.org>
In-Reply-To: <87zgcs4ma1.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB1553:EE_
x-ms-office365-filtering-correlation-id: e66e91e7-fa01-4648-dde9-08dac72ba250
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Y63kPo2QnCLfX2llr+Nw7B78lMPlC7VSLGBcqpGAS58HM2xSlVlJBFojt7RvsPZVROMwpTOtH8/F1kI6c7MKgME+vMoDEZitGND5r6zR/vAOyekHDz3HixWhV3pdKF4oXh2jIbdX+kZbk6clqurWfVXN0/vDSGoY/JiBL9KNQMxD5z1AUzmSQi/Axj1ZnGVd8cyS45sgjS2LWmsFN5WrZ3EAFrz3G0kcduI6Dv6T/EVkUjopHD243WbCKMFNW6YGWLeJ1Sn19srihWnjvJfwxnhiEGbUEVk9pIDPdEauFP7ooj0WKc2tMaS5UkBaBkn1ybVKG0ZjT7p09iJP3eQ7Y37Jti00nU1V1Em1NpfEd1wxNVvSyZO/qTXpBQVbgwnFhCP0q9Sao7uHDxrL2krL+TnR4HBCWp8anfhE2U9uuxakzabtJ88kz/OeFVsiXp3qaSoMhgi6Elne8oTp2DqPOVnIXda1C58XtyHg9V0G5l4ZTCj5cVN14vW6/2pvDY2M2NcJxHG4Bf0bqmC4Rhkn5oJJvDqJwjKmns9p/sgk0qXuvYjMYvsU2bxatHsR23ohFVwoZFqWsIsd/oqC9u8Z41HfNX1VwopQo+Qw4el7TbJaBOaVNkh85WXs+peiEG7lhtlfVwlQJwuqm++pAQocbyGoQvndYMTl9Aebr5US5bcON6598yMUF5L0dQl9FhSU
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(5660300002)(44832011)(52536014)(8936002)(2906002)(64756008)(54906003)(33656002)(66556008)(66446008)(66476007)(6916009)(4326008)(83380400001)(8676002)(71200400001)(498600001)(66946007)(76116006)(55016003)(186003)(38100700002)(6506007)(7696005)(86362001)(9686003)(107886003)(53546011)(122000001)(38070700005)(99936003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 Cs7qsAweE7+D+XTFAXLyCLbJS4O6VRA160Ulvf5BH/0QfQdPcYSVWFglgPLjQp925W3bmq5tn/lvVt7JkQAAiErlmhf1JQy98VuIMx09kZKV0GPmxvJo8T8WaaDlS+hBpJpoik+bYpQShATYWioQmrRLXboUapTub7QYxTgX/KNJh0sX1KzNEC1/Bk3rBMSL5H8EMDQ30zbbRlwlGjQFtSCAVTzTgfPPb4Bkkk3dEGSBUhMqfzH3kcLfJQJfjQUb4xNRRzg6msmzfVlP2h0+w8JqrvnDhdowNVEZk2O0a8GzzywyP+GoMJmf189sKuPvuYC1m+O3y2YooGXx0IjKd0zl33romU0klo30tJN6ofgyb79xI/0vUnXrUKFoO+NQMbiu1UUH48TBrcw6wPuVRzXIm7HCNFWgxIt/JA6TTNrkHh+umU+/vx8BfICtiweYHvBgrVIrNVUqH0fCGUNasvjzRF+ZAdrO5QoCT9zYlGA=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_0022_01D8F8D9.D2511330"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cSPOa2j1AFa/OD8Se1iipyGnuCkuztRBgoc1nIGHxGkFCZGOie6XG8PkC08Ih4zcysBIbCamIjG7MJjKq99qmLdMXXdqCtc7FSnFJocKxQiLTN0LRoNuDGlVC42buEX+sfd4boX2f4KZub5U2fSAiDaOaYLlnurFDid7tw5560at5vHz+2r7MVibJUHhHrI675SZ/RINrefucdsOvHx3VDXGHCU0jK929TRoaueSAoyDVPOxY2Mu9tsYU7LmDKtQJEo0iGlS9LPrHWnf0juqSZ+8zph6DSScqzz6SqfHlx7jMaYLWC31kpfgyMVdKgSDrHBBoJIj9uOJsjOpzdSzq12b0QcaHMNFzJG4w6qWWcLwQfYnkkIE//ryL0lGYKtw4j8Noy12NFNA2HXGHX4LBTOXAbVpgh11CSliPR6MtUP2GzC0MqFeJXR9M8a3o3y90lh989EKL7uq9xOBFDomyHoGw8fX8+bQZqg5nGfSTFrJePVBrn0nctFpxKaTbb7mW351hYBRdakQDmTVBgoOWsak8TSrwgk8sJrAKqkTd+0CzjcsIW2vYKiALmePnWp5yfap1NQOkJqZp+YhlOfJwc4pQAO+jSd8GwyuJlaBIN863SEQMMvSxTVsXb6/OTb8IQzzVJA9wEQaD6hZKsEaVG5dvzkfUGc6xyBbWmOMe+bFiFEKGDaG0kiSKoE3w7nwGHGf9MJFN3rhiVaAeD/wz276+RUThPcvPvctfN9fkiJYXF286kRDT2a9mbfocUEKck0YhP6p3zks0cO5kfczZ6SiRB7GzEp9jRG8A8asSyI3T4Rew1WkDk5+AQ/8I0He
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e66e91e7-fa01-4648-dde9-08dac72ba250
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 17:05:44.6764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1553
X-Proofpoint-GUID: mxGNjdG5LlIpJWCau2OyO_ogcRrPFVYW
X-Proofpoint-ORIG-GUID: mxGNjdG5LlIpJWCau2OyO_ogcRrPFVYW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150116

------=_NextPart_000_0022_01D8F8D9.D2511330
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_0023_01D8F8D9.D2511330"


------=_NextPart_001_0023_01D8F8D9.D2511330
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sometimes I saw this issue in seconds/minutes. However, I did just see it
run over night on one system, and it hasn't died yet. I did see one kernel
splat from that run though, so I attached it here. I am building the kernel
with the parameters you recommended to turn off as we speak. I will share
with you what I see once I get it installed and running.


Thanks,

Russell


-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org> 
Sent: Tuesday, November 15, 2022 1:34 AM
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: xenomai@lists.linux.dev; Bryan Butler <Bryan.Butler@kratosdefense.com>;
Shawn McManus <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory

CAUTION: This email originated from outside of the organization. Do not
click links or open attachments unless you recognize the sender and know the
content is safe.


Hi Russell,

Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Hi Philippe,
>
> I went ahead and tested out your changes on the "next" branch. Looks 
> like it runs better (so definitely progress), but it still hangs 
> eventually. I have

How long does it take to hit this bug?

> attached the output from
> the debug kernel (a couple runs because the output was different both 
> times).
>
> Thanks,
>
> Russell
>
> [2. text/plain; stack_trace_1.txt]...
>

This is the log which has the best information so far. There is a lot of
noise added by multiple subsystems though, could you try reproducing the
issue, but this time with the following kernel options set as mentioned
below?

# CONFIG_FTRACE is off
# CONFIG_KASAN is off
# CONFIG_JUMP_LABEL is off
# CONFIG_EVL_DEBUG_WOLI is off
CONFIG_PROVE_LOCKING=y
CONFIG_DEBUG_HARD_LOCKS=y
CONFIG_EVL_DEBUG_CORE=y

Thanks,

--
Philippe.

------=_NextPart_001_0023_01D8F8D9.D2511330
Content-Type: text/plain;
	name="stack_trace_4.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="stack_trace_4.txt"

Nov 15 00:01:55 10.243.1.49 [ 1513.156427] EVL: RxMain switching in-band =
[pid=3D11995, excpt=3D6, adjust_owner_boost+0x17c/0x1a0]
Nov 15 00:01:55 10.243.1.49 [ 1513.203609] EVL: RxMain[11995] could not =
receive HM event #3
Nov 15 00:01:55 10.243.1.49 [ 1513.203635] ------------[ cut here =
]------------
Nov 15 00:01:55 10.243.1.49 [ 1513.203637] WARNING: CPU: 4 PID: 11995 at =
kernel/evl/mutex.c:274 adjust_owner_boost+0x17c/0x1a0
Nov 15 00:01:55 10.243.1.49 [ 1513.203648] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat =
nf_nat iptable_mangle iptable_security iptable_raw nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables =
rfkill ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror =
dm_region_hash dm_log dm_mod iTCO_wdt gpio_ich iTCO_vendor_support =
x86_pkg_temp_thermal mxm_wmi intel_powerclamp coretemp kvm_intel kvm =
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel =
crypto_simd cryptd rapl mei_me i2c_i801 lpc_ich i2c_smbus input_leds =
mfd_core joydev intel_pch_thermal pcspkr intel_cstate sg ftdi_sio mei =
ioatdma acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler wmi ip_tables xfs =
libcrc32c sr_mod sd_mod cdrom t10_pi ast drm_vram_helper drm_kms_helper =
syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm igb
Nov 15 00:01:55 10.243.1.49  drm
Nov 15 00:01:55 10.243.1.49 [ 1513.203813]  ixgbe ahci libahci libata =
crc32c_intel mdio ptp i2c_algo_bit pps_core dca
Nov 15 00:01:55 10.243.1.49 [ 1513.203833] CPU: 4 PID: 11995 Comm: =
RxMain Not tainted 5.15.77evl-g6437d24c6dbc #1
Nov 15 00:01:55 10.243.1.49 [ 1513.203840] Hardware name: Supermicro =
Super Server/X10SDV-6C-TLN4F, BIOS 1.3 02/13/2018
Nov 15 00:01:55 10.243.1.49 [ 1513.203843] IRQ stage: Linux
Nov 15 00:01:56 10.243.1.49 [ 1513.203845] RIP: =
0010:adjust_owner_boost+0x17c/0x1a0
Nov 15 00:01:56 10.243.1.49 [ 1513.203852] Code: 3a c0 ea ff 5b 41 5c 41 =
5d 41 5e 5d c3 cc cc cc cc 4c 89 e7 e8 45 be ea ff 48 89 df e8 3d be ea =
ff eb a1 0f 0b e9 b0 fe ff ff <0f> 0b 4c 89 f7 e8 0a c0 ea ff e9 11 ff =
ff ff 0f 0b e9 6f ff ff ff
Nov 15 00:01:56 10.243.1.49 [ 1513.203857] RSP: 0018:ffff8881659d7a08 =
EFLAGS: 00010046
Nov 15 00:01:56 10.243.1.49 [ 1513.203862] RAX: ffff8881602ad1d8 RBX: =
ffff888141d4e000 RCX: ffffffffac2f0b67
Nov 15 00:01:56 10.243.1.49 [ 1513.203866] RDX: dffffc0000000000 RSI: =
dffffc0000000000 RDI: ffff8881602ad1d8
Nov 15 00:01:56 10.243.1.49 [ 1513.203870] RBP: ffff8881659d7a28 R08: =
ffffed102c055a2f R09: ffffed102c055a2f
Nov 15 00:01:56 10.243.1.49 [ 1513.203874] R10: ffff8881602ad173 R11: =
ffffed102c055a2e R12: ffff8881602ad1f0
Nov 15 00:01:56 10.243.1.49 [ 1513.203878] R13: ffff8881602ad150 R14: =
ffff8881602ad170 R15: ffff888141d4e078
Nov 15 00:01:56 10.243.1.49 [ 1513.203882] FS:  00007fb882ffe700(0000) =
GS:ffff88841c000000(0000) knlGS:0000000000000000
Nov 15 00:01:56 10.243.1.49 [ 1513.203887] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 15 00:01:56 10.243.1.49 [ 1513.203891] CR2: 0000000000000000 CR3: =
0000000174026005 CR4: 00000000003706e0
Nov 15 00:01:56 10.243.1.49 [ 1513.203895] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 15 00:01:56 10.243.1.49 [ 1513.203898] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 15 00:01:56 10.243.1.49 [ 1513.203902] Call Trace:
Nov 15 00:01:56 10.243.1.49 [ 1513.203904]  <TASK>
Nov 15 00:01:56 10.243.1.49 [ 1513.203916]  drop_booster+0x239/0x350
Nov 15 00:01:56 10.243.1.49 [ 1513.203930]  ? =
evl_requeue_mutex_wait+0x530/0x530
Nov 15 00:01:56 10.243.1.49 [ 1513.203935]  ? =
rcu_read_lock_sched_held+0x5b/0xd0
Nov 15 00:01:56 10.243.1.49 [ 1513.203949]  ? =
rcu_read_lock_any_held.part.15+0x20/0x20
Nov 15 00:01:56 10.243.1.49 [ 1513.203959]  ? =
do_raw_spin_lock+0xb1/0x1e0
Nov 15 00:01:56 10.243.1.49 [ 1513.203979]  =
__evl_unlock_mutex+0x2bb/0x340
Nov 15 00:01:56 10.243.1.49 [ 1513.203998]  =
monitor_oob_ioctl+0x80f/0x1380
Nov 15 00:01:56 10.243.1.49 [ 1513.204008]  ? =
__kasan_check_read+0x11/0x20
Nov 15 00:01:56 10.243.1.49 [ 1513.204023]  ? =
do_raw_spin_unlock+0x97/0x140
Nov 15 00:01:56 10.243.1.49 [ 1513.204050]  ? enter_monitor+0x160/0x160
Nov 15 00:01:56 10.243.1.49 [ 1513.204097]  ? =
do_raw_spin_lock+0x119/0x1e0
Nov 15 00:01:56 10.243.1.49 [ 1513.204106]  ? spin_dump+0x90/0x90
Nov 15 00:01:56 10.243.1.49 [ 1513.204123]  ? =
__kasan_check_read+0x11/0x20
Nov 15 00:01:56 10.243.1.49 [ 1513.204131]  ? =
do_raw_spin_unlock+0x97/0x140
Nov 15 00:01:56 10.243.1.49 [ 1513.204156]  EVL_ioctl+0x81/0xf0
Nov 15 00:01:56 10.243.1.49 [ 1513.204174]  do_oob_syscall+0x699/0x6b0
Nov 15 00:01:56 10.243.1.49 [ 1513.204188]  ? =
prepare_for_signal+0x180/0x180
Nov 15 00:01:56 10.243.1.49 [ 1513.204202]  ? do_oob_irq+0x283/0x7e0
Nov 15 00:01:56 10.243.1.49 [ 1513.204223]  =
handle_oob_syscall+0x189/0x230
Nov 15 00:01:56 10.243.1.49 [ 1513.204237]  ? =
handle_pipelined_syscall+0x820/0x820
Nov 15 00:01:56 10.243.1.49 [ 1513.204254]  ? =
rcu_read_lock_sched_held+0x5b/0xd0
Nov 15 00:01:56 10.243.1.49 [ 1513.204265]  ? =
rcu_read_lock_any_held.part.15+0x20/0x20
Nov 15 00:01:56 10.243.1.49 [ 1513.204286]  pipeline_syscall+0xa7/0x1c0
Nov 15 00:01:56 10.243.1.49 [ 1513.204306]  =
syscall_enter_from_user_mode+0x47/0x110
Nov 15 00:01:56 10.243.1.49 [ 1513.204321]  do_syscall_64+0x15/0xb0
Nov 15 00:01:56 10.243.1.49 [ 1513.204332]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 15 00:01:56 10.243.1.49 [ 1513.204340] RIP: 0033:0x7fb8beef1940
Nov 15 00:01:56 10.243.1.49 [ 1513.204347] Code: 77 ff ff bf 02 00 00 10 =
8b 44 24 0c 48 98 48 89 c6 48 8b 04 24 48 89 c2 4c 8b 54 24 38 41 b8 00 =
00 00 00 b8 9d 00 00 00 0f 05 <48> 89 44 24 30 48 8b 44 24 30 89 44 24 =
2c 8b 44 24 28 be 00 00 00
Nov 15 00:01:56 10.243.1.49 [ 1513.204352] RSP: 002b:00007fb882fee300 =
EFLAGS: 00000202 ORIG_RAX: 000000000000009d
Nov 15 00:01:56 10.243.1.49 [ 1513.204358] RAX: ffffffffffffffda RBX: =
0000000000000001 RCX: 00007fb8beef1940
Nov 15 00:01:57 10.243.1.49 [ 1513.204362] RDX: 0000000000006d02 RSI: =
000000000000000c RDI: 0000000010000002
Nov 15 00:01:57 10.243.1.49 [ 1513.204365] RBP: 00007fb882fee430 R08: =
0000000000000000 R09: 00000000004596a8
Nov 15 00:01:57 10.243.1.49 [ 1513.204369] R10: 00007fb874000dc0 R11: =
0000000000000202 R12: 00007fb882fee4e0
Nov 15 00:01:57 10.243.1.49 [ 1513.204372] R13: 0000000083f2eea8 R14: =
0000000000000008 R15: 0000000083f2eea8
Nov 15 00:01:57 10.243.1.49 [ 1513.204410]  </TASK>
Nov 15 00:01:57 10.243.1.49 [ 1513.204412] irq event stamp: 537
Nov 15 00:01:57 10.243.1.49 [ 1513.204414] hardirqs last  enabled at =
(537): [<ffffffffac1aaac2>] __up_console_sem+0x62/0x70
Nov 15 00:01:57 10.243.1.49 [ 1513.204424] hardirqs last disabled at =
(536): [<ffffffffac1aaaa7>] __up_console_sem+0x47/0x70
Nov 15 00:01:57 10.243.1.49 [ 1513.204432] softirqs last  enabled at =
(86): [<ffffffffad400403>] __do_softirq+0x403/0x57b
Nov 15 00:01:57 10.243.1.49 [ 1513.204440] softirqs last disabled at =
(79): [<ffffffffac0d261d>] irq_exit_rcu+0x7d/0x150
Nov 15 00:01:57 10.243.1.49 [ 1513.204449] ---[ end trace =
e15e7b271a08d237 ]---
Nov 15 00:01:57 10.243.1.49 [ 1514.893764] EVL: RxMain resuming =
out-of-band [pid=3D11995, excpt=3D6, adjust_owner_boost+0x17e/0x1a0]
------=_NextPart_001_0023_01D8F8D9.D2511330--

------=_NextPart_000_0022_01D8F8D9.D2511330
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCFcgw
ggQyMIIDGqADAgECAgEBMA0GCSqGSIb3DQEBBQUAMHsxCzAJBgNVBAYTAkdCMRswGQYDVQQIDBJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcMB1NhbGZvcmQxGjAYBgNVBAoMEUNvbW9kbyBDQSBM
aW1pdGVkMSEwHwYDVQQDDBhBQUEgQ2VydGlmaWNhdGUgU2VydmljZXMwHhcNMDQwMTAxMDAwMDAw
WhcNMjgxMjMxMjM1OTU5WjB7MQswCQYDVQQGEwJHQjEbMBkGA1UECAwSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHDAdTYWxmb3JkMRowGAYDVQQKDBFDb21vZG8gQ0EgTGltaXRlZDEhMB8GA1UE
AwwYQUFBIENlcnRpZmljYXRlIFNlcnZpY2VzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAvkCd9G7h6naHHE1FRI6+RsiDBp3BKv4YH47kAvrzq11QihYxC5oG0MVwIs1JLVRjzLZuaEYL
U+rLTCTAvHJO6vEVrvRUmhIKw3qyM2Di2olV8yJY897cz++DhqKMlE+faPKYkEaEJ8d2v+PMNSyL
XgdkZYLASLCokflhn3YgUKiRx2a163hiA1bwihoT6jGjHqCZ/Tj29icyWG8H9Wu4+xQrr7eqzNZj
X3OM2gWZqDioyxd4NlGs6Z70eDqNzw/ZQuKYDKsvnw4B3u+fmUnxLd+sdE0bmLVHxeUp0fmQGMdi
nL6DxyZ7Poolx8DdneY1aBAgnY/Y3tLDhJwNXugvyQIDAQABo4HAMIG9MB0GA1UdDgQWBBSgEQoj
PpbxB+zirynvgqV/0DCktDAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zB7BgNVHR8E
dDByMDigNqA0hjJodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9BQUFDZXJ0aWZpY2F0ZVNlcnZpY2Vz
LmNybDA2oDSgMoYwaHR0cDovL2NybC5jb21vZG8ubmV0L0FBQUNlcnRpZmljYXRlU2VydmljZXMu
Y3JsMA0GCSqGSIb3DQEBBQUAA4IBAQAIVvwC8Jvo/6T61nvGRIDOT8TF9gBYzKa2vBRJaAR26Obu
XewCD2DWjVAYTyZOAePmsKXuv7x0VEG//fwSuMdPWvSJYAV/YLcFSvP28cK/xLl0hrYtfWvM0vNG
3S/G4GrDwzQDLH2W3VrCDqcKmcEFi6sML/NcOs9sN1UJh95TQGxY7/y2q2VuBPYb3DzgWhXGntnx
WUgwIWUDbOzpIXPsmwOh4DetoBUYj/q6As6nLKkQEyzU5QgmqyKXYPiQXnTUoppTvfKpaOCibsLX
bLGjD56/62jnVvKu8uMrODoJgbVrhde+Le0/GreyY+L1YiyC1GoAQVDxOYOflek2lphuMIIFgTCC
BGmgAwIBAgIQOXJEOvkit1HX02wQ3TE1lTANBgkqhkiG9w0BAQwFADB7MQswCQYDVQQGEwJHQjEb
MBkGA1UECAwSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHDAdTYWxmb3JkMRowGAYDVQQKDBFD
b21vZG8gQ0EgTGltaXRlZDEhMB8GA1UEAwwYQUFBIENlcnRpZmljYXRlIFNlcnZpY2VzMB4XDTE5
MDMxMjAwMDAwMFoXDTI4MTIzMTIzNTk1OVowgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcg
SmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3
b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MIICIjAN
BgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAgBJlFzYOw9sIs9CsVw127c0n00ytUINh4qogTQkt
ZAnczomfzD2p7PbPwdzx07HWezcoEStH2jnGvDoZtF+mvX2do2NCtnbyqTsrkfjib9DsFiCQCT7i
6HTJGLSR1GJk23+jBvGIGGqQIjy8/hPwhxR79uQfjtTkUcYRZ0YIUcuGFFQ/vDP+fmyc/xadGL1R
jjWmp2bIcmfbIWax1Jt4A8BQOujM8Ny8nkz+rwWWNR9XWrf/zvk9tyy29lTdyOcSOk2uTIq3XJq0
tyA9yn8iNK5+O2hmAUTnAU5GU5szYPeUvlM3kHND8zLDU+/bqv50TmnHa4xgk97Exwzf4TKuzJM7
UXiVZ4vuPVb+DNBpDxsP8yUmazNt925H+nND5X4OpWaxKXwyhGNVicQNwZNUMBkTrNN9N6frXTps
NVzbQdcS2qlJC9/YgIoJk2KOtWbPJYjNhLixP6Q5D9kCnusSTJV882sFqV4Wg8y4Z+LoE53MW4LT
TLPtW//e5XOsIzstAL81VXQJSdhJWBp/kjbmUZIO8yZ9HE0XvMnsQybQv0FfQKlERPSZ51eHnlAf
V1SoPv10Yy+xUGUJ5lhCLkMaTLTwJUdZ+gQek9QmRkpQgbLevni3/GcV4clXhB4PY9bpYrrWX1Uu
6lzGKAgEJTm4Diup8kyXHAc/DVL17e8vgg8CAwEAAaOB8jCB7zAfBgNVHSMEGDAWgBSgEQojPpbx
B+zirynvgqV/0DCktDAdBgNVHQ4EFgQUU3m/WqorSs9UgOHYm8Cd8rIDZsswDgYDVR0PAQH/BAQD
AgGGMA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0gBAowCDAGBgRVHSAAMEMGA1UdHwQ8MDowOKA2oDSG
Mmh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0FBQUNlcnRpZmljYXRlU2VydmljZXMuY3JsMDQGCCsG
AQUFBwEBBCgwJjAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMA0GCSqGSIb3
DQEBDAUAA4IBAQAYh1HcdCE9nIrgJ7cz0C7M7PDmy14R3iJvm3WOnnL+5Nb+qh+cli3vA0p+rvSN
b3I8QzvAP+u431yqqcau8vzY7qN7Q/aGNnwU4M309z/+3ri0ivCRlv79Q2R+/czSAaF9ffgZGclC
KxO/WIu6pKJmBHaIkU4MiRTOok3JMrO66BQavHHxW/BBC5gACiIDEOUMsfnNkjcZ7Tvx5Dq2+UUT
JnWvu6rvP3t3O9LEApE9GQDTF1w52z97GA1FzZOFli9d31kWTz9RvdVFGD/tSo7oBmF0Ixa1DVBz
J0RHfxBdiSprhTEUxOipakyAvGp4z7h/jnZymQyd/teRCBaho1+VMIIF9TCCBN2gAwIBAgIRAJIF
dv7a2pEWVMfTkiUaPlcwDQYJKoZIhvcNAQELBQAwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGlt
aXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1
cmUgRW1haWwgQ0EwHhcNMjIwMzEwMDAwMDAwWhcNMjMwMzEwMjM1OTU5WjCB9jEaMBgGA1UEFBMR
KzEgKDcxOSkgODg0LTYzOTIxDjAMBgNVBBETBTkyMTMxMTIwMAYDVQQKDClLcmF0b3MgRGVmZW5z
ZSAmIFNlY3VyaXR5IFNvbHV0aW9ucywgSW5jLjESMBAGA1UECRMJU3VpdGUgNjAwMRMwEQYDVQQI
EwpDYWxpZm9ybmlhMRIwEAYDVQQHEwlTYW4gRGllZ28xCzAJBgNVBAYTAlVTMRgwFgYDVQQDEw9S
dXNzZWxsIEpvaG5zb24xMDAuBgkqhkiG9w0BCQEWIXJ1c3NlbGwuam9obnNvbkBrcmF0b3NkZWZl
bnNlLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALnh/To9+nijBjtTASsMRaO4
eMR3Oh755HRtJdmmnh8R22FPh0g7SqJ0LqsdxB+F2MZuiATU0yGTqCiipYr7rvJe84G+g7buxK89
qShsTVKg7ho0hYqf5st4OofS70TU6tDSok5DonFeoP13o8WSDj6VaTCgdN4R2EpylpCbkwA0Ztab
OVLXq2c3T/2lYz9E3FktVbyW/g98PMreSQw/YHHVJDHIjRVuHWPDXNxWgL8JhvmBgW/sM0+RbOEB
d8BbpUDKKENyfyh7pyWDuaGdwXgZewYN/rsed9sY3CQbjXdPlkNs2hRr3OBF2x7/r2dxC1WcjAqX
nFpkj5GgZAj9ylkCAwEAAaOCAdowggHWMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0A
MB0GA1UdDgQWBBQozNUBGAya4A+1PrjoDHHIppZKmDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/
BAIwADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1BgwrBgEEAbIx
AQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9DUFMwWgYDVR0fBFMwUTBP
oE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRp
b25hbmRTZWN1cmVFbWFpbENBLmNybDCBigYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRw
Oi8vY3J0LnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3Vy
ZUVtYWlsQ0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAsBgNVHREE
JTAjgSFydXNzZWxsLmpvaG5zb25Aa3JhdG9zZGVmZW5zZS5jb20wDQYJKoZIhvcNAQELBQADggEB
AFr/GaEORVDnaQlG1aZnzFZxeaplFNh2DXG9CRzdu3U6HWBvAYgQqwVxvRD8O8omtchUCTyApdif
jla9M2OlWeyyAqIvCLqgZu7R2YkDuKzrNkyug95yKSUuG6WnFyr62tmlm7/Z/BOwYKdDracwiiJf
1nhhK9tCUhSLEWmNBv6z6rYmszNdajEGuJ4Om2ul76u21GZzvV9xAeCZtzbpQiVK+ib5T8fe/USd
/GIJkUmeyLNip1x1UA6TWJQNM6Y6vBNj2juHeydhVYUwOwrNiBWfYvbzZgbcTkoPjC5zbNf1/ffM
j37+cmagv+vKIk2eZNfvxAw2iHBK/+oQe8fqbZ0wggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06
KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEU
MBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwG
A1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAw
MDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5j
aGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNV
BAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8
gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUfItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9N
xOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeWQcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6
kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YBrf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlV
x/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewDch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+Q
U5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0O
BBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYD
VR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRp
ZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUFBwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDov
L2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzAB
hhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXe
jpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1G
wmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Y
s7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJ
JIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz
9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG0
3i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8
q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQOZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15us
wgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qodx/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucX
qm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i5ZgtwCLXgAIe5W8mybM2JzGCBF0wggRZAgEB
MIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQH
EwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNB
IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OS
JRo+VzANBglghkgBZQMEAgEFAKCCAoEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMjIxMTE1MTcwNTQyWjAvBgkqhkiG9w0BCQQxIgQgx7V+/MNcSi3Y3ZBte0raqQnc
MkgnGOFXGcCtKwvTVLswgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQB6
JewJTnPSwQOWjr8P3CDWVwqVJ8OJFgTQ6Iuxd+hUt3sycDFd0q4tqLvL2o0oFcGftb3j1ckFmWuq
sj2yLRyg6WJ5jT8Yah8iSKKzEYzSslPZgG5st+mt9tXO4hf50xtyrwYzV3uWFILGTGfeaJSJRkZL
ZeQ165xLxuO6331kwF7rrNq+0I1idFxW6Udt5pfQlHWrkEz3uEsf6TS5ThGgZ2qowUC0YspTZ/S9
yrGCXPzGL6jU3ea6BTYBnwONbyuvMCRL1eh7f9WYHoUyi9UKfi2YtTrN4usoJ4Z+wy6/heb6iM5N
qaipuJVMD7qVrCdxgiMO24AhC0d2Sg67ViTTAAAAAAAA

------=_NextPart_000_0022_01D8F8D9.D2511330--
