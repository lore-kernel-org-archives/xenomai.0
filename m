Message-ID: <5139D7F5.2090904@xenomai.org>
Date: Fri, 08 Mar 2013 13:22:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <512C806F.2020209@hilscher.com>	<512C9E78.1060208@siemens.com>	<512CC5C6.8050204@hilscher.com>	<512CC6A3.1010005@siemens.com>	<512F120A.5060109@hilscher.com>	<512F4005.60000@siemens.com>	<512F48AA.8020601@hilscher.com>	<5130B39C.70300@hilscher.com>	<513465CF.4030807@hilscher.com>	<51350D5B.6060309@xenomai.org>	<5135CCDE.5090401@hilscher.com>	<5135D667.8060309@siemens.com>	<51361281.20307@hilscher.com>	<51364A61.3090002@xenomai.org>	<5136F9E9.9030604@hilscher.com>	<5136FC1E.6060608@xenomai.org>	<51371B89.4020103@hilscher.com>	<513730CE.2070102@xenomai.org>	<51374B98.7030103@hilscher.com>	<51376093.7060701@siemens.com>
	<5137AF89.1020009@xenomai.org>	<5138B33C.1060506@hilscher.com>
	<5139BABA.8010602@hilscher.com>
In-Reply-To: <5139BABA.8010602@hilscher.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jerome Poncin <JPoncin@hilscher.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/08/2013 11:17 AM, Jerome Poncin wrote:

> Le 07/03/2013 16:33, Jerome Poncin a =C3=A9crit :
>> Le 06/03/2013 22:05, Gilles Chanteperdrix a =C3=A9crit :
>>> On 03/06/2013 04:28 PM, Jan Kiszka wrote:
>>>
>>>> Also here: Do not misuse write(), define an IOCTL that contains
>>>> something like "MMAP" and another one with MUNMAP in its name - that=
's
>>>> the purpose of this service, no?
>>>
>>> A lot of drivers probably have to reinvent a way to pass all the
>>> parameters for an mmap, why not adding an "mmap" method to RTDM drive=
rs?
>>>
>>>
>> Hello,
>>
>> I  re factored my code with all your remarks (I think and I hope).
>>
>> Could you say me if it's correct now ?
>>
>> Jan, you're right, It's possible to use Xenomai with UIO driver, but I=
=20
>> would like to use more real time possibilities of Xenomai in future=20
>> (like IRQ).
>> My first goal is to have a code compliant.
>> I added IRQ, and my next step will be to understand why the kernel=20
>> crash after IRQ registration.
>>
>> Thank you for your help,
>>
>> Jerome
>>
>>
>>
> Hello,
>=20
> I have good news because, I arrived to validated driver with IRQ=20
> support. I changed position of cifx on my motherboard in my PC and the =

> IRQ affected is not shared ;-) !
>=20
> I have now a question about IRQ. What is the good method to signal to=20
> user-land that there is an IRQ. Is there an example ?


Almost every "read" call is an example... ;-)

--=20
                                                                Gilles.


