Message-ID: <53C974FA.5030308@xenomai.org>
Date: Fri, 18 Jul 2014 21:26:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53C9627E.4010102@zultron.com>
In-Reply-To: <53C9627E.4010102@zultron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian packages for testing:  Xenomai 2.6.3,
 Linux 3.8.13, x86 and Beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>, xenomai@xenomai.org

On 07/18/2014 08:07 PM, John Morris wrote:
> I've built new Xenomai kernel packages for the Machinekit project.  As 
> the subject says, they're based on Xenomai 2.6.3 and Linux 3.8.13 and 
> run on the x86 architectures (mostly vanilla with the Debian config) and 
> Beaglebone (Robert C Nelson's patches and config).
> 
> They are based on the upstream Debian packaging, completely different 
> from my previous packages, which were based on the awful make-kpkg 
> stuff.  These promise to be much more maintainable.
> 
> RTAI kernels are also included in the new packaging.
> 
> To install:
> 
> # configure the Debian archive
> sudo sh -c \
>      "sudo apt-key adv --keyserver hkp://keys.gnupg.net \
>          --recv-key 73571BB9; \
>      echo 'deb http://deb.dovetail-automata.com wheezy main' > \
>          /etc/apt/sources.list.d/machinekit.list"

If you are interested, you can make a debian package which adds the key
to the keyring. See:
http://www.xenomai.org/debian/pool/main/x/xenomai-keyring/


-- 
                                                                Gilles.

