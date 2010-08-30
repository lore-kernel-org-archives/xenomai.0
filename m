From: jmf <xeno.nonono@domain.hid>
Date: Mon, 30 Aug 2010 16:56:28 +0000 (UTC)
Message-ID: <loom.20100830T183243-347@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] How to resolve this lockup situation?
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

Dear all,

this is the situation: from a Xeno task, a shared library function is called
to control some device. After a system update (both Xeno and the device
drivers) that function returns with a timeout. As it turns out, as a part of
the device drivers, there is also a deamon running which the shared lib
tries to talk to. Obviously, while the RT task waits for the function to return,
that deamon does not get any CPU time to answer so the function returns
a timeout.

Now, the questions are: why did it work before the update, before we
noticed the existence of a deamon? Is there any way to make Xenomai give
the Linux scheduler some time so the deamon can do its work? Or can that
deamon process somehow be moved to the Xeno domain? I think I stumbled
upon a respective function meant for testing once but can't find it anymore...

Thanks a lot for any clue!
-jmf


