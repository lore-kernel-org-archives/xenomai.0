Subject: Re: [PATCH] Add --disable-{demo,testsuite} options
References: <20210813081254.1904938-1-fontaine.fabrice@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <86057dfa-d2ed-1932-db29-4608edb08865@siemens.com>
Date: Fri, 13 Aug 2021 10:54:30 +0200
MIME-Version: 1.0
In-Reply-To: <20210813081254.1904938-1-fontaine.fabrice@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fabrice Fontaine <fontaine.fabrice@gmail.com>, xenomai@xenomai.org

On 13.08.21 10:12, Fabrice Fontaine via Xenomai wrote:
> Allow the user to disable demo and testsuite to avoid the following
> build failures on arc and riscv32:

Are you working on ports to those archs? Or is xenomai userland just
prematurely built for those in buildroot?

> 
> latency.c: In function 'display':
> latency.c:326:21: error: format '%ld' expects argument of type 'long int', but argument 2 has type 'time_t' {aka 'long long int'} [-Werror=format=]
>   326 |         ("RTT|  %.2ld:%.2ld:%.2ld  (%s, %Ld us period, "
>       |                 ~~~~^
>       |                     |
>       |                     long int
>       |                 %.2lld
>   327 |          "priority %d)\n", dt / 3600,
>       |                            ~~~~~~~~~
>       |                               |
>       |                               time_t {aka long long int}
> 
> altency.c: In function ‘display’:
> altency.c:262:21: error: format ‘%ld’ expects argument of type ‘long int’, but argument 2 has type ‘time_t’ {aka ‘long long int’} [-Werror=format=]
>   262 |         ("RTT|  %.2ld:%.2ld:%.2ld  (%s, %Ld us period, "
>       |                 ~~~~^
>       |                     |
>       |                     long int
>       |                 %.2lld
>   263 |          "priority %d)\n", dt / 3600,
>       |                            ~~~~~~~~~
>       |                               |
>       |                               time_t {aka long long int}
> 

How about fixing those issues instead?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

