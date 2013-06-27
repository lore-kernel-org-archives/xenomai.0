Message-ID: <51CC308E.7090405@xenomai.org>
Date: Thu, 27 Jun 2013 14:31:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201306260906.22955.leo@alaxarxa.net>	<51CB231E.8030600@xenomai.org>	<201306271109.22749.leo@alaxarxa.net>
	<51CC2DB7.2070806@xenomai.org>
In-Reply-To: <51CC2DB7.2070806@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai warn_upon_switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/27/2013 02:19 PM, Gilles Chanteperdrix wrote:

>> AAnd I don't know how to silent (or if is possible) this messages.
> 
> 
> The point is that these messages are telling you that there is a bug,
> either in xenomai code (a bug was fixed since xenomai 2.6.2.1 which
> could explain such a behaviour), or in orocos code. When the bug is
> fixed the signal will disappear.
> 


Sorry, the bug I was referring was fixed between xenomai 2.6.2 and
xenomai 2.6.2.1, anyway, if you use xenomai 2.6 current git, and install
a handler for SIGDEBUG as done in examples/native/sigdebug.c, you should
be able to know the reason for receiving the signal you get, and help us
help you from there.

-- 
                                                                Gilles.

