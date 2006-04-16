Message-ID: <6ee4c8380604161110y3c937a74t9186bad2d9af2058@domain.hid>
Date: Sun, 16 Apr 2006 14:10:55 -0400
From: "Brian L." <bluczkie@domain.hid>
Sender: zorander@domain.hid
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai-help] General question on Native Skin tasks
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

If I create a native-skin RT_TASK from userspace with no flags, i.e.

void task(void*)
{
    for (;;) ;
}
int main()
{
   RT_TASK t;
   rt_task_create(&t, 0, 3, 0);
   rt_task_start(&t,task,0);
   (do something which blocks)
}

Should that task starve all other tasks? In what ways is it different
behaviorally from an ordinary posix thread? I ask because I have a
thread that might be spinning and a frozen system (back in the rtlinux
days, spinning in the real-time domain was a surefire way to freeze
without any other sign of trouble). If it is the case that this task
outweighs an ordinary linux thread/task, how can I make it the same?

Also,  I haven't completely tracked this down yet, but xenomai seems
to be page-faulting in a loop and exploding rather spectacularly in a
native-skin multithreaded program that doesn't do anything outside of
relatively ordinary queue/mutex/task stuff. I'm upgrading to trunk to
see if it goes away.

Short of a serial cable, is there a way to capture Oops/Panic text as
it flies by?

