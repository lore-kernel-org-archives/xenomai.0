Message-ID: <43FED3F5.2060608@domain.hid>
Date: Fri, 24 Feb 2006 10:37:57 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problems solved
References: <C0237ECB.24E3%steve@domain.hid>
In-Reply-To: <C0237ECB.24E3%steve@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Steven Seeger wrote:
> Well, I solved my problems by getting rid of the geode. On a 400 mhz celeron
> board, everything works great. My software used 100% of the CPU on the geode
> and locked up the Linux side when the stepper motor would run, but on the
> celeron it uses a negligible amount of the CPU. This is good for me to see
> that the problem isn't with my code probably, but bad that Xenomai seems to
> have issues on the Geode that RTAI/fusion did not.

Again, the only way to make your point here would be to run the latency test in 
user-space, disabling the periodic timing at configuration level (v2.1 only), and 
making sure that no SMI source is active. If the results actually show performance 
degradation on this board between v2.0 (which is based on the latest fusion code) 
and v2.1-rc3, then your conclusion would have more weight.

> 
> Just giving you all a heads up. The geode sucks anyway.
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

