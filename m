MIME-Version: 1.0
Sender: peter.soetens@domain.hid
In-Reply-To: <4AC46376.9030902@domain.hid>
References: <4AC46376.9030902@domain.hid>
From: Peter Soetens <peter@domain.hid>
Date: Fri, 2 Oct 2009 13:39:41 +0200
Message-ID: <634c78ce0910020439n54f92f5dnc38d9ac96555932@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] XUM follow-up: known problems and wishes for
	RT-Socket-CAN
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Thu, Oct 1, 2009 at 10:08, Wolfgang Grandegger <wg@domain.hid> wrote:
> Hello,
>
> I also enjoyed a lot the XUM at Dresden and hope that it will be
> repeated regularly.
>
> During the meeting, I heard some complaints about RT-Socket-CAN (aka
> RTCAN) not working properly in the past. I might have missed some
> related emails, sorry. Are there still pending issues?

As discussed in the other thread, I believe one point being made is
that if you want to use select() on RTDM  file descriptors, you need
to use the Posix skin, or at least, the thread calling into select()
must be created using the Posix skin. This limits the use of RTDM and
every derivative driver, like rtcan.

I vaguely remember something about applications hanging at exit, but
this would also be related to native+rtdm. Steven Kauffmann can
probably sketch the situation better...

Peter

