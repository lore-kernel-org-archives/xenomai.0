Message-ID: <7289437c0804030246v7992ec23kedcc2c8b71dc14f8@domain.hid>
Date: Thu, 3 Apr 2008 11:46:54 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_937_26999754.1207216014934"
Subject: [Xenomai-help] Question about rtdm_mmap_to_user()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_937_26999754.1207216014934
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I try to allocate a buffer in kernel space (with kmalloc) and then map it
into user-space (with rtdm_mmap_to_user).
After, I fill in the buffer in user space with the address returned by
rtdm_mmap_to_user, and when I read it into the kernel space with the kernel
address, I don't have the values put in user-space.

What I'm doing wrong ?
Have you a simple example of use of rtdm_mmap_to_user ?

Thanks in advance.
Best Regards,
Perrine

------=_Part_937_26999754.1207216014934
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello, <br><br>I try to allocate a buffer in kernel space (with kmalloc) and then map it into user-space (with rtdm_mmap_to_user).<br>After, I fill in the buffer in user space with the address returned by rtdm_mmap_to_user, and when I read it into the kernel space with the kernel address, I don&#39;t have the values put in user-space.<br>
<br>What I&#39;m doing wrong ?<br>Have you a simple example of use of rtdm_mmap_to_user ?<br><br>Thanks in advance.<br>Best Regards, <br>Perrine<br>

------=_Part_937_26999754.1207216014934--

