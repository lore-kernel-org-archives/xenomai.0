Date: Thu, 01 Dec 2005 09:37:03 +0800
From: =?gb2312?B?ufnT7u+j?= <pigguo@domain.hid>
Message-id: <d2b06bd248f3.d248f3d2b06b@domain.hid>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-language: zh-CN
Content-transfer-encoding: 7BIT
Content-disposition: inline
Subject: [Xenomai-core] rt_heap_bind error -2
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

Hi, I'm using xenomai instead of fusion.
When I bind a heap in user space which is created by a kernel module, 
the return value is -2 which I don't know what it means for it is not 
one of several values explained by the document.
This program runned well with fusion 0.9.
My kernel is 2.6.13 patched with ipipe.
Can anybody shed light on it?

And there's another strange error. In an ISR, printk must be called or 
the interrupt can't be cleared. So now I add an empty printk to every 
ISR.

Thanks.

