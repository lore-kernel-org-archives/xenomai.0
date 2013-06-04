Message-ID: <51ADF3F3.9020903@xenomai.org>
Date: Tue, 04 Jun 2013 16:04:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMJ=MEeeWCB9AgnmjyPjM8F9kLe63UCBCBirB2i_MYvb_UvL5w@mail.gmail.com>
	<51ADE071.5090308@xenomai.org>
	<CAMJ=MEeXAb5Kobhhubr3kVUbcsZ7vXdN01NKQCvJrXpr6RgWAQ@mail.gmail.com>
In-Reply-To: <CAMJ=MEeXAb5Kobhhubr3kVUbcsZ7vXdN01NKQCvJrXpr6RgWAQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [xenomai-forge] psos: crash while stressing event
	timers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: xenomai@xenomai.org

On 06/04/2013 02:57 PM, Ronny Meeus wrote:
> On Tue, Jun 4, 2013 at 2:41 PM, Philippe Gerum <rpm@xenomai.org
> <mailto:rpm@xenomai.org>> wrote:
>
>     On 06/04/2013 12:56 PM, Ronny Meeus wrote:
>
>         Hello
>
>         we are currently running with recent version of xenomai-forge.
>         The issue we see is a crash while running the attached
>         application code
>         (pSOS interface).
>
>
>     How recent? What is your current head commit?
>
>
> 0fb3e28aa5efca4d9a9930db8f437f61eafdf9bc
>
>
>
>         Other useful information is that we typically see the issue when
>         we start
>         to reach a high cpuload.
>         On boards with a stronger processor, the number of batches can
>         be much
>         higher compared to boards with a low end processor.
>
>         The problem is observed in various processor environments
>         (mips/arm/ppc)
>         and with different versions of the C library.
>
>
>     Do you have these patches in?
>
>     http://git.xenomai.org/?p=__xenomai-forge.git;a=commit;h=__ba4fbc35cb6cc0a49aa062e1df1f8c__24e09533e4
>     <http://git.xenomai.org/?p=xenomai-forge.git;a=commit;h=ba4fbc35cb6cc0a49aa062e1df1f8c24e09533e4>
>
>     http://git.xenomai.org/?p=__xenomai-forge.git;a=commit;h=__a397d4f5f87f5824730776f4cb36e0__8d3efa2191
>     <http://git.xenomai.org/?p=xenomai-forge.git;a=commit;h=a397d4f5f87f5824730776f4cb36e08d3efa2191>
>
>
> Both changesets are included.
>

You may want to get a post-mortem backtrace of the application fault, 
reading the core dump image against your executable with gdb.

-- 
Philippe.

