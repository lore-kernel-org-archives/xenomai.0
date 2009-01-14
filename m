Message-ID: <496DEDBB.8000204@domain.hid>
Date: Wed, 14 Jan 2009 14:50:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <496DEB16.5060803@domain.hid>
In-Reply-To: <496DEB16.5060803@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Clock drift.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Gilles Chanteperdrix wrote:
> Hi,
> 
> I run clocktest on a system here, not running NTP, using
> CONFIG_GENERIC_CLOCKEVENT, with a systematic drift of 3us/s. How can
> this happen? Does it come from the error due to the multiply and shift
> used for tsc to/from ns conversions ?

What clocksource is used by Linux? Also tsc?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 26
Corporate Competence Center Embedded Linux

