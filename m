From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4BCC619E.2@domain.hid>
References: <4BCC619E.2@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 19 Apr 2010 17:06:26 +0200
Message-ID: <1271689586.16659.123.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC] fix XENO_OPT_DEBUG bugs.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

On Mon, 2010-04-19 at 15:58 +0200, Gilles Chanteperdrix wrote:
> Hi,
> 
> I found some code which was referencing directly some
> CONFIG_XENO_OPT_DEBUG_ variables with things like:
> 
> #ifdef CONFIG_XENO_OPT_DEBUG_FOO
> 
> This usage is incompatible with the pre-requisites of the assert.h
> header that CONFIG_XENO_OPT_DEBUG_FOO should be defined at all times.
> While grepping for CONFIG_XENO_OPT_DEBUG_, I found that we also have
> many duplicates of construction like:
> #ifndef CONFIG_XENO_OPT_DEBUG_FOO
> #define CONFIG_XENO_OPT_DEBUG_FOO 0
> #endif /* CONFIG_XENO_OPT_DEBUG_FOO */
> 
> So, a patch follows which:
> - replace the #ifdef with some #if XENO_DEBUG(FOO)
> - move all the initializations to assert.h
> 

Yes, that makes a lot of sense. Declaring DEBUG options locally was a
sloppy fix for this annoying issue I used a lot myself. This has to be
centralized somewhere.

> This will make any reference to CONFIG_XENO_OPT_DEBUG_FOO outside of
> assert.h suspicious, and easy to detect.
> 
> Thanks in advance for any comments.
> Regards.
> 


-- 
Philippe.



