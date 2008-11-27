Message-ID: <20081127175234.163sujmgcgcgs4gk@domain.hid>
Date: Thu, 27 Nov 2008 17:52:34 +0200
From: Mehmet Alphan Ulusoy <alphan@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-9;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Zombie user tasks
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

I have a problem where when I want to terminate a xenomai user space =20
task, the task becomes a zombie and I can not re-run it since some of =20
the resources (like mutexes) it uses are already there and can't be =20
created again.

The scenario is as follows:

- A process running on the computer forks to create a child.
- The child executes the user space task using the system() call. =20
(child does not return). I suppose userTask is the child of the child =20
process now.
- After a while it attempts to terminate the task by calling "pkill =20
-SIGTERM userTask"  using the system() call again.
- The task, not always but sooner or later -above steps are repeated =20
for a number of times-, becomes a zombie.
- The user space task has a signal handler for SIGTERM and SIGINT signals.
- The signal handler is as follows:

void terminateGracefully(int sig)
{
     int err;
=09    while (( err =3D rt_task_delete(&tid)) !=3D 0)
=09    {
=09        printf("Error deleting task. Code %d.\n");
=09    }
=09    while (( err =3D rt_alarm_delete(&aid)) !=3D 0)
=09    {
=09        printf("Error deleting alarm. Code %d.\n");
=09    }
=09    while (( err =3D rt_pipe_delete(&pidMon)) !=3D 0)
=09    {
=09        printf("Error deleting pipe. Code %d.\n");
=09    }
=09    while (( err =3D close(sid)) !=3D 0)
=09    {
=09        printf("Error deleting socket. Code %d.\n");
=09    }
=09}

- The signal handler is installed as follows:

signal(SIGTERM, terminateGracefully);
signal(SIGKILL, terminateGracefully);
signal(SIGINT, terminateGracefully);

- The child process which makes the system() call has a signal handler =20
installed for SIGCHILD signal and calls wait() to collect their exit =20
status.

signal(SIGCHLD, waitChild);

void waitChild(int sig)
{

     int status =3D0;

     wait(&status);

}

I've read somewhere that it's not safe to call printf() from a signal =20
handler but even if I comment those lines out I can observe the same =20
behavior. I don't see any error messages printed on the screen.

Is there a specific order to follow while deleting real-time entities? =20
Is the system() call or "pkill -SIGTERM" the problem?

regards,

alphan

