Message-ID: <92b2c5595173ecaa0ac699af617d274c.squirrel@www.xenomai.org>
In-Reply-To: <12EC81E5-3663-4EB3-9144-52BC2DAADD29@mah.priv.at>
References: <22700C72-58CD-4B92-B397-43DFC7943F14@mah.priv.at>
	<c5618ea63b6ec1da7d2fa937467d9f4c.squirrel@www.xenomai.org>
	<12EC81E5-3663-4EB3-9144-52BC2DAADD29@mah.priv.at>
Date: Sat, 3 Nov 2012 11:53:35 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Question on rt_timer_tsc() vs rt_timer_read()
 semantics
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org


Michael Haberler wrote:
> I should have also noted the following:
>
> this is a 3.2.21 kernel homegrown like so:
> http://git.mah.priv.at/gitweb/linuxcnc-kernel.git/shortlog/refs/heads/linuxcnc-3.2.21-xenomai-x86
>
> I just see the ipipe tracer is for 2.6x only; I had dropped the 2.6 line
> because of a module unloading issue but if that's the only option I'll
> pick up the 2.6.38.8 kernel again and go from there

The I-pipe tracer is available for 3.2 as well.

-- 
                    Gilles.


