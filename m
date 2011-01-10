From: Peter Soetens <peter@domain.hid>
Date: Mon, 10 Jan 2011 17:18:58 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201101101718.58201.peter@domain.hid>
Subject: [Xenomai-help] Correct use of xeno_sigshadow_install()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hi,

A while ago, I was advised to call xeno_sigshadow_install() after a library 
installed a sigwinch signal handler (I believe this was Xenomai 2.5.1). Could 
it be that this is no longer supported in recent versions ? What is the 
correct way to avoid a segfault if an application installed a sigwinch handler 
after Xenomai did ?

Regards,
Peter

