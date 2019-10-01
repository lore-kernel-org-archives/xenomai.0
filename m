Subject: Re: Kernel crash at startup when enabling RTNet + RTIPv4
References: <b7f-5d934f00-47-344a2840@235460637>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4e3b24df-a9ce-f860-081c-f4fc29ea16db@siemens.com>
Date: Tue, 1 Oct 2019 15:10:30 +0200
MIME-Version: 1.0
In-Reply-To: <b7f-5d934f00-47-344a2840@235460637>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>, xenomai@xenomai.org

On 01.10.19 15:04, François Legal via Xenomai wrote:
> 
> Hello list,
> 
> I've been struggling to get the RTNet + RTIPv4 part to work on a Zynq 7000 board. Using source code from stable Xenomai 3.0.9 tarball, and patching a vanilla 4.4.189 linux.
> I consistently had the kernel crash (0 pointer dereference error) at startup when enabling either RTIPv4, RTCFG or RTMAC.
> 
> I finally found that there "might" be a problem with the Makefile in kernel/drivers/net/stack.
> It turns out that (on my system at least), the order in which the protocol stacks appear in the Makefile is wrong because (I running a kernel with everything builtin, no modules) the protocols are loaded in that order, and thus, (in my case) RTIPv4 gets initialized before stack_mgr does which cause it to fail while registering (calling __rtdev_add_pack with a not initialized rt_packets array).
> 
> When I reorder the protocols in the Makefile, everything works flawlessly.
> 
> I can provide a patch if this needs to be fixed.
> 

Upstream does not support built-in RTnet. I suspect we need to sort this and 
more issues out systematically in order to permit that. Also, the glue scripting 
will need adjustments because of assumptions that RTnet comes in modules.

That said, contributions in that directions are welcome!

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

