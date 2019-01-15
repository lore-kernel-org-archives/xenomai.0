Subject: Re: [PATCH 1/5] cobalt/intr: vfile: do not assume all irqs are
 cobalt-managed
References: <20190114173522.25750-1-rpm@xenomai.org>
 <85f70313-fccd-7c3f-a5e2-b1b4f2d8219a@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <7b7ef372-05e7-dd49-0b7d-878a72c9adf3@xenomai.org>
Date: Tue, 15 Jan 2019 19:05:32 +0100
MIME-Version: 1.0
In-Reply-To: <85f70313-fccd-7c3f-a5e2-b1b4f2d8219a@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 1/15/19 6:12 PM, Jan Kiszka wrote:
> On 14.01.19 18:35, Philippe Gerum wrote:
>> Non-cobalt kernel code may hook interrupts using ipipe_request_irq()
>> directly, which means that xnintr_vec_first() cannot assume that
>> __ipipe_irq_cookie() always returns a valid xnintr struct for all
>> irqs.
> 
> Is there an out-of-tree use case for that already, or is this rather
> defensive?
> 

I stumbled upon this issue when hooking a device IRQ inside a regular
driver using the pipeline interface, as using xnintr* and friends at
such interface level would be a bad idea. Sometimes we may want to have
pipeline-aware drivers which are not and should not be RTDM-based. We
can't assume what 3rd party drivers are doing or not in this respect.

Once such driver is enabled, reading /proc/xenomai/irq for instance
would start the fireworks.

-- 
Philippe.

