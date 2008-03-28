Message-ID: <47ED5188.3010802@domain.hid>
Date: Fri, 28 Mar 2008 21:14:00 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20080328190310.GB9009@domain.hid>
In-Reply-To: <20080328190310.GB9009@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH][SOLO] add more warnings
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Robert Schwebel <r.schwebel@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Robert Schwebel wrote:
> Contrary to what one would assume, -Wall doesn't warn on everything. It
> turned out to add a few more options, like -Wsign-compare, -Wfloat-equal
> and -Wformat-security, which is what the patch below does.
> 
> When running with these options, we get the following warnings:
> 

It should be better now.

-- 
Philippe.

