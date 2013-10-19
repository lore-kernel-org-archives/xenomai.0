MIME-Version: 1.0
Date: Sat, 19 Oct 2013 11:54:58 -0800
Message-ID: <CAKKWdtd7w73z+VzXBxMYA87+BcN+d4GDUFz5Q84DKub468tFsw@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] questions about the life-time of the real time objects
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Please consider if some Native real time objects are created like
=93alarm=94,  by rt_alarm_create() and a real time task by
rt_task_create()  and some other objects inside a real time Xenomai
task or inside a regular Linux task and the task ends and finishes
without deleting those objects explicitly.

1) Will those objects be deleted automatically? Will their name be
removed from registry and their descriptors are removed from the
system heap automatically?

2) If no why when I create an =93alarm=94 object , I can see its name in
/proc/xenomai/timerstat/master and when the task finishes , the name
disappears.

3) If yes, when a task ends, where (what function) it will return to?

