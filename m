Message-ID: <FB64A9A42E10824EAC3F78D6A2CD596E04DBD14C@kheops.clb.tcfr.thales>
From: Antoine.BRUGEAS@fr.thalesgroup.com
Date: Tue, 4 Jul 2006 12:42:27 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Xenomai-help] Modification of the PSOS skin.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid


hello,

Xenomai is under the GPL license, and I think that I have to redistribute the source code when I modify or add something on it.  But, I don't know how to process to distribute the source code. Then, I give you modifications in this mailing list.

Antoine Brugeas


files modified : psos.h and task.c


*********************psos.h**********************************************




/*
 * Copyright (C) 2001,2002,2003 Philippe Gerum <rpm@xenomai.org>.
 *
 * Xenomai is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published
 * by the Free Software Foundation; either version 2 of the License,
 * or (at your option) any later version.
 *
 * Xenomai is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Xenomai; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
 * 02111-1307, USA.
 *
 * This file satisfies the references within the emulator code
 * mimicking a pSOS+ like API built upon the Xenomai nucleus.
 *
 * pSOS and pSOS+ are registered trademarks of Wind River Systems, Inc.
 */

#ifndef _XENO_SKIN_PSOS_H
#define _XENO_SKIN_PSOS_H

#include <nucleus/xenomai.h>

#define PSOS_SKIN_VERSION_CODE    0x00000004
#define PSOS_SKIN_MAGIC           0x50534F53

#ifndef SUCCESS
#define SUCCESS 0
#endif

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

u_long as_catch(void (*routine)(void),
		u_long mode);

u_long as_send(u_long tid,
	       u_long signals);

#define as_return() return
#define i_return()  return

#define EV_NOWAIT       0x0001
#define EV_WAIT         0x0000
#define EV_ANY          0x0002
#define EV_ALL          0x0000

u_long ev_receive(u_long events,
		  u_long flags,
		  u_long timeout,
		  u_long *events_r);

u_long ev_send(u_long tid,
	       u_long events);

#define K_GLOBAL        0x0001
#define K_LOCAL         0x0000

void k_fatal(u_long err_code,
	     u_long flags);

#define PT_GLOBAL       0x0001
#define PT_LOCAL        0x0000
#define PT_DEL          0x0004
#define PT_NODEL        0x0000

u_long pt_create(char name[4],
		 void *paddr,
		 void *laddr,
		 u_long psize,
		 u_long bsize,
		 u_long flags,
		 u_long *ptid,
		 u_long *nbuf);

u_long pt_delete(u_long ptid);

u_long pt_getbuf(u_long ptid,
		 void **bufaddr);

u_long pt_ident(char name[4],
		u_long node,
		u_long *ptid);

u_long pt_retbuf(u_long ptid,
		 void *buf);

#define Q_GLOBAL        0x0001
#define Q_LOCAL         0x0000
#define Q_PRIOR         0x0002
#define Q_FIFO          0x0000
#define Q_LIMIT         0x0004
#define Q_NOLIMIT       0x0000
#define Q_PRIBUF        0x0008
#define Q_SYSBUF        0x0000
#define Q_NOWAIT        0x0001
#define Q_WAIT          0x0000

u_long q_broadcast(u_long qid,
		   u_long msgbuf[4],
		   u_long *count);

u_long q_create(char name[4],
		u_long maxnum,
		u_long flags,
		u_long *qid);

u_long q_delete(u_long qid);

u_long q_ident(char name[4],
	       u_long node,
	       u_long *qid);

u_long q_receive(u_long qid,
		 u_long flags,
		 u_long timeout,
		 u_long msgbuf[4]);

u_long q_send(u_long qid,
	      u_long msgbuf[4]);

u_long q_urgent(u_long qid,
		u_long msgbuf[4]);

u_long q_vcreate(char name[4],
		 u_long flags,
		 u_long maxnum,
		 u_long maxlen,
		 u_long *qid);

u_long q_vdelete(u_long qid);

u_long q_vident(char name[4],
		u_long node,
		u_long *qid);

u_long q_vreceive(u_long qid,
		  u_long flags,
		  u_long timeout,
		  void *msgbuf,
		  u_long buflen,
		  u_long *msglen);

u_long q_vsend(u_long qid,
	       void *msgbuf,
	       u_long msglen);

