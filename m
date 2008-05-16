MIME-Version: 1.0
Date: Fri, 16 May 2008 12:11:23 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <2ff1a98a0805160149w3478755bqa4ffa44dfc7107b0@domain.hid>
References: <2ff1a98a0805160149w3478755bqa4ffa44dfc7107b0@domain.hid>
Message-ID: <62ac12da32c026b0097185dff53fe0d8@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] =?utf-8?q?_Re=3A__Re=3A_VxWorks_skin_problem_conce?=
 =?utf-8?q?rning_WIND=5FTCBstructure?=
Reply-To: matthieu.connaulte_xenomai@domain.hid
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

> I suggest you patch your kernel with the patch Philippe sent, adapt it
> to suit your needs, maybe changing TASK_DESC as in vxworks taskLib.h,
> test and debug it, then send us a patch which we will be happy to
> merge.
>=20
> --
>  Gilles

Ok, I was about doing it.

I still have some questions about the migration of my app, as I don't kno=
w
Xenomai in details.

Here is part of my code which aims at defining a procedure to restart a
task. If you have time to have a look on it, it would be helpful.


 /***********************************************************************=
******
*
* vx_t_restart -  task restart routine.
*
* Restart a task with its original priority and mode.
*
* RETURNS:=20
* EOK if successful.
* ERR_OBJID if the task id is invalid.
* ERR_OBJDEL if the task is deleted by another task while in t_restart.
* ANAIS_ERROR if an unknown failure in taskRestart.
*/

