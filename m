Message-ID: <4AC72281.9090901@domain.hid>
Date: Sat, 03 Oct 2009 12:08:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <47a3101a0910021728p63da56f7g59edabc521cc4dfe@domain.hid>
In-Reply-To: <47a3101a0910021728p63da56f7g59edabc521cc4dfe@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on gumstix
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Linus Casassa <linus@domain.hid>
Cc: xenomai@xenomai.org

Linus Casassa wrote:
> It works!
> 
> But I notice that the frequency is bad configured.
> 
> I am using the trivial-periodic example.
> http://www.xenomai.org/documentation/xenomai-2.4/html/api/trivial-periodic_8c-example.html
> 
> I had to change
> rt_task_set_periodic(NULL, TM_NOW, 1000000000);
> to
> rt_task_set_periodic(NULL, TM_NOW, 1000);
> to get 1 second.
> 
> How can I fix this?

You probably selected a periodic timer for the native skin. The example
is made for the aperiodic timer.

-- 
					    Gilles.

