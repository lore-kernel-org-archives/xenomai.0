References: <a9bb92d8-5e99-7afe-4381-7fad371632d0@smile.fr>
 <21e6332e-1acf-d53e-3ad5-543ff548a3a5@xenomai.org>
 <f0e3a9e8-4120-5076-e812-550d7ff4007f@smile.fr>
 <20161220143632.GC17365@csclub.uwaterloo.ca>
From: Julien Stephan <julien.stephan@smile.fr>
Message-ID: <af04ff4b-8c05-260d-b179-e843971cedf4@smile.fr>
Date: Wed, 21 Dec 2016 09:33:58 +0100
MIME-Version: 1.0
In-Reply-To: <20161220143632.GC17365@csclub.uwaterloo.ca>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] __COBALT_SYSCALL_BIT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org



On 20/12/2016 15:36, Lennart Sorensen wrote:
> On Tue, Dec 20, 2016 at 01:36:44PM +0100, Julien Stephan wrote:
>> I'm porting Xenomai on the MPPA processor of Kalray. The problem is that
>> their Linux port is quite new and is not yet publicly available ...
> Well that would easily be fixed if someone with the GPL code decided to
> share it.  The license clearly says you can and that no other restrictions
> are allowed to be impossed on the code.
Excuse me for my poor english: "not yet" may be confusing... I meant
"not currently"
> I had never heard of this one before, although looking at their website,
> I don't have much hope.  I don't think we need another architecture, which
> means yet another architecture to support in the kernel, glibc, gcc, not
> to mention all the stupid runtimes that need architecture specific code
> (hard enough to get those to support existing popular architectures).
> And when I see VLIW for a general purpose CPU, I can only think "doomed".
> It never worked before, and I don't believe it ever will.  But maybe
> they don't actually mean VLIW in the traditional sense.  Or maybe it is
> just intel that can't make it work.
>
> The design looks an awful lot like the tilera tile chips, which are also
> lots of cores in a big mesh with lots of fast IO and VLIW.  Not sure
> they have had much success yet.
>
> Well we will see what happens.
>
>

Well, thank you for your poor answer, but if you cannot help me, just
don't.

So my question was completely architecture independent. I wanted to know
if changing the __COBALT_SYSCALL_BIT from  0x10000000 to 0x700 was safe.
I mean, maybe some part of xenomai code really need it at 0x10000000.

So anyone that know xenomai better than me can answer it?

Thank you in advance
Julien
--=20
=20
Logo <http://www.smile.fr/>

14 rue G=E9nissieu
38000 GRENOBLE
www.smile.fr <http://www.smile.fr/> =09
*Julien STEPHAN*
Ing=E9nieur =E9tude et d=E9veloppement
Email : julien.stephan@smile.fr <mailto:julien.stephan@smile.fr>
Tel : +33 (0)4.58.00.19.59

=20

bandeaux_mail
<http://www.smile.fr/Ressources/Livres-blancs/Ingenierie/Linux-pour-l-embar=
que?utm_source=3Dsignature&utm_medium=3Demail&utm_campaign=3Dsignature>

eco Pour la plan=E8te, n'imprimez ce mail que si c'est n=E9cessaire
