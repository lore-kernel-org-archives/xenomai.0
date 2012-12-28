MIME-Version: 1.0
In-Reply-To: <50DCC0DD.6030105@xenomai.org>
References: <CAFjfccCyg_nbnNB3UGxEbWy3+SV+wp9T5iuj87DBN1Do08C7DQ@mail.gmail.com>
	<loom.20121227T200150-371@post.gmane.org>
	<50DCA303.7090303@xenomai.org>
	<CAAq7VdD_rrspRMqE8MVfLLnwPi+wOj87QedkdiSAto5YBG76Kw@mail.gmail.com>
	<50DCC0DD.6030105@xenomai.org>
From: Wim Meeussen <wim@hidof.com>
Date: Fri, 28 Dec 2012 10:32:51 -0800
Message-ID: <CAAq7VdDJB+F8CArTAXjVLfVZ1d5i0dfhH+p66K5QVTKzPVL-LQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Kernel compilation error due to Adeos patch error in
	'io_apic.c'
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

>>> Ok, do you have the issue with I-pipe core 3.4 and 3.5 ?

>> With Xenomai 2.6.2, ipipe-core-3.5.3-x86-2.patch, linux 3.5.3 and gcc
>> 4.6.3, I have a different problem, which I haven't been able to solve
>> yet (that's why I started using the older 3.2.21 kernel, and ran into
>> the problem described above).
>>
>> Running "make CONFIG_DEBUG_SECTION_MISMATCH=y -j4" on the 3.5.3 kernel
>> sources gives me the result below.  The
>> "CONFIG_DEBUG_SECTION_MISMATCH" parameter was suggested by the
>> previous build that failed, to get more information on the failure.
>>
>>
>> WARNING: drivers/scsi/fcoe/libfcoe.o(.init.text+0x1e): Section
>> mismatch in reference from the function init_module() to the function
>> .exit.text:fcoe_transport_exit()
>> The function __init init_module() references
>> a function __exit fcoe_transport_exit().
>> This is often seen when error handling in the init function
>> uses functionality in the exit path.
>> The fix is often to remove the __exit annotation of
>> fcoe_transport_exit() so it may be used outside an exit section.


> Are you sure this error is related to xenomai?

I still have to dig a little deeper to check what is causing this
problem, that's why I hadn't reported this before. I'll try to compile
the 3.5.3 kernel with the same configuration, but without the Adeos
patch. I'll follow up on this email when I can confirm the problem is
related to Xenomai.

Thanks for the response!
Wim




--
Wim Meeussen
CTO, hiDOF Inc.
650-529-4522
http://hidof.com

