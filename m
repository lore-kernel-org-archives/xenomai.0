Message-ID: <47777A80.6000507@domain.hid>
Date: Sun, 30 Dec 2007 12:01:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4776D498.4000802@domain.hid>
In-Reply-To: <4776D498.4000802@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH 5/5] consolidate common 32/64-bit code
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Long patch, short summary: removes more than 700 LOC by pushing common
> code in commonly used files. Specifically, there is now only
> arch/x86/ipipe.c again.
> 

Given that much code is moved around, this needs to be merged asap
before we attempt to bring more updates in. At first sight, this patch
does not introduce the IRQ trampoline changes, so it's probably a
no-brainer.

-- 
Philippe.


