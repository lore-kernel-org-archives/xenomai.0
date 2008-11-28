Message-ID: <20081128181906.mnv2mvjgo44wgoc0@domain.hid>
Date: Fri, 28 Nov 2008 18:19:06 +0200
From: Mehmet Alphan Ulusoy <alphan@domain.hid>
References: <20081127175234.163sujmgcgcgs4gk@domain.hid>
	<492EF786.4040303@domain.hid>
In-Reply-To: <492EF786.4040303@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Zombie user tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Thanks for the prompt and informative reply. After reading about =20
signals and processes I have to admit that I didn't have a clear idea =20
on the concept when I was posting my initial question. Nevertheless =20
I've modified the code of the user space task as follows:

- signal handler sets flag when it's called.

- At the end of the initialization routine (main()):

...
while(!termFlag)
     pause();

clean();

return;

}


ensures that clean() is called only if SIGTERM is received and =20
termFlag is raised by the signal handler. (termFlag is an int).

Is this safe?

By the way, in my trials I've found out that ppid of the zombie task =20
is 1 (init). So does this mean that the parent of the task did not =20
call wait() properly and init is the new parent of the task? Even so, =20
shouldn't it be cleaned automatically by init?

-- alphan


On Thu 27 Nov 2008 21:39:50 EET, Gilles Chanteperdrix wrote:

> Mehmet Alphan Ulusoy wrote:
>> void terminateGracefully(int sig)
>> {
>>      int err;
>> =09    while (( err =3D rt_task_delete(&tid)) !=3D 0)
>> =09    {
>> =09        printf("Error deleting task. Code %d.\n");
>> =09    }
>> =09    while (( err =3D rt_alarm_delete(&aid)) !=3D 0)
>> =09    {
>> =09        printf("Error deleting alarm. Code %d.\n");
>> =09    }
>> =09    while (( err =3D rt_pipe_delete(&pidMon)) !=3D 0)
>> =09    {
>> =09        printf("Error deleting pipe. Code %d.\n");
>> =09    }
>> =09    while (( err =3D close(sid)) !=3D 0)
>> =09    {
>> =09        printf("Error deleting socket. Code %d.\n");
>> =09    }
>> =09}
>
> This code is seriously broken. You risk an infinite loop which may brick
> your box, if ever it happens over a thread with the SCHED_FIFO policy.
> All these calls are not async signal safe, so should not be called in a
> signal handler. Almost the only thing permitted in a signal handler is
> to call sem_post, or to set a flag used by your application when a
> syscall returns EINTR.
>
>> - The child process which makes the system() call has a signal handler
>> installed for SIGCHILD signal and calls wait() to collect their exit
>> status.
>
> The handler for SIGCHLD should be installed in the parent process, not
> the children.
>
>>
>> signal(SIGCHLD, waitChild);
>>
>> void waitChild(int sig)
>> {
>>
>>      int status =3D0;
>>
>>      wait(&status);
>>
>> }
>
> That is incorrect, you may receive SIGCHLD only once for several
> children termination, so, you should call wait4 in non blocking mode
> until it returns EWOULDBLOCK.
>
> Or you should ignore explicitely SIGCHLD altogether, passing SIG_IGN to
> signal or sigaction, Linux will then take care correctly of terminated
> children.
>
>> Is there a specific order to follow while deleting real-time entities?
>> Is the system() call or "pkill -SIGTERM" the problem?
>
> why using system, why not using the kill service directly?
>
> --
> =09=09=09=09=09    Gilles.
>
>



