From: "Charlton, John" <john.charlton@domain.hid>
Date: Tue, 2 Mar 2010 08:26:53 -0500
Message-ID: <CF7FB0793253794F9F45991443E5FE2006483DE995@domain.hid>
References: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>
	<4B86EDC2.7010905@domain.hid>	<4B86FCBB.10203@domain.hid>
	<4B86FFA0.3000403@domain.hid>	<4B870134.2040802@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE98D@us194mx002.tycoelectronics.net>
	<4B87FC70.90903@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE98F@us194mx002.tycoelectronics.net>
	<CF7FB0793253794F9F45991443E5FE2006483DE993@domain.hid>
	<4B8C2490.1040604@domain.hid> <4B8C25B9.8090705@domain.hid>
	<4B8C26F7.3020306@domain.hid> <4B8C2797.2000501@domain.hid>
	<4B8C29E1.7070404@domain.hid> <4B8C2B3E.8020505@domain.hid>
	<4B8C2C35.6030006@domain.hid> <4B8C2FE6.5000406@domain.hid>
	<4B8C30DA.3000705@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE994@domain.hid>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE2006483DE994@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] mlockall error after calling mlockall()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Charlton, John" <john.charlton@domain.hid>, 'Jan Kiszka' <jan.kiszka@domain.hid>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

While I was debugging this problem, it looked like I could change ksrc/skin=
s/native/cond.c by modifying the rt_cond_wait_inner function as follows:
--- xenomai-2.5.1_bak/ksrc/skins/native/cond.c  2010-01-15 19:09:31.0000000=
00 -0500
+++ xenomai-2.5.1/ksrc/skins/native/cond.c      2010-03-01 17:17:22.0000000=
00 -0500
@@ -468,15 +468,22 @@
 {
        unsigned lockcnt;
        int err;
+        int err_save;

        err =3D rt_cond_wait_prologue(cond, mutex, &lockcnt,
                                    timeout_mode, timeout);

+        err_save =3D err;
        if(!err || err =3D=3D -ETIMEDOUT || err =3D=3D -EINTR)
                do {
                        err =3D rt_cond_wait_epilogue(mutex, lockcnt);
                } while (err =3D=3D -EINTR);

+        if (err_save =3D=3D -ETIMEDOUT)
+        {
+          err =3D err_save;
+        }
+
        return err;
 }
 /**

When I made these changes and put a printk in rt_cond_wait_inner also the p=
rintk did not get printed and the change above did not seem to make any dif=
ference.  So should I revert these changes or should they be made in additi=
on to the syscall.c kernel and cond.c user space changes as follows:

--- xenomai-2.5.1_bak/ksrc/skins/native/syscall.c       2010-02-01 20:01:09=
.000000000 -0500
+++ xenomai-2.5.1/ksrc/skins/native/syscall.c   2010-03-01 16:13:20.0000000=
00 -0500
@@ -1869,8 +1869,12 @@

        err =3D rt_cond_wait_prologue(cond, mutex, &lockcnt, timeout_mode, =
timeout);

-       if (err =3D=3D 0 || err =3D=3D -ETIMEDOUT)
-               err =3D rt_cond_wait_epilogue(mutex, lockcnt);
+        if (err =3D=3D 0 || err =3D=3D -ETIMEDOUT) {
+                int loc_err =3D rt_cond_wait_epilogue(mutex, lockcnt);
+                if (loc_err < 0)
+                       err =3D loc_err;
+        }
+

        if (err =3D=3D -EINTR && __xn_reg_arg3(regs)
            && __xn_safe_copy_to_user((void __user *)__xn_reg_arg3(regs),

--- xenomai-2.5.1_bak/src/skins/native/cond.c   2010-01-15 19:09:32.0000000=
00 -0500
+++ xenomai-2.5.1/src/skins/native/cond.c       2010-03-01 16:44:48.0000000=
00 -0500
@@ -41,7 +41,7 @@                                                          =
       =20
                                                                           =
       =20
 int rt_cond_wait(RT_COND *cond, RT_MUTEX *mutex, RTIME timeout)           =
       =20
 {                                                                         =
       =20
-       int saved_lockcnt, err;                                            =
       =20
+  int saved_lockcnt, err, saved_err;                                      =
       =20
                                                                           =
       =20
 #ifdef CONFIG_XENO_FASTSYNCH                                              =
       =20
        saved_lockcnt =3D mutex->lockcnt;                                  =
         =20
@@ -49,7 +49,7 @@                                                          =
       =20
        err =3D XENOMAI_SKINCALL5(__native_muxid,                          =
         =20
                                __native_cond_wait_prologue, cond, mutex,  =
       =20
                                NULL, XN_RELATIVE, &timeout);              =
       =20
-                                                                          =
       =20
+        saved_err =3D err;                                                =
         =20
        while (err =3D=3D -EINTR)                                          =
           =20
                err =3D XENOMAI_SKINCALL2(__native_muxid,                  =
         =20
                                        __native_cond_wait_epilogue, mutex,=
       =20
@@ -62,6 +62,7 @@                                                          =
       =20
                                 __native_cond_wait_prologue, cond, mutex, =
       =20
                                 &saved_lockcnt, XN_RELATIVE, &timeout);   =
       =20
                                                                           =
       =20
+        saved_err =3D err;                                                =
         =20
        while (err =3D=3D -EINTR)                                          =
           =20
                err =3D XENOMAI_SKINCALL2(__native_muxid,                  =
         =20
                                        __native_cond_wait_epilogue, mutex,=
       =20
@@ -69,12 +70,12 @@                                                        =
       =20
                                                                           =
       =20
 #endif /* !CONFIG_XENO_FASTSYNCH */

