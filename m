Message-ID: <50AE49ED.9020804@ruggedcom.com>
Date: Thu, 22 Nov 2012 10:51:09 -0500
From: Makarand Pradhan <makarandpradhan@ruggedcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: [Xenomai] Mutex enhancement for Auto relaxed threads
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Greetings,

I have a proposal for enhancing the process of locking a real-time mutex in=
 auto-relaxed Xenomai threads. It will  save a lot of CPU cycles in some sc=
enarios, and I would like to get your expert opinion about it (I have coded=
 the enhancement for native skin and changes are attached to this email).

Xenomai mutex is designed in such a way that trapping to the kernel is not =
needed.This is a very efficient design which saves a great deal of CPU cycl=
es.
However, there is an exception to this efficient behavior: if the Xenomai t=
hread is an auto-relaxed thread (i.e. running with priority 0), locking a m=
utex always traps to the kernel because the current implementation handles =
auto-relaxing upon exiting the system call.

Look at this scenario:

A Xenomai thread
1) locks a mutex (which is an OUTER mutex in this scenario)
2) then loops multiple times through some operation that requires locking a=
n unlocking some other mutex (INNER mutex)
3) unlocks the OUTER mutex

If the thread is a real-time thread, locking mutexes is done efficiently. I=
f the thread is auto-relaxed though, both OUTER and INNER mutexes cause tra=
pping to the kernel which is not really needed.
Please note that locking the OUTER mutex already moves the thread to the pr=
imary domain, so handling the INNER mutex could be done as if the thread wa=
s a real-time (non-auto-relaxed) thread.

Enhancements:
The mutex code was modified in such a way that priority 0 (auto-relaxed) th=
read will do a system call only once when grabbing and releasing the outter=
most mutex. The inner mutexes will not jump into the kernel. This change wo=
uld significantly save CPU cycles by using the user space fast mutexes when=
 the thread is not relaxed after grabbing the outtermost mutex.


I would highly appreciate your comments.

Best Regards,
Makarand
Software Engineer
RuggedCom Inc.
www.ruggedcom.com
300 Applewood Crescent
Concord, Ontario, L4K 5C7
Tel:  (905)482-4523
Fax: (905)856-1995





-- =

___________________________________________________________________________
NOTICE OF CONFIDENTIALITY:
This e-mail and any attachments may contain confidential and privileged inf=
ormation.  If you are
not the intended recipient, please notify the sender immediately by return =
e-mail and delete this
e-mail and any copies.  Any dissemination or use of this information by a p=
erson other than the
intended recipient is unauthorized and may be illegal.
_____________________________________________________________________

  =


-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: xenomai_changes
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20121122/fc104aa=
6/attachment.ksh>
