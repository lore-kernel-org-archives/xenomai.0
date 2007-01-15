Subject: Re: [Xenomai-core] Unwanted mode switch.
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45A656C6.6060406@domain.hid>
References: <45A656C6.6060406@domain.hid>
Content-Type: text/plain
Date: Mon, 15 Jan 2007 22:47:26 +0100
Message-Id: <1168897647.25238.83.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2007-01-11 at 16:24 +0100, Gilles Chanteperdrix wrote:
> Hi,
> 
> in order to test the nocow patch, I wrote the attached test. Despite the
> fact that there is no longer any page fault (I have nucleus debugging
> on, so I would get a message if there was a fault), there is still an
> unwanted mode switch at step 5. Any idea what could be the cause ?
> 

I'll have a look asap.

> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



