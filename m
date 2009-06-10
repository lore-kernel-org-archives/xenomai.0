Message-ID: <4A3010BE.9020107@domain.hid>
Date: Wed, 10 Jun 2009 21:59:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6a782b880906051338r401163b2m7e1d1a53f7f0800@domain.hid>
	<4A299794.6010504@domain.hid>
	<6a782b880906101236l625792d5p6fcd3dad53e965a2@domain.hid>
In-Reply-To: <6a782b880906101236l625792d5p6fcd3dad53e965a2@domain.hid>
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
> Sorry, i didnt understand you answer.

The question was vague, so was the answer.

> I get the global queue doing this:
> 
> threads = &pod->threadq;    // GLOBAL QUEUE   
> holder = getheadq(&nkpod->threadq); //HEAD NODE

These are internal data, you are not supposed to access them that way.
Besides threadq is not the ready queue. And with the recent advent of
the scheduler classes, you could not do the same modification for the
latest version of Xenomai. In short, it is a bad idea, really.

If you explained us what you are trying to do (and not how you are
trying to do it), maybe we could help. Chances are that you can do what
you do without changing Xenomai core, simply using hooks for instance.

-- 
					    Gilles.

