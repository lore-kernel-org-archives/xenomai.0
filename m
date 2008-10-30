Message-ID: <f8b4363d0810300151p7782d43au76e009d9ce9f9303@domain.hid>
Date: Thu, 30 Oct 2008 04:51:12 -0400
From: "Antino Kim" <antinokim@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] [Total Newbie] Module xeno_native not found
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

I'm a total newbie in using Linux kernel and Xenomai.
Around 4am, I was able to successfully compile a Xenomai patched
vanilla Linux kernel and install Xenomai! I thought all the trouble
was over...
When I tried running a example program, I got the following error message:


/usr/src/xenomai-2.4.5/examples/native$ ./trivial-periodic
Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_native?)

/usr/src/xenomai-2.4.5/examples/native$ modprobe xeno_native
FATAL: Module xeno_native not found.


I will be willing to provide more information if needed, but my gut
feeling tells me it should be a very simple (and obvious) problem to
experienced users. I would really appreciate any help. Thanks.

--
Antino Kim

