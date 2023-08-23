Received: from mx0a-001f5801.pphosted.com (mx0b-001f5801.pphosted.com [148.163.159.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EE81F188
	for <xenomai@lists.linux.dev>; Wed, 23 Aug 2023 21:42:56 +0000 (UTC)
Received: from pps.filterd (m0090335.ppops.net [127.0.0.1])
	by mx0b-001f5801.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37ND2o8s009476;
	Wed, 23 Aug 2023 14:42:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	kratosdefense.com; h=from:to:cc:subject:date:message-id
	:references:in-reply-to:content-type:mime-version; s=
	Kratos081023; bh=UJQy4NZSgw92A1c6xfyHh7Ai6k7o/4xwfHodTyp0hEo=; b=
	VCQDflqzwrNX4t5Jn2YE2jdVaAZK4ZkoPqF7RYLd9gHjcb0+PKLVUOkpxI4AgJQo
	l5mkaHhJCHVeCSK1KGSrTtlYNiLRDu0U6t4IEaioaL84vYPMfhAZvdKCBg6ctBmK
	VHhrLthKb7QGwIT8KSCQKrbCZU4LZkqe7VdAv85Po7+I2firB7mVG7BuZXYEftNG
	cmDcUGts/hzR1C69uYLn9anZ5rN016Qi+A+P7tzd1g0EfU8s40EV6/o9zDzF00nI
	WXCJA/D24XbgaZ+SBo1aQbhcHtUmcpxk1AGZBQWsmGDYCpbzOHUPhxOB+8icyhI2
	S/ujJ8A9wmVzBzhgN9mJVQ==
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02lp0145.outbound.protection.office365.us [23.103.199.145])
	by mx0b-001f5801.pphosted.com (PPS) with ESMTPS id 3sn22ahxw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Aug 2023 14:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=H+vaTusILHbuxsgwIfTkMnCSraLiEermFtIzxGeNefuLp8JntZQCqw7FfG6RctS6vWehxJHnxrC/fUFxripN/602zyK2YT20fS48MbOuYf+UMxsGo8h7I8+W1wrAALpFqiDLL5bcn5Z2AtZAMbVghIVuJeceMJ6vkAfAj8hJvo1fNJxxwRi6q7p+zlBBsRxgpUE1792Qy6nhp+0nzuDSjRAjhT6haPXUzTVJcQqZgDaNcl0E/tdgjJnSOzBOb6xQHfNDZXXHW5KwpnodQqnlaBe7I2iEA+wXy462U8CzNjW2YHQXLVNRSAu52PwA1We9LMmbv/0ThtDFRIXCsLgGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJQy4NZSgw92A1c6xfyHh7Ai6k7o/4xwfHodTyp0hEo=;
 b=iD7ek0fBML/bCpWrRlcrAMMs6oWVaGM/3GwYL9FNrnYXXst3Ei7H4MLnXxttGFkPJ94atmGnFlWxwrz1SsvJjZbPHTyDXUIHu24MWIMPs3D5AE7E+W2e1vA9qGVOkPc5FJho+hgPyEs0jKRx3Ynen++boVK0Dg4emcXYA48TUxEJr7KJyOCwSWu8HT1renl/pm+MIYC5nykDT7tXzlkJLkj5vn8ld+XyQQMM/+pI3AwfC6KHATZ6vc5oTUebStjz/NdqHbjfl2iWmI9EtnP+gL7ueCntN1F2g7L19k59cF8azeJQ0MDRX57WRF96QJvZibm6tmzXG5pLe2X0knjKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kratosdefense.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJQy4NZSgw92A1c6xfyHh7Ai6k7o/4xwfHodTyp0hEo=;
 b=cDx2EE90+TIGqulPWoT5wzZK5la3dFgJ3aVNDlmK39wNwtmKU2JOlDepaSQHqIegt/KwlTJ/gVKQMJvyezuawwtZkikTjAplAD+IEf4aOE1Jokzqc+QDB7NWkkP6CoDphnwdBb6jHVz+zdrQ0PD5/5qS4vUFYNI5JSl7IJEAFEfuU77yVIvS0YV6VFtziYEFE633rxvC5aGr3eeGhRoqQJiKf5bzeVqsmnwmUcqyVWenkX3aaMvOtoKJYs8m/dCp2mTgmb2HU56tqpHEmRdaIOU5PoMB5FT4LWWhe4CqWmBoin9Wky+iTUxNF/6EmEwRckn1Yubvz6WKOFkW0zv9CA==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1188.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:189::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 21:42:51 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::a041:219c:fa6e:ca57]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::a041:219c:fa6e:ca57%3]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 21:42:51 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
        Dave Rolenc
	<Dave.Rolenc@kratosdefense.com>
