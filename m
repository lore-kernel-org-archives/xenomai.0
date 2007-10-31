Message-ID: <4728943F.8060405@domain.hid>
Date: Wed, 31 Oct 2007 15:42:07 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E0172B790@domain.hid>
	<47285666.4080108@domain.hid> <47285858.3030204@domain.hid>
	<E5E9C6CC7DC8844A8DA7A9EFE7B5350E0172BA3F@esealmw118.eemea.ericsson.se>
In-Reply-To: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E0172BA3F@esealmw118.eemea.ericsson.se>
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
>>> The other option would be to extend this skin with a 
>> Xenomai-specific 
>>> syscall returning this value, in a similar way than 
>> tm_getm(), which 
>>> returns the TSC converted to nanoseconds.
>>>
>> Like the attached patch does.
> 
> Thanks for the quick patch. It seems necessary to change the call
> ticks = xntbase_get_jiffies(&psos_tbase)
> to
> ticks = xntbase_get_jiffies(psos_tbase)

Ack.

> in syscall.c for the patch to work.
> Will this change become part of the regular Xenomai release?
>

Yes, this extension makes a lot of sense in the pSOS context.

-- 
Philippe.

