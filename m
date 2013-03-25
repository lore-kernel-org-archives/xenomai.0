MIME-Version: 1.0
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Mon, 25 Mar 2013 15:16:48 +0100
Message-ID: <CAMJ=MEdEOxm2_7_3On9vdzfQq1+5oyqXt+R+5RMPc30u_GNcKw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] xenomai-forge: psos skin: t_delete assertion when task
 was not able to run before it is deleted.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello

I'm doing some more tests related to task creation and deletion.
The complete testcode is attached to the mail.

I basically have a task that creates, starts and deletes other tasks in a l=
oop:

  for (i=3D0;i<500;i++) {
    printf("Priority %d\n",i);
    check("t_create loop3",t_create ("TEST",(i%HIGH_PRIO)+2,100000,0,0,&tid=
),0);
    check("t_start loop3",t_start(tid,T_PREEMPT,test_taskcreation_body,args=
),0);
    check("t_delete loop3",t_delete(tid),0);
  }

If the code above is execute by a task running at priority 1, there is no i=
ssue.
Note that the task that are being created range from prio 2 to 97
(HIGH_PRIO=3D95).

If the task that executes the code is running at a higher priority
(for example 3), I observe this:
# taskset 2 ./createdelete.exe
   0"000.492| WARNING: [main] Xenomai compiled with full debug enabled,
                              very high latencies expected [--enable-debug=
=3Dfull]
Priority 0
createdelete.exe: ../../include/copperplate/threadobj.h:205:
__threadobj_tag_unlocked: Assertion `thobj->status & 0x20' failed.
Aborted

Conclusion is: as soon as a task that is being created/started/deleted
has a lower priority than the task that creates it, the code crashes
in t_delete with the assertion above.

---
Ronny
-------------- next part --------------
A non-text attachment was scrubbed...
Name: createdelete.c
Type: text/x-csrc
Size: 1546 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130325/b3ed188=
1/attachment.c>
