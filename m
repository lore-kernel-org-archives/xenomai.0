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
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e7a00208-aa12-7896-9a59-4d821ec6e35c@xenomai.org>
Date: Fri, 29 Jun 2018 17:52:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180629174205.70feb18e@md1pvb1c.ad001.siemens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Henning Schild <henning.schild@siemens.com>, Pintu Kumar <pintu.ping@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/29/2018 05:42 PM, Henning Schild wrote:
> Hi,
> 
> i had a closer look. You might want to revert the following commit
> https://gitlab.denx.de/Xenomai/xenomai/commit/408c93e26438c83c08f216a2c8bd7079253cf71a
> 
> It does include the testcase in the build even if the feature is
> disabled.
> 

I don't think so. It includes the testcase in the source distribution
allowing "make distcheck" to succeed, even if the test has not be built
in the smokey driver, which fixes a build regression introduced by
dlopen. Tests built in the executable must be listed in COBALT_SUBDIRS,
which dlopen isn't unless --enable-dlopen-libs has been given.

If you want to exclude the dlopen test from the test series at runtime,
you can pass "--exclude=dlopen" on the command line to smokey, as
mentioned in the help strings (smokey --help).

-- 
Philippe.

