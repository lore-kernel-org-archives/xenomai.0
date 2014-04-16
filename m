References: <1396785025.43347.YahooMailNeo@web171602.mail.ir2.yahoo.com>
 <534276FE.7000805@xenomai.org>
Message-ID: <1397673291.55013.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Date: Wed, 16 Apr 2014 19:34:51 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <534276FE.7000805@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Deadlock in CANCEL_RESTORE with
	CONFIG_XENO_ASYNC_CANCEL during thread suspension
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

> Sent: Monday, April 7, 2014 11:59 AM
> Subject: Re: [Xenomai] Deadlock in CANCEL_RESTORE with CONFIG_XENO_ASYNC_=
CANCEL during thread suspension
> =

> On 04/06/2014 01:50 PM, Matthias Schneider wrote:
>>  Hi all,
>> =

>>  using xenomai-forge with mercury, when
>>  CONFIG_XENO_ASYNC_CANCEL is defined, CANCEL_RESTORE
>>  will include a call to backtrace_check(), which in turn
>>  will call backtrace_dump, which will take the
>>  mutex "__printlock".
>> =

>>  In case a thread gets suspended while holding that lock,
>>  the next call to CANCEL_RESTORE from whatever thread will
>>  cause a deadlock.
> =

> That's the price for using thread suspend/resume unsafe constructs, we =

> never know at which location we will be preempting threads.
> =

> =

>> =

>>  Is there any way of getting around that?
>> =

> =

> We could block the notification signal when holding this internal lock. =

> I'll have a look.
> =

> -- =

> Philippe.
> =


Would the enclosed patch be an acceptable solution to the problem? It seems=
 to=A0
work=A0quite well in my case.

Regards,
Matthias
-------------- next part --------------
A non-text attachment was scrubbed...
Name: backtrace_dump_block_signals.patch
Type: text/x-patch
Size: 1109 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140416/62286c1=
6/attachment.bin>
