MIME-Version: 1.0
In-Reply-To: <1243585964.25099.8.camel@domain.hid>
References: <abaf774b0905270831q6c8aeb44mb2cf10f7ca3b926f@domain.hid>
	<4A1D6ED4.3060104@domain.hid> <1243443636.22014.79.camel@domain.hid>
	<4A1D73B6.1050602@domain.hid>
	<abaf774b0905272354m2ece1cb3s967f17b876b55bbf@domain.hid>
	<4A1E46C9.9050806@domain.hid>
	<abaf774b0905280853x23fe5bf2y68cd354ba6a787c9@domain.hid>
	<1243585964.25099.8.camel@domain.hid>
Date: Wed, 3 Jun 2009 11:41:02 +0100
Message-ID: <abaf774b0906030341x2e0fca36t7db790b9157e1570@domain.hid>
From: Steve <sbxenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xeno-test hangs during latency test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On 29/05/2009, Philippe Gerum <rpm@xenomai.org> wrote:
> On Thu, 2009-05-28 at 16:53 +0100, Steve wrote:
>> More importantly, I am now running:
>> Vanilla Linux Kernel: 2.6.29.4
>> Adeos Patch: adeos-ipipe-2.6.29.4-x86-2.4-01.patch
>> Xenomai Version: 2.4.7
>>
>
> 2.4.7 vanilla does not support 2.6.29 kernels (actually, it does not
> even compile against it), so I guess you are in fact running a snapshot
> from the v2.4.x maintenance branch
> (http://git.xenomai.org/?p=xenomai-2.4.git;a=summary).
>
> If true, and this snapshot was taken between May 19 and May 21, then a
> short lived bug affecting the timer programming code may well lead to
> the kind of issue you reported. In such a case, you may want to pull the
> latest changes from our git tree.
>
>> Due to the change in kernel my config file is now different.  The
>> primary change that may be relevant based on previous postings is that
>>  CONFIG_CPU_IDLE is now set, because it will not disable unless ACPI
>> is completely disabled.
>>
>> The OS still hangs during the latency test of xeno-test, but I now
>> have the attached output from the kernel console (including the final
>> initialisation message ('boot scripts') before the hang).
>>
>> Steve
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
> --
> Philippe.
>
>
>

Having installed the latest version of Xenomai (2.4.8) it no longer
hangs, thanks for the advice.

You guess correctly, I was running 2.4.X released on the 19th May, not
2.4.7 as I incorrectly said in my later post, and so it seems that
that was my problem.  Just for completeness, I am now running a
vanilla 2.6.29.4 Linux kernel patched with
adeos-ipipe-2.6.29.4-x86-2.4-01 and Xenomai 2.4.8 on Ubuntu 8.04.

Thanks for your help,

Steve

