Message-ID: <20050831193733.w5f2d662w0gswwkg@domain.hid>
Date: Wed, 31 Aug 2005 19:37:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [Adeos-main] adeos i386 and ppc patches forward ported to 2.6.13
References: <1125495609.4643.16.camel@domain.hid>
In-Reply-To: <1125495609.4643.16.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Stelian Pop <stelian.pop@domain.hid>
Cc: adeos-main@gna.org

Quoting Stelian Pop <stelian.pop@domain.hid>:

> Hi,
>
> I've forward ported
> 	adeos-linux-2.6.10-ppc-r8c2.patch
> 	adeos-linux-2.6.12-i386-r13c1.patch
> to a fresh 2.6.13 kernel.
>

Thanks.

> The i386 patch port was quite trivial, except for a few code changes.
> However, I had to modify the ADEOS_PREEMPT_RT definition to:
> +config ADEOS_PREEMPT_RT
> +       def_bool PREEMPT_VOLUNTARY || PREEMPT_DESKTOP || PREEMPT_RT
> +
> (removed the PREEMPT_NONE from the def_bool definition) in order to make
> it build on a regular, non PREEMPT_RT kernel (or else the compilation
> would fail on a raw_spinlock_t undefined error). I think this problem
> exists in the 2.6.12 patch as well.
>

Ok. Looks like time has come to upgrade the combined Adeos/PREEMPT_RT patch to
-rt1 in order to fix the issues brought since 0.7.44, I guess.

> The ppc patch was a bit more tricky, but I think I got all of it right.
> It works ok most of the time (RTAI fusion testsuite passes for example -
> on a G4 Powerbook), but it hangs the machine hard sometimes. I am not
> sure if the problem is due to the port or if it is present in the 2.6.10
> version as well.
>

I had a report about issues involving insufficiently protected
get_mmu_context/destroy_context calls on the RTAI mailing list with
2.6.10-r8c1; I'm currently checking the proposed fix that has been sent to me
on a mpc8541. If this works, then maybe this would solve the issue you mention
too; hopefully.

> The two patches are at:
> 	http://www.popies.net/tmp/adeos-linux-2.6.13-i386-r13c1.patch
> 	http://www.popies.net/tmp/adeos-linux-2.6.13-ppc-r8c2.patch
>

I've picked them; they likely won't reach the CVS or the DL area until 
next week
since I'm temporarily behind some paranoid firewall though.

Thanks again.

> Stelian.
> --
> Stelian Pop <stelian.pop@domain.hid>
>
>
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
>




