From: "Landau, Bracha" <BLandau@domain.hid>
Date: Tue, 30 Jun 2009 10:24:36 +0300
Message-ID: <065A7D06F7D4E546A18E80E08D066E181189FBBFD4@domain.hid>
In-Reply-To: <4A48D072.5040400@domain.hid>
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

Thanks for your help.

I tried to put in "printk"s in the kernel implementation of the xenomai pth=
read_mutex_lock, and it did not work. Neither did xnprintf. I did this in o=
rder to find out what is the exact cause of the error; generally adding pri=
ntk's in the kernel implementation of functions did work, but on this one i=
t didn't.

Is there any way to discern what exactly the problem is? This code was work=
ing on earlier versions of Xenomai (2.2) and did not generate an error on t=
his instance of calling pthread_mutex_lock.

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Monday, June 29, 2009 5:32 PM
To: Landau, Bracha
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] pthread_mutex_lock returns 1

Landau, Bracha wrote:
> I have a xenomai-based application basically working on my mpc8272
> based board. pthread_mutex_lock generally works (and returns zero),
> but in some cases returns 1 (yes, positive, not negative) which is an
> unknown error.
> Any idea why this may be happening?

1 is not an unknown error, it is EPERM. And the POSIX spec mandates that er=
rors returned by pthread_* services are the error status. They are not stor=
ed in errno. This is even documented in Xenomai pthread_mutex_lock
documentation:

Returns:
    0 on success

    an error number if:

        * EPERM, the caller context is invalid;
        (...)
        * EPERM, the mutex is not process-shared and does not belong to the=
 current process;

(...)
Valid contexts:

        * Xenomai kernel-space thread;
        * Xenomai user-space thread (switches to primary mode).

I use the following script to convert back and forth between libc errors an=
d their value:

#! /bin/sh

sed  "s,#define\t\(.*\b$1\b.*\)/\*\(.*\)\*/,\1\2,;t;d" /usr/include/asm*/er=
rno*



> ----------------------------------------------------------------------
> -- This e-mail is confidential, the property of NDS Ltd and intended
> for the addressee only. Any dissemination, copying or distribution of
> this message or any attachments by anyone other than the intended
> recipient is strictly prohibited.

If this message is confidential, why do you send it to a public mailing lis=
t in the first place? Should we unsubscribe you from the mailing list to pr=
eserve your confidentiality?

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

