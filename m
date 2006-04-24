Message-ID: <444CDB68.7010607@domain.hid>
Date: Mon, 24 Apr 2006 16:06:32 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] my tick takes a break !!
References: <5B122FD931231D408AC32630D1B1F7290ADD16EF@BUDMLVEM03.e2k.ad.ge.com>	<17484.53834.564922.482694@domain.hid>	<444CD47D.7010800@domain.hid>
	<17484.54840.377511.270338@domain.hid>
In-Reply-To: <17484.54840.377511.270338@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > If you feel lucky, the 3rd option coming with v2.2 is to get rid of the 
>  > UVM and use the new direct call interface now available from user-space 
>  > for the VxWorks skin. In such a case, you need 1) the development 
>  > trunk/, 2) to load xeno_vxworks, 3) work with the new VxWorks interface 
>  > from user-space exactely the way one would use the existing native or 
>  > POSIX skin.
> 
> But round-robin scheduling will not work for threads in secondary mode,
> whereas it works with UVM.
> 

Sorry, I don't get the point. If it works in secondary mode under the 
UVM, it will work outside the UVM too, since we have shadow threads 
scheduled by Linux, in any case.

-- 

Philippe.

