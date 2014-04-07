References: <1396262085.387.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53395104.6050109@xenomai.org> <53396B31.1090903@xenomai.org>
 <5339AACA.4090807@xenomai.org>
 <1396782702.1096.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <53416D09.7060805@xenomai.org>
Message-ID: <1396889360.63594.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Mon, 7 Apr 2014 17:49:20 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53416D09.7060805@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] EINTR in notifier.c (mercury)
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

----- Original Message -----

> From: Philippe Gerum <rpm@xenomai.org>
> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <xeno=
mai@xenomai.org>
> Cc: =

> Sent: Sunday, April 6, 2014 5:04 PM
> Subject: Re: [Xenomai] EINTR in notifier.c (mercury)
> =

> On 04/06/2014 01:11 PM, Matthias Schneider wrote:
>>>  On Monday, March 31, 2014 7:50 PM, Gilles Chanteperdrix =

> <gilles.chanteperdrix@xenomai.org> wrote:
>> =

>>>>  On 03/31/2014 03:18 PM, Philippe Gerum wrote:
>>>> =A0  On 03/31/2014 01:27 PM, Gilles Chanteperdrix wrote:
>>>>> =A0  On 03/31/2014 12:34 PM, Matthias Schneider wrote:
>>>>>> =A0  Hi all,
>>>>>> =

>>>>>> =

>>>>>> =A0  still working on thread suspension in mercury, I noticed =

> that some
>>>>>> =A0  threadobj_suspend() and threadobj_resume() calls seemed =

> not to have the desired
>>>>>> =A0  effect. Analyzing the issue, I found out that sometimes =

> the read operations on
>>>>>> =A0  the pipe in notifier_wait() seem to return with EINTR, =

> especially in
>>>>>> =A0  heavily loaded systems. Restarting the read system call =

> in that case made
>>>>>> =A0  thread suspension a lot more reliable in my case.
>>>>>> =

>>>>>> =A0  I have attached a patch adding loops to deal with the =

> EINTR situation in all
>>>>> =

>>>>> =A0  You can probably avoid testing for EINTR if all signal =

> handlers are
>>>>> =A0  registered with the SA_RESTART flag.
>>>>> =

>>>> =

>>>> =A0  The app may not explicitly care for signals (granted, most would =

> do, but
>>>> =A0  we would then have to assume they do it right).
>>>> =

>>> =

>>>  Yes, applications may want to use signals to interrupt a call to read
>>>  and voluntarily get EINTR anyway.
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.
>> =

>> =

>>  Please find attached a third version of my patch dealing with
>>  EINTR syscalls. Note that I also stumbled over unexpected behavior
>>  in threadobj_sleep and cancel_sync due to EINTRs. Considering that
>>  mercury is using signals for user-space round-robin and thread
>>  suspension, even without any application signals EINTR happens
>>  quite often.
> =

> @@ -86,9 +88,13 @@ static void notifier_sighandler(int sig, siginfo_t *si=
ginfo, =

> void *uc)
> =A0=A0=A0 =A0=A0=A0 if (nf->owner && nf->owner !=3D tid)
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 continue;
> =

> -=A0=A0=A0 =A0=A0=A0 while (__STD(read(nf->psfd[0], &c, 1)) > 0)
> -=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* Callee must run async-safe code only. */
> -=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 nf->callback(nf);
> +=A0=A0=A0 =A0=A0=A0 do {
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ret =3D __STD(read(nf->psfd[0], &c, 1)); =

> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (ret > 0)
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* Callee must run async-safe co=
de only. */
> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 nf->callback(nf);
> +=A0=A0=A0 =A0=A0=A0 } while (ret > 0 || errno =3D=3D EINTR);
> =

> In theory, we could receive a zero byte count on EOF, in which case we sh=
ould =

> not test errno, rather we should bail out immediately.
> =

> @@ -1093,7 +1093,9 @@ int threadobj_sleep(struct timespec *ts)
> =A0=A0=A0  */
> =A0=A0=A0 current->run_state =3D __THREAD_S_DELAYED;
> =A0=A0=A0 threadobj_save_timeout(&current->core, ts);
> -=A0=A0=A0 ret =3D -__RT(clock_nanosleep(CLOCK_COPPERPLATE, TIMER_ABSTIME=
, ts, NULL));
> +=A0=A0=A0 do
> +=A0=A0=A0 =A0=A0=A0 ret =3D -__RT(clock_nanosleep(CLOCK_COPPERPLATE, TIM=
ER_ABSTIME, ts, =

> NULL));
> =

> We should definitely pass and use the "remain" field in =

> clock_nanosleep(), not to restart a complete wait each time we get interr=
upted.
> =

> =

> -- =

> Philippe.
> =


I have attached a new version of the patch leaving the loop on ret =3D=3D 0=
. Note=A0
that this will be a new behavior in compared to before the patch.

Gilles already pointed out that=A0TIMER_ABSTIME allows restarting the same =
syscall
in threadobj_sleep.

Regards,
Matthias
-------------- next part --------------
A non-text attachment was scrubbed...
Name: eintr_4.patch
Type: text/x-patch
Size: 3055 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140407/439744e=
d/attachment.bin>