u_long q_vurgent(u_long qid,
		 void *msgbuf,
		 u_long msglen);

u_long q_vbroadcast(u_long qid,
		    void *msgbuf,
		    u_long msglen,
		    u_long *count);

#define RN_PRIOR        0x0002
#define RN_FIFO         0x0000
#define RN_DEL          0x0004
#define RN_NODEL        0x0000
#define RN_NOWAIT       0x0001
#define RN_WAIT         0x0000

u_long rn_create(char name[4],
		 void *rnaddr,
		 u_long rnsize,
		 u_long usize,
		 u_long flags,
		 u_long *rnid,
		 u_long *allocsize);

u_long rn_delete(u_long rnid);

u_long rn_getseg(u_long rnid,
		 u_long size,
		 u_long flags,
		 u_long timeout,
		 void **segaddr);

u_long rn_ident(char name[4],
		u_long *rnid);

u_long rn_retseg(u_long rnid,
		 void *segaddr);

#define SM_GLOBAL       0x0001
#define SM_LOCAL        0x0000
#define SM_PRIOR        0x0002
#define SM_FIFO         0x0000
#define SM_NOWAIT       0x0001
#define SM_WAIT         0x0000

u_long sm_create(char name[4],
		 u_long icount,
		 u_long flags,
		 u_long *smid);

u_long sm_delete(u_long smid);

u_long sm_ident(char name[4],
		u_long node,
		u_long *smid);

u_long sm_p(u_long smid,
	    u_long flags,
	    u_long timeout);

u_long sm_v(u_long smid);

#define T_NOPREEMPT     0x0001
#define T_PREEMPT       0x0000
#define T_TSLICE        0x0002
#define T_NOTSLICE      0x0000
#define T_NOASR         0x0004
#define T_ASR           0x0000
#define T_SUPV          0x2000
#define T_USER          0x0000
#define T_LEVELMASK0    0x0000
#define T_LEVELMASK1    0x0100
#define T_LEVELMASK2    0x0200
#define T_LEVELMASK3    0x0300
#define T_LEVELMASK4    0x0400
#define T_LEVELMASK5    0x0500
#define T_LEVELMASK6    0x0600
#define T_LEVELMASK7    0x0700
#define T_NOISR         0x0700
#define T_ISR           0x0000
#define T_GLOBAL        0x0001
#define T_LOCAL         0x0000
#define T_NOFPU         0x0000
#define T_FPU           0x0002
#define T_SHADOW        0x8000

u_long t_create(char name[4],
		u_long prio,
		u_long sstack,
		u_long ustack,
		u_long flags,
		u_long *tid);

u_long t_delete(u_long tid);

u_long t_getreg(u_long tid,
		u_long regnum,
		u_long *regvalue);

u_long t_ident(char name[4],
	       u_long node,
	       u_long *tid);

u_long t_mode(u_long clrmask,
	      u_long setmask,
	      u_long *oldmode);

u_long t_restart(u_long tid,
		 u_long targs[]);

u_long t_resume(u_long tid);

u_long t_setpri(u_long tid,
		u_long newprio,
		u_long *oldprio);

u_long t_setreg(u_long tid,
		u_long regnum,
		u_long regvalue);

u_long t_start(u_long tid,
	       u_long mode,
	       void (*startaddr)(u_long a0,
				 u_long a1,
				 u_long a2,
				 u_long a3),
	       u_long targs[]);

u_long t_suspend(u_long tid);

u_long tm_cancel(u_long tmid);

u_long tm_evafter(u_long ticks,
		  u_long events,
		  u_long *tmid);

u_long tm_evevery(u_long ticks,
		  u_long events,
		  u_long *tmid);

u_long tm_evwhen(u_long date,
		 u_long time,
		 u_long ticks,
		 u_long events,
		 u_long *tmid);

u_long tm_get(u_long *date,
	      u_long *time,
	      u_long *ticks);

u_long tm_set(u_long date,
	      u_long time,
	      u_long ticks);

u_long tm_tick(void);

u_long tm_wkafter(u_long ticks);

u_long tm_wkwhen(u_long date,
		 u_long time,
		 u_long ticks);

#ifdef __cplusplus
};
#endif /* __cplusplus */

