References: <6f474cec-909e-f230-73ff-b3b1fcf9c555@siemens.com>
 <20171012124935.24781-1-christoph.muellner@theobroma-systems.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <642936d6-2e75-39e9-e9c2-e600e6bfae72@xenomai.org>
Date: Thu, 19 Oct 2017 11:46:14 +0200
MIME-Version: 1.0
In-Reply-To: <20171012124935.24781-1-christoph.muellner@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] ipipe: gicv3: [v3] Enable interrupt
	pipelining.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Christoph Muellner <christoph.muellner@theobroma-systems.com>, jan.kiszka@siemens.com, dmitriy@oss-tech.org, xenomai@xenomai.org

On 10/12/2017 02:49 PM, Christoph Muellner wrote:
> This patch enables interrupt pipelining for ARM/ARM64 SoC with a
> GICv3 interrupt controller.
> 
> The patch was tested on a Rockchip RK3399 (ARM64 SoC) with
> Linux 4.12.14, I-pipe 4.11-arm64 and Xenomai/Cobalt 3.1 (next).
> xeno-test did not show any errors/fails and latency ran
> 72 hours in a row.
> 
> [v2]: Add I-pipe locking and the forwarding calls for locking/unlocking
> the IRQ in case of masking/unmasking.
> 
> [v3]: Using hard_cond_* instead of #ifdef'd hard_local_*.
> 
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>

Merged, thanks.

-- 
Philippe.

