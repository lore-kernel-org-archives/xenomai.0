Message-Id: <5963B18A-B0A0-4048-841F-F3A7F239588A@comcast.net>
From: Steven Seeger <steven.seeger@domain.hid>
In-Reply-To: <BE4E1CF0-48F4-42EF-9C19-A4A01F43A597@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Thu, 26 Mar 2009 13:28:15 -0400
References: <BE4E1CF0-48F4-42EF-9C19-A4A01F43A597@domain.hid>
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

I forgot to mention. In order to keep tsc as the clockdev I disabled  
the code in the kernel that removes it as the clocksource.

Steven

On Mar 26, 2009, at 1:25 PM, Steven Seeger wrote:

> Using TSC really dropped us down. I don't know wh\y the timekeeper
> says tsc is unstable. We ran our system for an 8 minute cycle and
> timed it with a stopwatch, and it was accurate to the second.
>
> On our test irq0 usage dropped from 19% to 13%. Thanks for the help,
> guys.
>
> Steven
>
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


