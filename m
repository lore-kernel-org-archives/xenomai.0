From: "Hans-J. Ude" <software@domain.hid>
Date: Wed, 23 Nov 2005 18:06:32 +0100
Message-ID: <000001c5f050$416d9e00$7b030080@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Priorities in the vxWorks skin
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

When I create some tasks under the vx skin with different priorities and
then look at the /proc/xeno/sched file they are all listed with the
value 2. Shouldn't priorities be mapped to the internal priority scale?
Of course I can't expect the original vx values there but nevertheless
they shouldn't be all the same. I've created an rtai interrupt handler
task with priority 99 too. That one appeares with the value 100 in the
list.

regards,
Hans


