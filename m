Message-ID: <492429F8.2090309@domain.hid>
Date: Wed, 19 Nov 2008 16:00:08 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <42B0FA09DE79461986CBEE046DEF3B87@domain.hid>
In-Reply-To: <42B0FA09DE79461986CBEE046DEF3B87@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Does Valgrind work with Xenomai?
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rob@domain.hid
Cc: xenomai@xenomai.org

Robert McCullough wrote:
> Hi,
> 
>  
> 
> I currently have a C++ application that is using 5 RTDM drivers, 2
> Xenomai real-time user-space threads and several non-real-time Linux
> threads.
> 
> This application seems to have a memory leak because after running for
> several hours the OOM-Killer kills this application.
> 
> I am looking for a memory leak detection tool to help find the leak.
> 
>   
> 
> Two years ago in the following mail it was mentioned that making
> Valgrind aware of Xenomai syscalls was on the todo list.
> 
> http://article.gmane.org/gmane.linux.real-time.xenomai.users/1805
> 
>  
> 
> Has this been done?
>

No news.

> Does Valgrind work with Xenomai?
> 

Nope.

> Do you have to use the Xenomai simulator with Valgrind?
> 

This won't work in your case. The simulator is rather aimed at virtualizing a
standalone environment for debugging the nucleus and skins that normally run in
kernel space; it is not application-oriented - you would have lots of namespace
conflicts to begin with.

> Or is there a better memory debugger the works with C++, Linux, and Xenomai?
> 

Sorry for the lame suggestion, but you may have to resort to old cranky tools
like dmalloc, provided your new/delete operators are still backed by malloc(3).
At least you should be able to identify some leakage.

>  
> 
> Thanks, 
> 
> Rob
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

