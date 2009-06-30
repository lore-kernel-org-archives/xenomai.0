From: "Landau, Bracha" <BLandau@domain.hid>
Date: Tue, 30 Jun 2009 10:56:32 +0300
Message-ID: <065A7D06F7D4E546A18E80E08D066E181189FBC01D@ILMA1.IL.NDS.COM>
In-Reply-To: <4A49C46F.8010301@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] pthread_mutex_lock returns 1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

I'm using Xenomai version 2.4.

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Tuesday, June 30, 2009 10:53 AM
To: Landau, Bracha
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] pthread_mutex_lock returns 1

Landau, Bracha wrote:
> Thanks for your help.
>
> I tried to put in "printk"s in the kernel implementation of the
> xenomai pthread_mutex_lock, and it did not work. Neither did xnprintf.
> I did this in order to find out what is the exact cause of the error;
> generally adding printk's in the kernel implementation of functions
> did work, but on this one it didn't.
>
> Is there any way to discern what exactly the problem is? This code was
> working on earlier versions of Xenomai (2.2) and did not generate an
> error on this instance of calling pthread_mutex_lock.

Either your mutex is not process-shared and you try to use it from a differ=
ent process (if that is the case, that is easy to know, you did not call pt=
hread_mutexattr_setpshared, and you try to access the mutex from a differen=
t process, because you called fork after pthread_mutex_init for instance, s=
ee http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#M=
ixing_fork_with_Xenomai_POSIX_skin_services.
)

Or you are trying to lock the mutex from a thread which is not a Xenomai th=
read (that is, a thread created with __real_pthread_create, or in some part=
 of the code where pthread_create is not wrapped with Xenomai POSIX skin's =
compilation flags).

You do not tell us with what version of Xenomai you have the problem. If th=
is is 2.5-rc2, it is normal that you do not see your printks: the mutexes f=
ast path is now handled in user-space (so, now that you mention it, I wonde=
r if the pshared attribute works, so, you may have pthread_mutex_lock which=
 does not fail when it is handled in user-space, and which fails when it ha=
s to go through kernel-space).


> This e-mail is confidential, the property of NDS Ltd and intended for
> the addressee only. Any dissemination, copying or distribution of this
> message or any attachments by anyone other than the intended recipient
> is strictly prohibited.

Please be informed that since you send this mail to a public mailing list, =
we cannot fulfil these requirements in any other way than by preventing you=
 from posting to the list.

--
                                          Gilles


This e-mail is confidential, the property of NDS Ltd and intended for the a=
ddressee only. Any dissemination, copying or distribution of this message o=
r any attachments by anyone other than the intended recipient is strictly p=
rohibited. If you have received this message in error, please immediately n=
otify the postmaster@domain.hid and destroy the original message. Messages sen=
t to and from NDS may be monitored. NDS cannot guarantee any message delive=
ry method is secure or error-free. Information could be intercepted, corrup=
ted, lost, destroyed, arrive late or incomplete, or contain viruses. We do =
not accept responsibility for any errors or omissions in this message and/o=
r attachment that arise as a result of transmission. You should carry out y=
our own virus checks before opening any attachment. Any views or opinions p=
resented are solely those of the author and do not necessarily represent th=
ose of NDS.

To protect the environment please do not print this e-mail unless necessary=
.

NDS Limited Registered Office: One London Road, Staines,Middlesex TW18 4EX,=
 United Kingdom. A company registered in England and Wales Registered no. 3=
080780 VAT no. GB 603 8808 40-00

