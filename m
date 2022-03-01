Message-ID: <48156ea9-7f01-b172-a21d-a518687bd824@siemens.com>
Date: Tue, 1 Mar 2022 08:24:37 +0100
MIME-Version: 1.0
Subject: Re: Question about apply xenomai patch to RT kernel
Content-Language: en-US
References: <CAPEvDeBTsSZRW3jBZZnwmyV4fUMNDvohGHsPxX=kj_9kRHLoHQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAPEvDeBTsSZRW3jBZZnwmyV4fUMNDvohGHsPxX=kj_9kRHLoHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: FJKONG <bh1scw@gmail.com>, xenomai@xenomai.org

On 01.03.22 02:23, FJKONG via Xenomai wrote:
> Hi all,
> 
> I am trying to apply xenomai patch to RT kernel, but there are some
> conflicts.
> I am not sure if xenomai can works with RT kernel, or should I remove RT
> from kernel and then apply xenomai patch.
> what is the right way to fix this?

The easiest path forward right now is likely using 5.15 (with dovetail
patch), maybe even 5.16. There, the conflicts should be much smaller
than with older kernels where the remaining RT patch was much larger.
But I don't have information about recent attempts to make this working,
so there might be additional issues.

Which version did you try?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

