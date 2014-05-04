Message-ID: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Date: Sun, 4 May 2014 17:59:10 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] FreeRTOS skin
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

Hi all,

please find enclosed a patch with a FreeRTOS skin for xenomai-forge I have=
=A0
been =A0working on for some time. I would like to get some feedback and adv=
ice
what still needs to be done to get it accepted in Xenomai. There is a set o=
f=A0
unit tests included and the possibility to download the original FreeRTOS p=
ackage=A0
in order to run most of its (platform independent) test suite. Until now I =
have=A0
been working under mercury only. Documentation is available in form of a RE=
ADME=A0
file in lib/freertos/README, which should also be a good starting point. I =
have=A0
not attached "configure" to the patch, so you will need to recreate the con=
figure=A0
script first before actually running it. You can apply the patch via

git am --keep-cr < 0001-Initial-Freertos-commit.patch
autoreconf
./configure
make

Running the testcases, you might stumble over a
#0 =A0EINVAL in threadobj_unlock_sched(), threadobj.c:59
error, which is due to=A0
http://www.xenomai.org/pipermail/xenomai/2014-May/030821.html
I will try to continue the discussion there.

I do not consider the patch 100% finished yet and I am still working on fol=
lowing topics:

* more testing =A0
=A0 * "vStartDynamicPriorityTasks" is not yet passing
=A0 * "vCreateBlockTimeTasks"/"vCreateAltBlockTimeTasks" seem to fail somet=
imes
=A0 * it has been ages since I ran the vfile system tests.
=A0 * testing with optimization

* test under cobalt (not started yet, still need to get a working setup)
* portBYTE_ALIGNMENT define
* some refactoring (mostly in task.c)

I am publishing this patch already now since I do not want to "finish" it f=
irst
before the first review only to find out I have overlooked something that=
=A0
should have been done differently. Some points to start a discussion are ma=
ybe:

* what kind of documentation is still missing

* correct placement of CANCEL_DEFER and CANCEL_RESTORE

* priority of new threads during prologue (will start conversation based on
http://www.xenomai.org/pipermail/xenomai/2014-February/030117.html
)

I am doing this in my free time, so please be patient when I am not respond=
ing=A0
right away...

Regards,

Matthias
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Initial-Freertos-commit.patch.gz
Type: application/x-gzip
Size: 34769 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140504/ed4fc48=
3/attachment.bin>
