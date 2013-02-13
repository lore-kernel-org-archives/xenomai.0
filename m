MIME-Version: 1.0
In-Reply-To: <CAPeEhaq-oMmhntc3rYDt-e1=qEorjkVj8G+qYKcNSxOggjGH7A@mail.gmail.com>
References: <CAPeEhaoS1dLW0VfiGVVsyEcGokO8zDNP-yg_2SFMRxzXD5a6Rw@mail.gmail.com>
	<511B5190.3070800@xenomai.org>
	<CAPeEhaq-oMmhntc3rYDt-e1=qEorjkVj8G+qYKcNSxOggjGH7A@mail.gmail.com>
Date: Wed, 13 Feb 2013 14:30:53 -0600
Message-ID: <CAPeEharzL54WkK2TCBmQo7ec8Aa1-t1dyBKuHBeZ0hLzGgCiwQ@mail.gmail.com>
From: uMinded Strikes Again <iceblu3710@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Fwd:  Porting IPIPE to SUN5I (Allwinner A13)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Ok so I am on my way with kernel version 3.4.29 however my sun5i directory
is quite lacking. If I compare /arch/arm/omap2/ their are dozens of files
to the SOC features and a complete Kconfig file as well but in my
/arch/arm/sun5i/ their are just the basics for the clock to run and no
Kconfig at all!

Is their a drivers patch out there for the sunxi chipsets or will I be
writing my own for this whole architecture??


On Wed, Feb 13, 2013 at 2:40 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 02/13/2013 05:08 AM, uMinded Strikes Again wrote:
>
> > I am trying to port IPIPE to my allwinner A13 board but do not know where
> > to exactly start on this... I know what needs to be done but not how to
> do
> > it.
>
>
> I recommend using a 3.2, 3.4 or 3.5 kernel and starting here:
> http://xenomai.org/index.php/I-pipe-core:ArmPorting
>
> --
>                                                                 Gilles.
>
