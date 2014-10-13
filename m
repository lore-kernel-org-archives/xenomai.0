Date: Mon, 13 Oct 2014 07:58:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141013055801.GD13181@sisyphus.hd.free.fr>
References: <CALe7ZU1=q_ukbypJT3cVe3njGuOWMF-6z-_sJtQyzAV5a2W1WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALe7ZU1=q_ukbypJT3cVe3njGuOWMF-6z-_sJtQyzAV5a2W1WQ@mail.gmail.com>
Subject: Re: [Xenomai] Installng xenomai on laptop
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: JAY KOTHARI <jaikothari10@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Mon, Oct 13, 2014 at 10:48:40AM +0530, JAY KOTHARI wrote:
>    I want xenomai on laptop(dell i3 2.2GHz processor). Can anyone suggest
> me which options I need to configure while patching xenomai to my linux so
> that I get maximum performance . I am afraid of power management options
> and heating problems if I make wrong choice. Please let me know safe
> options which to be touched for laptop which would optimize performance of
> xenomai without causing any damage.

A laptop is not different from any other x86, so the general x86
instructions apply. As for the maximum (real-time, I suppose)
performances, they depend on your application. For instance I find
that disabling CONFIG_PREEMPT generally improves real-time latency,
though your application may need to enable CONFIG_PREEMPT for good
latency when in secondary mode.

-- 
					    Gilles.

