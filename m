Message-ID: <53BFD255.203@xenomai.org>
Date: Fri, 11 Jul 2014 14:02:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53BF7A2A.7020302@siemens.com>
In-Reply-To: <53BF7A2A.7020302@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Inconsistent traced Linux IRQ state on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 07/11/2014 07:46 AM, Jan Kiszka wrote:
> Gilles,
> 
> we see an warning about an inconsistency of the Linux IRQ state on ARM
> with CONFIG_PROVE_LOCKING and, thus, CONFIG_TRACE_IRQFLAGS. I just
> browsed code and history and stumbled over 11a959bf53 ("ipipe/arm:
> disable calls to trace_hardirqs_(on|off) from assembly", ipipe-3.4.6),
> the only obvious related delta between vanilla and the ipipe kernel. Can
> you comment on both why you disabled it and if you think it could
> explain our observation?

I have no idea, could you try reverting the commit and see if it changes
anything?

-- 
                                                                Gilles.

