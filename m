Message-ID: <4541C0E6.3070807@domain.hid>
Date: Fri, 27 Oct 2006 10:18:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] switchtest and Xenomai 2.2.4
References: <1160947939.4962.27.camel@domain.hid> <453FC4C0.5070105@domain.hid>
	<454078AD.5000907@domain.hid> <4540DE60.40209@domain.hid>
	<4540E1AB.2040200@domain.hid> <4540EABD.10403@domain.hid>
	<4540ECA6.5000604@domain.hid> <45411147.1070205@domain.hid>
In-Reply-To: <45411147.1070205@domain.hid>
Content-Type: multipart/mixed; boundary="------------080906060901090803090905"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------080906060901090803090905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Webb wrote:
> Gilles Chanteperdrix wrote:
> 
>> In the file ksrc/drivers/testing/switchtest.c, try commenting the calls
>> to try_module_get and module_put. You will need to recompile kernel
>> space support. I am afraid the module counter is decreased several 
>> times when close is called several times, so we basically screw it up.
>>
>> The attached patch also closes the file descriptors only once the 
>> threads are joined.
> 
> 
> It looks like this did the trick.  After commenting out the 
> try_module_get/module_put calls and applying your latest patch to 
> switchtest.c, switchtest appears to be working properly once again.

Ok, could you try one last thing: keep try_module_get and module_put in
ksrc/drivers/testing/switchtest.c and apply the attached patch to 
src/testsuite/switchtest/switchtest.c

-- 
                                                  Gilles Chanteperdrix

--------------080906060901090803090905
Content-Type: text/x-patch; name="xeno-switchtest-join-after-cancel-all.4.diff"
Content-Disposition: inline;
	filename="xeno-switchtest-join-after-cancel-all.4.diff"
Content-Transfer-Encoding: quoted-printable

Index: src/testsuite/switchtest/switchtest.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/switchtest/switchtest.c	(r=C3=A9vision 1749)
+++ src/testsuite/switchtest/switchtest.c	(copie de travail)
@@ -1173,8 +1173,12 @@
 			if (param->type !=3D RTK && param->thread)
 				pthread_cancel(param->thread);
 		}
+	}
+=09
+	for (i =3D 0; i < nr_cpus; i ++) {
+		struct cpu_tasks *cpu =3D &cpus[i];
=20
-		/* join them. */
+		/* join the user-space tasks. */
 		for (j =3D 0; j < cpu->tasks_count; j++) {
 			struct task_params *param =3D &cpu->tasks[j];
=20

--------------080906060901090803090905--

