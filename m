References: <CAFUnMknMngz+jwp5BQe5QhP6O4KrACCNs2Ka1MSC=irU9t9y9w@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <fefc6bf4-324b-092f-ba81-f4a67b93702f@xenomai.org>
Date: Sat, 30 Jun 2018 11:03:16 +0200
MIME-Version: 1.0
In-Reply-To: <CAFUnMknMngz+jwp5BQe5QhP6O4KrACCNs2Ka1MSC=irU9t9y9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] modules folder missing in usr/xenomai & modules not
 getting compiled in xenomai 2.6.4 - xeno_hal.ko xeno_rtdm.ko
 xeno_nucleus.ko
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 06/30/2018 10:20 AM, Ashok kumar wrote:
> Hi,
> 
> I have patched the xenomai-2.6.4 with linux-3.14.17
> after that I am running xenomai user library
> 
> cd
> /usr/src
> 
> sudo
> mkdir build_xenomai-2.6.4
> 
> cd
> build_xenomai-2.6.4
> 
> in build_xenomai-2.6.4
> I have  config.log, config.status and makefile generated
> after running configure command below
> 
> sudo  ../xenomai-2.6.4/configure --enable-shared --enable-smp
> --enable-x86-sepsudo make
> 
> make install
> 
> the modules folder missing in usr/xenomai & modules not getting
> compiled in xenomai 2.6.4
> 
> I have attached the config.log, config.status and makefile for your
> reference and I am using autoconf (GNU Autoconf) 2.69
> automake (GNU automake) 1.11.6 aclocal (GNU automake) 1.11.6
> 
> help me to get the modules xeno_hal.ko xeno_rtdm.ko xeno_nucleus.ko
> 
> getting compiled from the makefile generated.
> 
> is there any guidelines for configuring ,compiling xenomai-2.6.4
> ,user-space libraries and header files

https://gitlab.denx.de/Xenomai/xenomai/wikis/Installing_Xenomai_2

-- 
Philippe.

