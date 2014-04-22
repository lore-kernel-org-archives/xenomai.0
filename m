Message-ID: <53566854.2040502@xenomai.org>
Date: Tue, 22 Apr 2014 15:02:12 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1398115447.70510.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <53561B23.6010104@xenomai.org>
 <1398163799.26874.YahooMailNeo@web171604.mail.ir2.yahoo.com>
In-Reply-To: <1398163799.26874.YahooMailNeo@web171604.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/22/2014 12:49 PM, Matthias Schneider wrote:
> ----- Original Message -----
>> From: Philippe Gerum <rpm@xenomai.org>
>> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <xenomai@xenomai.org>
>> Cc:
>> Sent: Tuesday, April 22, 2014 9:32 AM
>> Subject: Re: [Xenomai] occasional EBADF in select() in notifier.c
>>
>> On 04/21/2014 11:24 PM, Matthias Schneider wrote:
>>>    Still working on thread suspension in forge/mercury, I occasionally get a
>> EBADF
>>>    of the select() call in notifier.c. I suspect that this is due to accessing
>> a
>>>    copy of the file descriptor list notifier_rset while one of the file
>> descriptors
>>>    is being closed. This seems to be due to concurrent access on the
>> notifier_rset
>>>    from notifier_sighandler() and notifier_destroy().
>> "notifier_lock" is held in
>>>    notifier_lock(), but not when copying and invoking select in
>> notifier_sighandler().
>>>    The EBADF leads to a "spurious notification" reporting and
>> process termination -
>>>     obviously, the thread suspension was not triggered.
>>>
>>>    I can think of several ways of addressing this issue but I am not sure
>> about
>>>    side effects:
>>>    a) hold the "notifier_lock" mutex between copying the descriptor
>> list and calling select
>>
>> Not an option, we would need a threaded handler for grabbing the
>> mutex-based lock, which would defeat the purpose of using a directed
>> signal for forcing the recipient thread to stop execution until released.
>>
>
> Ok, I understand.
>
>>>    b) repeating the select() call in the case of EBADF
>>>
>>
>> EBADF should be ignored. This just means that we won't find the notifier
>> block in the scanned list anyway, which is a possible and correct outcome.
>
>
> I do not agree. EBADF only signals that any of the fds is invalid, but not necessarily the one the current thread is interested in. In the scenario being produced in my test, descriptor "A" was being signaled and "B" was closed, being the cause for EBADF. If I had ignored the error, I would have missed a notification for "A". Repeating the select call with a fresh copy of notifier_rset seemed to correctly retrieved the right entry.

This is what I implied: ignore the invalid fd causing EBADF, drop it 
from the poll mask and redo. We obviously don't want to miss other valid 
notifications.

>
>>
>>>    Any ideas?
>>>
>>>    Anyway, why is the select call necessary, isnt the file descriptor signaled
>> via
>>>    siginfo->si_fd, too?
>>>
>>
>> Yes it is. This select() loop is a left-over.
>
> So would this be a third variant, getting rid of select() and using si_fd?
>

Yes, we don't need to maintain the notifier_rset and the select loop. 
Just check for psfd[0] ==  siginfo->si_fd in loop for a match.

-- 
Philippe.

