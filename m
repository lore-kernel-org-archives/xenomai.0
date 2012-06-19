MIME-Version: 1.0
In-Reply-To: <20120618140819.GA32727@csclub.uwaterloo.ca>
References: <CAKKWdtcnn+EYfEQ=j4by6YtBRWn4nsFRMaCK=uWvKA1ubZ=EeA@mail.gmail.com>
	<20120611141444.GU32727@csclub.uwaterloo.ca>
	<CAKKWdtdvPGDsz3fJz0b64bPELR9RH92B3a=nPCCPtga7ZVUwNg@mail.gmail.com>
	<20120618140819.GA32727@csclub.uwaterloo.ca>
Date: Tue, 19 Jun 2012 16:21:36 +0430
Message-ID: <CAKKWdtfmWS2+v7Vvqob+v2brGmN7YHzigBmRMVPfFtXLXXOe4g@mail.gmail.com>
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

So if BIOS does not lock the SMI disabling so Xenomai kernel can disable SM=
I.
Then if the x86 PC system can work this way, there will be no problem
I think because the SMBus code is used for a better performance only I
think.

The fans start rotating after pressing the power-on switch.
I wonder if the fan speed control is compulsory for the correct
function of a computer.  ACPI spec does not talk about any necessity
of the running of the SMBus code.

I wonder if laptop computers work with Xenomai without SMI.

Regards

On Mon, Jun 18, 2012 at 6:38 PM, Lennart Sorensen
<lsorense@csclub.uwaterloo.ca> wrote:
> On Sun, Jun 17, 2012 at 05:25:08PM +0430, ali hagigat wrote:
>> I think SMI needs some initialization from BIOS and then Linux kernel.
>> The Linux kernel has some CONFIG_ variables to disable/enable SMI.
>> In theory a motherboard can be built to generate SMI without the
>> software help. But I think OEMs do not build such a board. So I think
>> an x86 PC hard real time system is possible for today's PCs.
>>
>> Please correct me if I am wrong.
>
> The majority of systems I have seen do have SMI enabled at all times
> and no way to turn it off.
>
> IBM even released a kernel driver to allow linux users to disable SMI on
> some xSeries servers, but they must also handle certain fan controllers
> from linux in that case since the SMI BIOS code is no longer doing it.
> For those doing real time, this is acceptable to have to do, certainly
> much better than having the SMI BIOS code interrupting real time just
> to check on the fans.
>
> I do not believe linux has any way to turn it off. =A0It is rather system
> specific. =A0All I see is CONFIG_GOOGLE_SMI which is specific to google's
> machines. =A0Also CONFIG_IBM_RTL (IBM Premium Real Time Mode).
>
> --
> Len Sorensen

