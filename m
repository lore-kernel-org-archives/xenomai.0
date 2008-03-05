Message-ID: <47CE9A92.10206@domain.hid>
Date: Wed, 05 Mar 2008 14:05:22 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0803041734290.26008@domain.hid>
	<47CE8544.9070800@domain.hid>
	<Pine.LNX.4.64.0803051337420.394@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0803051337420.394@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Shared IRQ issue with Xeno Peak PCI CAN driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Cc: xenomai@xenomai.org

Klaas Gadeyne wrote:
> On Wed, 5 Mar 2008, Wolfgang Grandegger wrote:
>> Klaas Gadeyne wrote:
>>> Hi,
>>>
>>> we're having a problem finding a non-shared IRQ for a PEAK systems can
>>> board in a particular industrial SBC with PCI backplane [*].
>>> Loading the xeno_can_peak_pci driver fails due to a "so-called" IRQ
>>> conflict. (see below)
>>>
>>> However, it seems the IRQ (12) is not assigned, so this shouldn't be a
>>> problem [**]?
> 
> [...]
>>> Any hints on how to debug this?  We've already tried everything
>>> described in the FAQ (I guess), but we don't understand there's a
>>> conflict even if nothing is listed in /proc/interrupts?
>>
>> There are two CAN controllers on the card, right? Therefore you need
>> support for shared interrupts. Actually, requesting the IRQ 12 for the
>> second CAN controller fails because it's already used by the first one.
> 
> Thx! (we've just found out ourselves that the difference in behaviour
> between the 2 pc's was indeed due to different xenomai versions
> (<http://svn.gna.org/viewcvs/xenomai?rev=3291&view=rev>).

Well, yes. Since commit 3291

http://svn.gna.org/viewcvs/xenomai?rev=3291&view=rev

the driver does not tolerate that failure any more. Do you prefer the
old behavior (ignoring the failure and using just the first channel)?

Wolfgang.

