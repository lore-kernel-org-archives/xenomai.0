Message-ID: <50F3989B.7050808@zultron.com>
Date: Sun, 13 Jan 2013 23:33:15 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <50F19CE1.5080106@zultron.com> <50F1B37E.3030502@xenomai.org>
	<50F23AA2.3080102@zultron.com> <50F2BC64.408@xenomai.org>
	<50F30CB8.7000001@zultron.com> <50F30EEA.8090803@xenomai.org>
In-Reply-To: <50F30EEA.8090803@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] SMI workarounds in one-size-fits-all kernel packages
 (Was: Re: Kernel OOPS during regression tests)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 01/13/2013 01:45 PM, Gilles Chanteperdrix wrote:
> On 01/13/2013 08:36 PM, John Morris wrote:
>> On 01/13/2013 07:53 AM, Gilles Chanteperdrix wrote:
>>> On 01/13/2013 05:40 AM, John Morris wrote:
>>>> On 01/12/2013 01:03 PM, Gilles Chanteperdrix wrote:
>>>>> It seems a really bad idea to enable the SMI workaround by default.
>>>>
>>>> Thanks!  Despite feeling uncomfortable contradicting the documentation,
>>>> I was encouraged to turn this on by someone more authoritative than me.
>>>> It does seem like a separate package with it turned on is warranted for
>>>> those who have problems and have been fairly warned about the risk.
>>>
>>> I guess we should turn the compile-time option into a kernel parameter.
>>> So, the smi workaround would be disabled by default, and only enabled
>>> when passing a kerne command-line option.
>>
>> That would be ideal!
> 
> We will try to issue a fix for the 2.6.2 release first, this improvement
> will be part of the next release.

A boot-time option would definitely solve the one-kernel-fits-all need.
 In my ideal fantasy world, a run-time option, perhaps in /proc/xenomai,
would potentially make this dummy-proof, since someone could write a
utility to tweak settings in a running system, maybe even a smart
utility that could help detect dangerous conditions.

I did find Jan's userland utility 'smictrl' [1] that uses libpci to
provide a simple way to query and set SMI controls on a running system.
 If it has all the functionality of Xenomai's SMI workaround, maybe we
could toss that into the packages, write a wiki page and say 'good
enough for now'.  (I tried it on an old Dell PC and my old Thinkpad,
both with ICH5 chipset, and while it could manipulate some bits, the
ones that might have mattered couldn't be reset.  I assumed they were
locked down by the BIOS, not by any shortcoming of the utility.)

	John

[1]  http://git.kiszka.org/?p=smictrl.git

