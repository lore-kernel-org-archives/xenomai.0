From: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Subject: Re: [PATCH 0/4] net/tcp: Fix several bugs and allow rttcp to be built
Date: Tue, 06 Nov 2018 21:39:18 +0100
Message-ID: <19517852.ZZHjAC89BG@lenni>
In-Reply-To: <C2EC5BA46D13CD44B5915A8FEEB4C44EE54700F0@DDCEXCH.ddc-ny.com>
References: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
 <trinity-a484b3cc-c55e-4a1f-93b3-01027a957713-1541443052918@msvc-mesg-gmx022>
 <C2EC5BA46D13CD44B5915A8FEEB4C44EE54700F0@DDCEXCH.ddc-ny.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Pham, Phong" <phamp@ddc-web.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Hillman,
 Robert" <hillman@ddc-web.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Phong,

Pham, Phong wrote:
> Hi Sebastian,
>
> Your patch (fixing TCP flags endianness issue) does work.

Great, thanks for testing.

=2D-
Sebastian

> (I was
> under the impression to use tcp_flag_word and fix it in
> rt_tcp_set_flags() which I reported doesn't work earlier.)

> Phong.
>
> -----Original Message-----
> From: Sebastian Smolorz [mailto:Sebastian.Smolorz@gmx.de]
> Sent: Monday, November 05, 2018 10:38 AM
> To: Pham, Phong
> Cc: Jan Kiszka; Hillman, Robert; xenomai@xenomai.org
> Subject: Re: [PATCH 0/4] net/tcp: Fix several bugs and allow rttcp to
> be built

> Hi,
>
> Pham, Phong wrote:
>
> > Hi Sebastian,
> >
> >
> >
> > " Phong, can you test this on your machine?"
> > No the fix does not work.  It overwrites the window field.
>
>
> Did you try the patch I sent here?
>
> https://www.xenomai.org/pipermail/xenomai/2018-November/039831.html
>
> --
> Sebastian
> Notice: This e-mail and any files transmitted with it may contain Data
> Device Corporation's and its subsidiaries privileged and proprietary
> information. It is intended solely for the use of the individual or
> entity to whom it is addressed. If you are not the named recipient of
> this transmission, any disclosure, copying, distribution or reliance
> on the contents of this message is prohibited. If you received this
> e-mail in error, please destroy it and any attached files and notify
> me immediately.

> Click Here<http://www.ddc-web.com/Profile/EmailPrivacy.aspx> to view
> our privacy statement.





