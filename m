Subject: Re: (unknown)
References: <20190410111408.18824-1-norbert.lange@andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <29afc873-e249-6060-462c-e0b32afb3416@siemens.com>
Date: Wed, 10 Apr 2019 15:37:17 +0200
MIME-Version: 1.0
In-Reply-To: <20190410111408.18824-1-norbert.lange@andritz.com>
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
To: Norbert Lange <nolange79@gmail.com>, xenomai@xenomai.org

On 10.04.19 13:14, Norbert Lange via Xenomai wrote:
> V3 of the patchset, corrected many checkstyle issues,
> simplified condvar autoinit.
> 

Thanks for the update!

> I did not use ARRAY_SIZE, as that would need another include.
> 

Ah, we do not have this construct in lib/ so far.

There are private ARRAY_LEN macros in lib/analogy/calibration.c and 
utils/analogy/analogy_calibrate.h. Well, something that can be consolidates later.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

