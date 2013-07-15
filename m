MIME-Version: 1.0
Date: Mon, 15 Jul 2013 17:48:44 +0200
Message-ID: <CANKLDmty3tu1DMtObXnQ5oNkJOJoOyprOp5BQJ5YZtoiYaYqWA@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] i.MX Timer Tick stall on iMX6Solo
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

I'm running on a iMX6Solo (singlecore) chip. The problem we are seeing is
that a couple of times during the day, the i.MX Timer Tick irq doesn't
trigger and after some time starts running again. So the reprogramming of
the timer is suspect ;-)

I'm using ipipe-3.0-imx6q and Xenomai 2.6.2.1.

Can anyone help me to make the timer reprogramming robust? Is there a
robust way to do that (instead of adding a factor to the mxc_min_delay like
commit-e1c0a1461512f does)? All help or pointers are highly appreciated!

Thanks,
Henri.
