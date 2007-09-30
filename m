From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46FF81BA.1020506@domain.hid>
References: <46F9167F.20008@domain.hid> <1190756271.26427.0.camel@domain.hid>
	<46FA26ED.4070505@domain.hid>  <46FF78DF.7090104@domain.hid>
	<1191149545.5989.7.camel@domain.hid>  <46FF81BA.1020506@domain.hid>
Content-Type: text/plain
Date: Sun, 30 Sep 2007 21:52:09 +0200
Message-Id: <1191181929.5989.33.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Non-APIC setup broken for 2.4-SVN?
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2007-09-30 at 13:00 +0200, Jan Kiszka wrote:
> > Do you work with 2.6.22 baseline, or the latest stable update?
> 
> 2.6.22.7 and .23-rc8. Both hang hard when I play with the backlight
> keys
> of my Fujitsu-Siemens Lifebook,

Hey, shameless plug, you have been caught. :o)

> > Grmff... Do you run with your smp_processor_id() instrumentation in?
> 
> Yes, but I suspect this is just a symptom of some severe memory
> corruption that (also?) hits I-pipe data structures.

Unlikely, but a timing-dependent issue may explain this behaviour as
well.

>  I just put in some
> different instrumentation, and that warning is gone, the box just
> hangs
> hard at a different point. Very unfriendly.
> 
> Jan
> 
-- 
Philippe.



