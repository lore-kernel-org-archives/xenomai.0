Date: Sat, 11 Apr 2009 13:00:10 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <49E08F6F.8000604@domain.hid>
Message-ID: <Pine.LNX.4.64.0904111233180.32647@domain.hid>
References: <Pine.LNX.4.64.0904081243120.22300@domain.hid>
	<Pine.LNX.4.64.0904081659110.22300@domain.hid>
	<Pine.LNX.4.64.0904101250540.4820@domain.hid>
	<Pine.LNX.4.64.0904101708030.4820@domain.hid>
	<6C68EA7C-72E4-482D-917A-24C7C6DA31C9@domain.hid>
	<Pine.LNX.4.64.0904101729031.4820@domain.hid>
	<49E08F6F.8000604@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Running xeno-test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


On Sat, 11 Apr 2009, Gilles Chanteperdrix wrote:
>...
> So, in the mean time, you should not load the drivers and let xeno-test
> load them once at a time when needed.

Thanks. This did indeed resolve the problem, and allowed all of the
latency tests to run. Unfortunately the subsequent switchtest step
appears to have completely hung the PC, but that could be a memory
error, since I'm temporarily experimenting with Xenomai on an
8-year-old PC, and memtest86 occasionally flags a couple of marginal
bytes of RAM on this PC. I'll receive a new computer in a couple of
weeks.

Martin

