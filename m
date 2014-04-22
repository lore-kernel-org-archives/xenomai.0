References: <1398115447.70510.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <53561B23.6010104@xenomai.org> 
Message-ID: <1398163799.26874.YahooMailNeo@web171604.mail.ir2.yahoo.com>
Date: Tue, 22 Apr 2014 11:49:59 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53561B23.6010104@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

----- Original Message -----=0A> From: Philippe Gerum <rpm@xenomai.org>=0A>=
 To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <xenom=
ai@xenomai.org>=0A> Cc: =0A> Sent: Tuesday, April 22, 2014 9:32 AM=0A> Subj=
ect: Re: [Xenomai] occasional EBADF in select() in notifier.c=0A> =0A> On 0=
4/21/2014 11:24 PM, Matthias Schneider wrote:=0A>>=A0 Still working on thre=
ad suspension in forge/mercury, I occasionally get a =0A> EBADF=0A>>=A0 of =
the select() call in notifier.c. I suspect that this is due to accessing =
=0A> a=0A>>=A0 copy of the file descriptor list notifier_rset while one of =
the file =0A> descriptors=0A>>=A0 is being closed. This seems to be due to =
concurrent access on the =0A> notifier_rset=0A>>=A0 from notifier_sighandle=
r() and notifier_destroy(). =0A> "notifier_lock" is held in=0A>>=A0 notifie=
r_lock(), but not when copying and invoking select in =0A> notifier_sighand=
ler().=0A>>=A0 The EBADF leads to a "spurious notification" reporting and =
=0A> process termination -=0A>> =A0=A0 obviously, the thread suspension was=
 not triggered.=0A>> =0A>>=A0 I can think of several ways of addressing thi=
s issue but I am not sure =0A> about=0A>>=A0 side effects:=0A>>=A0 a) hold =
the "notifier_lock" mutex between copying the descriptor =0A> list and call=
ing select=0A> =0A> Not an option, we would need a threaded handler for gra=
bbing the =0A> mutex-based lock, which would defeat the purpose of using a =
directed =0A> signal for forcing the recipient thread to stop execution unt=
il released.=0A>=A0=0A=0AOk, I understand.=0A=0A>>=A0 b) repeating the sele=
ct() call in the case of EBADF=0A>> =0A> =0A> EBADF should be ignored. This=
 just means that we won't find the notifier =0A> block in the scanned list =
anyway, which is a possible and correct outcome.=0A=0A=0AI do not agree. EB=
ADF only signals that any of the fds is invalid, but not necessarily the on=
e the current thread is interested in.=A0In the scenario being produced in =
my test, descriptor "A" was being signaled and "B" was closed, being the ca=
use for EBADF. If I had ignored the error, I would have missed a notificati=
on for "A". Repeating the select call with a fresh copy of notifier_rset se=
emed to correctly retrieved the right entry.=0A=0A> =0A>>=A0 Any ideas?=0A>=
> =0A>>=A0 Anyway, why is the select call necessary, isnt the file descript=
or signaled =0A> via=0A>>=A0 siginfo->si_fd, too?=0A>> =0A> =0A> Yes it is.=
 This select() loop is a left-over.=0A=0ASo would this be a third variant, =
getting rid of select() and using si_fd?=0A=0A=0A> =0A>>=A0 Regards,=0A>>=
=A0 Matthias=0A> =0A> =0A> -- =0A> Philippe.=0A>

