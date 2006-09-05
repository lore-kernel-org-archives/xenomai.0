From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-ID: <17661.38171.623862.679877@domain.hid>
Date: Tue, 5 Sep 2006 17:17:47 +0200
Subject: Re: [Xenomai-help] resubmission : memset of heap crashes Xenomai-Task
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A4E9AEC@ARVMAIL1.mra.roland-man.biz>
References: <5D63919D95F87E4D9D34FF7748CE2C2A4E9AEC@ARVMAIL1.mra.roland-man.biz>
Content-Transfer-Encoding: Quoted-Printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
 > Some times ago (2006.07.06) I had the problem described below.=20
 > As far as I can see, there is no solution for this till now.=20
 > I think, it is worth a second go, as I believe, a industrial strength =
application can=B4t accept this behavior.
 > Therefore I would like to ask the Xenomai-PPC gurus (as far as I can s=
ee, it could only be reproduced on PPC (not Qemu)) again, to judge, wheth=
er this is a serios problem or just something I have to live with.
 >=20
 > Thank you in advance
 > Roderik
 >=20
 >=20
 > Xenomai Version : 2.2-rc2
 > Skin : native
 > Kernel : 2.4.25
 > Arch.: PPC
 >=20
 > I try to allocate as much memory as possible with the functions :
 > rt_heap_create and
 > rt_heap_alloc.
 > (see source attached)
 >=20
 > When I try to use the allocated memory with memset, the Xenomai-task c=
rashes with a "Segmentation fault".

You are doing:

RT_HEAP bigheap[MAXHEAPBLOCKS];
  =20

   for(i=3D0;i<MAXHEAPBLOCKS;i++)
   {
       /* some treatment */
   }

   /* access bigheap[i] */

After the for loop, i is MAXHEAPBLOCKS, so, you are accessing the bigheap
array beyond its end, probably overriding the bigbuf array.

--=20


					    Gilles Chanteperdrix.

