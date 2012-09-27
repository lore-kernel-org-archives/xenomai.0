Message-ID: <506458A3.7030708@xenomai.org>
Date: Thu, 27 Sep 2012 15:46:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1999962074.3983480.1348752195552.JavaMail.root@zmail.sgconsulting.it>
	<5064555B.1020306@xenomai.org>
In-Reply-To: <5064555B.1020306@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 2.6.1 - Linux 2.6.38.8 on AT91SAM9260 -
 Kernel compilation fails
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Forconi <forconi@wavecomm.it>
Cc: xenomai@xenomai.org

On 09/27/2012 03:32 PM, Gilles Chanteperdrix wrote:
> On 09/27/2012 03:23 PM, Forconi wrote:
>> The command:
>>
>> make ARCH=arm CROSS_COMPILE=arm-unknown-linux-gnu- uImage
>>
>> is the command I use to cross compile kernels for my AT91 board, and I have successfully cross-compiled several kernels, so I think AS is the cross-as not the system-as.
>>
>> It seems like my cross-as doesn't support that assembler instruction.. (arm-unknown-linux-gnu-as version is: GNU assembler 2.16.1)
> 
> I very much doubt an ARM assembler does not support
> ldm sp,{r0-r3}

You can also try replacing ldm with ldmia, but ldmia is supposed to be
the default for ldm where no suffix is specified, at least it is what
the documentation says.

-- 
					    Gilles.

