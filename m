Message-ID: <20060905114004.17461.qmail@domain.hid>
Date: Tue, 5 Sep 2006 12:40:04 +0100 (BST)
From: somshekar kadam <som_kadam@domain.hid>
Subject: Re: [Xenomai-core] Xenomai port to MIPS
In-Reply-To: <44FD308F.6030604@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org


Hi Jan, 

 To begin with porting I need some help you people, 
I dont see an announcement of Xenomai start, who are
the Authors and maintainers of this I know were very
well its you and Philipe Gerum and others also whom i
dont know. As I need to put all this in a document ,
can help me on this.
Thanks In Advance 
Neelu my nick name 

--- Jan Kiszka <jan.kiszka@domain.hid> wrote:

> somshekar kadam wrote:
> > Hi All, 
> > 
> > After a good study with help of mailing list, we
> fix
> > on porting Xenomai to our ustom board running with
> > Mips4k .
> 
> Nice to hear. :)
> 
> > what I understand is we have Adeos with Xenomai,
> and
> > realtime capability of Xenomai. 
> 
> Yep.
> 
> > 
> > our ultimate goal is realtime. To Begin with port
> of
> > Xenomai I would like to know , in case is there a
> > porting doc or some pointer which help to
> understand
> > Xenomai better and quick, to go ahead.
> > Please comment on this. 
> 
> Your first step still remains the fairly independent
> port of Adeos/Ipipe
> over MIPS. Philippe already pointed out the
> available resources. Start
> over a recent vanilla kernel (or do you need special
> patches for your
> targets?), make Linux boot with Ipipe enabled, then
> stress the event
> pipeline with a simple Ipipe test module.
> 
> Once this works you can proceed to Xenomai, porting
> over what's under
> ksrc/arch/<arch> and include/asm-<arch>. Not all
> internal functions may
> be documented. Try to grab their meaning from other
> archs and/or their
> usage - or ask on this list.
> 
> Another hint: post your patches early even if they
> do not work yet. We
> may have a look and comment on style and
> functionality. This will make
> it easier to finally merge them (which should be
> your goal to ease
> long-term maintenance). And it may attract early
> adopters that can
> provide further feedback and test results.
> 
> Jan
> 
> 



		
__________________________________________________________
Yahoo! India Answers: Share what you know. Learn something new
http://in.answers.yahoo.com/

