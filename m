Message-ID: <6ee4c8380604032304h2de399c6geffbbae78ab6124b@domain.hid>
Date: Tue, 4 Apr 2006 02:04:12 -0400
From: "Brian L." <bluczkie@domain.hid>
Sender: zorander@domain.hid
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai-help] Panic in rt_queue_create: bug or misuse?
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

I apologize for not including the panic here. I will be obtaining a
serial cable tomorrow and accessing panic text should become much
simpler. Since the panic is several screen-fulls long, even if I were
to painstakingly type it in, it would be missing vital information.

I'm posting this now in case this is a known issue with a simple fix.
Newsgroup history doesn't turn up any messages with rt_queue_create
and panic in the past few months. I am running xenomai 2.1.0 on linux
2.6.15 with APIC disabled in kernel config on a celeron 566/440bx.

Code:
=3D=3D=3D=3D=3D=3D
int main() {
RT_TASK main_task;
RT_QUEUE queue;
RT_MUTEX lock;

if (0 !=3D rt_task_shadow(&main_task,"MAIN",1,T_FPU)) {
   die("Couldn't Shadow Main Task\n");
}

rt_mutex_create(&lock,0);
rt_queue_create(&queue,"log_queue",8192,100,Q_FIFO);
...
}
=3D=3D=3D=3D=3D=3D

The kernel panics and freezes the test machine in rt_queue_create. I
will post panic text as soon as it is accessible to me. The panic
occurs whether or not I shadow the main task and whether or not the
mutex is named. Am I misusing an API or am I possibly looking at a
bug?

The bottom 25 lines of the panic seem to involve a call to the ipipe
exception handler every 6-8 lines. It doesn't look like endless
recursion, though, so we could just be walking up an exception tree.
I'm missing the top of the trace and the panic type because it doesn't
get logged and I can't scroll a frozen machine.

Thanks,

Brian

