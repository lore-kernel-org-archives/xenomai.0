From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Mon, 22 Sep 2008 19:59:48 +0200
References: <200809212226.14177.niklaus.giger@domain.hid>
	<48D7B05D.5060101@domain.hid>
In-Reply-To: <48D7B05D.5060101@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809221959.50065.niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core]
 =?iso-8859-1?q?xenomai-solo-vxWorks=3A_Calling_sem?=
 =?iso-8859-1?q?Give_twice_on_a=09binary_semaphore_should_not_return_an_er?=
 =?iso-8859-1?q?ror?=
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Hi 

Thanks a lot. This patch does indeed fix my problem.

Best regards

Niklaus
Am Montag 22 September 2008 16.49:01 schrieb Philippe Gerum:
> Niklaus Giger wrote:
> > Hi
> >
> > Examining errors in my big testsuite I discovered that giving a second
> > time a binary semaphore xenomai returns an error where vxWorks reports
> > OK.
>
> Thanks for reporting. That patch should fix this issue:
>
> diff --git a/vxworks/semLib.c b/vxworks/semLib.c
> index 62f9326..6467354 100644
> --- a/vxworks/semLib.c
> +++ b/vxworks/semLib.c
> @@ -104,8 +104,11 @@ static STATUS xsem_give(struct wind_sem *sem)
>  	if (syncobj_lock(&sem->u.xsem.sobj, &syns))
>  		return S_objLib_OBJ_ID_ERROR;
>
> -	if (sem->u.xsem.value >= sem->u.xsem.maxvalue)
> -		ret = S_semLib_INVALID_OPERATION;
> +	if (sem->u.xsem.value >= sem->u.xsem.maxvalue) {
> +		if (sem->u.xsem.maxvalue == INT_MAX)
> +			/* No wrap around. */
> +			ret = S_semLib_INVALID_OPERATION;
> +	}
>  	else if (++sem->u.xsem.value <= 0)
>  		syncobj_post(&sem->u.xsem.sobj);
>
> > See the attached test case.
> >
> >> sudo  ../../bin/BSys/mak/xeno_vx-solo/debug/tst
> >> assert passed at testTask line 65
> >> assert passed at testTask line 66
> >> assert failed at testTask line 67
> >> testTask done
> >> Xenomai/SOLO: failed to remove registry mount point /mnt/xenomai/4569
> >> (errno=16)
> >
> > Best regards
> >
> >
> >
> > ------------------------------------------------------------------------
> >
> > _______________________________________________
> > Xenomai-core mailing list
> > Xenomai-core@domain.hid
> > https://mail.gna.org/listinfo/xenomai-core

-- 
NIklaus Giger


