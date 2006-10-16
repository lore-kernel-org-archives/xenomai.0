From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] vxworks returns -1 for semGive
Date: Mon, 16 Oct 2006 08:02:25 +0200
References: <200609252310.03954.niklaus.giger@domain.hid>
In-Reply-To: <200609252310.03954.niklaus.giger@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610160802.27984.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Am Montag, 25. September 2006 23:10 schrieb Niklaus Giger:
> Hi
>
> I modified satch.c (see attached patch) to get a testcase for a wrong
> behaviour of the vxWorks skin. A semGive returns -1 if it is not preceded
> by a errnoSet(0).
>
> Output is:
> -- /usr/xenomai/bin $ /bin/satch
> NO TASK WAITING
> Xenomai: Switching RootTask to secondary mode after exception #1025 from
> user-space at 0xfe5cff8 (pid 3715)
>
> __xeno_user_init: semMCreate 45 taskId 44
> __xeno_user_init: semTake 45 status 0 0 taskId 44
> __xeno_user_init: semGive 45 status -1 errno 1441896 taskId 44
> Error code 1441896: S_semLib_INVALID_OPERATION
> __xeno_user_init: semTake 45 status 0 1441896 taskId 44
> __xeno_user_init: semGive 45 status 0 errno 0 taskId 44
> Error code 0: Unknown error
This error has been fixed. Probably with the recent changes to the syscall 
routines (r1722).

Thanks a lot for your hard work.

-- 
Niklaus Giger