#define ERR_TIMEOUT  0x01
#define ERR_SSFN     0x03     /* Illegal system service function number */
#define ERR_NODENO   0x04
#define ERR_OBJDEL   0x05
#define ERR_OBJID    0x06
#define ERR_OBJTYPE  0x07
#define ERR_OBJTFULL 0x08     /* Node's Object table full */
#define ERR_OBJNF    0x09

#define ERR_RSTFS    0x0D     /* Informative; files may be corrupted */
#define ERR_NOTCB    0x0E
#define ERR_NOSTK    0x0F
#define ERR_TINYSTK  0x10
#define ERR_PRIOR    0x11
#define ERR_ACTIVE   0x12
#define ERR_NACTIVE  0x13
#define ERR_SUSP     0x14
#define ERR_NOTSUSP  0x15
#define ERR_SETPRI   0x16
#define ERR_REGNUM   0x17

#define ERR_DELFS    0x18     /* pHILE+ resources in use */
#define ERR_DELLC    0x19     /* pREPC+ resources in use */
#define ERR_DELNS    0x1A     /* pNA+ resources in use */

#define ERR_RNADDR   0x1B
#define ERR_UNITSIZE 0x1C
#define ERR_TINYUNIT 0x1D
#define ERR_TINYRN   0x1E
#define ERR_SEGINUSE 0x1F

#define ERR_ZERO     0x20     /* Cannot getseg; request size of zero is */
#define ERR_TOOBIG   0x21
#define ERR_NOSEG    0x22
#define ERR_NOTINRN  0x23
#define ERR_SEGADDR  0x24
#define ERR_SEGFREE  0x25
#define ERR_RNKILLD  0x26
#define ERR_TATRNDEL 0x27

#define ERR_PTADDR   0x28
#define ERR_BUFSIZE  0x29
#define ERR_TINYPT   0x2A
#define ERR_BUFINUSE 0x2B
#define ERR_NOBUF    0x2C
#define ERR_BUFADDR  0x2D
#define ERR_BUFFREE  0x2F

#define ERR_KISIZE   0x30     /* Message length exceeds KI maximum */
#define ERR_MSGSIZ   0x31
#define ERR_BUFSIZ   0x32
#define ERR_NOQCB    0x33
#define ERR_NOMGB    0x34
#define ERR_QFULL    0x35
#define ERR_QKILLD   0x36
#define ERR_NOMSG    0x37
#define ERR_TATQDEL  0x38
#define ERR_MATQDEL  0x39
#define ERR_VARQ     0x3A
#define ERR_NOTVARQ  0x3B

#define ERR_NOEVS    0x3C
#define ERR_NOTINASR 0x3E
#define ERR_NOASR    0x3F

#define ERR_NOSCB    0x41
#define ERR_NOSEM    0x42
#define ERR_SKILLD   0x43
#define ERR_TATSDEL  0x44


#define ERR_NOTIME   0x47
#define ERR_ILLDATE  0x48
#define ERR_ILLTIME  0x49
#define ERR_ILLTICKS 0x4A
#define ERR_BADTMID  0x4C
#define ERR_TMNOTSET 0x4D
#define ERR_TOOLATE  0x4E

#define ERR_ILLRSC   0x53     /* Object not created from this node */
#define ERR_NOAGNT   0x54     /* Cannot wait; the remote node is out */
                              /* of Agents */
#define ERR_AGTBLKD  0x55     /* Agent blocked.  This is not an error. */

#define ERR_STALEID  0x65     /* Object does not exist any more */
#define ERR_NDKLD    0x66     /* Remote Node no longer in service */
#define ERR_MASTER   0x67     /* Cannot terminate Master node */

#endif /* !_XENO_SKIN_PSOS_H */




*********************task.c **********************************************



/*
 * Copyright (C) 2001,2002,2003 Philippe Gerum <rpm@xenomai.org>.
 *
 * Xenomai is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published
 * by the Free Software Foundation; either version 2 of the License,
 * or (at your option) any later version.
 *
 * Xenomai is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Xenomai; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
 * 02111-1307, USA.
 */

#include "psos+/task.h"
#include "psos+/tm.h"

static xnqueue_t psostaskq;

static u_long psos_time_slice;

static void psostask_delete_hook (xnthread_t *thread)

