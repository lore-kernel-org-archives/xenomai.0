Message-ID: <4A49CA45.8000501@domain.hid>
Date: Tue, 30 Jun 2009 10:18:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <065A7D06F7D4E546A18E80E08D066E181189FBBFD4@domain.hid>
In-Reply-To: <065A7D06F7D4E546A18E80E08D066E181189FBBFD4@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_mutex_lock returns 1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Landau, Bracha wrote:
> Thanks for your help.
> 
> I tried to put in "printk"s in the kernel implementation of the
> xenomai pthread_mutex_lock, and it did not work. Neither did
> xnprintf. I did this in order to find out what is the exact cause of
> the error; generally adding printk's in the kernel implementation of
> functions did work, but on this one it didn't.

That is because the implementation of the pthread_mutex_lock service is
in ksrc/skins/posix/syscall.c, and calls pse51_mutex_timedlock_break in
ksrc/skins/posix/mutex.c, pthread_mutex_lock implementation in
ksrc/skins/posix/mutex.c is only for kernel-space users. We had to split
this for correct handling of Linux signals.

> 
> Is there any way to discern what exactly the problem is? This code
> was working on earlier versions of Xenomai (2.2) and did not generate
> an error on this instance of calling pthread_mutex_lock.

Ok, I have checked, 2.2 already had the pshared attribute, so I think
your issue is the other one (calling phtread_mutex services from non
real-time threads). Or maybe some other undocumented reason, which you
should find by adding printks... :-)


> This e-mail is confidential, the property of NDS Ltd and intended for
> the addressee only. Any dissemination, copying or distribution of
> this message or any attachments by anyone other than the intended
> recipient is strictly prohibited.

Did I tell you that I found these footers stupid?

-- 
                                          Gilles


