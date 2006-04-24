MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17484.56747.936438.531627@domain.hid>
Date: Mon, 24 Apr 2006 16:16:11 +0200
Subject: Re: [Xenomai-help] my tick takes a break !!
In-Reply-To: <444CDB68.7010607@domain.hid>
References: <5B122FD931231D408AC32630D1B1F7290ADD16EF@BUDMLVEM03.e2k.ad.ge.com>
	<17484.53834.564922.482694@domain.hid>
	<444CD47D.7010800@domain.hid>
	<17484.54840.377511.270338@domain.hid>
	<444CDB68.7010607@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > Gilles Chanteperdrix wrote:
 > > Philippe Gerum wrote:
 > >  > If you feel lucky, the 3rd option coming with v2.2 is to get rid of the 
 > >  > UVM and use the new direct call interface now available from user-space 
 > >  > for the VxWorks skin. In such a case, you need 1) the development 
 > >  > trunk/, 2) to load xeno_vxworks, 3) work with the new VxWorks interface 
 > >  > from user-space exactely the way one would use the existing native or 
 > >  > POSIX skin.
 > > 
 > > But round-robin scheduling will not work for threads in secondary mode,
 > > whereas it works with UVM.
 > > 
 > 
 > Sorry, I don't get the point. If it works in secondary mode under the 
 > UVM, it will work outside the UVM too, since we have shadow threads 
 > scheduled by Linux, in any case.

A thread in secondary mode in Xenomai kernel-space nucleus, is seen as
the root thread, which never has the XNRRB bit set.

The UVM nucleus, on the other hand, has no notion of primary or
secondary mode, when a thread is running in secondary mode it still is
the current thread, so may have the XNRRB bit set.

-- 


					    Gilles Chanteperdrix.

