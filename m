Date: Wed, 8 Mar 2006 21:35:07 +0100 (CET)
From: Herman Bruyninckx <Herman.Bruyninckx@domain.hid>
Subject: Re: AW: [Xenomai-core] Fundamental Questions
In-Reply-To: <440F3A8A.9030501@domain.hid>
Message-ID: <Pine.LNX.4.64.0603082132080.7091@domain.hid>
References: <003501c642e1$b1050990$a10a10ac@domain.hid>
	<440F3A8A.9030501@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Reply-To: Herman Bruyninckx <herman.bruyninckx@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 8 Mar 2006, Jan Kiszka wrote:

> Christopher Stone wrote:
>> I do not have specific plans.
>>
>> I am working on something I am currently calling the Xen Loadable Module or
>> XLM. It is an Xenomai application that when loaded, turns the Linux kernel
>> into a Xen compatible hypervisor. For the rationale behind it see here:
>> http://www.openembedded.biz/content/view/36/27.
>>
>> When it is ready, in 6 to 8 weeks, I am prepared to contribute it. It is a
>> significant work, but, is an Xenomai application, so I don't know if you
>> guys want it. It does fit with your goals with respect to industrial grade
>> Linux.
>>
>> I think that XLM actually illustrates a key point that people forget when
>> they compare rt-preempt to Xenomai. I believe that in the industrial grade
>> Linux world, the ability to support multiple OS's is key, especially in
>> light of the emerging dual core CPU's. Due to ADEOS, Xenomai has the
>> infrastructure to support doing things like running eCos on one core and
>> Linux on the other, or eCos and Linux, side by side, on the same CPU. XLM is
>> designed to make this easy. Rt-preempt has no such capability.
>
> Sounds interesting, especially when considering future systems with
> hardware support for virtualisation, thus removing the need to patch the
> guest OS (there are still people with the desire to run Windows aside
> the RTOS core for visualisation etc.). And if your approach have real
> advantages over Xen, specifically on embedded systems or in combination
> with hard real-time, this could become really great.
>
I have the same positive reaction towards this XLM suggestion!

In some of our projects with machine tool builders, this kind of
virtualization is high on their wish list, because it's a perfect way
(hopefully) to combine lots of legacy GUI code with the advantages of a
realtime Linux-based controller.

Herman

--
   K.U.Leuven, Mechanical Eng.,  Mechatronics & Robotics Research Group
     <http://people.mech.kuleuven.be/~bruyninc> Tel: +32 16 322480

Disclaimer: http://www.kuleuven.be/cwis/email_disclaimer.htm


