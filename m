Subject: =?utf-8?q?rt=5Ftask=5Funblock=28=29_POSIX_alternative?=
Date: Tue, 07 Apr 2020 15:41:17 +0200
From: =?utf-8?q?Petr_=c4=8cervenka?= <grugh@centrum.cz>
MIME-Version: 1.0
Message-Id: <20200407154117.5D7D71C2@centrum.cz>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hello everyone.
I there a rt_task_unblock() Xenomai POSIX skin alternative?
I created an example of periodic POSIX task, similar to the latency example but with very long period. When I receive a INT signal I set the end flag and I would like to unblock a task that waits on read(timerfd). But all my attempts led to standard wait timeout or worse.
Thanks in advance.
Best regards
Petr Cervenka

