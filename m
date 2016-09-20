References: <1560138.jJyhniltkJ@indiana>
 <b4c844ac2faa4a4a8d56a4e41e67fb6f@AUSMXMBX04.mrws.biz>
 <8882775.Clc1uLdNep@soho>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a5c36b27-1f4e-ac3a-bac8-4d668b23291b@xenomai.org>
Date: Tue, 20 Sep 2016 09:06:15 +0200
MIME-Version: 1.0
In-Reply-To: <8882775.Clc1uLdNep@soho>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Cannot create a share library linked against Xenomai
 libs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, xenomai@xenomai.org

On 09/20/2016 08:37 AM, Leopold Palomo-Avellaneda wrote:
> El Dimarts, 20 de setembre de 2016, a les 06:18:45, 
> dietmar.schindler@manroland-web.com va escriure:
>>> Von: Xenomai [mailto:xenomai-bounces@xenomai.org] Im Auftrag von Leopold
>>> Palomo-Avellaneda Gesendet: Montag, 19. September 2016 22:45
>>>
>>> I'm trying to build a shared library, using the posix skin with Xenomai
>>> 3.0.3. I have built xenomai with:
>>>
>>> '--with-core=cobalt' '--enable-smp' '--enable-pshared' '--enable-fortify'
>>> '--enable-shared
>>>
>>> I built withour any error. However, when I try to build a library (shared)
>>> that uses xenomai I got this error:
>>>
>>> /usr/bin/ld: /usr/xenomai/lib/xenomai/bootstrap.o: relocation R_X86_64_32
>>> against `.rodata.str1.1' can not be used when making a shared object;
>>> recompile with -fPIC
>>
>> Here is an answer to a similar problem:
>> http://stackoverflow.com/a/38431538/2413201 It says to use the compiler
>> flags -Wformat=0 or/and -Wno-format-security; perhaps it helps also in your
>> case. --
> 
> Thanks,
> 
> but not. I have tried in both cases: recompiling my lib and xenomai. Still 
> getting the same error.
> 
> What surprises me more is that with 2.6.x I have no error but with 3.x I get 
> it. 
> 

2.6.x did not have any bootstrap module, which explains the difference.

-- 
Philippe.

