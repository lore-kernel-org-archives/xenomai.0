References: <1396262085.387.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53395104.6050109@xenomai.org> <53396B31.1090903@xenomai.org>
Message-ID: <1396287806.69716.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Date: Mon, 31 Mar 2014 18:43:26 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53396B31.1090903@xenomai.org>
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

> On Monday, March 31, 2014 3:17 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> > On 03/31/2014 01:27 PM, Gilles Chanteperdrix wrote:
>>  On 03/31/2014 12:34 PM, Matthias Schneider wrote:
>>>  Hi all,
>>> =

>>> =

>>>  still working on thread suspension in mercury, I noticed that some
>>> =

>>>  threadobj_suspend() and threadobj_resume() calls seemed not to have th=
e desired
>>> =

>>>  effect. Analyzing the issue, I found out that sometimes the read opera=
tions on
>>>  the pipe in notifier_wait() seem to return with EINTR, especially in
>>>  heavily loaded systems. Restarting the read system call in that case m=
ade
>>>  thread suspension a lot more reliable in my case.
>>> =

>>>  I have attached a patch adding loops to deal with the EINTR situation
>> =

>>  You can probably avoid testing for EINTR if all signal handlers are
>>  registered with the SA_RESTART flag.
>> =

> =

> The app may not explicitly care for signals (granted, most would do, but =

> we would then have to assume they do it right).
> =

> -- =

> Philippe.
> =


I do agree with Philippe, there are also=A0several xenomai signals register=
ed=A0
without SA_RESTART. I have attached an updated patch that should address=A0
all of Philippe's earlier points - including the incorrect loop (sorry
about that).

Regards,
Matthias
-------------- next part --------------
A non-text attachment was scrubbed...
Name: notifier_eintr_2.patch
Type: text/x-patch
Size: 1570 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140331/c8e1a96=
1/attachment.bin>
