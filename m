From: "Charlton, John" <john.charlton@domain.hid>
Date: Mon, 1 Mar 2010 15:30:23 -0500
Message-ID: <CF7FB0793253794F9F45991443E5FE2006483DE993@domain.hid>
References: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>
	<4B86EDC2.7010905@domain.hid> <4B86FCBB.10203@domain.hid>
	<4B86FFA0.3000403@domain.hid> <4B870134.2040802@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE98D@us194mx002.tycoelectronics.net>
	<4B87FC70.90903@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE98F@us194mx002.tycoelectronics.net>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE2006483DE98F@us194mx002.tycoelectronics.net>
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
To: "Charlton, John" <john.charlton@domain.hid>, 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "'jan.kiszka@domain.hid'" <jan.kiszka@domain.hid>

I added some printk output to the cond.c file in xenomai-2.5.1 and it shows=
 that  xnsync_sleep_on returned -ETIMEDOUT as it should:
Xenomai: registered exported object M1-1908 (mutexes)
Xenomai: registered exported object C1-1908 (condvars)
xnsynch_sleep_on returned: -110
xnsynch_sleep_on returned: -110
xnsynch_sleep_on returned: -110
xnsynch_sleep_on returned: -110
xnsynch_sleep_on returned: -110
xnsynch_sleep_on returned: -110
xnsynch_sleep_on returned: -4
Xenomai: native: cleaning up cond "C1-1908" (ret=3D0).
Xenomai: unregistered exported object C1-1908 (condvars)
Xenomai: native: cleaning up mutex "M1-1908" (ret=3D0).
Xenomai: unregistered exported object M1-1908 (mutexes)
Xenomai: POSIX: destroyed thread df5a0800

I put the printk on line cond.c:433 after err is set in rt_cond_wait_prolog=
ue():

	info =3D xnsynch_sleep_on(&cond->synch_base,
				timeout, timeout_mode);
	if (info & XNRMID)
		err =3D -EIDRM;	/* Condvar deleted while pending. */
	else if (info & XNTIMEO) {
		err =3D -ETIMEDOUT;	/* Timeout. */
        }
	else if (info & XNBREAK) {
		err =3D -EINTR;	/* Unblocked. */
	}
        printk(KERN_DEBUG "xnsynch_sleep_on returned: %d\n", err);

I put a printk in rt_cond_wait_inner() which is called directly by rt_cond_=
wait() from user mode but did not see the output in the dmesg output for th=
at one.

--

John


-----Original Message-----
From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] On=
 Behalf Of Charlton, John
Sent: Monday, March 01, 2010 10:52 AM
To: 'Gilles Chanteperdrix'
Cc: xenomai@xenomai.org; 'jan.kiszka@domain.hid'
Subject: Re: [Xenomai-help] mlockall error after calling mlockall()

I am attaching a much simpler tar ball that demonstrates the difference bet=
ween xenomai-2.4.6.1 and xenomai-2.5.1 rt_cond_wait() function.  The differ=
ence is that in the new version of xenomai-2.5.1 the rt_cond_wait() functio=
n does wait for the condition for the specified timeout interval but when i=
t timesout it returns 0 and I have not been able to get it to return -ETIME=
DOUT.  The CanFestival timers_xeno task depends on the value of -ETIMEDOUT =
being returned when a timeout occurs.

--

John

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Friday, February 26, 2010 11:53 AM
To: Charlton, John
Cc: 'jan.kiszka@domain.hid'; xenomai@xenomai.org
Subject: Re: [Xenomai-help] mlockall error after calling mlockall()

Charlton, John wrote:
> I am attaching a simpler portion of the timer loop that demonstrates=20
> the problem.  As I said before the problem does not occur with
> xenomai-2.4.6.1/linux-2.6.27.7 but does occur with=20
> xenomai-2.5.1/linux-2.6.32.7.
>=20
> I had some problems applying your patch so I will let you know if I am=20
> able to do that.

But did you have the watchdog enabled with 2.4.6.1 ?

--=20
					    Gilles.

