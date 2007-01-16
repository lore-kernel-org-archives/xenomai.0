Message-ID: <20070116132851.19872.qmail@domain.hid>
Date: Tue, 16 Jan 2007 13:28:51 +0000 (GMT)
From: somshekar kadam <som_kadam@domain.hid>
Subject: Re: [Adeos-main] Porting IPIPE on MIPS Architecture,
	User Process running error, Kernel hangs.
In-Reply-To: <1168943855.17557.45.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org, Subramani Venkatesh <subbu31mani@domain.hid>
Cc: adeos-main@gna.org

Hi Phillipe , 

  Thanks A lot for Helping on the MIPS Port for Adoes.

Thanks And Regards
Neelu

--- Philippe Gerum <rpm@xenomai.org> wrote:

> On Tue, 2007-01-16 at 15:49 +0530, Subramani
> Venkatesh wrote:
> > Hello All,
> > I am currently porting Adeos-ipipe on one of my
> MIPS architecture. I
> > am using I-Pipe 1.5-01, X86 as reference to my
> porting. So Far I did
> > relevant changes in
> > 1.Interrupts handlers
> > 2. System calls
> > 3. Pagefault Handler 
> > Except Exception handling, I mean critcial bug
> events.
> > With this changes I am able to Boot Linux kernel
> and also able to
> > mount Ramdisk successfully.
> > 
> 
> [...]
> 
> > Opening console is successfull and executing
> /sbin/init
> > Algorithmics/MIPS FPU Emulator v1.5
> > INIT: version 2.85 booting
> > grep: error while loading shared libraries:
> libc.so.6: failed to map
> > segment from shared object: Error 4090
> 
> There is likely something fishy in the syscall
> interception path from
> arch/mips/kernel/entry.S; all the syscalls seem to
> return error values
> mistakenly once the pipelining is in effect. You may
> want to check your
> changes in this area.
> 
> Btw, it would be nice to work in an open manner and
> post your code on
> this list if you want to ask for help about it here.
> Contribution has to
> work both ways. TIA,
> 
> -- 
> Philippe.
> 
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
> 



		
__________________________________________________________
Yahoo! India Answers: Share what you know. Learn something new
http://in.answers.yahoo.com/

