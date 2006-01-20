From: Stephan Zimmermann <s.zimmermann@domain.hid>
Subject: Re: [Xenomai-help] Meassage Queue c++
Date: Fri, 20 Jan 2006 09:14:37 +0100
References: <43CFC6B5.8080308@domain.hid>
In-Reply-To: <43CFC6B5.8080308@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601200914.37506.s.zimmermann@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Am Donnerstag, 19. Januar 2006 18:04 schrieb Nathaniel Villaume:
> Hi Stephan,
>
> I don't know if it is related, but I wouldn't return a pointer to a
> local variable:
>
> void *data;
> ...
> return data;
>
> Maybe something is happening where when the queue is empty the size is 0
> --so malloc returns who-knows-what?

Hi, 
thanks for the hint, but I don't think this is the Problem, because the 
Program crashes befor the read function returns. I think it is related with 
the way I create/bind the queue in the constructor, but I am not sure.

Please don't think too much about it, I decided to stop my c++ 
realtime-experiments anyway, will code plain c instead.

Greetings, Stephan

