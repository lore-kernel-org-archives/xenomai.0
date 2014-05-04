References: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <536689FE.5060503@xenomai.org>
Message-ID: <1399238572.11209.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Date: Sun, 4 May 2014 22:22:52 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <536689FE.5060503@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] FreeRTOS skin
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

----- Original Message -----=0A=0A> From: Gilles Chanteperdrix <gilles.chan=
teperdrix@xenomai.org>=0A> To: Matthias Schneider <ma30002000@yahoo.de>; "x=
enomai@xenomai.org" <xenomai@xenomai.org>=0A> Cc:=A0=0A> Sent: Sunday, May =
4, 2014 8:42 PM=0A> Subject: Re: [Xenomai] FreeRTOS skin=0A>=A0=0A> On 05/0=
4/2014 06:59 PM, Matthias Schneider wrote:=0A>> Hi all,=0A>>=A0=0A>> please=
 find enclosed a patch with a FreeRTOS skin for xenomai-forge I have=A0=0A>=
> been  working on for some time. I would like to get some feedback and adv=
ice=0A>> what still needs to be done to get it accepted in Xenomai. There i=
s a set of=A0=0A>> unit tests included and the possibility to download the =
original FreeRTOS package=A0=0A>> in order to run most of its (platform ind=
ependent) test suite. Until now I have=A0=0A>> been working under mercury o=
nly. Documentation is available in form of a README=A0=0A>> file in lib/fre=
ertos/README, which should also be a good starting point. I have=A0=0A>> no=
t attached "configure" to the patch, so you will need to recreate the confi=
gure=A0=0A>> script first before actually running it. You can apply the pat=
ch via=0A>=A0=0A>=A0=0A> Hi,=0A>=A0=0A> I am not sure that checking whether=
 a type is compatible with void *=A0=0A> will not suddenly avoid the assert=
 check for any pointer type in:=0A>=A0=0A> @@ -328,6 +328,7 @@ static inlin=
