Date: Mon, 25 Feb 2019 11:05:37 +0100
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: xenomai-3.0.5 include path
Message-ID: <20190225110537.47846d93@md1za8fc.ad001.siemens.net>
In-Reply-To: <201902250201528162258@aliyun.com>
References: <2019022210543291904613@aliyun.com>
 <20190222123317.62f7fb3f@md1za8fc.ad001.siemens.net>
 <201902250201528162258@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "demon.han@aliyun.com" <demon.han@aliyun.com>, xenomai@xenomai.org

Am Mon, 25 Feb 2019 02:01:53 +0800
schrieb "demon.han@aliyun.com" <demon.han@aliyun.com>:

> Hi,
> My installation was refer to:
> https://rtt-lwr.readthedocs.io/en/latest/rtpc/xenomai3.html: "cd
> xenomai-3.0.5 ./configure --with-pic --with-core=cobalt --enable-smp
> --disable-tls --enable-dlopen-libs --disable-clock-monotonic-raw make
> -j`nproc` sudo make install"

The link suggests that you are on Ubuntu. The documentation says to do
"sudo make install", which will work exactly one time ... This is
wrong, especially since you are on a debian-based distro.

Instaed you should be building debian packages and install those.
Everything you need is in the tree. Just change CONFIG_OPTS in
debian/rules, add an entry to debian/changelog and run
dpkg-buildpackage.
If you are not on debian use prefix/destdir and "xstow" and _never_
"make install" as root.

Now you should probably ask your package manager which files in /usr do
not belong to any package. And remove all that look like xenomai. After
that see if a single "make install" will get you into the same conflict
again, or the installation of the resulting package.

Henning


> Then:
> "echo '
> ### Xenomai
> export XENOMAI_ROOT_DIR=/usr/xenomai
> export XENOMAI_PATH=/usr/xenomai
> export PATH=$PATH:$XENOMAI_PATH/bin:$XENOMAI_PATH/sbin
> export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$XENOMAI_PATH/lib/pkgconfig
> export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$XENOMAI_PATH/lib
> export OROCOS_TARGET=xenomai
> ' >> ~/.xenomai_rc
> echo 'source ~/.xenomai_rc' >> ~/.bashrc 
> source ~/.bashrc"
> 
> Is there anything could be fixed,gratefunlly?
> thanks,
> demon.
> 
> 
> demon.han@aliyun.com
>  
> From: Henning Schild
> Date: 2019-02-22 19:33
> To: demon.han--- via Xenomai
> CC: demon.han@aliyun.com
> Subject: Re: xenomai-3.0.5 include path
> Hi,
>  
> did you compare the two files? My guess would be that you are on a
> system where a careless "make install" was run on multiple versions of
> xenomai, possibly with prefix dirs set.
>  
> Once you are sure that both headers are indeed coming out of the same
> installation, it would be time to look the the install target of make.
>  
> Henning
>  
> Am Fri, 22 Feb 2019 10:54:33 +0800
> schrieb demon.han--- via Xenomai <xenomai@xenomai.org>:
>  
> > Hi,
> > I am working on xenomai3.0.5 with Eherlab Ethercat.
> > Here I got a problem.
> > After installing xenomai,I got 2 include directory:
> > 1. /usr/include/xenomai
> > 2./usr/xenomai/include
> > I find rtdm_driver.h in /usr/include/xenomai but
> > out /usr/xenomai/include. This cause a problem,I think:
> > when I compile Etherlab,I got error as"/master/rtdm.c:37:30: fatal
> > error: rtdm/rtdm_driver.h: No such file or directory", so I copy the
> > header to /usr/xenomai/include/rtdm,and the error is fixed. Is there
> > another way to fix the problem? Best Wishes.
> > demon.
> > 
> > 
> > 
> > demon.han@aliyun.com  
>  


