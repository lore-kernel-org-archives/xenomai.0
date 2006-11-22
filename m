Message-ID: <456458BC.2060407@domain.hid>
Date: Wed, 22 Nov 2006 15:03:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] What returns rt_task_self
	in	relation	to	rt_task_create
References: <20403318.1164195534169.JavaMail.ngmail@domain.hid>	<45643CC4.1000201@domain.hid>
	<1164199940.5006.270.camel@domain.hid>	<45644D39.10007@domain.hid>
	<1164204035.5006.305.camel@domain.hid>
In-Reply-To: <1164204035.5006.305.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Philippe Gerum wrote:
> On Wed, 2006-11-22 at 14:14 +0100, Jan Kiszka wrote:
> We could add that, and the same stuff upon return from the task body
> inside the trampoline call, but the only way to solve this with no leak
> would be to call the nucleus at each invocation, and not use any cached
> descriptor here. Since TLS requires to be operated by the owning task,
> there is no point in trying to have a deleted task clean those up
> thoroughly.
> 

When creating a TLS key, you can specify a cleanup function that get
called when a thread exits (or is canceled).

-- 
                                                 Gilles Chanteperdrix

