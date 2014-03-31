Message-ID: <1396262085.387.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Date: Mon, 31 Mar 2014 11:34:45 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] EINTR in notifier.c (mercury)
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


still working on thread suspension in mercury, I noticed that some

threadobj_suspend() and threadobj_resume() calls seemed not to have the des=
ired

effect. Analyzing the issue, I found out that sometimes the read operations=
 on=A0
the pipe in notifier_wait() seem to return with EINTR, especially in=A0
heavily loaded systems. Restarting the read system call in that case made=
=A0
thread suspension a=A0lot more reliable in my case.

I have attached a patch adding loops to deal with the EINTR situation in all

read and write operations of notifier.c. =



Regards,
Matthias =

-------------- next part --------------
A non-text attachment was scrubbed...
Name: notifier.c.patch
Type: text/x-patch
Size: 1626 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140331/afc8f5a=
6/attachment.bin>
