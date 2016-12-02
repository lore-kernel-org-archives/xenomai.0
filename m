MIME-Version: 1.0
In-Reply-To: <7bcf3d70-494c-9fa1-8554-f746ef130b7c@xenomai.org>
References: <CAMJ=MEdM7O5OBjpQV8sYyVfpToJbuy24MMfDRouDeMaryGcR+g@mail.gmail.com>
 <7bcf3d70-494c-9fa1-8554-f746ef130b7c@xenomai.org>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Fri, 2 Dec 2016 15:29:27 +0100
Message-ID: <CAMJ=MEcg43Sz1aT2K3J3LMEoBhRTj8cvZqCx1a9z5y5v+XNTgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai]
	=?utf-8?q?Question_about_config_option_=E2=80=93mem-poo?=
	=?utf-8?q?l-size?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, Dec 2, 2016 at 3:01 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 12/02/2016 02:03 PM, Ronny Meeus wrote:
>> Hello
>>
>> Context: I'm using the pSOS interface over the Mercury core (version 3.0=
.3).
>>
>> I have a question about option:
>> =E2=80=93mem-pool-size
>> described on page
>> http://xenomai.org/2015/05/application-setup-and-init/
>>
>> Is the parameter specifying the maximum size that will be used Xenomai
>> or is this the initial value that will be used while creating the main
>> memory pool.
>>
>> The explanation makes me think it is the first case while tests show
>> that it is the
>> latter case. e.g. the memory pool just extends when it is depleted.
>>
>
> How do you check this?

I check it by creating a pSOS message queue in which I sent 100k messages.
I see that this succeeds without errors.
I have also put a trace in the tlsf heap code and I see it constantly exten=
ding.

This is the test application:

#include <psos.h>
#include <stdio.h>

static void main_test_task(u_long a,u_long b,u_long c,u_long d)
{
        unsigned long qid, err;
        int i;
        unsigned long message_count =3D 100000;
        unsigned long mesg[4];

        q_create("LINE",0,Q_NOLIMIT|Q_PRIOR,&qid);
        for (i=3D0;i<message_count;i++)
        {
                err =3D q_send(qid, mesg);
                if (err !=3D 0)
                    printf("Error: q_send err=3D%ld count=3D%d\n", err, i);
        }
        printf("SUCCESS: Test passed (nr messages sent=3D%ld)\n",message_co=
unt);

        while (1)
                tm_wkafter(1000);
}


int main(int argc, char * const *argv)
{
        unsigned long tid;
        unsigned long args[4] =3D {0,0,0,0};

        t_create("MAIN",25,16000,16000,0,&tid);
        t_start(tid,T_PREEMPT|T_TSLICE,main_test_task,args);
        while (1)
                tm_wkafter(1000);
}


The unclean patch below solves the issue (to better understand the issue).
Correct patch can be provided later.

I was introducing a config parameter that specifies whether the pool actual=
ly
needs to grow or not. To be backwards compatible the default could be to gr=
ow.


diff --git a/lib/boilerplate/tlsf/tlsf.c b/lib/boilerplate/tlsf/tlsf.c
--- a/lib/boilerplate/tlsf/tlsf.c
+++ b/lib/boilerplate/tlsf/tlsf.c
@@ -452,6 +452,12 @@ static __inline__ bhdr_t *process_area(v
 /******************************************************************/

 static char *mp;         /* Default memory pool. */
+static int grow_mp =3D 0;
+
+void tlsf_grow_common_pool(int grow)
+{
+       grow_mp =3D grow;
+}

 /******************************************************************/
 size_t init_memory_pool(size_t mem_pool_size, void *mem_pool)
@@ -625,6 +631,7 @@ void *tlsf_malloc(size_t size)
        void *area;

        area_size =3D sizeof(tlsf_t) + BHDR_OVERHEAD * 8; /* Just a
safety constant */
+       area_size +=3D size;
        area_size =3D (area_size > DEFAULT_AREA_SIZE) ? area_size :
DEFAULT_AREA_SIZE;
        area =3D get_new_area(&area_size);
        if (area =3D=3D ((void *) ~0))
@@ -710,7 +717,7 @@ void *malloc_ex(size_t size, void *mem_p
        so they are not longer valid when the function fails */
     b =3D FIND_SUITABLE_BLOCK(tlsf, &fl, &sl);
 #if USE_MMAP || USE_SBRK
-    if (!b && mem_pool =3D=3D mp) {        /* Don't grow private pools */
+    if (!b && (mem_pool =3D=3D mp) && grow_mp) {   /* Don't grow private p=
ools */
        size_t area_size;
        void *area;
        /* Growing the pool size when needed */


Ronny

>
>> To me it would make more sense that the parameter is specifying the maxi=
mum
>> memory that will be used since like it is today the application's
>> memory usage can
>> grow until all system memory is consumed.
>>
>
> As stated in the documentation, this parameter configures the size of
> the memory area underlying the the main/session heap, which is meant to
> be a memory limit.
>
> --
> Philippe.

