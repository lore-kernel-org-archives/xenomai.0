Message-ID: <476E6D11.7080408@domain.hid>
Date: Sun, 23 Dec 2007 15:13:37 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200712161158.20969.paul_c@domain.hid>
In-Reply-To: <200712161158.20969.paul_c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH] ipipe fix for PowerPC & SMP
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: adeos-main@gna.org

Paul wrote:
> Attached, a trivial patch to fix a compile time error when building an SMP 
> kernel for powerpc - I suspect this affects all patches for this 
> architecture, not just the current 2.6.21 & 2.6.23 releases.
> 

We don't support SMP platforms over 2.6.2[01]/powerpc, but this is
indeed applicable to 2.6.23. The funny thing is that GCC 4.2.0 for
powerpc64 does not seem to have any problem with this, and fortunately
generates the right offset out of a wrong expression...

Applied, thanks.

-- 
Philippe.

