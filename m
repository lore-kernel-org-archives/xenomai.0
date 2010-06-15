Message-ID: <4C17AA80.9000804@domain.hid>
Date: Tue, 15 Jun 2010 18:29:52 +0200
From: Ramon <ramoncostacastello@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] pcibios_find_device
Reply-To: ramoncostacastello@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I'm porting an old practice environment in RTLinux to Xenomai.

In that code I use commands like "pcibios_find_device" to obtain the 
addresses used by a PCI AD/DA board
(we access to this device at a register level  using outb commands).

In the old rtlinux environment my code was executed in kernel mode and I 
could access "pcibios_...."  commands easily. Is it possible
to use these commands in user space mode (using xenomai) ?

Thank you
Ramon

