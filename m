Message-ID: <7f9d2c54f31bb668ad319bd3f924b00b.squirrel@www.xenomai.org>
In-Reply-To: <76d212e3.f7b7.13f5f6a053b.Coremail.ericvic@163.com>
References: <76d212e3.f7b7.13f5f6a053b.Coremail.ericvic@163.com>
Date: Thu, 20 Jun 2013 15:24:29 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rel_imx_3.0.15_12.03.00  CPU Frequency Scaling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ericvic@163.com
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


=C7=B6=C8=EB=CA=BD=B9=A4=B3=CC=CA=A6 wrote:
> I'm trying to build using the instruction from Xenomai package
> (rel_imx_3.0.15_12.03.00) and I'm facing some issues. The kernel does not
> compile when I turn off 'CPU Frequency Scaling' option. I use
> imx5_defconfig from the standard kernel config files. When I let 'CPU
> Frequency Scaling' on, with Xenomai, I have the message on Xenomai
> configuration options, but the build run with success. Do I have to lel
> this option on

First please not that the patches for real_imx_3.0.15 are for imx6q and are
not supposed to work with imx5x. If indeed you want to use this kernel
with imx6q, please use the defconfig for imx6q, not for imx5x. And indeed,
in this case, you have to enable CONFIG_CPUFREQ, but select the
"performance" governor so that the cpu frequency does not change.

--=20
                    Gilles.


