Message-ID: <4BE9AB86.5040805@domain.hid>
Date: Tue, 11 May 2010 21:09:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100511142653.GA22374@domain.hid>
In-Reply-To: <20100511142653.GA22374@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Scheduling clarification/solution...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tschaeche IT-Services <services@domain.hid>
Cc: xenomai@xenomai.org

Tschaeche IT-Services wrote:
> Hi,
> 
> having done some tests and having read the thread
> https://mail.gna.org/public/xenomai-help/2010-04/msg00051.html 
> i got the following understanding:

You are summarizing stuff explained in Xenomai documentation:
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Life-with-Adeos-rev-B.pdf
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Native-API-Tour-rev-C.pdf
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai

To be consistent, when a task is scheduled by Xenomai scheduler, we say
it is in "primary mode", whereas when scheduled by Linux scheduler, we
say it is in "secondary mode". Since this is the terminology we chose,
you would probably better stick to it than using other terms.


> (...)
>    Linux/Posix calls. (on the other side Linux/Posix calls
>    does not control priority when in RT xenomai state).

I do not really understand what you mean. The priorities are fully
propagated between the two schedulers. If you call phtread_setschedparam
or sched_setscheduler, the priority should be propagated to a Xenomai
thread.

-- 
					    Gilles.

