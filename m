References: <CAPN7LrHBjkFqi8x3KGmZDn810GuYTij4gpyQc1pxhFMiifdycQ@mail.gmail.com>
 <CAPN7LrGe_wmRLdbvdcznMMqeyo1PgbrZnyUKVCWbfZAuF+t75A@mail.gmail.com>
 <20180926142128.4a127510@md1pvb1c.ad001.siemens.net>
 <CAPN7LrFNhNHoyPBW387vC15GF4n7JKyUKqVR2f1wZ3an67XQPg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4cbf5f1c-0381-8fcd-9e52-1221ca8e1b11@siemens.com>
Date: Wed, 26 Sep 2018 20:25:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAPN7LrFNhNHoyPBW387vC15GF4n7JKyUKqVR2f1wZ3an67XQPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe 4.14 causing kernel stuck at "Loading initial
 ramdisk...", failed to boot on x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: c ww <cww230@gmail.com>
Cc: Henning Schild <henning.schild@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 26.09.18 18:01, c ww wrote:
> Hi Henning,
> Awesome, now the kernel compilation looks great and no more fpu errors. But
> one thing i noticed, in the unreleased xenomai 'next' branch it seems the
> configure file is missing. In this case, are there different method to
> configure the xenomai prior to install it?

When you work against the Xenomai git tree, you need to call scripts/bootstrap 
first. It will generate the files that are only part of the release tarball (we 
do not version-control generated artifacts).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