{
    /* The scheduler is locked while hooks are running */
    psostask_t *task;
    psostm_t *tm;

    if (xnthread_get_magic(thread) != PSOS_SKIN_MAGIC)
	return;

    task = thread2psostask(thread);

    removeq(&psostaskq,&task->link);

    while ((tm = (psostm_t *)getgq(&task->alarmq)) != NULL)
	tm_destroy_internal(tm);

    ev_destroy(&task->evgroup);
    xnarch_delete_display(&task->threadbase);
    psos_mark_deleted(task);
    xnfree(task);
}

void psostask_init (u_long rrperiod)

{
    initq(&psostaskq);
    psos_time_slice = rrperiod;
    xnpod_add_hook(XNHOOK_THREAD_DELETE,psostask_delete_hook);
}

void psostask_cleanup (void)

{
    xnholder_t *holder;

    while ((holder = getheadq(&psostaskq)) != NULL)
	t_delete((u_long)link2psostask(holder));

    xnpod_remove_hook(XNHOOK_THREAD_DELETE,psostask_delete_hook);
}

u_long t_create (char name[4],
		 u_long prio,
		 u_long sstack,
		 u_long ustack,
		 u_long flags,
		 u_long *tid)
{
    xnflags_t bflags = 0;
    psostask_t *task;
    char aname[5];
    spl_t s;
    int n;

    xnpod_check_context(XNPOD_THREAD_CONTEXT);

    if (prio < 1 || prio > 255)
	return ERR_PRIOR;

    aname[0] = name[0];
    aname[1] = name[1];
    aname[2] = name[2];
    aname[3] = name[3];
    aname[4] = '\0';

    task = (psostask_t *)xnmalloc(sizeof(*task));

    if (!task)
	return ERR_NOTCB;

    if (!(flags & T_SHADOW))
	{
	ustack += sstack;

	if (ustack < 1024)
	    {
	    xnfree(task);
	    return ERR_TINYSTK;
	    }

	if (flags & T_FPU)
	    bflags |= XNFPU;

	if (xnpod_init_thread(&task->threadbase,
			      aname,
			      prio,
			      bflags,
			      ustack) != 0)
	    {
	    xnfree(task);
	    return ERR_NOSTK; /* Assume this is the only possible failure */
	    }
	}

    xnthread_set_magic(&task->threadbase,PSOS_SKIN_MAGIC);
    xnthread_time_slice(&task->threadbase) = psos_time_slice;

    ev_init(&task->evgroup);
    inith(&task->link);

    for (n = 0; n < PSOSTASK_NOTEPAD_REGS; n++)
	task->notepad[n] = 0;

    initgq(&task->alarmq,
	   &xnmod_glink_queue,
	   xnmod_alloc_glinks,
	   XNMOD_GHOLDER_THRESHOLD,
	   xnpod_get_qdir(nkpod),
	   xnpod_get_maxprio(nkpod,0));

    task->magic = PSOS_TASK_MAGIC;

    xnlock_get_irqsave(&nklock,s);
    appendq(&psostaskq,&task->link);
    *tid = (u_long)task;
    xnlock_put_irqrestore(&nklock,s);

    xnarch_create_display(&task->threadbase,aname,psostask);

    return SUCCESS;
}

static void psostask_trampoline (void *cookie) {

    psostask_t *task = (psostask_t *)cookie;

    task->entry(task->args[0],
		task->args[1],
		task->args[2],
		task->args[3]);

    t_delete(0);
}

u_long t_start (u_long tid,
		u_long mode,
		void (*startaddr)(u_long,u_long,u_long,u_long),
		u_long targs[])
{
    u_long err = SUCCESS;
    xnflags_t xnmode;
    psostask_t *task;
    spl_t s;
    int n;

    xnpod_check_context(XNPOD_THREAD_CONTEXT);

    xnlock_get_irqsave(&nklock,s);

    //task = psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
    if (tid == 0)/*Add by AB*/
	task = psos_current_task();
    else
	{
	task = psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);

	if (!task)
	    {
	    err = psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
	    goto unlock_and_exit;
	    }
	}

    if (!task)
	{
	err = psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
	goto unlock_and_exit;
	}

    if (!xnthread_test_flags(&task->threadbase,XNDORMANT))
	{
	err = ERR_ACTIVE; /* Task already started */
	goto unlock_and_exit;
	}

    xnmode = psos_mode_to_xeno(mode);

    for (n = 0; n < 4; n++)
	task->args[n] = targs ? targs[n] : 0;

    task->entry = startaddr;

    xnpod_start_thread(&task->threadbase,
		       xnmode,
		       (int)((mode >> 8) & 0x7),
		       XNPOD_ALL_CPUS,
		       psostask_trampoline,
		       task);

 unlock_and_exit:

    xnlock_put_irqrestore(&nklock,s);

    return err;
}

