Message-ID: <4A49C46F.8010301@domain.hid>
Date: Tue, 30 Jun 2009 09:53:19 +0200
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
> 
> Is there any way to discern what exactly the problem is? This code
> was working on earlier versions of Xenomai (2.2) and did not generate
> an error on this instance of calling pthread_mutex_lock.

Either your mutex is not process-shared and you try to use it from a
different process (if that is the case, that is easy to know, you did
not call pthread_mutexattr_setpshared, and you try to access the mutex
from a different process, because you called fork after
pthread_mutex_init for instance, see
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Mixing_fork_with_Xenomai_POSIX_skin_services.
)

Or you are trying to lock the mutex from a thread which is not a Xenomai
thread (that is, a thread created with __real_pthread_create, or in some
part of the code where pthread_create is not wrapped with Xenomai POSIX
skin's compilation flags).

You do not tell us with what version of Xenomai you have the problem. If
this is 2.5-rc2, it is normal that you do not see your printks: the
mutexes fast path is now handled in user-space (so, now that you mention
it, I wonder if the pshared attribute works, so, you may have
pthread_mutex_lock which does not fail when it is handled in user-space,
and which fails when it has to go through kernel-space).


> This e-mail is confidential, the property of NDS Ltd and intended for
> the addressee only. Any dissemination, copying or distribution of
> this message or any attachments by anyone other than the intended
> recipient is strictly prohibited.

Please be informed that since you send this mail to a public mailing
list, we cannot fulfil these requirements in any other way than by
preventing you from posting to the list.

-- 
                                          Gilles


