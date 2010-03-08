Message-ID: <4B9586F4.7070900@domain.hid>
Date: Tue, 09 Mar 2010 00:23:32 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B95532E.1060409@domain.hid> <4B955D71.5050306@domain.hid>
	<4B955EE4.9030204@domain.hid>
In-Reply-To: <4B955EE4.9030204@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] BUG: Bad page map
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Steven A. Falco wrote:
>> Steven A. Falco wrote:
>>> I'm beginning to write an RTDM driver for a custom PCI
>>> device.  The plan is to map the device registers into
>>> user space, and deal with all the details in a Xenomai
>>> process.  However, I ran into crashes trying to access
>>> the device's memory from user space (via mmap in the RTDM
>>> driver).
>> Turns out to behave the same without IPIPE/Xenomai.  I'll
>> repost on the ppc dev list.
> 
> ISTR it is a known issue, and has been fixed. If that is the case,
> latest I-pipes (such as 2.6.30.3-powerpc-DENX-2.7-06), should contain a
> fix. Please give it a try.

It so happens that 2.6.30 contains the fix for the bug I seemed to remember:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=fbc78b07ba53ace155f27491c81a009e541a93ad

So, you probably have another problem, and should, as you said, post on
the ppc dev list.

-- 
					    Gilles.

