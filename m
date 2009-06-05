Message-ID: <4A299794.6010504@domain.hid>
Date: Sat, 06 Jun 2009 00:09:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6a782b880906051338r401163b2m7e1d1a53f7f0800@domain.hid>
In-Reply-To: <6a782b880906051338r401163b2m7e1d1a53f7f0800@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Get ready queue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thiago Lima <thiagolims@domain.hid>
Cc: xenomai@xenomai.org

Thiago Lima wrote:
> Hi everybody,
> 
> I have a function in a linux kernel module that is called whenever a
> function in xenomai domain starts. In this moment, i need to get the ready
> queue with all ready threads of xenomai.
> Do you realize how can i do that ?

If you are using a skin, then you should restrict yourself to the
services of that skin. If you are writing a skin, then the services you
can access are those of the nucleus.

http://www.xenomai.org/documentation/trunk/html/api/group__nucleus.html

If you are writing your own skin, then you can add an xnholder structure
to the TCB of your tasks, it will allow you to walk this list once you
need it.

-- 
					    Gilles.

