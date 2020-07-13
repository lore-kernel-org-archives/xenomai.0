Subject: Re: Problem when compiling Xenomai 3.0.8 user libraries with
 enable-debug
References: <CAKP50V6HKWY9p3jnP8EgEVeoqJj9rtUbSK2k8eqVs-y40cK8MA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <328ae88e-dfc0-3200-acb2-d14ff3c00dda@siemens.com>
Date: Mon, 13 Jul 2020 19:40:33 +0200
MIME-Version: 1.0
In-Reply-To: <CAKP50V6HKWY9p3jnP8EgEVeoqJj9rtUbSK2k8eqVs-y40cK8MA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
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
To: Matheus Leitzke <senseipinto@gmail.com>, xenomai@xenomai.org

On 11.07.20 19:42, Matheus Leitzke via Xenomai wrote:
> Hello,
> 
> I am setting my Xenomai user libraries with:
> 
> ./configure --host=arm-linux-gnueabihf --enable-smp --enable-debug=full
> --enable-pshared --with-core=cobalt
> 
> But when I use make to compile the user libraries, the following error is
> throw:
> 
> make[5]: Entering directory
> '/home/matheus/Downloads/xenomai-3.0.8/lib/cobalt/arch/arm'
>    CC       libarch_la-features.lo
> features.c: In function ‘cobalt_check_features’:
> features.c:78:1: error: r7 cannot be used in asm here
>   }
> 
> This error is thrown because the r7 register is being used in macro
> XENOMAI_SYSCALL2 inside cobalt_check_features from features,c cobalt file.
> 
> I try to follow this suggestion:
> https://tls.mbed.org/kb/development/arm-thumb-error-r7-cannot-be-used-in-asm-here.
> However, when inserting "-fomit-frame-pointer" on Makefile c flags
> variables, this has no effect.
> 
> This error occurs only when I set --enable-debug flag.
> 
> Do you have any suggestions?
> 
> Matheus
> 

Cannot reproduce - what toolchain are you using? I'm on Linaro gcc 
8.3-2019.03.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

