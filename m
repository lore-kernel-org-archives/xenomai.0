Date: Tue, 03 Jun 2008 09:53:08 +0200
Message-Id: <794283247@domain.hid>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] still verification problems
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

Hi

I still have problems with 2 tests of the testsuite:
irqloop doesn't seem to work:
-------------------------------------
bash-3.00# irqbench/irqloop
Test mode:    user-space task
Port type:    serial
Port address: 0x3f8
Port IRQ:     4

Received IRQs:     0
Acknowledged IRQs: 0
bash-3.00# 
------------------------------------

latency in kernel mode fails
-----------------------------------
bash-3.00# latency/latency -t1
== Sampling period: 100 us
== Test mode: in-kernel periodic task
== All results in microseconds
latency: failed to start in-kernel timer benchmark, code -25
---|------------|------------|------------|--------|-------------------------
RTS|  267928.028|  805352.732|      32.768|       0|    00:00:40/00:00:40
bash-3.00# 
-----------------------------------------------------------------------------------

if nobody can give me hints (modules are loaded) where to look for the errors, maybe somebody can
send me the manpages. I heard they are availible for debian unstable users, but
I would have to download and in stall it, just for this reason, so maybe someone
can manage to download and send them to me.

Can I assume, if all the tests in the testsuite work, that everything works fine? Sure there won't be a
100% guarantee, but I would do anything to make sure, that later errors won't have there source in
an non working Linux/Xenomai.

Thx & Greez
Joachim
_________________________________________________________________________
In 5 Schritten zur eigenen Homepage. Jetzt Domain sichern und gestalten! 
Nur 3,99 EUR/Monat! http://www.maildomain.web.de/?mc=021114


