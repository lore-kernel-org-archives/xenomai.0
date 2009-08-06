From: Andreas Glatz <andreasglatz@domain.hid>
In-Reply-To: <1249578204.3809.221.camel@domain.hid>
References: <1249509063.4762.84.camel@domain.hid>
	<1249578204.3809.221.camel@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 06 Aug 2009 15:15:10 -0400
Message-Id: <1249586110.8905.9.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-help] Alignment exception on powerpc
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

Hi Philippe,


> > Is there a way to execute the exception handler from primary mode 
> > to prevent the tasks to switch to secondary mode?
> 
> I have absolutely no freaking idea whether the following patch will
> work, but you are welcome to feel lucky:
> 

The patch seems to work. I even put a printk inside the if(fixed == 1) 
clause inside of the patched function alignment_exception() 
to check if things really get fixed... and they do!

I just noticed that u sent out another patch. Do u want me to test that
one too? 

Of course, now I have the problem that I don't know which one is
better... :p

Andreas

