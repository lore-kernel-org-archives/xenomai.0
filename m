Message-ID: <528A5170.4070609@xenomai.org>
Date: Mon, 18 Nov 2013 18:42:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1ViO8p-0004L8-4y@sd-51317.dedibox.fr>
 <528A156C.1070501@xenomai.org> <528A21A9.9050502@siemens.com>
 <528A2486.4030606@xenomai.org> <528A2567.2000105@siemens.com>
 <528A27AF.3060608@xenomai.org> <528A2BB3.9040902@siemens.com>
 <528A2F96.7080302@xenomai.org> <528A3918.4000902@siemens.com>
 <528A3CEB.80909@xenomai.org> <528A446C.5060409@siemens.com>
 <528A4737.8040607@siemens.com>
In-Reply-To: <528A4737.8040607@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : switchtest: Account for
 invalid last_switch.from field
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On 11/18/2013 05:58 PM, Jan Kiszka wrote:
> Bailing out from rtswitch_pend_rt remains correct and necessary (with
> the new RTDM semantics): rtdm_task_destroy will now kick us out of the
> rtdm_even_wait, and that at a time where no switch happened yet.

So, you also have to check rtswitch_to_rt return value, and return in 
that case as well.


-- 
					    Gilles.

