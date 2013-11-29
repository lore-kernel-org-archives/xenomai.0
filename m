From: Wolfgang Denk <wd@denx.de>
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <52985E94.4070101@xenomai.org>
References: <20131128143152.04ac3eab.norbert.bukuli@mediso.hu>
 <5297BD30.4060007@xenomai.org>
 <20131129094157.3d7202e1.norbert.bukuli@mediso.hu>
 <52985E94.4070101@xenomai.org>
Date: Fri, 29 Nov 2013 23:53:20 +0100
Message-Id: <20131129225320.5327838040F@gemini.denx.de>
Subject: Re: [Xenomai] test suite programs crash with Illegal instruction on
	MPC5200
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Dear Philippe Gerum,

In message <52985E94.4070101@xenomai.org> you wrote:
> On 11/29/2013 09:41 AM, Bukuli Norbert wrote:
> > (gdb) cont
> > Continuing.
> > warning: Could not load shared library symbols for linux-vdso32.so.1.
> > Do you need "set solib-search-path" or "set sysroot"?
> > warning: .dynamic section for "/opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libpthread_rt.so.1" is not at the expected address (wrong library or version mismatch?)
> > warning: .dynamic section for "/opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libxenomai.so.0" is not at the expected address (wrong library or version mismatch?)
> 
> These warnings may trigger with recent broken gdbserver releases, let's 
> ignore them.

I don't think this is a good idea.  The actual problem is in the
previous warning:

warning: Could not load shared library symbols for linux-vdso32.so.1.
Do you need "set solib-search-path" or "set sysroot"?

You must set solib-search-path.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
After Goliath's defeat, giants ceased to command respect.
- Freeman Dyson

