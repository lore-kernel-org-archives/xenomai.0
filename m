MIME-Version: 1.0
In-Reply-To: <20120611141444.GU32727@csclub.uwaterloo.ca>
References: <CAKKWdtcnn+EYfEQ=j4by6YtBRWn4nsFRMaCK=uWvKA1ubZ=EeA@mail.gmail.com>
	<20120611141444.GU32727@csclub.uwaterloo.ca>
Date: Sun, 17 Jun 2012 17:25:08 +0430
Message-ID: <CAKKWdtdvPGDsz3fJz0b64bPELR9RH92B3a=nPCCPtga7ZVUwNg@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] the Linux kernel and operating system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

I think SMI needs some initialization from BIOS and then Linux kernel.
The Linux kernel has some CONFIG_ variables to disable/enable SMI.
In theory a motherboard can be built to generate SMI without the
software help. But I think OEMs do not build such a board. So I think
an x86 PC hard real time system is possible for today's PCs.

Please correct me if I am wrong.

On Mon, Jun 11, 2012 at 6:44 PM, Lennart Sorensen
<lsorense@csclub.uwaterloo.ca> wrote:
> On Sat, Jun 09, 2012 at 01:43:37PM +0430, ali hagigat wrote:
>> What kernel subsystems are effecting the real time functionality of an
>> x86 PC system? Is there a complete list of the CONFIG_ variables
>> regarding that for 2.6.38.8?
>
> Well in general I would say that using an x86 PC to do real time can't
> be done. =A0Most x86 PCs use SMI, which destroys any hope of actually
> getting real time to provide any real response time promises.
>
> Now if you happen to have a PC that doesn't use SMI, or can have it
> disabled, then you can get real time.
>
> On things that are not PCs this is pretty much never a problem.
>
> There are some server vendors that provide information on turning off
> SMI because they have customers that want to run real time software on
> the machine.
>
> --
> Len Sorensen

