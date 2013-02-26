Message-ID: <512D1356.4060004@web.de>
Date: Tue, 26 Feb 2013 20:56:06 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <5123BCE7.2050609@xenomai.org>	<224444793.158669.1360843957336.JavaMail.ngmail@webmail16.arcor-online.net>	<511CD5C2.50701@arcor.de>	<511CD673.2030400@xenomai.org>	<511CDF65.1020907@arcor.de>	<511D3A22.40307@xenomai.org>	<511DF30B.6040601@arcor.de>	<511E26AE.1010203@xenomai.org>	<511E3A5C.4000209@arcor.de>	<51237586.6030201@arcor.de>
	<963432115.61822.1361872899385.JavaMail.ngmail@webmail10.arcor-online.net>
	<512CA697.5060405@xenomai.org> <512CA7FA.60807@siemens.com>
	<512D014D.8020208@xenomai.org>
In-Reply-To: <512D014D.8020208@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] kernel configuration problems with ACPI
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 2013-02-26 19:39, Gilles Chanteperdrix wrote:
> On 02/26/2013 01:18 PM, Jan Kiszka wrote:
> =

>> On 2013-02-26 13:12, Gilles Chanteperdrix wrote:
>>> On 02/26/2013 11:01 AM, hahnchristopher@arcor.de wrote:
>>>
>>>> On 02/19/2013 6:56 PM,  Gilles Chanteperdrix wrote:
>>>>> On 02/19/2013 01:52 PM, Christopher Hahn wrote:
>>>>>
>>>>>> Do you have any idea how to solve the problem?
>>>>>> Even if the system receives interrupts at IRQ 4, the program doesn't =

>>>>>> receive any message from the serial port with this kernel configurat=
ion.
>>>>>
>>>>>
>>>>> Trying to register the irq handler as level instead of edge?
>>>>>
>>>>> -- =

>>>>>                                                                 Gille=
s.
>>>>>
>>>>
>>>> I removed the 'RTDM_IRQTYPE_EDGE' from ksrc/drivers/serial/16550A.c at=
 line 123.
>>>>
>>>> Now I get 'Xenomai: xnintr_shirq_handler: IRQ4 not handled. Disabling =
IRQ line.'
>>>
>>>
>>> Jan, any idea?
>>
>> Not really. If there is an IRQ and the UART says "not for me", either
>> the UART is buggy or someone else injects on that line.
> =

> =

> Or we are handling the irq as edge triggered whereas it is level
> triggered. Is not there an RTDM_IRQTYPE_LEVEL instead of RTDM_IRQTYPE_EDG=
E?

Level is default, ie. the absence of EDGE will choose it.

I noticed that the kernel considers this line level triggered. It's
unusual. Still, the change above should have solved it then if that was
the problem. I-pipe picks up the type from Linux, thus should mask&ack
the line properly. RTDM_IRQTYPE_EDGE just avoids loosing edge events by
selecting the shirq_handler.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130226/0c6c29f=
e/attachment.pgp>
