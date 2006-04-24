MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17484.54840.377511.270338@domain.hid>
Date: Mon, 24 Apr 2006 15:44:24 +0200
Subject: Re: [Xenomai-help] my tick takes a break !!
In-Reply-To: <444CD47D.7010800@domain.hid>
References: <5B122FD931231D408AC32630D1B1F7290ADD16EF@BUDMLVEM03.e2k.ad.ge.com>
	<17484.53834.564922.482694@domain.hid>
	<444CD47D.7010800@domain.hid>
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
 > If you feel lucky, the 3rd option coming with v2.2 is to get rid of the 
 > UVM and use the new direct call interface now available from user-space 
 > for the VxWorks skin. In such a case, you need 1) the development 
 > trunk/, 2) to load xeno_vxworks, 3) work with the new VxWorks interface 
 > from user-space exactely the way one would use the existing native or 
 > POSIX skin.

But round-robin scheduling will not work for threads in secondary mode,
whereas it works with UVM.

-- 


					    Gilles Chanteperdrix.

