Subject: Re: [Xenomai-core] libnative versioning
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45706A0E.9050400@domain.hid>
References: <45704CAB.5060502@domain.hid> <1164992204.4952.109.camel@domain.hid>
	<45706A0E.9050400@domain.hid>
Content-Type: text/plain
Date: Fri, 01 Dec 2006 19:00:55 +0100
Message-Id: <1164996055.4952.141.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Fri, 2006-12-01 at 18:44 +0100, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > 
> > The Xenomai ABI has been kept compatible between versions
> 
> I am afraid you are being optimistic: I for one made some changes in the
> posix skin that break the kernel/user interface.

Sorry, I've been unclear:

s,Xenomai ABI,Xenomai native interface ABI,

>  Maybe we need an ABI
> revision for each skin ?
> 

There is one for the nucleus already, so maybe we could extend the
feature. This said, the point ABI revs is basically to detect potential
mismatches; would an old POSIX app run improperly over the new library,
or would it choke at startup?

-- 
Philippe.



