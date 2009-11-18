Message-ID: <4B042121.2050509@domain.hid>
Date: Wed, 18 Nov 2009 17:30:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] ipipe_suspend_domain vs. pipeline state of caller
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

on x86, trace_hardirqs_on in safe_halt feels unhappy about the fact that
it is called with neither real irqs disable nor the root domain stalled.
Call path is cpu_idle -> default_idle -> safe_halt. We loose the
stalling of the root domain in cpu_idle via ipipe_suspend_domain.

That raises the question how ipipe_suspend_domain is supposed to deal
with the pipeline state of the calling domain. Currently it clears the
stall unconditionally, which is obviously not correct for the idle path.
My feeling is that it should not alter the state, rather restore it on
exit. But this is an exported interface (though a widely unused today, I
guess), and I don't claim to oversee all corner cases.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

