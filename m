Message-ID: <46262FE2.3010908@domain.hid>
Date: Wed, 18 Apr 2007 16:49:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <46261AC8.5080803@domain.hid>
In-Reply-To: <46261AC8.5080803@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] version of __ipipe_restore_pipeline_head
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jean-Luc Pamart <jlpamart@domain.hid>
Cc: xenomai@xenomai.org

Jean-Luc Pamart wrote:
> (...)
> realtimedriver: disagrees about version of symbol 
> __ipipe_restore_pipeline_head
> realtimedriver: Unknown symbol __ipipe_restore_pipeline_head
> 
> My configuration :
> xeno 2.3
> hal 1.6-03

I hope you mean Adeos I-pipe 1.7-03, right ?

> My linux version is 2.6.19
> 
> 
> We have __ipipe_restore_pipeline_head symbol in
> the kernel :
> 
> c013f7b0 T __ipipe_restore_pipeline_head
> c013f7b0 U __ipipe_restore_pipeline_head    [xeno_native]
> c013f7b0 U __ipipe_restore_pipeline_head    [xeno_nucleus]
> c013f7b0 U __ipipe_restore_pipeline_head    [xeno_rtdm]
> c013f7b0 U __ipipe_restore_pipeline_head    [xeno_posix]
> 
> but the module realtimedriver I want to insmod has
> been builded with the same sources.
> 
> 
> So what may I do ?

You likely changed a kernel option and recompiled the kernel without
recompiling the "realtimedriver" module. Try recompiling the module.

-- 
                                                 Gilles Chanteperdrix

