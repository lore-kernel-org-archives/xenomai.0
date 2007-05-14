From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17992.20159.337584.769619@domain.hid>
Date: Mon, 14 May 2007 13:57:51 +0200
In-Reply-To: <17992.16937.797697.933278@domain.hid>
References: <7289437c0705140221tb124a04mcbf9910e47d3ac2e@domain.hid>
	<17992.16937.797697.933278@domain.hid>
Subject: Re: [Xenomai-help] Problem with Message queue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>, xenomai@xenomai.org

Gilles Chanteperdrix wrote:
 > However, I do not understand what your program is supposed to do, here
 > it dies without printing anything.

There is definitely something wrong on ARM. The program works as
expected on x86, it dies on ARM at exactly the second printf of
routine2. Replacing printf with fprintf(stderr works. Supposing that it
could be a stack size issue, I increased it, and it does not change
anything. 

More on this tonight, in the meantime, please replace printf with
fprintf(stderr,.

-- 


					    Gilles Chanteperdrix.

