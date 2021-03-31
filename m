Subject: Re: [PATCH 4/8] lib: y2038: convert to internal timespec type
References: <20210327095417.2289913-1-rpm@xenomai.org>
 <20210327095417.2289913-5-rpm@xenomai.org>
 <556e88f0-6b20-ab48-1d22-d0dcf8a2d8f0@siemens.com>
 <87wntnr8y0.fsf@xenomai.org>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Message-ID: <019dc973-21ff-8663-a95f-fce52cd96ff6@siemens.com>
Date: Wed, 31 Mar 2021 17:58:33 +0200
In-Reply-To: <87wntnr8y0.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: chensong@tj.kylinos.cn, Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 31.03.21 11:03, Philippe Gerum wrote:
> 
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> 
>> Hi Philippe,
>>
>> which "internal timespec type" are you talking about?
> 
> struct __user_old_timespec. The one added to make the user / kernel
> boundary wrt time specification explicit.
> 


Thanks! I just overlooked

 struct __sched_rr_param {
-	struct timespec __sched_rr_quantum;
+	struct __user_old_timespec __sched_rr_quantum;
 };

from the first patch of the series. That explains it.

Thanks for all the help and sorry for the noise.

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

