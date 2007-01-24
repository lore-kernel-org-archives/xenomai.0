Message-ID: <b647ffbd0701240208r1db2372end68276616cbebd69@domain.hid>
Date: Wed, 24 Jan 2007 11:08:48 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] isolating unwanted mode switch
In-Reply-To: <200701231627.51851.jweber@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200701231448.35285.jweber@domain.hid>
	<b647ffbd0701231345n33a7ecafm879ca25bdedab2fe@domain.hid>
	<200701231627.51851.jweber@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 23/01/07, Jeff Weber <jweber@domain.hid> wrote:
> Dimitry:
> > ...
> > exceptions (CPU exceptions, e.g. page faults). I presume, you have
> > done mlockall(CURRENT | FUTURE), haven't you?
> Yes.  my Linux application follows this this model:
>
> main () {
>          mlockall(MCL_CURRENT | MCL_FUTURE);
>         rt_task_shadow( ... )  // become a realtime thread
>
>         // for N threads:
>                 rt_task_spawn( ... ) // fork off child RT thread
> }
>
> It is one of the child RT threads that encounters the SIGXCPU unwanted mode
> switch.  It this the correct way to call mlockall() ?

Looks ok. Just to avoid getting into the same trap twice. You don't
use system(), fork() or alike beasts in your code, do you?


> > Moreover, enable "Nucleus debugging support" in your kernel config. If
> > it's an exception indeed, you would see a message like :
> Will do.  I always stayed away from enabling XENO_OPT_DEBUG in the past
> because of the associated "scary" warning:
>         "... Do not switch this option on unless you really know what you
>         are doing."
> While I was reconfiguring my kernel, I came across the related config:
> XENO_OPT_DEBUG_QUEUES, which has even "scarier" warning:
>         "... It adds even more runtime
>         overhead then CONFIG_XENO_OPT_DEBUG, use with care."
>
> Is the  XENO_OPT_DEBUG_QUEUES option safe and useful to enable too?

None of them will blow your boards up (or at least, they were not
designed to act this way :) They are helpful in debugging of some -
primarily internal - issues but may provide some useful info in
general.

DEBUG_QUEUES enables additional debugging messages for various queue
operations, that's not something you need know.

On the other hand, the "switch to secondary mode..." message that is
enabled by XENO_OPT_DEBUG may give you an address where the exception
has been taken.


>
>         thanks,
>         Jeff
>

-- 
Best regards,
Dmitry Adamushko