e int pshared_check(void *heap, void *addr)=0A>         ({ =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=0A> \=0A>                 type handle;    =
                                        \=0A>                 assert(__buil=
tin_types_compatible_p(typeof(type), unsigned long)  || \=0A> +            =
  __builtin_types_compatible_p(typeof(type), void*) || \=0A>               =
        __builtin_types_compatible_p(typeof(type), uintptr_t));=A0=0A> \=0A=
>                 assert(ptr =3D=3D NULL || __memchk(__main_heap, ptr));   =
   \=0A>                 handle =3D (type)ptr;                             =
       \=0A> @@ -337,6 +338,7 @@ static inline int pshared_check(void *heap=
, void *addr)=0A>         ({ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0=0A> \=0A>                 type *ptr;                                  =
            \=0A>                 assert(__builtin_types_compatible_p(typeo=
f(handle), unsigned  long) || \=0A> +              __builtin_types_compatib=
le_p(typeof(handle), void*) || \=0A>                       __builtin_types_=
compatible_p(typeof(handle), uintptr_t));=A0=0A> \=0A>                 ptr =
=3D (type *)handle;                                  \=0A>                 =
ptr;                                                    \=0A>=A0=0AI do agr=
ee with the argument; actually originally I had typedef'ed=A0=0AxQueueHandl=
e, xTaskHandle and xSemaphorehandle as uintptr_t.=0AHowever, when compiling=
 original FreeRTOS applications like the=0A"demo", I ran into many warnings=
 (warning: comparison between=A0=0Apointer and integer) when comparing the =
handles to "NULL"=A0=0Alike=A0=0A=0Aif (queueHandle !=3D NULL) {}=0A=0ANow =
I see three possibilities:=0A* stick with the void* and allow it in the che=
ck (admittedly=A0=0A=A0 greatly reducing its use)=0A* change the applicatio=
n code=0A* suppress warnings when compiling application code (not really=A0=
=0A=A0 my favorite)=0A=0AOriginally the handles are tyepdef'ed to void* as =
well.=0AAny ideas?=0A=0A=0A> That is a bit complicated:=0A> +#if portBYTE_A=
LIGNMENT =3D=3D 8=0A> +      #define portBYTE_ALIGNMENT_MASK (0x0007)=0A> +=
#endif=0A> +=0A> +#if portBYTE_ALIGNMENT =3D=3D 4=0A> +      #define portBY=
TE_ALIGNMENT_MASK (0x0003)=0A> +#endif=0A> +=0A> +#if portBYTE_ALIGNMENT =
=3D=3D 2=0A> +      #define portBYTE_ALIGNMENT_MASK (0x0001)=0A> +#endif=0A=
> +=0A> +#if portBYTE_ALIGNMENT =3D=3D 1=0A> +      #define portBYTE_ALIGNM=
ENT_MASK (0x0000)=0A> +#endif=0A> +=0A> +#ifndef portBYTE_ALIGNMENT_MASK=0A=
> +      #error "Invalid portBYTE_ALIGNMENT definition"=0A> +#endif=0A>=A0=
=0A> It seems simpler to me to define portBYTE_ALIGNNMENT_MASK to=A0=0A> po=
rtByteALIGNMENT - 1 and trigger an error if portBYTE_ALIGNMENT=A0=0A> is mo=
re than 8 or not a power of 2.=0A=0AI could change it to:=0A=0A#if portBYTE=
_ALIGNMENT > 8 || portBYTE_ALIGNMENT < 1 || \=0A=A0 =A0 ((portBYTE_ALIGNMEN=
T & ~(portBYTE_ALIGNMENT-1))!=3DportBYTE_ALIGNMENT)=0A#error Check portBYTE=
_ALIGNMENT definition=0A#endif=0A=0A#define portBYTE_ALIGNMENT_MASK (portBY=
TE_ALIGNMENT - 1)=0A=0A> On 64 bits machines, long and int are different, s=
o, you probably want=A0=0A> #define portLONG long=0A> To avoid unpleasant s=
urprises in:=0A>=A0=0A> +#define portCHAR              char=0A> +#define po=
rtFLOAT              float=0A> +#define portDOUBLE            double=0A> +#=
define portLONG              int=0A=0AChanged to=A0=0A#define portLONG     =
         long=0A=0A> I am not sure what is portBYTE_ALIGNEMENT, but I guess=
 sizeof(long) would=A0=0A> make more sense.=0A> +#define portBYTE_ALIGNMENT=
    8 //FIXME: double check...=0A=0ASeems to be used internally byt the ori=
ginal FreeRTOS implementation,=0Abut is in a public header, so keep it for =
completeness' sake.=0AChanging to sizeof(long) as suggested.=0A=0A> I belie=
ve there is an error in these macros definition:=0A> This one looks strange=
:=0A> +#define portNOP() __asm__ __volatile__ ("nop");=0A>=A0=0A> If you do=
 not care whether portNOP is a barrier you can drop the  "volatile"=0A> oth=
erwise you should add "memory" as clobber.=0A=0AThe original FreeRTOS imple=
mentation is "just" volatile (actually it is=A0=0Adefined exactly the same =
way as in my header file), so it is a little=A0=0Adifficult to guess the or=
iginal authors' motives. Since I do not have any=0Asample code that makes u=
se of this macro, I am not sure of the implications=A0=0Aon existing source=
 code when changing it, independent from removing the volatile=0Aor adding =
the clobbering.=0A=0A> It may not be a good idea to define errors to overla=
p with errno errors in:=0A> +/* Error definitions. */=0A> +#define errCOULD=
_NOT_ALLOCATE_REQUIRED_MEMORY  (-1)=0A> +#define errNO_TASK_TO_RUN         =
             (-2)=0A> +#define errQUEUE_BLOCKED                      (-4)=
=0A> +#define errQUEUE_YIELD                        (-5)=0A>=A0=0A> I would=
 either define these errors as errno errors or give them values which=0A> d=
o not correspond to any errno constant.=0A=0AI could change the first error=
 code to=0A=0A#define errCOULD_NOT_ALLOCATE_REQUIRED_MEMORY   (-ENOMEM)=0A=
=0Aand remove the other three codes - they are only needed for the=A0=0A=0A=
"CoRoutine"-feature, which is not supported by my xenomai=A0=0Aimplementati=
on and were included only for completeness sake.=0A=0AI have also changed T=
askGenericaCreate to actually return=A0=0AerrCOULD_NOT_ALLOCATE_REQUIRED_ME=
MORY.=0A=0A> +#define xSemaphoreAltGive(xSemaphore) xSemaphoreGive(xMutex)=
=0A> +=0A> +#define xSemaphoreGiveFromISR(xSemaphore, pxHigherPriorityTaskW=
oken) \=0A> +      xSemaphoreGive(xMutex)=0A> +=0A>=A0=0A> About the testsu=
ite: does it really make sense to include both the unpatched=A0=0A> testsui=
te and xenomai-specific patches? I mean if you want to include the=A0=0A> t=
ests in xenomai sources, then include them patched, or do not include them,=
=A0=0A> and include the patch.=0A=0AI cannot 100% follow here. There is one=
 xenomai-specific test suite included,=0Awhich is written for xenomai speci=
fically and the original FreeRTOS "demo".=A0=0AThe FreeRTOS "demo" is downl=
oadable with and will be patched by the patches=A0=0Athat are checked in. T=
his demo code might be checked in with patches applied=A0=0Aalternatively. =
Is it that what you were suggesting? Or did I simply not make=A0=0Aclear th=
e difference between the "testsuite" and the "demo"?=0A=0AMatthias=0A

