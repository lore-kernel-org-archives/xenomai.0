From: Michael Pustylnik <MichaelPustylnik@ruggedcom.com>
Date: Thu, 22 Nov 2012 11:55:52 -0500
Message-ID: <990B36E792F1A4488D3E2B1C46FD62D69A13775FD4@corpmail2>
References: <50AE49ED.9020804@ruggedcom.com> <50AE4F97.8030102@xenomai.org>
In-Reply-To: <50AE4F97.8030102@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Mutex enhancement for Auto relaxed threads
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Makarand Pradhan <MakarandPradhan@ruggedcom.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Although you can use mutexes in this order, why would you want to do that? =
Logically, unlocking mutex1 would mean finishing some operation started whe=
n mutex1 was locked. If as a part of the operation you locked mutex2 and ha=
ven't unlocked it yet, that would mean you haven't completed your operation=
 yet, and unlocking mutex1 at this point would probably be a bug. Am I wron=
g?

Michael Pustylnik, P.Eng.
Senior Software Engineer
RuggedCom Inc.
www.ruggedcom.com
300 Applewood Crescent
Concord, Ontario, L4K 5C7
Tel:  (905)482-4523
Fax: (905)856-1995

=20


-----Original Message-----
From: xenomai-bounces@xenomai.org [mailto:xenomai-bounces@xenomai.org] On B=
ehalf Of Gilles Chanteperdrix
Sent: Thursday, November 22, 2012 11:15 AM
To: Makarand Pradhan
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] Mutex enhancement for Auto relaxed threads

On 11/22/2012 04:51 PM, Makarand Pradhan wrote:
> Greetings,
>=20
> I have a proposal for enhancing the process of locking a real-time mutex =
in auto-relaxed Xenomai threads. It will  save a lot of CPU cycles in some =
scenarios, and I would like to get your expert opinion about it (I have cod=
ed the enhancement for native skin and changes are attached to this email).
>=20
> Xenomai mutex is designed in such a way that trapping to the kernel is no=
t needed.This is a very efficient design which saves a great deal of CPU cy=
cles.
> However, there is an exception to this efficient behavior: if the Xenomai=
 thread is an auto-relaxed thread (i.e. running with priority 0), locking a=
 mutex always traps to the kernel because the current implementation handle=
s auto-relaxing upon exiting the system call.
>=20
> Look at this scenario:
>=20
> A Xenomai thread
> 1) locks a mutex (which is an OUTER mutex in this scenario)
> 2) then loops multiple times through some operation that requires locking=
 an unlocking some other mutex (INNER mutex)
> 3) unlocks the OUTER mutex

I did not look in details at your code, but what if I do

lock mutex1
lock mutex2
unlock mutex1
unlock mutex2

?

--=20
					    Gilles.

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
http://www.xenomai.org/mailman/listinfo/xenomai

No virus found in this incoming message.
Checked by AVG - www.avg.com=20
Version: 8.5.455 / Virus Database: 271.1.1/5393 - Release Date: 11/21/12 20=
:05:00

