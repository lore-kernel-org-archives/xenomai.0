Subject: Re: Why heapmem is the first choice for memory management on
 Xenomai-v3.1.0 whereas xenomai-v3.0.9 prefers to use TLSF?
References: <CAAvDm6ZRrnwDLDtK48hTuJQ7UFSn0_fYhH-yKeimK=X741_QsA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f0b1b0f5-2897-7a83-a0d2-f6166b59384d@siemens.com>
Date: Thu, 13 Aug 2020 15:13:50 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6ZRrnwDLDtK48hTuJQ7UFSn0_fYhH-yKeimK=X741_QsA@mail.gmail.com>
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

On 13.08.20 15:07, 孙世龙 sunshilong via Xenomai wrote:
> Hi, list
> 
> As the subject, could you shed some light on this question?
> Are there some potential problems when using TLSF?
> 

Such questions should generally by answered in the git history. Did you 
search for it there already? Have a look at 
dc63a21a2580ee45949cf242cd0e6689e7f043e2 specifically.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

