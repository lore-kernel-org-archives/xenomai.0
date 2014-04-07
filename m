Message-ID: <534276FE.7000805@xenomai.org>
Date: Mon, 07 Apr 2014 11:59:26 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1396785025.43347.YahooMailNeo@web171602.mail.ir2.yahoo.com>
In-Reply-To: <1396785025.43347.YahooMailNeo@web171602.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Deadlock in CANCEL_RESTORE with
 CONFIG_XENO_ASYNC_CANCEL during thread suspension
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/06/2014 01:50 PM, Matthias Schneider wrote:
> Hi all,
>
> using xenomai-forge with mercury, when
> CONFIG_XENO_ASYNC_CANCEL is defined, CANCEL_RESTORE
> will include a call to backtrace_check(), which in turn
> will call backtrace_dump, which will take the
> mutex "__printlock".
>
> In case a thread gets suspended while holding that lock,
> the next call to CANCEL_RESTORE from whatever thread will
> cause a deadlock.

That's the price for using thread suspend/resume unsafe constructs, we 
never know at which location we will be preempting threads.

>
> Is there any way of getting around that?
>

We could block the notification signal when holding this internal lock. 
I'll have a look.

-- 
Philippe.

