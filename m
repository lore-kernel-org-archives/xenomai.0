Message-ID: <4D959B95.4060006@domain.hid>
Date: Fri, 01 Apr 2011 11:32:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <A537C502-9185-43A0-999B-A2DB8583008E@edu.hefr.ch>
In-Reply-To: <A537C502-9185-43A0-999B-A2DB8583008E@edu.hefr.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] process on linux
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: davide doninelli <davide.doninelli@domain.hid>
Cc: xenomai@xenomai.org

davide doninelli wrote:
> Hi 
> i see in linux proces 3 xenomai processes per xenomai RT task .
> I don't understand what are the first 2 process.
> Is that right? What are used for? Tasks are like in envelope?
> i don't find information about that.
> 
> #ps
> ....
>  483 root     ./interrupt_xeno_userspacen 
>   484 root     ./interrupt_xeno_userspacen 
>   485 root     ./interrupt_xeno_userspacen 

With the quantity of information you give us, we can only guess, but you
probably use a linuxthreads based libc, so:
- each thread appears as an entry in ps output
- there is a "manager" thread called when creating the first thread.

So, 483 is probably the main thread, 484 the manager thread, 485 is the
"mytask" thread.

Still guessing, I think you are confusing 2 + N with 3 * N, because you
only tested with N == 1.

-- 
					    Gilles.

