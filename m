Message-ID: <528A19A6.4010506@xenomai.org>
Date: Mon, 18 Nov 2013 14:44:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1ViO8p-0004L8-4y@sd-51317.dedibox.fr>
In-Reply-To: <E1ViO8p-0004L8-4y@sd-51317.dedibox.fr>
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
To: xenomai@xenomai.org

On 11/18/2013 01:41 PM, git repository hosting wrote:
> Module: xenomai-jki
> Branch: for-forge
> Commit: 3e6d8ff9a99262e78655329dc043aacc607eb158
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=3e6d8ff9a99262e78655329dc043aacc607eb158
>
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Mon Nov 18 13:19:34 2013 +0100
>
> switchtest: Account for invalid last_switch.from field
>
> If we close a test device early, no switch may have yet taken place when
> the first call to rtswitch_to_rt/nrt happens. This can cause to_idx to
> become -1, and the system will crash. Handle this corner case
> gracefully.

I do not see how this can happen at all. Normally all the tasks are 
destroyed and joined in rtswitch_close using rtdm_task_destroy / 
rtdm_task_join. So, there is probably another problem.


-- 
					    Gilles.