Subject: RE: [External] - Re: CPU Stuck Error When Using Xbufs
Thread-Topic: [External] - Re: CPU Stuck Error When Using Xbufs
Thread-Index: AdnVQZ6QBW12xpu+Qi24iADTKEeVDwAAj97AABPsPQAAAfaegAAb01zg
Date: Wed, 23 Aug 2023 21:42:51 +0000
Message-ID: 
 <PH1P110MB10506D3909C7F85BC5523BFAE21CA@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB1050E89C04D3AE6B62BB426FE21FA@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB105005EB4439ACFDCAA9C0F2E21FA@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87il96p63x.fsf@xenomai.org> <87bkeyp3hs.fsf@xenomai.org>
In-Reply-To: <87bkeyp3hs.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB1188:EE_
x-ms-office365-filtering-correlation-id: 24b12748-ced6-452b-6bce-08dba421e6c9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Gl/EASrHr1K8ri27Ii13pZZig2+/eN5+6T5GT4qK2CPXmyAvYg+A0ykuoxctcC2N9Y2EJeuceYFn7MAy0oMMDhCjvVNaiYQBCx8LUbwd59js/dqMXQ7+6oYV9J81TDGV2MI3cJBO2ahUl6f57l8wgASUDaFcV+9saMfj5C7nqQhACojMK8Y8ohbk1DC1FXRnvW+3BIUm25RfNSmsoDA26jPxLLK7ZcawMqW7z3THqRwINv+L7COE8q1UyIJNVJcpEmYZ4SRgFsztHLxkIKZmbtLJ5+YgE0M1q/Nxjd7RfkRBdOTsYUu2IUuprxF2153FeBGyVM1in6DwONMPqbw9YGkRNFtVICAfP2PDedg3acS7IKWW9vQsl4gGoTXcbKbRSX2OzjpKMvl2V10y92HYSqETUPNRZyaaq1LkxdLYXOBmarwsuqnrTAMvdXQfyW0r9fLa3Emy7xAmkgflZKLQrWdBJlL4Bd477LXblgzq7L2XviwJLOR5dswGrB+g7dzhM07T6N/ig/LbvC71/iEF4bekOiNWlkNzZ5p7uWmB++o1xj1yOkO0gxI7kqtM2gGbKKPh37qcVRR7oXEjrOogY+9ehZL78x3/9p46zNGZWOk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39830400003)(186009)(451199024)(1800799009)(6506007)(7696005)(52536014)(6916009)(53546011)(8936002)(8676002)(4326008)(54906003)(66556008)(66946007)(76116006)(66476007)(64756008)(66446008)(55016003)(9686003)(41300700001)(26005)(107886003)(5660300002)(44832011)(71200400001)(966005)(508600001)(83380400001)(86362001)(2906002)(33656002)(41320700001)(99936003)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 kjEpWC2GfH7/NYjtJ8zSRrQCGgtWQRYyj7Gb+q3+Xaq4qe4myfrhRLo5Fpi6r45bQAMQiB4Z5gu1Bk8andd5XBSuFdhaveohAGo2gUYrKEUI3Me4aTEuULg2C14078KUP5kBk15PY8ceSwnOTYlLC1nvHjwclWwtnNJVGUneN8PAoiYXVeFZrQ70+qmcqZsMeQaI9f6WsJbvyBfUBXSgsfQIW+rXFz66T933FcataykDnziCXFllpK09BkQVDdxALQnF1xS/OA+tgXkNKFSzAiyRMQLDZVkJK9Fg4d9dF5Zdug90KGAEJcjhOEUtbdNSOCnl4CbRaNr00PdrOHYbW8rcMgYL7kte1ZEcHTXs/02IG6fAaTWZVtoD5CkE/itXoCDt1tojw3fRqGdAPc7M3Gs5bc6eY7H+b5+VpDeCw0w=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_0081_01D9D5D8.78A0B2F0"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4hhU2qTwkZtYcjAnV7ah71Qp0nOGZlBhFJZO62UZSaCcbjYpDjGtHvMBx44C1L4cauZ9cZYrtrkHP/5YeATC51Xj96ROqY8P9Ytr7RpBOSsQ02pK18ET2oGC4qE5596oFLAXhfoiTzy3QFJ+dCO9u9H9pSgnNYZxYi0/KHxh07x+dOu9p3y9kb7FM2nhruMZnuIXw8de6NnqTCTidILbqMtSfdU9AbTsaLIMaerrl2rwxYeGUV/crEjh2Hy2teHY1vTNQ93xbdDnPVHIazkcac9FXoa0tpP5qViiFP5Zxqm+wRqzIl7zpSy5FW16d8oRHKMUQCC3jKyYDBJnKNqAvhetdG5s7SRSoTf3BLjiFTAxJ189MRF/U1hu/f0q7l0kzsVig3aaiCJedmMZCsCeD95qkxgD4jS7YFydlkZoI7rd0DkXXf+f8ljx6oJgoN+hqSkj3Fjvhaz7HVoFb5rsqSKaHaWEmBUp4C4O8+PzDuT2nmC0IthttuRZCrskALs82cBlCpVztTvtee8ZWc+V26Bmmv8alxmvRMq4kkrMs+/UbjDPW474L8eJgkhN4NvUJQYLm0Nk4+qyCgdwA0XRJAJKI+vpexiOhzzgU4MvE3vkcsGnw+q0kQCy6KnzJ86lcTNaHQbXt7FHyNTmFNIpKSW74LPxRj/kmdxQ8LXfSOtTnNSIfuAdB4wwNZ0Ck1T/WDWXXo3UCBf8p90W88uBE188M+t7aME0r0+Ez6dLhw+cef19UvpL8QzGz81oEY1EqbDqv+P0YF9ONPKyyuZkHRfpItu0dhSijrG/UWFidIbH5HJd8APfVncfNJwlfgzQ
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b12748-ced6-452b-6bce-08dba421e6c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 21:42:51.5485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1188
X-Proofpoint-ORIG-GUID: rEY6tP1E7z-lko2poaFvApbH7isJofS2
X-Proofpoint-GUID: rEY6tP1E7z-lko2poaFvApbH7isJofS2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_15,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1011 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2308230193

