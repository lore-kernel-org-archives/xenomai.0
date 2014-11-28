From: <dietmar.schindler@manroland-web.com>
Date: Fri, 28 Nov 2014 12:26:32 +0000
Message-ID: <208C6975C932E94F86239FEA59CCA632DCD4A13E@AUSMXMBX02.mrws.biz>
References: <54775097.30705@siemens.com> <20141127181823.GK7842@hermes>
 <547772AF.108@siemens.com> <20141127191438.GI24110@csclub.uwaterloo.ca>
 <20141127203400.GP7842@hermes> <54778CF6.6000909@siemens.com>
 <20141127231527.GC24076@hermes> <5478430B.9030602@siemens.com>
 <20141128095038.GA3832@hermes> <547846AC.6070204@siemens.com>
 <20141128101605.GC3832@hermes>
In-Reply-To: <20141128101605.GC3832@hermes>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] [pull] forge: Adjust default registry mount point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai@xenomai.org

> Von: Gilles Chanteperdrix
> Gesendet: Freitag, 28. November 2014 11:16
> ...
> In fact, the point is. Putting xenomai mount point under /mnt does
> not even break Debian. Because of the new standard, there is little
> chance for any Debian package to mount anything on /mnt or under
> /mnt.
>
> It is simply the local admin decision to decide to respect or not
> respect the standard. I have been using Debian since 1997 (up to
> back a few days, where I finally switched), and ALWAYS mounted
> things in /mnt subdirectories. And never had any problems with any
> Debian packages (and as I said, I seem to remember that some
> versions of the autofs packages had their mount points under /mnt,
> at any rate, the autofs mount points changed with debian versions,
> so, if you had them in one place and upgrading, it would have been a
> PIT to follow what Debian imposed).
>
> The standard changes the usage of /mnt, but does not provide a
> replacement. So, what we are left are choices among directories that
> are not specifically made for mounting things. I do not like that
> option.
>
> So yes, when using Xenomai, the user will have to accept to not
> follow the standard and create a /mnt/tmp directory for temporary
> mounts. But I suspect this is an issue nobody cares about, I mean,
> except you and Lennart.

I don't want to add fuel to the fire, but I also care about following (even=
 changing) standards. And I'm afraid I fail to see the problem with choosin=
g another temporary mount point. As you cited from http://www.tldp.org/LDP/=
Linux-Filesystem-Hierarchy/html/mnt.html in your message on 27.11.2014 23:5=
6:

  This directory [/mnt] must not be used by installation programs: a suitab=
le temporary
  directory not in use by the system must be used instead.

So, wouldn't using something like "/tmp/xenomai" conform to the new standar=
d as well as work on old systems?
--
Best regards,
Dietmar Schindler
________________________________
manroland web systems GmbH -- Managing Director: Joern Gosse
Registered Office: Augsburg -- Trade Register: AG Augsburg -- HRB-No.: 2681=
6 -- VAT: DE281389840

Confidentiality note:
This eMail and any files transmitted with it are confidential and intended =
solely for the use of the individual or entity to whom they are addressed. =
If you are not the intended recipient, you are hereby notified that any use=
 or dissemination of this communication is strictly prohibited. If you have=
 received this eMail in error, then please delete this eMail.

! Please consider your environmental responsibility before printing this eM=
ail !
________________________________

