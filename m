References: <1362151982.5735.YahooMailNeo@web171205.mail.ir2.yahoo.com>
	<5130E0C7.80709@siemens.com> <5130E6FE.2070905@siemens.com>
	<1362185238.64750.YahooMailNeo@web171203.mail.ir2.yahoo.com>
	<5131B5A2.6000501@web.de> <5131DC27.80909@xenomai.org>
	<5131DE8D.4070701@web.de> <51320ACA.4070101@xenomai.org>
	<51320EDF.2090104@web.de> <51320F98.7010900@xenomai.org>
	<51330EB1.9030801@web.de> <51331123.9070800@xenomai.org>
Message-ID: <1362345350.16477.YahooMailNeo@web171206.mail.ir2.yahoo.com>
Date: Sun, 3 Mar 2013 21:15:50 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@yahoo.it>
In-Reply-To: <51331123.9070800@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] kvm freeze with ipipe patch for kernel 3.x
Reply-To: Gabriele Moabiti <gabmoa@yahoo.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Jan Kiszka <jan.kiszka@web.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

>>>>>>>=0A=0A>>>>>>> I'm planning to get them merged into 3.8 first of all,=
 maybe also into=0A>>>>>>> 3.5 (as this is our current production baseline)=
. No plans exist beyond=0A>>>>>>> that. I'd rather like to leave older kern=
els alone to reduce maintenance=0A>>>>>>> efforts (porting is simple, prope=
r testing takes time).=0A>>>>>>>=0A>>>>>>> Also note that 3.2 is lacking mu=
ch more critical fixes than those few=0A>>>>>>> around KVM. IOW: Don't use =
it for anything serious with x86.=0A>>>>>>=0A>>>>>>=0A>>>>>> Maybe revertin=
g the mprotect/ipipe_pin_vma patches in the 3.2 branch, so=0A>>>>>> as to a=
void the zero page corruption, but take some faults sometimes=0A>>>>>> woul=
d be a simple, feasible solution? 3.2 seems to have been chosen as a=0A>>>>=
>> long term stable branch.=0A>>>>>=0A>>>>> Again, the problem is not writi=
ng the patches=0A>>>>=0A>>>>=0A>>>> It is easy to forget a patch when (back=
)porting patches from an I-pipe=0A>>>> to the other.=0A>>>>=0A>>>>> but tes=
ting all the stuff=0A>>>>> in all necessary combinations.=0A=0ASo.. does 3.=
2 or 3.4 (at least an LTS kernel) will be supported or it's better to use o=
nly the 3.5.7 (EOL)?=0AI think if a kernel patch has serious problems shoul=
d be marked as broken or unstable.

