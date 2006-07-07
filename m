Message-ID: <e325d110607071259g5ebc019bs2565887803265adc@domain.hid>
Date: Fri, 7 Jul 2006 20:59:08 +0100
From: "Kim Chuan Lim" <lim.kim.chuan@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] xenomai beginner problem.
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

Hi all,
The following is my problem...

suse003:/usr/xenomai/testsuite/latency # ./run
*
*
* Type ^C to stop this application.
*
*
Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_native?)
suse003:/usr/xenomai/testsuite/latency # modprobe xeno_native
FATAL: Module xeno_native not found.

i'm using an old pentium 3 1GHz machine with suse9.3.
i recently downloaded kernel 2.6.17 from kernel.org and patch it with
xenomai trunk.

May i know what is my problem??
Is it i didnt setup my kernel probably?

The following is the result of my locate..

locate xeno_native
/home/username/linux-2.6.17.4/kernel/xenomai/skins/native/.xeno_native.o.cmd
/home/username/linux-2.6.17.4/kernel/xenomai/skins/native/xeno_native.o

How can i load the xeno_native manually?

Regards,
Kim Chuan.

