From: "=?iso-8859-1?Q?Hans_S=F8ndergaard_(HSO)?=" <HSO@VIAUC.DK>
Date: Thu, 11 Dec 2008 17:32:07 +0100
Message-ID: <2220D86D21B55040AB683933DBD97B5A2B086A2E96@domain.hid>
References: <0B45E93C5FF65740AEAE690BF3848B7AD3849E@rennsmail04.eu.thmulti.com>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7AD3849E@rennsmail04.eu.thmulti.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_heap_create problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Thank you for your proposal for /dev/rtheap missing.

It guided me to [Xenomai-help] February 20, 2006, where Philippe suggested =
this command:
        mknod /dev/rtheap c 10 254

Now it works.

Regards
Hans So

-----Original Message-----
From: Fillod Stephane [mailto:stephane.fillod@domain.hid]
Sent: 11. december 2008 16:08
To: Hans S=F8ndergaard (HSO); xenomai@xenomai.org
Subject: RE: [Xenomai-help] rt_heap_create problem

Hans S=F8ndergaard (HSO) wrote:
> I use Xenimai 2.4.3 and Linux 2.6.24 on an AT91SAM9260 processor based on=
 ARM926EJ-S.
> My problem is that the code snippet below gives an error -2.

What does mean error -2 ?  Isn't it ENOENT /* No such file or directory */ =
?

A rough guess would lead to /dev/rtheap missing. Can you check?
You may also make use of strace to get more clues.

Regards
--
Stephane


