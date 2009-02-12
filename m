Message-ID: <499480EE.3040403@domain.hid>
Date: Thu, 12 Feb 2009 21:05:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7ed3bc8b0902120904r800de72q97e694001600051e@domain.hid>
In-Reply-To: <7ed3bc8b0902120904r800de72q97e694001600051e@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Known-to-work motherboards?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stuart O Anderson <soa@domain.hid>
Cc: xenomai@xenomai.org

Stuart O Anderson wrote:
> Hello -
> 
> Is there a list of recent motherboards that are known to play nicely
> with Xenomai?  I've run into problems with some machines (USB host
> drops out, SATA doesn't work, etc) we have in the lab.  I've been able
> to work around these problems in most cases.

As answered to the questions you initially asked on this list, the only
known needed workaround is to disable MSI interrupts (I do not even know
if it is still needed). So, if you have other problems, we would be glad
to know it, because we like to think that when a kernel configuration
works with Linux, it works when enabling Xenomai. So, any motherboard
which works with Linux is supposed to work with Xenomai.

> If there isn't a list online that I've missed, is anyone running
> xenomai on a relatively recent machine with 8 or more cores without
> problems?  If so, can you provide hardware specs?

Xenomai will have scalability problems when running on an 8 cores system
(if you intend to run real-time tasks on each of the 8 cores).

-- 
					    Gilles.

