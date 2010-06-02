Message-ID: <4C0636FC.5060301@domain.hid>
Date: Wed, 02 Jun 2010 12:48:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100601135005.GA5483@domain.hid>
	<1275402757.27918.151.camel@domain.hid>
	<20100601155403.GA8240@domain.hid>
	<4C053C51.4090903@domain.hid> <4C061823.70005@domain.hid>
	<1275470136.18250.16.camel@domain.hid>
	<4C06229F.3030403@domain.hid> <4C062327.5000101@domain.hid>
	<20100602101924.GA27248@domain.hid>
In-Reply-To: <20100602101924.GA27248@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Handling Linux Signals in primary domain context
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tschaeche IT-Services <services@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Tschaeche IT-Services wrote:
> Looking at your discussion, handling asynchronous Linux signals in a primary domain task
> is not a "must" (but would be nice) for Xenomai according to initiate the signal handling
> in secondary domain *immediately*.
> 
> Another solution might be, checking the state of the AMOK-task when Xenomai
> schedules the task for execution. If Linux-Signals are pending, force secondary
> domain switch. Thus, asynchronous Linux signals are handled at latest on
> primary domain scheduler activities - which would be sufficient for us...

As Philippe explained to you in the second answer you received to your
initial mail, that is impossible, because the function migrating threads
from primary to secondary mode can not be called at any time. This issue
is bugging us for some time, if that had worked, we would have
implemented it a long time ago.

-- 
					    Gilles.

