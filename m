Message-ID: <459CC73B.1080402@domain.hid>
Date: Thu, 04 Jan 2007 10:22:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Support for 2.6.19
References: <459C3EB8.5DA080F6@domain.hid>
In-Reply-To: <459C3EB8.5DA080F6@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Detlef Vollmann <dv@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Detlef Vollmann wrote:
> Hello,
> 
> the x86 branch supports kernel 2.6.19, but the ARM branch only supports
> 2.6.15.  Is there a specific reason for this?
> Does anybody have a feeling what would be needed to be changed
> for 2.6.19 support?

I guess the reason is that it is some work that needs to be done. I had
ported from 2.6.15 to 2.6.17, it was a trivial task as far as I could
see, but never tried to port to 2.6.19. There were some architectural
changes in 2.6.19, I do not know about their impact on the ARM
architecture though.

-- 
                                                 Gilles Chanteperdrix

