Message-ID: <4FDDE5DC.4030608@xenomai.org>
Date: Sun, 17 Jun 2012 16:12:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtcnn+EYfEQ=j4by6YtBRWn4nsFRMaCK=uWvKA1ubZ=EeA@mail.gmail.com>	<20120611141444.GU32727@csclub.uwaterloo.ca>
	<CAKKWdtdvPGDsz3fJz0b64bPELR9RH92B3a=nPCCPtga7ZVUwNg@mail.gmail.com>
In-Reply-To: <CAKKWdtdvPGDsz3fJz0b64bPELR9RH92B3a=nPCCPtga7ZVUwNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] the Linux kernel and operating system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

On 06/17/2012 02:55 PM, ali hagigat wrote:
> I think SMI needs some initialization from BIOS and then Linux kernel.
> The Linux kernel has some CONFIG_ variables to disable/enable SMI.

Last time I checked, the linux kernel did not have such CONFIG_
variables, which is why xenomai adds them.

> In theory a motherboard can be built to generate SMI without the
> software help. But I think OEMs do not build such a board. So I think
> an x86 PC hard real time system is possible for today's PCs.
> 
> Please correct me if I am wrong.

An SMI is an interrupt, so, there must be software to handle the SMI,
so, no, a motherboard can not be built to generate SMI without software
help.

Intel chipsets provide a register to disable SMIs, but also provide a
register to lock usage of the first register. So yes, there are some PC
today that you can not use for real-time. Unless, of course, you are
ready to use your own BIOS instead of the one provided by the hardware
vendor, or your hardware vendor is willing to change the BIOS.

-- 
                                                                Gilles.

