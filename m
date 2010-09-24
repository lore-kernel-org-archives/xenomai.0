Message-ID: <4C9C566A.509@domain.hid>
Date: Fri, 24 Sep 2010 09:42:34 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4c98be64201c58.15378618@domain.hid> <4C98C555.9050300@domain.hid>
	<4c9910335ccc47.39737985@domain.hid>
In-Reply-To: <4c9910335ccc47.39737985@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Support for PCAN-PCI Express card
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mariusz Janiak <mariuszjaniak@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, Oliver Hartkopp <socketcan@domain.hid>

On 09/21/2010 10:06 PM, Mariusz Janiak wrote:
> Dnia 21-09-2010 o godz. 16:46 Wolfgang Grandegger napisa=C5=82(a):
>> On 09/21/2010 04:17 PM, Mariusz Janiak wrote:
>>> Hi,
>>>
>>> Does Xenomai Peak CAN driver support PCAN-PCI Express card?
>>
>> Probably. What is the PCI vendor and device id of that card?
>=20
> I don't know. I don't have this card yet. How can I check it?

Then I don't know either. Looking to Peak's own chrdev driver, it seems
that it's supported be the standard PCI driver as well. Therefore I
assume that it's supported by RT-Socket-CAN. But you could contact Peak
for clarification.

Wolfgang.


