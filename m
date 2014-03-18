MIME-Version: 1.0
Date: Tue, 18 Mar 2014 01:56:47 +0100
Message-ID: <CABWi3-b=Rb15y+hnxnmz7WtMKYd7miT2o2dBB05ajXZ96_W65A@mail.gmail.com>
From: Laci Tele <laci.tele1@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] ipipe-3.0-imx6q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Gilles,

In your ipipe git repo (ipipe-gch.git) there is a branch named
ipipe-3.0-imx6q .
I cloned the repo and checked that branch out.
Its a 3.0.43 kernel. And this is what I don't understand.
Is it supposed to be a kernel for Freescale im6q boards?
Because Freescale's supported kernels are:
3.0.35
3.5.7 (alpha)(obsolete)
3.10.9 (alpha)(obsolete)
3.10.17 (beta)

What are you doing with 3.0.43 kernel ? Freescale has no such a supported
kernel.
If anyone wants to run xenomai on any mx6q card, that guy starts to
download the kernel at:
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/refs/heads (git
name is confusing, this is not only linux-2.6)
Check the branches here. The most importants are:
imx_3.0.35_4.1.0<http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/log/?h=imx_3.0.35_4.1.0>
imx_3.10.17_1.0.0_beta<http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/log/?h=imx_3.10.17_1.0.0_beta>

There is no 3.0.43 kernel and never was. Of course many kind of kernels are
able to run on Freescale cards, but only with limited HW peripheral
support. No HDMI, no USB, no SATA...or something else is missing.
You should stick to a Freescale kernel, if you wanna make a usable ipipe
kernel patch for mx6 cards.
Is it harder to patch 3.0.35 than 3.0.43 ?
I don't understand this I'm confused.
Regards,
Laci
