Message-ID: <48E6332C.80304@domain.hid>
Date: Fri, 03 Oct 2008 16:58:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <118594.12208.qm@domain.hid>
In-Reply-To: <118594.12208.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] trap exceptions in user
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gabriele Moabiti <gabmoa@domain.hid>
Cc: xenomai@xenomai.org

Gabriele Moabiti wrote:
> I need to customize some exception (fpu is the most important) inside real time.
> How can I do that?
> Is it possible in  the rt user domain? And what about that in the rt-kernel domain?

You should probably tell us what you want to do instead of how you want
to do it. Because what you ask requires xenomai kernel modifications and
will have really poor performances, so is a solution which you should avoid.

So, what does your real-time x86 assembler code do exactly ?

-- 
                                                 Gilles.

