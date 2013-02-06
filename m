Message-ID: <51124977.3050706@vmars.tuwien.ac.at>
Date: Wed, 06 Feb 2013 13:15:51 +0100
From: Elshuber Martin <martine@vmars.tuwien.ac.at>
MIME-Version: 1.0
References: <DUB112-W13050D5AFBEFC5B494C17E2DB070@phx.gbl>
In-Reply-To: <DUB112-W13050D5AFBEFC5B494C17E2DB070@phx.gbl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai on uClinux on Altera FPGA
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear Hasan,

I did it, on a non-MMU Nios 2 architecture with a Stratix IV FPGA, using=20
the guide ("Xenomai on NIOS II Softcore Processor: a step by step=20
Guide") in the link below
http://kadionik.vvv.enseirb-matmeca.fr/nios2-xenomai/doc/Xenomai%20on%20N=
IOS%20II%20Softcore%20Processor%20Guide-v1.2.pdf

However there might be newer versions available that are not covered by=20
this document.

I hope this helps
Martin

On 02/06/2013 12:59 PM, Hasan Erdem Yant=C4=B1r wrote:
> Hello
> I am a researcher and dealing with RTOSes on Field Programmable Gate Ar=
rays. As an processor I am using Nios II soft core processor on Altera FP=
GAs, and I've loaded the uClinux operating system. The operating system w=
hich I loaded was nios2-linux-20090929.tar version. After loading uClinux=
, I've patched it with Xenomai 2.6 however patch causes a verification er=
ror while loading the image file.
> Are there any member in this list who succesfully patched Xenomai to uC=
linux and run it on the FPGA. Can he/she provide the exact version / sour=
ce of the uClinux which he/she has used.
> Thanks... 		 	   	=09
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai


