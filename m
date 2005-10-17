Message-ID: <43538C34.7010802@domain.hid>
Date: Mon, 17 Oct 2005 13:34:12 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug-reminder] user/kernel space header deps
References: <43536E90.2050001@domain.hid>
In-Reply-To: <43536E90.2050001@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> just to avoid that this issue got lost during the migration to Xenomai:
> 
> It's still not possible to compile a C++ POSIX program with CFLAGS
> obtained via "xeno-config --posix-ldflags". This is due to the fact that
> low-level, C++-incompatible headers get included in that case. Moreover,
> the same scenarion works for native skin programs only by chance at the
> moment.
> 
> On the long term, a clear separation between types, defines, function
> prototypes, etc. needed for the user API on the one and for core
> compilation on the other side is required.
> 

Without duplicating definitions and ABI information, otherwise this would be an 
absolute nightmare. Suggestions welcome.

-- 

Philippe.

