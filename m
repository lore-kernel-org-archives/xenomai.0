Date: Sat, 19 Sep 2015 17:14:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150919151423.GE22852@hermes.click-hack.org>
References: <CAFkYNwbawB8iHkJA51FpuQFDDY2aYBj2_aMontPadSBf=VZ8AA@mail.gmail.com>
 <20150919151106.GD22852@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150919151106.GD22852@hermes.click-hack.org>
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

On Sat, Sep 19, 2015 at 05:11:06PM +0200, Gilles Chanteperdrix wrote:
> On Sun, Sep 20, 2015 at 02:58:58AM +1200, vibnwis wrote:
> > Hi All,
> > 
> > Having installed Xenomai, I am wanting to test Xenomai.
> > 
> > If I understood the guide correctly under the title "Installing the Xenomai
> > libraries and tools", I would need to compile the libraries as well as the
> > test apps. For that I need to do by executing the command below in the
> > xenomai_root which in my case is xenomai_root=xenomai-3. However, the
> > configure file is not found. I am totally confused of what have I done
> > wrong? Any helps/advise would be appreciated.
> > 
> > $xenomai_root/configure CFLAGS="-march=armv4t" LDFLAGS="-march=armv4t" \
> >   --build=i686-pc-linux-gnu --host=arm-none-linux-gnueabi- --with-core=cobalt
> 
> -march=armv4t works for ARM processors using the ARMv4T architecture
> revision. The cortex A9 in an omap4460 uses the ARMv7 architecture
> revision. So, you should pass -march=armv7 instead, or -mcpu=cortex-a9

Could also be -march=armv7-a

> 
> the argument to the --host option should not include the leading
> dash.
> 
> the variable xenomai_root should probably be an absolute path. And
> note that if you downloaded xenomai-3 from its git repository as
> opposed to its latest archive, you also need to call autoreconf -i
> to create the configure scrippt.

If the toolchain you use has no support for floating point, you
probably also want to use a toolchain with floating point support,
such as the Denx ELDK 5 toolchain for the armv7a-hf architecture, or
the Linaro toolchain.

-- 
					    Gilles.
https://click-hack.org

