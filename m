MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-ID: <17411.17370.189222.143661@domain.hid>
Date: Mon, 27 Feb 2006 19:24:26 +0100
Subject: Re: AW: [Xenomai-core] vxworks-skin taskSpawn
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A1C3C4F@ARVMAIL1.mra.roland-man.biz>
References: <5D63919D95F87E4D9D34FF7748CE2C2A1C3C4F@ARVMAIL1.mra.roland-man.biz>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Content-Transfer-Encoding: Quoted-Printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
 > Dear Gilles,
 >=20
 > perhaps I should have mentioned in my earlier postings that I am using=
 a PowerPC platform. I hope this does not nullify your prior analyses.

Everything works fine here with the config files you sent me, so I guess
the issue is specific to the ppc platform.

 > As the following output shows, my timer is running in onshot mode :
 >=20
 > ~ # cat /proc/xenomai/timer
 > status=3Doneshot:setup=3D40:tickval=3D1:jiffies=3D940509634545=20
 >=20
 > so, the prerequisites for uvm module should be correct !?
 > Is the default timing something I can influence with the vxWorks-API ?=
 In the examples satch.c and koan.c I can=B4t see any function call refer=
ing to timer mode manipulation.

Timer mode is set at compile-time using kernel configuration menu and
may be overriden when loading the xeno_nucleus module by using the
"tick_arg" argument.

--=20


					    Gilles Chanteperdrix.

