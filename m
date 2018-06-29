Date: Fri, 29 Jun 2018 18:07:08 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180629180708.52975276@md1pvb1c.ad001.siemens.net>
In-Reply-To: <e7a00208-aa12-7896-9a59-4d821ec6e35c@xenomai.org>
References: <CAOuPNLias38WgrA7SeQxC-Nh47q7kM8vRVR=ex_yFzQT1pnDZg@mail.gmail.com>
 <CAOuPNLgNoHKH5EA3aanAqSMXQn1Y25oM3rCWNN7-5DUJxc=sBQ@mail.gmail.com>
 <CALLqZ8TNfqRY0vqfCqExS+CxWGqTDe9Tm5-q3sMzbaY5Vi1nHQ@mail.gmail.com>
 <CAOuPNLjpiUzDTskhMHfRpqsoPU_1gd1n3PrXa=K0GGbsG+WoNA@mail.gmail.com>
 <CAOuPNLi0k3KmzKJjyE5vqQmW-92DoRXyB+pGMqqwSiwY7Tz8Sw@mail.gmail.com>
 <CAOuPNLhQ-f_wm9u8ikWf_yB43f6c+8f8bm8zo36vEE+43ZpKtQ@mail.gmail.com>
 <20180627143752.648bb696@md1pvb1c.ad001.siemens.net>
 <CAOuPNLjW5AY1yMYux4FQXzvzd6FpyTP8tZ4JEJq3DZa3C5kiuA@mail.gmail.com>
 <CAOuPNLgbE8iySGr12b8-eRdyr5iN3jhJ38iS9aZDprJUs+zRYw@mail.gmail.com>
 <CAOuPNLg9Tw_MK2UrazRc2Bwg0Jsi2PU=aL2tzSaDRiY6qUhFww@mail.gmail.com>
 <20180628173615.10a16310@md1pvb1c.ad001.siemens.net>
 <CAOuPNLgBVJPHOyzOypiCG0VkAZMG+EjSe-cAjALKS=rXm8t27w@mail.gmail.com>
 <20180629174205.70feb18e@md1pvb1c.ad001.siemens.net>
 <e7a00208-aa12-7896-9a59-4d821ec6e35c@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] beaglebone: arm: xeno-test gives segmentation fault -
 test dlopen failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Am Fri, 29 Jun 2018 17:52:44 +0200
schrieb Philippe Gerum <rpm@xenomai.org>:

> On 06/29/2018 05:42 PM, Henning Schild wrote:
> > Hi,
> > 
> > i had a closer look. You might want to revert the following commit
> > https://gitlab.denx.de/Xenomai/xenomai/commit/408c93e26438c83c08f216a2c8bd7079253cf71a
> > 
> > It does include the testcase in the build even if the feature is
> > disabled.
> >   
> 
> I don't think so. It includes the testcase in the source distribution
> allowing "make distcheck" to succeed, even if the test has not be
> built in the smokey driver, which fixes a build regression introduced
> by dlopen. Tests built in the executable must be listed in
> COBALT_SUBDIRS, which dlopen isn't unless --enable-dlopen-libs has
> been given.

Yes, you are right. I just saw a "+= dlopen" in the resulting Makefile
but that should not cause the problem.

Pintu: Please build in a completely fresh environment i.e. "git clean
-dfx; autoreconf -i; ./configure". And now give me

grep dlopening -A1 config.log
grep am__append_1 testsuite/smokey/Makefile
autoreconf --version

Ideally with a hash i can find on gitlab.denx.de.

Henning


> If you want to exclude the dlopen test from the test series at
> runtime, you can pass "--exclude=dlopen" on the command line to
> smokey, as mentioned in the help strings (smokey --help).
> 


