MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18047.39887.117650.552218@domain.hid>
Date: Mon, 25 Jun 2007 12:41:19 +0200
In-Reply-To: <7289437c0706250217g7cab3109ic2d5079deded5069@domain.hid>
References: <7289437c0706250217g7cab3109ic2d5079deded5069@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Problem to have load module support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Perrine Martignoni wrote:
 > Hello,
 > 
 > I use xenomai 2.3.1 on an ARM9 board.
 > And I want to put the option "enable loadable module support" in my kernel.
 > 
 > When I put this option in the Linux kernel with xenomai, the kernel doesn't
 > run.
 > I have this error of Bad CRC :
 > Booting image at 10080000
 > .....
 > Verifying Checksum... Bad Data CRC
 > 
 > I noticed that when I remove xenomai and I put the option, the Linux kernel
 > run with no problem.
 > 
 > Is this behavior normal?

No, your boot loader likely has a size limit which the kernel with
loadable module support exceeds. Increase this limit and everything
should be fine.

-- 


					    Gilles Chanteperdrix.

