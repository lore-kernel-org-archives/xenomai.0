Message-ID: <49BE79E0.8030401@domain.hid>
Date: Mon, 16 Mar 2009 17:10:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5eecf1c50903160904oc5b34bcwb49ea3b7dbbbfe28@domain.hid>
In-Reply-To: <5eecf1c50903160904oc5b34bcwb49ea3b7dbbbfe28@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xeno-test output
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Salvatore De Astis <dev.rinux@domain.hid>
Cc: xenomai@xenomai.org

Salvatore De Astis wrote:
> Hi at all!
> I tested the xenomai performance with xeno-test but  the "in-kernel
> periodic task" test mode shows me negative latencies, why?
> I've attached the report.
> Do you take a look at file and tell me if there is something wrong in
> my configuration, please?

That is because Xenomai timer anticipates, usually to get an almost null
latency for user-space tasks. So, you get negative latencies in
kernel-space. Fortunately, you can choose this (fixed) anticipation with
/proc/xenomai/latency.

-- 
                                                 Gilles.

