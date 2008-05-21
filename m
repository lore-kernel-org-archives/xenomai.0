Message-ID: <2ff1a98a0805210733u39894a17tca5420ae8f7ce5ca@domain.hid>
Date: Wed, 21 May 2008 16:33:09 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2336.81.252.86.91.1211379896.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
	<2ff1a98a0805190532i2fdb4267qc4566d98ab8cd57@domain.hid>
	<2ff1a98a0805190557j743680d4sb7d9f5c8e97072e@domain.hid>
	<12036.62.39.72.60.1211212126.squirrel@domain.hid>
	<2ff1a98a0805190857s1ad98139h9abe63b743dda35@domain.hid>
	<5481.62.39.72.60.1211293804.squirrel@domain.hid>
	<18483.10408.141546.420660@domain.hid>
	<2336.81.252.86.91.1211379896.squirrel@domain.hid>
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org

On Wed, May 21, 2008 at 4:24 PM, Fabien MAHOT
<fabien.mahot@domain.hid> wrote:
> Hello,
>
> I tried your patch. Now, sem_wait() returns an Interrupt system call error
> when a time-out end signal arrives. That's good.
>
> But, with the same test program, the one which tests sem_wait(), my system
> crashes a while after the same_wait() call. (System freeze --> reboot)
> After sem_wait() call, there are a mutex unlock and a sleep calls, but I
> can't say if they are a problem with them :
> - With mutex unlock call and sleep call: the system crashes between these
> calls. (printf() calls)
> - If I cancel mutex unlock, the threads sleeps and the system is good.
> - If I add a sem_post() in the EndTimeOut handler, sem_wait wakes up the
> thread but the system crashes before or over mutex unlock processing.
>
> before your patch, with this program, i had sem_wait problem but no crash
> of the system.

I have debugged the sem_wait issue by running your program, unloading
and reloading xenomai posix skin module many times, without any crash
or any reboot.

It shows one thing: there is an issue crashing your platform. Have you
run the Xenomai testsuite to know if this is a general problem ?

-- 
 Gilles

