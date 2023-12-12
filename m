Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C335168B1
	for <xenomai@lists.linux.dev>; Tue, 12 Dec 2023 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bupt.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.edu.cn
X-QQ-mid: bizesmtp69t1702365389t4vjn651
Received: from 3cfae85af25a ( [106.39.130.102])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Dec 2023 15:16:26 +0800 (CST)
X-QQ-SSF: 01400000000000102000000A0000000
X-QQ-FEAT: PS/N6jJLnDae+430liOBmctubpjKnfzTyzHwszWQWR3dmg5ZhuV1aPEbTbawr
	mR5TGxxx0P+AkC0UwNR6+aOt8mgq48D33Z56B3xqYpRqqKs88xRIEvy205AR/hsjsneXJND
	l08e8sBKgGb5WZCP+abMD221LYC6mRbicRSs+YVjLSBLIlAgHb3xTCkquzgkq4wH8UcEViY
	XiGah46b0I0KP8d/WLoeDT2vRe5lPYmL7/spS3ZpjpzUWJopQXf9j4lSDL7LmEbpDxVT8XY
	AXMtXoYneHlIXhtbQm8g/32Np+cIkjkasJJT19Q1CGQQaHuTt4myw+Qzo8KQVO42rbiWPJf
	gtN1/Y4CEPAowmdh2oZD42Fjw+j5GqXnphBePqrHFVUX2hCI0xfVWpdJZgpAA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5510582145683719056
Date: Tue, 12 Dec 2023 07:16:26 +0000
From: Li Hongyu <lihongyu1999@bupt.edu.cn>
To: xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>,
	Chen Hongzhan <hongzhan.chen@intel.com>,
	Wang Rick Y <rick.y.wang@intel.com>, MengweiXu <mwx@bupt.edu.cn>,
	Jorge Ramirez <jorge.ramirez.ortiz@gmail.com>,
	Andrew Noren <andrew.noren@gmail.com>
Subject: [RROS] Introduce a rust dual-kernel RROS based on the dovetail
Message-ID: <EE82543C18AFC423+20231212071625.GA955@3cfae85af25a>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.edu.cn:qybglogicsvrgz:qybglogicsvrgz6a-1

Hello,

At our recent meetup in Wuxi, China, we had the opportunity to discuss
the motivation behind and the current progress of RROS. Following the
successful launch of our satellite into space[1], we are excited to announce
the official open-sourcing of RROS, which is now available at 

https://github.com/BUPT-OS/RROS](https://github.com/BUPT-OS/RROS

. For those interested in exploring RROS, you can find the code in the
kernel/rros directory on this repository.

We are thrilled to introduce RROS to the public. As mentioned in our earlier
presentation, our goal is to ensure compatibility with the libevl interface
and to strive for performance on par with EVL.

At present, we are still working towards full support for all interfaces of
libevl r27. Performance evaluations will commence once we have implemented
all the necessary features. We want to present our progress to the community
and discuss potential collaborations with the Xenomai/EVL community.

We look forward to your feedback and suggestions!

[1] https://bupt-os.github.io/website/news/2023_12_9/satellite_launch/

Best regards,
Hongyu Li
