From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: dovetail vs. ipipe: COW-breaking in copy_pte_range
Message-ID: <3df057f7-cab7-4886-ed46-12084157eb45@siemens.com>
Date: Fri, 23 Oct 2020 14:11:13 +0200
MIME-Version: 1.0
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>, "Meng, Fino" <fino.meng@intel.com>

Hi Philippe,

a merge conflict in 5.4-stable requires me to look into [1]. It states:

>     Revisit: Further COW breaking in copy_user_page() and copy_pte_range()
>     may be useless once __ipipe_disable_ondemand_mappings() has run for a
>     co-kernel task, since all of its mappings have been populated, and
>     unCOWed if applicable.

And if I look into the dovetail baseline commit, this logic is indeed
gone. Did you revisit this and came to the conclusion that it can safely
be dropped? Or did it take other changes in dovetail to make it
obsolete? Would help to resolve [2] if we could simply drop it...

Thanks,
Jan

[1]
https://gitlab.denx.de/Xenomai/ipipe-noarch/-/commit/caa1b5261d0d27d0801ab9d41dfe39d648583a37
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=2c25b951117857d43fdac01fe7bd3894514e6ecf

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

