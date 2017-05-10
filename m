References: <20170510170616.2f6d7a1a@md1em3qc>
 <5aaed9fc-d72f-32c6-6e1a-7f61bf67b8b0@numalliance.com>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <dfb3caf2-fdbe-0138-8f87-836ea4482bae@numalliance.com>
Date: Wed, 10 May 2017 17:25:33 +0200
MIME-Version: 1.0
In-Reply-To: <5aaed9fc-d72f-32c6-6e1a-7f61bf67b8b0@numalliance.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] copperplate tunables with dso
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>



Le 10/05/2017 =E0 17:20, St=E9phane Ancelot a =E9crit :
>
> Le 10/05/2017 =E0 17:06, Henning Schild a =E9crit :
>> Hi,
>>
>> today i have to a question from an application developers point of
>> view. How do i override the default value of a tunable when libcobalt
>> is linked with dlopen()?
>> This article https://xenomai.org/2015/05/application-setup-and-init/
>> describes the tunables but not the dso-case.
> this may help you.
> #include <xenomai/init.h>
> #include <xenomai/tunables.h>
>
>
>
> static int foo_tune(void)
> {
>         set_config_tunable(mem_pool_size,5000000);
>         printf("mem pool size=3D%ld\n", get_config_tunable(mem_pool_siz=
e));
>
>
>          return 0; /* Success, otherwise -errno */
> }
>
> /*
>  * CAUTION: we assume that all omitted handlers are zeroed
>  * due to the static storage class. Make sure to initialize them
>  * explicitly to NULL if the descriptor belongs to the .data
>  * section instead.
>  */
> static struct setup_descriptor foo_setup =3D {
>         .name =3D "foo",
>         .tune =3D foo_tune,
>         .parse_option =3D NULL,
>         .help =3D NULL,
>         .init =3D NULL,
>         .options =3D NULL,
> };
>
> /* Register the setup descriptor. */
> user_setup_call(foo_setup);

> char  **fakeargv;
> int *fakeargc;
>
> #ifdef __COBALT__
>     fakeargc =3D (int*)malloc(sizeof(int));
>     *fakeargc =3D1;
>     fakeargv =3D (char**)malloc(2*sizeof(char*));
>     fakeargv[0] =3D (char*)malloc(7);
>     strcpy(fakeargv[0],"python");
>     fakeargv[1] =3D NULL;
>     xenomai_init(fakeargc,(char* const**)&fakeargv);
> #endif
>
>> Is there a way to override the default values when using dlopen()?
>> Maybe delaying the call to the constructors, or passing some arguments
>> to them?
>>
>> kind regards,
>> Henning
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

