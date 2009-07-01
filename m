From: "Landau, Bracha" <BLandau@domain.hid>
Date: Wed, 1 Jul 2009 11:31:48 +0300
Message-ID: <065A7D06F7D4E546A18E80E08D066E181189FBC64C@ILMA1.IL.NDS.COM>
In-Reply-To: <4A49CA45.8000501@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

 Thanks.

The mutex failed in the function pse51_mutex_trylock_internal, in the follo=
wing section (the printk is mine):

#if XENO_DEBUG(POSIX)
        if (mutex->owningq !=3D pse51_kqueues(mutex->attr.pshared))
        {
                printk ("mutex->owningq\n");
                return EPERM;
        }
#endif /* XENO_DEBUG(POSIX) */

I have XENO_DEBUG defined.

What does this mean?

(BTW, nothing I can do about those footers.)

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Tuesday, June 30, 2009 11:18 AM
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

That is because the implementation of the pthread_mutex_lock service is in =
ksrc/skins/posix/syscall.c, and calls pse51_mutex_timedlock_break in ksrc/s=
kins/posix/mutex.c, pthread_mutex_lock implementation in ksrc/skins/posix/m=
utex.c is only for kernel-space users. We had to split this for correct han=
dling of Linux signals.

>
> Is there any way to discern what exactly the problem is? This code was
> working on earlier versions of Xenomai (2.2) and did not generate an
> error on this instance of calling pthread_mutex_lock.

Ok, I have checked, 2.2 already had the pshared attribute, so I think your =
issue is the other one (calling phtread_mutex services from non real-time t=
hreads). Or maybe some other undocumented reason, which you should find by =
adding printks... :-)


> This e-mail is confidential, the property of NDS Ltd and intended for
> the addressee only. Any dissemination, copying or distribution of this
> message or any attachments by anyone other than the intended recipient
> is strictly prohibited.

Did I tell you that I found these footers stupid?

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

