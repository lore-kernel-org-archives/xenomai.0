Message-ID: <2ff1a98a0710161040n772fb76cv86d69312c4b853b2@domain.hid>
Date: Tue, 16 Oct 2007 19:40:56 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4714F580.7030403@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4714F580.7030403@domain.hid>
Subject: Re: [Xenomai-core] [RFC][PATCH] Enforce nkaffinity unconditionally
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

On 10/16/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Hi,
>
> after looking at the reason for the nkaffinity-vs.-POSIX issue [1]
> again, I came to the conclusion that there is no way to apply the
> current global affinity scheme on the POSIX skin. This scheme goes like
> this:
>  - If the user provides whatever thread affinity _explicitly_, use this
>    one.
>  - If the user doesn't do so, apply the global nkaffinity.
>
> In kernel space, is is simple to differentiate between both cases,
> because all affinity fiddling for all skins go through Xenomai's hands.
> But for the user space POSIX skin, we rely on the task affinity that is
>  set using standard Linux services, and that one has no "dirty-bit" to
> tell both scenarios apart.
>
> So my conclusion is that we should rather apply the nkaffinity always,
> ie. logically AND it with the desired (or default) affinity. The
> system's default behaviour will still be the same compared to earlier
> Xenomai versions, as nkaffinity is ALL_CPUS by default. I also think
> this behaviour is easier to understand for the user than the current
> approach.
>
> Any concerns about the (yet untested) attached patch?

Well... Thanks for working in my stead. I had a look a the posix
situation but could not find the place in the code where the affinity
was set for user-space posix threads.

But when looking at the way nkaffinity worked, I wondered why it was
not set globally with a cpus_and on the tasks affinity. So, I
basically agree with your patch (if it does what I think it does).

-- 
                                               Gilles Chanteperdrix

