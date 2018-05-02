References: <C2EC5BA46D13CD44B5915A8FEEB4C44E8A2D2291@DDCEXCH.ddc-ny.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <70acf08c-e861-c18b-c0f8-b60cc7571084@siemens.com>
Date: Wed, 2 May 2018 07:34:03 +0200
MIME-Version: 1.0
In-Reply-To: <C2EC5BA46D13CD44B5915A8FEEB4C44E8A2D2291@DDCEXCH.ddc-ny.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] potentially missing timer rating check in
 select_root_only_timer()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Pham, Phong" <phamp@ddc-web.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "Hillman, Robert" <hillman@ddc-web.com>

Hi Phong,

On 2018-05-02 03:13, Pham, Phong wrote:
> Hi,
> 
> I am suspecting that in kernel/ipipe/timer.c:select_root_only_timer()
> 
> When t->irq == per_cpu(ipipe_percpu.hrtimer_irq, icpu), a condition to test the timer rating against current timer rating before installing the timer is missing.  That is t->rating > percpu_timer->rating (combined with same irq #) before the condition becomes true.

Conceptually, I-pipe timers should have highest rating. Can you explain
in more details why it should be there?

Also note that your own code looks suspicious: percpu_timer is a per-cpu
variable but is not accesses as such.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

