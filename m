Message-ID: <4A48D9A1.40509@domain.hid>
Date: Mon, 29 Jun 2009 17:11:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] DYNAMIC_FTRACE vs. I-pipe tracer
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Hi Philippe,

I saw this for 2.6.30, but it obviously also made it into 2.6.29:

http://git.denx.de/?p=ipipe-2.6.git;a=commitdiff;h=d302f7638b9b52ea90e3c042edd940449cedb7a1

What precise problem does it try to solve? Is it a 2.6.30-only problem?
The point is that, last time I checked, the dynamic ftrace approach was
by far not I-pipe compatible. So I suspect we rather need a fix for the
core issue, but keep DYNAMIC_FTRACE off.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

