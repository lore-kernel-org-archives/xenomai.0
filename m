From: "Proctor, Frederick M. (Fed)" <frederick.proctor@nist.gov>
Subject: IPIPE patch causes hang during initrd boot; Ubuntu 18 desktop system
Date: Fri, 7 Jun 2019 13:02:46 +0000
Message-ID: <SN6PR09MB3069382F832609A66E69622A80100@SN6PR09MB3069.namprd09.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I am installing Xenomai + Cobalt with the IPIPE patch on a Ubuntu
18-based x86/64 desktop system. I have these versions:

Linux kernel 4.14.71 PREEMPT_RT patch 4.14.71-rt44 IPIPE 4.14.71

I have compiled the kernel three different ways: the stock
configuration, with the PREEMPT_RT patch, and with the IPIPE patch (no
PREEMPT_RT). I have configured out the ACPI processor, CPU_FREQ, and
CPU_IDLE options in all cases. The first two boot fine (stock kernel,
PREEMPT_RT). The IPIPE-patched kernel hangs during the initrd loading
phase.

I've tailored the kernel configuration somewhat based on the
hardware I have, but nothing has worked to get a booting IPIPE kernel.

Does anyone have guidance on setting up the IPIPE patch on an x86/64
kernel on a desktop Ubuntu 18 machine? I am planning on continuing to
trim down the kernel config options, but before I do this, I want to
ask this group if anyone has had a similar problem.

