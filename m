Message-ID: <527ab539f4e846b0f0f03fb5cf3b8f14.squirrel@www.xenomai.org>
In-Reply-To: <CF928888-710A-475C-B58A-D369B8B3C228@mah.priv.at>
References: <22700C72-58CD-4B92-B397-43DFC7943F14@mah.priv.at>
	<c5618ea63b6ec1da7d2fa937467d9f4c.squirrel@www.xenomai.org>
	<CF928888-710A-475C-B58A-D369B8B3C228@mah.priv.at>
Date: Sat, 3 Nov 2012 12:03:58 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Question on rt_timer_tsc() vs rt_timer_read()
 semantics
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org


Michael Haberler wrote:
> - the timedelta module just samples with rtapi_get_time():
>
> http://git.mah.priv.at/gitweb/emc2-dev.git/blob/5979d84f31c0ef8e9dccdb26426732d0b83f3a87:/src/hal/components/timedelta.comp
> (this _is_ a kernel module, it's in preprocessor language).
>
> rtapi_get_time() in turn calls rt_timer_read() here:
> http://git.mah.priv.at/gitweb/emc2-dev.git/blob/5979d84f31c0ef8e9dccdb26426732d0b83f3a87:/src/rtapi/xenomai_kernel_rtapi.c#l657
>
>
> whew, I think I covered it. Is this still comprehensible ;-?

That is a lot to check, so, I am afraid it will be hard to be of any help,
the tracer is probably your only hope.

Just a minor nit though, if you intend to run LinuxCNC on anything else
than x86, you should replace rdtscll with rt_timer_tsc or __xn_rdtsc.


-- 
                    Gilles.


