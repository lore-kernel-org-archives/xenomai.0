Message-ID: <4DA6F0DD.1080403@domain.hid>
Date: Thu, 14 Apr 2011 15:04:29 +0200
From: Jesper Christensen <jbc@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] kernel threads crash - possible race condition?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


I wrote about some problems concerning stack corruption when running
xenomai on ppc. I have found out that if i disable hardware interrupts
while running "rthal_thread_switch" the problem seems to dissapear
somewhat. I saw a crash yesterday after running for 3 hours, and i'm
currently running a test (has been running for 3 hours). Usually it
would fail after 30-40 minutes. My question is: could there be a problem
if we receive an interrupt between updating the stack pointer and the
sprg3 register with the new thread pointer?

/Jesper