------=_NextPart_000_0081_01D9D5D8.78A0B2F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Philippe,

It appears that this has solved our issue. Thanks!


Russell

-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org> 
Sent: Wednesday, August 23, 2023 2:26 AM
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: xenomai@lists.linux.dev; Dave Rolenc <Dave.Rolenc@kratosdefense.com>
Subject: [External] - Re: CPU Stuck Error When Using Xbufs

CAUTION: This email originated from outside of the organization. Do not
click links or open attachments unless you recognize the sender and know the
content is safe.


Philippe Gerum <rpm@xenomai.org> writes:

> Russell Johnson <russell.johnson@kratosdefense.com> writes:
>
>> [[S/MIME Signed Part:Undecided]]
>> Hello,
>>
>> I am running into a CPU Stuck issue when I added another xbuf to our 
>> application where we have data being transported from EVL  to Linux 
>> constantly.
>>
>> I get a message on the console that mentions there is a CPU that is 
>> stuck due to spinlock recursion:
>> "
>> Message from syslogd@Modem1 at Aug 18 23:02:25 ...
>> kernel:BUG: spinlock cpu recursion on CPU#5, SINK_0_DATA/4437 Message 
>> from syslogd@Modem1 at Aug 18 23:02:25 ...
>> kernel: lock: 0xffff8f27d329f610, .magic: dead4ead, .owner:
>> SINK_0_XBUF_L/4402, .owner_cpu: 5
>> "
>>
>> I collected some data using sysrq and got the following stacks for 
>> both of the threads in question:
>> "
>> task:SINK_0_DATA     state:S stack:    0 pid:15095 ppid: 14415
>> flags:0x00000000
>> Call Trace:
>> <TASK>
>> ? wait_events.isra.15+0xae/0x3e0
>> ? evl_lock_mutex_timeout+0x45/0x540
>> ? evl_flush_wait+0x50/0x50
>> ? monitor_oob_ioctl+0x487/0xbd0
>> ? poll_oob_ioctl+0xc7/0x440
>> ? EVL_ioctl+0x46/0xa0
>> ? do_oob_syscall+0x251/0x260
>> ? handle_oob_syscall+0xa4/0xf0
>> ? pipeline_syscall+0x65/0x130
>> ? syscall_enter_from_user_mode+0x4d/0x120
>> ? do_syscall_64+0x1d/0xa0
>> ? entry_SYSCALL_64_after_hwframe+0x67/0xd1
>> </TASK>
>>
>> task:SINK_0_XBUF_L   state:R  running task     stack:    0 pid:15059
ppid:
>> 14333 flags:0x00000008
>> Call Trace:
>> <TASK>
>> dovetail_context_switch+0xaf/0x200
>> __evl_schedule+0x266/0x560
>> run_oob_call+0x99/0x170
>> inbound_signal_output+0xab/0xb0
>> do_xbuf_read+0x1b3/0x240
>> xbuf_read+0x4d/0x70
>> ? do_irq_work+0x70/0x70
>> vfs_read+0x9b/0x1a0
>> ksys_read+0xc4/0xe0
>> __x64_sys_read+0x15/0x20
>> do_syscall_64+0x4c/0xa0
>> entry_SYSCALL_64_after_hwframe+0x67/0xd1
>> "
>>
>> NOTE: SINK_0_DATA is the thread in the EVL app that is pushing data 
>> onto the xbuf. SINK_0_XBUF_L is the thread in the Linux app that is 
>> pulling data off of the xbuf.
>>
>> Do you have any idea would could be going on?
>
> Yes, quite clearly now. I'll follow up on this in the coming days.
>

