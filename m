Message-ID: <2ff1a98a0805060916u7d9f446au76a1df4787060b6e@domain.hid>
Date: Tue, 6 May 2008 18:16:33 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <20080506160603.216980@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080506160603.216980@domain.hid>
Subject: Re: [Xenomai-help] Pros/Contras Xenomai - CONFIG_PREEMPT_RT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Reichert <Karl-Trampe@domain.hid>
Cc: xenomai@xenomai.org

On Tue, May 6, 2008 at 6:06 PM, Karl Reichert <Karl-Trampe@domain.hid> wrote:
> Hello all,

Hi, I do not want to discuss about this issue, since I feel others
will do it better than me. However, I think you are wrong about what
you say are advantages of PREEMPT_RT over Xenomai:

>  2) There is only one API to use. No matter if you are creating a program as real time task or not, you can use the same API.

If you use Xenomai Posix API, you get the same thing with Xenomai.

>  3) One can use CPU isolation on dual core machines, making one core running only real time tasks and the other the rest.

You can do the same thing with Xenomai


-- 
 Gilles

