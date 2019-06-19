Subject: Re: Preview: 4.19-x86 support
References: <4a035faa-d1f8-d2ed-9351-192cea2d79eb@siemens.com>
 <57789334.2591537.1560892805627@mail.yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <82b7acc0-17d4-0c8c-8130-c2a9156cf739@siemens.com>
Date: Wed, 19 Jun 2019 08:23:34 +0200
MIME-Version: 1.0
In-Reply-To: <57789334.2591537.1560892805627@mail.yahoo.com>
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
To: Alec Ari <neotheuser@ymail.com>, Xenomai <xenomai@xenomai.org>

On 18.06.19 23:20, Alec Ari wrote:
> Hi, a bit OT: How hard is it for you guys to re-write IPIPE on top of the latest 
> entry_64.S file? I mean, every few kernel releases, especially when 
> KAISER/RETROLINE was introduced, that file changed dramatically. Is x86 assembly 
> programming easy for you Jan and Philippe? You're both extremely good at what 
> you do.

The Spectre/Meltdown fixes were actually widely orthogonal to I-pipe. Porting to 
4.19 had a few conflicts in the entry code, but nothing that was awfully hard to 
resolve when looking at the old I-pipe patch and the changes to that file in 
mainline since then.

Thanks to Philippe's rework of the patch queue, we have a functional split-up 
now that helps rebasing the patches. It can and will be further improved, but it 
is already valuable, hopefully also for other contributors: We definitely need 
more people on these kernel topics.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

