content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 May 2007 17:48:49 +0200
Message-ID: <5C40CD1E4697424ABDE3AC57CF1B22C6032202CC@FR0-MAILMB20.res.airbus.corp>
From: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
Subject: Re: [Xenomai-help] [Newbie question] threads and task CPU affinity
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
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

> > Hi,
> >=20
> > I'm still blocked on a CPU affinity problem.
> > In order to adapt a set affinity function which is based on
> > posix linux lib :
> > - CPU_AssignPID(uint32 PID, uint32 CPU_id)
> > - the cpu affinity of the caller and all its child threads=20
> must be set to CPU_id.
> >=20
> > Problems are:
> > Child PIDs must be listed, the only means I found is=20
> listing pids using `ls /proc/"Parent pid"/ > temp_file`
> > And each listed pid is sched_setaffinity'ed.
> > I don't know if setting affinity of RT threads from an=20
> other thread (parent) using pid works with xenomai.
> >=20
> > So, my question is :
> > With xenomai, is recursively cpu affinity setting from a=20
> parent thread, a good way of doing ?
> > I read switchtest program, and I conclude that in a xenomai=20
> and RT perspective, it seems "nicer"
> > to set affinity each threads separately during their init=20
> phase before the RT infinite loop.
> > Otherwise, setting affinity after child threads creation=20
> from its parent, may switch them into=20
> > secondary mode during their RT loop, and at an unknown moment.
> > Argumentation is important for my internship because I have=20
> to port on xenomai a very big RT=20
> > posix based application. And I should justify any=20
> modifications and prevent potential problems.
> >=20
> > Sorry, I don't know if it is clear.
>=20
> I think that it is safe to assume that if the affinity of a thread is
> inherited from the thread that created it with Linux posix=20
> library, the
> same will happen with Xenomai.
>=20
> Now, if you want to set the affinity of a group of threads after their
> creation, I do not see how to do this without walking through the list
> of threads. If your library has an abstraction for threads,=20
> you can keep
> them in a list. It will be useful at process exit time to=20
> cleanly cancel
> all threads (this may be useful if you want to detect leaks=20
> for instance).
>=20
> Note that when talking about scheduling affinity function, we are
> swimming in the undefined, since these functions are not=20
> standardized by
> posix.
>=20
> But since you are porting a library to Xenomai maybe you can=20
> have a look
> at the current implementation of CPU_AssignPID ?
>=20
> --=20
>                                                  Gilles Chanteperdrix

Thanks,
Precisly, the current implementation has nothing curious and=20
there is no reason it does not work on xenomai but,
in a simple program that just switches the cpu :
Before CPU_assignpid call, 'ps -ax -0 SCHED | grep <pid>'
and '/proc/xenomai/sched' returns the same result (i.e. the current thread =
runs on the same cpu)
After CPU_assignpid call, 'ps -ax -0 SCHED | grep <pid>' shows that threads=
 cpu has switched
whereas '/proc/xenomai/sched' shows no changes.

Does '/proc/xenomai/sched' not change during running, if yes
I continue debugging my program ?

And unfortunatly, this library does not have a threads abstraction.

CPU_Error CPU_AssignPid(uint32 Pid, CPU_CpuId Cpu)
{
  int mask =3D 1, i, nbTask;
  int cpu_nb;
  char cmd[SIZE_CMD] ;
  uint32 taskPid;
  FILE * filePid;
=20=20
  cpu_nb =3D CPU_GetNbCpu();=09
=20=20
  if(Cpu > cpu_nb )
    {
      return CPU_INVALID_CPUID;
    }
  for (i=3D0; i<Cpu; i++) mask =3D mask *2;
=20=20
=20=20
  sprintf(cmd,"ls /proc/%d/task | wc | awk '{print $1}' > /tmp/nbTask.tmp",=
Pid);
  system(cmd);
  filePid =3D fopen("/tmp/nbTask.tmp","r");
  fscanf(filePid,"%d",&nbTask);
  fclose ( filePid );
=20=20
  if ( nbTask =3D=3D 1)
    {
      if(sched_setaffinity(Pid,sizeof(int), (unsigned long *)&mask) =3D=3D =
-1)
	{/* manage error*/}
    }
  else
    {
      sprintf(cmd,"ls /proc/%d/task  > /tmp/listPid.tmp",Pid);
      system(cmd);
      filePid =3D fopen("/tmp/listPid.tmp","r");
      for ( i =3D0 ; i < nbTask ; i++ )
	{
	  fscanf(filePid,"%u",&taskPid);
	  if(sched_setaffinity(taskPid, (unsigned long *)&mask) =3D=3D -1)
	   {/* manage error*/}
      fclose ( filePid );
    }=20=20
  return CPU_OK;
}

This e-mail is intended only for the above addressee. It may contain privil=
eged information.
If you are not the addressee you must not copy, distribute, disclose or use=
 any of the information in it.=20
If you have received it in error please delete it and immediately notify th=
e sender.
Security Notice: all e-mail, sent to or from this address, may be accessed =
by someone other than the recipient, for system management and security rea=
sons. This access is controlled under Regulation of security reasons.
This access is controlled under Regulation of Investigatory Powers Act 2000=
, Lawful Business Practises.



