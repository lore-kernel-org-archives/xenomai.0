MIME-Version: 1.0
In-Reply-To: <200905041409.01179.smolorz@domain.hid>
References: <ff1d78710905040459u56772812kb95fb6083a2ee0c5@domain.hid>
	<200905041409.01179.smolorz@domain.hid>
Date: Mon, 4 May 2009 15:30:38 +0200
Message-ID: <ff1d78710905040630r754df1ffme2f56f51fada6302@domain.hid>
From: Steven Kauffmann <steven.kauffmann@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel lockup when shared IRQ is enabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <smolorz@domain.hid>
Cc: xenomai@xenomai.org

2009/5/4 Sebastian Smolorz <smolorz@domain.hid>:
> Steven Kauffmann wrote:
>> Hi all,
>>
>> As some other people on this mailing list, we also have system lockups
>> with the latest 2.4 branch. For some people the problems seems to be
>> solved when using the adeos-ipipe-2.6.28.9-x86-2.2-07.patch. So we
>> tried that but the system still freezes. The console output on another
>> machine reports nothing when the system freezes but at computer
>> startup we found this line:
>>
>> Xenomai: xnintr_shirq_handler: IRQ11 not handled. Disabling IRQ line.
>>
>> lspci shows us that the peak CAN card and the ethernet controller use
>> the same IRQ.
>
> Generally, it is problematic to share IRQs between RT and NRT devices. You
> better try to decouple these two devices WRT IRQ sharing.
>
>> Every time we try to bring up the ethernet device the system freezes.
>> Is this related with the above kernel log message and that both cards
>> use the same IRQ?
>
> Are you sure that the system freezes? Do you happen to be logged in over the
> net?

Yes I'm sure. I cannot ping to the system anymore ...

