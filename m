Message-ID: <44DA896F.9060102@domain.hid>
Date: Wed, 09 Aug 2006 19:18:39 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] expected output and runtime of switchtest ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>



soekris:/usr/xenomai/testsuite/switchtest# modprobe xeno_switchtest
[  160.221018] Xenomai: starting RTDM services.
soekris:/usr/xenomai/testsuite/switchtest#
soekris:/usr/xenomai/testsuite/switchtest# switch -n
soekris:/usr/xenomai/testsuite/switchtest# switch rtk0
cpu 0: 498
cpu 0: 998
cpu 0: 1498
cpu 0: 2000
cpu 0: 2496
cpu 0: 2998
cpu 0: 3498
cpu 0: 3998
cpu 0: 4500

...

This prog has been running for atleast 1/2 hr,
with minimum args..

what should it be doing ?

