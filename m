From: jmf <xeno.nonono@domain.hid>
Date: Mon, 30 Aug 2010 23:18:26 +0000 (UTC)
Message-ID: <loom.20100831T011722-431@domain.hid>
References: <loom.20100830T183243-347@domain.hid>
	<4C7BED23.5050400@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How to resolve this lockup situation?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Maybe to clarify: the SDK of the said device comes with a shared lib
(whose function I'm calling from an RT thread) and that deamon which
is probably doing the communication with the usb device; with the old
setup where things were still working, I just didn't notice it's existence.
These two only come as binaries. So yes, my system has a serious flaw,
it's not RT. Before, the deamon obviously answered to the shared lib
function in a timely manner. Until we can redesign that system from
ground up and get rid of the non-RT compatible component, I'm just
concerned with getting the old status back. I don't understand what's
different, but is there any way to get Linux some processing time back?


