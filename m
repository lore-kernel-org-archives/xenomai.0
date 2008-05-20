Message-ID: <2ff1a98a0805200823w2694b107rf2bfd418ccda7ab8@domain.hid>
Date: Tue, 20 May 2008 17:23:50 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <5481.62.39.72.60.1211293804.squirrel@domain.hid>
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

On Tue, May 20, 2008 at 4:30 PM, Fabien MAHOT
<fabien.mahot@domain.hid> wrote:
> Thank you,
>
> I tried to use rt_fprintf(stderr) or rt_printf(), but there is no debug
> traces on my Screen. But when I used fprintf(stderr) or printf(), there is
> no problem, I ve got traces on my screen.
> Compilation is good, I don't know why it doesn't work.

Neither do I. I am not very familiar with rt_printf.

>
> I also checked the info->si_value.sival_ptr value and it is good.
>
> My StackWrite and StackRead functions don't need a mutex. There is no
> conflict between them.
>
> Otherwise, I decided to cancel the lock use in EndTimeOut and I use a
> semaphore to indicate the time-out end to TimeOut thread. But there is a
> bug.
> This test program explains it :
> When TimeOut thread starts a time-out and waits the associated semaphore
> (sem_wait()). When signal of time-out end arrives, TimeOut thread wakes up
> whereas there is no sem_post(), and sem_wait returns no error.

Could you check sem_wait return value (not just test if is negative)
as well as errno ?


> Result on the screen :
>
> Start of timeOut
> Wait of timeOut end
> End of timeOut thread
>
>
>
> The use of a semphore doesn't change my problem, I always have system crash.

Ok. I will run your test to see if I can reproduce the crash you observe.

-- 
 Gilles

