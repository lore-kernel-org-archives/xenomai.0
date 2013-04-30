From: "George Pontis" <GPontis@z9.com>
References: <mailman.293.1366744201.1444.xenomai@xenomai.org>
In-Reply-To: <mailman.293.1366744201.1444.xenomai@xenomai.org>
Date: Tue, 30 Apr 2013 13:50:36 -0700
Message-ID: <006201ce45e4$5dc8e4f0$195aaed0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: [Xenomai] Qt - Xenomai compatibility problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I took a snapshot from git of the current Xenomai code and put it in the hands of the software
developers. They reported that Qt would not build after patching with Xenomai. The problem was that
Qt uses "signals" as a keyword, and that conflicts with the function prototype for rt_task_notify
under xenomai/native:


int rt_task_notify(RT_TASK *task, rt_sigset_t signals);


Although this is not a Xenomai problem, it might save some users the annoyance if the name "signals"
could change.

George



