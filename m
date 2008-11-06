Message-ID: <4913017F.3040001@domain.hid>
Date: Thu, 06 Nov 2008 15:38:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <843a47610811040527v582d1aa0oce35d4278b6c6af9@domain.hid>	<4910A0BD.8020808@domain.hid>	<843a47610811051556y3b73ae28gebcdf0eeb2a8b800@domain.hid>	<4912F652.3020608@domain.hid>
	<843a47610811060628o3c321bc4wce3e7223611b971@domain.hid>
In-Reply-To: <843a47610811060628o3c321bc4wce3e7223611b971@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Masking / Disabling the local timer interrupt
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Matthew Fornero <mfornero.lists@domain.hid>
Cc: xenomai@xenomai.org

Matthew Fornero wrote:
> A couple of follow ups:
> 
> 1). I have not been able to find the RT_INTR pointer associated with
> the local APIC timer interrupt-- is there some documentation on this?
> Basically, I would need something to pass to rt_intr_disable
> 
> 2). rt_intr_disable looks like it will disable the interrupt across
> all CPUs. Is there any way to disable the Xenomai local APIC timer
> handler on just a single CPU?

You do not need to send your mails twice, we receive your mails.

-- 
                                                 Gilles.

