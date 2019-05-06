Subject: Re: rtdm_task_init vs. supported_cpus
References: <e57c2c94-b593-ecee-6108-097929a96ee7@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <3c94ecae-88ac-0b1b-0d06-153a5107cbb8@xenomai.org>
Date: Mon, 6 May 2019 17:11:21 +0200
MIME-Version: 1.0
In-Reply-To: <e57c2c94-b593-ecee-6108-097929a96ee7@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 5/6/19 5:02 PM, Jan Kiszka wrote:
> Hi Philippe,
> 
> while playing with maxcpus on x86, I ran into one issue again that I
> think I saw already but forgot to dig into back then: When an RTDM
> driver happens to create a kernel task (rtdm_task_init) on a support
> outside of xenomai.supported_cpus, we will crash. That may happen
> because that command is run over module_init, or any other context that
> is not a Xenomai-blessed Linux task with therefore constraint affinity
> mask.
> 
> Any suggestions how to resolve that best? Restrict the affinity of the
> rtdm_task_init caller? Permanently or maybe just temporarily? Or is
> there some way to resolve that deeper inside xnthread_* APIs?
> 

xnthread_pin_initial() may help.


-- 
Philippe.

