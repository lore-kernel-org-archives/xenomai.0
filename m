Message-ID: <4A60A5B5.3090604@domain.hid>
Date: Fri, 17 Jul 2009 18:24:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <D2793D9B-14B5-493B-9D5E-B9E4F60F8761@domain.hid>
In-Reply-To: <D2793D9B-14B5-493B-9D5E-B9E4F60F8761@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RT_PREEMPT patch and other things...
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Andreas Glatz <andi.glatz@domain.hid>
Cc: xenomai@xenomai.org

Andreas Glatz wrote:
> Hi,
> 
> I have some questions about the future of Xenomai:
> 
> 1) I read that in Xenomai 3 you will add support to switch between  
> the native Xenomai scheduler
>       and the Linux scheduler patched with the RT_PREEMPT patchset.  
> When are you planning to
>       start this development?
> 

There are some early components available, see
http://git.denx.de/?p=xenomai-solo.git and
http://git.xenomai.org/?p=rtdm-native.git.

> 2) Is it right to say that when Xenomai runs on top of the patched  
> Linux scheduler we will still
>       have the native API with all it's nice features like RT_QUEUE  
> and RT_PIPE?

Yes, the plan is to allow easy code migration between both RT models,
and that would include code written for the Native skin.

> 
> 3) Have you ever heard about a Xenomai/IPIPE port to m68k?

I had some chat with the guy who is working on RTAI for m68k, which
included writing some I-pipe-like patch. Unfortunately there was not
much drive visible to push that part upstream. But it's released now, so
someone else could pick that task up.

> 
> 4) What are the most important conferences/summits/... for Xenomai  
> developers?

E.g. RTLWS [1]. At least /me plans to attend (though on a non-Xenomai
topic).

> 
> Greetings from the Linux Symposium in Montreal,
> 
> Andreas (Ruggedcom Inc.)

Jan

[1] http://www.osadl.org/Dresden-2009.rtlws11-dresden-2009.0.html

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

