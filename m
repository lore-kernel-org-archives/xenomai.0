Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Jan 2008 10:24:51 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D376589@domain.hid>
In-Reply-To: <2ff1a98a0801150844l309d1368i945e7183aa5da807@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D376570@domain.hid>
	<2ff1a98a0801150827ka2070dfxd937209e57271b3f@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D37657B@slcmail.slc.mew.int>
	<2ff1a98a0801150844l309d1368i945e7183aa5da807@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] rms scheduling
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

> This is transparent, you do not have to care about that, provided that
> you use rt_timer_ns2ticks everywhere, things will work the same way in
> one-shot mode or periodic mode.

I didn't do this, of course. :) Oh well. It won't take too long.

> Since xenomai 2.4, each skin has its own timebase. Most skins do not
> have a service such as rt_timer_set_mode to set whether they will be
> periodic or one-shot, but their module accept a parameter.

I think there is a disconnect in Xenomai with regards to userspace
threading and applications. If I have two applications that use Xenomai
threads, it might be nice if they could each operate on a separate
timebase (xenomai running in one shot) but of course this could violate
RMS if the applications don't play nice.

Anyway, I have my answer. Thanks! BTW, any word on if your watchdog
patch will make it in to trunk? I have been using it with great success.

Steven=20

