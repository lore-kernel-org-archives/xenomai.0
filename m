Message-ID: <46FA35E3.2070600@domain.hid>
Date: Wed, 26 Sep 2007 12:35:15 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <46F777EE.3060100@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB023D2124@domain.hid>
	<46F7B400.1020209@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB0244B830@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0244B830@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RTCAN (MSCAN) doesn't compile on latest Denx
	2.6.23
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Daniel Schnell wrote:
> Wolfgang Grandegger wrote:
> 
>> I have a patch already since a while but forgot to post it. Could you
>> please give the attached patch a try? 
>>
> 
> I have given the patch a try and it doesn't quite work out of the box,
> as there is an index off-by-one error concerning the configured CAN
> ports. The result is that probing the CAN controller starts with the
> second entry in the device tree and a random address will be probed for
> the second CAN controller where ioremap gladly bumps out with an error
> which results in a RT-CAN shutdown.
> 
> The applied patch solves the issue for me. I don't know if it works in
> case of (! #defined CONFIG_PPC_MERGE)

I'm going to check that. Thanks for reporting.

Wolfgang.


