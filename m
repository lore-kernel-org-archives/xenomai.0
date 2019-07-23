MIME-Version: 1.0
In-Reply-To: <e442b204-b50f-9728-faab-155b4b9b3270@siemens.com>
References: <CALTC7XLtQUJ9xqwAbURTDeCHzJouAUjz1Lj0nhMovsEeL0q0EQ@mail.gmail.com>
 <f2b6ba72-043d-135a-b86f-c9ee25419343@web.de>
 <2db36c82-bc3a-7968-77fd-4d338999851e@xenomai.org>
 <2a01ec5b-11ae-ced0-bc34-e53435926e7e@web.de>
 <CALTC7XLa3OGs=ygtHoXV3WsJ4Z7X6aqp7hC++aB9aYvRpuo2yQ@mail.gmail.com>
 <e442b204-b50f-9728-faab-155b4b9b3270@siemens.com>
From: Cris Almaraz <cristina.almaraz@gmail.com>
Date: Tue, 23 Jul 2019 14:08:55 +0200
Message-ID: <CALTC7XLC4xakm4qnnuxFvJhmnP+KA61a570DsUF0C_75pTn_6g@mail.gmail.com>
Subject: Re: [PATCH] boilerplate: Fix bogus "typeof(type)" in macros
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>

Hello again,

as I was extracting the code to post it I found the issue with the
set_config_tunable call: my application is including a shared library
that also uses Xenomai and contains the --auto-init-solib flag. Even
when the library does not set any tunable, I guess that it is creating
some conflict at the start of the application. Excluding the library
(that is luckily no longer needed by my program) has solved the issue
for me.

For the syntax issue (not being able to use 1G to define the size),
you can find below the code that I am issuing as test. I guess that
there is an include missing somewhere:

#include <cstdio>
#include <unistd.h>
#include <sys/mman.h>
#include <xenomai/init.h>
#include <xenomai/tunables.h>
#include <alchemy/heap.h>

static int my_tune(void)
{
    //set_config_tunable(mem_pool_size, 1*1024*1024*1024);
    set_config_tunable(mem_pool_size, 1G);
    printf("mem pool size=3D%ld\n",get_config_tunable(mem_pool_size));
    return 0;
}

static struct setup_descriptor my_setup =3D {
    .name =3D "setup-test",
    .tune =3D my_tune,
};

user_setup_call(my_setup);

int main() {
    mlockall(MCL_CURRENT | MCL_FUTURE);
    RT_HEAP heap_desc;
    rt_heap_create(&heap_desc, "myHeap", 60000000, H_SINGLE);
    rt_heap_delete(&heap_desc);
    return 0;
}

Build commands:
g++ -I/usr/xenomai/include -O0 -g3 -Wall --std=3Dgnu++11 -c
-fmessage-length=3D0 -I/usr/xenomai/include/mercury
-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
-fasynchronous-unwind-tables -D__MERCURY__
-I/usr/xenomai/include/alchemy -MMD -MP -MF"testXeno3.d"
-MT"testXeno3.o" -o "testXeno3.o" "testXeno3.cpp"

g++ -Wl,--no-as-needed -lalchemy  -lcopperplate
/usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=3Dmain
-Wl,--dynamic-list=3D/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib
-lmercury -lpthread -lrt -o "testXeno3"  testXeno3.o

As system configuration, I am using Xenomai 3.0.9 Core Mercury over CentOS =
7.4

Thanks again for your time and regards,
Cristina.




On 7/12/19, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 11.07.19 13:19, Cris Almaraz via Xenomai wrote:
>> Thank you for the fast answers!
>>
>> Enabling the extensions (=C2=A0-=C2=A0-std=3Dgnu++11) has fixed the issu=
e for me.
>>
>> Anyhow, I noticed that I still cannot use the set_config_tunable() to
>> set the mem_pool_size. I configure it as described below, but I still
>> get the warning
>>
>> WARNING: [APP] heapobj_init() failed for xxx bytes, raise
>> --mem-pool-size?
>>
>> If I use the command line option  --mem-pool-size it works without any
>> issues, but I=C2=B4d like to include it in the code.
>
> You may call set_config_tunable too late, after __config_done was set to =
1.
>
>>
>> Also, as secondary issue, I cannot use the syntax of 1G to define the
>> size, as G is not defined (error below). That=C2=B4s why I have the "GBY=
TE"
>> definition.
>>
>> error: unable to find numeric literal operator =E2=80=98operator"" G=E2=
=80=99
>>
>> #define GBYTE (1024*1024*1024)
>> static int my_tune(void){
>>     set_config_tunable(mem_pool_size, 1*GBYTE);
>>     printf("mem pool size=3D%ld\n",get_config_tunable(mem_pool_size));
>>     return 0;
>> }
>>
>> static struct setup_descriptor my_setup =3D {
>>     .name =3D "mySetup",
>>     .tune =3D my_tune,=09
>> };
>>
>> user_setup_call(my_setup);
>>
>> Any ideas on these points?
>>
>
> Please share complete reproduction cases with build instructions. I can't
> reproduce the issues based on the above information.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>

