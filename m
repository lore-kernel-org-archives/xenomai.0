Message-ID: <49CBBBF2.1010204@domain.hid>
Date: Thu, 26 Mar 2009 18:31:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BE4E1CF0-48F4-42EF-9C19-A4A01F43A597@domain.hid>
	<5963B18A-B0A0-4048-841F-F3A7F239588A@comcast.net>
In-Reply-To: <5963B18A-B0A0-4048-841F-F3A7F239588A@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] irq0 usage
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Seeger <steven.seeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> I forgot to mention. In order to keep tsc as the clockdev I disabled  
> the code in the kernel that removes it as the clocksource.

Even when idle=poll or nohlt the kernel disables the tsc as clocksource ?
Also note that Xenomai does not care if Linux uses the tsc as
clocksource or not to use the tsc.

-- 
                                                 Gilles.

