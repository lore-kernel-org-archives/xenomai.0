Subject: Re: Slow path detected in RTCAP
References: <7230-5e7a3000-1f-4d48c480@89258041>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5126083f-9855-158e-c039-984032fe05ee@siemens.com>
Date: Tue, 24 Mar 2020 18:01:20 +0100
MIME-Version: 1.0
In-Reply-To: <7230-5e7a3000-1f-4d48c480@89258041>
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

On 24.03.20 17:05, François Legal via Xenomai wrote:
> Hello,
> 
> I'm trying to port an old application that used to be running on DSPBIOS to Xenomai, using RTNET for the network part.
> I'm getting some weird results with semaphores, but before that I got that debug dump :
> 
> [   49.201310] WARNING: CPU: 0 PID: 958 at /home/dev/UCC/linux-4.4.189/kernel/ipipe/core.c:1912 __ipipe_post_work_root+0xe8/0xfc()
> [   49.214809] CPU: 0 PID: 958 Comm: Maître de Rés Not tainted 4.4.189 #47
> [   49.222636] Hardware name: Xilinx Zynq Platform
> [   49.227791] I-pipe domain: Xenomai
> [   49.231705] [<c00159e8>] (unwind_backtrace) from [<c0012e24>] (show_stack+0x10/0x14)
> [   49.240511] [<c0012e24>] (show_stack) from [<c0222798>] (dump_stack+0x104/0x120)
> [   49.248887] [<c0222798>] (dump_stack) from [<c0025568>] (warn_slowpath_common+0x80/0xb0)
> [   49.258162] [<c0025568>] (warn_slowpath_common) from [<c0025660>] (warn_slowpath_null+0x1c/0x24)
> [   49.268172] [<c0025660>] (warn_slowpath_null) from [<c008b7bc>] (__ipipe_post_work_root+0xe8/0xfc)
> [   49.278344] [<c008b7bc>] (__ipipe_post_work_root) from [<c00a4df0>] (rtdm_nrtsig_pend+0x24/0x2c)
> [   49.288219] [<c00a4df0>] (rtdm_nrtsig_pend) from [<c034e2c8>] (rtcap_xmit_hook+0x150/0x1bc)
> [   49.297550] [<c034e2c8>] (rtcap_xmit_hook) from [<c033fc64>] (rtdev_locked_xmit+0x28/0x3c)
> [   49.307010] [<c033fc64>] (rtdev_locked_xmit) from [<c0340be4>] (rtdev_xmit+0x38/0x84)
> [   49.315871] [<c0340be4>] (rtdev_xmit) from [<c034935c>] (rt_packet_sendmsg+0x2d4/0x304)
> [   49.324865] [<c034935c>] (rt_packet_sendmsg) from [<c00a6380>] (rtdm_fd_sendmsg+0x80/0x98)
> [   49.334205] [<c00a6380>] (rtdm_fd_sendmsg) from [<c00aa0d8>] (CoBaLt_sendmsg+0x78/0xa4)
> [   49.343275] [<c00aa0d8>] (CoBaLt_sendmsg) from [<c00b602c>] (handle_head_syscall+0x168/0x320)
> [   49.352953] [<c00b602c>] (handle_head_syscall) from [<c000f9d0>] (local_restart+0x20/0x44)
> [
> 
> The indicated thread "Maître de Rés" is a xenomai posix thread.
> 
> I see that the call stack includes RTCAP code, and I checked that this does not happen when RTCAP is disabled in kernel build. Anyway, Is this slow path to be expected in RTCAP ?
> 

This issue is supposed to be fixed in 3.1 via b2f253fd21b8. Are you on 
3.0.x? If you could try out a backport, we could merge that into stable 
as well.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

