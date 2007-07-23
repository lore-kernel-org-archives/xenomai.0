In-Reply-To: <1185210931.5998.273.camel@domain.hid>
References: <16123805.1184916759093.JavaMail.ngmail@domain.hid>
	<1184890451.28303.356.camel@domain.hid>
	<1184852543.28303.67.camel@domain.hid>
	<24703926.1184851660664.JavaMail.ngmail@domain.hid>
	<32098568.1184853156077.JavaMail.ngmail@domain.hid>
	<25782679.1184932464850.JavaMail.ngmail@domain.hid>
	<1184933771.5998.3.camel@domain.hid>
	<1185202908.5998.271.camel@domain.hid>
	<1185210931.5998.273.camel@domain.hid>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B91B4F7E-A39F-437E-967E-DAD097F2AC2E@jdkoftinoff.com>
Content-Transfer-Encoding: 7bit
From: Jeff Koftinoff <jeffk@domain.hid>
Date: Mon, 23 Jul 2007 10:45:39 -0700
Subject: [Xenomai-core] r2773 mistake? x86_64 adeos patch
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi!

We are trying to compile xenomai for x86_64. Yesterday, revision  
r2773 "Add Adeos 2.6.22/x86_64", added the file adeos-ipie-2.6.22- 
x86_64-1.1-00.patch.

However it appears that the patch is only patching files in arch/ 
i386/ instead of arch/x86_64...

Or am I doing something wrong?

Thanks

jeffk