u_long t_restart (u_long tid,
		  u_long targs[])
{
    u_long err = SUCCESS;
    psostask_t *task;
    spl_t s;
    int n;

    xnpod_check_context(XNPOD_THREAD_CONTEXT);

    xnlock_get_irqsave(&nklock,s);

//    task = psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
    if (tid == 0)/*Add by AB*/
	task = psos_current_task();
    else
	{
	task = psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);

	if (!task)
	    {
	    err = psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
	    goto unlock_and_exit;
	    }
	}

    if (!task)
	{
	err = psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
	goto unlock_and_exit;
	}

    if (xnthread_test_flags(&task->threadbase,XNDORMANT))
	{
	err = ERR_NACTIVE;
	goto unlock_and_exit;
	}

    for (n = 0; n < 4; n++)
	task->args[n] = targs ? targs[n] : 0;

    xnpod_restart_thread(&task->threadbase);

 unlock_and_exit:

    xnlock_put_irqrestore(&nklock,s);

    return err;
}

u_long t_delete (u_long tid)

{
    u_long err = SUCCESS;
    psostask_t *task;
    spl_t s;

    xnpod_check_context(XNPOD_THREAD_CONTEXT);

    if (tid == 0)
	xnpod_delete_self(); /* Never returns */

    xnlock_get_irqsave(&nklock,s);

//    task = psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
    if (tid == 0)/*Add by AB*/
	task = psos_current_task();
    else
	{
	task = psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);

	if (!task)
	    {
	    err = psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
	    goto unlock_and_exit;
	    }
	}

    if (!task)
	{
	err = psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
	goto unlock_and_exit;
	}

    xnpod_delete_thread(&task->threadbase);

 unlock_and_exit:

    xnlock_put_irqrestore(&nklock,s);

    return err;
}

u_long t_ident (char name[4],
		u_long node,
		u_long *tid)
{
    u_long err = SUCCESS;
    xnholder_t *holder;
    psostask_t *task;
    spl_t s;

    xnpod_check_context(XNPOD_THREAD_CONTEXT);

    if (node > 1)
	return ERR_NODENO;

    if (!name)
	{
	*tid = (u_long)psos_current_task();
	return SUCCESS;
	}

    xnlock_get_irqsave(&nklock,s);

    for (holder = getheadq(&psostaskq);
	 holder; holder = nextq(&psostaskq,holder))
	{
	task = link2psostask(holder);

	if (task->threadbase.name[0] == name[0] &&
	    task->threadbase.name[1] == name[1] &&
	    task->threadbase.name[2] == name[2] &&
	    task->threadbase.name[3] == name[3])
	    {
	    *tid = (u_long)task;
	    goto unlock_and_exit;
	    }
	}

    err = ERR_OBJNF;

 unlock_and_exit:

    xnlock_put_irqrestore(&nklock,s);

    return err;
}

u_long t_mode (u_long clrmask,
	       u_long setmask,
	       u_long *oldmode)
{
    xnpod_check_context(XNPOD_THREAD_CONTEXT);

    *oldmode = xeno_mode_to_psos(xnpod_set_thread_mode(&psos_current_task()->threadbase,
						       psos_mode_to_xeno(clrmask),
						       psos_mode_to_xeno(setmask)));
    *oldmode |= ((psos_current_task()->threadbase.imask & 0x7) << 8);

    return SUCCESS;
}

u_long t_getreg (u_long tid,
		 u_long regnum,
		 u_long *regvalue)
{
    u_long err = SUCCESS;
    psostask_t *task;
    spl_t s;

    xnlock_get_irqsave(&nklock,s);

   if (tid == 0)/*Add by AB*/
	task = psos_current_task();
    else
	{
	task = psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);

	if (!task)
	    {
	    err = psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
	    goto unlock_and_exit;
	    }
	}

    if (!task)
	{
	err = psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
	goto unlock_and_exit;
	}

    if (regnum >= PSOSTASK_NOTEPAD_REGS)
	{
	err = ERR_REGNUM;
	goto unlock_and_exit;
	}

    *regvalue = task->notepad[regnum];

 unlock_and_exit:

    xnlock_put_irqrestore(&nklock,s);

    return err;
}

