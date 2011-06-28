Message-ID: <4E09EE85.4040005@domain.hid>
Date: Tue, 28 Jun 2011 17:08:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTi=2WnfLFC9DVQY81obGPO6_CG_PCA@mail.gmail.com>	<4E086122.7060405@domain.hid>	<BANLkTimCab2u0EOrJ6JtLTVLNAzktbvFQg@domain.hid>	<4E09D243.4050706@domain.hid>
	<BANLkTimTquz4n7qMzRd05gWAi6rkMmc2gw@domain.hid>
In-Reply-To: <BANLkTimTquz4n7qMzRd05gWAi6rkMmc2gw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Program hangs using "rt_task_sleep" in a
 particular way
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Adrien LEMAITRE <adrien.lemaitre@domain.hid>
Cc: xenomai@xenomai.org

On 06/28/2011 04:02 PM, Adrien LEMAITRE wrote:
> Hi,
> 
> Thanks for your answer.
> 
> 2011/6/28 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> 
>> The problem is that the "rt_task_spawn" service causes its caller to
>> switch to secondary mode. This means, that the task is no longer real-time.
>>
> 
> I wasn't aware of this fact. It could be annoying if we have to create
> several RT Tasks...
> It's only true for rt_task_spawn or for all Xenomai services ?

Which services stay in primary mode, and which services switch to
secondary mode is documented in the API documentation:
http://www.xenomai.org/documentation/xenomai-2.5/html/api/index.html

> 
> A better practice will to first make several rt_task_create and after
> activate them by rt_task_start services?

Probably. But if these tasks use 100% cpu and never let linux run, you
will have other problems later (the first being that the system will no
longer respond to non real-time activities such as the consoles, the
graphic system, etc...).

> 
> 
> 
>> Normally, root thread priority coupling should allow to avoid that.
>> Unfortunately, there is a small hole in this functionality which make it
>> not work in some conditions (and fixing this hole would introduce a
>> possibility of priority inversion).
>>
> My advisor (jerome Delatour from ESEO) want to better understand this point,
> where could I find explanations on this point ?

This is a point discovered recently, see the thread starting here:
https://mail.gna.org/public/xenomai-help/2011-03/msg00165.html

-- 
					    Gilles.

