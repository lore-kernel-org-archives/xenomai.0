From: Tempo Rubato <info@temporubato.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Message-Id: <C64FB7DD-F6A4-4B16-969A-81E4F022E9B0@temporubato.com>
Date: Sun, 1 May 2016 17:32:54 +0200
Subject: [Xenomai] timerbench.c question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi

I=E2=80=99m studying the timerbench.c driver code servicing the latency test=
ing utility. While the code is really great I=E2=80=99m wondering why in the=
 timer_task_proc the start_time is set which is never read in the task mode?=


And why exactly is this put into the big dual kernel lock?=20

Is it to avoid potentially unbound atomicly locked code of other threads it c=
ould get switched into while in rtdm_task_sleep_abs ?

Best
Rolf



