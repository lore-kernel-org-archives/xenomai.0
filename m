Received: from mx0a-001f5801.pphosted.com (mx0b-001f5801.pphosted.com [148.163.159.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC3DA486
	for <xenomai@lists.linux.dev>; Fri, 18 Nov 2022 21:08:38 +0000 (UTC)
Received: from pps.filterd (m0090335.ppops.net [127.0.0.1])
	by mx0b-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIK69F1028351;
	Fri, 18 Nov 2022 13:08:31 -0800
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02lp0149.outbound.protection.office365.us [23.103.199.149])
	by mx0b-001f5801.pphosted.com (PPS) with ESMTPS id 3kx0sw9xv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Nov 2022 13:08:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=UzWxH4PcoeQKaLP2nXvrCc08B0AzTurZnLy53aUrcPiSr9uADKL90JWlW+lARkNkZwrljXziJO2I5iP99lUyMNZ3eQI/XCPtcguifX5mkacpM+ynV7H2SCFkuNevUvL/UUt+28be1U0F7tPAXqmpVjmJDCA3CDxC3bYWiipcnW7iA3pMh4yqjpnFVwNrM6NIFoN4DkckMobxgYGi4hUpzD73f85Qg0ZmWfGTqnsMzN8P6ftKfUoQlBOdUZTmODvkglTPgR8uGs3uIYHfpu8yTQfykiYBEoUkmqVIw0oxaZgPHYhupDazcBde6GmTWsW11dS9Dhv2cN1jwJiiP5B5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7edkkYsk+4Dmlv1FE1nrNwuwk2JRxW0LUlqZ9BjR8Yc=;
 b=INugrfJUmF2AmkkvdQ0F+Arg8MiSBi4XCB55Wd7uvyCYVEi+/4/FughWKPPPyDdjfN7yfnZw17RH6PP02w94Hg9MXaAeuFM+YwQob5LzW3QcNZjFMiFknsiDfgCPLi1YCLOu8eUqm6SRQeSvTQIk6h/jlsURPOTskoediOeuN3xP2/oUA922f+08qdJmirTWlZg9UH/UU5IzN3vYYvjNVWGMMfNDdBoZTwdp/ylnqs5yUwhXjcgaRYBjTETQ3F+3ycoBFWiUqVLoDwSnHeFl4kjlOUK87XOC5F/l/4pZzCA2tNt6mg2lcTjqAiAqS7FqCa3YuLgZ/Q1hwHGPD3mfDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7edkkYsk+4Dmlv1FE1nrNwuwk2JRxW0LUlqZ9BjR8Yc=;
 b=aYvxxm7Pu+ODJKnHd0sdfGgjAUUrVi6UKYPQNMtdvE/H3qVHatlzNEHP7HlOgbOHKsdr3/Evl6jF5niHGDGecZ+H7duRw2WqwbpsBZvk1UiKdKuIAWfCark5Tv2tWh9QcBKKtrrAIe77QOwqEUw0qarlB3iIL3rlCDWEJJ0+so1/Dx+J2B2WrMR05RLcV7qO3C1jT1eVjW4sjidNZ+2AjabMYr7eu2w76GfnC4MgYIoHviGI37Y+BKWG9nHjDFme4upz703ov+/hD56Wrx3++AlQj5jSAcBBw29g1dMfu71V73DBT3GXg1OuCrMQnQN2d/nUs41UrFulsIMjD2xKrQ==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1066.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Fri, 18 Nov
 2022 21:08:27 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725%6]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 21:08:27 +0000
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
 Adjz0yff24VAOdNORJO8c3TjB/9lSwAgymPQAAE3ZMAAARoBAABtP6rQAH6X0oAAFuqKwAAYlRuAAA/9EKAABRGVgAAsa2CAAAwq7lAAKDcSAAAAOPzgAABSMQAAASbBYAAeYkCAABstmLA=
Date: Fri, 18 Nov 2022 21:08:26 +0000
Message-ID: 
 <PH1P110MB1050D58533B66C165127E5BCE2099@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10508DD9688B7D0E82AB30CDE23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050307D7FC58A2B99A40094E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <877d04dm52.fsf@xenomai.org>
 <PH1P110MB1050221E0BC34BD641127901E2009@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87leodn9kv.fsf@xenomai.org>
 <PH1P110MB105002FA12DD4C10060A7B59E2059@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87zgcs4ma1.fsf@xenomai.org>
 <PH1P110MB10500F942C9666D27F48E154E2049@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87v8ng3vv7.fsf@xenomai.org> <87edu2dh2j.fsf@xenomai.org>
 <PH1P110MB10505104BB0814A3F46A86BCE2079@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87tu2xbk5k.fsf@xenomai.org>
 <PH1P110MB10501A307D34D09C49EEBB74E2069@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87pmdlbjg7.fsf@xenomai.org>
 <PH1P110MB1050175A9DBC1F6E7F4E868DE2069@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87h6ywbs97.fsf@xenomai.org>
