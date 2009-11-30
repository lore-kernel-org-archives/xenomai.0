Message-ID: <4B13B8D0.3040700@domain.hid>
Date: Mon, 30 Nov 2009 13:21:36 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B13B144.3030008@domain.hid>
In-Reply-To: <4B13B144.3030008@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] problem with xeno_nucleus.xenomai_gid boot option
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jonas Buchli <jonas@domain.hid>
Cc: xenomai@xenomai.org

Jonas Buchli wrote:
> dear all,
> 
> i am trying to setup a xenomai system to run RT tasks as a non-root 
> user, we are adding the xeno_nucleus.xenomai_gid kernel option, but 
> dmesg gives the following output:
> 
> ---------------------------------------------------------------------
> embedded-pc104:> dmesg | grep gid
> Kernel command line: root=UUID=d6b0719f-bd4b-4420-9a20-8d732c90f153 ro 
> lapic console=ttyS0,115200n8 console=tty xeno_nucleus.xenomai_gid=1002
> Unknown boot option `xeno_nucleus.xenomai_gid=1002': ignoring
> ---------------------------------------------------------------------
> 
> however, the first trick described here works:
> http://www.xenomai.org/index.php/Non-root_RT
> 
> --------------------------------------------------------------
> embedded-pc104:> sudo modprobe xeno_nucleus xenomai_gid=1002
> --------------------------------------------------------------
> 
> any idea what we are missing?

Hopefully clarified in the wiki:

http://www.xenomai.org/index.php?title=Non-root_RT&diff=2143&oldid=1946

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

