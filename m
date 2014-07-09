Message-ID: <53BD0AA6.30901@xenomai.org>
Date: Wed, 09 Jul 2014 11:25:58 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKc2Hpb0S50P=9iWvw3z9NexHmyZEjuAU=7SGyT77EPpub_D2A@mail.gmail.com>	<53B57361.1000603@xenomai.org>	<CAKc2HpZROnFhxVZo3PWQzAoTYZHvvRCydFqxokKS_bQT2LHYVg@mail.gmail.com>	<53BC20E5.6090607@xenomai.org>
 <CAKc2HpbWrU7_1JG4_K9+P_3H8Vs5-xq6W7aZ4ELjVNB+ReOD0A@mail.gmail.com>
In-Reply-To: <CAKc2HpbWrU7_1JG4_K9+P_3H8Vs5-xq6W7aZ4ELjVNB+ReOD0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-forge: Deadlock in finalize_thread()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kim De Mey <kim.demey@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/09/2014 10:09 AM, Kim De Mey wrote:

> Newer version --dump-config output:
> ...
> CONFIG_XENO_COMPILER="gcc version 4.7.0 (Cavium Inc. Version:
> SDK_3_1_0 build 27) "
> ...
>

Thanks. I can't reproduce this issue yet, so posting the current gdb 
backtraces for all the threads still shown by "info threads" after a 
deadlock would help.

TIA,

-- 
Philippe.

