References: <CAKJ14NcLeYWfjRdLnagFo9ZaukU3Bq8W8sPV1sC4LOD4OUgp8g@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b37fe6c5-6655-920a-5909-1b049d6c3e84@xenomai.org>
Date: Sun, 17 Dec 2017 15:25:49 +0100
MIME-Version: 1.0
In-Reply-To: <CAKJ14NcLeYWfjRdLnagFo9ZaukU3Bq8W8sPV1sC4LOD4OUgp8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTnet fixes - testers needed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andreas Glatz <andi.glatz@gmail.com>, xenomai@xenomai.org

On 12/17/2017 12:01 AM, Andreas Glatz wrote:
>>
>> I pushed a pile of RTnet fixes in a WIP branch of the official repo
>> (wip/rtnet-fixes). Most of them address invalid direct references to
>> user memory from kernel space (instead of properly copying back and
>> forth via the copy_from/to_user interface), which are badly wrong at any
>> rate, even breaking the kernel on SMAP-enabled x86 platforms.
>>
>> Most I/O calls were affected, ioctl, sendmsg and recvmsg. I'm still in
>> the early process of testing the changes gradually, which involves
>> running tests for all socket levels (RAW, DGRAM) and protocols (INET,
>> PACKET) enabled.
>>
>> If you depend on RTnet and want to help with testing, you may want to
>> give this branch a try. Any help with reviewing the changes would be
>> beneficial to the project too.
>>
> 
> I merged the most recent ipipe version for the 4.9.y kernel into
> 4.9.69 and patched it with xenomai 3 from the WIP branch (see snip1
> below). The kernel boots on the Wandboard with an imx.6 quad. I then
> can load the rtnet modules including the rt_fec.ko driver for the FEC
> MAC on the imx.6 SoC (see snip2 below) and rtping works. I compiled
> and started a udp server [1] that I know works on a similar setup with
> the 4.1.y kernel. However, I still see a page domain fault (see snip3
> below). That seems to happen somewhere early on in the rt_udp_bind()
> function.... I'm currently compiling the 4.9 kernel with debug symbols
> to see where it exactly happens. I'll continue looking into it
> tomorrow...
> 

Thanks. You may need that patch:

diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index a3fd496f3..436830341 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -350,7 +350,7 @@ int rt_udp_ioctl(struct rtdm_fd *fd, unsigned int request, void __user *arg)
 {
 	struct rtsocket *sock = rtdm_fd_to_private(fd);
 	const struct _rtdm_setsockaddr_args *setaddr;
-	struct _rtdm_setsockaddr_args *_setaddr;
+	struct _rtdm_setsockaddr_args _setaddr;
 
 	/* fast path for common socket IOCTLs */
 	if (_IOC_TYPE(request) == RTIOC_TYPE_NETWORK)-- 

--
Philippe.

