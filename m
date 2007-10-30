MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18215.45291.872538.68005@domain.hid>
Date: Tue, 30 Oct 2007 23:32:11 +0100
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB025E424A@is-hdq-exchange.marel.net>
References: <1192524631.6045.23.camel@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB025E41E8@domain.hid>
	<2ff1a98a0710300247q3df99efbybb4ad9a03b7fdf6@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB025E424A@is-hdq-exchange.marel.net>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] [Xenomai-core] Xenomai v2.4-rc4
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

Daniel Schnell wrote:
 > Gilles Chanteperdrix wrote:
 > > On 10/30/07, Daniel Schnell <daniel.schnell@domain.hid> wrote:
 > >> However we think there might be a problem with
 > >> pthread_cond_timedwait() in the POSIX skin.
 > >> It seems that after return of ETIMEOUT the mutex is not acquired
 > >> again by the function automatically
 > > 
 > > Ok, do you still observe the same behaviour with the attached patch ?
 > 
 > No, this patch fixes the issues. Thanks.
 > 
 > 
 > Was the segmentation fault corelated to that fix or is it still waiting
 > somewhere ?

The segmentatino fault was due to a cleanup handler "pthread_cleanup_push"ed by
__wrap_pthread_cond_timedwait that was not pthread_cleanup_poped in the
error case.

-- 


					    Gilles Chanteperdrix.

