Subject: RE: [Adeos-main] adeos porting
From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
In-Reply-To: <0C53F2DBA565D411885300508B553B5204CCEAE8@domain.hid>
References: 
	 <0C53F2DBA565D411885300508B553B5204CCEAE8@domain.hid>
Content-Type: text/plain
Message-Id: <1091642514.618.142.camel@domain.hid>
Mime-Version: 1.0
Date: Wed, 04 Aug 2004 20:01:54 +0200
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: aaron durbin <aarondurbin@domain.hid>
Cc: "'adeos-main@gna.org'" <adeos-main@gna.org>

On Wed, 2004-08-04 at 18:03, aaron durbin wrote:
> >Do you target the 3.0, 3.1 or fusion (poised to become 4.0) branch?
> 
> Actually I am not totally sure at this point. It was my (mis?)understanding
> that newer development on RTAI was using the ADEOS as its base interrupt
> dispatcher.

This is right. RTAI/x86 runs over Adeos since 24.1.11.

>  Fusion, I believe, is the new-new stuff (experimental), but I
> thought the 3.x branches were the newer stable stuff.  Could you give me a
> brief description on what they are and what direction they are going? I read
> a little up on fusion and xenomai stuff on www.fdn.fr/~brouchou/rtai.   

3.0 is the stable RTAI branch, for the 2.4 kernel series only, replacing
the legacy 24.1.x . Adeos is available there for x86. It has entered the
maintenance phase six months ago, so don't expect anything but small
bugfixes there. I would not recommend any arch port to start from this
codebase.

3.1 is the testing branch, still supporting the 2.4 series for all
archs, and the 2.6 series for x86 only. The architecture is the same
than 3.0, but it has been extended in several aspects. Adeos is
available there for x86 (the old RTHAL has been discontinued for this
arch), and a preliminary port exists for PPC. Like with 3.0, hard
real-time in user-space is only available for x86 though. Other archs
have no choice but running the apps in kernel space as modules. Changes
to this branch are calming down. It is poised to replace 3.0 as the
stable branch in a few weeks from now, once the remaining 2.6-related
problems have been found. 2.4 is ok already though.

fusion/4.0 is a complete departure from the 3.x architecture, based on
the Xenomai technology that has been initiated back three years ago and
continuously developed since then. It is aimed at rebuilding the RTAI
system over a nanokernel core. It's indeed new to the point that there
is no code recycled from the 24.1.x series. But "experimental" is a
wording chosen to minimize the potential confusion with the current 3.x
branch, not to qualify the state of the code which is maturing
reasonably fast.
In a few words, fusion is for the 2.6 (and above) kernel series, purely
Adeos-based, and specifically designed to have RTAI and the vanilla
(preemptible) kernel cooperate in providing hard real-time support in
user-space. Since 3.x has many (too many) APIs, fusion is also an
attempt to provide a more compact and simple native interface; old 3.x
interfaces will be rewritten in parallel over the new core for
compatibility purpose during the next months.  The fusion architecture
has been defined to be easily portable to other archs, but since it has
not been ported yet beyond x86, I cannot prove it (except that its core
runs glitchlessly over an even-driven simulator). However, there are
proofs for all the rest: just download 0.4 and try it (use the
testsuite/latency test). 
Since the x86 port is in good shape, a PPC port is the next goal.

-- 

Philippe.


