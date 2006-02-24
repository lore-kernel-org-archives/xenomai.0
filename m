Date: Fri, 24 Feb 2006 05:57:40 -0800
Subject: Re: [Xenomai-help] problems solved
From: Steven Seeger <steve@domain.hid>
Message-ID: <C02450D4.24F7%steve@domain.hid>
In-Reply-To: <43FED3F5.2060608@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

> Again, the only way to make your point here would be to run the latency test
> in 
> user-space, disabling the periodic timing at configuration level (v2.1 only),
> and 
> making sure that no SMI source is active. If the results actually show
> performance 
> degradation on this board between v2.0 (which is based on the latest fusion
> code) 
> and v2.1-rc3, then your conclusion would have more weight.
> 

Didn't we already figure out that my geode board won't run the latency tests
because it doesn't support aperiodic mode? I get garbage data from the
latency teests. When I tried to disable periodic mode in configuration I get
an ENODEV on module insert.

Steven


