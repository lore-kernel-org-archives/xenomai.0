From: Matthias Fuchs <matthias.fuchs@domain.hid>
Subject: Re: [Xenomai-core] No hardware interrupts with xenomai on ppc405
Date: Tue, 12 Sep 2006 09:32:19 +0200
References: <4503EB88.2040309@domain.hid>
	<200609111904.16512.matthias.fuchs@domain.hid>
	<4505A75B.8000601@domain.hid>
In-Reply-To: <4505A75B.8000601@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609120932.20196.matthias.fuchs@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Monday 11 September 2006 20:13, Wolfgang Grandegger wrote:
> 
> In 2.6 the interrupts are disabled by default. Then the attached patch 
> for Xenomai should help.
> 
> Wolfgang.
> 
Your patch also works fine. Now what's the recommended solution? I noticed 
that Philippe already checked in an Adeos fix.

Matthias

