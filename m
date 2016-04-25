References: <E1aq1Ri-0002Ry-RW@sd-51317.xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <571E312A.9040903@siemens.com>
Date: Mon, 25 Apr 2016 17:00:58 +0200
MIME-Version: 1.0
In-Reply-To: <E1aq1Ri-0002Ry-RW@sd-51317.xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Philippe Gerum : lib/cobalt: add config switch to
 enable lazy setsched update mode
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

On 2016-04-12 18:45, git repository hosting wrote:
> Module: xenomai-3
> Branch: wip/dovetail
> Commit: 867070475384652b4e3d4a25f5ad983732a59a7e
> URL:    http://git.xenomai.org/?p=xenomai-3.git;a=commit;h=867070475384652b4e3d4a25f5ad983732a59a7e
> 
> Author: Philippe Gerum <rpm@xenomai.org>
> Date:   Sun Mar 20 17:58:33 2016 +0100
> 
> lib/cobalt: add config switch to enable lazy setsched update mode
> 
> --enable-lazy-setsched should be given for enabling lazy propagation
> of scheduling parameters upon calls to pthread_setschedparam*(),
> sched_setscheduler(). Defaults to off.

Missed this so far: Is there particular reason to keep it off by
default? Regression concerns (i.e. this will be only off in the
beginning) or downsides of the lazy implementation?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

