Message-ID: <53AC2986.5050808@xenomai.org>
Date: Thu, 26 Jun 2014 16:09:10 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAEeRa+SS+Kwnf_L_zi5tWJ81Le8rVWbZM_hQWSdaBR-1TAcnwg@mail.gmail.com>
In-Reply-To: <CAEeRa+SS+Kwnf_L_zi5tWJ81Le8rVWbZM_hQWSdaBR-1TAcnwg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Safe to use GCC atomics within Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stefan S <smarzlys@gmail.com>, xenomai@xenomai.org

On 06/26/2014 02:17 PM, Stefan S wrote:
> Hi all,
>
> GCC 4.6.3 (included in Ubuntu 12.04 LTS) supports atomic builtins.
> I would like to know whether it is safe to use the following builtins:
>
> * type __sync_fetch_and_or (type *ptr, type value, ...)
> * __sync_synchronize (...)
> * type __sync_lock_test_and_set (type *ptr, type value, ...)
> (Definitions taken from
> https://gcc.gnu.org/onlinedocs/gcc-4.1.2/gcc/Atomic-Builtins.html)
>
> I know that in "asm/xenomai/atomic.h", there are some Xenomai specific
> defintions but not for the first one.
>
> My configuration:
>
> * Xenomai 2.6.3 with ipipe-core-3.10.32-x86-2 patch on a vanilla kernel
> * x86_64, Intel core i5
> * Ubuntu 12.04.4 LTS

I'm using gcc 4.8.2 (fedora) on x86 platforms currently, but I had no 
issue with using the atomic builtins of the 4.6.x series some time ago 
(Xenomai 3 depends on those builtins). So you should be ok.

-- 
Philippe.

