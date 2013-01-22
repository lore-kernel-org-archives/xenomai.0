Message-ID: <50FEF361.4000705@xenomai.org>
Date: Tue, 22 Jan 2013 21:15:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMgy_J0idydJq8wzH3CwQoCa+BEbSyUyOJoWmvwc+oAB3jpZ6w@mail.gmail.com>	<CAKvQZ_2Nzfgj7oK12+t3CtLj-YWBCB=nFYSDU6B4KqW4aWQpnQ@mail.gmail.com>	<50B88506.6000002@xenomai.org>	<CAKvQZ_3LJ-u2B0zc0+pobSGnMZ4nNviyxfuP1uiVRVuHw9Y9pQ@mail.gmail.com>	<50B8F21B.5090503@xenomai.org>	<CAKvQZ_13VsZV9sKjNLqMTHJhGn55pjkLqffsb8kYQb1b8H7rFw@mail.gmail.com>
	<50FE4116.8060508@zultron.com>
In-Reply-To: <50FE4116.8060508@zultron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Frustrating experience with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>
Cc: xenomai@xenomai.org

On 01/22/2013 08:34 AM, John Morris wrote:

> Hi Willy,
> 
> On 01/21/2013 06:43 PM, Willy Lambert wrote:
>> Here is a first try.
>> http://www.xenomai.org/index.php/Building_kernel
>>  Don't hesitate to comment/correct this. I will add some links later to :
>> _ a good complete kernel building guide (if you have some please share)
>> _ x86 configure hints wiki page.
>>
>> The end is a bit specific to Debian/Ubuntu distros. Is it a problem ?
>> Should I rework this ?
> 
> Nice write-up.  I've done the same thing on the LinuxCNC website.  Feel
> free to comment, fix, borrow, ignore....
> 
> http://wiki.linuxcnc.org/cgi-bin/wiki.pl?XenomaiKernel


Just a note about running the dohell script:
dohell -m /tmp 100 is a light load
If you can not run ltp (though it probably exists as a package for all
distributions), you should at least use the -b argument to generate load
with hackbench.

-- 
                                                                Gilles.

