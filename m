Message-ID: <4E0A24A0.5050203@domain.hid>
Date: Tue, 28 Jun 2011 20:59:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1309285551.669.35.camel@domain.hid>
In-Reply-To: <1309285551.669.35.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Posix Memory Leak w/ sem_open
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henry Bausley <hbausley@domain.hid>
Cc: xenomai@xenomai.org

On 06/28/2011 08:25 PM, Henry Bausley wrote:
> 
> Using the program below the used main heap continues to grow forever. 
> 
> int  main(void)
> {
>   sem_t *mutex;
>   mutex = sem_open(SEM_NAME,O_CREAT,0644,1);
>   sem_close(mutex);
>   sem_unlink(SEM_NAME);
>   return 0;
> }
> 
> I am using xenomai 2.5.6 with the ipipe-2.6.35.9-powerpc-2.12-02
> kernel.  Below you can see the used heap continually grow when
> executing the above program.
> 
Should be fixed with the following patch:

diff --git a/ksrc/skins/posix/syscall.c b/ksrc/skins/posix/syscall.c
index 3c7f7ee..c9e84a6 100644
--- a/ksrc/skins/posix/syscall.c
+++ b/ksrc/skins/posix/syscall.c
@@ -718,17 +718,20 @@ static int __sem_close(struct pt_regs *regs)
 
 	usm = assoc2usem(assoc);
 
-	if ((closed = (--usm->refcnt == 0)))
+	err = sem_close(&sm.native_sem);
+
+	if (!err && (closed = (--usm->refcnt == 0)))
 		pse51_assoc_remove(&pse51_queues()->usems,
 				   (u_long)sm.shadow_sem.sem);
 
-	err = sem_close(&sm.native_sem);
-
 	xnlock_put_irqrestore(&pse51_assoc_lock, s);
 
 	if (err)
 		return -thread_get_errno();
 
+	if (usm->refcnt == 0)
+		xnfree(usm);
+
 	return __xn_safe_copy_to_user((void __user *)__xn_reg_arg2(regs),
 				      &closed, sizeof(int));
 }


> 
> 
> 
> 
> 
> 
> 
> Outbound scan for Spam or Virus by Barracuda at Delta Tau
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
                                                                Gilles.

