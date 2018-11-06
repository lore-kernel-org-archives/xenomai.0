MIME-Version: 1.0
Message-ID: <trinity-2874bf98-ddbf-4e83-a13e-fac0159b7c7f-1541499106089@msvc-mesg-gmx021>
From: "Sebastian Smolorz" <Sebastian.Smolorz@gmx.de>
Subject: Re: [PATCH 0/4] net/tcp: Fix several bugs and allow rttcp to be built
Content-Type: text/plain; charset=UTF-8
Date: Tue, 6 Nov 2018 11:11:46 +0100
In-Reply-To: <trinity-a484b3cc-c55e-4a1f-93b3-01027a957713-1541443052918@msvc-mesg-gmx022>
References: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
 <C2EC5BA46D13CD44B5915A8FEEB4C44EE545BC96@DDCEXCH.ddc-ny.com>
 <62f6ce84-8672-c6d4-a1a2-d9bc996c9ef0@siemens.com>
 <4717946.93qni4ym1a@lenni>
 <C2EC5BA46D13CD44B5915A8FEEB4C44EE546DFAD@DDCEXCH.ddc-ny.com>
 <trinity-a484b3cc-c55e-4a1f-93b3-01027a957713-1541443052918@msvc-mesg-gmx022>
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Smolorz via Xenomai <xenomai@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "Hillman, Robert" <hillman@ddc-web.com>, "Pham, Phong" <phamp@ddc-web.com>, Jan Kiszka <jan.kiszka@siemens.com>

Hi Phong,

Sebastian Smolorz wrote:
> Pham, Phong wrote:
> > Hi Sebastian,
> >
> > " Phong, can you test this on your machine?"
> > No the fix does not work.  It overwrites the window field.
>
> Did you try the patch I sent here?
>
> https://www.xenomai.org/pipermail/xenomai/2018-November/039831.html

I have sent out a new patch series. You can fetch it and apply
it on top of master. This should also fix your problem of
receiving zero bytes although there was data sent.

=2D-
Sebastian