-       return err;
+       return saved_err;
 }

 int rt_cond_wait_until(RT_COND *cond, RT_MUTEX *mutex, RTIME timeout)
 {
-       int saved_lockcnt, err;
+  int saved_lockcnt, err, saved_err;

 #ifdef CONFIG_XENO_FASTSYNCH
        saved_lockcnt =3D mutex->lockcnt;
@@ -82,7 +83,7 @@
        err =3D XENOMAI_SKINCALL5(__native_muxid,
                                __native_cond_wait_prologue, cond, mutex,
                                NULL, XN_REALTIME, &timeout);
-
+        saved_err =3D err;
        while (err =3D=3D -EINTR)
                err =3D XENOMAI_SKINCALL2(__native_muxid,
                                        __native_cond_wait_epilogue, mutex,
@@ -94,14 +95,14 @@
        err =3D XENOMAI_SKINCALL5(__native_muxid,
                                __native_cond_wait_prologue, cond, mutex,
                                &saved_lockcnt, XN_REALTIME, &timeout);
-
+        saved_err =3D err;
        while (err =3D=3D -EINTR)
-               err =3D -XENOMAI_SKINCALL2(__native_muxid,
+               err =3D XENOMAI_SKINCALL2(__native_muxid,
                                         __native_cond_wait_epilogue, mutex=
,
                                         saved_lockcnt);
 #endif /* !CONFIG_XENO_FASTSYNCH */

-       return err;
+       return saved_err;
 }

 int rt_cond_signal(RT_COND *cond)


-----Original Message-----
From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] On=
 Behalf Of Jan Kiszka
Sent: Monday, March 01, 2010 4:26 PM
To: Gilles Chanteperdrix
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] mlockall error after calling mlockall()

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Same issue exists in user space. And rt_cond_wait_inner needs fixing.
>>> And then there is a spurious sign inversion:
>>>
>>> diff --git a/src/skins/native/cond.c b/src/skins/native/cond.c index
>>> 478321d..f874678 100644
>>> --- a/src/skins/native/cond.c
>>> +++ b/src/skins/native/cond.c
>>> @@ -96,9 +96,9 @@ int rt_cond_wait_until(RT_COND *cond, RT_MUTEX *mutex=
, RTIME timeout)
>>>  				&saved_lockcnt, XN_REALTIME, &timeout);
>>> =20
>>>  	while (err =3D=3D -EINTR)
>>> -		err =3D -XENOMAI_SKINCALL2(__native_muxid,
>>> -					 __native_cond_wait_epilogue, mutex,
>>> -					 saved_lockcnt);
>>> +		err =3D XENOMAI_SKINCALL2(__native_muxid,
>>> +					__native_cond_wait_epilogue, mutex,
>>> +					saved_lockcnt);
>>>  #endif /* !CONFIG_XENO_FASTSYNCH */
>> Ok for the sign inversion, but in this case the status is Ok. We call=20
>> cond_wait_epilogue only if prologue returned -EINTR, and update the=20
>> status, this is what we want.
>>
>> There is only one way out which will not break the ABI: do not call=20
>> cond_wait_epilogue in the kernel-space cond_wait_prologue.
>>
>=20
> Unfortunately, that ABI is broken: If we get -ETIMEDOUT on cond wait=20
> an -EINTR on mutex lock, we lose the former, don't we?
>=20
> If we can't find a workaround, I'm for breaking the ABI for this=20
> particular service - but let's search for an alternative first.
>=20

The only way around ABI changes: save the return code of cond_wait /somewhe=
re/ across prologue and epilogue syscalls - but where???

Jan


I will make the changes above and those to syscall.c since it looks like th=
ey will fix the immediate problem I am having.  My .config for the linux ke=
rnel always has CONFIG_XENO_FASTSYNC=3D'y' even if I set it manually it is =
reset to 'y' so the else !CONFIG_XENO_FASTSYNC is not a factor for my kerne=
l build.  I also added a saved_err to the user mode rt_cond_wait/wait_unitl=
 to return the prologue error code to the application.  I will keep monitor=
ing until you determine a better solution.

Thanks for the help,
--

John

_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help

