Date: Fri, 08 Sep 2017 10:08:56 +0000
Message-ID: <20170908100856.Horde.SqkGLUjRRnFYC2FBrqJAifc@office.mrmoco.com>
From: Paul Wilkinson <paul.w@mrmoco.com>
References: <20170907153622.Horde.hT_sRaGS6VmkuifQTO4pqBa@office.mrmoco.com>
 <f9704809-eeea-3ee0-99f6-896ed32200be@siemens.com>
In-Reply-To: <f9704809-eeea-3ee0-99f6-896ed32200be@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Subject: Re: [Xenomai] Questions around porting app to Xenomai/Cobalt
 resulting in SIGABRT ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org


Quoting Jan Kiszka <jan.kiszka@siemens.com>:

>
> Are you running the application as normal user instead of root, or is
> something else taking away permissions (CAP_SYS_NICE) from it?
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA ITP SES-DE
> Corporate Competence Center Embedded Linux


Ordinarily I run the app as a normal user which is a member of the
group saved in /sys/module/xenomai/parameters/allowed_group

However I have tried running it as root, with same failure mode .... as
reflected in the gdb session provided.

Paul.



