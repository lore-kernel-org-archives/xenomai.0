From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <13574091.1166708188484.JavaMail.ngmail@domain.hid>
References: <b647ffbd0612210509r7494454fqc820f83a4b1f8719@domain.hid>
	<b647ffbd0612210245p12227990j2584147720e95adc@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
	<13529671.1166621136153.JavaMail.ngmail@domain.hid>
	<15069404.1166690889417.JavaMail.ngmail@domain.hid>
	<458A4DE0.5030005@domain.hid>
	<2890274.1166696466862.JavaMail.ngmail@domain.hid>
	<16382545.1166699974895.JavaMail.ngmail@domain.hid>
	<1166700491.4936.5.camel@domain.hid>
	<25528819.1166701882755.JavaMail.ngmail@domain.hid>
	<13574091.1166708188484.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 15:13:13 +0100
Message-Id: <1166710393.4960.13.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Re: Re: Re: Re: A fairly small rtnet/Xenomai
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2006-12-21 at 14:36 +0100, M. Koehrer wrote:
> Hi all,
> 
> some more interesing measurements:
> 1) Even when I remove the printf() completely, the system freezes.
> My realtimetask is then
> static void realtimetask(void *arg)
> {
>     system("ls -l");
>     rt_task_sleep(1000000000ULL);
> 
> }
> 
> 2) When I replace the printf() by a gepid() the behaviour is the same.
> 
> 3) Jan, your application using the rt_task_shadow behaves the very same (it freezes)!
> 
> 4) A getpid() directly after system does not help - however, a printf at this position helps to
> prevent the freeze.
> 
> But now, I found one very interesting thing:
> When I rename my /lib/tls to /lib/tls.disabled, it works!!!!
> It seems to be (once more) a ugly thread local storage stuff.
> The ldd dependency of xeno_crash show libc and libpthread that are take from 
> /lib/tls/i686/cmov directory.
> Perhaps that could give a hint!

Please check the following assertions on your setup:

- does enabling the debug option for the Xenomai nucleus cause Xenomai
warnings to appear (messages about forced switches of the crashtest task
to secondary mode), even over 2.6.17 with the very same test code?

- does enabling CONFIG_DEBUG_SPINLOCK and CONFIG_DEBUG_SPINLOCK_SLEEP in
the kernel hacking section cause Linux warnings to appear while the test
code runs over 2.6.19, before the box crashes?

- does the bug still occurs after the call to the system() routine has
been replaced by the following frag?

    if (vfork() == 0)
            execlp("/bin/ls", "ls", "-l", NULL);
    else
            wait(NULL);

-- 
Philippe.