Please give a try to this patch:
https://urldefense.com/v3/__https://source.denx.de/Xenomai/xenomai4/linux-ev
l/-/commit/6b0dbab59eedb0b992a08be35197fccacad578d3__;!!KM6X6ZXWXVtZMQ!aQX1I
dWU2mC0fpoFsdz9yOB0Ywl-whRYJ1j3vJ3bM_HXU4sIAzNqORFiWcC1mbs6HCAjWbqDyJsbvPYyk
ShlZA$

Thanks,

--
Philippe.

------=_NextPart_000_0081_01D9D5D8.78A0B2F0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCFbQw
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
J0RHfxBdiSprhTEUxOipakyAvGp4z7h/jnZymQyd/teRCBaho1+VMIIF4TCCBMmgAwIBAgIRAI/z
sKoC9gIWd6K2uUMqX0gwDQYJKoZIhvcNAQELBQAwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGlt
aXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1
cmUgRW1haWwgQ0EwHhcNMjMwMzA5MDAwMDAwWhcNMjQwMzA4MjM1OTU5WjCB4jEaMBgGA1UEFBMR
KzEgKDcxOSkgODg0LTYzOTIxDjAMBgNVBBETBTkyMTMxMTIwMAYDVQQKDClLcmF0b3MgRGVmZW5z
ZSAmIFNlY3VyaXR5IFNvbHV0aW9ucywgSW5jLjESMBAGA1UECRMJU3VpdGUgNjAwMRMwEQYDVQQI
EwpDYWxpZm9ybmlhMQswCQYDVQQGEwJVUzEYMBYGA1UEAxMPUnVzc2VsbCBKb2huc29uMTAwLgYJ
KoZIhvcNAQkBFiFydXNzZWxsLmpvaG5zb25Aa3JhdG9zZGVmZW5zZS5jb20wggEiMA0GCSqGSIb3
DQEBAQUAA4IBDwAwggEKAoIBAQDAs1JlPXcxObC/SDH5jeXQCR/wpwukNllyXtVupCmQwW0zjEXN
bnSaUcXkpkqU52fnuPrvg49YNVMs8j9ftVR1JgYBTzqfe4cYa1085W31zMc1ysOFO4Q4fmL1ew+t
UkDewFDJhiZMPbsFDFMLZmrdsdE+zoO3snCOykm1bJYQ23DFfk+41sgLNMSxrvaMzTk9Dr2MVGYJ
U5XiwKGseszOA59mR278QTbitwAaGm2yZ3haqxRpSiLdTCpWP6NT+ufDgN7gdUqNHzIDX0/Wkm2l
se1EneAnUyGvZAVuqcgrtdHzslP51mJ92jxuDSkRNJxUU8jo3OkX1rkRRpppQi0vAgMBAAGjggHa
MIIB1jAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUG/7kujLuZ4Qp
vVGdPTrnUMwMRwMwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYB
BQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEW
F2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2Vj
dGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5j
cmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9T
ZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEF
BQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wLAYDVR0RBCUwI4EhcnVzc2VsbC5qb2huc29u
QGtyYXRvc2RlZmVuc2UuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQBRRMaZHiM5JRYIchy62As+w13F
TXX2s5QeFwTWbbS732kxBxsFpv1KxGoL7Dze5Y3pQXk0wHKEu922i1O5rSBQ/63HOeZ9t1F1Vu7b
oUU6BP+uhqcamCtQPkV9MiEInBonCOimhoeqU2aSgyOHAM7MAnXAk4SZ/ElFQAogucYaDI1DpciA
uClBkWCfbYVjYkzbN/WURM02AQpicgXkWXJoWxHt9J1unZP7AIdIE3WD5No+wsxF0nZTg+5XU0RY
Y1FAx82tWR4Hq4i2qOFgs/pu2KSfGzo2IOuft380xuEe67ovMgvTzNL/PVaYNxn08XACfn4hbP9Y
LBCOCUz2NbYXMIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkqhkiG9w0BAQwFADCB
iDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkxFDASBgNVBAcTC0plcnNleSBDaXR5
MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0Eg
Q2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCB
ljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGll
bnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY75tqSvysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eo
Z9X140qOTKl1HyLTJbazGl6nBEibivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+
TZNTEDygNfcXlkHKRhBhVFHdJDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5x
sOFbme/SoY9WAa39uJORHtbC0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManRy6XcCFJE
6k/LHt3ndD3sA3If/JBz6OX2ZebtQdHnKav7Azf+bAhudg7PkFOTuRMCAwEAAaOCAWQwggFgMB8G
A1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0GA1UdDgQWBBQJwPL8C9qU21/+K9+omULP
yeCtADAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEF
BQcDAgYIKwYBBQUHAwQwEQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6
Ly9jcmwudXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNy
bDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9V
U0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRy
dXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEAQUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9
FzGR87bjgrShfsbMIYdhqpFuSUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg6
5FWM89YN5yFTvSB5PelcLGnCLwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwp
Tf64ZNnXUF8p+5JJpGtkUG/XfdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32VBXglIrHQ3v9
AAS0yPo4Xl1FdXqGFe5TcDQSqXh3TbjugGnG+d9yZX3lB8bwc/Tn2FlIl7tPbDAL4jNdUNA7jGee
+tAnTtlZ6bFz+CsWmCIb6j6lDFqkXVsp+3KyLTZGXq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2
fG7Bt2tPC8BLC9WIM90gbMhAmtMGquITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0
RfwhBlakdYYrkDmdWC+XszE19GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcj
fvp4hYbDOO6qHcfzy/uY0fO5ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svqw1o5A2Hc
NzLOpklhNwZ+4uWYLcAi14ACHuVvJsmzNicxggRdMIIEWQIBATCBrDCBljELMAkGA1UEBhMCR0Ix
GzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMP
U2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRp
b24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAI/zsKoC9gIWd6K2uUMqX0gwDQYJYIZIAWUDBAIBBQCg
ggKBMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgyMzIxNDI0
OVowLwYJKoZIhvcNAQkEMSIEIOIe02TxyUQfsDxHZIWiPg8z21K6sy1rEUn48Y1A9hdyMIGTBgkq
hkiG9w0BCQ8xgYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglg
hkgBZQMEAQIwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAsGCWCGSAFlAwQCATALBglg
hkgBZQMEAgMwCwYJYIZIAWUDBAICMAcGBSsOAwIaMIG9BgkrBgEEAYI3EAQxga8wgawwgZYxCzAJ
BgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQx
GDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1
dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQCP87CqAvYCFneitrlDKl9IMIG/Bgsq
hkiG9w0BCRACCzGBr6CBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQD
EzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIR
AI/zsKoC9gIWd6K2uUMqX0gwDQYJKoZIhvcNAQEBBQAEggEAfvjyMOp5YhvSHvGCz3BJ8l+XIz6/
7jlmPcIoIBIg7o9OZvRyOzN5fgtXo2AUf/k02L6H38YBEgwi+9vcbkOWtZToSYeQc/RJS3ZGC3Zk
8aEL0C4N9uiUOdri86SYVDKMVogwdr+qVah4kZ0dUQ0s2Y6kI1d/NzbiCsXlvqfmqzJ/8vCEs/u7
kJfUYxUfvyxh4OJE1ppu9W8wuY9AuiVfkjqusFEMjvVTFJvRWIpEWYYnWS05BqwDzfpVvaALKrV0
qdNxNl+nzQHeJ3tvUs1Lqdsv4qBIV0axXGAff5e10Vev6icMVOy27PBA/vkS+ie/z+zTUBsszp3A
azQFVjG0+AAAAAAAAA==

------=_NextPart_000_0081_01D9D5D8.78A0B2F0--
