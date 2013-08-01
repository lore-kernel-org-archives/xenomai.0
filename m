From: Skander Bahloul <skander.bahloul@imag.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Thu, 1 Aug 2013 18:20:13 +0200
Message-Id: <0DE90633-1CDC-4BB5-837D-D9FA5409B73D@imag.fr>
Mime-Version: 1.0 (Apple Message framework v1085)
Subject: [Xenomai] polling task and rt_task_sleep()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear Xenomai list members,

I'am trying to use xenomai for a polling task.

I'am use rt_task_sleep() and i discover that this function is important =
to execute the program but it causes latencies.

If i delete this function, the terminal freeze.

Can you help me.

Thank you very much!=

