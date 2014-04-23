References: <1396785025.43347.YahooMailNeo@web171602.mail.ir2.yahoo.com>
 <534276FE.7000805@xenomai.org>
 <1397673291.55013.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <5354F784.5060301@xenomai.org>
Message-ID: <1398275062.5884.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Date: Wed, 23 Apr 2014 18:44:22 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <5354F784.5060301@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

=0A=0A----- Original Message -----=0A> From: Philippe Gerum <rpm@xenomai.or=
g>=0A> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" =
<xenomai@xenomai.org>=0A> Cc: =0A> Sent: Monday, April 21, 2014 12:48 PM=0A=
> Subject: Re: [Xenomai] Deadlock in CANCEL_RESTORE with CONFIG_XENO_ASYNC_=
CANCEL during thread suspension=0A> =0A> On 04/16/2014 08:34 PM, Matthias S=
chneider wrote:=0A>>  ----- Original Message -----=0A>> =0A>>>  From: Phili=
ppe Gerum <rpm@xenomai.org>=0A>>>  To: Matthias Schneider <ma30002000@yahoo=
.de>; =0A> "xenomai@xenomai.org" <xenomai@xenomai.org>=0A>>>  Cc:=0A>>>  Se=
nt: Monday, April 7, 2014 11:59 AM=0A>>>  Subject: Re: [Xenomai] Deadlock i=
n CANCEL_RESTORE with =0A> CONFIG_XENO_ASYNC_CANCEL during thread suspensio=
n=0A>>> =0A>>>  On 04/06/2014 01:50 PM, Matthias Schneider wrote:=0A>>>> =
=A0  Hi all,=0A>>>> =0A>>>> =A0  using xenomai-forge with mercury, when=0A>=
>>> =A0  CONFIG_XENO_ASYNC_CANCEL is defined, CANCEL_RESTORE=0A>>>> =A0  wi=
ll include a call to backtrace_check(), which in turn=0A>>>> =A0  will call=
 backtrace_dump, which will take the=0A>>>> =A0  mutex "__printlock".=0A>>>=
> =0A>>>> =A0  In case a thread gets suspended while holding that lock,=0A>=
>>> =A0  the next call to CANCEL_RESTORE from whatever thread will=0A>>>> =
=A0  cause a deadlock.=0A>>> =0A>>>  That's the price for using thread susp=
end/resume unsafe constructs, =0A> we=0A>>>  never know at which location w=
e will be preempting threads.=0A>>> =0A>>> =0A>>>> =0A>>>> =A0  Is there an=
y way of getting around that?=0A>>>> =0A>>> =0A>>>  We could block the noti=
fication signal when holding this internal lock.=0A>>>  I'll have a look.=
=0A>>> =0A>>>  --=0A>>>  Philippe.=0A>>> =0A>> =0A>>  Would the enclosed pa=
tch be an acceptable solution to the problem? It seems =0A> to=0A>>  work q=
uite well in my case.=0A>> =0A> =0A> We need to block the notification sign=
al each time the printout =0A> serialization lock is acquired, not only whe=
n dumping a backtrace.=0A> =0A> It is also preferable not to assume any sig=
mask disposition when doing =0A> so, i.e. forcibly unblocking SIGNOTIFY may=
 prove dangerous in the =0A> future, depending on the call site.=0A> =0A> A=
lso, the code should work for both the mercury and cobalt cores.=0A> =0A> T=
he commit below should address these issues:=0A> =0A> http://git.xenomai.or=
g/xenomai-forge.git/commit/?h=3Dnext&id=3D9ba637cc7902cea15944a894443e22caf=
0c19139=0A> =0A> =0A> -- =0A> Philippe.=0A> =0A=0AI can confirm that the fi=
x is working - thanks for correcting my patch.=A0=0AIn general, thread susp=
ension on mercury seems to be working quite reliably=0Anow, I will let you =
know when/if I find another issue.=0A=0AMatthias

