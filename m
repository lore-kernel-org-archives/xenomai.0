From: Paul <paul_c@domain.hid>
Date: Tue, 6 Nov 2007 21:18:26 +0000
References: <47246784.8070402@domain.hid>
In-Reply-To: <47246784.8070402@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711062118.26925.paul_c@domain.hid>
Subject: Re: [Adeos-main] [PATCH] harden MTRR access
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: Philippe Gerum <rpm@xenomai.org>


Hi Jan

On Sunday 28 October 2007 10:42, Jan Kiszka wrote:
> Running Xenomai's latency test while firing up X not just points out
> once again long delays due to MTRR fiddling and wbinvd invocation - it
> simply locks up the box! The reason is that MTRR fiddling needs hard IRQ
> protection, which this patch introduces. Note: I focused on standard
> MTRR, skipping the legacy CPUs (and dead MTRR code).

Preliminary indications are that this fixes an intermittant & random lockup on 
my x86_64 build. Fortuitous that the same code is used for both i386 and 
x86_64 kernels ;)


Regards, Paul.

