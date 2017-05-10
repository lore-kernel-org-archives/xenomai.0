References: <20170510170616.2f6d7a1a@md1em3qc>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <5aaed9fc-d72f-32c6-6e1a-7f61bf67b8b0@numalliance.com>
Date: Wed, 10 May 2017 17:20:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170510170616.2f6d7a1a@md1em3qc>
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


Le 10/05/2017 =E0 17:06, Henning Schild a =E9crit :
> Hi,
>
> today i have to a question from an application developers point of
> view. How do i override the default value of a tunable when libcobalt
> is linked with dlopen()?
> This article https://xenomai.org/2015/05/application-setup-and-init/
> describes the tunables but not the dso-case.
this may help you.

char  **fakeargv;
int *fakeargc;

#ifdef __COBALT__
     fakeargc =3D (int*)malloc(sizeof(int));
     *fakeargc =3D1;
     fakeargv =3D (char**)malloc(2*sizeof(char*));
     fakeargv[0] =3D (char*)malloc(7);
     strcpy(fakeargv[0],"python");
     fakeargv[1] =3D NULL;
     xenomai_init(fakeargc,(char* const**)&fakeargv);
#endif

> Is there a way to override the default values when using dlopen()?
> Maybe delaying the call to the constructors, or passing some arguments
> to them?
>
> kind regards,
> Henning
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

