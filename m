Message-ID: <5527E771.6070601@denx.de>
Date: Fri, 10 Apr 2015 17:08:33 +0200
From: Stefan Roese <sr@denx.de>
MIME-Version: 1.0
References: <203841149.1070671428676190916.JavaMail.httpd@webmail-27.iol.local>
In-Reply-To: <203841149.1070671428676190916.JavaMail.httpd@webmail-27.iol.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai]
 =?utf-8?q?=5BPATCH=5D_hal/arm=3A_Add_Zynq_v3=2E14=2E17_?=
 =?utf-8?q?patches=E2=80=8F?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "claudio.lorini@libero.it" <claudio.lorini@libero.it>, xenomai@xenomai.org

On 10.04.2015 16:29, claudio.lorini@libero.it wrote:
> On Wed, Jan 21, 2015 at 04:05:43PM +0100, Stefan Roese wrote:
>> Xilinx Zynq is already supported in the mainline Xenomai git repository.
>> This patch adds support for the v3.14.17 Linux Kernel with the latest
>> arm-6 i-pipe patch additionally to the already present v3.5 and v3.8
>> support...
> 
> Hello,
> can someone indicate a specific branch of the linux-xlnx git repo to use?
> I've tried to apply to the one with tag 'xlnx_3.14' without success
> and the README brings no information yet, (the last and only linux version
> i succeeded in patching is the 3.8).
> thanks, Claudio.

The README mentions says:

---- Zynq (v3.14.17)

1- Checkout the "xilinx-zynq-v3.14.17" branch from the DENX Linux git
   repository [2]
2- apply zynq/ipipe-core-3.14.17-zynq-pre.patch
3- apply ipipe-core-3.14.17-arm-*.patch
4- apply zynq/ipipe-core-3.14.17-zynq-post.patch
5- you can resume to generic installation instructions.

[2] git://git.denx.de/linux-denx.git

So please use this git repo as a base:

http://git.denx.de/?p=linux-2.6-denx.git;a=shortlog;h=refs/heads/xilinx-zynq-v3.14.17

HTP.

Thanks,
Stefan


