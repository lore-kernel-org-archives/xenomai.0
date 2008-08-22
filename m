Message-ID: <48AE8620.4090307@domain.hid>
Date: Fri, 22 Aug 2008 11:25:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <215341.81823.qm@domain.hid>
In-Reply-To: <215341.81823.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ARM926EJ-S and Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: stan.bred@domain.hid
Cc: xenomai@xenomai.org

Stankiewicz Bredkjaer wrote:
> Hi all,
> 
> As a newbie with no experience with Xenomai, I would like to know if
> Texas Instruments Davinci Evaluation boards, especially the ARM926EJ
> arch. have been already ported? I'm working with the Davinci dm6467
> board and it is delivered with a montavista patched 2.6.10 Linux
> kernel on which I would like to install Xenomai. Is it possible? Is
> there something i have to know prior installing Xenomai on the Board?

Hi,

usually, adding an ARM board to the I-pipe patch is just a few days
work, and is documented in Xenomai wiki.

However, it is easy for vanilla kernels where the board-independent
infrastructure already exists, which means 2.6.1[4-5] or 2.6.2[0,4-6]

I have already heard about these davinci boards, and they seem to have a
lot of drivers. It is not easy, but I would advise you to migrate to the
latest kernel (2.6.26), port the drivers to this new kernel (this is the
non-easy part, because kernel APIs have a tendency to evolve rapidly
over time), then port Xenomai for your board.

Regards.

-- 
                                                 Gilles.

