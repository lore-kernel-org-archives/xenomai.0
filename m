Message-ID: <4CE93407.6010702@domain.hid>
Date: Sun, 21 Nov 2010 16:00:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E2CAE7F7B064EA49B5CE7EE9A4BB167D14FF9E1190@domain.hid>
In-Reply-To: <E2CAE7F7B064EA49B5CE7EE9A4BB167D14FF9E1190@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] GUI Debugging tool for Linux
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Hemal C.Bavishi" <Hemal.Bavishi@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hemal C.Bavishi wrote:
> Dear All,
> 
> Do you have any idea of GUI C debugging tool for Linux works for
> Xenomai patch? I tried to use DDD (Data Display Debugger) but when I
> load my program compiled with xenomai kernel then it gives me an
> error "xenomai binding failed". I also tried to use other debugger
> program like GPS but I got almost similar issue(thread debugging
> using libthead_db enabled - program exited with code 01). Please
> help.

ddd is a gdb frontend. So, please try and load your program with gdb,
and show us the error message.

Telling us which version of xenomai, on which architecture, and whether
you are remote debugging would also help us reproduce the issue.


-- 
                                                                Gilles.