In-Reply-To: <87h6ywbs97.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB1066:EE_
x-ms-office365-filtering-correlation-id: 98ae0498-e649-4238-55ac-08dac9a90953
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 w9yTOuKTvVSlwxuJUqYaNbjMDXmGXhM3uRzQRm+fmzJJA0xzn8Z7gQXqmCiJ6Lm0PGWiZ2UuW/n6qzhfmXHlkxuP7hGma6VM09I78g9Opsj4qugGt3UkWhMMQv08KuYzpQmP9msa4OnPmhgfaVZfWMOxIJ1brxWk52V6ZfWUdBtsAiUP+cEBH2OejnyZJ45OSxLeIB6lQSJ3Z61OfJQ/04UkfAacto7+9RVSck7kUgl1DWrG+92f2QmKJKQ9N2F7gknCcp0BouIIZTmzd/KRq1wex1MoeLsWPD7SfIGrZ3lGytY7VxufaS6ghK/7aH3L3fjVqb2fRwxpX29EYZIJ/hztSvU8jBqNsKSLg2szrZJW36Q1w+dOCuZ9cOWi8q3FUo4ZgxiE5ruDMkp2IHtPniIuQ6/q8hFIl9OsbcVZmj6UA58NGAcIdk02Q8YAYeJIoFECxadtk9+IQCRptrzAJCZSb3zyCnvxfRmWF9V9MIqjjqlQRkEPtIqAewRw8zJF7p+TQkN83DDvh6xQF/OeAU/XZ8Iz6mTFZFZqwJvNSMZ/D2mnyRS6biuw/1gQoBMGyKNWrnxEGKFz+hUO5XSq4RMJQMnjt49Kh701iNWODCctTIb31xQcgwUYlK/eIbgH
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(64756008)(99936003)(122000001)(38100700002)(86362001)(55016003)(8676002)(33656002)(38070700005)(66556008)(76116006)(66446008)(66476007)(66946007)(6916009)(186003)(4326008)(71200400001)(6506007)(7696005)(9686003)(498600001)(54906003)(107886003)(2906002)(52536014)(44832011)(5660300002)(8936002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 B/mJM2sE1lio2MRwBgAD/xtUqHhzypBxwFSSZV069M2cfgwMpUu+bRMWK8ogB7q6U5reB/PgkUmEnDUgPxQsaGS9D72+3RHMDMsAt45RUScfsFVNd70m6lRqeAnHhDT/PFT/1cIE/NohfHquu+Jy6gsnXO1VsBGNdZqowgMJo6EsJEVY02CNAcMoytzvrvoL5j7Vs2/hmGUosc+88NYxG33HGhFl1TMhGR2IE5nihUiZpwmH/lzqyGR1jscCmnnB9jbMai1Cc1GbcZdMP5RztQnUm5PBegtTGFPpLxAn/9mudsE404R3FY++9i9wXpVjKlRV7BlGiV2hJ3gKg2njtubCjWmPMecllcNDe5VviUrBCphsQ35Nd3Jc4spGFmq8r6uVsnMySdXEbZdAtXY8ZMvnoGl3phSx191FeePgRb2qYUrDJ63uGLFAVGn16eHz3X8rncEVpIrjkjMTWMKxdoyQthcislymqmbodJHMck4=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_0048_01D8FB57.39836AB0"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lXUF2j82EbvmoftkYAoNW3MTKbG+p7lBB4T9eOpMHfA82gOZIxV6yR4+PxdoyU+pKgdZR92/fX0DrLoe735kWF4fcv8bXfKUQWlBr7/US2icoSCsgFC6dfzwyG1xx2zQvv7acKNKMYh2DkR8ssNZXwgGNEKN9mA/BQtVvReKOv/LAgpCygZJALYx2wu0igTbgD1n1g9rmtc7vOhzE15KMF9SPHQDOumYmvLE37ITsqjppkEGNz9oCIfiOoBXxqiATdTt9PPPaQzNkj9h+J2vuy0boCJtN9KCSuEJ57O0ZVbbdMpU57NsZuomxPP1mzbb5rL7Tpn1CTi3ukQkyUz2yRYl2ZHyvSWfW42H35AR1F/KK/dcB3qC+0GflPB5EMpG3qH+2RJ3Te8+6pFwGRZaLArp33eqk4af2v8Kn97LzKB53AFQeXl+jyrtbLAa11dDXkBpCTNfrK8+yyTGvw9dQcjPBf0INm2eXtbttP8Y8t/ois3N1jXIV2bLcg17MWbihGPABisnCBJrq8tmUCB1u0pi0pGysHOoL+ttytkFbXr/GXUH8kpeNIjNNa56vVLn+zCsGf/rEtC8GE13o+R2gypflaOOHXz6TszlB/7ebQSWWjXrtI29gQ/gkQLeQMrLLQHFAdTo9cNcBYPqQk2pNremdx/p0OjADtxMXC0xAQAl2UB+c2n8axZeFF8RtnBCdOmC8FBjmJF3Sycdudih/gGXLZSdS9QYiFQ5b2bMqKIiNdX/SFyPbKO2XBqjBr5SJi4TNT30AtdeMm8BbHWp5KNOHVhJyUR951SA1Da0AW1iLE99bL1EY1nJNI7a3sDa
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ae0498-e649-4238-55ac-08dac9a90953
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 21:08:26.8990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1066
X-Proofpoint-ORIG-GUID: QvSabhNZSMDnI36AJ0Q1522vvcUH8Axd
X-Proofpoint-GUID: QvSabhNZSMDnI36AJ0Q1522vvcUH8Axd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180124

------=_NextPart_000_0048_01D8FB57.39836AB0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I found the error in the make output. There was also a warning that I pasted
below.

----------------------------------------------------------------------------
-----------------

In file included from ./arch/x86/include/asm/special_insns.h:10,
                 from ./arch/x86/include/asm/processor.h:25,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:88,
                 from ./include/linux/spinlock.h:55,
                 from kernel/rcu/tree.c:23:
kernel/rcu/tree_plugin.h: In function 'rcu_read_unlock_strict':
./include/linux/irqflags.h:289:3: error: expected expression before '{'
token
  ({      \
   ^
kernel/rcu/tree_plugin.h:826:40: note: in expansion of macro 'irqs_disabled'
   on_pipeline_entry() || running_oob() irqs_disabled() || preempt_count()
|| !rcu_state.gp_kthread)
                                        ^~~~~~~~~~~~~
In file included from kernel/rcu/tree.c:4762:
kernel/rcu/tree_plugin.h:826:26: error: called object is not a function or
function pointer
   on_pipeline_entry() || running_oob() irqs_disabled() || preempt_count()
|| !rcu_state.gp_kthread)

----------------------------------------------------------------------------
-----------------

CC [M]  sound/soc/intel/common/soc-acpi-intel-bxt-match.o
drivers/net/phy/sfp.c:168: warning: "T_WAIT" redefined
 #define T_WAIT   msecs_to_jiffies(50)

In file included from ./include/evl/thread.h:25,
                 from ./include/evl/sched.h:14,
                 from ./include/evl/flag.h:11,
                 from ./include/asm-generic/evl/netdevice.h:10,
                 from ./arch/x86/include/dovetail/netdevice.h:5,
                 from ./include/net/netoob.h:5,
                 from ./include/linux/netdevice.h:43,
                 from ./include/linux/rtnetlink.h:7,
                 from drivers/net/phy/sfp.c:17:
./include/uapi/evl/thread.h:21: note: this is the location of the previous
definition
 #define T_WAIT    0x00000008 /* Periodic wait */

Thanks,

Russell

------=_NextPart_000_0048_01D8FB57.39836AB0
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
9w0BCQUxDxcNMjIxMTE4MjEwODI1WjAvBgkqhkiG9w0BCQQxIgQgUnDXYnkb2WAPjdVPT0ftHHDI
ECyV3p5g2YESWEBbDkkwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQCb
+8Sz/keQ1B/VcM4SSMcyv7FHcb16M0zPOS8smLHiXbN3GHZsQaWPr+3sgkMIul2ObQV5nJVIsXwk
B3GAYPhlOvvFff4Tftcjw1SVSrtEa41d5XbzggcWoiPE8duqu8oH+WEpQaXGa3QIlkXWIZeMXKcx
RtsQTDbFkRoYQ2iI4alIa7tNRdpwqvgOAokIPZqTf7PusWL94giXjE7R9rLOAbVIY4mYPioZDEhN
n/eb/uFW3CYkGSLGv2Xdq6qL/hwhnWjcjqhSbPIHMGZahg2a1NbP5PbDTreI2jsT9HsfaN9jgCIz
3GTFkcSh74x1lbjUUX7b5e3Bt3ZWrhZNMXp9AAAAAAAA

------=_NextPart_000_0048_01D8FB57.39836AB0--
