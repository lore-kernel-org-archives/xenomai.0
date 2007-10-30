Message-ID: <4726FC9B.1070806@domain.hid>
Date: Tue, 30 Oct 2007 10:42:51 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4726513D.9020308@domain.hid>
In-Reply-To: <4726513D.9020308@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH] janitorial: remove i8253_lock conversion
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
Cc: adeos-main@gna.org

Jan Kiszka wrote:
> Unless I'm utterly wrong, there are practically only two use cases
> regarding the PIT: Either Linux has complete hold of it for clocksource
> and/or clockevent usage, or the RT domain takes it over, also
> completely. In both cases the RT domain does not need to use the
> i8253_lock (see Xenomai).

Ack.

 So let's remove the hunks that harden this
> lock for no good (upcoming 2.6.24 would otherwise require even
> _extended_ patching). Patch addresses i386, but this cleanup should be
> applicable to x86_64 likewise.
>

Our x86_64 port relies on having APIC+TSC, so we don't even care about
the PIT anyway.

Will merge, thanks.

> Jan
> 


-- 
Philippe.

