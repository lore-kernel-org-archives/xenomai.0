MIME-Version: 1.0
Sender: mfornero@gmail.com
Date: Mon, 22 Jul 2013 13:10:16 -0400
Message-ID: <CADVgf9kDgO9oHA3juWEGV-1RXBo5vNzzR208Ot3W3318Zryscw@mail.gmail.com>
From: Matthew Fornero <mfornero.lists@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Xenomai for Zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Mon, Jul 22, 2013 at 11:26 AM, Kari Kumpulainen <k_olavi@ovi.com> wrote:
> Hello,
>
> Which kernel and Xenomai versions should I use if I want to build Xenomai
> support for a Zynq (Xilinx) chip?
> I tried to patch the 3.5 kernel provided by Xilinx, but patching failed
> because of conflicts in some files.

There are a couple projects on github which should get you started.
Note that I haven't updated either of these for a while:

3.5 based kernel: https://github.com/mfornero/ipipe
This is a merge of the Xilinx 3.5 tree and the ipipe 3.5 tree. Both
are now fairly out of date

3.8 based kernel: use the patches and readme found here:
https://github.com/mfornero/xenomai/tree/for-upstream/ksrc/arch/arm/patches

I believe the later will be merged into the Xenomai tree at some point.

Best Regards,

Matt Fornero