UINT32 vx_t_restart ( UINT32 tid,		/* task ID of task to restart */
					  UINT32 args[4])	/* new arguments for task */
{

  WIND_TCB 		*pTcb;		/* the task's control block */
  P2V_SHADOW_TCB 	*pShadow;			/* the TCB extension */=20
  UINT32 		tmp1;
  UINT32 		i;
  UINT32 		vxArgs[10];     /* larger arg array for vxWorks */
  UINT32 		lock;
  struct sigtcb 	*pSigTcb;
 =20
  /* get the task's TCB, and check for validity */
 =20
  if  (tid =3D=3D 0)
	tid =3D taskIdSelf();
 =20
  if( (pTcb =3D taskTcb(tid)) =3D=3D NULL)=20
   	return (ERR_OBJID);
 =20
  /* get the TCB extension and make sure it's a p2v task */
 =20
  if( (pShadow =3D taskExtTcb(tid)) =3D=3D NULL )=20
	return (ERR_OBJID);
 =20
  if (tid =3D=3D taskIdSelf())
	{
	  /* self restart not possible because we have we have no context
	   * from which to sucessfully terminate or reinitialize ourself.
	   * We defer all self restarts to the exception task.
	   * To self restart within a critical section, we must TASK_UNSAFE ()
	   * until the safeCnt =3D=3D 0.  Otherwise, the excTask would block
	   * forever trying to terminate us.
	   */
	 =20
	  while (pTcb->safeCnt > 0)	/* make task unsafe */
	    TASK_UNSAFE ();
	  	 =20
	  taskSpawn ("t_restart", 0, 0,
				 6000, ( FUNCPTR)vx_t_restart, (int) tid,
				 0, 0, 0, 0, 0, 0, 0, 0, 0);
	  FOREVER
	    taskSuspend (0);			/* wait for restart */
	}
 =20
  /* The following loop allows the target task to run until
   * it gives up all critical resources and can be suspended
   * without causing an interlock.  The criteria for suspending
   * the task here are the same as deleting a task -- both the
   * safeCnt and the lockCnt must be 0.  Note:  this loop does
   * things which should never appear in user code, namely entering
   * kernel mode and directly manipulating task queues.
   */
 =20
  lock =3D intLock();
  while ((pTcb->safeCnt > 0) ||
		 ((pTcb->status =3D=3D WIND_READY) && (pTcb->lockCnt > 0)))
	{
	  kernelState =3D TRUE;				/* KERNEL ENTER */
	 =20
	  intUnlock (lock);				/* UNLOCK INTERRUPTS */
	 =20
	  if (pTcb =3D=3D taskIdCurrent)
	    {

		  pTcb->safeCnt =3D 0;				/* unprotect */
		  pTcb->lockCnt =3D 0;				/* unlock */
		 =20
		  if (Q_FIRST (&pTcb->safetyQHead) !=3D NULL)	/* flush safe queue */
			windPendQFlush (&pTcb->safetyQHead);
		 =20
		  windExit ();				/* KERNEL EXIT */
	    }
	  else						/* wait to destroy */
	    {
		  if (windPendQPut (&pTcb->safetyQHead, WAIT_FOREVER) !=3D OK)
			{
			  windExit ();				/* KERNEL EXIT */
			  return (ANAIS_ERROR);
			}
		 =20
		  switch (windExit())
			{
			 =20
			case ERROR :				/* timed out */
		    return (ANAIS_ERROR);
		=09
			default :				/* we were flushed */
			  break;
			}
		}
	 =20
	  /* Make sure target task didn't exit */
	 =20
	  lock =3D intLock ();				/* LOCK INTERRTUPTS */
	 =20
	  if (TASK_ID_VERIFY (pTcb) !=3D OK)
		{
		  intUnlock (lock);				/* UNLOCK INTERRUPTS */
		  return (ERR_OBJDEL);
	    }
	}
 =20
  /* Suspend the task being restarted (this already happened above=20
   * if the task is restarting itself.
   */
 =20
  taskSuspend (tid);
=09
  TASK_SAFE();                                       /* protect deleter *=
/
 =20
  /* At this point target task is suspended and can't be deleted
   * by anyone else.  If task is restarting itself, it is safe from
   * deletion.
   */
  /* Save the pointers to the TCB extension, since the VxWorks TCB will
   * be wiped clean by taskRestart.
   */
  /* Set reserved field to NULL because delete hook runs when a
   * task is restarted -- and we don't want that!
   */
  tmp1 =3D (UINT32) pTcb->pTaskVar;
  pTcb->pTaskVar =3D NULL;

  /* Reuse signal info structure in the task stack */
 =20
  pSigTcb =3D pTcb->pSignalInfo;
 =20
  intUnlock(lock);  				/* INT UNLOCK */
 =20
  /* Disarm all the task's timers.
   * Need to taskLock because we don't want timers expiring and
   * trying to update linked list while we are.
   */

  /* set the task's new arguments */

  if ( args =3D=3D NULL )
	vxArgs[0] =3D vxArgs[1] =3D vxArgs[2] =3D vxArgs[3] =3D 0;
  else
	for ( i =3D 0; i < 4; i++ )
	  vxArgs[i] =3D args[i];
 =20
  taskArgsSet (pTcb, pTcb->pStackBase, (int *) vxArgs);

  /*
   *  Note:  vxWorks' taskRestart keeps the current stack, rather than
   *  reducing the stacksize to the original.=20
   *  To keep the outermost stack frame intact, must modify
   *  the vxWorks option word -- otherwise the stack would be
   *  reinitialized to 0xee's
   */
 =20
  pTcb->options |=3D VX_NO_STACK_FILL;
 =20
  /* don't let restarted task run till its TCB is fixed */
 =20
  taskLock ();   				/* TASK LOCK */
 =20
  if (taskRestart (tid) =3D=3D ERROR)
	{
	  taskUnlock ();				/* TASK UNLOCK */
	  if (errno =3D=3D S_objLib_OBJ_DELETED)=20
	    return (ERR_OBJDEL);
	  else
	    return (ANAIS_ERROR);
	}

  /* Reconnect TCB extension */
  pTcb->pTaskVar =3D (struct taskVar *) tmp1;

  /* reinitialize signal info */
 =20
  bzero ((char *) pSigTcb, sizeof (struct sigtcb));
  for (i =3D 0; i <=3D _NSIGS; i++)
	pSigTcb->sigt_qhead[i].sigq_next =3D pSigTcb->sigt_qhead[i].sigq_prev =3D
&pSigTcb->sigt_qhead[i];

 =20
  pTcb->pSignalInfo =3D pSigTcb;

  /*
   * restarting a task clears all pending signals and events and resets=20
   * the signal handler.
   */

  taskUnlock ();   				/* TASK UNLOCK */
  taskUnsafe ();   				/* TASK UNSAFE */
 =20
  return (EOK);
}

There are still WIND_TCB members use in this part of code, and I thing it=
's
possible to simplify this routine...
What do you think about it ?

Matthieu



