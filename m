Message-ID: <4256e7340802220457m6a4f7737qd5a572ef7f6707e7@domain.hid>
Date: Fri, 22 Feb 2008 12:57:07 +0000
From: "Moti M" <tabulo@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] Advice on running Xenosim/MVM
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

Hello,

I need some general advice on Xenosim v2.4.1. I have successfully (as
far as I can see) built and installed the MVM environment, however
when I try running the Xenoscope application it always exits with
error 99. From the source code it looks like this happens if SIGINT,
SIGTERM or SIGHUP are received, but I am not sure why one of these
would always occur when I run Xenoscope.

Is there something I am missing when running Xenoscope, or perhaps
some setting I should have enabled during the kernel config process?
(I am using Xenomai 2.4.1/Linux kernel version 2.6.23.14 on x86.)

Thanks,
M Tabz

