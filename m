Message-ID: <4F4920DE.40600@domain.hid>
Date: Sat, 25 Feb 2012 18:56:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHOEnGfih5tin7NAnf-qU6tKxVtnb=LjuBFE5QxFQpxfA=EBkg@domain.hid>
	<CAHOEnGdKstVsBUKnQcCm3NK4BfngnGOAKfimXA5VL=ujUzR2ig@domain.hid>
	<4F3AAA52.6060802@domain.hid>
	<CAHOEnGdzwe3gj5c_PAkqBHsYCz=-+McZkDTz7kSOLUQyVDVDyg@domain.hid>
	<4F46C7CD.1070509@domain.hid>
	<CAHOEnGfV3f6aKwzvU+cAkofDXhoHXKQU4YRexUatB85KtTYiDg@domain.hid>
In-Reply-To: <CAHOEnGfV3f6aKwzvU+cAkofDXhoHXKQU4YRexUatB85KtTYiDg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Freeze while running examples
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?T3NjYXIgRMOhdmlsYQ==?= <odavilar@domain.hid>
Cc: xenomai@xenomai.org

On 02/24/2012 11:55 PM, Oscar D=C3=A1vila wrote:
> 2012/2/23 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>=20
>> On 02/23/2012 11:43 PM, Oscar D=C3=A1vila wrote:
>>> 2012/2/14 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>>
>>>> On 02/14/2012 06:54 PM, Oscar D=C3=A1vila wrote:
>>>>> I compiled Xenomai succesfully, but when i try to run an example it=

>>>> freezes
>>>>> / machine look up, any help will be apreciated, thanks.
>>>>>
>>>>> Here is some info about the system, its a Debian 6.0 with a
>>>>> kernel 2.6.35.9, xenomai-2.6.0, the adeos
>>>>> patch adeos-ipipe-2.6.35.9-x86-2.8-04.patch and Im also using the
>>>>> nmi_watchdog=3D2 in the boot kernel options.
>>>>
>>>> Please reproduce the bug:
>>>> - in text mode, so as to have the full bug trace;
>>>> - with frame pointers enabled;
>>>> - with highest kernel verbosity for BUGs and backtraces.
>>>>
>>>
>>> How do i do this last point? i mean, i already compile kernel with fr=
ame
>>> pointers enabled, also i already ran it in text mode, and i active al=
l
>> the
>>> xenomai debug kernel options. i saw some other debug options in kerne=
l
>>> hacking, do i have to active those ones too?
>>
>> The stack trace looks fine. Could you show us the disassembly of the
>> __ipipe_sync_stage function?
>>
>>
> Here is what i think is the disassembly of the __ipipe_sync_stage funct=
ion,
> the full disassembly of the core.c file is in
> http://odavilar.0x1fee3.org/xenomai/__ipipe_sync_stage

Please obtain the disassembly with objdump -d vmlinx, so that we get the
addresses corresponding with the instructions. Without the addresses, we
do not know where to look.

--=20
                                                                Gilles.


