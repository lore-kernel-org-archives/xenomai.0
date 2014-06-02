References: <1400788012.41259.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Message-ID: <1401734780.6508.YahooMailNeo@web171606.mail.ir2.yahoo.com>
Date: Mon, 2 Jun 2014 19:46:20 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <1400788012.41259.YahooMailNeo@web171603.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] FreeRTOS skin #2
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

----- Original Message -----

> From: Matthias Schneider <ma30002000@yahoo.de>
> To: "xenomai@xenomai.org" <xenomai@xenomai.org>
> Cc: =

> Sent: Thursday, May 22, 2014 9:46 PM
> Subject: [Xenomai] FreeRTOS skin #2
> =

> Hi all,
> =

> after having rework extensively the FreeRTOS skin patch I feel ready=A0
> for the second round of review comments. I hope no one will mind me=A0
> starting a new thread for discussing it. I have tried to address all=A0
> of the mentioned issues so far, plus many more.
> =

> Among them:
> =

> * reworked alignment macros
> * #define portLONG long
> * remapped error codes
> * reworked scheduler start and stop completely as suggested
> * reworked Scheduler.queued_task, .state and .num_tasks
> * added new (internal) scheduler state taskSCHEDULER_SUSPENDING
> * many other improvements and simplifications
> * only take tasklist_lock for short time
> =

> Like suggested, I have gone for the simpler implementation of the task=A0
> scheduler functionality and I added warnings and checks in case unsupport=
ed
> use cases are triggered (e.g. holding the scheduler lock on mp systems, e=
tc.)
> This still needs to be reflected in the docu.
> =

> I have not yet addressed the issues of=A0
> =

> * vPortEnterCritical()/vPortExitCritical()
> =A0 since they are used extensively in the demo code (which is completely=
=A0
> =A0 hardware independent), but this can still be easily adapted.
> =

> * starting thread priority inheritance (need to start a new=A0
> =A0 discussion thread)
> =

> * there is still a workaround for the cobalt priorities in the patch...
> =

> Regards,
> Matthias
> =

> p.s. Thank you a lot for your responsiveness addressing issues reported=
=A0
> by me, including all the refactoring that is making my life easier!


Please find enclosed a new version of the FreeRTOS skin. It adapts to the=
=A0
latest changes in forge/next and also removes the previously included=A0
workarounds - thanks to the changes done based on the first review round
they were no longer necessary.

Regards,
Matthias
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Initial-Freertos-commit-no.-3.patch.gz
Type: application/x-gzip
Size: 34384 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140602/7a47798=
6/attachment.bin>
