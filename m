References: <1398115447.70510.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <53561B23.6010104@xenomai.org>
 <1398163799.26874.YahooMailNeo@web171604.mail.ir2.yahoo.com>
 <53566854.2040502@xenomai.org>
Message-ID: <1398189653.17723.YahooMailNeo@web171602.mail.ir2.yahoo.com>
Date: Tue, 22 Apr 2014 19:00:53 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53566854.2040502@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] occasional EBADF in select() in notifier.c
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>



----- Original Message -----
> From: Philippe Gerum <rpm@xenomai.org>
> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <xeno=
mai@xenomai.org>
> Cc: =

> Sent: Tuesday, April 22, 2014 3:02 PM
> Subject: Re: [Xenomai] occasional EBADF in select() in notifier.c
> =

> On 04/22/2014 12:49 PM, Matthias Schneider wrote:
>>  ----- Original Message -----
>>>  From: Philippe Gerum <rpm@xenomai.org>
>>>  To: Matthias Schneider <ma30002000@yahoo.de>; =

> "xenomai@xenomai.org" <xenomai@xenomai.org>
>>>  Cc:
>>>  Sent: Tuesday, April 22, 2014 9:32 AM
>>>  Subject: Re: [Xenomai] occasional EBADF in select() in notifier.c
>>> =

>>>  On 04/21/2014 11:24 PM, Matthias Schneider wrote:
>>>> =A0 =A0 Still working on thread suspension in forge/mercury, I =

> occasionally get a
>>>  EBADF
>>>> =A0 =A0 of the select() call in notifier.c. I suspect that this is due =

> to accessing
>>>  a
>>>> =A0 =A0 copy of the file descriptor list notifier_rset while one of th=
e =

> file
>>>  descriptors
>>>> =A0 =A0 is being closed. This seems to be due to concurrent access on =

> the
>>>  notifier_rset
>>>> =A0 =A0 from notifier_sighandler() and notifier_destroy().
>>>  "notifier_lock" is held in
>>>> =A0 =A0 notifier_lock(), but not when copying and invoking select in
>>>  notifier_sighandler().
>>>> =A0 =A0 The EBADF leads to a "spurious notification" reporting =

> and
>>>  process termination -
>>>> =A0 =A0  obviously, the thread suspension was not triggered.
>>>> =

>>>> =A0 =A0 I can think of several ways of addressing this issue but I am =

> not sure
>>>  about
>>>> =A0 =A0 side effects:
>>>> =A0 =A0 a) hold the "notifier_lock" mutex between copying the =

> descriptor
>>>  list and calling select
>>> =

>>>  Not an option, we would need a threaded handler for grabbing the
>>>  mutex-based lock, which would defeat the purpose of using a directed
>>>  signal for forcing the recipient thread to stop execution until =

> released.
>>> =

>> =

>>  Ok, I understand.
>> =

>>>> =A0 =A0 b) repeating the select() call in the case of EBADF
>>>> =

>>> =

>>>  EBADF should be ignored. This just means that we won't find the =

> notifier
>>>  block in the scanned list anyway, which is a possible and correct =

> outcome.
>> =

>> =

>>  I do not agree. EBADF only signals that any of the fds is invalid, but =
not =

> necessarily the one the current thread is interested in. In the scenario =
being =

> produced in my test, descriptor "A" was being signaled and =

> "B" was closed, being the cause for EBADF. If I had ignored the error, =

> I would have missed a notification for "A". Repeating the select call =

> with a fresh copy of notifier_rset seemed to correctly retrieved the righ=
t =

> entry.
> =

> This is what I implied: ignore the invalid fd causing EBADF, drop it =

> from the poll mask and redo. We obviously don't want to miss other valid =

> notifications.
>=A0

Ok, sorry I got you wrong.

>> =

>>> =

>>>> =A0 =A0 Any ideas?
>>>> =

>>>> =A0 =A0 Anyway, why is the select call necessary, isnt the file =

> descriptor signaled
>>>  via
>>>> =A0 =A0 siginfo->si_fd, too?
>>>> =

>>> =

>>>  Yes it is. This select() loop is a left-over.
>> =

>>  So would this be a third variant, getting rid of select() and using si_=
fd?
>> =

> =

> Yes, we don't need to maintain the notifier_rset and the select loop. =

> Just check for psfd[0] =3D=3D=A0 siginfo->si_fd in loop for a match.
> =

> =

> -- =

> Philippe.
> =



Considering the three options I think I prefer the last one and remove the
select() altogether. I have attached a small patch that does exactly that.

Matthias
-------------- next part --------------
A non-text attachment was scrubbed...
Name: notifier_without_select.patch
Type: text/x-patch
Size: 1812 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140422/7412edc=
d/attachment.bin>
