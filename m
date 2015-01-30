MIME-Version: 1.0
Sender: roland.pastorino@gmail.com
In-Reply-To: <20150129130414.GA4766@hermes.click-hack.org>
References: <CABxGBLRcHB_V1H-Da-yv5GMaN=_9-tD_K0werwc-SPSGgTRy5g@mail.gmail.com>
 <20150129130414.GA4766@hermes.click-hack.org>
Date: Fri, 30 Jan 2015 12:15:07 +0100
Message-ID: <CABxGBLTCDi_3ZBr_96PhyhPry9tNCWyvwWSzcaA4CxfKpJbrRQ@mail.gmail.com>
From: Roland Pastorino <roland@rolandpastorino.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] ToD drift on i7-3740QM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

2015-01-29 14:04 GMT+01:00 Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org>:
> On Thu, Jan 29, 2015 at 01:59:36PM +0100, Roland Pastorino wrote:
>> 2015-01-29 13:25 GMT+01:00 Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org>:
>> > On Sun, Jan 25, 2015 at 12:15:39PM +0100, Roland Pastorino wrote:
>> >> Good morning everyone,
>> >>
>> >> I would like to know if some of you could give me a hint on how to
>> >> solve my ToD drift problem.
>> >> This question is similar to this one ->
>> >> http://comments.gmane.org/gmane.linux.real-time.xenomai.users/19719
>> >>
>> >> Problem:
>> >> After installing Xenomai and after the first reboot, my ToD drift was
>> >> around 500000 us/s.
>> >> After the second reboot, my ToD drift is around 500 us/s which I
>> >> presume is still too high.
>> >> I checked the troubleshooting information on Xenomai website but it didn't help.
>> >>
>> >> Machine and configuration:
>> >> - PC = Thinkpad w530
>> >> - cpu = i7-3740QM
>> >> - kernel configuration file is attached. I followed the Xenomai
>> >> website for the configuration.
>> >> - cobalt kernel of Xenomai 3
>> >> - Linux kernel 3.16
>> >> - ipipe-core-3.16-x86-1.patch
>> >> - Ubuntu 14.10
>> >
>> > Actually, the kernel configuration is not attached. But probably the
>> > only interesting item is whether CONFIG_CPU_FREQ is missing.
>> >
>> >
>> > --
>> >                                             Gilles.
>>
>> I've attached the kernel configuration this time...
>>
>> CONFIG_CPU_FREQ is like this:
>> # CPU Frequency scaling
>> #
>> # CONFIG_CPU_FREQ is not set
>>
>> This is the result of configuring the kernel via 'makemenuconfig'.
>> Also I noticed that the 'clocktest' can give different results
>> (without rebooting my machine).
>> For example now my ToD drift is around 67 us/s which is better but
>> different from the previously mentioned results.
>> The best I got was 0.6 us/s.
>
> Linux and Xenomai do not necessarily use the same clock source, and
> when they use the same, do not necessarily use the same frequency,
> especially when Linux has NTP running. So, unless you launch
> clocktest to watch CLOCK_HOST_REALTIME, a difference is expected.
> But 500us/s is abnormal, something is off. You need to look at the
> frequencies used by Linux and Xenomai, and see which one is off.
>
>
> --
>                                             Gilles.

I see the point.
If I run the 'clocktest' with CLOCK_HOST_REALTIME, I get this:

== Tested clock: 8 (CLOCK_HOST_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0         -339532135.1       122526.008          0            0.0
  1         -339532070.5       121839.520          0            0.0
  2         -339532420.1       122929.781          0            0.0
  3         -339531750.8       123088.126          0            0.0

The drift is still way off.
CLOCK_REALTIME gives:

== Tested clock: 0 (CLOCK_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0         -302580987.5       330900.325          0            0.0
  1         -302580653.8       330346.234          0            0.0
  2         -302580710.2       329623.634          0            0.0
  3         -302580359.1       329730.306          0            0.0

I verified that NTP is running.
$ sudo service ntp service
* NTP server is running

As you mentioned the Linux and/or Xenomai frequencies is/are probably off.
I have to mention that my Linux clock (=date) can run faster or slower
than the wall-clock time.
Could you please tell me where I should start searching for a
solution? Linux kernel sources, ipipe patch?

Many Thanks.

Roland Pastorino

