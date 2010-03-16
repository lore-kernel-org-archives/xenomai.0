Date: Tue, 16 Mar 2010 15:11:00 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <1268730959.27899.245.camel@domain.hid>
Message-ID: <alpine.DEB.1.10.1003161507040.29805@domain.hid>
References: <alpine.DEB.1.10.1003151439040.27204@domain.hid>
	<1268663424.27899.226.camel@domain.hid>
	<4B9E6312.6010109@domain.hid>
	<1268673002.27899.230.camel@domain.hid>
	<4B9E7520.8000107@domain.hid>
	<1268676605.27899.233.camel@domain.hid>
	<4B9E7949.5060606@domain.hid>
	<alpine.DEB.1.10.1003161001560.29063@domain.hid>
	<1268730959.27899.245.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] Problem throwing a C++ Exception on Blackfin
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

>> Even this is sufficient to trigger the problem: int main(){try{throw "foo";}catch(...){}};
> Still, you should try disabling CONFIG_IPIPE on your kernel to see
> whether this makes a difference on 2.6.28. If it does, then you may want

The problem appears even without CONFIG_IPIPE. It is somehow related to other activity and/or other tasks at the same time, but not specifically to realtime activity. On a fresh install of uClinux-dist-2009R1.1-RC4 with matching toolchain, the above little test can be run continously without problems in a loop, but will crash as soon as another telnet session to the board is started. Or it is run in gdb.

Anyway, this is not a problem with I-pipe/Xenomai/etc. ... I'll look for help at the more appriorate places. Thanks!

Greetings from Hamburg,
Kolja


