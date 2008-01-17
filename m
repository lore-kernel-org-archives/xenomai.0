Message-ID: <2ff1a98a0801170604s68893af2h5fe7f867bf166b45@domain.hid>
Date: Thu, 17 Jan 2008 15:04:26 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d3f72a390801170558s2d683197p4dba00f087d45eb8@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d3f72a390801170558s2d683197p4dba00f087d45eb8@domain.hid>
Subject: Re: [Xenomai-core] PORTING XENOMAI on ep9315 proccessor
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: axel axel <softaxel@domain.hid>
Cc: xenomai@xenomai.org

On Jan 17, 2008 2:58 PM, axel axel <softaxel@domain.hid> wrote:
> HI
>
> another question four you.
>
> i'm a newbie of Xenomai and Ipipe, but i had to porting Xenomai on ARM9
> Cirrus ep9315.
>
> And so i ask me and you:
>
> where and when is TSC( time stam counter ) used in Xenomai ? I try to know
> reading the code but i don't understand good.
>
> I explain it better.
>
> Is it foundamental  the  implementation of TSC emulation  ( the hardware
> doesn't have TSC, has only a free counter for debug  ) for the main
> functionality of Xenomai OR
> need only for the functions relative to exactly differences of time () ?

Implementation of a TSC is mandatory, but the good news is that if
your hardware has a free running counter, the implementation is pretty
straightforward, and you have an example on Xenomai wiki:
http://www.xenomai.org/index.php/I-pipe:ArmPorting#Free-running_counters

-- 
                                               Gilles Chanteperdrix

