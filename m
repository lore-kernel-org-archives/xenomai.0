Message-ID: <53748B83.10003@xenomai.org>
Date: Thu, 15 May 2014 11:40:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <tencent_78F888AD0086A46145B8F379@qq.com>
In-Reply-To: <tencent_78F888AD0086A46145B8F379@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai consulting
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5YWo5pa55L2N55qE6ZmN5Li0?= <853121005@qq.com>, xenomai <xenomai@xenomai.org>

On 05/15/2014 05:43 AM, 全方位的降临 wrote:
> Dear friend： I am so glad to use the Xenomai in my development
> board.My development board is Zedboard,Zedboard belongs to the Xilinx
> company's zynq series and i see the Xenomai has the zynq patch.The
> name of patch are ipipe-core-3.8-zynq-pre.patch and
> ipipe-core-3.8-zynq-post.patch. The official Zedboard only provides
> 3.6 version of the Linux kernel，so i don't have the 3.8 version of
> the Linux Kernel of Zedboard.When I am trying to patch the 3.6 kernel
> using ipipe-core-3.8-zynq-pre.patch,it tells me that
> prepare-kernel.sh: Unable to patch kernel 3.6.0-digilent-13.01 with
> ipipe-core-3.8-zynq-pre.patch. Please tell me what's different
> betweent these two patch,how should I slove this problem. Thank you
> very much.

The only way to solve this is to port the I-pipe patch to the 3.6
kernel, because patches provided by the Xenomai project do not cover
this kernel. You can start from the patches for the 3.5 kernel, this is
what is the most close to 3.6. Do not expect the patches to apply
cleanly, some work is needed, if you really want to use 3.5.

-- 
                                                                Gilles.

