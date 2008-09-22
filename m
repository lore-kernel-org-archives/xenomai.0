Message-ID: <48D7B05D.5060101@domain.hid>
Date: Mon, 22 Sep 2008 16:49:01 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200809212226.14177.niklaus.giger@domain.hid>
In-Reply-To: <200809212226.14177.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] xenomai-solo-vxWorks: Calling semGive twice on
 a	binary semaphore should not return an error
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Niklaus Giger <niklaus.giger@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Niklaus Giger wrote:
> Hi
> 
> Examining errors in my big testsuite I discovered that giving a second
> time a binary semaphore xenomai returns an error where vxWorks reports OK.
> 

Thanks for reporting. That patch should fix this issue:

diff --git a/vxworks/semLib.c b/vxworks/semLib.c
index 62f9326..6467354 100644
--- a/vxworks/semLib.c
+++ b/vxworks/semLib.c
@@ -104,8 +104,11 @@ static STATUS xsem_give(struct wind_sem *sem)
 	if (syncobj_lock(&sem->u.xsem.sobj, &syns))
 		return S_objLib_OBJ_ID_ERROR;

-	if (sem->u.xsem.value >= sem->u.xsem.maxvalue)
-		ret = S_semLib_INVALID_OPERATION;
+	if (sem->u.xsem.value >= sem->u.xsem.maxvalue) {
+		if (sem->u.xsem.maxvalue == INT_MAX)
+			/* No wrap around. */
+			ret = S_semLib_INVALID_OPERATION;
+	}
 	else if (++sem->u.xsem.value <= 0)
 		syncobj_post(&sem->u.xsem.sobj);

> See the attached test case.
>> sudo  ../../bin/BSys/mak/xeno_vx-solo/debug/tst
>> assert passed at testTask line 65
>> assert passed at testTask line 66
>> assert failed at testTask line 67
>> testTask done
>> Xenomai/SOLO: failed to remove registry mount point /mnt/xenomai/4569
>> (errno=16)
> 
> Best regards
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.


