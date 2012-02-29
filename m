Message-ID: <4F4E6603.7060209@domain.hid>
Date: Wed, 29 Feb 2012 18:53:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAH=ipMDXKUmjn87Tw-bwUShQQv5SLgi1sohYKrwDkAQW9wJSLQ@mail.gmail.com>
In-Reply-To: <CAH=ipMDXKUmjn87Tw-bwUShQQv5SLgi1sohYKrwDkAQW9wJSLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai 2.6.0:Linkage Error.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: teoman cengiz <teoman.ondin@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On 02/29/2012 05:16 PM, teoman cengiz wrote:
> Hello;
> 
>    I was using Xenomai 2.4.8 .  My applications were running and I had no
> linkage or run time errors.
> 
>    Due to some necessities ,xenomai 2.6.0. But I can even not  run
> xenomai-2.6.0 default examples such as latency:
> 
> robotlab@domain.hid$ sudo
> ./latency
> /usr/src/xenomai-2.6.0/src/testsuite/latency/.libs/lt-latency: symbol
> lookup error: /usr/src/xenomai-2.6.0/src/skins/native/.libs/libnative.so.3:
> undefined symbol: xeno_current

Do you have the same problem if you run make install and run the
installed latency?

> Also I get errors in rtdm in xenomai-head examples  :
> 
> robotlab@domain.hid$
> ./tut01-skeleton-app
> ./tut01-skeleton-app: symbol lookup error: /usr/xenomai/lib/librtdm.so.1:
> undefined symbol: xeno_bind_skin_opt

You are trying to compile xenomai-head examples with xenomai 2.6. This
will not work. You should try and compile xenomai 2.6 examples. Please
pick them from the git repository as the makefiles were broken in
xenomai 2.6.0 as well. Alternatively, you can apply the following patch:
http://git.xenomai.org/?p=xenomai-2.6.git;a=commitdiff;h=689e0433ab907958f162181d9b8c3b49012dd67a;hp=b10443b256dcc57a6a200572def4adda567d473a

> 
> I get same error from my own application too,
> 
> *I am sure, my flags are correct !
> 
> The makefiles finds all rtdm and native *libraries or what else required..
> 
> So it is not a xeno-config fault. I also tried by hand and edited makefiles
> properly.

It is the makefiles fault: the xeno-config usage has changed in xenomai
2.6. So, you should, as I already told you in three separate mails,
some of which even private, run xeno-config --help to understand the syntax.

The next time you ask the same question, you will either be flamed, or
simply ignored, depending on my mood at the time.

-- 
					    Gilles.

