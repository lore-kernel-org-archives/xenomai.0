Date: Sun, 20 Sep 2015 10:11:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150920081125.GG22852@hermes.click-hack.org>
References: <CAFkYNwbawB8iHkJA51FpuQFDDY2aYBj2_aMontPadSBf=VZ8AA@mail.gmail.com>
 <20150919151106.GD22852@hermes.click-hack.org>
 <20150919151423.GE22852@hermes.click-hack.org>
 <CAFkYNwZSskEBYeHOK1UEXi7iGucm5x=O7wBB9YQ+1A_Gu9iGgA@mail.gmail.com>
 <CAFkYNwZS5Js_22DMKozYciMwVUKxPbUJ0-FoAxoY50rfxtcBQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFkYNwZS5Js_22DMKozYciMwVUKxPbUJ0-FoAxoY50rfxtcBQA@mail.gmail.com>
Subject: Re: [Xenomai] Installing xenomai libraries ARM OMAP4460
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: vibnwis <vibnwis@gmail.com>
Cc: xenomai@xenomai.org

On Sun, Sep 20, 2015 at 08:04:31PM +1200, vibnwis wrote:
> Thanks, I managed to get .configure by executing autoreconf -i. However, I
> am facing another problem.
> 
> $xenomai_root/configure CC=arm-linux-gnueabihf- CFLAGS="-march=armv7-a
> -mfpu3=vfp" LDFLAGS="-march=armv7-a -mfpu=vfp3" --build=i686-pc-linux-gnu
> --host=${CC}  --with-core=cobalt
> (...)
> Any idea how to set the --host for Linaro toolchain?

My answer to your first mail already contained the answer to that
question.

-- 
					    Gilles.
https://click-hack.org

