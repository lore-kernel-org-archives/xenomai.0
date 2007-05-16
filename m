Message-ID: <cbe23c50705161334xe590352p32ecceb35c6703a4@domain.hid>
Date: Wed, 16 May 2007 22:34:18 +0200
From: "Eric Noulard" <eric.noulard@domain.hid>
In-Reply-To: <17995.26328.303873.229987@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0D1@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01EB2198@domain.hid>
	<17993.62961.195987.37407@domain.hid>
	<cbe23c50705151326v5ce31bcbie877828121059de9@domain.hid>
	<17995.26328.303873.229987@domain.hid>
Subject: Re: [Xenomai-help] memcpy performance on Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

2007/5/16, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> Eric Noulard wrote:
>  >
>  > I was about to say just the same but before developing my idea
>  > I have xenomai question:
>  > Are the share memory region obtained by shm_open
>  > shareable between kernel task and user task just like
>  > rt_heap_create/rt_heap_alloc does (read from the doc).
>
> Well, if you found rt_heaps doc, it would have been easy to have a look
> at posix shared memory doc as well...

I should have said it but in fact I did read the doc
yesterday and didn't find the answer.

I reread it more carefully tonight and find it.
Sorry about that.

> Anyway, yes, on platforms where
> sharing a memory area between kernel space and user-space is not a
> problem, posix shared memory are shareable. On ARM, it is a no go
> because of the cache architecture.

Thank you very much for your answer :))

And please excuse me for my too fast read.
I will read doc more carefully next time.


-- 
Erk

