Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 Jul 2008 12:20:40 +0200
Message-ID: <406CC9939904F143B9D42CEEA3E56E563AC08E@oab1mx1.oneaccess.intra>
References: <406CC9939904F143B9D42CEEA3E56E563AC067@domain.hid>
	<48918FF9.6030804@domain.hid>
From: "Filip Van Rillaer" <Filip.VanRillaer@domain.hid>
Subject: Re: [Xenomai-help] xnpipe EPOLLIN starvation
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
Cc: xenomai@xenomai.org

Hello Gilles,

EPOLLET is indeed enabled.
The first time EPOLLIN is received in the 2nd domain, I do a read (it
receives 1 byte in a buffer of 256).  So the read is exhausted and I
expect that the next time data arrives I should get the EPOLLIN (as it
BECOMES readable).  But even adding another read (which returns -EAGAIN)
did not make it possible to receive the EPOLLIN when a little bit later
data is written at the Xenomai side of the xnpipe.

Best regards,
Filip

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: 31 July 2008 12:12
To: Filip Van Rillaer
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] xnpipe EPOLLIN starvation

Filip Van Rillaer wrote:
> Hi,
> =20
> I am transferring data from the Xenomai domain to the 2nd domain with=20
> the xenomai pipe.  In the 2nd domain I am using the epoll interface to

> wait for the arrival of new data.  The first time that data are=20
> written in the pipe at the Xenomai side, the 2nd domain receives the=20
> EPOLLIN (an that's OK).  But the 2nd time data are written in the pipe

> at the Xenomai side, the 2nd domain is NOT receiving EPOLLIN and=20
> therefore dies forever.
> =20
> I am not familiar at all with the Xenomai internals, but I tried to=20
> gather some information: it look like when the first characters are=20
> written at the Xenomai side, the xnpipe_wakeup_proc calls=20
> xnpipe_dequeue_wait and this way it is removed forever from the=20
> waiters-queue.
> When I remove the "else"-instruction in xnpipe_poll so that=20
> xnpipe_wakeup_proc is called un-conditionally, then it works as=20
> expected ... however I have no idea if this patch is correct.  So
please comment.
> =20
> FYI:
> URL: http://svn.gna.org/svn/xenomai/trunk
> Repository Root: http://svn.gna.org/svn/xenomai Repository UUID:=20
> c6d672ea-8702-0410-b560-f74c916a59fe
> Revision: 4047

Are you sure you are not having a problem with "edge-triggered" versus
"level-triggered" notification ?
http://www.kegel.com/c10k.html#nb.edge
http://www.kegel.com/c10k.html#nb

--=20
                                                 Gilles.

