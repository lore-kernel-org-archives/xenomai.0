Message-ID: <4829C8C9.4020300@domain.hid>
Date: Tue, 13 May 2008 18:58:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <A3B06EAFE0D9C14096681C935E0B300802110A0C@zue-s-15.zue.zwick.de>	<4829613B.3000500@domain.hid><0C9896A4B6D338488AD6FFFE58BAEF100276DBF6@domain.hid><48297566.1010607@domain.hid><0C9896A4B6D338488AD6FFFE58BAEF100276DC66@domain.hid>
	<4829AA19.8070405@domain.hid>
	<0C9896A4B6D338488AD6FFFE58BAEF100276DD0C@serveur3.lgm.com>
In-Reply-To: <0C9896A4B6D338488AD6FFFE58BAEF100276DD0C@serveur3.lgm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt management under rtdm driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: DOURNES Guillaume <Guillaume.DOURNES@lgm.fr>
Cc: xenomai@xenomai.org

DOURNES Guillaume wrote:
> Sorry my old archive contained svn files. I send again my cource code.
> 
> I have some syslog message as kernel : Oops : 0000 [#1], or kernel : CPU : 0, or EIP : 0060 [<f8a88de7>] Tainted : PF  VLI, etc.

Well, if your system locks up while the test runs, it is not likely that
any message is pushed to syslog anymore. At best you see something on
the console (VGA or serial).

> 
> I don't understand the watchdog catch. Can you explain a little more ?

See the help in the kernel configuration: If the the watchdog catches
some spinning Xenomai thread, it will suspend it, allowing the rest of
the system to run again. This will also generate a log message on the
kernel console.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

