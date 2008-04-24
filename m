MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18449.4281.679002.804576@domain.hid>
Date: Fri, 25 Apr 2008 00:59:05 +0200
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E646F2F@afsexc01.aurora.aero>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>
	<2ff1a98a0804230730t44382de9i813b23d235ece2e3@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F19@domain.hid>
	<18447.31623.723753.421351@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F1D@afsexc01.aurora.aero>
	<18447.43488.713144.166771@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F21@domain.hid>
	<18448.11276.526008.229326@domain.hid>
	<48103103.7020005@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F23@domain.hid>
	<2ff1a98a0804240730w36d69599q8ed98c1657365cb@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F2A@afsexc01.aurora.aero>
	<18448.49233.523862.911803@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F2F@afsexc01.aurora.aero>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] serial port overrun problem RT TASK geode
	latencies too high
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Karch, Joshua" <jkarch@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Karch, Joshua wrote:
 > Gilles,
 > 
 > The framebuffer support was added to the kernel, and magically the latency is now down to the 1300 range. I modprobed the timerbench module and so the number 1340 is the worst I've seen.   The next thing to do is to play around with the outb and SMI. I got to the point where I haven't found any errors in a two minute test.

1300 is still way too high. A normal latency is something less than
100us, probably even less than 50us. 

-- 


					    Gilles.

