Message-ID: <4C73F540.3040906@domain.hid>
Date: Tue, 24 Aug 2010 18:37:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C73EC62.80703@domain.hid>
	<1282667450.1961.132.camel@domain.hid>
In-Reply-To: <1282667450.1961.132.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Adeos-main] [RFT] ipipe patch for 2.6.35.3-x86
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

Philippe Gerum wrote:
> On Tue, 2010-08-24 at 17:59 +0200, Jan Kiszka wrote:
>> Hi,
>>
>> just uploaded a forward port of the 2.6.34 ipipe patch for x86 to latest
>> stable 2.6.35.3. It boots and runs fine here in 64-bit mode with Xenomai
>> head, but I only ran light tests so far. Anyone interested in upgrading
>> the host kernel (I think I read some request recently) is welcome to
>> give it a try and report results back (specifically on 32 bit as that is
>> a bit out of focus for me ATM). You can download the full git tree from
>>
>> 	git://git.kiszka.org/ipipe-2.6.git queues/2.6.35-x86
>> 	(alternatively also via http://)
>>
>> Looking forward to feedback,
> 
> The comment and the relevant code for 82a7dd3df needs fixing: all
> pipeline ports should expose 4 IPIs, named IPIPE_SERVICE_IPI[0-3].
> powerpc/SMP has one more up to 2.6.34, but IPI4 will disappear in
> 2.6.35. The upcoming arm/SMP port conforms to this requirement as well.
> Those are merely pipelined IPI channels, the way the arch-dep section
> manages to multiplex them (or not) over the available hw channel(s) is
> of course unspecified. The virtual IPI numbers are also unspecified.

Ah, so you mean a generic parameter check in ipipe_send_ipi for those 4
IPIs is possible? Then I will add a corresponding patch to the generic
queue.

> 
> Nitpicking: if you intend to push this material to me at some point,
> please make sure to prefix commit subject lines with 'ipipe:' for the
> -noarch section, and 'x86/ipipe:' for the rest. I'm a grep fanboy, and
> this 'tends' to conform to linux mainline as well.

OK, will fix.

And if I had a wish for the maintainer: Please ensure that the -noarch
branch in kept in proper sync with the latest arch. Took me a while (and
two temp branches) to extract a proper x86-only patch for the port.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

