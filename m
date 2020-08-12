Subject: Re: Is the main memory pool same with the private heap?
References: <CAAvDm6aVOcgRkCk8dDYHrGs2Rfe=QcacuJp4=b30rFPjWj4RMQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <425d77d5-93cd-fb73-5f19-aaf83f927ca0@siemens.com>
Date: Wed, 12 Aug 2020 18:03:39 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6aVOcgRkCk8dDYHrGs2Rfe=QcacuJp4=b30rFPjWj4RMQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>, xenomai <xenomai@xenomai.org>

On 06.08.20 10:01, 孙世龙 sunshilong via Xenomai wrote:
> Hi,
> As the subject, are they the same thing:
> * main memory pool, whose size can be set explicitly using --mem-pool-size,
> 1Mb by default
> * private heap, whose size can be set explicitly using
> CONFIG_XENO_OPT_PRIVATE_HEAPSZ.

The former defines a per-process userspace memory pool. The latter is an 
in-kernel resource settings. So they are not the same.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

