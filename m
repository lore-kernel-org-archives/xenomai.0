Message-ID: <49A43CE0.6050405@domain.hid>
Date: Tue, 24 Feb 2009 19:30:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] [ANNOUNCE] LTTng-over-I-pipe git tree
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: xenomai-help <xenomai@xenomai.org>

Hi,

I'm pleased to announce updated LTTng support for Adeos/I-pipe. At

    git://git.kiszka.org/ipipe-2.6.git lttng/2.6.28-x86

you can find a recent 2.6.28.7 tree with latest x86-2.2-06 I-pipe patch,
and on top of that LTTng 0.88. So you just need to clone that tree to
have a fully patched and (according to all current tests) working
I-pipe+LTTng kernel for x86. Other arches are currently not in my
customer's scope but would be feasible as well.

To use this with Xenomai, you additionally need an update patch for the
existing instrumentation, see [1].

I will keep the tree updated as we move on with our code base or as I
happen to give new versions a try. And if anyone comes across some issue
with these patches, please let us know!

Jan

[1] http://permalink.gmane.org/gmane.linux.real-time.xenomai.devel/6009

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

