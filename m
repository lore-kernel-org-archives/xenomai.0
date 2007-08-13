Date: Mon, 13 Aug 2007 09:06:22 +0200 (CEST)
From: Klaas Gadeyne <klaas.gadeyne@domain.hid>
In-Reply-To: <46BC8074.3090104@domain.hid>
Message-ID: <Pine.LNX.4.64.0708130903220.14311@domain.hid>
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid> 
	<2ff1a98a0708090242k70178437y716b502ce338e0a6@domain.hid> 
	<46BAF956.5090401@domain.hid>
	<3535aae80708090909m57f10233rd317cc862f534702@domain.hid>
	<1186676576.4978.12.camel@domain.hid> <46BC1494.2010303@domain.hid> 
	<Pine.LNX.4.64.0708100951160.23969@domain.hid>
	<3535aae80708100805l526475ebt5e4ff54c92f7daab@domain.hid>
	<46BC8074.3090104@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] hard lock-up
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 10 Aug 2007, Jan Kiszka wrote:
[..]
> BTW, given that the SMI workaround is infunctional on your system: Do
> you get reasonable latencies ATM? It looked to me like the NMI watchdog
> might have triggered due to SMI-related delays.

We do get very reasonable latencies once the AGP functionality is
turned off (otherwise, latencies are pathetic).  Note that we haven't
sorted out whether the buggy behaviour and huge latencies are due to
the AGP bus in general or too the specific intel_something_els_here
driver.

Klaas

