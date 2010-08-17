Message-ID: <4C6A4B5C.9030504@domain.hid>
Date: Tue, 17 Aug 2010 10:42:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <76E258664B189C4CBEF125491CA11ECC9458403922@domain.hid>	<76E258664B189C4CBEF125491CA11ECC9458403925@domain.hid>	<1281597159.1730.71.camel@domain.hid>	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD14F757@domain.hid>	<4C642F04.4020008@domain.hid>	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065786@domain.hid>	<4C651A5D.9030101@domain.hid>	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065788@domain.hid>	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065789@domain.hid>	<4C695C36.1030308@domain.hid>	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD2A1992@domain.hid>
	<AANLkTingp952EJiZk38P_hywNyKB9333mr1Cs4ctpQcc@domain.hid>
In-Reply-To: <AANLkTingp952EJiZk38P_hywNyKB9333mr1Cs4ctpQcc@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] 2.6.32.18/x86 (Ubuntu) hangs at boot w/ Xenomai
 2.5.3 [was: HELP]
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Prakash A S <asprakash83@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Prakash A S wrote:
> On Mon, Aug 16, 2010 at 9:38 PM, Hemal C.Bavishi <
> Hemal.Bavishi@domain.hid> wrote:
> 
>> Dear Stefan,
>>
>> The behavior was quite peculiar and it has nothing to do with the "building
>> debian packages howto". However, it would be good if you specify these steps
>> into howto under building debian packages for smooth installation for new
>> comers:)
>>
>> Nevertheless, I resolved this issue by explicitly calling the
>> update-initramfs -c -k with the image name. I was bit surprised with the
>> behavior but it worked for me.
>>
>> However, I am still facing the problem of hang up issue at boot(blank
>> screen which other users also has reported) some time (it generally boots
>> after every 3/4 starts). I don't know what's an issue but I observed this
>> behavior in 4 different system. Do you have any solution for this issue? Do
>> I have to build xenomai with the newer kernel version 2.6.32.34? Would that
>> solve current issue?
>>
> 
> Try to pass (without quote) "noapic nolapic" in kernel boot option and
> please update the scenario.

That is not going to work: if APIC and IO/APIC support are selected in
the kernel, Xenomai will try and use them, and if you pass these
options, it will not be able to use them.

-- 
					    Gilles.

