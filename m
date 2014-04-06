References: <1396262085.387.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53395104.6050109@xenomai.org> <53396B31.1090903@xenomai.org>
 <5339AACA.4090807@xenomai.org>
Message-ID: <1396782702.1096.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Sun, 6 Apr 2014 12:11:42 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <5339AACA.4090807@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] EINTR in notifier.c (mercury)
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

> On Monday, March 31, 2014 7:50 PM, Gilles Chanteperdrix <gilles.chanteper=
drix@xenomai.org> wrote:

> > On 03/31/2014 03:18 PM, Philippe Gerum wrote:
>>  On 03/31/2014 01:27 PM, Gilles Chanteperdrix wrote:
>>>  On 03/31/2014 12:34 PM, Matthias Schneider wrote:
>>>>  Hi all,
>>>> =

>>>> =

>>>>  still working on thread suspension in mercury, I noticed that some
>>>>  threadobj_suspend() and threadobj_resume() calls seemed not to have=
=A0the desired
>>>>  effect. Analyzing the issue, I found out that sometimes the read oper=
ations on
>>>>  the pipe in notifier_wait() seem to return with EINTR, especially=A0in
>>>>  heavily loaded systems. Restarting the read system call in that case =
made
>>>>  thread suspension a lot more reliable in my case.
>>>> =

>>>>  I have attached a patch adding loops to deal with the EINTR situation=
 in all
>>> =

>>>  You can probably avoid testing for EINTR if all signal handlers are
>>>  registered with the SA_RESTART flag.
>>> =

>> =

>>  The app may not explicitly care for signals (granted, most would do, but
>>  we would then have to assume they do it right).
>> =

> =

> Yes, applications may want to use signals to interrupt a call to read =

> and voluntarily get EINTR anyway.
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 Gilles.


Please find attached a third version of my patch dealing with
EINTR syscalls. Note that I also stumbled over unexpected behavior
in threadobj_sleep and cancel_sync due to EINTRs. Considering that
mercury is using signals for user-space round-robin and thread
suspension, even without any application signals EINTR happens=A0
quite often.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: eintr_3.patch
Type: text/x-patch
Size: 3040 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140406/c4a1fe2=
0/attachment.bin>
