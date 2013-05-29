Message-ID: <1369818659.61078.YahooMailNeo@web172202.mail.ir2.yahoo.com>
Date: Wed, 29 May 2013 10:10:59 +0100 (BST)
From: Franz Engel <franz_lambert_engel@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] kernel BUG at arch/x86/kernel/ipipe.c:593
Reply-To: Franz Engel <franz_lambert_engel@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I have a problem. I try to install a new system:
Ubuntu 12.04
Kernel 3.2.21
Xenomai 2.6.2
Ipipe ipipe-core-3.2.21-x86-5.patch

I build the non realtime kernel with the default settings and it works.
Then I patched the kernel and prepared it with the xenomai preperation-scri=
pt. No error. Then I installed the kernel. The system starts and i can see =
Unity for ca. 20 seconds. Then I get a kernel panic. It would be great if s=
omebody has an idea. Here is my config and the trace.
I have not so much experinces with traces. It looks like that the crash is =
triggerd by the line "BUG_ON(irq<0)" and this is made by the line "irq =3D =
__this_cpu_read(vector_irq[vector])". Could it be a problem with my dual co=
re system (I attach also the lspci and the cpuinfo). But exactly on this ha=
rdware my last xenomai kernel was working.
(my config is very dirty; but i want to clean them first after xenomai is w=
orking).


Thanks and regards,
=A0=A0=A0=A0 Franz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Config
Type: application/octet-stream
Size: 139200 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130529/4692ed0=
1/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: cpuinfo
Type: application/octet-stream
Size: 3328 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130529/4692ed0=
1/attachment-0001.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lspci
Type: application/octet-stream
Size: 2541 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130529/4692ed0=
1/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Trace
Type: application/octet-stream
Size: 8376 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130529/4692ed0=
1/attachment-0003.obj>
