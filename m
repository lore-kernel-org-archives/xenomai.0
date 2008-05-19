Message-ID: <2ff1a98a0805190857s1ad98139h9abe63b743dda35@domain.hid>
Date: Mon, 19 May 2008 17:57:36 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <12036.62.39.72.60.1211212126.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
	<2ff1a98a0805190532i2fdb4267qc4566d98ab8cd57@domain.hid>
	<2ff1a98a0805190557j743680d4sb7d9f5c8e97072e@domain.hid>
	<12036.62.39.72.60.1211212126.squirrel@domain.hid>
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

On Mon, May 19, 2008 at 5:48 PM, Fabien MAHOT
<fabien.mahot@domain.hid> wrote:
> Thanks a lot for your answer,
>
> I add a mutex in my StackWrite function. What happens when the EndTimeOut
> routine is in process and a new time-out signal occurs? The EndTimeOut
> processing finished ?

Actually locking a mutex in a signal handler is strictly forbiden. So,
you should implement EndTimeOut so that it does not lock any mutex
(implicitly or explicitly).

>
> I also add an external variable to the condition variable.
>
> I try to use rt_printf() instead of calling my Display function. The
> compilation is OK, but when I execute my test program, there is no trace
> on the screen (I use rt_printf() like printf()). (I ve got rtdk.h and
> librtdk.so)
> I would like to try with this function ...

Maybe what you want is rather rt_fprintf(stderr) ?

>
> In spite of these modifications, the system always crashes
>
> I am not running my program under X-window. I ve got a screen on the VGA
> port of my target.

As I told you, I think the crash is due to the value of
info->si_value.sival_ptr in EndTimeOut. Did you check this value ?

-- 
 Gilles