u_long t_resume (u_long tid)

{
    u_long err = SUCCESS;
    psostask_t *task;
    spl_t s;

    xnlock_get_irqsave(&nklock,s);

//    task = psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
    if (tid == 0)/*Add by AB*/
	task = psos_current_task();
    else
	{
	task = psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);

	if (!task)
	    {
	    err = psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
	    goto unlock_and_exit;
	    }
	}

    if (!task)
	{
	err = psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
	goto unlock_and_exit;
	}

    if (!xnthread_test_flags(&task->threadbase,XNSUSP))
	{
	err = ERR_NOTSUSP; /* Task not suspended. */
	goto unlock_and_exit;
	}

    xnpod_resume_thread(&task->threadbase,XNSUSP);
    xnpod_schedule();

 unlock_and_exit:

    xnlock_put_irqrestore(&nklock,s);

    return err;
}

u_long t_suspend (u_long tid)

{
    u_long err = SUCCESS;
    psostask_t *task;
    spl_t s;

    xnpod_check_context(XNPOD_THREAD_CONTEXT);

    if (tid == 0)
	{
	xnpod_suspend_self();
	return SUCCESS;
	}

    xnlock_get_irqsave(&nklock,s);

    //    task = psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
    if (tid == 0)/*Add by AB*/
	task = psos_current_task();
    else
	{
	task = psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);

	if (!task)
	    {
	    err = psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
	    goto unlock_and_exit;
	    }
	}

    if (!task)
	{
	err = psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
	goto unlock_and_exit;
	}

    if (xnthread_test_flags(&task->threadbase,XNSUSP))
	{
	err = ERR_SUSP; /* Task already suspended. */
	goto unlock_and_exit;
	}

    xnpod_suspend_thread(&task->threadbase,
			 XNSUSP,
			 XN_INFINITE,
			 NULL);

 unlock_and_exit:

    xnlock_put_irqrestore(&nklock,s);

    return err;
}

u_long t_setpri (u_long tid,
		 u_long newprio,
		 u_long *oldprio)
{
    u_long err = SUCCESS;
    psostask_t *task;
    spl_t s;

    xnpod_check_context(XNPOD_THREAD_CONTEXT);

    xnlock_get_irqsave(&nklock,s);

    if (tid == 0)
	task = psos_current_task();
    else
	{
	task = psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);

	if (!task)
	    {
	    err = psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
	    goto unlock_and_exit;
	    }
	}

    *oldprio = xnthread_current_priority(&task->threadbase);

    if (newprio != 0)
	{
	if (newprio < 1 || newprio > 255)
	    {
	    err = ERR_SETPRI;
	    goto unlock_and_exit;
	    }

	if (newprio != *oldprio)
	    {
	    xnpod_renice_thread(&task->threadbase,newprio);
	    xnpod_schedule();
	    }
	}

 unlock_and_exit:

    xnlock_put_irqrestore(&nklock,s);

    return err;
}

u_long t_setreg (u_long tid,
		 u_long regnum,
		 u_long regvalue)
{
    u_long err = SUCCESS;
    psostask_t *task;
    spl_t s;				

    xnlock_get_irqsave(&nklock,s);

  
//    task = psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);
    if (tid == 0)/*Add by AB*/
	task = psos_current_task();
    else
	{
	task = psos_h2obj_active(tid,PSOS_TASK_MAGIC,psostask_t);

	if (!task)
	    {
	    err = psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
	    goto unlock_and_exit;
	    }
	}

    if (!task)
	{
	err = psos_handle_error(tid,PSOS_TASK_MAGIC,psostask_t);
	goto unlock_and_exit;
	}

    if (regnum >= PSOSTASK_NOTEPAD_REGS)
	{
	err = ERR_REGNUM;
	goto unlock_and_exit;
	}

    task->notepad[regnum] = regvalue;

 unlock_and_exit:

    xnlock_put_irqrestore(&nklock,s);

    return err;
}

/*
 * IMPLEMENTATION NOTES:
 *
 * - Code executing on behalf of interrupt context is currently not
 * allowed to scan/alter the global psos task queue (psostaskq).
 */




