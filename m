Message-ID: <b647ffbd0612210717u4b8f0505m65d01bc2824a144a@domain.hid>
Date: Thu, 21 Dec 2006 16:17:54 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Re: Re: Re: Re: Re: A fairly small rtnet/Xenomai
In-Reply-To: <12420573.1166713240349.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b647ffbd0612210509r7494454fqc820f83a4b1f8719@domain.hid>
	<15069404.1166690889417.JavaMail.ngmail@domain.hid>
	<458A4DE0.5030005@domain.hid>
	<2890274.1166696466862.JavaMail.ngmail@domain.hid>
	<16382545.1166699974895.JavaMail.ngmail@domain.hid>
	<1166700491.4936.5.camel@domain.hid>
	<25528819.1166701882755.JavaMail.ngmail@domain.hid>
	<13574091.1166708188484.JavaMail.ngmail@domain.hid>
	<1166710393.4960.13.camel@domain.hid>
	<12420573.1166713240349.JavaMail.ngmail@domain.hid>
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
Cc: Xenomai help <xenomai@xenomai.org>

On 21/12/06, M. Koehrer <mathias_koehrer@domain.hid> wrote:
>
> > - does the bug still occurs after the call to the system() routine has
> > been replaced by the following frag?
> >
> >     if (vfork() == 0)
> >             execlp("/bin/ls", "ls", "-l", NULL);
> >     else
> >             wait(NULL);
> >
> I have replaced the system() call by your code fragement. And yes, this works!
> No freeze!

Ok, could you let me know what happens if you use fork() instead of vfork()?

system() is the same thing : fork -> exec + but it also deals with signals.


-- 
Best regards,
Dmitry Adamushko

