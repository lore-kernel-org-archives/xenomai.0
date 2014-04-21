Message-ID: <5355934D.8020105@xenomai.org>
Date: Mon, 21 Apr 2014 23:53:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1398115447.70510.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <53558E66.8090102@xenomai.org>
In-Reply-To: <53558E66.8090102@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] occasional EBADF in select() in notifier.c
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/21/2014 11:32 PM, Gilles Chanteperdrix wrote:
> On 04/21/2014 11:24 PM, Matthias Schneider wrote:
>> Still working on thread suspension in forge/mercury, I occasionally get a EBADF
>> of the select() call in notifier.c. I suspect that this is due to accessing a 
>> copy of the file descriptor list notifier_rset while one of the file descriptors 
>> is being closed. This seems to be due to concurrent access on the notifier_rset 
>> from notifier_sighandler() and notifier_destroy(). "notifier_lock" is held in 
>> notifier_lock(), but not when copying and invoking select in notifier_sighandler().
>> The EBADF leads to a "spurious notification" reporting and process termination -
>>  obviously, the thread suspension was not triggered.
>>
>> I can think of several ways of addressing this issue but I am not sure about 
>> side effects:
>> a) hold the "notifier_lock" mutex between copying the descriptor list and calling select
>> b) repeating the select() call in the case of EBADF
>>
>> Any ideas?
>>
>> Anyway, why is the select call necessary, isnt the file descriptor signaled via 
>> siginfo->si_fd, too?
> 
> I do not know this part of the code, but normally, when select is called
> for a closed descriptor, select will return with the descriptor
> readable, EOF is returned when reading the descriptor, which can then be
> closed. We had a bug report some time ago to implement this behaviour in
> xenomai posix skin (so for cobalt).

Obviously, if it is already closed, read will not return EOF, and there
is no need to close it again, I got all mixed up, sorry for the noise.

> 


-- 
                                                                Gilles.

