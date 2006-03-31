Message-ID: <442CC760.3070506@domain.hid>
Date: Fri, 31 Mar 2006 01:08:32 -0500
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] errors to console when running xeno-test (latency
	-t	1)
References: <44280C96.1030608@domain.hid>	<17448.18916.701490.357146@domain.hid>	<442958C2.3080800@domain.hid>
	<17450.38539.674211.828082@domain.hid>
In-Reply-To: <17450.38539.674211.828082@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Jim Cromie wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Jim Cromie wrote:
>  > >  > hello xenophiles,
>  > >  > 
>  > >  > Im getting errors to the console when running latency -t 1.
>  > >  > they also appear in dmesg output
>  > >
>  > > This should be fixed in revision 807.
>  > >
>  > >   
>  > 807 didnt fix it here.  Its also still present in 815
>
> Reverting 807 produces a bug on my test box identical to the one you are
> reporting. Merging 807 again make the bug disappear. Could you double
> check ? If the bug persists, could you send me privately your .config
> file ?
>
>   
yes, now works. 
My err was not recompiling the kernel too.
sorry for the noise.

