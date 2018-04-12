MIME-Version: 1.0
In-Reply-To: <CALLqZ8SApBe3Zfix9p6vfFH-S1_20j7d5_A9kve3iL3H+F2HYQ@mail.gmail.com>
References: <CAOuPNLhmVjMMm80Xmu9DKCAD7QqyRZ_qBbnmCi38nKX9defDVQ@mail.gmail.com>
 <fg9ar1ooobcbsnuj1ib0ko69.1523444325709@embeddedgreg.com>
 <20180411134504.c5pswbha72ywtc7l@csclub.uwaterloo.ca>
 <CALLqZ8SApBe3Zfix9p6vfFH-S1_20j7d5_A9kve3iL3H+F2HYQ@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Thu, 12 Apr 2018 11:56:20 +0530
Message-ID: <CAOuPNLhVJ2wFG_nZ4+c4BPpX+idyDd-fNVVb9s7izej-qajcbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] How to use rtdm serial driver on beagle bone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

In BeagleBone there is no direct serial interface available.
However, we use Serial over USB (ttyUSB0) to connect to minicom.
In this case it is possible to use this interface over Xenomai and
check latency improvement?


Thanks,
Pintu



On Wed, Apr 11, 2018 at 7:34 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
> I think someone tried this with the uart on the PI, the basic steps
> would be (IMHO)
>      -unbind the current uart driver
>      -insert the xeno_16550A driver
>     -fix problems as they arise
>
> If you search the list you should see people who have tried this with
> other platforms in the past.
>
> -Greg
>
> On Wed, Apr 11, 2018 at 9:45 AM, Lennart Sorensen
> <lsorense@csclub.uwaterloo.ca> wrote:
>> On Wed, Apr 11, 2018 at 06:58:45AM -0400, Greg Gallagher wrote:
>>> What serial chip is on the beaglebone? If it's not supported then your best bet is to port the Linux driver to rtdm.
>>
>> I believe the normal driver is the 8250_omap.
>>
>> So it is 16550 style, but not 100% the same.
>>
>> --
>> Len Sorensen

