Message-ID: <4B1FE230.8070702@domain.hid>
Date: Wed, 09 Dec 2009 18:45:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <843773D242212C4882D4EDFFBF665F7F0155A93A9D@FW-SBS.fw.local>
In-Reply-To: <843773D242212C4882D4EDFFBF665F7F0155A93A9D@FW-SBS.fw.local>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai scheduling while atomic bug--debugging
 parameters
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Josh Karch <JKarch@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Josh Karch wrote:
> parameters and see if that resolves the problem:  Any ideas on
> whether that issue was addressed in 2.4.10?

Looking a the thread you show us, the user which had the original
problem seem not to have sent any further data, so chances are that the
issue was not addressed.

The data we are interested in are:
- better stack traces (frame pointer are possibly disabled in your
kernel, it would probably be better if you enabled them)
- kernel configuration
- a run with all xenomai and I-pipe debug options enabled

TIA.

-- 
                                          Gilles


