Message-ID: <511D0297.6030105@mediso.hu>
Date: Thu, 14 Feb 2013 16:28:23 +0100
From: Norbert Bukuli <norbert.bukuli@mediso.hu>
MIME-Version: 1.0
References: <511B94E4.2070708@mediso.hu> <511B9901.7040104@xenomai.org>
	<511BB60E.7090900@mediso.hu> <511BCA3E.4050705@xenomai.org>
	<511C989C.7070700@mediso.hu>
In-Reply-To: <511C989C.7070700@mediso.hu>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Floating point operations in kernel on powerpc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This problem is still not resolved, so any suggestion or idea is
highly appreciated!
Thank you in advance!

On 2013-02-14 08:56, Norbert Bukuli wrote:
> Dear Mr Gerum,
> 
> let me respond your letter below.
> 
> On 2013-02-13 18:15, Philippe Gerum wrote:
>> On 02/13/2013 04:49 PM, Norbert Bukuli wrote:
>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>> 
>>> Dear Mr Gerum,
>>> 
>>> thank you for your kind answer. As you can see in the example 
>>> code I do not call explicitly either _savefpr_XX or 
>>> rthal_save_fpu and their restore counterparts. I only do some 
>>> floating point operations in a Xenomai domain kernel thread. 
>>> However the linker misses the routines mentioned earlier. Are 
>>> there linker flags to change this behaviour? One important
>>> note, in the kernel configuration the hardware FPU support is
>>> switched on. (CONFIG_XENO_HW_FPU=y)
> 
>> -msoft-float with hw FPU looks suspicious.
> -msoft-float is defined by the kernel's make system, but if you
> read the line further you can see, that I set the -mhard-float
> compiler flag.
> 
> I don't understand why you
>> mention C runtime libraries when building kernel modules either.
> It is probably my bad english, sorry for that. I mentioned the c
> runtime library, because there is a file a kernel source:
> arch/powerpc/lib/crtsavres.S One can see in this file: "Based on
> gcc/config/rs6000/crtsavres.asm from gcc".
> 
>> Building with eldk 5.2.1 for fpu-enabled 6xx cores can be done 
>> with 
>> eldk-5.2.1/powerpc/sysroots/i686-eldk-linux/usr/bin/powerpc-linux/powerpc-linux-gcc
>
>> 
> 
> from a stock eldk install. I use eldk-switch for set the
> environmental variables corresponding to the ELDK toolchain, and I
> use exactly the same compiler: $ eldk-switch -r 5.2.1 powerpc $
> which powerpc-linux-gcc 
> /opt/eldk-5.2.1/powerpc/sysroots/i686-eldk-linux/usr/bin/powerpc-linux/powerpc-linux-gcc
>
> 
> 
>> Actually, running fpu code in kernel space is a bad idea in the 
>> first place. Xenomai supports this for desperate situations when 
>> porting relic code absolutely requires it, but this is clearly 
>> something that should be avoided. You should really consider
>> moving all that stuff to userland if the situation is not that
>> desperate.
> 
> 
> Yes, I know, that is what we are working on. As I wrote it in my
> first letter, we should port our application to Xenomai and run it
> in userspace.
> 
> If it can help here is the test project: 
> https://gist.github.com/bukulin/4951215 (At the compilation the
> kernel build directory should be defined with KSRC=<kernel build
> directory>)
> 
> Thank you four your help, again!
> 
> 
> _______________________________________________ Xenomai mailing
> list Xenomai@xenomai.org 
> http://www.xenomai.org/mailman/listinfo/xenomai
> 

- -- 
Best regards,
Norbert Bukuli
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJRHQKXAAoJEJEs22zQJ00SLYoH/3rS1nwHS7sy/RvD1CVfQPpd
Q0sYm1pxPqQlmVrwwG7onVrViaSBDLYa1zO6NOGdJ6jX03XoOLjQWchqyUYnHqrN
6ntExf1PPwn6ppm0mmrZxgw0hIsjjjWFrYOAAW5m59ZW4HmjJu3KdRnQ2xmEfOhy
L473TW1Kr92oO9djRwY28vn3TivkwgEdRJ4L5nBGG8t2nyR389mmNtEZ72s3E5Po
T8wWk2wzTAek18LC8XshTn4pN0u7VdAPiLmsEHG7cQJ+BxL1LrcB91eX1BulkCDM
A0AyFYZPDkNJUw18RKa7UeE1T8iRdLl7on6XFqt3bvchxPL9KCZQLDoZqUqRHxw=
=BdIz
-----END PGP SIGNATURE-----

