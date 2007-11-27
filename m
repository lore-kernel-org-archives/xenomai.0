MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18252.36930.625870.462352@domain.hid>
Date: Tue, 27 Nov 2007 22:46:42 +0100
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2AE3BBE9@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2AE3BBE9@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Compatibility of Xenomai-Versions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik.Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik.Wildenburg@domain.hid wrote:
 > How compatible are the different Xenomai-Versions ? 
 > 
 > - E.g. can I use a 2.3.2 application (compiled and linked against 2.3.2
 > Libraries) on an 2.4.x kernel (kernel with a 2.4.x Xenomai) without
 > recompiling the application ? 

Xenomai has a notion of ABI revision, which has been increased in
2.4.x. So, no, if you update Xenomai kernel-space support, you have to
update Xenomai user-space support. The ABI revision was increased for a
good reason: some system calls implementation changed, so running with
mixed version would cause random errors.

Xenomai libraries are also versioned, so you will get a loader error if
you try to run an old application with a newer library.

 > - Can I link a 2.4.x-application (linked and compiled against 2.4.x
 > libraries) with an xenomai vendor libriary (e.g. some realtime functions
 > from a vendor) build with an 2.3.x Xenomai version ?

It depends on what is in this library. If there is a call to
xeno_bind_skin, you will get the ABI revision error.

 > 
 > In my understanding I would say yes, as long as the API and the header
 > files did not change (type or number of parameters, constants).
 > Is this correct ? If yes, is there an documentation where and when the
 > API changed in an significant way ?

Look for ksrc/skins/*/API.CHANGES. Note that only external API changes
are documented, internal API changes are not documented though they
caused an ABI revision increase.

-- 


					    Gilles Chanteperdrix.

