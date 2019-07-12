Subject: Re: [PATCH] boilerplate: Fix bogus "typeof(type)" in macros
References: <CALTC7XLtQUJ9xqwAbURTDeCHzJouAUjz1Lj0nhMovsEeL0q0EQ@mail.gmail.com>
 <f2b6ba72-043d-135a-b86f-c9ee25419343@web.de>
 <2db36c82-bc3a-7968-77fd-4d338999851e@xenomai.org>
 <2a01ec5b-11ae-ced0-bc34-e53435926e7e@web.de>
 <CALTC7XLa3OGs=ygtHoXV3WsJ4Z7X6aqp7hC++aB9aYvRpuo2yQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e442b204-b50f-9728-faab-155b4b9b3270@siemens.com>
Date: Fri, 12 Jul 2019 12:43:44 +0200
MIME-Version: 1.0
In-Reply-To: <CALTC7XLa3OGs=ygtHoXV3WsJ4Z7X6aqp7hC++aB9aYvRpuo2yQ@mail.gmail.com>
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
To: Cris Almaraz <cristina.almaraz@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 11.07.19 13:19, Cris Almaraz via Xenomai wrote:
> Thank you for the fast answers!
> 
> Enabling the extensions ( - -std=gnu++11) has fixed the issue for me.
> 
> Anyhow, I noticed that I still cannot use the set_config_tunable() to
> set the mem_pool_size. I configure it as described below, but I still
> get the warning
> 
> WARNING: [APP] heapobj_init() failed for xxx bytes, raise --mem-pool-size?
> 
> If I use the command line option  --mem-pool-size it works without any
> issues, but I´d like to include it in the code.

You may call set_config_tunable too late, after __config_done was set to 1.

> 
> Also, as secondary issue, I cannot use the syntax of 1G to define the
> size, as G is not defined (error below). That´s why I have the "GBYTE"
> definition.
> 
> error: unable to find numeric literal operator ‘operator"" G’
> 
> #define GBYTE (1024*1024*1024)
> static int my_tune(void){
>     set_config_tunable(mem_pool_size, 1*GBYTE);
>     printf("mem pool size=%ld\n",get_config_tunable(mem_pool_size));
>     return 0;
> }
> 
> static struct setup_descriptor my_setup = {
>     .name = "mySetup",
>     .tune = my_tune,	
> };
> 
> user_setup_call(my_setup);
> 
> Any ideas on these points?
> 

Please share complete reproduction cases with build instructions. I can't
reproduce the issues based on the above information.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

