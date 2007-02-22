Message-ID: <45DD5BA1.4080101@domain.hid>
Date: Thu, 22 Feb 2007 10:00:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <45DC1D05.1000206@domain.hid>
	<45DC2478.2020602@domain.hid>	<45DC39DE.8050802@domain.hid>
	<45DC3E6C.8040905@domain.hid> <45DC4281.8030903@domain.hid>
	<45DC9C9D.4050107@domain.hid> <45DD54A4.5040204@domain.hid>
In-Reply-To: <45DD54A4.5040204@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: (was: [Xenomai-help] CAN driver)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Hi Gilles and Jan,
> 
> Jan Kiszka wrote:
> 
>>Wolfgang Grandegger wrote:
>>
>>>>>BTW: some time ago I provided a patch to make the CAN utility programs
>>>>>part of the Doxygen documentation. IIRC, we said it's nice to have
>>>>>hyperlinked examples in general.
>>>>
>>>>Some link at hand? Does it still apply? Sounds like something worth to
>>>>apply.
>>>
>>>See https://mail.gna.org/public/xenomai-core/2006-11/msg00033.html.
>>>My patch was for the CAN utilities only. The idea was to have a more
>>>general implementation including code snippets and now examples as well.
>>>
>>>Wolfgang.
>>>
>>
>>Gilles, as you are planning to regenerate the docs for trunk anyway,
>>would you merge this patch (or better the corrected version) at that chance?
> 
> 
> Attached is a revised patch for hyper-linking with example and utility 
> programs. Apart from the CAN utilities, I have also added cross-link.c 
> for RTserial and the code snippets of the native skin by adding 
> "@example" tags to the appropriate source files. For the "demos" of the 
> skins it was not obvious for me where to put them. The examples are then 
> also part of the PDF documentation. Please have a look, hope you like 
> it. I personally find the hyper-linking very useful.

Ok. I finally got doxygen 1.4.6 tabs (the problem was the filesystem
rights of the tabs.css file), I will include your patch tonight.

-- 
                                                 Gilles Chanteperdrix

