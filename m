Message-ID: <4C17ACBF.2060705@domain.hid>
Date: Tue, 15 Jun 2010 18:39:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C17AA80.9000804@domain.hid>
In-Reply-To: <4C17AA80.9000804@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pcibios_find_device
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ramoncostacastello@domain.hid
Cc: xenomai@xenomai.org

Ramon wrote:
> Hi,
> 
> I'm porting an old practice environment in RTLinux to Xenomai.
> 
> In that code I use commands like "pcibios_find_device" to obtain the 
> addresses used by a PCI AD/DA board
> (we access to this device at a register level  using outb commands).
> 
> In the old rtlinux environment my code was executed in kernel mode and I 
> could access "pcibios_...."  commands easily. Is it possible
> to use these commands in user space mode (using xenomai) ?

Not directly, but you may use libpci:
http://mj.ucw.cz/pciutils.html

Note however that you may run into other issues if you intend to use
hardware directly in user-space. It is probably a better idea to use
RTDM to write a driver in kernel-space.

-- 
					    Gilles.

