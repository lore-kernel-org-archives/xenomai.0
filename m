Subject: Re: xeno-test failed due to cond_destroy error
References: <CAMDn9+TNXf5msUQu6kobU9-b2-8O460rg6icT18NpJdnQzh1Rw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <02935a30-7b67-5878-ce25-f2276aeea0a8@siemens.com>
Date: Mon, 10 May 2021 08:49:52 +0200
MIME-Version: 1.0
In-Reply-To: <CAMDn9+TNXf5msUQu6kobU9-b2-8O460rg6icT18NpJdnQzh1Rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fangsuo Wu <tiger20081015@gmail.com>, xenomai@xenomai.org

On 10.05.21 03:56, Fangsuo Wu via Xenomai wrote:
> Hi, I met below errors when running xeno-test in my board:
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> *sh-4.4# ./xeno-testStarted child 209: /bin/sh
> /usr/xenomai/bin/xeno-test-run-wrapper ./xeno-test++ echo 0++
> testdir=/usr/xenomai/bin++ /usr/xenomai/bin/smokey --run
> random_alloc_rounds=64 pattern_check_rounds=64arith OKbufp skipped (no
> kernel support)cpu_affinity skipped (no kernel support)fpu_stress OKiddp
> skipped (no kernel support)leaks OKmemory_coreheap OKmemory_heapmem
> OKmemory_tlsf OKnet_packet_dgram skipped (no kernel support)net_packet_raw
> skipped (no kernel support)net_udp skipped (no kernel support)posix_clock
> OKFAILED autoinit_simple_conddestroy cond_destroy: returned -22 instead of
> 0 - Invalid argumentchild 209 returned: exited with status 1*
> 
> How can I solve the cond_destroy error and what kernel configurations do I
> need for "no kernel support" items? Can someone give some hints? Thanks!
> 

Please use an email client that is capable of sending unmangled
plaintext emails to prevent such things as above.

Then we need more information about your board, the revision of Xenomai
used, how you built etc.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

