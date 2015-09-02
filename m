References: <55E45EE2.1090307@free.fr>
 <20150831183003.GA5696@hermes.click-hack.org>
 <20150901102001.GB26674@hermes.click-hack.org> <55E70104.3060207@free.fr>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <55E70306.5050305@xenomai.org>
Date: Wed, 2 Sep 2015 16:09:10 +0200
MIME-Version: 1.0
In-Reply-To: <55E70104.3060207@free.fr>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rt_e1000e driver issues
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_ANCELOT?= <sancelot@free.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>



On 09/02/2015 04:00 PM, St=E9phane ANCELOT wrote:
> On 01/09/2015 12:20, Gilles Chanteperdrix wrote:
>> On Mon, Aug 31, 2015 at 08:30:03PM +0200, Gilles Chanteperdrix wrote:
>>> On Mon, Aug 31, 2015 at 04:04:18PM +0200, St=E9phane ANCELOT wrote:
>>>> Hi,
>>>>
>>>> I am checking timing issues of realtime rtnet frames in my=20
>>>> application.
>>>> Timing to send a frame is  convenient.
>>>> but I have some issues with the time to receive the frames.
>>>>
>>>> Although the RxDelays are cleared, the frame is received almost=20
>>>> 175us later
>>>> than it should in comparison with a rt8169 driver (v2.6 version)=20
>>>> and the
>>>> same application.
>>>>
>>>> Any idea where to look at first ?
>>> modinfo rt_e1000e
>> Actually, the module parameters are the same as the Linux driver,
>> so, they are documented in Documentation/networking/e1000e.txt in
>> the Linux kernel sources, here for instance:
>> https://git.xenomai.org/ipipe.git/tree/Documentation/networking/e1000e.t=
xt?id=3Dv4.2-rc1=20
>>
>> (beware that the driver versions are not the same, so, there may be
>> some differences, like default values, or even some options, but
>> modinfo will tell you that).
>>
>> Your problem is probably that you should disable interrupt
>> throttling passing InterruptThrottleRate=3D0.
>>
> Hi,
> I checked the timerdelays settings everything seems rigth by default.
> However,  I think the main differences I mesure are related to the=20
> usage of EarlyReceive in r8169 driver. Thus spending less time in recv=20
> func .
>
> I will soon check the same application using the igb driver

I have made some round trip time measurement with two e1000e boards, and=20
I am pretty sure
with InterruptThrottleRate=3D0 *RxDelay=3D0 the delays are in the 10s of=20
microseconds order (on a
gigabit link).

--
                                                 Gilles Chanteperdrix

