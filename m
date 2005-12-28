Message-ID: <43B278B3.1070206@domain.hid>
Date: Wed, 28 Dec 2005 12:36:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_task_spawn how to
References: <20051228004108.2353.qmail@domain.hid>
In-Reply-To: <20051228004108.2353.qmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD77B552E7E5AC42EFE7368D0"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrice Congo <congo_p@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD77B552E7E5AC42EFE7368D0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi Patrice,

Patrice Congo wrote:
> Hi all,
> 
> is it posible to spawn a  task from another rt task?
> The following code tries to, but does not succeed:
> <code>
> #include <string.h>
> #include <stdio.h>
> 
> #include <native/task.h>
> //#include <general_macros.h>
> 
> #define STACK_SIZE 8192
> 
> RT_TASK spawner;
> RT_TASK spawnee;
> void spawner_work(void* c);
> void spawnee_work(void* c);
> 
> void spawner_work(void* c)
> {
> 	printf("\nspawner\n");
> 	//SWITCH_TASK_TO_SECONDARY_MODE();
> 	int
> ret=rt_task_spawn(&spawnee,"spawnee",STACK_SIZE,50,0,spawnee_work,NULL);
> 	printf("IN SPAWNER WORK: ret=%d
> %s\n",ret,strerror(ret));
> }
> 
> void spawnee_work(void* c)
> {
> 	printf("I am spawnee");	
> }
> 
> int main(int argc, char *argv[])
> {
> 	int ret=
> 	
> rt_task_spawn(&spawner,"spawner",STACK_SIZE,50,0,spawner_work,NULL);
> 	printf("\nIN MAIN:ret=%d %s\n",ret,strerror(-ret));
> 	getchar();
> 	return 0;
> }
> 
> 
> </code>
> 
> the resulting output is:
> <output>
> spawner
> 
> IN MAIN:ret=0 Success
> 
> </output>
> This means that the task "spawner" starts but get
> blocked at rt_task_spwan call.

Hmm, strange. This is what I see with latest SVN checkout of Xenomai:

spawner
IN SPAWNER WORK: ret=0 Success
I am spawnee
IN MAIN:ret=0 Success

Looks fine.

But you are lacking mlockall() in your demo. Maybe some page fault is
hitting your spawnee during creation.

> 
> Switching context explicitely to secondary or to
> primary does not help too.
> 
> can you help?
> 
> best, patrice
> 

Jan

--------------enigD77B552E7E5AC42EFE7368D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDsnizniDOoMHTA+kRAlypAJ9pSE3pgnua8cznonhv/DlKrcsFQgCdHyh1
NvIDHCEL8+LFg1b9WafU3kQ=
=szIW
-----END PGP SIGNATURE-----

--------------enigD77B552E7E5AC42EFE7368D0--

