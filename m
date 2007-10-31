Message-ID: <47285666.4080108@domain.hid>
Date: Wed, 31 Oct 2007 11:18:14 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E0172B790@domain.hid>
In-Reply-To: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E0172B790@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] xntbase_get_jiffies in user space?
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas Necker <thomas.necker@domain.hid>
Cc: xenomai@xenomai.org

Thomas Necker wrote:
> A few weeks ago I was asking about a global variable available that just
> counts the system ticks (for pSOS skin) and that could be read by the
> application. Philippe suggested xntbase_get_jiffies for that purpose.
> Now it seems to me that this function can only be called in kernel
> space. Is that correct? And if so, is there a way to get this
> information in user space? Basically I want to get rid of kernel code in
> this context completely if possible.
>

The pSOS skin supports tm_get() which converts the current count of
jiffies to calendar date and time, but this may not be handy for your
calculations.

The other option would be to extend this skin with a Xenomai-specific
syscall returning this value, in a similar way than tm_getm(), which
returns the TSC converted to nanoseconds.

> Thomas
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

