Subject: Re: [ipipe][PULL] x86 update to 4.4.158
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <688c02d5-bcd2-f43c-7e7a-af4e586919b4@siemens.com>
Message-ID: <fe475c4a-52bc-766d-4fbc-2b6aa1e8fcd6@siemens.com>
Date: Tue, 30 Oct 2018 14:40:26 +0100
MIME-Version: 1.0
In-Reply-To: <688c02d5-bcd2-f43c-7e7a-af4e586919b4@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 27.09.18 19:05, Jan Kiszka wrote:
> The following changes since commit f4dfbe3f8ecff040c66cd13c49861bb4cb3a2009:
> 
>    ipipe: fix preemption damage in hard_preempt_enable() (2018-03-26 19:30:20 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.denx.de/Xenomai/ipipe-x86.git for-upstream/4.4
> 
> for you to fetch changes up to 9e6ffc487727f214e510c746ebc1a36538530170:
> 
>    Merge tag 'v4.4.158' into for-upstream/4.4 (2018-09-27 08:40:17 +0200)
> 
> This has been tested on x86-64 so far.
> 
> ----------------------------------------------------------------
> (removing all upstream stable commits)
> 
> Henning Schild (1):
>        x86: make fpu switching eager
> 
> Jan Kiszka (11):
>        Merge tag 'v4.4.109' into for-upstream/4.4-update
>        x86/ipipe: Disable access_ok context under I-pipe
>        Merge tag 'v4.4.120' into for-upstream/4.4-update
>        Merge tag 'v4.4.126' into for-upstream/4.4-update
>        Merge tag 'v4.4.131' into for-upstream/4.4-update
>        Merge tag 'v4.4.136' into for-upstream/4.4-update
>        Merge tag 'v4.4.137' into for-upstream/4.4-update
>        x86/ipipe: Fix kgdb hook skipping
>        Merge tag 'v4.4.138' into for-upstream/4.4
>        Merge tag 'v4.4.157' into for-upstream/4.4
>        Merge tag 'v4.4.158' into for-upstream/4.4
> 
Resolved as I merged this along with further updates. Same for 4.9.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

