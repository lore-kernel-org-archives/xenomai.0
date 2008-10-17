Message-ID: <48F8A908.4010407@domain.hid>
Date: Fri, 17 Oct 2008 17:02:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081016154620.320953568@domain.hid>	<20081016154621.802426487@domain.hid>	<48F7A1A2.3050201@domain.hid>
	<48F7BF9A.4070305@domain.hid>
In-Reply-To: <48F7BF9A.4070305@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 09/12] Optionally replace
 pthread_getspecific with TLS variables
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>
>> The real downside here is a lot of #ifdef clutter. What about the idea
>> of defining an API to abstract the differences between
>> pthread_get/setspecific and __thread and have #ifdef only in one header ?
> 
> Sometimes you only store a value that way, sometimes you also have to
> provide the object that is stored. Then its initialisation is fairly
> specific.
> 
> Everything can be abstracted, but I'm not that optimistic that the
> result will be better readable, just look at the patched users. Or what
> abstractions do you have in mind?

I tried, but I failed. The usage differences in the skins are to
significant to define a generic per-thread wrapper that fits at least a
subset of use cases.

Anyway, I was at least able to eliminate two #ifdefs by converting the
xeno_current_key initialization from pthread_once to a constructor
function (that is under #ifdef anyway). Updates will follow.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

