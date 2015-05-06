From: SMITH Peter T <peter.t.smith@alstom.com>
Date: Wed, 6 May 2015 14:22:33 +0000
Message-ID: <92BAB684D31DCD4A8F623A7EE7FD8C06013ED0D5@041-DB3MPN1-092.041d.mgd.msft.net>
References: <92BAB684D31DCD4A8F623A7EE7FD8C06013ED08A@041-DB3MPN1-092.041d.mgd.msft.net>
 <20150506140524.GW1993@hermes.click-hack.org>
In-Reply-To: <20150506140524.GW1993@hermes.click-hack.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Xenomai on Zynq (linux-denx xilinx-zynq-v3.14.17)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles,

So do I need to disable some more kernel configuration options?

Peter

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: 06 May 2015 15:05
To: SMITH Peter T
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] Xenomai on Zynq (linux-denx xilinx-zynq-v3.14.17)

On Wed, May 06, 2015 at 01:50:36PM +0000, SMITH Peter T wrote:
> Hi everyone,
>
> I have successfully built a kernel for Zynq 7020 (on the Xilinx
> ZC702 board) following the instructions on the Xenomai web site.
>
> I have used the linux-denx git (branch xilinx-zynq-v3.14.17) and the
> xenomai-2.6 git (branch master). The kernel boots and I am able to log
> on to the target, so all seems well. I have also made sure that
> CONFIG_CPU_FREQ and CONFIG_CPU_IDLE are not enabled.
>
> I do however, see a strange error message related to [ INFO:
> inconsistent lock state ] in my dmesg output.
>
> My first question is, is this anything to worry about? Is it an
> indication that my build is incorrect.

Yes, in its current form, irq state tracking does not work correctly, and w=
hat is more gets function called in Xenomai domain which should not be call=
ed. So, better disable it altogether. Jan proposed to fix this, but only ca=
me up with an empirically validated implementation which was thus refused. =
This functionality will probably be disabled in the kernel configuration if=
 nobody comes with an implementation which can be proved to cover all the c=
ases.

> My second (and last) question is related to performance. Below is the
> output of the latency test on an unloaded target. Is it normal to see
> negative latencies or is this an indication that something is wrong?

Yes, it means that your system is not correctly calibrated.

--
                                            Gilles.

________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may =
be privileged. If you are not a named recipient, please notify the sender i=
mmediately and do not disclose the contents to another person, use it for a=
ny purpose or store or copy the information in any medium.

