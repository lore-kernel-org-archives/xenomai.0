From: Paul <paul_c@domain.hid>
Date: Mon, 12 Mar 2007 12:25:54 +0000
References: <200703081924.47952.paul_c@domain.hid> <45F46D4A.1040502@domain.hid>
In-Reply-To: <45F46D4A.1040502@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703121225.54402.paul_c@domain.hid>
Subject: [Xenomai-core] Re: [Xenomai-help] Xenomai & kernel packages for
	Debian
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
Cc: xenomai@xenomai.org, xenomai@xenomai.org


Hi Jan

On Sunday 11 March 2007 20:57, Jan Kiszka wrote:
> Nice work! Hope that some people give this a try -- and report their
> findings here.

Judging by the web logs, several people have downloaded some of the packages.. 
Just to keep 'em on their toes, another set of x86_64 builds were added last 
night ;)

> Maybe you should create a dedicated page in the wiki to help those who
> do not immediately know what to do with the repos, explain what is
> contained, and tell beginners how to get it running quickly.

Most people interested in the packages wouldn't be *nix beginners and would 
probably have some knowledge of the apt tools. That said, there are some 
gotchas that would be worth documenting along with some commentary on 
make-kpkg & patching.

 On the todo list is an improvement of package descriptions, embedding 
supported kernel/arch data in linux-patches-xenomai. Perhaps adding an m4 & 
makefile.am snippet to the dev package.. Maybe copying assorted examples from 
the root directory and in ksrc/skins to xenomai-dev.


Regards, Paul.

