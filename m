Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C3D1FD0
	for <xenomai@lists.linux.dev>; Fri, 26 Aug 2022 16:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1661531560;
	bh=6siNYGkZUwiH5A6W39OO7BmsvjQtFULxJUI8pOgDphU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Tpn89PLjM4YuM2jfEsE+WgGSCTr3BwqIJdeVp3k54letAP6zdK+iqF++AUnaZEPvl
	 tfnz3pwerViZ8OAMf6QCS19XCvvwA0Me7JfQ0EqldELdec9WrMqCEgQSuzCn7RXsCB
	 kV8WxngpyA50f/IIq54lH0+xVLS+fxlhe8+zeOuw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([92.210.49.225]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9qhD-1oXMw10Dn3-0060ug; Fri, 26
 Aug 2022 18:26:48 +0200
Message-ID: <ad5ac2e9-e662-ee94-94fa-c7d42b6e4b68@web.de>
Date: Fri, 26 Aug 2022 18:26:46 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/1] net/drivers: igc: introduce rt_igc driver
Content-Language: en-US
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@lists.linux.dev
References: <20220822011821.21283-1-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@web.de>
In-Reply-To: <20220822011821.21283-1-hongzhan.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1+QP0SYXQUlpbScvK0SeGpLoMllxddaSBgTjITI7MrZWq1P6DF6
 E0/2hwCsydjnc4Jmx4hdwjSNgLIj2cmBDfnGe/sSGjSM+T3ROZInlGVTDbPlWkf1R3wT1+5
 snA/4u9pFjNU5BK2Rxmyjc2s6EkxivcHsv/7J0RdICL/YpYs0MIi5Sv/Gp1kk32nXhgWhZ/
 idVMhs8MyrIerdO+6CKyg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jxlojw6F81s=:9sGGidroM4iFS0qVqYR4OU
 WnOYSSGJLndgSayGD52uBIENUeaQDY7n3s/gzbhQucXVnBkX96gQU+DsUh3/iXTuF8hK9E5Mg
 HLNTlTt3BARY7oECPmwmOGTjMC2UgeLDPLzAfKE1yYCIT6cK3q++u1P+KsZ5M/7THPT7ZDLbO
 Su5P+0wvrJlice5aLU330o3Jq1lXAdXInpv30QJD9efRw4q2chcsQfcgQQGVUxuD60/CQphL9
 2Js+PaAYI53vy91w9jujDcCaAAQawQS8/ySVcAd7pQnyV81WP17AqLcZs6uaYyxyk+g+L13me
 GPGj7EOl2G8O/I0XEsl+jD8XYAiHEiUSHI0ino8mk4gpTkPiyxfT6hzZCDhdWs2ERA2hUgXLd
 LG21+Udb2FJrs0n/klRu6E/BVsISVumkycoGLAU19aef9DMplAPbKhZi3fbhtez7vZfyxuwX6
 T0RvKGutAUuHQ6h1lXYObxTBWAa6C3vvib8oZt8Ha5O1lhROS7BGyWCBDBfkvmlHsV/c17Byf
 8xkG1cC34NYAllZLCJH/9Z+dlWitw5wdiruGRr6bXU0rG7q9UgLOCh/UXJTdMkLQU9T925KR6
 3YrD6knHzMypW4vCRM/m27JUs9H/+x56PEohx3VdIABHQdNkvShINqgOMGFoAsP1WIsxOpP2n
 OVz/NvF1KwzPZmcW5EIS6ziz8NKb4hlI40WduY2U6Uuntf8KvA5tYreS29blqgA+NqXOlrlSV
 lsIiZIcyH1dTGEoGbM6S3URKetbpFO6B5IB54aClrIQRGkacUolxz6Xnyf5dzUdUeNFv4AESH
 /4PJ8h5KnDpLQppikIqAkkZ2lCoyIqYkBDd34jQl+bqhTCQ/TGtQ+H8h5J0q4tKUGJA2RwrJQ
 scVJiBx42/7blKEnT868iUWfB/u4gwQeIY8KLo5vseEBp14i9u+qlbBAfa+wAbuu4AGVB/cyf
 y4Qe9F78EQlnBwK+xXqwTUMgXXnaMHuVlj3MAEijGN9dhmz1lKcHCO160n13kYYEV3eSjRktc
 wQAK3vXEjnvoYBdlLtqt7ioJZMl4dbegQ9HzmdC6izuCcTEPu45ghfj90ctfPyEuPjNYBdbCi
 uc8ssuTAGH8//NKhpXXxwUT9s6ispXEvCfRDnZnFbUsfjLGdyexf4ZL6Q==

On 22.08.22 03:18, Hongzhan Chen wrote:
> ported basic network functions not including TSN.
>
> 1. passed three network related smokey test: UDP, raw, dgram, But
>    I do not know if these three test is enough to validate the
>    driver, please let me know if there is other tests need to
>    cover.

If those tests exchanged more than a hand-full of packets (to make sure
we are not leaking buffers, thus will run out of resources after a
while) and if you checked that the reported latency is comparable to
rt_igb e.g., then we have a good indication that the driver works. The
rest is field-testing.

> 2. In addtion, another thing I want to discuss here is TSN functions of
>    i225 has the very similiar effect with TDMA not only from clock sync,
>    master and slave arch, timing mangement but the difference for TSN is
>    that most of fucntions is implemented by hardware. We are considering
>    if it is feasible to implement TSN-enabled TDMA-TSN driver to make
>    use of i225 hardware feature because TDMA itself is really heavy.

Yeah, time-triggered send is basically what RTmac/TDMA introduced via
software almost two decades ago. I'm not sure, though, if we should map
the configuration of TSN capabilities of modern hardware on interfaces
(RTmac & Co.) that were designed that long ago. If it happens to work
our easily, it's a nice experiment, but we would likely miss other
things (Qbv transmission windows e.g.). And there is also the question
how to set up an operate PTP aside RTnet.

Jan
