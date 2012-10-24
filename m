Message-ID: <50883F34.4010604@xenomai.org>
Date: Wed, 24 Oct 2012 21:19:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANzNmi8DYqXmwtGe+Nu_HnLC8KgRO=H-29p6QBrjWrawreK_ig@mail.gmail.com>	<508837F9.9060904@xenomai.org>
	<CANzNmi8qKWz2PwyS0e_fchO7xpcsq_a0yqDYbuiRU_PYVjsvQA@mail.gmail.com>
In-Reply-To: <CANzNmi8qKWz2PwyS0e_fchO7xpcsq_a0yqDYbuiRU_PYVjsvQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problem trying an example for the first time.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Pavez <sebastian.pavez.t@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 10/24/2012 09:08 PM, Sebastian Pavez wrote:
> 
> 
> 2012/10/24 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org
> <mailto:gilles.chanteperdrix@xenomai.org>>
> 
>     On 10/24/2012 07:45 PM, Sebastian Pavez wrote:
>     > Hi everyone,
>     >
>     > Finally I was able to boot the kernel with xenomai. I did that with
>     > xenomai-2.6.1, linux-3.2.32 and ipipe-core-3.2.21-x86-1.patch with
>     this
>     > steps as a guide
>     > http://code.google.com/p/jhu-lcsr-ros-pkg/wiki/UbuntuXenomai.
>     >
>     > Now when I try to execute an example like the one suggested on the
>     quick
>     > build guide I get an error, I attached the capt of this,
> 
>     Please try to run the latency test or the xeno-test script first before
>     trying to compile examples.
> 
>     For patches on the issue with examples, see the mailing list archives.
> 
>     --
>                                                 Gilles.
> 
> Thank you Gilles for your response  ... again
> 
> I executed the test. I attach a capture of them.
> I think the latency one is ok, but for xeno-test the result doesn't seem
> nice.

First, please stop wasting people's bandwidth with images. When the
error is text, simply cut and paste the text.

Please no private mails.

Second the xeno-test you are running is not xenomai 2.6.1 xeno-test, so
you have binaries of some other version of xenomai version installed,
presumably xenomai 2.5. As explained in the troubleshooting guide, this
is a risky situation.

> 
> Regarding the issue with the examples I already read this post
> http://www.xenomai.org/pipermail/xenomai/2012-October/026561.html but I
> didn't understand exactly what to do with that ... I have to change the
> entries that are different on the file??

Try applying the patch. Using xenomai supposes that you are a C
programmer and as such you should already have seen "unresolved
symbols", and that you are familiar with using the common unix tools.

> 
> One last question, what does it mean the negative values on the latency
> test?? Are they normal??

Yes, this too is an issue which has been discussed many times on this list.


-- 
					    Gilles.

