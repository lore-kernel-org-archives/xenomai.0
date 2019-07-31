Subject: Re: Updating the r8169 driver
References: <CAPnNZ0Wp-VTyiEt9Bh7vkKbbUAUDLTkK92TVLar8CVsdaendVQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c80d1e45-d28a-d3cd-fe86-3d0275f77201@siemens.com>
Date: Wed, 31 Jul 2019 11:35:17 +0200
MIME-Version: 1.0
In-Reply-To: <CAPnNZ0Wp-VTyiEt9Bh7vkKbbUAUDLTkK92TVLar8CVsdaendVQ@mail.gmail.com>
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
To: Antoine Hoarau <antoine@flr.io>, xenomai@xenomai.org

On 30.07.19 22:53, Antoine Hoarau via Xenomai wrote:
> Hi all,
> I have a setup where I need an updated r8169.
> I started updating the (very) old one provided with rtnet with the cards
> from linux 2.6 (the code is quite similar). Attached the first draft,
> (highly) experimental.
> In the end I need an even more up to date version, so I'll start from the
> 4.19 when I can, but the code is completely different. I'm really wondering
> why this driver would need to be completely re-written at every kernel
> version, but anyways.
> I see the e1000e just got updated, anyone working on updating this
> particular driver ?

Not to my knowledge. Updates are wellcome, just please ensure they are formatted
as patch in the end and build against 4.4 up to latest supported kernel
(currently 4.19). See also contributing.md. BTW, if you want to avoid building
your own compilation environment, fork our mirror on github [1] and activate
travis-ci for it.

Thanks!
Jan

[1] https://github.com/xenomai-ci/xenomai

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

