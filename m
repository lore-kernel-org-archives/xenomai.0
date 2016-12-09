References: <5e3ba13de86d172dfe04.1481033431@devws148.be.alcatel-lucent.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b902d6f1-446d-adac-5f60-938117ce5f21@xenomai.org>
Date: Fri, 9 Dec 2016 12:07:28 +0100
MIME-Version: 1.0
In-Reply-To: <5e3ba13de86d172dfe04.1481033431@devws148.be.alcatel-lucent.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] copperplate/mercury: introduce tunable to set
 max priority
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>, xenomai@xenomai.org

On 12/06/2016 03:10 PM, Ronny Meeus wrote:
> This patch introduces a tunable in the mercury copperplate code that allows
> to put an upper limit on the priority used by the created thread objects.
> 
> Before this patch the complete OS scheduler's FIFO range was used and it was
> not possible to restrict it. Restricting it can be useful in case other
> activities (typically platform related things) need to get a higher priority
> than the application threads.
> 
> The following tuneable can be used to configure the max priority to be 92:
> set_config_tunable(sched_max_prio, 92);
> 

The patch should only affect Mercury, not Cobalt. We may need some
CONFIG_XENO_MERCURY #ifdeffery here.

-- 
Philippe.

